---
title: Integrera en SPA | Komma igång med AEM SPA Editor och React
description: Förstå hur källkoden för ett Single Page-program (SPA) skrivet i React kan integreras med ett Adobe Experience Manager (AEM)-projekt. Lär dig använda moderna front end-verktyg, som en webpack-dev-server, för att snabbt utveckla SPA mot AEM JSON-modell-API:t.
sub-product: platser
feature: SPA
topics: development
version: cloud-service
activity: develop
audience: developer
kt: 4853
thumbnail: 4853-spa-react.jpg
topic: SPA
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '2109'
ht-degree: 0%

---


# Integrera en SPA {#integrate-spa}

Förstå hur källkoden för ett Single Page-program (SPA) skrivet i React kan integreras med ett Adobe Experience Manager (AEM)-projekt. Lär dig använda moderna front end-verktyg, som en webpack-dev-server, för att snabbt utveckla SPA mot AEM JSON-modell-API:t.

## Syfte

1. Förstå hur SPA projekt integreras med AEM med bibliotek på klientsidan.
2. Lär dig hur du använder en webbpaketutvecklingsserver för dedikerad frontendutveckling.
3. Utforska användningen av en **proxy**- och statisk **mock**-fil för utveckling mot AEM JSON-modell-API

## Vad du ska bygga

I det här kapitlet läggs en enkel `Header`-komponent till i SPA. När den här statiska `Header`-komponenten byggs ut används flera metoder för AEM SPA.

![Nytt sidhuvud i AEM](./assets/integrate-spa/final-header-component.png)

*SPA utökas för att lägga till en statisk  `Header` komponent*

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Hämta koden

1. Hämta startpunkten för den här självstudiekursen via Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
   $ cd aem-guides-wknd-spa
   $ git checkout React/integrate-spa-start
   ```

2. Distribuera kodbasen till en lokal AEM med Maven:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Om du använder [AEM 6.x](overview.md#compatibility) lägger du till profilen `classic`:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/integrate-spa-solution) eller checka ut koden lokalt genom att växla till grenen `React/integrate-spa-solution`.

## Integreringsmetod {#integration-approach}

Två moduler skapades som en del av AEM: `ui.apps` och `ui.frontend`.

Modulen `ui.frontend` är ett [webbpack](https://webpack.js.org/)-projekt som innehåller all SPA källkod. Huvuddelen av SPA utveckling och testning kommer att ske i webbpaketsprojektet. När ett produktionsbygge utlöses byggs SPA och kompileras med webpack. De kompilerade artefakterna (CSS och Javascript) kopieras till modulen `ui.apps` som sedan distribueras till AEM.

![ui.frontHigh-level architecture](assets/integrate-spa/ui-frontend-architecture.png)

*En högnivåbild av SPA.*

Ytterligare information om Front-end-bygget finns här[](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/uifrontend-react.html).

## Inspect SPA integrering {#inspect-spa-integration}

Kontrollera sedan `ui.frontend`-modulen för att förstå SPA som har genererats automatiskt av [AEM Project-arkitypen](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/uifrontend-react.html).

1. I den utvecklingsmiljö du väljer öppnar du AEM för WKND-SPA. I den här självstudien används [Visual Studio Code IDE](https://docs.adobe.com/content/help/en/experience-manager-learn/cloud-service/local-development-environment-set-up/development-tools.html#microsoft-visual-studio-code).

   ![VSCode - AEM WKND SPA Project](./assets/integrate-spa/vscode-ide-openproject.png)

2. Utöka och inspektera mappen `ui.frontend`. Öppna filen `ui.frontend/package.json`

3. Under `dependencies` ska du se flera relaterade till `react` inklusive `react-scripts`

   ```json
   "react": "^16.12.0",
   "react-app-polyfill": "^1.0.5",
   "react-dom": "^16.12.0",
   "react-router-dom": "^5.1.2",
   "react-scripts": "3.4.1"
   ```

   `ui.frontend` är ett React-program som är baserat på [Create React App](https://create-react-app.dev/) eller CRA kort. Versionen `react-scripts` anger vilken version av CRA som används.

4. Det finns även tre beroenden som har prefixet `@adobe`:

   ```json
   "@adobe/aem-react-editable-components": "^1.0.0",
   "@adobe/aem-spa-component-mapping": "^1.0.0",
   "@adobe/aem-spa-page-model-manager": "^1.0.0",
   ```

   Ovanstående moduler utgör [AEM JS SDK](https://docs.adobe.com/content/help/en/experience-manager-65/developing/headless/spas/spa-blueprint.html)-SPA för redigeraren och innehåller funktioner som gör det möjligt att mappa SPA komponenter till AEM.

5. I `package.json`-filen finns flera `scripts` definierade:

   ```json
   "scripts": {
       "start": "react-scripts start",
       "build": "react-scripts build && clientlib",
       "test": "react-scripts test",
       "eject": "react-scripts eject",
   }
   ```

   Det här är standardbyggskript som [är tillgängliga](https://create-react-app.dev/docs/available-scripts) av Create React App.

   Den enda skillnaden är att `&& clientlib` har lagts till i `build`-skriptet. Den här extra instruktionen ansvarar för att kopiera den kompilerade SPA till `ui.apps`-modulen som ett klientbibliotek under bygget.

   NPM-modulen [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator) används för att underlätta detta.

6. Inspect filen `ui.frontend/clientlib.config.js`. Den här konfigurationsfilen används av [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator#clientlibconfigjs) för att avgöra hur klientbiblioteket ska genereras.

7. Inspect filen `ui.frontend/pom.xml`. Den här filen omvandlar mappen `ui.frontend` till en [Maven-modul](http://maven.apache.org/guides/mini/guide-multiple-modules.html). Filen `pom.xml` har uppdaterats för att använda [front-maven-plugin](https://github.com/eirslett/frontend-maven-plugin) till **test** och **build** SPA under en Maven-konstruktion.

8. Inspect filen `index.js` på `ui.frontend/src/index.js`:

   ```js
   //ui.frontend/src/index.js
   ...
   document.addEventListener('DOMContentLoaded', () => {
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
   });
   ```

   `index.js` är SPA ingångspunkt. `ModelManager` tillhandahålls av AEM JS SDK SPA Editor. Det ansvarar för att anropa och injicera `pageModel` (JSON-innehållet) i programmet.

## Lägg till en huvudkomponent {#header-component}

Lägg sedan till en ny komponent i SPA och distribuera ändringarna till en lokal AEM.

1. Skapa en ny mapp med namnet `Header` i modulen `ui.frontend` under `ui.frontend/src/components`.
2. Skapa en fil med namnet `Header.js` under mappen `Header`.

   ![Huvudmapp och fil](assets/integrate-spa/header-folder-js.png)

3. Fyll i `Header.js` med följande:

   ```js
   //Header.js
   import React, {Component} from 'react';
   
   export default class Header extends Component {
   
       render() {
           return (
                   <header className="Header">
                       <div className="Header-container">
                           <h1>WKND</h1>
                       </div>
                   </header>
           );
       }
   }
   ```

   Ovanför är en standardreaktionskomponent som ger en statisk textsträng.

4. Öppna filen `ui.frontend/src/App.js`. Detta är programmets startpunkt.
5. Gör följande uppdateringar i `App.js` för att inkludera den statiska `Header`:

   ```diff
     import { Page, withModel } from '@adobe/aem-react-editable-components';
     import React from 'react';
   + import Header from './components/Header/Header';
   
     // This component is the application entry point
     class App extends Page {
     render() {
         return (
         <div>
   +       <Header />
            {this.childComponents}
            {this.childPages}
        </div>
   ```

6. Öppna en ny terminal och navigera till mappen `ui.frontend` och kör kommandot `npm run build`:

   ```shell
   $ cd aem-guides-wknd-spa
   $ cd ui.frontend
   $ npm run build
   ...
   Compiled successfully.
   
   File sizes after gzip:
   
   118.95 KB (-33 B)  build/static/js/2.489f399a.chunk.js
   1.11 KB (+48 B)    build/static/js/main.6cfa5095.chunk.js
   806 B              build/static/js/runtime-main.42b998df.js
   451 B              build/static/css/main.e57bbe8a.chunk.css
   ```

7. Navigera till mappen `ui.apps`. Under `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/clientlibs/clientlib-react` ska du se att de kompilerade SPA har kopierats från mappen`ui.frontend/build`.

   ![Klientbibliotek genererat i ui.apps](./assets/integrate-spa/compiled-spa-uiapps.png)

8. Återgå till terminalen och navigera till mappen `ui.apps`. Kör följande Maven-kommando:

   ```shell
   $ cd ../ui.apps
   $ mvn clean install -PautoInstallPackage
   ...
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  9.629 s
   [INFO] Finished at: 2020-05-04T17:48:07-07:00
   [INFO] ------------------------------------------------------------------------
   ```

   Detta distribuerar `ui.apps`-paketet till en lokal instans av AEM som körs.

9. Öppna en webbläsarflik och gå till [http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html). Nu bör du se innehållet i `Header`-komponenten som visas i SPA.

   ![Implementering av inledande rubrik](./assets/integrate-spa/initial-header-implementation.png)

   Steg 6-8 körs automatiskt när en Maven-bygge utlöses från projektets rot (d.v.s. `mvn clean install -PautoInstallSinglePackage`). Nu bör du förstå grunderna i integrationen mellan SPA och AEM klientbibliotek. Observera att du fortfarande kan redigera och lägga till `Text`-komponenter i AEM under den statiska `Header`-komponenten.

## Webpack Dev Server - Proxy för JSON API {#proxy-json}

Som vi har sett i tidigare övningar tar det några minuter att skapa och synkronisera klientbiblioteket till en lokal instans av AEM. Detta är godtagbart för sluttestning, men är inte idealiskt för större delen av SPA.

Du kan använda en [webpack-dev-server](https://webpack.js.org/configuration/dev-server/) för att snabbt utveckla SPA. SPA drivs av en JSON-modell som genereras av AEM. I den här övningen kommer JSON-innehållet från en instans som körs av AEM att **proxideras** till utvecklingsservern.

1. Återgå till IDE och öppna filen `ui.frontend/package.json`.

   Leta efter en rad som följande:

   ```json
   "proxy": "http://localhost:4502",
   ```

   [Create React App](https://create-react-app.dev/docs/proxying-api-requests-in-development) är en enkel mekanism för proxy-API-begäranden. Alla okända begäranden proxiceras via `localhost:4502`, den lokala AEM snabbstarten.

2. Öppna ett terminalfönster och navigera till mappen `ui.frontend`. Kör kommandot `npm start`:

   ```shell
   $ cd ui.frontend
   $ npm start
   ...
   Compiled successfully!
   
   You can now view wknd-spa-react in the browser.
   
   Local:            http://localhost:3000
   On Your Network:  http://192.168.86.136:3000
   
   Note that the development build is not optimized.
   To create a production build, use npm run build.
   ```

3. Öppna en ny flik i webbläsaren (om den inte redan är öppen) och gå till [http://localhost:3000/content/wknd-spa-react/us/en/home.html](http://localhost:3000/content/wknd-spa-react/us/en/home.html).

   ![Webpack-dev-server - proxy-json](./assets/integrate-spa/webpack-dev-server-1.png)

   Du bör se samma innehåll som i AEM, men utan att någon av redigeringsfunktionerna är aktiverade.

   >[!NOTE]
   >
   > På grund av säkerhetskraven för AEM måste du vara inloggad på den lokala AEM (http://localhost:4502) i samma webbläsare, men på en annan flik.

4. Återgå till IDE och skapa en ny mapp med namnet `media` `ui.frontend/src/media`.
5. Hämta och lägg till följande WKND-logotyp i mappen `media`:

   ![WKND, logotyp](./assets/integrate-spa/wknd-logo-dk.png)

6. Öppna `Header.js` på `ui.frontend/src/components/Header/Header.js` och importera logotypen:

   ```diff
     import React, {Component} from 'react';
   + import wkndLogoDark from '../../media/wknd-logo-dk.png';
   ```

7. Gör följande uppdateringar av `Header.js` för att inkludera logotypen i sidhuvudet:

   ```js
    export default class Header extends Component {
   
       get logo() {
           return (
               <div className="Logo">
                   <img className="Logo-img" src={wkndLogoDark} alt="WKND SPA" />
               </div>
           );
       }
   
       render() {
           return (
                   <header className="Header">
                       <div className="Header-container">
                           {this.logo}
                       </div>
                   </header>
           );
       }
   }
   ```

   Spara ändringarna i `Header.js`.

8. Gå tillbaka till webbläsaren på [http://localhost:3000/content/wknd-spa-react/us/en/home.html](http://localhost:3000/content/wknd-spa-react/us/en/home.html). Du bör omedelbart se ändringarna av appen återspeglas.

   ![Logotyp tillagd i rubrik](./assets/integrate-spa/added-logo-localhost.png)

   Du kan fortsätta att göra innehållsuppdateringar i AEM och se hur de återspeglas i **webpack-dev-server**, eftersom vi proxyerar innehållet.

9. Stoppa webbpaketets dev-server med `ctrl+c` i terminalen.

## Webpack Dev Server - Mock JSON API {#mock-json}

Ett annat sätt att snabbt utveckla är att använda en statisk JSON-fil som fungerar som JSON-modell. Genom att&quot;maska&quot; JSON tar vi bort beroendet av en lokal AEM. Den gör det också möjligt för en frontendutvecklare att uppdatera JSON-modellen för att testa funktionalitet och driva ändringar i JSON API som senare skulle implementeras av en backend-utvecklare.

Den första konfigurationen av JSON-modellinstansen kräver **en lokal AEM**.

1. Gå till [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json) i webbläsaren.

   Detta är den JSON som exporteras av AEM som driver programmet. Kopiera JSON-utdata.

2. Återgå till IDE-navigeringen till `ui.frontend/public` och lägg till en ny mapp med namnet `mock-content`.
3. Skapa en ny fil med namnet `mock.model.json` under `ui.frontend/public/mock-content`. Klistra in JSON-utdata från **Steg 1** här.

   ![Modell-Json-fil](./assets/integrate-spa/mock-model-json-created.png)

4. Öppna filen `index.html` på `ui.frontend/public/index.html`. Uppdatera metadataegenskapen för den AEM sidmodellen så att den pekar på en variabel `%REACT_APP_PAGE_MODEL_PATH%`:

   ```html
       <!-- AEM page model -->
       <meta
          property="cq:pagemodel_root_url"
          content="%REACT_APP_PAGE_MODEL_PATH%"
       />
   ```

   Om du använder en variabel för värdet för `cq:pagemodel_root_url` blir det enklare att växla mellan proxy- och mock-json-modellen.

5. Öppna filen `ui.frontend/.env.development` och gör följande uppdateringar för att kommentera ut det tidigare värdet för `REACT_APP_PAGE_MODEL_PATH`:

   ```plain
   PUBLIC_URL=/
   
   #REACT_APP_PAGE_MODEL_PATH=/content/wknd-spa-react/us/en.model.json
   REACT_APP_PAGE_MODEL_PATH=/mock-content/mock.model.json
   
   REACT_APP_ROOT=/content/wknd-spa-react/us/en/home.html
   ```

6. Om den körs just nu stoppar du **webpack-dev-server**. Starta **webpack-dev-server** från terminalen:

   ```shell
   $ cd ui.frontend
   $ npm start
   ```

   Navigera till [http://localhost:3000/content/wknd-spa-react/us/en/home.html](http://localhost:3000/content/wknd-spa-react/us/en/home.html) och se SPA med samma innehåll som används i **proxyn** json.

7. Gör en liten ändring i `mock.model.json`-filen som skapades tidigare. Det uppdaterade innehållet visas omedelbart i **webpack-dev-server**.

   ![Json-uppdatering av modellmodell](./assets/integrate-spa/webpack-mock-model.gif)

Att kunna manipulera JSON-modellen och se effekterna på en live-SPA kan hjälpa en utvecklare att förstå JSON-modellens API. Det gör det även möjligt att utveckla både fram- och bakände parallellt.

Nu kan du växla var JSON-innehållet ska användas genom att växla posterna i `env.development`-filen:

```plain
# JSON API via proxy to AEM
#REACT_APP_PAGE_MODEL_PATH=/content/wknd-spa-react/us/en.model.json

# JSON API via static mock file
REACT_APP_PAGE_MODEL_PATH=/mock-content/mock.model.json
```

## Lägg till format med Sass

Det bästa sättet att reagera är att hålla varje komponent modulär och fristående. En allmän rekommendation är att undvika att återanvända samma CSS-klassnamn i olika komponenter, vilket gör att användningen av preprocessorer inte blir lika kraftfull. Det här projektet använder [Sass](https://sass-lang.com/) för några användbara funktioner som variabler. Det här projektet kommer även att följa [SATS CSS-namnkonventioner](https://github.com/suitcss/suit/blob/master/doc/components.md) löst. SUIT är en variant av BEM-notation, Block Element Modifier, som används för att skapa konsekventa CSS-regler.

1. Öppna ett terminalfönster och stoppa **webpack-dev-server** om den startas. I mappen `ui.frontend` anger du följande kommando för att [installera Sass](https://create-react-app.dev/docs/adding-a-sass-stylesheet):

   ```shell
   $ cd ui.frontend
   $ npm install node-sass --save
   ```

   Installera `sass` som ett peer-beroende:

   ```shell
   $ npm install sass --save
   ```

2. Installera `normalize-scss` för att normalisera formaten i olika webbläsare:

   ```shell
   $ npm install normalize-scss
   ```

3. Starta **webpack-dev-server** så att vi kan se formaten uppdateras i realtid:

   ```shell
   $ npm start
   ```

   Använd antingen metoden Proxy of Mock för att hantera JSON-modellens API.

4. Gå tillbaka till IDE och skapa en ny mapp under `ui.frontend/src` med namnet `styles`.
5. Skapa en ny fil under `ui.frontend/src/styles` med namnet `_variables.scss` och fyll i den med följande variabler:

   ```scss
   //_variables.scss
   
   //== Colors
   //
   //## Gray and brand colors for use across theme.
   
   $black:                  #202020;
   $gray:                   #696969;
   $gray-light:             #EBEBEB;
   $gray-lighter:           #F7F7F7;
   $white:                  #FFFFFF;
   $yellow:                 #FFEA00;
   $blue:                   #0045FF;
   
   
   //== Typography
   //
   //## Font, line-height, and color for body text, headings, and more.
   
   $font-family-sans-serif:  "Helvetica Neue", Helvetica, Arial, sans-serif;
   $font-family-serif:       Georgia, "Times New Roman", Times, serif;
   $font-family-base:        $font-family-sans-serif;
   $font-size-base:          18px;
   
   $line-height-base:        1.5;
   $line-height-computed:    floor(($font-size-base * $line-height-base));
   
   // Functional Colors
   $brand-primary:             $yellow;
   $body-bg:                   $white;
   $text-color:                $black;
   $text-color-inverse:        $gray-light;
   $link-color:                $blue;
   
   //Layout
   $max-width: 1024px;
   
   // Spacing
   $gutter-padding: 12px;
   ```

6. Ge filtillägget ett nytt namn `index.css` vid `ui.frontend/src/index.css` till **`index.scss`**. Ersätt innehållet med följande:

   ```scss
   /* index.scss * /
   
   /* Normalize */
   @import '~normalize-scss/sass/normalize';
   
   @import './styles/variables';
   
   body {
       background-color: $body-bg;
       font-family: $font-family-base;
       margin: 0;
       padding: 0;
       font-size: $font-size-base;
       text-align: left;
       color: $text-color;
       line-height: $line-height-base;
   }
   
   //spacing for header
   body.page {
       padding-top: 75px;
   }
   ```

7. Uppdatera `ui.frontend/src/index.js` så att den innehåller det omdöpta `index.scss`:

   ```diff
    ...
   - import './index.css';
   + import './index.scss';
    ....
   ```

8. Skapa en ny fil med namnet `Header.scss` under `ui.frontend/src/components/Header`. Fyll filen med följande:

   ```scss
   @import '../../styles/variables';
   
   .Header {
       width: 100%;
       position: fixed;
       top: 0;
       left:0;
       z-index: 99;
       background-color: $brand-primary;
       box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.24);
   }
   
   .Header-container {
       display: flex;
       max-width: $max-width;
       margin: 0 auto;
       padding-left: $gutter-padding;
       padding-right: $gutter-padding;
   }
   
   .Logo {
       z-index: 100;
       display: flex;
       padding-top: $gutter-padding;
       padding-bottom: $gutter-padding;
   }
   
   .Logo-img {
       width: 100px;
   }
   ```

9. Inkludera `Header.scss` genom att uppdatera `Header.js`:

   ```js
   import React, {Component} from 'react';
   import wkndLogoDark from '../../media/wknd-logo-dk.png';
   
   require('./Header.scss');
   ...
   ```

10. Återgå till webbläsaren och **webpack-dev-server**: [http://localhost:3000/content/wknd-spa-react/us/en/home.html](http://localhost:3000/content/wknd-spa-react/us/en/home.html)

   ![Formaterat huvud - webbpaketets dev-server](./assets/integrate-spa/styled-header.png)

   Du bör nu se de uppdaterade formaten som lagts till i `Header`-komponenten.

## Distribuera SPA uppdateringar till AEM

Ändringarna som görs i `Header` är för närvarande bara synliga via **webpack-dev-server**. Distribuera den uppdaterade SPA för att AEM se ändringarna.

1. Navigera till projektets rot (`aem-guides-wknd-spa`) och distribuera projektet till AEM med Maven:

   ```shell
   $ cd ..
   $ mvn clean install -PautoInstallSinglePackage
   ```

2. Navigera till [http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html). Du bör se den uppdaterade `Header` med logotyp och format tillämpade.

   ![Uppdaterat sidhuvud i AEM](./assets/integrate-spa/final-header-component.png)

   Nu när den uppdaterade SPA är i AEM kan redigeringen fortsätta.

## Felsökning av nodassaselfel

Under utvecklingen kan du råka ut för följande fel:

```
Error: Missing binding aem-guides-wknd-spa/ui.frontend/node_modules/node-sass/vendor/darwin-x64-72/binding.node
Node Sass could not find a binding for your current environment: macOS 64-bit with Node.js 12.x
```

Detta kan inträffa när den lokala versionen av **Node.js** och **npm** skiljer sig från den som används av [front-maven-plugin](https://github.com/eirslett/frontend-maven-plugin). Om du kör kommandot `npm rebuild node-sass` kan du tillfälligt åtgärda problemet eller ta bort mappen `ui.frontend/node_modules` och installera om.

Det finns också några sätt att ta itu med detta permanent.

* Kontrollera att den lokala versionen av npm och Node.js matchar de versioner som används av [Maven build](https://github.com/adobe/aem-guides-wknd-spa/blob/React/latest/pom.xml#L118)
* Lägg till följande körningssteg till `ui.frontend/pom.xml` före `npm run build`-steget:

   ```xml
   <execution>
       <id>npm rebuild node-sass</id>
       <goals>
           <goal>npm</goal>
       </goals>
       <configuration>
           <arguments>rebuild node-sass</arguments>
       </configuration>
   </execution>
   ```

## Grattis! {#congratulations}

Grattis, du har uppdaterat SPA och utforskat integreringen med AEM! Du kan nu använda två olika metoder för att utveckla SPA mot AEM JSON-modell-API:t med **webpack-dev-server**.

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/React/integrate-spa-solution) eller checka ut koden lokalt genom att växla till grenen `React/integrate-spa-solution`.

### Nästa steg {#next-steps}

[Mappa SPA komponenter till AEM komponenter](map-components.md)  - Lär dig hur du mappar React-komponenter till Adobe Experience Manager-komponenter (AEM) med AEM SPA Editor JS SDK. Komponentmappning gör att användare kan göra dynamiska uppdateringar av SPA komponenter i AEM SPA Editor, på samma sätt som vid traditionell AEM.
