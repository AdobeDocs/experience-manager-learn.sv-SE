---
title: SAML 2.0 Custom Login Hook
description: Lär dig utveckla en anpassad inloggningsfunktion för SAML 2.0 för AEM.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Security
role: Developer
level: Intermediate
last-substantial-update: 2025-03-11T00:00:00Z
duration: 520
source-git-commit: 34f098de6bd15875e5534250b28c08bdb62e74fa
workflow-type: tm+mt
source-wordcount: '977'
ht-degree: 0%

---


# SAML 2.0-inloggningskrok

Lär dig utveckla en anpassad inloggningsfunktion för SAML 2.0 för AEM. I den här självstudiekursen finns stegvisa instruktioner för att skapa en anpassad inloggningskrok som integreras med en SAML 2.0-identitetsleverantör, så att användare kan autentisera med sina SAML-inloggningsuppgifter.

Om IDP inte kan skicka användarprofildata och användargruppsmedlemskap i SAML-försäkran, eller om data måste omvandlas innan synkronisering till AEM, kan anpassade SAML-kopplingar implementeras för att utöka SAML-autentiseringsprocessen. SAML-kopplingar gör det möjligt att anpassa gruppmedlemskapstilldelning, ändra användarprofilattribut och lägga till anpassad affärslogik under autentiseringsflödet.

>[!NOTE]
>Anpassade SAML-hookar stöds på **AEM som molntjänst** och **AEM LTS**. Den här funktionen är inte tillgänglig i äldre AEM-versioner.

## Vanliga användningssätt

Anpassade SAML-krokar är användbara när det är nödvändigt att:

+ Tilldela gruppmedlemskap dynamiskt baserat på anpassad affärslogik utöver vad som anges i SAML-försäkringar
+ Omvandla eller förbättra användarprofildata innan de synkroniseras med AEM
+ Mappa komplexa SAML-attributstrukturer till AEM användaregenskaper
+ Implementera anpassade auktoriseringsregler eller villkorliga grupptilldelningar
+ Lägg till anpassad loggning eller granskning under SAML-autentisering
+ Integrera med externa system under autentiseringsprocessen

## `SamlHook` OSGi-tjänstgränssnitt

Gränssnittet `com.adobe.granite.auth.saml.spi.SamlHook` innehåller två hook-metoder som anropas i olika stadier av SAML-autentiseringsprocessen:

### `postSamlValidationProcess()`-metod

Den här metoden anropas **efter** att SAML-svaret har validerats, men **före** startar användarsynkroniseringsprocessen. Det här är det idealiska stället att ändra SAML-kontrolldata, till exempel lägga till eller omforma attribut.

```java
public void postSamlValidationProcess(
    HttpServletRequest request, 
    Assertion assertion, 
    Message samlResponse)
```

#### Användningsfall

+ Lägg till ytterligare gruppmedlemskap i försäkran
+ Omforma attributvärden innan de synkroniseras
+ Förbättra kontrollen med data från externa källor
+ Validera anpassade affärsregler

### `postSyncUserProcess()`-metod

Den här metoden anropas **när** användarsynkroniseringsprocessen har slutförts. Den här kroken kan användas för att utföra ytterligare åtgärder efter att AEM-användaren har skapats eller uppdaterats.

```java
public void postSyncUserProcess(
    HttpServletRequest request, 
    HttpServletResponse response, 
    Assertion assertion,
    AuthenticationInfo authenticationInfo, 
    String samlResponse)
```

#### Användningsfall

+ Uppdatera ytterligare egenskaper för användarprofiler som inte omfattas av standardsynkronisering
+ Skapa eller uppdatera anpassade användarrelaterade resurser i AEM
+ Utlös arbetsflöden eller meddelanden efter användarautentisering
+ Logga anpassade autentiseringshändelser

**Viktigt!** För att ändra användaregenskaper i databasen krävs följande för implementeringen av kroken:

+ En `SlingRepository`-referens injicerad via `@Reference`
+ En konfigurerad [tjänstanvändare](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/developing/advanced/service-users) med lämplig behörighet (konfigurerad i tillägget Apache Sling Service User Mapper Service)
+ Korrekt sessionshantering med try-catch-finally -block

## Implementera en anpassad SAML-hook

I följande steg beskrivs hur du skapar och distribuerar en anpassad SAML-hook.

### Skapa SAML-krokimplementeringen

Skapa en ny Java-klass i AEM-projektet som implementerar gränssnittet `com.adobe.granite.auth.saml.spi.SamlHook`:

```java
package com.mycompany.aem.saml;

import com.adobe.granite.auth.saml.spi.Assertion;
import com.adobe.granite.auth.saml.spi.Attribute;
import com.adobe.granite.auth.saml.spi.Message;
import com.adobe.granite.auth.saml.spi.SamlHook;
import org.apache.jackrabbit.api.JackrabbitSession;
import org.apache.jackrabbit.api.security.user.Authorizable;
import org.apache.jackrabbit.api.security.user.UserManager;
import org.apache.sling.auth.core.spi.AuthenticationInfo;
import org.apache.sling.jcr.api.SlingRepository;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.metatype.annotations.AttributeDefinition;
import org.osgi.service.metatype.annotations.Designate;
import org.osgi.service.metatype.annotations.ObjectClassDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Nonnull;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.ValueFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
@Designate(ocd = SampleImpl.Configuration.class, factory = true)
public class SampleImpl implements SamlHook {
    @ObjectClassDefinition(name = "Saml Sample Authentication Handler Hook Configuration")
    @interface Configuration {
        @AttributeDefinition(
                name = "idpIdentifier",
                description = "Identifier of SAML Idp. Match the idpIdentifier property's value configured in the SAML Authentication Handler OSGi factory configuration (com.adobe.granite.auth.saml.SamlAuthenticationHandler~<unique-id>) this SAML hook will hook into"
        )
        String idpIdentifier();

    }

    private static final String SAMPLE_SERVICE_NAME = "sample-saml-service";
    private static final String CUSTOM_LOGIN_COUNT = "customLoginCount";

    private final Logger log = LoggerFactory.getLogger(getClass());

    private SlingRepository repository;

    @SuppressWarnings("UnusedDeclaration")
    @Reference(name = "repository", cardinality = ReferenceCardinality.MANDATORY)
    public void bindRepository(SlingRepository repository) {
        this.repository = repository;
    }

    /**
     * This method is called after the user sync process is completed.
     * At this point, the user has already been synchronized in OAK (created or updated).
     * Example: Track login count by adding custom attributes to the user in the repository
     *
     * @param request
     * @param response
     * @param assertion
     * @param authenticationInfo
     * @param samlResponse
     */
    @Override
    public void postSyncUserProcess(HttpServletRequest request, HttpServletResponse response, Assertion assertion,
                                    AuthenticationInfo authenticationInfo, String samlResponse) {
        log.info("Custom Audit Log: user {} successfully logged in", authenticationInfo.getUser());

        // This code executes AFTER the user has been synchronized in OAK
        // The user object already exists in the repository at this point
        Session serviceSession = null;
        try {
            // Get a service session - requires "sample-saml-service" to be configured as system user
            // Configure in: "Apache Sling Service User Mapper Service Amendment"
            serviceSession = repository.loginService(SAMPLE_SERVICE_NAME, null);

            // Get the UserManager to work with users and groups
            UserManager userManager = ((JackrabbitSession) serviceSession).getUserManager();

            // Get the authorizable (user) that just logged in
            Authorizable user = userManager.getAuthorizable(authenticationInfo.getUser());

            if (user != null && !user.isGroup()) {
                ValueFactory valueFactory = serviceSession.getValueFactory();

                // Increment login count
                long loginCount = 1;
                if (user.hasProperty(CUSTOM_LOGIN_COUNT)) {
                    loginCount = user.getProperty(CUSTOM_LOGIN_COUNT)[0].getLong() + 1;
                }
                user.setProperty(CUSTOM_LOGIN_COUNT, valueFactory.createValue(loginCount));
                log.debug("Set {} property to {} for user {}", CUSTOM_LOGIN_COUNT, loginCount, user.getID());

                // Save all changes to the repository
                if (serviceSession.hasPendingChanges()) {
                    serviceSession.save();
                    log.debug("Successfully saved custom attributes for user {}", user.getID());
                }
            } else {
                log.warn("User {} not found or is a group", authenticationInfo.getUser());
            }

        } catch (RepositoryException e) {
            log.error("Error adding custom attributes to user repository for user: {}",
                     authenticationInfo.getUser(), e);
        } finally {
            if (serviceSession != null) {
                serviceSession.logout();
            }
        }
    }

    /**
     * This method is called after the SAML response is validated but before the user sync process starts.
     * We can modify the assertion here to add custom attributes.
     *
     * @param request
     * @param assertion
     * @param samlResponse
     */
    @Override
    public void postSamlValidationProcess(@Nonnull HttpServletRequest request, @Nonnull Assertion assertion, @Nonnull Message samlResponse) {
        // Add the attribute "memberOf" with value "sample-group" to the assertion
        // In this example "memberOf" is a multi-valued attribute that contains the groups from the Saml Idp
        log.debug("Inside postSamlValidationProcess");
        Attribute groupsAttr = assertion.getAttributes().get("groups");
        if (groupsAttr != null) {
            groupsAttr.addAttributeValue("sample-group-from-hook");
        } else {
            groupsAttr = new Attribute();
            groupsAttr.setName("groups");
            groupsAttr.addAttributeValue("sample-group-from-hook");
            assertion.getAttributes().put("groups", groupsAttr);
        }
    }

}
```

### Konfigurera SAML-kroken

SAML-kroken använder OSGi-konfiguration för att ange vilken IDP den ska gälla för. Skapa en OSGi-konfigurationsfil i projektet på:

`/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/com.mycompany.aem.saml.CustomSamlHook~okta.cfg.json`

```json
{
  "idpIdentifier": "$[env:SAML_IDP_ID;default=http://www.okta.com/exk4z55r44Jz9C6am5d7]",
  "service.ranking": 100
}
```

`idpIdentifier` måste matcha det `idpIdentifier`-värde som konfigurerats i motsvarande SAML Authentication Handler OSGi-fabrikskonfiguration (PID: `com.adobe.granite.auth.saml.SamlAuthenticationHandler~<unique-id>.cfg.json`). Denna matchning är viktig: SAML-kroken anropas bara för SAML-autentiserings-hanterarinstansen som har samma `idpIdentifier`-värde. SAML Authentication Handler är en fabrikskonfiguration, vilket innebär att du kan ha flera instanser (t.ex. `com.adobe.granite.auth.saml.SamlAuthenticationHandler~okta.cfg.json`, `com.adobe.granite.auth.saml.SamlAuthenticationHandler~azure.cfg.json`) och varje krok är kopplad till en specifik hanterare via `idpIdentifier`. Egenskapen `service.ranking` styr körningsordningen när flera kopplingar är konfigurerade (högre värden körs först).

### Lägg till Maven-beroenden

Lägg till nödvändigt SAML SPI-beroende i AEM Mavens kärnprojekt `pom.xml`.

**För AEM as a Cloud Service-projekt** använder du API-beroendet för AEM SDK som innehåller SAML-gränssnitt:

```xml
<dependency>
    <groupId>com.adobe.aem</groupId>
    <artifactId>aem-sdk-api</artifactId>
    <version>${aem.sdk.api}</version>
    <scope>provided</scope>
</dependency>
```

Artefakten `aem-sdk-api` innehåller alla nödvändiga Adobe Granite SAML-gränssnitt, inklusive `com.adobe.granite.auth.saml.spi.SamlHook`.

### Konfigurera tjänstanvändare (valfritt)

Om SAML-kroken behöver ändra innehåll i AEM JCR-databas, t.ex. användaregenskaper (som visas i `postSyncUserProcess`-exemplet), måste en [tjänstanvändare](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/developing/advanced/service-users) konfigureras:

1. Skapa en tjänstanvändarmappning i projektet på `/ui.config/src/main/content/jcr_root/apps/myproject/osgiconfig/config/org.apache.sling.serviceusermapping.impl.ServiceUserMapperImpl.amended~saml.cfg.json`:

```json
{
  "user.mapping": [
    "com.mycompany.aem.core:sample-saml-service=saml-hook-service"
  ]
}
```

1. Skapa ett poinit-skript för att definiera tjänstanvändaren och behörigheterna på `/ui.config/src/main/content/jcr_root/apps/myproject/osgiconfig/config/org.apache.sling.jcr.repoinit.RepositoryInitializer~saml.cfg.json`:

```
create service user saml-hook-service with path system/saml

set ACL for saml-hook-service
    allow jcr:read,rep:write,rep:userManagement on /home/users
end
```

Detta ger tjänstanvändaren behörighet att läsa och ändra användaregenskaper i databasen.

### Distribuera till AEM

Distribuera den anpassade SAML-kroken till AEM as a Cloud Service:

1. Bygg AEM-projektet
1. Bekräfta koden i Cloud Manager Git-databasen
1. Distribuera med hjälp av en pipeline för fullständig stackdistribution
1. SAML-kroken aktiveras automatiskt när en användare autentiserar via SAML


### Viktiga överväganden

+ **IDP-identifierarmatchning**: `idpIdentifier` som konfigurerats i SAML-kroken måste exakt matcha `idpIdentifier` i SAML Authentication Handler-fabrikskonfigurationen (`com.adobe.granite.auth.saml.SamlAuthenticationHandler~<unique-id>`)
+ **Attributnamn**: Kontrollera att attributnamnen som refereras i kroken (t.ex. `groupMembership`) matchar attributen som konfigurerats i SAML Authentication Handler
+ **Prestanda**: Behåll krok-implementeringar med låg vikt när de körs under varje SAML-autentisering
+ **Felhantering**: SAML-krok-implementeringar ska utlösa `com.adobe.granite.auth.saml.spi.SamlHookException` när kritiska fel inträffar som ska misslyckas med autentiseringen. SAML-autentiseringshanteraren fångar upp dessa undantag och returnerar `AuthenticationInfo.FAIL_AUTH`. För databasåtgärder bör du alltid fånga upp `RepositoryException` och logga fel på rätt sätt. Använd try-catch-finally-blocken för att säkerställa att resurserna rensas ordentligt
+ **Testa**: Testa anpassade krokar noggrant i lägre miljöer innan du driftsätter dem i produktion
+ **Flera hookar**: Flera SAML-hook-implementeringar kan konfigureras. Alla matchande hookar kommer att köras. Använd egenskapen `service.ranking` i OSGi-komponenten för att styra körningsordningen (högre rankningsvärden körs först). Om du vill återanvända en SAML-hook i flera fabrikskonfigurationer för SAML Authentication Handler (`com.adobe.granite.auth.saml.SamlAuthenticationHandler~<unique-id>`) skapar du flera krokkonfigurationer (OSGi-fabrikskonfigurationer), där var och en har en egen `idpIdentifier` som matchar respektive SAML-autentiseringshanterare
+ **Säkerhet**: Verifiera och sanera alla data från SAML-försäkran innan de används i affärslogiken
+ **Databasåtkomst**: När du ändrar användaregenskaper i `postSyncUserProcess` ska du alltid använda en [tjänstanvändare](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/developing/advanced/service-users) med lämplig behörighet i stället för administrativa sessioner
+ **Tjänstanvändarbehörigheter**: Bevilja minimala nödvändiga behörigheter till [tjänstanvändaren](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/developing/advanced/service-users) (t.ex. endast `jcr:read` och `rep:write` på `/home/users`, inte fullständiga administratörsrättigheter)
+ **Sessionshantering**: Använd alltid try-catch-finally-block för att säkerställa att databassessionerna stängs korrekt, även om undantag inträffar
+ **Inställning för användarsynkronisering**: `postSyncUserProcess`-kroken körs efter att användaren har synkroniserats med OAK, så användarobjektet finns garanterat i databasen vid den tidpunkten
