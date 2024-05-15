---
title: Mappa SPA komponenter till AEM | Komma igång med AEM SPA Editor och React
description: Lär dig hur du mappar React-komponenter till Adobe Experience Manager-komponenter (AEM) med AEM SPA Editor JS SDK. Komponentmappning gör att användare kan göra dynamiska uppdateringar av SPA komponenter i AEM SPA Editor, på samma sätt som vid traditionell AEM. Du får också lära dig hur du använder AEM React Core Components.
feature: SPA Editor
version: Cloud Service
jira: KT-4854
thumbnail: 4854-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 497ce6d7-cd39-4fb3-b5e0-6c60845f7648
duration: 477
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '2123'
ht-degree: 0%

---

# Mappa SPA komponenter till AEM {#map-components}

Lär dig hur du mappar React-komponenter till Adobe Experience Manager-komponenter (AEM) med AEM SPA Editor JS SDK. Komponentmappning gör att användare kan göra dynamiska uppdateringar av SPA komponenter i AEM SPA Editor, på samma sätt som vid traditionell AEM.

Det här kapitlet innehåller en djupdykning i AEM JSON-modell-API:t och hur JSON-innehåll som exponeras av en AEM automatiskt kan injiceras i en React-komponent som utkast.

## Syfte

1. Lär dig hur du mappar AEM komponenter till SPA.
1. Inspect hur en React-komponent använder dynamiska egenskaper som skickas från AEM.
1. Lär dig använda direkt [Reagera AEM kärnkomponenter](https://github.com/adobe/aem-react-core-wcm-components-examples).

## Vad du ska bygga

I det här kapitlet kontrolleras hur `Text` SPA är mappad till AEM `Text`-komponenten. React Core Components like the `Image` SPA används i SPA och skrivs i AEM. Funktioner i **Layoutbehållare** och **Mallredigerare** används också för att skapa en vy som ser lite mer varierad ut.

![Slutredigering av kapitelexempel](./assets/map-components/final-page.png)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Det här kapitlet är en fortsättning på [Integrera SPA](integrate-spa.md) för att följa med i det hela är det SPA projektet.

## Mappningsmetod

Det grundläggande konceptet är att mappa en SPA till en AEM. AEM komponenter, kör serversidan, exportera innehåll som en del av JSON-modellens API. JSON-innehållet används av SPA, som kör klientsidan i webbläsaren. En 1:1-mappning skapas mellan SPA och en AEM.

![Översikt över mappning av en AEM till en React-komponent](./assets/map-components/high-level-approach.png)

*Översikt över mappning av en AEM till en React-komponent*

## Inspect textkomponenten

The [AEM Project Archettype](https://github.com/adobe/aem-project-archetype) ger en `Text` som är mappad till AEM [Textkomponent](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/text.html). Detta är ett exempel på en **innehåll** -komponent, på så sätt att den återges *innehåll* från AEM.

Låt oss se hur komponenten fungerar.

### Inspect JSON-modellen

1. Innan du hoppar in i SPA är det viktigt att förstå den JSON-modell som AEM tillhandahåller. Navigera till [Core Component Library](https://www.aemcomponents.dev/content/core-components-examples/library/core-content/text.html) och visa sidan för komponenten Text. Core Component Library innehåller exempel på alla AEM Core Components.
1. Välj **JSON** för ett av exemplen:

   ![Text JSON-modell](./assets/map-components/text-json.png)

   Du bör se tre egenskaper: `text`, `richText`och `:type`.

   `:type` är en reserverad egenskap som visar `sling:resourceType` (eller sökväg) för AEM. Värdet för `:type` är vad som används för att mappa AEM till SPA.

   `text` och `richText` är ytterligare egenskaper som exponeras för SPA.

1. Visa JSON-utdata på [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Du bör kunna hitta en post som liknar:

   ```json
   "text": {
       "id": "text-a647cec03a",
       "text": "<p>Hello World! Updated content!</p>\r\n",
       "richText": true,
       ":type": "wknd-spa-react/components/text",
       "dataLayer": {}
      }
   ```

### Inspect SPA komponenten Text

1. I den utvecklingsmiljö du väljer öppnar du AEM för SPA. Expandera `ui.frontend` och öppna filen `Text.js` under `ui.frontend/src/components/Text/Text.js`.

1. Det första området vi ska inspektera är det `class Text` på ~rad 40:

   ```js
   class Text extends Component {
   
       get richTextContent() {
           return (<div
                   id={extractModelId(this.props.cqPath)}
                   data-rte-editelement
                   dangerouslySetInnerHTML={{__html: DOMPurify.sanitize(this.props.text)}} />
                   );
       }
   
       get textContent() {
           return <div>{this.props.text}</div>;
       }
   
       render() {
           return this.props.richText ? this.richTextContent : this.textContent;
       }
   }
   ```

   `Text` är en standardreaktionskomponent. Komponenten använder `this.props.richText` för att avgöra om innehållet som ska återges kommer att vara RTF eller oformaterad text. Det faktiska &quot;innehåll&quot; som används kommer från `this.props.text`.

   För att undvika en eventuell XSS-attack, skickas RTF-texten via `DOMPurify` innan [hazerouslySetInnerHTML](https://reactjs.org/docs/dom-elements.html#dangerouslysetinnerhtml) för att återge innehållet. Återkalla `richText` och `text` egenskaper från JSON-modellen tidigare i övningen.

1. Nästa, öppna `ui.frontend/src/components/import-components.js` ta en titt på `TextEditConfig` på ~rad 86:

   ```js
   const TextEditConfig = {
   emptyLabel: 'Text',
   
       isEmpty: function(props) {
           return !props || !props.text || props.text.trim().length < 1;
       }
   };
   ```

   Koden ovan avgör när platshållaren ska återges i AEM redigeringsmiljö. Om `isEmpty` metodreturer **true** återges platshållaren.

1. Ta en titt på `MapTo` ring på ~rad 94:

   ```js
   export default MapTo('wknd-spa-react/components/text')(LazyTextComponent, TextEditConfig);
   ```

   `MapTo` tillhandahålls av AEM SPA Editor JS SDK (`@adobe/aem-react-editable-components`). Banan `wknd-spa-react/components/text` representerar `sling:resourceType` för AEM. Den här sökvägen matchas med `:type` exponeras av JSON-modellen som observerats tidigare. `MapTo` hanterar tolkningen av JSON-modellens svar och skickar de korrekta värdena som `props` till SPA.

   Du hittar AEM `Text` komponentdefinition vid `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components/text`.

## Använd React Core-komponenter

[AEM WCM-komponenter - React Core-implementering](https://github.com/adobe/aem-react-core-wcm-components-base) och [AEM WCM-komponenter - Spa editor - React Core-implementering](https://github.com/adobe/aem-react-core-wcm-components-spa). Detta är en uppsättning återanvändbara gränssnittskomponenter som mappas till AEM. De flesta projekt kan återanvända dessa komponenter som en startpunkt för sin egen implementering.

1. Öppna filen i projektkoden `import-components.js` på `ui.frontend/src/components`.
Den här filen importerar alla SPA som mappar till AEM. Med tanke på den dynamiska karaktären hos implementeringen av SPA Editor måste vi uttryckligen referera till alla SPA komponenter som är kopplade till AEM redigerbara komponenter. Detta gör att en AEM kan välja att använda en komponent var de vill i programmet.
1. Följande import-programsatser innehåller SPA komponenter skrivna i projektet:

   ```js
   import './Page/Page';
   import './Text/Text';
   import './Container/Container';
   import './ExperienceFragment/ExperienceFragment';
   ```

1. Det finns flera andra `imports` från `@adobe/aem-core-components-react-spa` och `@adobe/aem-core-components-react-base`. Dessa importerar komponenterna React Core och gör dem tillgängliga i det aktuella projektet. Dessa mappas sedan till projektspecifika AEM med `MapTo`, precis som med `Text` tidigare komponentexempel.

### Uppdatera AEM

Profiler är en funktion i AEM mallar som ger utvecklare och avancerade användare detaljkontroll över vilka komponenter som är tillgängliga för användning. React Core-komponenterna ingår i SPA Code men måste aktiveras via en policy innan de kan användas i programmet.

1. Navigera AEM startskärmen till **verktyg** > **Mallar** > **[WKND SPA React](http://localhost:4502/libs/wcm/core/content/sites/templates.html/conf/wknd-spa-react)**.

1. Markera och öppna **SPA** mall för redigering.

1. Välj **Layoutbehållare** och klicka på den **policy** ikon för att redigera profilen:

   ![policy för layoutbehållare](assets/map-components/edit-spa-page-template.png)

1. Under **Tillåtna komponenter** > **WKND SPA React - Innehåll** > check **Bild**, **Teaser** och **Titel**.

   ![Uppdaterade komponenter tillgängliga](assets/map-components/update-components-available.png)

   Under **Standardkomponenter** > **Lägg till mappning** och väljer **Bild - WKND SPA React - Innehåll** komponent:

   ![Ange standardkomponenter](./assets/map-components/default-components.png)

   Ange en **mime-typ** av `image/*`.

   Klicka **Klar** för att spara principuppdateringarna.

1. I **Layoutbehållare** klicka på **policy** ikonen för **Text** -komponenten.

   Skapa en ny princip med namnet **WKND SPA**. Under **Plugins** > **Formatering** > markera alla rutor för att aktivera ytterligare formateringsalternativ:

   ![Aktivera RTE-formatering](assets/map-components/enable-formatting-rte.png)

   Under **Plugins** > **Styckeformat** > markera kryssrutan till **Aktivera styckeformat**:

   ![Aktivera styckeformat](./assets/map-components/text-policy-enable-paragraphstyles.png)

   Klicka **Klar** för att spara principuppdateringen.

### Författarinnehåll

1. Navigera till **Hemsida** [http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html).

1. Nu bör du kunna använda de extra komponenterna **Bild**, **Teaser** och **Titel** på sidan.

   ![Ytterligare komponenter](assets/map-components/additional-components.png)

1. Du bör även kunna redigera `Text` och lägga till fler styckeformat i **helskärm** läge.

   ![RTF-redigering i helskärmsläge](assets/map-components/full-screen-rte.png)

1. Du bör också kunna dra och släppa en bild från **Resurssökare**:

   ![Dra och släpp bild](assets/map-components/drag-drop-image.png)

1. Upplevelsen med **Titel** och **Teaser** -komponenter.

1. Lägg in egna bilder via [AEM Assets](http://localhost:4502/assets.html/content/dam) eller installera den färdiga kodbasen för standarden [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest). The [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest) innehåller många bilder som kan återanvändas på WKND-SPA. Paketet kan installeras med [AEM](http://localhost:4502/crx/packmgr/index.jsp).

   ![Package Manager install wknd.all](./assets/map-components/package-manager-wknd-all.png)

## Inspect layoutbehållaren

Stöd för **Layoutbehållare** tillhandahålls automatiskt av AEM SPA Editor SDK. The **Layoutbehållare**, vilket anges med namnet, är en **container** -komponenten. Behållarkomponenter är komponenter som accepterar JSON-strukturer som representerar *övriga* och instansiera dem dynamiskt.

Låt oss inspektera layoutbehållaren ytterligare.

1. I en webbläsare navigerar du till [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json)

   ![JSON-modell-API - responsivt rutnät](./assets/map-components/responsive-grid-modeljson.png)

   The **Layoutbehållare** har en `sling:resourceType` av `wcm/foundation/components/responsivegrid` och känns igen av SPA Editor med `:type` -egenskapen, precis som `Text` och `Image` -komponenter.

   Samma funktioner för att ändra storlek på en komponent med [Layoutläge](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/siteandpage/responsive-layout.html#defining-layouts-layout-mode) finns i SPA Editor.

2. Återgå till [http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html). Lägg till ytterligare **Bild** och försök ändra storlek på dem med **Layout** alternativ:

   ![Ändra storlek på bilden i layoutläget](./assets/map-components/responsive-grid-layout-change.gif)

3. Öppna JSON-modellen igen [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json) och observera `columnClassNames` som en del av JSON:

   ![Klassnamn för kolumn](./assets/map-components/responsive-grid-classnames.png)

   Klassnamnet `aem-GridColumn--default--4` anger att komponenten ska vara 4 kolumner bred baserat på ett 12-kolumnsstödraster. Mer information om [responsiv stödraster finns här](https://adobe-marketing-cloud.github.io/aem-responsivegrid/).

4. Återgå till utvecklingsmiljön och i `ui.apps` modul där det finns ett klientbibliotek definierat på `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/clientlibs/clientlib-grid`. Öppna filen `less/grid.less`.

   Den här filen avgör brytpunkterna (`default`, `tablet`och `phone`) som används av **Layoutbehållare**. Den här filen är avsedd att anpassas efter projektspecifikationer. För närvarande är brytpunkterna inställda på `1200px` och `768px`.

5. Du bör kunna använda de responsiva funktionerna och de uppdaterade reglerna för avancerad text i `Text` för att skapa en vy som följande:

   ![Slutredigering av kapitelexempel](assets/map-components/final-page.png)

## Grattis! {#congratulations}

Grattis, du lärde dig att mappa SPA till AEM komponenter och du använde React Core-komponenterna. Du får också en chans att utforska de responsiva funktionerna i **Layoutbehållare**.

### Nästa steg {#next-steps}

[Navigering och routning](navigation-routing.md) - Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med React Router och React Core Components.

## (Bonus) Beständiga konfigurationer av källkontrollen {#bonus-configs}

I många fall, särskilt i början av ett AEM projekt, är det viktigt att behålla konfigurationer som mallar och relaterade innehållsprinciper för källkontroll. Detta garanterar att alla utvecklare arbetar mot samma uppsättning innehåll och konfigurationer och kan säkerställa ytterligare enhetlighet mellan miljöer. När ett projekt når en viss mognadsnivå kan rutinen med mallhantering överföras till en särskild grupp med avancerade användare.

Nästa steg är att utföra med Visual Studio Code IDE och [Synkronisering AEM VSCode](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync) men skulle kunna göra det med vilket verktyg som helst och med vilken IDE som helst som du har konfigurerat till **pull** eller **import** innehåll från en lokal AEM.

1. Kontrollera att du har **Synkronisering AEM VSCode** installeras via Marketplace-tillägget:

   ![Synkronisering AEM VSCode](./assets/map-components/vscode-aem-sync.png)

2. Expandera **ui.content** i Project Explorer och navigera till `/conf/wknd-spa-react/settings/wcm/templates`.

3. **Högerklicka** den `templates` mapp och markera **Importera från AEM**:

   ![VSCode-importmall](./assets/map-components/import-aem-servervscode.png)

4. Upprepa stegen för att importera innehåll men välj **policyer** mapp på `/conf/wknd-spa-react/settings/wcm/templates/policies`.

5. Inspect `filter.xml` filen finns på `ui.content/src/main/content/META-INF/vault/filter.xml`.

   ```xml
   <!--ui.content filter.xml-->
   <?xml version="1.0" encoding="UTF-8"?>
    <workspaceFilter version="1.0">
        <filter root="/conf/wknd-spa-react" mode="merge"/>
        <filter root="/content/wknd-spa-react" mode="merge"/>
        <filter root="/content/dam/wknd-spa-react" mode="merge"/>
        <filter root="/content/experience-fragments/wknd-spa-react" mode="merge"/>
    </workspaceFilter>
   ```

   The `filter.xml` filen ansvarar för att identifiera sökvägarna till de noder som installeras med paketet. Lägg märke till `mode="merge"` på vart och ett av filtren som anger att befintligt innehåll inte kommer att ändras, läggs endast nytt innehåll till. Eftersom innehållsförfattare kan uppdatera dessa sökvägar är det viktigt att en koddistribution gör det **not** skriva över innehåll. Se [FileVault-dokumentation](https://jackrabbit.apache.org/filevault/filter.html) för mer information om hur du arbetar med filterelement.

   Jämför `ui.content/src/main/content/META-INF/vault/filter.xml` och `ui.apps/src/main/content/META-INF/vault/filter.xml` för att förstå de olika noder som hanteras av varje modul.

## (Bonus) Skapa en anpassad bildkomponent {#bonus-image}

En SPA Image-komponent har redan tillhandahållits av React Core-komponenterna. Om du vill ha en extra övning skapar du en egen React-implementering som mappar till AEM [Bildkomponent](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/image.html). The `Image` -komponenten är ett annat exempel på en **innehåll** -komponenten.

### Inspect the JSON

Innan du hoppar in i SPA ska du kontrollera JSON-modellen som finns i AEM.

1. Navigera till [Exempel på bilder i Core Component Library](https://www.aemcomponents.dev/content/core-components-examples/library/core-content/image.html).

   ![Image Core Component JSON](./assets/map-components/image-json.png)

   Egenskaper för `src`, `alt`och `title` används för att fylla i SPA `Image` -komponenten.

   >[!NOTE]
   >
   > Andra bildegenskaper visas (`lazyEnabled`, `widths`) som gör det möjligt för en utvecklare att skapa en adaptiv och lat laddande komponent. Komponenten som är inbyggd i den här självstudiekursen är enkel och gör **not** använder dessa avancerade egenskaper.

### Implementera komponenten Bild

1. Skapa sedan en ny mapp med namnet `Image` under `ui.frontend/src/components`.
1. Under `Image` mapp skapa en ny fil med namnet `Image.js`.

   ![Image.js-fil](./assets/map-components/image-js-file.png)

1. Lägg till följande `import` programsatser till `Image.js`:

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/aem-react-editable-components';
   ```

1. Lägg sedan till `ImageEditConfig` för att bestämma när platshållaren ska visas i AEM:

   ```js
   export const ImageEditConfig = {
   
       emptyLabel: 'Image',
   
       isEmpty: function(props) {
           return !props || !props.src || props.src.trim().length < 1;
       }
   };
   ```

   Platshållaren visas om `src` -egenskapen har inte angetts.

1. Nästa implementering av `Image` klass:

   ```js
    export default class Image extends Component {
   
       get content() {
           return <img     className="Image-src"
                           src={this.props.src}
                           alt={this.props.alt}
                           title={this.props.title ? this.props.title : this.props.alt} />;
       }
   
       render() {
           if(ImageEditConfig.isEmpty(this.props)) {
               return null;
           }
   
           return (
                   <div className="Image">
                       {this.content}
                   </div>
           );
       }
   }
   ```

   Ovanstående kod återger en `<img>` baserat på säljarna `src`, `alt`och `title` skickas in av JSON-modellen.

1. Lägg till `MapTo` kod som mappar React-komponenten till AEM:

   ```js
   MapTo('wknd-spa-react/components/image')(Image, ImageEditConfig);
   ```

   Lägg märke till strängen `wknd-spa-react/components/image` motsvarar platsen för AEM i `ui.apps` vid: `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components/image`.

1. Skapa en ny fil med namnet `Image.css` i samma katalog och lägg till följande:

   ```scss
   .Image-src {
       margin: 1rem 0;
       width: 100%;
       border: 0;
   }
   ```

1. I `Image.js` lägg till en referens till filen högst upp under `import` programsatser:

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/aem-react-editable-components';
   
   require('./Image.css');
   ```

1. Öppna filen `ui.frontend/src/components/import-components.js` och lägga till en referens till det nya `Image` komponent:

   ```js
   import './Page/Page';
   import './Text/Text';
   import './Container/Container';
   import './ExperienceFragment/ExperienceFragment';
   import './Image/Image'; //add reference to Image component
   ```

1. I `import-components.js` kommentera i React Core Component Image:

   ```js
   //MapTo('wknd-spa-react/components/image')(ImageV2, {isEmpty: ImageV2IsEmptyFn});
   ```

   Detta säkerställer att vår anpassade Image-komponent används i stället.

1. Distribuera SPA kod från projektets rot till AEM med Maven:

   ```shell
   $ cd aem-guides-wknd-spa.react
   $ mvn clean install -PautoInstallSinglePackage
   ```

1. Inspect SPA i AEM. Alla bildkomponenter på sidan ska fortsätta att fungera. Inspect den återgivna utskriften så ska du se koden för vår anpassade Image-komponent i stället för React Core-komponenten.

   *Anpassad bildkomponentkod*

   ```html
   <div class="Image">
       <img class="Image-src" src="/content/image-src.jpg">
   </div>
   ```

   *React Core Component Image markup*

   ```html
   <div class="cmp-image cq-dd-image">
       <img src="/content/image-src.jpg" class="cmp-image__image">
   </div>
   ```

   Detta är en bra introduktion till att utöka och implementera dina egna komponenter.
