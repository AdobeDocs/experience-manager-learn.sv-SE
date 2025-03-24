---
title: Så här kodar du för AEM Style System
description: I den här videon ska vi titta närmare på den beskrivning av CSS (eller LESS) och JavaScript som användes för att formatera Adobe Experience Managers Core Title Component med Style System, samt hur dessa format tillämpas på HTML och DOM.
feature: Style System
version: Experience Manager 6.4, Experience Manager 6.5, Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Intermediate, Experienced
doc-type: Technical Video
exl-id: 8fbc3819-3214-4c58-8629-a27eb6f0c545
duration: 1005
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1065'
ht-degree: 0%

---

# Så här kodar du för formatsystemet{#understanding-how-to-code-for-the-aem-style-system}

I den här videon ska vi titta närmare på den beskrivning av CSS (eller [!DNL LESS]) och JavaScript som användes för att formatera Experience Managers Core Title Component med Style System, samt hur dessa format tillämpas på HTML och DOM.


## Så här kodar du för formatsystemet {#understanding-how-to-code-for-the-style-system}

>[!VIDEO](https://video.tv.adobe.com/v/21538?quality=12&learn=on)

Angivet AEM-paket (**technical-review.sites.style-system-1.0.0.zip**) installerar exempelnamnstilen, exempelprinciper för komponenterna Web.Retail Layout Container och Title samt en exempelsida.

[technical-review.sites.style-system-1.0.0.zip](assets/technical-review.sites.style-system-1.0.0.zip)

### CSS {#the-css}

Följande är definitionen [!DNL LESS] för exempelformatet som finns på:

* `/apps/demo/sites/style-system/clientlib-example/components/titles/styles/example.less`

För dem som föredrar CSS är det CSS som [!DNL LESS] kompilerar till under det här kodfragmentet.

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

Ovanstående [!DNL LESS] kompileras internt av Experience Manager till följande CSS.

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

Följande JavaScript samlar in och injicerar den aktuella sidans senaste ändringsdatum och -tid under titeltexten när exempelformatet tillämpas på rubrikkomponenten.

Det är valfritt att använda jQuery och de namnkonventioner som används.

Följande är definitionen [!DNL LESS] för exempelformatet som finns på:

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

## Utveckla bästa praxis {#development-best-practices}

### HTML bästa praxis {#html-best-practices}

* HTML (genereras via HTML) ska vara så strukturellt semantiskt som möjligt, så att man slipper gruppera/kapsla element i onödan.
* HTML-element ska kunna adresseras via CSS-klasser i BEM-format.

**Bra** - Alla element i komponenten kan adresseras via BEM-notation:

```html
<!-- Good practice -->
<div class="cmp-list">
    <ul class="cmp-list__item-group">
        <li class="cmp-list__item">...</li>
    </ul>
</div>
```

**Dåligt** - list- och listelementen kan endast adresseras efter elementnamn:

```html
<!-- Bad practice -->
<div class="cmp-list">
    <ul>
        <li>...</li>
    </ul>
</div>
```

* Det är bättre att exponera mer data och dölja dem än att exponera för för lite data som kräver framtida backend-utveckling för att exponera dem.

   * Att använda skribentreglage kan hjälpa till att hålla HTML stabilt, där författarna kan välja vilka innehållselement som ska skrivas till HTML. Funktionen kan vara särskilt viktig när du skriver bilder till HTML som inte kan användas för alla format.
   * Undantaget till den här regeln är när dyra resurser, till exempel bilder, exponeras som standard, eftersom händelsebilder som döljs av CSS i det här fallet hämtas i onödan.

      * Moderna bildkomponenter använder ofta JavaScript för att välja och läsa in den lämpligaste bilden för användningsfallet (visningsruta).

### CSS best practices {#css-best-practices}

>[!NOTE]
>
>Style System gör en liten teknisk skillnad från [BEM](https://en.bem.info/), eftersom `BLOCK` och `BLOCK--MODIFIER` inte används för samma element, vilket anges av [BEM](https://en.bem.info/).
>
>På grund av produktbegränsningar tillämpas `BLOCK--MODIFIER` i stället på det överordnade elementet för `BLOCK`.
>
>Alla andra innehavare av [BEM](https://en.bem.info/) ska justeras mot.

* Använd preprocessorer som [LESS](https://lesscss.org/) (stöds av AEM internt) eller [SCSS](https://sass-lang.com/) (kräver anpassat build-system) för att tillåta tydlig CSS-definition och återanvändbarhet.

* Se till att väljarens vikt/specificitet är enhetlig. Detta hjälper till att undvika och lösa problem med att identifiera CSS-överlappningskonflikter.
* Ordna varje format i en separat fil.
   * Dessa filer kan kombineras med LESS/SCSS `@imports` eller om rå CSS krävs, via filinkludering i HTML Client Library eller anpassade front-end-system för att skapa resurser.
* Undvik att blanda många komplexa format.
   * Ju fler format som kan användas samtidigt på en komponent, desto fler möjligheter till genomskinlighet. Det kan bli svårt att upprätthålla/kvalitetssäkra varumärkesprofiler/säkerställa varumärkesanpassning.
* Använd alltid CSS-klasser (efter BEM-notation) för att definiera CSS-regler.
   * Om det är absolut nödvändigt att markera element utan CSS-klasser (d.v.s. oskarpa element), flyttar du dem högre i CSS-definitionen så att det tydligt framgår att de har lägre specificitet än eventuella kollisioner med element av den typen som har valbara CSS-klasser.
* Undvik att formatera `BLOCK--MODIFIER` direkt eftersom det är kopplat till det responsiva stödrastret. Om du ändrar visningen av det här elementet kan återgivningen och funktionaliteten för det responsiva stödrastret påverkas, så det är bara formatet på den här nivån när metoden är att ändra beteendet för det responsiva stödrastret.
* Använd formatomfång med `BLOCK--MODIFIER`. `BLOCK__ELEMENT--MODIFIERS` kan användas i komponenten, men eftersom `BLOCK` representerar komponenten och komponenten är formaterad är formatet&quot;definierat&quot; och omfång via `BLOCK--MODIFIER`.

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
   <td><p><span class="code">.cmp-list—dark</span></p> <p><span class="code"> .cmp-list</span></p> <p><span class="code"> </span><strong><span class="code"> .cmp-list_item </span></strong></p> <p><strong> färg: blå,</strong></p> <p><strong> }</strong></p> </td> 
  </tr> 
  <tr> 
   <td valign="middle"><span class="code">.cmp-image—hero</span></td> 
   <td valign="middle"><span class="code">.cmp-image</span></td> 
   <td valign="middle"><span class="code">.cmp-image_caption</span></td> 
   <td valign="middle">→</td> 
   <td valign="middle"><p><span class="code">.cmp-image—hero</span></p> <p><span class="code"> .cmp-image</span></p> <p><span class="code"> .cmp-image_caption {</span></p> <p><span class="code"> färg: röd,</span></p> <p><span class="code"> }</span></p> </td> 
  </tr> 
 </tbody> 
</table>

När det gäller kapslade komponenter kommer CSS-väljardjupet för dessa kapslade komponentelement att överskrida väljaren på den tredje nivån. Upprepa samma mönster för den kapslade komponenten, men omfånget görs av den överordnade komponentens `BLOCK`. Du kan med andra ord starta den kapslade komponentens `BLOCK` på den tredje nivån och den kapslade komponentens `ELEMENT` är på den fjärde väljarnivån.

### JavaScript bästa praxis {#javascript-best-practices}

De bästa metoderna som definieras i det här avsnittet gäller&quot;style-JavaScript&quot; eller JavaScript som är särskilt avsedda att hantera komponenten för stilistiska, snarare än funktionella ändamål.

* Style-JavaScript bör användas med omdöme och är ett minoritetsfall.
* Style-JavaScript ska i första hand användas för att ändra komponentens DOM för att ge stöd för formatering med CSS.
* Utvärdera användningen av Javascript på nytt om komponenterna kommer att visas många gånger på en sida och förstå kostnaderna för beräkning/ritning och återanvändning.
* Utvärdera användningen av Javascript på nytt om nya data/nytt innehåll hämtas asynkront (via AJAX) när komponenten kan visas många gånger på en sida.
* Hantera både publicerings- och redigeringsupplevelser.
* Återanvänd style-Javascript när det är möjligt.
   * Om flera format för en komponent till exempel kräver att bilden flyttas till en bakgrundsbild, kan style-JavaScript implementeras en gång och kopplas till flera `BLOCK--MODIFIERs`.
* Separera style-JavaScript från fungerande JavaScript när det är möjligt.
* Utvärdera kostnaden för JavaScript jämfört med att visa dessa DOM-ändringar i HTML direkt via HTML.
   * När en komponent som använder style-JavaScript behöver ändras på serversidan, ska du utvärdera om JavaScript-manipuleringen kan utföras just nu och vilka effekter/förändringar som är kopplade till komponentens prestanda och stödbarhet.

#### Prestandaöverväganden {#performance-considerations}

* Style-JavaScript ska vara lätt och smalt.
* För att undvika flimmer och onödiga omritningar döljer du först komponenten via `BLOCK--MODIFIER BLOCK` och visar den när alla DOM-ändringar i JavaScript har slutförts.
* Prestanda för ändringar av format-JavaScript påminner om grundläggande jQuery-plugin-program som kopplar till och ändrar element i DOMReady.
* Kontrollera att förfrågningar grupperas och att CSS och JavaScript är minimerade.

## Ytterligare resurser {#additional-resources}

* [Systemdokumentation för format](https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/style-system.html)
* [Skapar AEM-klientbibliotek](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/clientlibs.html)
* [BEM-dokumentationswebbplats (Block Element Modifier)](https://getbem.com/)
* [LESS Documentation website](https://lesscss.org/)
* [jQuery-webbplats](https://jquery.com/)
