---
title: Integrera AEM Sites och Adobe Analytics med Platform Web SDK
description: Integrera AEM Sites och Adobe Analytics med SDK.
version: Experience Manager as a Cloud Service
feature: Integrations
topic: Integrations, Architecture
role: Admin, Developer
level: Beginner, Intermediate
doc-type: Tutorial
last-substantial-update: 2023-05-25T00:00:00Z
jira: KT-13328
thumbnail: KT-13328.jpeg
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
exl-id: 0cc3d3bc-e4ea-4ab2-8878-adbcf0c914f5
duration: 2252
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '1529'
ht-degree: 0%

---

# Integrera AEM Sites och Adobe Analytics med Platform Web SDK

Lär dig det **moderna sättet** att integrera Adobe Experience Manager (AEM) och Adobe Analytics med Platform Web SDK. Den här omfattande självstudiekursen vägleder dig genom processen att sömlöst samla in [WKND](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project)-sidvyn och CTA klickdata. Få värdefulla insikter genom att visualisera insamlade data i Adobe Analysis Workspace, där ni kan utforska olika mätvärden och dimensioner. Utforska även plattformsdatauppsättningen för att verifiera och analysera data. Följ oss på den här resan för att utnyttja kraften i AEM och Adobe Analytics för datadrivet beslutsfattande.

## Ökning

Att få insikter i användarbeteenden är ett viktigt mål för alla marknadsföringsteam. Genom att förstå hur användarna interagerar med sitt innehåll kan teamen fatta välgrundade beslut, optimera strategier och få bättre resultat. WKND:s marknadsföringsteam, en fiktiv enhet, har satt sina mål att implementera Adobe Analytics på sin webbplats för att uppnå detta mål. Det främsta målet är att samla in data om två viktiga mätvärden: sidvisningar och call-to-action-klickningar (CTA) på hemsidan.

Genom att spåra sidvisningar kan teamet analysera vilka sidor som får flest uppmärksamhet från användarna. Dessutom ger spårning av CTA-klickningar på hemsidan värdefulla insikter om hur effektivt teamets call-to-action-element är. Dessa data kan visa vilka CTA:er som är intressanta för användarna, vilka som behöver justeras, och de kan upptäcka nya möjligheter att öka användarengagemanget och driva konverteringar.


>[!VIDEO](https://video.tv.adobe.com/v/3419872?quality=12&learn=on)

## Förutsättningar

Följande krävs vid integrering av Adobe Analytics med Platform Web SDK.

Du har slutfört konfigurationsstegen från självstudiekursen **[Integrera Experience Platform Web SDK](./web-sdk.md)**.

I **AEM som Cloud Service**:

+ [AEM Administratörsåtkomst till AEM as a Cloud Service-miljö](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/accessing/overview.html?lang=sv-SE)
+ Tillgång till Cloud Manager för Distributionshanteraren
+ Klona och distribuera [WKND - exempelprojektet för Adobe Experience Manager](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) till din AEM as a Cloud Service-miljö.

I **Adobe Analytics**:

+ Åtkomst att skapa **rapportsviten**
+ Åtkomst att skapa **Analysis Workspace**

I **Experience Platform**:

+ Åtkomst till standardproduktionen, **Prod**-sandlådan.
+ Åtkomst till **scheman** under datahantering
+ Åtkomst till **datauppsättningar** under Datahantering
+ Åtkomst till **datastreams** under datainsamling
+ Åtkomst till **taggar** under datainsamling

Om du inte har nödvändiga behörigheter kan systemadministratören som använder [Adobe Admin Console](https://adminconsole.adobe.com/) bevilja nödvändiga behörigheter.

Innan vi börjar med integreringsprocessen för AEM och Analytics med Platform Web SDK kan vi _ta en titt på de viktigaste komponenterna och nyckelelementen_ som introducerades i självstudiekursen [Integrate Experience Platform Web SDK](./web-sdk.md) . Den utgör en stabil grund för integreringen.

>[!VIDEO](https://video.tv.adobe.com/v/3419873?quality=12&learn=on)

När vi har fått en sammanfattning av XDM-schemat, Datastream, Dataset, Tag-egenskapen och, AEM och taggegenskapsanslutningen, går vi vidare med integreringsresan.

## Definiera dokument för SDR (Analytics Solution Design Reference)

Som en del av implementeringsprocessen rekommenderar vi att du skapar ett SDR-dokument (Solution Design Reference). Det här dokumentet spelar en viktig roll som en plan för att definiera affärskrav och utforma effektiva strategier för datainsamling.

SDR-dokumentet ger en omfattande översikt över implementeringsplanen och säkerställer att alla intressenter är samordnade och förstår projektets mål och omfattning.


>[!VIDEO](https://video.tv.adobe.com/v/3419874?quality=12&learn=on)

Mer information om koncept och olika element som ska inkluderas i SDR-dokumentet finns i [Skapa och underhåll ett SDR-dokument](https://experienceleague.adobe.com/docs/analytics-learn/tutorials/implementation/implementation-basics/creating-and-maintaining-an-sdr.html?lang=sv-SE). Du kan också hämta en Excel-exempelmall, men den WKND-specifika versionen är också tillgänglig [här](./assets/Initial-WKND-WebSDK-BRD-SDR.xlsx).

## Ställ in Analytics - report suite, Analysis Workspace

Det första steget är att konfigurera Adobe Analytics, särskilt att rapportera programpaket med konverteringsvariabler (eller eVar) och framgångshändelser. Konverteringsvariablerna används för att mäta orsak och effekt. Framgångshändelserna används för att spåra åtgärder.

I den här självstudiekursen används `eVar5, eVar6, and eVar7` för att spåra _WKND-sidnamn, WKND-CTA-id och WKND-CTA-namn_ och `event7` för att spåra _WKND CTA Click Event_.

För att analysera, samla in insikter och dela dessa insikter med andra från insamlade data skapas ett projekt i Analysis Workspace.

>[!VIDEO](https://video.tv.adobe.com/v/3419875?quality=12&learn=on)

Om du vill veta mer om konfiguration och koncept för Analytics rekommenderar vi följande resurser:

+ [Report Suite](https://experienceleague.adobe.com/docs/analytics/admin/admin-tools/manage-report-suites/c-new-report-suite/t-create-a-report-suite.html?lang=sv-SE)
+ [Konverteringsvariabler](https://experienceleague.adobe.com/docs/analytics/admin/admin-tools/manage-report-suites/edit-report-suite/conversion-variables/conversion-var-admin.html?lang=sv-SE)
+ [Slutförda händelser](https://experienceleague.adobe.com/sv/docs/analytics/admin/admin-tools/manage-report-suites/edit-report-suite/conversion-variables/success-event)
+ [Analysis Workspace](https://experienceleague.adobe.com/docs/analytics/analyze/analysis-workspace/home.html?lang=sv-SE)

## Uppdatera dataström - lägg till analystjänst

En dataström instruerar Platform Edge Network var insamlade data ska skickas. I den [tidigare självstudiekursen](./web-sdk.md) har en dataström konfigurerats för att skicka data till Experience Platform. Datastream uppdateras för att skicka data till analysrapportsviten som konfigurerades i steget [ovan](#setup-analytics---report-suite-analysis-workspace).

>[!VIDEO](https://video.tv.adobe.com/v/3419876?quality=12&learn=on)

## Skapa XDM-schema

XDM-schemat (Experience Data Model) hjälper er att standardisera insamlade data. I den [tidigare självstudiekursen](./web-sdk.md) skapas ett XDM-schema med `AEP Web SDK ExperienceEvent` en fältgrupp. Med det här XDM-schemat skapas dessutom en datauppsättning för lagring av insamlade data i Experience Platform.

Det XDM-schemat har dock inte Adobe Analytics-specifika fältgrupper för att skicka händelsedata till eVar. Ett nytt XDM-schema skapas i stället för att det befintliga schemat uppdateras för att undvika att eVar, händelsedata i plattformen, lagras.

Det nya XDM-schemat har `AEP Web SDK ExperienceEvent` och `Adobe Analytics ExperienceEvent Full Extension` fältgrupper.

>[!VIDEO](https://video.tv.adobe.com/v/3419877?quality=12&learn=on)


## Egenskapen Uppdatera tagg

I den [tidigare självstudiekursen](./web-sdk.md) skapas en taggegenskap med dataelement och en regel för att samla in, mappa och skicka sidvisningsdata. Den måste förbättras för:

+ Mappar sidnamnet till `eVar5`
+ Startar analysanropet **pageview** ( eller skicka signal)
+ Samla in CTA-data med Adobe klientdatalager
+ Mappar CTA-ID och namn till `eVar6` respektive `eVar7`. Dessutom räknas CTA-klickningar till `event7`
+ Startar **link click**-analysanropet ( eller skicka beacon)


>[!VIDEO](https://video.tv.adobe.com/v/3419882?quality=12&learn=on)

>[!TIP]
>
>Data Element- och Rule-Event-koden som visas i videon är tillgänglig för din referens. **Expandera dragspelselementet nedan**. Om du emellertid INTE använder Adobe Client Data Layer måste du ändra nedanstående kod, men begreppet att definiera dataelementen och använda dem i regeldefinitionen gäller fortfarande.

+++ Dataelement och regelhändelsekod

+ `Component ID`-dataelementkoden.

  ```javascript
  if(event && event.path && event.path.includes('.')) {    
      // split on the `.` to return just the component ID for e.g. button-06bc532b85, tabs-bb27f4f426-item-cc9c2e6718
      return event.path.split('.')[1];
  }else {
      //return dummy ID
      return "WKND-CTA-ID";
  }
  ```

+ `Component Name`-dataelementkoden.

  ```javascript
  if(event && event.component && event.component.hasOwnProperty('dc:title')) {
      // Return the Button, Link, Image, Tab name, for e.g. View Trips, Full Article, See Trips
      return event.component['dc:title'];
  }else {
      //return dummy ID
      return "WKND-CTA-Name";    
  }    
  ```

+ Koden `all pages - on load` **Regelvillkor**

  ```javascript
  if(event && event.component && event.component.hasOwnProperty('@type') && event.component.hasOwnProperty('xdm:template')) {
      return true;
  }else{
      return false;
  }    
  ```

+ Koden `home page - cta click` **Rule-Event**

  ```javascript
  var componentClickedHandler = function(evt) {
  // defensive coding to avoid a null pointer exception
  if(evt.hasOwnProperty("eventInfo") && evt.eventInfo.hasOwnProperty("path")) {
      //trigger Tag Rule and pass event
      console.log("cmp:click event: " + evt.eventInfo.path);
  
      var event = {
          //include the path of the component that triggered the event
          path: evt.eventInfo.path,
          //get the state of the component that triggered the event
          component: window.adobeDataLayer.getState(evt.eventInfo.path)
      };
  
      //Trigger the Tag Rule, passing in the new `event` object
      // the `event` obj can now be referenced by the reserved name `event` by other Tag Property data elements
      // i.e `event.component['someKey']`
      trigger(event);
  }
  }
  
  //set the namespace to avoid a potential race condition
  window.adobeDataLayer = window.adobeDataLayer || [];
  //push the event listener for cmp:click into the data layer
  window.adobeDataLayer.push(function (dl) {
  //add event listener for `cmp:click` and callback to the `componentClickedHandler` function
  dl.addEventListener("cmp:click", componentClickedHandler);
  });    
  ```

+ Koden `home page - cta click` **Regelvillkor**

  ```javascript
  if(event && event.component && event.component.hasOwnProperty('@type')) {
      //Check for Button Type OR Teaser CTA type
      if(event.component['@type'] === 'wknd/components/button' ||
      event.component['@type'] === 'wknd/components/teaser/cta') {
          return true;
      }
  }
  
  // none of the conditions are met, return false
  return false;    
  ```

+++

Mer information om hur du integrerar AEM Core Components med Adobe Client Data Layer finns i [Using the Adobe Client Data Layer with AEM Core Components guide](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/adobe-client-data-layer/data-layer-overview.html?lang=sv-SE).


>[!INFO]
>
>Om du vill ha en mer heltäckande bild av informationen om egenskapen **Variabel karta** i dokumentet Solution Design Reference (SDR) kan du hämta den färdiga WKND-specifika versionen [här](./assets/Final-WKND-WebSDK-BRD-SDR.xlsx).



## Verifiera uppdaterad taggegenskap på WKND

För att säkerställa att den uppdaterade taggegenskapen byggs, publiceras och fungerar korrekt på WKND-webbplatsens sidor. Använd [Adobe Experience Platform Debugger-tillägget](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob) i Google Chrome webbläsare:

+ Kontrollera byggdatumet för att se till att taggegenskapen är den senaste versionen.

+ Om du vill verifiera XDM-händelsedata för både PageView och HomePage CTA Click använder du menyalternativet Experience Platform Web SDK i tillägget.

>[!VIDEO](https://video.tv.adobe.com/v/3419883?quality=12&learn=on)

## Simulera webbtrafik - Selenium automation

För att generera en meningsfull mängd trafik för testningsändamål utvecklas ett Selenium automation-skript. Det här anpassade skriptet simulerar användarinteraktion med WKND-webbplatsen, som sidvy, och klickning på CTA.

>[!VIDEO](https://video.tv.adobe.com/v/3419884?quality=12&learn=on)

## Datauppsättningsverifiering - WKND-sidvy, CTA-data

Datauppsättningen är en lagrings- och hanteringskonstruktion för en samling data, som en databastabell som följer ett schema. Den datauppsättning som skapades i den [föregående självstudiekursen](./web-sdk.md) återanvänds för att verifiera att sidvyn och CTA klickdata är inkapslade i Experience Platform datauppsättning. I datauppsättningens användargränssnitt visas olika detaljer, t.ex. totala poster, storlek och inkapslade batchar, tillsammans med ett visuellt tilltalande stapeldiagram.

>[!VIDEO](https://video.tv.adobe.com/v/3419885?quality=12&learn=on)

## Analyser - WKND-sidvy, CTA datavisualisering

Analysis Workspace är ett kraftfullt verktyg i Adobe Analytics som gör det möjligt att utforska och visualisera data på ett flexibelt och interaktivt sätt. Det har ett dra-och-släpp-gränssnitt för att skapa anpassade rapporter, utföra avancerad segmentering och tillämpa olika datavisualiseringar.

Vi öppnar Analysis Workspace-projektet som skapats i steget [Setup Analytics](#setup-analytics---report-suite-analysis-workspace) igen. I avsnittet **Toppsidor** kan du granska olika mätvärden, som besök, unika besökare, poster, studsfrekvens och mycket annat. Dra och släpp WKND-specifika mått (WKND Page Name, WKND CTA Name) och mätvärden (WKND CTA Click Event) för att utvärdera WKND-sidornas och hemsidans prestanda. Dessa insikter är värdefulla för marknadsförarna för att förstå vilka CTA-avtal som är mer effektiva och fatta datadrivna beslut i linje med deras affärsmål.

Om du vill visualisera användarresor använder du Flödesvisualisering, med början från **WKND-sidnamnet** och sedan expanderar till olika sökvägar.

>[!VIDEO](https://video.tv.adobe.com/v/3419886?quality=12&learn=on)

## Sammanfattning

Snyggt jobb! Du har slutfört installationen av AEM och Adobe Analytics med Platform Web SDK för att samla in, analysera sidvyn och CTA klickdata.

Implementering av Adobe Analytics är avgörande för att marknadsföringsteamen ska få insikter i användarbeteenden, fatta välgrundade beslut, så att de kan optimera sitt innehåll och fatta datadrivna beslut.

Genom att implementera de rekommenderade stegen och använda de tillhandahållna resurserna, t.ex. dokumentet Solution Design Reference (SDR) och förstå viktiga Analytics-koncept, kan marknadsförarna effektivt samla in och analysera data.

>[!VIDEO](https://video.tv.adobe.com/v/3419888?quality=12&learn=on)


>[!AVAILABILITY]
>
>Om du föredrar den **kompletta videon** som täcker hela integrationsprocessen i stället för enskilda installationsstegsvideor kan du klicka [här](https://video.tv.adobe.com/v/3419889/) för att komma åt den.


## Ytterligare resurser

+ [Integrera Experience Platform Web SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform/web-sdk.html?lang=sv-SE)
+ [Använda Adobe-klientdatalagret med kärnkomponenterna](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/adobe-client-data-layer/data-layer-overview.html?lang=sv-SE)
+ [Integrerar Experience Platform-datainsamlingstaggar och AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-data-collection-tags/overview.html?lang=sv-SE)
+ [Adobe Experience Platform Web SDK och Edge Network - översikt](https://experienceleague.adobe.com/docs/platform-learn/data-collection/web-sdk/overview.html?lang=sv-SE)
+ [Självstudiekurser för datainsamling](https://experienceleague.adobe.com/docs/platform-learn/data-collection/overview.html?lang=sv-SE)
+ [Adobe Experience Platform Debugger - översikt](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html?lang=sv-SE)
