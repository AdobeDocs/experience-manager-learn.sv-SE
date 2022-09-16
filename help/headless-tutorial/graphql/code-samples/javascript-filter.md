---
title: Filtrera frågor
description: En JavaScript-implementering som gör att specifika innehållsfragment kan väljas och sedan visas deras information.
version: Cloud Service
mini-toc-levels: 1
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
kt: 11135
thumbnail: KT-11135.jpg
index: false
hide: true
hidefromtoc: true
source-git-commit: 680ed62141b853daf104a827067ca6d5a209796d
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---


# Filtrera frågor

I det här JavaScript- och Handlebars-exemplet visas hur du filtrerar GraphQL-resultat och visar de valda resultaten.

Den här koden:

+ Ansluter till [wknd.site](https://wknd.site)AEM Publish-tjänsten och kräver ingen autentisering
+ Använder beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-slug`
