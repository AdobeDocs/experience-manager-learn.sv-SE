---
title: Program för filtrering av Angular
description: En enkel Angular som filtrerar WKND-äventyr med Content Fragments.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
kt: 11133
thumbnail: KT-11133.jpg
index: false
hide: true
hidefromtoc: true
source-git-commit: 74510a4b075d2dba9b3f27018ba05f15dcad9562
workflow-type: tm+mt
source-wordcount: '137'
ht-degree: 0%

---


# Program för filtrering av Angular

Utforska AEM Headless GraphQL API:er för att filtrera data med en [Angular](https://angular.io/) app. Den här Angularna skapar en lista med WKND-äventyr som kan filtreras efter aktivitetstyp.

Den här koden visar hur du använder Adobe [AEM Headless Client for JavaScript](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md) om du vill anropa beständiga GraphQL-frågor från Angularna. Den här appen använder `wknd-shared/adventures-all` beständig fråga för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. När en användare väljer en aktivitetstyp skickas den valda typen till `wknd-shared/adventures-by-activity` beständig fråga och hämtar äventyrsinformation endast för äventyren med den angivna aktivitetstypen.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-activity`
