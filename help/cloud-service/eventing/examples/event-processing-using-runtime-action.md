---
title: AEM händelsehantering med Adobe I/O Runtime Action
description: Lär dig hur du bearbetar mottagna AEM med Adobe I/O Runtime Action.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 0
last-substantial-update: 2024-01-30T00:00:00Z
jira: KT-14879
thumbnail: KT-14879.jpeg
source-git-commit: 85e1ee33626d27f1b6c07bc631a7c1068930f827
workflow-type: tm+mt
source-wordcount: '548'
ht-degree: 0%

---


# AEM händelsehantering med Adobe I/O Runtime Action

Lär dig hur du bearbetar mottagna AEM händelser med [Adobe I/O Runtime](https://developer.adobe.com/runtime/docs/guides/overview/what_is_runtime/) Åtgärd. Det här exemplet förbättrar det tidigare exemplet [Adobe I/O Runtime Action and AEM Events](runtime-action.md)kontrollerar du att du har slutfört den innan du fortsätter med den här.

>[!VIDEO](https://video.tv.adobe.com/v/3427054?quality=12&learn=on)

I det här exemplet lagrar händelsebearbetningen de ursprungliga händelsedata och mottagna händelser som ett aktivitetsmeddelande i Adobe I/O Runtime-lagringen. Men om händelsen är _Innehållsfragmentet har ändrats_ skriver du, anropar AEM författartjänst för att hitta ändringsinformationen. Slutligen visas händelseinformationen i ett enda program (SPA).

## Krav

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service miljö med [AEM Eventing aktiverad](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment). Dessutom innehåller exemplet [WKND Sites](https://github.com/adobe/aem-guides-wknd?#aem-wknd-sites-project) projektet måste distribueras till det.

- Åtkomst till [Adobe Developer Console](https://developer.adobe.com/developer-console/docs/guides/getting-started/).

- [ADOBE DEVELOPER CLI](https://developer.adobe.com/runtime/docs/guides/tools/cli_install/) installeras på din lokala dator.

- Lokalt initierat projekt från det tidigare exemplet [Adobe I/O Runtime Action and AEM Events](./runtime-action.md#initialize-project-for-local-development).


## Processor för AEM-händelser

I det här exemplet använder händelseprocessorn [åtgärd](https://developer.adobe.com/runtime/docs/guides/using/creating_actions/) utför följande uppgifter:

- Tolkar mottagen händelse i ett aktivitetsmeddelande.
- Om mottagen händelse är av _Innehållsfragmentet har ändrats_ skriv, anropa tillbaka till AEM författartjänst för att hitta ändringsinformationen.
- Bevarar ursprungliga händelsedata, aktivitetsmeddelanden och ändringsinformation (om sådana finns) i Adobe I/O Runtime-lagringsutrymme.

För att utföra ovanstående uppgifter börjar vi med att lägga till en åtgärd i projektet, utveckla JavaScript-moduler för att utföra ovanstående uppgifter och slutligen uppdatera åtgärdskoden så att den använder de utvecklade modulerna.

Se bifogad fil [WKND-AEM-Eventing-Runtime-Action.zip](../assets/examples/event-processing-using-runtime-action/WKND-AEM-Eventing-Runtime-Action.zip) för hela koden och de viktigaste filerna markeras i avsnittet nedan.

### Lägg till åtgärd

- Kör följande kommando om du vill lägga till en åtgärd:

  ```bash
  aio app add action
  ```

- Välj `@adobe/generator-add-action-generic` som åtgärdsmall, namnge åtgärden som `aem-event-processor`.

  ![Lägg till åtgärd](../assets/examples/event-processing-using-runtime-action/add-action-template.png)

### Utveckla JavaScript-moduler

För att utföra de uppgifter som nämns ovan ska vi utveckla följande JavaScript-moduler.

- The `src/dx-excshell-1/actions/aem-event-processor/eventValidator.js` bestämmer om den mottagna händelsen är av _Innehållsfragmentet har ändrats_ typ.

  ```javascript
  async function needsAEMCallback(aemEvent) {
  // create a Logger
  const logger = Core.Logger('eventValidator', {
      level: 'info',
  });
  
  let isValid = false;
  
  // verify the event is a Content Fragment Modified event
  if (
      aemEvent
      && aemEvent.ContentType === 'contentFragment'
      && aemEvent.EventName === 'modified'
  ) {
      logger.info('Processing Content Fragment Modified Event');
      isValid = true;
  }
  
  return isValid;
  }
  
  module.exports = needsAEMCallback;
  ```

- The `src/dx-excshell-1/actions/aem-event-processor/loadEventDetailsFromAEM.js` modulen anropar AEM författartjänst för att hitta ändringsinformationen.

  ```javascript
  ...
  const auth = require('@adobe/jwt-auth');
  ...
  // Get AEM Service Credentials aka Technical Account details.
  // These are passed to the action as params and added in .env file.
  const clientId = params.AEM_SERVICECREDENTIALS_TECHNICALACCOUNT_CLIENTID;
  const technicalAccountId = params.AEM_SERVICECREDENTIALS_ID;
  const orgId = params.AEM_SERVICECREDENTIALS_ORG;
  const clientSecret = params.AEM_SERVICECREDENTIALS_TECHNICALACCOUNT_CLIENTSECRET;
  // Private key is passed as a string with \n and \r characters escaped.
  const privateKey = params.AEM_SERVICECREDENTIALS_PRIVATEKEY.replace(
      /\\n/g,
      '\n',
  ).replace(/\\r/g, '\r');
  const metaScopes = params.AEM_SERVICECREDENTIALS_METASCOPES.split(',');
  const ims = `https://${params.AEM_SERVICECREDENTIALS_IMSENDPOINT}`;
  
  // Get the access token from IMS using Adobe I/O SDK
  const { access_token } = await auth({
      clientId,
      technicalAccountId,
      orgId,
      clientSecret,
      privateKey,
      metaScopes,
      ims,
  });
  ...
  // Call AEM Author service to get the CF details using AEM Assets API
  const res = await fetch(
      `${aemAuthorHost}${cfPath.replace('/content/dam/', '/api/assets/')}.json`,
  {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${access_token}`,
    },
  },
  );
  
  let newValuesOfCFPropertiesAddedOrModified = {};
  // If the response is OK, get the values of the CF properties that were added or modified
  if (res.ok) {
      logger.info('AEM Event Details loaded from AEM Author instance');
      const responseJSON = await res.json();
  
      // Get the values of the CF properties that were added or modified
      if (
      responseJSON
      && responseJSON.properties
      && responseJSON.properties.elements
      ) {
      const allCurrentCFProperties = responseJSON.properties.elements;
  
      newValuesOfCFPropertiesAddedOrModified = cfPropertiesAddedOrModified.map(
          (key) => ({
          key,
          value: allCurrentCFProperties[key],
          }),
      );
      }    
  }
  ...
  ```

  Se [Självstudiekurs om AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials.html?lang=en) om du vill veta mer om det. Dessutom finns [Konfigurationsfiler för App Builder](https://developer.adobe.com/app-builder/docs/guides/configuration/) för att hantera hemligheter och åtgärdsparametrar.

- The `src/dx-excshell-1/actions/aem-event-processor/storeEventData.js` i lagras de ursprungliga händelsedata, aktivitetsmeddelanden och ändringsinformation (om sådana finns) i Adobe I/O Runtime-lagringen.

  ```javascript
  ...
  const filesLib = require('@adobe/aio-lib-files');
  ...
  
  const files = await filesLib.init();
  
  const eventDataAsJSON = JSON.stringify({
      activity: activityMessage,
      aemEvent,
      aemEventDetails,
  });
  
  // store details in a folder named YYYY-MM-DD and a file named <eventID>.json
  const bytesWritten = await files.write(
      `${formattedDate}/${aemEvent.getEventID()}.json`,
      eventDataAsJSON,
  );
  ...
  ```

### Uppdatera åtgärdskod

Slutligen ska du uppdatera åtgärdskoden på `src/dx-excshell-1/actions/aem-event-processor/index.js` för att använda de utvecklade modulerna.

```javascript
...
// handle the challenge probe request, they are sent by I/O to verify the action is valid
if (params.challenge) {
    logger.info('Challenge probe request detected');
    responseMsg = JSON.stringify({ challenge: params.challenge });
} else {
    logger.info('AEM Event request received');

    // create AEM Event object from request parameters
    const aemEvent = new AEMEvent(params);

    // get AEM Event as activity message using the helper method
    const activityMessage = aemEvent.getEventAsActivityMessage();

    // determine if AEM Event requires callback to AEM Author service
    const callbackAEMForEventDetails = await needsAEMCallback(aemEvent);

    let eventDetails = {};
    if (callbackAEMForEventDetails) {
    // call AEM Author service to get specifics about the event
    eventDetails = await loadEventDetailsFromAEMAuthorService(
        aemEvent,
        params,
    );
    }

    // store AEM Event and Event details in the file system
    const storageDetails = await storeEventData(
    activityMessage,
    aemEvent,
    eventDetails || {},
    );
    logger.info(`Storage details: ${JSON.stringify(storageDetails)}`);

    // create response message
    responseMsg = JSON.stringify({
    message: 'AEM Event processed',
    activityMessage,
    });

    // response object
    const response = {
    statusCode: 200,
    body: responseMsg,
    };
    logger.info('Adobe I/O Runtime action response', response);

    // Return the response to the caller
    return response;
}
...
```

## Ytterligare resurser

- The `src/dx-excshell-1/actions/model` mappen innehåller `aemEvent.js` och `errors.js` filer, som används av åtgärden för att analysera den mottagna händelsen och hantera fel.
- The `src/dx-excshell-1/actions/load-processed-aem-events` -mappen innehåller åtgärdskod. Den här åtgärden används av SPA för att läsa in de bearbetade AEM händelserna från Adobe I/O Runtime-lagringen.
- The `src/dx-excshell-1/web-src` -mappen innehåller den SPA koden som visar de bearbetade AEM.
- The `src/dx-excshell-1/ext.config.yaml` filen innehåller åtgärdskonfiguration och parametrar.

## Koncept och viktiga arbetsmoment

Kraven för händelsebearbetning skiljer sig från projekt till projekt, men de viktigaste stegen i det här exemplet är:

- Händelsebearbetningen kan göras med Adobe I/O Runtime Action.
- Körningsåtgärden kan kommunicera med system som interna program, tredjepartslösningar och Adobe-lösningar.
- Körningsåtgärden fungerar som en startpunkt för en affärsprocess som utformats kring en innehållsändring.





