---
title: Sidmallar
seo-title: Komma igång med AEM Sites - sidmallar
description: Lär dig hur du skapar och ändrar sidmallar. Förstå förhållandet mellan en sidmall och en sida. Lär dig hur du konfigurerar profiler för en sidmall för att få en mer detaljerad styrning och enhetlig varumärkeshantering för innehåll.  En välstrukturerad artikel i tidskriften kommer att skapas utifrån en dummy från Adobe XD.
sub-product: platser
version: Cloud Service
type: Tutorial
topic: Innehållshantering
feature: Kärnkomponenter, redigerbara mallar, sidredigeraren
role: Developer
level: Beginner
kt: 7498
thumbnail: KT-7498.jpg
translation-type: tm+mt
source-git-commit: 67b7f5ee5fc9e42537a9622922327fb7a456d2bd
workflow-type: tm+mt
source-wordcount: '767'
ht-degree: 0%

---


# Sidmallar {#page-templates}

>[!CAUTION]
>
> De snabba funktionerna som visas här kommer att släppas under andra halvåret 2021. Den relaterade dokumentationen är tillgänglig för förhandsgranskning.

I det här kapitlet utforskar vi förhållandet mellan en sidmall och en sida. Vi kommer att bygga ut en ej formaterad artikel i Magazine som bygger på några modeller från [AdobeXD](https://www.adobe.com/products/xd.html). Under processen att skapa mallen beskrivs kärnkomponenter och avancerade principkonfigurationer.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att stegen som beskrivs i kapitlet [Författarinnehåll och publiceringsändringar](./author-content-publish.md) har slutförts.

## Syfte

1. Inspect är en siddesign som skapats i Adobe XD och som mappas till Core Components.
1. Förstå detaljerna om sidmallar och hur profiler kan användas för att få exakt kontroll över sidinnehållet.
1. Lär dig hur mallar och sidor länkas.

## Vad du ska bygga {#what-you-will-build}

I den här delen av självstudiekursen ska du skapa en ny mall för artikelsida för tidskrifter som kan användas för att skapa nya tidskriftsartiklar och anpassa sig till en gemensam struktur. Mallen kommer att baseras på design och ett användargränssnittspaket som producerats i AdobeXD. Det här kapitlet handlar endast om att bygga ut mallens struktur eller skelett. Inga format kommer att implementeras, men mallen och sidorna kommer att fungera.

## UI-planering med Adobe XD {#adobexd}

I de flesta fall börjar planering av en ny webbplats med dummies och statisk design. [Adobe ](https://www.adobe.com/products/xd.html) XDär ett designverktyg som bygger upp användarupplevelser. Därefter undersöker vi ett gränssnittspaket och dummies för att planera strukturen för artikelsidmallen.

>[!VIDEO](https://video.tv.adobe.com/v/30214/?quality=12&learn=on)

**Ladda ned designfilen för  [WKND-artikeln](https://github.com/adobe/aem-guides-wknd/releases/download/aem-guides-wknd-0.0.2/AEM_UI-kit-WKND-article-design.xd)**.

>[!NOTE]
>
> En allmän [AEM Core Components UI Kit finns också tillgänglig](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/AEM-CoreComponents-UI-Kit.xd) som startpunkt för anpassade projekt.

## Skapa sidmall för tidskriftsartikel

När du skapar en sida måste du välja en mall som ska användas som bas för att skapa den nya sidan. Mallen definierar strukturen för den resulterande sidan, det inledande innehållet och de tillåtna komponenterna.

Det finns tre huvudområden för [Sidmallar](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/sites/authoring/features/templates.html):

1. **Struktur**  - definierar komponenter som är en del av mallen. Dessa kan inte redigeras av innehållsförfattare.
1. **Ursprungligt innehåll**  - definierar komponenter som mallen ska börja med, som kan redigeras och/eller tas bort av innehållsförfattare
1. **Profiler**  - definierar konfigurationer för hur komponenter ska bete sig och vilka alternativ författare ska ha tillgängliga.

Skapa sedan en ny mall i AEM som matchar strukturen i modellerna. Detta inträffar i en lokal instans av AEM. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/332915/?quality=12&learn=on)

### Lösningspaket

En färdig [lösning av Magazine Template](assets/page-templates/WKND-Magazine-Template-SOLUTION-1.0.zip) kan hämtas och installeras via Package Manager.

## Uppdatera sidhuvud och sidfot med Experience Fragments {#experience-fragments}

Ett vanligt tillvägagångssätt när du skapar globalt innehåll, till exempel ett sidhuvud eller en sidfot, är att använda ett [Experience Fragment](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html). Med Experience Fragments kan användare kombinera flera komponenter för att skapa en enda referensbar komponent. Experience Fragments har fördelen att det stöder hantering av flera webbplatser och [lokalisering](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/experience-fragment.html?lang=en#localized-site-structure).

Webbplatsmallen genererade ett sidhuvud och en sidfot. Uppdatera sedan Experience Fragments så att de matchar dummyerna. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/332916/?quality=12&learn=on)

Steg på hög nivå för videon nedan:

1. Hämta exempelinnehållspaketet **[WKND-Starter-Assets-Skate-Article-1.0.zip](assets/page-templates/WKND-Starter-Assets-Skate-Article-1.0.zip)**.
1. Överför och installera innehållspaketet med Package Manager.
1. Uppdatera Experience Fragments för sidhuvud och sidfot så att WKND-logotypen används

## Skapa en artikelsida för Magazine

Skapa sedan en ny sida med mallen Artikelsida för tidskrift. Skriv innehållet på sidan så att det matchar webbplatsens dummies. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/332917/?quality=12&learn=on)

## Grattis! {#congratulations}

Grattis, du har just skapat en ny mall och sida med Adobe Experience Manager Sites.

### Nästa steg {#next-steps}

Nu matchar tidskriftens artikelsida och webbplatsen inte varumärkesstilarna för WKND. Följ självstudiekursen [Theming](theming.md) för att lära dig de bästa sätten att uppdatera CSS- och Javascript-klientkod som används för att tillämpa globala format på webbplatsen.

### Lösningspaket

Ett lösningspaket för det här kapitlet kan hämtas: [WKND-Magazine-Template-SOLUTION-1.0.zip](assets/page-templates/WKND-Magazine-Template-SOLUTION-1.0.zip).
