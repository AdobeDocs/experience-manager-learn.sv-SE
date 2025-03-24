---
title: Filtrerar Angular-program
description: En enkel Angular-app som filtrerar WKND-äventyr med Content Fragments.
version: Experience Manager as a Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-11133
thumbnail: KT-11133.jpg
index: false
hide: true
hidefromtoc: true
exl-id: c238dd83-65d3-4b04-b90e-19ed250b8e36
duration: 26
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '130'
ht-degree: 0%

---

# Filtrerar Angular-program

Utforska AEM Headless GraphQL API:er för att filtrera data med en [Angular](https://angular.io/) -app. Den här Angular-appen skapar en lista över WKND-äventyr som kan filtreras efter aktivitetstyp.

Den här koden visar hur du använder Adobe [AEM Headless Client för JavaScript](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md) för att anropa beständiga GraphQL-frågor från Angular. Den här appen använder den `wknd-shared/adventures-all` beständiga frågan för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. När en användare väljer en aktivitetstyp skickas den valda typen till den `wknd-shared/adventures-by-activity` beständiga frågan och hämtar äventyrsinformationen för endast de äventyren med den angivna aktivitetstypen.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-activity`
