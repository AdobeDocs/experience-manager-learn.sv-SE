---
title: Filtrera med jQuery och Handtag
description: En JavaScript-implementering som använder jQuery och Handlebars som filtrerar WKND-annonser som ska visas. .
version: Cloud Service
mini-toc-levels: 1
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-11135
thumbnail: KT-11135.jpg
index: false
hide: true
hidefromtoc: true
exl-id: 75ffd84a-62b1-480f-b05f-3664f54bb171
duration: 26
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '138'
ht-degree: 0%

---

# Filtrera med jQuery och Handtag

Utforska möjligheten AEM Headless GraphQL API:er att filtrera data med en JavaScript-app som använder [jQuery](https://jquery.com/) och [Handlebars](https://handlebarsjs.com/). Den här appen skapar en lista med WKND-äventyr som kan filtreras efter aktivitetstyp.

Den här koden visar hur du använder Adobe [AEM Headless Client för JavaScript](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md) för att anropa beständiga GraphQL-frågor. Den här appen använder den `wknd-shared/adventures-all` beständiga frågan för att samla in alla äventyr och härleda en lista över tillgängliga aktivitetstyper. När en användare väljer en aktivitetstyp skickas den valda typen till den `wknd-shared/adventures-by-activity` beständiga frågan och hämtar äventyrsinformationen för endast de äventyren med den angivna aktivitetstypen.

Den här koden:

+ Ansluter till en AEM Publish-tjänst och kräver ingen autentisering
+ Använder WKND:s beständiga frågor: `wknd-shared/adventures-all` och `wknd-shared/adventures-by-activity`
