---
title: Github.com av webbkrok
description: Lär dig hur du verifierar en webkrok från Github.com i en App Builder-åtgärd.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Intermediate
jira: KT-15714
last-substantial-update: 2023-06-06T00:00:00Z
exl-id: 5492dc7b-f034-4a7f-924d-79e083349e26
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '363'
ht-degree: 0%

---

# Github.com av webbkrok

Med hjälp av Webhooks kan du skapa eller konfigurera integreringar som prenumererar på vissa händelser på GitHub.com. När en av dessa händelser utlöses skickar GitHub en HTTP POST-nyttolast till webchens konfigurerade URL. Av säkerhetsskäl är det dock viktigt att verifiera att inkommande webkrok-begäran faktiskt kommer från GitHub och inte från en skadlig aktör. Den här självstudiekursen vägleder dig genom stegen för att verifiera en GitHub.com webkrok-förfrågan i en Adobe App Builder-åtgärd med hjälp av en delad hemlighet.

## Konfigurera Github-hemlighet i AppBuilder

1. **Lägg till hemlighet i `.env`-filen:**

   I App Builder-projektets `.env`-fil lägger du till en anpassad nyckel för GitHub.com-webbkrokhemligheten:

   ```env
   # Specify your secrets here
   # This file must not be committed to source control
   ...
   GITHUB_SECRET=my-github-webhook-secret-1234!
   ```

2. **Uppdatera `ext.config.yaml`-fil:**

   Filen `ext.config.yaml` måste uppdateras för att GitHub.com ska kunna verifieras.

   - Ställ in konfigurationen `web` för AppBuilder-åtgärden på `raw` för att ta emot texten för Raw-begäran från GitHub.com.
   - Lägg till nyckeln `GITHUB_SECRET` under `inputs` i åtgärdskonfigurationen för AppBuilder och mappa den till fältet `.env` som innehåller hemligheten. Värdet för den här nyckeln är fältnamnet `.env` som har prefixet `$`.
   - Ange `require-adobe-auth`-anteckningen i AppBuilder-åtgärdskonfigurationen till `false` för att tillåta att åtgärden anropas utan att Adobe-autentisering krävs.

   Den resulterande `ext.config.yaml`-filen ska se ut ungefär så här:

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

Lägg sedan till den JavaScript-kod som anges nedan (kopieras från [GitHub.coms dokumentation](https://docs.github.com/en/webhooks/using-webhooks/validating-webhook-deliveries#javascript-example)) till din AppBuilder-åtgärd. Se till att exportera funktionen `verifySignature`.

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

Verifiera sedan att begäran kommer från GitHub genom att jämföra signaturen i begärandehuvudet med signaturen som genereras av funktionen `verifySignature`.

Lägg till följande kod i funktionen `main` i AppBuilder-åtgärdens `index.js`:


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

Gå tillbaka till GitHub.com och ange samma hemliga värde för GitHub.com när du skapar webkroken. Använd det hemliga värde som anges i `.env`-filens `GITHUB_SECRET`-nyckel.

Gå till databasinställningarna i GitHub.com och redigera webkroken. Ange det hemliga värdet i fältet `Secret` i webkrokinställningarna. Klicka på __Uppdatera webkrok__ längst ned om du vill spara ändringarna.

![Github Webkrok Secret](./assets/github-webhook-verification/github-webhook-settings.png)

Följ de här stegen för att se till att din App Builder-åtgärd på ett säkert sätt kan verifiera att inkommande webkrok-begäranden verkligen kommer från din GitHub.com.
