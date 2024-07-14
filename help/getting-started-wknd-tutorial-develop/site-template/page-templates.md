---
title: Sidmallar
description: Lär dig skapa och ändra sidmallar. Förstå förhållandet mellan en sidmall och en sida. Lär dig hur du konfigurerar profiler för en sidmall för att få en mer detaljerad styrning och enhetlig varumärkeshantering för innehåll.  En välstrukturerad artikel i Magazine skapas utifrån en dummy från Adobe XD.
version: Cloud Service
topic: Content Management
feature: Core Components, Editable Templates, Page Editor
role: Developer
level: Beginner
jira: KT-7498
thumbnail: KT-7498.jpg
doc-type: Tutorial
exl-id: 261ec68f-36f4-474f-a6e4-7a2f9cea691b
recommendations: noDisplay, noCatalog
duration: 1561
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '628'
ht-degree: 0%

---

# Sidmallar {#page-templates}

I det här kapitlet utforskar vi förhållandet mellan en sidmall och en sida. Vi kommer att bygga ut en ej formaterad artikel i tidskriften som bygger på några modeller från [AdobeXD](https://www.adobe.com/products/xd.html). Under processen att skapa mallen beskrivs kärnkomponenter och avancerade principkonfigurationer.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att stegen som beskrivs i kapitlet [Författarinnehåll och publiceringsändringar](./author-content-publish.md) har slutförts.

## Syfte

1. Förstå detaljerna om sidmallar och hur profiler kan användas för att få exakt kontroll över sidinnehållet.
1. Lär dig hur mallar och sidor länkas.
1. Skapa en ny mall och redigera en sida.

## Vad du ska bygga {#what-you-will-build}

I den här delen av självstudiekursen ska du skapa en ny mall för artikelsida för tidskrifter som kan användas för att skapa nya tidskriftsartiklar och anpassa sig till en gemensam struktur. Mallen är baserad på design och ett UI Kit som producerats i AdobeXD. Det här kapitlet handlar endast om att bygga ut mallens struktur eller skelett. Inga format implementeras, men mallen och sidorna fungerar.

## Skapa sidmall för tidskriftsartikel

När du skapar en sida måste du välja en mall, som används som bas för att skapa den nya sidan. Mallen definierar strukturen för den resulterande sidan, det inledande innehållet och de tillåtna komponenterna.

Det finns tre huvudområden för [Sidmallar](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/sites/authoring/features/templates.html):

1. **Struktur** - definierar komponenter som är en del av mallen. Dessa kan inte redigeras av innehållsförfattare.
1. **Ursprungligt innehåll** - definierar komponenter som mallen börjar med, som kan redigeras och/eller tas bort av innehållsförfattare
1. **Principer** - definierar konfigurationer för hur komponenter beter sig och vilka alternativ författare har tillgängliga.

Skapa sedan en ny mall i AEM som matchar strukturen i modellerna. Detta inträffar i en lokal instans av AEM. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/332915?quality=12&learn=on)

Du kan använda följande miniatyrbild för att identifiera mallen (eller överföra din egen!)

![Miniatyrbild för artikelsidmall](./assets/page-templates/article-page-template-thumbnail.png)


### Lösningspaket

En färdig [lösning av Magazine-mallen](assets/page-templates/WKND-Magazine-Template-SOLUTION-1.1.zip) kan hämtas och installeras via Package Manager.

## Uppdatera sidhuvud och sidfot med Experience Fragments {#experience-fragments}

Ett vanligt tillvägagångssätt när du skapar globalt innehåll, till exempel ett sidhuvud eller en sidfot, är att använda ett [Experience Fragment](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html). Med Experience Fragments kan användare kombinera flera komponenter för att skapa en enda referensbar komponent. Experience Fragments har fördelen att det stöder hantering av flera webbplatser och [lokalisering](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/experience-fragment.html?lang=en#localized-site-structure).

Webbplatsmallen genererade ett sidhuvud och en sidfot. Uppdatera sedan Experience Fragments så att de matchar dummyerna. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/332916?quality=12&learn=on)

Steg på hög nivå för videon nedan:

1. Hämta exempelinnehållspaketet **[WKND-Starter-Assets-Skate-Article-1.2.zip](assets/page-templates/WKND-Starter-Assets-Skate-Article-1.2.zip)**.
1. Överför och installera innehållspaketet med Package Manager.
1. Uppdatera Experience Fragments för sidhuvud och sidfot så att WKND-logotypen används

## Skapa en artikelsida för Magazine

Skapa sedan en ny sida med mallen Artikelsida för tidskrift. Skriv innehållet på sidan så att det matchar webbplatsens modeller. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/332917?quality=12&learn=on)

Använd den [angivna texten](./assets/page-templates/la-skateparks-copy.txt) för att fylla i artikeltexten.

## Grattis! {#congratulations}

Grattis, du har just skapat en ny mall och sida med Adobe Experience Manager Sites.

### Nästa steg {#next-steps}

Nu matchar tidskriftens artikelsida och webbplatsen inte varumärkesstilarna för WKND. Följ självstudiekursen [Theming](theming.md) för att lära dig de bästa sätten att uppdatera CSS- och JavaScript-klientkod som används för att tillämpa globala format på webbplatsen.

### Lösningspaket

Det finns ett lösningspaket för det här kapitlet att hämta: [WKND-Magazine-Template-SOLUTION-1.0.zip](assets/page-templates/WKND-Magazine-Template-SOLUTION-1.0.zip).
