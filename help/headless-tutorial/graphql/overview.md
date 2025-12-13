---
title: Kom igång med AEM Headless - GraphQL
description: Läs mer om Experience Manager GraphQL API:er och deras funktioner.
feature: Content Fragments, GraphQL API, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 0056971f-2f89-43b3-bb6f-dd16c2a50370
thumbnail: 328618.jpg
last-substantial-update: 2022-07-20T00:00:00Z
duration: 626
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '265'
ht-degree: 0%

---

# Komma igång med AEM Headless - GraphQL {#getting-started-with-aem-headless}

AEM GraphQL API:er för innehållsfragment
har stöd för headless CMS-scenarier där externa klientprogram återger upplevelser med hjälp av innehåll som hanteras i AEM.

Ett modernt API för innehållsleverans är avgörande för effektiviteten och prestandan i Javascript-baserade klientprogram. Att använda ett REST API medför utmaningar:

* Ett stort antal begäranden om att hämta ett objekt i taget
* Innehåll som ofta&quot;överlevererar&quot;, vilket innebär att programmet får mer än det behöver

För att övervinna dessa problem tillhandahåller GraphQL ett frågebaserat API som gör det möjligt för kunder att fråga AEM efter endast det innehåll som de behöver och att ta emot via ett enda API-anrop.

>[!VIDEO](https://video.tv.adobe.com/v/3452883?captions=swe&quality=12&learn=on)

Den här videon är en översikt över GraphQL API som implementerats i AEM. GraphQL-API:t i AEM är främst utformat för att leverera AEM Content Fragment-program till program längre fram i kedjan som en del av en headless-driftsättning.

>[!CONTEXTUALHELP]
>id="aemcloud_learn_headless_graphql_overview"
>title="Komma igång med AEM Headless - GraphQL"
>abstract="Lär dig hur du levererar innehållsfragment med GraphQL."
>additional-url="https://video.tv.adobe.com/v/3452883?captions=swe" text="Översikt över GraphQL i AEM"

## AEM Headless GraphQL Video Series

Läs om AEM GraphQL-funktioner genom den djupgående genomgången av Content Fragments och AEM GraphQL API:er och utvecklingsverktyg.

* [AEM Headless GraphQL Video Series](./video-series/modeling-basics.md)

## AEM Headless GraphQL Hands-on Tutorial

Utforska AEM GraphQL funktioner genom att bygga ut en React App som förbrukar innehållsfragment via AEM GraphQL API:er.

* [AEM Headless GraphQL Hands-on Tutorial](./multi-step/overview.md)

## AEM GraphQL vs. AEM Content Services

|                                | AEM GraphQL API:er | AEM Content Services |
|--------------------------------|:-----------------|:---------------------|
| Schemadefinition | Strukturerade modeller för innehållsfragment | AEM Components |
| Innehåll | Innehållsfragment | AEM Components |
| Innehållsidentifiering | Efter GraphQL-fråga | Efter AEM Page |
| Leveransformat | GraphQL JSON | AEM ComponentExporter JSON |
