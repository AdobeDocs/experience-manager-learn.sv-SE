---
title: Generera JWT-åtkomsttoken i App Builder-åtgärd
description: Lär dig hur du skapar en åtkomsttoken med JWT-autentiseringsuppgifter som kan användas i en App Builder-åtgärd.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Intermediate
jira: KT-11743
last-substantial-update: 2023-01-17T00:00:00Z
exl-id: 9a3fed96-c99b-43d1-9dba-a4311c65e5b9
duration: 151
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '456'
ht-degree: 0%

---

# Generera JWT-åtkomsttoken i App Builder-åtgärd

App Builder-åtgärder kan behöva interagera med Adobe API:er som är kopplade till Adobe Developer Console-projekt om App Builder-appen också ska användas.

Detta kan kräva att App Builder-åtgärden genererar en egen JWT-åtkomsttoken som är kopplad till önskat Adobe Developer Console-projekt.

>[!IMPORTANT]
>
> Granska [App Builder säkerhetsdokumentation](https://developer.adobe.com/app-builder/docs/guides/security/) för att förstå när det är lämpligt att generera åtkomsttoken jämfört med att använda tillhandahållna åtkomsttoken.
>
> Den anpassade åtgärden kan behöva tillhandahålla egna säkerhetskontroller för att säkerställa att bara de som tillåts komma åt App Builder-åtgärden, och de Adobe-tjänster som ligger till grund för den, får åtkomst till åtgärden.


## .env-fil

I App Builder-projektets `.env`-fil lägger du till anpassade nycklar för varje Adobe Developer Console-projekts JWT-autentiseringsuppgifter. JWT-autentiseringsuppgifter kan hämtas från Adobe Developer Console-projektets __autentiseringsuppgifter__ > __tjänstkonto (JWT)__ för en viss arbetsyta.

![Adobe Developer Console JWT-tjänstautentiseringsuppgifter](./assets/jwt-auth/jwt-credentials.png)

```
...
JWT_CLIENT_ID=58b23182d80a40fea8b12bc236d71167
JWT_CLIENT_SECRET=p8e-EIRF6kY6EHLBSdw2b-pLUWKodDqJqSz3
JWT_TECHNICAL_ACCOUNT_ID=1F072B8A63C6E0230A495EE1@techacct.adobe.com
JWT_IMS_ORG=7ABB3E6A5A7491460A495D61@AdobeOrg
JWT_METASCOPES=https://ims-na1.adobelogin.com/s/ent_analytics_bulk_ingest_sdk,https://ims-na1.adobelogin.com/s/event_receiver_api
JWT_PRIVATE_KEY=LS0tLS1C..kQgUFJJVkFURSBLRVktLS0tLQ==
```

Värdena för `JWT_CLIENT_ID`, `JWT_CLIENT_SECRET`, `JWT_TECHNICAL_ACCOUNT_ID`, `JWT_IMS_ORG` kan kopieras direkt från Adobe Developer Console-projektets JWT-inloggningsskärm.

### Metasskop

Bestäm vilka Adobe-API:er och deras metaskop App Builder-åtgärden interagerar med. Visa metaseparerade områden med kommaavgränsare i tangenten `JWT_METASCOPES`. Giltiga metascope-objekt visas i [Adobe JWT Metascope-dokumentation](https://developer.adobe.com/developer-console/docs/guides/authentication/JWT/Scopes/).


Följande värde kan till exempel läggas till i nyckeln `JWT_METASCOPES` i `.env`:

```
...
JWT_METASCOPES=https://ims-na1.adobelogin.com/s/ent_analytics_bulk_ingest_sdk,https://ims-na1.adobelogin.com/s/event_receiver_api
...
```

### Privat nyckel

`JWT_PRIVATE_KEY` måste vara speciellt formaterad eftersom den är ett flerradsvärde som inte stöds i `.env`-filer. Det enklaste sättet är att base64 koda den privata nyckeln. Base64-kodning av den privata nyckeln (`-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----`) kan utföras med inbyggda verktyg från operativsystemet.

>[!BEGINTABS]

>[!TAB macOS]

1. Öppna `Terminal`
1. Kör kommandot `base64 -i /path/to/private.key | pbcopy`
1. Base64-utdata kopieras automatiskt till Urklipp
1. Klistra in i `.env` som värde till motsvarande nyckel

>[!TAB Windows]

1. Öppna `Command Prompt`
1. Kör kommandot `certutil -encode C:\path\to\private.key C:\path\to\encoded-private.key`
1. Kör kommandot `findstr /v CERTIFICATE C:\path\to\encoded-private.key`
1. Kopiera base64-utdata till Urklipp
1. Klistra in i `.env` som värde till motsvarande nyckel

>[!TAB Linux®]

1. Öppen terminal
1. Kör kommandot `base64 private.key`
1. Kopiera base64-utdata till Urklipp
1. Klistra in i `.env` som värde till motsvarande nyckel

>[!ENDTABS]

Följande base64-kodade privata nyckel kan till exempel läggas till i nyckeln `JWT_PRIVATE_KEY` i `.env`:

```
...
JWT_PRIVATE_KEY=LS0tLS1C..kQgUFJJVkFURSBLRVktLS0tLQ==
```

## Indatamappning

När JWT-autentiseringsuppgiftsvärdet har angetts i filen `.env` måste de mappas till åtgärdsindata för AppBuilder så att de kan läsas i själva åtgärden. Det gör du genom att lägga till poster för varje variabel i `ext.config.yaml`-åtgärden `inputs` i formatet: `PARAMS_INPUT_NAME: $ENV_KEY`.

Till exempel:

```yaml
operations:
  view:
    - type: web
      impl: index.html
actions: actions
runtimeManifest:
  packages:
    dx-excshell-1:
      license: Apache-2.0
      actions:
        generic:
          function: actions/generic/index.js
          web: 'yes'
          runtime: nodejs:16
          inputs:
            LOG_LEVEL: debug
            JWT_CLIENT_ID: $JWT_CLIENT_ID
            JWT_TECHNICAL_ACCOUNT_ID: $JWT_TECHNICAL_ACCOUNT_ID
            JWT_IMS_ORG: $JWT_IMS_ORG
            JWT_METASCOPES: $JWT_METASCOPES
            JWT_PRIVATE_KEY: $JWT_PRIVATE_KEY
          annotations:
            require-adobe-auth: false
            final: true
```

Nycklarna som definieras under `inputs` är tillgängliga för objektet `params` som tillhandahålls för App Builder-åtgärden.


## JWT-autentiseringsuppgifter för att komma åt token

I App Builder-åtgärden är JWT-autentiseringsuppgifterna tillgängliga i `params`-objektet och kan användas av [`@adobe/jwt-auth`](https://www.npmjs.com/package/@adobe/jwt-auth) för att generera en åtkomsttoken, som i sin tur kan komma åt andra Adobe API:er och tjänster.

```javascript
const fetch = require("node-fetch");
const { Core } = require("@adobe/aio-sdk");
const { errorResponse, stringParameters, checkMissingRequestInputs } = require("../utils");
const auth = require("@adobe/jwt-auth");

async function main(params) {
  const logger = Core.Logger("main", { level: params.LOG_LEVEL || "info" });

  try {
    // Perform any necessary input error checking
    const systemErrorMessage = checkMissingRequestInputs(params, [
            "JWT_CLIENT_ID", "JWT_TECHNICAL_ACCOUNT_ID", "JWT_IMS_ORG", "JWT_CLIENT_SECRET", "JWT_METASCOPES", "JWT_PRIVATE_KEY"], []);

    // Split the metascopes into an array (they are comma delimited in the .env file)
    const metascopes = params.JWT_METASCOPES?.split(',') || [];

    // Base64 decode the private key value
    const privateKey = Buffer.from(params.JWT_PRIVATE_KEY, 'base64').toString('utf-8');

    // Exchange the JWT credentials for an 24-hour Access Token
    let { accessToken } = await auth({
      clientId: params.JWT_CLIENT_ID,                          // Client Id
      technicalAccountId: params.JWT_TECHNICAL_ACCOUNT_ID,     // Technical Account Id
      orgId: params.JWT_IMS_ORG,                               // Adobe IMS Org Id
      clientSecret: params.JWT_CLIENT_SECRET,                  // Client Secret
      metaScopes: metascopes,                                  // Metadcopes defining level of access the access token should provide
      privateKey: privateKey,                                  // Private Key to sign the JWT
    });

    // The 24-hour IMS Access Token is used to call the Analytics APIs
    // Can look at caching this token for 24 hours to reduce calls
    const accessToken = await getAccessToken(params);

    // Invoke an exmaple Adobe API endpoint using the generated accessToken
    const res = await fetch('https://analytics.adobe.io/api/example/reports', {
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-Proxy-Global-Company-Id": 'example',
        "Authorization": `Bearer ${accessToken}`,
        "x-Api-Key": params.JWT_CLIENT_ID,
      },
      method: "POST",
      body: JSON.stringify({... An Analytics query ... }),
    });

    if (!res.ok) { throw new Error("Request to API failed with status code " + res.status);}

    // Analytics API data
    let data = await res.json();

    const response = {
      statusCode: 200,
      body: data,
    };

    return response;
  } catch (error) {
    logger.error(error);
    return errorResponse(500, "server error", logger);
  }
}

exports.main = main;
```
