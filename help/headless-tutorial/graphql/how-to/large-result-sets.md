---
title: Arbeta med stora resultatuppsättningar i AEM Headless
description: Lär dig hur du arbetar med stora resultatuppsättningar med AEM Headless.
version: Cloud Service
topic: Headless
feature: GraphQL API
role: Architect, Developer
level: Intermediate
doc-type: Article
last-substantial-update: 2023-04-14T00:00:00Z
jira: KT-13102
thumbnail: 3418381.jpeg
exl-id: 304b4d80-27bd-4336-b2ff-4b613a30f712
duration: 308
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '843'
ht-degree: 0%

---

# Stora resultatuppsättningar i AEM Headless

AEM GraphQL-frågor utan rubriker kan returnera stora resultat. I den här artikeln beskrivs hur du arbetar med stora resultat i AEM Headless för att få bästa prestanda för ditt program.

AEM Headless har stöd för en [offset/limit](#list-query) - och [markörbaserad sidnumrering](#paginated-query) -frågor till mindre delmängder av en större resultatmängd. Flera förfrågningar kan göras för att samla in så många resultat som behövs.

I exemplen nedan används små delmängder av resultat (fyra poster per begäran) för att demonstrera teknikerna. I ett verkligt program skulle du använda ett större antal poster per begäran för att förbättra prestandan. 50 poster per begäran är en bra baslinje.

## Content Fragment Model

Du kan använda sidnumrering och sortering mot alla innehållsfragmentmodeller.

## GraphQL beständiga frågor

När du arbetar med stora datauppsättningar kan både förskjutning, begränsning och markörbaserad sidnumrering användas för att hämta en viss delmängd av data. Det finns dock vissa skillnader mellan de två teknikerna som kan göra den ena mer lämplig än den andra i vissa situationer.

### Förskjutning/gräns

Listfrågor där `limit` och `offset` används ger en enkel metod som anger startpunkten (`offset`) och antalet poster som ska hämtas (`limit`). Med den här metoden kan du välja en delmängd av resultaten var som helst i den fullständiga resultatuppsättningen, till exempel hoppa till en viss resultatsida. Det är enkelt att implementera, men det kan vara långsamt och ineffektivt när du hanterar stora resultat, eftersom det krävs genomsökning av alla föregående poster för att hämta många poster. Den här metoden kan också leda till prestandaproblem när förskjutningsvärdet är högt, eftersom många resultat kan behöva hämtas och tas bort.

#### GraphQL query

```graphql
# Retrieves a list of Adventures sorted price descending, and title ascending if there is the prices are the same.
query adventuresByOffetAndLimit($offset:Int!, $limit:Int) {
    adventureList(offset: $offset, limit: $limit, sort: "price DESC, title ASC", ) {
      items {
        _path
        title
        price
      }
    }
  }
```

##### Frågevariabler

```json
{
  "offset": 1,
  "limit": 4
}
```

#### GraphQL svar

Det resulterande JSON-svaret innehåller det andra, tredje, fjärde och femte mest kostsamma äventyret. De första två äventyren i resultatet har samma pris (`4500`), så [listfrågan](#list-queries) anger äventyren med samma pris sorteras sedan efter rubrik i stigande ordning.)

```json
{
  "data": {
    "adventureList": {
      "items": [
        {
          "_path": "/content/dam/wknd-shared/en/adventures/cycling-tuscany/cycling-tuscany",
          "title": "Cycling Tuscany",
          "price": 4500
        },
        {
          "_path": "/content/dam/wknd-shared/en/adventures/west-coast-cycling/west-coast-cycling",
          "title": "West Coast Cycling",
          "price": 4500
        },
        {
          "_path": "/content/dam/wknd-shared/en/adventures/surf-camp-in-costa-rica/surf-camp-costa-rica",
          "title": "Surf Camp in Costa Rica",
          "price": 3400
        },
        {
          "_path": "/content/dam/wknd-shared/en/adventures/cycling-southern-utah/cycling-southern-utah",
          "title": "Cycling Southern Utah",
          "price": 3000
        }
      ]
    }
  }
}
```

### Sidnumrerad fråga

Markörbaserad sidnumrering, som är tillgänglig i sidnumrerade frågor, innebär att du använder en markör (en referens till en viss post) för att hämta nästa resultatuppsättning. Det här arbetssättet är effektivare eftersom det inte behövs någon genomsökning av alla tidigare poster för att hämta den datadeluppsättning som krävs. Sidnumrerade frågor fungerar bra för att iterera genom stora resultatuppsättningar från början, till en punkt i mitten eller till slutet. Listfrågor där `limit` och `offset` används ger en enkel metod som anger startpunkten (`offset`) och antalet poster som ska hämtas (`limit`). Med den här metoden kan du välja en delmängd av resultaten var som helst i den fullständiga resultatuppsättningen, till exempel hoppa till en viss resultatsida. Det är enkelt att implementera, men det kan vara långsamt och ineffektivt när du hanterar stora resultat, eftersom det krävs genomsökning av alla föregående poster för att hämta många poster. Den här metoden kan också leda till prestandaproblem när förskjutningsvärdet är högt, eftersom många resultat kan behöva hämtas och tas bort.

#### GraphQL query

```graphql
# Retrieves the most expensive Adventures (sorted by title ascending if there is the prices are the same)
query adventuresByPaginated($first:Int, $after:String) {
 adventurePaginated(first: $first, after: $after, sort: "price DESC, title ASC") {
       edges {
          cursor
          node {
            _path
            title
            price
          }
        }
        pageInfo {
          endCursor
          hasNextPage
        }
    }
  }
```

##### Frågevariabler

```json
{
  "first": 3
}
```

#### GraphQL svar

Det resulterande JSON-svaret innehåller det andra, tredje, fjärde och femte mest kostsamma äventyret. De första två äventyren i resultatet har samma pris (`4500`), så [listfrågan](#list-queries) anger äventyren med samma pris sorteras sedan efter rubrik i stigande ordning.)

```json
{
  "data": {
    "adventurePaginated": {
      "edges": [
        {
          "cursor": "NTAwMC4...Dg0ZTUwN2FkOA==",
          "node": {
            "_path": "/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp",
            "title": "Bali Surf Camp",
            "price": 5000
          }
        },
        {
          "cursor": "SFNDUwMC4wC...gyNWUyMWQ5M2Q=",
          "node": {
            "_path": "/content/dam/wknd-shared/en/adventures/cycling-tuscany/cycling-tuscany",
            "title": "Cycling Tuscany",
            "price": 4500
          }
        },
        {
          "cursor": "AVUwMC4w...0ZTYzMjkwMzE5Njc=",
          "node": {
            "_path": "/content/dam/wknd-shared/en/adventures/west-coast-cycling/west-coast-cycling",
            "title": "West Coast Cycling",
            "price": 4500
          }
        }
      ],
      "pageInfo": {
        "endCursor": "NDUwMC4w...kwMzE5Njc=",
        "hasNextPage": true
      }
    }
  }
}
```

#### Nästa uppsättning sidnumrerade resultat

Nästa resultatuppsättning kan hämtas med parametern `after` och värdet `endCursor` från föregående fråga. Om det inte finns fler resultat att hämta är `hasNextPage` `false`.

##### Frågevariabler

```json
{
  "first": 3,
  "after": "NDUwMC4w...kwMzE5Njc="
}
```

## Reaktionsexempel

Följande är React-exempel som visar hur du använder metoderna [offset och limit](#offset-and-limit) och [markörbaserad sidnumrering](#cursor-based-pagination). Vanligtvis är antalet resultat per begäran större, men för dessa exempel är gränsen satt till 5.

### Exempel på förskjutning och begränsning

>[!VIDEO](https://video.tv.adobe.com/v/3418381/?quality=12&learn=on)

Med förskjutning och begränsning kan delmängder av resultat enkelt hämtas och visas.

#### useEffect-krok

Koppeln `useEffect` anropar en beständig fråga (`adventures-by-offset-and-limit`) som hämtar en lista med annonser. Frågan använder parametrarna `offset` och `limit` för att ange startpunkten och antalet resultat som ska hämtas. Haken `useEffect` anropas när värdet `page` ändras.


```javascript
import { useState, useEffect } from "react";
import AEMHeadless from "@adobe/aem-headless-client-js";
...
export function useOffsetLimitAdventures(page, limit) {
    const [adventures, setAdventures] = useState([]);
    const [hasMore, setHasMore] = useState(true);

    useEffect(() => {
      async function fetchData() {
        const queryParameters = {
          offset: page * limit, // Calculate the offset based on the current page and the limit
          limit: limit + 1,     // Add 1 to the limit to determine if there are more adventures to fetch
        };

        // Invoke the persisted query with the offset and limit parameters
        const response = await aemHeadlessClient.runPersistedQuery(
          "wknd-shared/adventures-by-offset-and-limit",
          queryParameters
        );        
        const data = response?.data;

        if (data?.adventureList?.items?.length > 0) {
          // Collect the adventures - slice off the last item since the last item is used to determine if there are more adventures to fetch
          setAdventures([...data.adventureList.items].slice(0, limit));
          // Determine if there are more adventures to fetch
          setHasMore(data.adventureList.items.length > limit);
        } else {
          setHasMore(false);
        }
      }
      fetchData();
    }, [page]);

    return { adventures, hasMore };
}
```

#### Komponent

Komponenten använder kroken `useOffsetLimitAdventures` för att hämta en lista med annonser. Värdet `page` ökas och minskas för att hämta nästa och föregående resultatuppsättning. Värdet `hasMore` används för att avgöra om knappen för nästa sida ska aktiveras.

```javascript
import { useState } from "react";
import { useOffsetLimitAdventures } from "./api/persistedQueries";

export default function OffsetLimitAdventures() {
  const LIMIT = 5;
  const [page, setPage] = useState(0);

  let { adventures, hasMore } = useOffsetLimitAdventures(page, LIMIT);

  return (
    <section className="offsetLimit">
      <h2>Offset/limit query</h2>
      <p>Collect sub-sets of adventures using offset and limit.</p>

      <h4>Page: {page + 1}</h4>
      <p>
        Query variables:
        <em>
          <code>
            &#123; offset: {page * LIMIT}, limit: {LIMIT} &#125;
          </code>
        </em>
      </p>

      <hr />

      <ul className="adventures">
        {adventures?.map((adventure) => {
          return (
            <li key={adventure._path}>
              {adventure.title} <em>(${adventure.price})</em>
            </li>
          );
        })}
      </ul>

      <hr />

      <ul className="buttons">
        <li>
          <button disabled={page === 0} onClick={() => setPage(page - 1)}>
            Previous
          </button>
        </li>
        <li>
          <button disabled={!hasMore} onClick={() => setPage(page + 1)}>
            Next
          </button>
        </li>
      </ul>
    </section>
  );
}
```

### Sidnumrerat exempel

![Sidnumrerat exempel](./assets/large-results/paginated-example.png)

_Varje röd ruta representerar en diskret sidnumrerad HTTP GraphQL-fråga._

Med markörbaserad sidnumrering kan du enkelt hämta och visa stora resultatuppsättningar genom att samla in resultaten stegvis och sammanfoga dem med befintliga resultat.


#### UseEffect-krok

Koppeln `useEffect` anropar en beständig fråga (`adventures-by-paginated`) som hämtar en lista med annonser. Frågan använder parametrarna `first` och `after` för att ange antalet resultat som ska hämtas och markören som ska börja från. `fetchData` gör kontinuerliga slingor och samlar in nästa uppsättning sidnumrerade resultat tills det inte finns fler resultat att hämta.

```javascript
import { useState, useEffect } from "react";
import AEMHeadless from "@adobe/aem-headless-client-js";
...
export function usePaginatedAdventures() {
    const LIMIT = 5;
    const [adventures, setAdventures] = useState([]);
    const [queryCount, setQueryCount] = useState(0);

    useEffect(() => {
      async function fetchData() {
        let paginatedAdventures = [];
        let paginatedCount = 0;
        let hasMore = false;
        let after = null;
        
        do {
          const response = await aemHeadlessClient.runPersistedQuery(
            "wknd-shared/adventures-by-paginated",
            {
                first: LIMIT,
                after: after
            }
          );
          // The GraphQL data is stored on the response's data field
          const data = response?.data;

          paginatedCount = paginatedCount + 1;

          if (data?.adventurePaginated?.edges?.length > 0) {
            // Add the next set page of adventures to full list of adventures
            paginatedAdventures = [...paginatedAdventures, ...data.adventurePaginated.edges];
          }

          // If there are more adventures, set the state to fetch them
          hasMore = data.adventurePaginated?.pageInfo?.hasNextPage;
          after = data.adventurePaginated.pageInfo.endCursor;

        } while (hasMore);

        setQueryCount(paginatedCount);
        setAdventures(paginatedAdventures);
      }

      fetchData();
    }, []);

    return { adventures, queryCount };
}
```

#### Komponent

Komponenten använder kroken `usePaginatedAdventures` för att hämta en lista med annonser. Värdet `queryCount` används för att visa antalet HTTP-begäranden som har gjorts för att hämta listan med annonser.

```javascript
import { useState } from "react";
import { usePaginatedAdventures } from "./api/persistedQueries";
...
export default function PaginatedAdventures() {
  let { adventures, queryCount } = usePaginatedAdventures();

  return (
    <section className="paginated">
      <h2>Paginated query</h2>
      <p>Collect all adventures using {queryCount} cursor-paginated HTTP GraphQL requests</p>

      <hr/>
      <ul className="adventures">
        {adventures?.map((adventure) => {
          return (
            <li key={adventure.node._path}>
              {adventure.node.title} <em>(${adventure.node.price})</em>
            </li>
          );
        })}
      </ul>
      <hr/>
    </section>
  );
}
```
