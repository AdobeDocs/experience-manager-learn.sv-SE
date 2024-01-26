---
title: Mappa SPA komponenter till AEM | Komma igång med AEM SPA Editor och Angular
description: Lär dig hur du mappar komponentkomponenter till Adobe Experience Manager (AEM) med AEM SPA Editor JS SDK. Komponentmappning gör att användare kan göra dynamiska uppdateringar av SPA komponenter i AEM SPA Editor, på samma sätt som vid traditionell AEM.
feature: SPA Editor
version: Cloud Service
jira: KT-5311
thumbnail: 5311-spa-angular.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 19a8917c-a1e7-4293-9ce1-9f4c1a565861
duration: 665
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '2211'
ht-degree: 0%

---

# Mappa SPA komponenter till AEM {#map-components}

Lär dig hur du mappar komponentkomponenter till Adobe Experience Manager (AEM) med AEM SPA Editor JS SDK. Komponentmappning gör att användare kan göra dynamiska uppdateringar av SPA komponenter i AEM SPA Editor, på samma sätt som vid traditionell AEM.

I det här kapitlet finns en djupdykning i AEM JSON-modell-API:t och hur JSON-innehåll som exponeras av en AEM automatiskt kan injiceras i en Angular som props.

## Syfte

1. Lär dig hur du mappar AEM komponenter till SPA.
2. Förstå skillnaden mellan **Behållare** komponenter och **Innehåll** -komponenter.
3. Skapa en ny komponentkomponent som mappar till en befintlig AEM.

## Vad du ska bygga

I det här kapitlet granskas hur `Text` SPA är mappad till AEM `Text`-komponenten. En ny `Image` SPA som kan användas i SPA och redigeras i AEM skapas. Funktioner i **Layoutbehållare** och **Mallredigerare** kommer också att användas för att skapa en vy som är lite mer varierad i utseendet.

![Slutredigering av kapitelexempel](./assets/map-components/final-page.png)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Hämta koden

1. Hämta startpunkten för den här självstudiekursen via Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
   $ cd aem-guides-wknd-spa
   $ git checkout Angular/map-components-start
   ```

2. Distribuera kodbasen till en lokal AEM med Maven:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Om du använder [AEM 6.x](overview.md#compatibility) lägg till `classic` profil:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/map-components-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/map-components-solution`.

## Mappningsmetod

Det grundläggande konceptet är att mappa en SPA till en AEM. AEM komponenter, kör serversidan, exportera innehåll som en del av JSON-modellens API. JSON-innehållet används av SPA, som kör klientsidan i webbläsaren. En 1:1-mappning skapas mellan SPA och en AEM.

![Översikt över mappning av en AEM till en Angular-komponent](./assets/map-components/high-level-approach.png)

*Översikt över mappning av en AEM till en Angular-komponent*

## Inspect textkomponenten

The [AEM Project Archettype](https://github.com/adobe/aem-project-archetype) ger en `Text` som är mappad till AEM [Textkomponent](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/text.html). Detta är ett exempel på en **innehåll** -komponent, på så sätt att den återges *innehåll* från AEM.

Låt oss se hur komponenten fungerar.

### Inspect JSON-modellen

1. Innan du hoppar in i SPA är det viktigt att förstå den JSON-modell som AEM tillhandahåller. Navigera till [Core Component Library](https://www.aemcomponents.dev/content/core-components-examples/library/core-content/text.html) och visa sidan för komponenten Text. Core Component Library innehåller exempel på alla AEM Core Components.
2. Välj **JSON** för ett av exemplen:

   ![Text JSON-modell](./assets/map-components/text-json.png)

   Du bör se tre egenskaper: `text`, `richText`och `:type`.

   `:type` är en reserverad egenskap som visar `sling:resourceType` (eller sökväg) för AEM. Värdet för `:type` är vad som används för att mappa AEM till SPA.

   `text` och `richText` är ytterligare egenskaper som exponeras för SPA.

### Inspect komponenten Text

1. Öppna en ny terminal och navigera till `ui.frontend` -mappen i projektet. Kör `npm install` och sedan `npm start` för att starta **dev-server för webbpaket**:

   ```shell
   $ cd ui.frontend
   $ npm run start:mock
   ```

   The `ui.frontend` är inställd för att använda [dummy JSON-modell](./integrate-spa.md#mock-json).

2. Ett nytt webbläsarfönster öppnas för [http://localhost:4200/content/wknd-spa-angular/us/en/home.html](http://localhost:4200/content/wknd-spa-angular/us/en/home.html)

   ![Webbpaketets dev-server med modellinnehåll](assets/map-components/initial-start.png)

3. I den utvecklingsmiljö du väljer öppnar du AEM för WKND-SPA. Expandera `ui.frontend` och öppna filen **text.component.ts** under `ui.frontend/src/app/components/text/text.component.ts`:

   ![Källkod för komponenten Text.js Angular](assets/map-components/vscode-ide-text-js.png)

4. Det första området som ska inspekteras är det `class TextComponent` på ~rad 35:

   ```js
   export class TextComponent {
       @Input() richText: boolean;
       @Input() text: string;
       @Input() itemName: string;
   
       @HostBinding('innerHtml') get content() {
           return this.richText
           ? this.sanitizer.bypassSecurityTrustHtml(this.text)
           : this.text;
       }
       @HostBinding('attr.data-rte-editelement') editAttribute = true;
   
       constructor(private sanitizer: DomSanitizer) {}
   }
   ```

   [@Input()](https://angular.io/api/core/Input) dekoratorn används för att deklarera fält som anger värden via det mappade JSON-objektet, som granskats tidigare.

   `@HostBinding('innerHtml') get content()` är en metod som visar det redigerade textinnehållet från värdet för `this.text`. Om innehållet är RTF-text (bestäms av `this.richText` flagga) Angularnas inbyggda säkerhet ignoreras. Angularnas [DomSanitizer](https://angular.io/api/platform-browser/DomSanitizer) används för att&quot;rensa&quot; HTML i Raw-format och förhindra cross site scripting-problem. Metoden är bunden till `innerHtml` egenskapen med [@HostBinding](https://angular.io/api/core/HostBinding) dekorator.

5. Nästa steg `TextEditConfig` på ~rad 24:

   ```js
   const TextEditConfig = {
       emptyLabel: 'Text',
       isEmpty: cqModel =>
           !cqModel || !cqModel.text || cqModel.text.trim().length < 1
   };
   ```

   Koden ovan avgör när platshållaren ska återges i AEM redigeringsmiljö. Om `isEmpty` metodreturer **true** återges platshållaren.

6. Ta en titt på `MapTo` ring på ~rad 53:

   ```js
   MapTo('wknd-spa-angular/components/text')(TextComponent, TextEditConfig );
   ```

   **MapTo** tillhandahålls av AEM SPA Editor JS SDK (`@adobe/cq-angular-editable-components`). Banan `wknd-spa-angular/components/text` representerar `sling:resourceType` för AEM. Den här sökvägen matchas med `:type` exponeras av JSON-modellen som observerats tidigare. **MapTo** tolkar JSON-modellsvaret och skickar de korrekta värdena till `@Input()` SPA.

   Du hittar AEM `Text` komponentdefinition vid `ui.apps/src/main/content/jcr_root/apps/wknd-spa-angular/components/text`.

7. Experimentera genom att ändra **en.model.json** fil på `ui.frontend/src/mocks/json/en.model.json`.

   Vid ~rad 62 uppdaterar du den första `Text` värde som ska användas **`H1`** och **`u`** taggar:

   ```json
       "text": {
           "text": "<h1><u>Hello World!</u></h1>",
           "richText": true,
           ":type": "wknd-spa-angular/components/text"
       }
   ```

   Återgå till webbläsaren för att se de effekter som **dev-server för webbpaket**:

   ![Uppdaterad textmodell](assets/map-components/updated-text-model.png)

   Försök att växla `richText` egenskap mellan **true** / **false** för att se hur återgivningslogiken fungerar.

8. Inspect **text.component.html** på `ui.frontend/src/app/components/text/text.component.html`.

   Den här filen är tom eftersom hela innehållet i komponenten anges av `innerHTML` -egenskap.

9. Inspect **app.module.ts** på `ui.frontend/src/app/app.module.ts`.

   ```js
   @NgModule({
   imports: [
       BrowserModule,
       SpaAngularEditableComponentsModule,
       AppRoutingModule
   ],
   providers: [ModelManagerService, { provide: APP_BASE_HREF, useValue: '/' }],
   declarations: [AppComponent, TextComponent, PageComponent, HeaderComponent],
   entryComponents: [TextComponent, PageComponent],
   bootstrap: [AppComponent]
   })
   export class AppModule {}
   ```

   The **TextComponent** ingår inte uttryckligen, utan i stället dynamiskt via **AEMResponsiveGridComponent** från AEM SPA Editor JS SDK. Därför måste de anges i **app.module.ts**&#39; [entryComponents](https://angular.io/guide/entry-components) array.

## Skapa bildkomponenten

Skapa sedan en `Image` Angular-komponent som är mappad till AEM [Bildkomponent](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/image.html). The `Image` -komponenten är ett annat exempel på en **innehåll** -komponenten.

### Inspect the JSON

Innan du hoppar in i SPA ska du kontrollera JSON-modellen som finns i AEM.

1. Navigera till [Exempel på bilder i Core Component Library](https://www.aemcomponents.dev/content/core-components-examples/library/core-content/image.html).

   ![Image Core Component JSON](./assets/map-components/image-json.png)

   Egenskaper för `src`, `alt`och `title` används för att fylla i SPA `Image` -komponenten.

   >[!NOTE]
   >
   > Andra bildegenskaper visas (`lazyEnabled`, `widths`) som gör det möjligt för en utvecklare att skapa en adaptiv och lat laddande komponent. Komponenten som är inbyggd i den här självstudiekursen är enkel och gör **not** använder dessa avancerade egenskaper.

2. Återgå till din utvecklingsmiljö och öppna `en.model.json` på `ui.frontend/src/mocks/json/en.model.json`. Eftersom det här är en ny komponent i vårt projekt måste vi&quot;göra dummy&quot; av Image JSON.

   På ~rad 70 lägger du till en JSON-post för `image` modell (glöm inte bort det avslutande kommatecknet) `,` efter den andra `text_386303036`) och uppdatera `:itemsOrder` array.

   ```json
   ...
   ":items": {
               ...
               "text_386303036": {
                   "text": "<p>A new text component.</p>\r\n",
                   "richText": true,
                   ":type": "wknd-spa-angular/components/text"
                   },
               "image": {
                   "alt": "Rock Climber in New Zealand",
                   "title": "Rock Climber in New Zealand",
                   "src": "/mocks/images/adobestock-140634652.jpeg",
                   ":type": "wknd-spa-angular/components/image"
               }
           },
           ":itemsOrder": [
               "text",
               "text_386303036",
               "image"
           ],
   ```

   Projektet innehåller en exempelbild på `/mock-content/adobestock-140634652.jpeg` som används med **dev-server för webbpaket**.

   Du kan visa hela [en.model.json här](https://github.com/adobe/aem-guides-wknd-spa/blob/Angular/map-components-solution/ui.frontend/src/mocks/json/en.model.json).

3. Lägg till ett stockfoto som ska visas av komponenten.

   Skapa en ny mapp med namnet **bilder** under `ui.frontend/src/mocks`. Ladda ned [adobestock-140634652.jpeg](assets/map-components/adobestock-140634652.jpeg) och montera den i den nya **bilder** mapp. Du kan använda din egen bild om du vill.

### Implementera komponenten Bild

1. Stoppa **dev-server för webbpaket** om det startas.
2. Skapa en ny Image-komponent genom att köra Angular CLI `ng generate component` från `ui.frontend` mapp:

   ```shell
   $ ng generate component components/image
   ```

3. Öppna i IDE **image.component.ts** på `ui.frontend/src/app/components/image/image.component.ts` och uppdatera enligt följande:

   ```js
   import {Component, Input, OnInit} from '@angular/core';
   import {MapTo} from '@adobe/cq-angular-editable-components';
   
   const ImageEditConfig = {
   emptyLabel: 'Image',
   isEmpty: cqModel =>
       !cqModel || !cqModel.src || cqModel.src.trim().length < 1
   };
   
   @Component({
   selector: 'app-image',
   templateUrl: './image.component.html',
   styleUrls: ['./image.component.scss']
   })
   export class ImageComponent implements OnInit {
   
   @Input() src: string;
   @Input() alt: string;
   @Input() title: string;
   
   constructor() { }
   
   get hasImage() {
       return this.src && this.src.trim().length > 0;
   }
   
   ngOnInit() { }
   }
   
   MapTo('wknd-spa-angular/components/image')(ImageComponent, ImageEditConfig);
   ```

   `ImageEditConfig` är konfigurationen som avgör om författarplatshållaren ska återges i AEM, baserat på om `src` egenskapen är ifylld.

   `@Input()` av `src`, `alt`och `title` är de egenskaper som mappas från JSON API.

   `hasImage()` är en metod som avgör om bilden ska återges.

   `MapTo` mappar SPA-komponenten till AEM på `ui.apps/src/main/content/jcr_root/apps/wknd-spa-angular/components/image`.

4. Öppna **image.component.html** och uppdatera enligt följande:

   ```html
   <ng-container *ngIf="hasImage">
       <img class="image" [src]="src" [alt]="alt" [title]="title"/>
   </ng-container>
   ```

   Detta kommer att återge `<img>` element if `hasImage` returnerar **true**.

5. Öppna **image.component.scss** och uppdatera enligt följande:

   ```scss
   :host-context {
       display: block;
   }
   
   .image {
       margin: 1rem 0;
       width: 100%;
       border: 0;
   }
   ```

   >[!NOTE]
   >
   > The `:host-context` rule is **kritisk** för att AEM platshållaren för redigeraren SPA ska fungera korrekt. Alla SPA komponenter som ska redigeras i den AEM sidredigeraren behöver den här regeln som mest.

6. Öppna `app.module.ts` och lägg till `ImageComponent` till `entryComponents` array:

   ```js
   entryComponents: [TextComponent, PageComponent, ImageComponent],
   ```

   Gilla `TextComponent`, `ImageComponent` är dynamiskt inläst och måste inkluderas i `entryComponents` array.

7. Starta **dev-server för webbpaket** för att se `ImageComponent` rendera.

   ```shell
   $ npm run start:mock
   ```

   ![Bild tillagd i dummyn](assets/map-components/image-added-mock.png)

   *Bilden har lagts till i SPA*

   >[!NOTE]
   >
   > **Bonusutmaning**: Implementera en ny metod för att visa värdet för `title` som en bildtext under bilden.

## Uppdatera principer i AEM

The `ImageComponent` -komponenten visas bara i **dev-server för webbpaket**. Distribuera sedan den uppdaterade SPA för att AEM och uppdatera mallprofilerna.

1. Stoppa **dev-server för webbpaket** och från **root** av projektet, använd ändringarna i AEM med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa
   $ mvn clean install -PautoInstallSinglePackage
   ```

2. Navigera AEM startskärmen till **[!UICONTROL Tools]** > **[!UICONTROL Templates]** > **[WKND SPA Angular](http://localhost:4502/libs/wcm/core/content/sites/templates.html/conf/wknd-spa-angular)**.

   Markera och redigera **SPA**:

   ![Redigera SPA](assets/map-components/edit-spa-page-template.png)

3. Välj **Layoutbehållare** och klicka på den **policy** ikon för att redigera profilen:

   ![Policy för layoutbehållare](./assets/map-components/layout-container-policy.png)

4. Under **Tillåtna komponenter** > **WKND SPA Angular - Innehåll** > kontrollera **Bild** komponent:

   ![Bildkomponent vald](assets/map-components/check-image-component.png)

   Under **Standardkomponenter** > **Lägg till mappning** och väljer **Bild - WKND SPA Angular - Innehåll** komponent:

   ![Ange standardkomponenter](assets/map-components/default-components.png)

   Ange en **mime-typ** av `image/*`.

   Klicka **Klar** för att spara principuppdateringarna.

5. I **Layoutbehållare** klicka på **policy** ikonen för **Text** komponent:

   ![Ikon för textkomponentprofil](./assets/map-components/edit-text-policy.png)

   Skapa en ny princip med namnet **WKND SPA**. Under **Plugins** > **Formatering** > markera alla rutor för att aktivera ytterligare formateringsalternativ:

   ![Aktivera RTE-formatering](assets/map-components/enable-formatting-rte.png)

   Under **Plugins** > **Styckeformat** > markera kryssrutan till **Aktivera styckeformat**:

   ![Aktivera styckeformat](./assets/map-components/text-policy-enable-paragraphstyles.png)

   Klicka **Klar** för att spara principuppdateringen.

6. Navigera till **Hemsida** [http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html).

   Du bör även kunna redigera `Text` och lägga till fler styckeformat i **helskärm** läge.

   ![RTF-redigering i helskärmsläge](assets/map-components/full-screen-rte.png)

7. Du bör också kunna dra och släppa en bild från **Resurssökare**:

   ![Dra och släpp bild](./assets/map-components/drag-drop-image.gif)

8. Lägg in egna bilder via [AEM Assets](http://localhost:4502/assets.html/content/dam) eller installera den färdiga kodbasen för standarden [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest). The [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest) innehåller många bilder som kan återanvändas på WKND-SPA. Paketet kan installeras med [AEM](http://localhost:4502/crx/packmgr/index.jsp).

   ![Package Manager install wknd.all](./assets/map-components/package-manager-wknd-all.png)

## Inspect layoutbehållaren

Stöd för **Layoutbehållare** tillhandahålls automatiskt av AEM SPA Editor SDK. The **Layoutbehållare**, vilket anges med namnet, är en **container** -komponenten. Behållarkomponenter är komponenter som accepterar JSON-strukturer som representerar *övriga* och instansiera dem dynamiskt.

Låt oss inspektera layoutbehållaren ytterligare.

1. Öppna IDE **responsive-grid.component.ts** på `ui.frontend/src/app/components/responsive-grid`:

   ```js
   import { AEMResponsiveGridComponent,MapTo } from '@adobe/cq-angular-editable-components';
   
   MapTo('wcm/foundation/components/responsivegrid')(AEMResponsiveGridComponent);
   ```

   The `AEMResponsiveGridComponent` implementeras som en del av AEM SPA Editor SDK och ingår i projektet via `import-components`.

2. I en webbläsare navigerar du till [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json)

   ![JSON-modell-API - responsivt rutnät](./assets/map-components/responsive-grid-modeljson.png)

   The **Layoutbehållare** har en `sling:resourceType` av `wcm/foundation/components/responsivegrid` och känns igen av SPA Editor med `:type` -egenskapen, precis som `Text` och `Image` -komponenter.

   Samma funktioner för att ändra storlek på en komponent med [Layoutläge](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/siteandpage/responsive-layout.html#defining-layouts-layout-mode) finns i SPA Editor.

3. Återgå till [http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html). Lägg till ytterligare **Bild** och försök ändra storlek på dem med **Layout** alternativ:

   ![Ändra storlek på bilden i layoutläget](./assets/map-components/responsive-grid-layout-change.gif)

4. Öppna JSON-modellen igen [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json) och observera `columnClassNames` som en del av JSON:

   ![Klassnamn för kolumn](./assets/map-components/responsive-grid-classnames.png)

   Klassnamnet `aem-GridColumn--default--4` anger att komponenten ska vara 4 kolumner bred baserat på ett 12-kolumnsstödraster. Mer information om [responsiv stödraster finns här](https://adobe-marketing-cloud.github.io/aem-responsivegrid/).

5. Återgå till utvecklingsmiljön och i `ui.apps` modul där det finns ett klientbibliotek definierat på `ui.apps/src/main/content/jcr_root/apps/wknd-spa-angular/clientlibs/clientlib-grid`. Öppna filen `less/grid.less`.

   Den här filen avgör brytpunkterna (`default`, `tablet`och `phone`) som används av **Layoutbehållare**. Den här filen är avsedd att anpassas efter projektspecifikationer. För närvarande är brytpunkterna inställda på `1200px` och `650px`.

6. Du bör kunna använda de responsiva funktionerna och de uppdaterade reglerna för avancerad text i `Text` för att skapa en vy som följande:

   ![Slutredigering av kapitelexempel](assets/map-components/final-page.png)

## Grattis! {#congratulations}

Grattis, du lärde dig att mappa SPA komponenter till AEM komponenter och du implementerade en ny `Image` -komponenten. Du får också en chans att utforska de responsiva funktionerna i **Layoutbehållare**.

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/map-components-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/map-components-solution`.

### Nästa steg {#next-steps}

[Navigering och routning](navigation-routing.md) - Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med Angular Router och läggs till i en befintlig Header-komponent.

## Bonus - Beständiga konfigurationer till källkontroll {#bonus}

I många fall, särskilt i början av ett AEM projekt, är det viktigt att behålla konfigurationer som mallar och relaterade innehållsprinciper för källkontroll. Detta garanterar att alla utvecklare arbetar mot samma uppsättning innehåll och konfigurationer och kan säkerställa ytterligare enhetlighet mellan miljöer. När ett projekt når en viss mognadsnivå kan rutinen med mallhantering överföras till en särskild grupp med avancerade användare.

Nästa steg är att utföra med Visual Studio Code IDE och [Synkronisering AEM VSCode](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync) men skulle kunna göra det med vilket verktyg som helst och med vilken IDE som helst som du har konfigurerat till **pull** eller **import** innehåll från en lokal AEM.

1. Kontrollera att du har **Synkronisering AEM VSCode** installeras via Marketplace-tillägget:

   ![Synkronisering AEM VSCode](./assets/map-components/vscode-aem-sync.png)

2. Expandera **ui.content** i Project Explorer och navigera till `/conf/wknd-spa-angular/settings/wcm/templates`.

3. **Högerklicka** den `templates` mapp och markera **Importera från AEM**:

   ![VSCode-importmall](assets/map-components/import-aem-servervscode.png)

4. Upprepa stegen för att importera innehåll men välj **policyer** mapp på `/conf/wknd-spa-angular/settings/wcm/policies`.

5. Inspect `filter.xml` filen finns på `ui.content/src/main/content/META-INF/vault/filter.xml`.

   ```xml
   <!--ui.content filter.xml-->
   <?xml version="1.0" encoding="UTF-8"?>
    <workspaceFilter version="1.0">
        <filter root="/conf/wknd-spa-angular" mode="merge"/>
        <filter root="/content/wknd-spa-angular" mode="merge"/>
        <filter root="/content/dam/wknd-spa-angular" mode="merge"/>
        <filter root="/content/experience-fragments/wknd-spa-angular" mode="merge"/>
    </workspaceFilter>
   ```

   The `filter.xml` filen ansvarar för att identifiera sökvägarna till de noder som installeras med paketet. Lägg märke till `mode="merge"` på vart och ett av filtren som anger att befintligt innehåll inte kommer att ändras, läggs endast nytt innehåll till. Eftersom innehållsförfattare kan uppdatera dessa sökvägar är det viktigt att en koddistribution gör det **not** skriva över innehåll. Se [FileVault-dokumentation](https://jackrabbit.apache.org/filevault/filter.html) för mer information om hur du arbetar med filterelement.

   Jämför `ui.content/src/main/content/META-INF/vault/filter.xml` och `ui.apps/src/main/content/META-INF/vault/filter.xml` för att förstå de olika noder som hanteras av varje modul.
