---
title: Next.js - Exempel på AEM Headless
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här Next.js-programmet visas hur du frågar efter innehåll med hjälp AEM GraphQL API:er med beständiga frågor.
version: Cloud Service
mini-toc-levels: 1
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-10721
thumbnail: KT-10721.jpg
last-substantial-update: 2023-05-10T00:00:00Z
badgeVersions: label="AEM Headless as a Cloud Service" before-title="false"
exl-id: 4f67bb37-416a-49d9-9d7b-06c3573909ca
duration: 210
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '744'
ht-degree: 0%

---

# Next.js App

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här Next.js-programmet visas hur du frågar efter innehåll med hjälp AEM GraphQL API:er med beständiga frågor. AEM Headless Client för JavaScript används för att köra GraphQL beständiga frågor som stöder programmet.

![Next.js-appen med AEM Headless](./assets/next-js/next-js.png)

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/next-js)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Node.js v18](https://nodejs.org/)
+ [Git](https://git-scm.com/)

## AEM

Appen Next.js fungerar med följande AEM driftsättningsalternativ. Alla distributioner kräver [WKND delad v3.0.0+](https://github.com/adobe/aem-guides-wknd-shared/releases/latest) eller [WKND Site v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) installeras i den AEM as a Cloud Service miljön.

Det här exemplet på appen Next.js är utformat för att ansluta till __AEM Publish__ service.

### Krav för AEM författare

Next.js är utformad för att ansluta till __AEM Publish__ och få tillgång till oskyddat innehåll. Next.js kan konfigureras att ansluta till AEM Author via `.env` egenskaper som beskrivs nedan. Bilder som hanteras från AEM författare kräver autentisering, och därför måste användaren som använder appen Next.js också loggas in AEM Author.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql` databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Redigera `aem-guides-wknd-graphql/next-js/.env.local` fil och ange `NEXT_PUBLIC_AEM_HOST` till AEM.

   ```plain
   # AEM service
   NEXT_PUBLIC_AEM_HOST=https://publish-p123-e456.adobeaemcloud.com/
   ...
   ```

   Om du ansluter till AEM Author-tjänsten måste du ange AEM Author-tjänsten som standard.

   Använda en lokal AEM `AEM_AUTH_METHOD=basic` och ange användarnamn och lösenord i `AEM_AUTH_USER` och `AEM_AUTH_PASSWORD` egenskaper.

   ```plain
   ...
   # The variables are not prefixed with NEXT_PUBLIC so they are only available server-side
   AEM_AUTH_METHOD=basic
   AEM_AUTH_USER=aem-user-account 
   AEM_AUTH_PASSWORD=password-for-the-aem-user-account
   ```

   Så här använder du [AEM as a Cloud Service lokal utvecklingstoken](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/generating-access-tokens-for-server-side-apis.html#generating-the-access-token) set `AEM_AUTH_METHOD=dev-token` och ange det fullständiga dev-tokenvärdet i `AEM_AUTH_DEV_TOKEN` -egenskap.

   ```plain
   ...
   # The variables are not prefixed with NEXT_PUBLIC so they are only available server-side
   AEM_AUTH_METHOD=dev-token
   AEM_AUTH_DEV_TOKEN=my-dev-token
   ```

1. Redigera `aem-guides-wknd-graphql/next-js/.env.local` fil och validera  `NEXT_PUBLIC_AEM_GRAPHQL_ENDPOINT` är inställd på rätt AEM GraphQL-slutpunkt.

   När du använder [WKND delad](https://github.com/adobe/aem-guides-wknd-shared/releases/latest) eller [WKND-plats](https://github.com/adobe/aem-guides-wknd/releases/latest), använder du `wknd-shared` GraphQL API-slutpunkt.

   ```plain
   ...
   NEXT_PUBLIC_AEM_GRAPHQL_ENDPOINT=wknd-shared
   ...
   ```

1. Öppna en kommandotolk och starta appen Next.js med följande kommandon:

   ```shell
   $ cd aem-guides-wknd-graphql/next-js
   $ npm install
   $ npm run dev
   ```

1. Ett nytt webbläsarfönster öppnar appen Next.js på [http://localhost:3000](http://localhost:3000)
1. I appen Next.js visas en lista med äventyr. Om du väljer ett äventyr öppnas informationen på en ny sida.

## Koden

Nedan följer en sammanfattning av hur appen Next.js byggs, hur den ansluter till AEM Headless för att hämta innehåll med GraphQL beständiga frågor och hur data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/next-js).

### Beständiga frågor

Efter AEM Headless-metodtips använder appen Next.js AEM GraphQL beständiga frågor för att fråga efter äventyrsdata. Appen använder två beständiga frågor:

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

+ `wknd/adventure-by-slug` beständig fråga, som returnerar ett enda äventyr av `slug` (en anpassad egenskap som unikt identifierar ett äventyr) med en komplett uppsättning egenskaper. Den här beständiga frågan styr äventyrsdetaljvyerna.

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

AEM beständiga frågor körs via HTTP-GET och därmed [AEM Headless-klient för JavaScript](https://github.com/adobe/aem-headless-client-js) används för att [köra beständiga GraphQL-frågor](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md#aemheadlessrunpersistedquerypath-variables-options--promiseany) mot AEM och läsa in äventyrsinnehållet i appen.

Varje beständig fråga har en motsvarande funktion i `src/lib//aem-headless-client.js`, som anropar den AEM GraphQL-slutpunkten och returnerar äventyrsdata.

Varje funktion i sin tur anropar `aemHeadlessClient.runPersistedQuery(...)`, kör den beständiga GraphQL-frågan.

```js
// src/lib/aem-headless-client.js

...
/**
 * Invokes the 'adventures-all` persisted query using the parameterizable namespace.
 * 
 * @returns a GraphQL response of all adventures.
 */
async getAllAdventures() {
  const queryAdventuresAll = process.env.NEXT_PUBLIC_AEM_GRAPHQL_ENDPOINT + '/adventures-all';
    
  try {
    return await this.aemHeadlessClient.runPersistedQuery(queryAdventuresAll);
  } catch(e) {
    console.error(e)
  }    
}

// And so on, and so forth ... 

async getAdventureSlugs(queryVariables) { ... }

async getAdventuresBySlug(slug, queryVariables) { ... }
...
```

### Sidor

Appen Next.js använder två sidor för att presentera äventyrsdata.

+ `src/pages/index.js`

  Användningsområden [Next.js&#39;s getServerSideProps()](https://nextjs.org/docs/basic-features/data-fetching/get-server-side-props) ringa `getAllAdventures()` och visar varje äventyr som ett kort.

  Användning av `getServerSiteProps()` möjliggör återgivning på serversidan av denna Next.js-sida.

+ `src/pages/adventures/[...slug].js`

  A [Next.js Dynamic Route](https://nextjs.org/docs/routing/dynamic-routes) som visar information om ett enskilt äventyr. Den här dynamiska vägen förhämtar varje annons data med [Next.js&#39;s getStaticProps()](https://nextjs.org/docs/basic-features/data-fetching/get-static-props) via ett samtal till `getAdventureBySlug(slug, queryVariables)` med `slug` param som skickas via äventyret på `adventures/index.js` och `queryVariables` för att styra bildformat, bredd och kvalitet.

  Den dynamiska vägen kan förhämta information för alla äventyr genom att använda [Next.js getStaticPaths()](https://nextjs.org/docs/basic-features/data-fetching/get-static-paths) och fylla i alla möjliga ruttpermutationer baserat på den fullständiga listan över äventyr som returneras av GraphQL-frågan  `getAdventurePaths()`

  Användning av `getStaticPaths()` och `getStaticProps(..)` tillåter Statisk platsgenerering för dessa Next.js-sidor.

## Distributionskonfiguration

Next.js-appar, särskilt när det gäller SSR (Server-side rendering) och SSG (Server-side generation), kräver inte avancerade säkerhetskonfigurationer som CORS (Cross-origin Resource Sharing).

Om Next.js däremot gör HTTP-begäranden till AEM från klientens kontext kan säkerhetskonfigurationer i AEM behövas. Granska [AEM Headless single-page app deployment tutorial](../deployment/spa.md) för mer information.
