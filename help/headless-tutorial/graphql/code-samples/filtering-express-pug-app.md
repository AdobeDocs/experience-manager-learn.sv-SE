---
title: Filtrera appen ExpressJS och Pug
description: En enkel ExpressJS/Pug-app som filtrerar WKND-äventyr med hjälp av Content Fragments.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
kt: 11812
thumbnail: KT-11812.jpg
index: false
hide: true
hidefromtoc: true
source-git-commit: c96b8c9761ff9477fda40d641db5021994b32754
workflow-type: tm+mt
source-wordcount: '145'
ht-degree: 0%

---


# Filtrera appen ExpressJS och Pug

Utforska AEM Headless GraphQL API:er för att filtrera data med en [ExpressJS](https://expressjs.com/)/[Pug](https://pugjs.org/) app. Den här ExpressJS/Pug-appen skapar en lista över WKND-äventyr som kan filtreras efter aktivitetstyp.

Den här koden visar hur du använder Adobe [AEM Headless Client för NodeJS](https://github.com/adobe/aem-headless-client-nodejs#aem-headless-client-for-nodejs) för att anropa beständiga GraphQL-frågor med Node.js-baserad JavaScript. Den här appen använder `wknd-shared/adventures-all` beständig fråga för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. När en användare väljer en aktivitetstyp skickas den valda typen till `wknd-shared/adventures-by-activity` beständig fråga och hämtar äventyrsinformation endast för äventyren med den angivna aktivitetstypen.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-activity`
