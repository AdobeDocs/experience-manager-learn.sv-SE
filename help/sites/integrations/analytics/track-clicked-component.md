---
title: Spåra klickade komponenter med Adobe Analytics
description: Använd det händelsestyrda Adobe Client Data-lagret för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-plats. Lär dig hur du använder regler i Experience Platform Launch för att lyssna efter dessa händelser och skicka data till en Adobe Analytics med en spårlänkssignal.
feature: analys
topics: integrations
audience: administrator
doc-type: tutorial
activity: setup
version: cloud-service
kt: 6296
thumbnail: KT-6296.jpg
topic: Integreringar
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '1835'
ht-degree: 1%

---


# Spåra klickade komponenter med Adobe Analytics

Använd det händelsestyrda [Adobe-klientdatalagret med AEM kärnkomponenter](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html) för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-plats. Lär dig hur du använder regler i Experience Platform Launch för att lyssna efter klickhändelser, filtrera efter komponent och skicka data till en Adobe Analytics med en spårlänkssignal.

## Vad du ska bygga

WKND:s marknadsföringsteam vill veta vilka Call to Action-knappar (CTA) som fungerar bäst på hemsidan. I den här självstudiekursen ska vi lägga till en ny regel i Experience Platform Launch som lyssnar efter `cmp:click`-händelser från **Teaser** och **Button**-komponenter och skickar komponent-ID:t och en ny händelse till Adobe Analytics bredvid spårlänksfyren.

![Vad du ska göra för att skapa spårningsklickningar](assets/track-clicked-component/final-click-tracking-cta-analytics.png)

### Mål {#objective}

1. Skapa en händelsestyrd regel i Launch baserat på händelsen `cmp:click`.
1. Filtrera de olika händelserna efter komponentresurstyp.
1. Ange komponent-ID:t som klickades på och skicka händelse-Adobe Analytics med spårlänkens fyr.

## Förutsättningar

Den här självstudien är en fortsättning på [Samla in siddata med Adobe Analytics](./collect-data-analytics.md) och förutsätter att du har:

* En **startegenskap** med [Adobe Analytics-tillägget](https://docs.adobe.com/content/help/en/launch/using/extensions-ref/adobe-extension/analytics-extension/overview.html) aktiverat
* **Adobe** AnalyticsTest/Dev-rapportsprogram-ID och spårningsserver. Se följande dokumentation för [hur du skapar en ny rapportsvit](https://docs.adobe.com/content/help/en/analytics/admin/manage-report-suites/new-report-suite/new-report-suite.html).
* [Tillägget Experience Platform ](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) Debuggerbrowser har konfigurerats med egenskapen Launch inläst på  [https://wknd.site/us/en.](https://wknd.site/us/en.html) htmlor en AEM webbplats med datalagret Adobe aktiverat.

## Inspect the Button and Teaser Schema

Innan du gör regler i Launch är det praktiskt att granska [schemat för Button och Teaser](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#item) och inspektera dem i datalagrets implementering.

1. Navigera till [https://wknd.site/us/en.html](https://wknd.site/us/en.html)
1. Öppna webbläsarens utvecklarverktyg och gå till **konsolen**. Kör följande kommando:

   ```js
   adobeDataLayer.getState();
   ```

   Detta returnerar det aktuella läget för Adobe-klientdatalagret.

   ![Datalagerstatus via webbläsarkonsolen](assets/track-clicked-component/adobe-data-layer-state-browser.png)

1. Expandera svaret och sök efter poster som har prefixet `button-` och `teaser-xyz-cta`. Du bör se ett dataschema som följande:

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
       @type: "wknd/components/teaser/cta"
       dc:title: "Surf's Up"
       parentId: "teaser-da32481ec8"
       xdm:linkURL: "/content/wknd/us/en/magazine/san-diego-surf.html"
   ```

   Dessa baseras på schemat [för komponent-/behållarobjekt](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#item). Regeln vi skapar i Launch kommer att använda det här schemat.

## Skapa en CTA-klickad regel

Adobe-klientdatalagret är ett **händelsedatalager som styrs av**. När du klickar på en Core-komponent skickas en `cmp:click`-händelse via datalagret. Skapa sedan en regel som ska avlyssna händelsen `cmp:click`.

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Regler** i startgränssnittet och klicka sedan på **Lägg till regel**.
1. Namnge regeln **CTA-klickad**.
1. Klicka på **Händelser** > **Lägg till** för att öppna guiden **Händelsekonfiguration**.
1. Under **Händelsetyp** väljer du **Anpassad kod**.

   ![Namnge regeln som CTA klickade på och lägg till den anpassade kodhändelsen](assets/track-clicked-component/custom-code-event.png)

1. Klicka på **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

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

   Ovanstående kodfragment lägger till en händelseavlyssnare genom att [föra in en funktion](https://github.com/adobe/adobe-client-data-layer/wiki#pushing-a-function) i datalagret. När händelsen `cmp:click` aktiveras anropas funktionen `componentClickedHandler`. I den här funktionen läggs några säkerhetskontroller till och ett nytt `event`-objekt skapas med det senaste [tillståndet för datalagret](https://github.com/adobe/adobe-client-data-layer/wiki#getstate) för komponenten som utlöste händelsen.

   Efter att `trigger(event)` har anropats. `trigger()` är ett reserverat namn i Launch och kommer att utlösa startregeln. Vi skickar `event`-objektet som en parameter som i sin tur kommer att visas med ett annat reserverat namn i Launch med namnet `event`. Dataelement i Launch kan nu referera till olika egenskaper som: `event.component['someKey']`.

1. Spara ändringarna.
1. Klicka på **Lägg till** under **Åtgärder** för att öppna guiden **Åtgärdskonfiguration**.
1. Under **Åtgärdstyp** väljer du **Anpassad kod**.

   ![Åtgärdstyp för anpassad kod](assets/track-clicked-component/action-custom-code.png)

1. Klicka på **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

   ```js
   console.debug("Component Clicked");
   console.debug("Component Path: " + event.path);
   console.debug("Component type: " + event.component['@type']);
   console.debug("Component text: " + event.component['dc:title']);
   ```

   Objektet `event` skickas från metoden `trigger()` som anropas i den anpassade händelsen. `component` är det aktuella läget för komponenten som härletts från datalagret  `getState` som utlöste klickningen.

1. Spara ändringarna och kör en [build](https://docs.adobe.com/content/help/en/launch/using/reference/publish/builds.html) i Launch för att befordra koden till [miljön](https://docs.adobe.com/content/help/en/launch/using/reference/publish/environments.html) som används på din AEM.

   >[!NOTE]
   >
   > Det kan vara användbart att använda [Adobe Experience Platform Debugger](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html) för att växla inbäddningskoden till en **Development**-miljö.

1. Navigera till [WKND-platsen](https://wknd.site/us/en.html) och öppna utvecklarverktygen för att visa konsolen. Välj **Bevara logg**.

1. Klicka på någon av knapparna **Teaser** eller **Knapp** CTA för att navigera till en annan sida.

   ![CTA-knapp för att klicka](assets/track-clicked-component/cta-button-to-click.png)

1. Observera i utvecklarkonsolen att regeln **CTA Click** har utlösts:

   ![CTA-knapp klickad](assets/track-clicked-component/cta-button-clicked-log.png)

## Skapa dataelement

Skapa sedan ett dataelement för att hämta komponent-ID:t och titeln som du klickade på. I den föregående övningen återkom utdata för `event.path` till `component.button-b6562c963d` och värdet för `event.component['dc:title']` till exempel &quot;Visa resor&quot;.

### Komponent-ID

1. Navigera till Experience Platform Launch och till den webbegenskap som är integrerad med AEM.
1. Navigera till avsnittet **Dataelement** och klicka på **Lägg till nytt dataelement**.
1. För **Namn** anger du **komponent-ID**.
1. För **Dataelementtyp** väljer du **Anpassad kod**.

   ![Formulär för komponent-ID-dataelement](assets/track-clicked-component/component-id-data-element.png)

1. Klicka på **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.path && event.path.includes('.')) {
       // split on the `.` to return just the component ID
       return event.path.split('.')[1];
   }
   ```

   Spara ändringarna.

   >[!NOTE]
   >
   > Kom ihåg att `event`-objektet är tillgängligt och omfång baserat på händelsen som utlöste **regeln** i Launch. Värdet för ett dataelement anges inte förrän dataelementet är *refererat* i en regel. Det är därför säkert att använda det här dataelementet i en regel som **CTA Click**-regeln som skapades i den föregående övningen *men* skulle inte vara säker att använda i andra sammanhang.

### Komponenttitel

1. Navigera till avsnittet **Dataelement** och klicka på **Lägg till nytt dataelement**.
1. För **Namn** anger du **Komponenttitel**.
1. För **Dataelementtyp** väljer du **Anpassad kod**.
1. Klicka på **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('dc:title')) {
       return event.component['dc:title'];
   }
   ```

   Spara ändringarna.

## Lägga till ett villkor i regeln CTA klickat

Uppdatera sedan regeln **CTA Click** för att kontrollera att regeln bara aktiveras när händelsen `cmp:click` utlöses för en **Teaser** eller en **Button**. Eftersom Teaser CTA betraktas som ett separat objekt i datalagret är det viktigt att kontrollera det överordnade objektet för att verifiera att det kommer från ett Teaser.

1. Navigera till regeln **CTA Click** som skapades tidigare i startgränssnittet.
1. Under **Villkor** klickar du på **Lägg till** för att öppna guiden **Villkorskonfiguration**.
1. För **Villkorstyp** väljer du **Anpassad kod**.

   ![CTA klickade på anpassad villkorskod](assets/track-clicked-component/custom-code-condition.png)

1. Klicka på **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('@type')) {
       // console.log("Event Type: " + event.component['@type']);
       //Check for Button Type OR Teaser CTA type
       if(event.component['@type'] === 'wknd/components/button' ||
          event.component['@type'] === 'wknd/components/teaser/cta') {
           return true;
       }
   }
   
   // none of the conditions are met, return false
   return false;
   ```

   Ovanstående kod kontrollerar först om resurstypen är från en **Button** och kontrollerar sedan om resurstypen är från en CTA inom en **Teaser**.

1. Spara ändringarna.

## Ange analysvariabler och utlösa Track Link Beacon

För närvarande ger regeln **CTA Click** bara en konsolsats. Använd sedan dataelementen och Analytics-tillägget för att ange Analytics-variabler som en **åtgärd**. Vi kommer också att ange en ytterligare åtgärd som utlöser **spårlänken** och skicka insamlade data till Adobe Analytics.

1. I **CTA Click** rule **remove** the **Core - Custom Code** action (the console statements):

   ![Ta bort anpassad kodsåtgärd](assets/track-clicked-component/remove-console-statements.png)

1. Klicka på **Lägg till** under Åtgärder för att lägga till en ny åtgärd.
1. Ställ in typen **Tillägg** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Ange variabler**.

1. Ange följande värden för **eVars**, **Props** och **Händelser**:

   * `evar8` - `%Component ID%`
   * `prop8` -  `%Component ID%`
   * `event8`

   ![Ange eVar och händelser](assets/track-clicked-component/set-evar-prop-event.png)

   >[!NOTE]
   >
   > Här används `%Component ID%` eftersom den ger en unik identifierare för den CTA som du klickade på. En potentiell nackdel med att använda `%Component ID%` är att analysrapporten kommer att innehålla värden som `button-2e6d32893a`. Om du använder `%Component Title%` skulle det ge ett mer användarvänligt namn, men värdet kanske inte är unikt.

1. Lägg sedan till ytterligare en åtgärd till höger om **Adobe Analytics - Ange variabler** genom att trycka på ikonen **plus**:

   ![Lägg till ytterligare en startåtgärd](assets/track-clicked-component/add-additional-launch-action.png)

1. Ange typen **Tillägg** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Skicka fyr**.
1. Under **Spårning** anger du alternativknappen till **`s.tl()`**.
1. För **Länktyp** väljer du **Egen länk** och för **Länknamn** anger du värdet till: **`%Component Title%: CTA Clicked`**:

   ![Konfiguration för funktionen Skicka länk](assets/track-clicked-component/analytics-send-beacon-link-track.png)

   Då kombineras den dynamiska variabeln från dataelementet **Komponenttitel** och den statiska strängen **CTA-klickning**.

1. Spara ändringarna. Regeln **CTA Click** bör nu ha följande konfiguration:

   ![Konfiguration för slutgiltig start](assets/track-clicked-component/final-page-loaded-config.png)

   * **1.** Lyssna efter  `cmp:click` händelsen.
   * **2.** Kontrollera att händelsen utlöstes av en  **** Button eller  **Teaser**.
   * **3.** Ange Analytics-variabler för för att spåra  **komponent-** ID:t som en  **eVar**,  **prop** och en  **händelse**.
   * **4.** Skicka Analytics Track Link Beacon (och ta  **** inte med det som en sidvy).

1. Spara alla ändringar och bygg ett Launch-bibliotek, och marknadsför till rätt miljö.

## Validera beteendet för spårlänk och Analytics-anropet

Nu när regeln **CTA Click** skickar analysfyren bör du kunna se analysspårningsvariablerna med Experience Platform-felsökaren.

1. Öppna [WKND-platsen](https://wknd.site/us/en.html) i webbläsaren.
1. Klicka på felsökningsikonen ![Experience platform Debugger icon](assets/track-clicked-component/experience-cloud-debugger.png) för att öppna Experience Platform Debugger.
1. Kontrollera att felsökaren mappar Launch-egenskapen till *din*-utvecklingsmiljö, enligt beskrivningen ovan, och **Konsolloggning** är markerad.
1. Öppna Analytics-menyn och kontrollera att rapportsviten är inställd på *din*-rapportsvit.

   ![Felsökning på fliken Analytics](assets/track-clicked-component/analytics-tab-debugger.png)

1. Klicka på någon av knapparna **Teaser** eller **Knapp** CTA i webbläsaren för att navigera till en annan sida.

   ![CTA-knapp för att klicka](assets/track-clicked-component/cta-button-to-click.png)

1. Gå tillbaka till Felsökning för Experience Platform och bläddra nedåt och expandera **Nätverksbegäranden** > *Din rapportsvit*. Du bör kunna hitta uppsättningen **eVar**, **prop** och **event**.

   ![Analyshändelser, evar och prop spåras vid klickning](assets/track-clicked-component/evar-prop-link-clicked-tracked-debugger.png)

1. Gå tillbaka till webbläsaren och öppna utvecklarkonsolen. Navigera till webbplatsens sidfot och klicka på en av navigeringslänkarna:

   ![Klicka på navigeringslänken i sidfoten](assets/track-clicked-component/click-navigation-link-footer.png)

1. Observera att meddelandet *&quot;Anpassad kod&quot; för regeln&quot;Klickad&quot; inte uppfylldes* i webbläsarkonsolen.

   Detta beror på att navigeringskomponenten utlöser en `cmp:click`-händelse *men* på grund av vår kontroll av resurstypen utförs ingen åtgärd.

   >[!NOTE]
   >
   > Om du inte ser några konsolloggar kontrollerar du att **konsolloggning** är markerad under **Starta** i Felsökning för Experience Platform.

## Grattis!

Du har precis använt det händelsestyrda klientdatalagret Adobe och Experience Platform Launch för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-plats.