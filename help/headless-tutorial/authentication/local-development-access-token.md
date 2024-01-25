---
title: Åtkomsttoken för lokal utveckling
description: AEM Local Development Access-token används för att påskynda utvecklingen av integreringar med AEM as a Cloud Service som programmässigt interagerar med AEM Author eller Publish services via HTTP.
version: Cloud Service
feature: APIs
jira: KT-6785
thumbnail: 330477.jpg
topic: Headless, Integrations
role: Developer
level: Intermediate, Experienced
last-substantial-update: 2023-01-12T00:00:00Z
doc-type: Tutorial
exl-id: 197444cb-a68f-4d09-9120-7b6603e1f47d
duration: 653
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1067'
ht-degree: 0%

---

# Åtkomsttoken för lokal utveckling

Utvecklare som bygger integreringar som kräver programmatisk åtkomst till AEM as a Cloud Service behöver ett enkelt och snabbt sätt att få temporära åtkomsttoken för AEM för att underlätta lokala utvecklingsaktiviteter. För att tillgodose detta behov kan AEM Developer Console låta utvecklare generera tillfälliga åtkomsttoken som kan användas för programmässig åtkomst till AEM.

>[!VIDEO](https://video.tv.adobe.com/v/330477?quality=12&learn=on)

## Generera en lokal åtkomsttoken för utveckling

![Hämta en lokal åtkomsttoken för utveckling](assets/local-development-access-token/getting-a-local-development-access-token.png)

Token för lokal utvecklingsåtkomst ger åtkomst till AEM författar- och publiceringstjänster som den användare som skapade token, tillsammans med deras behörigheter. Trots att detta är en utvecklingstoken bör du inte dela denna token eller lagra den i källkontrollen.

1. I [Adobe Admin Console](https://adminconsole.adobe.com/) säkerställa att du, utvecklaren, är medlem i
   + __Cloud Manager - utvecklare__ IMS-produktprofil (ger åtkomst till AEM Developer Console)
   + Antingen __AEM administratörer__ eller __AEM__ IMS-produktprofil för AEM tjänst som åtkomsttoken kan integreras med
   + Sandbox AEM as a Cloud Service environment require membership in either __AEM administratörer__ eller __AEM__ Produktprofil
1. Logga in på [Adobe Cloud Manager](https://my.cloudmanager.adobe.com)
1. Öppna programmet som innehåller den AEM as a Cloud Service miljön att integrera med
1. Tryck på __ellips__ bredvid miljön i __Miljö__ och markera __Developer Console__
1. Tryck på __Integreringar__ tab
1. Tryck på __Lokal token__ tab
1. Tryck __Hämta lokal utvecklingstoken__ knapp
1. Tryck på __hämtningsknapp__ i det övre vänstra hörnet för att ladda ned JSON-filen som innehåller `accessToken` och spara JSON-filen på en säker plats på utvecklingsdatorn.
   + Detta är din dygnet-runt-token för utvecklaråtkomst till den AEM as a Cloud Service miljön.

![AEM Developer Console - integreringar - Get Local Development Token](./assets/local-development-access-token/developer-console.png)

## Använde token för lokal utvecklingsåtkomst{#use-local-development-access-token}

![Åtkomsttoken för lokal utveckling - externt program](assets/local-development-access-token/local-development-access-token-external-application.png)

1. Hämta den temporära Local Development Access-token från AEM Developer Console
   + Den lokala utvecklingsåtkomsttoken upphör att gälla var 24:e timme, så utvecklare måste hämta nya åtkomsttoken varje dag
1. Ett externt program utvecklas som programmässigt interagerar med AEM as a Cloud Service
1. Det externa programmet läser i åtkomsttoken för lokal utveckling
1. Det externa programmet konstruerar HTTP-begäranden till AEM as a Cloud Service och lägger till Local Development Access Token som en Bearer-token i HTTP-begärandenas auktoriseringshuvud
1. AEM as a Cloud Service tar emot HTTP-begäran, autentiserar begäran och utför det arbete som begärdes av HTTP-begäran och returnerar ett HTTP-svar till det externa programmet

### Externt exempelprogram

Vi ska skapa ett enkelt externt JavaScript-program som visar hur du programmässigt får åtkomst AEM as a Cloud Service via HTTPS med hjälp av den lokala utvecklaråtkomsttoken. Detta visar hur _alla_ program eller system som körs utanför AEM, oavsett ramverk eller språk, kan använda åtkomsttoken för att programmässigt autentisera till, och komma åt, AEM as a Cloud Service. I [nästa avsnitt](./service-credentials.md)uppdaterar vi den här programkoden så att den stöder metoden att generera en token för användning i produktionen.

Det här exempelprogrammet körs från kommandoraden och uppdaterar metadata AEM resurser med hjälp av AEM Assets HTTP API:er, med följande flöde:

1. Läser in parametrar från kommandoraden (`getCommandLineParams()`)
1. Hämtar åtkomsttoken som används för att autentisera till AEM as a Cloud Service (`getAccessToken(...)`)
1. Visar alla resurser i en AEM resursmapp som anges i kommandoradsparametrar (`listAssetsByFolder(...)`)
1. Uppdatera metadata för resurser i listan med värden som anges i kommandoradsparametrar (`updateMetadata(...)`)

Nyckelelementet för programmatisk autentisering till AEM med åtkomsttoken är att lägga till en HTTP-begäranderubrik för auktorisering till alla HTTP-begäranden som görs till AEM, i följande format:

+ `Authorization: Bearer ACCESS_TOKEN`

## Kör det externa programmet

1. Se till att [Node.js](/help/cloud-service/local-development-environment/development-tools.md?lang=en#node-js) installeras på din lokala utvecklingsdator, som används för att köra det externa programmet
1. Ladda ned och zippa upp [externt exempelprogram](./assets/aem-guides_token-authentication-external-application.zip)
1. Kör från kommandoraden i projektmappen `npm install`
1. Kopiera [laddade ned Local Development Access Token](#download-local-development-access-token) till en fil med namnet `local_development_token.json` i projektets rot
   + Men kom ihåg att aldrig binda några referenser till Git!
1. Öppna `index.js` och granska programkoden och kommentarerna.

   ```javascript
   const fetch = require('node-fetch');
   const fs = require('fs');
   const auth = require('@adobe/jwt-auth');
   
   // The root context of the Assets HTTP API
   const ASSETS_HTTP_API = '/api/assets';
   
   // Command line parameters
   let params = { };
   
   /**
   * Application entry point function
   */
   (async () => {
       console.log('Example usage: node index.js aem=https://author-p1234-e5678.adobeaemcloud.com propertyName=metadata/dc:rights "propertyValue=WKND Limited Use" folder=/wknd-shared/en/adventures/napa-wine-tasting file=credentials-file.json' );
   
       // Parse the command line parameters
       params = getCommandLineParams();
   
       // Set the access token to be used in the HTTP requests to be local development access token
       params.accessToken = await getAccessToken(params.developerConsoleCredentials);
   
       // Get a list of all the assets in the specified assets folder
       let assets = await listAssetsByFolder(params.folder);
   
       // For each asset, update it's metadata
       await assets.forEach(asset => updateMetadata(asset, { 
           [params.propertyName]: params.propertyValue 
       }));
   })();
   
   /**
   * Returns a list of Assets HTTP API asset URLs that reference the assets in the specified folder.
   * 
   * https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/admin/mac-api-assets.html?lang=en#retrieve-a-folder-listing
   * 
   * @param {*} folder the Assets HTTP API folder path (less the /content/dam path prefix)
   */
   async function listAssetsByFolder(folder) {
       return fetch(`${params.aem}${ASSETS_HTTP_API}${folder}.json`, {
               method: 'get',
               headers: { 
                   'Content-Type': 'application/json',
                   'Authorization': 'Bearer ' + params.accessToken // Provide the AEM access token in the Authorization header
               },
           })
           .then(res => {
               console.log(`${res.status} - ${res.statusText} @ ${params.aem}${ASSETS_HTTP_API}${folder}.json`);
   
               // If success, return the JSON listing assets, otherwise return empty results
               return res.status === 200 ? res.json() : { entities: [] };
           })
           .then(json => { 
               // Returns a list of all URIs for each non-content fragment asset in the folder
               return json.entities
                   .filter((entity) => entity['class'].indexOf('asset/asset') === -1 && !entity.properties.contentFragment)
                   .map(asset => asset.links.find(link => link.rel.find(r => r === 'self')).href);
           });
   }
   
   /**
   * Update the metadata of an asset in AEM
   * 
   * https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/admin/mac-api-assets.html?lang=en#update-asset-metadata
   * 
   * @param {*} asset the Assets HTTP API asset URL to update
   * @param {*} metadata the metadata to update the asset with
   */
   async function updateMetadata(asset, metadata) {        
       await fetch(`${asset}`, {
               method: 'put',
               headers: { 
                   'Content-Type': 'application/json',
                   'Authorization': 'Bearer ' + params.accessToken // Provide the AEM access token in the Authorization header
               },
               body: JSON.stringify({
                   class: 'asset',
                   properties: metadata
               })
           })
           .then(res => { 
               console.log(`${res.status} - ${res.statusText} @ ${asset}`);
           });
   }
   
   /**
   * Parse and return the command line parameters. Expected params are:
   * 
   * - aem = The AEM as a Cloud Service hostname to connect to.
   *              Example: https://author-p12345-e67890.adobeaemcloud.com
   * - folder = The asset folder to update assets in. Note that the Assets HTTP API do NOT use the JCR `/content/dam` path prefix.
   *              Example: '/wknd-shared/en/adventures/napa-wine-tasting'
   * - propertyName = The asset property name to update. Note this is relative to the [dam:Asset]/jcr:content node of the asset.
   *              Example: metadata/dc:rights
   * - propertyValue = The value to update the asset property (specified by propertyName) with.
   *              Example: "WKND Free Use"
   * - file = The path to the JSON file that contains the credentials downloaded from AEM Developer Console
   *              Example: local_development_token_cm_p1234-e5678.json 
   */
   function getCommandLineParams() {
       let parameters = {};
   
       // Parse the command line params, splitting on the = delimiter
       for (let i = 2; i < process.argv.length; i++) {
           let key = process.argv[i].split('=')[0];
           let value = process.argv[i].split('=')[1];
   
           parameters[key] = value;
       };
   
       // Read in the credentials from the provided JSON file
       if (parameters.file) {
           parameters.developerConsoleCredentials = JSON.parse(fs.readFileSync(parameters.file));
       }
   
       console.log(parameters);
   
       return parameters;
   }
   
   async function getAccessToken(developerConsoleCredentials) {s
       if (developerConsoleCredentials.accessToken) {
           // This is a Local Development access token
           return developerConsoleCredentials.accessToken;
       } 
   }
   ```

   Granska `fetch(..)` inbjudningar i `listAssetsByFolder(...)` och `updateMetadata(...)`och meddela `headers` definiera `Authorization` HTTP-begärandehuvud med värdet `Bearer ACCESS_TOKEN`. Det är så här HTTP-begäran som kommer från det externa programmet autentiseras till AEM as a Cloud Service.

   ```javascript
   ...
   return fetch(`${params.aem}${ASSETS_HTTP_API}${folder}.json`, {
               method: 'get',
               headers: { 
                   'Content-Type': 'application/json',
                   'Authorization': 'Bearer ' + params.accessToken // Provide the AEM access token in the Authorization header
               },
   })...
   ```

   Alla HTTP-begäranden som AEM as a Cloud Service måste ange Bearer-åtkomsttoken i auktoriseringshuvudet. Kom ihåg att varje AEM as a Cloud Service miljö kräver en egen åtkomsttoken. Utvecklingens åtkomsttoken fungerar inte på scenen eller i produktionen, scenen fungerar inte på utveckling eller produktion och produktionens fungerar inte på utvecklingsfasen eller scenen!

1. Med kommandoraden från projektets rot kör du programmet och skickar följande parametrar:

   ```shell
   $ node index.js \
       aem=https://author-p1234-e5678.adobeaemcloud.com \
       folder=/wknd-shared/en/adventures/napa-wine-tasting \
       propertyName=metadata/dc:rights \
       propertyValue="WKND Limited Use" \
       file=local_development_token.json
   ```

   Följande parametrar skickas:

   + `aem`: Schemat och värdnamnet för den AEM as a Cloud Service miljön som programmet interagerar med (t.ex. `https://author-p1234-e5678.adobeaemcloud.com`).
   + `folder`: Resursmappens sökväg vars resurser uppdateras med `propertyValue`; lägg INTE till `/content/dam` prefix (ex. `/wknd-shared/en/adventures/napa-wine-tasting`)
   + `propertyName`: Namnet på den resursegenskap som ska uppdateras, relativt till `[dam:Asset]/jcr:content` (ex. `metadata/dc:rights`).
   + `propertyValue`: Det värde som ska anges för `propertyName` till; värden med mellanslag måste kapslas in med `"` (ex. `"WKND Limited Use"`)
   + `file`: Den relativa sökvägen till JSON-filen som hämtas från AEM Developer Console.

   En lyckad körning av programresultatet för varje resurs som har uppdaterats:

   ```shell
   200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd-shared/en/adventures/napa-wine-tasting.json
   200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd-shared/en/adventures/napa-wine-tasting/AdobeStock_277654931.jpg.json
   200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd-shared/en/adventures/napa-wine-tasting/AdobeStock_239751461.jpg.json
   200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd-shared/en/adventures/napa-wine-tasting/AdobeStock_280313729.jpg.json
   200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd-shared/en/adventures/napa-wine-tasting/AdobeStock_286664352.jpg.json
   ```

### Verifiera metadatauppdatering i AEM

Kontrollera att metadata har uppdaterats genom att logga in i den AEM as a Cloud Service miljön (se till att samma värd skickas till `aem` kommandoradsparameter används).

1. Logga in i den AEM as a Cloud Service miljön som det externa programmet interagerade med (använd samma värd som finns i `aem` kommandoradsparameter)
1. Navigera till __Resurser__ > __Filer__
1. Navigera till resursmappen som anges av `folder` kommandoradsparameter, till exempel __WKND__ > __Engelska__ > __Annonser__ > __Napa-vinsprovning__
1. Öppna __Egenskaper__ för alla (icke-innehållsfragment) resurser i mappen
1. Tryck på __Avancerat__ tab
1. Granska värdet på den uppdaterade egenskapen, till exempel __Copyright__ som mappas till den uppdaterade `metadata/dc:rights` JCR-egenskap, som återspeglar värdet i `propertyValue` parameter, till exempel __WKND Begränsad användning__

![Uppdatering av metadata för begränsad användning i WKND](./assets/local-development-access-token/asset-metadata.png)

## Nästa steg

Nu när vi programmässigt har kommit åt AEM as a Cloud Service med hjälp av den lokala utvecklingstoken. Därefter måste vi uppdatera programmet så att det kan hanteras med tjänstens autentiseringsuppgifter, så att det här programmet kan användas i ett produktionssammanhang.

+ [Så här använder du tjänstens autentiseringsuppgifter](./service-credentials.md)
