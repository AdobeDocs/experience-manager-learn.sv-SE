---
title: Kom igång med AEM Headless - GraphQL
description: Läs mer om API:erna för GraphQL och deras funktioner i Experience Manager.
feature: Content Fragments, GraphQL API, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 0056971f-2f89-43b3-bb6f-dd16c2a50370
source-git-commit: 129dedd4cd6973d5d576bed5f714ce62152923de
workflow-type: tm+mt
source-wordcount: '268'
ht-degree: 1%

---

# Komma igång med AEM Headless - GraphQL {#getting-started-with-aem-headless}

AEM GraphQL API:er för innehållsfragment har stöd för headless CMS-scenarier där externa klientprogram återger upplevelser med innehåll som hanteras i AEM.

Ett modernt API för innehållsleverans är avgörande för effektiviteten och prestandan i Javascript-baserade klientprogram. Att använda ett REST API medför utmaningar:

* Ett stort antal begäranden om att hämta ett objekt i taget
* Innehåll som ofta&quot;överlevererar&quot;, vilket innebär att programmet får mer än det behöver

För att övervinna dessa utmaningar tillhandahåller GraphQL ett frågebaserat API som gör att klienter kan fråga AEM efter endast det innehåll som behövs och ta emot via ett enda API-anrop.

>[!VIDEO](https://video.tv.adobe.com/v/328618/?quality=12&learn=on)

Den här videon är en översikt över GraphQL API som implementeras i AEM. GraphQL-API:t i AEM är främst utformat för att leverera AEM Content Fragment-program till program längre fram i kedjan som en del av en headlessdistribution.

>[!CONTEXTUALHELP]
>id="aemcloud_learn_headless_graphql_overview"
>title="Komma igång med AEM Headless - GraphQL"
>abstract="Lär dig hur du levererar innehållsfragment med GraphQL."
>additional-url="https://video.tv.adobe.com/v/328618" text="Översikt över GraphQL i AEM"

## AEM Headless GraphQL Video Series

Lär dig mer om AEM GraphQL-funktioner genom ingående genomgång av Content Fragments och AEM GraphQL API:er och utvecklingsverktyg.

* [AEM Headless GraphQL Video Series](./video-series/modeling-basics.md)

## AEM Headless GraphQL Hands-on Tutorial

Utforska AEM GraphQL-funktioner genom att bygga ut en React App som förbrukar innehållsfragment via AEM GraphQL API:er.

* [AEM Headless GraphQL Hands-on Tutorial](./multi-step/overview.md)

## AEM GraphQL vs. AEM Content Services

|  | AEM GraphQL API:er | AEM Content Services |
|--------------------------------|:-----------------|:---------------------|
| Schemadefinition | Strukturerade modeller för innehållsfragment | AEM |
| Innehåll | Innehållsfragment | AEM |
| Innehållsidentifiering | Efter GraphQL-fråga | Efter AEM |
| Leveransformat | GraphQL JSON | AEM ComponentExporter JSON |
