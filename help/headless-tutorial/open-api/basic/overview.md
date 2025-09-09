---
title: AEM Headless OpenAPI - självstudiekurs | Leverans av innehållsfragment
description: En komplett självstudiekurs som visar hur man bygger upp och exponerar innehåll med AEM OpenAPI-baserade API:er för Content Fragment Delivery.
doc-type: Tutorial
mini-toc-levels: 1
jira: KT-6678
thumbnail: KT-6678.jpg
feature: Content Fragments
topic: Headless, Content Management
role: Developer
level: Beginner
last-substantial-update: 2022-10-17T00:00:00Z
duration: 54
source-git-commit: c6213dd318ec4865375c57143af40dbe3f3990b1
workflow-type: tm+mt
source-wordcount: '365'
ht-degree: 1%

---

# Kom igång med AEM Content Fragment Delivery med OpenAPI:er

Utforska den här självstudiekursen som visar hur du bygger upp och visar AEM-innehåll med AEM Content Fragment Delivery med OpenAPI-API:er och använder det i ett headless CMS-scenario. Detta utforskar dessa koncept genom att gå och tänka på hur en React-app skapas som visar WKND-team och tillhörande medlemsinformation. Team och medlemmar modelleras med AEM Content Fragment Models och används av React-appen med AEM Content Fragment Delivery med OpenAPI:er.

![WKND Teams-app](./assets/overview/main.png)

Den här självstudiekursen handlar om följande ämnen:

* Skapa en projektkonfiguration
* Skapa modeller för innehållsfragment för att modellera data
* Skapa innehållsfragment baserat på tidigare modeller
* Se hur Content Fragments in AEM kan efterfrågas med AEM Content Fragment Delivery med dokumentationsfunktionen &quot;Try it&quot; i OpenAPI:er
* Förbruka data för innehållsfragment via AEM Content Fragment Delivery med OpenAPI-API-anrop från ett exempel på React-app
* Förbättra React-appen så att den kan redigeras i den universella redigeraren

## Förutsättningar {#prerequisites}

Du måste följa den här självstudiekursen på följande sätt:

* AEM Sites as a Cloud Service
* HTML och JavaScript
* Följande verktyg måste installeras lokalt:
   * [Node.js v22+](https://nodejs.org/)
   * [Git](https://git-scm.com/)
   * En IDE (till exempel [Microsoft® Visual Studio Code](https://code.visualstudio.com/))

### AEM as a Cloud Service

Du bör ha **AEM Administrator**-åtkomst till en AEM as a Cloud Service-miljö för att kunna slutföra den här självstudiekursen. En **utvecklingsmiljö**, **snabbutvecklingsmiljö** eller en miljö i ett **sandlådeprogram** kan också användas.

## Kom så börjar vi!

Starta självstudiekursen med [Definiera modeller för innehållsfragment](1-content-fragment-models.md).

## GitHub-projekt

Källkoden och innehållspaketen är tillgängliga i [AEM Headless-självstudiekurserna](https://github.com/adobe/aem-tutorials) GitHub-databasen.

Branschen [`main` innehåller den slutliga källkoden ](https://github.com/adobe/aem-tutorials/tree/main/headless/open-api/basic) för den här självstudien.
Ögonblicksbilder av koden i slutet av varje steg är tillgängliga som Git-taggar.

* Början av kapitel 4 - Reagera app: [`headless_open-api_basic`](https://github.com/adobe/aem-tutorials/tree/headless_open-api_basic//headless/open-api/basic)
* Slut på kapitel 4 - Reagera app: [`headless_open-api_basic_4-end`](https://github.com/adobe/aem-tutorials/tree/headless_open-api_basic_4-end//headless/open-api/basic)
* Slut på kapitel 5 - Universal Editor: [`headless_open-api_basic_5-end`](https://github.com/adobe/aem-tutorials/tree/headless_open-api_basic_5-end//headless/open-api/basic)

Om du har problem med självstudiekursen eller koden kan du lämna ett [GitHub-problem](https://github.com/adobe/aem-tutorials/issues).
