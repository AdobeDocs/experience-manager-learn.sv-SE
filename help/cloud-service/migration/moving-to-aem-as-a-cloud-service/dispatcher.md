---
title: Konfigurera Dispatcher vid flyttning till AEM as a Cloud Service
description: Lär dig mer om AEM Dispatcher för AEM as a Cloud Service, Dispatcher-konverteringsverktyget och hur du använder Dispatcher Tools SDK.
version: Cloud Service
feature: Dispatcher
topic: Migration, Upgrade
role: Developer
level: Experienced
kt: 8633
thumbnail: 336962.jpeg
exl-id: 81397b21-b4f3-4024-a6da-a9b681453eff
source-git-commit: 53a314c5cd9eaad5a26a0992c750c159f8e3697f
workflow-type: tm+mt
source-wordcount: '174'
ht-degree: 2%

---

# Dispatcher

Lär dig mer om AEM Dispatcher for AEM as a Cloud Service, med fokus på betydande ändringar från Dispatcher för AEM 6, Dispatcher-konverteringsverktyget och hur du använder Dispatcher Tools SDK.

>[!VIDEO](https://video.tv.adobe.com/v/336962/?quality=12&learn=on)

## Dispatcher Converter

![Dispatcher Converter](./assets/dispatcher-converter-diagram.png)

Använd [AEM Dispatcher Converter](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/moving/refactoring-tools/dispatcher-transformation-utility-tools.html) för att omforma befintliga konfigurationer för Adobe Managed Services Dispatcher eller Adobe Managed Services Dispatcher till AEM as a Cloud Service kompatibla Dispatcher-konfigurationer.

### Viktiga aktiviteter

* Använd [Adobe I/O Dispatcher Converter](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#aio-aem-migrationdispatcher-converter) för att migrera en befintlig Dispatcher-konfiguration.
* Referera till modulen Dispatcher från [AEM Project Archetype](https://github.com/adobe/aem-project-archetype/tree/develop/src/main/archetype/dispatcher.cloud) som bästa praxis.
* [Konfigurera lokala Dispatcher-verktyg](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/dispatcher-tools.html) för att validera dispatchern, innan du testar i en Cloud Service-miljö.


