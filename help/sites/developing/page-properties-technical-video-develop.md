---
title: Utöka Sidegenskaper i AEM Sites
description: Lär dig hur du utökar metadatafälten för Sidegenskaper i Adobe Experience Manager Sites. I den här videon beskrivs det mest effektiva sättet att uppnå detta med funktionerna i Sling Resource Merger.
topic: Development
feature: Core Components
role: Developer
level: Intermediate
version: Cloud Service
jira: KT-243
thumbnail: 25173.jpg
doc-type: Technical Video
exl-id: 500f4e07-2686-42a2-8e44-d96dde02a112
duration: 488
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '198'
ht-degree: 0%

---

# Utöka sidegenskaper {#extending-page-properties-in-aem-sites}

Att anpassa metadatafälten för Sidegenskaper är ett vanligt krav i alla implementeringar av Sites. I den här videon beskrivs det mest effektiva sättet att uppnå detta med funktionerna i Sling Resource Merger.

>[!VIDEO](https://video.tv.adobe.com/v/25173?quality=12&learn=on)

I videon ovan visas hur du anpassar sidegenskaperna för [WKND-referenswebbplatsen](https://github.com/adobe/aem-guides-wknd).

## Exempel på paket med WKND-sidegenskaper

Du kan använda [exempelpaketet med WKND-sidegenskaper](./assets/WKND-PageProperties-Example-Dialog-1.0.zip) som innehåller **WKND**- och **Basic**-flikanpassningar som visas i videon ovan. Flikanpassningen **SocialMedia** tillhandahålls inte eftersom [WKND Page-komponenten](https://github.com/adobe/aem-guides-wknd/blob/main/ui.apps/src/main/content/jcr_root/apps/wknd/components/page/.content.xml#L5) nu använder V3-versionen av WCM Core-komponenter och i V3-versionen är den [sociala delningen föråldrad](https://github.com/adobe/aem-core-wcm-components/pull/1930).

I utbildningssyfte kan du emellertid peka WKND-sidkomponenten mot V2-versionen av WCM Core Components med egenskapsvärdet `sling:resourceSuperType` och täcka över fliken [ Sociala media](https://github.com/adobe/aem-core-wcm-components/blob/main/content/src/content/jcr_root/apps/core/wcm/components/page/v2/page/_cq_dialog/.content.xml#L95). Mer information finns i [Konfigurera dina sidegenskaper](https://experienceleague.adobe.com/docs/experience-manager-65/developing/extending-aem/page-properties-views.html#configuring-your-page-properties)

Det här exempelpaketet ska installeras på en lokal AEM SDK- eller AEM 6.X.X-instans i utbildningssyfte.
