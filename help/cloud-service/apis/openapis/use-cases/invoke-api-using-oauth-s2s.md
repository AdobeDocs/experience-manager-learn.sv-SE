---
title: Anropa OpenAPI-baserade AEM-API:er med OAuth Server-till-Server-autentisering
description: Lär dig hur du anropar OpenAPI-baserade AEM-API:er på AEM as a Cloud Service från anpassade program med OAuth Server-till-Server-autentisering.
version: Experience Manager as a Cloud Service
feature: Developing
topic: Development, Architecture, Content Management
role: Architect, Developer, Leader
level: Beginner
doc-type: Tutorial
jira: KT-16516
thumbnail: KT-16516.jpeg
last-substantial-update: 2025-02-28T00:00:00Z
duration: 0
exl-id: 8338a905-c4a2-4454-9e6f-e257cb0db97c
source-git-commit: 610fe6fc91a400baa9d7f5d40a6a5c2084f93ed0
workflow-type: tm+mt
source-wordcount: '1687'
ht-degree: 0%

---

# Anropa OpenAPI-baserade AEM-API:er med OAuth Server-till-Server-autentisering

Lär dig hur du anropar OpenAPI-baserade AEM-API:er på AEM as a Cloud Service från anpassade program med _OAuth Server-till-Server_-autentisering.

OAuth Server-till-Server-autentiseringen är idealisk för backend-tjänster som behöver API-åtkomst utan användarinteraktion. Den använder tilldelningstypen _client_credentials_ för OAuth 2.0 för att autentisera klientprogrammet.

## Vad du lär dig{#what-you-learn}

I den här självstudiekursen får du lära dig att:

- Konfigurera ett Adobe Developer Console-projekt (ADC) så att du får åtkomst till Assets Author API med hjälp av _OAuth Server-till-Server-autentisering_.

- Utveckla ett exempel på ett NodeJS-program som anropar Assets Author API för att hämta metadata för en viss resurs.

Innan du börjar bör du kontrollera följande:

- [Åtkomst till Adobe API:er och relaterade koncept](../overview.md#accessing-adobe-apis-and-related-concepts)-avsnitt.
- [Konfigurera OpenAPI-baserade AEM API:er](../setup.md)-artiklar.

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- Moderniserad AEM as a Cloud Service-miljö med följande:
   - AEM version `2024.10.18459.20241031T210302Z` eller senare.
   - Nya produktprofiler (om miljön skapades före november 2024)

  Mer information finns i artikeln [Konfigurera OpenAPI-baserade AEM API:er](../setup.md).

- Exempelprojektet [WKND Sites](https://github.com/adobe/aem-guides-wknd?#aem-wknd-sites-project) måste distribueras till det.

- Åtkomst till [Adobe Developer Console](https://developer.adobe.com/developer-console/docs/guides/getting-started/).

- Installera [Node.js](https://nodejs.org/en/) på den lokala datorn för att köra exempelprogrammet NodeJS.

## Utvecklingssteg

Utvecklingsstegen på hög nivå är följande:

1. Konfigurera ADC-projekt
   1. Lägg till Assets Author API
   1. Konfigurera autentiseringsmetoden som OAuth Server-till-Server
   1. Associera produktprofil med autentiseringskonfigurationen
1. Konfigurera AEM-instansen för att aktivera ADC-projektkommunikation
1. Utveckla ett exempel på ett NodeJS-program
1. Verifiera flödet från början till slut

## Konfigurera ADC-projekt

Konfigurationssteget för ADC-projekt är _upprepat_ från [Konfigurera OpenAPI-baserade AEM-API:er](../setup.md). Det upprepas att lägga till API:t för Assets Author och konfigurera autentiseringsmetoden som OAuth Server-to-Server.

>[!TIP]
>
>Kontrollera att du har slutfört **Aktivera åtkomst till AEM API:er** i artikeln [Konfigurera OpenAPI-baserade AEM API:er](../setup.md#enable-aem-apis-access) . Utan det är autentiseringsalternativet Server-till-server inte tillgängligt.


1. Öppna önskat projekt från [Adobe Developer Console](https://developer.adobe.com/console/projects).

1. Om du vill lägga till AEM API:er klickar du på knappen **Lägg till API** .

   ![Lägg till API](../assets/s2s/add-api.png)

1. I dialogrutan _Lägg till API_ filtrerar du efter _Experience Cloud_, markerar **AEM Assets Author API**-kortet och klickar på **Nästa**.

   ![Lägg till AEM API](../assets/s2s/add-aem-api.png)

1. I dialogrutan _Konfigurera API_ väljer du autentiseringsalternativet **Server-till-server** och klickar på **Nästa**. Server-till-server-autentiseringen är idealisk för backend-tjänster som behöver API-åtkomst utan användarinteraktion.

   ![Välj autentisering](../assets/s2s/select-authentication.png)

1. Byt namn på autentiseringsuppgifterna för enklare identifiering (om det behövs) och klicka på **Nästa**. I demosyfte används standardnamnet.

   ![Byt namn på autentiseringsuppgifter](../assets/s2s/rename-credential.png)

1. Välj **AEM Assets Collaborator Users - författare - Program XXX - Miljö XXX** Produktprofil och klicka på **Spara**. Som du ser kan du bara välja den produktprofil som är kopplad till AEM Assets API-användartjänst.

   ![Välj produktprofil](../assets/s2s/select-product-profile.png)

1. Granska AEM API och autentiseringskonfigurationen.

   ![AEM API-konfiguration](../assets/s2s/aem-api-configuration.png)

   ![Autentiseringskonfiguration](../assets/s2s/authentication-configuration.png)

## Konfigurera AEM-instans för att aktivera ADC-projektkommunikation

Följ instruktionerna i artikeln [Konfigurera OpenAPI-baserade AEM API:er](../setup.md#configure-the-aem-instance-to-enable-adc-project-communication) för att konfigurera AEM-instansen så att ADC-projektkommunikation aktiveras.

## Utveckla ett exempel på ett NodeJS-program

Låt oss utveckla ett exempel på ett NodeJS-program som anropar Assets Author API.

Du kan använda andra programmeringsspråk som Java, Python osv. för att utveckla programmet.

I testsyfte kan du använda [Postman](https://www.postman.com/), [curl](https://curl.se/) eller någon annan REST-klient för att anropa AEM API:er.

### Granska API

Innan vi utvecklar programmet ska vi granska [den angivna resursens metadata](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/../assets/author/#operation/getAssetMetadata)-slutpunkt från _Assets Author API_. API-syntaxen är:

```http
GET https://{bucket}.adobeaemcloud.com/adobe/../assets/{assetId}/metadata
```

Om du vill hämta metadata för en viss resurs behöver du värdena `bucket` och `assetId`. `bucket` är AEM-instansnamnet utan Adobe-domännamnet (.adobeaemcloud.com), till exempel `author-p63947-e1420428`.

`assetId` är JCR UUID för resursen med prefixet `urn:aaid:aem:`, till exempel `urn:aaid:aem:a200faf1-6d12-4abc-bc16-1b9a21f870da`. Det finns flera sätt att hämta `assetId`:

- Lägg till AEM resurssökväg `.json` för att hämta metadata för resursen. Till exempel `https://author-p63947-e1420429.adobeaemcloud.com/content/dam/wknd-shared/en/adventures/cycling-southern-utah/adobestock-221043703.jpg.json` och leta efter egenskapen `jcr:uuid`.

- Du kan också hämta `assetId` genom att inspektera resursen i webbläsarens elementkontroll. Leta efter attributet `data-id="urn:aaid:aem:..."`.

  ![Inspektera resurs](../assets/s2s/inspect-asset.png)

### Anropa API:t med webbläsaren

Innan vi utvecklar programmet måste vi anropa API:t med funktionen **Prova** i [API-dokumentationen](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/).

1. Öppna [Assets Author API-dokumentationen](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/) i webbläsaren.

1. Expandera avsnittet _Metadata_ och klicka på alternativet **Levererar den angivna resursens metadata**.

1. Klicka på knappen **Testa** i den högra rutan.
   ![API-dokumentation](../assets/s2s/api-documentation.png)

1. Ange följande värden:

   | Avsnitt | Parameter | Värde |
   | --- | --- | --- |
   |  | bucket | AEM-instansnamnet utan Adobe-domännamnet (.adobeaemcloud.com), till exempel `author-p63947-e1420428`. |
   | **Säkerhet** | Bearer Token | Använd åtkomsttoken från ADC-projektets autentiseringsuppgifter för OAuth Server-till-server. |
   | **Säkerhet** | X-API-tangent | Använd värdet `ClientID` från ADC-projektets autentiseringsuppgifter för OAuth Server-till-server. |
   | **Parametrar** | assetId | Den unika identifieraren för resursen i AEM, till exempel `urn:aaid:aem:a200faf1-6d12-4abc-bc16-1b9a21f870da` |
   | **Parametrar** | X-Adobe-Accept-Experimental | 1 |

   ![Anropa API - åtkomsttoken](../assets/s2s/generate-access-token.png)

   ![Anropa API - indatavärden](../assets/s2s/invoke-api-input-values.png)

1. Klicka på **Skicka** för att anropa API:t och granska svaret på fliken **Svar**.

   ![Anropa API - svar](../assets/s2s/invoke-api-response.png)

Stegen ovan bekräftar moderniseringen av AEM as a Cloud Service-miljön och ger åtkomst till AEM API:er. Det bekräftar också den lyckade konfigurationen av ADC-projektet och kommunikationen mellan klient-ID för OAuth Server-till-Server-autentiseringsuppgifter och AEM Author-instansen.

### Exempel på NodeJS-program

Låt oss utveckla ett exempel på ett NodeJS-program.

Om du vill utveckla programmet kan du antingen använda instruktionerna _Kör-the-sample-application_ eller _Steg-för-steg-utveckling_ .

>[!BEGINTABS]

>[!TAB Kör-the-sample-application]

1. Hämta exempelfilen [demo-nodatums-app-to-invoke-aem-openapi](../assets/s2s/demo-nodejs-app-to-invoke-aem-openapi.zip) för programmet och extrahera den.

1. Navigera till den extraherade mappen och installera beroendena.

   ```bash
   $ npm install
   ```

1. Ersätt platshållarna i filen `.env` med de faktiska värdena från ADC-projektets autentiseringsuppgifter för OAuth Server-till-server.

1. Ersätt `<BUCKETNAME>` och `<ASSETID>` i filen `src/index.js` med de faktiska värdena.

1. Kör programmet NodeJS.

   ```bash
   $ node src/index.js
   ```

>[!TAB Steg-för-steg-utveckling]

1. Skapa ett nytt NodeJS-projekt.

   ```bash
   $ mkdir demo-nodejs-app-to-invoke-aem-openapi
   $ cd demo-nodejs-app-to-invoke-aem-openapi
   $ npm init -y
   ```

1. Installera biblioteket _fetch_ och _dotenv_ om du vill göra HTTP-begäranden och läsa miljövariablerna.

   ```bash
   $ npm install node-fetch
   $ npm install dotenv
   ```

1. Öppna projektet i din favoritkodredigerare och uppdatera filen `package.json` för att lägga till filen `type` i `module`.

   ```json
   {
       ...
       "version": "1.0.0",
       "type": "module",
       "main": "index.js",
       ...
   }
   ```

1. Skapa filen `.env` och lägg till följande konfiguration. Ersätt platshållarna med de faktiska värdena från ADC-projektets autentiseringsuppgifter för OAuth Server-till-Server.

   ```properties
   CLIENT_ID=<ADC Project OAuth Server-to-Server credential ClientID>
   CLIENT_SECRET=<ADC Project OAuth Server-to-Server credential Client Secret>
   SCOPES=<ADC Project OAuth Server-to-Server credential Scopes>
   ```

1. Skapa filen `src/index.js` och lägg till följande kod och ersätt `<BUCKETNAME>` och `<ASSETID>` med de faktiska värdena.

   ```javascript
   // Import the dotenv configuration to load environment variables from the .env file
   import "dotenv/config";
   
   // Import the fetch function to make HTTP requests
   import fetch from "node-fetch";
   
   // REPLACE THE FOLLOWING VALUES WITH YOUR OWN
   const bucket = "<BUCKETNAME>"; // Bucket name is the AEM instance name (e.g. author-p63947-e1420428)
   const assetId = "<ASSETID>"; // Asset ID is the unique identifier for the asset in AEM (e.g. urn:aaid:aem:a200faf1-6d12-4abc-bc16-1b9a21f870da). You can get it by inspecting the asset in browser's element inspector, look for data-id="urn:aaid:aem:..."
   
   // Load environment variables for authentication
   const clientId = process.env.CLIENT_ID; // Adobe IMS client ID
   const clientSecret = process.env.CLIENT_SECRET; // Adobe IMS client secret
   const scopes = process.env.SCOPES; // Scope for the API access
   
   // Adobe IMS endpoint for obtaining an access token
   const adobeIMSV3TokenEndpointURL =
   "https://ims-na1.adobelogin.com/ims/token/v3";
   
   // Function to obtain an access token from Adobe IMS
   const getAccessToken = async () => {
       console.log("Getting access token from IMS"); // Log process initiation
       //console.log("Client ID: " + clientId); // Display client ID for debugging purposes
   
       // Configure the HTTP POST request to fetch the access token
       const options = {
           method: "POST",
           headers: {
           "Content-Type": "application/x-www-form-urlencoded", // Specify form data content type
           },
           // Send client ID, client secret, and scopes as the request body
           body: `grant_type=client_credentials&client_id=${clientId}&client_secret=${clientSecret}&scope=${scopes}`,
       };
   
       // Make the HTTP request to fetch the access token
       const response = await fetch(adobeIMSV3TokenEndpointURL, options);
   
       //console.log("Response status: " + response.status); // Log the HTTP status for debugging
   
       const responseJSON = await response.json(); // Parse the JSON response
   
       console.log("Access token received"); // Log success message
   
       // Return the access token
       return responseJSON.access_token;
   };
   
   // Function to retrieve metadata for a specific asset from AEM
   const getAssetMetadat = async () => {
       // Fetch the access token using the getAccessToken function
       const accessToken = await getAccessToken();
   
       console.log("Getting asset metadata from AEM");
   
       // Invoke the Assets Author API to retrieve metadata for a specific asset
       const resp = await fetch(
           `https://${bucket}.adobeaemcloud.com/adobe/../assets/${assetId}/metadata`, // Construct the URL with bucket and asset ID
           {
           method: "GET",
           headers: {
               "If-None-Match": "string", // Header to handle caching (not critical for this tutorial)
               "X-Adobe-Accept-Experimental": "1", // Header to enable experimental Adobe API features
               Authorization: "Bearer " + accessToken, // Provide the access token for authorization
               "X-Api-Key": clientId, // Include the OAuth S2S ClientId for identification
           },
           }
       );
   
       const data = await resp.json(); // Parse the JSON response
   
       console.log("Asset metadata received"); // Log success message
       console.log(data); // Display the retrieved metadata
   };
   
   // Call the getAssets function to start the process
   getAssetMetadat();
   ```

1. Kör programmet NodeJS.

   ```bash
   $ node src/index.js
   ```

>[!ENDTABS]

### API-svar

När körningen är klar visas API-svaret i konsolen. Svaret innehåller metadata för angiven resurs.

```json
{
  "assetId": "urn:aaid:aem:9c09ff70-9ee8-4b14-a5fa-ec37baa0d1b3",
  "assetMetadata": {    
    ...
    "dc:title": "A Young Mountain Biking Couple Takes A Minute To Take In The Scenery",
    "xmp:CreatorTool": "Adobe Photoshop Lightroom Classic 7.5 (Macintosh)",
    ...
  },
  "repositoryMetadata": {
    ...
    "repo:name": "adobestock-221043703.jpg",
    "repo:path": "/content/dam/wknd-shared/en/adventures/cycling-southern-utah/adobestock-221043703.jpg",
    "repo:state": "ACTIVE",
    ...
  }
}
```

Grattis! Du har anropat de OpenAPI-baserade AEM-API:erna från ditt anpassade program med OAuth Server-till-Server-autentisering.

### Granska programkoden

Huvudpratbubblorna från exemplet NodeJS-programkod är:

1. **IMS-autentisering**: Hämtar en åtkomsttoken med hjälp av inställningarna för OAuth Server-till-Server-autentiseringsuppgifter i ADC-projektet.

   ```javascript
   // Function to obtain an access token from Adobe IMS
   const getAccessToken = async () => {
   
       // Configure the HTTP POST request to fetch the access token
       const options = {
           method: "POST",
           headers: {
           "Content-Type": "application/x-www-form-urlencoded", // Specify form data content type
           },
           // Send client ID, client secret, and scopes as the request body
           body: `grant_type=client_credentials&client_id=${clientId}&client_secret=${clientSecret}&scope=${scopes}`,
       };
   
       // Make the HTTP request to fetch the access token from Adobe IMS token endpoint https://ims-na1.adobelogin.com/ims/token/v3
       const response = await fetch(adobeIMSV3TokenEndpointURL, options);
   
       const responseJSON = await response.json(); // Parse the JSON response
   
       // Return the access token
       return responseJSON.access_token;
   };
   ...
   ```

1. **API-anrop**: Anropar Assets Author API för att hämta metadata för en viss resurs genom att ange åtkomsttoken för auktorisering.

   ```javascript
   // Function to retrieve metadata for a specific asset from AEM
   const getAssetMetadat = async () => {
       // Fetch the access token using the getAccessToken function
       const accessToken = await getAccessToken();
   
       console.log("Getting asset metadata from AEM");
   
       // Invoke the Assets Author API to retrieve metadata for a specific asset
       const resp = await fetch(
           `https://${bucket}.adobeaemcloud.com/adobe/../assets/${assetId}/metadata`, // Construct the URL with bucket and asset ID
           {
           method: "GET",
           headers: {
               "If-None-Match": "string", // Header to handle caching (not critical for this tutorial)
               "X-Adobe-Accept-Experimental": "1", // Header to enable experimental Adobe API features
               Authorization: "Bearer " + accessToken, // Provide the access token for authorization
               "X-Api-Key": clientId, // Include the OAuth S2S ClientId for identification
           },
           }
       );
   
       const data = await resp.json(); // Parse the JSON response
   
       console.log("Asset metadata received"); // Log success message
       console.log(data); // Display the retrieved metadata
   };
   ...
   ```

## Under huven

När API-anropet lyckades skapas en användare som representerar ADC-projektets autentiseringsuppgifter för OAuth Server-till-Server i AEM Author-tjänsten tillsammans med användargrupperna som matchar produktprofilen och tjänstkonfigurationen. Den _tekniska kontoanvändaren_ är kopplad till produktprofilen och användargruppen _Services_ som har de behörigheter som krävs för att _LÄS_ resursens metadata.

Följ de här stegen för att verifiera att den tekniska kontoanvändaren och användargruppen har skapats:

- Gå till autentiseringskonfigurationen **OAuth Server-till-Server** i ADC-projektet. Observera värdet för **e-postadress för tekniskt konto**.

  ![E-post för tekniskt konto](../assets/s2s/technical-account-email.png)

- Gå till **Verktyg** > **Säkerhet** > **Användare** i AEM Author-tjänsten och sök efter värdet **E-post för tekniskt konto**.

  ![Teknisk kontoanvändare](../assets/s2s/technical-account-user.png)

- Klicka på den tekniska kontoanvändaren för att visa användarinformation, som **Grupper**-medlemskap. Som framgår nedan är den tekniska kontoanvändaren associerad med användargrupperna **AEM Assets Collaborator Users - författare - Program XXX - Environment XXX** och **AEM Assets Collaborator Users - Service** .

  ![Användarmedlemskap för tekniskt konto](../assets/s2s/technical-account-user-membership.png)

- Observera att den tekniska kontoanvändaren är kopplad till produktprofilen **AEM Assets Collaborator Users - författare - Program XXX - Miljö XXX**. Produktprofilen är associerad med **AEM Assets API-användare** och **AEM Assets Collaborator-användartjänster**.

  ![Användarproduktprofil för tekniskt konto](../assets/s2s/technical-account-user-product-profile.png)

- Produktprofilen och associationen för tekniska kontoanvändare kan verifieras på fliken **API-autentiseringsuppgifter** för **produktprofiler**.

  ![API-autentiseringsuppgifter för produktprofil](../assets/s2s/product-profile-api-credentials.png)

## 403-fel för icke-GET-begäranden

För att _LÄS_ resursens metadata har den tekniska kontoanvändaren som skapades för OAuth Server-till-Server-autentiseringsuppgifterna nödvändiga behörigheter via användargruppen Tjänster (till exempel AEM Assets Collaborator Users - Service).

Om du vill _skapa, uppdatera, ta bort_ (CUD) metadata för resursen måste den tekniska kontoanvändaren ha ytterligare behörigheter. Du kan verifiera det genom att anropa API:t med en begäran som inte är GET (till exempel PATCH, DELETE) och observera 403-felsvaret.

Låt oss anropa _PATCH_ -begäran för att uppdatera metadata för resursen och observera 403-felsvaret.

- Öppna [Assets Author API-dokumentationen](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/) i webbläsaren.

- Ange följande värden:

  | Avsnitt | Parameter | Värde |
  | --- | --- | --- |
  | **Bucket** |  | AEM-instansnamnet utan Adobe-domännamnet (.adobeaemcloud.com), till exempel `author-p63947-e1420428`. |
  | **Säkerhet** | Bearer Token | Använd åtkomsttoken från ADC-projektets autentiseringsuppgifter för OAuth Server-till-server. |
  | **Säkerhet** | X-API-tangent | Använd värdet `ClientID` från ADC-projektets autentiseringsuppgifter för OAuth Server-till-server. |
  | **Brödtext** |  | `[{ "op": "add", "path": "foo","value": "bar"}]` |
  | **Parametrar** | assetId | Den unika identifieraren för resursen i AEM, till exempel `urn:aaid:aem:a200faf1-6d12-4abc-bc16-1b9a21f870da` |
  | **Parametrar** | X-Adobe-Accept-Experimental | * |
  | **Parametrar** | X-Adobe-Accept-Experimental | 1 |

- Klicka på **Skicka** för att anropa _PATCH_-begäran och observera 403-felsvaret.

  ![Anropa API - PATCH-begäran](../assets/s2s/invoke-api-patch-request.png)

Du kan åtgärda felet 403 på två sätt:

- I ADC Project uppdaterar du den associerade produktprofilen för OAuth Server-till-Server-autentiseringsuppgiften med en lämplig produktprofil som har de behörigheter som krävs för att _skapa, uppdatera, ta bort_ (CUD) metadata för resursen, till exempel **AEM-administratörer - författare - Program XXX - Miljö XXX**. Mer information finns i artikeln [Använda - API:ts anslutna autentiseringsuppgifter och hantering av produktprofiler](../how-to/credentials-and-product-profile-management.md) .

- Med AEM Project uppdaterar du den associerade AEM-tjänstanvändargruppens (till exempel AEM Assets Collaborator Users - Service) behörigheter i AEM Author så att _Create, Update, Delete_ (CUD) of the asset metadata. Mer information finns i artikeln [Använda - behörighetshantering för AEM-användargrupper](../how-to/services-user-group-permission-management.md).

## Sammanfattning

I den här självstudiekursen lärde du dig att anropa OpenAPI-baserade AEM-API:er från anpassade program. Du har aktiverat åtkomst till AEM API:er, skapat och konfigurerat ett Adobe Developer Console-projekt (ADC).
I ADC-projektet lade du till AEM API:er, konfigurerade autentiseringstypen och kopplade till produktprofilen. Du har även konfigurerat AEM-instansen för att aktivera ADC-projektkommunikation och utvecklat ett exempel-NodeJS-program som anropar Assets Author API.

## Ytterligare resurser

- [Implementeringshandbok för autentiseringsuppgifter för OAuth Server-till-Server](https://developer.adobe.com/developer-console/docs/guides/authentication/ServerToServerAuthentication/implementation/)
