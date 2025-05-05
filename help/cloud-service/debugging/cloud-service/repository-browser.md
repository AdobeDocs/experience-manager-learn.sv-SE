---
title: Felsöka AEM med Databasläsaren
description: Databasläsaren är ett kraftfullt verktyg som ger synlighet i AEM underliggande datalager, vilket gör det enkelt att felsöka AEM as a Cloud Service-miljön.
feature: Developer Tools
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-10004
thumbnail: 341464.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 88af40fc-deff-4b92-84b1-88df2dbdd90b
duration: 305
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '253'
ht-degree: 0%

---

# Felsöka AEM as a Cloud Service med Databasläsaren

Databasläsaren är ett kraftfullt verktyg som ger synlighet i AEM underliggande datalager, vilket gör det enkelt att felsöka AEM as a Cloud Service-miljön. Databasläsaren har stöd för en skrivskyddad vy över resurserna och egenskaperna för AEM i produktions-, scen- och utvecklingsfasen samt författartjänsterna, publiceringstjänsterna och förhandsgranskningstjänsterna.

>[!VIDEO](https://video.tv.adobe.com/v/3447058?quality=12&learn=on&captions=swe)

Databasläsaren är __ENDAST__ tillgänglig i AEM as a Cloud Service-miljöer (använd [CRXDE Lite](../aem-sdk-local-quickstart/other-tools.md#crxde-lite) för att felsöka den lokala AEM SDK).

## Åtkomst till databasläsaren

Så här öppnar du Databasläsaren i AEM as a Cloud Service:

1. Kontrollera att din användare har [den nödvändiga åtkomsten](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developer-tools/repository-browser.html?lang=sv-SE#access-prerequisites)
1. Logga in på [Cloud Manager](https://my.cloudmanager.adobe.com)
1. Välj det program som innehåller AEM as a Cloud Service-miljön som ska felsökas
1. Öppna den [Developer Console](./developer-console.md) som motsvarar AEM as a Cloud Service-miljön som ska felsökas
1. Välj fliken __Databasläsare__
1. Välj tjänstenivån i AEM för att bläddra
   + Alla författare
   + Alla utgivare
   + Alla förhandsvisningar
1. Välj __Öppna databasläsaren__

Databasläsaren öppnas för den valda tjänstnivån (Författare, Publicera eller Förhandsgranska) i skrivskyddat läge och visar resurser och egenskaper som användaren har tillgång till.

## Åtkomst till publicera och förhandsgranska

Som standard är åtkomsten till Publicera eller Förhandsgranska begränsad, vilket minskar antalet tillgängliga resurser i Databasläsaren. [Om du vill visa alla resurser för Publicera (eller Förhandsgranska) lägger du till användare i en administratörsroll för Publicera (eller Förhandsgranska).](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developer-tools/repository-browser.html?lang=sv-SE#navigate-the-hierarchy)
