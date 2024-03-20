---
title: Real User Monitoring (RUM)
description: Läs mer om övervakning av verkliga användare (RUM) på AEM as a Cloud Service webbplats.
version: Cloud Service
feature: Operations
topic: Performance
role: Admin, Developer, Leader, User
level: Intermediate
doc-type: Tutorial
duration: 0
jira: KT-11861
thumbnail: KT-11861.png
last-substantial-update: 2024-03-18T00:00:00Z
source-git-commit: 7c80bb25b79a77c4a0bb2bbedf8a7c338177b857
workflow-type: tm+mt
source-wordcount: '647'
ht-degree: 0%

---


# Real User Monitoring (RUM)

Läs mer om övervakning av verkliga användare (RUM) på AEM as a Cloud Service webbplats. Lär dig hur du aktiverar RUM, vilka data som samlas in och hur du använder RUM-data för att optimera användarupplevelsen på din webbplats.

## Ökning

Real User Monitoring (RUM) är en metod som används för att _samla in, mäta och analysera användarinteraktioner och upplevelser_ med en webbplats i realtid. Här får ni insikter om hur besökarna interagerar med er webbplats, inklusive deras beteende, resultat och övergripande upplevelse. Detta uppnås genom att en liten del JavaScript-kod injiceras på webbplatsens sidor.

Med JavaScript-kod hämtar RUM data direkt från användarens webbläsare när de interagerar med webbplatsen. Dessa data kan användas för att identifiera och diagnostisera prestandaproblem, optimera användarupplevelsen och förbättra affärsresultatet.

RUM-funktionen i AEM as a Cloud Service ger en heltäckande bild av hur webbplatsen fungerar. Här hämtas följande nyckelvärden för varje sida (URL) som användaren besöker:

- [LCP (Störst Contentful Paint)](https://web.dev/articles/lcp) - mäter inläsningsprestanda.
- [Cumulative Layout Shift (CLS)](https://web.dev/articles/cls) - mäter visuell stabilitet.
- [Interaktion med nästa färg (INP)](https://web.dev/articles/inp) - mäter interaktivitet.
- Sidor - mäter hur många gånger en sida visas.

Dessutom innehåller det 404 fel- och sidvydiagram för webbplatsen.

LCP-, CLS- och INP-värdena ingår i [Core Web Vitals](https://web.dev/articles/vitals) som är en uppsättning mätvärden för hastighet, svarstider och visuell stabilitet på en webbplats. Dessa värden används av Google för att mäta användarupplevelsen på en webbplats och är viktiga för sökmotorns rankning.

## Aktivera RUM

Information om hur du aktiverar RUM för din AEMCS-webbplats finns i [Konfigurera tjänsten för övervakning av verkliga användare](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/content-requests#how-to-set-up-the-rum-service).

Viktiga detaljer för RUM i AEMCS är:

- RUM gäller endast för publiceringstjänsten i AEMCS, vilket innebär att JavaScript-kod endast matas in i publiceringsmiljön.
- The `com.adobe.granite.webvitals.WebVitalsConfig` OSGi-konfigurationen styr sökvägarna include och exclude, dessa är databassökvägar och inte URL-sökvägar.
- Som standard `/content` bana ingår.
- Om du vill utesluta banor lägger du till `AEM_WEBVITALS_EXCLUDE` Cloud Manager-miljövariabel, se [Lägga till miljövariabler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/environment-variables#add-variables). Banorna avgränsas med kommatecken.
- OOTB-koden ansvarar för att injicera JavaScript-koden på sidorna.

### Verifiering

Kontrollera om RUM är aktiverat för webbplatsen genom att visa den publicerade sidans HTML-källa och söka efter följande skriptblock:

```html
...

<!-- Added before the closing </head> tag -->
<script type="module">
    window.RUM_BASE = 'https://rum.hlx.page/';
    import { sampleRUM } from 'https://rum.hlx.page/.rum/@adobe/helix-rum-js@^1/src/index.js';
    sampleRUM('top');
    window.addEventListener('load', () => sampleRUM('load'));
    document.addEventListener('click', () => sampleRUM('click'));
</script>

...

<!-- Added before the closing </body> tag -->
<script type="module">
    window.RUM_BASE = 'https://rum.hlx.page/';
    import { sampleRUM } from 'https://rum.hlx.page/.rum/@adobe/helix-rum-js@^1/src/index.js';
    sampleRUM('lazy');
    sampleRUM('cwv');
</script>
```

## RUM-datainsamling

- RUM-data samlas in med `sampleRUM()` genom att skicka kontrollpunktens namn. I exemplet ovan är kontrollpunkterna `top`, `load`, `click`, `lazy`och `cwv`.
- En kontrollpunkt är en namngiven händelse i sekvensen där sidan läses in och interagerar med den.

Se även [Övervakningstjänst och integritet för verkliga användare](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/content-requests#rum-service-and-privacy) och [Vilka data samlas in](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/content-requests#what-data-is-being-collected) för mer information.

## RUM-datavy

Om du vill visa RUM-data behöver du `domainkey`, tillhandahåller Adobe det som en del av RUM-konfigurationen. Kontrollpanelen för RUM finns på [https://data.aem.live/](https://data.aem.live/) och du kan komma åt den med hjälp av domännyckeln och URL:en.

Nedanför skärmbilden visas RUM-kontrollpanelen för AEM WKND-webbplats.

![RUM Dashboard](./assets/rum/RUM-Dashboard-WKND.png)

Kontrollpanelen för RUM ger följande viktiga insikter:

- **Prestandamått** - LCP, CLS, INP och Pageviews.
- **Felmått** - 404 fel.
- **Sidvisningsdiagram** - Antal sidvisningar över tiden.

## Så här använder du RUM-data

Med hjälp av ovanstående insikter kan ni optimera användarupplevelsen på er webbplats. Till exempel:

- Minska LCP, CLS och INP för att förbättra sidinläsningsprestanda och interaktivitet. Se [Så här förbättrar du LCP](https://web.dev/articles/lcp#improve-lcp), [Förbättra CLS](https://web.dev/articles/cls#improve-cls) och [Så här förbättrar du INP](https://web.dev/articles/inp#improve-inp)för mer information.
- Åtgärda de 404 felen för att förbättra användarupplevelsen.
- Analysera sidvydiagrammen för att förstå användarbeteendet och optimera innehållet.

Adobe rekommenderar att kontrollpanelen för RUM granskas regelbundet och särskilt efter större eller mindre release.

Se även [Vem kan utnyttja Real User Monitoring Service?](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/content-requests#who-can-benefit-from-rum-service) för mer information.
