---
title: Reaktionsapp - Exempel på AEM Headless
description: Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I React-programmet visas hur du frågar efter innehåll med hjälp av AEM GraphQL API:er med hjälp av beständiga frågor.
version: Experience Manager as a Cloud Service
mini-toc-levels: 1
jira: KT-10715
thumbnail: KT-10715.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
last-substantial-update: 2023-05-10T00:00:00Z
exl-id: b1ab2a13-8b0e-4d7f-82b5-78b1dda248ba
badgeVersions: label="AEM Headless as a Cloud Service" before-title="false"
duration: 256
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '799'
ht-degree: 0%

---

# Reagera app{#react-app}

Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I React-programmet visas hur du frågar efter innehåll med hjälp av AEM GraphQL API:er med hjälp av beständiga frågor. AEM Headless Client för JavaScript används för att köra de beständiga GraphQL-frågor som ligger till grund för programmet.

![Reagera app med AEM Headless](./assets/react-app/react-app.png)

Visa [källkoden på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app)

En [fullständig stegvis självstudiekurs](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html?lang=sv-SE) som beskriver hur React-appen skapades är tillgänglig.

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Node.js v18](https://nodejs.org/en/)
+ [Git](https://git-scm.com/)

## AEM

Programmet React fungerar med följande driftsättningsalternativ för AEM. Alla distributioner kräver att [WKND-platsen v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) är installerad.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html?lang=sv-SE)
+ Lokal konfiguration med [SDK för AEM Cloud-tjänsten](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html?lang=sv-SE)
   + Kräver [JDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2Fjcr cr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)

Reaktionsprogrammet är utformat för att ansluta till en __AEM Publish__ -miljö, men det kan hämta innehåll från AEM Author om autentisering anges i React-programmets konfiguration.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql`-databasen:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Redigera filen `aem-guides-wknd-graphql/react-app/.env.development` och ställ in `REACT_APP_HOST_URI` så att den pekar på AEM-målfilen.

   Uppdatera autentiseringsmetoden om du ansluter till en författarinstans.

   ```plain
   # Server namespace
   REACT_APP_HOST_URI=https://publish-p123-e456.adobeaemcloud.com
   
   #AUTH (Choose one method)
   # Authentication methods: 'service-token', 'dev-token', 'basic' or leave blank to use no authentication
   REACT_APP_AUTH_METHOD=basic
   
   # For Bearer auth, use DEV token (dev-token) from Cloud console
   REACT_APP_DEV_TOKEN=dev-token
   
   # For Service toke auth, provide path to service token file (download file from Cloud console)
   REACT_APP_SERVICE_TOKEN=auth/service-token.json
   
   # For Basic auth, use AEM ['user','pass'] pair (eg for Local AEM Author instance)
   REACT_APP_BASIC_AUTH_USER=admin
   REACT_APP_BASIC_AUTH_PASS=admin
   ```

1. Öppna en terminal och kör kommandona:

   ```shell
   $ cd aem-guides-wknd-graphql/react-app
   $ npm install
   $ npm start
   ```

1. Ett nytt webbläsarfönster ska läsas in på [http://localhost:3000](http://localhost:3000)
1. En lista över äventyr från WKND-referensplatsen ska visas i programmet.

## Koden

Nedan följer en sammanfattning av hur React-programmet byggs, hur det ansluter till AEM Headless för att hämta innehåll med GraphQL beständiga frågor och hur dessa data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app).


### Beständiga frågor

I enlighet med bästa praxis för AEM Headless använder React-programmet AEM GraphQL beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

+ `wknd/adventures-all` beständig fråga, som returnerar alla äventyr i AEM med en förkortad uppsättning egenskaper. Den här beständiga frågan styr den inledande vyns äventyrslista.

```
# Retrieves a list of all Adventures
#
# Optional query variables:
# - { "offset": 10 }
# - { "limit": 5 }
# - { 
#    "imageFormat": "JPG",
#    "imageWidth": 1600,
#    "imageQuality": 90 
#   }
query ($offset: Int, $limit: Int, $sort: String, $imageFormat: AssetTransformFormat=JPG, $imageWidth: Int=1200, $imageQuality: Int=80) {
  adventureList(
    offset: $offset
    limit: $limit
    sort: $sort
    _assetTransform: {
      format: $imageFormat
      width: $imageWidth
      quality: $imageQuality
      preferWebp: true
  }) {
    items {
      _path
      slug
      title
      activity
      price
      tripLength
      primaryImage {
        ... on ImageRef {
          _path
          _dynamicUrl
        }
      }
    }
  }
}
```

+ `wknd/adventure-by-slug` beständig fråga, som returnerar ett enskilt äventyr från `slug` (en anpassad egenskap som unikt identifierar ett äventyr) med en fullständig uppsättning egenskaper. Den här beständiga frågan styr äventyrsdetaljvyerna.

```
# Retrieves an Adventure Fragment based on it's unique slug.
#
# Required query variables:
# - {"slug": "bali-surf-camp"}
#
# Optional query variables:
# - { 
#     "imageFormat": "JPG",
#     "imageSeoName": "my-adventure",
#     "imageWidth": 1600,
#     "imageQuality": 90 
#   }
#  
# This query returns an adventure list but since the the slug property is set to be unique in the Content Fragment Model, only a single Content Fragment is expected.

query ($slug: String!, $imageFormat:AssetTransformFormat=JPG, $imageSeoName: String, $imageWidth: Int=1200, $imageQuality: Int=80) {
  adventureList(
    filter: {slug: {_expressions: [{value: $slug}]}}
    _assetTransform: {
      format: $imageFormat
      seoName: $imageSeoName
      width: $imageWidth
      quality: $imageQuality
      preferWebp: true
  }) {
    items {
      _path
      title
      slug
      activity
      adventureType
      price
      tripLength
      groupSize
      difficulty
      price
      primaryImage {
        ... on ImageRef {
          _path
          _dynamicUrl
        }
      }
      description {
        json
        plaintext
        html
      }
      itinerary {
        json
        plaintext
        html
      }
    }
    _references {
      ... on AdventureModel {
        _path
        slug
        title
        price
        __typename
      }
    }
  }
}
```

### Kör GraphQL beständig fråga

AEM beständiga frågor körs över HTTP GET och därför används klienten [AEM Headless för JavaScript](https://github.com/adobe/aem-headless-client-js) för att [köra de beständiga GraphQL-frågorna](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md#aemheadlessrunpersistedquerypath-variables-options--promiseany) mot AEM och läsa in äventyrsinnehållet i appen.

Varje beständig fråga har en motsvarande React [useEffect](https://reactjs.org/docs/hooks-effect.html)-krok i `src/api/usePersistedQueries.js` som asynkront anropar AEM HTTP GET beständiga frågans slutpunkt och returnerar äventyrsdata.

Varje funktion anropar i sin tur `aemHeadlessClient.runPersistedQuery(...)` och kör den beständiga GraphQL-frågan.

```js
// src/api/usePersistedQueries.js

/**
 * React custom hook that returns a list of adevntures by activity. If no activity is provided, all adventures are returned.
 * 
 * Custom hook that calls the 'wknd-shared/adventures-all' or 'wknd-shared/adventures-by-activity' persisted query.
 *
 * @returns an array of Adventure JSON objects, and array of errors
 */
export function useAdventuresByActivity(adventureActivity, params = {}) {
  ...
  let queryVariables = params;

  // If an activity is provided (i.e "Camping", "Hiking"...) call wknd-shared/adventures-by-activity query
  if (adventureActivity) {
    // The key is 'activity' as defined in the persisted query
    queryVariables = { ...queryVariables, activity: adventureActivity };

    // Call the AEM GraphQL persisted query named "wknd-shared/adventures-by-activity" with parameters
    response = await fetchPersistedQuery("wknd-shared/adventures-by-activity", queryVariables);
  } else {
    // Else call the AEM GraphQL persisted query named "wknd-shared/adventures-all" to get all adventures
    response = await fetchPersistedQuery("wknd-shared/adventures-all", queryVariables);
  }
  
  ... 
}

...
/**
 * Private function that invokes the AEM Headless client.
 * 
 * @param {String} persistedQueryName the fully qualified name of the persisted query
 * @param {*} queryParameters an optional JavaScript object containing query parameters
 * @returns the GraphQL data or an error message 
 */
async function fetchPersistedQuery(persistedQueryName, queryParameters) {
  let data;
  let err;

  try {
    // AEM GraphQL queries are asynchronous, either await their return or use Promise-based .then(..) { ... } syntax
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

  return { data, err };
}
```

### Vyer

I React-programmet används två vyer för att presentera äventyrsdata i webbupplevelsen.

+ `src/components/Adventures.js`

  Anropar `getAdventuresByActivity(..)` från `src/api/usePersistedQueries.js` och visar de returnerade äventyren i en lista.

+ `src/components/AdventureDetail.js`

  Anropar `getAdventureBySlug(..)` med den `slug`-parameter som skickas via äventyrsmarkeringen i komponenten `Adventures` och visar information om ett enskilt äventyr.

### Miljövariabler

Flera [miljövariabler](https://create-react-app.dev/docs/adding-custom-environment-variables) används för att ansluta till en AEM-miljö. Standardanslutning till AEM Publish som körs vid `http://localhost:4503`. Uppdatera filen `.env.development` om du vill ändra AEM-anslutningen:

+ `REACT_APP_HOST_URI=https://publish-p123-e456.adobeaemcloud.com`: Ange som AEM-målvärd
+ `REACT_APP_GRAPHQL_ENDPOINT=/content/graphql/global/endpoint.json`: Ange slutpunktssökvägen för GraphQL. Detta används inte av React-appen eftersom den bara använder beständiga frågor.
+ `REACT_APP_AUTH_METHOD=`: Den autentiseringsmetod som rekommenderas. Valfritt, som standard används ingen autentisering.
   + `service-token`: Använd tjänstautentiseringsuppgifter för att hämta en åtkomsttoken på AEM as a Cloud Service
   + `dev-token`: Använd dev-token för lokal utveckling i AEM as a Cloud Service
   + `basic`: Använd användare/pass för lokal utveckling med lokal AEM Author
   + Lämna tomt om du vill ansluta till AEM utan autentisering
+ `REACT_APP_AUTHORIZATION=admin:admin`: Ange grundläggande autentiseringsuppgifter som ska användas vid anslutning till en AEM Author-miljö (endast för utveckling). Om du ansluter till en publiceringsmiljö är den här inställningen inte nödvändig.
+ `REACT_APP_DEV_TOKEN`: Dev-tokensträng. Om du vill ansluta till en fjärrinstans kan du förutom grundläggande autentisering (användare:pass) använda Bearer-autentisering med DEV-token från molnkonsolen
+ `REACT_APP_SERVICE_TOKEN`: Sökväg till autentiseringsuppgifter för tjänsten. Om du vill ansluta till en fjärrinstans kan du autentisera med Service Token (hämta fil från Developer Console).

### Proxy AEM-förfrågningar

När du använder webbpaketets utvecklingsserver (`npm start`) är projektet beroende av en [proxykonfiguration](https://create-react-app.dev/docs/proxying-api-requests-in-development/#configuring-the-proxy-manually) med `http-proxy-middleware`. Filen är konfigurerad på [src/setupProxy.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/setupProxy.js) och är beroende av flera anpassade miljövariabler inställda på `.env` och `.env.development`.

Om du ansluter till en AEM-redigeringsmiljö måste motsvarande [autentiseringsmetod konfigureras](#environment-variables).

### Cross-origin resource sharing (CORS)

Det här React-programmet är beroende av en AEM-baserad CORS-konfiguration som körs i AEM-målmiljön och förutsätter att React-appen körs på `http://localhost:3000` i utvecklingsläge.  Mer information om hur du konfigurerar och konfigurerar CORS finns i [AEM Headless-distributionsdokumentationen](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/spa.html?lang=sv-SE).
