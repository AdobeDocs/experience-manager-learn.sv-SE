---
title: Lägga till navigering och routning | Komma igång med AEM SPA Editor och React
description: Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med React Router och läggs till i en befintlig Header-komponent.
sub-product: platser
feature: maven-archetype, SPA Editor
topics: development
version: cloud-service
activity: develop
audience: developer
kt: 4988
thumbnail: 4988-spa-react.jpg
translation-type: tm+mt
source-git-commit: e99779b5d42bb9a3b258e2bbe815defde9d40bf7
workflow-type: tm+mt
source-wordcount: '2112'
ht-degree: 0%

---


# Lägga till navigering och routning {#navigation-routing}

Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med React Router och läggs till i en befintlig Header-komponent.

## Syfte

1. Förstå de alternativ för SPA-modellroutning som är tillgängliga när du använder SPA-redigeraren.
2. Lär dig att använda [React Router](https://reacttraining.com/react-router/) för att navigera mellan olika vyer av SPA.
3. Implementera en dynamisk navigering som styrs av AEM sidhierarki.

## Vad du ska bygga

I det här kapitlet läggs en navigeringsmeny till i en befintlig `Header` komponent. Navigeringsmenyn styrs av AEM sidhierarki och den JSON-modell som finns i [Navigation Core-komponenten](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html)används.

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

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/navigation-routing-solution) eller checka ut koden lokalt genom att växla till grenen `React/navigation-routing-solution`.

## Inspect Header-uppdateringar {#inspect-header}

I tidigare kapitel lades `Header` komponenten till som en ren React-komponent som inkluderades via `App.js`. I det här kapitlet har `Header` komponenten tagits bort och lagts till via [mallredigeraren](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/template-editor-feature-video-use.html). Detta gör att användare kan konfigurera navigeringsmenyn för `Header` i AEM.

>[!NOTE]
>
> Flera CSS- och JavaScript-uppdateringar har redan gjorts i kodbasen för att starta det här kapitlet. Om du vill fokusera på kärnkoncept beskrivs inte **alla** kodändringar. Du kan se de fullständiga ändringarna [här](https://github.com/adobe/aem-guides-wknd-spa/compare/React/map-components-solution...React/navigation-routing-start).

1. I den IDE du väljer öppnar du SPA-startprojektet för det här kapitlet.
2. Under `ui.frontend` modulen inspekterar du filen `Header.js` på: `ui.frontend/src/components/Header/Header.js`.

   Flera uppdateringar har gjorts, bland annat tillägg av en `HeaderEditConfig` och en `MapTo` för att komponenten ska kunna mappas till en AEM `wknd-spa-react/components/header`.

   ```js
   /* Header.js */
   ...
   export const HeaderEditConfig = {
       ...
   }
   ...
   MapTo('wknd-spa-react/components/header')(withRouter(Header), HeaderEditConfig);
   ```

3. I modulen `ui.apps` Granska komponentdefinitionen för den AEM `Header` komponenten: `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components/header/.content.xml`:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Header"
       sling:resourceSuperType="wknd-spa-react/components/navigation"
       componentGroup="WKND SPA React - Structure"/>
   ```

   Den AEM `Header` komponenten ärver alla funktioner i [Navigation Core-komponenten](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html) via `sling:resourceSuperType` -egenskapen.

## Lägg till sidhuvudet i mallen {#add-header-template}

1. Öppna en webbläsare och logga in på AEM, [http://localhost:4502/](http://localhost:4502/). Startkodbasen ska redan distribueras.
2. Navigera till **SPA-sidmallen**: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html).
3. Markera den yttre **rotlayoutbehållaren** och klicka på dess **ikon** . Var försiktig så att du **inte** markerar **layoutbehållaren** som inte är låst för redigering.

   ![Välj ikon för rotlayoutbehållarprincipen](assets/navigation-routing/root-layout-container-policy.png)

4. Skapa en ny profil med namnet **SPA-struktur**:

   ![SPA-strukturprincip](assets/navigation-routing/spa-policy-update.png)

   Under **Tillåtna komponenter** > **Allmänt** > väljer du komponenten **Layoutbehållare** .

   Under **Tillåtna komponenter** > **WKND SPA REACT - STRUKTUR** > väljer du **Header** -komponenten:

   ![Markera rubrikkomponent](assets/navigation-routing/select-header-component.png)

   Under **Tillåtna komponenter** > **WKND SPA REACT - Innehåll** > väljer du komponenterna **Bild** och **Text** . Du bör välja totalt 4 komponenter.

   Click **Done** to save the changes.

5. Uppdatera sidan och lägg till komponenten **Header** ovanför den olåsta **layoutbehållaren**:

   ![lägg till rubrikkomponent i mall](./assets/navigation-routing/add-header-component.gif)

6. Markera **huvudkomponenten** och klicka på **principikonen** för att redigera profilen.
7. Skapa en ny profil med en **principtitel** för **WKND SPA-huvudet**.

   Under **Egenskaper**:

   * Ange **navigeringsroten** till `/content/wknd-spa-react/us/en`.
   * Ange **Uteslut rotnivåer** till **1**.
   * Avmarkera **Samla in alla underordnade sidor**.
   * Ange **navigeringsstrukturens djup** till **3**.

   ![Konfigurera huvudprincip](assets/navigation-routing/header-policy.png)

   Då samlas navigeringen 2 nivåer under `/content/wknd-spa-react/us/en`.

8. När du har sparat ändringarna bör du se det ifyllda `Header` som en del av mallen:

   ![Komponent för fyllt sidhuvud](assets/navigation-routing/populated-header.png)

## Skapa underordnade sidor

Skapa sedan ytterligare sidor i AEM som ska fungera som olika vyer i SPA. Vi kommer också att inspektera den hierarkiska strukturen i JSON-modellen som AEM tillhandahåller.

1. Gå till **Sites** Console: [http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home](http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home). Markera hemsidan för **WKND SPA-reaktion** och klicka på **Skapa** > **Sida**:

   ![Skapa ny sida](assets/navigation-routing/create-new-page.png)

2. Under **Mall** väljer du **SPA-sida**. Under **Egenskaper** anger du **Sida 1** som **rubrik** och **sida 1** som namn.

   ![Ange egenskaper för den inledande sidan](assets/navigation-routing/initial-page-properties.png)

   Klicka på **Skapa** och klicka på **Öppna** i dialogrutan för att öppna sidan i AEM SPA-redigeraren.

3. Lägg till en ny **Text** -komponent i **huvudlayoutbehållaren**. Redigera komponenten och ange texten: **Sidan 1** med RTE- och **H1** -elementen (du måste ange helskärmsläge för att ändra styckeelementen)

   ![Exempel på innehåll, sida 1](assets/navigation-routing/page-1-sample-content.png)

   Du kan lägga till ytterligare innehåll, som en bild.

4. Gå tillbaka till AEM Sites-konsolen och upprepa stegen ovan och skapa en andra sida med namnet **Page 2** som en jämställd sida på **sidan 1**.
5. Skapa slutligen en tredje sida, **sidan 3** , men som **underordnad** till **sidan 2**. När webbplatshierarkin är klar ska den se ut så här:

   ![Exempel på webbplatshierarki](assets/navigation-routing/wknd-spa-sample-site-hierarchy.png)

6. På en ny flik öppnar du JSON-modell-API:t från AEM: [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Detta JSON-innehåll begärs när SPA läses in för första gången. Den yttre strukturen ser ut så här:

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

   Under `:children` den finns en post för varje sida som skapas. Innehållet för alla sidor finns i den här inledande JSON-begäran. När navigeringsflödet har implementerats läses efterföljande vyer av SPA in snabbt eftersom innehållet redan är tillgängligt på klientsidan.

   Det är inte klokt att läsa in **ALL** i innehållet i en SPA i den inledande JSON-begäran eftersom det skulle göra den inledande sidinläsningen långsammare. Nu ska vi titta på hur sidornas hierarkiska djup samlas in.

7. Gå till **SPA-rotmallen** på: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html).

   Klicka på menyn **** Sidegenskaper > **Sidprofil**:

   ![Öppna sidprincipen för SPA-roten](assets/navigation-routing/open-page-policy.png)

8. I **SPA-rotmallen** finns en extra **hierarkisk strukturflik** som du kan använda för att styra det JSON-innehåll som samlas in. Med **strukturdjupet** bestämmer du hur djupt i platshierarkin underordnade sidor ska samlas under **roten**. Du kan också använda fältet **Strukturmönster** för att filtrera bort ytterligare sidor baserat på ett reguljärt uttryck.

   Uppdatera **strukturdjupet** till **2**:

   ![Uppdatera strukturdjup](assets/navigation-routing/update-structure-depth.png)

   Klicka på **Klar** för att spara ändringarna i profilen.

9. Öppna JSON-modellen [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json)igen.

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

   Observera att sökvägen till **sidan 3** har tagits bort: `/content/wknd-spa-react/us/en/home/page-2/page-3` från den ursprungliga JSON-modellen.

   Senare kommer vi att se hur AEM SDK för SPA-redigeraren dynamiskt kan läsa in ytterligare innehåll.

## Implementera navigeringen

Implementera sedan navigeringsmenyn som en del av `Header`. Vi kan lägga till koden direkt i `Header.js` men det är bättre att använda det för att undvika stora komponenter. I stället implementerar vi en `Navigation` SPA-komponent som kan återanvändas senare.

1. Granska den JSON som visas av AEM `Header` komponent på [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json):

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

   De AEM sidornas hierarkiska karaktär modelleras i JSON som kan användas för att fylla i en navigeringsmeny. Kom ihåg att `Header` komponenten ärver alla funktioner i [Navigation Core Component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/navigation.html) och att innehållet som exponeras via JSON automatiskt mappas till React Props.

2. Öppna ett nytt terminalfönster och navigera till `ui.frontend` mappen för SPA-projektet. Starta **webpack-dev-server** med kommandot `npm start`.

   ```shell
   $ cd ui.frontend
   $ npm start
   ```

3. Öppna en ny flik i webbläsaren och gå till [http://localhost:3000/](http://localhost:3000/).

   Webbpack- **dev-server** bör konfigureras att proxyansluta JSON-modellen från en lokal instans av AEM (`ui.frontend/.env.development`). Detta gör att vi kan koda direkt mot innehåll som skapats i AEM i den tidigare övningen. Kontrollera att du är autentiserad i AEM i samma webbläsarsession.

   ![menyväxla till/från](./assets/navigation-routing/nav-toggle-static.gif)

   Menyalternativfunktionen är redan implementerad `Header` för tillfället. Implementera sedan navigeringsmenyn.

4. Gå tillbaka till den utvecklingsmiljö du vill använda och öppna `Header.js` på `ui.frontend/src/components/Header/Header.js`.
5. Uppdatera `homeLink()` metoden för att ta bort den hårdkodade strängen och använda de dynamiska förskjutningar som skickas av AEM:

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

   Ovanstående kod fyller i en URL som baseras på det rotnavigeringsobjekt som konfigurerats av komponenten. `homeLink()` används för att fylla i logotypen i metoden och används för att bestämma om bakåtknappen ska visas i `logo()` `backButton()`.

   Spara ändringar i `Header.js`.

6. Lägg till en rad högst upp i `Header.js` för att importera `Navigation` komponenten under den andra importen:

   ```js
   /* Header.js */
   ...
   import Navigation from '../Navigation/Navigation';
   ```

7. Uppdatera sedan metoden `get navigation()` för att instansiera `Navigation` komponenten:

   ```js
   /* Header.js */
   ...
   get navigation() {
       //pass all the props to Navigation component
       return <Navigation {...this.props} />;
   }
   ...
   ```

   I stället för att implementera navigeringen inom `Header` kommer vi som sagt att implementera större delen av logiken i `Navigation` komponenten.  De som `Header` är med omfattar den JSON-struktur som behövs för att skapa menyn, vi skickar alla utkast.
8. Öppna filen `Navigation.js` på `ui.frontend/src/components/Navigation/Navigation.js`.
9. Implementera `renderGroupNav(children)` metoden:

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

   Den här metoden tar en array med navigeringsobjekt `children`och skapar en osorterad lista. Sedan itereras det över arrayen och skickar objektet till `renderNavItem`den, som sedan implementeras.

10. Implementera `renderNavItem`:

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

   Den här metoden återger ett listobjekt med CSS-klasser baserade på egenskaper `level` och `active`. Metoden anropar sedan `renderLink` för att skapa ankartaggen. Eftersom `Navigation` innehållet är hierarkiskt används en rekursiv strategi för att anropa `renderGroupNav` för det aktuella objektets underordnade objekt.

11. Implementera `renderLink` metoden:

   Lägg till en importmetod för [Link](https://reacttraining.com/react-router/web/api/Link) -komponenten, som ingår i React-routern, längst upp i filen med övriga importer:

   ```js
   import {Link} from "react-router-dom";
   ```

   Slutför sedan implementeringen av `renderLink` metoden:

   ```js
   renderLink(item){
       return (
           <Link to={item.url} title={item.title} aria-current={item.active && 'page'}
              className={this.baseCss + '__item-link'}>{item.title}</Link>
       );
   }
   ```

   Observera att i stället för en vanlig ankartagg `<a>`används [länkkomponenten](https://reacttraining.com/react-router/web/api/Link) . Detta garanterar att en uppdatering av hela sidan inte aktiveras, utan använder i stället den React-router som tillhandahålls av AEM SPA Editor JS SDK.

12. Spara ändringar i `Navigation.js` och återgå till **webpack-dev-server**: [http://localhost:3000](http://localhost:3000)

   ![Slutförd rubriknavigering](assets/navigation-routing/completed-header.png)

   Öppna navigeringen genom att klicka på menyväxlingsknappen så visas de ifyllda navigeringslänkarna. Du bör kunna navigera till olika vyer av SPA.

## Inspect the SPA Routing

Nu när navigeringen har implementerats inspekterar du routningen i AEM.

1. I IDE öppnar du filen `index.js` på `ui.frontend/src/index.js`.

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

   Observera att `App` komponenten är figursatt i `Router` komponenten från [React Router](https://reacttraining.com/react-router/). Den `ModelManager`som tillhandahålls av AEM JS SDK för SPA-redigeraren lägger till dynamiska vägar till AEM sidor baserat på JSON-modellens API.

2. Öppna en terminal, navigera till projektets rot och distribuera projektet till AEM med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa
   $ mvn clean install -PautoInstallSinglePackage
   ```

3. Gå till SPA-startsidan i AEM: [http://localhost:4502/content/wknd-spa-react/us/en/home.html](http://localhost:4502/content/wknd-spa-react/us/en/home.html) och öppna utvecklarverktygen i webbläsaren. Skärmbilder nedan hämtas från webbläsaren Google Chrome.

   Uppdatera sidan så ser du en XHR-begäran `/content/wknd-spa-react/us/en.model.json`som är SPA-roten. Observera att endast tre underordnade sidor inkluderas baserat på hierarkidjupets konfiguration till SPA-rotmallen som skapades tidigare i självstudiekursen. Detta inkluderar inte **sidan 3**.

   ![Initial JSON-begäran - SPA-rot](assets/navigation-routing/initial-json-request.png)

4. När utvecklingsverktygen är öppna använder du navigeringen till `Header` sidan 3 ****:

   ![Sidan 3 navigera](assets/navigation-routing/page-three-navigation.png)

   Observera att en ny XHR-begäran görs till: `/content/wknd-spa-react/us/en/home/page-2/page-3.model.json`

   ![Sida tre XHR-begäran](assets/navigation-routing/page-3-xhr-request.png)

   AEM Modellhanteraren inser att JSON-innehållet på **sidan 3** inte är tillgängligt och utlöser automatiskt den ytterligare XHR-begäran.

5. Fortsätt navigera i SPA med de olika navigeringslänkarna för `Header` komponenten. Observera att inga ytterligare XHR-begäranden görs och att inga fullständiga siduppdateringar görs. Detta gör att SPA-avtalet blir snabbt för slutanvändaren och minskar antalet onödiga förfrågningar som skickas tillbaka till AEM.

   ![Navigering har implementerats](assets/navigation-routing/final-navigation-implemented.gif)

6. Experimentera med länkar genom att navigera direkt till: [http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html](http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html). Observera att webbläsarens bakåtknapp fortsätter att fungera.

## Grattis! {#congratulations}

Grattis! Du har lärt dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering har implementerats med React Router och lagts till i `Header` komponenten.

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/navigation-routing-solution) eller checka ut koden lokalt genom att växla till grenen `React/navigation-routing-solution`.
