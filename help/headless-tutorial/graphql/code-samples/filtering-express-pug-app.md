---
title: Filtrera Express-app
description: En enkel Express-app som filtrerar WKND-äventyr med Content Fragments.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-11812
thumbnail: KT-11812.jpg
index: false
hide: true
hidefromtoc: true
recommendations: noCatalog, noDisplay
exl-id: b64f33ab-cd18-4cbc-a57e-baf505f1442a
duration: 29
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '144'
ht-degree: 0%

---

# Filtrera Express-app

Utforska möjligheten AEM Headless GraphQL API:er att filtrera data med en [Express](https://expressjs.com/) - och [Pug](https://pugjs.org/) -app. Den här Express-appen skapar en lista över WKND-äventyr som kan filtreras efter aktivitetstyp.

Den här koden visar hur du använder Adobe [AEM Headless Client för NodeJS](https://github.com/adobe/aem-headless-client-nodejs#aem-headless-client-for-nodejs) för att anropa beständiga GraphQL-frågor med hjälp av Node.js-baserad JavaScript. Den här appen använder den `wknd-shared/adventures-all` beständiga frågan för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. När en användare väljer en aktivitetstyp skickas den valda typen till den `wknd-shared/adventures-by-activity` beständiga frågan och hämtar äventyrsinformationen för endast de äventyren med den angivna aktivitetstypen. Äventyrsinformation hämtas från AEM via den `wknd-shared/adventures-by-slug` beständiga frågan.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all`, `wknd-shared/adventures-by-activity` och `wknd-shared/adventures-by-slug`
