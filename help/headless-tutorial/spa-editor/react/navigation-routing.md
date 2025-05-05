---
title: Lägga till navigering och routning | Komma igång med AEM SPA Editor och React
description: Läs om hur flera vyer i SPA kan användas genom att mappa till AEM Pages med SPA Editor SDK. Dynamisk navigering implementeras med React Router och React Core Components.
feature: SPA Editor
version: Experience Manager as a Cloud Service
jira: KT-4988
thumbnail: 4988-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 9c3d47c7-1bb9-441c-a0e6-85887a32c817
duration: 337
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1481'
ht-degree: 0%

---

# Lägga till navigering och routning {#navigation-routing}

Läs om hur flera vyer i SPA kan användas genom att mappa till AEM Pages med SPA Editor SDK. Dynamisk navigering implementeras med React Router och React Core Components.

## Syfte

1. Förstå de alternativ för SPA-modellroutning som är tillgängliga när du använder SPA-redigeraren.
1. Lär dig att använda [Reaktionsrouter](https://reacttraining.com/react-router) för att navigera mellan olika vyer av SPA.
1. Använd AEM React Core Components för att implementera en dynamisk navigering som styrs av AEM sidhierarki.

## Vad du ska bygga

I det här kapitlet läggs navigering till i en SPA i AEM. Navigeringsmenyn styrs av AEM sidhierarki och använder JSON-modellen som tillhandahålls av [kärnkomponenten för navigering](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/navigation.html).

![Navigering har lagts till](assets/navigation-routing/navigation-added.png)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Det här kapitlet är en fortsättning på kapitlet [Mappa komponenter](map-components.md), men för att följa med i det hela behöver du ett SPA-aktiverat AEM-projekt som distribuerats till en lokal AEM-instans.

## Lägg till navigeringen i mallen {#add-navigation-template}

1. Öppna en webbläsare och logga in på AEM, [http://localhost:4502/](http://localhost:4502/). Startkodbasen ska redan distribueras.
1. Navigera till **SPA-sidmallen**: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html).
1. Markera den yttre **rotlayoutbehållaren** och klicka på ikonen **Princip** . Var försiktig så att **inte** **layoutbehållaren** inte är låst för redigering.

   ![Välj ikon för rotlayoutbehållarprincipen](assets/navigation-routing/root-layout-container-policy.png)

1. Skapa en ny princip med namnet **SPA-struktur**:

   ![SPA-strukturprincip](assets/navigation-routing/spa-policy-update.png)

   Välj komponenten **Layoutbehållare** under **Tillåtna komponenter** > **Allmänt** >.

   Under **Tillåtna komponenter** > **WKND SPA REACT - STRUKTUR** > väljer du komponenten **Navigation**:

   ![Välj navigeringskomponent](assets/navigation-routing/select-navigation-component.png)

   Under **Tillåtna komponenter** > **WKND SPA REACT - Innehåll** > väljer du komponenterna **Bild** och **Text**. Du bör välja totalt 4 komponenter.

   Klicka på **Klar** för att spara ändringarna.

1. Uppdatera sidan och lägg till komponenten **Navigation** ovanför den olåsta **layoutbehållaren**:

   ![lägg till navigeringskomponent i mall](assets/navigation-routing/add-navigation-component.png)

1. Markera **navigeringskomponenten** och klicka på dess **princip**-ikon för att redigera profilen.
1. Skapa en ny princip med en **principtitel** på **SPA-navigering**.

   Under **Egenskaper**:

   * Ange **Navigeringsrot** till `/content/wknd-spa-react/us/en`.
   * Ange **Uteslut rotnivåer** till **1**.
   * Avmarkera **Samla in alla underordnade sidor**.
   * Ange **Navigeringsstrukturdjupet** till **3**.

   ![Konfigurera navigeringsprincip](assets/navigation-routing/navigation-policy.png)

   Detta samlar in navigering 2 nivåer under `/content/wknd-spa-react/us/en`.

1. När du har sparat dina ändringar bör du se det ifyllda `Navigation` som en del av mallen:

   ![Populerad navigeringskomponent](assets/navigation-routing/populated-navigation.png)

## Skapa underordnade sidor

Skapa sedan ytterligare sidor i AEM som ska fungera som de olika vyerna i SPA. Vi kommer också att undersöka den hierarkiska strukturen för JSON-modellen som tillhandahålls av AEM.

1. Gå till konsolen **Platser**: [http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home](http://localhost:4502/sites.html/content/wknd-spa-react/us/en/home). Markera **hemsidan WKND SPA-reaktion** och klicka på **Skapa** > **Sida**:

   ![Skapa ny sida](assets/navigation-routing/create-new-page.png)

1. Under **Mall** väljer du **SPA-sida**. Under **Egenskaper** anger du **Sida 1** som namn för **Titel** och **sida-1**.

   ![Ange egenskaperna för den inledande sidan](assets/navigation-routing/initial-page-properties.png)

   Klicka på **Skapa** och öppna sidan i AEM SPA Editor genom att klicka på **Öppna** i popup-dialogrutan.

1. Lägg till en ny **Text**-komponent i **huvudlayoutbehållaren**. Redigera komponenten och ange texten: **Sida 1** med RTE och elementet **H2** .

   ![Exempel på innehåll, sida 1](assets/navigation-routing/page-1-sample-content.png)

   Du kan lägga till ytterligare innehåll, som en bild.

1. Gå tillbaka till AEM Sites-konsolen och upprepa stegen ovan, och skapa en andra sida med namnet **Sida 2** som motsvarar **sidan 1**.
1. Skapa slutligen en tredje sida, **Sida 3**, men som **underordnad** till **sida 2**. När webbplatshierarkin är klar ska den se ut så här:

   ![Exempel på webbplatshierarki](assets/navigation-routing/wknd-spa-sample-site-hierarchy.png)

1. Navigeringskomponenten kan nu användas för att navigera till olika områden i SPA.

   ![Navigering och routning](assets/navigation-routing/navigation-working.gif)

1. Öppna sidan utanför AEM Editor: [http://localhost:4502/content/wknd-spa-react/us/en/home.html](http://localhost:4502/content/wknd-spa-react/us/en/home.html). Använd komponenten **Navigation** för att navigera till olika vyer av programmet.

1. Använd webbläsarens utvecklarverktyg för att inspektera nätverksförfrågningar när du navigerar. Skärmbilder nedan hämtas från Google Chrome webbläsare.

   ![Observera nätverksbegäranden](assets/navigation-routing/inspect-network-requests.png)

   Observera att efter den första sidinläsningen kommer efterföljande navigering inte att orsaka en uppdatering av hela sidan och att nätverkstrafiken minimeras när du återgår till tidigare besökta sidor.

## JSON-modell för hierarkisida {#hierarchy-page-json-model}

Kontrollera sedan JSON-modellen som driver multivisningsupplevelsen av SPA.

1. Öppna JSON-modell-API:t från AEM på en ny flik: [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Det kan vara praktiskt att använda ett webbläsartillägg för att [formatera JSON](https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa).

   Det här JSON-innehållet begärs när SPA läses in för första gången. Den yttre strukturen ser ut så här:

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

   Under `:children` ska du se en post för varje sida som skapas. Innehållet för alla sidor finns i den här inledande JSON-begäran. Med navigeringsroutningen läses efterföljande vyer av SPA in snabbt eftersom innehållet redan är tillgängligt på klientsidan.

   Det är inte klokt att läsa in **ALL** av innehållet i en SPA i den inledande JSON-begäran eftersom det skulle göra den inledande sidinläsningen långsammare. Sedan ska vi titta på hur sidornas hierarkidjup samlas in.

1. Gå till mallen **SPA Root** på: [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-app-template/structure.html).

   Klicka på menyn **Sidegenskaper** > **Sidprofil**:

   ![Öppna sidprincipen för SPA-roten](assets/navigation-routing/open-page-policy.png)

1. Mallen **SPA Root** har en extra flik för **Hierarisk struktur** som styr JSON-innehållet som samlas in. **Strukturdjupet** avgör hur djupt i platshierarkin underordnade sidor ska samlas under **rotmappen**. Du kan också använda fältet **Strukturmönster** för att filtrera bort ytterligare sidor baserat på ett reguljärt uttryck.

   Uppdatera **strukturdjupet** till **&#x200B;**:

   ![Uppdatera strukturdjup](assets/navigation-routing/update-structure-depth.png)

   Klicka på **Klar** om du vill spara ändringarna i profilen.

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

   Observera att sökvägen **Sidan 3** har tagits bort: `/content/wknd-spa-react/us/en/home/page-2/page-3` från den ursprungliga JSON-modellen. Detta beror på att **sidan 3** är på nivå 3 i hierarkin och att vi har uppdaterat principen så att endast innehåll med maximalt djup på nivå 2 inkluderas.

1. Öppna SPA-startsidan igen: [http://localhost:4502/content/wknd-spa-react/us/en/home.html](http://localhost:4502/content/wknd-spa-react/us/en/home.html) och öppna webbläsarens utvecklarverktyg.

   Uppdatera sidan så ska du se XHR-begäran till `/content/wknd-spa-react/us/en.model.json`, som är SPA-roten. Observera att endast tre underordnade sidor inkluderas baserat på hierarkidjupets konfiguration till SPA-rotmallen som skapades tidigare i självstudiekursen. Detta inkluderar inte **sidan 3**.

   ![Initial JSON-begäran - SPA-rot](assets/navigation-routing/initial-json-request.png)

1. När utvecklingsverktygen är öppna använder du komponenten `Navigation` för att navigera direkt till **sidan 3**:

   Observera att en ny XHR-begäran görs till: `/content/wknd-spa-react/us/en/home/page-2/page-3.model.json`

   ![Sidan tre XHR-begäran](assets/navigation-routing/page-3-xhr-request.png)

   AEM Model Manager förstår att JSON-innehållet **Sidan 3** inte är tillgängligt och utlöser automatiskt den ytterligare XHR-begäran.

1. Experimentera med djupa länkar genom att navigera direkt till: [http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html](http://localhost:4502/content/wknd-spa-react/us/en/home/page-2.html). Tänk också på att webbläsarens bakåtknapp fortsätter att fungera.

## Inspektera reaktionsdirigering  {#react-routing}

Navigering och routning implementeras med [Reaktionsrouter](https://reactrouter.com/en/main). React Router är en samling navigeringskomponenter för React-program. [AEM React Core Components](https://github.com/adobe/aem-react-core-wcm-components-base) använder funktioner i React Router för att implementera komponenten **Navigation** som användes i föregående steg.

Kontrollera sedan hur React Router är integrerat med SPA och experimentera med React Routers [Link](https://reactrouter.com/en/main/components/link) -komponent.

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

   Observera att `App` är omsluten i komponenten `Router` från [React Router](https://reacttraining.com/react-router). `ModelManager`, som tillhandahålls av AEM SPA Editor JS SDK, lägger till dynamiska vägar till AEM Pages baserat på JSON-modellens API.

1. Öppna filen `Page.js` vid `ui.frontend/src/components/Page/Page.js`

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

   SPA-komponenten `Page` använder funktionen `MapTo` för att mappa **sidor** i AEM till en motsvarande SPA-komponent. Verktyget `withRoute` hjälper till att dynamiskt dirigera SPA till rätt underordnad AEM-sida baserat på egenskapen `cqPath`.

1. Öppna komponenten `Header.js` på `ui.frontend/src/components/Header/Header.js`.
1. Uppdatera `Header` för att kapsla in taggen `<h1>` i en [länk](https://reactrouter.com/en/main/components/link) på startsidan:

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

   I stället för att använda standardankartaggen `<a>` använder vi `<Link>` som tillhandahålls av React Router. Så länge som `to=` pekar på en giltig väg, kommer SPA att växla till den vägen och **inte** utför en uppdatering av hela sidan. Här kan vi helt enkelt hårdkoda länken till hemsidan för att visa hur `Link` används.

1. Uppdatera testet `App.test.js` `ui.frontend/src/App.test.js`.

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

   Använd länken i `Header` i stället för att använda komponenten `Navigation` för att navigera.

   ![Huvudlänk](assets/navigation-routing/header-link.png)

   Observera att en uppdatering av hela sidan har **inte** utlösts och att SPA-routningen fungerar.

1. Du kan också experimentera med filen `Header.js` med en `<a>` -ankartagg som standard:

   ```js
   <a href="/content/wknd-spa-react/us/en/home.html">
       <h1>WKND</h1>
   </a>
   ```

   Detta kan illustrera skillnaden mellan SPA-routning och vanliga länkar till webbsidor.

## Grattis! {#congratulations}

Grattis! Du har lärt dig hur flera vyer i SPA kan användas genom att mappa till AEM Pages med SPA Editor SDK. Dynamisk navigering har implementerats med React Router och lagts till i komponenten `Header`.
