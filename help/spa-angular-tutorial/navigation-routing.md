---
title: Lägga till navigering och routning | Komma igång med AEM SPA-redigerare och vinkelrät
description: Lär dig hur flera vyer i SPA stöds med AEM sidor och SPA Editor SDK. Dynamisk navigering implementeras med hjälp av vinkelvägar och läggs till i en befintlig Header-komponent.
sub-product: platser
feature: SPA Editor
topics: development
doc-type: tutorial
version: cloud-service
activity: develop
audience: developer
kt: 5312
thumbnail: 5312-spa-angular.jpg
translation-type: tm+mt
source-git-commit: e99779b5d42bb9a3b258e2bbe815defde9d40bf7
workflow-type: tm+mt
source-wordcount: '2643'
ht-degree: 0%

---


# Lägga till navigering och routning {#navigation-routing}

Lär dig hur flera vyer i SPA stöds med AEM sidor och SPA Editor SDK. Dynamisk navigering implementeras med hjälp av vinkelvägar och läggs till i en befintlig Header-komponent.

## Syfte

1. Förstå de alternativ för SPA-modellroutning som är tillgängliga när du använder SPA-redigeraren.
2. Lär dig att använda [vinkelroutning](https://angular.io/guide/router) för att navigera mellan olika vyer av SPA.
3. Implementera en dynamisk navigering som styrs av AEM sidhierarki.

## Vad du ska bygga

I det här kapitlet läggs en navigeringsmeny till i en befintlig `Header` komponent. Navigeringsmenyn styrs av AEM sidhierarki och använder den JSON-modell som finns i [navigeringskärnkomponenten](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html).

![Navigering har implementerats](assets/navigation-routing/final-navigation-implemented.gif)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Hämta koden

1. Hämta startpunkten för den här självstudiekursen via Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
   $ cd aem-guides-wknd-spa
   $ git checkout Angular/navigation-routing-start
   ```

2. Distribuera kodbasen till en lokal AEM med Maven:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Om du använder [AEM 6.x](overview.md#compatibility) lägger du till `classic` profilen:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

3. Installera det färdiga paketet för den traditionella [WKND-referensplatsen](https://github.com/adobe/aem-guides-wknd/releases/latest). Bilderna som tillhandahålls av [WKND-referenswebbplatsen](https://github.com/adobe/aem-guides-wknd/releases/latest) kommer att återanvändas i WKND SPA. Paketet kan installeras med [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp).

   ![Package Manager install wknd.all](./assets/map-components/package-manager-wknd-all.png)

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/navigation-routing-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/navigation-routing-solution`.

## Inspect HeaderComponent - uppdateringar {#inspect-header}

I tidigare kapitel lades `HeaderComponent` komponenten till som en ren vinkelkomponent som inkluderades via `app.component.html`. I det här kapitlet tas `HeaderComponent` komponenten bort från programmet och läggs till via [mallredigeraren](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/template-editor-feature-video-use.html). Detta gör att användare kan konfigurera navigeringsmenyn för `HeaderComponent` i AEM.

>[!NOTE]
>
> Flera CSS- och JavaScript-uppdateringar har redan gjorts i kodbasen för att starta det här kapitlet. Om du vill fokusera på kärnkoncept beskrivs inte **alla** kodändringar. Du kan se de fullständiga ändringarna [här](https://github.com/adobe/aem-guides-wknd-spa/compare/Angular/map-components-solution...Angular/navigation-routing-start).

1. I den IDE du väljer öppnar du SPA-startprojektet för det här kapitlet.
2. Under `ui.frontend` modulen inspekterar du filen `header.component.ts` på: `ui.frontend/src/app/components/header/header.component.ts`.

   Flera uppdateringar har gjorts, bland annat tillägg av en `HeaderEditConfig` och en `MapTo` för att komponenten ska kunna mappas till en AEM `wknd-spa-angular/components/header`.

   ```js
   /* header.component.ts */
   ...
   const HeaderEditConfig = {
       ...
   };
   
   @Component({
   selector: 'app-header',
   templateUrl: './header.component.html',
   styleUrls: ['./header.component.scss']
   })
   export class HeaderComponent implements OnInit {
   @Input() items: object[];
       ...
   }
   ...
   MapTo('wknd-spa-angular/components/header')(withRouter(Header), HeaderEditConfig);
   ```

   Anteckna anteckningen `@Input()` för `items`. `items` innehåller en array med navigeringsobjekt som skickas från AEM.

3. I modulen `ui.apps` Granska komponentdefinitionen för den AEM `Header` komponenten: `ui.apps/src/main/content/jcr_root/apps/wknd-spa-angular/components/header/.content.xml`:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Header"
       sling:resourceSuperType="wknd-spa-angular/components/navigation"
       componentGroup="WKND SPA Angular - Structure"/>
   ```

   Den AEM `Header` komponenten ärver alla funktioner i [Navigation Core-komponenten](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html) via `sling:resourceSuperType` -egenskapen.

## Lägg till HeaderComponent i SPA-mallen {#add-header-template}

1. Öppna en webbläsare och logga in på AEM, [http://localhost:4502/](http://localhost:4502/). Startkodbasen ska redan distribueras.
2. Navigera till **[!UICONTROL SPA Page Template]**: [http://localhost:4502/editor.html/conf/wknd-spa-angular/settings/wcm/templates/spa-page-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-angular/settings/wcm/templates/spa-page-template/structure.html).
3. Markera den yttre **[!UICONTROL Root Layout Container]** och klicka på dess **[!UICONTROL Policy]** ikon. Var försiktig så att du **inte** markerar den ej låsta **[!UICONTROL Layout Container]** färgen för redigering.

   ![Välj ikon för rotlayoutbehållarprincipen](assets/navigation-routing/root-layout-container-policy.png)

4. Kopiera den aktuella profilen och skapa en ny profil med namnet **[!UICONTROL SPA Structure]**:

   ![SPA-strukturprincip](assets/map-components/spa-policy-update.png)

   Under **[!UICONTROL Allowed Components]** > **[!UICONTROL General]** > markerar du **[!UICONTROL Layout Container]** komponenten.

   Under **[!UICONTROL Allowed Components]** > **[!UICONTROL WKND SPA ANGULAR - STRUCTURE]** > markerar du **[!UICONTROL Header]** komponenten:

   ![Markera rubrikkomponent](assets/map-components/select-header-component.png)

   Under **[!UICONTROL Allowed Components]** > **[!UICONTROL WKND SPA ANGULAR - Content]** > markerar du **[!UICONTROL Image]** och **[!UICONTROL Text]** komponenter. Du bör välja totalt 4 komponenter.

   Click **[!UICONTROL Done]** to save the changes.

5. **Uppdatera** sidan. Lägg till **[!UICONTROL Header]** komponenten ovanför det olåsta **[!UICONTROL Layout Container]**:

   ![lägg till rubrikkomponent i mall](./assets/navigation-routing/add-header-component.gif)

6. Markera **[!UICONTROL Header]** komponenten och klicka på **Policy** -ikonen för att redigera profilen.

   ![Klicka på Huvudprincip](assets/navigation-routing/header-policy-icon.png)

7. Skapa en ny profil med ett **[!UICONTROL Policy Title]** av **&quot;WKND SPA Header&quot;**.

   Under **[!UICONTROL Properties]**:

   * Ställ in **[!UICONTROL Navigation Root]** på `/content/wknd-spa-angular/us/en`.
   * Ställ in **[!UICONTROL Exclude Root Levels]** på **1**.
   * Avmarkera **[!UICONTROL Collect al child pages]**.
   * Ställ in **[!UICONTROL Navigation Structure Depth]** på **3**.

   ![Konfigurera huvudprincip](assets/navigation-routing/header-policy.png)

   Då samlas navigeringen 2 nivåer under `/content/wknd-spa-angular/us/en`.

8. När du har sparat ändringarna bör du se det ifyllda `Header` som en del av mallen:

   ![Komponent för fyllt sidhuvud](assets/navigation-routing/populated-header.png)

## Skapa underordnade sidor

Skapa sedan ytterligare sidor i AEM som ska fungera som olika vyer i SPA. Vi kommer också att inspektera den hierarkiska strukturen i JSON-modellen som AEM tillhandahåller.

1. Gå till **Sites** Console: [http://localhost:4502/sites.html/content/wknd-spa-angular/us/en/home](http://localhost:4502/sites.html/content/wknd-spa-angular/us/en/home). Markera startsidan för **WKND SPA Angular** och klicka på **[!UICONTROL Create]** > **[!UICONTROL Page]**:

   ![Skapa ny sida](assets/navigation-routing/create-new-page.png)

2. Under **[!UICONTROL Template]** select **[!UICONTROL SPA Page]**. Under **[!UICONTROL Properties]** Skriv **&quot;Sida 1&quot;** som **[!UICONTROL Title]** namn och **&quot;sida-1&quot;** .

   ![Ange egenskaper för den inledande sidan](assets/navigation-routing/initial-page-properties.png)

   Klicka på **[!UICONTROL Create]** och klicka på i dialogrutan **[!UICONTROL Open]** för att öppna sidan i AEM SPA-redigeraren.

3. Lägg till en ny **[!UICONTROL Text]** komponent i huvudkomponenten **[!UICONTROL Layout Container]**. Redigera komponenten och ange texten: **&quot;Sidan 1&quot;** med RTE och **H1** -elementet (du måste ange helskärmsläge för att ändra styckeelementen)

   ![Exempel på innehåll, sida 1](assets/navigation-routing/page-1-sample-content.png)

   Du kan lägga till ytterligare innehåll, som en bild.

4. Gå tillbaka till AEM Sites-konsolen och upprepa stegen ovan och skapa en andra sida med namnet **&quot;Sida 2&quot;** som motsvarar **sidan 1**. Lägg till innehåll på **sidan 2** så att det blir lätt att identifiera.
5. Skapa slutligen en tredje sida, **&quot;Sidan 3&quot;** , men som **underordnad** till **sidan 2**. När webbplatshierarkin är klar ska den se ut så här:

   ![Exempel på webbplatshierarki](assets/navigation-routing/wknd-spa-sample-site-hierarchy.png)

6. På en ny flik öppnar du JSON-modell-API:t från AEM: [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json). Detta JSON-innehåll begärs när SPA läses in för första gången. Den yttre strukturen ser ut så här:

   ```json
   {
   "language": "en",
   "title": "en",
   "templateName": "spa-app-template",
   "designPath": "/libs/settings/wcm/designs/default",
   "cssClassNames": "spa page basicpage",
   ":type": "wknd-spa-angular/components/spa",
   ":items": {},
   ":itemsOrder": [],
   ":hierarchyType": "page",
   ":path": "/content/wknd-spa-angular/us/en",
   ":children": {
       "/content/wknd-spa-angular/us/en/home": {},
       "/content/wknd-spa-angular/us/en/home/page-1": {},
       "/content/wknd-spa-angular/us/en/home/page-2": {},
       "/content/wknd-spa-angular/us/en/home/page-2/page-3": {}
       }
   }
   ```

   Under `:children` den finns en post för varje sida som skapas. Innehållet för alla sidor finns i den här inledande JSON-begäran. När navigeringsflödet har implementerats läses efterföljande vyer av SPA in snabbt eftersom innehållet redan är tillgängligt på klientsidan.

   Det är inte klokt att läsa in **ALL** i innehållet i en SPA i den inledande JSON-begäran eftersom det skulle göra den inledande sidinläsningen långsammare. Nu ska vi titta på hur sidornas hierarkiska djup samlas in.

7. Gå till **SPA-rotmallen** på: [http://localhost:4502/editor.html/conf/wknd-spa-angular/settings/wcm/templates/spa-app-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-angular/settings/wcm/templates/spa-app-template/structure.html).

   Klicka på **[!UICONTROL Page properties menu]** > **[!UICONTROL Page Policy]**:

   ![Öppna sidprincipen för SPA-roten](assets/navigation-routing/open-page-policy.png)

8. Mallen **SPA-rot** har en extra **[!UICONTROL Hierarchical Structure]** flik som styr det JSON-innehåll som samlas in. Här **[!UICONTROL Structure Depth]** anges hur djupt i platshierarkin underordnade sidor ska samlas under **roten**. Du kan också använda **[!UICONTROL Structure Patterns]** fältet för att filtrera bort ytterligare sidor baserat på ett reguljärt uttryck.

   Uppdatera **[!UICONTROL Structure Depth]** till **&quot;2&quot;**:

   ![Uppdatera strukturdjup](assets/navigation-routing/update-structure-depth.png)

   Klicka **[!UICONTROL Done]** för att spara ändringarna i profilen.

9. Öppna JSON-modellen [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json)igen.

   ```json
   {
   "language": "en",
   "title": "en",
   "templateName": "spa-app-template",
   "designPath": "/libs/settings/wcm/designs/default",
   "cssClassNames": "spa page basicpage",
   ":type": "wknd-spa-angular/components/spa",
   ":items": {},
   ":itemsOrder": [],
   ":hierarchyType": "page",
   ":path": "/content/wknd-spa-angular/us/en",
   ":children": {
       "/content/wknd-spa-angular/us/en/home": {},
       "/content/wknd-spa-angular/us/en/home/page-1": {},
       "/content/wknd-spa-angular/us/en/home/page-2": {}
       }
   }
   ```

   Observera att sökvägen till **sidan 3** har tagits bort: `/content/wknd-spa-angular/us/en/home/page-2/page-3` från den ursprungliga JSON-modellen.

   Senare kommer vi att se hur AEM SDK för SPA-redigeraren dynamiskt kan läsa in ytterligare innehåll.

## Implementera navigeringen

Implementera sedan navigeringsmenyn med en ny `NavigationComponent`. Vi kan lägga till koden direkt i `header.component.html` men det är bättre att undvika stora komponenter. Implementera i stället en `NavigationComponent` som kan återanvändas senare.

1. Granska den JSON som visas av AEM `Header` komponent på [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json):

   ```json
   ...
   "header": {
       "items": [
       {
       "level": 0,
       "active": true,
       "path": "/content/wknd-spa-angular/us/en/home",
       "description": null,
       "url": "/content/wknd-spa-angular/us/en/home.html",
       "lastModified": 1589062597083,
       "title": "WKND SPA Angular Home Page",
       "children": [
               {
               "children": [],
               "level": 1,
               "active": false,
               "path": "/content/wknd-spa-angular/us/en/home/page-1",
               "description": null,
               "url": "/content/wknd-spa-angular/us/en/home/page-1.html",
               "lastModified": 1589429385100,
               "title": "Page 1"
               },
               {
               "level": 1,
               "active": true,
               "path": "/content/wknd-spa-angular/us/en/home/page-2",
               "description": null,
               "url": "/content/wknd-spa-angular/us/en/home/page-2.html",
               "lastModified": 1589429603507,
               "title": "Page 2",
               "children": [
                   {
                   "children": [],
                   "level": 2,
                   "active": false,
                   "path": "/content/wknd-spa-angular/us/en/home/page-2/page-3",
                   "description": null,
                   "url": "/content/wknd-spa-angular/us/en/home/page-2/page-3.html",
                   "lastModified": 1589430413831,
                   "title": "Page 3"
                   }
               ],
               }
           ]
           }
       ],
   ":type": "wknd-spa-angular/components/header"
   ```

   De AEM sidornas hierarkiska karaktär modelleras i JSON som kan användas för att fylla i en navigeringsmeny. Kom ihåg att `Header` komponenten ärver alla funktioner i [Navigation Core Component](https://www.aemcomponents.dev/content/core-components-examples/library/templating/navigation.html) och att innehållet som exponeras via JSON automatiskt mappas till vinkelanteckningen `@Input` .

2. Öppna ett nytt terminalfönster och navigera till `ui.frontend` mappen för SPA-projektet. Skapa ett nytt `NavigationComponent` med det vinkelformade CLI-verktyget:

   ```shell
   $ cd ui.frontend
   $ ng generate component components/navigation
   CREATE src/app/components/navigation/navigation.component.scss (0 bytes)
   CREATE src/app/components/navigation/navigation.component.html (25 bytes)
   CREATE src/app/components/navigation/navigation.component.spec.ts (656 bytes)
   CREATE src/app/components/navigation/navigation.component.ts (286 bytes)
   UPDATE src/app/app.module.ts (2032 bytes)
   ```

3. Skapa sedan en klass med namnet `NavigationLink` med hjälp av Angular CLI i den nya `components/navigation` katalogen:

   ```shell
   $ cd src/app/components/navigation/
   $ ng generate class NavigationLink
   CREATE src/app/components/navigation/navigation-link.spec.ts (187 bytes)
   CREATE src/app/components/navigation/navigation-link.ts (32 bytes)
   ```

4. Gå tillbaka till den utvecklingsmiljö du valt och öppna filen på `navigation-link.ts` `/src/app/components/navigation/navigation-link.ts`.

   ![Öppna filen navigation-link.ts](assets/navigation-routing/ide-navigation-link-file.png)

5. Fyll `navigation-link.ts` med följande:

   ```js
   export class NavigationLink {
   
       title: string;
       path: string;
       url: string;
       level: number;
       children: NavigationLink[];
       active: boolean;
   
       constructor(data) {
           this.path = data.path;
           this.title = data.title;
           this.url = data.url;
           this.level = data.level;
           this.active = data.active;
           this.children = data.children.map( item => {
               return new NavigationLink(item);
           });
       }
   }
   ```

   Det här är en enkel klass som representerar en enskild navigeringslänk. I klasskonstruktorn förväntar vi `data` att vara det JSON-objekt som skickas från AEM. Den här klassen används både i `NavigationComponent` och `HeaderComponent` för att enkelt fylla i navigeringsstrukturen.

   Ingen dataomvandling utförs, den här klassen skapas främst för att skriva JSON-modellen med hög kvalitet. Observera att `this.children` skrivs som `NavigationLink[]` och att konstruktorn skapar nya `NavigationLink` objekt rekursivt för varje objekt i `children` arrayen. Kom ihåg att JSON-modellen för `Header` är hierarkisk.

6. Open the file `navigation-link.spec.ts`. Det här är testfilen för `NavigationLink` klassen. Uppdatera den med följande:

   ```js
   import { NavigationLink } from './navigation-link';
   
   describe('NavigationLink', () => {
       it('should create an instance', () => {
           const data = {
               children: [],
               level: 1,
               active: false,
               path: '/content/wknd-spa-angular/us/en/home/page-1',
               description: null,
               url: '/content/wknd-spa-angular/us/en/home/page-1.html',
               lastModified: 1589429385100,
               title: 'Page 1'
           };
           expect(new NavigationLink(data)).toBeTruthy();
       });
   });
   ```

   Observera att `const data` följer samma JSON-modell som tidigare inspekterats för en enda länk. Detta är långt ifrån ett robust enhetstest, men det bör räcka att testa konstruktorn för `NavigationLink`.

7. Open the file `navigation.component.ts`. Uppdatera den med följande:

   ```js
   import { Component, OnInit, Input } from '@angular/core';
   import { NavigationLink } from './navigation-link';
   
   @Component({
   selector: 'app-navigation',
   templateUrl: './navigation.component.html',
   styleUrls: ['./navigation.component.scss']
   })
   export class NavigationComponent implements OnInit {
   
       @Input() items: object[];
   
       constructor() { }
   
       get navigationLinks(): NavigationLink[] {
   
           if (this.items && this.items.length > 0) {
               return this.items.map(item => {
                   return new NavigationLink(item);
               });
           }
   
           return null;
       }
   
       ngOnInit() {}
   
   }
   ```

   `NavigationComponent` förväntar sig ett `object[]` namn `items` som är JSON-modellen från AEM. Den här klassen visar en enda metod `get navigationLinks()` som returnerar en array med `NavigationLink` objekt.

8. Öppna filen `navigation.component.html` och uppdatera den med följande:

   ```html
   <ul *ngIf="navigationLinks && navigationLinks.length > 0" class="navigation__group">
       <ng-container *ngTemplateOutlet="recursiveListTmpl; context:{ links: navigationLinks }"></ng-container>
   </ul>
   ```

   Detta genererar en initial `<ul>` och anropar `get navigationLinks()` metoden från `navigation.component.ts`. En `<ng-container>` används för att göra ett anrop till en mall med namnet `recursiveListTmpl` och skickar den `navigationLinks` som en variabel med namnet `links`.

   Lägg till `recursiveListTmpl` nästa:

   ```html
   <ng-template #recursiveListTmpl let-links="links">
       <li *ngFor="let link of links" class="{{'navigation__item navigation__item--' + link.level}}">
           <a [routerLink]="link.url" class="navigation__item-link" [title]="link.title" [attr.aria-current]="link.active">
               {{link.title}}
           </a>
           <ul *ngIf="link.children && link.children.length > 0">
               <ng-container *ngTemplateOutlet="recursiveListTmpl; context:{ links: link.children }"></ng-container>
           </ul>
       </li>
   </ng-template>
   ```

   Här implementeras resten av återgivningen för navigeringslänken. Observera att variabeln `link` är av typen `NavigationLink` och att alla metoder/egenskaper som skapas av den klassen är tillgängliga. [`[routerLink]`](https://angular.io/api/router/RouterLink) används i stället för normalt `href` attribut. Det gör att vi kan länka till specifika vägar i appen utan att behöva uppdatera hela sidan.

   Den rekursiva delen av navigeringen implementeras också genom att skapa en annan `<ul>` om den aktuella `link` har en `children` array som inte är tom.

9. Uppdatera `navigation.component.spec.ts` för att lägga till stöd för `RouterTestingModule`:

   ```diff
    ...
   + import { RouterTestingModule } from '@angular/router/testing';
    ...
    beforeEach(async(() => {
       TestBed.configureTestingModule({
   +   imports: [ RouterTestingModule ],
       declarations: [ NavigationComponent ]
       })
       .compileComponents();
    }));
    ...
   ```

   Du måste lägga till `RouterTestingModule` filen eftersom komponenten använder `[routerLink]`.

10. Uppdatera `navigation.component.scss` för att lägga till några grundläggande format i `NavigationComponent`:

   ```scss
   @import "~src/styles/variables";
   
   $link-color: $black;
   $link-hover-color: $white;
   $link-background: $black;
   
   :host-context {
       display: block;
       width: 100%;
   }
   
   .navigation__item {
       list-style: none;
   }
   
   .navigation__item-link {
       color: $link-color;
       font-size: $font-size-large;
       text-transform: uppercase;
       padding: $gutter-padding;
       display: flex;
       border-bottom: 1px solid $gray;
   
       &:hover {
           background: $link-background;
           color: $link-hover-color;
       }
   
   }
   ```

## Uppdatera sidhuvudskomponenten

Nu när programmet `NavigationComponent` har implementerats `HeaderComponent` måste det uppdateras för att referera till det.

1. Öppna en terminal och navigera till `ui.frontend` mappen i SPA-projektet. Starta **webbpaketets dev-server**:

   ```shell
   $ npm start
   ```

2. Öppna en webbläsarflik och gå till [http://localhost:4200/](http://localhost:4200/).

   Webbpaketets **dev-server** bör konfigureras att proxyansluta JSON-modellen från en lokal instans av AEM (`ui.frontend/proxy.conf.json`). Detta gör att vi kan koda direkt mot innehåll som skapats i AEM från tidigare kurser.

   ![menyväxla till/från](./assets/navigation-routing/nav-toggle-static.gif)

   Menyalternativfunktionen är redan implementerad `HeaderComponent` för tillfället. Lägg sedan till navigeringskomponenten.

3. Gå tillbaka till den utvecklingsmiljö du vill använda och öppna filen `header.component.ts` på `ui.frontend/src/app/components/header/header.component.ts`.
4. Uppdatera `setHomePage()` metoden för att ta bort den hårdkodade strängen och använda de dynamiska förskjutningar som skickas av AEM:

   ```js
   /* header.component.ts */
   import { NavigationLink } from '../navigation/navigation-link';
   ...
    setHomePage() {
       if (this.hasNavigation) {
           const rootNavigationLink: NavigationLink = new NavigationLink(this.items[0]);
           this.isHome = rootNavigationLink.path === this.route.snapshot.data.path;
           this.homePageUrl = rootNavigationLink.url;
       }
   }
   ...
   ```

   En ny instans av `NavigationLink` skapas baserat på `items[0]`roten för den JSON-navigeringsmodell som skickas från AEM. `this.route.snapshot.data.path` returnerar den aktuella vinkelruttens sökväg. Det här värdet används för att avgöra om det aktuella flödet är **hemsidan**. `this.homePageUrl` används för att fylla i ankarlänken på **logotypen**.

5. Öppna `header.component.html` och ersätt den statiska platshållaren för navigeringen med en referens till den nyskapade `NavigationComponent`:

   ```diff
       <div class="header-navigation">
           <div class="navigation">
   -            Navigation Placeholder
   +           <app-navigation [items]="items"></app-navigation>
           </div>
       </div>
   ```

   `[items]=items` -attributet skickar `@Input() items` från `HeaderComponent` till den `NavigationComponent` plats där navigeringen ska skapas.

6. Öppna `header.component.spec.ts` och lägg till en deklaration för `NavigationComponent`:

   ```diff
       /* header.component.spect.ts */
   +   import { NavigationComponent } from '../navigation/navigation.component';
   
       describe('HeaderComponent', () => {
       let component: HeaderComponent;
       let fixture: ComponentFixture<HeaderComponent>;
   
       beforeEach(async(() => {
           TestBed.configureTestingModule({
           imports: [ RouterTestingModule ],
   +       declarations: [ HeaderComponent, NavigationComponent ]
           })
           .compileComponents();
       }));
   ```

   Eftersom testämnet nu `NavigationComponent` används som en del av `HeaderComponent` måste det deklareras som en del av testbädden.

7. Spara ändringar i alla öppna filer och gå tillbaka till **webbpaketets dev-server**: [http://localhost:4200/](http://localhost:4200/)

   ![Slutförd rubriknavigering](assets/navigation-routing/completed-header.png)

   Öppna navigeringen genom att klicka på menyväxlingsknappen så visas de ifyllda navigeringslänkarna. Du bör kunna navigera till olika vyer av SPA.

## Förstå SPA-routning

Nu när navigeringen har implementerats inspekterar du routningen i AEM.

1. I IDE öppnar du filen `app-routing.module.ts` på `ui.frontend/src/app`.

   ```js
   /* app-routing.module.ts */
   import { AemPageDataResolver, AemPageRouteReuseStrategy } from '@adobe/cq-angular-editable-components';
   import { NgModule } from '@angular/core';
   import { RouteReuseStrategy, RouterModule, Routes, UrlMatchResult, UrlSegment } from '@angular/router';
   import { PageComponent } from './components/page/page.component';
   
   export function AemPageMatcher(url: UrlSegment[]): UrlMatchResult {
       if (url.length) {
           return {
               consumed: url,
               posParams: {
                   path: url[url.length - 1]
               }
           };
       }
   }
   
   const routes: Routes = [
       {
           matcher: AemPageMatcher,
           component: PageComponent,
           resolve: {
               path: AemPageDataResolver
           }
       }
   ];
   @NgModule({
       imports: [RouterModule.forRoot(routes)],
       exports: [RouterModule],
       providers: [
           AemPageDataResolver,
           {
           provide: RouteReuseStrategy,
           useClass: AemPageRouteReuseStrategy
           }
       ]
   })
   export class AppRoutingModule {}
   ```

   Arrayen definierar vägar eller navigeringssökvägar till vinkelkomponentmappningar. `routes: Routes = [];`

   `AemPageMatcher` är en anpassad Angular-router [UrlMatcher](https://angular.io/api/router/UrlMatcher)som matchar allt som &quot;ser ut som&quot; en sida i AEM som är en del av det här vinkelprogrammet.

   `PageComponent` är den vinkelkomponent som representerar en sida i AEM och de matchande vägarna aktiveras. Kontrollen `PageComponent` kommer att genomföras ytterligare.

   `AemPageDataResolver`, som tillhandahålls av AEM JS SDK för SPA-redigeraren, är en anpassad [vinkelrouterlösare](https://angular.io/api/router/Resolve) som används för att omforma rutt-URL:en, som är sökvägen i AEM inklusive tillägget .html, till resurssökvägen i AEM, som är sidsökvägen minus tillägget.

   Ett exempel är att `AemPageDataResolver` omformningen av ett flödes URL-adress `content/wknd-spa-angular/us/en/home.html` till en sökväg `/content/wknd-spa-angular/us/en/home`. Detta används för att matcha sidans innehåll baserat på sökvägen i JSON-modellens API.

   `AemPageRouteReuseStrategy`, som tillhandahålls av AEM SPA Editor JS SDK, är en anpassad [RouteReuseStrategy](https://angular.io/api/router/RouteReuseStrategy) som förhindrar återanvändning av `PageComponent` rutterna. Annars kan innehåll från sidan &quot;A&quot; visas vid navigering till sidan &quot;B&quot;.

2. Öppna filen `page.component.ts` på `ui.frontend/src/app/components/page/`.

   ```js
   ...
   export class PageComponent {
       items;
       itemsOrder;
       path;
   
       constructor(
           private route: ActivatedRoute,
           private modelManagerService: ModelManagerService
       ) {
           this.modelManagerService
           .getData({ path: this.route.snapshot.data.path })
           .then(data => {
               this.path = data[Constants.PATH_PROP];
               this.items = data[Constants.ITEMS_PROP];
               this.itemsOrder = data[Constants.ITEMS_ORDER_PROP];
           });
       }
   }
   ```

   Den `PageComponent` krävs för att bearbeta den JSON som hämtats från AEM och används som vinkelkomponent för att återge rutterna.

   `ActivatedRoute`, som tillhandahålls av modulen Vinkelrouter, innehåller läget som anger vilket AEM sidans JSON-innehåll som ska läsas in i den här instansen av komponenten för vinkelsideskomponenten.

   `ModelManagerService`, hämtar JSON-data baserat på vägen och mappar data till klassvariablerna `path`, `items`, `itemsOrder`. Dessa skickas sedan till [AEMPageComponent](https://www.npmjs.com/package/@adobe/cq-angular-editable-components#aempagecomponent.md)

3. Öppna filen `page.component.html` på `ui.frontend/src/app/components/page/`

   ```html
   <aem-page 
       class="structure-page" 
       [attr.data-cq-page-path]="path" 
       [cqPath]="path" 
       [cqItems]="items" 
       [cqItemsOrder]="itemsOrder">
   </aem-page>
   ```

   `aem-page` innehåller [AEMPageComponent](https://www.npmjs.com/package/@adobe/cq-angular-editable-components#aempagecomponent.md). Variablerna `path`, `items`och `itemsOrder` skickas till `AEMPageComponent`. De `AemPageComponent`som tillhandahålls via JavaScript SDK:er i SPA-redigeraren itererar sedan över dessa data och instansierar dynamiskt vinkelkomponenter baserat på JSON-data som visas i självstudiekursen [för](./map-components.md)kartkomponenter.

   Det `PageComponent` är egentligen bara en proxy för `AEMPageComponent` och det är `AEMPageComponent` den som gör huvuddelen av det tunga lyftet för att korrekt mappa JSON-modellen till vinkelkomponenterna.

## Inspect SPA-routning i AEM

1. Öppna en terminal och stoppa **webbpaketets dev-server** om den startas. Navigera till projektets rot och distribuera projektet till AEM med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!CAUTION]
   >
   > Vissa mycket strikta lintingregler är aktiverade i det vinkelbaserade projektet. Om det inte går att skapa Maven kontrollerar du felet och söker efter **Lint-fel i de listade filerna.**. Åtgärda eventuella fel som uppstått vid markören och kör kommandot Maven igen.

2. Gå till SPA-startsidan i AEM: [http://localhost:4502/content/wknd-spa-angular/us/en/home.html](http://localhost:4502/content/wknd-spa-angular/us/en/home.html) och öppna utvecklarverktygen i webbläsaren. Skärmbilder nedan hämtas från webbläsaren Google Chrome.

   Uppdatera sidan så ser du en XHR-begäran `/content/wknd-spa-angular/us/en.model.json`som är SPA-roten. Observera att endast tre underordnade sidor inkluderas baserat på hierarkidjupets konfiguration till SPA-rotmallen som skapades tidigare i självstudiekursen. Detta inkluderar inte **sidan 3**.

   ![Initial JSON-begäran - SPA-rot](assets/navigation-routing/initial-json-request.png)

3. Gå till **sidan 3** när utvecklingsverktygen är öppna:

   ![Sidan 3 navigera](assets/navigation-routing/page-three-navigation.png)

   Observera att en ny XHR-begäran görs till: `/content/wknd-spa-angular/us/en/home/page-2/page-3.model.json`

   ![Sida tre XHR-begäran](assets/navigation-routing/page-3-xhr-request.png)

   AEM Modellhanteraren inser att JSON-innehållet på **sidan 3** inte är tillgängligt och utlöser automatiskt den ytterligare XHR-begäran.

4. Fortsätt navigera i SPA med de olika navigeringslänkarna. Observera att inga ytterligare XHR-begäranden görs och att inga fullständiga siduppdateringar görs. Detta gör att SPA-avtalet blir snabbt för slutanvändaren och minskar antalet onödiga förfrågningar som skickas tillbaka till AEM.

   ![Navigering har implementerats](assets/navigation-routing/final-navigation-implemented.gif)

5. Experimentera med länkar genom att navigera direkt till: [http://localhost:4502/content/wknd-spa-angular/us/en/home/page-2.html](http://localhost:4502/content/wknd-spa-angular/us/en/home/page-2.html). Observera att webbläsarens bakåtknapp fortsätter att fungera.

## Grattis! {#congratulations}

Grattis! Du har lärt dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering har implementerats med hjälp av vinkelroutning och lagts till i `Header` komponenten.

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/navigation-routing-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/navigation-routing-solution`.

### Nästa steg {#next-steps}

[Skapa en anpassad komponent](custom-component.md) - Lär dig hur du skapar en anpassad komponent som ska användas med AEM SPA-redigeraren. Lär dig hur du utvecklar redigeringsdialogrutor och Sling-modeller för att utöka JSON-modellen så att den fyller i en anpassad komponent.
