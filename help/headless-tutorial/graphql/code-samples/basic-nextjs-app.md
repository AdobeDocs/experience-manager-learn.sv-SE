---
title: Basic Next.js-app
description: En grundläggande Next.js-app som visar en lista över WKND-äventyr och deras information
version: Cloud Service
mini-toc-levels: 1
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
kt: 11368
thumbnail: KT-11368.jpg
index: false
hide: true
hidefromtoc: true
source-git-commit: 74510a4b075d2dba9b3f27018ba05f15dcad9562
workflow-type: tm+mt
source-wordcount: '92'
ht-degree: 0%

---


# Basic Next.js-app

Detta [Next.js](https://nextjs.org/) app visar hur du kan fråga efter innehåll med hjälp AEM GraphQL API:er med beständiga frågor. Det här programmet återger en filterbar version av WKND Adventures, och när du väljer ett äventyr visas all information om äventyren.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-slug`

Om du vill ha en mer detaljerad genomgång av hur den här appen Next.js byggs kan du gå igenom [Exempel på dokumentation för appen Next.js](../example-apps/next-js.md).
