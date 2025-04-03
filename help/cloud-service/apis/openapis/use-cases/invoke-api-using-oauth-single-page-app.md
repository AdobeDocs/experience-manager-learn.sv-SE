---
title: Anropa OpenAPI-baserade AEM-API:er med OAuth Single Page App
description: Lär dig hur du anropar OpenAPI-baserade AEM-API:er på AEM as a Cloud Service med användarbaserad autentisering från en anpassad Single Page App (SPA) via OAuth 2.0 PKCE-flöde.
version: Cloud Service
feature: Developing
topic: Development, Architecture, Content Management
role: Architect, Developer, Leader
level: Intermediate
doc-type: Tutorial
jira: KT-17430
thumbnail: KT-17430.jpg
last-substantial-update: 2025-03-28T00:00:00Z
duration: 0
exl-id: 9fb92127-9dea-4a1d-b1f7-8fb98cabf188
source-git-commit: 7212bec910320847e9375dd1956a8cf76df1d579
workflow-type: tm+mt
source-wordcount: '2104'
ht-degree: 0%

---

# Anropa OpenAPI-baserade AEM-API:er med OAuth Single Page App

Lär dig hur du anropar OpenAPI-baserade AEM-API:er på AEM as a Cloud Service med **OAuth Single Page App-autentisering**. Det följer OAuth 2.0 PKCE-flödet (Proof Key for Code Exchange) för användarbaserad autentisering i ett Single Page-program (SPA).

OAuth Single Page App-autentisering är idealisk för JavaScript-baserade program som körs i webbläsaren. Oavsett om de saknar en serverdelsserver eller behöver hämta åtkomsttoken för att kunna interagera med AEM API:er för en användares räkning.

PKCE-flödet utökar anslagstypen OAuth 2.0 _permission_code_ och förbättrar säkerheten genom att förhindra avlyssning av auktoriseringskoden. Mer information finns i avsnittet [Skillnad mellan autentiseringsuppgifter för OAuth Server-till-Server och Web App respektive Single Page App ](../overview.md#difference-between-oauth-server-to-server-vs-web-app-vs-single-page-app-credentials).

>[!AVAILABILITY]
>
>OpenAPI-baserade AEM API:er är tillgängliga som en del av ett program för tidig åtkomst. Om du är intresserad av att få tillgång till dem bör du skicka ett e-postmeddelande till [aem-apis@adobe.com](mailto:aem-apis@adobe.com) med en beskrivning av ditt användningsfall.

## Vad du lär dig{#what-you-learn}

I den här självstudiekursen får du lära dig att:

- Konfigurera ett Adobe Developer Console-projekt (ADC) så att du får tillgång till OpenAPI-baserade AEM-API:er med _OAuth Single Page App_ -autentisering eller så kallas _OAuth 2.0 PKCE-flöde_ .

- Implementera autentiseringsflödet för OAuth Single Page App i en anpassad SPA.
   - IMS-användarautentisering och appauktorisering.
   - Få åtkomst till tokenhämtning med OAuth 2.0 PKCE-flöde.
   - Använd åtkomsttoken för att anropa OpenAPI-baserade AEM API:er.

Innan du börjar bör du kontrollera följande:

- [Åtkomst till Adobe API:er och relaterade koncept](../overview.md#accessing-adobe-apis-and-related-concepts)-avsnitt.
- [Konfigurera OpenAPI-baserade AEM API:er](../setup.md)-artiklar.

## Översikt över WKND SPA och funktionella flöden{#wknd-spa-overview-and-functional-flow}

Låt oss utforska vad WKND SPA är, hur det har byggts och hur det fungerar.

WKND SPA är ett **React-baserat Single Page-program** som demonstrerar hur du på ett säkert sätt får en användarspecifik åtkomsttoken och interagerar med AEM API:er direkt från klientsidan. Det implementerar autentiseringsflödet OAuth 2.0 PKCE via Adobe IMS och integreras med två viktiga AEM API:er:

1. **Webbplats-API**: För åtkomst till modeller för innehållsfragment
1. **Assets API**: För hantering av DAM-mappar

Adobe Developer Console-projektet (ADC) är konfigurerat för att aktivera autentisering med OAuth Single Page App, vilket ger det **client_id** som krävs för att initiera OAuth 2.0 PKCE-flödet.

>[!IMPORTANT]
>
>ADC-projektet tillhandahåller INTE någon _client_secrets_. I stället genererar SPA en _code_verifier_ och _code_enge_ för att på ett säkert sätt utbyta auktoriseringskoden för en _åtkomsttoken_. Det eliminerar behovet av att lagra en klienthemlighet på klientsidan, vilket förbättrar säkerheten.


>[!VIDEO](https://video.tv.adobe.com/v/3456964?quality=12&learn=on)



I följande diagram visas det funktionella flödet för WKND SPA _med användarspecifik åtkomsttoken för att anropa OpenAPI-baserade AEM API:er_:

![WKND SPA-autentiseringsflöde](../assets/spa/wknd-spa-auth-flow.png)

1. SPA initierar autentiseringsflödet genom att dirigera användaren till Adobe Identity Management System (IMS) via en auktoriseringsbegäran.
1. Som en del av auktoriseringsbegäran skickar SPA _client_id_, _redirect_uri_ och _code_enge_ till IMS efter OAuth 2.0 PKCE-flödet. SPA genererar ett slumpmässigt _code_verifier_, hashas det med SHA-256 och Base64 kodar resultatet för att skapa _code_enge_.
1. IMS-programmet autentiserar användaren och utfärdar, vid lyckad autentisering, _permission_code_ som skickas tillbaka till SPA via _redirect_uri_.
1. SPA utbyter _permission_code_ för en _åtkomsttoken_ genom att skicka en POST-begäran till IMS-tokenslutpunkten. Den innehåller _code_verifier_ i begäran om validering av den _code_enge_ som skickades tidigare. Detta säkerställer att auktoriseringsbegäran (steg 2) och tokenbegäran (steg 4) länkas till samma autentiseringsflöde, vilket förhindrar avlyssningsattacker.
1. IMS-programmet validerar _code_verifier_ och returnerar den användarspecifika _åtkomsttoken_.
1. SPA innehåller _åtkomsttoken_ i API-begäranden till AEM för att autentisera och hämta användarspecifikt innehåll.

WKND SPA är ett [React](https://react.dev/)-baserat program och använder [React Context](https://react.dev/reference/react/createContext) för hantering av autentiseringstillstånd, [React Router](https://reactrouter.com/home) för navigering.

Andra SPA-ramverk som Angular, Vue och vanilla JavaScript kan användas för att skapa SPA som kan integreras med Adobe API:er med de metoder som illustreras i den här självstudiekursen.

## Så här använder du den här självstudien{#how-to-use-this-tutorial}

Du kan använda den här självstudiekursen på två sätt:

- [Granska SPA-nyckelkodfragment](#review-spa-key-code-snippets): Förstå autentiseringsflödet för OAuth Single Page App och utforska nyckelimplementeringarna för API-anrop i WKND SPA.
- [Konfigurera och kör SPA](#setup-and-run-the-spa): Följ stegvisa instruktioner för att konfigurera och köra WKND SPA på den lokala datorn.

Välj den väg som passar dina behov bäst!

## Granska SPA-kodfragment{#review-spa-key-code-snippets}

Låt oss dyka upp i de nyckelkodfragment från WKND SPA som visar hur man:

- Hämta en användarspecifik åtkomsttoken med autentiseringsflödet OAuth Single Page App.

- Anropa OpenAPI-baserade AEM-API:er direkt från klientsidan.

Dessa fragment hjälper dig att förstå autentiseringsprocessen och API-interaktioner i SPA.

### Hämta SPA-koden{#download-the-spa-code}

1. Hämta zip-filen [WKND SPA &amp; AEM APIs - Demo App](../assets/spa/wknd-spa-with-aemapis-demo.zip) och extrahera den.

1. Navigera till den extraherade mappen och öppna filen `.env.example` i din favoritkodredigerare. Granska de konfigurationsparametrar som krävs.

   ```plaintext
   ########################################################################
   # Adobe IMS, Adobe Developer Console (ADC), and AEM as a Cloud Service Information
   ########################################################################
   # Adobe IMS OAuth endpoints
   REACT_APP_ADOBE_IMS_AUTHORIZATION_ENDPOINT=https://ims-na1.adobelogin.com/ims/authorize/v2
   REACT_APP_ADOBE_IMS_TOKEN_ENDPOINT=https://ims-na1.adobelogin.com/ims/token/v3
   
   # Adobe Developer Console (ADC) Project's OAuth Single-Page App credential
   REACT_APP_ADC_CLIENT_ID=<ADC Project OAuth Single-Page App credential ClientID>
   REACT_APP_ADC_SCOPES=<ADC Project OAuth Single-Page App credential Scopes>
   
   # AEM Assets Information
   REACT_APP_AEM_ASSET_HOSTNAME=<AEMCS Hostname, e.g., https://author-p63947-e1502138.adobeaemcloud.com/>
   
   ################################################
   # Single Page Application Information
   ################################################
   
   # Enable HTTPS for local development
   HTTPS=true
   PORT=3001
   
   # SSL Certificate and Key for local development 
   SSL_CRT_FILE=./ssl/server.crt
   SSL_KEY_FILE=./ssl/server.key
   
   # The URL to which the user will be redirected after the OAuth flow is complete
   REACT_APP_REDIRECT_URI=https://localhost:3000/callback
   ```

   Du måste ersätta platshållarna med de faktiska värdena från Adobe Developer Console (ADC) Project och AEM as a Cloud Service Assets.

### IMS-användarautentisering och SPA-auktorisering{#ims-user-authentication-and-spa-authorization}

Låt oss utforska koden som hanterar IMS-användarautentisering och SPA-auktorisering. För att kunna hämta innehållsfragmentmodeller och DAM-mappar måste användaren autentisera med Adobe IMS och ge WKND SPA behörighet att komma åt AEM API:er för deras räkning.

Under den första inloggningen uppmanas användaren att ge sitt medgivande så att WKND SPA kan komma åt de nödvändiga resurserna på ett säkert sätt.

![WKND SPA Första inloggning och samtycke](../assets/spa/wknd-spa-first-login-consent.png)

1. I filen `src/context/IMSAuthContext.js` initierar funktionen `login` IMS-användarautentisering och appauktoriseringsflöde. Det genererar ett slumpmässigt `code_verifier` och `code_challenge` för att på ett säkert sätt utbyta `code` för en åtkomsttoken. `code_verifier` lagras i den lokala lagringsplatsen för senare bruk. Som vi nämnt tidigare lagras eller används inte `client_secret` i SPA, utan det genereras en direkt och används i två steg: `authorize` - och `token` -begäranden.

   ```javascript
   ...
   const login = async () => {
       try {
           const codeVerifier = generateCodeVerifier();
           const codeChallenge = generateCodeChallenge(codeVerifier);
   
           localStorage.setItem(STORAGE_KEYS.CODE_VERIFIER, codeVerifier);
   
           const params = new URLSearchParams(
               getAuthParams(AUTH_METHODS.S256, codeChallenge, codeVerifier)
           );
   
           window.location.href = `${
               APP_CONFIG.adobe.ims.authorizationEndpoint //https://ims-na1.adobelogin.com/ims/authorize/v2
           }?${params.toString()}`;
       } catch (error) {
           console.error("Login initialization failed:", error);
           throw error;
       }
   };
   ...
   
   // Generate a random code verifier
   export function generateCodeVerifier() {
       const array = new Uint8Array(32);
       window.crypto.getRandomValues(array);
       const wordArray = CryptoJS.lib.WordArray.create(array);
       return base64URLEncode(wordArray);
   }
   
   // Generate code challenge using SHA-256
   export function generateCodeChallenge(codeVerifier) {
       const hash = CryptoJS.SHA256(codeVerifier);
       return base64URLEncode(hash);
   }
   
   // Get authorization URL parameters
   const getAuthParams = useCallback((method, codeChallenge, codeVerifier) => {
       const baseParams = {
           client_id: APP_CONFIG.adobe.adc.clientId, // ADC Project OAuth Single-Page App credential ClientID
           scope: APP_CONFIG.adobe.adc.scopes, // ADC Project OAuth Single-Page App credential Scopes
           response_type: "code",
           redirect_uri: APP_CONFIG.adobe.spa.redirectUri, // SPA redirect URI https://localhost:3000/callback
           code_challenge_method: method, // S256 or plain
       };
   
       return {
           ...baseParams,
           code_challenge:
               method === AUTH_METHODS.S256 ? codeChallenge : codeVerifier,
           };
   }, []);    
   ...
   ```

   Om användaren inte är autentiserad mot Adobe IMS visas inloggningssidan för Adobe ID där användaren uppmanas att autentisera.

   Om den redan är autentiserad omdirigeras användaren tillbaka till angiven _redirect_uri_ i WKND SPA med en _permission_code_.

### Få åtkomst till tokenhämtning med OAuth 2.0 PKCE-flöde{#access-token-retrieval-using-oauth-20-pkce-flow}

WKND SPA utbyter på ett säkert sätt _permission_code_ med Adobe IMS för en användarspecifik åtkomsttoken med _client_id_ och _code_verifier_.

1. I filen `src/context/IMSAuthContext.js` byter funktionen `exchangeCodeForToken` ut _permission_code_ mot en användarspecifik åtkomsttoken.

   ```javascript
   ...
   // Handle the callback from the Adobe IMS authorization endpoint
   const handleCallback = async (code) => {
       if (authState.isProcessingCallback) return;
   
       try {
           updateAuthState({ isProcessingCallback: true });
   
           const data = await exchangeCodeForToken(code);
   
           if (data.access_token) {
               handleStorageToken(data.access_token);
               localStorage.removeItem(STORAGE_KEYS.CODE_VERIFIER);
           }
       } catch (error) {
           console.error("Error exchanging code for token:", error);
           throw error;
       } finally {
           updateAuthState({ isProcessingCallback: false });
       }
   };
   
   ...
   // Exchange the authorization code for an access token
   const exchangeCodeForToken = useCallback(async (code) => {
       const codeVerifier = localStorage.getItem(STORAGE_KEYS.CODE_VERIFIER);
   
       if (!codeVerifier) {
           throw new Error("No code verifier found");
       }
   
       //https://ims-na1.adobelogin.com/ims/token/v3
       const response = await fetch(APP_CONFIG.adobe.ims.tokenEndpoint, {
           method: "POST",
           headers: { "Content-Type": "application/x-www-form-urlencoded" },
           body: new URLSearchParams({
               grant_type: "authorization_code",
               client_id: APP_CONFIG.adobe.adc.clientId, // ADC Project OAuth Single-Page App credential ClientID
               code_verifier: codeVerifier, // Code verifier generated during login
               code, // Authorization code received from the IMS
               redirect_uri: `${window.location.origin}/callback`,
           }),
       });
   
       if (!response.ok) {
           throw new Error("Token request failed");
       }
   
       return response.json();
   }, []);
   
   const handleStorageToken = useCallback(
       (token) => {
           if (token) {
               localStorage.setItem(STORAGE_KEYS.ACCESS_TOKEN, token);
               updateAuthState({ isLoggedIn: true, accessToken: token });
           }
       },
       [updateAuthState]
   );
   ...
   ```

   Åtkomsttoken lagras i webbläsarens lokala lager och används i efterföljande API-anrop till AEM API:er.

### Åtkomst till OpenAPI-baserade AEM API:er med åtkomsttoken{#accessing-openapi-based-aem-apis-using-the-access-token}

WKND SPA använder den användarspecifika åtkomsttoken för att anropa innehållsfragmentmodellerna och API-slutpunkterna för DAM-mappar.

I filen `src/components/InvokeAemApis.js` visar funktionen `fetchContentFragmentModels` hur du använder åtkomsttoken för att anropa OpenAPI-baserade AEM-API:er från klientsidan.

```javascript
    ...
  // Fetch Content Fragment Models
  const fetchContentFragmentModels = useCallback(async () => {
    try {
      updateState({ isLoading: true, error: null });
      const data = await makeApiRequest({
        endpoint: `${API_PATHS.CF_MODELS}?cursor=0&limit=10&projection=summary`,
      });
      updateState({ cfModels: data.items });
    } catch (err) {
      updateState({ error: err.message });
      console.error("Error fetching CF models:", err);
    } finally {
      updateState({ isLoading: false });
    }
  }, [makeApiRequest, updateState]);

  // Common API request helper
  const makeApiRequest = useCallback(
    async ({ endpoint, method = "GET", passAPIKey = false, body = null }) => {
    
      // Get the access token from the local storage
      const token = localStorage.getItem("adobe_ims_access_token");
      if (!token) {
        throw new Error("No access token available. Please login again.");
      }

      const headers = {
        Authorization: `Bearer ${token}`,
        "Content-Type": "application/json",
        ...(passAPIKey && { "x-api-key": APP_CONFIG.adobe.adc.clientId }),
      };

      const response = await fetch(
        `${APP_CONFIG.adobe.aem.hostname}${endpoint}`,
        {
          method,
          headers,
          ...(body && { body: JSON.stringify(body) }),
        }
      );

      if (!response.ok) {
        throw new Error(`API request failed: ${response.statusText}`);
      }

      return method === "DELETE" ? null : response.json();
    },
    []
  );
  ...
```

## Konfigurera och kör SPA{#setup-and-run-the-spa}

Låt oss konfigurera och köra WKND SPA på din lokala dator för att förstå autentiseringsflödet för OAuth Single Page App och API-anrop.

### Förutsättningar{#prerequisites}

För att kunna genomföra den här självstudiekursen behöver du:

- Moderniserad AEM as a Cloud Service-miljö med följande:
   - AEM version `2024.10.18459.20241031T210302Z` eller senare.
   - Nya produktprofiler (om miljön skapades före november 2024)

  Mer information finns i artikeln [Konfigurera OpenAPI-baserade AEM API:er](../setup.md) .

- Exempelprojektet [WKND Sites](https://github.com/adobe/aem-guides-wknd?#aem-wknd-sites-project) måste distribueras till det.

- Åtkomst till [Adobe Developer Console](https://developer.adobe.com/developer-console/docs/guides/getting-started/).

- Installera [Node.js](https://nodejs.org/en/) på den lokala datorn för att köra exempelprogrammet NodeJS.

### Utvecklingssteg{#development-steps}

Utvecklingsstegen på hög nivå är följande:

1. Konfigurera ADC-projekt
   1. Lägg till API:er för Assets och Sites.
   1. Konfigurera autentiseringsuppgifter för OAuth Single Page App.
1. Konfigurera AEM-instansen
   1. Aktivera ADC-projektkommunikation
   1. Om du vill att SPA ska få åtkomst till AEM API:er genom att konfigurera CORS-inställningarna.
1. Konfigurera och kör WKND SPA på den lokala datorn
1. Verifiera flödet från början till slut

### Konfigurera ADC-projekt{#configure-adc-project}

Konfigurationssteget för ADC-projekt är _upprepat_ från [Konfigurera OpenAPI-baserade AEM-API:er](../setup.md). Den upprepas för att lägga till Assets, Sites API och konfigurera autentiseringsmetoden som OAuth Single Page App.

1. Öppna önskat projekt från [Adobe Developer Console](https://developer.adobe.com/console/projects).

1. Om du vill lägga till AEM API:er klickar du på knappen **Lägg till API** .

   ![Lägg till API](../assets/spa/add-api.png)

1. I dialogrutan _Lägg till API_ kan du filtrera efter _Experience Cloud_, markera **AEM CS Sites Content Management**-kortet och klicka på **Nästa**.

   ![Lägg till AEM API](../assets/spa/add-aem-sites-api.png)

1. I dialogrutan _Konfigurera API_ väljer du autentiseringsalternativet **Användarautentisering** och klickar på **Nästa**.

   ![Konfigurera AEM API](../assets/spa/configure-aem-api.png)

1. I nästa dialogruta _Konfigurera API_ väljer du autentiseringsalternativet **OAuth Single-Page App** och klickar på **Next**.

   ![Konfigurera enkelsidig OAuth-app](../assets/spa/configure-oauth-spa.png)

1. Ange följande information i dialogrutan _Konfigurera OAuth-enkelsidig app_ och klicka på **Nästa**.
   - Standardomdirigerings-URI: `https://localhost:3001/callback`
   - Omdirigerings-URI-mönster: `https://localhost:3001/callback`

   ![Konfigurera enkelsidig OAuth-app](../assets/spa/configure-oauth-spa-details.png)

1. Granska de tillgängliga scopen och klicka på **Spara konfigurerad API**.

   ![Spara konfigurerat API](../assets/spa/save-configured-api.png)

1. Upprepa stegen ovan om du vill lägga till **AEM Assets Author API**.

1. Granska AEM API och autentiseringskonfigurationen.

   ![AEM API-konfiguration](../assets/spa/aem-api-configuration.png)

   ![Autentiseringskonfiguration](../assets/spa/authentication-configuration.png)

### Konfigurera AEM-instans för att aktivera ADC-projektkommunikation{#configure-aem-instance-to-enable-adc-project-communication}

Följ instruktionerna i artikeln [Konfigurera OpenAPI-baserade AEM API:er](../setup.md#configure-the-aem-instance-to-enable-adc-project-communication) för att konfigurera AEM-instansen så att ADC-projektkommunikation aktiveras.

### AEM CORS-konfiguration{#aem-cors-configuration}

AEM as a Cloud Service Cross-Origin Resource Sharing (CORS) underlättar för andra webbegenskaper än AEM att göra webbläsarbaserade klientanrop till AEM API:er.

1. Leta reda på eller skapa filen `com.adobe.granite.cors.impl.CORSPolicyImpl~wknd-graphql.cfg.json` från mappen `/ui.config/src/main/content/jcr_root/apps/wknd/osgiconfig/config.author/` i AEM Project.

   ![Sök efter CORS-konfigurationsfilen](../assets/spa/locate-cors-config-file.png)

1. Lägg till följande konfiguration i filen.

   ```json
   {
       "alloworigin":[
         ""
       ],
       "alloworiginregexp":[
         "https://localhost:.*",
         "http://localhost:.*"
       ],
       "allowedpaths": [
         "/adobe/sites/.*",
         "/graphql/execute.json.*",
         "/content/_cq_graphql/wknd-shared/endpoint.json",
         "/content/experience-fragments/.*"
       ],
       "supportedheaders": [
         "Origin",
         "Accept",
         "X-Requested-With",
         "Content-Type",
         "Access-Control-Request-Method",
         "Access-Control-Request-Headers",
         "Authorization"
       ],
       "supportedmethods":[
         "GET",
         "HEAD",
         "POST"
       ],
       "maxage:Integer": 1800,
       "supportscredentials": true,
       "exposedheaders":[ "" ]
   }
   ```

1. Bekräfta konfigurationsändringarna och skicka ändringarna till Git-fjärrdatabasen som Cloud Manager pipeline är ansluten till.

1. Distribuera ovanstående ändringar med FullStack Pipeline i Cloud Manager.

### Konfigurera och kör SPA{#configure-and-run-the-spa}

1. Hämta zip-filen [WKND SPA &amp; AEM APIs - Demo App](../assets/spa/wknd-spa-with-aemapis-demo.zip) och extrahera den.

1. Navigera till den extraherade mappen och kopiera filen `.env.example` till `.env`.

1. Uppdatera filen `.env` med de konfigurationsparametrar som krävs från Adobe Developer Console (ADC) Project- och AEM as a Cloud Service-miljön. Till exempel:

   ```plaintext
   ########################################################################
   # Adobe IMS, Adobe Developer Console (ADC), and AEM as a Cloud Service Information
   ########################################################################
   # Adobe IMS OAuth endpoints
   REACT_APP_ADOBE_IMS_AUTHORIZATION_ENDPOINT=https://ims-na1.adobelogin.com/ims/authorize/v2
   REACT_APP_ADOBE_IMS_TOKEN_ENDPOINT=https://ims-na1.adobelogin.com/ims/token/v3
   REACT_APP_ADOBE_IMS_USERINFO_ENDPOINT=https://ims-na1.adobelogin.com/ims/userinfo/v2
   
   # Adobe Developer Console (ADC) Project's OAuth Single-Page App credential
   REACT_APP_ADC_CLIENT_ID=ddsfs455a4a440c48c7474687c96945d
   REACT_APP_ADC_SCOPES=AdobeID,openid,aem.folders,aem.assets.author,aem.fragments.management
   
   # AEM Assets Information
   REACT_APP_AEM_ASSET_HOSTNAME=https://author-p69647-e1453424.adobeaemcloud.com/
   
   ################################################
   # Single Page Application Information
   ################################################
   
   # Enable HTTPS for local development
   HTTPS=true
   PORT=3001
   
   # SSL Certificate and Key for local development 
   SSL_CRT_FILE=./ssl/server.crt
   SSL_KEY_FILE=./ssl/server.key
   
   # The URL to which the user will be redirected after the OAuth flow is complete
   REACT_APP_REDIRECT_URI=https://localhost:3000/callback
   ```

1. Öppna en terminal och navigera till den extraherade mappen. Installera nödvändiga beroenden och starta WKND SPA med följande kommando.

   ```bash
   $ npm install
   $ npm start
   ```

### Verifiera flödet från början till slut{#verify-the-end-to-end-flow}

1. Öppna en webbläsare och gå till `https://localhost:3001` för att komma åt WKND SPA. Acceptera den självsignerade certifikatvarningen.

   ![WKND SPA - startsida](../assets/spa/wknd-spa-home.png)

1. Klicka på knappen **Adobe IMS-inloggning** för att initiera autentiseringsflödet för OAuth Single Page App.

1. Autentisera mot Adobe IMS och ge ditt medgivande till att WKND SPA får åtkomst till resurserna åt dig.

1. När autentiseringen lyckades omdirigeras du tillbaka till WKND SPA:s `/invoke-aem-apis`-väg och åtkomsttoken lagras i webbläsarens lokala lagring.

   ![WKND SPA Anropar AEM API:er](../assets/spa/wknd-spa-invoke-aem-apis.png)

1. Klicka på knappen **Hämta innehållsfragmentmodeller** i `https://localhost:3001/invoke-aem-apis`-vägen för att anropa API:t för innehållsfragmentmodeller. I SPA visas en lista med innehållsfragmentmodeller.

   ![WKND SPA - Hämta CF-modeller](../assets/spa/wknd-spa-fetch-cf-models.png)

1. På samma sätt kan du visa, skapa och ta bort DAM-mappar på fliken **Assets - Mappar API** .

   ![WKND SPA Assets API](../assets/spa/wknd-spa-assets-api.png)

1. I webbläsarens utvecklingsverktyg kan du inspektera nätverksförfrågningar och svar för att förstå API-anropen.

   ![WKND SPA-nätverksbegäranden](../assets/spa/wknd-spa-network-requests.png)

>[!IMPORTANT]
>
>Om den autentiserade användaren saknar nödvändig behörighet för att lista, skapa eller ta bort AEM-resurser misslyckas API-anropen med ett 403-fel som inte är tillåtet. Även om användaren är autentiserad och har en giltig IMS-åtkomsttoken kan han eller hon inte få åtkomst till AEM-resurser utan den behörighet som krävs.

### Granska SPA-koden{#review-the-spa-code}

Låt oss granska den övergripande kodstrukturen och de viktigaste startpunkterna i WKND SPA. SPA byggs med React Framework och använder React Context API för autentisering och statushantering.

1. Filen `src/App.js` är huvudstartpunkten i WKND SPA. Programkomponenten kapslar in hela programmet och initierar `IMSAuthProvider`-kontexten.

1. `src/context/IMSAuthContext.js` skapar Adobe IMSAuthContext för att ge de underordnade komponenterna autentiseringstillstånd. Den innehåller inloggnings-, utloggnings- och handleCallback-funktioner som initierar autentiseringsflödet för OAuth Single Page App.

1. Mappen `src/components` innehåller olika komponenter som demonstrerar API-anropen till AEM API:er. Komponenten `InvokeAemApis.js` visar hur du använder åtkomsttoken för att anropa AEM API:er.

1. Filen `src/config/config.js` läser in miljövariablerna från filen `.env` och exporterar dem för användning i programmet.

1. Filen `src/utils/auth.js` innehåller verktygsfunktioner som genererar kodverifieraren och kodutmaningen för OAuth 2.0 PKCE-flödet.

1. Mappen `ssl` innehåller det självsignerade certifikatet och nyckelfilerna som ska köra den lokala SSL HTTP-proxyn.

Du kan utveckla eller integrera befintliga SPA med Adobe API:er med hjälp av de metoder som illustreras i den här självstudiekursen.

## Sammanfattning{#summary}

I den här självstudiekursen lärde du dig att anropa OpenAPI-baserade AEM-API:er på AEM as a Cloud Service med användarbaserad autentisering från en Single Page App (SPA) via OAuth 2.0 PKCE-flödet.

## Ytterligare resurser{#additional-resources}

- [Implementeringshandbok för användarautentisering](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/implementation/)
- [Auktorisera begäran](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/IMS/#authorize-request)
- [Hämtar åtkomsttoken](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/IMS/#fetching-access-tokens)
