---
title: Integrera AEM Sites och Experience Platform Web SDK
description: Lär dig hur du integrerar AEM Sites as a Cloud Service med Experience Platform Web SDK. Detta grundläggande steg är avgörande för att integrera Adobe Experience Cloud-produkter som Adobe Analytics, Target eller nyligen lanserade innovativa produkter som Real-Time Customer Data Platform, Customer Journey Analytics och Journey Optimizer.
version: Experience Manager as a Cloud Service
feature: Integrations
topic: Integrations, Architecture
role: Admin, Architect, Data Architect, Developer
level: Beginner, Intermediate
doc-type: Tutorial
last-substantial-update: 2023-04-26T00:00:00Z
jira: KT-13156
thumbnail: KT-13156.jpeg
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service" before-title="false"
exl-id: 47df99e6-6418-43c8-96fe-85e3c47034d6
duration: 1303
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1248'
ht-degree: 0%

---

# Integrera AEM Sites och Experience Platform Web SDK

Lär dig integrera AEM as a Cloud Service med Experience Platform [Web SDK](https://experienceleague.adobe.com/docs/experience-platform/web-sdk/home.html). Detta grundläggande steg är avgörande för att integrera Adobe Experience Cloud-produkter som Adobe Analytics, Target eller nyligen lanserade innovativa produkter som Real-Time Customer Data Platform, Customer Journey Analytics och Journey Optimizer.

Du får också lära dig att samla in och skicka [WKND - exempel på Adobe Experience Manager-projekt](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) sidvisningsdata i [Experience Platform](https://experienceleague.adobe.com/en/docs/experience-platform/landing/home).

När du är klar med konfigurationen har du implementerat en stabil grund. Du kan dessutom gå vidare med implementeringen av Experience Platform med program som [Real-Time Customer Data Platform (Real-Time CDP)](https://experienceleague.adobe.com/docs/experience-platform/rtcdp/intro/rtcdp-intro/overview.html), [Customer Journey Analytics (CJA)](https://experienceleague.adobe.com/en/docs/customer-journey-analytics) och [Adobe Journey Optimizer (AJO)](https://experienceleague.adobe.com/en/docs/journey-optimizer). Den avancerade implementeringen bidrar till att öka kundengagemanget genom att standardisera webb- och kunddata.

## Förutsättningar

Följande krävs vid integrering av Experience Platform Web SDK.

I **AEM som Cloud Service**:

+ AEM Administrator-åtkomst till AEM as a Cloud Service-miljön
+ Tillgång till Cloud Manager för Distributionshanteraren
+ Klona och distribuera [WKND - exempelprojektet för Adobe Experience Manager](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) till din AEM as a Cloud Service-miljö.

I **Experience Platform**:

+ Åtkomst till standardproduktionen, **Prod**-sandlådan.
+ Åtkomst till **scheman** under datahantering
+ Åtkomst till **datauppsättningar** under Datahantering
+ Åtkomst till **datastreams** under datainsamling
+ Åtkomst till **taggar** under datainsamling

Om du inte har de behörigheter som krävs kan systemadministratören som använder [Adobe Admin Console](https://adminconsole.adobe.com/) bevilja de behörigheter som krävs.

>[!VIDEO](https://video.tv.adobe.com/v/3418856?quality=12&learn=on)

## Skapa XDM-schema - Experience Platform

XDM-schemat (Experience Data Model) hjälper er att standardisera kundupplevelsedata. Om du vill samla in **WKND-sidvisningsdata** skapar du ett XDM-schema och använder de fältgrupper som tillhandahålls av Adobe `AEP Web SDK ExperienceEvent` för webbdatainsamling.

Det finns generiska och specifika branscher, till exempel Retail, Financial Services, Healthcare med flera, en serie referensdatamodeller. Mer information finns i [Översikt över branschdatamodeller](https://experienceleague.adobe.com/en/docs/experience-platform/xdm/schema/industries/overview).


>[!VIDEO](https://video.tv.adobe.com/v/3418894?quality=12&learn=on)

Läs mer om XDM-schema och relaterade koncept som fältgrupper, typer, klasser och datatyper i [XDM-systemöversikt](https://experienceleague.adobe.com/en/docs/experience-platform/xdm/home).

[XDM-systemöversikten](https://experienceleague.adobe.com/en/docs/experience-platform/xdm/home) är en bra resurs för att lära sig mer om XDM-schema och relaterade begrepp som fältgrupper, typer, klasser och datatyper. Det ger en omfattande förståelse för XDM-datamodellen och hur man skapar och hanterar XDM-scheman för att standardisera data i hela företaget. Utforska den för att få en djupare förståelse för XDM-schemat och hur det kan hjälpa er med datainsamling och datahantering.

## Skapa dataström - Experience Platform

En dataström instruerar Platform Edge Network var insamlade data ska skickas. Den kan till exempel skickas till Experience Platform, Analytics eller Adobe Target.


>[!VIDEO](https://video.tv.adobe.com/v/3418895?quality=12&learn=on)

Bekanta dig med begreppet Datastreams och relaterade ämnen som datastyrning och konfiguration genom att gå till [sidan Översikt över datastreams](https://experienceleague.adobe.com/docs/experience-platform/datastreams/overview.html).

## Create Tag property - Experience Platform

Lär dig hur du skapar en taggegenskap i Experience Platform för att lägga till Web SDK JavaScript-biblioteket på WKND-webbplatsen. Den nyligen definierade taggegenskapen har följande resurser:

+ Taggtillägg: [Core](https://exchange.adobe.com/apps/ec/100223/adobe-launch-core-extension) och [Adobe Experience Platform Web SDK](https://exchange.adobe.com/apps/ec/106387/aep-web-sdk)
+ Dataelement: Dataelement av anpassad kodtyp som extraherar sidnamn, webbplatsavsnitt och värdnamn med hjälp av WKND-platsens Adobe-klientdatalager. XDM-objekttypselementet som är kompatibelt med det nyligen skapade WKND XDM-schemainbyggda tidigare [Skapa XDM-schema](#create-xdm-schema---experience-platform) -steget.
+ Regel: Skicka data till Platform Edge Network när en WKND-webbsida besöktes med hjälp av Adobe Client Data Layer utlöste händelsen `cmp:show`.

När du skapar och publicerar taggbiblioteket med **publiceringsflödet** kan du använda knappen **Lägg till alla ändrade resurser** . Om du vill välja alla resurser som dataelement, regel och taggtillägg i stället för att identifiera och välja en enskild resurs. Under utvecklingsfasen kan du dessutom publicera biblioteket enbart i _utvecklingsmiljön_ och sedan verifiera och befordra det till _scenen_ eller _produktionen_ .

>[!VIDEO](https://video.tv.adobe.com/v/3418896?quality=12&learn=on)


>[!TIP]
>
>Data Element- och Rule-Event-koden som visas i videon är tillgänglig för din referens. **Expandera dragspelselementet nedan**. Om du emellertid INTE använder Adobe Client Data Layer måste du ändra nedanstående kod, men begreppet att definiera dataelementen och använda dem i regeldefinitionen gäller fortfarande.


+++ Dataelement och regelhändelsekod

+ `Page Name`-dataelementkoden.

  ```javascript
  if(event && event.component && event.component.hasOwnProperty('dc:title')) {
      // return value of 'dc:title' from the data layer Page object, which is propogated via 'cmp:show` event
      return event.component['dc:title'];
  }
  ```

+ `Site Section`-dataelementkoden.

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

+ `Host Name`-dataelementkoden.

  ```javascript
  if(window && window.location && window.location.hostname) {
      return window.location.hostname;
  }
  ```

+ Regelhändelsekoden `all pages - on load`

  ```javascript
  var pageShownEventHandler = function(evt) {
  // defensive coding to avoid a null pointer exception
  if(evt.hasOwnProperty("eventInfo") && evt.eventInfo.hasOwnProperty("path")) {
      // trigger tags Rule and pass event
      console.debug("cmp:show event: " + evt.eventInfo.path);
      var event = {
          // include the path of the component that triggered the event
          path: evt.eventInfo.path,
          // get the state of the component that triggered the event
          component: window.adobeDataLayer.getState(evt.eventInfo.path)
      };
  
      // Trigger the tags Rule, passing in the new 'event' object
      // the 'event' obj can now be referenced by the reserved name 'event' by other tags data elements
      // i.e 'event.component['someKey']'
      trigger(event);
      }
  }
  
  // set the namespace to avoid a potential race condition
  window.adobeDataLayer = window.adobeDataLayer || [];
  
  // push the event listener for cmp:show into the data layer
  window.adobeDataLayer.push(function (dl) {
      //add event listener for 'cmp:show' and callback to the 'pageShownEventHandler' function
      dl.addEventListener("cmp:show", pageShownEventHandler);
  });
  ```

+++


Översikten [Taggar](https://experienceleague.adobe.com/en/docs/experience-platform/tags/home) innehåller ingående information om viktiga begrepp som dataelement, regler och tillägg.

Mer information om hur du integrerar AEM Core Components med Adobe Client Data Layer finns i [Using the Adobe Client Data Layer with AEM Core Components guide](https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/integrations/adobe-client-data-layer/data-layer-overview).

## Ansluta taggegenskap till AEM

Lär dig hur du länkar den nyligen skapade taggegenskapen till AEM via Adobe IMS och taggar i Adobe Experience Platform Configuration i AEM. När en AEM as a Cloud Service-miljö är etablerad genereras automatiskt flera konfigurationer av Adobe IMS Technical Account, inklusive taggar. Stegvisa instruktioner finns i [Koppla AEM Sites med taggegenskap med IMS](https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/integrations/experience-platform-data-collection-tags/connect-aem-tag-property-using-ims).

För AEM 6.5 måste du dock konfigurera en manuellt.



När du har länkat taggegenskapen kan WKND-webbplatsen läsa in taggegenskapens JavaScript-bibliotek på webbsidorna med hjälp av taggarna i Adobe Experience Platform molntjänstkonfiguration.

### Verifiera inläsning av taggegenskap på WKND

Använd tillägget Adobe Experience Platform Debugger [Chrome](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob) och kontrollera om taggegenskapen läses in på WKND-sidor. Du kan verifiera,

+ Taggegenskapsinformation som tillägg, version, namn med mera.
+ Plattforms-SDK biblioteksversion, DataStream ID
+ XDM-objekt som del `events`-attribut i Experience Platform Web SDK

>[!VIDEO](https://video.tv.adobe.com/v/3418897?quality=12&learn=on)

## Skapa datauppsättning - Experience Platform

De sidvisningsdata som samlas in med Web SDK lagras i Experience Platform datasjön som datauppsättningar. Datauppsättningen är en lagrings- och hanteringskonstruktion för en samling data, som en databastabell som följer ett schema. Lär dig hur du skapar en datauppsättning och konfigurerar den tidigare skapade datauppsättningen för att skicka data till Experience Platform.


>[!VIDEO](https://video.tv.adobe.com/v/3418898?quality=12&learn=on)

[Översikt över datauppsättningar](https://experienceleague.adobe.com/en/docs/experience-platform/catalog/datasets/overview) innehåller mer information om begrepp, konfigurationer och andra inmatningsfunktioner.


## WKND-sidvisningsdata i Experience Platform

När Web SDK har byggts med AEM, särskilt på WKND-webbplatsen, är det dags att generera trafik genom att navigera på webbplatserna. Bekräfta sedan att sidvisningsdata hämtas till Experience Platform-datauppsättningen. I datauppsättningens användargränssnitt visas olika detaljer, t.ex. totala poster, storlek och inkapslade batchar, tillsammans med ett visuellt tilltalande stapeldiagram.

>[!VIDEO](https://video.tv.adobe.com/v/3418899?quality=12&learn=on)


## Sammanfattning

Snyggt jobb! Du har slutfört installationen av AEM med Experience Platform Web SDK för att samla in och importera data från en webbplats. Med denna grund kan ni nu utforska fler möjligheter att förbättra och integrera produkter som Analytics, Target, Customer Journey Analytics (CJA) och många andra för att skapa innehållsrika, personaliserade upplevelser för era kunder. Fortsätt lära dig och utforska Adobe Experience Cloud fulla potential.

>[!VIDEO](https://video.tv.adobe.com/v/3418900?quality=12&learn=on)


>[!AVAILABILITY]
>
>Om du föredrar den **kompletta videon** som täcker hela integrationsprocessen i stället för enskilda installationsstegsvideor kan du klicka [här](https://video.tv.adobe.com/v/3418905/) för att komma åt den.

## Ytterligare resurser

+ [Använda Adobe-klientdatalagret med kärnkomponenterna](https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/integrations/adobe-client-data-layer/data-layer-overview)
+ [Integrerar Experience Platform-datainsamlingstaggar och AEM](https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/integrations/experience-platform-data-collection-tags/overview)
+ [Adobe Experience Platform Web SDK och Edge Network - översikt](https://experienceleague.adobe.com/en/docs/platform-learn/data-collection/web-sdk/overview)
+ [Självstudiekurser för datainsamling](https://experienceleague.adobe.com/en/docs/platform-learn/data-collection/overview)
+ [Adobe Experience Platform Debugger - översikt](https://experienceleague.adobe.com/en/docs/platform-learn/data-collection/debugger/overview)
