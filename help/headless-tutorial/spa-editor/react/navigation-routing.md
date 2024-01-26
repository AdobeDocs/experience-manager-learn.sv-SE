---
title: Lägga till navigering och routning | Komma igång med AEM SPA Editor och React
description: Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med React Router och React Core Components.
feature: SPA Editor
version: Cloud Service
jira: KT-4988
thumbnail: 4988-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 9c3d47c7-1bb9-441c-a0e6-85887a32c817
duration: 437
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1481'
ht-degree: 0%

---

# Lägga till navigering och routning {#navigation-routing}

Lär dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering implementeras med React Router och React Core Components.

## Syfte

1. Förstå de alternativ för SPA modellroutning som är tillgängliga när du använder SPA Editor.
1. Lär dig använda [Reagera router](https://reacttraining.com/react-router) för att navigera mellan olika vyer av SPA.
1. Använd AEM React Core Components för att implementera en dynamisk navigering som styrs av den AEM sidhierarkin.

## Vad du ska bygga

I det här kapitlet läggs navigering till i en SPA i AEM. Navigeringsmenyn styrs av AEM sidhierarki och den JSON-modell som finns i [Kärnkomponent för navigering](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/navigation.html).

![Navigering har lagts till](assets/navigation-routing/navigation-added.png)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Det här kapitlet är en fortsättning på [Mappa komponenter](map-components.md) för att följa med i det hela behöver du ett SPA-aktiverat AEM-projekt som distribueras till en lokal AEM.

## Lägg till navigeringen i mallen {#add-navigation-template}

1. Öppna en webbläsare och logga in på AEM, [http://localhost:4502/](http://localhost:4502/). Startkodbasen ska redan distribueras.
1. Navigera till **SPA**: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html).
1. Markera den yttre **Rotlayoutbehållare** och klicka på **Policy** -ikon. Var försiktig **not** för att välja **Layoutbehållare** ej låst för redigering.

   ![Välj ikon för rotlayoutbehållarprincipen](assets/navigation-routing/root-layout-container-policy.png)

1. Skapa en ny princip med namnet **SPA**:

   ![SPA](assets/navigation-routing/spa-policy-update.png)

   Under **Tillåtna komponenter** > **Allmänt** > välj **Layoutbehållare** -komponenten.

   Under **Tillåtna komponenter** > **WKND SPA REACT - STRUKTUR** > välj **Navigering** komponent:

   ![Välj navigeringskomponent](assets/navigation-routing/select-navigation-component.png)

   Under **Tillåtna komponenter** > **WKND SPA REACT - Innehåll** > välj **Bild** och **Text** -komponenter. Du bör välja totalt 4 komponenter.

   Klicka **Klar** för att spara ändringarna.

1. Uppdatera sidan och lägg till **Navigering** -komponenten ovanför det olåsta **Layoutbehållare**:

   ![lägg till navigeringskomponent i mall](assets/navigation-routing/add-navigation-component.png)

1. Välj **Navigering** och klicka på dess **Policy** om du vill redigera profilen.
1. Skapa en ny profil med en **Principtitel** av **SPA**.

   Under **Egenskaper**:

   * Ange **Navigeringsrot** till `/content/wknd-spa-react/us/en`.
   * Ange **Uteslut rotnivåer** till **1**.
   * Avmarkera **Samla in alla underordnade sidor**.
   * Ange **Navigeringsstrukturens djup** till **3**.

   ![Konfigurera navigeringsprincip](assets/navigation-routing/navigation-policy.png)

   Detta samlar in navigeringen 2 nivåer under `/content/wknd-spa-react/us/en`.

1. När du har sparat ändringarna bör du se det ifyllda `Navigation` som en del av mallen:

   ![Fylld navigeringskomponent](assets/navigation-routing/populated-navigation.png)

## Skapa underordnade sidor

Skapa sedan ytterligare sidor i AEM som ska fungera som de olika vyerna i SPA. Vi kommer också att inspektera den hierarkiska strukturen i JSON-modellen som AEM tillhandahåller.

1. Navigera till **Webbplatser** konsol: [http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home](http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home). Välj **WKND SPA React Home Page** och klicka **Skapa** > **Sida**:

   ![Skapa ny sida](assets/navigation-routing/create-new-page.png)

1. Under **Mall** välj **SPA**. Under **Egenskaper** enter **Sida 1** för **Titel** och **page-1** som namn.

   ![Ange egenskaper för den inledande sidan](assets/navigation-routing/initial-page-properties.png)

   Klicka **Skapa** och i dialogrutan klickar du på **Öppna** för att öppna sidan i AEM SPA Editor.

1. Lägg till en ny **Text** till huvudkomponenten **Layoutbehållare**. Redigera komponenten och ange texten: **Sida 1** med RTE och **H2** -element.

   ![Exempel på innehåll, sida 1](assets/navigation-routing/page-1-sample-content.png)

   Du kan lägga till ytterligare innehåll, som en bild.

1. Återgå till AEM Sites-konsolen och upprepa stegen ovan och skapa en andra sida med namnet **Sidan 2** som ett syskon av **Sida 1**.
1. Skapa slutligen en tredje sida, **Sidan 3** men som **child** av **Sidan 2**. När webbplatshierarkin är klar ska den se ut så här:

   ![Exempel på webbplatshierarki](assets/navigation-routing/wknd-spa-sample-site-hierarchy.png)

1. Navigeringskomponenten kan nu användas för att navigera till olika delar av SPA.

   ![Navigering och routning](assets/navigation-routing/navigation-working.gif)

1. Öppna sidan utanför AEM: [http://localhost:4502/content/wknd-spa-react/us/en/home.html](http://localhost:4502/content/wknd-spa-react/us/en/home.html). Använd **Navigering** för att navigera till olika vyer av programmet.

1. Använd webbläsarens utvecklarverktyg för att inspektera nätverksförfrågningar när du navigerar. Skärmbilder nedan hämtas från webbläsaren Google Chrome.

   ![Observera nätverksbegäranden](assets/navigation-routing/inspect-network-requests.png)

   Observera att efter den första sidinläsningen kommer efterföljande navigering inte att orsaka en uppdatering av hela sidan och att nätverkstrafiken minimeras när du återgår till tidigare besökta sidor.

## JSON-modell för hierarkisida {#hierarchy-page-json-model}

Kontrollera sedan den JSON-modell som driver SPA upplevelse av flera vyer.

1. På en ny flik öppnar du JSON-modell-API:t från AEM: [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Det kan vara praktiskt att använda ett webbläsartillägg för [formatera JSON](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa).

   Detta JSON-innehåll begärs när SPA läses in första gången. Den yttre strukturen ser ut så här:

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

   Under `:children` Du bör se en post för varje sida som skapas. Innehållet för alla sidor finns i den här inledande JSON-begäran. Med navigeringsroutningen läses efterföljande vyer av SPA in snabbt eftersom innehållet redan är tillgängligt på klientsidan.

   Det är inte klokt att läsa in **ALLA** av innehållet i en SPA i den inledande JSON-begäran, eftersom detta skulle göra den inledande sidinläsningen långsammare. Sedan ska vi titta på hur sidornas hierarkidjup samlas in.

1. Navigera till **SPA** mall på: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html).

   Klicka på **Meny för sidegenskaper** > **Sidprofil**:

   ![Öppna sidprincipen för SPA](assets/navigation-routing/open-page-policy.png)

1. The **SPA** mallen har en extra **Hierarkisk struktur** för att kontrollera det insamlade JSON-innehållet. The **Strukturdjup** avgör hur djupt i platshierarkin underordnade sidor ska samlas under **root**. Du kan också använda **Strukturmönster** om du vill filtrera ut ytterligare sidor baserat på ett reguljärt uttryck.

   Uppdatera **Strukturdjup** till **2**:

   ![Uppdatera strukturdjup](assets/navigation-routing/update-structure-depth.png)

   Klicka **Klar** om du vill spara ändringarna i profilen.

1. Öppna JSON-modellen igen [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json).

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

   Observera att **Sidan 3** Sökvägen har tagits bort: `/content/wknd-spa-react/us/en/home/page-2/page-3` från den ursprungliga JSON-modellen. Det beror på att **Sidan 3** är på nivå 3 i hierarkin och vi har uppdaterat policyn till att endast inkludera innehåll på högst nivå 2.

1. Öppna SPA hemsida igen: [http://localhost:4502/content/wknd-spa-react/us/en/home.html](http://localhost:4502/content/wknd-spa-react/us/en/home.html) och öppna utvecklarverktygen i webbläsaren.

   Uppdatera sidan så ska du se XHR-begäran för att `/content/wknd-spa-react/us/en.model.json`, som är SPA. Observera att endast tre underordnade sidor inkluderas baserat på hierarkidjupets konfiguration till SPA rotmall som skapades tidigare i självstudiekursen. Detta inkluderar inte **Sidan 3**.

   ![Initial JSON-begäran - SPA](assets/navigation-routing/initial-json-request.png)

1. Med utvecklingsverktygen öppna kan du använda `Navigation` -komponent som du navigerar direkt till **Sidan 3**:

   Observera att en ny XHR-begäran görs till: `/content/wknd-spa-react/us/en/home/page-2/page-3.model.json`

   ![Sida tre XHR-begäran](assets/navigation-routing/page-3-xhr-request.png)

   AEM Modellhanteraren förstår att **Sidan 3** JSON-innehåll är inte tillgängligt och utlöser automatiskt ytterligare XHR-begäran.

1. Experimentera med länkar genom att navigera direkt till: [http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html](http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html). Tänk också på att webbläsarens bakåtknapp fortsätter att fungera.

## Inspect React Routing  {#react-routing}

Navigering och routning implementeras med [Reagera router](https://reactrouter.com/en/main). React Router är en samling navigeringskomponenter för React-program. [AEM React Core Components](https://github.com/adobe/aem-react-core-wcm-components-base) använder funktionerna i React Router för att implementera **Navigering** -komponenten som användes i föregående steg.

Kontrollera sedan hur React Router är integrerat med SPA och experimentera med React Routers [Länk](https://reactrouter.com/en/main/components/link) -komponenten.

1. Öppna filen i IDE `index.js` på `ui.frontend/src/index.js`.

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

   Observera att `App` är inkapslad i `Router` komponent från [Reagera router](https://reacttraining.com/react-router). The `ModelManager`, som tillhandahålls av AEM JS SDK, lägger till dynamiska vägar till AEM sidor baserat på JSON-modellens API.

1. Öppna filen `Page.js` på `ui.frontend/src/components/Page/Page.js`

   ```js
   class AppPage extends Page {
     get containerProps() {
       let attrs = super.containerProps;
       attrs.className =
         (attrs.className || '') + ' page ' + (this.props.cssClassNames || '');
       return attrs;
     }
   }
   
   export default MapTo('wknd-spa-react/components/page')(
     withComponentMappingContext(withRoute(AppPage))
   );
   ```

   The `Page` SPA använder `MapTo` funktion som ska mappas **Sidor** i AEM till en motsvarande SPA. The `withRoute` kan du dirigera SPA dynamiskt till rätt AEM underordnad sida baserat på `cqPath` -egenskap.

1. Öppna `Header.js` komponent vid `ui.frontend/src/components/Header/Header.js`.
1. Uppdatera `Header` för att radbryta `<h1>` i en [Länk](https://reactrouter.com/en/main/components/link) till hemsidan:

   ```diff
     //Header.js
     import React, {Component} from 'react';
   + import {Link} from 'react-router-dom';
     require('./Header.css');
   
   export default class Header extends Component {
   
       render() {
           return (
               <header className="Header">
               <div className="Header-container">
   +              <Link to="/content/wknd-spa-react/us/en/home.html">
                       <h1>WKND</h1>
   +              </Link>
               </div>
               </header>
           );
       }
   ```

   I stället för att använda en standardinställning `<a>` ankartagg som vi använder `<Link>` tillhandahålls av React Router. Så länge `to=` pekar på en giltig rutt, SPA byter till den rutten och **not** utföra en fullständig uppdatering av sidan. Här kan vi helt enkelt hårdkoda länken till hemsidan för att visa hur man använder `Link`.

1. Uppdatera testet på `App.test.js` på `ui.frontend/src/App.test.js`.

   ```diff
   + import { BrowserRouter as Router } from 'react-router-dom';
     import App from './App';
   
     it('renders without crashing', () => {
       const div = document.createElement('div');
   -   ReactDOM.render(<App />, div);
   +   ReactDOM.render(<Router><App /></Router>, div);
     });
   ```

   Eftersom vi använder funktionerna i React Router i en statisk komponent som refereras i `App.js` måste vi uppdatera enhetstestet för att ta hänsyn till det.

1. Öppna en terminal, navigera till projektets rot och distribuera projektet till AEM med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa.react
   $ mvn clean install -PautoInstallSinglePackage
   ```

1. Navigera till en av sidorna i SPA i AEM: [http://localhost:4502/content/wknd-spa-react/us/en/home/page-1.html](http://localhost:4502/content/wknd-spa-react/us/en/home/page-1.html)

   I stället för att använda `Navigation` om du vill navigera använder du länken i `Header`.

   ![Sidhuvudslänk](assets/navigation-routing/header-link.png)

   Observera att en uppdatering av hela sidan är **not** aktiveras och att SPA fungerar.

1. Experimentera med `Header.js` fil med en standard `<a>` ankartagg:

   ```js
   <a href="/content/wknd-spa-react/us/en/home.html">
       <h1>WKND</h1>
   </a>
   ```

   Detta kan illustrera skillnaden mellan SPA och vanliga länkar på webbsidor.

## Grattis! {#congratulations}

Grattis! Du har lärt dig hur flera vyer i SPA kan användas genom att mappa till AEM sidor med SPA Editor SDK. Dynamisk navigering har implementerats med React Router och lagts till i `Header` -komponenten.
