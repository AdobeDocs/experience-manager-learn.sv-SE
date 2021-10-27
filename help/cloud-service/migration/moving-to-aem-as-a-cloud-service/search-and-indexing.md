---
title: Söka och indexera på AEM as a Cloud Service
description: Lär dig mer om AEM as a Cloud Service sökindex, hur du konverterar AEM 6 indexdefinitioner och hur du distribuerar index.
version: Cloud Service
feature: Search
topic: Migration, Upgrade
role: Developer
level: Experienced
kt: 8634
thumbnail: 336963.jpeg
exl-id: f752df86-27d4-4dbf-a3cb-ee97b7d9a17e
source-git-commit: 1ddf6154d50a341d9a0fd4234392c37ced878a73
workflow-type: tm+mt
source-wordcount: '211'
ht-degree: 0%

---

# Söka och indexera

Lär dig mer om AEM as a Cloud Service sökindex, hur du konverterar AEM 6-indexdefinitioner till AEM as a Cloud Service kompatibla och hur du distribuerar index till AEM as a Cloud Service.

>[!VIDEO](https://video.tv.adobe.com/v/336963/?quality=12&learn=on)

## Indexkonverterare

![Indexkonverterare](./assets/index-converter.png)

Använd [Indexkonverteringsverktyg](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#command-aio-aem-migrationindex-converter) om du vill konvertera anpassade indexdefinitioner för ekv till AEM as a Cloud Service kompatibla indexdefinitioner.

### Viktiga aktiviteter

* Använd [Adobe I/O Workflow Migrator](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#command-aio-aem-migrationindex-converter) verktyg för att migrera arbetsflöden för bearbetning av resurser så att de kan använda Asset compute mikrotjänster.
* Konfigurera en [lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html) och driftsätta anpassade index. Se till att de uppdaterade indexen är uppdaterade.
* Distribuera den uppdaterade kodbasen till en AEM as a Cloud Service utvecklingsmiljö och fortsätt att validera.
* Om du ändrar ett utanför rutans index **ALLTID** kopiera den senaste indexdefinitionen från en AEM as a Cloud Service miljö som körs i den senaste versionen. Ändra den kopierade indexdefinitionen efter dina behov.