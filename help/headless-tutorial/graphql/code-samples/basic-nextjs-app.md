---
title: Basic Next.js-app
description: En grundläggande Next.js-app som visar en lista över WKND-äventyr och deras information
version: Cloud Service
mini-toc-levels: 1
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-11368
thumbnail: KT-11368.jpg
index: false
hide: true
hidefromtoc: true
exl-id: 2d4396dc-2346-4561-b040-eba0ab62a96f
duration: 22
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '116'
ht-degree: 0%

---

# Basic Next.js-app

Detta [Next.js](https://nextjs.org/) app visar hur du kan fråga efter innehåll med hjälp AEM GraphQL API:er med beständiga frågor. Det här programmet återger en filterbar version av WKND Adventures, och när du väljer ett äventyr visas all information om äventyren.

Den här koden:

+ Ansluter till en AEM-publiceringstjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-slug`

Om du vill ha en mer detaljerad genomgång av hur den här appen Next.js byggs kan du gå igenom [Exempel på dokumentation för appen Next.js](../example-apps/next-js.md).

>[!IMPORTANT]
>
> Codesandbox.io stöder inte redigering av Next.js-programmet i den inbäddade IDE:n. Om du vill redigera det här kodexemplet [öppna appen Next.js direkt i codesandbox.io](https://codesandbox.io/s/wknd-next-js-app-u8x5f8).
