---
title: Generera åtkomsttoken för server-till-server i App Builder-åtgärden
description: Lär dig hur du skapar en åtkomsttoken med hjälp av autentiseringsuppgifter för OAuth Server-till-Server som kan användas i en App Builder-åtgärd.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Intermediate
jira: KT-14724
last-substantial-update: 2024-02-29T00:00:00Z
duration: null
source-git-commit: c77dd9c2872e7e43863d83837cedbff50a7d3c1a
workflow-type: tm+mt
source-wordcount: '400'
ht-degree: 0%

---

# Generera åtkomsttoken för server-till-server i App Builder-åtgärden

App Builder-åtgärder kan behöva interagera med Adobe API:er som stöder **OAuth Server-till-Server-autentiseringsuppgifter** och är kopplade till Adobe Developer Console-projekt som appen App Builder är distribuerad.

I den här guiden beskrivs hur du skapar en åtkomsttoken med _OAuth Server-till-Server-autentiseringsuppgifter_ för användning i en App Builder-åtgärd.

>[!IMPORTANT]
>
> JWT-autentiseringsuppgifterna (Service Account) har ersatts med autentiseringsuppgifterna för OAuth Server-till-Server. Det finns dock fortfarande vissa Adobe-API:er som bara stöder JWT-autentiseringsuppgifter och migrering till OAuth Server-till-Server pågår. Läs Adobe API-dokumentationen för att ta reda på vilka autentiseringsuppgifter som stöds.

## Projektkonfigurationer för Adobe Developer Console

När du lägger till önskat Adobe-API i Adobe Developer Console-projekt finns det i _Konfigurera API_ väljer du **OAuth Server-till-server** autentiseringstyp.

![Adobe Developer Console - OAuth Server-till-server](./assets/s2s-auth/oauth-server-to-server.png)

Välj önskad produktprofil om du vill tilldela det ovan automatiskt skapade integrationstjänstkontot. Det innebär att tjänstkontots behörigheter styrs via produktprofilen.

![Adobe Developer Console - produktprofil](./assets/s2s-auth/select-product-profile.png)

## .env-fil

I App Builder-projektets `.env` lägg till anpassade nycklar för Adobe Developer Console-projektets OAuth Server-till-Server-autentiseringsuppgifter. Autentiseringsvärdena för OAuth Server-till-Server kan hämtas från Adobe Developer Console-projektets __Referenser__ > __OAuth Server-till-server__ för en viss arbetsyta.

![Adobe Developer Console OAuth Server-till-server-autentiseringsuppgifter](./assets/s2s-auth/oauth-server-to-server-credentials.png)

```
...
OAUTHS2S_CLIENT_ID=58b23182d80a40fea8b12bc236d71167
OAUTHS2S_CLIENT_SECRET=p8e-EIRF6kY6EHLBSdw2b-pLUWKodDqJqSz3
OAUTHS2S_CECREDENTIALS_METASCOPES=AdobeID,openid,ab.manage,additional_info.projectedProductContext,read_organizations,read_profile,account_cluster.read
```

Värdena för `OAUTHS2S_CLIENT_ID`, `OAUTHS2S_CLIENT_SECRET`, `OAUTHS2S_CECREDENTIALS_METASCOPES` kan kopieras direkt från Adobe Developer Console-projektets skärm OAuth Server-till-Server-autentiseringsuppgifter.

## Indatamappning

Med autentiseringsuppgiften OAuth Server-to-Server angiven i `.env` måste de mappas till AppBuilder-åtgärdsindata så att de kan läsas i själva åtgärden. Det gör du genom att lägga till poster för varje variabel i `ext.config.yaml` åtgärd `inputs` i formatet: `PARAMS_INPUT_NAME: $ENV_KEY`.

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
            OAUTHS2S_CLIENT_ID: $OAUTHS2S_CLIENT_ID
            OAUTHS2S_CLIENT_SECRET: $OAUTHS2S_CLIENT_SECRET
            OAUTHS2S_CECREDENTIALS_METASCOPES: $OAUTHS2S_CECREDENTIALS_METASCOPES
          annotations:
            require-adobe-auth: false
            final: true
```

De tangenter som definieras under `inputs` finns på `params` -objekt som anges för App Builder-åtgärden.

## OAuth Server-till-Server-autentiseringsuppgifter för att komma åt token

I App Builder-åtgärden är autentiseringsuppgifterna för OAuth Server-till-Server tillgängliga i `params` -objekt. Med dessa autentiseringsuppgifter kan åtkomsttoken genereras med [OAuth 2.0-bibliotek](https://oauth.net/code/). Du kan också använda [Nodhämtningsbibliotek](https://www.npmjs.com/package/node-fetch) om du vill göra en POST-förfrågan till Adobe IMS-tokenslutpunkten för att hämta åtkomsttoken.

I följande exempel visas hur du använder `node-fetch` bibliotek för att göra en begäran om POST till Adobe IMS-tokenslutpunkten för att hämta åtkomsttoken.

```javascript
const fetch = require("node-fetch");
const { Core } = require("@adobe/aio-sdk");
const { errorResponse, stringParameters, checkMissingRequestInputs } = require("../utils");

async function main(params) {
  const logger = Core.Logger("main", { level: params.LOG_LEVEL || "info" });

  try {
    // Perform any necessary input error checking
    const systemErrorMessage = checkMissingRequestInputs(params, ["OAUTHS2S_CLIENT_ID", "OAUTHS2S_CLIENT_SECRET", "OAUTHS2S_CECREDENTIALS_METASCOPES"], []);

    // The Adobe IMS token endpoint URL
    const adobeIMSV3TokenEndpointURL = 'https://ims-na1.adobelogin.com/ims/token/v3';

    // The POST request options
    const options = {
        method: 'POST',
        headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `grant_type=client_credentials&client_id=${params.OAUTHS2S_CLIENT_ID}&client_secret=${params.OAUTHS2S_CLIENT_SECRET}&scope=${params.OAUTHS2S_CECREDENTIALS_METASCOPES}`,
    };

    // Make a POST request to the Adobe IMS token endpoint to get the access token
    const response = await fetch(adobeIMSV3TokenEndpointURL, options);
    const responseJSON = await response.json();

    // The 24-hour IMS Access Token is used to call the AEM Data Service API
    // Can look at caching this token for 24 hours to reduce calls
    const accessToken = responseJSON.access_token;

    // Invoke an AEM Data Service API using the access token
    const res = await fetch(`https://api.adobeaemcloud.com/adobe/stats/statistics/contentRequestsQuota?imsOrgId=${IMS_ORG_ID}&current=true`, {
      headers: {
        'X-Adobe-Accept-Experimental': '1',
        'x-gw-ims-org-id': IMS_ORG_ID,
        'X-Api-Key': params.OAUTHS2S_CLIENT_ID,
        Authorization: `Bearer ${access_token}`, // The 24-hour IMS Access Token
      },
      method: "GET",
    });

    if (!res.ok) { throw new Error("Request to API failed with status code " + res.status);}

    // API data
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
