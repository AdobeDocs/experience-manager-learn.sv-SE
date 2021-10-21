---
title: Reaktionsapp - Exempel AEM Headless
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Ett React-program som demonstrerar hur du frågar efter innehåll med GraphQL-API:erna i AEM. Den AEM Headless-klienten för JavaScript används för att köra GraphQL-frågor som stöder programmet.
version: Cloud Service
mini-toc-levels: 1
kt: 9166
thumbnail: KT-9166.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
source-git-commit: 9c1649247c65a1fa777b7574d1ab6ab49d0f722b
workflow-type: tm+mt
source-wordcount: '600'
ht-degree: 1%

---


# Reagera app

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Ett React-program som demonstrerar hur du frågar efter innehåll med GraphQL-API:erna i AEM. Den AEM Headless-klienten för JavaScript används för att köra GraphQL-frågor som stöder programmet.

![Reagera på program](./assets/react-screenshot.png)

Det finns en komplett självstudiekurs [här](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html).

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

* [JDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
* [Node.js v10+](https://nodejs.org/en/)
* [npm 6+](https://www.npmjs.com/)
* [Git](https://git-scm.com/)

## AEM

Programmet är utformat för att ansluta till en AEM **Upphovsman** eller **Publicera** med den senaste versionen av [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest) installerade.

* [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/overview/introduction.html)
* [AEM 6.5.10+](https://experienceleague.adobe.com/docs/experience-manager-65/release-notes/service-pack/new-features-latest-service-pack.html)

Vi rekommenderar [distribuera WKND-referensplatsen till en Cloud Service-miljö](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/overview.html#coding-against-the-right-aem-version). En lokal konfiguration med [AEM Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html) eller [AEM 6.5 QuickStart jar](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=en#install-local-aem-instances) kan också användas.

## Så här använder du

1. Klona `aem-guides-wknd-graphql` databas:

   ```shell
   git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Redigera `aem-guides-wknd/react-app/.env.development` arkivera och se till att `REACT_APP_HOST_URI` pekar på AEM. Uppdatera autentiseringsmetoden (om du ansluter till en författarinstans).

   ```plain
   # Server namespace
   REACT_APP_HOST_URI=http://localhost:4503
   REACT_APP_GRAPHQL_ENDPOINT=/content/graphql/global/endpoint.json
   #AUTH (Choose one method)
   # Authentication methods: 'service-token', 'dev-token', 'basic' or leave blank to use no authentication
   ...
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

Nedan följer en kort sammanfattning av de filer och den kod som är viktiga för programmet. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql).

### AEM Headless Client for JavaScript

The [AEM Headless Client](https://github.com/adobe/aem-headless-client-js) används för att köra GraphQL-frågan. I AEM Headless Client finns två metoder för att köra frågor: [`runQuery`](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md#aemheadlessrunqueryquery-options--promiseany) och [`runPersistedQuery`](https://github.com/adobe/aem-headless-client-js/blob/main/api-reference.md#aemheadlessrunpersistedquerypath-variables-options--promiseany).

`runQuery` kör en standard GraphQL-fråga för AEM och är den vanligaste typen av frågekörning.

[Beständiga frågor](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/video-series/graphql-persisted-queries.html) är en funktion i AEM som cachelagrar resultatet av en GraphQL-fråga och sedan gör resultatet tillgängligt via GET. Beständiga frågor bör användas för vanliga frågor som kommer att köras om och om igen. I det här programmet är listan med annonser den första frågan som körs på hemskärmen. Detta blir en mycket populär fråga och därför bör en beständig fråga användas. `runPersistedQuery` kör en begäran mot en beständig frågeslutpunkt.

`src/api/useGraphQL.js` är en [Reaktionseffektkrok](https://reactjs.org/docs/hooks-overview.html#effect-hook) som lyssnar efter ändringar i parametern `query` och `path`. If `query` är tom används en beständig fråga baserat på `path`. Här skapas AEM Headless Client och används för att hämta data.

```js
function useGraphQL(query, path) {
    let [data, setData] = useState(null);
    let [errorMessage, setErrors] = useState(null);

    useEffect(() => {
      // construct a new AEMHeadless client based on the graphQL endpoint
      const sdk = new AEMHeadless({ endpoint: REACT_APP_GRAPHQL_ENDPOINT })

      // if query is not null runQuery otherwise fall back to runPersistedQuery
      const request = query ? sdk.runQuery.bind(sdk) : sdk.runPersistedQuery.bind(sdk);

      request(query || path)
        .then(({ data, errors }) => {
          //If there are errors in the response set the error message
          if(errors) {
            setErrors(mapErrors(errors));
          }
          //If data in the response set the data as the results
          if(data) {
            setData(data);
          }
        })
        .catch((error) => {
          setErrors(error);
        });
    }, [query, path]);

    return {data, errorMessage}
}
```

### Äventyrsmaterial

Appen visar i första hand en lista med annonser och ger användarna möjlighet att klicka in i informationen om ett äventyr.

`Adventures.js` - Visar en kortlista med annonser.