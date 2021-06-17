---
title: Bootstrap the Remote SPA for SPA Editor
description: Lär dig hur du startar en SPA för AEM kompatibilitet SPA redigeraren.
topic: Headless, SPA, Development
feature: SPA, kärnkomponenter, API:er, utveckling
role: Developer, Architect
level: Beginner
kt: 7633
thumbnail: kt-7633.jpeg
source-git-commit: 76b10941ca8aeb5aa15ca39d354d9f7e7fb24522
workflow-type: tm+mt
source-wordcount: '1227'
ht-degree: 0%

---


# Bootstrap the Remote SPA for SPA Editor

Innan de redigerbara områdena kan läggas till i SPA måste det startas med JavaScript SDK för AEM SPA redigeraren och några andra konfigurationer.


## Ladda ned WKND App-källan

Om du inte redan har gjort det hämtar du WKND-appens källkod från Github.com och växlar grenen som innehåller ändringarna till SPA som utfördes i den här självstudiekursen.

```
$ mkdir -p ~/Code/wknd-app
$ cd ~/Code/wknd-app
$ git clone --branch feature/spa-editor https://github.com/adobe/aem-guides-wknd-graphql.git
$ cd aem-guides-wknd-graphql
```

## Lägg till AEM JS SDK npm-beroenden i redigeraren

Lägg först till AEM npm-beroenden SPA React-projektet.

```
$ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
$ npm install --save \
    @adobe/aem-spa-page-model-manager \
    @adobe/aem-spa-component-mapping \
    @adobe/aem-react-editable-components \
    @adobe/aem-core-components-react-base \
    @adobe/aem-core-components-react-spa
```

+ `@adobe/aem-spa-page-model-manager` innehåller API:t för att hämta innehåll från AEM.
+ `@adobe/aem-spa-component-mapping` innehåller det API som mappar AEM innehåll till SPA.
+ ` @adobe/aem-react-editable-components` innehåller ett API för att skapa anpassade SPA och innehåller implementeringar som används ofta, till exempel komponenten  `AEMPage` React.
+ `@adobe/aem-core-components-react-base` innehåller en serie färdiga React-komponenter som smidigt kan integreras med AEM WCM Core Components och som är SPA Editor-agnostiska. Dessa innehåller i första hand innehållskomponenter som:
   + Titel
   + Text
   + Breadcrumbs
   + Och så vidare.
+ `@adobe/aem-core-components-react-spa` innehåller en serie färdiga React-komponenter som smidigt kan integreras med AEM WCM Core Components och som kräver SPA Editor. De innehåller i första hand komponenter som innehåller innehållskomponenter från `@adobe/aem-core-components-react-base`, som:
   + Behållare
   + Carousel
   + och så vidare.

## Granska SPA miljövariabler

Flera miljövariabler måste exponeras för SPA så att de kan interagera med AEM.

1. Öppna SPA på `~/Code/wknd-app/aem-guides-wknd-graphql/react-app` i din IDE
1. Öppna filen `.env.development`
1. Lägg till filen och var särskilt uppmärksam på tangenterna:

   ```
   REACT_APP_HOST_URI=http://localhost:4502
   REACT_APP_AUTHORIZATION=admin:admin
   ```

   ![SPA](./assets/spa-bootstrap/env-variables.png)

   *Kom ihåg att anpassade miljövariabler i React måste föregås av  `REACT_APP_`.*

   + `REACT_APP_AEM_URI`: schemat och värddatorn för den AEM tjänst som fjärr-SPA ansluter till.
      + Det här värdet ändras baserat på om AEM (lokal miljö, Dev, Stage eller Production) och AEM Service-typ (Författare kontra Publicera)
   + `REACT_APP_AEM_AUTH`: de inloggningsuppgifter som SPA använder för att AEM och hämta innehåll.
      + Krävs för användning med AEM Author
      + Krävs eventuellt för användning med AEM Publish (om innehållet är skyddat)
      + Utvecklingar mot AEM SDK har stöd för lokala konton via Basic Auth. Det här är den metod som används i den här självstudiekursen.
      + Använd [åtkomsttoken](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html) när du integrerar med AEM som Cloud Service

## Integrera ModelManager API

När AEM npm-beroenden är tillgängliga för programmet initierar du AEM `ModelManager` i projektets `index.js` innan `ReactDOM.render(...)` anropas.

[ModelManager](https://www.npmjs.com/package/@adobe/aem-spa-page-model-manager) ansvarar för att ansluta till AEM för att hämta redigerbart innehåll.

1. Öppna SPA i IDE
1. Öppna filen `src/index.js`
1. Lägg till import `ModelManager` och initiera den före anropet `ReactDOM.render(..)`,

   ```
   ...
   import { ModelManager } from "@adobe/aem-spa-page-model-manager";
   
   // Initialize the ModelManager before invoking ReactDOM.render(...).
   ModelManager.initializeAsync();
   
   ReactDOM.render(...);
   ```

Filen `src/index.js` ska se ut så här:

![src/index.js](./assets/spa-bootstrap/index-js.png)

## Konfigurera en intern SPA

När du hämtar redigerbart innehåll från AEM i SPA är det bäst att konfigurera en [intern proxy i SPA](https://create-react-app.dev/docs/proxying-api-requests-in-development/#configuring-the-proxy-manually), som är konfigurerad att dirigera lämpliga begäranden till AEM. Detta görs genom att använda [http-proxy-middleware](https://www.npmjs.com/package/http-proxy-middleware) npm-modulen, som redan är installerad av den grundläggande WKND GraphQL-appen.

1. Öppna SPA i IDE
1. Skapa en fil på `src/proxy/setupProxy.spa-editor.auth.basic.js`
1. Lägg till följande kod i filen:

   ```
   const { createProxyMiddleware } = require('http-proxy-middleware');
   const {REACT_APP_HOST_URI, REACT_APP_AUTHORIZATION } = process.env;
   
   /*
       Set up a proxy with AEM for local development
       In a production environment this proxy should be set up at the webserver level or absolute URLs should be used.
   */
   module.exports = function(app) {
   
       /**
       * Filter to check if the request should be re-routed to AEM. The paths to be re-routed at:
       * - Starts with /content (AEM content)
       * - Starts with /graphql (AEM graphQL endpoint)
       * - Ends with .model.json (AEM Content Services)
       * 
       * @param {*} path the path being requested of the SPA
       * @param {*} req the request object
       * @returns true if the SPA request should be re-routed to AEM
       */
       const toAEM = function(path, req) {
           return path.startsWith('/content') || 
               path.startsWith('/graphq') ||
               path.endsWith('.model.json')
       }
   
       /**
       * Re-writes URLs being proxied to AEM such that they can resolve to real AEM resources
       * - The "root" case of `/.model.json` are rewritten to the SPA's home page in AEM
       * - .model.json requests for /adventure:xxx routes are rewritten to their corresponding adventure page under /content/wknd-app/us/en/home/adventure/ 
       * 
       * @param {*} path the path being requested of the SPA
       * @param {*} req the request object
       * @returns returns a re-written path, or nothing to use the @param path
       */
       const pathRewriteToAEM = function (path, req) { 
           if (path === '/.model.json') {
               return '/content/wknd-app/us/en/home.model.json';
           } else if (path.startsWith('/adventure:') && path.endsWith('.model.json')) {
               return '/content/wknd-app/us/en/home/adventure/' + path.split('/').pop();
           }    
       }
   
       /**
       * Register the proxy middleware using the toAEM filter and pathRewriteToAEM rewriter 
       */
       app.use(
           createProxyMiddleware(
               toAEM, // Only route the configured requests to AEM
               {
                   target: REACT_APP_HOST_URI,
                   changeOrigin: true,
                   // Pass in credentials when developing against an Author environment
                   auth: REACT_APP_AUTHORIZATION,
                   pathRewrite: pathRewriteToAEM // Rewrite SPA paths being sent to AEM
               }
           )
       );
   
       /**
       * Enable CORS on requests from the SPA to AEM
       * 
       * If this rule is not in place, CORS errors will occur when running the SPA on http://localhost:3000
       */
       app.use((req, res, next) => {
           res.header("Access-Control-Allow-Origin", REACT_APP_HOST_URI);
           next();
       });
   };
   ```

   Filen `setupProxy.spa-editor.auth.basic.js` ska se ut så här:

   ![src/proxy/setupProxy.spa-editor.auth.basic.js](./assets/spa-bootstrap/setup-proxy-spaeditor-js.png)

   Den här proxykonfigurationen gör två huvudsaker:

   1. Proxyspecifika begäranden som gjorts till SPA, `http://localhost:3000` till AEM `http://localhost:4502`
      + Det är bara proxies-begäranden vars sökvägar matchar mönster som anger att de ska hanteras av AEM, enligt definitionen i `toAEM(path, req)`.
      + SPA banor skrivs om till motsvarande AEM sidor, enligt definitionen i `pathRewriteToAEM(path, req)`
   1. CORS-huvuden läggs till i alla begäranden om att tillåta åtkomst till AEM innehåll, enligt definitionen i `res.header("Access-Control-Allow-Origin", REACT_APP_HOST_URI);`
      + Om detta inte läggs till inträffar CORS-fel vid inläsning AEM innehåll i SPA.

1. Öppna filen `src/setupProxy.js`
1. Kommentera raden `const proxy = require('./proxy/setupProxy.auth.basic')`
1. Lägg till en linje som pekar på den nya proxykonfigurationsfilen:

   ```
   // Proxy configuration for SPA Editor (and GraphQL) using Basic Auth
   const proxy = require('./proxy/setupProxy.spa-editor.auth.basic')
   ```

   Filen `setupProxy.js` ska se ut så här:

   ![src/setupProxy.js](./assets/spa-bootstrap/setup-proxy-js.png)

Observera att alla ändringar i `src/setupProxy.js` eller de refererade filerna kräver att SPA startas om.

## Statisk SPA

Statiska SPA-resurser som WKND-logotypen och inläsningsgrafik måste ha sina src-URL:er uppdaterade för att de ska kunna läsas in från SPA. Om den vänstra är relativ och SPA läses in i SPA Editor för redigering, används dessa URL:er som standard AEM värd i stället för SPA, vilket resulterar i 404 begäranden enligt bilden nedan.

![Brutna statiska resurser](./assets/spa-bootstrap/broken-static-resource.png)

För att lösa det här problemet måste du se till att en statisk resurs som SPA är värd för använder absoluta sökvägar som innehåller SPA.

1. Öppna SPA i din utvecklingsmiljö
1. Öppna SPA miljövariabelfil `src/.env.development` och lägg till en variabel för den SPA offentliga URI:n:

   ```
   ...
   # The base URI the SPA is accessed from
   REACT_APP_PUBLIC_URI=http://localhost:3000
   ```

   _När du distribuerar till AEM som en Cloud Service måste du göra samma sak för motsvarande  `.env` filer._

1. Öppna filen `src/App.js`
1. Importera den SPA offentliga URI:n från de SPA miljövariablerna

   ```
   const {  REACT_APP_PUBLIC_URI } = process.env;
   
   function App() { ... }
   ```

1. Lägg till WKND-logotypen `<img src=.../>` med `REACT_APP_PUBLIC_URI` för att framtvinga upplösning mot SPA.

   ```
   <img src={REACT_APP_PUBLIC_URI + '/' +  logo} className="logo" alt="WKND Logo"/>
   ```

1. Gör samma sak med att läsa in bild i `src/components/Loading.js`

   ```
   const { REACT_APP_PUBLIC_URI } = process.env;
   
   class Loading extends Component {
   
       render() {
           return (<div className="loading">
               <img src={REACT_APP_PUBLIC_URI + '/' + loadingIcon} alt="Loading..." />
           </div>);
       }
   }
   ```

1. .. och för __två instanser__ av bakåtknappen i `src/components/AdventureDetails.js`

   ```
   const { REACT_APP_PUBLIC_URI } = process.env;
   
   function AdventureDetail(props) {
       ...
       render() {
           <img className="Backbutton-icon" src={REACT_APP_PUBLIC_URI + '/' + backIcon} alt="Return" />
       }
   }
   ```

Filerna `App.js`, `Loading.js` och `AdventureDetails.js` ska se ut så här:

![Statiska resurser](./assets/spa-bootstrap/static-resources.png)

## AEM responsivt rutnät

För att SPA redigerarens layoutläge för redigerbara områden i SPA måste vi integrera AEM responsiv CSS för stödraster i SPA. Oroa dig inte - det här rutnätssystemet kommer bara att användas för de redigerbara behållarna, och du kan använda ditt rutnätssystem för att styra layouten för resten av SPA.

Lägg till AEM Responsive Grid SCSS-filer i SPA.

1. Öppna SPA i din utvecklingsmiljö
1. Hämta och kopiera följande två filer till `src/styles`
   + [_grid.scss](./assets/spa-bootstrap/_grid.scss)
      + AEM Responsive Grid SCSS-generator
   + [_grid-init.scss](./assets/spa-bootstrap/_grid-init.scss)
      + Anropar `_grid.scss` med de SPA specifika brytpunkterna (skrivbord och mobil) och kolumnerna (12).
1. Öppna `src/App.scss` och importera `./styles/grid-init.scss`

   ```
   ...
   @import './styles/grid-init';
   ...
   ```

Filerna `_grid.scss` och `_grid-init.scss` ska se ut så här:

![AEM responsiv stödraster-SCSS](./assets/spa-bootstrap/aem-responsive-grid.png)

Nu innehåller SPA den CSS som krävs för AEM Layout Mode för komponenter som lagts till i en AEM.

## Starta SPA

Nu när SPA har startats för integrering med AEM, kör vi SPA och ser hur den ser ut!

1. Navigera till roten för det SPA projektet på kommandoraden
1. Starta SPA med de vanliga kommandona (kör `npm install` om du inte redan har det)

   ```
   $ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
   $ npm install 
   $ npm run start
   ```

1. Bläddra i SPA på [http://localhost:3000](http://localhost:3000). Allt borde se bra ut!

![SPA körs på http://localhost:3000](./assets/spa-bootstrap/localhost-3000.png)

## Öppna SPA i AEM SPA

När SPA körs på [http://localhost:3000](http://localhost:3000) kan vi öppna den med AEM SPA Editor. Inget är redigerbart i SPA än. Detta validerar bara SPA i AEM.

1. Logga in på AEM Author
1. Navigera till __Sites > WKND App > us > en__
1. Markera startsidan för __WKND-programmet__ och tryck på __Redigera__ så visas SPA.

   ![Redigera startsida för WKND-program](./assets/spa-bootstrap/edit-home.png)

1. Växla till __Förhandsgranska__ med lägesväljaren i det övre högra hörnet
1. Klicka runt SPA

   ![SPA körs på http://localhost:3000](./assets/spa-bootstrap/spa-editor.png)

## Grattis!

Du har startat SPA för att vara AEM SPA Editor-kompatibel! Nu kan du:

+ Lägg till JS SDK npm-beroenden AEM redigeraren i det SPA projektet
+ Konfigurera SPA
+ Integrera ModelManager-API:t med SPA
+ Konfigurera en intern proxy för SPA så att rätt innehållsbegäran dirigeras till AEM
+ Åtgärda problem med statiska SPA resurser som åtgärdas i kontexten SPA redigeraren
+ Lägg till CSS för AEM responsivt stödraster som stöder layouting i AEM redigerbara behållare

## Nästa steg

Nu när vi har nått en nivå av kompatibilitet med AEM SPA Editor kan vi börja införa redigerbara områden. Vi ska först titta på hur du placerar en [fast redigerbar komponent](./spa-fixed-component.md) i SPA.
