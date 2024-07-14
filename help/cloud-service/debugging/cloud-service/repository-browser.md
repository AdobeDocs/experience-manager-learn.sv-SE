---
title: Felsöka AEM med databasläsaren
description: Databasläsaren är ett kraftfullt verktyg som ger synlighet i AEM underliggande datalager, vilket gör det enkelt att felsöka AEM as a Cloud Service-miljön.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
jira: KT-10004
thumbnail: 341464.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 88af40fc-deff-4b92-84b1-88df2dbdd90b
duration: 305
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '253'
ht-degree: 0%

---

# Felsöka AEM as a Cloud Service med Databasläsaren

Databasläsaren är ett kraftfullt verktyg som ger synlighet i AEM underliggande datalager, vilket gör det enkelt att felsöka AEM as a Cloud Service-miljön. Databasläsaren har stöd för en skrivskyddad vy över resurser och egenskaper för AEM på produktions-, scen- och utvecklingsstadiet samt för tjänsterna Author, Publish och Preview.

>[!VIDEO](https://video.tv.adobe.com/v/341464?quality=12&learn=on)

Databasläsaren är __ENDAST__ tillgänglig i AEM as a Cloud Service-miljöer (använd [CRXDE Lite](../aem-sdk-local-quickstart/other-tools.md#crxde-lite) för att felsöka den lokala AEM SDK).

## Åtkomst till databasläsaren

Så här öppnar du Databasläsaren i AEM as a Cloud Service:

1. Kontrollera att din användare har [den nödvändiga åtkomsten](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developer-tools/repository-browser.html#access-prerequisites)
1. Logga in på [Cloud Manager](https://my.cloudmanager.adobe.com)
1. Välj det program som innehåller AEM as a Cloud Service-miljön som ska felsökas
1. Öppna den [Developer Console](./developer-console.md) som motsvarar AEM as a Cloud Service-miljön som ska felsökas
1. Välj fliken __Databasläsare__
1. Välj AEM tjänstnivå att bläddra i
   + Alla författare
   + Alla utgivare
   + Alla förhandsvisningar
1. Välj __Öppna databasläsaren__

Databasläsaren öppnas för den valda tjänstnivån (Författare, Publish eller Förhandsgranska) i skrivskyddat läge och visar resurser och egenskaper som användaren har åtkomst till.

## Publish- och Preview-åtkomst

Som standard är åtkomsten till Publish eller Preview begränsad, vilket minskar antalet tillgängliga resurser i Databasläsaren. [Om du vill visa alla resurser på Publish (eller Förhandsgranska) lägger du till användare i en administratörsroll för Publish (eller Förhandsgranska).](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developer-tools/repository-browser.html#navigate-the-hierarchy)
