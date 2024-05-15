---
title: Reagera på appredigering med Universal Editor
description: Lär dig hur du redigerar innehållet i ett exempel på React-program med Universal Editor.
version: Cloud Service
feature: Developer Tools, Headless
topic: Development, Content Management
role: Architect, Developer
level: Intermediate
doc-type: Tutorial
duration: 87
last-substantial-update: 2024-04-19T00:00:00Z
jira: KT-15359
thumbnail: KT-15359.png
exl-id: 69ed610e-2eff-43b3-98f9-3dc40594e879
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '415'
ht-degree: 0%

---

# Reagera på appredigering med Universal Editor

Lär dig hur du redigerar innehållet i ett exempel på React-program med Universal Editor. Innehållet lagras i AEM och hämtas med GraphQL API:er.

I den här självstudiekursen får du hjälp med att konfigurera den lokala utvecklingsmiljön, med hjälp av React-appen för att redigera innehållet och med hjälp av Universella redigerare redigera innehållet.

## Vad du lär dig

Den här självstudiekursen handlar om följande ämnen:

- En kort översikt över Universal Editor
- Konfigurera den lokala utvecklingsmiljön
   - **AEM SDK**: innehåller innehåll som lagras i innehållsfragment för React-appen med GraphQL API:er.
   - **Reagera-app**: ett enkelt användargränssnitt som visar innehållet från AEM.
   - **Universell redigeringstjänst**: a _lokal kopia av Universal Editor-tjänsten_ som binder Universal Editor och AEM SDK.
- Hur man instrumenterar React-appen för att redigera innehåll med Universal Editor
- Redigera innehållet i React-appen med Universal Editor


## Översikt över Universal Editor

Den universella redigeraren ger möjlighet för skribenter och utvecklare (front-end och back-end) att ta del av några av fördelarna med den universella redigeraren:

- Skapat för att redigera headless och headful content i WYSIWYG-läge (What-you-see-is-what-you-get).
- Innehållsredigeringen är enhetlig och fungerar på olika frontend-tekniker som React, Angular, Vue etc. Därmed kan innehållsförfattarna redigera innehållet utan att behöva oroa sig för den underliggande tekniken.
- Det krävs mycket minimalt med instrument för att aktivera den universella redigeraren i frontendprogrammet. Det innebär att maximera utvecklarens produktivitet och låta dem fokusera på att skapa upplevelsen.
- Man kan skilja mellan tre roller, innehållsförfattare, gränssnittsutvecklare och backend-utvecklare, så att varje roll kan fokusera på sitt huvudansvar.


## Sample React-app

Den här självstudiekursen använder [**WKND Teams**](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/basic-tutorial#react-app---basic-tutorial---teampersons) som exempelappen React. The **WKND Teams** React-appen visar en lista över teammedlemmar och deras information.

Teaminformation som titel, beskrivning och teammedlemmar lagras som _Team_ Innehållsfragment i AEM. Personinformation som namn, biografi och profilbild lagras på samma sätt som _Person_ Innehållsfragment i AEM.

Innehållet i React-appen tillhandahålls av AEM med GraphQL API:er och användargränssnittet byggs med två React-komponenter, `Teams` och `Person`.

Det finns en motsvarande självstudiekurs om hur du skapar **WKND Teams** Reagera-app. Du hittar självstudiekursen [här](https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview).

## Nästa steg

Lär dig hur [konfigurera den lokala utvecklingsmiljön](./local-development-setup.md).
