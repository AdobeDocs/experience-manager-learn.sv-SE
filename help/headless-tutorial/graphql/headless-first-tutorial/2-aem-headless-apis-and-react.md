---
title: AEM Headless APIs and React - AEM Headless first tutorial
description: Lär dig hur du hämtar data för innehållsfragment från AEM GraphQL API:er och visar dem i React-appen.
version: Experience Manager as a Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Development
role: Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-05-16T00:00:00Z
jira: KT-13270
thumbnail: KT-13270.jpeg
exl-id: 2b726473-5a32-4046-bce8-6da3c57a1b60
duration: 225
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '856'
ht-degree: 0%

---

# AEM Headless API:er och React

Välkommen till den här självstudiekursen där vi ska utforska hur du konfigurerar en React-app för att ansluta till Adobe Experience Manager (AEM) Headless-API:er med AEM Headless SDK. Vi ska ta upp hämtning av Content Fragment-data från AEM GraphQL API:er och visa dem i React-appen.

AEM Headless API:er ger åtkomst till AEM-innehåll från alla klientprogram. Vi vägleder dig genom att konfigurera din React-app så att du kan ansluta till AEM Headless-API:er med AEM Headless SDK. Med den här konfigurationen skapas en återanvändbar kommunikationskanal mellan appen React och AEM.

Därefter använder vi AEM Headless SDK för att hämta information om innehållsfragment från AEM GraphQL API:er. Content Fragments in AEM innehåller strukturerad innehållshantering. Genom att använda AEM Headless SDK kan du enkelt hämta Content Fragment-data med GraphQL.

När vi har data från Content Fragment integrerar vi dem i React-appen. Du får lära dig att formatera och visa data på ett tilltalande sätt. Vi kommer att beskriva de bästa sätten att hantera och återge Content Fragment-data i React-komponenter, vilket säkerställer en smidig integrering med appens användargränssnitt.

Under hela självstudiekursen kommer vi att ge förklaringar, kodexempel och praktiska tips. När allt är klart kan du konfigurera appen React så att du kan ansluta till AEM Headless API:er, hämta Content Fragment-data med AEM Headless SDK och smidigt visa dem i appen React. Kom så börjar vi!


## Klona React-appen

1. Klona appen från [Github](https://github.com/lamontacrook/headless-first/tree/main) genom att köra följande kommando på kommandoraden.

   ```
   $ git clone git@github.com:lamontacrook/headless-first.git
   ```

1. Ändra till katalogen `headless-first` och installera beroendena.

   ```
   $ cd headless-first
   $ npm ci
   ```

## Konfigurera React-appen

1. Skapa en fil med namnet `.env` i projektets rot. Ange följande värden i `.env`:

   ```
   REACT_APP_AEM=<URL of the AEM instance>
   REACT_APP_ENDPOINT=<the name of the endpoint>
   REACT_APP_PROJECT=<the name of the folder with Content Fragments>
   REACT_APP_TOKEN=<developer token>
   ```

1. Du kan hämta en utvecklartoken i Cloud Manager. Logga in på [Adobe Cloud Manager](https://experience.adobe.com/). Klicka på __Experience Manager > Cloud Manager__. Välj lämpligt program och klicka sedan på ellipserna bredvid Miljön.

   ![AEM Developer Console](./assets/2/developer-console.png)

   1. Klicka på fliken __Integrationer__
   1. Klicka på __fliken Lokal token och knappen Hämta lokal utvecklingstoken__
   1. Kopiera åtkomsttoken med början efter den öppna offerten till före avslutande citattecken.
   1. Klistra in den kopierade token som värde för `REACT_APP_TOKEN` i filen `.env`.
   1. Nu skapar vi appen genom att köra `npm ci` på kommandoraden.
   1. Starta nu React-appen och kör `npm run start` på kommandoraden.
   1. I [./src/utils](https://github.com/lamontacrook/headless-first/tree/main/src/utils) en fil med namnet `context.js` innehåller koden som anger värdena i filen `.env` i appens kontext.

## Kör React-appen

1. Starta React-appen genom att köra `npm run start` på kommandoraden.

   ```
   $ npm run start
   ```

   Appen React startar och öppnar ett webbläsarfönster till `http://localhost:3000`. Ändringar i React-appen läses automatiskt in igen i webbläsaren.

## Anslut till AEM Headless API:er

1. Om du vill ansluta React-appen till AEM as a Cloud Service lägger du till några saker i `App.js`. Lägg till `useContext` i `React`-importen.

   ```javascript
   import React, {useContext} from 'react';
   ```

   Importera `AppContext` från filen `context.js`.

   ```javascript
   import { AppContext } from './utils/context';
   ```

   Definiera en kontextvariabel i programkoden.

   ```javascript
   const context = useContext(AppContext);
   ```

   Och radbryt till slut returkoden i `<AppContext.Provider> ... </AppContext.Provider>`.

   ```javascript
   ...
   return(<div className='App'>
       <AppContext.Provider value={context}>
           ...
       </AppContext.Provider>
   </div>);
   ```

   Som referens bör `App.js` nu vara så här.

   ```javascript
   import React, {useContext} from 'react';
   import './App.css';
   import { BrowserRouter, Routes, Route } from 'react-router-dom';
   import Home from './screens/home/home';
   import { AppContext } from './utils/context';
   
   const App = () => {
   const context = useContext(AppContext);
   return (
       <div className='App'>
       <AppContext.Provider value={context}>
           <BrowserRouter>
           <Routes>
               <Route exact={true} path={'/'} element={<Home />} />
           </Routes>
           </BrowserRouter>
       </AppContext.Provider>
       </div>
   );
   };
   
   export default App;
   ```

1. Importera `AEMHeadless` SDK. SDK är ett hjälpbibliotek som används av programmet för att interagera med AEM Headless API:er.

   Lägg till den här importsatsen i `home.js`.

   ```javascript
   import AEMHeadless from '@adobe/aem-headless-client-js';
   ```

   Lägg till följande `{ useContext, useEffect, useState }` i importsatsen ` React`.

   ```javascript
   import React, { useContext, useEffect, useState } from 'react';
   ```

   Importera `AppContext`.

   ```javascript
   import { AppContext } from '../../utils/context';
   ```

   I komponenten `Home` hämtar du variabeln `context` från `AppContext`.

   ```javascript
   const Home = () => {
   const context = useContext(AppContext);
   ...
   }
   ```

1. Initiera AEM Headless SDK i en `useEffect()` eftersom AEM Headless SDK måste ändras när variabeln `context` ändras.

   ```javascript
   useEffect(() => {
   const sdk = new AEMHeadless({
       serviceURL: context.url,
       endpoint: context.endpoint,
       auth: context.token
   });
   }, [context]);  
   ```

   >[!NOTE]
   >
   > Det finns en `context.js`-fil under `/utils` som läser element från filen `.env`. Som referens är `context.url` webbadressen för AEM as a Cloud Service-miljön. `context.endpoint` är den fullständiga sökvägen till slutpunkten som skapades i föregående lektion. Slutligen är `context.token` utvecklartoken.


1. Create React-läge som visar innehållet som kommer från AEM Headless SDK.

   ```javascript
   const Home = () => {
   const [content, setContent] = useState({});
   ...
   }
   ```

1. Anslut appen till AEM. Använd den beständiga fråga som skapades i föregående lektion. Vi lägger till följande kod i `useEffect` när AEM Headless SDK har initierats. Gör `useEffect` beroende av variabeln `context` enligt nedan.


   ```javascript
   useEffect(() => {
   ...
   sdk.runPersistedQuery('<name of the endpoint>/<name of the persisted query>', { path: `/content/dam/${context.project}/<name of the teaser fragment>` })
       .then(({ data }) => {
       if (data) {
           setContent(data);
       }
       })
       .catch((error) => {
       console.log(`Error with pure-headless/teaser. ${error.message}`);
       });
   }, [context]);
   ```

1. Öppna nätverksvyn för utvecklingsverktygen för att granska GraphQL begäran.

   `<url to environment>/graphql/execute.json/pure-headless/teaser%3Bpath%3D%2Fcontent%2Fdam%2Fpure-headless%2Fhero`

   ![Chrome Dev Tools](./assets/2/dev-tools.png)

   AEM Headless SDK kodar begäran för GraphQL och lägger till de angivna parametrarna. Du kan öppna begäran i webbläsaren.

   >[!NOTE]
   >
   > Eftersom begäran går till redigeringsmiljön måste du vara inloggad i miljön på en annan flik i samma webbläsare.


## Återge innehåll i innehållsfragment

1. Visa innehållets fragment i appen. Returnera en `<div>` med teaserns titel.

   ```javascript
   return (
   <div className='main-body'>
       <div>{content.component && (content.component.item.title)}</div>
   </div>
   );
   ```

   Textfältet för teaser visas på skärmen.

1. Det sista steget är att lägga till suddgummit på sidan. En React Teaser-komponent ingår i paketet. Först tar vi med importen. Lägg till raden längst upp i filen `home.js`:

   `import Teaser from '../../components/teaser/teaser';`

   Uppdatera programsatsen return:

   ```javascript
   return (
   <div className='main-body'>
       <div>{content.component && <Teaser content={content.component.item} />}</div>
   </div>
   );
   ```

   Nu bör du se suddgummit med innehållet inuti fragmentet.


## Nästa steg

Grattis! Du har uppdaterat React-appen så att den kan integreras med AEM Headless API:er med AEM Headless SDK!

Sedan skapar vi en mer komplex bildlistkomponent som dynamiskt återger refererade innehållsfragment från AEM.

[Nästa kapitel: Skapa en bildlistkomponent](./3-complex-components.md)
