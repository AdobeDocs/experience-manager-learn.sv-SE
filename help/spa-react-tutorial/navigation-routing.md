---
title: Lägga till navigering och routning | Komma igång med AEM SPA Editor och React
description: Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med React Router och läggs till i en befintlig Header-komponent.
sub-product: platser
feature: SPA Editor
topics: development
version: cloud-service
activity: develop
audience: developer
kt: 4988
thumbnail: 4988-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '2117'
ht-degree: 0%

---


# Lägga till navigering och routning {#navigation-routing}

Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med React Router och läggs till i en befintlig Header-komponent.

## Syfte

1. Förstå de alternativ för SPA modellroutning som är tillgängliga när du använder SPA Editor.
1. Lär dig att använda [Reaktionsrouter](https://reacttraining.com/react-router/) för att navigera mellan olika vyer av SPA.
1. Implementera en dynamisk navigering som styrs av AEM sidhierarki.

## Vad du ska bygga

I det här kapitlet läggs en navigeringsmeny till i en befintlig `Header`-komponent. Navigeringsmenyn styrs av AEM sidhierarki och den JSON-modell som finns i [Navigation Core Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html) används.

![Navigering har implementerats](assets/navigation-routing/final-navigation-implemented.gif)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Hämta koden

1. Hämta startpunkten för den här självstudiekursen via Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
   $ cd aem-guides-wknd-spa
   $ git checkout React/navigation-routing-start
   ```

1. Distribuera kodbasen till en lokal AEM med Maven:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Om du använder [AEM 6.x](overview.md#compatibility) lägger du till profilen `classic`:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

1. Installera det färdiga paketet för den traditionella [WKND-referensplatsen](https://github.com/adobe/aem-guides-wknd/releases/latest). Bilderna som tillhandahålls av [WKND-referensplatsen](https://github.com/adobe/aem-guides-wknd/releases/latest) kommer att återanvändas i WKND-SPA. Paketet kan installeras med [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp).

   ![Package Manager install wknd.all](./assets/map-components/package-manager-wknd-all.png)

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/navigation-routing-solution) eller checka ut koden lokalt genom att växla till grenen `React/navigation-routing-solution`.

## Inspect Header-uppdateringar {#inspect-header}

I tidigare kapitel lades `Header`-komponenten till som en ren React-komponent som inkluderades via `App.js`. I det här kapitlet har `Header`-komponenten tagits bort och lagts till via [mallredigeraren](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/template-editor-feature-video-use.html). Detta gör att användare kan konfigurera navigeringsmenyn för `Header` inifrån AEM.

>[!NOTE]
>
> Flera CSS- och JavaScript-uppdateringar har redan gjorts i kodbasen för att starta det här kapitlet. Om du vill fokusera på kärnkoncept beskrivs inte **alla** kodändringar. Du kan visa de fullständiga ändringarna [här](https://github.com/adobe/aem-guides-wknd-spa/compare/React/map-components-solution...React/navigation-routing-start).

1. Öppna SPA startprojekt för det här kapitlet i den IDE du väljer.
1. Under `ui.frontend`-modulen undersöker du filen `Header.js` på: `ui.frontend/src/components/Header/Header.js`.

   Flera uppdateringar har gjorts, bland annat tillägg av en `HeaderEditConfig` och en `MapTo` som gör att komponenten kan mappas till en AEM `wknd-spa-react/components/header`-komponent.

   ```js
   /* Header.js */
   ...
   export const HeaderEditConfig = {
       ...
   }
   ...
   MapTo('wknd-spa-react/components/header')(withRouter(Header), HeaderEditConfig);
   ```

1. I modulen `ui.apps` kontrollerar du komponentdefinitionen för AEM `Header`-komponenten: `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components/header/.content.xml`:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Header"
       sling:resourceSuperType="wknd-spa-react/components/navigation"
       componentGroup="WKND SPA React - Structure"/>
   ```

   AEM `Header`-komponenten ärver alla funktioner i [Navigation Core Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html) via egenskapen `sling:resourceSuperType`.

## Lägg till sidhuvudet i mallen {#add-header-template}

1. Öppna en webbläsare och logga in på AEM, [http://localhost:4502/](http://localhost:4502/). Startkodbasen ska redan distribueras.
1. Navigera till **SPA sidmall**: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html).
1. Markera den yttre **rotlayoutbehållaren** och klicka på dess **profil**-ikon. Var försiktig **inte** med att välja **layoutbehållaren** som inte är låst för redigering.

   ![Välj ikon för rotlayoutbehållarprincipen](assets/navigation-routing/root-layout-container-policy.png)

1. Skapa en ny princip med namnet **SPA Struktur**:

   ![SPA](assets/navigation-routing/spa-policy-update.png)

   Under **Tillåtna komponenter** > **Allmänt** > väljer du komponenten **Layoutbehållare**.

   Under **Tillåtna komponenter** > **WKND SPA REACT - STRUKTUR** väljer du komponenten **Header**:

   ![Markera rubrikkomponent](assets/navigation-routing/select-header-component.png)

   Under **Tillåtna komponenter** > **WKND SPA REACT - Innehåll** > väljer du komponenterna **Bild** och **Text**. Du bör välja totalt 4 komponenter.

   Klicka på **Klar** för att spara ändringarna.

1. Uppdatera sidan och lägg till komponenten **Header** ovanför den olåsta **layoutbehållaren**:

   ![lägg till rubrikkomponent i mall](./assets/navigation-routing/add-header-component.gif)

1. Markera **Header**-komponenten och klicka på dess **Policy**-ikon för att redigera profilen.
1. Skapa en ny princip med **principtiteln** **WKND-SPA**.

   Under **Egenskaper**:

   * Ange **Navigeringsrot** till `/content/wknd-spa-react/us/en`.
   * Ange **Uteslut rotnivåer** till **1**.
   * Avmarkera **Samla in alla underordnade sidor**.
   * Ange **Navigeringsstrukturdjupet** till **3**.

   ![Konfigurera huvudprincip](assets/navigation-routing/header-policy.png)

   Detta samlar in navigeringen 2 nivåer under `/content/wknd-spa-react/us/en`.

1. När du har sparat ändringarna bör du se det ifyllda `Header` som en del av mallen:

   ![Komponent för fyllt sidhuvud](assets/navigation-routing/populated-header.png)

## Skapa underordnade sidor

Skapa sedan ytterligare sidor i AEM som ska fungera som de olika vyerna i SPA. Vi kommer också att inspektera den hierarkiska strukturen i JSON-modellen som AEM tillhandahåller.

1. Navigera till konsolen **Platser**: [http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home](http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home). Välj **WKND SPA React Home Page** och klicka på **Create** > **Sida**:

   ![Skapa ny sida](assets/navigation-routing/create-new-page.png)

1. Under **Mall** väljer du **SPA sida**. Under **Egenskaper** anger du **Sida 1** för **Rubriken** och **sida-1** som namn.

   ![Ange egenskaper för den inledande sidan](assets/navigation-routing/initial-page-properties.png)

   Klicka på **Skapa** och klicka på **Öppna** i popup-fönstret för att öppna sidan i AEM SPA.

1. Lägg till en ny **Text**-komponent i huvudbehållaren **Layoutbehållare**. Redigera komponenten och ange texten: **Sida 1** med RTE och elementet **H1** (du måste ange helskärmsläge för att ändra styckeelementen)

   ![Exempel på innehåll, sida 1](assets/navigation-routing/page-1-sample-content.png)

   Du kan lägga till ytterligare innehåll, som en bild.

1. Gå tillbaka till AEM Sites-konsolen och upprepa stegen ovan och skapa en andra sida med namnet **Sida 2** som en jämställd **sida 1**.
1. Skapa slutligen en tredje sida, **Sida 3**, men som **underordnad** av **sida 2**. När webbplatshierarkin är klar ska den se ut så här:

   ![Exempel på webbplatshierarki](assets/navigation-routing/wknd-spa-sample-site-hierarchy.png)

1. På en ny flik öppnar du JSON-modell-API:t från AEM: [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Detta JSON-innehåll begärs när SPA läses in första gången. Den yttre strukturen ser ut så här:

   ```json
   {
   "language": "en",
   "title": "en",
   "templateName": "spa-app-template",
   "designPath": "/libs/settings/wcm/designs/default",
   "cssClassNames": "spa page basicpage",
   ":type": "wknd-spa-react/components/spa",
   ":items": {},
   ":itemsOrder": [],
   ":hierarchyType": "page",
   ":path": "/content/wknd-spa-react/us/en",
   ":children": {
       "/content/wknd-spa-react/us/en/home": {},
       "/content/wknd-spa-react/us/en/home/page-1": {},
       "/content/wknd-spa-react/us/en/home/page-2": {},
       "/content/wknd-spa-react/us/en/home/page-2/page-3": {}
       }
   }
   ```

   Under `:children` ska du se en post för varje sida som skapas. Innehållet för alla sidor finns i den här inledande JSON-begäran. När navigeringsflödet har implementerats läses efterföljande vyer av SPA in snabbt eftersom innehållet redan är tillgängligt på klientsidan.

   Det är inte klokt att läsa in **ALL** för innehållet i en SPA i den inledande JSON-begäran eftersom det skulle göra den inledande sidinläsningen långsammare. Nu ska vi titta på hur sidornas hierarkiska djup samlas in.

1. Gå till mallen **SPA Root** på: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html).

   Klicka på menyn **Sidegenskaper** > **Sidprofil**:

   ![Öppna sidprincipen för SPA](assets/navigation-routing/open-page-policy.png)

1. Mallen **SPA Root** har en extra **hierarkisk struktur**-flik som styr det JSON-innehåll som samlas in. **Strukturdjupet** bestämmer hur djupt i platshierarkin underordnade sidor ska samlas under **roten**. Du kan också använda fältet **Strukturmönster** för att filtrera bort ytterligare sidor baserat på ett reguljärt uttryck.

   Uppdatera **strukturdjupet** till **2**:

   ![Uppdatera strukturdjup](assets/navigation-routing/update-structure-depth.png)

   Klicka på **Klar** för att spara ändringarna i profilen.

1. Öppna JSON-modellen [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json) igen.

   ```json
   {
   "language": "en",
   "title": "en",
   "templateName": "spa-app-template",
   "designPath": "/libs/settings/wcm/designs/default",
   "cssClassNames": "spa page basicpage",
   ":type": "wknd-spa-react/components/spa",
   ":items": {},
   ":itemsOrder": [],
   ":hierarchyType": "page",
   ":path": "/content/wknd-spa-react/us/en",
   ":children": {
       "/content/wknd-spa-react/us/en/home": {},
       "/content/wknd-spa-react/us/en/home/page-1": {},
       "/content/wknd-spa-react/us/en/home/page-2": {}
       }
   }
   ```

   Observera att sökvägen **Sida 3** har tagits bort: `/content/wknd-spa-react/us/en/home/page-2/page-3` från den inledande JSON-modellen.

   Senare kommer vi att se hur AEM SDK för redigeraren kan läsa in ytterligare innehåll dynamiskt.

## Implementera navigeringen

Implementera sedan navigeringsmenyn som en del av `Header`. Vi kan lägga till koden direkt i `Header.js`, men det är bättre att använda det här för att undvika stora komponenter. Istället implementerar vi en `Navigation`-SPA som kan återanvändas senare.

1. Granska den JSON som visas av AEM `Header`-komponenten på [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json):

   ```json
   ...
   "header": {
       "items": [
       {
       "level": 0,
       "active": true,
       "path": "/content/wknd-spa-react/us/en/home",
       "description": null,
       "url": "/content/wknd-spa-react/us/en/home.html",
       "lastModified": 1589062597083,
       "title": "WKND SPA React Home Page",
       "children": [
               {
               "children": [],
               "level": 1,
               "active": false,
               "path": "/content/wknd-spa-react/us/en/home/page-1",
               "description": null,
               "url": "/content/wknd-spa-react/us/en/home/page-1.html",
               "lastModified": 1589429385100,
               "title": "Page 1"
               },
               {
               "level": 1,
               "active": true,
               "path": "/content/wknd-spa-react/us/en/home/page-2",
               "description": null,
               "url": "/content/wknd-spa-react/us/en/home/page-2.html",
               "lastModified": 1589429603507,
               "title": "Page 2",
               "children": [
                   {
                   "children": [],
                   "level": 2,
                   "active": false,
                   "path": "/content/wknd-spa-react/us/en/home/page-2/page-3",
                   "description": null,
                   "url": "/content/wknd-spa-react/us/en/home/page-2/page-3.html",
                   "lastModified": 1589430413831,
                   "title": "Page 3"
                   }
               ],
               }
           ]
           }
       ],
   ":type": "wknd-spa-react/components/header"
   ```

   De AEM sidornas hierarkiska karaktär modelleras i JSON som kan användas för att fylla i en navigeringsmeny. Kom ihåg att `Header`-komponenten ärver alla funktioner i [Navigation Core Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html) och att innehållet som exponeras via JSON automatiskt mappas till React Props.

1. Öppna ett nytt terminalfönster och navigera till mappen `ui.frontend` i SPA. Starta **webpack-dev-server** med kommandot `npm start`.

   ```shell
   $ cd ui.frontend
   $ npm start
   ```

1. Öppna en ny flik i webbläsaren och gå till [http://localhost:3000/](http://localhost:3000/).

   **webpack-dev-server** bör konfigureras att proxyansluta JSON-modellen från en lokal instans av AEM (`ui.frontend/.env.development`). Detta gör att vi kan koda direkt mot innehåll som skapats i AEM i den tidigare övningen. Kontrollera att du är autentiserad i AEM i samma webbläsarsession.

   ![menyväxla till/från](./assets/navigation-routing/nav-toggle-static.gif)

   Menyalternativfunktionen är redan implementerad i `Header`. Implementera sedan navigeringsmenyn.

1. Gå tillbaka till den utvecklingsmiljö du vill använda och öppna `Header.js` på `ui.frontend/src/components/Header/Header.js`.
1. Uppdatera metoden `homeLink()` för att ta bort den hårdkodade strängen och använda de dynamiska uttryck som skickas av AEM:

   ```js
   /* Header.js */
   ...
   get homeLink() {
        //expect a single root defined as part of the navigation
       if(!this.props.items || this.props.items.length !== 1) {
           return null;
       }
   
       return this.props.items[0].url;
   }
   ...
   ```

   Ovanstående kod fyller i en URL som baseras på det rotnavigeringsobjekt som konfigurerats av komponenten. `homeLink()` används för att fylla i logotypen i  `logo()` metoden och används för att avgöra om bakåtknappen ska visas i  `backButton()`.

   Spara ändringar i `Header.js`.

1. Lägg till en rad högst upp i `Header.js` för att importera komponenten `Navigation` under den andra importen:

   ```js
   /* Header.js */
   ...
   import Navigation from '../Navigation/Navigation';
   ```

1. Uppdatera sedan metoden `get navigation()` för att instansiera komponenten `Navigation`:

   ```js
   /* Header.js */
   ...
   get navigation() {
       //pass all the props to Navigation component
       return <Navigation {...this.props} />;
   }
   ...
   ```

   I stället för att implementera navigeringen i `Header` implementerar vi huvuddelen av logiken i `Navigation`-komponenten.  De som är med i `Header` innehåller den JSON-struktur som behövs för att skapa menyn. Vi skickar alla utkast.
1. Öppna filen `Navigation.js` på `ui.frontend/src/components/Navigation/Navigation.js`.
1. Implementera metoden `renderGroupNav(children)`:

   ```js
   /* Navigation.js */
   ...
   renderGroupNav(children) {
   
       if(children === null || children.length < 1 ) {
           return null;
       }
       return (<ul className={this.baseCss + '__group'}>
                   {children.map(
                       (item,index) => { return this.renderNavItem(item,index)}
                   )}
               </ul>
       );
   }
   ...
   ```

   Den här metoden tar en array med navigeringsobjekt, `children`, och skapar en lista som inte är ordnad. Sedan itereras det över arrayen och skickar objektet till `renderNavItem`, som kommer att implementeras härnäst.

1. Implementera `renderNavItem`:

   ```js
   /* Navigation.js */
   ...
   renderNavItem(item, index) {
       const cssClass = this.baseCss + '__item ' + 
                        this.baseCss + '__item--level-' + item.level + ' ' +
                        (item.active ? ' ' + this.baseCss + '__item--active' : '');
       return (
           <li key={this.baseCss + '__item-' + index} className={cssClass}>
                   { this.renderLink(item) }
                   { this.renderGroupNav(item.children) }
           </li>
       );
   }
   ...
   ```

   Den här metoden återger ett listobjekt med CSS-klasser baserade på egenskaperna `level` och `active`. Metoden anropar sedan `renderLink` för att skapa ankartaggen. Eftersom `Navigation`-innehållet är hierarkiskt används en rekursiv strategi för att anropa `renderGroupNav` för det aktuella objektets underordnade objekt.

1. Implementera metoden `renderLink`:

   Lägg till en importmetod för komponenten [Link](https://reacttraining.com/react-router/web/api/Link), som ingår i React-routern, högst upp i filen med de andra importerna:

   ```js
   import {Link} from "react-router-dom";
   ```

   Slutför sedan implementeringen av metoden `renderLink`:

   ```js
   renderLink(item){
       return (
           <Link to={item.url} title={item.title} aria-current={item.active && 'page'}
              className={this.baseCss + '__item-link'}>{item.title}</Link>
       );
   }
   ```

   Observera att i stället för en vanlig ankartagg, `<a>`, används komponenten [Link](https://reacttraining.com/react-router/web/api/Link). Detta garanterar att en uppdatering av hela sidan inte aktiveras, utan använder i stället den React-router som finns i AEM JS SDK för SPA Editor.

1. Spara ändringar i `Navigation.js` och gå tillbaka till **webpack-dev-server**: [http://localhost:3000](http://localhost:3000)

   ![Slutförd rubriknavigering](assets/navigation-routing/completed-header.png)

   Öppna navigeringen genom att klicka på menyväxlingsknappen så visas de ifyllda navigeringslänkarna. Du bör kunna navigera till olika vyer av SPA.

## Inspect the SPA Routing

Nu när navigeringen har implementerats inspekterar du routningen i AEM.

1. I IDE öppnar du filen `index.js` vid `ui.frontend/src/index.js`.

   ```js
   /* index.js */
   import { Router } from 'react-router-dom';
   ...
   ...
    ModelManager.initialize().then(pageModel => {
       const history = createBrowserHistory();
       render(
       <Router history={history}>
           <App
           history={history}
           cqChildren={pageModel[Constants.CHILDREN_PROP]}
           cqItems={pageModel[Constants.ITEMS_PROP]}
           cqItemsOrder={pageModel[Constants.ITEMS_ORDER_PROP]}
           cqPath={pageModel[Constants.PATH_PROP]}
           locationPathname={window.location.pathname}
           />
       </Router>,
       document.getElementById('spa-root')
       );
   });
   ```

   Observera att `App` är omsluten i `Router`-komponenten från [React Router](https://reacttraining.com/react-router/). `ModelManager`, som tillhandahålls av AEM JS SDK för SPA, lägger till dynamiska vägar till AEM sidor baserat på JSON-modellens API.

1. Öppna en terminal, navigera till projektets rot och distribuera projektet till AEM med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa
   $ mvn clean install -PautoInstallSinglePackage
   ```

1. Navigera till SPA hemsida i AEM: [http://localhost:4502/content/wknd-spa-react/us/en/home.html](http://localhost:4502/content/wknd-spa-react/us/en/home.html) och öppna webbläsarens utvecklarverktyg. Skärmbilder nedan hämtas från webbläsaren Google Chrome.

   Uppdatera sidan så ser du en XHR-begäran till `/content/wknd-spa-react/us/en.model.json`, som är SPA. Observera att endast tre underordnade sidor inkluderas baserat på hierarkidjupets konfiguration till SPA som skapades tidigare i självstudiekursen. Detta inkluderar inte **sidan 3**.

   ![Initial JSON-begäran - SPA](assets/navigation-routing/initial-json-request.png)

1. När utvecklingsverktygen är öppna använder du navigeringen `Header` för att navigera till **sidan 3**:

   ![Sidan 3 navigera](assets/navigation-routing/page-three-navigation.png)

   Observera att en ny XHR-begäran görs till: `/content/wknd-spa-react/us/en/home/page-2/page-3.model.json`

   ![Sida tre XHR-begäran](assets/navigation-routing/page-3-xhr-request.png)

   AEM Modellhanteraren förstår att JSON-innehållet **Sida 3** inte är tillgängligt och utlöser automatiskt den extra XHR-begäran.

1. Fortsätt navigera i SPA med de olika navigeringslänkarna för `Header`-komponenten. Observera att inga ytterligare XHR-begäranden görs och att inga fullständiga siduppdateringar görs. Detta gör SPA snabbt för slutanvändaren och minskar antalet onödiga förfrågningar som skickas tillbaka till AEM.

   ![Navigering har implementerats](assets/navigation-routing/final-navigation-implemented.gif)

1. Experimentera med länkar genom att navigera direkt till: [http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html](http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html). Observera att webbläsarens bakåtknapp fortsätter att fungera.

## Grattis! {#congratulations}

Grattis! Du har lärt dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering har implementerats med React Router och lagts till i `Header`-komponenten.

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/navigation-routing-solution) eller checka ut koden lokalt genom att växla till grenen `React/navigation-routing-solution`.
