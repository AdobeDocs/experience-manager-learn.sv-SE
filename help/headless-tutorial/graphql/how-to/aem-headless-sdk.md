---
title: Använda AEM Headless SDK
description: Lär dig hur du skapar GraphQL-frågor med AEM Headless SDK.
version: Cloud Service
topic: Headless
feature: GraphQL API
role: Developer
level: Intermediate
kt: 10269
thumbnail: KT-10269.jpeg
exl-id: 922a464a-2286-4132-9af8-f5a1fb5ce268
source-git-commit: 595d990b7d8ed3c801a085892fef38d780082a15
workflow-type: tm+mt
source-wordcount: '415'
ht-degree: 0%

---

# AEM Headless SDK

AEM Headless SDK är en uppsättning bibliotek som kunder kan använda för att snabbt och enkelt interagera med AEM Headless API:er via HTTP.

AEM Headless SDK finns för olika plattformar:

+ [AEM Headless SDK för webbläsare på klientsidan (JavaScript)](https://github.com/adobe/aem-headless-client-js)
+ [AEM Headless SDK for server-side/Node.js (JavaScript)](https://github.com/adobe/aem-headless-client-nodejs)
+ [AEM Headless SDK for Java™](https://github.com/adobe/aem-headless-client-java)

## Beständiga GraphQL-frågor

Fråga AEM med GraphQL med beständiga frågor (i motsats till [klientdefinierade GraphQL-frågor](#graphl-queries)) gör att utvecklare kan behålla en fråga (men inte dess resultat) i AEM och sedan begära att frågan ska köras efter namn. Beständiga frågor liknar begreppet lagrade procedurer i SQL-databaser.

Beständiga frågor är bättre än klientdefinierade GraphQL-frågor, eftersom beständiga frågor körs med HTTP-GET, som kan cachelagras på CDN- och AEM Dispatcher-nivåer. Beständiga frågor är också aktiva, definiera ett API och frigör behovet av att utvecklaren förstår detaljerna för varje modell för innehållsfragment.

### Exempel på koder{#persisted-graphql-queries-code-examples}

Nedan följer kodexempel på hur du kör en beständig GraphQL-fråga mot AEM.

+++ JavaScript-exempel

Installera [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) genom att köra `npm install` från roten i ditt Node.js-projekt.

```
$ npm i @adobe/aem-headless-client-js
```

I det här kodexemplet visas hur du ställer AEM med [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) npm-modul använda `async/await` syntax. AEM Headless SDK för JavaScript har också stöd för [Promise syntax](https://github.com/adobe/aem-headless-client-js#use-aemheadless-client).

Den här koden förutsätter en beständig fråga med namnet `wknd/adventureNames` har skapats på AEM Author och publicerats på AEM Publish.

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

+++ Reagera useEffect(..) exempel

Installera [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) genom att köra `npm install` från roten i React-projektet.

```
$ npm i @adobe/aem-headless-client-js
```

I det här kodexemplet visas hur du använder [Reagera useEffect(..) krok](https://reactjs.org/docs/hooks-effect.html) för att köra ett asynkront anrop till AEM GraphQL.

Använda `useEffect` om du vill göra det asynkrona GraphQL-anropet i React användbart eftersom:

1. Den tillhandahåller synkron wrapper för det asynkrona anropet till AEM.
1. Det minskar behovet av AEM.

Den här koden förutsätter en beständig fråga med namnet `wknd-shared/adventure-by-slug` har skapats på AEM Author och publicerats på AEM Publish med GraphiQL.

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

Anropa den anpassade reaktionen `useEffect` krocka från andra ställen i en React-komponent.

```javascript
import useAdventureBySlug from '...';

let { data, errors } = useAdventureBySlug('bali-surf-camp');
```

Nytt `useEffect` Det går att skapa kopplingar för varje beständig fråga som React-appen använder.

+++

<p> </p>

## GraphQL-frågor

AEM stöder klientdefinierade GraphQL-frågor, men det är AEM bästa sättet att använda [beständiga GraphQL-frågor](#persisted-graphql-queries).

