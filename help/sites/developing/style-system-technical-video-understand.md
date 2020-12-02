---
title: Så här kodar du för AEM Style System
description: I den här videon ska vi titta närmare på den beskrivning av CSS (eller LESS) och JavaScript som används för att formatera huvudtitelkomponenten i Adobe Experience Manager med Style System, samt hur dessa format tillämpas på HTML och DOM.
feature: style-system
topics: development, components, front-end-development
audience: developer, implementer
doc-type: technical video
activity: understand
version: 6.4, 6.5
translation-type: tm+mt
source-git-commit: 664d3964df796d508973067f8fa4fe5ef83c5fec
workflow-type: tm+mt
source-wordcount: '1145'
ht-degree: 0%

---


# Så här kodar du för formatsystemet{#understanding-how-to-code-for-the-aem-style-system}

I den här videon ska vi titta närmare på den beskrivning av CSS (eller [!DNL LESS]) och JavaScript som används för att formatera Experience Managers Core Title Component med Style System, samt hur dessa format tillämpas på HTML och DOM.

>[!NOTE]
>
>AEM Style System introducerades med [AEM 6.3 SP1](https://helpx.adobe.com/experience-manager/6-3/release-notes/sp1-release-notes.html) + [Feature Pack 20593](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-20593).
>
>I videon antas att komponenten We.Retail Title har uppdaterats för att ärva från [Core Components v2.0.0+](https://github.com/Adobe-Marketing-Cloud/aem-core-wcm-components/releases).

## Så här kodar du för formatsystemet {#understanding-how-to-code-for-the-style-system}

>[!VIDEO](https://video.tv.adobe.com/v/21538/?quality=9&learn=on)

Det angivna AEM-paketet (**technical-review.sites.style-system-1.0.0.zip**) installerar exempelnamnstilen, exempelprinciper för komponenterna Web.Retail Layout Container och Title samt en exempelsida.

[technical-review.sites.style-system-1.0.0.zip](assets/technical-review.sites.style-system-1.0.0.zip)

### CSS {#the-css}

Följande är [!DNL LESS]-definitionen för exempelformatet som finns på:

* `/apps/demo/sites/style-system/clientlib-example/components/titles/styles/example.less`

För dem som föredrar CSS är det CSS som [!DNL LESS] kompileras till under det här kodfragmentet.

```css
/* LESS */
.cmp-title--example {
 .cmp-title {
  text-align: center;

  .cmp-title__text {
   color: #EB212E;
   font-weight: 600;
   font-size: 5rem;
   border-bottom: solid 1px #ddd;
   padding-bottom: 0;
   margin-bottom: .25rem
  }

  // Last Modified At element injected via JS
  .cmp-title__last-modified-at {
   color: #999;
   font-size: 1.5rem;
   font-style: italic;
   font-weight: 200;
  }
 }
}
```

Ovanstående [!DNL LESS] kompileras direkt av Experience Manager till följande CSS.

```css
/* CSS */
.cmp-title--example .cmp-title {
 text-align: center;
}

.cmp-title--example .cmp-title .cmp-title__text {
 color: #EB212E;
 font-weight: 600;
 font-size: 5rem;
 border-bottom: solid 1px #ddd;
 padding-bottom: 0;
 margin-bottom: 0.25rem;
}

.cmp-title--example .cmp-title .cmp-title__last-modified-at {
 color: #999;
 font-size: 1.5rem;
 font-style: italic;
 font-weight: 200;
}
```

### JavaScript {#example-javascript}

Följande JavaScript samlar in och injicerar den aktuella sidans senaste ändringsdatum och -tid under titeltexten när exempelformatet tillämpas på komponenten Title.

Det är valfritt att använda jQuery och de namnkonventioner som används.

Följande är [!DNL LESS]-definitionen för exempelformatet som finns på:

* `/apps/demo/sites/style-system/clientlib-example/components/titles/styles/js/title.js`

```js
/**
 * JavaScript supporting Styles may be re-used across multi Component Styles.
 *
 * For example:
 * Many styles may require the Components Image (provided via an <img> element) to be set as the background-image.
 * A single JavaScript function may be used to adjust the DOM for all styles that required this effect.
 *
 * JavaScript must react to the DOMNodeInserted event to handle style-switching in the Page Editor Authoring experience.
 * JavaScript must also run on DOM ready to handle the initial page load rendering (AEM Publish).
 * JavaScript must mark and check for elements as processed to avoid cyclic processing (ie. if the JavaScript inserts a DOM node of its own).
 */
jQuery(function ($) {
    "use strict;"

    moment.locale("en");

    /**
     * Method that injects p element, containing the current pages last modified date/time, under the title text.
     *
     * Similar to the CSS Style application, component HTML elements should be targeted via the BEM class names (as they define the stable API)
     * and targeting "raw" elements (ex. "li", "a") should be avoided.
     */
    function applyComponentStyles() {

        $(".cmp-title--example").not("[data-styles-title-last-modified-processed]").each(function () {
            var title = $(this).attr("data-styles-title-last-modified-processed", true),
                url = Granite.HTTP.getPath() + ".model.json";

            $.getJSON(url, function(data) {
                var dateObject = moment(data['lastModifiedDate']),
                    titleText = title.find('.cmp-title__text');

                titleText.after($("<p>").addClass("cmp-title__last-modified-at").text("Last modified " + dateObject.fromNow()));
            });
        });
    }

    // Handle DOM Ready event
    applyComponentStyles();

    // Apply Styles when a component is inserted into the DOM (ie. during Authoring)
    $(".responsivegrid").bind("DOMNodeInserted", applyComponentStyles);
});
```

## Bästa praxis för utveckling {#development-best-practices}

### Bästa praxis för HTML {#html-best-practices}

* HTML (genererad via HTML) ska vara så strukturellt semantisk som möjligt. undvika onödig gruppering/kapsling av element.
* HTML-element ska kunna adresseras via CSS-klasser i BEM-format.

**Bra**  - Alla element i komponenten kan adresseras via BEM-notation:

```html
<!-- Good practice -->
<div class="cmp-list">
    <ul class="cmp-list__item-group">
        <li class="cmp-list__item">...</li>
    </ul>
</div>
```

**Felaktigt**  - list- och listelementen kan endast adresseras efter elementnamn:

```html
<!-- Bad practice -->
<div class="cmp-list">
    <ul>
        <li>...</li>
    </ul>
</div>
```

* Det är bättre att exponera mer data och dölja dem än att exponera för för lite data som kräver framtida backend-utveckling för att exponera dem.

   * Att implementera redigeringsbara innehållsreglage kan hjälpa till att hålla denna HTML-kod intakt, där författarna kan välja vilka innehållselement som ska skrivas till HTML-koden. Funktionen kan vara särskilt viktig när du skriver bilder till HTML som inte kan användas för alla format.
   * Undantaget till den här regeln är när dyra resurser, till exempel bilder, exponeras som standard, eftersom händelsebilder som döljs av CSS i det här fallet hämtas i onödan.

      * Moderna bildkomponenter använder ofta JavaScript för att välja och läsa in den lämpligaste bilden för användningsfallet (visningsruta).

### CSS best practices {#css-best-practices}

>[!NOTE]
>
>Style System gör en liten teknisk skillnad från [BEM](https://en.bem.info/), eftersom `BLOCK` och `BLOCK--MODIFIER` inte används för samma element, enligt vad som anges av [BEM](https://en.bem.info/).
>
>På grund av produktbegränsningar tillämpas i stället `BLOCK--MODIFIER` på det överordnade elementet för `BLOCK`-elementet.
>
>Alla övriga innehavare av [BEM](https://en.bem.info/) ska justeras mot.

* Använd preprocessorer som [LESS](https://lesscss.org/) (stöds av AEM native) eller [SCSS](https://sass-lang.com/) (kräver anpassat byggsystem) för att tillåta tydlig CSS-definition och återanvändbarhet.

* Behåll väljarens vikt/specificitet enhetlig. Detta hjälper till att undvika och lösa svåridentifierade CSS-överlappningskonflikter.
* Ordna varje format i en separat fil.
   * Dessa filer kan kombineras med LESS/SCSS `@imports` eller om rå CSS krävs, via filinkludering i HTML-klientbibliotek eller anpassade frontendsystem för att skapa resurser.
* Undvik att blanda många komplexa format.
   * Ju fler format som kan användas samtidigt på en komponent, desto fler möjligheter till genomskinlighet. Det kan bli svårt att upprätthålla/kvalitetssäkra varumärkesprofiler/säkerställa varumärkesanpassning.
* Använd alltid CSS-klasser (efter BEM-notation) för att definiera CSS-regler.
   * Om det är absolut nödvändigt att markera element utan CSS-klasser (d.v.s. oskarpa element), flyttar du dem högre i CSS-definitionen så att det tydligt framgår att de har lägre specificitet än eventuella kollisioner med element av den typen som har valbara CSS-klasser.
* Undvik att formatera `BLOCK--MODIFIER` direkt eftersom det är kopplat till det responsiva stödrastret. Om du ändrar visningen av det här elementet kan återgivningen och funktionaliteten för det responsiva stödrastret påverkas, så det är bara formatet på den här nivån när metoden är att ändra beteendet för det responsiva stödrastret.
* Använd formatomfång med `BLOCK--MODIFIER`. `BLOCK__ELEMENT--MODIFIERS` kan användas i komponenten, men eftersom `BLOCK` representerar komponenten och komponenten är den som är formaterad är Style&quot;definierad&quot; och omfångsdefinierad via `BLOCK--MODIFIER`.

Exempel på CSS-väljarstruktur ska vara följande:

<table> 
 <tbody> 
  <tr> 
   <td valign="bottom"><p>Första nivåväljaren</p> <p>BLOCK—MODIFIER</p> </td> 
   <td valign="bottom"><p>Val av andra nivån</p> <p>BLOCK</p> </td> 
   <td valign="bottom"><p>Väljare på tredje nivån</p> <p>BLOCK_ELEMENT</p> </td> 
   <td> </td> 
   <td valign="middle">Effektiv CSS-väljare</td> 
  </tr> 
  <tr> 
   <td valign="middle"><span class="code">.cmp-list—dark</span></td> 
   <td valign="middle"><span class="code">.cmp-list</span></td> 
   <td valign="middle"><span class="code">.cmp-list_item</span></td> 
   <td valign="middle">→</td> 
   <td><p><span class="code">.cmp-list—dark</span></p> <p><span class="code"> .cmp-list</span></p> <p><span class="code"> </span><strong><span class="code"> .cmp-list_item {  </span></strong></p> <p><strong> färg: blå,</strong></p> <p><strong> }</strong></p> </td> 
  </tr> 
  <tr> 
   <td valign="middle"><span class="code">.cmp-image—hero</span></td> 
   <td valign="middle"><span class="code">.cmp-image</span></td> 
   <td valign="middle"><span class="code">.cmp-image_caption</span></td> 
   <td valign="middle">→</td> 
   <td valign="middle"><p><span class="code">.cmp-image—hero</span></p> <p><span class="code"> .cmp-image</span></p> <p><span class="code"> .cmp-image_caption {</span></p> <p><span class="code"> färg: rött,</span></p> <p><span class="code"> }</span></p> </td> 
  </tr> 
 </tbody> 
</table>

När det gäller kapslade komponenter kommer CSS-väljardjupet för dessa kapslade komponentelement att överskrida väljaren på den tredje nivån. Upprepa samma mönster för den kapslade komponenten, men omfånget görs av den överordnade komponentens `BLOCK`. Du kan med andra ord starta den kapslade komponentens `BLOCK` på den tredje nivån, och den kapslade komponentens `ELEMENT` kommer att vara på den fjärde väljarnivån.

### Bästa praxis för JavaScript {#javascript-best-practices}

De bästa metoderna som definieras i det här avsnittet gäller&quot;style-JavaScript&quot; eller JavaScript som är specifikt avsedd att hantera komponenten för stilistiska, snarare än funktionella ändamål.

* Style-JavaScript bör användas med omdöme och är ett minoritetsfall.
* Style-JavaScript ska i första hand användas för att ändra komponentens DOM med stöd för formatering med CSS.
* Utvärdera användningen av Javascript på nytt om komponenterna kommer att visas många gånger på en sida och förstå kostnaderna för beräkning/ritning och återanvändning.
* Utvärdera användningen av Javascript på nytt om nya data/nytt innehåll hämtas asynkront (via AJAX) när komponenten kan visas många gånger på en sida.
* Hantera både publicerings- och redigeringsupplevelser.
* Återanvänd style-Javascript när det är möjligt.
   * Om flera format för en komponent till exempel kräver att bilden flyttas till en bakgrundsbild, kan style-JavaScript implementeras en gång och kopplas till flera `BLOCK--MODIFIERs`.
* Skilj style-JavaScript från funktionell JavaScript när det är möjligt.
* Utvärdera kostnaden för JavaScript jämfört med att visa dessa DOM-ändringar i HTML direkt via HTML.
   * När en komponent som använder style-JavaScript behöver ändras på serversidan, ska du utvärdera om JavaScript-manipuleringen kan utföras just nu och vilka effekter/förändringar som är kopplade till komponentens prestanda och stödbarhet.

#### Prestandaöverväganden {#performance-considerations}

* Style-JavaScript ska hållas lätt och svagt.
* För att undvika flimmer och onödiga omritningar döljer du först komponenten via `BLOCK--MODIFIER BLOCK` och visar den när alla DOM-ändringar i JavaScript har slutförts.
* Prestanda för style-JavaScript-ändringar liknar grundläggande jQuery-plugin-program som kopplar till och ändrar element i DOMReady.
* Kontrollera att förfrågningar grupperas och att CSS och JavaScript är minimerade.

## Ytterligare resurser {#additional-resources}

* [Systemdokumentation](https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/style-system.html)
* [Skapa AEM klientbibliotek](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/clientlibs.html)
* [Dokumentationswebbplats för BEM (Block Element Modifier)](https://getbem.com/)
* [LESS Documentation webbplats](https://lesscss.org/)
* [jQuery-webbplats](https://jquery.com/)
