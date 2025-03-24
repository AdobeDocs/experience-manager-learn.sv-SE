---
title: Bygg en React-app som frågar AEM med GraphQL API - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Bygg en React-app som hämtar innehåll/data från AEM GraphQL API, och se även hur AEM Headless JS SDK används.
version: Experience Manager as a Cloud Service
mini-toc-levels: 1
jira: KT-6716
thumbnail: KT-6716.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 772b595d-2a25-4ae6-8c6e-69a646143147
duration: 410
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1181'
ht-degree: 0%

---


# Bygg en React-app som använder AEM GraphQL API:er

I det här kapitlet tittar du närmare på hur AEM GraphQL API:er kan styra upplevelsen i ett externt program.

En enkel React-app används för att fråga efter och visa **Team**- och **Person**-innehåll som exponeras av AEM GraphQL API:er. Användningen av React är i stort sett oviktig, och den uppladdande externa applikationen kan skrivas i vilket ramverk som helst för vilken plattform som helst.

## Förutsättningar

Stegen som beskrivs i de tidigare delarna av den här flerdelade självstudiekursen har slutförts, eller så har [basic-tutorial-solution.content.zip](assets/explore-graphql-api/basic-tutorial-solution.content.zip) installerats på dina AEM as a Cloud Service Author- och Publish-tjänster.

_Skärmbilder i IDE i det här kapitlet kommer från [Visual Studio-kod](https://code.visualstudio.com/)_

Följande programvara måste vara installerad:

- [Node.js v18](https://nodejs.org/en)
- [Visual Studio-kod](https://code.visualstudio.com/)

## Mål

Lär dig mer om:

- Hämta och starta exempelappen React
- Fråga AEM GraphQL slutpunkter med [AEM Headless JS SDK](https://github.com/adobe/aem-headless-client-js)
- Fråga AEM efter en lista över team och deras refererade medlemmar
- Fråga AEM efter information om en teammedlem

## Hämta exempelappen React

I det här kapitlet implementeras en utbäddad exempelapp React med den kod som krävs för att interagera med AEM GraphQL API, och visa team- och persondata som hämtats från dem.

Källkoden för exempelappen React finns på Github.com på <https://github.com/adobe/aem-guides-wknd-graphql/tree/main/basic-tutorial>

Så här skaffar du React-appen:

1. Klona exempelappen WKND GraphQL React från [Github.com](https://github.com/adobe/aem-guides-wknd-graphql).

   ```shell
   $ cd ~/Code
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Navigera till mappen `basic-tutorial` och öppna den i din IDE.

   ```shell
   $ cd ~/Code/aem-guides-wknd-graphql/basic-tutorial
   $ code .
   ```

   ![Reagera app i VSCode](./assets/graphql-and-external-app/react-app-in-vscode.png)

1. Uppdatera `.env.development` för att ansluta till AEM as a Cloud Service Publish-tjänsten.

   - Ange värdet för `REACT_APP_HOST_URI` som din AEM as a Cloud Service Publish URL (t.ex. `REACT_APP_HOST_URI=https://publish-p123-e456.adobeaemcloud.com`) och `REACT_APP_AUTH_METHOD` har värdet `none`

   >[!NOTE]
   >
   > Kontrollera att du har publicerat projektkonfigurationen, Content Fragment-modeller, redigerade innehållsfragment, GraphQL slutpunkter och beständiga frågor från tidigare steg.
   >
   > Om du utförde ovanstående steg på AEM Author SDK kan du peka på `http://localhost:4502` och `REACT_APP_AUTH_METHOD`:s värde till `basic`.


1. Gå till mappen `aem-guides-wknd-graphql/basic-tutorial` från kommandoraden

1. Starta React-appen

   ```shell
   $ cd ~/Code/aem-guides-wknd-graphql/basic-tutorial
   $ npm install
   $ npm start
   ```

1. Appen React startar i utvecklingsläge på [http://localhost:3000/](http://localhost:3000/). Ändringar som görs i React-appen under hela kursen återspeglas direkt.

![Delvis implementerad React App](./assets/graphql-and-external-app/partially-implemented-react-app.png)

>[!IMPORTANT]
>
>   Den här React-appen är delvis implementerad. Följ stegen i den här självstudiekursen för att slutföra implementeringen. De JavaScript-filer som behöver implementeras har följande kommentar, se till att du lägger till/uppdaterar koden i de filerna med koden som anges i den här självstudiekursen.
>
>
> //**********************************
>
>  // TODO Implementera detta genom att följa stegen från AEM Headless Tutorial
>
>  //**********************************
>

## Anatomi i React-appen

Exempelappen React består av tre huvuddelar:

1. Mappen `src/api` innehåller filer som används för att skapa GraphQL-frågor till AEM.
   - `src/api/aemHeadlessClient.js` initierar och exporterar AEM Headless Client som används för att kommunicera med AEM
   - `src/api/usePersistedQueries.js` implementerar [anpassade React-kopplingar](https://react.dev/learn/reusing-logic-with-custom-hooks#custom-hooks-sharing-logic-between-components) som returnerar data från AEM GraphQL till vykomponenterna `Teams.js` och `Person.js`.

1. Filen `src/components/Teams.js` visar en lista med team och deras medlemmar med hjälp av en listfråga.
1. Filen `src/components/Person.js` visar information om en person med hjälp av en parametriserad fråga med ett resultat.

## Granska objektet AEMHeadless

Granska filen `aemHeadlessClient.js` för hur du skapar det `AEMHeadless`-objekt som används för att kommunicera med AEM.

1. Öppna `src/api/aemHeadlessClient.js`.

1. Granska raderna 1-40:

   - Importdeklarationen `AEMHeadless` från [AEM Headless Client för JavaScript](https://github.com/adobe/aem-headless-client-js), rad 11.

   - Auktoriseringskonfigurationen baseras på variabler som definierats i `.env.development`, rad 14-22 och, pilfunktionsuttrycket `setAuthorization`, rad 31-40.

   - `serviceUrl`-konfigurationen för den inkluderade [utvecklingsproxykonfigurationen](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app#proxy-api-requests), rad 27.

1. Raderna 42-49 är viktigast eftersom de instansierar klienten `AEMHeadless` och exporterar den för användning i hela React-appen.

```javascript
// Initialize the AEM Headless Client and export it for other files to use
const aemHeadlessClient = new AEMHeadless({
  serviceURL: serviceURL,
  endpoint: REACT_APP_GRAPHQL_ENDPOINT,
  auth: setAuthorization(),
});

export default aemHeadlessClient;
```

## Implementera för att köra beständiga AEM GraphQL-frågor

Om du vill implementera den generiska funktionen `fetchPersistedQuery(..)` för att köra AEM GraphQL beständiga frågor öppnar du filen `usePersistedQueries.js`. Funktionen `fetchPersistedQuery(..)` använder `aemHeadlessClient`-objektets `runPersistedQuery()`-funktion för att köra frågan asynkront, löftesbaserat beteende.

Senare anropar den anpassade funktionen React `useEffect` den för att hämta specifika data från AEM.

1. I `src/api/usePersistedQueries.js` **update** `fetchPersistedQuery(..)`, rad 35, med koden nedan.

```javascript
/**
 * Private, shared function that invokes the AEM Headless client.
 *
 * @param {String} persistedQueryName the fully qualified name of the persisted query
 * @param {*} queryParameters an optional JavaScript object containing query parameters
 * @returns the GraphQL data or an error message
 */
async function fetchPersistedQuery(persistedQueryName, queryParameters) {
  let data;
  let err;

  try {
    // AEM GraphQL queries are asynchronous, either await their return or use Promise-based syntax
    const response = await aemHeadlessClient.runPersistedQuery(
      persistedQueryName,
      queryParameters
    );
    // The GraphQL data is stored on the response's data field
    data = response?.data;
  } catch (e) {
    // An error occurred, return the error messages
    err = e
      .toJSON()
      ?.map((error) => error.message)
      ?.join(", ");
    console.error(e.toJSON());
  }

  // Return the GraphQL and any errors
  return { data, err };
}
```

## Implementera Teams-funktioner

Bygg sedan upp funktionaliteten för att visa teamen och deras medlemmar i React-appens huvudvy. Den här funktionen kräver:

- En ny [anpassad React useEffect-krok](https://react.dev/reference/react/useEffect#useeffect) i `src/api/usePersistedQueries.js` som anropar den `my-project/all-teams` beständiga frågan och returnerar en lista med Team Content Fragments i AEM.
- En React-komponent på `src/components/Teams.js` som anropar den nya anpassade React `useEffect`-kroken och återger teamdata.

När det är klart fylls programmets huvudvy i med teamdata från AEM.

![Teamvy](./assets/graphql-and-external-app/react-app__teams-view.png)

### Steg

1. Öppna `src/api/usePersistedQueries.js`.

1. Hitta funktionen `useAllTeams()`

1. Om du vill skapa en `useEffect`-krok som anropar den beständiga frågan `my-project/all-teams` via `fetchPersistedQuery(..)` lägger du till följande kod. Haken returnerar bara relevanta data från AEM GraphQL-svaret på `data?.teamList?.items`, vilket gör att komponenterna i vyn React kan vara agnostiska för de överordnade JSON-strukturerna.

   ```javascript
   /**
    * Custom hook that calls the 'my-project/all-teams' persisted query.
    *
    * @returns an array of Team JSON objects, and array of errors
    */
   export function useAllTeams() {
     const [teams, setTeams] = useState(null);
     const [error, setError] = useState(null);
   
     // Use React useEffect to manage state changes
     useEffect(() => {
       async function fetchData() {
         // Call the AEM GraphQL persisted query named "my-project/all-teams"
         const { data, err } = await fetchPersistedQuery(
           "my-project/all-teams"
         );
         // Sets the teams variable to the list of team JSON objects
         setTeams(data?.teamList?.items);
         // Set any errors
         setError(err);
       }
       // Call the internal fetchData() as per React best practices
       fetchData();
     }, []);
   
     // Returns the teams and errors
     return { teams, error };
   }
   ```

1. Öppna `src/components/Teams.js`

1. Hämta listan med team från AEM med kroken `useAllTeams()` i komponenten `Teams` React.

   ```javascript
   import { useAllTeams } from "../api/usePersistedQueries";
   ...
   function Teams() {
     // Get the Teams data from AEM using the useAllTeams
     const { teams, error } = useAllTeams();
     ...
   }
   ```



1. Utför den vybaserade dataverifieringen och visa ett felmeddelande eller en inläsningsindikator baserat på returnerade data.

   ```javascript
   function Teams() {
     const { teams, error } = useAllTeams();
   
     // Handle error and loading conditions
     if (error) {
       // If an error ocurred while executing the GraphQL query, display an error message
       return <Error errorMessage={error} />;
     } else if (!teams) {
       // While the GraphQL request is executing, show the Loading indicator
       return <Loading />;
     }
     ...
   }
   ```

1. Återge slutligen teamdata. Varje team som returneras från GraphQL-frågan återges med den tillhandahållna `Team` React-underkomponenten.

   ```javascript
   import React from "react";
   import { Link } from "react-router-dom";
   import { useAllTeams } from "../api/usePersistedQueries";
   import Error from "./Error";
   import Loading from "./Loading";
   import "./Teams.scss";
   
   function Teams() {
     const { teams, error } = useAllTeams();
   
     // Handle error and loading conditions
     if (error) {
       return <Error errorMessage={error} />;
     } else if (!teams) {
       return <Loading />;
     }
   
     // Teams have been populated by AEM GraphQL query. Display the teams.
     return (
       <div className="teams">
         {teams.map((team, index) => {
           return <Team key={index} {...team} />;
         })}
       </div>
     );
   }
   
   // Render single Team
   function Team({ title, shortName, description, teamMembers }) {
     // Must have title, shortName and at least 1 team member
     if (!title || !shortName || !teamMembers) {
       return null;
     }
   
     return (
       <div className="team">
         <h2 className="team__title">{title}</h2>
         <p className="team__description">{description.plaintext}</p>
         <div>
           <h4 className="team__members-title">Members</h4>
           <ul className="team__members">
             {/* Render the referenced Person models associated with the team */}
             {teamMembers.map((teamMember, index) => {
               return (
                 <li key={index} className="team__member">
                   <Link to={`/person/${teamMember.fullName}`}>
                     {teamMember.fullName}
                   </Link>
                 </li>
               );
             })}
           </ul>
         </div>
       </div>
     );
   }
   
   export default Teams;
   ```


## Implementera personfunktion

Med funktionen [Teams](#implement-teams-functionality) slutförd kan vi implementera funktionen för att hantera visningen av en gruppmedlems, eller en persons, information.

Den här funktionen kräver:

- En ny [anpassad React useEffect-krok](https://react.dev/reference/react/useEffect#useeffect) i `src/api/usePersistedQueries.js` som anropar den parametriserade `my-project/person-by-name` beständiga frågan och returnerar en person.

- En React-komponent på `src/components/Person.js` som använder en persons fullständiga namn som frågeparameter, anropar den nya anpassade React `useEffect`-kroken och återger persondata.

När du är klar återges en personvy när du väljer en persons namn i Teams-vyn.

![Person](./assets/graphql-and-external-app/react-app__person-view.png)

1. Öppna `src/api/usePersistedQueries.js`.

1. Hitta funktionen `usePersonByName(fullName)`

1. Om du vill skapa en `useEffect`-krok som anropar den beständiga frågan `my-project/all-teams` via `fetchPersistedQuery(..)` lägger du till följande kod. Haken returnerar bara relevanta data från AEM GraphQL-svaret på `data?.teamList?.items`, vilket gör att komponenterna i vyn React kan vara agnostiska för de överordnade JSON-strukturerna.

   ```javascript
   /**
    * Calls the 'my-project/person-by-name' and provided the {fullName} as the persisted query's `name` parameter.
    *
    * @param {String!} fullName the full
    * @returns a JSON object representing the person
    */
   export function usePersonByName(fullName) {
     const [person, setPerson] = useState(null);
     const [errors, setErrors] = useState(null);
   
     useEffect(() => {
       async function fetchData() {
         // The key is the variable name as defined in the persisted query, and may not match the model's field name
         const queryParameters = { name: fullName };
   
         // Invoke the persisted query, and pass in the queryParameters object as the 2nd parameter
         const { data, err } = await fetchPersistedQuery(
           "my-project/person-by-name",
           queryParameters
         );
   
         if (err) {
           // Capture errors from the HTTP request
           setErrors(err);
         } else if (data?.personList?.items?.length === 1) {
           // Set the person data after data validation
           setPerson(data.personList.items[0]);
         } else {
           // Set an error if no person could be found
           setErrors(`Cannot find person with name: ${fullName}`);
         }
       }
       fetchData();
     }, [fullName]);
   
     return { person, errors };
   }
   ```

1. Öppna `src/components/Person.js`
1. Analysera vägparametern `fullName` i komponenten `Person` och hämta persondata från AEM med hjälp av kroken `usePersonByName(fullName)`.

   ```javascript
   import { useParams } from "react-router-dom";
   import { usePersonByName } from "../api/usePersistedQueries";
   ...
   function Person() {
     // Read the person's `fullName` which is the parameter used to query for the person's details
     const { fullName } = useParams();
   
     // Query AEM for the Person's details, using the `fullName` as the filtering parameter
     const { person, error } = usePersonByName(fullName);
     ...
   }
   ```

1. Utför vybaserad dataverifiering och visa ett felmeddelande eller en inläsningsindikator baserat på returnerade data.

   ```javascript
   function Person() {
     // Read the person's `fullName` which is the parameter used to query for the person's details
     const { fullName } = useParams();
   
     // Query AEM for the Person's details, using the `fullName` as the filtering parameter
     const { person, error } = usePersonByName(fullName);
   
     // Handle error and loading conditions
     if (error) {
       return <Error errorMessage={error} />;
     } else if (!person) {
       return <Loading />;
     }
     ...
   }
   ```

1. Återge sedan persondata.

   ```javascript
   import React from "react";
   import { useParams } from "react-router-dom";
   import { usePersonByName } from "../api/usePersistedQueries";
   import { mapJsonRichText } from "../utils/renderRichText";
   import Error from "./Error";
   import Loading from "./Loading";
   import "./Person.scss";
   
   function Person() {
     // Read the person's `fullName` which is the parameter used to query for the person's details
     const { fullName } = useParams();
   
     // Query AEM for the Person's details, using the `fullName` as the filtering parameter
     const { person, error } = usePersonByName(fullName);
   
     // Handle error and loading conditions
     if (error) {
       return <Error errorMessage={error} />;
     } else if (!person) {
       return <Loading />;
     }
   
     // Render the person data
     return (
       <div className="person">
         <img
           className="person__image"
           src={process.env.REACT_APP_HOST_URI+person.profilePicture._path}
           alt={person.fullName}
         />
         <div className="person__occupations">
           {person.occupation.map((occupation, index) => {
             return (
               <span key={index} className="person__occupation">
                 {occupation}
               </span>
             );
           })}
         </div>
         <div className="person__content">
           <h1 className="person__full-name">{person.fullName}</h1>
           <div className="person__biography">
             {/* Use this utility to transform multi-line text JSON into HTML */}
             {mapJsonRichText(person.biographyText.json)}
           </div>
         </div>
       </div>
     );
   }
   
   export default Person;
   ```

## Prova appen

Granska appen [http://localhost:3000/](http://localhost:3000/) och klicka på länkarna _Medlemmar_. Du kan också lägga till fler team och/eller medlemmar i Team Alpha genom att lägga till innehållsfragment i AEM.

>[!IMPORTANT]
>
>Om du vill verifiera implementeringsändringarna eller om du inte kan få appen att fungera efter ändringarna ovan, se lösningsgrenen [grundläggande självstudiekurs](https://github.com/adobe/aem-guides-wknd-graphql/tree/solution/basic-tutorial).

## Under hålet

Öppna webbläsarens **utvecklingsverktyg** > **Nätverk** och _Filter_ för `all-teams`-begäran. Observera att GraphQL API-begäran `/graphql/execute.json/my-project/all-teams` görs mot `http://localhost:3000` och **NOT** mot värdet för `REACT_APP_HOST_URI`, till exempel `<https://publish-pxxx-exxx.adobeaemcloud.com`. Begärandena görs mot React-appens domän eftersom [proxykonfigurationen](https://create-react-app.dev/docs/proxying-api-requests-in-development/#configuring-the-proxy-manually) har aktiverats med modulen `http-proxy-middleware`.


![GraphQL API-begäran via Proxy](assets/graphql-and-external-app/graphql-api-request-via-proxy.png)


Granska huvudfilen `../setupProxy.js` och inom `../proxy/setupProxy.auth.**.js` filer observerar du hur `/content`- och `/graphql`-sökvägarna proxideras och anger att det inte är en statisk resurs.

```javascript
module.exports = function(app) {
  app.use(
    ['/content', '/graphql'],
  ...
```

Att använda den lokala proxyn är inte ett lämpligt alternativ för produktionsdistribution och mer information finns i avsnittet _Produktionsdistribution_.

## Grattis!{#congratulations}

Grattis! Du har nu skapat React-appen för att använda och visa data från AEM GraphQL API:er som en del av den grundläggande självstudiekursen!
