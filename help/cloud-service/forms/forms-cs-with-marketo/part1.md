---
title: Integrera AEM Forms Cloud Service och Marketo
description: Lär dig hur du integrerar AEM Forms och Marketo med AEM Forms Form Data Model.
feature: Form Data Model,Integration
version: Cloud Service
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
last-substantial-update: 2024-07-24T00:00:00Z
jira: KT-15876
source-git-commit: 426020f59c7103829b7b7b74acb0ddb7159b39fa
workflow-type: tm+mt
source-wordcount: '338'
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

1. Åtkomst till instansen av AEM Forms Cloud Service
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

* [Ladda ned och zippa upp resurser som hör till den här självstudiekursen](assets/marketo.zip)

ZIP-filen innehåller följande:

1. marketo.json - Det här är swagger-filen som används för att konfigurera datakällan.
1. Se till att du ändrar egenskapen host i marketo.json så att den pekar på din markering.

## Nästa steg

[Skapa data-Source](./part2.md)
