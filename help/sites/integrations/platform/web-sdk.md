---
title: Integrera Experience Platform Web SDK
description: Lär dig hur du integrerar AEM as a Cloud Service med Experience Platform Web SDK. Detta grundläggande steg är avgörande för att integrera Adobe Experience Cloud-produkter som Adobe Analytics, Target eller nyligen lanserade innovativa produkter som Real-time Customer Data Platform, Customer Journey Analytics och Journey Optimizer.
version: Cloud Service
feature: Integrations
topic: Integrations, Architecture
role: Admin, Architect, Data Architect, Developer
level: Beginner, Intermediate
doc-type: Tutorial
last-substantial-update: 2023-04-26T00:00:00Z
jira: KT-13156
thumbnail: KT-13156.jpeg
source-git-commit: 3f129fb4fc53e55d118802d3a0e566a9a9bcb9a2
workflow-type: tm+mt
source-wordcount: '1153'
ht-degree: 0%

---


# Integrera Experience Platform Web SDK

Lär dig integrera AEM as a Cloud Service med Experience Platform [Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/home.html). Detta grundläggande steg är avgörande för att integrera Adobe Experience Cloud-produkter som Adobe Analytics, Target eller nyligen lanserade innovativa produkter som Real-time Customer Data Platform, Customer Journey Analytics och Journey Optimizer.

Du får även lära dig hur du samlar in och skickar [WKND - exempel på Adobe Experience Manager-projekt](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) sidvisningsdata i [Experience Platform](https://experienceleague.adobe.com/docs/experience-platform/landing/home.html).

När du är klar med den här konfigurationen kan du gå vidare till att implementera Experience Platform och relaterade program som [Real-time Customer Data Platform (Real-Time CDP)](https://experienceleague.adobe.com/docs/experience-platform/rtcdp/overview.html), [Customer Journey Analytics (CJA)](https://experienceleague.adobe.com/docs/customer-journey-analytics.html) och [Adobe Journey Optimizer (AJO)](https://experienceleague.adobe.com/docs/journey-optimizer.html). Att öka kundengagemanget genom att standardisera webb- och kunddata.

## Förutsättningar

Följande krävs vid integrering av Experience Platform Web SDK.

I **AEM som Cloud Service**:

+ AEM administratörsåtkomst till AEM as a Cloud Service miljö
+ Åtkomst till Cloud Manager för Distributionshanteraren
+ Klona och distribuera [WKND - exempel på Adobe Experience Manager-projekt](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) i AEM as a Cloud Service miljö.

I **Experience Platform**:

+ Tillgång till standardproduktionen **Prod** sandlåda.
+ Åtkomst till **Scheman** under Datahantering
+ Åtkomst till **Datauppsättningar** under Datahantering
+ Åtkomst till **Datastreams** under Datainsamling
+ Åtkomst till **Taggar** (tidigare Launch) under Datainsamling

Om du inte har nödvändig behörighet använder systemadministratören [Adobe Admin Console](https://adminconsole.adobe.com/) kan ge nödvändiga behörigheter.

>[!VIDEO](https://video.tv.adobe.com/v/3418856?quality=12&learn=on)

## Skapa XDM-schema - Experience Platform

XDM-schemat (Experience Data Model) hjälper er att standardisera kundupplevelsedata. För att samla in **WKND-sidvy** data, skapa ett XDM-schema och använda fältgrupper som tillhandahålls av Adobe `AEP Web SDK ExperienceEvent` för insamling av webbdata.


>[!VIDEO](https://video.tv.adobe.com/v/3418894?quality=12&learn=on)

Lär dig mer om XDM-schema och relaterade koncept som fältgrupper, typer, klasser och datatyper från [XDM - systemöversikt](https://experienceleague.adobe.com/docs/experience-platform/xdm/home.html).

The [XDM - systemöversikt](https://experienceleague.adobe.com/docs/experience-platform/xdm/home.html) är en bra resurs att lära sig om XDM-schema och relaterade koncept som fältgrupper, typer, klasser och datatyper. Det ger en omfattande förståelse för XDM-datamodellen och hur man skapar och hanterar XDM-scheman för att standardisera data i hela företaget. Utforska den för att få en djupare förståelse för XDM-schemat och hur det kan hjälpa er med datainsamling och datahantering.

## Skapa DataStream - Experience Platform

En DataStream instruerar Platform Edge Network var insamlade data ska skickas. Den kan till exempel skickas till Experience Platform, Analytics eller Adobe Target.


>[!VIDEO](https://video.tv.adobe.com/v/3418895?quality=12&learn=on)

Bekanta dig med begreppet Datastreams och relaterade ämnen som datastyrning och konfiguration genom att besöka [Översikt över datastreams](https://experienceleague.adobe.com/docs/experience-platform/edge/datastreams/overview.html) sida.

## Skapa tagg, egenskap - Experience Platform

Lär dig hur du skapar en taggegenskap (tidigare kallad Launch) i Experience Platform för att lägga till JavaScript-biblioteket för Web SDK på WKND-webbplatsen. Den nyligen definierade taggegenskapen har följande resurser:

+ Taggtillägg: [Core](https://exchange.adobe.com/apps/ec/100223/adobe-launch-core-extension) och [Adobe Experience Platform Web SDK](https://exchange.adobe.com/apps/ec/106387/aep-web-sdk)
+ Dataelement: Data-element av anpassad kodtyp som extraherar sidnamn, webbplatsavsnitt och värdnamn med WKND-platsens Adobe-klientdatalager. XDM-objektets datatypselement som överensstämmer med det nya WKND XDM-schemabygget som skapades tidigare [Skapa XDM-schema](#create-xdm-schema---experience-platform) steg.
+ Regel: Skicka data till plattforms-Edge-nätverket när en WKND-webbsida besöks med hjälp av Adobe-klientdatalagret som utlöses `cmp:show` -händelse.


>[!VIDEO](https://video.tv.adobe.com/v/3418896?quality=12&learn=on)


+++ Dataelement och regelhändelsekod

+ The `Page Name` Dataelementkod.

   ```javascript
   if(event && event.component && event.component.hasOwnProperty('dc:title')) {
       // return value of 'dc:title' from the data layer Page object, which is propogated via 'cmp:show` event
       return event.component['dc:title'];
   }
   ```

+ The `Site Section` Dataelementkod.

   ```javascript
   if(event && event.component && event.component.hasOwnProperty('repo:path')) {
   let pagePath = event.component['repo:path'];
   
   let siteSection = '';
   
   //Check of html String in URL.
   if (pagePath.indexOf('.html') > -1) { 
    siteSection = pagePath.substring(0, pagePath.lastIndexOf('.html'));
   
    //replace slash with colon
    siteSection = siteSection.replaceAll('/', ':');
   
    //remove `:content`
    siteSection = siteSection.replaceAll(':content:','');
   }
   
       return siteSection 
   }
   ```

+ The `Host Name` Dataelementkod.

   ```javascript
   if(window && window.location && window.location.hostname) {
       return window.location.hostname;
   }
   ```

+ The `all pages - on load` Regelhändelsekod

   ```javascript
   var pageShownEventHandler = function(evt) {
   // defensive coding to avoid a null pointer exception
   if(evt.hasOwnProperty("eventInfo") && evt.eventInfo.hasOwnProperty("path")) {
       //trigger Launch Rule and pass event
       console.debug("cmp:show event: " + evt.eventInfo.path);
       var event = {
           //include the path of the component that triggered the event
           path: evt.eventInfo.path,
           //get the state of the component that triggered the event
           component: window.adobeDataLayer.getState(evt.eventInfo.path)
       };
   
       //Trigger the Launch Rule, passing in the new 'event' object
       // the 'event' obj can now be referenced by the reserved name 'event' by other Launch data elements
       // i.e 'event.component['someKey']'
       trigger(event);
       }
   }
   
   //set the namespace to avoid a potential race condition
   window.adobeDataLayer = window.adobeDataLayer || [];
   
   //push the event listener for cmp:show into the data layer
   window.adobeDataLayer.push(function (dl) {
       //add event listener for 'cmp:show' and callback to the 'pageShownEventHandler' function
       dl.addEventListener("cmp:show", pageShownEventHandler);
   });
   ```

+++


The [Översikt över taggar](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html) ger ingående kunskap om viktiga begrepp som dataelement, regler och tillägg.

Mer information om hur du integrerar AEM med Adobe Client Data Layer finns i [Använda Adobe Client Data Layer med AEM Core Components Guide](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/adobe-client-data-layer/data-layer-overview.html).

## Koppla tagg-egenskap till AEM

Lär dig länka den nyligen skapade taggegenskapen till AEM via Adobe IMS och Adobe Launch Configuration i AEM. När en AEM as a Cloud Service miljö är etablerad genereras flera Adobe IMS-konfigurationer av det tekniska kontot automatiskt, inklusive Adobe Launch. För AEM 6.5 måste du dock konfigurera en manuellt.

När du har länkat taggegenskapen kan WKND-webbplatsen läsa in taggegenskapens JavaScript-bibliotek på webbsidorna med molntjänstkonfigurationen för Adobe Launch.

### Verifiera inläsning av taggegenskap på WKND

Använda Adobe Experience Platform Debugger [Krom](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob) eller [Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/) kontrollerar du om taggegenskapen läses in på WKND-sidor. Du kan verifiera,

+ Taggegenskapsinformation som tillägg, version, namn med mera.
+ Plattforms-SDK-biblioteksversion, DataStream ID
+ XDM-objekt som del `events` attribut i Experience Platform Web SDK

>[!VIDEO](https://video.tv.adobe.com/v/3418897?quality=12&learn=on)

## Skapa datauppsättning - Experience Platform

De sidvisningsdata som samlas in med Web SDK lagras som datauppsättningar i Experience Platform. Datauppsättningen är en lagrings- och hanteringskonstruktion för en samling data, som en databastabell som följer ett schema. Lär dig hur du skapar en datauppsättning och konfigurerar den tidigare skapade datauppsättningen för att skicka data till Experience Platform.


>[!VIDEO](https://video.tv.adobe.com/v/3418898?quality=12&learn=on)

The [Översikt över datauppsättningar](https://experienceleague.adobe.com/docs/experience-platform/catalog/datasets/overview.html) ger mer information om koncept, konfigurationer och andra funktioner för konsumtion.


## WKND-sidvisningsdata i Experience Platform

Efter installationen av Web SDK med AEM, särskilt på WKND-webbplatsen, är det dags att generera trafik genom att navigera på webbplatssidorna. Bekräfta sedan att sidvisningsdata hämtas till datauppsättningen Experience Platform. I datauppsättningens användargränssnitt visas olika detaljer, t.ex. totala poster, storlek och inkapslade batchar, tillsammans med ett visuellt tilltalande stapeldiagram.

>[!VIDEO](https://video.tv.adobe.com/v/3418899?quality=12&learn=on)


## Sammanfattning

Bra jobbat! Du har slutfört konfigurationen av AEM med Adobe Experience Platform (Experience Platform) Web SDK för att samla in och importera data från en webbplats. Med denna grund kan ni nu utforska fler möjligheter att förbättra och integrera produkter som Analytics, Target, Customer Journey Analytics (CJA) och många andra för att skapa innehållsrika, personaliserade upplevelser för era kunder. Fortsätt lära dig och utforska Adobe Experience Cloud fulla potential.

>[!VIDEO](https://video.tv.adobe.com/v/3418900?quality=12&learn=on)

## Ytterligare resurser

+ [Använda Adobe-klientdatalagret med kärnkomponenterna](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/adobe-client-data-layer/data-layer-overview.html)
+ [Integrera taggar och AEM för datainsamling från Experience Platform](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-data-collection-tags/overview.html)
+ [Adobe Experience Platform Web SDK och Edge Network - översikt](https://experienceleague.adobe.com/docs/platform-learn/data-collection/web-sdk/overview.html)
+ [Självstudiekurser om datainsamling](https://experienceleague.adobe.com/docs/platform-learn/data-collection/overview.html)
+ [Adobe Experience Platform Debugger - översikt](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html)

