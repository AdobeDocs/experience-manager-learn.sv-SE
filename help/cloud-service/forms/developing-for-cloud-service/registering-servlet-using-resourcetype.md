---
title: Registrera en serverdator med resurstypen
description: Mappa en serverlet till en resurstyp i AEM Forms CS
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Developer Tools
jira: KT-14581
duration: 90
exl-id: 2a33a9a9-1eef-425d-aec5-465030ee9b74
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '378'
ht-degree: 0%

---

# Introduktion

Bindning av serverlets efter sökvägar har flera nackdelar jämfört med bindning efter resurstyper, nämligen:

* Sökvägsbundna servrar kan inte åtkomststyras med JCR-databasens standardåtkomstkontrollistor
* Sökvägsbundna serverlets kan endast registreras för en sökväg och inte för en resurstyp (d.v.s. ingen suffixhantering)
* Om en banbunden servlet inte är aktiv, t.ex. om paketet saknas eller inte har startats, kan en POST ge oväntade resultat. oftast skapar en nod vid `/bin/xyz` som sedan täcker serverlets sökvägbindning
mappningen är inte genomskinlig för en utvecklare som bara tittar på databasen
Med tanke på dessa nackdelar rekommenderar vi att du binder servlets till resurstyper i stället för sökvägar

## Skapa server

Starta aem-Banking-projektet i IntelliJ. Skapa en servlet med namnet GetFieldChoices under serverletmappen, som visas på skärmbilden nedan.
![alternativ](assets/fetchchoices.png)

## Exempel på serverdel

Följande servertjänst är bunden till Sling-resurstypen: _**azure/fetchoptions**_



```java
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.servlets.annotations.SlingServletResourceTypes;
import org.osgi.framework.Constants;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Session;
import javax.servlet.Servlet;
import java.io.IOException;
import java.io.Serializable;

@Component(
        service={Servlet.class }
)

        @SlingServletResourceTypes(
                resourceTypes="azure/fetchchoices",
                methods= "GET",
                extensions="json"
                )


public class GetFieldChoices extends SlingAllMethodsServlet implements Serializable {
    private static final long serialVersionUID = 1L;
    private final  transient Logger log = LoggerFactory.getLogger(this.getClass());


   

    protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) {

        log.debug("The form path I got was "+request.getParameter("formPath"));

    }
}
```

## Skapa resurser i CRX

* Logga in på ditt lokala AEM SDK.
* Skapa en resurs med namnet `fetchchoices` (du kan namnge den här noden ändå) av typen `cq:Page` under innehållsnoden.
* Spara ändringarna
* Skapa en nod med namnet `jcr:content` av typen `cq:PageContent` och spara ändringarna
* Lägg till följande egenskaper i noden `jcr:content`

| Egenskapsnamn | Egenskapsvärde |
|--------------------|--------------------|
| jcr:title | Verktygstjänster |
| sling:resourceType | `azure/fetchchoices` |


Värdet `sling:resourceType` måste matcha resourceTypes=&quot;azure/fetchchoice&quot; som anges i serverleten.

Du kan nu anropa din serverdator genom att begära resursen med `sling:resourceType` = `azure/fetchchoices` i dess fullständiga sökväg, med alla väljare eller tillägg registrerade i Sling-servern.

```html
http://localhost:4502/content/fetchchoices/jcr:content.json?formPath=/content/forms/af/forrahul/jcr:content/guideContainer
```

Sökvägen `/content/fetchchoices/jcr:content` är sökvägen till resursen och tillägget `.json` är den som anges i serverleten

## Synkronisera AEM

1. Öppna det AEM projektet i din favoritredigerare. Jag har använt IntelliJ för det här.
1. Skapa en mapp med namnet `fetchchoices` under `\aem-banking-application\ui.content\src\main\content\jcr_root\content`
1. Högerklicka på mappen `fetchchoices` och välj `repo | Get Command` (Det här menyalternativet är konfigurerat i ett tidigare kapitel i den här självstudiekursen).

Den här noden bör synkroniseras från AEM till ditt lokala AEM.

Din AEM projektstruktur bör se ut så här
![resource-resolver](assets/mapping-servlet-resource.png)
Uppdatera filter.xml i mappen aem-Banking-application\ui.content\src\main\content\META-INF\vault med följande post

```xml
<filter root="/content/fetchchoices" mode="merge"/>
```

Nu kan du överföra dina ändringar till en AEM as a Cloud Service-miljö med Cloud Manager.

## Nästa steg

[Aktivera Forms Portal-komponenter](./forms-portal-components.md)
