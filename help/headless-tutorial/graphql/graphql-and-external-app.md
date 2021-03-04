---
title: AEM med GraphQL från en extern app - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Utforska AEM GraphQL API:er som ett exempel på en WKND GraphQL React-app. Lär dig hur den här externa appen gör GraphQL-anrop till AEM för att stärka upplevelsen. Lär dig hur du utför grundläggande felhantering.
sub-product: resurser
topics: headless
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
mini-toc-levels: 1
kt: 6716
thumbnail: KT-6716.jpg
feature: '"Innehållsfragment, GraphQL API:er"'
topic: '"Headless, Content Management"'
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '1406'
ht-degree: 0%

---


# Fråga AEM med GraphQL från en extern app

I det här kapitlet utforskar vi hur AEM GraphQL API:er kan användas för att skapa en upplevelse i ett externt program.

I den här självstudien används en enkel React-app för att fråga efter och visa Adventure-innehåll som exponeras av AEM GraphQL API:er. Användningen av React är i stort sett oviktig, och den uppladdande externa applikationen kan skrivas i vilket ramverk som helst för vilken plattform som helst.

## Förutsättningar

Det här är en självstudiekurs i flera delar och det antas att de steg som beskrivs i de föregående delarna har slutförts.

_Skärmbilder från IDE i det här kapitlet kommer från  [Visual Studio Code](https://code.visualstudio.com/)_

Du kan också installera ett webbläsartillägg som [GraphQL Network](https://chrome.google.com/webstore/detail/graphql-network/igbmhmnkobkjalekgiehijefpkdemocm) för att kunna visa mer information om en GraphQL-fråga.

## Mål

I det här kapitlet får vi lära oss att:

* Starta och förstå funktionen hos exempelappen React
* Se hur anrop görs från det externa programmet till AEM GraphQL-slutpunkter
* Definiera en GraphQL-fråga för att filtrera en lista över äventyr Innehållsfragment efter aktivitet
* Uppdatera React-appen för att tillhandahålla kontroller för att filtrera via GraphQL, listan över äventyr per aktivitet

## Starta appen React

Eftersom det här kapitlet fokuserar på att utveckla en klient som ska använda innehållsfragment över GraphQL, måste exempelkoden [WKND GraphQL React-appen hämtas och konfigureras](./setup.md#react-app) på den lokala datorn, och [AEM SDK körs som författartjänsten](./setup.md#aem-sdk) med [WKND-exempelplatsen installerad](./setup.md#wknd-site) .

Det beskrivs mer ingående i avsnittet [Snabbinställningar](./setup.md) i avsnittet Reagera, men de förkortade instruktionerna kan följas:

1. Om du inte redan gjort det klonar du exempelappen WKND GraphQL React från [Github.com](https://github.com/adobe/aem-guides-wknd-graphql)

   ```shell
   $ git clone --branch tutorial/react git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna appen WKND GraphQL React i din utvecklingsmiljö

   ![Reagera app i VSCode](./assets/graphql-and-external-app/react-app-in-vscode.png)

1. Gå till mappen `react-app` från kommandoraden
1. Starta WKND GraphQL React-appen genom att köra följande kommando från projektets rot (mappen `react-app`)

   ```shell
   $ cd aem-guides-wknd-graphql/react-app
   $ npm start
   ```

1. Granska appen på [http://localhost:3000/](http://localhost:3000/). Exempelappen React består av två huvuddelar:

   * Hemupplevelsen fungerar som ett index för WKND Adventures genom att fråga __Adventure__ Content Fragments in AEM med GraphQL. I det här kapitlet ska vi ändra den här vyn så att den har stöd för filtrering av äventyren efter aktivitet.

      ![WKND GraphQL React-app - Hemupplevelse](./assets/graphql-and-external-app/react-home-view.png)

   * I upplevelsen av äventyrsinformation används GraphQL för att fråga efter det specifika __Adventure__ Content Fragment, och fler datapunkter visas.

      ![WKND GraphQL React-app - Detaljupplevelse](./assets/graphql-and-external-app/react-details-view.png)

1. Använd webbläsarens utvecklingsverktyg och ett webbläsartillägg som [GraphQL Network](https://chrome.google.com/webstore/detail/graphql-network/igbmhmnkobkjalekgiehijefpkdemocm) för att inspektera de GraphQL-frågor som skickas till AEM och deras JSON-svar. Den här metoden kan användas för att övervaka GraphQL-begäranden och svar för att säkerställa att de är korrekt formulerade och att deras svar är som förväntat.

   ![Raw Query for adventureList](assets/graphql-and-external-app/raw-query-chrome-extension.png)

   *GraphQL-fråga skickad till AEM från React-appen*

   ![GraphQL JSON-svar](assets/graphql-and-external-app/graphql-json-response.png)

   *JSON-svar från AEM till React-appen*

   Frågorna och svaren ska matcha det som visas i GraphiQL IDE.

   >[!NOTE]
   >
   > Under utvecklingen konfigureras React-appen för att proxyvis skicka HTTP-begäranden via webbpaketets utvecklingsserver till AEM. React-appen gör förfrågningar till `http://localhost:3000` som proxyger till AEM Author-tjänsten som körs `http://localhost:4502`. Granska filen `src/setupProxy.js` och `env.development` för mer information.
   >
   > I icke-utvecklingsscenarier skulle React-appen konfigureras direkt för att begära AEM.

## Utforska programmets GraphQL-kod

1. Öppna filen `src/api/useGraphQL.js` i din IDE.

   Detta är en [React Effect Hook](https://reactjs.org/docs/hooks-overview.html#effect-hook) som lyssnar efter ändringar i programmets `query` och vid en ändring görs en HTTP-POST-begäran till AEM GraphQL-slutpunkten och JSON-svaret returneras till programmet.

   Varje gång React-appen behöver göra en GraphQL-fråga anropas den anpassade `useGraphQL(query)`-kroken och den skickas i GraphQL för att skickas till AEM.

   Denna krok använder den enkla `fetch`-modulen för att göra GraphQL-begäran för HTTP-POSTEN, men andra moduler som [Apollo GraphQL-klienten](https://www.apollographql.com/docs/react/) kan användas på samma sätt.

1. Öppna `src/components/Adventures.js` i den utvecklingsmiljö som ansvarar för startvyns äventyrslista och granska anropet av kroken `useGraphQL`.

   Den här koden anger att standardvärdet `query` ska vara `allAdventuresQuery` enligt definitionen nedan i den här filen.

   ```javascript
   const [query, setQuery] = useState(allAdventuresQuery);
   ```

   ... och varje gång variabeln `query` ändras anropas kroken `useGraphQL`, som i sin tur kör GraphQL-frågan mot AEM och returnerar JSON till variabeln `data`, som sedan används för att återge listan med äventyr.

   ```javascript
   const { data, errorMessage } = useGraphQL(query);
   ```

   `allAdventuresQuery` är en konstant GraphQL-fråga som definieras i filen och som frågar alla Adventure-innehållsfragment, utan någon filtrering, och returnerar bara datapunkterna som behöver återge hemvyn.

   ```javascript
   const allAdventuresQuery = `
   {
       adventureList {
         items {
           _path
           adventureTitle
           adventurePrice
           adventureTripLength
           adventurePrimaryImage {
           ... on ImageRef {
               _path
               mimeType
               width
               height
             }
           }
         }
     }
   }
   `;
   ```

1. Öppna `src/components/AdventureDetail.js`, komponenten React som visar upplevelsen av äventyrsinformation. Den här vyn begär ett visst innehållsfragment, använder JCR-sökvägen som sitt unika ID, och återger den angivna informationen.

   På samma sätt som `Adventures.js` används den anpassade `useGraphQL` React Hook igen för att utföra GraphQL-frågan mot AEM.

   Innehållsfragmentets sökväg samlas in från komponentens `props` överkant som används för att ange det innehållsfragment som frågan ska göras om.

   ```javascript
   const contentFragmentPath = props.location.pathname.substring(props.match.url.length);
   ```

   ... och den parametriserade GraphQL-frågan skapas med funktionen `adventureDetailQuery(..)` och skickas till `useGraphQL(query)` som kör GraphQL-frågan mot AEM och returnerar resultatet till variabeln `data`.

   ```javascript
   const { data, errorMessage } = useGraphQL(adventureDetailQuery(contentFragmentPath));
   ```

   Funktionen `adventureDetailQuery(..)` kapslar bara in en filtrerande GraphQL-fråga som använder AEM `<modelName>ByPath`-syntax för att fråga ett enskilt innehållsfragment som identifieras av dess JCR-sökväg, och returnerar alla angivna datapunkter som krävs för att återge äventyrets information.

   ```javascript
   function adventureDetailQuery(_path) {
   return `{
       adventureByPath (_path: "${_path}") {
         item {
           _path
           adventureTitle
           adventureActivity
           adventureType
           adventurePrice
           adventureTripLength
           adventureGroupSize
           adventureDifficulty
           adventurePrice
           adventurePrimaryImage {
               ... on ImageRef {
               _path
               mimeType
               width
               height
               }
           }
           adventureDescription {
               html
           }
           adventureItinerary {
               html
           }
         }
       }
   }
   `;
   }
   ```

## Skapa en parametriserad GraphQL-fråga

Låt oss sedan ändra appen React för att utföra parametriserade, filtrerade GraphQL-frågor som begränsar hemvyn genom äventyrets aktivitet.

1. Öppna filen i din utvecklingsmiljö: `src/components/Adventures.js`. Den här filen representerar hemupplevelsens äventyrskomponent, som frågar efter och visar Adventures-kort.
1. Inspect funktionen `filterQuery(activity)`, som inte används, men har förberetts för att formulera en GraphQL-fråga som filtrerar äventyren med `activity`.

   Observera att parametern `activity` matas in i GraphQL-frågan som en del av `filter` i fältet `adventureActivity`, vilket kräver att fältets värde matchar parameterns värde.

   ```javascript
   function filterQuery(activity) {
       return `
           {
           adventures (filter: {
               adventureActivity: {
               _expressions: [
                   {
                   value: "${activity}"
                   }
                 ]
               }
           }){
               items {
               _path
               adventureTitle
               adventurePrice
               adventureTripLength
               adventurePrimaryImage {
               ... on ImageRef {
                   _path
                   mimeType
                   width
                   height
               }
               }
             }
         }
       }
       `;
   }
   ```

1. Uppdatera `return`-satsen för komponenten React Adventures om du vill lägga till knappar som anropar den nya parametern `filterQuery(activity)` för att tillhandahålla äventyren som ska visas.

   ```javascript
   function Adventures() {
       ...
       return (
           <div className="adventures">
   
           {/* Add these three new buttons that set the GraphQL query accordingly */}
   
           {/* The first button uses the default `allAdventuresQuery` */}
           <button onClick={() => setQuery(allAdventuresQuery)}>All</button>
   
           {/* The 2nd and 3rd button use the `filterQuery(..)` to filter by activity */}
           <button onClick={() => setQuery(filterQuery('Camping'))}>Camping</button>
           <button onClick={() => setQuery(filterQuery('Surfing'))}>Surfing</button>
   
           <ul className="adventure-items">
           ...
       )
   }
   ```

1. Spara ändringarna och läs in React-appen igen i webbläsaren. De tre nya knapparna visas högst upp och när du klickar på dem återställs automatiskt AEM för Adventure Content Fragments med motsvarande aktivitet.

   ![Filtrera annonser efter aktivitet](./assets/graphql-and-external-app/filter-by-activity.png)

1. Försök lägga till fler filterknappar för aktiviteterna: `Rock Climbing`, `Cycling` och `Skiing`

## Hantera GraphQL-fel

GraphQL är starkt typbestämd och kan därför returnera användbara felmeddelanden om frågan är ogiltig. Nu ska vi simulera en felaktig fråga för att se felmeddelandet som returneras.

1. Öppna filen `src/api/useGraphQL.js` igen. Inspect följande utdrag för att se felhanteringen:

   ```javascript
   //useGraphQL.js
   .then(({data, errors}) => {
           //If there are errors in the response set the error message
           if(errors) {
               setErrors(mapErrors(errors));
           }
           //Otherwise if data in the response set the data as the results
           if(data) {
               setData(data);
           }
       })
       .catch((error) => {
           setErrors(error);
       });
   ```

   Svaret kontrolleras för att se om det innehåller ett `errors`-objekt. Objektet `errors` skickas av AEM om det finns problem med GraphQL-frågan, till exempel ett odefinierat fält baserat på schemat. Om det inte finns något `errors`-objekt ställs `data` in och returneras.

   `window.fetch` innehåller en `.catch`-sats till *catch* alla vanliga fel, t.ex. en ogiltig HTTP-begäran eller om det inte går att ansluta till servern.

1. Öppna filen `src/components/Adventures.js`.
1. Ändra `allAdventuresQuery` så att den innehåller en ogiltig egenskap `adventurePetPolicy`:

   ```javascript
   /**
    * Query for all Adventures
    * adventurePetPolicy has been added beneath items
   */
   const allAdventuresQuery = `
   {
       adventureList {
         items {
           adventurePetPolicy
           _path
           adventureTitle
           adventurePrice
           adventureTripLength
           adventurePrimaryImage {
           ... on ImageRef {
               _path
               mimeType
               width
               height
           }
           }
         }
       }
   }
   `;
   ```

   Vi vet att `adventurePetPolicy` inte är en del av Adventure-modellen, så detta bör utlösa ett fel.

1. Spara ändringarna och gå tillbaka till webbläsaren. Ett felmeddelande bör visas enligt följande:

   ![Ogiltigt egenskapsfel](assets/graphql-and-external-app/invalidProperty.png)

   GraphQL API:t upptäcker att `adventurePetPolicy` är odefinierad i `AdventureModel` och returnerar ett felmeddelande.

1. Inspect svaret från AEM med webbläsarens utvecklarverktyg för att se JSON-objektet `errors`:

   ![Fel i JSON-objekt](assets/graphql-and-external-app/error-json-response.png)

   Objektet `errors` är mycket detaljerat och innehåller information om platsen för den felaktiga frågan och klassificeringen av felet.

1. Återgå till `Adventures.js` och återställ frågeändringen för att returnera programmet till rätt läge.

## Grattis!{#congratulations}

Grattis! Du har utforskat koden för exempelappen WKND GraphQL React och uppdaterat den till att använda parametriserade, filtrerade GraphQL-frågor för att lista äventyren efter aktivitet! Du har också en chans att utforska grundläggande felhantering.

## Nästa steg {#next-steps}

I nästa kapitel, [Avancerad datamodellering med fragmentreferenser](./fragment-references.md), får du lära dig hur du använder funktionen Fragmentreferens för att skapa en relation mellan två olika innehållsfragment. Du får också lära dig hur du ändrar en GraphQL-fråga så att den inkluderar fält från en refererad modell.
