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
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '266'
ht-degree: 0%

---

# Komma igång med AEM Headless - GraphQL {#getting-started-with-aem-headless}

{{aem-headless-trials-promo}}

AEM GraphQL API:er för innehållsfragment har stöd för headless CMS-scenarier där externa klientprogram återger upplevelser med innehåll som hanteras i AEM.

Ett modernt API för innehållsleverans är avgörande för effektiviteten och prestandan i Javascript-baserade klientprogram. Att använda ett REST API medför utmaningar:

* Ett stort antal begäranden om att hämta ett objekt i taget
* Innehåll som ofta&quot;överlevererar&quot;, vilket innebär att programmet får mer än det behöver

För att lösa dessa problem tillhandahåller GraphQL ett frågebaserat API som gör det möjligt för kunderna att fråga AEM efter endast det innehåll de behöver och att ta emot via ett enda API-anrop.

>[!VIDEO](https://video.tv.adobe.com/v/328618?quality=12&learn=on)

Den här videon är en översikt över GraphQL API som implementerats i AEM. GraphQL API i AEM är främst utformat för att leverera AEM Content Fragment till program längre fram i kedjan som en del av en headless-driftsättning.

>[!CONTEXTUALHELP]
>id="aemcloud_learn_headless_graphql_overview"
>title="Komma igång med AEM Headless - GraphQL"
>abstract="Lär dig hur du levererar innehållsfragment med GraphQL."
>additional-url="https://video.tv.adobe.com/v/328618" text="Översikt över GraphQL i AEM"

## AEM Headless GraphQL Video Series

Lär dig mer om AEM funktioner i GraphQL genom den djupgående genomgången av Content Fragments och AEM GraphQL API:er och utvecklingsverktyg.

* [AEM Headless GraphQL Video Series](./video-series/modeling-basics.md)

## AEM Headless GraphQL Hands-on Tutorial

Utforska AEM GraphQL funktioner genom att bygga ut en React App som förbrukar innehållsfragment via AEM GraphQL API:er.

* [AEM Headless GraphQL Hands-on Tutorial](./multi-step/overview.md)

## AEM GraphQL jämfört med AEM Content Services

|                                | AEM GraphQL API:er | AEM Content Services |
|--------------------------------|:-----------------|:---------------------|
| Schemadefinition | Strukturerade modeller för innehållsfragment | AEM |
| Innehåll | Innehållsfragment | AEM |
| Innehållsidentifiering | Efter GraphQL-fråga | Efter AEM |
| Leveransformat | GraphQL JSON | AEM ComponentExporter JSON |
