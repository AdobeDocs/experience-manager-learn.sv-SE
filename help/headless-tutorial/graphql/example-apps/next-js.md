---
title: Next.js - Exempel på AEM Headless
description: Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I det här Next.js-programmet visas hur du kan söka efter innehåll med hjälp av AEM GraphQL-API:er med hjälp av beständiga frågor.
version: Experience Manager as a Cloud Service
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
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '744'
ht-degree: 0%

---

# Next.js App

Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I det här Next.js-programmet visas hur du kan söka efter innehåll med hjälp av AEM GraphQL-API:er med hjälp av beständiga frågor. AEM Headless Client för JavaScript används för att köra de beständiga GraphQL-frågor som ligger till grund för programmet.

![appen Next.js med AEM Headless](./assets/next-js/next-js.png)

Visa [källkoden på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/next-js)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Node.js v18](https://nodejs.org/)
+ [Git](https://git-scm.com/)

## AEM

Appen Next.js fungerar med följande driftsättningsalternativ för AEM. För alla distributioner krävs att [WKND Shared v3.0.0+](https://github.com/adobe/aem-guides-wknd-shared/releases/latest) eller [WKND Site v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) installeras i AEM as a Cloud Service-miljön.

Det här exemplet på appen Next.js är utformat för att ansluta till tjänsten __AEM Publish__.

### Krav för AEM Author

Next.js är utformad för att ansluta till __AEM Publish__-tjänsten och få åtkomst till oskyddat innehåll. Next.js kan konfigureras att ansluta till AEM Author via egenskaperna `.env` som beskrivs nedan. Bilder som hanteras från AEM Author kräver autentisering, och därför måste den användare som använder appen Next.js också vara inloggad på AEM Author.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql`-databasen:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Redigera filen `aem-guides-wknd-graphql/next-js/.env.local` och ställ in `NEXT_PUBLIC_AEM_HOST` på tjänsten AEM.

   ```plain
   # AEM service
   NEXT_PUBLIC_AEM_HOST=https://publish-p123-e456.adobeaemcloud.com/
   ...
   ```

   Om du ansluter till AEM Author-tjänsten måste autentiseringen tillhandahållas eftersom AEM Author-tjänsten är säker som standard.

   Om du vill använda en lokal AEM-kontouppsättning `AEM_AUTH_METHOD=basic` och ange användarnamn och lösenord i egenskaperna `AEM_AUTH_USER` och `AEM_AUTH_PASSWORD`.

   ```plain
   ...
   # The variables are not prefixed with NEXT_PUBLIC so they are only available server-side
   AEM_AUTH_METHOD=basic
   AEM_AUTH_USER=aem-user-account 
   AEM_AUTH_PASSWORD=password-for-the-aem-user-account
   ```

   Om du vill använda en [lokal utvecklingstoken från AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/generating-access-tokens-for-server-side-apis.html?lang=sv-SE#generating-the-access-token) anger du `AEM_AUTH_METHOD=dev-token` och anger det fullständiga dev-tokenvärdet i egenskapen `AEM_AUTH_DEV_TOKEN`.

   ```plain
   ...
   # The variables are not prefixed with NEXT_PUBLIC so they are only available server-side
   AEM_AUTH_METHOD=dev-token
   AEM_AUTH_DEV_TOKEN=my-dev-token
   ```

1. Redigera filen `aem-guides-wknd-graphql/next-js/.env.local` och validera att `NEXT_PUBLIC_AEM_GRAPHQL_ENDPOINT` är inställt på rätt slutpunkt för AEM GraphQL.

   Använd GraphQL API-slutpunkten `wknd-shared` när du använder [WKND delad](https://github.com/adobe/aem-guides-wknd-shared/releases/latest) eller [WKND-plats](https://github.com/adobe/aem-guides-wknd/releases/latest).

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

I enlighet med bästa praxis för AEM Headless använder appen Next.js AEM GraphQL beständiga frågor för att fråga efter äventyrsdata. Appen använder två beständiga frågor:

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

Varje beständig fråga har en motsvarande funktion i `src/lib//aem-headless-client.js`, som anropar slutpunkten för AEM GraphQL och returnerar äventyrsdata.

Varje funktion anropar i sin tur `aemHeadlessClient.runPersistedQuery(...)` och kör den beständiga GraphQL-frågan.

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

  Använder [Next.js getServerSideProps()](https://nextjs.org/docs/basic-features/data-fetching/get-server-side-props) för att anropa `getAllAdventures()` och visar varje äventyr som ett kort.

  Användning av `getServerSiteProps()` tillåter återgivning på serversidan av den här Next.js-sidan.

+ `src/pages/adventures/[...slug].js`

  En [dynamisk väg för Next.js](https://nextjs.org/docs/routing/dynamic-routes) som visar information om ett enskilt äventyr. Den här dynamiska vägen förhämtar data för varje äventyr med hjälp av [Next.js getStaticProps()](https://nextjs.org/docs/basic-features/data-fetching/get-static-props) via ett anrop till `getAdventureBySlug(slug, queryVariables)` med hjälp av den `slug` -parameter som skickas via äventyrsmarkeringen på `adventures/index.js` -sidan och `queryVariables` för att styra bildformatet, bredden och kvaliteten.

  Den dynamiska vägen kan förhämta information för alla äventyr genom att använda [Next.js getStaticPaths()](https://nextjs.org/docs/basic-features/data-fetching/get-static-paths) och fylla i alla möjliga vägpermutationer baserat på den fullständiga listan över äventyr som returneras av GraphQL-frågan `getAdventurePaths()`

  Användningen av `getStaticPaths()` och `getStaticProps(..)` tillät generering av statiska platser för dessa Next.js-sidor.

## Distributionskonfiguration

Next.js-appar, särskilt när det gäller SSR (Server-side rendering) och SSG (Server-side generation), kräver inte avancerade säkerhetskonfigurationer som CORS (Cross-origin Resource Sharing).

Om Next.js däremot gör HTTP-begäranden till AEM från klientens kontext kan säkerhetskonfigurationer i AEM behövas. Mer information finns i självstudiekursen [AEM Headless Single-page app deployment](../deployment/spa.md).
