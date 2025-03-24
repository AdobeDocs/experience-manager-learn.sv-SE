---
title: Utvecklingsaspekter
description: Fundera på effekten på frontend- och back-end-utvecklingsprocessen när du aktiverar front-end-flödet.
version: Experience Manager as a Cloud Service
feature: AEM Project Archetype, Cloud Manager, CI-CD Pipeline
topic: Content Management, Development, Development, Architecture
role: Developer, Architect, Admin
level: Intermediate
jira: KT-10689
mini-toc-levels: 1
index: y
recommendations: noDisplay, noCatalog
doc-type: Tutorial
exl-id: a3b27d5b-b167-4c60-af49-8f2e8d814c86
duration: 79
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '201'
ht-degree: 0%

---

# Utvecklingsaspekter

När frontend-pipelinen har aktiverats för att endast distribuera frontresurserna i AEM as a Cloud Service-miljön har det en viss inverkan på den lokala AEM-utvecklingen och du måste justera Git-förgreningsmodellen.

## Syfte

* Så här får du ett smidigt utvecklingsflöde för både fram- och baksida
* Granska beroendena mellan hela stacken och frontendpipeline


## Lokala utvecklingsöverväganden

>[!VIDEO](https://video.tv.adobe.com/v/3409421?quality=12&learn=on)


## Justerad utvecklingsmetod

* För lokal utveckling med AEM SDK behöver back-end-dev-teamet fortfarande klientlib-generering via modulen `ui.frontend`, men under Cloud Manager-distributionen till AEM as a Cloud Service-miljön måste du hoppa över det. Det här visar en utmaning om hur du isolerar ändringar i projektkonfigurationen som beskrivs i kapitlet [Uppdatera projekt](update-project.md).

En __lösning__ kan vara att justera Git-förgreningsmodellen och se till att AEM projektkonfigurationsändringar aldrig kommer tillbaka till den __lokala utvecklingsgrenen__ som AEM serverutvecklare använder.


* Om du inför nya komponenter eller uppdaterar en befintlig komponent som har ändrats i både modulen `ui.app` och `ui.frontend` måste du köra både fullständiga och främre rörledningar som en del av en pågående förbättring i ditt AEM-projekt.
