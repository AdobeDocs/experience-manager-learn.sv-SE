---
title: AEM Headless-driftsättningar
description: null
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
kt: null
thumbnail: KT-.jpg
mini-toc-levels: 2
source-git-commit: 10032375a23ba99f674fb59a6f6e48bf93908421
workflow-type: tm+mt
source-wordcount: '83'
ht-degree: 0%

---


# AEM Headless-driftsättningar

AEM Headless-driftsättningar är inbyggda mobilappar för iOS, Android osv. som konsumerar och interagerar med innehåll i AEM på ett headless sätt.

Mobila distributioner kräver minimal konfiguration eftersom HTTP-anslutningar till AEM Headless API:er inte initieras i webbläsarkontexten.

## Distributionskonfigurationer

| Mobilappen ansluter till | AEM Author | AEM Publish | AEM |
|-----------------------:|:----------:|:-----------:|:-----------:|
| [Dispatcher-filter](./dispatcher-fitlers.md) | ✘ | ✔ | ✔ |
| [CORS-konfiguration](./cors.md) | ✘ | ✘ | ✘ |
| Värdnamn för bild-URL | ✔ | ✔ | ✔ |

## Exempel på mobilappar

Adobe tillhandahåller exempelappar för iOS och Android.


