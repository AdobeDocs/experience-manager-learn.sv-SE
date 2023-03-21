---
title: Samla in siddata med Adobe Analytics
description: Använd det händelsestyrda Adobe Client Data-lagret för att samla in data om användaraktivitet på en webbplats som byggts med Adobe Experience Manager. Lär dig hur du använder regler i Experience Platform Launch för att lyssna efter dessa händelser och skicka data till en Adobe Analytics rapportserie.
version: Cloud Service
topic: Integrations
feature: Adobe Client Data Layer
role: Developer
level: Intermediate
kt: 5332
thumbnail: 5332-collect-data-analytics.jpg
exl-id: 33f2fd25-8696-42fd-b496-dd21b88397b2
source-git-commit: ef1fe712921bd5516cb389862cacf226a71aa193
workflow-type: tm+mt
source-wordcount: '2371'
ht-degree: 1%

---

# Samla in siddata med Adobe Analytics

Lär dig använda de inbyggda funktionerna i [Adobe Client Data Layer med AEM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html) för att samla in data om en sida i Adobe Experience Manager Sites. [Experience Platform Launch](https://www.adobe.com/experience-platform/launch.html) och [Adobe Analytics-tillägg](https://experienceleague.adobe.com/docs/experience-platform/tags/extensions/adobe/analytics/overview.html) används för att skapa regler för att skicka siddata till Adobe Analytics.

## Vad du ska bygga

![Spårning av siddata](assets/collect-data-analytics/analytics-page-data-tracking.png)

I den här självstudiekursen utlöser du en startregel baserad på en händelse från Adobe-klientdatalagret, lägger till villkor för när regeln ska utlösas och skickar sedan **Sidnamn** och **Sidmall** en AEM till Adobe Analytics.

### Mål {#objective}

1. Skapa en händelsestyrd regel i Launch baserat på ändringar i datalagret
1. Mappa egenskaper för siddatalager till dataelement i Launch
1. Samla in siddata och skicka till Adobe Analytics med sidvyfyren

## Förutsättningar

Följande krävs:

* **Experience Platform Launch** Egenskap
* **Adobe Analytics** test/dev report suite ID and tracking server. Se följande dokumentation för [skapa en ny rapportserie](https://experienceleague.adobe.com/docs/analytics/admin/manage-report-suites/new-report-suite/new-report-suite.html).
* [Felsökning för Experience Platform](https://experienceleague.adobe.com/docs/debugger-learn/tutorials/experience-platform-debugger/introduction-to-the-experience-platform-debugger.html) webbläsartillägg. Skärmbilder i den här självstudiekursen som tagits från webbläsaren Chrome.
* (Valfritt) AEM webbplatsen med [Adobe-klientdatalagret har aktiverats](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation). I den här självstudiekursen används den offentliga webbplatsen [https://wknd.site/us/en.html](https://wknd.site/us/en.html) men du är välkommen att använda din egen webbplats.

>[!NOTE]
>
> Behöver du hjälp med att integrera Launch och din AEM webbplats? [Se den här videoserien](../experience-platform/data-collection/tags/overview.md).

## Switch Launch Environment for WKND Site

[https://wknd.site](https://wknd.site) är en publik webbplats som bygger på [ett öppen källkodsprojekt](https://github.com/adobe/aem-guides-wknd) som utformats som referens och [självstudiekurs](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html) för AEM implementeringar.

I stället för att konfigurera en AEM miljö och installera WKND-kodbasen kan du använda felsökningsprogrammet Experience Platform för att **switch** live [https://wknd.site/](https://wknd.site/) till *din* Starta egenskap. Naturligtvis kan du använda din egen AEM om den redan har [Adobe-klientdatalagret har aktiverats](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation)

1. Logga in på Experience Platform Launch och [skapa en startegenskap](https://experienceleague.adobe.com/docs/launch-learn/implementing-in-websites-with-launch/configure-launch/launch.html) (om du inte redan gjort det).
1. Se till att en inledande start [Biblioteket har skapats](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/libraries.html#create-a-library) och befordrades till en Launch [miljö](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/environments/environments.html).
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

The [WKND-referensprojekt](https://github.com/adobe/aem-guides-wknd) byggs med AEM kärnkomponenter och har [Adobe-klientdatalagret har aktiverats](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation) som standard. Kontrollera sedan att datalagret för klienten i Adobe är aktiverat.

1. Navigera till [https://wknd.site](https://wknd.site).
1. Öppna webbläsarens utvecklarverktyg och gå till **Konsol**. Kör följande kommando:

   ```js
   adobeDataLayer.getState();
   ```

   Detta returnerar det aktuella läget för Adobe-klientdatalagret.

   ![Adobe datalagrets läge](assets/collect-data-analytics/adobe-data-layer-state.png)

1. Expandera svaret och inspektera `page` post. Du bör se ett dataschema som följande:

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

   Vi kommer att använda standardegenskaper från [Sidschema](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#page),  `dc:title`, `xdm:language` och `xdm:template` av datalagret för att skicka siddata till Adobe Analytics.

   >[!NOTE]
   >
   > Se inte `adobeDataLayer` javascript-objekt? Se till att [Adobe-klientdatalagret har aktiverats](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation) på din webbplats.

## Skapa en inläst sidregel

Adobe-klientdatalagret är ett **event** datalager. När AEM **Sida** datalagret läses in och utlöser en händelse `cmp:show`. Skapa en regel som aktiveras baserat på `cmp:show` -händelse.

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till **Regler** i startgränssnittet och klicka sedan på **Skapa ny regel**.

   ![Skapa regel](assets/collect-data-analytics/analytics-create-rule.png)

1. Namnge regeln **Inläst sida**.
1. Klicka **Händelser** **Lägg till** för att öppna **Händelsekonfiguration** guide.
1. Under **Händelsetyp** välj **Egen kod**.

   ![Namnge regeln och lägg till en anpassad kodhändelse](assets/collect-data-analytics/custom-code-event.png)

1. Klicka **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

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

   Ovanstående kodfragment lägger till en händelseavlyssnare med [trycka en funktion](https://github.com/adobe/adobe-client-data-layer/wiki#pushing-a-function) till datalagret. När `cmp:show` -händelsen aktiveras `pageShownEventHandler` funktionen anropas. I den här funktionen läggs några säkerhetskontroller till och en ny `event` är konstruerad med den senaste [datalagrets läge](https://github.com/adobe/adobe-client-data-layer/wiki#getstate) för komponenten som utlöste händelsen.

   Efter det `trigger(event)` anropas. `trigger()` är ett reserverat namn i Launch och kommer att utlösa startregeln. Vi skickar `event` objekt som en parameter som i sin tur exponeras av ett annat reserverat namn i Launch med namnet `event`. Dataelement i Launch kan nu referera till olika egenskaper som: `event.component['someKey']`.

1. Spara ändringarna.
1. Nästa under **Åtgärder** klicka **Lägg till** för att öppna **Åtgärdskonfiguration** guide.
1. Under **Åtgärdstyp** välj **Egen kod**.

   ![Åtgärdstyp för anpassad kod](assets/collect-data-analytics/action-custom-code.png)

1. Klicka **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

   ```js
   console.debug("Page Loaded ");
   console.debug("Page name: " + event.component['dc:title']);
   console.debug("Page type: " + event.component['@type']);
   console.debug("Page template: " + event.component['xdm:template']);
   ```

   The `event` objektet skickas från `trigger()` metoden anropas i den anpassade händelsen. `component` är den aktuella sidan som härleds från datalagret `getState` i den anpassade händelsen. Återkalla tidigare [Sidschema](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#page) exponeras av datalagret för att visa de olika tangenterna som visas utanför rutan.

1. Spara ändringarna och kör en [bygga](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/builds.html) i Launch för att marknadsföra koden till [miljö](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/environments/environments.html) som används på din AEM.

   >[!NOTE]
   >
   > Det kan vara mycket användbart att använda [Adobe Experience Platform Debugger](https://experienceleague.adobe.com/docs/debugger-learn/tutorials/experience-platform-debugger/introduction-to-the-experience-platform-debugger.html) för att växla inbäddningskoden till en **Utveckling** miljö.

1. Navigera till AEM webbplats och öppna utvecklarverktygen för att visa konsolen. Uppdatera sidan så ser du att konsolmeddelandena har loggats:

   ![Sidinlästa konsolmeddelanden](assets/collect-data-analytics/page-show-event-console.png)

## Skapa dataelement

Skapa sedan flera dataelement för att hämta olika värden från datalagret för klienten i Adobe. Som vi tidigare sett är det möjligt att komma åt egenskaperna för datalagret direkt via anpassad kod. Fördelen med att använda dataelement är att de kan återanvändas i alla Launch-regler.

Återkalla tidigare [Sidschema](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#page) exponeras av datalagret:

Dataelement mappas till `@type`, `dc:title`och `xdm:template` egenskaper.

### Komponentresurstyp

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till **Dataelement** och klicka **Skapa nytt dataelement**.
1. För **Namn** enter **Komponentresurstyp**.
1. För **Dataelementtyp** välj **Egen kod**.

   ![Komponentresurstyp](assets/collect-data-analytics/component-resource-type-form.png)

1. Klicka **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('@type')) {
       return event.component['@type'];
   }
   ```

   Spara ändringarna.

   >[!NOTE]
   >
   > Kom ihåg att `event` objektet görs tillgängligt och omfång baserat på den händelse som utlöste **Regel** i Launch. Värdet för ett dataelement anges inte förrän dataelementet är *refererad* inom en regel. Det är därför säkert att använda det här dataelementet i en regel som **Inläst sida** regel som skapades i föregående steg *men* inte är säkert att använda i andra sammanhang.

### Sidnamn

1. Klicka **Lägg till dataelement**.
1. För **Namn** enter **Sidnamn**.
1. För **Dataelementtyp** välj **Egen kod**.
1. Klicka **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('dc:title')) {
       return event.component['dc:title'];
   }
   ```

   Spara ändringarna.

### Sidmall

1. Klicka **Lägg till dataelement**.
1. För **Namn** enter **Sidmall**.
1. För **Dataelementtyp** välj **Egen kod**.
1. Klicka **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

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
1. Leta reda på **Adobe Analytics** och klicka **Installera**

   ![Adobe Analytics Extension](assets/collect-data-analytics/analytics-catalog-install.png)

1. Under **Bibliotekshantering** > **Rapportsviter** anger du de ID:n för rapportsviten som du vill använda för varje Launch-miljö.

   ![Ange rapportsvitens ID:n](assets/collect-data-analytics/analytics-config-reportSuite.png)

   >[!NOTE]
   >
   > Det går bra att använda en rapportserie för alla miljöer i den här självstudiekursen, men i verkligheten vill du använda separata rapportsviter, som bilden nedan visar

   >[!TIP]
   >
   >Vi rekommenderar att du använder *Hantera biblioteket åt mig, alternativ* eftersom bibliotekshanteringen gör det mycket enklare att behålla `AppMeasurement.js` biblioteket är uppdaterat.

1. Markera kryssrutan för att aktivera **Använd Activity Map**.

   ![Aktivera Använd Activity Map](assets/track-clicked-component/analytic-track-click.png)

1. Under **Allmänt** > **Spårningsserver** anger du spårningsservern, t.ex. `tmd.sc.omtrdc.net`. Ange din SSL-spårningsserver om din webbplats stöder `https://`

   ![Ange spårningsservrarna](assets/collect-data-analytics/analytics-config-trackingServer.png)

1. Klicka **Spara** för att spara ändringarna.

## Lägga till ett villkor i regeln Sidinläst

Uppdatera sedan **Inläst sida** regel som ska använda **Komponentresurstyp** dataelement för att säkerställa att regeln bara aktiveras när `cmp:show` händelsen är för **Sida**. Andra komponenter kan utlösa `cmp:show` -händelsen. Carousel-komponenten kommer till exempel att utlösa den när bildrutorna ändras. Därför är det viktigt att lägga till ett villkor för den här regeln.

1. I startgränssnittet går du till **Inläst sida** regeln skapades tidigare.
1. Under **Villkor** klicka **Lägg till** för att öppna **Villkorskonfiguration** guide.
1. För **Villkorstyp** välj **Värdejämförelse**.
1. Ange det första värdet i formulärfältet till `%Component Resource Type%`. Du kan använda ikonen Dataelement ![data-element, ikon](assets/collect-data-analytics/cylinder-icon.png) för att välja **Komponentresurstyp** dataelement. Låt jämförelseobjektet vara inställt på `Equals`.
1. Ange det andra värdet till `wknd/components/page`.

   ![Villkorskonfiguration för regel för sidinläst](assets/collect-data-analytics/condition-configuration-page-loaded.png)

   >[!NOTE]
   >
   > Det går att lägga till det här villkoret i den anpassade kodfunktionen som avlyssnar `cmp:show` händelse som skapades tidigare i självstudiekursen. Om du lägger till den i användargränssnittet blir den synligare för ytterligare användare som kan behöva göra ändringar i regeln. Dessutom kan vi använda vårt dataelement!

1. Spara ändringarna.

## Ange analysvariabler och aktivera sidvisningsfunktionen

För närvarande **Inläst sida** regeln returnerar bara en konsolsats. Använd sedan dataelementen och Analytics-tillägget för att ange Analytics-variabler som **åtgärd** i **Inläst sida** regel. Vi kommer också att vidta ytterligare åtgärder för att aktivera **Sidvisningsfyr** och skicka insamlade data till Adobe Analytics.

1. I **Inläst sida** regel **ta bort** den **Core - anpassad kod** åtgärd (konsolprogramsatser):

   ![Ta bort anpassad kodsåtgärd](assets/collect-data-analytics/remove-console-statements.png)

1. Klicka på under Åtgärder **Lägg till** för att lägga till en ny åtgärd.
1. Ange **Tillägg** skriv till **Adobe Analytics** och ange **Åtgärdstyp** till  **Ange variabler**

   ![Ange åtgärdstillägg för analysuppsättningsvariabler](assets/collect-data-analytics/analytics-set-variables-action.png)

1. Välj en tillgänglig **eVar** och anges som värdet för dataelementet **Sidmall**. Använda ikonen Dataelement ![Ikon för dataelement](assets/collect-data-analytics/cylinder-icon.png) för att välja **Sidmall** -element.

   ![Ange som eVar](assets/collect-data-analytics/set-evar-page-template.png)

1. Bläddra nedåt, under **Ytterligare inställningar** set **Sidnamn** till dataelementet **Sidnamn**:

   ![Variabeluppsättning för sidnamnsmiljö](assets/collect-data-analytics/page-name-env-variable-set.png)

   Spara ändringarna.

1. Lägg sedan till ytterligare en åtgärd till höger om **Adobe Analytics - Ange variabler** genom att trycka på **plus** ikon:

   ![Lägg till ytterligare en startåtgärd](assets/collect-data-analytics/add-additional-launch-action.png)

1. Ange **Tillägg** skriv till **Adobe Analytics** och ange **Åtgärdstyp** till  **Skicka Beacon**. Eftersom det här anses vara en sidvy låter du standardspårningsinställningen vara **`s.t()`**.

   ![Åtgärden Skicka Beacon Adobe Analytics](assets/track-clicked-component/send-page-view-beacon-config.png)

1. Spara ändringarna. The **Inläst sida** regeln ska nu ha följande konfiguration:

   ![Konfiguration för slutgiltig start](assets/collect-data-analytics/final-page-loaded-config.png)

   * **1.** Lyssna på `cmp:show` -händelse.
   * **2.** Kontrollera att händelsen utlöstes av en sida.
   * **3.** Ange analysvariabler för **Sidnamn** och **Sidmall**
   * **4.** Skicka analyssidans vy
1. Spara alla ändringar och bygg ett Launch-bibliotek, och marknadsför till rätt miljö.

## Validera sidvyns beacon- och analysanrop

Nu när **Inläst sida** regel skickar analysfyren, så du bör kunna se analysspårningsvariablerna med Experience Platform-felsökaren.

1. Öppna [WKND-plats](https://wknd.site/us/en.html) i webbläsaren.
1. Klicka på felsökningsikonen ![Experience platform Debugger, ikon](assets/collect-data-analytics/experience-cloud-debugger.png) för att öppna felsökningsprogrammet för Experience Platform.
1. Kontrollera att felsökaren mappar Launch-egenskapen till *din* Utvecklingsmiljö, enligt beskrivningen ovan, och **Konsolloggning** är markerad.
1. Öppna Analytics-menyn och kontrollera att rapportsviten är inställd på *din* rapportsvit. Sidnamnet ska också fyllas i:

   ![Felsökning på fliken Analytics](assets/collect-data-analytics/analytics-tab-debugger.png)

1. Bläddra nedåt och expandera **Nätverksförfrågningar**. Du bör kunna hitta **evar** för **Sidmall**:

   ![Evar och Page Name](assets/collect-data-analytics/evar-page-name-set.png)

1. Gå tillbaka till webbläsaren och öppna utvecklarkonsolen. Klicka igenom **Carousel** överst på sidan.

   ![Klicka igenom karusellsidan](assets/collect-data-analytics/click-carousel-page.png)

1. Observera följande i webbläsarkonsolen:

   ![Villkoret är inte uppfyllt](assets/collect-data-analytics/condition-not-met.png)

   Det beror på att Carousel utlöser en `cmp:show` event *men* på grund av vår check på **Komponentresurstyp**, ingen händelse utlöses.

   >[!NOTE]
   >
   > Om inga konsolloggar visas kontrollerar du att **Konsolloggning** är incheckad **Starta** i Experience Platform Debugger.

1. Navigera till en artikelsida som [Western Australia](https://wknd.site/us/en/magazine/western-australia.html). Lägg märke till att sidnamnet och malltypen ändras.

## Grattis!

Du har precis använt det händelsestyrda klientdatalagret Adobe och Experience Platform Launch för att samla in data från en AEM webbplats och skicka dem till Adobe Analytics.

### Nästa steg

Titta på följande självstudiekurs för att lära dig hur du använder det händelsestyrda Adobe-klientdatalagret för att [spåra klick på specifika komponenter på en Adobe Experience Manager-webbplats](track-clicked-component.md).
