---
title: Live Demonstration av användningsexempel från Personalization
description: Upplev personalisering i praktiken på WKND Enablement-webbplatsen med A/B-tester, beteendeanpassning och kända användarpersonaliseringsexempel.
version: Experience Manager as a Cloud Service
feature: Personalization, Integrations
topic: Personalization, Integrations
role: Developer, Architect, Leader, User
level: Beginner
doc-type: Tutorial
last-substantial-update: 2025-11-03T00:00:00Z
jira: KT-19546
thumbnail: KT-19546.jpeg
source-git-commit: ed7af09d747d54a84d2583073d3c731388b5f516
workflow-type: tm+mt
source-wordcount: '944'
ht-degree: 0%

---

# Live-demonstration av användningsfall för personalisering

Besök webbplatsen [WKND Enablement](https://wknd.enablementadobe.com/us/en.html){target="wknd"} om du vill se exempel på A/B-testning, beteendeanpassning och personalisering för kända användare.

>[!VIDEO](https://video.tv.adobe.com/v/3476461/?learn=on&enablevpops)

Den här sidan vägleder dig genom praktiska demonstrationer av varje personaliseringsscenario. Använd det för att utforska vad som är möjligt innan du skapar dessa funktioner på din egen AEM-webbplats.

>[!IMPORTANT]
>
> Öppna demowebbplatsen i flera webbläsarfönster eller inkognito/privat surfläge om du vill se olika personaliserade varianter samtidigt.
> När du använder läget för privat surfning kan Firefox och Safari blockera ECID-cookien, alternativt använda vanligt bläddringsläge eller rensa cookies innan du provar ett nytt personaliseringsscenario.

## Exempel på demoanvändning

Webbplatsen [WKND-aktivering](https://wknd.enablementadobe.com/us/en.html){target="wknd"} visar tre typer av personalisering:

| Personalization Type | Vad du kommer att se | Timing |
|---------------------|-----------------|---------|
| **Beteendeanpassning** | Innehållet anpassas efter ditt surfbeteende och dina intressen. Kallas vanligtvis _nästa sida eller samma sida_ | Realtid och batch |
| **Kända Personalization** | Skräddarsydda upplevelser som bygger på fullständiga kundprofiler som bygger på data från flera olika system. Kallas vanligtvis _personalisering i skala_ | Realtid |
| **A/B-testning** | Olika innehållsvariationer testas för att hitta den bästa prestandan. Kallas vanligen för _experiment_ | Realtid |

## Beteendeanpassning

Innehållet anpassas automatiskt baserat på besökarens åtgärder och intressen under webbläsarsessionen. Detta kallas vanligtvis för _nästa sida eller en helsidesanpassning_.

### Home-, Adventures- och Magazine-sidor

De här upplevelserna visas omedelbart baserat på ditt nuvarande surfbeteende (personalisering i realtid). Adobe Experience Platform Edge Network används för personalisering i realtid.

| Sida | Vad du kommer att se | Så här testar du | Upplevelse |
|------|-----------------|-------------|------------|
| [Startsida](https://wknd.enablementadobe.com/us/en.html){target="wknd"} | En personlig **familjvänlig Adventures-hjältebanner** med en familj som träffas av en sjö, som främjar guidade upplevelser som skapar delade minnen | Besök [Bali Surf Camp](https://wknd.enablementadobe.com/us/en/adventures/bali-surf-camp.html){target="wknd"} eller [Gastronomic Marais Tour](https://wknd.enablementadobe.com/us/en/adventures/gastronomic-marais-tour.html){target="wknd"} och gå sedan tillbaka till startsidan | ![Hem - familjereklam](./assets/live-demo/behavioral-home-family-hero.png){width="200" zoomable="yes"} |
| [Anteckningar](https://wknd.enablementadobe.com/us/en/adventures.html){target="wknd"} | En kampanjhjälte **för**&quot;Free Bike Tune Up&quot; med meddelandet&quot;We have You Covered&quot; och det kostnadsfria cykelunderhållserbjudandet från WKND:s expertpartner | Besök ett eventuellt beröringsrelaterat äventyr (till exempel [Cycling Tuscany](https://wknd.enablementadobe.com/us/en/adventures/cycling-tuscany.html){target="wknd"}) och navigera sedan till sidan Adventures | ![Tillägg - Gratis cykel, trimma upp hjälte](./assets/live-demo/behavioral-adventures-bike-hero.png){width="200" zoomable="yes"} |
| [Anteckningar](https://wknd.enablementadobe.com/us/en/adventures.html){target="wknd"} | En **hjälte för kamputsamling** som visar upp viktig campingutrustning (sovsäckar, kavajer, stövlar) med meddelandet&quot;Ditt nästa äventyr börjar med rätt växel&quot; | Besök ett eventuellt kampanjrelaterat äventyr (till exempel [Yosemite Backpackaging](https://wknd.enablementadobe.com/us/en/adventures/yosemite-backpacking.html){target="wknd"}) och navigera sedan till sidan Adventures | ![Adventures - Camp Gear Collection Hero](./assets/live-demo/behavioral-adventures-camp-hero.png){width="200" zoomable="yes"} |
| [Magazine](https://wknd.enablementadobe.com/us/en/magazine.html){target="wknd"} | En tidskänslig **tidskriftsförsäljningskampanj** med rollerade WKND-tidskrifter och framträdande&quot;SALE!&quot; emblem och specialpris för läsare på utleveranser och utomhussamlingar | Läs en eller flera tidskriftsartiklar (till exempel [Ski Taching](https://wknd.enablementadobe.com/us/en/magazine/ski-touring.html){target="wknd"}) och navigera sedan till startsidan för Magazine | ![Magazine - Sale Hero](./assets/live-demo/behavioral-magazine-sale-hero.png){width="200" zoomable="yes"} |

### Adventures and Magazine pages (batch)

De här upplevelserna bygger på historiskt beteende och visas på ditt nästa besök eller senare samma dag (gruppanpassning). Data samlas in och bearbetas i profilattribut och aktiveras för Adobe Experience Platform Edge Network.

| Sida | Vad du kommer att se | Så här testar du | Upplevelse |
|------|-----------------|-------------|------------|
| [Anteckningar](https://wknd.enablementadobe.com/us/en/adventures.html){target="wknd"} | En hjälte med surfingteman som innehåller **färggranna surfbord under palmträd** med meddelandet&quot;Your Surf Journey Starts Here&quot; och strukturerat surfmålsinnehåll baserat på dina intressen | Besök flera [surf-relaterade äventyr](https://wknd.enablementadobe.com/us/en/adventures.html#tabs-b4210c6ff3-item-b411b19941-tab){target="wknd"} och gå sedan tillbaka till sidan Adventures nästa dag | ![Anbud - Surfing Hero](./assets/live-demo/behavioral-adventures-surfing-hero.png){width="200" zoomable="yes"} |
| [Magazine](https://wknd.enablementadobe.com/us/en/magazine.html){target="wknd"} | Ett **anpassat prenumerationserbjudande för tidningar** med resmål i världen med en klassisk VW-skåpbil, som betonar&quot;Din personliga tidskriftsupplevelse&quot; med exklusiva prenumerantförmåner | Läs 3 eller fler [tidskriftsartiklar](https://wknd.enablementadobe.com/us/en/magazine.html){target="wknd"} och gå sedan tillbaka till startsidan för tidskriften nästa dag | ![Magazine - Subscribe Hero](./assets/live-demo/behavioral-magazine-subscribe-hero.png){width="200" zoomable="yes"} |

**Läs mer:** Vill du implementera beteendeanpassning på din egen AEM-webbplats? Börja med självstudiekursen [Beteendeanpassning](./use-cases/behavioral-targeting.md) om du vill lära dig hela installationsprocessen.

## Känd personalisering för användare

Personaliserade upplevelser som bygger på fullständiga kundprofiler som bygger på data från flera olika system, inklusive inköpshistorik och kundens livscykelstadium. Adobe Experience Platform Edge Network används för personalisering i realtid.

### Hemsidans hjälte

WKND-startsidans hjältebanner anpassas utifrån autentiserade användarprofiler. Testa med dessa demokonton för att se en personaliserad upplevelse:

| Sida | Vad du kommer att se | Så här testar du | Profilkontext | Upplevelse |
|------|-----------------|-------------|-----------------|------------|
| [Startsida](https://wknd.enablementadobe.com/us/en.html){target="wknd"} | En skidverkets insida med **premiumskidutrustning med erbjudandet&quot;EXTRA 25 % OFF&quot;**, med experttips för att förbereda sig för det kommande skidäventyret | Logga in med `rwilson/rwilson` och uppdatera sidan | Nyligen köpta skidäventyr, och därmed sälja skidutrustning | ![Home - Ski Gear Upsell](./assets/live-demo/known-user-ski-gear-hero.png){width="200" zoomable="yes"} |

**Läs mer:** Är du redo att implementera användaranpassning på din egen AEM-webbplats? Börja med självstudiekursen för [kända användare av Personalization](./use-cases/known-user-personalization.md) för att lära dig hela installationsprocessen.

## A/B-tester (experiment)

Testa olika innehållsvariationer för att avgöra vilka som fungerar bäst för era affärsmål. Adobe Target skickar slumpmässigt olika varianter till besökare och spår som fungerar bättre. Detta kallas vanligtvis _experiment_.

### Artiklar på hemsidan

WKND-hemsidan kör ett aktivt A/B-test med tre varianter av den aktuella artikeln _Camping i Western Australia_. Varje besökare tilldelas slumpvis för att se en av dessa variationer:

| Sida | Vad du kommer att se | Så här testar du | Upplevelse |
|------|-----------------|-------------|------------|
| [Startsida](https://wknd.enablementadobe.com/us/en.html){target="wknd"} | En av tre slumpmässigt tilldelade aktuella artikelvarianter i avsnittet &quot;Vår funktion&quot;: **&quot;Av rutnätet: Epic Camping Routes Across Western Australia&quot;** eller **&quot;Wandering the Wild: Camping Adventures in Western Australia&quot;** (eller en tredje variant), var och en med unika bilder och meddelanden för att testa vilka som fungerar bäst | Besök hemsidan i olika webbläsare, använd läget Incognito/private eller rensa cookies för att se olika varianter | ![A/B-testvariationer](./assets/live-demo/ab-test-variations.png){width="200" zoomable="yes"} |

**Läs mer:** Vill du implementera A/B-testning på din egen AEM-webbplats? Börja med självstudiekursen [Experimentation (A/B Testing)](./use-cases/experimentation.md) om du vill veta mer om den fullständiga installationsprocessen.


## Nästa steg

Vill du implementera personalisering på din egen AEM-webbplats? Börja med [Personalization Overview](./overview.md) om du vill veta mer om hela installationsprocessen.


