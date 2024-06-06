---
title: Github.com av webbkrok
description: Lär dig hur du verifierar en webkrok från Github.com i en App Builder-åtgärd.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Intermediate
jira: KT-15714
last-substantial-update: 2023-06-06T00:00:00Z
source-git-commit: 4b9f784de5fff7d9ba8cf7ddbe1802c271534010
workflow-type: tm+mt
source-wordcount: '363'
ht-degree: 0%

---


# Github.com av webbkrok

Med hjälp av Webhooks kan du skapa eller konfigurera integreringar som prenumererar på vissa händelser på GitHub.com. När en av dessa händelser utlöses skickar GitHub en HTTP-POST-nyttolast till webboks konfigurerade URL. Av säkerhetsskäl är det dock viktigt att verifiera att inkommande webkrok-begäran faktiskt kommer från GitHub och inte från en skadlig aktör. Den här självstudiekursen vägleder dig genom stegen för att verifiera en GitHub.com webkrok-förfrågan i en Adobe App Builder-åtgärd med hjälp av en delad hemlighet.

## Konfigurera Github-hemlighet i AppBuilder

1. **Lägg till hemlighet i `.env` fil:**

   I App Builder-projektets `.env` lägger du till en anpassad nyckel för GitHub.com-webbhollhemlighet:

   ```env
   # Specify your secrets here
   # This file must not be committed to source control
   ...
   GITHUB_SECRET=my-github-webhook-secret-1234!
   ```

2. **Uppdatera `ext.config.yaml` fil:**

   The `ext.config.yaml` filen måste uppdateras för att verifiera GitHub.com webkrok-förfrågan.

   - Ange AppBuilder-åtgärden `web` konfiguration till `raw` om du vill ha texten för obearbetade förfrågningar från GitHub.com.
   - Under `inputs` i AppBuilder-åtgärdskonfigurationen lägger du till `GITHUB_SECRET` nyckel, mappa den till `.env` fält som innehåller hemligheten. Värdet för den här nyckeln är `.env` fältnamn prefix med `$`.
   - Ange `require-adobe-auth` anteckning i AppBuilder-åtgärdskonfigurationen till `false` så att åtgärden kan anropas utan att autentisering av Adobe krävs.

   Resultatet `ext.config.yaml` filen ska se ut ungefär så här:

   ```yaml
   operations:
     view:
       - type: web
         impl: index.html
   actions: actions
   web: web-src
   runtimeManifest:
     packages:
       dx-excshell-1:
         license: Apache-2.0
         actions:
           github-to-jira:
             function: actions/generic/index.js
             web: 'raw'
             runtime: nodejs:20
             inputs:
               LOG_LEVEL: debug
               GITHUB_SECRET: $GITHUB_SECRET
             annotations:
               require-adobe-auth: false
               final: true
   ```

## Lägg till verifieringskod i AppBuilder-åtgärden

Lägg sedan till JavaScript-koden som anges nedan (kopieras från [GitHub.coms dokumentation](https://docs.github.com/en/webhooks/using-webhooks/validating-webhook-deliveries#javascript-example)) till din AppBuilder-åtgärd. Se till att exportera `verifySignature` funktion.

```javascript
// src/dx-excshell-1/actions/generic/github-webhook-verification.js

let encoder = new TextEncoder();

async function verifySignature(secret, header, payload) {
    let parts = header.split("=");
    let sigHex = parts[1];

    let algorithm = { name: "HMAC", hash: { name: 'SHA-256' } };

    let keyBytes = encoder.encode(secret);
    let extractable = false;
    let key = await crypto.subtle.importKey(
        "raw",
        keyBytes,
        algorithm,
        extractable,
        [ "sign", "verify" ],
    );

    let sigBytes = hexToBytes(sigHex);
    let dataBytes = encoder.encode(payload);
    let equal = await crypto.subtle.verify(
        algorithm.name,
        key,
        sigBytes,
        dataBytes,
    );

    return equal;
}

function hexToBytes(hex) {
    let len = hex.length / 2;
    let bytes = new Uint8Array(len);

    let index = 0;
    for (let i = 0; i < hex.length; i += 2) {
        let c = hex.slice(i, i + 2);
        let b = parseInt(c, 16);
        bytes[index] = b;
        index += 1;
    }

    return bytes;
}

module.exports = { verifySignature };
```

## Implementera verifiering i AppBuilder-åtgärd

Verifiera sedan att begäran kommer från GitHub genom att jämföra signaturen i begärandehuvudet med signaturen som genereras av `verifySignature` funktion.

I AppBuilder-åtgärdens `index.js`lägger du till följande kod i `main` funktion:


```javascript
// src/dx-excshell-1/actions/generic/index.js

const { verifySignature } = require("./github-webhook-verification");
...

// Main function that will be executed by Adobe I/O Runtime
async function main(params) {
  // Create a Logger
  const logger = Core.Logger("main", { level: params?.LOG_LEVEL || "info" });

  try {
    // Log parameters if LOG_LEVEL is 'debug'
    logger.debug(stringParameters(params));

    // Define required parameters and headers
    const requiredParams = [
      // Verifies the GITHUB_SECRET is present in the action's configuration; add other parameters here as needed.
      "GITHUB_SECRET"
    ];

    const requiredHeaders = [
      // Require the x-hub-signature-256 header, which GitHub.com populates with a sha256 hash of the payload
      "x-hub-signature-256"
    ];

    // Check for missing required parameters and headers
    const errorMessage = checkMissingRequestInputs(params, requiredParams, requiredHeaders);

    if (errorMessage) {
      // Return and log client errors
      return errorResponse(400, errorMessage, logger);
    }

    // Decode the request body (which is base64 encoded) to a string
    const body = Buffer.from(params.__ow_body, 'base64').toString('utf-8');

    // Verify the GitHub webhook signature
    const isSignatureValid = await verifySignature(
      params.GITHUB_SECRET,
      params.__ow_headers["x-hub-signature-256"],
      body
    );

    if (!isSignatureValid) {
      // GitHub signature verification failed
      return errorResponse(401, "Unauthorized", logger);
    } else {
      logger.debug("Signature verified");
    }

    // Parse the request body as JSON so its data is useful in the action
    const githubParams = JSON.parse(body) || {};

    // Optionally, merge the GitHub webhook request parameters with the action parameters
    const mergedParams = {
      ...params,
      ...githubParams
    };

    // Do work based on the GitHub webhook request
    doWork(mergedParams);

    return {
      statusCode: 200,
      body: { message: "GitHub webhook received and processed!" }
    };

  } catch (error) {
    // Log any server errors
    logger.error(error);
    // Return with 500 status code
    return errorResponse(500, "Server error", logger);
  }
}
```

## Konfigurera webkrok i GitHub

Gå tillbaka till GitHub.com och ange samma hemliga värde för GitHub.com när du skapar webkroken. Använd det hemliga värdet som anges i `.env` fil `GITHUB_SECRET` -tangenten.

Gå till databasinställningarna i GitHub.com och redigera webkroken. Ange det hemliga värdet i webbkrokinställningarna `Secret` fält. Klicka __Uppdatera webkrok__ längst ned för att spara ändringarna.

![Github Webkrok Secret](./assets/github-webhook-verification/github-webhook-settings.png)

Genom att följa de här stegen ser du till att din App Builder-åtgärd på ett säkert sätt kan verifiera att inkommande webkrok verkligen kommer från din GitHub.com.
