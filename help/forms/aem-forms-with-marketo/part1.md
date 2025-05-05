---
title: Integrera AEM Forms och Marketo
description: Lär dig hur du integrerar AEM Forms och Marketo med AEM Forms Form Data Model.
feature: Adaptive Forms, Form Data Model
version: Experience Manager 6.4, Experience Manager 6.5
topic: Integrations, Development
role: Developer
level: Experienced
exl-id: 45047852-4fdb-4702-8a99-faaad7213b61
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
last-substantial-update: 2020-03-20T00:00:00Z
duration: 77
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '386'
ht-degree: 0%

---

# Integrera AEM Forms och Marketo


Marketo, som ingår i Adobe, tillhandahåller Marketing Automation-programvara som fokuserar på kontobaserad marknadsföring, inklusive e-post, mobilt, sociala, digitala annonser, webbhantering och analys.

Med hjälp av AEM Forms Form Data Model kan vi nu integrera AEM Form med Marketo.

[Läs mer om formulärdatamodellen](https://helpx.adobe.com/se/experience-manager/6-5/forms/using/data-integration.html)

Marketo visar ett REST API som tillåter fjärrexekvering av många av systemets funktioner. Det finns många alternativ, från att skapa program till att importera leads, som ger detaljerad kontroll av en Marketo-instans. Med hjälp av formulärdatamodellen är det mycket enkelt att integrera AEM Forms med Marketo.

>[!NOTE]
>
>Den här självstudiekursen är särskilt anpassad för AEM Forms 6.5. Om du vill integrera AEM Forms as a Cloud Service med Adobe Marketo Engage läser du den [dedikerade dokumentationen för integreringen](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/forms/integrate/services/integrate-adaptive-form-with-market-engage/integrate-form-to-marketo-engage).

I den här självstudiekursen får du hjälp med att integrera AEM Forms med Marketo med hjälp av Form Data Model. När du är klar med självstudiekursen får du ett OSGi-paket som utför den anpassade autentiseringen mot Marketo. Du kommer också att ha konfigurerat datakällan med den angivna swagger-filen.

Vi rekommenderar att du är bekant med följande ämnen i avsnittet Krav för att komma igång.

## Förutsättning

1. [AEM-server med AEM Forms Add on-paket installerat](/help/forms/adaptive-forms/installing-aem-form-on-windows-tutorial-use.md)
1. Lokal AEM Development Environment
1. Välbekant med formulärdatamodell
1. Grundläggande kunskap om växlingsfiler
1. Skapa adaptiv Forms

**Klienthemlighet-ID och klienthemlighet**

Det första steget i integreringen av Marketo med AEM Forms är att hämta de API-autentiseringsuppgifter som behövs för att göra REST-anrop med API. Du behöver följande

1. client_id
1. client_secrets
1. identity_endpoint

[Följ den officiella Marketo-dokumentationen för att få tillgång till ovanstående egenskaper.](https://developers.marketo.com/rest-api/) Du kan också kontakta administratören för din Marketo-instans.

**Innan du börjar**

* [Ladda ned och zippa upp resurser som hör till den här självstudiekursen](assets/marketo-integration-assets.zip)

ZIP-filen innehåller följande:

1. BlankTemplatePackage.zip - Det här är den adaptiva formulärmallen. Importera detta med pakethanteraren.
1. marketo.json - Det här är swagger-filen som används för att konfigurera datakällan.
1. Se till att du ändrar egenskapen host i marketo.json så att den pekar på din markering.

## Nästa steg

[Skapa data-Source](./part2.md)
