---
title: Felsöka en taggimplementering
description: En introduktion till några vanliga verktyg och tekniker för att felsöka en taggimplementering. Lär dig hur du använder webbläsarens utvecklarkonsol och tillägget Experience Platform Debugger för att identifiera och felsöka viktiga aspekter av en taggimplementering.
topics: integrations
audience: administrator
solution: Experience Manager, Data Collection, Experience Platform
doc-type: technical video
activity: setup
kt: 6047
thumbnail: 38567.jpg
topic: Integrations
role: Developer
level: Intermediate
exl-id: 647447ca-3c29-4efe-bb3a-d3f53a936a2a
source-git-commit: 1d2daf53cd28fcd35cb2ea5c50e29b447790917a
workflow-type: tm+mt
source-wordcount: '282'
ht-degree: 0%

---

# Felsöka en taggimplementering {#debug-tags-implementation}

En introduktion till vanliga verktyg och tekniker som används för att felsöka en taggimplementering. Lär dig hur du använder webbläsarens utvecklarkonsol och tillägget Experience Platform Debugger för att identifiera och felsöka viktiga aspekter av en taggimplementering.

>[!VIDEO](https://video.tv.adobe.com/v/38567?quality=12&learn=on)

## Felsökning på klientsidan via satellitobjekt

Felsökning på klientsidan är användbart för att verifiera inläsning av taggegenskapsregler eller körningsordning. När en taggegenskap läggs till på webbplatsen kan `_satellite` JavaScript-objekt finns i webbläsaren för att underlätta klientsidans händelse- och dataspårning.

Aktivera felsökning på klientsidan genom att ringa `setDebug(true)` på `_satellite` -objekt.

1. Öppna webbläsarkonsolen och kör kommandot nedan.

   ```javascript
       _satellite.setDebug(true);
   ```

1. Läs in AEM webbplats igen och verifiera konsolloggen _utlöst regel_ som nedan.

   ![Tagga egenskap på författar- och publiceringssidor](assets/satellite-object-debugging.png)

## Felsökning via Adobe Experience Platform Debugger

Adobe tillhandahåller Adobe Experience Platform Debugger [Kromtillägg](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob) och [Firefox-tillägg](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/) att felsöka, förstå och få insikter i integreringen.

1. Öppna Adobe Experience Platform Debugger-tillägget och öppna webbplatssidan i Publish-instansen

1. I **Adobe Experience Platform Debugger > Summary > Adobe Experience Platform Tags** kontrollerar du dina taggegenskapsdetaljer som Namn, Version, Byggdatum, Miljö och Tillägg.

   ![Information om Adobe Experience Platform Debugger and Tag Property](assets/tag-property-details.png)

## Ytterligare resurser {#additional-resources}

+ [Introduktion till Adobe Experience Platform Debugger](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html)

+ [Satellitobjektreferens](https://experienceleague.adobe.com/docs/experience-platform/tags/client-side/satellite-object.html)
