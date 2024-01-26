---
title: Integrera en SPA | Komma igång med AEM SPA Editor och Angular
description: Förstå hur källkoden för ett enkelsidigt program (SPA) skrivet i Angular kan integreras med ett Adobe Experience Manager-projekt (AEM). Lär dig använda moderna front end-verktyg, som Angularnas CLI-verktyg, för att snabbt utveckla SPA mot AEM JSON-modell-API.
feature: SPA Editor
version: Cloud Service
jira: KT-5310
thumbnail: 5310-spa-angular.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: e9386885-86de-4e43-933c-2f0a2c04a2f2
duration: 649
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '2045'
ht-degree: 0%

---

# Integrera en SPA {#integrate-spa}

Förstå hur källkoden för ett enkelsidigt program (SPA) skrivet i Angular kan integreras med ett Adobe Experience Manager-projekt (AEM). Lär dig använda moderna front end-verktyg, som en webpack-dev-server, för att snabbt utveckla SPA mot AEM JSON-modell-API:t.

## Syfte

1. Förstå hur SPA projekt integreras med AEM med bibliotek på klientsidan.
2. Lär dig hur du använder en lokal utvecklingsserver för dedikerad frontendutveckling.
3. Upptäck hur du använder en **proxy** och statisk **mock** fil för utveckling mot AEM JSON-modell-API

## Vad du ska bygga

I det här kapitlet kommer ett enkelt `Header` till SPA. Under processen att bygga ut denna statiska `Header` flera metoder för AEM SPA.

![Nytt sidhuvud i AEM](./assets/integrate-spa/final-header-component.png)

*SPA utökas för att lägga till en statisk `Header` komponent*

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Hämta koden

1. Hämta startpunkten för den här självstudiekursen via Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
   $ cd aem-guides-wknd-spa
   $ git checkout Angular/integrate-spa-start
   ```

2. Distribuera kodbasen till en lokal AEM med Maven:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Om du använder [AEM 6.x](overview.md#compatibility) lägg till `classic` profil:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/integrate-spa-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/integrate-spa-solution`.

## Integreringsmetod {#integration-approach}

Två moduler skapades som en del av AEM: `ui.apps` och `ui.frontend`.

The `ui.frontend` modulen är [webbpaket](https://webpack.js.org/) projekt som innehåller all SPA källkod. Huvuddelen av SPA utveckling och testning görs i webbpaketsprojektet. När ett produktionsbygge utlöses byggs SPA och kompileras med webpack. De kompilerade artefakterna (CSS och Javascript) kopieras till `ui.apps` som sedan distribueras till AEM.

![ui.frontHigh-level architecture](assets/integrate-spa/ui-frontend-architecture.png)

*En högnivåbild av SPA.*

Ytterligare information om Front-end-bygget kan [hittades här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend-angular.html).

## Integreringen av Inspect SPA {#inspect-spa-integration}

Kontrollera sedan `ui.frontend` för att förstå SPA som har genererats automatiskt av [AEM projekttyp](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend-angular.html).

1. I den utvecklingsmiljö du väljer öppnar du AEM för WKND-SPA. Den här självstudiekursen använder [Visual Studio Code IDE](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/development-tools.html#microsoft-visual-studio-code).

   ![VSCode - AEM WKND SPA Project](./assets/integrate-spa/vscode-ide-openproject.png)

2. Expandera och inspektera `ui.frontend` mapp. Öppna filen `ui.frontend/package.json`

3. Under `dependencies` du bör se flera relaterade till `@angular`:

   ```json
   "@angular/animations": "~9.1.11",
   "@angular/common": "~9.1.11",
   "@angular/compiler": "~9.1.11",
   "@angular/core": "~9.1.11",
   "@angular/forms": "~9.1.10",
   "@angular/platform-browser": "~9.1.10",
   "@angular/platform-browser-dynamic": "~9.1.10",
   "@angular/router": "~9.1.10",
   ```

   The `ui.frontend` modulen är [Angular](https://angular.io) genereras med [CLI-verktyget för angular](https://angular.io/cli) som inkluderar routning.

4. Det finns även tre beroenden som prefix `@adobe`:

   ```json
   "@adobe/cq-angular-editable-components": "^2.0.2",
   "@adobe/cq-spa-component-mapping": "^1.0.3",
   "@adobe/cq-spa-page-model-manager": "^1.1.3",
   ```

   Modulerna ovan utgör [AEM SPA Editor JS SDK](https://experienceleague.adobe.com/docs/experience-manager-65/developing/headless/spas/spa-blueprint.html) och tillhandahåller funktioner som gör det möjligt att mappa SPA komponenter till AEM.

5. I `package.json` flera filer `scripts` definieras:

   ```json
   "scripts": {
       "start": "ng serve --open --proxy-config ./proxy.conf.json",
       "build": "ng lint && ng build && clientlib",
       "build:production": "ng lint && ng build --prod && clientlib",
       "test": "ng test",
       "sync": "aemsync -d -w ../ui.apps/src/main/content"
   }
   ```

   Dessa skript är baserade på vanliga [CLI-kommandon för angular](https://angular.io/cli/build) men har ändrats något för att fungera med det större AEM.

   `start` - kör Angularna lokalt med en lokal webbserver. Den har uppdaterats för att proxyvisa innehållet i den lokala AEM instansen.

   `build` - sammanställer Angularna för produktionsdistribution. Tillägget `&& clientlib` ansvarar för att kopiera den kompilerade SPA till `ui.apps` som ett klientbibliotek under bygget. NPM-modulen [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator) används för att underlätta detta.

   Mer information om tillgängliga skript finns [här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend-angular.html).

6. Inspect filen `ui.frontend/clientlib.config.js`. Den här konfigurationsfilen används av [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator#clientlibconfigjs) för att avgöra hur klientbiblioteket ska genereras.

7. Inspect filen `ui.frontend/pom.xml`. Den här filen omvandlar `ui.frontend` mapp till en [Maven module](https://maven.apache.org/guides/mini/guide-multiple-modules.html). The `pom.xml` filen har uppdaterats för att använda [front-maven-plugin](https://github.com/eirslett/frontend-maven-plugin) till **test** och **bygg** SPA under en Maven-byggnad.

8. Inspect filen `app.component.ts` på `ui.frontend/src/app/app.component.ts`:

   ```js
   import { Constants } from '@adobe/cq-angular-editable-components';
   import { ModelManager } from '@adobe/cq-spa-page-model-manager';
   import { Component } from '@angular/core';
   
   @Component({
   selector: '#spa-root', // tslint:disable-line
   styleUrls: ['./app.component.css'],
   templateUrl: './app.component.html'
   })
   export class AppComponent {
       ...
   
       constructor() {
           ModelManager.initialize().then(this.updateData);
       }
   
       private updateData = pageModel => {
           this.path = pageModel[Constants.PATH_PROP];
           this.items = pageModel[Constants.ITEMS_PROP];
           this.itemsOrder = pageModel[Constants.ITEMS_ORDER_PROP];
       }
   }
   ```

   `app.component.js` är SPA ingångspunkt. `ModelManager` tillhandahålls av AEM JS SDK SPA Editor. Den ansvarar för att anropa och injicera `pageModel` (JSON-innehållet) i programmet.

## Lägga till en rubrikkomponent {#header-component}

Lägg sedan till en ny komponent i SPA och distribuera ändringarna till en lokal AEM för att se integreringen.

1. Öppna ett nytt terminalfönster och navigera till `ui.frontend` mapp:

   ```shell
   $ cd aem-guides-wknd-spa/ui.frontend
   ```

2. Installera [ANGULAR CLI](https://angular.io/cli#installing-angular-cli) globalt Detta används för att generera komponentkomponenter i Angularna samt för att skapa och underhålla Angularna via **ng** -kommando.

   ```shell
   $ npm install -g @angular/cli
   ```

   >[!CAUTION]
   >
   > Versionen av **@angular/cli** används av det här projektet **9.1.7**. Vi rekommenderar att Angularnas CLI-versioner är synkroniserade.

3. Skapa ett nytt `Header` genom att köra Angular CLI `ng generate component` från `ui.frontend` mapp.

   ```shell
   $ ng generate component components/header
   
   CREATE src/app/components/header/header.component.css (0 bytes)
   CREATE src/app/components/header/header.component.html (21 bytes)
   CREATE src/app/components/header/header.component.spec.ts (628 bytes)
   CREATE src/app/components/header/header.component.ts (269 bytes)
   UPDATE src/app/app.module.ts (1809 bytes)
   ```

   Detta skapar ett skelett för den nya komponenten Angular Header på `ui.frontend/src/app/components/header`.

4. Öppna `aem-guides-wknd-spa` -projektet i den utvecklingsmiljö du vill. Navigera till `ui.frontend/src/app/components/header` mapp.

   ![Sökväg för huvudkomponent i IDE](assets/integrate-spa/header-component-path.png)

5. Öppna filen `header.component.html` och ersätta innehållet med följande:

   ```html
   <!--/* header.component.html */-->
   <header className="header">
       <div className="header-container">
           <h1>WKND</h1>
       </div>
   </header>
   ```

   Observera att detta visar statiskt innehåll, så den här Angularna behöver inte justeras till standardgenererade `header.component.ts`.

6. Öppna filen **app.component.html** på  `ui.frontend/src/app/app.component.html`. Lägg till `app-header`:

   ```html
   <app-header></app-header>
   <router-outlet></router-outlet>
   ```

   Detta kommer att inkludera `header` -komponenten ovanför allt sidinnehåll.

7. Öppna en ny terminal och navigera till `ui.frontend` och kör `npm run build` kommando:

   ```shell
   $ cd ui.frontend
   $ npm run build
   
   Linting "angular-app"...
   All files pass linting.
   Generating ES5 bundles for differential loading...
   ES5 bundle generation complete.
   ```

8. Navigera till `ui.apps` mapp. Under `ui.apps/src/main/content/jcr_root/apps/wknd-spa-angular/clientlibs/clientlib-angular` ser du att de kompilerade SPA har kopierats från`ui.frontend/build` mapp.

   ![Klientbibliotek genererat i ui.apps](assets/integrate-spa/compiled-spa-uiapps.png)

9. Återgå till terminalen och navigera till `ui.apps` mapp. Kör följande Maven-kommando:

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

   Detta kommer att distribuera `ui.apps` till en lokal instans av AEM.

10. Öppna en webbläsarflik och navigera till [http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html). Nu bör du se innehållet i `Header` som visas i SPA.

   ![Implementering av inledande rubrik](assets/integrate-spa/initial-header-implementation.png)

   Steg **7-9** körs automatiskt när en Maven-bygge utlöses från projektets rot (dvs. `mvn clean install -PautoInstallSinglePackage`). Nu bör du förstå grunderna i integrationen mellan SPA och AEM klientbibliotek. Observera att du fortfarande kan redigera och lägga till `Text` -komponenter i AEM `Header` kan inte redigeras.

## Webpack Dev Server - Proxy för JSON API {#proxy-json}

Som vi har sett i tidigare övningar tar det några minuter att skapa och synkronisera klientbiblioteket till en lokal instans av AEM. Detta är godtagbart för sluttestning, men är inte idealiskt för större delen av SPA.

A [dev-server för webbpaket](https://webpack.js.org/configuration/dev-server/) kan användas för att snabbt utveckla SPA. SPA drivs av en JSON-modell som genereras av AEM. I den här övningen är JSON-innehållet från en instans av AEM som körs **proxibel** till utvecklingsservern som konfigurerats av [Angular](https://angular.io/guide/build).

1. Återgå till utvecklingsmiljön och öppna filen **proxy.conf.json** på `ui.frontend/proxy.conf.json`.

   ```json
   [
       {
           "context": [
                       "/content/**/*.(jpg|jpeg|png|model.json)",
                       "/etc.clientlibs/**/*"
                   ],
           "target": "http://localhost:4502",
           "auth": "admin:admin",
           "logLevel": "debug"
       }
   ]
   ```

   The [Angular](https://angular.io/guide/build#proxying-to-a-backend-server) har en enkel mekanism för proxy-API-begäranden. De mönster som anges i `context` proxyservrar `localhost:4502`, den lokala AEM snabbstarten.

2. Öppna filen **index.html** på `ui.frontend/src/index.html`. Det här är HTML-rotfilen som används av dev-servern.

   Observera att det finns en post för `base href="/"`. The [bastagg](https://angular.io/guide/deployment#the-base-tag) är avgörande för att programmet ska kunna matcha relativa URL:er.

   ```html
   <base href="/">
   ```

3. Öppna ett terminalfönster och navigera till `ui.frontend` mapp. Kör kommandot `npm start`:

   ```shell
   $ cd ui.frontend
   $ npm start
   
   > wknd-spa-angular@0.1.0 start /Users/dgordon/Documents/code/aem-guides-wknd-spa/ui.frontend
   > ng serve --open --proxy-config ./proxy.conf.json
   
   10% building 3/3 modules 0 active[HPM] Proxy created: [ '/content/**/*.(jpg|jpeg|png|model.json)', '/etc.clientlibs/**/*' ]  ->  http://localhost:4502
   [HPM] Subscribed to http-proxy events:  [ 'error', 'close' ]
   ℹ ｢wds｣: Project is running at http://localhost:4200/webpack-dev-server/
   ℹ ｢wds｣: webpack output is served from /
   ℹ ｢wds｣: 404s will fallback to //index.html
   ```

4. Öppna en ny flik i webbläsaren (om den inte redan är öppen) och navigera till [http://localhost:4200/content/wknd-spa-angular/us/en/home.html](http://localhost:4200/content/wknd-spa-angular/us/en/home.html).

   ![Webpack-dev-server - proxy-json](assets/integrate-spa/webpack-dev-server-1.png)

   Du bör se samma innehåll som i AEM, men utan att någon av redigeringsfunktionerna är aktiverade.

5. Återgå till utvecklingsmiljön och skapa en ny mapp med namnet `img` på `ui.frontend/src/assets`.
6. Ladda ned och lägg till följande WKND-logotyp i `img` mapp:

   ![WKND logo](./assets/integrate-spa/wknd-logo-dk.png)

7. Öppna **header.component.html** på `ui.frontend/src/app/components/header/header.component.html` och innehåller logotypen:

   ```html
   <header class="header">
       <div class="header-container">
           <div class="logo">
               <img class="logo-img" src="assets/img/wknd-logo-dk.png" alt="WKND SPA" />
           </div>
       </div>
   </header>
   ```

   Spara ändringarna i **header.component.html**.

8. Återgå till webbläsaren. Du bör omedelbart se ändringarna av appen återspeglas.

   ![Logotyp tillagd i rubrik](assets/integrate-spa/added-logo-localhost.png)

   Du kan fortsätta göra innehållsuppdateringar i **AEM** och se hur de återspeglas i **dev-server för webbpaket**, eftersom vi proxyger innehållet. Observera att innehållsändringarna bara är synliga i **dev-server för webbpaket**.

9. Stoppa den lokala webbservern med `ctrl+c` i terminalen.

## Webpack Dev Server - Mock JSON API {#mock-json}

Ett annat sätt att snabbt utveckla är att använda en statisk JSON-fil som fungerar som JSON-modell. Genom att&quot;maska&quot; JSON tar vi bort beroendet av en lokal AEM. Den gör det också möjligt för en frontendutvecklare att uppdatera JSON-modellen för att testa funktionalitet och driva ändringar i JSON API som senare skulle implementeras av en backend-utvecklare.

Den första konfigurationen av JSON-modellen gör **kräver en lokal AEM**.

1. Navigera till [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json).

   Detta är den JSON som exporteras av AEM som driver programmet. Kopiera JSON-utdata.

2. Återgå till IDE-navigeringen till `ui.frontend/src` och lägga till nya mappar **myggor** och **json** för att matcha följande mappstruktur:

   ```plain
   |-- ui.frontend
       |-- src
           |-- mocks
               |-- json
   ```

3. Skapa en ny fil med namnet **en.model.json** under `ui.frontend/public/mocks/json`. Klistra in JSON-utdata från **Steg 1** här.

   ![Modell-Json-fil](assets/integrate-spa/mock-model-json-created.png)

4. Skapa en ny fil **proxy.mock.conf.json** under `ui.frontend`. Fyll filen med följande:

   ```json
   [
       {
       "context": [
           "/content/**/*.model.json"
       ],
       "pathRewrite": { "^/content/wknd-spa-angular/us" : "/mocks/json"} ,
       "target": "http://localhost:4200",
       "logLevel": "debug"
       }
   ]
   ```

   Den här proxykonfigurationen skriver om begäranden som börjar med `/content/wknd-spa-angular/us` med `/mocks/json` och kör motsvarande statiska JSON-fil, till exempel:

   ```plain
   /content/wknd-spa-angular/us/en.model.json -> /mocks/json/en.model.json
   ```

5. Öppna filen **angular.json**. Lägg till en ny **dev** konfiguration med en uppdaterad **resurser** -array som refererar till **myggor** mappen skapades.

   ```json
    "dev": {
             "assets": [
               "src/mocks",
               "src/assets",
               "src/favicon.ico",
               "src/logo192.png",
               "src/logo512.png",
               "src/manifest.json"
             ]
       },
   ```

   ![Uppdateringsmapp för JSON Dev Assets för angular](assets/integrate-spa/dev-assets-update-folder.png)

   Skapa en dedikerad **dev** konfigurationen ser till att **myggor** används endast under utvecklingen och distribueras aldrig till AEM i ett produktionsbygge.

6. I **angular.json** filen, uppdatera **browserTarget** konfiguration som ska använda den nya **dev** konfiguration:

   ```diff
     ...
     "serve": {
         "builder": "@angular-devkit/build-angular:dev-server",
         "options": {
   +       "browserTarget": "angular-app:build:dev"
   -       "browserTarget": "angular-app:build"
         },
     ...
   ```

   ![Angular JSON build dev update](assets/integrate-spa/angular-json-build-dev-update.png)

7. Öppna filen `ui.frontend/package.json` och lägga till en ny **start:mock** för att referera till **proxy.mock.conf.json** -fil.

   ```diff
       "scripts": {
           "start": "ng serve --open --proxy-config ./proxy.conf.json",
   +       "start:mock": "ng serve --open --proxy-config ./proxy.mock.conf.json",
           "build": "ng lint && ng build && clientlib",
           "build:production": "ng lint && ng build --prod && clientlib",
           "test": "ng test",
           "sync": "aemsync -d -w ../ui.apps/src/main/content"
       }
   ```

   Om du lägger till ett nytt kommando är det enkelt att växla mellan proxykonfigurationerna.

8. Om programmet körs kan du stoppa **dev-server för webbpaket**. Starta **dev-server för webbpaket** med **start:mock** skript:

   ```shell
   $ npm run start:mock
   
   > wknd-spa-angular@0.1.0 start:mock /Users/dgordon/Documents/code/aem-guides-wknd-spa/ui.frontend
   > ng serve --open --proxy-config ./proxy.mock.conf.json
   ```

   Navigera till [http://localhost:4200/content/wknd-spa-angular/us/en/home.html](http://localhost:4200/content/wknd-spa-angular/us/en/home.html) och du borde se samma SPA, men innehållet hämtas nu från **mock** JSON-fil.

9. Gör en liten ändring i **en.model.json** filen skapades tidigare. Det uppdaterade innehållet bör omedelbart återspeglas i **dev-server för webbpaket**.

   ![Json-uppdatering av modellmodell](./assets/integrate-spa/webpack-mock-model.gif)

   Att kunna manipulera JSON-modellen och se effekterna på en live-SPA kan hjälpa en utvecklare att förstå JSON-modellens API. Det gör det även möjligt att utveckla både fram- och bakände parallellt.

## Lägg till format med Sass

Därefter läggs en del uppdaterade format till i projektet. Det här projektet lägger till [Sass](https://sass-lang.com/) har stöd för några användbara funktioner som variabler.

1. Öppna ett terminalfönster och stoppa **dev-server för webbpaket** om det startas. inifrån `ui.frontend` mapp Ange följande kommando för att uppdatera Angularna till **.scss** filer.

   ```shell
   $ cd ui.frontend
   $ ng config schematics.@schematics/angular:component.styleext scss
   ```

   Detta uppdaterar `angular.json` fil med en ny post längst ned i filen:

   ```json
   "schematics": {
       "@schematics/angular:component": {
       "styleext": "scss"
       }
   }
   ```

2. Installera `normalize-scss` för att normalisera format i olika webbläsare:

   ```shell
   $ npm install normalize-scss --save
   ```

3. Återgå till IDE och under `ui.frontend/src` skapa en ny mapp med namnet `styles`.
4. Skapa en ny fil under `ui.frontend/src/styles` namngiven `_variables.scss` och fylla i den med följande variabler:

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
   $header-height: 75px;
   
   // Spacing
   $gutter-padding: 12px;
   ```

5. Ge filtillägget ett nytt namn **styles.css** på `ui.frontend/src/styles.css` till **styles.scss**. Ersätt innehållet med följande:

   ```scss
   /* styles.scss * /
   
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
   
   body.page {
       max-width: $max-width;
       margin: 0 auto;
       padding: $gutter-padding;
       padding-top: $header-height;
   }
   ```

6. Uppdatera **angular.json** och ge alla referenser nya namn till **style.css** med **styles.scss**. Det ska finnas tre referenser.

   ```diff
     "styles": [
   -    "src/styles.css"
   +    "src/styles.scss"
      ],
   ```

## Uppdatera rubrikformat

Lägg sedan till några varumärkesspecifika format i **Sidhuvud** -komponent med Sass.

1. Starta **dev-server för webbpaket** för att se hur formaten uppdateras i realtid:

   ```shell
   $ npm run start:mock
   ```

2. Under `ui.frontend/src/app/components/header` namn **header.component.css** till **header.component.scss**. Fyll filen med följande:

   ```scss
   @import "~src/styles/variables";
   
   .header {
       width: 100%;
       position: fixed;
       top: 0;
       left:0;
       z-index: 99;
       background-color: $brand-primary;
       box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.24);
   }
   
   .header-container {
       display: flex;
       max-width: $max-width;
       margin: 0 auto;
       padding-left: $gutter-padding;
       padding-right: $gutter-padding;
   }
   
   .logo {
       z-index: 100;
       display: flex;
       padding-top: $gutter-padding;
       padding-bottom: $gutter-padding;
   }
   
   .logo-img {
       width: 100px;
   }
   ```

3. Uppdatera **header.component.ts** till referens **header.component.scss**:

   ```diff
   ...
     @Component({
       selector: 'app-header',
       templateUrl: './header.component.html',
   -   styleUrls: ['./header.component.css']
   +   styleUrls: ['./header.component.scss']
     })
   ...
   ```

4. Återgå till webbläsaren och **dev-server för webbpaket**:

   ![Formaterat huvud - webbpaketets dev-server](assets/integrate-spa/styled-header.png)

   Nu bör du se de uppdaterade formaten som lagts till i **Sidhuvud** -komponenten.

## Distribuera SPA uppdateringar till AEM

De ändringar som gjorts i **Sidhuvud** är för närvarande bara synliga genom **dev-server för webbpaket**. Distribuera den uppdaterade SPA för att AEM se ändringarna.

1. Stoppa **dev-server för webbpaket**.
2. Navigera till projektets rot `/aem-guides-wknd-spa` och driftsätta projektet för att AEM med Maven:

   ```shell
   $ cd ..
   $ mvn clean install -PautoInstallSinglePackage
   ```

3. Navigera till [http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html). Du bör se den uppdaterade **Sidhuvud** med logotyp och format tillämpade:

   ![Uppdaterat sidhuvud i AEM](assets/integrate-spa/final-header-component.png)

   Nu när den uppdaterade SPA är i AEM kan redigeringen fortsätta.

## Grattis! {#congratulations}

Grattis, du har uppdaterat SPA och utforskat integreringen med AEM! Du kan nu använda två olika metoder för att utveckla SPA mot AEM JSON-modell-API:t med en **dev-server för webbpaket**.

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/integrate-spa-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/integrate-spa-solution`.

### Nästa steg {#next-steps}

[Mappa SPA komponenter till AEM](map-components.md) - Lär dig hur du mappar komponentkomponenter till Adobe Experience Manager (AEM) med AEM SPA Editor JS SDK. Med komponentmappning kan författare göra dynamiska uppdateringar av SPA komponenter i AEM SPA Editor, på samma sätt som med traditionell AEM.
