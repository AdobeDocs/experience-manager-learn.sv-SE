---
title: Använda Adobe-klientdatalagret med AEM kärnkomponenter
description: Adobe-klientdatalagret innehåller en standardmetod för att samla in och lagra data om en besökarupplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data. Adobe Client Data Layer är plattformsoberoende, men är helt integrerad i de centrala komponenterna för användning med AEM.
feature: core-component
topics: integrations
audience: developer
doc-type: feature video
activity: use
version: cloud-service
kt: 6261
thumbnail: 41195.jpg
translation-type: tm+mt
source-git-commit: e13a5171fbeb9e1eb5f78d1c691bc8b4b896a998
workflow-type: tm+mt
source-wordcount: '775'
ht-degree: 0%

---


# Använda Adobe-klientdatalagret med AEM kärnkomponenter {#overview}

Adobe-klientdatalagret innehåller en standardmetod för att samla in och lagra data om en besökarupplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data. Adobe Client Data Layer är plattformsoberoende, men är helt integrerad i de centrala komponenterna för användning med AEM.

>[!VIDEO](https://video.tv.adobe.com/v/41195?quality=12&learn=on)

>[!NOTE]
>
> Vill du aktivera Adobe-klientdatalagret på AEM? [Se instruktionerna här](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation).

## Utforska datalagret

Du kan få en uppfattning om de inbyggda funktionerna i Adobe Client Data Layer genom att använda utvecklarverktygen i din webbläsare och den aktiva [WKND-referenswebbplatsen](https://wknd.site/).

>[!NOTE]
>
> Skärmbilder nedan tagna från webbläsaren Chrome.

1. Navigera till [https://wknd.site](https://wknd.site)
1. Öppna utvecklarverktygen och ange följande kommando i **konsolen**:

   ```js
   window.adobeDataLayer.getState();
   ```

   Inspect svaret för att se det aktuella läget för datalagret på en AEM. Du bör se information om sidan och enskilda komponenter.

   ![Adobe datalagersvar](assets/data-layer-state-response.png)

1. Skicka ett dataobjekt till datalagret genom att ange följande i konsolen:

   ```js
   window.adobeDataLayer.push({
       "component": {
           "training-data": {
               "title": "Learn More",
               "link": "learn-more.html"
           }
       }
   });
   ```

1. Kör kommandot `adobeDataLayer.getState()` igen och sök efter posten `training-data`.
1. Lägg sedan till en path-parameter som returnerar bara ett specifikt läge för en komponent:

   ```js
   window.adobeDataLayer.getState('component.training-data');
   ```

   ![Returnera endast en enda datainmatning](assets/return-just-single-component.png)

## Arbeta med händelser

Det är bäst att utlösa en anpassad kod som baseras på en händelse från datalagret. Sedan kan du utforska registreringen och lyssna på olika händelser.

1. Ange följande hjälpmetod i konsolen:

   ```js
   function getDataObjectHelper(event, filter) {
       if (event.hasOwnProperty("eventInfo") && event.eventInfo.hasOwnProperty("path")) {
           var dataObject = window.adobeDataLayer.getState(event.eventInfo.path);
           if (dataObject != null) {
               for (var property in filter) {
                   if (!dataObject.hasOwnProperty(property) || (filter[property] !== null && filter[property] !== dataObject[property])) {
                       return;
                   }
                   return dataObject;
               }
           }
       }
       return;
   }
   ```

   Ovanstående kod inspekterar `event` objektet och använder `adobeDataLayer.getState` metoden för att hämta det aktuella läget för objektet som utlöste händelsen. Hjälpmetoden granskar sedan `filter` villkoren och bara om den aktuella `dataObject` uppfyller filtret returneras den.

   >[!CAUTION]
   >
   > Det är viktigt att du **inte** uppdaterar webbläsaren under övningen, annars försvinner konsolens JavaScript.

1. Ange sedan en händelsehanterare som ska anropas när en **Teaser** -komponent visas i en **Carousel**.

   ```js
   function teaserShownHandler(event) {
       var dataObject = getDataObjectHelper(event, {"@type": "wknd/components/teaser"});
       if(dataObject != null) {
           console.log("Teaser Shown: " + dataObject['dc:title']);
           console.log(dataObject);
       }
   }
   ```

   Metoden anropas `teaserShownHandler` och `getDataObjectHelper` skickas som ett filter för `wknd/components/teaser` att `@type` filtrera bort händelser som utlöses av andra komponenter.

1. Därefter skickar du en händelseavlyssnare till datalagret för att avlyssna `cmp:show` händelsen.

   ```js
   window.adobeDataLayer.push(function (dl) {
        dl.addEventListener("cmp:show", teaserShownHandler);
   });
   ```

   Händelsen `cmp:show` aktiveras av många olika komponenter, som när en ny bildruta visas i **Carousel** eller när en ny flik väljs i **Tab** -komponenten.

1. På sidan växlar du karusellbildrutorna och följer konsolsatserna:

   ![Växla Carousel och se händelseavlyssnare](assets/teaser-console-slides.png)

1. Ta bort händelseavlyssnaren från datalagret för att sluta lyssna efter `cmp:show` händelsen:

   ```js
   window.adobeDataLayer = window.adobeDataLayer || [];
   window.adobeDataLayer.push(function(dl) {
       dl.removeEventListener("cmp:show", teaserShownHandler);
   });
   ```

1. Gå tillbaka till sidan och växla karusellbilderna. Observera att inga fler programsatser loggas och att ingen lyssnar på händelsen.

1. Ange sedan en händelsehanterare som ska anropas när händelsen för sidan som visas aktiveras:

   ```js
   function pageShownHandler(event) {
       var dataObject = getDataObjectHelper(event, {"@type": "wknd/components/page"});
       if(dataObject != null) {
           console.log("Page Shown: " + dataObject['dc:title']);
           console.log(dataObject);
       }
   }
   ```

   Observera att resurstypen `wknd/components/page` används för att filtrera händelsen.

1. Sedan skickar du en händelseavlyssnare till datalagret för att avlyssna `cmp:show` händelsen och anropar `pageShownHandler`.

   ```js
   window.adobeDataLayer = window.adobeDataLayer || [];
   window.adobeDataLayer.push(function (dl) {
        dl.addEventListener("cmp:show", pageShownHandler);
   });
   ```

1. Du bör omedelbart se en konsolprogramsats som utlösts med siddata:

   ![Visa data](assets/page-show-console-data.png)

   Händelsen `cmp:show` för sidan aktiveras för varje sida som läses in högst upp på sidan. Du kan fråga varför händelsehanteraren utlöstes när sidan redan har lästs in?

   Detta är en av de unika funktionerna i Adobe Client Data Layer, eftersom du kan registrera händelseavlyssnare **före** eller **efter** det att datalagret har initierats. Detta är en viktig funktion för att undvika konkurrensförhållanden.

   Datalagret underhåller en kömatris med alla händelser som har inträffat i sekvens. Datalagret kommer som standard att utlösa händelseåteranrop för händelser som har inträffat **tidigare** samt händelser i **framtiden**. Det går att filtrera händelserna så att de bara är äldre eller framtida. [Mer information finns i dokumentationen](https://github.com/adobe/adobe-client-data-layer/wiki#addeventlistener).


## Nästa steg

Titta på följande självstudiekurs för att lära dig hur du använder det händelsestyrda Adobe Client Data-lagret för att [samla in siddata och skicka till Adobe Analytics](../analytics/collect-data-analytics.md).


## Ytterligare resurser {#additional-resources}

* [Dokumentation för Adobe-klientdatalager](https://github.com/adobe/adobe-client-data-layer/wiki)
* [Använda Adobe Client Data Layer och Core Components Documentation](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/data-layer/overview.html)
