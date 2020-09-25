---
title: Samla in siddata med Adobe Analytics
description: Använd det händelsestyrda Adobe Client Data-lagret för att samla in data om användaraktivitet på en webbplats som byggts med Adobe Experience Manager. Lär dig hur du använder regler i Experience Platform Launch för att lyssna efter dessa händelser och skicka data till en Adobe Analytics rapportserie.
feature: analytics
topics: integrations
audience: administrator
doc-type: tutorial
activity: setup
version: cloud-service
kt: 5332
thumbnail: 5332-collect-data-analytics.jpg
translation-type: tm+mt
source-git-commit: 97fe98c8c62f5472f7771bbc803b2a47dc97044d
workflow-type: tm+mt
source-wordcount: '2402'
ht-degree: 1%

---


# Samla in siddata med Adobe Analytics

Lär dig använda de inbyggda funktionerna i [Adobe Client Data Layer med AEM Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html) för att samla in data om en sida i Adobe Experience Manager Sites. [Experience Platform Launch](https://www.adobe.com/experience-platform/launch.html) och [Adobe Analytics-tillägget](https://docs.adobe.com/content/help/en/launch/using/extensions-ref/adobe-extension/analytics-extension/overview.html) kommer att användas för att skapa regler för att skicka siddata till Adobe Analytics.

## Vad du ska bygga

![Spårning av siddata](assets/collect-data-analytics/analytics-page-data-tracking.png)

I den här självstudiekursen utlöser du en startregel baserad på en händelse från Adobe-klientdatalagret, lägger till villkor för när regeln ska utlösas och skickar **sidnamnet** och **sidmallen** för en AEM till Adobe Analytics.

### Mål {#objective}

1. Skapa en händelsestyrd regel i Launch baserat på ändringar i datalagret
1. Mappa egenskaper för siddatalager till dataelement i Launch
1. Samla in siddata och skicka till Adobe Analytics med sidvyfyren

## Förutsättningar

Följande krävs:

* **Experience Platform Launch** , egenskap
* **Adobe Analytics** test-/dev-rapportsprogram-ID och spårningsserver. Följande dokumentation visar hur du [skapar en ny rapportserie](https://docs.adobe.com/content/help/en/analytics/admin/manage-report-suites/new-report-suite/new-report-suite.html).
* [Webbläsartillägg för felsökning](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) i Experience Platform. Skärmbilder i den här självstudiekursen som tagits från webbläsaren Chrome.
* (Valfritt) AEM Plats med [Adobe-klientdatalagret aktiverat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation). I den här självstudiekursen används den offentliga webbplatsen [https://wknd.site/us/en.html](https://wknd.site/us/en.html) , men du är välkommen att använda din egen webbplats.

>[!NOTE]
>
> Behöver du hjälp med att integrera Launch och din AEM webbplats? [Se den här videoserien](../experience-platform-launch/overview.md).

## Switch Launch Environment for WKND Site

[https://wknd.site](https://wknd.site) är en publik webbplats som bygger på [ett öppen källkodsprojekt](https://github.com/adobe/aem-guides-wknd) som utformats som referens och [självstudiekurs](https://docs.adobe.com/content/help/en/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html) för AEM implementeringar.

I stället för att konfigurera en AEM och installera WKND-kodbasen kan du använda felsökningsfunktionen Experience Platform för att **växla** live- [https://wknd.site/](https://wknd.site/) till *din* Launch-egenskap. Du kan förstås använda en egen AEM om den redan har [Adobe-klientdatalagret aktiverat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation)

1. Logga in på Experience Platform Launch och [skapa en startegenskap](https://docs.adobe.com/content/help/en/core-services-learn/implementing-in-websites-with-launch/configure-launch/launch.html) (om du inte redan gjort det).
1. Kontrollera att ett initialt [startbibliotek har skapats](https://docs.adobe.com/content/help/en/launch/using/reference/publish/libraries.html#create-a-library) och befordrats till en startmiljö [](https://docs.adobe.com/content/help/en/launch/using/reference/publish/environments.html).
1. Kopiera startkoden för inbäddning från miljön som biblioteket har publicerats i.

   ![Copy Launch Embed Code](assets/collect-data-analytics/launch-environment-copy.png)

1. Öppna en ny flik i webbläsaren och gå till [https://wknd.site/](https://wknd.site/)
1. Öppna webbläsartillägget Experience Platform Debugger

   ![Felsökning för Experience Platform](assets/collect-data-analytics/experience-platform-debugger-extension.png)

1. Navigera till **Starta** > **Konfiguration** och ersätt den befintliga inbäddningskoden med **din** inbäddningskod med den kopierade inbäddningskoden *under* Injicerade inbäddningskoder.

   ![Ersätt inbäddad kod](assets/collect-data-analytics/platform-debugger-replace-embed.png)

1. Aktivera **konsolloggning** och **lås** felsökaren på fliken WKND.

   ![Konsolloggning](assets/collect-data-analytics/console-logging-lock-debugger.png)

## Verifiera Adobe klientdatalager på WKND-plats

WKND- [referensprojektet](https://github.com/adobe/aem-guides-wknd) byggs med AEM kärnkomponenter och har [Adobe Client Data Layer aktiverat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation) som standard. Kontrollera sedan att datalagret för klienten i Adobe är aktiverat.

1. Gå till [https://wknd.site](https://wknd.site).
1. Öppna webbläsarens utvecklarverktyg och gå till **konsolen**. Kör följande kommando:

   ```js
   adobeDataLayer.getState();
   ```

   Detta returnerar det aktuella läget för Adobe-klientdatalagret.

   ![Adobe datalagrets läge](assets/collect-data-analytics/adobe-data-layer-state.png)

1. Expandera svaret och inspektera `page` inmatningen. Du bör se ett dataschema som följande:

   ```json
   page-2eee4f8914:
       @type: "wknd/components/page"
       dc:description: "WKND is a collective of outdoors, music, crafts, adventure sports, and travel enthusiasts that want to share our experiences, connections, and expertise with the world."
       dc:title: "WKND Adventures and Travel"
       repo:modifyDate: "2020-08-31T21:02:21Z"
       repo:path: "/content/wknd/us/en.html"
       xdm:language: "en-US"
       xdm:tags: ["Attract"]
       xdm:template: "/conf/wknd/settings/wcm/templates/landing-page-template"
   ```

   Vi använder standardegenskaper som härletts från [sidschemat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#page)`dc:title`och `xdm:language` `xdm:template` datalagret för att skicka siddata till Adobe Analytics.

   >[!NOTE]
   >
   > Ser du inte `adobeDataLayer` javascript-objektet? Kontrollera att [Adobe-klientdatalagret har aktiverats](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation) på din plats.

## Skapa en inläst sidregel

Adobe-klientdatalagret är ett **händelsestyrt** datalager. När AEM **siddatalager** läses in utlöser det en händelse `cmp:show`. Skapa en regel som ska aktiveras baserat på `cmp:show` händelsen.

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Regler** i startgränssnittet och klicka sedan på **Skapa ny regel**.

   ![Skapa regel](assets/collect-data-analytics/analytics-create-rule.png)

1. Ange ett namn för regelsidan **Inläst**.
1. Klicka på **Händelser** **Lägg till** för att öppna **guiden för händelsekonfiguration** .
1. Under **Händelsetyp** väljer du **Egen kod**.

   ![Namnge regeln och lägg till en anpassad kodhändelse](assets/collect-data-analytics/custom-code-event.png)

1. Klicka på **Öppna redigerare** i huvudpanelen och ange följande kodfragment:

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

   Ovanstående kodfragment lägger till en händelseavlyssnare genom att [föra in en funktion](https://github.com/adobe/adobe-client-data-layer/wiki#pushing-a-function) i datalagret. När `cmp:show` händelsen utlöses anropas `pageShownEventHandler` funktionen. I den här funktionen läggs några säkerhetskontroller till och en ny `event` skapas med det senaste [läget för datalagret](https://github.com/adobe/adobe-client-data-layer/wiki#getstate) för komponenten som utlöste händelsen.

   Efter det `trigger(event)` anropas. `trigger()` är ett reserverat namn i Launch och kommer att utlösa startregeln. Vi skickar objektet som en parameter som `event` i sin tur visas med ett annat reserverat namn i Launch med namnet `event`. Dataelement i Launch kan nu referera till olika egenskaper som: `event.component['someKey']`.

1. Spara ändringarna.
1. Klicka sedan på **Lägg** till under **Åtgärder** för att öppna **guiden för åtgärdskonfiguration** .
1. Under **Åtgärdstyp** väljer du **Egen kod**.

   ![Åtgärdstyp för anpassad kod](assets/collect-data-analytics/action-custom-code.png)

1. Klicka på **Öppna redigerare** i huvudpanelen och ange följande kodfragment:

   ```js
   console.debug("Page Loaded ");
   console.debug("Page name: " + event.component['dc:title']);
   console.debug("Page type: " + event.component['@type']);
   console.debug("Page template: " + event.component['xdm:template']);
   ```

   Objektet `event` skickas från den `trigger()` metod som anropas i den anpassade händelsen. `component` är den aktuella sidan som härleds från datalagret `getState` i den anpassade händelsen. Återkalla [sidschemat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#page) som visas av datalagret tidigare för att se de olika tangenterna som visas utanför rutan.

1. Spara ändringarna och kör en [version](https://docs.adobe.com/content/help/en/launch/using/reference/publish/builds.html) i Launch för att marknadsföra koden i den [miljö](https://docs.adobe.com/content/help/en/launch/using/reference/publish/environments.html) som används på AEM.

   >[!NOTE]
   >
   > Det kan vara användbart att använda [Adobe Experience Platform Debugger](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) för att växla inbäddningskoden till en **utvecklingsmiljö** .

1. Navigera till AEM webbplats och öppna utvecklarverktygen för att visa konsolen. Uppdatera sidan så ser du att konsolmeddelandena har loggats:

   ![Sidinlästa konsolmeddelanden](assets/collect-data-analytics/page-show-event-console.png)

## Skapa dataelement

Skapa sedan flera dataelement för att hämta olika värden från datalagret för klienten i Adobe. Som vi tidigare sett är det möjligt att komma åt egenskaperna för datalagret direkt via anpassad kod. Fördelen med att använda dataelement är att de kan återanvändas i alla Launch-regler.

Återkalla [sidschemat](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#page) som exponeras av datalagret tidigare:

Dataelement mappas till egenskaperna `@type`, `dc:title`och `xdm:template` .

### Komponentresurstyp

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Dataelement** och klicka på **Skapa nytt dataelement**.
1. I **Namn** anger du **komponentresurstyp**.
1. För **dataelementtyp** väljer du **Anpassad kod**.

   ![Komponentresurstyp](assets/collect-data-analytics/component-resource-type-form.png)

1. Klicka på **Öppna redigerare** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('@type')) {
       return event.component['@type'];
   }
   ```

   Spara ändringarna.

   >[!NOTE]
   >
   > Kom ihåg att `event` objektet är tillgängligt och omfång baserat på händelsen som utlöste **regeln** i Launch. Värdet för ett dataelement anges inte förrän dataelementet *refereras* i en regel. Det är därför säkert att använda det här dataelementet i en regel som **sidinläsningsregeln** som skapades i föregående steg, *men* inte säkert att använda i andra sammanhang.

### Sidnamn

1. Klicka på **Lägg till dataelement**.
1. I **Namn** anger du **Sidnamn**.
1. För **dataelementtyp** väljer du **Anpassad kod**.
1. Klicka på **Öppna redigerare** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('dc:title')) {
       return event.component['dc:title'];
   }
   ```

   Spara ändringarna.

### Sidmall

1. Klicka på **Lägg till dataelement**.
1. I **Namn** anger du **Sidnamn**.
1. För **dataelementtyp** väljer du **Anpassad kod**.
1. Klicka på **Öppna redigerare** och ange följande i den anpassade kodredigeraren:

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
1. Leta reda på **Adobe Analytics** -tillägget och klicka på **Installera**

   ![Adobe Analytics Extension](assets/collect-data-analytics/analytics-catalog-install.png)

1. Under **Bibliotekshantering** > **Rapportsviter** anger du de ID:n för rapportsviten som du vill använda för varje startmiljö.

   ![Ange rapportsvitens ID:n](assets/collect-data-analytics/analytics-config-reportSuite.png)

   >[!NOTE]
   >
   > Det går bra att använda en rapportserie för alla miljöer i den här självstudiekursen, men i verkligheten vill du använda separata rapportsviter, som bilden nedan visar

   >[!TIP]
   >
   >Vi rekommenderar att du använder alternativet ** Hantera biblioteket åt mig som bibliotekshanteringsinställning eftersom det gör det mycket enklare att hålla `AppMeasurement.js` biblioteket uppdaterat.

1. Ange spårningsservern under **Allmänt** > **Spårningsserver**, t.ex. `tmd.sc.omtrdc.net`. Ange din SSL-spårningsserver om din webbplats stöder `https://`

   ![Ange spårningsservrarna](assets/collect-data-analytics/analytics-config-trackingServer.png)

1. Click **Save** to save the changes.

## Lägga till ett villkor i regeln Sidinläst

Uppdatera sedan regeln för inläst **** sida så att dataelementet **Component Resource Type** används, så att regeln bara aktiveras när `cmp:show` händelsen gäller för **sidan**. Andra komponenter kan utlösa `cmp:show` händelsen, till exempel utlöser komponenten Carousel den när bildrutorna ändras. Därför är det viktigt att lägga till ett villkor för den här regeln.

1. I startgränssnittet navigerar du till den regel för **sidinläsning** som skapades tidigare.
1. Under **Villkor** klickar du på **Lägg** till för att öppna **guiden Konfiguration** av villkor.
1. För **Villkorstyp** väljer du **Värdejämförelse**.
1. Ange det första värdet i formulärfältet till `%Component Resource Type%`. Du kan använda ikonen ![för](assets/collect-data-analytics/cylinder-icon.png) dataelementet för dataelementet i dataelementet för **komponentresurstypen** . Låt jämförelseobjektet vara `Equals`.
1. Ange det andra värdet som `wknd/components/page`.

   ![Villkorskonfiguration för regel för sidinläst](assets/collect-data-analytics/condition-configuration-page-loaded.png)

   >[!NOTE]
   >
   > Det går att lägga till det här villkoret i den anpassade kodfunktionen som avlyssnar den `cmp:show` händelse som skapades tidigare i självstudien. Om du lägger till den i användargränssnittet blir den synligare för ytterligare användare som kan behöva göra ändringar i regeln. Dessutom har vi använt vårt dataelement!

1. Spara ändringarna.

## Ange analysvariabler och aktivera sidvisningsfunktionen

Regeln för inläst **sida** visar bara en konsolsats. Sedan använder du dataelementen och Analytics-tillägget för att ange Analytics-variabler som en **åtgärd** i regeln **Inläst** sida. Vi kommer också att ange en ytterligare åtgärd som ska utlösa **sidvisningsbeacon** och skicka insamlade data till Adobe Analytics.

1. I regeln **Sidinläsning** **tar** du bort åtgärden **Core - Custom Code** (konsolprogramsatserna):

   ![Ta bort anpassad kodsåtgärd](assets/collect-data-analytics/remove-console-statements.png)

1. Klicka på **Lägg till** under Åtgärder för att lägga till en ny åtgärd.
1. Ange **tilläggstypen** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Ange variabler**

   ![Ange åtgärdstillägg för analysuppsättningsvariabler](assets/collect-data-analytics/analytics-set-variables-action.png)

1. Markera en tillgänglig **eVar** på huvudpanelen och ange som värde för **sidmallen** för dataelement. Använd ikonen ![Dataelement för dataelement](assets/collect-data-analytics/cylinder-icon.png) för att välja **sidmallselementet** .

   ![Ange som eVar](assets/collect-data-analytics/set-evar-page-template.png)

1. Bläddra nedåt under **Ytterligare inställningar** och ange **Sidnamn** till dataelementet **Sidnamn**:

   ![Variabeluppsättning för sidnamnsmiljö](assets/collect-data-analytics/page-name-env-variable-set.png)

   Spara ändringarna.

1. Lägg sedan till ytterligare en åtgärd till höger om **Adobe Analytics - Ställ in variabler** genom att trycka på **plusikonen** :

   ![Lägg till ytterligare en startåtgärd](assets/collect-data-analytics/add-additional-launch-action.png)

1. Ange **tilläggstypen** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Skicka signal**. Eftersom detta betraktas som en sidvy bör du låta standardspårningsinställningen vara **`s.t()`**.

   ![Åtgärden Skicka Beacon Adobe Analytics](assets/track-clicked-component/send-page-view-beacon-config.png)

1. Spara ändringarna. Regeln **Sidinläsning** bör nu ha följande konfiguration:

   ![Konfiguration för slutgiltig start](assets/collect-data-analytics/final-page-loaded-config.png)

   * **1.** Lyssna efter `cmp:show` händelsen.
   * **2.** Kontrollera att händelsen utlöstes av en sida.
   * **3.** Ange analysvariabler för **sidnamn** och **sidmall**
   * **4.** Skicka analyssidans vy
1. Spara alla ändringar och bygg ett Launch-bibliotek, och marknadsför till rätt miljö.

## Validera sidvyns beacon- och analysanrop

Nu när regeln **Sidinläsning** skickar analysfyren bör du kunna se analysspårningsvariablerna med Experience Platform-felsökaren.

1. Öppna [WKND-platsen](https://wknd.site/us/en.html) i webbläsaren.
1. Klicka på ikonen för felsökning av ![Experience platform Debugger](assets/collect-data-analytics/experience-cloud-debugger.png) för att öppna Experience Platform Debugger.
1. Kontrollera att felsökaren mappar Launch-egenskapen till *din* utvecklingsmiljö, enligt beskrivningen ovan, och att **konsolloggning** är markerad.
1. Öppna Analytics-menyn och kontrollera att rapportsviten är inställd på *din* rapportserie. Sidnamnet ska också fyllas i:

   ![Felsökning på fliken Analytics](assets/collect-data-analytics/analytics-tab-debugger.png)

1. Bläddra nedåt och utöka **nätverksbegäranden**. Du bör kunna hitta **evar** -uppsättningen för **sidmallen**:

   ![Evar och Page Name](assets/collect-data-analytics/evar-page-name-set.png)

1. Gå tillbaka till webbläsaren och öppna utvecklarkonsolen. Klicka igenom **Carousel** överst på sidan.

   ![Klicka igenom karusellsidan](assets/collect-data-analytics/click-carousel-page.png)

1. Observera följande i webbläsarkonsolen:

   ![Villkoret är inte uppfyllt](assets/collect-data-analytics/condition-not-met.png)

   Detta beror på att Carousel utlöser en `cmp:show` händelse *men* på vår kontroll av **komponentresurstypen** utlöses ingen händelse.

   >[!NOTE]
   >
   > Om du inte ser några konsolloggar kontrollerar du att **konsolloggning** är markerat under **Starta** i Felsökning för Experience Platform.

1. Navigera till en artikelsida som [Western Australia](https://wknd.site/us/en/magazine/western-australia.html). Lägg märke till att sidnamnet och malltypen ändras.

## Grattis!

Du har precis använt det händelsestyrda klientdatalagret Adobe och Experience Platform Launch för att samla in data från en AEM webbplats och skicka dem till Adobe Analytics.

### Nästa steg

Ta en titt på följande självstudiekurs för att lära dig hur du använder det händelsestyrda Adobe Client Data-lagret för att [spåra klick på specifika komponenter på en Adobe Experience Manager-webbplats](track-clicked-component.md).
