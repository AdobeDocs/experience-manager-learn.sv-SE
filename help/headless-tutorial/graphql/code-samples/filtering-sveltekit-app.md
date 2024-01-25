---
title: Simple SvelteKit-app
description: En enkel SvelteKit-app som visar WKND-äventyr som har modellerats med Content Fragments.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-11811
thumbnail: KT-11811.jpg
index: false
hide: true
recommendations: noCatalog, noDisplay
hidefromtoc: true
exl-id: 2e5bd50e-c0d7-4292-8097-e0a17f41a91a
duration: 24
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '113'
ht-degree: 0%

---

# Filtrera appen SvelteKit

Utforska AEM Headless GraphQL API:er med en [SvelteKit](https://kit.svelte.dev/) app. Den här SvelteKit-appen skapar en lista med WKND-äventyr som kan väljas för att visa information om äventyret.

Den här koden visar hur du använder Adobe [AEM Headless Client for JavaScript](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md) för att anropa beständiga GraphQL-frågor från SvelteKit. Den här appen använder `wknd-shared/adventures-all` beständig fråga för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. Äventyrsinformation begärs via `wknd-shared/adventures-by-slug` beständig fråga.

Den här koden:

+ Ansluter till en AEM-publiceringstjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-slug`
