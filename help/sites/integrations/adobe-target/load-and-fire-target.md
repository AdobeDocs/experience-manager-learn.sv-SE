---
title: Läsa in och utlösa ett Target-anrop
description: Lär dig hur du läser in, skickar parametrar till sidförfrågningar och startar ett Target-anrop från webbplatssidan med en startregel. Sidinformation hämtas och skickas som parametrar med hjälp av Adobe klientdatalager, som du kan använda för att samla in och lagra data om besökarnas upplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data.
feature: launch, core-components, data-layer
topics: integrations, administration, development
audience: administrator, developer
doc-type: technical video
activity: setup
version: cloud-service
kt: 6133
thumbnail: 41243.jpg
translation-type: tm+mt
source-git-commit: 25ca90f641aaeb93fc9319692f3b099d6b528dd1
workflow-type: tm+mt
source-wordcount: '447'
ht-degree: 0%

---


# Läsa in och utlösa ett Target-anrop {#load-fire-target}

Lär dig hur du läser in, skickar parametrar till sidförfrågningar och startar ett Target-anrop från webbplatssidan med en startregel. Sidinformation hämtas och skickas som parametrar med hjälp av Adobe klientdatalager, som du kan använda för att samla in och lagra data om besökarnas upplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data.

>[!VIDEO](https://video.tv.adobe.com/v/41243?quality=12&learn=on)

## Inläsningsregel för sida

Adobe-klientdatalagret är ett händelsestyrt datalager. När AEM siddatalager läses in utlöses en händelse `cmp:show` . I videon anropas `Launch Library Loaded` regeln med en anpassad händelse. Nedan hittar du de kodfragment som används i videon för den anpassade händelsen samt för dataelementen.

### Egen händelse

Kodfragmentet nedan lägger till en händelseavlyssnare genom att föra in en funktion i datalagret. När `cmp:show` händelsen utlöses anropas `pageShownEventHandler` funktionen. I den här funktionen läggs några säkerhetskontroller till och en ny `dataObject` skapas med det senaste läget för datalagret för komponenten som utlöste händelsen.

Efter det `trigger(dataObject)` anropas. `trigger()` är ett reserverat namn i Launch och kommer att utlösa startregeln. Vi skickar händelseobjektet som en parameter som i sin tur visas med ett annat reserverat namn i Launch-händelsen. Dataelement i Launch kan nu referera till olika egenskaper som: `event.component['someKey']`.

```javascript
var pageShownEventHandler = function(evt) {
// defensive coding to avoid a null pointer exception
if(evt.hasOwnProperty("eventInfo") && evt.eventInfo.hasOwnProperty("path")) {
   //trigger Launch Rule and pass event
   console.debug("cmp:show event: " + evt.eventInfo.path);
   var event = {
      //include the id of the component that triggered the event
      id: evt.eventInfo.path,
      //get the state of the component that triggered the event
      component: window.adobeDataLayer.getState(evt.eventInfo.path)
   };

      //Trigger the Launch Rule, passing in the new `event` object
      // the `event` obj can now be referenced by the reserved name `event` by other Launch data elements
      // i.e `event.component['someKey']`
      trigger(event);
   }
}

//set the namespace to avoid a potential race condition
window.adobeDataLayer = window.adobeDataLayer || [];
//push the event listener for cmp:show into the data layer
window.adobeDataLayer.push(function (dl) {
   //add event listener for `cmp:show` and callback to the `pageShownEventHandler` function
   dl.addEventListener("cmp:show", pageShownEventHandler);
});
```

### ID för datalagersida

```
if(event && event.id) {
    return event.id;
}
```

![Sida-ID](assets/pageid.png)

### Sidsökväg

```
if(event && event.component && event.component.hasOwnProperty('repo:path')) {
    return event.component['repo:path'];
}
```

![Sidsökväg](assets/pagepath.png)

### Sidrubrik

```
if(event && event.component && event.component.hasOwnProperty('dc:title')) {
    return event.component['dc:title'];
}
```

![Sidrubrik](assets/pagetitle.png)

### Vanliga problem

#### Varför skjuter inte mina lådor på mina webbsidor?

**Felmeddelande när mboxDisable cookie inte är inställd**

![Fel på Cookie-måldomän](assets/target-cookie-error.png)

**Lösning**

Målgrupper använder ibland molnbaserade instanser med Target för testning eller för enkla konceptbevis. Dessa domäner, och många andra, ingår i Public Suffix-listan .
I moderna webbläsare sparas inte cookies om du använder dessa domäner om du inte anpassar `cookieDomain` inställningen med `targetGlobalSettings()`.

```
window.targetGlobalSettings = {  
   cookieDomain: 'your-domain' //set the cookie directly on this subdomain 
};
```

## Stödlänkar

* [Dokumentation för Adobe-klientdatalager](https://github.com/adobe/adobe-client-data-layer/wiki)
* [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj)
* [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)
* [Använda Adobe Client Data Layer och Core Components Documentation](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html)
* [Introduktion till Adobe Experience Platform Debugger](https://docs.adobe.com/content/help/en/platform-learn/tutorials/data-ingestion/web-sdk/introduction-to-the-experience-platform-debugger.html)