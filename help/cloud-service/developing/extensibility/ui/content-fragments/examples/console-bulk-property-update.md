---
title: 'Exempel på egenskapsuppdatering i grupp: AEM Content Fragment Console-tillägg'
description: Ett exempel på AEM Content Fragments Console-tillägg som innebär att en egenskap för Content Fragments uppdateras satsvis.
feature: Developer Tools, Content Fragments
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-11604
thumbnail: KT-11604.png
doc-type: article
last-substantial-update: 2024-01-26T00:00:00Z
exl-id: fbfb5c10-95f8-4875-88dd-9a941d7a16fd
duration: 1362
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '769'
ht-degree: 0%

---

# Exempel på uppdatering av massegenskaper

>[!VIDEO](https://video.tv.adobe.com/v/3454454?quality=12&learn=on&captions=swe)

Det här exemplet på AEM Content Fragment Console-tillägg är ett [åtgärdsfältstillägg](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/action-bar/) som uppdaterar en Content Fragment-egenskap till ett gemensamt värde.

Det funktionella flödet för exempeltillägget är följande:

![Adobe I/O Runtime åtgärdsflöde](./assets/bulk-property-update/flow.png){align="center"}

1. Välj Innehållsfragment och klicka på tilläggets knapp i [åtgärdsfältet](#extension-registration) för att öppna [modal](#modal).
2. [modal](#modal) visar ett anpassat indataformulär som skapats med [React Spectrum](https://react-spectrum.adobe.com/react-spectrum/).
3. När du skickar formuläret skickas listan med markerade innehållsfragment och AEM-värden till den [anpassade Adobe I/O Runtime-åtgärden](#adobe-io-runtime-action).
4. [Adobe I/O Runtime-åtgärden](#adobe-io-runtime-action) verifierar indata och gör HTTP PUT-begäranden till AEM om att uppdatera de markerade innehållsfragmenten.
5. En serie HTTP-PUT:er för varje innehållsfragment som ska uppdatera den angivna egenskapen.
6. AEM as a Cloud Service består av egenskapsuppdateringarna för innehållsfragmentet och returnerar svar om huruvida åtgärden Adobe I/O Runtime lyckades eller inte.
7. modal fick svaret från Adobe I/O Runtime-åtgärden och visar en lista över lyckade bulkuppdateringar.

## Tilläggspunkt

Det här exemplet utökar till tilläggspunkten `actionBar` för att lägga till en anpassad knapp i konsolen för innehållsfragment.

| AEM UI Extended | Tilläggspunkt |
| ------------------------ | --------------------- | 
| [Konsol för innehållsfragment](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/) | [Åtgärdsfält](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/action-bar/) |


## Exempel på tillägg

I exemplet används ett befintligt Adobe Developer Console-projekt och följande alternativ används när App Builder-appen initieras, via `aio app init`.

+ Vilka mallar vill du söka efter?: `All Extension Points`
+ Välj de mallar som ska installeras:` @adobe/aem-cf-admin-ui-ext-tpl`
+ Vad vill du kalla tillägget? `Bulk property update`
+ Ange en kort beskrivning av tillägget: `An example action bar extension that bulk updates a single property one or more content fragments.`
+ Vilken version vill du börja med?: `0.0.1`
+ Vad vill du göra nu?
   + `Add a custom button to Action Bar`
      + Ange knappens etikettnamn: `Bulk property update`
      + Behöver du visa en modal för knappen? `y`
   + `Add server-side handler`
      + Med Adobe I/O Runtime kan du anropa serverlös kod vid behov. Hur vill du namnge den här åtgärden?: `generic`

Den genererade App Builder-tilläggsappen uppdateras enligt beskrivningen nedan.

### Appvägar{#app-routes}

`src/aem-cf-console-admin-1/web-src/src/components/App.js` innehåller [Reaktionsroutern](https://reactrouter.com/en/main).

Det finns två logiska uppsättningar vägar:

1. Den första vägen mappar begäranden till `index.html`, som anropar React-komponenten som ansvarar för [tilläggsregistreringen](#extension-registration).

   ```javascript
   <Route index element={<ExtensionRegistration />} />
   ```

1. Den andra uppsättningen vägar mappar URL:er till React-komponenter som återger innehållet i tilläggets modal. Param `:selection` representerar en begränsad sökväg för innehållsfragment i listan.

   Om tillägget har flera knappar för att anropa diskreta åtgärder mappas varje [tilläggsregistrering](#extension-registration) till en väg som definieras här.

   ```javascript
   <Route
       exact path="content-fragment/:selection/bulk-property-update"
       element={<BulkPropertyUpdateModal />}
       />
   ```

### Tillägg - registrering

`ExtensionRegistration.js`, mappad till `index.html`-vägen, är startpunkten för AEM-tillägget och definierar:

1. Platsen för tilläggsknappen visas i AEM-redigeringsgränssnittet (`actionBar` eller `headerMenu`)
1. Tilläggsknappens definition i funktionen `getButtons()`
1. Knappens klickningshanterare i funktionen `onClick()`

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
            return [
              {
                id: "examples.action-bar.bulk-property-update", // Unique ID for the button
                label: "Bulk property update", // Button label
                icon: "OpenIn", // Button icon; get name from: https://spectrum.adobe.com/page/icons/ (Remove spaces, keep uppercase)
                // Click handler for the extension button
                onClick(selections) {
                  // Collect the selected content fragment paths
                  const selectionIds = selections.map(
                    (selection) => selection.id
                  );

                  // Create a URL that maps to the
                  const modalURL =
                    "/index.html#" +
                    generatePath(
                      "/content-fragment/:selection/bulk-property-update",
                      {
                        // Set the :selection React route parameter to an encoded, delimited list of paths of the selected content fragments
                        selection: encodeURIComponent(selectionIds.join("|")),
                      }
                    );

                  // Open the route in the extension modal using the constructed URL
                  guestConnection.host.modal.showUrl({
                    // The modal title
                    title: "Bulk property update",
                    url: modalURL,
                  });
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

Varje väg i tillägget, enligt definition i [`App.js`](#app-routes), mappas till en React-komponent som återges i tilläggets modal.

I den här exempelappen finns en modal React-komponent (`BulkPropertyUpdateModal.js`) som har tre lägen:

1. Läser in, vilket anger att användaren måste vänta
1. Formuläret för uppdatering av massegenskaper där användaren kan ange egenskapsnamnet och värdet som ska uppdateras
1. Svaret på uppdateringsåtgärden för bulkegenskapen, en lista över de innehållsfragment som uppdaterades och de som inte kunde uppdateras

Viktigt är att all interaktion med AEM från tillägget delegeras till en [AppBuilder Adobe I/O Runtime-åtgärd](https://developer.adobe.com/runtime/docs/guides/using/creating_actions/), som är en separat serverlös process som körs i [Adobe I/O Runtime](https://developer.adobe.com/runtime/docs/).
Adobe I/O Runtime-åtgärder används för att kommunicera med AEM för att undvika anslutningsproblem mellan olika ursprung (CORS).

När formuläret för uppdatering av gruppegenskap skickas, anropar en anpassad `onSubmitHandler()` Adobe I/O Runtime-åtgärden och skickar den aktuella AEM-värden (domän) och användarens AEM-åtkomsttoken, som i sin tur anropar [ AEM Content Fragment API](https://experienceleague.adobe.com/docs/experience-manager-65/assets/extending/assets-api-content-fragments.html?lang=sv-SE) för att uppdatera innehållsfragmenten.

När svaret från Adobe I/O Runtime-åtgärden tas emot uppdateras modal-åtgärden så att resultatet av bulkegenskapsuppdateringen visas.

+ `src/aem-cf-console-admin-1/web-src/src/components/BulkPropertyUpdateModal.js`

```javascript
import React, { useState, useEffect } from 'react'
import { attach } from "@adobe/uix-guest"
import {
  Flex,
  Form,
  Provider,
  Content,
  defaultTheme,
  ContextualHelp,
  Text,
  TextField,
  ButtonGroup,
  Button,
  Heading,
  ListView,
  Item,
} from '@adobe/react-spectrum'

import Spinner from "./Spinner"

import { useParams } from "react-router-dom"

import allActions from '../config.json'
import actionWebInvoke from '../utils'

import { extensionId } from "./Constants"

export default function BulkPropertyUpdateModal() {
  // Set up state used by the React component
  const [guestConnection, setGuestConnection] = useState()
  
  const [actionInvokeInProgress, setActionInvokeInProgress] = useState(false);
  const [actionResponse, setActionResponse] = useState();

  const [propertyName, setPropertyName] = useState(null);
  const [propertyValue, setPropertyValue] = useState(null);
  const [validationState, setValidationState] = useState({});

  // Get the selected content fragment paths from the route parameter `:selection`
  let { selection } = useParams();
  let fragmentIds = selection?.split('|') || [];
  
  console.log('Content Fragment Ids', fragmentIds);

  if (!fragmentIds || fragmentIds.length === 0) {
    console.error("Unable to locate a list of Content Fragments to update.")
    return;
  }

  // Asynchronously attach the extension to AEM, we must wait or the guestConnection to be set before doing anything in the modal
  useEffect(() => {
    (async () => {
       // extensionId is the unique id of this extension (you can make this up as long as its unique) .. in this case its `bulk-property-update` pulled out into Constants.js as it is also referenced in ExtensionRegistration.js
      const guestConnection = await attach({ id: extensionId })
      setGuestConnection(guestConnection);
    })()
  }, [])


  // Determine view to display in the modal
  if (!guestConnection) {
    // If the guestConnection is not initialized, display a loading spinner
    return <Spinner />
  } else if (actionInvokeInProgress) {
    // If the bulk property action has been invoked but not completed, display a loading spinner
    return <Spinner />
  } else if (actionResponse) {
    // If the bulk property action has completed, display the response
    return renderResponse();
  } else {
    // Else display the bulk property update form
    return renderForm();
  }

  /**
   * Renders the Bulk Property Update form. 
   * This form has two fields:
   * - Property Name: The name of the Content Fragment property name to update
   * - Property Value: the value the Content Fragment property, specified by the Property Name, will be updated to
   * 
   * @returns the Bulk Property Update form
   */
  function renderForm() {
    return (
      // Use React Spectrum components to render the form
      <Provider theme={defaultTheme} colorScheme='light'>
        <Content width="100%">
          <Flex width="100%">
            <Form 
              width="100%">
              <TextField label="Property name"
                          isRequired={true}
                          validationState={validationState?.propertyName}
                onChange={setPropertyName}
                contextualHelp={
                  <ContextualHelp>
                    <Heading>Need help?</Heading>
                    <Content>
                      <Text>The <strong>Property name</strong> must be a valid for the Content Fragment model(s) the selected Content Fragments implement.</Text>
                    </Content>
                  </ContextualHelp>
                } />

              <TextField
                label="Property value"
                validationState={validationState?.propertyValue}
                onChange={setPropertyValue} />

              <ButtonGroup align="start" marginTop="size-200">
                <Button variant="cta" onPress={onSubmitHandler}>Update {fragmentIds.length} Content Fragments</Button>
              </ButtonGroup>
            </Form>
          </Flex>

          {/* Render the close button so the user can close the modal */}
          {renderCloseButton()}
        </Content>
      </Provider>
    )
  }
  /**
   * Display the response from the Adobe I/O Runtime action in the modal.
   * This includes:
   * - A list of content fragments that were updated successfully
   * - A list a content fragments that failed to update
   * 
   * @returns the response view
   */
  function renderResponse() {
    // Separate the successful and failed content fragments updates
    const successes = actionResponse.filter(item => item.status === 200);
    const failures = actionResponse.filter(item => item.status !== 200);

    return (
      <Provider theme={defaultTheme} colorScheme='light'>
        <Content width="100%">

          <Text>Bulk updated property <strong>{propertyName}</strong> with value <strong>{propertyValue}</strong></Text>

          {/* Render the list of content fragments that were updated successfully */}
          {successes.length > 0 &&
            <><Heading level="4">{successes.length} Content Fragments successfully updated</Heading>
              <ListView
                items={successes}
                selectionMode="none"
                aria-label="Successful updates"
              >
                {(item) => (
                  <Item key={item.fragmentId} textValue={item.fragmentId.split('/').pop()}>
                    {item.fragmentId.split('/').pop()}
                  </Item>
                )}
              </ListView></>}

          {/* Render the list of content fragments that failed to update */}
          {failures.length > 0 &&
            <><Heading level="4">{failures.length} Content Fragments failed to update</Heading><ListView
              items={failures}
              selectionMode="none"
              aria-label="Failed updates"
            >
              {(item) => (
                <Item key={item.fragmentId} textValue={item.fragmentId.split('/').pop()}>
                  {item.fragmentId.split('/').pop()}
                </Item>
              )}
            </ListView></>}

          {/* Render the close button so the user can close the modal */}
          {renderCloseButton()}
        </Content>
      </Provider>);
  }

  /**
   * Provide a close button for the modal, else it cannot be closed (without refreshing the browser window)
   * 
   * @returns a button that closes the modal.
   */
   function renderCloseButton() {
    return (
      <Flex width="100%" justifyContent="end" alignItems="center" marginTop="size-400">
        <ButtonGroup align="end">
          <Button variant="primary" onPress={() => guestConnection.host.modal.close()}>Close</Button>
        </ButtonGroup>
      </Flex>
    );
  }

  /**
   * Handle the Bulk Property Update form submission.
   * This function calls the supporting Adobe I/O Runtime action to update the selected Content Fragments, and then returns the response for display in the modal
   * When invoking the Adobe I/O Runtime action, the following parameters are passed as they're used by the action to connect to AEM:
   * - AEM Host to connect to
   * - AEM access token to connect to AEM with
   * - The list of Content Fragment paths to update
   * - The Content Fragment property name to update
   * - The value to update the Content Fragment property to
   * 
   * @returns a list of content fragment update successes and failures
   */
  async function onSubmitHandler() {
    // Validate the form input fields
    if (propertyName?.length > 1) {
      setValidationState({propertyName: 'valid', propertyValue: 'valid'});
    } else {
      setValidationState({propertyName: 'invalid', propertyValue: 'valid'});
      return;
    }

    // Mark the extension as invoking the action, so the loading spinner is displayed
    setActionInvokeInProgress(true);

    // Set the HTTP headers to access the Adobe I/O runtime action
    const headers = {
      'Authorization': 'Bearer ' + guestConnection.sharedContext.get('auth').imsToken,
      'x-gw-ims-org-id': guestConnection.sharedContext.get('auth').imsOrg
    };

    console.log('headers', headers);

    // Set the parameters to pass to the Adobe I/O Runtime action
    const params = {
      aemHost: `https://${guestConnection.sharedContext.get('aemHost')}`,

      fragmentIds: fragmentIds,
      propertyName: propertyName,
      propertyValue: propertyValue
    };

    // Invoke the Adobe I/O Runtime action named `generic`. This name defined in the `ext.config.yaml` file.
    const action = 'generic';

    try {
      // Invoke Adobe I/O Runtime action with the configured headers and parameters
      const actionResponse = await actionWebInvoke(allActions[action], headers, params);

      // Set the response from the Adobe I/O Runtime action
      setActionResponse(actionResponse);

      console.log(`Response from ${action}:`, actionResponse)
    } catch (e) {
      // Log and store any errors
      console.error(e)
    }

    // Set the action as no longer being invoked, so the loading spinner is hidden
    setActionInvokeInProgress(false);
  }
}
```


### Adobe I/O Runtime action

En App Builder-app med AEM-tillägg kan definiera eller använda 0 eller många Adobe I/O Runtime-åtgärder.
Adobe Runtime åtgärder bör vara ansvarsfulla och kräver interaktion med AEM eller andra Adobe webbtjänster.

I det här exempelprogrammet ansvarar Adobe I/O Runtime-åtgärden, som använder standardnamnet `generic`, för:

1. Skapa en serie HTTP-begäranden till AEM Content Fragment API för att uppdatera innehållsfragmenten.
1. Samla in svaren från dessa HTTP-begäranden och sortera dem till lyckade och misslyckade
1. Returnerar listan över lyckade och misslyckade visningslägen för modala (`BulkPropertyUpdateModal.js`)

+ `src/aem-cf-console-admin-1/actions/generic/index.js`


```javascript
const fetch = require('node-fetch')
const { Core } = require('@adobe/aio-sdk')
const { errorResponse, getBearerToken, stringParameters, checkMissingRequestInputs } = require('../utils')

// main function that will be executed by Adobe I/O Runtime
async function main (params) {
  // create a Logger
  const logger = Core.Logger('main', { level: params.LOG_LEVEL || 'info' })

  try {
    // 'info' is the default level if not set
    logger.info('Calling the main action')

    // log parameters, only if params.LOG_LEVEL === 'debug'
    logger.debug(stringParameters(params))

    // check for missing request input parameters and headers
    const requiredParams = [ 'aemHost', 'fragmentIds', 'propertyName', 'propertyValue' ]
    const requiredHeaders = ['Authorization']
    const errorMessage = checkMissingRequestInputs(params, requiredParams, requiredHeaders)
    if (errorMessage) {
      // return and log client errors
      return errorResponse(400, errorMessage, logger)
    }
      
    const body = {
      "properties": {
        "elements": {
          [params.propertyName]: {
            "value": params.propertyValue
          }
        }
      }
    };

    // Extract the user Bearer token from the Authorization header used to authenticate the request to AEM
    const accessToken = getBearerToken(params);

    let results = await Promise.all(params.fragmentIds.map(async (fragmentId) => {

      logger.info(`Updating fragment ${fragmentId} with property ${params.propertyName} and value ${params.propertyValue}`);

      const res = await fetch(`${params.aemHost}${fragmentId.replace('/content/dam/', '/api/assets/')}.json`, { 
        method: 'put',
        body: JSON.stringify(body),
        headers: {
          'Authorization': `Bearer ${accessToken}`,
          'Content-Type': 'application/json'
        }
      });

      if (res.ok) {
        logger.info(`Successfully updated ${fragmentId}`);
        return { fragmentId, status: res.status, statusText: res.statusText, body: await res.json() };
      } else {
        logger.info(`Failed to update ${fragmentId}`);
        return { fragmentId, status: res.status, statusText: res.statusText, body: await res.text() };
      }
    }));

    const response = {
      statusCode: 200,
      body: results
    };

    logger.info('Adobe I/O Runtime action response', response);

    // Return the response to the A
     return response;

  } catch (error) {
    // log any server errors
    logger.error(error)
    // return with 500
    return errorResponse(500, 'server error', logger)
  }
}

exports.main = main
```
