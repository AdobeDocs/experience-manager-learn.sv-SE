---
title: Använda smart översättningssökning med AEM Assets
description: Smart Translation Search möjliggör sökning och identifiering på flera språk automatiskt i AEM, både Assets och Pages, och stöder över 50 språk vilket minskar behovet av manuell översättning.
version: 6.4, 6.5
feature: Search
topic: Content Management
role: User
level: Beginner
last-substantial-update: 2022-09-03T00:00:00Z
thumbnail: 21297.jpg
exl-id: 4f35e3f7-ae29-4f93-bba9-48c60b800238
source-git-commit: b3e9251bdb18a008be95c1fa9e5c79252a74fc98
workflow-type: tm+mt
source-wordcount: '266'
ht-degree: 0%

---

# Använda smart översättningssökning med AEM Assets{#using-smart-translation-search-with-aem-assets}

Smart Translation Search möjliggör sökning och identifiering på flera språk automatiskt i AEM, både Assets och Pages, och stöder över 50 språk vilket minskar behovet av manuell översättning.

>[!VIDEO](https://video.tv.adobe.com/v/21297?quality=12&learn=on)

Med AEM Smart Translation Search kan användare söka efter innehåll i AEM med icke-engelska termer, för att matcha resurser i AEM som har motsvarande engelska termer.

Smart Translation Search är en perfekt komplementation till AEM smarta taggar som används för resurser på engelska.

Den här videon förutsätter [AEM smart översättningssökning](smart-translation-search-technical-video-setup.md) har konfigurerats.

## Så här fungerar Smart Translation Search {#how-smart-translation-search-works}

![Smart Translation Search Flow Diagram](assets/smart-translation-search-flow.png)

1. AEM utför en fulltextsökning som ger ett lokaliserat sökord (t.ex. den spanska termen för&quot;man&quot;,&quot;hombre&quot;).
2. Smart Translation Search, som tillhandahålls av Apache Oak Machine Translation OSGi-paketet, aktiveras och utvärderas om de angivna söktermerna kan översättas med registrerade språkpaket.
3. Alla översatta termer från steg 2 samlas in, och frågan utökas internt för att inkludera dem som söktermer. Den här utökade uppsättningen söktermer, om de utvärderas normalt mot AEM sökindex, och relevanta träffar hittas.
4. Sökresultaten som matchar den ursprungliga termen (&#39;hombre&#39;) eller den översatta termen (&#39;man&#39;) samlas in och returnerar användaren som sökresultat.

## Ytterligare resurser{#additional-resources}

* [Konfigurera smart översättningssökning med AEM Assets](smart-translation-search-technical-video-setup.md)
* [Språkpaket för Apache Joshua](https://cwiki.apache.org/confluence/display/JOSHUA/Language+Packs)
