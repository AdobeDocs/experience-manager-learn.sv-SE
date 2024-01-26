---
title: Felsöka AEM med databasläsaren
description: Databasläsaren är ett kraftfullt verktyg som ger synlighet i AEM underliggande datalager, vilket gör det enkelt att felsöka AEM as a Cloud Service miljö.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
jira: KT-10004
thumbnail: 341464.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 88af40fc-deff-4b92-84b1-88df2dbdd90b
duration: 318
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '253'
ht-degree: 0%

---

# Felsöka AEM as a Cloud Service med Databasläsaren

Databasläsaren är ett kraftfullt verktyg som ger synlighet i AEM underliggande datalager, vilket gör det enkelt att felsöka AEM as a Cloud Service miljö. Databasläsaren har stöd för en skrivskyddad vy över resurser och egenskaper för AEM på produktions-, scen- och utvecklingsstadiet samt författar-, publicerings- och förhandsgranskningstjänster.

>[!VIDEO](https://video.tv.adobe.com/v/341464?quality=12&learn=on)

Databasläsaren är __ENDAST__ tillgängliga i AEM as a Cloud Service miljöer (användning [CRXDE Lite](../aem-sdk-local-quickstart/other-tools.md#crxde-lite) för att felsöka den lokala AEM SDK).

## Åtkomst till databasläsaren

Så här öppnar du Databasläsaren på AEM as a Cloud Service:

1. Se till att din användare har [nödvändig åtkomst](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developer-tools/repository-browser.html#access-prerequisites)
1. Logga in på [Cloud Manager](https://my.cloudmanager.adobe.com)
1. Välj det program som innehåller den AEM as a Cloud Service miljön som ska felsökas
1. Öppna [Developer Console](./developer-console.md) motsvarar den AEM as a Cloud Service miljön som ska felsökas
1. Välj __Databasläsare__ tab
1. Välj AEM tjänstnivå att bläddra i
   + Alla författare
   + Alla utgivare
   + Alla förhandsvisningar
1. Välj __Öppna databasläsaren__

Databasläsaren öppnas för den valda tjänstnivån (Författare, Publicera eller Förhandsgranska) i skrivskyddat läge och visar resurser och egenskaper som användaren har tillgång till.

## Åtkomst till publicera och förhandsgranska

Som standard är åtkomsten till Publicera eller Förhandsgranska begränsad, vilket minskar antalet tillgängliga resurser i Databasläsaren. [Om du vill visa alla resurser för Publicera (eller Förhandsgranska) lägger du till användare i en administratörsroll för Publicera (eller Förhandsgranska).](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developer-tools/repository-browser.html#navigate-the-hierarchy)
