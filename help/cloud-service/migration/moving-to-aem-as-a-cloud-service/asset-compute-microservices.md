---
title: AEM Assets Microservices och gå över till AEM as a Cloud Service
description: Se hur AEM Assets as a Cloud Service mikrotjänster på asset compute gör det möjligt att automatiskt och effektivt generera alla renderingar av dina resurser och ersätta det traditionella AEM arbetsflödet.
version: Cloud Service
feature: Asset Compute Microservices
topic: Migration, Upgrade
role: Developer
level: Experienced
kt: 8635
thumbnail: 336990.jpeg
exl-id: 327e8663-086b-4b31-b159-a0cf30480b45
source-git-commit: 1ddf6154d50a341d9a0fd4234392c37ced878a73
workflow-type: tm+mt
source-wordcount: '213'
ht-degree: 1%

---

# AEM Assets Microservices - Moving to AEM as a Cloud Service

Se hur AEM Assets as a Cloud Service mikrotjänster på asset compute gör det möjligt att automatiskt och effektivt generera alla renderingar av dina resurser och ersätta det traditionella AEM arbetsflödet.

>[!VIDEO](https://video.tv.adobe.com/v/336990/?quality=12&learn=on)

## Arbetsflödesmigreringsverktyg

![Verktyg för resursarbetsflödesmigrering](./assets/asset-workflow-migration.png)

Använd [Verktyget för arbetsflödesmigrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/moving/refactoring-tools/asset-workflow-migration-tool.html) för att migrera befintliga arbetsflöden för att använda Asset compute-mikrotjänsterna på AEM as a Cloud Service.

### Viktiga aktiviteter

* Använd [Adobe I/O Workflow Migrator](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#command-aio-aem-migrationworkflow-migrator) verktyg för att migrera arbetsflöden för bearbetning av resurser så att de kan använda Asset compute mikrotjänster.
* Konfigurera en [lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html) och driftsätta de uppdaterade arbetsflödena. Manuell justering kan behövas för komplexa arbetsflöden.
* Fortsätt att iterera i en lokal utvecklingsmiljö med AEM SDK tills det uppdaterade arbetsflödet matchar funktionsparitet.
* Distribuera den uppdaterade kodbasen till en AEM as a Cloud Service utvecklingsmiljö och fortsätt att validera.

