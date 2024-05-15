---
title: Använda Adobe-klientdatalagret med AEM kärnkomponenter
description: Adobe-klientdatalagret innehåller en standardmetod för att samla in och lagra data om en besökares upplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data. Adobe Client Data Layer är plattformsoberoende, men är helt integrerad i de centrala komponenterna för användning med AEM.
topic: Integrations
feature: Adobe Client Data Layer, Core Components
role: Developer
level: Intermediate
jira: KT-6261
thumbnail: 41195.jpg
last-substantial-update: 2021-01-11T00:00:00Z
doc-type: Tutorial
exl-id: 066693b7-2b87-45e8-93ec-8bd09a7c263e
duration: 777
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '750'
ht-degree: 0%

---

# Använda Adobe-klientdatalagret med AEM kärnkomponenter {#overview}

Adobe-klientdatalagret innehåller en standardmetod för att samla in och lagra data om en besökares upplevelse på en webbsida och sedan göra det enkelt att komma åt dessa data. Adobe Client Data Layer är plattformsoberoende, men är helt integrerad i de centrala komponenterna för användning med AEM.

>[!VIDEO](https://video.tv.adobe.com/v/41195?quality=12&learn=on)

>[!NOTE]
>
> Vill du aktivera Adobe-klientdatalagret på AEM? [Se instruktionerna här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html#installation-activation).

## Utforska datalagret

Du kan få en uppfattning om de inbyggda funktionerna i Adobe Client Data Layer genom att bara använda utvecklarverktygen i din webbläsare och live [WKND-referensplats](https://wknd.site/us/en.html).

>[!NOTE]
>
> Skärmbilder nedan tagna från webbläsaren Chrome.

1. Navigera till [https://wknd.site/us/en.html](https://wknd.site/us/en.html)
1. Öppna utvecklingsverktygen och ange följande kommando i **Konsol**:

   ```js
   window.adobeDataLayer.getState();
   ```

   Om du vill se det aktuella läget för datalagret på en AEM plats kontrollerar du svaret. Du bör se information om sidan och enskilda komponenter.

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

1. Kör kommandot `adobeDataLayer.getState()` igen och hitta posten för `training-data`.
1. Lägg sedan till en path-parameter som returnerar bara ett specifikt läge för en komponent:

   ```js
   window.adobeDataLayer.getState('component.training-data');
   ```

   ![Returnera endast en enda datainmatning](assets/return-just-single-component.png)

## Arbeta med händelser

Det är bäst att utlösa en anpassad kod som baseras på en händelse från datalagret. Sedan kan du utforska registrering och avlyssning av olika händelser.

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

   Ovanstående kod kontrollerar `event` -objektet och använder `adobeDataLayer.getState` metod för att hämta det aktuella läget för objektet som utlöste händelsen. Sedan undersöker hjälpmetoden `filter` och bara om aktuell `dataObject` uppfyller filtervillkoren som returneras.

   >[!CAUTION]
   >
   > Det är viktigt **not** om du vill uppdatera webbläsaren under övningen, annars försvinner konsolens JavaScript.

1. Ange sedan en händelsehanterare som anropas när en **Teaser** -komponenten visas i en **Carousel**.

   ```js
   function teaserShownHandler(event) {
       var dataObject = getDataObjectHelper(event, {"@type": "wknd/components/teaser"});
       if(dataObject != null) {
           console.log("Teaser Shown: " + dataObject['dc:title']);
           console.log(dataObject);
       }
   }
   ```

   The `teaserShownHandler` funktionen anropar `getDataObjectHelper` och skickar ett filter med `wknd/components/teaser` som `@type` för att filtrera bort händelser som utlöses av andra komponenter.

1. Därefter skickar du en händelseavlyssnare till datalagret för att avlyssna `cmp:show` -händelse.

   ```js
   window.adobeDataLayer.push(function (dl) {
        dl.addEventListener("cmp:show", teaserShownHandler);
   });
   ```

   The `cmp:show` -händelsen aktiveras av många olika komponenter, som när en ny bildruta visas i **Carousel** eller när en ny flik är markerad i **Tabb** -komponenten.

1. På sidan växlar du på karusellbildrutorna och följer konsolsatserna:

   ![Växla Carousel och se händelseavlyssnare](assets/teaser-console-slides.png)

1. Om du vill sluta lyssna efter `cmp:show` -händelse tar du bort händelseavlyssnaren från datalagret

   ```js
   window.adobeDataLayer = window.adobeDataLayer || [];
   window.adobeDataLayer.push(function(dl) {
       dl.removeEventListener("cmp:show", teaserShownHandler);
   });
   ```

1. Gå tillbaka till sidan och växla karusellbilderna. Observera att inga fler programsatser loggas och att ingen lyssnar på händelsen.

1. Skapa sedan en händelsehanterare som anropas när händelsen som visas på sidan utlöses:

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

1. Därefter skickar du en händelseavlyssnare till datalagret för att avlyssna `cmp:show` händelse, anropa `pageShownHandler`.

   ```js
   window.adobeDataLayer = window.adobeDataLayer || [];
   window.adobeDataLayer.push(function (dl) {
        dl.addEventListener("cmp:show", pageShownHandler);
   });
   ```

1. Du bör omedelbart se en konsolprogramsats som utlösts med siddata:

   ![Sidvisningsdata](assets/page-show-console-data.png)

   The `cmp:show` -händelsen för sidan aktiveras för varje sida som läses in överst på sidan. Du kan fråga varför händelsehanteraren utlöstes när sidan redan har lästs in?

   En av de unika funktionerna i Adobe Client Data Layer är att du kan registrera händelseavlyssnare **före** eller **efter** Om datalagret har initierats kan det hjälpa till att undvika konkurrensvillkoren.

   Datalagret underhåller en kömatris med alla händelser som har inträffat i sekvens. Som standard utlöser datalagret händelseåteranrop för händelser som inträffar i **förfluten** och händelser i **future**. Det går att filtrera händelser från tidigare eller framtida händelser. [Mer information finns i dokumentationen](https://github.com/adobe/adobe-client-data-layer/wiki#addeventlistener).


## Nästa steg

Det finns två alternativ att fortsätta lära sig: första ett, se [samla in siddata och skicka dem till Adobe Analytics](../analytics/collect-data-analytics.md) självstudiekurs som visar hur du använder datalagret Adobe Client. Det andra alternativet är att lära sig hur [Anpassa Adobe-klientdatalagret med AEM](./data-layer-customize.md)


## Ytterligare resurser {#additional-resources}

* [Dokumentation för Adobe-klientdatalager](https://github.com/adobe/adobe-client-data-layer/wiki)
* [Använda Adobe Client Data Layer och Core Components Documentation](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html)
