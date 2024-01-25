---
title: Integrera AEM Forms och Marketo
description: Lär dig hur du integrerar AEM Forms och Marketo med AEM Forms Form Data Model.
feature: Adaptive Forms, Form Data Model
version: 6.4,6.5
topic: Integrations, Development
role: Developer
level: Experienced
exl-id: 45047852-4fdb-4702-8a99-faaad7213b61
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
last-substantial-update: 2020-03-20T00:00:00Z
duration: 83
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '370'
ht-degree: 0%

---

# Integrera AEM Forms och Marketo

Marketo, som ingår i Adobe, tillhandahåller Marketing Automation-programvara som fokuserar på kontobaserad marknadsföring, inklusive e-post, mobilt, sociala, digitala annonser, webbhantering och analys.

Med hjälp av AEM Forms Form Data Model kan vi nu integrera AEM Form med Marketo.

[Läs mer om formulärdatamodellen](https://helpx.adobe.com/experience-manager/6-5/forms/using/data-integration.html)

Marketo visar ett REST API som tillåter fjärrexekvering av många av systemets funktioner. Det finns många alternativ, från att skapa program till att importera leads, som ger detaljerad kontroll av en Marketo-instans. Med hjälp av formulärdatamodellen är det mycket enkelt att integrera AEM Forms med Marketo.

I den här självstudiekursen får du hjälp med att integrera AEM Forms med Marketo med hjälp av Form Data Model. När du är klar med självstudiekursen får du ett OSGi-paket som utför den anpassade autentiseringen mot Marketo. Du kommer också att ha konfigurerat datakällan med den angivna swagger-filen.

Vi rekommenderar att du är bekant med följande ämnen i avsnittet Krav för att komma igång.

## Förutsättning

1. [AEM server med AEM Forms Add on-paketet installerat](/help/forms/adaptive-forms/installing-aem-form-on-windows-tutorial-use.md)
1. Lokal AEM
1. Välbekant med formulärdatamodell
1. Grundläggande kunskap om växlingsfiler
1. Skapa adaptiv Forms

**Klienthemligt ID och klienthemlighetsnyckel**

Det första steget i integreringen av Marketo med AEM Forms är att hämta de API-autentiseringsuppgifter som behövs för att göra REST-anrop med API. Du behöver följande

1. client_id
1. client_secrets
1. identity_endpoint
1. autentiserings-URL

[Följ den officiella Marketo-dokumentationen för att få tillgång till ovanstående egenskaper.](https://developers.marketo.com/rest-api/) Du kan också kontakta administratören för din Marketo-instans.

**Innan du börjar**

[Hämta och zippa upp resurser som hör till den här artikeln.](assets/aemformsandmarketo.zip) ZIP-filen innehåller följande:

1. BlankTemplatePackage.zip - Det här är den adaptiva formulärmallen. Importera detta med pakethanteraren.
1. marketo.json - Det här är swagger-filen som används för att konfigurera datakällan.
1. MarketoAndForms.MarketoAndForms.core-1.0-SNAPSHOT.jar - Detta är paketet som utför den anpassade autentiseringen. Du kan använda det här alternativet om du inte kan slutföra självstudiekursen eller om ditt paket inte fungerar som det ska.

## Nästa steg

[Skapa anpassad autentisering](./part2.md)
