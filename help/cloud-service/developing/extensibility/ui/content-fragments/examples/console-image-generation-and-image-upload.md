---
title: OpenAI-bildgenerering via ett anpassat tillägg för Content Fragment Console
description: Lär dig hur du genererar digitala bilder från en beskrivning på ett naturligt språk med OpenAI eller DALL ・ E 2 och överför genererad bild till AEM med ett anpassat tillägg för Content Fragment Console.
feature: Developer Tools, Content Fragments
version: Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-11649
thumbnail: KT-11649.png
doc-type: article
last-substantial-update: 2024-01-26T00:00:00Z
exl-id: f3047f1d-1c46-4aee-9262-7aab35e9c4cb
duration: 1380
source-git-commit: 6f1245e804f0311c3f833ea8b2324cbc95272f52
workflow-type: tm+mt
source-wordcount: '1289'
ht-degree: 0%

---

# Generera AEM bildresurser med OpenAI

Lär dig hur du genererar en bild med OpenAI eller DALL ・ E 2 och överför den till AEM DAM för snabb innehållshantering.

>[!VIDEO](https://video.tv.adobe.com/v/3413093?quality=12&learn=on)

Det här exemplet AEM tillägget Content Fragment Console är ett [åtgärdsfält](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/action-bar/) tillägg som genererar digital bild från indata på naturens språk med [OpenAI API](https://openai.com/api/) eller [DALL ・ E 2](https://openai.com/dall-e-2/). Den genererade bilden överförs till AEM DAM och den valda Content Fragment-bildegenskapen uppdateras för att referera till den nyligen genererade, överförda bilden från DAM.

I det här exemplet lär du dig:

1. Bildgenerering med [OpenAI API](https://beta.openai.com/docs/guides/images/image-generation-beta) eller [DALL ・ E 2](https://openai.com/dall-e-2/)
2. Överför bilder till AEM
3. Egenskapsuppdatering för innehållsfragment

Det funktionella flödet för exempeltillägget är följande:

![Adobe I/O Runtime action flow for digital image generation](./assets/digital-image-generation/flow.png){align="center"}

1. Välj Innehållsfragment och klicka på tilläggets `Generate Image` knappen i [åtgärdsfält](#extension-registration) öppnar [modal](#modal).
1. The [modal](#modal) visar ett anpassat indataformulär som skapats med [Reagera spektrum](https://react-spectrum.adobe.com/react-spectrum/).
1. När du skickar formuläret skickas den angivna användaren `Image Description` text, det markerade innehållsfragmentet och AEM värd för [anpassad Adobe I/O Runtime-åtgärd](#adobe-io-runtime-action).
1. The [Adobe I/O Runtime action](#adobe-io-runtime-action) validerar indata.
1. Därefter anropas OpenAI:s [Bildgenerering](https://beta.openai.com/docs/guides/images/image-generation-beta) API och använder `Image Description` text för att ange vilken bild som ska genereras.
1. The [bildgenerering](https://beta.openai.com/docs/guides/images/image-generation-beta) slutpunkten skapar en originalbild med storleken _1024x1024_ pixlar som använder parametervärdet för promptbegäran och returnerar den genererade bild-URL:en som svar.
1. The [Adobe I/O Runtime action](#adobe-io-runtime-action) hämtar den genererade bilden till App Builder-miljön.
1. Därefter initieras bildöverföringen från App Builder-miljön till AEM DAM under en fördefinierad sökväg.
1. Den AEM as a Cloud Service sparar bilden i DAM och returnerar om Adobe I/O Runtime-åtgärden lyckades eller misslyckades. Det överförda svaret uppdaterar det valda Content Fragments image-egenskapsvärde med en annan HTTP-begäran som AEM från Adobe I/O Runtime-åtgärden.
1. modalen tar emot svar från Adobe I/O Runtime-åtgärden och tillhandahåller länken AEM resursinformation för den nyligen genererade, överförda bilden.

## Tilläggspunkt

Det här exemplet utökar till tilläggspunkten `actionBar` om du vill lägga till en anpassad knapp i konsolen för innehållsfragment.

| AEM UI Extended | Tilläggspunkt |
| ------------------------ | --------------------- | 
| [Konsol för innehållsfragment](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/) | [Åtgärdsfält](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/action-bar/) |

## Exempel på tillägg

I exemplet används ett befintligt Adobe Developer Console-projekt och följande alternativ när appen App Builder initieras via `aio app init`.

+ Vilka mallar vill du söka efter? `All Extension Points`
+ Välj de mallar som ska installeras:` @adobe/aem-cf-admin-ui-ext-tpl`
+ Vad vill du ge tillägget ett namn? `Image generation`
+ Ange en kort beskrivning av ditt tillägg: `An example action bar extension that generates an image using OpenAI and uploads it to AEM DAM.`
+ Vilken version vill du börja med? `0.0.1`
+ Vad vill du göra nu?
   + `Add a custom button to Action Bar`
      + Ange knappens etikettnamn: `Generate Image`
      + Måste du visa en modal för knappen? `y`
   + `Add server-side handler`
      + Med Adobe I/O Runtime kan du anropa serverlös kod vid behov. Hur vill du namnge den här åtgärden?: `generate-image`

Den skapade App Builder-tilläggsappen uppdateras enligt beskrivningen nedan.

### Inledande konfiguration

1. Registrera dig kostnadsfritt [OpenAI API](https://openai.com/api/) konto och skapa [API-nyckel](https://beta.openai.com/account/api-keys)
1. Lägg till den här nyckeln i ditt App Builder-projekts `.env` fil

   ```
       # Specify your secrets here
       # This file must not be committed to source control
       ## Adobe I/O Runtime credentials
       ...
       AIO_runtime_apihost=https://adobeioruntime.net
       ...
       # OpenAI secret API key
       OPENAI_API_KEY=my-openai-secrete-key-to-generate-images
       ...
   ```

1. Godkänd `OPENAI_API_KEY` uppdaterar Adobe I/O Runtime-åtgärden `src/aem-cf-console-admin-1/ext.config.yaml`

   ```yaml
       ...
   
       runtimeManifest:
         packages:
           aem-cf-console-admin-1:
             license: Apache-2.0
             actions:
               generate-image:
                 function: actions/generate-image/index.js
                 web: 'yes'
                 runtime: nodejs:16
                 inputs:
                   LOG_LEVEL: debug
                   OPENAI_API_KEY: $OPENAI_API_KEY
       ...
   ```

1. Installera under Node.js-bibliotek
   1. [OpenAI Node.js Library](https://github.com/openai/openai-node#installation) - för att enkelt anropa OpenAI API:t
   1. [AEM](https://github.com/adobe/aem-upload#install) - för att överföra bilder till AEM-CS-instanser.


>[!TIP]
>
>I följande avsnitt får du lära dig mer om nyckelfilerna React och Adobe I/O Runtime Action JavaScript. Nyckelfilerna från `web-src` och  `actions` finns i AppBuilder-projektmappen. [adobe-appbuilder-cfc-ext-image-generation-code.zip](./assets/digital-image-generation/adobe-appbuilder-cfc-ext-image-generation-code.zip).


### Appvägar{#app-routes}

The `src/aem-cf-console-admin-1/web-src/src/components/App.js` innehåller [Reagera router](https://reactrouter.com/en/main).

Det finns två logiska uppsättningar vägar:

1. Den första rutten mappar begäranden till `index.html`, som anropar React-komponenten som ansvarar för [tilläggsregistrering](#extension-registration).

   ```javascript
   <Route index element={<ExtensionRegistration />} />
   ```

1. Den andra uppsättningen vägar mappar URL:er till React-komponenter som återger innehållet i tilläggets modal. The `:selection` -param representerar en avgränsad sökväg för innehållsfragment.

   Om tillägget har flera knappar för att anropa diskreta åtgärder ska varje [tilläggsregistrering](#extension-registration) mappar till en väg som definieras här.

   ```javascript
   <Route
       exact path="content-fragment/:selection/generate-image-modal"
       element={<GenerateImageModal />}
       />
   ```

### Tillägg - registrering

`ExtensionRegistration.js`, mappas till `index.html` rutt, är ingångspunkten för AEM tillägg och definierar:

1. Platsen för tilläggsknappen visas i AEM (`actionBar` eller `headerMenu`)
1. Tilläggsknappens definition i `getButtons()` function
1. Knappens klickningshanterare i `onClick()` function

+ `src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
import React from "react";
import { generatePath } from "react-router";
import { Text } from "@adobe/react-spectrum";
import { register } from "@adobe/uix-guest";
import { extensionId } from "./Constants";

function ExtensionRegistration() {
  const init = async () => {
    const guestConnection = await register({
      id: extensionId, // Some unique ID for the extension used to facilitate communication between the extension and Content Fragment Console
      methods: {
        // Configure your Action Bar button here
        actionBar: {
          getButtons() {
            return [{
              'id': 'generate-image',     // Unique ID for the button
              'label': 'Generate Image',  // Button label 
              'icon': 'PublishCheck',      // Button icon; get name from: https://spectrum.adobe.com/page/icons/ (Remove spaces, keep uppercase)
              // Click handler for the extension button
              onClick(selections) {
                // Collect the selected content fragment paths 
                const selectionIds = selections.map(selection => selection.id);

                // Create a URL that maps to the 
                const modalURL = "/index.html#" + generatePath(
                  "/content-fragment/:selection/generate-image-modal",
                  {
                    // Set the :selection React route parameter to an encoded, delimited list of paths of the selected content fragments
                    selection: encodeURIComponent(selectionIds.join('|')),
                  }
                );

                // Open the route in the extension modal using the constructed URL
                guestConnection.host.modal.showUrl({
                  title: "Generate Image",
                  url: modalURL
                })
                },
              },
            ];
          },
        },
      },
    });
  };

  init().catch(console.error);

  return <Text>IFrame for integration with Host (AEM)...</Text>;
}

export default ExtensionRegistration;          
```

### Modal

Varje rutt för tillägget, enligt definition i [`App.js`](#app-routes), mappar till en React-komponent som återges i tilläggets modal.

I det här exemplet finns det en modal React-komponent (`GenerateImageModal.js`) som har fyra lägen:

1. Läser in, vilket anger att användaren måste vänta
1. Varningsmeddelandet som föreslår att användarna bara väljer ett innehållsfragment åt gången
1. Formuläret Generera bild där användaren kan ange en bildbeskrivning på det naturliga språket.
1. Svaret på bildgenereringsåtgärden, som tillhandahåller länken AEM resursinformation för den nyligen genererade, överförda bilden.

Viktigt är att all interaktion med AEM från tillägget ska delegeras till en [AppBuilder Adobe I/O Runtime-åtgärd](https://developer.adobe.com/runtime/docs/guides/using/creating_actions/), som är en separat serverlös process som körs i [Adobe I/O Runtime](https://developer.adobe.com/runtime/docs/).
Användning av Adobe I/O Runtime-åtgärder för att kommunicera med AEM, och för att undvika anslutningsproblem med korsorigo resursdelning (CORS).

När _Generera bild_ formulär skickas, en anpassad `onSubmitHandler()` anropar Adobe I/O Runtime-åtgärden, skickar bildbeskrivningen, aktuell AEM (domän) och användarens AEM åtkomsttoken. Åtgärden anropar sedan OpenAI:s [Bildgenerering](https://beta.openai.com/docs/guides/images/image-generation-beta) API för att generera en bild med den inskickade bildbeskrivningen. Nästa användning [AEM](https://github.com/adobe/aem-upload) nodmodulens `DirectBinaryUpload` klass som den överför genererad bild till AEM och slutligen använder [AEM Content Fragment API](https://experienceleague.adobe.com/docs/experience-manager-65/assets/extending/assets-api-content-fragments.html) för att uppdatera innehållsfragmenten.

När svaret från Adobe I/O Runtime-åtgärden tas emot uppdateras modalen så att resultatet av bildgenereringen visas.

+ `src/aem-cf-console-admin-1/web-src/src/components/GenerateImageModal.js`

```javascript
export default function GenerateImageModal() {
  // Set up state used by the React component
  const [guestConnection, setGuestConnection] = useState();

  // State hooks to manage the application state
  const [imageDescription, setImageDescription] = useState(null);
  const [validationState, setValidationState] = useState({});

  const [actionInvokeInProgress, setActionInvokeInProgress] = useState(false);
  const [actionResponse, setActionResponse] = useState();

  // Get the selected content fragment paths from the route parameter `:selection`
  const { selection } = useParams();
  const fragmentIds = selection?.split('|') || [];

  console.log('Selected Fragment Ids', fragmentIds);

  if (!fragmentIds || fragmentIds.length === 0) {
    console.error('The Content Fragments are not selected, can NOT generate images');
    return;
  }

  // Asynchronously attach the extension to AEM, we must wait or the guestConnection to be set before doing anything in the modal
  useEffect(() => {
    (async () => {
      const myGuestConnection = await attach({ id: extensionId });

      setGuestConnection(myGuestConnection);
    })();
  }, []);

  // Determine view to display in the modal
  if (!guestConnection) {
    // If the guestConnection is not initialized, display a loading spinner
    return <Spinner />;
  } if (actionInvokeInProgress) {
    // If the 'Generate Image' action has been invoked but not completed, display a loading spinner
    return <Spinner />;
  } if (fragmentIds.length > 1) {
    // If more than one CF selected show warning and suggest to select only one CF
    return renderMoreThanOneCFSelectionError();
  } if (fragmentIds.length === 1 && !actionResponse) {
    // Display the 'Generate Image' modal and ask for image description
    return renderImgGenerationForm();
  } if (actionResponse) {
    // If the 'Generate Image' action has completed, display the response
    return renderActionResponse();
  }

  /**
   * Renders the message suggesting to select only on CF at a time to not lose credits accidentally
   *
   * @returns the suggestion or error message to select one CF at a time
   */
  function renderMoreThanOneCFSelectionError() {
    return (
      <Provider theme={defaultTheme} colorScheme="light">
        <Content width="100%">
          <Text>
            As this operation
            <strong> uses credits from Generative AI services</strong>
            {' '}
            such as DALL·E 2 (or Stable Dufusion), we allow only one Generate Image at a time.
            <p />
            <strong>So please select only one Content Fragment at this moment.</strong>
          </Text>

          <Flex width="100%" justifyContent="end" alignItems="center" marginTop="size-400">
            <ButtonGroup align="end">
              <Button variant="negative" onPress={() => guestConnection.host.modal.close()}>Close</Button>
            </ButtonGroup>
          </Flex>

        </Content>
      </Provider>
    );
  }

  /**
   * Renders the form asking for image description in the natural language and
   * displays message this action uses credits from Generative AI services.
   *
   * @returns the image description input field and credit usage message
   */
  function renderImgGenerationForm() {
    return (

      <Provider theme={defaultTheme} colorScheme="light">
        <Content width="100%">

          <Flex width="100%">
            <Form
              width="100%"
            >
              <TextField
                label="Image Description"
                description="The image description in natural language, for e.g. Alaskan adventure in wilderness, animals, and flowers."
                isRequired
                validationState={validationState?.propertyName}
                onChange={setImageDescription}
                contextualHelp={(
                  <ContextualHelp>
                    <Heading>Need help?</Heading>
                    <Content>
                      <Text>
                        The
                        <strong>description of an image</strong>
                        {' '}
                        you are looking for in the natural language, for e.g. &quot;Family vacation on the beach with blue ocean, dolphins, boats and drink&quot;
                      </Text>
                    </Content>
                  </ContextualHelp>
                  )}
              />

              <Text>
                <p />
                Please note this will use credits from Generative AI services such as OpenAI/DALL·E 2. The AI-generated images are saved to this AEM as a Cloud Service Author service using logged user access (IMS) token.
              </Text>

              <ButtonGroup align="end">
                <Button variant="accent" onPress={onSubmitHandler}>Use Credits</Button>
                <Button variant="accent" onPress={() => guestConnection.host.modal.close()}>Close</Button>
              </ButtonGroup>
            </Form>
          </Flex>

        </Content>
      </Provider>
    );
  }

  function buildAssetDetailsURL(aemImgURL) {
    const urlParts = aemImgURL.split('.com');
    const aemAssetDetailsURL = `${urlParts[0]}.com/ui#/aem/assetdetails.html${urlParts[1]}`;

    return aemAssetDetailsURL;
  }

  /**
   * Displays the action response received from the App Builder
   *
   * @returns Displays App Builder action and details
   */
  function renderActionResponse() {
    return (
      <Provider theme={defaultTheme} colorScheme="light">
        <Content width="100%">

          {actionResponse.status === 'success'
            && (
              <>
                <Heading level="4">
                  Successfully generated an image, uploaded it to this AEM-CS Author service, and associated it to the selected Content Fragment.
                </Heading>

                <Text>
                  {' '}
                  Please see generated image in AEM-CS
                  {' '}
                  <Link>
                    <a href={buildAssetDetailsURL(actionResponse.aemImgURL)} target="_blank" rel="noreferrer">
                      here.
                    </a>
                  </Link>
                </Text>
              </>
            )}

          {actionResponse.status === 'failure'
            && (
            <Heading level="4">
              Failed to generate, upload image, please check App Builder logs.
            </Heading>
            )}

          <Flex width="100%" justifyContent="end" alignItems="center" marginTop="size-400">
            <ButtonGroup align="end">
              <Button variant="negative" onPress={() => guestConnection.host.modal.close()}>Close</Button>
            </ButtonGroup>
          </Flex>

        </Content>
      </Provider>
    );
  }

  /**
   * Handle the Generate Image form submission.
   * This function calls the supporting Adobe I/O Runtime actions such as
   * - Call the Generative AI service (DALL·E) with 'image description' to generate an image
   * - Download the AI generated image to App Builder runtime
   * - Save the downloaded image to AEM DAM and update Content Fragment's image reference property to use this new image
   *
   * When invoking the Adobe I/O Runtime actions, the following parameters are passed as they're used by the action to connect to AEM:
   * - AEM Host to connect to
   * - AEM access token to connect to AEM with
   * - The Content Fragment path to update
   *
   * @returns In case of success the updated content fragment, otherwise failure message
   */
  async function onSubmitHandler() {
    console.log('Started Image Generation orchestration');

    // Validate the form input fields
    if (imageDescription?.length > 1) {
      setValidationState({ imageDescription: 'valid' });
    } else {
      setValidationState({ imageDescription: 'invalid' });
      return;
    }

    // Mark the extension as invoking the action, so the loading spinner is displayed
    setActionInvokeInProgress(true);

    // Set the HTTP headers to access the Adobe I/O runtime action
    const headers = {
      Authorization: `Bearer ${guestConnection.sharedContext.get('auth').imsToken}`,
      'x-gw-ims-org-id': guestConnection.sharedContext.get('auth').imsOrg,
    };

    // Set the parameters to pass to the Adobe I/O Runtime action
    const params = {

      aemHost: `https://${guestConnection.sharedContext.get('aemHost')}`,

      fragmentId: fragmentIds[0],
      imageDescription,
    };

    const generateImageAction = 'generate-image';

    try {
      const generateImageActionResponse = await actionWebInvoke(allActions[generateImageAction], headers, params);

      // Set the response from the Adobe I/O Runtime action
      setActionResponse(generateImageActionResponse);

      console.log(`Response from ${generateImageAction}:`, actionResponse);
    } catch (e) {
      // Log and store any errors
      console.error(e);
    }

    // Set the action as no longer being invoked, so the loading spinner is hidden
    setActionInvokeInProgress(false);
  }
}
```

>[!NOTE]
>
>I `buildAssetDetailsURL()` funktionen, `aemAssetdetailsURL` variabelvärdet förutsätter att [Enhetligt gränssnitt](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/overview/aem-cloud-service-on-unified-shell.html#overview) är aktiverat. Om du har inaktiverat Unified Shell måste du ta bort `/ui#/aem` från variabelvärdet.


### Adobe I/O Runtime action

En AEM app i App Builder kan definiera eller använda 0 eller många av Adobe I/O Runtime åtgärder.
Åtgärden Adobe Runtime ansvarar för arbete som kräver interaktion med AEM, Adobe eller tredjeparts webbtjänster.

I det här exemplet är `generate-image` Adobe I/O Runtime åtgärd ansvarar för att

1. Generera en bild med [Generering av OpenAI API-avbildning](https://beta.openai.com/docs/guides/images/image-generation-beta) service
1. Överföra den genererade bilden till AEM-CS med [AEM](https://github.com/adobe/aem-upload) bibliotek
1. Göra en HTTP-begäran till AEM Content Fragment API för att uppdatera innehållets image-egenskap.
1. Returnera nyckelinformationen för lyckade och misslyckade resultat för visning av modala (`GenerateImageModal.js`)


#### Startpunkt (`index.js`)

The `index.js` arbetar över 1 till 3 uppgifter med hjälp av respektive JavaScript-modul, nämligen `generate-image-using-openai, upload-generated-image-to-aem, update-content-fragement`. Dessa moduler och tillhörande kod beskrivs i nästa [delavsnitt](#image-generation-module---generate-image-using-openaijs).

+ `src/aem-cf-console-admin-1/actions/generate-image/index.js`

```javascript
/**
 *
 * This action orchestrates an image generation by calling the OpenAI API (DALL·E 2) and saves generated image to AEM.
 *
 * It leverages following modules
 *  - 'generate-image-using-openai' - To generate an image using OpenAI API
 *  - 'upload-generated-image-to-aem' - To upload the generated image into AEM-CS instance
 *  - 'update-content-fragement' - To update the CF image property with generated image's DAM path
 *
 */

const { Core } = require('@adobe/aio-sdk');
const {
  errorResponse, stringParameters, getBearerToken, checkMissingRequestInputs,
} = require('../utils');

const { generateImageUsingOpenAI } = require('./generate-image-using-openai');

const { uploadGeneratedImageToAEM } = require('./upload-generated-image-to-aem');

const { updateContentFragmentToUseGeneratedImg } = require('./update-content-fragement');

// main function that will be executed by Adobe I/O Runtime
async function main(params) {
  // create a Logger
  const logger = Core.Logger('main', { level: params.LOG_LEVEL || 'info' });

  try {
    // 'info' is the default level if not set
    logger.info('Calling the main action');

    // log parameters, only if params.LOG_LEVEL === 'debug'
    logger.debug(stringParameters(params));

    // check for missing request input parameters and headers
    const requiredParams = ['aemHost', 'fragmentId', 'imageDescription'];
    const requiredHeaders = ['Authorization'];
    const errorMessage = checkMissingRequestInputs(params, requiredParams, requiredHeaders);

    if (errorMessage) {
      // return and log client errors
      return errorResponse(400, errorMessage, logger);
    }

    // extract the user Bearer token from the Authorization header
    const token = getBearerToken(params);

    // Call OpenAI (DALL·E 2) API to generate an image using image description
    const generatedImageURL = await generateImageUsingOpenAI(params);
    logger.info(`Generated image using OpenAI API and url is : ${generatedImageURL}`);

    // Upload the generated image to AEM-CS
    const uploadedImagePath = await uploadGeneratedImageToAEM(params, generatedImageURL, token);
    logger.info(`Uploaded image to AEM, path is: ${uploadedImagePath}`);

    // Update Content Fragment with the newly generated image reference
    const updateContentFragmentPath = await updateContentFragmentToUseGeneratedImg(params, uploadedImagePath, token);
    logger.info(`Updated Content Fragment path is: ${updateContentFragmentPath}`);

    let result;
    if (updateContentFragmentPath) {
      result = {
        status: 'success', message: 'Successfully generated and uploaded image to AEM', genTechServiceImageURL: generatedImageURL, aemImgURL: uploadedImagePath, fragmentPath: updateContentFragmentPath,
      };
    } else {
      result = { status: 'failure', message: 'Failed to generated and uploaded image, please check App Builder logs' };
    }

    const response = {
      statusCode: 200,
      body: result,
    };

    logger.info('Adobe I/O Runtime action response', response);

    // Return the response to the caller
    return response;
  } catch (error) {
    // log any server errors
    logger.error(error);
    // return with 500
    return errorResponse(500, 'server error', logger);
  }
}

exports.main = main;
```

#### Bildgenerering

Den här modulen ansvarar för att anropa OpenAI-filer [Bildgenerering](https://beta.openai.com/docs/guides/images/image-generation-beta) slutpunkt med [öppai](https://github.com/openai/openai-node) bibliotek. Så här hämtar du OpenAI API-hemlig nyckel som definieras i `.env` -fil, använder `params.OPENAI_API_KEY`.

+ `src/aem-cf-console-admin-1/actions/generate-image/generate-image-using-openai.js`

```javascript
/**
 * This module calls OpenAI API to generate an image based on image description provided to Action
 *
 */

const { Configuration, OpenAIApi } = require('openai');

const { Core } = require('@adobe/aio-sdk');

// Placeholder than actual OpenAI Image
const PLACEHOLDER_IMG_URL = 'https://www.gstatic.com/webp/gallery/2.png';

async function generateImageUsingOpenAI(params) {
  // create a Logger
  const logger = Core.Logger('generateImageUsingOpenAI', { level: params.LOG_LEVEL || 'info' });

  let generatedImageURL = PLACEHOLDER_IMG_URL;

  // create configuration object with the API Key
  const configuration = new Configuration({
    apiKey: params.OPENAI_API_KEY,
  });

  // create OpenAIApi object
  const openai = new OpenAIApi(configuration);

  logger.info(`Generating image for input: ${params.imageDescription}`);

  try {
    // invoke createImage method with details
    const response = await openai.createImage({
      prompt: params.imageDescription,
      n: 1,
      size: '1024x1024',
    });

    generatedImageURL = response.data.data[0].url;

    logger.info(`The OpenAI generate image url is: ${generatedImageURL}`);
  } catch (error) {
    logger.error(`Error while generating image, details are: ${error}`);
  }

  return generatedImageURL;
}

module.exports = {
  generateImageUsingOpenAI,
};
```

#### Överför till AEM

Den här modulen ansvarar för att överföra den OpenAI-genererade bilden till AEM med [AEM](https://github.com/adobe/aem-upload) bibliotek. Den genererade bilden hämtas först till App Builder-miljön med Node.js [Filsystem](https://nodejs.org/api/fs.html) biblioteket och när överföringen till AEM är klar tas det bort.

Kod nedan `uploadGeneratedImageToAEM` funktionen dirigerar genererad bildhämtning till körningsmiljön, överför den till AEM och tar bort den från körningsmiljön. Bilden överförs till `/content/dam/wknd-shared/en/generated` sökväg, kontrollera att alla mappar finns i DAM, vilket krav som måste användas [AEM](https://github.com/adobe/aem-upload) bibliotek.

+ `src/aem-cf-console-admin-1/actions/generate-image/upload-generated-image-to-aem.js`

```javascript
/**
 * This module uploads the generated image to AEM-CS instance using current user's IMS token
 *
 */

const { Core } = require('@adobe/aio-sdk');
const fs = require('fs');

const {
  DirectBinaryUploadErrorCodes,
  DirectBinaryUpload,
  DirectBinaryUploadOptions,
} = require('@adobe/aem-upload');

const codes = DirectBinaryUploadErrorCodes;
const IMG_EXTENSION = '.png';

const GENERATED_IMAGES_DAM_PATH = '/content/dam/wknd-shared/en/generated';

async function downloadImageToRuntime(logger, generatedImageURL) {
  logger.log('Downloading generated image to the runtime');

  // placeholder image name
  let generatedImageName = 'generated.png';

  try {
    // Get the generated image name from the image URL
    const justImgURL = generatedImageURL.substring(0, generatedImageURL.indexOf(IMG_EXTENSION) + 4);
    generatedImageName = justImgURL.substring(justImgURL.lastIndexOf('/') + 1);

    // Read image from URL as the buffer
    const response = await fetch(generatedImageURL);
    const buffer = await response.buffer();

    // Write/download image to the runtime
    fs.writeFileSync(generatedImageName, buffer, (err) => {
      if (err) throw err;
      logger.log('Saved the generated image!');
    });
  } catch (error) {
    logger.error(`Error while downloading image on the runtime, details are: ${error}`);
  }

  return generatedImageName;
}

function setupEventHandlers(binaryUpload, logger) {
  binaryUpload.on('filestart', (data) => {
    const { fileName } = data;

    logger.log(`Started file upload ${fileName}`);
  });

  binaryUpload.on('fileprogress', (data) => {
    const { fileName, transferred } = data;

    logger.log(`Fileupload is in progress ${fileName} & ${transferred}`);
  });

  binaryUpload.on('fileend', (data) => {
    const { fileName } = data;

    logger.log(`Finished file upload ${fileName}`);
  });

  binaryUpload.on('fileerror', (data) => {
    const { fileName, errors } = data;

    logger.log(`Error in file upload ${fileName} and ${errors}`);
  });
}

async function getImageSize(downloadedImgName) {
  const stats = fs.statSync(downloadedImgName);
  return stats.size;
}

async function uploadImageToAEMFromRuntime(logger, aemURL, downloadedImgName, accessToken) {
  let aemImageURL;
  try {
    logger.log('Uploading generated image to AEM from the runtime');

    const binaryUpload = new DirectBinaryUpload();

    // setup event handlers to track the progress, success or error
    setupEventHandlers(binaryUpload, logger);

    // get downloaded image size
    const imageSize = await getImageSize(downloadedImgName);
    logger.info(`The image upload size is: ${imageSize}`);

    // The deatils of the file to be uploaded
    const uploadFiles = [
      {
        fileName: downloadedImgName, // name of the file as it will appear in AEM
        fileSize: imageSize, // total size, in bytes, of the file
        filePath: downloadedImgName, // Full path to the local file
      },
    ];

    // Provide AEM URL and DAM Path where images will be uploaded
    const options = new DirectBinaryUploadOptions()
      .withUrl(`${aemURL}${GENERATED_IMAGES_DAM_PATH}`)
      .withUploadFiles(uploadFiles);

    // Add headers like content type and authorization
    options.withHeaders({
      'content-type': 'image/png',
      Authorization: `Bearer ${accessToken}`,
    });

    // Start the upload to AEM
    await binaryUpload.uploadFiles(options)
      .then((result) => {
        // Handle Error
        result.getErrors().forEach((error) => {
          if (error.getCode() === codes.ALREADY_EXISTS) {
            logger.error('The generated image already exists');
          }
        });

        // Handle Upload result and check for errors
        result.getFileUploadResults().forEach((fileResult) => {
          // log file upload result
          logger.info(`File upload result ${JSON.stringify(fileResult)}`);

          fileResult.getErrors().forEach((fileErr) => {
            if (fileErr.getCode() === codes.ALREADY_EXISTS) {
              const fileName = fileResult.getFileName();
              logger.error(`The generated image already exists ${fileName}`);
            }
          });
        });
      })
      .catch((err) => {
        logger.info(`Failed to uploaded generated image to AEM${err}`);
      });

    logger.info('Successfully uploaded generated image to AEM');

    aemImageURL = `${aemURL + GENERATED_IMAGES_DAM_PATH}/${downloadedImgName}`;
  } catch (error) {
    logger.info(`Error while uploading generated image to AEM, see ${error}`);
  }

  return aemImageURL;
}

async function deleteFileFromRuntime(logger, downloadedImgName) {
  try {
    logger.log('Deleting the generated image from the runtime');

    fs.unlinkSync(downloadedImgName);

    logger.log('Successfully deleted the generated image from the runtime');
  } catch (error) {
    logger.error(`Error while deleting generated image from the runtime, details are: ${error}`);
  }
}

async function uploadGeneratedImageToAEM(params, generatedImageURL, accessToken) {
  // create a Logger
  const logger = Core.Logger('uploadGeneratedImageToAEM', { level: params.LOG_LEVEL || 'info' });

  const aemURL = params.aemHost;

  logger.info(`Uploading generated image from ${generatedImageURL} to AEM ${aemURL} by streaming the bytes.`);

  // download image to the App Builder runtime
  const downloadedImgName = await downloadImageToRuntime(logger, generatedImageURL);

  // Upload image to AEM from the App Builder runtime
  const aemImageURL = await uploadImageToAEMFromRuntime(logger, aemURL, downloadedImgName, accessToken);

  // Delete the downloaded image from the App Builder runtime
  await deleteFileFromRuntime(logger, downloadedImgName);

  return aemImageURL;
}

module.exports = {
  uploadGeneratedImageToAEM,
};
```

#### Uppdatera innehållsfragment

Den här modulen ansvarar för att uppdatera den angivna Content Fragment-bildegenskapen med den nyligen överförda bildens DAM-sökväg med hjälp av AEM Content Fragment API.

+ `src/aem-cf-console-admin-1/actions/generate-image/update-content-fragement.js`

```javascript
/**
 * This module updates the CF image property with generated image's DAM path
 *
 */
const { Core } = require('@adobe/aio-sdk');

const ADVENTURE_MODEL_IMG_PROPERTY_NAME = 'primaryImage';

const ARTICLE_MODEL_IMG_PROPERTY_NAME = 'featuredImage';

const AUTHOR_MODEL_IMG_PROPERTY_NAME = 'profilePicture';

function findImgPropertyName(fragmenPath) {
  if (fragmenPath && fragmenPath.includes('/adventures')) {
    return ADVENTURE_MODEL_IMG_PROPERTY_NAME;
  } if (fragmenPath && fragmenPath.includes('/magazine')) {
    return ARTICLE_MODEL_IMG_PROPERTY_NAME;
  }
  return AUTHOR_MODEL_IMG_PROPERTY_NAME;
}

async function updateContentFragmentToUseGeneratedImg(params, uploadedImagePath, accessToken) {
  // create a Logger
  const logger = Core.Logger('updateContentFragment', { level: params.LOG_LEVEL || 'info' });

  const fragmenPath = params.fragmentId;
  const imgPropName = findImgPropertyName(fragmenPath);
  const relativeImgPath = uploadedImagePath.substring(uploadedImagePath.indexOf('/content/dam'));

  logger.info(`Update CF ${fragmenPath} to use ${relativeImgPath} image path`);

  const body = {
    properties: {
      elements: {
        [imgPropName]: {
          value: relativeImgPath,
        },
      },
    },
  };

  const res = await fetch(`${params.aemHost}${fragmenPath.replace('/content/dam/', '/api/assets/')}.json`, {
    method: 'put',
    body: JSON.stringify(body),
    headers: {
      Authorization: `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
    },

  });

  if (res.ok) {
    logger.info(`Successfully updated ${fragmenPath}`);
    return fragmenPath;
  }

  logger.info(`Failed to update ${fragmenPath}`);
  return '';
}

module.exports = {
  updateContentFragmentToUseGeneratedImg,
};
```
