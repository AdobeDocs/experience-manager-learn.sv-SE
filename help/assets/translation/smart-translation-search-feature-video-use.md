---
title: Använda smart översättningssökning med AEM Assets
description: Smart Translation Search möjliggör sökning och identifiering på flera språk automatiskt i AEM, både Assets och Pages, och stöder över 50 språk vilket minskar behovet av manuell översättning.
version: 6.3, 6.4, 6.5
feature: Sökning
topic: Innehållshantering
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '269'
ht-degree: 1%

---


# Använda smart översättningssökning med AEM Assets{#using-smart-translation-search-with-aem-assets}

Smart Translation Search möjliggör sökning och identifiering på flera språk automatiskt i AEM, både Assets och Pages, och stöder över 50 språk vilket minskar behovet av manuell översättning.

>[!VIDEO](https://video.tv.adobe.com/v/21297/?quality=9&learn=on)

Med AEM Smart Translation Search kan användare söka efter innehåll i AEM med icke-engelska termer, för att matcha resurser i AEM som har motsvarande engelska termer.

Smart Translation Search är en perfekt komplementation till AEM smarta taggar som används för resurser på engelska.

I den här videon antas [AEM sökningen efter smart översättning](smart-translation-search-technical-video-setup.md) har konfigurerats.

## Så här fungerar Smart Translation Search {#how-smart-translation-search-works}

![Smart Translation Search Flow Diagram](assets/smart-translation-search-flow.png)

1. AEM utför en fulltextsökning som ger ett lokaliserat sökord (t.ex. den spanska termen för&quot;man&quot;,&quot;hombre&quot;).
2. Smart Translation Search, som tillhandahålls av Apache Oak Machine Translation OSGi-paketet, aktiveras och utvärderas om de angivna söktermerna kan översättas med registrerade språkpaket.
3. Alla översatta termer från steg 2 samlas in, och frågan utökas internt för att inkludera dem som söktermer. Den här utökade uppsättningen söktermer, om de utvärderas normalt mot AEM sökindex, och relevanta träffar hittas.
4. Sökresultaten som matchar den ursprungliga termen (&#39;hombre&#39;) eller den översatta termen (&#39;man&#39;) samlas in och returnerar användaren som sökresultat.

## Ytterligare resurser{#additional-resources}

* [Konfigurera smart översättningssökning med AEM Assets](smart-translation-search-technical-video-setup.md)
* [Språkpaket för Apache Joshua](https://cwiki.apache.org/confluence/display/JOSHUA/Language+Packs)