---
title: Integrering av klientprogram - Avancerade koncept för AEM Headless - GraphQL
description: Implementera beständiga frågor och integrera dem i WKND-appen.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Intermediate
exl-id: d0576962-a86a-4742-8635-02be1ec3243f
duration: 290
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '927'
ht-degree: 0%

---

# Integrering av klientprogram

I föregående kapitel skapade och uppdaterade du beständiga frågor med GraphiQL Explorer.

I det här kapitlet beskrivs de olika stegen för att integrera de beständiga frågorna med WKND-klientprogrammet (även WKND App) med HTTP-GET-begäranden i befintliga **Reagera på komponenter**. Det är också en valfri utmaning att använda dina AEM Headless-kunskaper och kodningskunskaper för att förbättra WKND-klientapplikationen.

## Förutsättningar {#prerequisites}

Det här dokumentet är en del av en självstudiekurs i flera delar. Se till att föregående kapitel har fyllts i innan du fortsätter med det här kapitlet. WKND-klientprogrammet ansluter till AEM publiceringstjänst, så det är viktigt att du **publicerade följande till AEM publiceringstjänst**.

* Projektkonfigurationer
* GraphQL slutpunkter
* Modeller för innehållsfragment
* Skapat innehåll
* GraphQL beständiga frågor

The _Skärmbilder från IDE i det här kapitlet kommer från [Visual Studio Code](https://code.visualstudio.com/)_

### Kapitel 1-4 Lösningspaket (valfritt) {#solution-package}

Det finns ett lösningspaket som kan installeras och som slutför stegen i AEM för kapitel 1-4. Det här paketet är **behövs inte** om föregående kapitel har fyllts i.

1. Ladda ned [Advanced-GraphQL-Tutorial-Solution-Package-1.2.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/Advanced-GraphQL-Tutorial-Solution-Package-1.2.zip).
1. I AEM navigerar du till **verktyg** > **Distribution** > **Paket** för åtkomst **Pakethanteraren**.
1. Ladda upp och installera det paket (zip-fil) som laddats ned i föregående steg.
1. Replikera paketet till AEM

## Mål {#objectives}

I den här självstudiekursen får du lära dig hur du integrerar begäranden om beständiga frågor i exempelappen WKND GraphQL React med [AEM Headless Client for JavaScript](https://github.com/adobe/aem-headless-client-js).

## Klona och kör exempelklientprogrammet {#clone-client-app}

För att snabba upp självstudiekursen finns en React JS-app med startfunktion.

1. Klona [adobe/aem-guides-wknd-graphql](https://github.com/adobe/aem-guides-wknd-graphql) databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Redigera `aem-guides-wknd-graphql/advanced-tutorial/.env.development` fil och ange `REACT_APP_HOST_URI` för att peka på AEM publiceringstjänst.

   Uppdatera autentiseringsmetoden om du ansluter till en författarinstans.

   ```plain
   # Server namespace
   REACT_APP_HOST_URI=https://publish-pxx-eyy.adobeaemcloud.com
   
   #AUTH (Choose one method)
   # Authentication methods: 'service-token', 'dev-token', 'basic' or leave blank to use no authentication
   REACT_APP_AUTH_METHOD=
   
   # For Bearer auth, use DEV token (dev-token) from Cloud console
   REACT_APP_DEV_TOKEN=
   
   # For Service toke auth, provide path to service token file (download file from Cloud console)
   REACT_APP_SERVICE_TOKEN=auth/service-token.json
   
   # For Basic auth, use AEM ['user','pass'] pair (eg for Local AEM Author instance)
   REACT_APP_BASIC_AUTH_USER=
   REACT_APP_BASIC_AUTH_PASS=
   ```

   ![Reagera App Development Environment](assets/client-application-integration/react-app-dev-env-settings.png)


   >[!NOTE]
   > 
   > Instruktionerna ovan är att ansluta React-appen till **AEM Publiceringstjänst**, men ansluta till **AEM Author Service** hämta en lokal utvecklingstoken för AEM as a Cloud Service målmiljö.
   >
   > Det går också att ansluta appen till en [lokal författarinstans med AEMaaCS SDK](/help/headless-tutorial/graphql/quick-setup/local-sdk.md) med grundläggande autentisering.


1. Öppna en terminal och kör kommandona:

   ```shell
   $ cd aem-guides-wknd-graphql/advanced-tutorial
   $ npm install
   $ npm start
   ```

1. Ett nytt webbläsarfönster ska läsas in [http://localhost:3000](http://localhost:3000)


1. Tryck **Camping** > **Yosemite Backpackaging** om du vill visa Yosemite Backpackaging-presentationsinformation.

   ![Yosemite Backpackaging Screen](assets/client-application-integration/yosemite-backpacking-adventure.png)

1. Öppna webbläsarens utvecklarverktyg och kontrollera `XHR` förfrågan

   ![POST GraphQL](assets/client-application-integration/graphql-persisted-query.png)

   Du borde se `GET` begäranden till GraphQL-slutpunkten med projektkonfigurationsnamn (`wknd-shared`), beständigt frågenamn (`adventure-by-slug`), variabelnamn (`slug`), värde (`yosemite-backpacking`) och specialteckenkodningar.

>[!IMPORTANT]
>
>    Om du undrar varför GraphQL API-begäran görs mot `http://localhost:3000` och INTE mot AEM Publish Service-domän, granska [Under hålet](../multi-step/graphql-and-react-app.md#under-the-hood) från Grundläggande självstudiekurs.


## Granska koden

I [Grundläggande självstudiekurs - Bygg en React-app som använder AEM GraphQL API:er](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/graphql-and-react-app.html#review-the-aemheadless-object) steg som vi granskat och förbättrat några viktiga filer för att få expertis. Granska nyckelfilerna innan du förbättrar WKND-appen.

* [Granska objektet AEMHeadless](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/graphql-and-react-app.html#review-the-aemheadless-object)

* [Implementera för att köra AEM GraphQL beständiga frågor](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/graphql-and-react-app.html#implement-to-run-aem-graphql-persisted-queries)

### Granska `Adventures` Reaktionskomponent

Huvudvyn i appen WKND React är listan över alla annonser och du kan filtrera dessa annonser baserat på aktivitetstyp som _Camping, Cycling_. Den här vyn återges av `Adventures` -komponenten. Nedan finns de viktigaste implementeringsdetaljerna:

* The `src/components/Adventures.js` samtal `useAllAdventures(adventureActivity)` krok och här `adventureActivity` argument är aktivitetstyp.

* The `useAllAdventures(adventureActivity)` kroken definieras i `src/api/usePersistedQueries.js` -fil. Baserat på `adventureActivity` värdet avgör det vilken beständig fråga som ska anropas. Om värdet inte är null anropas `wknd-shared/adventures-by-activity`, annars får du alla tillgängliga äventyr `wknd-shared/adventures-all`.

* Haken använder huvudsidan `fetchPersistedQuery(..)` funktion som delegerar frågekörningen till `AEMHeadless` via `aemHeadlessClient.js`.

* Haken returnerar också endast relevanta data från AEM GraphQL-svar vid `response.data?.adventureList?.items`, som tillåter `Adventures` Reaktionsvykomponenter som är agnostiska för de överordnade JSON-strukturerna.

* När frågan har körts `AdventureListItem(..)` återgivningsfunktion från `Adventures.js` lägger till HTML-element för att visa _Bild, klipplängd, pris och titel_ information.

### Granska `AdventureDetail` Reaktionskomponent

The `AdventureDetail` Reaktionskomponenten återger detaljer om äventyret. Nedan finns de viktigaste implementeringsdetaljerna:

* The `src/components/AdventureDetail.js` samtal `useAdventureBySlug(slug)` krok och här `slug` argument är frågeparameter.

* Precis som ovan, `useAdventureBySlug(slug)` kroken definieras i `src/api/usePersistedQueries.js` -fil. Det ringer `wknd-shared/adventure-by-slug` beständig fråga genom delegering till `AEMHeadless` via `aemHeadlessClient.js`.

* När frågan har körts `AdventureDetailRender(..)` återgivningsfunktion från `AdventureDetail.js` lägger till elementet HTML för att visa Adventure-informationen.


## Förbättra koden

### Använd `adventure-details-by-slug` beständig fråga

I föregående kapitel skapade vi `adventure-details-by-slug` beständig fråga, ger ytterligare Adventure-information som _plats, instruktörsgrupp och administratör_. Låt oss ersätta `adventure-by-slug` med `adventure-details-by-slug` beständig fråga för att återge denna ytterligare information.

1. Öppna `src/api/usePersistedQueries.js`.

1. Leta reda på funktionen `useAdventureBySlug()` och uppdatera fråga som

```javascript
 ...

 // Call the AEM GraphQL persisted query named "wknd-shared/adventure-details-by-slug" with parameters
 response = await fetchPersistedQuery(
 "wknd-shared/adventure-details-by-slug",
 queryParameters
 );

 ...
```

### Visa ytterligare information

1. Om du vill visa ytterligare äventyrsinformation öppnar du `src/components/AdventureDetail.js`

1. Leta reda på funktionen `AdventureDetailRender(..)` och uppdatera returfunktionen som

   ```javascript
   ...
   
   return (<>
       <h1 className="adventure-detail-title">{title}</h1>
       <div className="adventure-detail-info">
   
           <LocationInfo {...location} />
   
           ...
   
           <Location {...location} />
   
           <Administrator {...administrator} />
   
           <InstructorTeam {...instructorTeam} />
   
       </div>
   </>); 
   
   ...
   ```

1. Definiera även motsvarande återgivningsfunktioner:

   **LocationInfo**

   ```javascript
   function LocationInfo({name}) {
   
       if (!name) {
           return null;
       }
   
       return (
           <>
               <div className="adventure-detail-info-label">Location</div>
               <div className="adventure-detail-info-description">{name}</div>
           </>
       );
   
   }
   ```

   **Plats**

   ```javascript
   function Location({ contactInfo }) {
   
       if (!contactInfo) {
           return null;
       }
   
       return (
           <>
               <div className='adventure-detail-location'>
                   <h2>Where we meet</h2>
                   <hr />
                   <div className="adventure-detail-addtional-info">Phone:{contactInfo.phone}</div>
                   <div className="adventure-detail-addtional-info">Email:{contactInfo.email}</div>
               </div>
           </>);
   }
   ```

   **InstructorTeam**

   ```javascript
   function InstructorTeam({ _metadata }) {
   
       if (!_metadata) {
           return null;
       }
   
       return (
           <>
               <div className='adventure-detail-team'>
                   <h2>Instruction Team</h2>
                   <hr />
                   <div className="adventure-detail-addtional-info">Team Name: {_metadata.stringMetadata[0].value}</div>
               </div>
           </>);
   }
   ```

   **Administratör**

   ```javascript
   function Administrator({ fullName, contactInfo }) {
   
       if (!fullName || !contactInfo) {
           return null;
       }
   
       return (
           <>
               <div className='adventure-detail-administrator'>
                   <h2>Administrator</h2>
                   <hr />
                   <div className="adventure-detail-addtional-info">Name: {fullName}</div>
                   <div className="adventure-detail-addtional-info">Phone: {contactInfo.phone}</div>
                   <div className="adventure-detail-addtional-info">Email: {contactInfo.email}</div>
               </div>
           </>);
   }
   ```

### Definiera nya format

1. Öppna `src/components/AdventureDetail.scss` och lägga till följande klassdefinitioner

   ```CSS
   .adventure-detail-administrator,
   .adventure-detail-team,
   .adventure-detail-location {
   margin-top: 1em;
   width: 100%;
   float: right;
   }
   
   .adventure-detail-addtional-info {
   padding: 10px 0px 5px 0px;
   text-transform: uppercase;
   }
   ```

>[!TIP]
>
>De uppdaterade filerna är tillgängliga under **AEM Guides WKND - GraphQL** projekt, se [Avancerad självstudiekurs](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/advanced-tutorial) -avsnitt.


När du är klar med ovanstående förbättringar ser WKND-appen ut så här nedan och webbläsarens utvecklarverktyg visar `adventure-details-by-slug` beständig fråga.

![Förbättrad WKND-APP](assets/client-application-integration/Enhanced-WKND-APP.gif)

## Utökad utmaning (valfritt)

I huvudvyn i appen WKND React kan du filtrera dessa annonser baserat på aktivitetstyp som _Camping, Cycling_. WKND:s affärsteam vill dock ha en extra _Plats_ baserad filtreringsfunktion. Kraven är

* Lägg till i det övre vänstra eller högra hörnet i WKND-appens huvudvy _Plats_ filtreringsikon.
* Klicka _Plats_ filtreringsikonen ska visa en lista med platser.
* Om du klickar på ett önskat platsalternativ i listan visas endast matchande annonser.
* Om det bara finns en matchande Adventure visas Adventure Details-vyn.

## Grattis

Grattis! Du har nu slutfört integreringen och implementeringen av de beständiga frågorna i WKND-exempelappen.
