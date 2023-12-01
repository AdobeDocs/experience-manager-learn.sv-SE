---
title: Felsöka en taggimplementering
description: En introduktion till några vanliga verktyg och tekniker för att felsöka en taggimplementering. Lär dig hur du använder webbläsarens utvecklarkonsol och tillägget Experience Platform Debugger för att identifiera och felsöka viktiga aspekter av en taggimplementering.
solution: Experience Manager, Data Collection, Experience Platform
jira: KT-6047
thumbnail: 38567.jpg
topic: Integrations
feature: Integrations
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 647447ca-3c29-4efe-bb3a-d3f53a936a2a
source-git-commit: 30d6120ec99f7a95414dbc31c0cb002152bd6763
workflow-type: tm+mt
source-wordcount: '291'
ht-degree: 0%

---

# Felsöka en taggimplementering {#debug-tags-implementation}

En introduktion till vanliga verktyg och tekniker som används för att felsöka en taggimplementering. Lär dig hur du använder webbläsarens utvecklarkonsol och tillägget Experience Platform Debugger för att identifiera och felsöka viktiga aspekter av en taggimplementering.

>[!VIDEO](https://video.tv.adobe.com/v/38567?quality=12&learn=on)

## Felsökning på klientsidan via satellitobjekt

Felsökning på klientsidan är användbart för att verifiera inläsning av taggegenskapsregler eller körningsordning. När en taggegenskap läggs till på webbplatsen kan `_satellite` JavaScript-objekt finns i webbläsaren för att underlätta klientsidans händelse- och dataspårning.

Om du vill aktivera felsökning på klientsidan ringer du `setDebug(true)` metoden på `_satellite` -objekt.

1. Öppna webbläsarkonsolen och kör kommandot nedan.

   ```javascript
       _satellite.setDebug(true);
   ```

1. Läs in AEM webbplatssida igen och verifiera konsolloggen _utlöst regel_ som nedan.

   ![Tagga egenskap på författar- och publiceringssidor](assets/satellite-object-debugging.png)

## Felsökning via Adobe Experience Platform Debugger

Adobe tillhandahåller Adobe Experience Platform Debugger [Kromtillägg](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob) och [Firefox-tillägg](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/) att felsöka, förstå och få insikter i integreringen.

1. Öppna tillägget Adobe Experience Platform Debugger och öppna webbplatssidan i Publish-instansen

1. I **Adobe Experience Platform Debugger > Sammanfattning > Adobe Experience Platform-taggar** kontrollerar du dina taggegenskapsdetaljer som Namn, Version, Byggdatum, Miljö och Tillägg.

   ![Egenskapsinformation för Adobe Experience Platform Debugger och tagg](assets/tag-property-details.png)

## Ytterligare resurser {#additional-resources}

+ [Introduktion till Adobe Experience Platform Debugger](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html)

+ [Satellitobjektreferens](https://experienceleague.adobe.com/docs/experience-platform/tags/client-side/satellite-object.html)
