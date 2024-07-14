---
title: Basic React-app
description: En grundläggande React-app som visar en lista över WKND-äventyr och deras information
version: Cloud Service
mini-toc-levels: 1
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-11134
thumbnail: KT-11134.jpg
index: false
hide: true
hidefromtoc: true
exl-id: 870be37f-68bb-4b0f-9918-e68b09be830e
duration: 17
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '91'
ht-degree: 0%

---

# Basic React-app

Den här [React](https://reactjs.org/)-appen visar hur du kan fråga efter innehåll med hjälp av AEM GraphQL-API:er med beständiga frågor. Det här programmet återger en filterbar version av WKND Adventures, och när du väljer ett äventyr visas all information om äventyren.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-slug`

Mer information om hur den här appen Next.js byggs finns i [exempeldokumentationen för appen React](../example-apps/react-app.md).
