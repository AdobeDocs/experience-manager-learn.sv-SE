---
title: Läsa in och utlösa ett Target-anrop
description: Lär dig hur du läser in, skickar parametrar till sidbegäran och startar ett Target-anrop från din webbplatssida med hjälp av en taggregel.
feature: Core Components, Adobe Client Data Layer
version: Experience Manager as a Cloud Service
jira: KT-6133
thumbnail: 41243.jpg
topic: Integrations
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: ec048414-2351-4e3d-b5f1-ade035c07897
duration: 588
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '544'
ht-degree: 0%

---

# Läsa in och utlösa ett Target-anrop {#load-fire-target}

Lär dig hur du läser in, skickar parametrar till sidbegäran och startar ett Target-anrop från din webbplatssida med hjälp av en taggregel. Webbsidesinformation hämtas och skickas som parametrar med hjälp av Adobe Client Data Layer, där du kan samla in och lagra data om besökarnas upplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data.

>[!VIDEO](https://video.tv.adobe.com/v/41243?quality=12&learn=on)

## Inläsningsregel för sida

Adobe klientdatalager är ett händelsestyrt datalager. När datalagret för AEM Page har lästs in utlöses en händelse `cmp:show`. I videon anropas regeln `tags Library Loaded` med en anpassad händelse. Nedan hittar du de kodfragment som används i videon för den anpassade händelsen och för dataelementen.

### Egen sidvisningshändelse{#page-event}

![Händelsekonfiguration som visas på sidan och anpassad kod](assets/load-and-fire-target-call.png)

Lägg till en ny **Event** i **Rule** i taggegenskapen

+ __Tillägg:__ Core
+ __Händelsetyp:__ Anpassad kod
+ __Namn:__ Händelsehanterare för sidvisning (eller något beskrivande)

Tryck på knappen __Öppna redigeraren__ och klistra in följande kodfragment. Koden __måste__ läggas till i __händelsekonfigurationen__ och en efterföljande __åtgärd__.

```javascript
// Define the event handler function
var pageShownEventHandler = function(coreComponentEvent) {

    // Check to ensure event trigger via AEM Core Components is shaped correctly
    if (coreComponentEvent.hasOwnProperty("eventInfo") && 
        coreComponentEvent.eventInfo.hasOwnProperty("path")) {
    
        // Debug the AEM Component path the show event is associated with
        console.debug("cmp:show event: " + coreComponentEvent.eventInfo.path);

        // Create the tags Event object
        var launchEvent = {
            // Include the ID of the AEM Component that triggered the event
            id: coreComponentEvent.eventInfo.path,
            // Get the state of the AEM Component that triggered the event           
            component: window.adobeDataLayer.getState(coreComponentEvent.eventInfo.path)
        };

        // Trigger the tags Rule, passing in the new `event` object
        // the `event` obj can now be referenced by the reserved name `event` by other tags data elements
        // i.e `event.component['someKey']`
        trigger(launchEvent);
   }
}

// With the AEM Core Component event handler, that proxies the event and relevant information to Data Collection, defined above...

// Initialize the adobeDataLayer global object in a safe way
window.adobeDataLayer = window.adobeDataLayer || [];

// Push the event custom listener onto the Adobe Data Layer
window.adobeDataLayer.push(function (dataLayer) {
   // Add event listener for the `cmp:show` event, and the custom `pageShownEventHandler` function as the callback
   dataLayer.addEventListener("cmp:show", pageShownEventHandler);
});
```

En anpassad funktion definierar `pageShownEventHandler` och lyssnar efter händelser som skickas av AEM Core Components, hämtar relevant information från Core Component, paketerar den i ett händelseobjekt och utlöser tagghändelsen med den härledda händelseinformationen vid dess nyttolast.

Taggregeln aktiveras med hjälp av taggarnas `trigger(...)`-funktion, som __endast__ är tillgänglig inifrån händelsekodfragmentsdefinitionen för en regel.

Funktionen `trigger(...)` tar ett händelseobjekt som en parameter som i sin tur visas i taggar som dataelement, med ett annat reserverat namn i taggar som heter `event`. Dataelement i taggar kan nu referera till data från det här händelseobjektet från objektet `event` med syntax som `event.component['someKey']`.

Om `trigger(...)` används utanför kontexten för händelsetypen Custom Code (till exempel i en åtgärd) genereras JavaScript-felet `trigger is undefined` på den webbplats som är integrerad med taggegenskapen.


### Dataelement

![Dataelement](assets/data-elements.png)

Taggar dataelement mappar data från händelseobjektet [som utlöses i den anpassade sidvisningshändelsen](#page-event) till variabler som är tillgängliga i Adobe Target, via Core-tilläggets Elementtyp för anpassade koddata.

#### Dataelement för sid-ID

```
if (event && event.id) {
    return event.id;
}
```

Den här koden returnerar Core-komponentens genererade unika ID.

![Sida-ID](assets/pageid.png)

### Dataelement för sidsökväg

```
if (event && event.component && event.component.hasOwnProperty('repo:path')) {
    return event.component['repo:path'];
}
```

Den här koden returnerar AEM-sidans sökväg.

![Sidsökväg](assets/pagepath.png)

### Dataelement för sidrubrik

```
if (event && event.component && event.component.hasOwnProperty('dc:title')) {
    return event.component['dc:title'];
}
```

Den här koden returnerar AEM-sidans titel.

![Sidtitel](assets/pagetitle.png)

## Felsökning

### Varför skjuter inte mina lådor på mina webbsidor?

#### Felmeddelande när mboxDisable cookie inte är inställd

![Målcookie-domänfel](assets/target-cookie-error.png)

```
> AT: [page-init] Adobe Target content delivery is disabled. Ensure that you can save cookies to your current domain, there is no "mboxDisable" cookie and there is no "mboxDisable" parameter in the query string.
```

#### Lösning

Målgrupper använder ibland molnbaserade instanser med Target för testning eller för enkla konceptbevis. Dessa domäner, och många andra, ingår i Public Suffix-listan .
Moderna webbläsare sparar inte cookies om du använder dessa domäner om du inte anpassar inställningen `cookieDomain` med `targetGlobalSettings()`.

```
window.targetGlobalSettings = {  
   cookieDomain: 'your-domain' //set the cookie directly on this subdomain, for example: 'publish-p1234-e5678.adobeaemcloud.com'
};
```

## Nästa steg

+ [Exportera Experience Fragment till Adobe Target](./export-experience-fragment-target.md)

## Stödlänkar

+ [Adobe Client Data Layer Documentation](https://github.com/adobe/adobe-client-data-layer/wiki)
+ [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob)
+ [Använda Adobe Client Data Layer och Core Components Documentation](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html)
+ [Introduktion till Adobe Experience Platform Debugger](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html)
