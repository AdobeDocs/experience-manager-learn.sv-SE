---
title: AEM Content Fragment console extension Adobe I/O Runtime actions
description: Lär dig hur du skapar ett AEM Content Fragment Console-tillägg som är modalt.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
kt: 11603
last-substantial-update: 2022-12-01T00:00:00Z
exl-id: 3062900a-0461-4c6f-81e6-c76a7f613804
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '560'
ht-degree: 1%

---

# Adobe I/O Runtime action

![Körningsåtgärder för AEM Content Fragment-tillägg](./assets/runtime-action/action-runtime-flow.png){align="center"}

AEM Content Fragment-tillägg kan innehålla valfritt antal [Adobe I/O Runtime-åtgärder](https://developer.adobe.com/runtime/docs/).

Adobe I/O Runtime-åtgärder är serverlösa funktioner som kan anropas av tillägget. Funktionsmakron är användbara för att utföra arbete som kräver interaktion med AEM eller andra webbtjänster från Adobe.
Åtgärder är vanligtvis mest användbara för att utföra åtgärder som varar länge (är längre än några sekunder) eller för att göra HTTP-begäranden till AEM eller andra webbtjänster.

Fördelarna med att använda Adobe I/O Runtime-funktionsmakron är:

+ Åtgärder är serverlösa funktioner som körs utanför en webbläsare, vilket eliminerar behovet av att oroa sig för CORS
+ Funktionsmakron kan inte avbrytas av användaren (till exempel uppdatering av webbläsaren)
+ Åtgärderna är asynkrona, så de kan köras så länge som behövs utan att blockera användaren

I AEM Content Fragment-tillägg används åtgärder oftast för att kommunicera AEM as a Cloud Service direkt, ofta:

+ Samla in relaterade data från AEM om innehållsfragment
+ Utföra anpassade åtgärder på innehållsfragment
+ Börjar skapa innehållsfragment

Tillägget AEM innehållsfragment visas i konsolen för innehållsfragment, men tillägg och tillhörande åtgärder kan anropa alla tillgängliga AEM-API:er, inklusive anpassade AEM-API-slutpunkter.

## Anropa en åtgärd

Adobe I/O Runtime-åtgärder anropas huvudsakligen från två platser i ett AEM Content Fragment-tillägg:

1. The [tilläggsregistrering](./extension-registration.md) `onClick(..)` hanterare
1. Inom en [modal](./modal.md)

### Från tilläggsregistrering

Adobe I/O Runtime-åtgärder kan anropas direkt från tilläggsregistreringskoden. Det vanligaste användningsfallet är att binda en åtgärd till en [rubrikmeny](./header-menu.md#no-modal)knappen som inte använder [modaler](./modal.md).

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
// allActions is an object containing all the actions defined in the extension's manifest
import allActions from '../config.json'

// actionWebInvoke is a helper that invokes an action
import actionWebInvoke from '../utils'
...
function ExtensionRegistration() {
  const init = async () => {
    const guestConnection = await register({
      id: extensionId, // A unique ID for the extension
      methods: {
        // Configure your header menu button here
        headerMenu: {
          getButton() {
            return {
              'id': 'example.my-header-menu-extension',  // Unique ID for the button
              'label': 'My header menu extension',       // Button label 
              'icon': 'Edit'                             // Button icon from https://spectrum.adobe.com/page/icons/
            }
          },

          // Click handler for the extension button
          onClick() {
            // Set the HTTP headers required to access the Adobe I/O runtime action
            const headers = {
              'Authorization': 'Bearer ' + guestConnection.sharedContext.get('auth').imsToken,
              'x-gw-ims-org-id': guestConnection.sharedContext.get('auth').imsOrg
            };

            // Set the parameters to pass to the Adobe I/O Runtime action
            const params = {
              aemHost: `https://${guestConnection.sharedContext.get('aemHost')}`, // Pass in the AEM host if the action interacts with AEM
              aemAccessToken: guestConnection.sharedContext.get('auth').imsToken
            };

            try {
              // Invoke Adobe I/O Runtime action named `generic`, with the configured headers and parameters.
              const actionResponse = await actionWebInvoke(allActions['generic'], headers, params);
            } catch (e) {
              // Log and store any errors
              console.error(e)
            }           
          }
        }
      }
    })
  }
  init().catch(console.error);
}
```

### Från modal

Adobe I/O Runtime-åtgärder kan anropas direkt från modulerna för att utföra mer engagerande arbete, särskilt arbete som bygger på kommunikation med AEM as a Cloud Service, Adobe webbtjänst eller till och med tredjepartstjänster.

Adobe I/O Runtime-åtgärder är Node.js-baserade JavaScript-program som körs i den serverlösa Adobe I/O Runtime-miljön. Dessa åtgärder kan adresseras via HTTP av SPA.

+ `./src/aem-cf-console-admin-1/web-src/src/components/MyModal.js`

```javascript
import React, { useState, useEffect } from 'react'
import { attach } from "@adobe/uix-guest"
import {
  Flex,
  Provider,
  Content,
  defaultTheme,
  Text,
  ButtonGroup,
  Button
} from '@adobe/react-spectrum'
import Spinner from "./Spinner"
import { useParams } from "react-router-dom"
import { extensionId } from "./Constants"

export default function MyModal() {
  // Initial modal views for Action Bar extensions typically pass in the list of selected Content Fragment Paths from ExtensionRegistration.js
  // Get the paths from useParams() and split on delimiter used
  let { selection } = useParams();
  let contentFragmentPaths = selection?.split('|') || [];

  const [actionInvokeInProgress, setActionInvokeInProgress] = useState(false);
  const [actionResponse, setActionResponse] = useState();

  // Asynchronously attach the extension to AEM. 
  // Wait or the guestConnection to be set before doing anything in the modal.
  const [guestConnection, setGuestConnection] = useState()
  useEffect(() => {
    (async () => {
      const guestConnection = await attach({ id: extensionId })
      setGuestConnection(guestConnection);
    })()
  }, [])

  if (!guestConnection) {
    // If the guestConnection is not initialized, display a loading spinner
    return <Spinner />
  } else if (!actionResponse) {
    // Else if the modal is ready to render and has not called the Adobe I/O Runtime action yet
    return (
        <Provider theme={defaultTheme} colorScheme='light'>
            <Content width="100%">
                <Flex width="100%">
                    <Text>
                        The selected Content Fragments are: { contentFragmentPaths.join(', ') }
                    </Text>                    

                     <ButtonGroup align="end">
                        <Button variant="cta" onPress={doWork}>Do work</Button>
                        <Button variant="primary" onPress={() => guestConnection.host.modal.close()}>Close</Button>
                    </ButtonGroup>
                </Flex>
            </Content>
        </Provider>
    )
  } else {
    // Else the modal has called the Adobe I/O Runtime action and is ready to render the response
    return (
        <Provider theme={defaultTheme} colorScheme='light'>
            <Content width="100%">
                <Flex width="100%">
                    <Text>
                        Done! The response from the action is: { actionResponse }
                    </Text>                    

                     <ButtonGroup align="end">
                        <Button variant="primary" onPress={() => guestConnection.host.modal.close()}>Close</Button>
                    </ButtonGroup>
                </Flex>
            </Content>
        </Provider>
    )
  }

  /**
   * Invoke the Adobe I/O Runtime action and store the response in the React component's state.
   */
  async function doWork() {
    // Mark the extension as invoking the action, so the loading spinner is displayed
    setActionInvokeInProgress(true);

    // Set the HTTP headers to access the Adobe I/O runtime action
    const headers = {
      'Authorization': 'Bearer ' + guestConnection.sharedContext.get('auth').imsToken,
      'x-gw-ims-org-id': guestConnection.sharedContext.get('auth').imsOrg
    };

    // Set the parameters to pass to the Adobe I/O Runtime action
    const params = {
      aemHost: `https://${guestConnection.sharedContext.get('aemHost')}`,
      contentFragmentPaths: contentFragmentPaths
    };

    try {
      // Invoke Adobe I/O Runtime action with the configured headers and parameters
      // Invoke the Adobe I/O Runtime action named `generic`.
      const actionResponse = await actionWebInvoke(allActions['generic'], headers, params);

      // Set the response from the Adobe I/O Runtime action
      setActionResponse(actionResponse);
    } catch (e) {
      // Log and store any errors
      console.error(e)
    }

    // Set the action as no longer being invoked, so the loading spinner is hidden
    setActionInvokeInProgress(false);
  }
}
```

## Adobe I/O Runtime action

+ `src/aem-cf-console-admin-1/actions/generic/index.js`

```javascript
const fetch = require('node-fetch')
const { Core } = require('@adobe/aio-sdk')
const { errorResponse, getBearerToken, stringParameters, checkMissingRequestInputs } = require('../utils')

async function main (params) {
  const logger = Core.Logger('main', { level: params.LOG_LEVEL || 'info' })

  try {
    logger.debug(stringParameters(params))

    // Check for missing request input parameters and headers
    const requiredParams = [ 'aemHost', 'contentFragmentPaths' ]
    const requiredHeaders = ['Authorization']
    const errorMessage = checkMissingRequestInputs(params, requiredParams, requiredHeaders)
    if (errorMessage) {
      // return and log client errors
      return errorResponse(400, errorMessage, logger)
    }
      
    // Extract the user Bearer token from the Authorization header used to authenticate the request to AEM
    const accessToken = getBearerToken(params);

    // Example HTTP request to AEM payload; This updates all 'title' properties of the Content Fragments to 'Hello World'
    const body = {
      "properties": {
        "elements": {
          "title": {
            "value": "Hello World"
          }
        }
      }
    };

    let results = await Promise.all(params.contentFragmentPaths.map(async (contentFragmentPath) => {
      // Invoke the AEM HTTP Assets Content Fragment API to update each Content Fragment
      // The AEM host is passed in as a parameter to the Adobe I/O Runtime action
      const res = await fetch(`${params.aemHost}${contentFragmentPath.replace('/content/dam/', '/api/assets/')}.json`, { 
        method: 'put',
        body: JSON.stringify(body),
        headers: {
          // Pass in the accessToken as AEM Author service requires authentication/authorization
          'Authorization': `Bearer ${accessToken}`,
          'Content-Type': 'application/json'
        }
      });

      if (res.ok) {
        logger.info(`Successfully updated title of ${contentFragmentPath}`);
        return { contentFragmentPath, status: res.status, statusText: res.statusText, body: await res.json() };
      } else {
        logger.info(`Failed to update title of ${contentFragmentPath}`);
        return { contentFragmentPath, status: res.status, statusText: res.statusText, body: await res.text() };
      }
    }));

    // Return a response to the AEM Content Fragment extension React application
    const response = {
      statusCode: 200,
      body: results
    };
    return response;

  } catch (error) {
    logger.error(error)
    return errorResponse(500, 'server error', logger)
  }
}
```

## AEM HTTP API:er

Följande AEM HTTP-API:er används ofta för interaktion med AEM från tillägg:

+ [AEM GraphQL API:er](https://experienceleague.adobe.com/landing/experience-manager/headless/developer.html)
+ [AEM Assets HTTP API](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/admin/mac-api-assets.html)
   + [Stöd för Content Fragments i AEM Assets HTTP API](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/admin/assets-api-content-fragments.html)
+ [AEM QueryBuilder API](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/full-stack/search/query-builder-api.html)
+ [Fullständig AEM as a Cloud Service API-referens](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/reference-materials.html)


## Adobe npm-moduler

Följande är användbara npm-moduler för utveckling av Adobe I/O Runtime-åtgärder:

+ [@adobe/aio-sdk](https://www.npmjs.com/package/@adobe/aio-sdk)
   + [Core SDK](https://github.com/adobe/aio-sdk-core)
   + [Tillståndsbibliotek](https://github.com/adobe/aio-lib-state)
   + [Filbibliotek](https://github.com/adobe/aio-lib-files)
   + [Adobe Target Library](https://github.com/adobe/aio-lib-target)
   + [Adobe Analytics Library](https://github.com/adobe/aio-lib-analytics)
   + [Adobe Campaign Standard Library](https://github.com/adobe/aio-lib-campaign-standard)
   + [Adobe kundprofilbibliotek](https://github.com/adobe/aio-lib-customer-profile)
   + [Adobe Audience Manager kunddatabibliotek](https://github.com/adobe/aio-lib-audience-manager-cd)
   + [Adobe I/O Events](https://github.com/adobe/aio-lib-events)
+ [@adobe/aio-lib-core-network](https://github.com/adobe/aio-lib-core-networking)
+ [@adobe/node-httptransfer](https://github.com/adobe/node-httptransfer)
