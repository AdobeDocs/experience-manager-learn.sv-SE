---
title: Hantera hemligheter i AEM as a Cloud Service
description: Lär dig de bästa sätten att hantera hemligheter inom AEM as a Cloud Service med verktyg och tekniker från AEM för att skydda känslig information och säkerställa att programmet förblir säkert och konfidentiellt.
version: Cloud Service
topic: Development, Security
feature: OSGI, Cloud Manager
role: Developer
jira: KT-15880
level: Intermediate, Experienced
exl-id: 856b7da4-9ee4-44db-b245-4fdd220e8a4e
source-git-commit: ba744f95f8d1f0b982cd5430860f0cb0945a4cda
workflow-type: tm+mt
source-wordcount: '702'
ht-degree: 0%

---

# Hantera hemligheter i AEM as a Cloud Service

Hantering av hemligheter, som API-nycklar och lösenord, är avgörande för att upprätthålla programsäkerheten. Adobe Experience Manager (AEM) as a Cloud Service har kraftfulla verktyg för att hantera hemligheter på ett säkert sätt.

I den här självstudiekursen lär du dig de bästa sätten att hantera hemligheter i AEM. Vi kommer att gå igenom de verktyg och tekniker som AEM tillhandahåller för att skydda känslig information och säkerställa att din applikation förblir säker och konfidentiell.

I den här självstudiekursen förutsätts det att du har kunskaper om AEM Java-utveckling, OSGi-tjänster, Sling Models och Adobe Cloud Manager.

## Secrets Manager OSGi service

I AEM as a Cloud Service ger hanteringen av hemligheter via OSGi-tjänster en skalbar och säker metod. OSGi-tjänster kan konfigureras för att hantera känslig information, t.ex. API-nycklar och lösenord, som definieras via OSGi-konfigurationer och som ställs in via Cloud Manager.

### OSGi-tjänstimplementering

Vi går igenom utvecklingen av en anpassad OSGi-tjänst som [exponerar hemligheter för OSGi-konfigurationer](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi#secret-configuration-values).

Implementeringen läser hemligheter från OSGi-konfigurationen via metoden `@Activate` och exponerar dem via metoden `getSecret(String secretName)`. Du kan också skapa diskreta metoder som `getApiKey()` för varje hemlighet, men den här metoden kräver mer underhåll när hemligheter läggs till eller tas bort.

```java
package com.example.core.util.impl;

import com.example.core.util.SecretsManager;
import org.osgi.service.component.annotations.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.sling.api.resource.ValueMap;
import org.apache.sling.api.resource.ValueMapDecorator;
import java.util.Map;

@Component(
    service = { SecretsManager.class }
)
public class SecretsManagerImpl implements SecretsManager {
    private static final Logger log = LoggerFactory.getLogger(SecretsManagerImpl.class);
 
    private ValueMap secrets;

    @Override
    public String getSecret(String secretName) {
        return secrets.get(secretName, String.class);
    }

    @Activate
    @Modified
    protected void activate(Map<String, Object> properties) {
        secrets = new ValueMapDecorator(properties);
    }
}
```

Som OSGi-tjänst är det bäst att registrera och använda den via ett Java-gränssnitt. Nedan visas ett enkelt gränssnitt som gör att konsumenterna kan få sina hemligheter via OSGi-egenskapsnamnet.

```java
package com.example.core.util;

import org.osgi.annotation.versioning.ConsumerType;

@ConsumerType
public interface SecretsManager {
    String getSecret(String secretName);
}
```

## Mappa hemligheter till OSGi-konfiguration

Visa hemliga värden i OSGi-tjänsten genom att mappa dem till OSGi-konfigurationer med hjälp av [OSGi-hemliga konfigurationsvärden](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi#secret-configuration-values). Definiera OSGi-egenskapsnamnet som nyckel för att hämta det hemliga värdet från metoden `SecretsManager.getSecret()`.

Definiera hemligheterna i OSGi-konfigurationsfilen `/apps/example/osgiconfig/config/com.example.core.util.impl.SecretsManagerImpl.cfg.json` i ditt AEM Maven-projekt. Varje egenskap representerar en hemlighet som exponeras i AEM, med värdet inställt via Cloud Manager. Nyckeln är OSGi-egenskapsnamnet som används för att hämta det hemliga värdet från tjänsten `SecretsManager`.

```json
{
    "api.key": "$[secret:api_key]",
    "service.password": "$[secret:service_password]"
}
```

Alternativt kan du använda en OSGi-tjänst för hantering av delade hemligheter genom att ta med hemligheter direkt i OSGi-konfigurationen för specifika tjänster som använder dem. Den här metoden är användbar när hemligheter bara behövs av en enda OSGi-tjänst och inte delas över flera tjänster. I det här fallet definieras hemliga värden i OSGi-konfigurationsfilen för den specifika tjänsten och nås i tjänstens Java-kod via metoden `@Activate`.

## Använda hemligheter

Hemligheter kan utnyttjas från OSGi-tjänsten på olika sätt, t.ex. från en Sling Model eller en annan OSGi-tjänst. Nedan finns exempel på hur man använder hemligheter från båda.

### Från försäljningsmodell

Sling Models innehåller ofta affärslogik för AEM webbplatskomponenter. OSGi-tjänsten `SecretsManager` kan användas via anteckningen `@OsgiService` och användas i Sling Model för att hämta det hemliga värdet.

```java
import com.example.core.util.SecretsManager;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.servlets.SlingHttpServletRequest;
import org.apache.sling.models.annotations.Model;
import org.apache.sling.models.annotations.OsgiService;

@Model(
    adaptables = {SlingHttpServletRequest.class, Resource.class},
    adapters = {ExampleDatabaseModel.class}
)
public class ExampleDatabaseModelImpl implements ExampleDatabaseModel {

    @OsgiService
    SecretsManager secretsManager;

    @Override 
    public String doWork() {
        final String secret = secretsManager.getSecret("api.key");
        // Do work with secret
    }
}
```

### Från OSGi-tjänst

OSGi-tjänster visar ofta återanvändbar affärslogik i AEM, som används av Sling Models, AEM som Workflows eller andra anpassade OSGi-tjänster. OSGi-tjänsten `SecretsManager` kan användas via anteckningen `@Reference` och användas i OSGi-tjänsten för att hämta det hemliga värdet.

```java
import com.example.core.util.SecretsManager;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

@Component
public class ExampleSecretConsumerImpl implements ExampleSecretConsumer {

    @Reference
    SecretsManager secretsManager;

    public void doWork() {
        final String secret = secretsManager.getSecret("service.password");
        // Do work with the secret
    }
}
```

## Ställa in hemligheter i Cloud Manager

Med OSGi-tjänsten och -konfigurationen på plats är det sista steget att ange de hemliga värdena i Cloud Manager.

Värden för hemligheter kan anges via [Cloud Manager API](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/#tag/Variables) eller, mer allmänt, via [Cloud Manager-gränssnittet](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/environment-variables#overview). Så här använder du en hemlig variabel via Cloud Manager-gränssnittet:

![Konfiguration av Cloud Manager Secrets](./assets/secrets/cloudmanager-configuration.png)

1. Logga in på [Adobe Cloud Manager](https://my.cloudmanager.adobe.com).
1. Välj det AEM program och den miljö som du vill ange hemligheten för.
1. Välj fliken **Konfiguration** i vyn Miljöinformation.
1. Välj **Lägg till**.
1. I dialogrutan Miljökonfiguration:
   - Ange det hemliga variabelnamnet (t.ex. `api_key`) som refereras i OSGi-konfigurationen.
   - Ange det hemliga värdet.
   - Välj vilken AEM som hemligheten gäller för.
   - Välj **Hemlighet** som typ.
1. Välj **Lägg till** om du vill behålla hemligheten.
1. Lägg till så många hemligheter som behövs. När du är klar väljer du **Spara** om du vill använda ändringarna direkt i AEM.

Att använda Cloud Manager-konfigurationer för hemligheter är en fördel om du tillämpar olika värden för olika miljöer eller tjänster och roterar hemligheter utan att behöva distribuera om AEM.
