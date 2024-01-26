---
title: Server-till-server-appen Node.js - AEM Headless-exempel
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Det här Node.js-programmet på serversidan visar hur du kan fråga efter innehåll med hjälp AEM GraphQL API:er med beständiga frågor.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-10798
thumbnail: KT-10798.jpg
last-substantial-update: 2023-05-10T00:00:00Z
badgeVersions: label="AEM Headless as a Cloud Service" before-title="false"
exl-id: 39b21a29-a75f-4a6c-ba82-377cf5cc1726
duration: 145
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '437'
ht-degree: 0%

---

# Server-till-server-appen Node.js

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Det här server-till-server-programmet visar hur du ställer frågor till innehåll med hjälp AEM GraphQL API:er med beständiga frågor och skriver ut det på terminalen.

![Server-till-server-appen Node.js med AEM Headless](./assets/server-to-server-app/server-to-server-app.png)

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/server-to-server)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Node.js v18](https://nodejs.org/en)
+ [Git](https://git-scm.com/)

## AEM

Programmet Node.js fungerar med följande AEM distributionsalternativ. Alla distributioner kräver [WKND Site v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) installeras.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html)
+ Valfritt, [autentiseringsuppgifter för tjänst](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/generating-access-tokens-for-server-side-apis.html) om begäranden auktoriseras (till exempel anslutning till AEM författartjänst).

Det här Node.js-programmet kan ansluta till AEM Author eller AEM Publish baserat på kommandoradsparametrarna.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql` databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna en terminal och kör kommandona:

   ```shell
   $ cd aem-guides-wknd-graphql/server-to-server-app
   $ npm install
   ```

1. Appen kan köras med kommandot:

   ```
   $ node index.js <AEM_HOST> <OPTIONAL_SERVICE_CONFIG_FILE_PATH>
   ```

   Om du till exempel vill köra programmet mot AEM Publicera utan auktorisering:

   ```shell
   $ node index.js https://publish-p123-e789.adobeaemcloud.com
   ```

   Så här kör du appen mot AEM författare med behörighet:

   ```shell
   $ node index.js https://author-p123-e456.adobeaemcloud.com ./service-config.json
   ```

1. En JSON-lista med äventyr från WKND-referensplatsen ska skrivas ut i terminalen.

## Koden

Nedan följer en sammanfattning av hur programmet Node.js från server till server har skapats, hur det ansluter till AEM Headless för att hämta innehåll med GraphQL beständiga frågor och hur dessa data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/server-to-server).

Det vanligaste användningsexemplet för server-till-server-AEM Headless-appar är att synkronisera Content Fragment-data från AEM till andra system, men det här programmet är avsiktligt enkelt och skriver ut JSON-resultaten från den beständiga frågan.

### Beständiga frågor

Efter AEM Headless-metodtips används AEM GraphQL beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

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

### Skapa AEM Headless-klient

```javascript
const { AEMHeadless, getToken } = require('@adobe/aem-headless-client-nodejs');

async function run() { 

    // Parse the AEM host, and optional service credentials from the command line arguments
    const args = process.argv.slice(2);
    const aemHost = args.length > 0 ? args[0] : null;                // Example: https://author-p123-e456.adobeaemcloud.com
    const serviceCredentialsFile = args.length > 1 ? args[1] : null; // Example: ./service-config.json

    // If service credentials are provided via command line argument,
    // use `getToken(..)` to exchange them with Adobe IMS for an AEM access token 
    let accessToken;
    if (serviceCredentialsFile) {
        accessToken = (await getToken(serviceCredentialsFile)).accessToken;
    }

    // Instantiate withe AEM Headless client to query AEM GraphQL APIs
    // The endpoint is left blank since only persisted queries should be used to query AEM's GraphQL APIs
    const aemHeadlessClient = new AEMHeadless({
        serviceURL: aemHost,
        endpoint: '',           // Avoid non-persisted queries
        auth: accessToken       // accessToken only set if the 2nd command line parameter is set
    })
    ...
}
```


### Kör GraphQL beständig fråga

AEM beständiga frågor körs via HTTP-GET och därmed [AEM Headless-klient för Node.js](https://github.com/adobe/aem-headless-client-nodejs) används för att [köra beständiga GraphQL-frågor](https://github.com/adobe/aem-headless-client-nodejs#within-asyncawait) mot AEM och hämtar äventyrsinnehållet.

Den beständiga frågan anropas genom anrop `aemHeadlessClient.runPersistedQuery(...)`och skickar det beständiga GraphQL-frågenamnet. När GraphQL har skickat in uppgifterna skickar du dem till den förenklade `doSomethingWithDataFromAEM(..)` som skriver ut resultaten, men vanligtvis skickar data till ett annat system, eller skapar utdata baserat på hämtade data.

```js
// index.js

async function run() { 
    ...
    try {
        // Retrieve the data from AEM GraphQL APIs
        data = await aemHeadlessClient.runPersistedQuery('wknd-shared/adventures-all')
        
        // Do something with the data from AEM. 
        // A common use case is sending the data to another system.
        await doSomethingWithDataFromAEM(data);
    } catch (e) {
        console.error(e.toJSON())
    }
}
```
