---
title: Konfigurera ditt BPA- och CAM-projekt
description: Läs om hur Best Practice Analyzer och Cloud Acceleration Manager ger en anpassad guide för migrering till AEM as a Cloud Service.
version: Cloud Service
feature: Developer Tools
topic: Migration, Upgrade
role: Developer
level: Experienced
kt: 8627
thumbnail: 336957.jpeg
exl-id: f8289dd4-b293-4b8f-b14d-daec091728c0
source-git-commit: 1ddf6154d50a341d9a0fd4234392c37ced878a73
workflow-type: tm+mt
source-wordcount: '234'
ht-degree: 2%

---

# Best Practice Analyzer och Cloud Acceleration Manager

Läs om hur Best Practice Analyzer (BPA) och Cloud Acceleration Manager (CAM) ger en anpassad guide för migrering till AEM as a Cloud Service. 

>[!VIDEO](https://video.tv.adobe.com/v/336957/?quality=12&learn=on)

## Utvärdera beredskap

![Högnivådiagram för BPA och CAM](assets/bpa-cam-diagram.png)

BPA-paketet ska installeras på en klon av produktionsmiljön AEM 6.x. BPA kommer att generera en rapport som sedan kan överföras till CAM, som ger vägledning om de viktigaste aktiviteter som behöver utföras för att gå över till AEM as a Cloud Service.

### Viktiga aktiviteter

* Klona produktionen i 6.x-miljö. När du migrerar innehåll och kodar för omfakturor är det viktigt att ha en klon av en produktionsmiljö för att testa olika verktyg och ändringar.
* Hämta det senaste BPA-verktyget från [Programdistributionsportal](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html) och installera i din AEM 6.x-klonade miljö.
* Använd BPA-verktyget för att generera en rapport som kan överföras till Cloud Acceleration Manager (CAM). CAM är tillgängligt via [https://experience.adobe.com/](https://experience.adobe.com/) > **Experience Manager** > **Cloud Acceleration Manager**.
* Använd CAM för att få vägledning om vilka uppdateringar som behöver göras i den aktuella kodbasen och miljön för att gå över till AEM as a Cloud Service.
