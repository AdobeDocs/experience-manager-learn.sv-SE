---
title: Utvecklingsaspekter
description: Fundera på effekten på frontend- och back-end-utvecklingsprocessen när du aktiverar front-end-flödet.
version: Cloud Service
type: Tutorial
feature: AEM Project Archetype, Cloud Manager, CI-CD Pipeline
topic: Content Management, Development, Development, Architecture
role: Developer, Architect, Admin
level: Intermediate
kt: 10689
mini-toc-levels: 1
index: y
recommendations: noDisplay, noCatalog
source-git-commit: b3e9251bdb18a008be95c1fa9e5c79252a74fc98
workflow-type: tm+mt
source-wordcount: '201'
ht-degree: 0%

---


# Utvecklingsaspekter

När du har aktiverat frontend-pipelinen för att endast distribuera frontendresurserna i AEM as a Cloud Service miljö påverkas den lokala AEM utvecklingen och du måste justera Git-förgreningsmodellen.

## Syfte

* Så här får du ett smidigt utvecklingsflöde för både fram- och baksida
* Granska beroendena mellan hela stacken och frontendpipeline


## Lokala utvecklingsöverväganden

>[!VIDEO](https://video.tv.adobe.com/v/3409421?quality=12&learn=on)


## Justerad utvecklingsmetod

* För den lokala utvecklingen med AEM SDK behöver back-end dev-teamet fortfarande generering av klientlib via `ui.frontend` men under distributionen av Cloud Manager till AEM as a Cloud Service miljö måste du hoppa över den. Det här utgör en utmaning om hur du isolerar ändringar i projektkonfigurationen som beskrivs i [Uppdatera projekt](update-project.md) kapitel.

A __lösning__ kan vara att justera Git-förgreningsmodellen och se till att AEM ändringar i projektkonfigurationen aldrig kommer tillbaka till __lokal utveckling__ som AEM bakomliggande utvecklare använder.


* Som en del av en pågående förbättring av AEM projekt, om du introducerar nya komponenter eller uppdaterar en befintlig komponent som har ändringar i båda `ui.app` och `ui.frontend` måste du köra både fullstacks- och frontendpipelines.



