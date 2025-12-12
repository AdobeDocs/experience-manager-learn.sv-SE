---
title: Komma igång med AEM Headless - Innehållstjänster
description: En komplett självstudiekurs som visar hur du bygger upp och visar innehåll med hjälp av AEM Headless.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 5aa32791-861a-48e3-913c-36028373b788
duration: 311
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '327'
ht-degree: 3%

---

# Komma igång med AEM Headless - Innehållstjänster

AEM Content Services använder traditionella AEM Pages för att skapa rubrikfria REST API-slutpunkter och AEM Components definierar, eller refererar, det innehåll som ska visas på dessa slutpunkter.

Med AEM Content Services kan samma innehållsabstraktioner som används för att skapa webbsidor i AEM Sites definiera innehåll och scheman för dessa HTTP-API:er. Med AEM Pages och AEM Components kan marknadsförarna snabbt komponera och uppdatera flexibla JSON-API:er som kan användas i alla applikationer.

## Självstudiekurs om innehållstjänster

En heltäckande självstudiekurs som visar hur man bygger upp och exponerar innehåll med AEM och som används av en inbyggd mobilapp i ett headless CMS-scenario.

>[!VIDEO](https://video.tv.adobe.com/v/28315?quality=12&learn=on)

I den här självstudiekursen utforskas hur AEM Content Services kan användas för att driva upplevelsen av en mobilapp som visar händelseinformation (musik, prestanda, konst osv.) som struktureras av WKND-teamet.

Den här självstudiekursen kommer att omfatta följande ämnen:

* Skapa innehåll som representerar en händelse med innehållsfragment
* Definiera slutpunkter för AEM Content Services med AEM Sites mallar och sidor som visar händelsedata som JSON
* Se hur AEM WCM Core Components kan användas för att marknadsförarna ska kunna skapa JSON-slutpunkter
* Förbruka AEM Content Services JSON från en mobilapp
   * Användningen av Android beror på att det har en plattformsoberoende emulator som alla användare (Windows, macOS och Linux) av den här självstudiekursen kan använda för att köra programmet.

## GitHub-projekt

Källkoden och innehållspaketen är tillgängliga på [AEM Guides - WKND Mobile GitHub Project](https://github.com/adobe/aem-guides-wknd-mobile).

Om du har problem med självstudiekursen eller koden lämnar du ett [GitHub-problem](https://github.com/adobe/aem-guides-wknd-mobile/issues).

## AEM GraphQL vs. AEM Content Services

|                                | AEM GraphQL API:er | AEM Content Services |
|--------------------------------|:-----------------|:---------------------|
| Schemadefinition | Strukturerade modeller för innehållsfragment | AEM Components |
| Innehåll | Innehållsfragment | AEM Components |
| Innehållsidentifiering | Efter GraphQL-fråga | Efter AEM Page |
| Leveransformat | GraphQL JSON | AEM ComponentExporter JSON |
