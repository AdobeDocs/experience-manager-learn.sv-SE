---
title: Spåra klickade komponenter med Adobe Analytics
description: Använd det händelsestyrda Adobe Client Data-lagret för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-webbplats. Lär dig hur du använder taggregler för att lyssna efter dessa händelser och skicka data till en Adobe Analytics-rapportserie med hjälp av en spårlänkssignal.
version: Experience Manager as a Cloud Service
topic: Integrations
feature: Adobe Client Data Layer
role: Developer
level: Intermediate
jira: KT-6296
thumbnail: KT-6296.jpg
badgeIntegration: label="Integrering" type="positive"
doc-type: Tutorial
exl-id: ab051363-d3e8-4c07-b1fa-3a5d24757496
duration: 394
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1750'
ht-degree: 0%

---

# Spåra klickade komponenter med Adobe Analytics

Använd det händelsestyrda [Adobe Client Data Layer med AEM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html) för att spåra klickningar på specifika komponenter på en Adobe Experience Manager-webbplats. Lär dig hur du använder regler i taggegenskapen för att lyssna efter klickhändelser, filtrera efter komponent och skicka data till en Adobe Analytics med en spårlänkssignal.

## Vad du ska bygga {#what-build}

WKND:s marknadsföringsteam är intresserade av att veta vilka `Call to Action (CTA)`-knappar som fungerar bäst på hemsidan. I den här självstudiekursen lägger vi till en regel i taggegenskapen som lyssnar efter `cmp:click`-händelserna från komponenterna **Teaser** och **Button**. Skicka sedan komponent-ID:t och en ny händelse till Adobe Analytics tillsammans med spårlänkens fyr.

![Det här skapar du spårklickningar för](assets/track-clicked-component/final-click-tracking-cta-analytics.png)

### Mål {#objective}

1. Skapa en händelsestyrd regel i taggegenskapen som fångar `cmp:click`-händelsen.
1. Filtrera de olika händelserna efter komponentresurstyp.
1. Ange komponent-id:t och skicka en händelse till Adobe Analytics med spårlänkens fyr.

## Förutsättningar

Den här självstudien är en fortsättning på [Samla in siddata med Adobe Analytics](./collect-data-analytics.md) och förutsätter att du har:

* En **taggegenskap** med [Adobe Analytics-tillägget](https://experienceleague.adobe.com/docs/experience-platform/tags/extensions/client/analytics/overview.html) aktiverat
* **Adobe Analytics** test-/dev-rapportsprogram-ID och spårningsserver. I följande dokumentation finns information om hur du [skapar en rapportsvit](https://experienceleague.adobe.com/docs/analytics/admin/admin-tools/manage-report-suites/c-new-report-suite/new-report-suite.html).
* Webbläsartillägget [Experience Platform Debugger](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html) har konfigurerats med taggegenskapen inläst på [WKND-webbplatsen](https://wknd.site/us/en.html) eller en AEM-webbplats där Adobe Data Layer är aktiverat.

## Inspektera schema för knappar och Teaser

Innan du skapar regler i taggegenskapen är det praktiskt att granska [schemat för Button och Teaser](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#item) och inspektera dem i datalagrets implementering.

1. Navigera till [WKND-startsida](https://wknd.site/us/en.html)
1. Öppna webbläsarens utvecklarverktyg och gå till **konsolen**. Kör följande kommando:

   ```js
   adobeDataLayer.getState();
   ```

   Ovanför kod returnerar det aktuella läget för Adobe Client Data Layer.

   ![Datalagrets tillstånd via webbläsarkonsolen](assets/track-clicked-component/adobe-data-layer-state-browser.png)

1. Expandera svaret och sök efter poster som har prefixats med posten `button-` och `teaser-xyz-cta`. Du bör se ett dataschema som följande:

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

   Ovanstående datainformation baseras på schemat [Component/Container Item](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#item). Den nya taggregeln använder det här schemat.

## Skapa en regel som CTA klickat på

Adobe-klientdatalagret är ett **händelsestyrt** datalager. När någon Core Component klickas skickas en `cmp:click`-händelse via datalagret. Om du vill lyssna efter `cmp:click`-händelsen skapar vi en regel.

1. Navigera till Experience Platform och till taggegenskapen som är integrerad med AEM Site.
1. Navigera till avsnittet **Regler** i gränssnittet för taggegenskaper och klicka sedan på **Lägg till regel**.
1. Namnge regeln **CTA klickade**.
1. Klicka på **Händelser** > **Lägg till** för att öppna guiden **Händelsekonfiguration**.
1. För fältet **Händelsetyp** väljer du **Egen kod**.

   ![Namnge regeln CTA klickade och lägg till den anpassade kodhändelsen](assets/track-clicked-component/custom-code-event.png)

1. Klicka på **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

   ```js
   var componentClickedHandler = function(evt) {
      // defensive coding to avoid a null pointer exception
      if(evt.hasOwnProperty("eventInfo") && evt.eventInfo.hasOwnProperty("path")) {
         //trigger Tag Rule and pass event
         console.debug("cmp:click event: " + evt.eventInfo.path);
         var event = {
            //include the path of the component that triggered the event
            path: evt.eventInfo.path,
            //get the state of the component that triggered the event
            component: window.adobeDataLayer.getState(evt.eventInfo.path)
         };
   
         //Trigger the Tag Rule, passing in the new `event` object
         // the `event` obj can now be referenced by the reserved name `event` by other Tag Property data elements
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

   Ovanstående kodfragment lägger till en händelseavlyssnare genom att [överföra en funktion](https://github.com/adobe/adobe-client-data-layer/wiki#pushing-a-function) till datalagret. När `cmp:click`-händelsen utlöses anropas funktionen `componentClickedHandler`. I den här funktionen läggs några säkerhetskontroller till och ett nytt `event`-objekt skapas med det senaste [-läget för datalagret ](https://github.com/adobe/adobe-client-data-layer/wiki#getstate) för komponenten som utlöste händelsen.

   Slutligen anropas funktionen `trigger(event)`. Funktionen `trigger()` är ett reserverat namn i taggegenskapen och den **utlöser** regeln. Objektet `event` skickas som en parameter som i sin tur visas med ett annat reserverat namn i taggegenskapen. Dataelement i taggegenskapen kan nu referera till olika egenskaper med kodfragment som `event.component['someKey']`.

1. Spara ändringarna.
1. Klicka på **Lägg till** under **Åtgärder** för att öppna guiden **Åtgärdskonfiguration**.
1. Välj **Anpassad kod** för fältet **Åtgärdstyp**.

   ![Åtgärdstyp för anpassad kod](assets/track-clicked-component/action-custom-code.png)

1. Klicka på **Öppna redigeraren** i huvudpanelen och ange följande kodfragment:

   ```js
   console.debug("Component Clicked");
   console.debug("Component Path: " + event.path);
   console.debug("Component type: " + event.component['@type']);
   console.debug("Component text: " + event.component['dc:title']);
   ```

   Objektet `event` skickas från metoden `trigger()` som anropas i den anpassade händelsen. Objektet `component` är det aktuella läget för komponenten som härleds från datalagrets `getState()`-metod och är det element som utlöste klickningen.

1. Spara ändringarna och kör en [build](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/builds.html) i taggegenskapen för att marknadsföra koden till den [miljö](https://experienceleague.adobe.com/docs/experience-platform/tags/publish/environments/environments.html) som används på din AEM-webbplats.

   >[!NOTE]
   >
   > Det kan vara användbart att använda [Adobe Experience Platform Debugger](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html) för att växla inbäddningskoden till en **Development** -miljö.

1. Navigera till [WKND-platsen](https://wknd.site/us/en.html) och öppna utvecklarverktygen för att visa konsolen. Markera kryssrutan **Bevara logg**.

1. Klicka på någon av CTA-knapparna **Teaser** eller **Button** för att navigera till en annan sida.

   ![CTA-knapp för att klicka](assets/track-clicked-component/cta-button-to-click.png)

1. Observera i utvecklarkonsolen att regeln **CTA klickade** har utlösts:

   ![CTA-knapp klickad](assets/track-clicked-component/cta-button-clicked-log.png)

## Skapa dataelement

Skapa sedan ett dataelement för att hämta komponent-ID:t och titeln som du klickade på. Återkalla i föregående övning utdata från `event.path` liknar `component.button-b6562c963d` och värdet för `event.component['dc:title']` var något som &quot;Visa resor&quot;.

### Komponent-ID

1. Navigera till Experience Platform och till taggegenskapen som är integrerad med AEM Site.
1. Navigera till avsnittet **Dataelement** och klicka på **Lägg till nytt dataelement**.
1. Ange **komponent-ID** för fältet **Namn**.
1. För fältet **Dataelementtyp** väljer du **Egen kod**.

   ![Formulär för komponent-ID-dataelement](assets/track-clicked-component/component-id-data-element.png)

1. Klicka på knappen **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.path && event.path.includes('.')) {
       // split on the `.` to return just the component ID
       return event.path.split('.')[1];
   }
   ```

1. Spara ändringarna.

   >[!NOTE]
   >
   > Kom ihåg att objektet `event` görs tillgängligt och omfång baserat på händelsen som utlöste egenskapen **Rule** i tagg. Värdet för ett dataelement anges inte förrän dataelementet är *refererat* i en regel. Det är därför säkert att använda det här dataelementet i en regel som **Sidinläsning** som skapades i föregående steg *, men* skulle inte vara säker att använda i andra sammanhang.


### Komponenttitel

1. Navigera till avsnittet **Dataelement** och klicka på **Lägg till nytt dataelement**.
1. Ange **Komponenttitel** för fältet **Namn**.
1. För fältet **Dataelementtyp** väljer du **Egen kod**.
1. Klicka på knappen **Öppna redigeraren** och ange följande i den anpassade kodredigeraren:

   ```js
   if(event && event.component && event.component.hasOwnProperty('dc:title')) {
       return event.component['dc:title'];
   }
   ```

1. Spara ändringarna.

## Lägga till ett villkor i regeln Klickade i CTA

Uppdatera sedan regeln **CTA Click** så att den bara aktiveras när händelsen `cmp:click` aktiveras för en **Teaser** eller en **Button** . Eftersom Teaser&#39;s CTA betraktas som ett separat objekt i datalagret är det viktigt att kontrollera att det överordnade objektet kommer från ett Teaser.

1. Gå till regeln **CTA Clicked** som skapades tidigare i gränssnittet för taggegenskaper.
1. Under **Villkor** klickar du på **Lägg till** för att öppna guiden **Konfiguration av villkor**.
1. Välj **Anpassad kod** för fältet **Villkorstyp**.

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

   Ovanstående kod kontrollerar först om resurstypen är från en **Button** eller om resurstypen kommer från en CTA i en **Teaser**.

1. Spara ändringarna.

## Ange analysvariabler och utlösa Track Link Beacon

För närvarande genererar regeln **CTA Click** bara en konsolsats. Därefter använder du dataelementen och Analytics-tillägget för att ange Analytics-variabler som en **åtgärd**. Vi ställer också in en extra åtgärd som utlöser **spårlänken** och skickar insamlade data till Adobe Analytics.

1. I regeln **CTA klickade** **tar du bort** åtgärden **Core - Custom Code** (konsolprogramsatserna):

   ![Ta bort anpassad kodåtgärd](assets/track-clicked-component/remove-console-statements.png)

1. Klicka på **Lägg till** under Åtgärder för att skapa en åtgärd.
1. Ange typen **Tillägg** till **Adobe Analytics** och ställ in **Åtgärdstyp** till **Ange variabler**.

1. Ange följande värden för **eVars**, **Props** och **Events**:

   * `evar8` - `%Component ID%`
   * `prop8` - `%Component ID%`
   * `event8`

   ![Ange eVar-status och händelser](assets/track-clicked-component/set-evar-prop-event.png)

   >[!NOTE]
   >
   > Här används `%Component ID%` eftersom den garanterar en unik identifierare för den CTA som du klickade på. En potentiell nackdel med `%Component ID%` är att analysrapporten innehåller värden som `button-2e6d32893a`. Om du använder `%Component Title%` skulle det ge ett mer användarvänligt namn, men värdet kanske inte är unikt.

1. Lägg sedan till en extra åtgärd till höger om **Adobe Analytics - Ange variabler** genom att trycka på ikonen **plus** :

   ![Lägg till en extra åtgärd i taggregeln](assets/track-clicked-component/add-additional-launch-action.png)

1. Ange typen **Tillägg** till **Adobe Analytics** och ställ in **åtgärdstypen** till **Skicka Beacon**.
1. Under **Spärra/knip** ställer du in alternativknappen på **`s.tl()`**.
1. För fältet **Länktyp** väljer du **Egen länk** och för **Länknamn** anger du värdet **`%Component Title%: CTA Clicked`**:

   ![Konfiguration för Lägg till länk-fyr](assets/track-clicked-component/analytics-send-beacon-link-track.png)

   Ovanstående config kombinerar den dynamiska variabeln från dataelementet **Component Title** och den statiska strängen **CTA Click**.

1. Spara ändringarna. Regeln **CTA klickade** bör nu ha följande konfiguration:

   ![Konfiguration av slutlig taggregel](assets/track-clicked-component/final-page-loaded-config.png)

   * **1.** Lyssna efter händelsen `cmp:click`.
   * **2.** Kontrollera att händelsen utlöstes av en **Button** eller **Teaser**.
   * **3.** Ange Analytics-variabler för att spåra **komponent-ID** som **eVar**, **prop** och en **händelse**.
   * **4.** Skicka analysspårslänkens Beacon (och behandla den **inte** som en sidvy).

1. Spara alla ändringar och bygg ditt taggbibliotek och marknadsför till rätt miljö.

## Validera beteendet för spårlänk och Analytics-anropet

Nu när regeln **CTA Click** skickar analysfyren bör du kunna se analysspårningsvariablerna med Experience Platform Debugger.

1. Öppna [WKND-platsen](https://wknd.site/us/en.html) i webbläsaren.
1. Klicka på felsökningsikonen ![Experience platform Debugger icon](assets/track-clicked-component/experience-cloud-debugger.png) för att öppna Experience Platform Debugger.
1. Kontrollera att felsökaren mappar taggegenskapen till *din*-utvecklingsmiljö, enligt beskrivningen ovan, och att **konsolloggning** är markerad.
1. Öppna Analytics-menyn och kontrollera att rapportsviten är inställd på *din*-rapportsvit.

   ![Flikfelsökning för analys](assets/track-clicked-component/analytics-tab-debugger.png)

1. Klicka på någon av CTA-knapparna **Teaser** eller **Button** i webbläsaren för att navigera till en annan sida.

   ![CTA-knapp för att klicka](assets/track-clicked-component/cta-button-to-click.png)

1. Gå tillbaka till Experience Platform Debugger och bläddra nedåt och expandera **Nätverksförfrågningar** > *Din rapportsvit*. Du bör kunna hitta uppsättningen **eVar**, **prop** och **event** .

   ![Analyshändelser, evar och prop spåras vid klickning](assets/track-clicked-component/evar-prop-link-clicked-tracked-debugger.png)

1. Gå tillbaka till webbläsaren och öppna utvecklarkonsolen. Navigera till webbplatsens sidfot och klicka på en av navigeringslänkarna:

   ![Klicka på navigeringslänken i sidfoten](assets/track-clicked-component/click-navigation-link-footer.png)

1. Observera att meddelandet *&quot;Anpassad kod&quot; för regeln&quot;CTA klickad&quot; inte uppfylldes i webbläsarkonsolen.*

   Ovanstående meddelande beror på att navigeringskomponenten utlöser en `cmp:click`-händelse *men* på grund av [villkoret för regeln ](#add-a-condition-to-the-cta-clicked-rule) som kontrollerar resurstypen. Ingen åtgärd utförs.

   >[!NOTE]
   >
   > Om du inte ser några konsolloggar kontrollerar du att **Konsolloggning** finns under **Experience Platform-taggar** i Experience Platform Debugger.

## Grattis!

Du har precis använt det händelsestyrda Adobe Client Data Layer and Tag i Experience Platform för att spåra klickningar på specifika komponenter på en AEM-webbplats.
