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
source-git-commit: 4966a48c29ae1b5d0664cb43feeb4ad94f43b4e1
workflow-type: tm+mt
source-wordcount: '596'
ht-degree: 0%

---


# AEM Headless SDK

The AEM Headless SDK is set of libraries that can be used by clients to quickly and easily interact with AEM Headless APIs over HTTP.

AEM Headless SDK finns för olika plattformar:

+ [AEM Headless SDK for client-side browsers (JavaScript)](https://github.com/adobe/aem-headless-client-js)
+ [AEM Headless SDK for server-side/Node.js (JavaScript)](https://github.com/adobe/aem-headless-client-nodejs)
+ [AEM Headless SDK for Java™](https://github.com/adobe/aem-headless-client-java)

## GraphQL-frågor

Fråga AEM GraphQL med hjälp av frågor (i motsats till [beständiga GraphQL-frågor](#persisted-graphql-queries)) kan utvecklare definiera frågor i koden och ange exakt vilket innehåll som ska begäras från AEM.

GraphQL queries tend to be less performant than persisted queries, as they are executed using HTTP POST, which is less cache-able at the CDN and AEM Dispatcher tiers.

### Exempel på koder{#graphql-queries-code-examples}

The following are code examples of how to execute a GraphQL query against AEM.

+++ JavaScript-exempel

Installera [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) genom att köra `npm install` från roten i ditt Node.js-projekt.

```
$ npm i @adobe/aem-headless-client-js
```

I det här kodexemplet visas hur du ställer AEM med [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) npm-modul använda `async/await` syntax. The AEM Headless SDK for JavaScript also supports [Promise syntax](https://github.com/adobe/aem-headless-client-js#use-aemheadless-client).

```javascript
import AEMHeadless from '@adobe/aem-headless-client-js';

// Initialize the AEMHeadless client with connection details
const aemHeadlessClient = new AEMHeadless({
    serviceURL: 'https://publish-p123-e789.adobeaemcloud.com',  // The AEM environment to query, this can be pulled out to env variables
    endpoint: '/content/cq:graphql/wknd/endpoint.json',         // The AEM GraphQL endpoint, this can be pulled out to env variables
})

async function fetchQuery(query, queryParams) {
    let data

    try {
        // AEM GraphQL queries are asynchronous, either await their return or use Promise-based .then(..) { ... } syntax
        const response = await aemHeadlessClient.runQuery(query, queryParams);
        // The GraphQL data is stored on the response's data key
        data = response.data;
    } catch (e) {
        console.error(e.toJSON())
    }

    return data;
};

// Define the GraphQL query in-code
const adventureNamesQuery = `{
    adventuresList {
        items {
            adventureName
        }
    }
}`;

let data = fetchQuery(adventureNamesQuery);
```

+++


+++ Reagera useEffect(..) exempel

Installera [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) genom att köra `npm install` från roten i React-projektet.

```
$ npm i @adobe/aem-headless-client-js
```

This code example shows how to use the [React useEffect(..) krok](https://reactjs.org/docs/hooks-effect.html) för att köra ett asynkront anrop till AEM GraphQL.

Använda `useEffect` om du vill göra det asynkrona GraphQL-anropet i React användbart eftersom det:

1. Tillhandahåller synkron wrapper för det asynkrona anropet till AEM.
1. Minskar onödig AEM.

```javascript
// src/useGraphQL.js

import { useState, useEffect } from 'react';
import AEMHeadless from '@adobe/aem-headless-client-js';

const aemHeadlessClient = new AEMHeadless({
    serviceURL: 'https://publish-p123-e789.adobeaemcloud.com', // The AEM environment to query, this can be pulled out to env variables
    endpoint: '/content/cq:graphql/global/endpoint.json'       // The AEM GraphQL endpoint, this can be pulled out to env variables
});

export function useGraphQL(query, queryParams) {
    let [data, setData] = useState(null);
    let [errors, setErrors] = useState(null);
  
    useEffect(() => {
        async function fetchData() {
            try {
                const response = await aemHeadlessClient.runQuery(query, queryParams);
                setData(response.data);
            } catch(error) {
                setErrors(error);
            };
        }
        fetchData();
    }, [query, queryParams]);
  
    return { data, errors }
}
```

Importera och använda `useGraphQL` krok i React-komponenten för att fråga AEM.

```javascript
import useGraphQL from 'useGraphQL';

const adventuresQuery = `{
    adventuresList {
        items {
            adventureName
        }
    }
}`;

let { data, errors } = useGraphQL(adventuresQuery);
```

+++

<p> </p>

## Beständiga GraphQL-frågor

Fråga AEM med GraphQL med beständiga frågor (i motsats till [vanliga GraphQL-frågor](#graphl-queries)) gör att utvecklare kan behålla en fråga (men inte dess resultat) i AEM och sedan begära att frågan ska köras efter namn. Beständiga frågor liknar begreppet lagrade procedurer i SQL-databaser.

Persisted queries tend to be more performant than regular GraphQL queries, as persisted queries are executed using HTTP GET, which is more cache-able at the CDN and AEM Dispatcher tiers. Beständiga frågor är också aktiva, definiera ett API och frigör behovet av att utvecklaren förstår detaljerna för varje modell för innehållsfragment.

### Code examples{#persisted-graphql-queries-code-examples}

The following are code examples of how to execute a GraphQL persisted query against AEM.

+++ JavaScript-exempel

Install the [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) by running the `npm install` command from the root of your Node.js project.

```
$ npm i @adobe/aem-headless-client-js
```

I det här kodexemplet visas hur du ställer AEM med [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) npm-modul använda `async/await` syntax. The AEM Headless SDK for JavaScript also supports [Promise syntax](https://github.com/adobe/aem-headless-client-js#use-aemheadless-client).

This code assumes a persisted query with the name `wknd/adventureNames` has been created on AEM Author and published to AEM Publish.

```javascript
import AEMHeadless from '@adobe/aem-headless-client-js';

// Initialize the AEMHeadless client with connection details
const aemHeadlessClient = new AEMHeadless({
    serviceURL: 'https://publish-p123-e789.adobeaemcloud.com',  // The AEM environment to query, this can be pulled out to env variables
    endpoint: '/content/cq:graphql/wknd/endpoint.json',         // The AEM GraphQL endpoint, this can be pulled out to env variables
})

async function fetchPersistedQuery(persistedQueryName) {
    let data

    try {
        // AEM GraphQL queries are asynchronous, either await their return or use Promise-based .then(..) { ... } syntax
        const response = await aemHeadlessClient.runPersistedQuery(persistedQueryName);
        // The GraphQL data is stored on the response's data field
        data = response.data;
    } catch (e) {
        console.error(e.toJSON())
    }

    return data;
};

// Execute the persisted query using its name
let data = fetchPersistedQuery('wknd/adventureNames');
```

+++

+++ Reagera useEffect(..) exempel

Install the [@adobe/aem-headless-client-js](https://github.com/adobe/aem-headless-client-js) by running the `npm install` command from the root of your React project.

```
$ npm i @adobe/aem-headless-client-js
```

I det här kodexemplet visas hur du använder [Reagera useEffect(..) hook](https://reactjs.org/docs/hooks-effect.html) to execute an asynchronous call to AEM GraphQL.

Använda `useEffect` om du vill göra det asynkrona GraphQL-anropet i React användbart eftersom:

1. Den tillhandahåller synkron wrapper för det asynkrona anropet till AEM.
1. Det minskar behovet av AEM.

Den här koden förutsätter en beständig fråga med namnet `wknd/adventureNames` har skapats på AEM Author och publicerats på AEM Publish.

```javascript
import AEMHeadless from '@adobe/aem-headless-client-js';

// Initialize the AEMHeadless client with connection details
const aemHeadlessClient = new AEMHeadless({
    serviceURL: 'https://publish-p123-e789.adobeaemcloud.com', // The AEM environment to query
    endpoint: '/content/cq:graphql/wknd/endpoint.json'         // The AEM GraphQL endpoint
})

export function fetchPersistedQuery(persistedQueryName) {
  let [data, setData] = useState(null);
  let [errors, setErrors] = useState(null);

  useEffect(async () => {
    try {
        // AEM GraphQL queries are asynchronous, either await their return or use Promise-based .then(..) { ... } syntax 
        const response = await aemHeadlessClient.runPersistedQuery(persistedQueryName);
        // The GraphQL data is stored on the response's data field
        setData(response.data);
    }.catch((error) => {
        setErrors(error);
    });

  }, [persistedQueryName]);

  return { data, errors }
}
```

Och anropa den här koden någon annanstans i React-koden.

```javascript
import useGraphL from '...';

let { data, errors } = fetchPersistedQuery('wknd/adventureNames');
```

+++

<p> </p>
