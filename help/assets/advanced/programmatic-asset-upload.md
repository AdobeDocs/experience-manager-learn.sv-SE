---
title: Programmatisk överföring av resurser till AEM as a Cloud Service
description: Lär dig hur du överför resurser till AEM as a Cloud Service med biblioteket @adobe/aem-upload Node.js.
version: Experience Manager as a Cloud Service
topic: Development, Content Management
feature: Asset Management
role: Developer
level: Intermediate
last-substantial-update: 2025-11-14T00:00:00Z
doc-type: Tutorial
jira: KT-19571
thumbnail: KT-19571.png
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '1585'
ht-degree: 0%

---


# Programmatisk överföring av resurser till AEM as a Cloud Service

Lär dig hur du överför resurser till AEM as a Cloud Service-miljön med klientprogrammet som använder biblioteket [aem-upload](https://github.com/adobe/aem-upload) Node.js.


>[!VIDEO](https://video.tv.adobe.com/v/3476956?captions=swe&quality=12&learn=on)


## Vad du lär dig

I den här självstudiekursen lär du dig:

+ Så här använder du metoden _direkt binär överföring_ för att överföra resurser till AEM as a Cloud Service-miljön (RDE, Dev, Stage, Prod) med biblioteket [aem-upload](https://github.com/adobe/aem-upload) Node.js.
+ Så här konfigurerar och kör du programmet [aem-asset-upload-sample](./assets/programmatic-asset-upload/aem-asset-upload-sample.zip) för att överföra resurser till AEM as a Cloud Service-miljön.
+ Granska exempelprogramkoden och förstå implementeringsinformationen.
+ Lär dig de bästa sätten att överföra programmatiska resurser till AEM as a Cloud Service-miljö.

## Om metoden _direkt binär överföring_

Med metoden _direkt binär överföring_ kan du överföra filer från källsystemet _direkt till molnlagringen_ i AEM as a Cloud Service-miljön med en _försignerad URL_. Man slipper slussa binära data genom AEM Java-processer vilket ger snabbare överföringar och minskad serverbelastning.

Innan du kör exempelprogrammet måste du förstå det direkta binära överföringsflödet.

I direkt binär överföring överförs binära data direkt till molnlagringen med försignerade URL:er. AEM as a Cloud Service ansvarar för enkel bearbetning som att generera försignerade URL:er och meddela AEM Asset Compute Service om att överföringen är slutförd. Följande logiska flödesdiagram visar det direkta binära överföringsflödet.

![Direkt binärt överföringsflöde](./assets/programmatic-asset-upload/direct-binary-asset-upload-flow.png)

### Biblioteket för aem-upload

[aem-upload](https://github.com/adobe/aem-upload) Node.js-biblioteket abstraherar implementeringsinformationen för _direct binary upload_ -metoden. Den innehåller två klasser för att samordna överföringsprocessen:

+ **FileSystemUpload** - Använd det när du överför filer från det lokala filsystemet, inklusive stöd för katalogstrukturer
+ **DirectBinaryUpload** - Använd den för mer detaljerad kontroll över den binära överföringsprocessen, till exempel överföring från strömmar eller buffertar

>[!CAUTION]
>
>Det finns ingen motsvarighet till biblioteket [aem-upload](https://github.com/adobe/aem-upload) i Java. Klientprogrammet måste skrivas i Node.js för att metoden _direkt binär överföring_ ska kunna användas. Mer information finns på sidan [Experience Manager Assets API:er och åtgärder](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/assets/admin/developer-reference-material-apis#use-cases-and-apis).

## Exempelprogram

Använd programmet [aem-asset-upload-sample](./assets/programmatic-asset-upload/aem-asset-upload-sample.zip) för att lära dig den programmatiska resursöverföringsprocessen. Exempelprogrammet demonstrerar användningen av både `FileSystemUpload` och `DirectBinaryUpload` klasser från biblioteket [aem-upload](https://github.com/adobe/aem-upload).

### Förutsättningar

Innan du kör exempelprogrammet bör du kontrollera att du har följande krav:

+ AEM as a Cloud Service utvecklingsmiljö, t.ex. Rapid Development Environment (RDE), Dev Environment
+ Node.js (senaste LTS-versionen)
+ Grundläggande förståelse för Node.js och npm

>[!CAUTION]
>
> Du kan INTE använda AEM as a Cloud Service SDK (kallas lokal AEM-instans) för att testa den programmatiska resursöverföringsprocessen. Du måste använda en AEM as a Cloud Service-miljö som t.ex. Rapid Development Environment (RDE), Dev Environment.

### Hämta exempelprogrammet

1. Hämta zip-filen [aem-asset-upload-sample](./assets/programmatic-asset-upload/aem-asset-upload-sample.zip) för programmet och extrahera den.

   ```bash
   $ unzip aem-asset-upload-sample.zip
   ```

1. Öppna den extraherade mappen i din favoritkodredigerare.

   ```bash
   $ cd aem-asset-upload-sample
   $ code .
   ```

1. Installera beroendena med kodredigerarens terminal.

   ```bash
   $ npm install
   ```

   ![Exempelprogram](./assets/programmatic-asset-upload/install-dependencies.png)

### Konfigurera exempelprogrammet

Innan du kör exempelprogrammet måste du konfigurera det med nödvändig AEM as a Cloud Service-miljöinformation som AEM författar-URL, _autentiseringsmetod_ och resursmappsökväg.

Det finns _flera autentiseringsmetoder_ som stöds av biblioteket [aem-upload](https://github.com/adobe/aem-upload) Node.js. I följande tabell sammanfattas de _autentiseringsmetoder_ som stöds och deras syfte.

| | Grundläggande autentisering | [Lokal utvecklingstoken](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/local-development-access-token) | [Tjänstautentiseringsuppgifter](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials) | [OAuth S2S](https://developer.adobe.com/developer-console/docs/guides/authentication/ServerToServerAuthentication/) | [OAuth-webbapp](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/implementation#oauth-web-app-credential) | [OAuth SPA](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/implementation#oauth-single-page-app-credential) |
|---|---|---|---|---|---|---|
| Stöds? | &check; | &check; | &check; | &cross; | &cross; | &cross; |
| Syfte | Lokal utveckling | Lokal utveckling | Produktion | Ej tillämpligt | Ej tillämpligt | Ej tillämpligt |

Följ stegen nedan för att konfigurera exempelprogrammet:

1. Kopiera filen `env.example` till filen `.env`.

   ```bash
   $ cp env.example .env
   ```

1. Öppna filen `.env` och uppdatera miljövariabeln `AEM_URL` med URL:en för AEM as a Cloud Service-författaren.

1. Välj autentiseringsmetod bland följande alternativ och uppdatera motsvarande miljövariabler.

>[!BEGINTABS]

>[!TAB Grundläggande autentisering]

Om du vill använda grundläggande autentisering måste du skapa en användare i AEM as a Cloud Service-miljön.

1. Logga in i din AEM as a Cloud Service-miljö.

1. Navigera till **Verktyg** > **Dokumentskydd** > **Användare** och klicka på knappen **Skapa** .

   ![Skapa användare](./assets/programmatic-asset-upload/create-user.png)

1. Ange användarinformation

   ![Användarinformation](./assets/programmatic-asset-upload/user-details.png)

1. Lägg till gruppen **DAM-användare** på fliken **Grupper**. Klicka på knappen **Spara och stäng**.

   ![Lägg till DAM-användargrupp](./assets/programmatic-asset-upload/add-dam-users-group.png)

1. Uppdatera miljövariablerna `AEM_USERNAME` och `AEM_PASSWORD` med användarnamnet och lösenordet för den skapade användaren.

>[!TAB Lokal utvecklingstoken]

Om du vill hämta den lokala utvecklingstoken måste du använda **AEM** Developer Console. Den genererade token är av JSON Web Token-typ.

1. Logga in på [Adobe Cloud Manager](https://experience.adobe.com/#/@aem/cloud-manager) och navigera till den önskade informationssidan för **Miljö**. Klicka på **..** och välj **Developer Console**.

   ![Developer Console](./assets/programmatic-asset-upload/developer-console.png)

1. Logga in på AEM Developer Console och använd knappen _Ny konsol_ för att växla till den nyare konsolen.

1. I avsnittet **Verktyg** väljer du **Integrationer** och klickar på knappen **Hämta lokal token** .

   ![Hämta lokal token](./assets/programmatic-asset-upload/get-local-token.png)

1. Kopiera tokenvärdet och uppdatera miljövariabeln `AEM_BEARER_TOKEN` med tokenvärdet.

Observera att den lokala utvecklingstoken är giltig i 24 timmar och utfärdas för den användare som genererade token.

>[!TAB Tjänstautentiseringsuppgifter]

Du måste använda **AEM** Developer Console för att få inloggningsuppgifterna för tjänsten. Den används för att generera token för JSON Web Token-typen (JWT) med modulen [jwt-auth](https://www.npmjs.com/package/@adobe/jwt-auth) npm.

1. Logga in på [Adobe Cloud Manager](https://experience.adobe.com/#/@aem/cloud-manager) och navigera till den önskade informationssidan för **Miljö**. Klicka på **..** och välj **Developer Console**.

   ![Developer Console](./assets/programmatic-asset-upload/developer-console.png)

1. Logga in på AEM Developer Console och använd knappen _Ny konsol_ för att växla till den nyare konsolen.

1. I avsnittet **Verktyg** väljer du **Integrationer** och klickar på knappen **Skapa nytt tekniskt konto** .

   ![Hämta autentiseringsuppgifter för tjänsten](./assets/programmatic-asset-upload/get-service-credentials.png)

1. Klicka på alternativet **Visa** om du vill kopiera JSON-inloggningsuppgifterna för tjänsten.

   ![Tjänstautentiseringsuppgifter](./assets/programmatic-asset-upload/service-credentials.png)

1. Skapa en `service-credentials.json`-fil i roten för exempelprogrammet och klistra in JSON-tjänstens inloggningsuppgifter i filen.

1. Uppdatera miljövariabeln `AEM_SERVICE_CREDENTIALS_FILE` med sökvägen till filen service-credentials.json.

1. Kontrollera att tjänstens autentiseringsuppgifter-användare har de behörigheter som krävs för att överföra resurser till AEM as a Cloud Service-miljön. Mer information finns på sidan [Konfigurera åtkomst i AEM](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials#configure-access-in-aem).

>[!ENDTABS]

Här är ett fullständigt exempel på `.env`-fil med alla tre autentiseringsmetoderna konfigurerade.

```
# AEM Environment Configuration
# Copy this file to .env and fill in your AEM as a Cloud Service details

# AEM as a Cloud Service Author URL (without trailing slash)
# Example: https://author-p12345-e67890.adobeaemcloud.com
AEM_URL=https://author-p63947-e1733365.adobeaemcloud.com

# Upload Configuration
# Target folder in AEM DAM where assets will be uploaded
TARGET_FOLDER=/content/dam

# DirectBinaryUpload Remote URLs (required for DirectBinaryUpload example)
# URLs for remote files to upload in the DirectBinaryUpload example
# These demonstrate uploading from remote sources (URLs, CDNs, APIs)
REMOTE_FILE_URL_1=https://placehold.co/600x400/red/white?text=Adobe+Experience+Manager+Assets

################################################################
# Authentication - Choose one of the following methods:
################################################################

# Method 1: Service Credentials (RECOMMENDED for production)
# Download service credentials JSON from AEM Developer Console and save it locally
# Then provide the path to the file here
AEM_SERVICE_CREDENTIALS_FILE=./service-credentials.json

# Method 2: Bearer Token Authentication (for manual testing)
AEM_BEARER_TOKEN=eyJhbGciOiJSUzI1NiIsIng1dSI6Imltc19uYTEta2V5LWF0LTEuY2VyIiwia2lkIjoiaW1zX25hM....fsdf-Rgt5hm_8FHutTyNQnkj1x1SUs5OkqUfJaGBaKBKdqQ

# Method 3: Basic Authentication (for development/testing only)
AEM_USERNAME=asset-uploader-local-user
AEM_PASSWORD=asset-uploader-local-user

# Optional: Enable detailed logging
DEBUG=false
```

### Kör exempelprogrammet

I exempelprogrammet visas tre olika sätt att överföra exempelresurser till AEM as a Cloud Service-miljön.

1. **FileSystemUpload** - Överför filer från ett lokalt filsystem med stöd för katalogstruktur och skapande av automatiska mappar
1. **DirectBinaryUpload** - Överför en [fjärrfil](https://placehold.co/600x400/red/white?text=Adobe+Experience+Manager+Assets). Filens binärfil buffras i minnet innan den överförs till AEM as a Cloud Service-miljön.
1. **Gruppöverföring** - Överför flera filer från ett lokalt filsystem gruppvis med automatisk logik för nya försök och felåterställning. Bakom scenerna används klassen `FileSystemUpload` för att överföra filer från det lokala filsystemet.

De resurser som ska överföras finns i mappen `sample-assets` och innehåller undermapparna `img`, `video` och `doc` som var och en innehåller några exempelresurser.

1. Använd följande kommando för att köra exempelprogrammet:

```bash
$ npm start
```

1. Ange det önskade alternativet _number_ bland följande alternativ:

```
╔════════════════════════════════════════════════════════════╗
║      AEM Asset Upload Sample Application                   ║
║      Demonstrating @adobe/aem-upload library               ║
╚════════════════════════════════════════════════════════════╝

Choose an upload method:

1. FileSystemUpload - Upload files from local filesystem with auto-folder creation
2. DirectBinaryUpload - Upload from remote URLs/streams to AEM
3. Batch Upload - Upload multiple files in batches with retry logic
4. Exit
```

På följande flikar visas exempelprogrammet, dess utdata och överförda resurser i AEM as a Cloud Service-miljön för varje överföringsmetod.

>[!BEGINTABS]

>[!TAB FileSystemUpload]

1. Exempelprogramutdata för alternativet `FileSystemUpload`:

```bash
...
Upload Summary:
──────────────────────────────────────────────────
Total files: 5
Successful: 5
Failed: 0
Total time: 2.67s
──────────────────────────────────────────────────
✓ 
All files uploaded successfully!
```

1. Assets har överförts med alternativet `FileSystemUpload` i AEM as a Cloud Service-miljön:

   ![Överförda resurser i AEM as a Cloud Service-miljö med klassen FileSystemUpload](./assets/programmatic-asset-upload/uploaded-assets-aem-file-system-upload.png)

>[!TAB DirectBinaryUpload]

1. Exempelprogramutdata för alternativet `DirectBinaryUpload`:

```bash
...
Upload Summary:
──────────────────────────────────────────────────
Total files: 1
Successful: 1
Total time: 561ms
──────────────────────────────────────────────────

✅ Successfully uploaded to AEM: https://author-p63947-e1733365.adobeaemcloud.com/ui#/aem/assets.html/content/dam?appId=aemshell
  → remote-file-1.png
    Source: https://placehold.co/600x400/red/white?text=Adobe+Experience+Manager+Assets
✓ 
All files uploaded successfully!
```

1. Assets har överförts med alternativet `DirectBinaryUpload` i AEM as a Cloud Service-miljön:

![Överförda resurser i AEM as a Cloud Service-miljö med klassen DirectBinaryUpload](./assets/programmatic-asset-upload/uploaded-assets-aem-direct-binary-upload.png)

>[!TAB Gruppöverföring]

1. Exempelprogramutdata för alternativet `Batch Upload`:

```bash
...
ℹ Found 4 item(s) to upload in batches (directories + files)
ℹ Batch size: 2 (small for demo, use 10-50 for production)

...

✓ Batch 2 completed in 2.79s

Upload Summary:
──────────────────────────────────────────────────
Total files: 5
Successful: 5
Failed: 0
Total time: 4.50s
──────────────────────────────────────────────────
✓ 
All files uploaded successfully!
```

1. Assets har överförts med alternativet `Batch Upload` i AEM as a Cloud Service-miljön:

![Överförda resurser i AEM as a Cloud Service-miljö med klassen BatchUpload](./assets/programmatic-asset-upload/uploaded-assets-aem-batch-upload.png)

>[!ENDTABS]

## Granska exempelprogramkoden

Huvudstartpunkten för exempelprogrammet är filen `index.js`. Den innehåller funktionen `promptUser` som uppmanar användaren att göra ett val och kör det valda exemplet.

```javascript
/**
 * Prompts user for choice and executes the selected example
 */
function promptUser() {
  rl.question(chalk.bold('Enter your choice (1-4): '), async (answer) => {
    console.log('');

    try {
      switch (answer.trim()) {
        case '1':
          console.log(chalk.bold.green('\n▶ Running FileSystemUpload Example...\n'));
          await filesystemUpload.main();
          break;

        case '2':
          console.log(chalk.bold.green('\n▶ Running DirectBinaryUpload Example...\n'));
          await directBinaryUpload.main();
          break;

        case '3':
          console.log(chalk.bold.green('\n▶ Running Batch Upload Example...\n'));
          await batchUpload.main();
          break;

        case '4':
          rl.close();
          return;

        default:
          console.log(chalk.red('\n✗ Invalid choice. Please enter 1, 2, 3, or 4.\n'));
      }

      // After example completes, ask if user wants to continue
      rl.question(chalk.bold('\nPress Enter to return to menu or Ctrl+C to exit...'), () => {
        displayMenu();
        promptUser();
      });

    } catch (error) {
      console.error(chalk.red('\n✗ Error:'), error.message);
      rl.question(chalk.bold('\nPress Enter to return to menu...'), () => {
        displayMenu();
        promptUser();
      });
    }
  });
}
```

Fullständig kod finns i filen `index.js` från exempelprogrammet.

På följande flikar visas implementeringsinformation för varje överföringsmetod.

>[!BEGINTABS]

>[!TAB FileSystemUpload]

Klassen `FileSystemUpload` används för att överföra filer från det lokala filsystemet med stöd för katalogstruktur och skapande av automatiska mappar.

```javascript
...
// Initialize FileSystemUpload
const upload = new FileSystemUpload();

const startTime = Date.now();
const spinner = createSpinner('Preparing upload...');

// Upload options for this specific upload
// For FileSystemUpload, the url should include the target folder path
const fullUrl = `${options.url}${targetFolder}`;

const uploadOptions = new FileSystemUploadOptions()
  .withUrl(fullUrl)
  .withDeepUpload(true);  // Enable recursive upload of subdirectories

// Add HTTP options including headers (auth is already in headers from config)
uploadOptions.withHttpOptions({
  headers: {
    ...options.headers,
    'X-Upload-Source': 'FileSystemUpload-Example'
  }
});

spinner.stop();

// Attach progress event handlers to the upload instance
handleUploadProgress(upload);

// Perform the upload and wait for completion
// Upload the contents (subdirectories and files) not the parent folder
const uploadResult = await upload.upload(uploadOptions, uploadPaths);
const totalTime = Date.now() - startTime;

// Analyze results using shared function
const analysis = analyzeUploadResult(uploadResult);

// Display summary
displayUploadSummary(analysis, totalTime);
...
```

Fullständig kod finns i filen `examples/filesystem-upload.js` från exempelprogrammet.

>[!TAB DirectBinaryUpload]

Klassen `DirectBinaryUpload` används för att överföra en fjärrfil till AEM as a Cloud Service-miljön.

```javascript
...
/**
 * Creates upload file objects for DirectBinaryUpload from remote URLs
 * @param {Array<Object>} remoteFiles - Array of objects with url, fileName, targetFolder
 * @returns {Array<Object>} Array of upload file objects
 */
async function createUploadFilesFromUrls(remoteFiles) {
  const uploadFiles = [];
  
  for (const remoteFile of remoteFiles) {
    logInfo(`Fetching: ${remoteFile.fileName} from ${remoteFile.url}`);
    try {
      const fileBuffer = await fetchRemoteFile(remoteFile.url);
      uploadFiles.push({
        fileName: remoteFile.fileName,
        fileSize: fileBuffer.length,
        blob: fileBuffer,  // DirectBinaryUpload uses 'blob' for buffers
        targetFolder: remoteFile.targetFolder,
        targetFile: `${remoteFile.targetFolder}/${remoteFile.fileName}`,
        sourceUrl: remoteFile.url  // Track source URL for display in summary
      });
      logSuccess(`Downloaded: ${remoteFile.fileName} (${formatBytes(fileBuffer.length)})`);
    } catch (error) {
      logError(`Failed to fetch ${remoteFile.fileName}: ${error.message}`);
    }
  }
  
  return uploadFiles;
}

...

    // Initialize DirectBinaryUpload
    const upload = new DirectBinaryUpload();

    // Fetch remote files and create upload objects
    const uploadFiles = await createUploadFilesFromUrls(remoteFiles);

...    

    // Upload options for each file
    const uploadOptions = new DirectBinaryUploadOptions()
        .withUrl(fullUrl)
        .withUploadFiles([uploadFile]);
    
    // Add HTTP options (auth is already in headers from config)
    uploadOptions
        .withHttpOptions({
        headers: {
            ...options.headers,
            'X-Upload-Source': 'DirectBinaryUpload-Example'
        }
        })
        .withMaxConcurrent(5);

    // Upload individual file and wait for completion
    const uploadResult = await upload.uploadFiles(uploadOptions);
```

Fullständig kod finns i filen `examples/direct-binary-upload.js` från exempelprogrammet.

>[!TAB Gruppöverföring]

Filerna delas upp i grupper och överförs i grupper med automatisk logik för nya försök och felåterställning. Bakom scenerna används klassen `FileSystemUpload` för att överföra filer från det lokala filsystemet.

```javascript
...
async function uploadInBatches(paths, options, targetFolder, batchSize = 2) {
  const allResults = [];
  const totalPaths = paths.length;
  const totalBatches = Math.ceil(totalPaths / batchSize);

  logInfo(`Processing ${totalPaths} item(s) in ${totalBatches} batch(es)`);

  for (let i = 0; i < totalPaths; i += batchSize) {
    const batchNumber = Math.floor(i / batchSize) + 1;
    const batch = paths.slice(i, i + batchSize);
    
    console.log(`\n${'='.repeat(50)}`);
    logInfo(`Batch ${batchNumber}/${totalBatches} - Uploading ${batch.length} item(s)`);
    console.log('='.repeat(50));

    const batchStartTime = Date.now();
    let retryCount = 0;
    const maxRetries = 3;
    let batchResults = null;

    // Retry logic for failed batches
    while (retryCount <= maxRetries) {
      try {
        // Create a fresh upload instance for each retry to avoid duplicate event listeners
        const upload = new FileSystemUpload();
        
        const fullUrl = `${options.url}${targetFolder}`;
        
        const uploadOptions = new FileSystemUploadOptions()
          .withUrl(fullUrl)
          .withDeepUpload(true);  // Enable recursive upload of subdirectories
        
        // Add HTTP options including headers (auth is already in headers from config)
        uploadOptions.withHttpOptions({
          headers: {
            ...options.headers,
            'X-Upload-Source': 'Batch-Upload-Example',
            'X-Batch-Number': batchNumber
          }
        });

        // Track progress - attach listeners to upload instance
        upload.on('foldercreated', (data) => {
          logSuccess(`Created folder: ${data.folderName} at ${data.targetFolder}`);
        });
        
        let currentFile = '';
        upload.on('filestart', (data) => {
          currentFile = data.fileName;
          logInfo(`Starting: ${currentFile}`);
        });

        upload.on('fileprogress', (data) => {
          const percentage = ((data.transferred / data.fileSize) * 100).toFixed(1);
          process.stdout.write(
            `\r  Progress: ${percentage}% - ${formatBytes(data.transferred)}/${formatBytes(data.fileSize)}`
          );
        });

        upload.on('fileend', (data) => {
          process.stdout.write('\n');
          logSuccess(`Completed: ${data.fileName}`);
        });

        upload.on('fileerror', (data) => {
          // Only show in DEBUG mode (may be retries)
          if (process.env.DEBUG === 'true') {
            process.stdout.write('\n');
            const errorMsg = data.error?.message || data.message || 'Unknown error';
            logWarning(`Error (may retry): ${data.fileName} - ${errorMsg}`);
          }
        });

        // Perform upload and wait for batch completion
        const uploadResult = await upload.upload(uploadOptions, batch);
        
        const batchEndTime = Date.now();
        const batchTime = batchEndTime - batchStartTime;
        
        logSuccess(`Batch ${batchNumber} completed in ${formatTime(batchTime)}`);
        
        // Extract detailed results from the upload result
        batchResults = uploadResult.detailedResult || [];
        break; // Success, exit retry loop

      } catch (error) {
        retryCount++;
        if (retryCount <= maxRetries) {
          logWarning(`Batch ${batchNumber} failed. Retry ${retryCount}/${maxRetries}...`);
          await new Promise(resolve => setTimeout(resolve, 2000 * retryCount)); // Exponential backoff
        } else {
          logError(`Batch ${batchNumber} failed after ${maxRetries} retries: ${error.message}`);
          // Mark all files in batch as failed
          batchResults = batch.map(file => ({
            fileName: path.basename(file),
            error: error,
            success: false
          }));
        }
      }
    }

    if (batchResults) {
      allResults.push(...batchResults);
    }
  }

  return allResults;
}
```

Fullständig kod finns i filen `examples/batch-upload.js` från exempelprogrammet.

>[!ENDTABS]

Dessutom innehåller filen `README.md` från exempelprogrammet detaljerad dokumentation för exempelprogrammet.

## God praxis

1. **Välj rätt autentiseringsmetod:**
Använd autentiseringsuppgifter för tjänster för produktionsmiljöer, lokal utvecklingstoken och grundläggande autentisering endast för utveckling/testning. Kontrollera att tjänstens autentiseringsuppgifter-användare har de behörigheter som krävs för att överföra resurser till AEM as a Cloud Service-miljön.

1. **Välj rätt överföringsmetod:**
Använd FileSystemUpload för lokala filer med automatisk mappgenerering, DirectBinaryUpload för strömmar/buffertar/fjärr-URL:er med detaljerad kontroll och batchöverföringsmönster för produktionsmiljöer med över 1 000 filer som kräver omförsökslogik.

1. **Strukturera DirectBinaryUpload-filobjekt korrekt**
Använd egenskapen blob (inte buffert) med obligatoriska fält: { fileName, fileSize, blob: buffer, targetFolder } och kom ihåg att DirectBinaryUpload INTE skapar mappar automatiskt.

1. **Exempelprogram som referens:**
Exempelprogrammet är en bra referens för implementeringsinformation i den programmatiska resursöverföringsprocessen. Du kan använda den som en startpunkt för din egen implementering.
