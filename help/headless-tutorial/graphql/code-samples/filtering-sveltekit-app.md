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
duration: 22
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '113'
ht-degree: 0%

---

# Filtrera appen SvelteKit

Utforska möjligheten AEM Headless GraphQL API:er att lista data med en [SvelteKit](https://kit.svelte.dev/) -app. Den här SvelteKit-appen skapar en lista med WKND-äventyr som kan väljas för att visa information om äventyret.

Den här koden visar hur du använder Adobe [AEM Headless Client för JavaScript](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md) för att anropa beständiga GraphQL-frågor från SvelteKit. Den här appen använder den `wknd-shared/adventures-all` beständiga frågan för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. Äventyrsinformation begärs via den `wknd-shared/adventures-by-slug` beständiga frågan.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-slug`
