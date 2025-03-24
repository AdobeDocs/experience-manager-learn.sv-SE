---
title: Använda AEM Headless SDK
description: Lär dig hur du ställer GraphQL-frågor med AEM Headless SDK.
version: Experience Manager as a Cloud Service
topic: Headless
feature: GraphQL API
role: Developer
level: Intermediate
jira: KT-10269
thumbnail: KT-10269.jpeg
exl-id: 922a464a-2286-4132-9af8-f5a1fb5ce268
duration: 200
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '432'
ht-degree: 0%

---

# AEM Headless SDK

AEM Headless SDK är en uppsättning bibliotek som kunder kan använda för att snabbt och enkelt interagera med AEM Headless API:er via HTTP.

AEM Headless SDK finns för olika plattformar:

+ [AEM Headless SDK för webbläsare på klientsidan (JavaScript)](https://github.com/adobe/aem-headless-client-js)
+ [AEM Headless SDK för server-side/Node.js (JavaScript)](https://github.com/adobe/aem-headless-client-nodejs)
+ [AEM Headless SDK for Java™](https://github.com/adobe/aem-headless-client-java)

## Beständiga GraphQL-frågor

Genom att fråga AEM med GraphQL med hjälp av beständiga frågor (till skillnad från [klientdefinierade GraphQL-frågor](#graphl-queries)) kan utvecklare behålla en fråga (men inte dess resultat) i AEM, och sedan begära att frågan körs med namn. Beständiga frågor liknar begreppet lagrade procedurer i SQL-databaser.

Beständiga frågor är bättre än klientdefinierade GraphQL-frågor eftersom beständiga frågor körs med HTTP GET, som kan cachelagras på CDN- och AEM Dispatcher-nivåer. Beständiga frågor är också aktiva, definiera ett API och frigör behovet av att utvecklaren förstår detaljerna för varje modell för innehållsfragment.

### Exempel på koder{#persisted-graphql-queries-code-examples}

Här följer några kodexempel på hur du kör en GraphQL-beständig fråga mot AEM.

+++ Exempel på JavaScript

Installera [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) genom att köra kommandot `npm install` från roten för ditt Node.js-projekt.

```
$ npm i @adobe/aem-headless-client-js
```

I det här kodexemplet visas hur du frågar AEM med hjälp av [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) npm-modulen med syntaxen `async/await`. AEM Headless SDK för JavaScript har även stöd för [Promise-syntax](https://github.com/adobe/aem-headless-client-js#use-aemheadless-client).

Koden förutsätter att en beständig fråga med namnet `wknd/adventureNames` har skapats på AEM Author och publicerats på AEM Publish.

```javascript
import AEMHeadless from '@adobe/aem-headless-client-js';

// Initialize the AEMHeadless client with connection details
const aemHeadlessClient = new AEMHeadless({
    serviceURL: 'https://publish-p123-e789.adobeaemcloud.com',  // The AEM environment to query, this can be pulled out to env variables
    endpoint: '/content/cq:graphql/wknd-shared/endpoint.json',  // The AEM GraphQL endpoint, this is not used when invoking persisted queries.
})

/**
 * Uses the AEM Headless SDK to execute a persisted query with optional query variables.

 * @param {String} persistedQueryName the fully qualified name of the persisted query
 * @param {*} queryParameters an optional JavaScript object containing query parameters
 * @returns the GraphQL data or an error message 
 */
export async function executePersistedQuery(persistedQueryName, queryParameters) {
    let data;
    let errors;

    try {
        // AEM GraphQL queries are asynchronous, either await their return or use Promise-based .then(..) { ... } syntax
        const response = await aemHeadlessClient.runPersistedQuery(persistedQueryName, queryParameters);
        // The GraphQL data is stored on the response's data field
        data = response.data;
    } catch (e) {
        console.error(e.toJSON())
        errors = e;
    }

    return { data, errors };
};

// Execute the persisted query using its name 'wknd-shared/adventures-by-slug' and optional query variables
let { data, errors } = executePersistedQuery('wknd-shared/adventures-by-slug', { "slug": "bali-surf-camp" });
```

+++

+++ Reagera useEffect(..), exempel

Installera [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) genom att köra kommandot `npm install` från roten för React-projektet.

```
$ npm i @adobe/aem-headless-client-js
```

I det här kodexemplet visas hur du använder kroken [React useEffect(..)](https://reactjs.org/docs/hooks-effect.html) för att köra ett asynkront anrop till AEM GraphQL.

Att använda `useEffect` för att göra det asynkrona GraphQL-anropet i React är användbart eftersom:

1. Den tillhandahåller synkron wrapper för asynkront anrop till AEM.
1. Det minskar behovet av AEM.

Koden förutsätter att en beständig fråga med namnet `wknd-shared/adventure-by-slug` har skapats på AEM Author och publicerats på AEM Publish med GraphiQL.

```javascript
import AEMHeadless from '@adobe/aem-headless-client-js';
import { useEffect, useState } from "react";

// Initialize the AEMHeadless client with connection details
const aemHeadlessClient = new AEMHeadless({
    serviceURL: 'https://publish-p123-e789.adobeaemcloud.com', // The AEM environment to query
    endpoint: '/content/cq:graphql/wknd-shared/endpoint.json'         // The AEM GraphQL endpoint, this is not used when invoking persisted queries.
})

/**
 * Private, shared function that invokes the AEM Headless client. 
 * React components/views will invoke GraphQL via the custom React useEffect hooks defined below.
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

/**
 * Calls the 'wknd-shared/adventure-by-slug' and provided the {slug} as the persisted query's `slug` parameter.
 *
 * @param {String!} slug the unique slug used to specify the adventure to return
 * @returns a JSON object representing the adventure
 */
export function useAdventureBySlug(slug) {
  const [adventure, setAdventure] = useState(null);
  const [errors, setErrors] = useState(null);

  useEffect(() => {
    async function fetchData() {
      // The key is the variable name as defined in the persisted query, and may not match the model's field name
      const queryParameters = { slug: slug };
      
      // Invoke the persisted query, and pass in the queryParameters object as the 2nd parameter
      const { data, err } = await fetchPersistedQuery(
        "wknd-shared/adventure-by-slug",
        queryParameters
      );

      if (err) {
        // Capture errors from the HTTP request
        setErrors(err);
      } else if (data?.adventureList?.items?.length === 1) {
        // Set the adventure data after data validation (there should only be 1 matching adventure)
        setAdventure(data.adventureList.items[0]);
      } else {
        // Set an error if no adventure could be found
        setErrors(`Cannot find adventure with slug: ${slug}`);
      }
    }
    fetchData();
  }, [slug]);

  return { adventure, errors };
}
```

Anropa den anpassade `useEffect`-kroken från någon annan plats i en React-komponent.

```javascript
import useAdventureBySlug from '...';

let { data, errors } = useAdventureBySlug('bali-surf-camp');
```

Nya `useEffect`-kopplingar kan skapas för varje beständig fråga som React-appen använder.

+++

<p> </p>

## GraphQL-frågor

AEM stöder klientdefinierade GraphQL-frågor, men det är AEM bästa praxis att använda [beständiga GraphQL-frågor](#persisted-graphql-queries).

## Webpack 5+

AEM Headless JS SDK är beroende av `util` som inte ingår i WebPack 5+ som standard. Om du använder Webpack 5+ får du följande fel:

```
Compiled with problems:
× ERROR in ./node_modules/@adobe/aio-lib-core-errors/src/AioCoreSDKErrorWrapper.js 12:13-28
Module not found: Error: Can't resolve 'util' in '/Users/me/Code/wknd-headless-examples/node_modules/@adobe/aio-lib-core-errors/src'

BREAKING CHANGE: webpack < 5 used to include polyfills for node.js core modules by default.
This is no longer the case. Verify if you need this module and configure a polyfill for it.

If you want to include a polyfill, you need to:
    - add a fallback 'resolve.fallback: { "util": require.resolve("util/") }'
    - install 'util'
If you don't want to include a polyfill, you can use an empty module like this:
    resolve.fallback: { "util": false }
```

Lägg till följande `devDependencies` i din `package.json`-fil:

```json
  "devDependencies": {
    "buffer": "npm:buffer@^6.0.3",
    "crypto": "npm:crypto-browserify@^3.12.0",
    "http": "npm:stream-http@^3.2.0",
    "https": "npm:https-browserify@^1.0.0",
    "stream": "npm:stream-browserify@^3.0.0",
    "util": "npm:util@^0.12.5",
    "zlib": "npm:browserify-zlib@^0.2.0"
  },
```

Kör sedan `npm install` för att installera beroendena.
