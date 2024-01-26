---
title: Filtrera React-app
description: En enkel React-app som filtrerar WKND-äventyr med Content Fragments.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-11132
thumbnail: KT-11132.jpg
index: false
hide: true
hidefromtoc: true
exl-id: 1eb9487e-a82a-4d15-a776-cf004f2e3f01
duration: 32
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '130'
ht-degree: 0%

---

# Filtrera React-app

Utforska AEM Headless GraphQL API:er för att filtrera data med en [Reagera](https://reactjs.org/) app. Den här React-appen skapar en lista över WKND-äventyr som kan filtreras efter aktivitetstyp.

Den här koden visar hur du använder Adobe [AEM Headless Client for JavaScript](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md) för att anropa beständiga GraphQL-frågor från React. Den här appen använder `wknd-shared/adventures-all` beständig fråga för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. När en användare väljer en aktivitetstyp skickas den valda typen till `wknd-shared/adventures-by-activity` beständig fråga och hämtar äventyrsinformation endast för äventyren med den angivna aktivitetstypen.

Den här koden:

+ Ansluter till en AEM-publiceringstjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-activity`
