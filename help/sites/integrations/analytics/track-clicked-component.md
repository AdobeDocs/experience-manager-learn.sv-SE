---
title: Spåra klickade komponenter med Adobe Analytics
description: Använd det händelsestyrda Adobe Client Data-lagret för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-plats. Lär dig hur du använder regler i Experience Platform Launch för att lyssna efter dessa händelser och skicka data till en Adobe Analytics med en spårlänkssignal.
feature: analytics
topics: integrations
audience: administrator
doc-type: tutorial
activity: setup
version: cloud-service
kt: 6296
thumbnail: KT-6296.jpg
translation-type: tm+mt
source-git-commit: 97fe98c8c62f5472f7771bbc803b2a47dc97044d
workflow-type: tm+mt
source-wordcount: '1773'
ht-degree: 1%

---


# Spåra klickade komponenter med Adobe Analytics

Använd det händelsestyrda [Adobe-klientdatalagret med AEM kärnkomponenter](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html) för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-plats. Lär dig hur du använder regler i Experience Platform Launch för att lyssna efter klickhändelser, filtrera efter komponent och skicka data till en Adobe Analytics med en spårlänkssignal.

## Vad du ska bygga

WKND:s marknadsföringsteam vill veta vilka Call to Action-knappar (CTA) som fungerar bäst på hemsidan. I den här självstudiekursen ska vi lägga till en ny regel i Experience Platform Launch som lyssnar efter `cmp:click` händelser från **Teaser** - och **Button** -komponenterna och skickar komponent-ID:t och en ny händelse till Adobe Analytics bredvid spårningsmarkeringen.

![Vad du ska göra för att skapa spårningsklickningar](assets/track-clicked-component/final-click-tracking-cta-analytics.png)

### Mål {#objective}

1. Skapa en händelsestyrd regel i Launch baserat på `cmp:click` händelsen.
1. Filtrera de olika händelserna efter komponentresurstyp.
1. Ange komponent-ID:t som klickades på och skicka händelse-Adobe Analytics med spårlänkens fyr.

## Förutsättningar

Den här självstudiekursen är en fortsättning på [Samla in siddata med Adobe Analytics](./collect-data-analytics.md) och förutsätter att du har:

* En **startegenskap** med tillägget [](https://docs.adobe.com/content/help/en/launch/using/extensions-ref/adobe-extension/analytics-extension/overview.html) Adobe Analytics aktiverat
* **Adobe Analytics** test-/dev-rapportsprogram-ID och spårningsserver. Följande dokumentation visar hur du [skapar en ny rapportserie](https://docs.adobe.com/content/help/en/analytics/admin/manage-report-suites/new-report-suite/new-report-suite.html).
* [Webbläsartillägget Experience Platform Debugger](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) har konfigurerats med egenskapen Launch inläst på [https://wknd.site/us/en.html](https://wknd.site/us/en.html) eller en AEM webbplats där Adobe Data Layer är aktiverat.

## Inspect the Button and Teaser Schema

Innan du gör regler i Launch är det praktiskt att granska [schemat för Button and Teaser](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#item) och inspektera dem i datalagrets implementering.

1. Navigera till [https://wknd.site/us/en.html](https://wknd.site/us/en.html)
1. Öppna webbläsarens utvecklarverktyg och gå till **konsolen**. Kör följande kommando:

   ```js
   adobeDataLayer.getState();
   ```

   Detta returnerar det aktuella läget för Adobe-klientdatalagret.

   ![Datalagerstatus via webbläsarkonsolen](assets/track-clicked-component/adobe-data-layer-state-browser.png)

1. Expandera svaret och sök efter poster med prefix `button-` och `teaser-xyz-cta` post. Du bör se ett dataschema som följande:

   Knappschema:

   ```json
   button-2e6d32893a:
       @type: "wknd/components/button"
       dc:title: "View All"
       parentId: "page-2eee4f8914"
       repo:modifyDate: "2020-07-11T22:17:55Z"
       xdm:linkURL: "/content/wknd/us/en/magazine.html"
   ```

   Teaser Schema:

   ```json
   teaser-da32481ec8-cta-adf3c09db9:
       @type: "nt:unstructured"
       dc:title: "Surf's Up"
       parentId: "teaser-da32481ec8"
       xdm:linkURL: "/content/wknd/us/en/magazine/san-diego-surf.html"
   ```

   Dessa baseras på [Component/Container Item Schema](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#item). Regeln vi skapar i Launch kommer att använda det här schemat.

## Skapa en CTA-klickad regel

Adobe-klientdatalagret är ett **händelsestyrt** datalager. När någon Core-komponent klickas skickas en `cmp:click` händelse via datalagret. Skapa sedan en regel som ska avlyssna `cmp:click` händelsen.

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Regler** i startgränssnittet och klicka sedan på **Lägg till regel**.
1. Namnge regeln som **CTA klickade** på.
1. Klicka på **Händelser** > **Lägg** till för att öppna **guiden för händelsekonfiguration** .
1. Under **Händelsetyp** väljer du **Egen kod**.

   ![Namnge regeln som CTA klickade på och lägg till den anpassade kodhändelsen](assets/track-clicked-component/custom-code-event.png)

1. Klicka på **Öppna redigerare** i huvudpanelen och ange följande kodfragment:

   ```js
   var componentClickedHandler = function(evt) {
      // defensive coding to avoid a null pointer exception
      if(evt.hasOwnProperty("eventInfo") && evt.eventInfo.hasOwnProperty("path")) {
         //trigger Launch Rule and pass event
         console.debug("cmp:click event: " + evt.eventInfo.path);
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
   //push the event listener for cmp:click into the data layer
   window.adobeDataLayer.push(function (dl) {
      //add event listener for `cmp:click` and callback to the `componentClickedHandler` function
      dl.addEventListener("cmp:click", componentClickedHandler);
   });
   ```

   Ovanstående kodfragment lägger till en händelseavlyssnare genom att [föra in en funktion](https://github.com/adobe/adobe-client-data-layer/wiki#pushing-a-function) i datalagret. När `cmp:click` händelsen utlöses anropas `componentClickedHandler` funktionen. I den här funktionen läggs några säkerhetskontroller till och ett nytt `event` objekt skapas med det senaste [läget för datalagret](https://github.com/adobe/adobe-client-data-layer/wiki#getstate) för komponenten som utlöste händelsen.

   Efter det `trigger(event)` anropas. `trigger()` är ett reserverat namn i Launch och kommer att utlösa startregeln. Vi skickar objektet som en parameter som `event` i sin tur visas med ett annat reserverat namn i Launch med namnet `event`. Dataelement i Launch kan nu referera till olika egenskaper som: `event.component['someKey']`.

1. Spara ändringarna.
1. Klicka sedan på **Lägg** till under **Åtgärder** för att öppna **guiden för åtgärdskonfiguration** .
1. Under **Åtgärdstyp** väljer du **Egen kod**.

   ![Åtgärdstyp för anpassad kod](assets/track-clicked-component/action-custom-code.png)

1. Klicka på **Öppna redigerare** i huvudpanelen och ange följande kodfragment:

   ```js
   console.debug("Component Clicked");
   console.debug("Component Path: " + event.path);
   console.debug("Component type: " + event.component['@type']);
   console.debug("Component text: " + event.component['dc:title']);
   ```

   Objektet `event` skickas från den `trigger()` metod som anropas i den anpassade händelsen. `component` är det aktuella läget för komponenten som härletts från datalagret `getState` som utlöste klickningen.

1. Spara ändringarna och kör en [version](https://docs.adobe.com/content/help/en/launch/using/reference/publish/builds.html) i Launch för att marknadsföra koden i den [miljö](https://docs.adobe.com/content/help/en/launch/using/reference/publish/environments.html) som används på AEM.

   >[!NOTE]
   >
   > Det kan vara användbart att använda [Adobe Experience Platform Debugger](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) för att växla inbäddningskoden till en **utvecklingsmiljö** .

1. Navigera till [WKND-platsen](https://wknd.site/us/en.html) och öppna utvecklarverktygen för att visa konsolen. Välj **Bevara logg**.

1. Klicka på någon av knapparna **Teaser** eller **Button** CTA för att navigera till en annan sida.

   ![CTA-knapp för att klicka](assets/track-clicked-component/cta-button-to-click.png)

1. Observera i utvecklarkonsolen att regeln **CTA-klickning** har utlösts:

   ![CTA-knapp klickad](assets/track-clicked-component/cta-button-clicked-log.png)

## Skapa dataelement

Skapa sedan ett dataelement för att hämta komponent-ID:t och titeln som du klickade på. I den tidigare övningen `event.path` var resultatet av något liknande `component.button-b6562c963d` och värdet av `event.component['dc:title']` var något som &quot;Visa resor&quot;.

### Komponent-ID

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Dataelement** och klicka på **Lägg till nytt dataelement**.
1. I **Namn** anger du **komponent-ID**.
1. För **dataelementtyp** väljer du **Anpassad kod**.

   ![Formulär för komponent-ID-dataelement](assets/track-clicked-component/component-id-data-element.png)

1. Klicka på **Öppna redigerare** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.path && event.path.includes('.')) {
       // split on the `.` to return just the component ID
       return event.path.split('.')[1];
   }
   ```

   Spara ändringarna.

   >[!NOTE]
   >
   > Kom ihåg att `event` objektet är tillgängligt och omfång baserat på händelsen som utlöste **regeln** i Launch. Värdet för ett dataelement anges inte förrän dataelementet *refereras* i en regel. Det är därför säkert att använda det här dataelementet i en regel som den **CTA-klickade** regeln som skapades i föregående övning *men* inte säkert att använda i andra sammanhang.

### Komponenttitel

1. Navigera till avsnittet **Dataelement** och klicka på **Lägg till nytt dataelement**.
1. I **Namn** anger du **Komponenttitel**.
1. För **dataelementtyp** väljer du **Anpassad kod**.
1. Klicka på **Öppna redigerare** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('dc:title')) {
       return event.component['dc:title'];
   }
   ```

   Spara ändringarna.

## Lägga till ett villkor i regeln CTA klickat

Uppdatera sedan regeln **CTA Click** för att se till att regeln bara aktiveras när `cmp:click` händelsen utlöses för en **Teaser** eller en **Button**. Eftersom Teaser CTA betraktas som ett separat objekt i datalagret är det viktigt att kontrollera det överordnade objektet för att verifiera att det kommer från ett Teaser.

1. I startgränssnittet navigerar du till den regel för **sidinläsning** som skapades tidigare.
1. Under **Villkor** klickar du på **Lägg** till för att öppna **guiden Konfiguration** av villkor.
1. Under **Villkorstyp** väljer du **Egen kod**.

   ![CTA klickade på anpassad villkorskod](assets/track-clicked-component/custom-code-condition.png)

1. Klicka på **Öppna redigerare** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('@type')) {
       //Check for Button Type
       if(event.component['@type'] === 'wknd/components/button') {
           return true;
       } else if (event.component['@type'] == 'nt:unstructured') {
           // Check for CTA inside a Teaser
           var parentComponentId = event.component['parentId'];
           var parentComponent = window.adobeDataLayer.getState('component.' + parentComponentId);
   
           if(parentComponent['@type'] === 'wknd/components/teaser') {
               return true;
           }
       }
   }
   
   return false;
   ```

   Ovanstående kod kontrollerar först om resurstypen kommer från en **Button** och kontrollerar sedan om resurstypen kommer från en CTA i en **Teaser**.

1. Spara ändringarna.

## Ange analysvariabler och utlösa Track Link Beacon

För närvarande genererar regeln **CTA Click** bara en konsolsats. Sedan använder du dataelementen och Analytics-tillägget för att ange Analytics-variabler som en **åtgärd**. Vi kommer också att ange en ytterligare åtgärd för att utlösa **Track Link** och skicka insamlade data till Adobe Analytics.

1. I regeln **Sidinläsning** **tar** du bort åtgärden **Core - Custom Code** (konsolprogramsatserna):

   ![Ta bort anpassad kodsåtgärd](assets/track-clicked-component/remove-console-statements.png)

1. Klicka på **Lägg till** under Åtgärder för att lägga till en ny åtgärd.
1. Ange **tilläggstypen** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Ange variabler**.

1. Ange följande värden för **eVars**, **Props** och **Events**:

   * `evar8` - `%Component ID%`
   * `prop8` - `%Component ID%`
   * `event8` - `CTA Clicked`

   ![Ange eVar och händelser](assets/track-clicked-component/set-evar-prop-event.png)

1. Lägg sedan till ytterligare en åtgärd till höger om **Adobe Analytics - Ställ in variabler** genom att trycka på **plusikonen** :

   ![Lägg till ytterligare en startåtgärd](assets/track-clicked-component/add-additional-launch-action.png)

1. Ange **tilläggstypen** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Skicka signal**.
1. Under **Spärra** anger du alternativknappen till **`s.tl()`**.
1. Under **Länktyp** väljer du **Egen länk** och för **Länknamn** anger du värdet till **komponenttiteln** för dataelementet:

   ![Konfiguration för funktionen Skicka länk](assets/track-clicked-component/analytics-send-beacon-link-track.png)

1. Spara ändringarna. Regeln **CTA Click** bör nu ha följande konfiguration:

   ![Konfiguration för slutgiltig start](assets/track-clicked-component/final-page-loaded-config.png)

   * **1.** Lyssna efter `cmp:click` händelsen.
   * **2.** Kontrollera att händelsen utlöstes av en **Button** eller **Teaser**.
   * **3.** Ange Analytics-variabler för för att spåra **komponent-ID** som en **eVar**, **prop** och en **händelse**.
   * **4.** Skicka Analytics Track Link Beacon (och behandla den **inte** som en sidvy).

1. Spara alla ändringar och bygg ett Launch-bibliotek, och marknadsför till rätt miljö.

## Validera beteendet för spårlänk och Analytics-anropet

Nu när regeln **CTA Click** skickar analysfyren bör du kunna se analysspårningsvariablerna med Experience Platform-felsökaren.

1. Öppna [WKND-platsen](https://wknd.site/us/en.html) i webbläsaren.
1. Klicka på ikonen för felsökning av ![Experience platform Debugger](assets/track-clicked-component/experience-cloud-debugger.png) för att öppna Experience Platform Debugger.
1. Kontrollera att felsökaren mappar Launch-egenskapen till *din* utvecklingsmiljö, enligt beskrivningen ovan, och att **konsolloggning** är markerad.
1. Öppna Analytics-menyn och kontrollera att rapportsviten är inställd på *din* rapportserie.

   ![Felsökning på fliken Analytics](assets/track-clicked-component/analytics-tab-debugger.png)

1. I webbläsaren klickar du på någon av knapparna **Teaser** eller **Button** CTA för att navigera till en annan sida.

   ![CTA-knapp för att klicka](assets/track-clicked-component/cta-button-to-click.png)

1. Gå tillbaka till Felsökning för Experience Platform och bläddra nedåt och expandera **Nätverksförfrågningar** > *Rapportsviten*. Du bör kunna hitta **eVar**, **prop** och **event** .

   ![Analyshändelser, evar och prop spåras vid klickning](assets/track-clicked-component/evar-prop-link-clicked-tracked-debugger.png)

1. Gå tillbaka till webbläsaren och öppna utvecklarkonsolen. Navigera till webbplatsens sidfot och klicka på en av navigeringslänkarna:

   ![Klicka på navigeringslänken i sidfoten](assets/track-clicked-component/click-navigation-link-footer.png)

1. Observera att meddelandet *&quot;Anpassad kod&quot; för regeln&quot;Klickad&quot; inte uppfylldes* i webbläsarkonsolen.

   Detta beror på att navigeringskomponenten utlöser en `cmp:click` händelse, *men* på att vi har kontrollerat mot resurstypen utförs ingen åtgärd.

   >[!NOTE]
   >
   > Om du inte ser några konsolloggar kontrollerar du att **konsolloggning** är markerat under **Starta** i Felsökning för Experience Platform.

## Grattis!

Du har precis använt det händelsestyrda klientdatalagret Adobe och Experience Platform Launch för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-plats.