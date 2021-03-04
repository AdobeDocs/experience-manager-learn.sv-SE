---
title: Samla in siddata med Adobe Analytics
description: Använd det händelsestyrda Adobe Client Data-lagret för att samla in data om användaraktivitet på en webbplats som byggts med Adobe Experience Manager. Lär dig hur du använder regler i Experience Platform Launch för att lyssna efter dessa händelser och skicka data till en Adobe Analytics rapportserie.
feature: analys
topics: integrations
audience: administrator
doc-type: tutorial
activity: setup
version: cloud-service
kt: 5332
thumbnail: 5332-collect-data-analytics.jpg
topic: Integreringar
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '2419'
ht-degree: 1%

---


# Samla in siddata med Adobe Analytics

Lär dig använda de inbyggda funktionerna i [Adobe Client Data Layer med AEM Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html) för att samla in data om en sida i Adobe Experience Manager Sites. [Experience Platform ](https://www.adobe.com/experience-platform/launch.html) Launchoch  [Adobe Analytics-](https://docs.adobe.com/content/help/en/launch/using/extensions-ref/adobe-extension/analytics-extension/overview.html) tillägget används för att skapa regler för att skicka siddata till Adobe Analytics.

## Vad du ska bygga

![Spårning av siddata](assets/collect-data-analytics/analytics-page-data-tracking.png)

I den här självstudiekursen utlöser du en startregel baserad på en händelse från Adobe-klientdatalagret, lägger till villkor för när regeln ska utlösas och skickar **sidnamnet** och **sidmallen** för en AEM till Adobe Analytics.

### Mål {#objective}

1. Skapa en händelsestyrd regel i Launch baserat på ändringar i datalagret
1. Mappa egenskaper för siddatalager till dataelement i Launch
1. Samla in siddata och skicka till Adobe Analytics med sidvyfyren

## Förutsättningar

Följande krävs:

* **Experience Platform** LaunchProperty
* **Adobe** AnalyticsTest/Dev-rapportsprogram-ID och spårningsserver. Se följande dokumentation för [hur du skapar en ny rapportsvit](https://docs.adobe.com/content/help/en/analytics/admin/manage-report-suites/new-report-suite/new-report-suite.html).
* [Experience Platform ](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) Debuggerbrowser-tillägg. Skärmbilder i den här självstudiekursen som tagits från webbläsaren Chrome.
* (Valfritt) AEM Plats med [Adobe Client Data Layer aktiverat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation). I den här självstudien används den offentliga webbplatsen [https://wknd.site/us/en.html](https://wknd.site/us/en.html), men du är välkommen att använda din egen webbplats.

>[!NOTE]
>
> Behöver du hjälp med att integrera Launch och din AEM webbplats? [Se den här videoserien](../experience-platform-launch/overview.md).

## Switch Launch Environment for WKND Site

[https://wknd.](https://wknd.site) site är en offentlig webbplats som byggts utifrån  [ett ](https://github.com/adobe/aem-guides-wknd) projekt med öppen källkod som utformats som referens och  [](https://docs.adobe.com/content/help/en/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html) självstudiekurser för AEM implementeringar.

I stället för att konfigurera en AEM miljö och installera WKND-kodbasen kan du använda felsökaren Experience Platform för att **växla** live [https://wknd.site/](https://wknd.site/) till *din* startegenskap. Naturligtvis kan du använda en egen AEM om den redan har [Adobe Client Data Layer aktiverat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation)

1. Logga in på Experience Platform Launch och [skapa en startegenskap](https://docs.adobe.com/content/help/en/core-services-learn/implementing-in-websites-with-launch/configure-launch/launch.html) (om du inte redan gjort det).
1. Kontrollera att ett initialt startbibliotek [har skapats](https://docs.adobe.com/content/help/en/launch/using/reference/publish/libraries.html#create-a-library) och befordrats till en startmiljö[miljö](https://docs.adobe.com/content/help/en/launch/using/reference/publish/environments.html).
1. Kopiera startkoden för inbäddning från miljön som biblioteket har publicerats i.

   ![Copy Launch Embed Code](assets/collect-data-analytics/launch-environment-copy.png)

1. Öppna en ny flik i webbläsaren och gå till [https://wknd.site/](https://wknd.site/)
1. Öppna webbläsartillägget Experience Platform Debugger

   ![Felsökning för Experience Platform](assets/collect-data-analytics/experience-platform-debugger-extension.png)

1. Navigera till **Starta** > **Konfiguration** och under **Inmatade inbäddningskoder** ersätt den befintliga inbäddningskoden för Launch med *din* inbäddningskod kopierad från steg 3.

   ![Ersätt inbäddad kod](assets/collect-data-analytics/platform-debugger-replace-embed.png)

1. Aktivera **Konsolloggning** och **Lås** felsökaren på fliken WKND.

   ![Konsolloggning](assets/collect-data-analytics/console-logging-lock-debugger.png)

## Verifiera Adobe klientdatalager på WKND-plats

[WKND Reference-projektet](https://github.com/adobe/aem-guides-wknd) har skapats med AEM Core Components och har [Adobe Client Data Layer aktiverat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation) som standard. Kontrollera sedan att datalagret för klienten i Adobe är aktiverat.

1. Navigera till [https://wknd.site](https://wknd.site).
1. Öppna webbläsarens utvecklarverktyg och gå till **konsolen**. Kör följande kommando:

   ```js
   adobeDataLayer.getState();
   ```

   Detta returnerar det aktuella läget för Adobe-klientdatalagret.

   ![Adobe datalagrets läge](assets/collect-data-analytics/adobe-data-layer-state.png)

1. Expandera svaret och kontrollera `page`-posten. Du bör se ett dataschema som följande:

   ```json
   page-2eee4f8914:
       @type: "wknd/components/page"
       dc:description: WKND is a collective of outdoors, music, crafts, adventure sports, and travel enthusiasts that want to share our experiences, connections, and expertise with the world.
       dc:title: "WKND Adventures and Travel"
       repo:modifyDate: "2020-08-31T21:02:21Z"
       repo:path: "/content/wknd/us/en.html"
       xdm:language: "en-US"
       xdm:tags: ["Attract"]
       xdm:template: "/conf/wknd/settings/wcm/templates/landing-page-template"
   ```

   Vi använder standardegenskaper som härletts från [sidschemat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#page), `dc:title`, `xdm:language` och `xdm:template` för datalagret för att skicka siddata till Adobe Analytics.

   >[!NOTE]
   >
   > Ser du inte JavaScript-objektet `adobeDataLayer`? Kontrollera att [Adobe-klientdatalagret har aktiverats](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation) på din plats.

## Skapa en inläst sidregel

Adobe-klientdatalagret är ett **händelsedatalager som styrs av**. När AEM **Sida**-datalagret har lästs in utlöser det en händelse `cmp:show`. Skapa en regel som ska aktiveras baserat på händelsen `cmp:show`.

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Regler** i startgränssnittet och klicka sedan på **Skapa ny regel**.

   ![Skapa regel](assets/collect-data-analytics/analytics-create-rule.png)

1. Namnge regeln **Inläst sida**.
1. Klicka på **Händelser** **Lägg till** för att öppna guiden **Händelsekonfiguration**.
1. Under **Händelsetyp** väljer du **Anpassad kod**.

   ![Namnge regeln och lägg till en anpassad kodhändelse](assets/collect-data-analytics/custom-code-event.png)

1. Klicka på **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

   ```js
   var pageShownEventHandler = function(evt) {
      // defensive coding to avoid a null pointer exception
      if(evt.hasOwnProperty("eventInfo") && evt.eventInfo.hasOwnProperty("path")) {
         //trigger Launch Rule and pass event
         console.debug("cmp:show event: " + evt.eventInfo.path);
         var event = {
            //include the path of the component that triggered the event
            path: evt.eventInfo.path,
            //get the state of the component that triggered the event
            component: window.adobeDataLayer.getState(evt.eventInfo.path)
         };
   
         //Trigger the Launch Rule, passing in the new `event` object
         // the `event` obj can now be referenced by the reserved name `event` by other Launch data elements
         // i.e `event.component['someKey']`
         trigger(event);
      }
   }
   
   //set the namespace to avoid a potential race condition
   window.adobeDataLayer = window.adobeDataLayer || [];
   //push the event listener for cmp:show into the data layer
   window.adobeDataLayer.push(function (dl) {
      //add event listener for `cmp:show` and callback to the `pageShownEventHandler` function
      dl.addEventListener("cmp:show", pageShownEventHandler);
   });
   ```

   Ovanstående kodfragment lägger till en händelseavlyssnare genom att [föra in en funktion](https://github.com/adobe/adobe-client-data-layer/wiki#pushing-a-function) i datalagret. När händelsen `cmp:show` aktiveras anropas funktionen `pageShownEventHandler`. I den här funktionen läggs några säkerhetskontroller till och en ny `event` skapas med det senaste [tillståndet för datalagret](https://github.com/adobe/adobe-client-data-layer/wiki#getstate) för komponenten som utlöste händelsen.

   Efter att `trigger(event)` har anropats. `trigger()` är ett reserverat namn i Launch och kommer att utlösa startregeln. Vi skickar `event`-objektet som en parameter som i sin tur kommer att visas med ett annat reserverat namn i Launch med namnet `event`. Dataelement i Launch kan nu referera till olika egenskaper som: `event.component['someKey']`.

1. Spara ändringarna.
1. Klicka på **Lägg till** under **Åtgärder** för att öppna guiden **Åtgärdskonfiguration**.
1. Under **Åtgärdstyp** väljer du **Anpassad kod**.

   ![Åtgärdstyp för anpassad kod](assets/collect-data-analytics/action-custom-code.png)

1. Klicka på **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

   ```js
   console.debug("Page Loaded ");
   console.debug("Page name: " + event.component['dc:title']);
   console.debug("Page type: " + event.component['@type']);
   console.debug("Page template: " + event.component['xdm:template']);
   ```

   Objektet `event` skickas från metoden `trigger()` som anropas i den anpassade händelsen. `component` är den aktuella sidan som härleds från datalagret  `getState` i den anpassade händelsen. Återkalla från tidigare [sidschemat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#page) som exponeras av datalagret för att se de olika nycklarna som visas utanför rutan.

1. Spara ändringarna och kör en [build](https://docs.adobe.com/content/help/en/launch/using/reference/publish/builds.html) i Launch för att befordra koden till [miljön](https://docs.adobe.com/content/help/en/launch/using/reference/publish/environments.html) som används på din AEM.

   >[!NOTE]
   >
   > Det kan vara användbart att använda [Adobe Experience Platform Debugger](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) för att växla inbäddningskoden till en **Development**-miljö.

1. Navigera till AEM webbplats och öppna utvecklarverktygen för att visa konsolen. Uppdatera sidan så ser du att konsolmeddelandena har loggats:

   ![Sidinlästa konsolmeddelanden](assets/collect-data-analytics/page-show-event-console.png)

## Skapa dataelement

Skapa sedan flera dataelement för att hämta olika värden från datalagret för klienten i Adobe. Som vi tidigare sett är det möjligt att komma åt egenskaperna för datalagret direkt via anpassad kod. Fördelen med att använda dataelement är att de kan återanvändas i alla Launch-regler.

Återkalla från tidigare [sidschemat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#page) som exponeras av datalagret:

Dataelement mappas till egenskaperna `@type`, `dc:title` och `xdm:template`.

### Komponentresurstyp

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Dataelement** och klicka på **Skapa nytt dataelement**.
1. För **Namn** anger du **Komponentresurstyp**.
1. För **Dataelementtyp** väljer du **Anpassad kod**.

   ![Komponentresurstyp](assets/collect-data-analytics/component-resource-type-form.png)

1. Klicka på **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('@type')) {
       return event.component['@type'];
   }
   ```

   Spara ändringarna.

   >[!NOTE]
   >
   > Kom ihåg att `event`-objektet är tillgängligt och omfång baserat på händelsen som utlöste **regeln** i Launch. Värdet för ett dataelement anges inte förrän dataelementet är *refererat* i en regel. Det är därför säkert att använda det här dataelementet i en regel som **Page Loaded**-regeln som skapades i föregående steg *men* kan inte användas i andra sammanhang utan risk.

### Sidnamn

1. Klicka på **Lägg till dataelement**.
1. För **Namn** anger du **Sidnamn**.
1. För **Dataelementtyp** väljer du **Anpassad kod**.
1. Klicka på **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('dc:title')) {
       return event.component['dc:title'];
   }
   ```

   Spara ändringarna.

### Sidmall

1. Klicka på **Lägg till dataelement**.
1. För **Namn** anger du **Sidmall**.
1. För **Dataelementtyp** väljer du **Anpassad kod**.
1. Klicka på **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('xdm:template')) {
       return event.component['xdm:template'];
   }
   ```

   Spara ändringarna.

1. Du bör nu ha tre dataelement som en del av din regel:

   ![Dataelement i regel](assets/collect-data-analytics/data-elements-page-rule.png)

## Lägg till analystillägget

Lägg sedan till Analytics-tillägget i Launch-egenskapen. Vi måste skicka dessa data någonstans!

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Gå till **Tillägg** > **Katalog**
1. Leta reda på tillägget **Adobe Analytics** och klicka på **Installera**

   ![Adobe Analytics Extension](assets/collect-data-analytics/analytics-catalog-install.png)

1. Under **Bibliotekshantering** > **Rapportsviter** anger du de ID:n för rapportsviten som du vill använda för varje startmiljö.

   ![Ange rapportsvitens ID:n](assets/collect-data-analytics/analytics-config-reportSuite.png)

   >[!NOTE]
   >
   > Det går bra att använda en rapportserie för alla miljöer i den här självstudiekursen, men i verkligheten vill du använda separata rapportsviter, som bilden nedan visar

   >[!TIP]
   >
   >Vi rekommenderar att du använder alternativet *Hantera biblioteket åt mig* som inställning för Bibliotekshantering eftersom det gör det mycket enklare att hålla `AppMeasurement.js`-biblioteket uppdaterat.

1. Markera kryssrutan för att aktivera **Använd Activity Map**.

   ![Aktivera Använd Activity Map](assets/track-clicked-component/analytic-track-click.png)

1. Under **Allmänt** > **Spårningsserver** anger du spårningsservern, t.ex. `tmd.sc.omtrdc.net`. Ange din SSL-spårningsserver om din webbplats stöder `https://`

   ![Ange spårningsservrarna](assets/collect-data-analytics/analytics-config-trackingServer.png)

1. Klicka på **Spara** för att spara ändringarna.

## Lägga till ett villkor i regeln Sidinläst

Uppdatera sedan regeln **Inläst sida** så att den använder dataelementet **Component Resource Type** för att säkerställa att regeln bara aktiveras när händelsen `cmp:show` är för **sidan**. Andra komponenter kan utlösa händelsen `cmp:show`, till exempel utlöser komponenten Carousel den när bildrutorna ändras. Därför är det viktigt att lägga till ett villkor för den här regeln.

1. Navigera till regeln **Page Loaded** som skapades tidigare i startgränssnittet.
1. Under **Villkor** klickar du på **Lägg till** för att öppna guiden **Villkorskonfiguration**.
1. För **Villkorstyp** väljer du **Värdejämförelse**.
1. Ställ in det första värdet i formulärfältet på `%Component Resource Type%`. Du kan använda dataelementikonen ![dataelementsikon](assets/collect-data-analytics/cylinder-icon.png) för att välja dataelementet **komponentresurstyp**. Lämna jämförelseobjektet inställt på `Equals`.
1. Ange det andra värdet som `wknd/components/page`.

   ![Villkorskonfiguration för regel för sidinläst](assets/collect-data-analytics/condition-configuration-page-loaded.png)

   >[!NOTE]
   >
   > Det går att lägga till det här villkoret i den anpassade kodfunktionen som avlyssnar händelsen `cmp:show` som skapades tidigare i självstudien. Om du lägger till den i användargränssnittet blir den synligare för ytterligare användare som kan behöva göra ändringar i regeln. Dessutom kan vi använda vårt dataelement!

1. Spara ändringarna.

## Ange analysvariabler och aktivera sidvisningsfunktionen

För närvarande ger regeln **Inläst sida** bara en konsolsats. Sedan använder du dataelementen och Analytics-tillägget för att ange Analytics-variabler som en **åtgärd** i **regeln för inläst sida**. Vi kommer också att ange en ytterligare åtgärd som ska utlösa **sidvisningsbeacon** och skicka insamlade data till Adobe Analytics.

1. I **regeln** för inläst sida **tar du bort** åtgärden **Core - Custom Code** (konsolsatserna):

   ![Ta bort anpassad kodsåtgärd](assets/collect-data-analytics/remove-console-statements.png)

1. Klicka på **Lägg till** under Åtgärder för att lägga till en ny åtgärd.
1. Ställ in typen **Tillägg** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Ange variabler**

   ![Ange åtgärdstillägg för analysuppsättningsvariabler](assets/collect-data-analytics/analytics-set-variables-action.png)

1. I huvudpanelen väljer du en tillgänglig **eVar** och anger som värde för dataelementet **Sidmall**. Använd ikonen Dataelement ![Ikon för dataelement](assets/collect-data-analytics/cylinder-icon.png) för att välja elementet **Sidmall**.

   ![Ange som eVar](assets/collect-data-analytics/set-evar-page-template.png)

1. Bläddra nedåt, under **Ytterligare inställningar** anger **Sidnamn** till dataelementet **Sidnamn**:

   ![Variabeluppsättning för sidnamnsmiljö](assets/collect-data-analytics/page-name-env-variable-set.png)

   Spara ändringarna.

1. Lägg sedan till ytterligare en åtgärd till höger om **Adobe Analytics - Ange variabler** genom att trycka på ikonen **plus**:

   ![Lägg till ytterligare en startåtgärd](assets/collect-data-analytics/add-additional-launch-action.png)

1. Ange typen **Tillägg** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Skicka fyr**. Eftersom detta betraktas som en sidvy bör du låta standardspårningsinställningen vara **`s.t()`**.

   ![Åtgärden Skicka Beacon Adobe Analytics](assets/track-clicked-component/send-page-view-beacon-config.png)

1. Spara ändringarna. Regeln **Inläst sida** bör nu ha följande konfiguration:

   ![Konfiguration för slutgiltig start](assets/collect-data-analytics/final-page-loaded-config.png)

   * **1.** Lyssna efter  `cmp:show` händelsen.
   * **2.** Kontrollera att händelsen utlöstes av en sida.
   * **3.** Ange analysvariabler för  **sidnamn** och  **sidmall**
   * **4.** Skicka analyssidans vy
1. Spara alla ändringar och bygg ett Launch-bibliotek, och marknadsför till rätt miljö.

## Validera sidvyns beacon- och analysanrop

Nu när regeln **Inläst sida** skickar analysfyren, bör du kunna se analysspårningsvariablerna med Experience Platform-felsökaren.

1. Öppna [WKND-platsen](https://wknd.site/us/en.html) i webbläsaren.
1. Klicka på felsökningsikonen ![Experience platform Debugger icon](assets/collect-data-analytics/experience-cloud-debugger.png) för att öppna Experience Platform Debugger.
1. Kontrollera att felsökaren mappar Launch-egenskapen till *din*-utvecklingsmiljö, enligt beskrivningen ovan, och **Konsolloggning** är markerad.
1. Öppna Analytics-menyn och kontrollera att rapportsviten är inställd på *din*-rapportsvit. Sidnamnet ska också fyllas i:

   ![Felsökning på fliken Analytics](assets/collect-data-analytics/analytics-tab-debugger.png)

1. Bläddra nedåt och expandera **Nätverksbegäranden**. Du bör kunna hitta **evar**-uppsättningen för **sidmallen**:

   ![Evar och Page Name](assets/collect-data-analytics/evar-page-name-set.png)

1. Gå tillbaka till webbläsaren och öppna utvecklarkonsolen. Klicka igenom **Carousel** överst på sidan.

   ![Klicka igenom karusellsidan](assets/collect-data-analytics/click-carousel-page.png)

1. Observera följande i webbläsarkonsolen:

   ![Villkoret är inte uppfyllt](assets/collect-data-analytics/condition-not-met.png)

   Detta beror på att Carousel inte utlöser en `cmp:show`-händelse *men* på grund av kontrollen av **komponentresurstypen** utlöses ingen händelse.

   >[!NOTE]
   >
   > Om du inte ser några konsolloggar kontrollerar du att **konsolloggning** är markerad under **Starta** i Felsökning för Experience Platform.

1. Navigera till en artikelsida som [Western Australia](https://wknd.site/us/en/magazine/western-australia.html). Lägg märke till att sidnamnet och malltypen ändras.

## Grattis!

Du har precis använt det händelsestyrda klientdatalagret Adobe och Experience Platform Launch för att samla in data från en AEM webbplats och skicka dem till Adobe Analytics.

### Nästa steg

Titta på följande självstudiekurs för att lära dig hur du använder det händelsestyrda Adobe-klientdatalagret för att [spåra klick på specifika komponenter på en Adobe Experience Manager-plats](track-clicked-component.md).
