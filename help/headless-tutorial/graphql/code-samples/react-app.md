---
title: Reagera app
description: En enkel React-app som visar WKND-äventyr med Content Fragments.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
kt: 11132
thumbnail: KT-11132.jpg
index: false
hide: true
hidefromtoc: true
source-git-commit: 680ed62141b853daf104a827067ca6d5a209796d
workflow-type: tm+mt
source-wordcount: '65'
ht-degree: 0%

---


# Reagera app

Utforska AEM Headless GraphQL API:er med en enkel React-app. Den här React-appen visar en lista över WKND-äventyr och ger en detaljerad vy för varje äventyr.

Den här koden:

+ Ansluter till [wknd.site](https://wknd.site)AEM Publish-tjänsten och kräver ingen autentisering
+ Använder beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-slug`
