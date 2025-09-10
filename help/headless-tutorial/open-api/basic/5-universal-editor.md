---
title: Redigera React App med Universal Editor | Headless Tutorial Part 5
description: Lär dig hur du gör React-appen redigerbar i AEM Universal Editor genom att lägga till de nödvändiga instrumenteringarna och konfigurationerna.
version: Experience Manager as a Cloud Service
mini-toc-levels: 1
feature: Content Fragments
topic: Headless, Content Management
role: Developer
level: Beginner
duration: 800
source-git-commit: da3bfa25a424e3176fb7d53189169515db225228
workflow-type: tm+mt
source-wordcount: '759'
ht-degree: 0%

---


# Redigera React-appen med Universal Editor

I det här kapitlet får du lära dig hur du kan göra React-appen som byggts i det [föregående kapitlet](./4-react-app.md) redigerbar med AEM Universal Editor. Med den universella redigeraren kan skribenter redigera innehåll direkt i sammanhanget med React-appupplevelsen samtidigt som de bibehåller den sömlösa upplevelsen av ett headless-program.

![Universell redigerare](./assets/5/main.png)

Universell redigerare är ett kraftfullt sätt att aktivera kontextredigering för alla webbprogram, så att författare kan redigera innehåll utan att behöva växla mellan olika redigeringsgränssnitt.

## Förutsättningar

* Föregående steg i den här självstudiekursen har slutförts, närmare bestämt [Skapa en React-app där AEM Content Fragment Delivery OpenAPI:er används](./4-react-app.md)
* En arbetskunskap om [hur du använder och implementerar Universal Editor](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/developing/universal-editor/introduction).

## Mål

Lär dig mer om:

* Lägg till Universal Editor-instrumentering i React-appen.
* Konfigurera React-appen för Universal Editor.
* Aktivera redigering direkt i React-appens gränssnitt med Universal Editor.

## Universell redigeringsinstrumentering

Universell redigerare kräver [HTML-attribut och metataggar](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/developing/universal-editor/attributes-types) för att identifiera redigerbart innehåll och upprätta en anslutning mellan användargränssnittet och AEM-innehållet.

### Lägg till taggar för Universal Editor

Lägg först till de metataggar som krävs för att identifiera React-appen som Universal Editor-kompatibel.

1. Öppna `public/index.html` i React-appen.
1. Lägg till [metataggar för Universal Editor och CORS-skript](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/developing/universal-editor/getting-started) i avsnittet `<head>` i React-appen:

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="utf-8" />
       <link rel="icon" href="%PUBLIC_URL%/favicon.ico" />
       <meta name="viewport" content="width=device-width, initial-scale=1" />
       <meta name="theme-color" content="#000000" />
       <meta name="description" content="WKND Teams React App" />
   
       <!-- Universal Editor meta tags and CORS script -->
       <meta name="urn:adobe:aue:system:aemconnection" content="aem:%REACT_APP_AEM_AUTHOR_HOST_URI%" />
       <script src="https://universal-editor-service.adobe.io/cors.js"></script>
   
       <link rel="apple-touch-icon" href="%PUBLIC_URL%/logo192.png" />
       <link rel="manifest" href="%PUBLIC_URL%/manifest.json" />
       <title>WKND Teams</title>
   </head>
   <body>
       <noscript>You need to enable JavaScript to run this app.</noscript>
       <div id="root"></div>
   </body>
   </html>
   ```

1. Uppdatera React-appens `.env`-fil så att den innehåller AEM Author-tjänstvärden som stöder återskrivningar i Universal Editor (används i värdet för metat-taggen `urn:adobe:aue:system:aemconnection`).

   ```bash
   # The AEM Publish (or Preview) service
   REACT_APP_HOST_URI=https://publish-p123-e456.adobeaemcloud.com
   
   # The AEM Author service
   REACT_APP_AEM_AUTHOR_HOST_URI=https://author-p123-e456.adobeaemcloud.com
   ```

### Instrumentet för teamkomponenten

Nu kan du lägga till attribut för Universal Editor för att göra teamkomponenten redigerbar.

1. Öppna `src/components/Teams.js`.
1. Uppdatera `Team`-komponenten så att den innehåller [attribut för Universal Editor](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/developing/universal-editor/attributes-types):

   När du anger attributet `data-aue-resource` kontrollerar du att AEM-sökvägen till innehållsfragmentet, som returneras av AEM Content Fragment Delivery med OpenAPI-API:er, är postfix med undersökvägen till varianten för innehållsfragment, i det här fallet `/jcr:content/data/master`.

   ```javascript
   import { useEffect, useState } from "react";
   import { Link } from "react-router-dom";
   import "./Teams.scss";
   
   function Teams() {
   
   // The teams folder is the only folder-tree that is allowed to contain Team Content Fragments.
   const TEAMS_FOLDER = '/content/dam/my-project/en/teams';
   
   // State to store the teams data
   const [teams, setTeams] = useState(null);
   
   useEffect(() => {
       /**
       * Fetches all teams and their associated member details
       * This is a two-step process:
       * 1. First, get all team content fragments from the specified folder
       * 2. Then, for each team, fetch the full details including hydrated references to get the team member names
       */
       const fetchData = async () => {
       try {
           // Step 1: Fetch all teams from the teams folder
           const response = await fetch(
           `${process.env.REACT_APP_HOST_URI}/adobe/contentFragments?path=${TEAMS_FOLDER}`
           );
           const allTeams = (await response.json()).items || [];
   
           // Step 2: Fetch detailed information for each team with hydrated references
           const hydratedTeams = [];
           for (const team of allTeams) {
               const hydratedTeamResponse = await fetch(
                   `${process.env.REACT_APP_HOST_URI}/adobe/contentFragments/${team.id}?references=direct-hydrated`
               );
               hydratedTeams.push(await hydratedTeamResponse.json());
           }
   
           setTeams(hydratedTeams);
       } catch (error) {
           console.error("Error fetching content fragments:", error);
       }
       };
   
       fetchData();
   }, [TEAMS_FOLDER]);
   
   // Show loading state while teams data is being fetched
   if (!teams) {
       return <div>Loading teams...</div>;
   }
   
   // Render the teams
   return (
       <div className="teams">
       {teams.map((team, index) => {
           return (
           <Team
               key={index}
               {...team}
           />
           );
       })}
       </div>
   );
   }
   
   /**
   * Team - renders a single team with its details and members
   * @param {Object} fields - The authored Content Fragment fields
   * @param {Object} references - Hydrated references containing member details such as fullName
   * @param {string} path - Path of the team content fragment
   */
   function Team({ fields, references, path }) {
   if (!fields.title || !fields.teamMembers) {
       return null;
   }
   
   return (
       <>
       {/* Specify the correct Content Fragment variation path suffix in the data-aue-resource attribute */}
       <div className="team"
           data-aue-resource={`urn:aemconnection:${path}/jcr:content/data/master`}
           data-aue-type="component"
           data-aue-label={fields.title}>
   
           <h2 className="team__title"
           data-aue-prop="title"
           data-aue-type="text"
           data-aue-label="Team Title">{fields.title}</h2>
           <p className="team__description"
           data-aue-prop="description"
           data-aue-type="richtext"
           data-aue-label="Team Description"
           dangerouslySetInnerHTML={{ __html: fields.description.value }}
           />
           <div>
           <h4 className="team__members-title">Members</h4>
           <ul className="team__members">
               {fields.teamMembers.map((teamMember, index) => {
               return (
                   <li key={index} className="team__member">
                   <Link to={`/person/${teamMember}`}>
                       {references[teamMember].value.fields.fullName}
                   </Link>
                   </li>
               );
               })}
           </ul>
           </div>
       </div>
       </>
   );
   }
   
   export default Teams;
   ```

### Personens instrument

Lägg på samma sätt till attribut för Universal Editor i komponenten Person.

1. Öppna `src/components/Person.js`.
1. Uppdatera komponenten så att den innehåller [attribut för Universal Editor](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/developing/universal-editor/attributes-types):

   När du anger attributet `data-aue-resource` kontrollerar du att AEM-sökvägen till innehållsfragmentet, som returneras av AEM Content Fragment Delivery med OpenAPI-API:er, är postfix med undersökvägen till varianten för innehållsfragment, i det här fallet `/jcr:content/data/master`.

   ```javascript
   import "./Person.scss";
   import { useEffect, useState } from "react";
   import { useParams } from "react-router-dom";
   
   /**
   * Person component - displays detailed information about a single person
   * Fetches person data from AEM using the ID from the URL parameters
   */
   function Person() {
       const { id } = useParams();
       const [person, setPerson] = useState(null);
   
       useEffect(() => {
           const fetchData = async () => {
           try {
               const response = await fetch(
               `${process.env.REACT_APP_HOST_URI}/adobe/contentFragments/${id}?references=direct-hydrated`
               );
               const json = await response.json();
               setPerson(json || null);
           } catch (error) {
               console.error("Error fetching person data:", error);
           }
           };
           fetchData();
       }, [id]);
   
       if (!person) {
           return <div>Loading person...</div>;
       }
   
       /* Add the Universal Editor data-aue-* attirbutes to the rendered HTML */
       return (
           <div className="person"
               data-aue-resource={`urn:aemconnection:${person.path}/jcr:content/data/master`}
               data-aue-type="component"
               data-aue-label={person.fields.fullName}>
               <img className="person__image"
                   src={process.env.REACT_APP_HOST_URI + person.references[person.fields.profilePicture].value.path}
                   alt={person.fields.fullName}
                   data-aue-prop="profilePicture"
                   data-aue-type="media"
                   data-aue-label="Profile Picture"
               />
               <div className="person__occupations">
                   {person.fields.occupation.map((occupation, index) => {
                   return (
                       <span key={index} className="person__occupation">
                           {occupation}
                       </span>
                   );
                   })}
               </div>
   
               <div className="person__content">
                   <h1 className="person__full-name"
                       data-aue-prop="fullName"
                       data-aue-type="text"
                       data-aue-label="Full Name">
                       {person.fields.fullName}
                   </h1>
                   <div className="person__biography"
                       data-aue-prop="biographyText"
                       data-aue-type="richtext"
                       data-aue-label="Biography"
                       dangerouslySetInnerHTML={{ __html: person.fields.biographyText.value }}
                   />
               </div>
           </div>
       );
   }
   ```

### Hämta den färdiga koden

Den fullständiga källkoden för det här kapitlet är [tillgänglig på Github.com](https://github.com/adobe/aem-tutorials/tree/headless_open-api_basic_5-end).


```bash
$ git fetch --tags
$ git tag
$ git checkout tags/headless_open-api_basic_5-end
```

## Testa integreringen i Universal Editor

Testa nu kompatibilitetsuppdateringarna i Universal Editor genom att öppna React-appen i Universal Editor.

### Starta React-appen

1. Kontrollera att React-appen körs:

   ```bash
   $ cd ~/Code/aem-guides-wknd-openapi/basic-tutorial
   $ npm install
   $ npm start
   ```

1. Verifiera att appen läses in på `http://localhost:3000` och visar team- och personinnehåll.

### Kör lokal SSL-proxy

Den universella redigeraren kräver att det redigerbara programmet läses in via HTTPS.

1. Använd modulen [local-ssl-proxy](https://www.npmjs.com/package/local-ssl-proxy) npm från kommandoraden om du vill köra den lokala React-appen över HTTPS.

   ```bash
   $ npm install -g local-ssl-proxy
   $ local-ssl-proxy --source 3001 --target 3000
   ```

1. Öppna `https://localhost:3001` i webbläsaren
1. Acceptera det självsignerade certifikatet.
1. Kontrollera att React-appen läses in.

### Öppna i Universal Editor

![Öppna appen i Universal Editor](./assets/5/open-app-in-universal-editor.png)

1. Navigera till [Universal Editor](https://experience.adobe.com/#/@myOrg/aem/editor/canvas/).
1. I fältet **Webbplats-URL** anger du HTTPS React-app-URL:en: `https://localhost:3001`.
1. Välj Klicka på **Öppna**.

Den universella redigeraren bör läsa in React-appen med redigeringsfunktionerna aktiverade.

### Testa redigeringsfunktioner

![Redigera i universell redigerare](./assets/5/edit-in-universal-editor.png)

1. Håll muspekaren över redigerbara element i React-appen i Universal Editor.

1. Om du vill navigera i React-appen aktiverar och inaktiverar du läget **Förhandsgranska** för att redigera. Kom ihåg att **förhandsgranskningen** inte har något med AEM Preview-tjänsten att göra, utan att den aktiverar och inaktiverar redigeringsfunktionen i den universella redigeraren.

1. Du bör se redigeringsindikatorer och kunna klicka på de olika redigerbara elementen i React-appen.

1. Försök redigera en teamtitel:
   * Klicka på en teamtitel
   * Redigera texten i egenskapspanelen
   * Spara ändringarna

1. Prova att redigera en persons profilbild:
   * Klicka på en persons profilbild
   * Välj en ny bild från resursväljaren
   * Spara ändringarna

1. Tryck på **Publicera** i det övre högra hörnet av Universal Editor för att publicera redigeringar i tjänsten AEM Publish (eller Preview) så att de återspeglas i React-appen i Universal Editor.

## Universella redigeringsdataattribut

Fullständig dokumentation om hur du instrumenterar ett program för Universal Editor finns i [dokumentationen för Universal Editor](https://experience.adobe.com/#/@myOrg/aem/editor/canvas/).

## Grattis!

Grattis! Du har nu integrerat Universal Editor med React-appen. Innehållsförfattare kan nu redigera innehållsfragment direkt i appgränssnittet React, vilket ger en smidig redigeringsupplevelse och samtidigt behåller fördelarna med en headless-arkitektur.

Kom ihåg att du alltid kan hämta den slutliga källkoden för den här självstudiekursen från `main`-grenen i [GitHub.com](https://github.com/adobe/aem-tutorials/tree/main).
