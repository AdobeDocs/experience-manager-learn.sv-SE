---
title: Läsa in och utlösa ett Target-anrop
description: Lär dig hur du läser in, skickar parametrar till sidförfrågningar och startar ett Target-anrop från webbplatssidan med en startregel. Sidinformation hämtas och skickas som parametrar med hjälp av Adobe klientdatalager, som du kan använda för att samla in och lagra data om besökarnas upplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data.
feature: Kärnkomponenter, Adobe-klientdatalager
topics: integrations, administration, development
audience: administrator, developer
doc-type: technical video
activity: setup
version: cloud-service
kt: 6133
thumbnail: 41243.jpg
topic: Integreringar
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '622'
ht-degree: 0%

---


# Läsa in och utlösa ett Target-anrop {#load-fire-target}

Lär dig hur du läser in, skickar parametrar till sidförfrågningar och startar ett Target-anrop från webbplatssidan med en startregel. Webbsidesinformation hämtas och skickas som parametrar med hjälp av Adobe klientdatalager, som du kan använda för att samla in och lagra data om besökarnas upplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data.

>[!VIDEO](https://video.tv.adobe.com/v/41243?quality=12&learn=on)

## Inläsningsregel för sida

Adobe-klientdatalagret är ett händelsestyrt datalager. När AEM siddatalager har lästs in utlöser det en händelse `cmp:show`. I videon anropas regeln `Launch Library Loaded` med en anpassad händelse. Nedan hittar du de kodfragment som används i videon för den anpassade händelsen samt för dataelementen.

### Egen sidvisningshändelse{#page-event}

![Händelsekonfiguration som visas på sidan och anpassad kod](assets/load-and-fire-target-call.png)

I Launch-egenskapen lägger du till en ny **Event** i **regeln**

+ __tillägg:__ Core
+ __händelsetyp:__ egen kod
+ __Namn:__ Händelsehanterare för sidvisning (eller något beskrivande)

Tryck på knappen __Öppna redigeraren__ och klistra in följande kodfragment. Den här koden __måste__ läggas till i __händelsekonfigurationen__ och en efterföljande __åtgärd__.

```javascript
// Define the event handler function
var pageShownEventHandler = function(coreComponentEvent) {

    // Check to ensure event trigger via AEM Core Components is shaped correctly
    if (coreComponentEvent.hasOwnProperty("eventInfo") && 
        coreComponentEvent.eventInfo.hasOwnProperty("path")) {
    
        // Debug the AEM Component path the show event is associated with
        console.debug("cmp:show event: " + coreComponentEvent.eventInfo.path);

        // Create the Launch Event object
        var launchEvent = {
            // Include the ID of the AEM Component that triggered the event
            id: coreComponentEvent.eventInfo.path,
            // Get the state of the AEM Component that triggered the event           
            component: window.adobeDataLayer.getState(coreComponentEvent.eventInfo.path)
        };

        //Trigger the Launch Rule, passing in the new `event` object
        // the `event` obj can now be referenced by the reserved name `event` by other Launch data elements
        // i.e `event.component['someKey']`
        trigger(launchEvent);
   }
}

// With the AEM Core Component event handler, that proxies the event and relevant information to Adobe Launch, defined above...

// Initialize the adobeDataLayer global object in a safe way
window.adobeDataLayer = window.adobeDataLayer || [];

// Push the event custom listener onto the Adobe Data Layer
window.adobeDataLayer.push(function (dataLayer) {
   // Add event listener for the `cmp:show` event, and the custom `pageShownEventHandler` function as the callback
   dataLayer.addEventListener("cmp:show", pageShownEventHandler);
});
```

En anpassad funktion definierar `pageShownEventHandler` och lyssnar efter händelser som skickas av AEM Core Components, hämtar relevant information från Core Component, paketerar den i ett händelseobjekt och utlöser Launch Event med den härledda händelseinformationen vid dess nyttolast.

Startregeln aktiveras med Launch-funktionen `trigger(...)` som är __endast__ som är tillgänglig från en Regels definition av anpassat kodfragment för en händelse.

Funktionen `trigger(...)` tar ett händelseobjekt som en parameter som i sin tur visas i Launch Data Elements med ett annat reserverat namn i Launch med namnet `event`. Data Elements i Launch kan nu referera till data från det här händelseobjektet från `event`-objektet med syntax som `event.component['someKey']`.

Om `trigger(...)` används utanför kontexten för händelsetypen Custom Code (till exempel i en Action) genereras JavaScript-felet `trigger is undefined` på den webbplats som är integrerad med egenskapen Launch.


### Dataelement

![Dataelement](assets/data-elements.png)

Adobe Launch Data Elements mappar data från händelseobjektet [som utlöstes i den anpassade sidvisningshändelsen](#page-event) till variabler som är tillgängliga i Adobe Target, via Core-tilläggets Custom Code Data Element Type.

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

Den här koden returnerar AEM sökväg.

![Sidsökväg](assets/pagepath.png)

### Dataelement för sidrubrik

```
if (event && event.component && event.component.hasOwnProperty('dc:title')) {
    return event.component['dc:title'];
}
```

Den här koden returnerar AEM sidtitel.

![Sidrubrik](assets/pagetitle.png)

## Felsökning

### Varför skjuter inte mina lådor på mina webbsidor?

#### Felmeddelande när mboxDisable cookie inte är inställd

![Fel på Cookie-måldomän](assets/target-cookie-error.png)

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

+ [Dokumentation för Adobe-klientdatalager](https://github.com/adobe/adobe-client-data-layer/wiki)
+ [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj)
+ [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)
+ [Använda Adobe Client Data Layer och Core Components Documentation](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html)
+ [Introduktion till Adobe Experience Platform Debugger](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html)