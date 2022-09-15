---
title: Reaktionsapp - Exempel AEM Headless
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här React-programmet visas hur du frågar efter innehåll med hjälp AEM GraphQL-API:er med beständiga frågor.
version: Cloud Service
mini-toc-levels: 1
kt: 10715
thumbnail: KT-10715.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: b1ab2a13-8b0e-4d7f-82b5-78b1dda248ba
source-git-commit: b20a29e67da0bcbf53ae8089a7cde0dfde800214
workflow-type: tm+mt
source-wordcount: '941'
ht-degree: 0%

---

# Reagera app{#react-app}

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här React-programmet visas hur du frågar efter innehåll med hjälp AEM GraphQL-API:er med beständiga frågor. Den AEM Headless-klienten för JavaScript används för att köra de GraphQL-beständiga frågor som stöder programmet.

![Reagera app med AEM Headless](./assets/react-app/react-app.png)

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app)

A [steg för steg, självstudiekurs](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html) Det finns en beskrivning av hur React-appen skapades.

>[!CONTEXTUALHELP]
>id="aemcloud_sites_trial_admin_content_fragments_react_app"
>title="Anpassa innehåll i en exempelapp för React"
>abstract="Vi har skapat en modern React-app som du kan använda för att lära dig hur du anpassar innehåll med hjälp av den headless-funktionsuppsättningen."

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [JDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
+ [Node.js v10+](https://nodejs.org/en/)
+ [npm 6+](https://www.npmjs.com/)
+ [Git](https://git-scm.com/)

## AEM

Programmet React fungerar med följande AEM driftsättningsalternativ. Alla distributioner kräver [WKND Site v2.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) som ska installeras.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html)
+ Lokal installation med [AEM Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html)
+ [AEM 6.5 SP13+ QuickStart](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=en#install-local-aem-instances)

Programmet React är utformat för att ansluta till en __AEM Publish__ -miljön kan den dock hämta innehåll från AEM Author om autentisering anges i React-programmets konfiguration.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql` databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Redigera `aem-guides-wknd-graphql/react-app/.env.development` fil och ange `REACT_APP_HOST_URI` för att peka på AEM.

   Uppdatera autentiseringsmetoden om du ansluter till en författarinstans.

   ```plain
   # Server namespace
   REACT_APP_HOST_URI=http://localhost:4503
   
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

1. Ett nytt webbläsarfönster ska läsas in [http://localhost:3000](http://localhost:3000)
1. En lista över äventyr från WKND-referensplatsen ska visas i programmet.

## Koden

Nedan visas en sammanfattning av hur React-programmet byggs, hur det ansluter till AEM Headless för att hämta innehåll med hjälp av beständiga GraphQL-frågor och hur data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app).


### Beständiga frågor

Efter AEM Headless-metodtips använder React-programmet AEM GraphQL-beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

+ `wknd/adventures-all` beständig fråga, som returnerar alla äventyr i AEM med en förkortad uppsättning egenskaper. Den här beständiga frågan styr den inledande vyns äventyrslista.

```
# Retrieves a list of all adventures
{
    adventureList {
        items {
            _path
            slug
            title
            price
            tripLength
            primaryImage {
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
```

+ `wknd/adventure-by-slug` beständig fråga, som returnerar ett enda äventyr av `slug` (en anpassad egenskap som unikt identifierar ett äventyr) med en komplett uppsättning egenskaper. Den här beständiga frågan styr äventyrsdetaljvyerna.

```
# Retrieves an adventure Content Fragment based on it's slug
# Example query variables: 
# {"slug": "bali-surf-camp"} 
# Technically returns an adventure list but since the the slug 
# property is set to be unique in the CF Model, only a single CF is expected

query($slug: String!) {
  adventureList(filter: {
        slug: {
          _expressions: [ { value: $slug } ]
        }
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
          mimeType
          width
          height
        }
      }
      description {
        json
        plaintext
      }
      itinerary {
        json
        plaintext
      }
    }
    _references {
      ...on AdventureModel {
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

### Kör beständig GraphQL-fråga

AEM beständiga frågor körs via HTTP-GET och därmed [AEM Headless-klient för JavaScript](https://github.com/adobe/aem-headless-client-js) används för [köra beständiga GraphQL-frågor](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md#aemheadlessrunpersistedquerypath-variables-options--promiseany) mot AEM och läsa in äventyrsinnehållet i appen.

Varje beständig fråga har en motsvarande funktion i `src/api/persistedQueries.js`, som asynkront anropar AEM HTTP GET-slutpunkten och returnerar äventyrsdata.

Varje funktion i sin tur anropar `aemHeadlessClient.runPersistedQuery(...)`, kör den beständiga GraphQL-frågan.

```js
// src/api/persistedQueries.js

/**
 * Queries a list of all Adventures using the persisted path "wknd-shared/adventures-all"
 * @returns {data, errors}
 */
export const getAllAdventures = async function() {
    return executePersistedQuery('wknd-shared/adventures-all');
}

...

/**
 * Uses the AEM Headless SDK to execute a query besed on a persistedQueryPath and optional query variables
 * @param {*} persistedQueryPath 
 * @param {*} queryVariables 
 * @returns 
 */
 const executePersistedQuery = async function(persistedQueryPath, queryVariables) {

    let data;
    let errors;

    try {
        // AEM GraphQL queries are asynchronous, either await their return or use Promise-based .then(..) { ... } syntax
        const response = await aemHeadlessClient.runPersistedQuery(persistedQueryPath, queryVariables);
        // The GraphQL data is stored on the response's data field
        data = response.data;
        errors = response.errors ? mapErrors(response.errors) : undefined;
    } catch (e) {
        console.error(e.toJSON());
        errors = e;
    }

    return {data, errors}; 
}
```

### Vyer

I React-programmet används två vyer för att presentera äventyrsdata i webbupplevelsen.

+ `src/components/Adventures.js`

   Anropar `getAllAdventures()` från `src/api/persistedQueries.js`  och visar de returnerade äventyren i en lista.

+ `src/components/AdventureDetail.js`

   Anropar `getAdventureBySlug(..)` med `slug` param som skickas via äventyret på `Adventures` och visar information om ett enskilt äventyr.


### Miljövariabler

Flera [miljövariabler](https://create-react-app.dev/docs/adding-custom-environment-variables) används för att ansluta till en AEM. Standardanslutningar till AEM-publicering som körs på `http://localhost:4503`. Uppdatera AEM `.env.development` fil:

+ `REACT_APP_HOST_URI=http://localhost:4502`: Ange som AEM målvärd
+ `REACT_APP_GRAPHQL_ENDPOINT=/content/graphql/global/endpoint.json`: Ange slutpunktsbanan för GraphQL. Detta används inte av React-appen eftersom den bara använder beständiga frågor.
+ `REACT_APP_AUTH_METHOD=`: Den önskade autentiseringsmetoden. Valfritt, som standard används ingen autentisering.
   + `service-token`: Använd tjänstautentiseringsuppgifter för att få en åtkomsttoken på AEM as a Cloud Service
   + `dev-token`: Använd dev-token för lokal utveckling på AEM as a Cloud Service
   + `basic`: Använd användare/pass för lokal utveckling med lokal AEM Author
   + Lämna tomt om du vill ansluta till AEM utan autentisering
+ `REACT_APP_AUTHORIZATION=admin:admin`: Ange grundläggande autentiseringsuppgifter som ska användas vid anslutning till en AEM Author-miljö (endast för utveckling). Om du ansluter till en publiceringsmiljö är den här inställningen inte nödvändig.
+ `REACT_APP_DEV_TOKEN`: Dev-tokensträng. Om du vill ansluta till en fjärrinstans kan du förutom grundläggande autentisering (user:pass) använda Bearer-autentisering med DEV-token från molnkonsolen
+ `REACT_APP_SERVICE_TOKEN`: Sökväg till tjänstens autentiseringsfil. Om du vill ansluta till en fjärrinstans kan du autentisera med Service Token (hämta fil från Developer Console).

### AEM

När webbpaketets utvecklingsserver används (`npm start`) förlitar sig projektet på [proxyinställningar](https://create-react-app.dev/docs/proxying-api-requests-in-development/#configuring-the-proxy-manually) använda `http-proxy-middleware`. Filen är konfigurerad på [src/setupProxy.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/setupProxy.js) och är beroende av flera anpassade miljövariabler som är inställda på `.env` och `.env.development`.

Om du ansluter till en AEM författarmiljö, [autentiseringsmetoden måste konfigureras](#environment-variables).

### Cross-origin resource sharing (CORS)

Det här React-programmet använder en AEM CORS-konfiguration som körs i AEM och förutsätter att React-appen körs på `http://localhost:3000` i utvecklingsläge. The [CORS-konfiguration](https://github.com/adobe/aem-guides-wknd/blob/master/ui.config/src/main/content/jcr_root/apps/wknd/osgiconfig/config.author/com.adobe.granite.cors.impl.CORSPolicyImpl~wknd-graphql.cfg.json) är en del av [WKND-webbplats](https://github.com/adobe/aem-guides-wknd).

![CORS-konfiguration](assets/react-app/cross-origin-resource-sharing-configuration.png)
