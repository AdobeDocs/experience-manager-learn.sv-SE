---
title: Konfigurera tillgångsinsikter med AEM Assets och Adobe Launch
description: I den här femdelade videoserien går vi igenom konfigurationen och konfigurationen av tillgångsinsikter för Experience Manager som distribueras via Launch by Adobe.
feature: Asset Insights
version: 6.4, 6.5
topic: Integrations
role: Developer
level: Intermediate
last-substantial-update: 2022-06-04T00:00:00Z
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Assets as a Cloud Service, AEM Assets 6.5" before-title="false"
doc-type: Tutorial
exl-id: 00125fe1-3bb9-4b1a-a83c-61c413403ae2
duration: 2056
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '811'
ht-degree: 0%

---

# Konfigurera tillgångsinsikter med AEM Assets och Adobe Experience Platform Launch

I den här femdelsvideoserien går vi igenom konfigurationen och konfigurationen av tillgångsinsikter för Experience Manager som driftsätts via Adobe Launch.

## Del 1: Översikt över tillgångsinsikter {#overview}

Översikt över tillgångsinsikter. Installera Core Components, Sample Image Component och andra innehållspaket för att göra miljön klar.

>[!VIDEO](https://video.tv.adobe.com/v/25943?quality=12&learn=on)

### Arkitekturdiagram {#architecture-diagram}

![Arkitekturdiagram](./assets/asset-insights-launch-tutorial/diagram.png)

>[!CAUTION]
>
>Se till att du hämtar [den senaste versionen av Core Components](https://github.com/adobe/aem-core-wcm-components) för er implementering.

I videon används Core Components v2.2.2, som inte är den senaste versionen. Använd den senaste versionen innan du fortsätter till nästa avsnitt.

* Ladda ned [Exempel på bildinnehåll för resursinsikter](./assets/asset-insights-launch-tutorial/aem-assets-insights-sample.zip)
* Ladda ned [de senaste AEM WCM Core Components](https://github.com/adobe/aem-core-wcm-components/releases)

## Del 2: Aktivera spårning av tillgångsinsikter för exempelbildkomponent {#sample-image-component-asset-insights}

Förbättringar av kärnkomponenter och användning av proxykomponent (exempelbildkomponent) för tillgångsinsikter. Redigera policyer för innehållsmallar för att aktivera exempelbildkomponenten för referensplatsen.

>[!VIDEO](https://video.tv.adobe.com/v/25944?quality=12&learn=on)

>[!NOTE]
>
>Image Core Component (Image Core-komponent) innehåller möjligheten att inaktivera UUID-spårning genom att inaktivera spårning av resursens UUID (unikt identifierarvärde för en nod som skapats i JCR)

Komponenten Core Image använder ***data-asset-id*** attribut inom överordnad &lt;div> av en bildtagg för att aktivera/inaktivera den här funktionen. Proxy-komponenten åsidosätter kärnkomponenten med följande ändringar.

* Tar bort ***data-asset-id*** från den överordnade diven för ett &lt;img> element i image.html
* Lägger till ***data-aem-asset-id*** direkt till &lt;img> elementet i image.html
* Lägger till ***data-trackable=&#39;true&#39;*** värdet till elementet &lt;img> i image.html
* ***data-aem-asset-id*** och ***data-trackable=&#39;true&#39;*** behålls på samma nodnivå

>[!NOTE]
>
>*data-aem-asset-id=&#39;image.UUID&#39;* och *data-trackable=&#39;true&#39;* är de nyckelattribut som måste finnas för resursinställningar. För insikter om tillgångsklickning måste den överordnade taggen ha ett giltigt href-värde, utöver ovanstående dataattribut som finns i taggen &lt;img> .

## Del 3: Adobe Analytics - Creating Report Suite, enabling Real-Time data collection and AEM Assets Reporting {#adobe-analytics-asset-insights}

Rapportsviten med datainsamling i realtid skapas för att spåra tillgångar. Konfigurationen av AEM Assets Insights konfigureras med Adobe Analytics inloggningsuppgifter.

>[!VIDEO](https://video.tv.adobe.com/v/25945?quality=12&learn=on)

>[!NOTE]
>
Datainsamling i realtid och rapportering av AEM tillgångar måste vara aktiverat för din Adobe Analytics Report Suite. Om du aktiverar AEM Asset Reporting reserveras analysvariabler för att spåra tillgångsinsikter.

För AEM Assets Insights-konfigurationen behöver du följande autentiseringsuppgifter

* Datacenter
* Analytics-företagsnamn
* Användarnamn för analys
* Delad hemlighet (kan hämtas från *Adobe Analytics > Admin > Företagsinställningar > Webbtjänst*).
* Report Suite (se till att välja rätt Report Suite som används för tillgångsrapportering)

## Del 4: Använda Adobe Experience Platform Launch för att lägga till Adobe Analytics-tillägg {#part-using-launch-by-adobe-for-adding-adobe-analytics-extension}

Lägga till Adobe Analytics Extension, skapa sidladdningsregler och integrera AEM med Launch med Adobe IMS-konto.

>[!VIDEO](https://video.tv.adobe.com/v/25946?quality=12&learn=on)

>[!NOTE]
>
Se till att replikera alla ändringar från författarinstansen till publiceringsinstansen.

### Regel 1: Sidspårare (pagetracker.js) {#rule-page-tracker-pagetracker-js}

```javascript
//For AEM 6.3
<script type="text/javascript" src="http://localhost:4503/etc/clientlibs/foundation/assetinsights/pagetracker.js"></script>
```

```javascript
//For AEM 6.4
<script type="text/javascript" src="http://localhost:4503/etc.clientlibs/dam/clientlibs/assetinsights/pagetracker.js"></script>
```

Page tracker implements two call back (registered in asset-embed-code)

* **\&lt;code>assetAnalytics.core.assetLoaded\&lt;code>** : anropas när load-händelsen skickas för asset-DOM-element.
* **\&lt;code>assetAnalytics.core.assetClick\&lt;code>** : anropas när händelsen click skickas för asset-DOM-element är detta bara relevant när asset-DOM-element har en ankartagg som överordnad med ett giltigt, externt &#39;href&#39;-attribut

Slutligen implementerar Page tracker en initieringsfunktion som.

* **\&lt;code>assetAnalytics.dispatcher.init()\&lt;code>** : anropades för att initiera sidspårningskomponenten. Detta MÅSTE anropas innan något av materialet-insights-events (Impressions and/or Clicks) genereras från webbsidan.
* **\&lt;code>assetAnalytics.dispatcher.init()\&lt;code>** : accepterar eventuellt ett AppMeasurementen objekt - om det anges försöker det inte skapa en instans av AppMeasurementet object.

### Regel 2: Bildspårare - Åtgärd 1 (asset-insights.js) {#rule-image-tracker-action-asset-insights-js}

```javascript
/*
 * AEM Asset Insights
 */

var sObj = window.s;
_satellite.notify('in assetAnalytics customInit');
(function initializeAssetAnalytics() {
 if ((!!window.assetAnalytics) && (!!assetAnalytics.dispatcher)) {
 _satellite.notify('assetAnalytics ready');
 /** NOTE:
  Copy over the call to 'assetAnalytics.dispatcher.init()' from Assets Pagetracker
  Be mindful about changing the AppMeasurement object as retrieved above.
  */
 assetAnalytics.dispatcher.init(
                                "",  /** RSID to send tracking-call to */
                                "",  /** Tracking Server to send tracking-call to */
                                "",  /** Visitor Namespace to send tracking-call to */
                                "",  /** listVar to put comma-separated-list of Asset IDs for Asset Impression Events in tracking-call, e.g. 'listVar1' */
                                "",  /** eVar to put Asset ID for Asset Click Events in, e.g. 'eVar3' */
                                "",  /** event to include in tracking-calls for Asset Impression Events, e.g. 'event8' */
                                "",  /** event to include in tracking-calls for Asset Click Events, e.g. 'event7' */
                                sObj  /** [OPTIONAL] if the webpage already has an AppMeasurement object, please include the object here. If unspecified, Pagetracker Core shall create its own AppMeasurement object */
                                );
 sObj.usePlugins = true;
 sObj.doPlugins = assetAnalytics.core.updateContextData;
}
 else {
 _satellite.notify('assetAnalytics not available. Consider updating the Custom Page Code', 4);
 }
})();
```

### Regel 2: Bildspårare - Åtgärd 2 (image-tracker.js) {#rule-image-tracker-action-image-tracker-js}

```javascript
/*
 * AEM Asset Insights
 */

document.querySelectorAll('[data-aem-asset-id]').forEach(function(element) {
    assetAnalytics.core.assetLoaded(element);
    var parent = element.parentElement;
    if (parent.nodeName == "A") {
        parent.addEventListener("click", function() {
            assetAnalytics.core.assetClicked(this)
        });
    }
});
```

* assetAnalytics.core.assetLoaded() : anropas vid inläsning av sida och utlöser tillgångsinställningar för alla spårbara bilder
* Analysvariabel som innehåller den inlästa tillgångslistan: **contextData[c.a.assets.idList]**
* assetAnalytics.core.assetClick() : anropas när objektets DOM-element har en ankartagg med ett giltigt href-värde. När du klickar på en resurs skapas en cookie med det resurs-ID som du klickade på som värde.**(Cookie-namn: a.assets.clickedid)**
* Analysvariabel som innehåller den inlästa tillgångslistan: **contextData[c.a.assets.clickedid&#39;]**
* Källa: **contextData[c.a.assets.source]**

### Felsökningsprogramsatser för konsol {#console-debug-statements}

```javascript
//Launch Build Info
_satellite.buildInfo

//Enables debug messages
_satellite.setDebug(true);

//Asset Insight JS Object
assetAnalytics

//List of trackable images
document.querySelectorAll(".cmp-image__image");
```

Det finns två webbläsartillägg för Google Chrome i videon som ett sätt att felsöka Analytics. Liknande tillägg finns även för andra webbläsare.

* [Starta tillägg för växlingskrom](https://chrome.google.com/webstore/detail/launch-and-dtm-switch/nlgdemkdapolikbjimjajpmonpbpmipk?hl=en)
* [Adobe Experience Cloud Debugger](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob)

Det går också att växla DTM till felsökningsläge med följande Chrome-tillägg: [Starta och DTM-växel](https://chrome.google.com/webstore/detail/launch-and-dtm-switch/nlgdemkdapolikbjimjajpmonpbpmipk?hl=en). Det gör det enklare att se om det finns några fel som rör DTM-distributionen. Dessutom kan du manuellt växla DTM till felsökningsläge via valfri webbläsare *utvecklarverktyg -> JS Console* genom att lägga till följande kodutdrag:

## Del 5: Testning av analysspårning och synkronisering av insiktsdata{#analytics-tracking-asset-insights}

Konfigurera AEM synkroniseringsrapport för jobbschemaläggning och resursinsikter

>[!VIDEO](https://video.tv.adobe.com/v/25947?quality=12&learn=on)
