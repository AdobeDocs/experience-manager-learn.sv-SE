---
title: Exportera resurser
description: Lär dig hur du exporterar och hämtar resurser i grupp på din lokala dator.
feature: Asset Management
version: Experience Manager as a Cloud Service
topic: Content Management
role: Developer
level: Experienced
last-substantial-update: 2025-04-28T00:00:00Z
doc-type: Tutorial
jira: KT-15313
thumbnail: KT-15313.jpeg
exl-id: d04c3316-6f8f-4fd1-9df1-3fe09d44f735
duration: 256
source-git-commit: 107a9a77a1bf2337f309d503a4a310d8d0781f0d
workflow-type: tm+mt
source-wordcount: '510'
ht-degree: 0%

---

# Exportera resurser

Lär dig hur du exporterar resurser till din lokala dator med ett anpassningsbart Node.js-skript. Det här exportskriptet innehåller ett exempel på hur du programmässigt hämtar resurser från AEM med [AEM Assets HTTP API:er](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/assets/admin/mac-api-assets), särskilt med fokus på de ursprungliga återgivningarna för att säkerställa högsta kvalitet. Den är utformad för att replikera mappstrukturen för AEM Assets på den lokala hårddisken, vilket gör det enkelt att säkerhetskopiera eller migrera resurser.

Skriptet hämtar bara resursens ursprungliga återgivningar, utan tillhörande metadata, såvida inte dessa metadata har bäddats in i resursen som XMP. Detta innebär att beskrivande information, kategoriseringar eller taggar som lagras i AEM men inte är integrerade i resursfilerna inte inkluderas i hämtningen. Andra återgivningar kan också laddas ned genom att skriptet ändras så att de inkluderas. Se till att du har tillräckligt med utrymme för att lagra de exporterade resurserna.

Skriptet körs vanligtvis mot AEM Author, men kan även köras mot AEM Publish så länge som AEM Assets HTTP API-slutpunkter och resursrenderingar är tillgängliga via Dispatcher.

Innan du kör skriptet måste du konfigurera det med din AEM instans-URL, inloggningsuppgifter (åtkomsttoken) och sökvägen till den mapp som du vill exportera.

## Exportera skript

Skriptet, skrivet som en JavaScript-modul, är en del av ett Node.js-projekt eftersom det är beroende av `node-fetch` och `p-limit`. Du kan kopiera skriptet nedan till ett tomt Node.js-projekt av typen `module` och köra `npm install node-fetch p-limit` för att installera beroendet.

Skriptet leder mappträdet för AEM Assets och hämtar resurser och mappar till en lokal mapp på datorn. Den använder [AEM Assets HTTP API](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/assets/admin/mac-api-assets) för att hämta mapp- och resursdata och hämtar de ursprungliga återgivningarna av resurserna.

```javascript
// export-assets.js

import fetch from 'node-fetch';
import { promises as fs } from 'fs';
import path from 'path';
import pLimit from 'p-limit';

// Do not process the contents of these well-known AEM system folders
const SKIP_FOLDERS = ['/content/dam/appdata', '/content/dam/projects', '/content/dam/_CSS', '/content/dam/_DMSAMPLE' ];

/**
 * Determine if the folder should be processed based on the entity and AEM path.
 * 
 * @param {Object} entity the AEM entity that should represent a folder returned from AEM Assets HTTP API
 * @param {String} aemPath the path in AEM of this source
 * @returns true if the entity should be processed, false otherwise
 */
function isValidFolder(entity, aemPath) {
    if (aemPath === '/content/dam') {
        return true;
    } else if (!entity.class.includes('assets/folder')) {
        return false;
    } else if (SKIP_FOLDERS.find((path) => path === aemPath)) {
        return false;
    } else if (entity.properties.hidden) {
        return false;
    }
    
    return true;
}

/**
 * Determine if the entity is downloadable.
 * @param {Object} entity the AEM entity that should represent an asset returned from AEM Assets HTTP API
 * @returns true if the entity is downloadable, false otherwise
 */
function isDownloadable(entity) {
    if (entity.class.includes('assets/folder')) {
        return false;
    } else if (entity.properties.contentFragment) {
        return false;
    }
    return true;
}

/**
 * Helper function to get the link from the entity based on the relationship name.
 * @param {Object} entity the entity from the AEM Assets HTTP API
 * @param {String} rel the relationship name
 * @returns {String} link URL
 */
function getLink(entity, rel) {
    return entity.links.find(link => link.rel.includes(rel));
}

/**
 * Helper function to fetch JSON data from the AEM Assets HTTP API.
 * @param {String} url the AEM Assets HTTP API URL to fetch data from
 * @returns {Object} the JSON response
 */
async function fetchJSON(url) {
    const response = await fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${AEM_ACCESS_TOKEN}`,
            'Content-Type': 'application/json'
        }
    });

    if (!response.ok) {
        throw new Error(`Error fetching ${url}: ${response.status}`);
    }

    return response.json();
}

/**
 * Helper function to download a file from AEM Assets.
 * @param {String} url the URL of the asset rendition to download
 * @param {String} outputPath the local path to save the downloaded file
 */
async function downloadFile(url, outputPath) {
    const response = await fetch(url, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${AEM_ACCESS_TOKEN}`,
        }
    });

    if (!response.ok) {
        throw new Error(`Failed to download file: ${response.statusText}`);
    }

    const arrayBuffer = await response.arrayBuffer();
    await fs.writeFile(outputPath, Buffer.from(arrayBuffer));

    console.log(`Downloaded asset: ${outputPath}`);
}

/**
 * Main entry point to download assets from AEM.
 * 
 * @param {Object} options 
 * @param {String} options.apiUrl (optional) the direct AEM Assets HTTP API URL
 * @param {String} options.localPath local filesystem path to save the assets
 * @param {String} options.aemPath AEM folder path
 */
async function downloadAssets({ apiUrl, localPath = LOCAL_DOWNLOAD_FOLDER, aemPath = '/content/dam' }) {
    if (!apiUrl) {
        const prefix = "/content/dam/";
        let apiPath = aemPath.startsWith(prefix) ? aemPath.substring(prefix.length) : aemPath;    

        if (!apiPath.startsWith('/')) {
            apiPath = '/' + apiPath;
        }

        apiUrl = `${AEM_HOST}/api/assets.json${apiPath}`;
    }
    
    const data = await fetchJSON(apiUrl);
    const entities = data.entities || [];

    // First, process folders
    for (const folder of entities.filter(entity => entity.class.includes('assets/folder'))) {
        const newLocalPath = path.join(localPath, folder.properties.name);
        const newAemPath = path.join(aemPath, folder.properties.name);

        if (!isValidFolder(folder, newAemPath)) {
            continue;
        }

        await fs.mkdir(newLocalPath, { recursive: true });

        await downloadAssets({
            apiUrl: getLink(folder, 'self')?.href,
            localPath: newLocalPath,
            aemPath: newAemPath
        });
    }

    // Now, process assets with concurrency limit
    const limit = pLimit(MAX_CONCURRENT_DOWNLOADS);
    const downloads = [];

    for (const asset of entities.filter(entity => entity.class.includes('assets/asset'))) {
        const assetLocalPath = path.join(localPath, asset.properties.name);
        if (isDownloadable(asset)) {
            downloads.push(limit(() => downloadFile(getLink(asset, 'content')?.href, assetLocalPath)));
        }
    }

    await Promise.all(downloads);

    // Handle pagination
    const nextUrl = getLink(data, 'next');
    if (nextUrl) {
        await downloadAssets({
            apiUrl: nextUrl?.href,
            localPath,
            aemPath
        });
    }
}

/***** SCRIPT CONFIGURATION *****/

// AEM host is the URL of the AEM environment to download the assets from
const AEM_HOST = 'https://author-p123-e456.adobeaemcloud.com';

// AEM access token used to access the AEM host. 
// This access token must have read access to the folders and assets to download.
const AEM_ACCESS_TOKEN = "eyJhbGciOiJS...zCprYZD0rSjg6g";

// The root folder in AEM to download assets from.
const AEM_ASSETS_FOLDER = '/content/dam/wknd-shared';

// The local folder to save the downloaded assets.
const LOCAL_DOWNLOAD_FOLDER = './exported-assets';

// The number of maximum concurrent downloads to avoid overwhelming the client or server.
const MAX_CONCURRENT_DOWNLOADS = 10;

/***** SCRIPT ENTRY POINT *****/

console.time('Download AEM assets');

await downloadAssets({
    aemPath: AEM_ASSETS_FOLDER,
    localPath: LOCAL_DOWNLOAD_FOLDER
}).catch(console.error);

console.timeEnd('Download AEM assets');
```

## Konfigurera exporten

När skriptet har laddats ned uppdaterar du konfigurationsvariablerna längst ned i skriptet.

`AEM_ACCESS_TOKEN` kan hämtas med hjälp av stegen i självstudiekursen [Tokenbaserad autentisering till AEM as a Cloud Service](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview). Ofta räcker det med en utvecklartoken på 24 timmar, så länge det tar mindre än 24 timmar att slutföra exporten och den användare som genererar token har läsåtkomst till resurserna som ska exporteras.

```javascript
...
/***** SCRIPT CONFIGURATION *****/

// AEM host is the URL of the AEM environment to download the assets from
const AEM_HOST = 'https://author-p123-e456.adobeaemcloud.com';

// AEM access token used to access the AEM host. 
// This access token must have read access to the folders and assets to download.
const AEM_ACCESS_TOKEN = "eyJhbGciOiJS...zCprYZD0rSjg6g";

// The root folder in AEM to download assets from.
const AEM_ASSETS_FOLDER = '/content/dam/wknd-shared';

// The local folder to save the downloaded assets.
const LOCAL_DOWNLOAD_FOLDER = './export-assets';

// The number of maximum concurrent downloads to avoid overwhelming the client or server. 10 is typically a good value.
const MAX_CONCURRENT_DOWNLOADS = 10;
```

## Exportera resurserna

Kör skriptet med Node.js för att exportera resurserna till din lokala dator.

Beroende på antalet resurser och deras storlek kan skriptet ta en stund att slutföra. När skriptet körs loggar det [förloppet](#output) till konsolen.

```shell
$ node export-assets.js
```

## Exportera utdata

Exportskriptet loggar förloppet till konsolen, vilket anger vilka resurser som hämtas. När skriptet har slutförts sparas resurserna i den lokala mappen som har angetts i konfigurationen och loggen avslutas med den totala tid det tog att hämta resurserna.

```plaintext
...
Downloaded asset: exported-assets/wknd-shared/en/magazine/skitouring/skitouring3sjoeberg.jpg
Downloaded asset: exported-assets/wknd-shared/en/magazine/skitouring/skitouring5sjoeberg.jpg
Downloaded asset: exported-assets/wknd-shared/en/magazine/skitouring/skitouring6sjoeberg.jpg
Downloaded asset: exported-assets/wknd-shared/en/magazine/western-australia/wa_camping_adobe.pdf
Downloaded asset: exported-assets/wknd-shared/en/magazine/western-australia/adobestock-156407519.jpeg
Downloaded asset: exported-assets/wknd-shared/en/magazine/western-australia/adobe-waadobe-wa-mg-3094.jpg
Downloaded asset: exported-assets/wknd-shared/en/magazine/western-australia/adobe-waadobe-wa-mg-3851.jpg
Downloaded asset: exported-assets/wknd-shared/en/magazine/western-australia/adobe-waadobe-wa-b6a7083.jpg
Downloaded asset: exported-assets/wknd-shared/en/magazine/western-australia/adobe-waadobe-wa-b6a6978.jpg
Download AEM assets: 24.770s
```

De exporterade resurserna finns i den lokala mappen som anges i konfigurationen `LOCAL_DOWNLOAD_FOLDER`. Mappstrukturen speglar mappstrukturen i AEM Assets, med resurserna hämtade till rätt undermappar. Dessa filer kan överföras till [molnlagringsleverantörer](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/assets/assets-view/bulk-import-assets-view) som stöds, för [bulkimport](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/migration/bulk-import) till andra AEM-instanser eller för säkerhetskopiering.

![Exporterade resurser](./assets/export/exported-assets.png)
