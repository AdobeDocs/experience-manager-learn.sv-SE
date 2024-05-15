---
title: Utveckla resursstatus i AEM Sites
description: Adobe Experience Manager resursstatus-API:er är ett anslutningsbart ramverk för att visa statusmeddelanden AEM olika redigeringswebbgränssnitt.
doc-type: Tutorial
version: 6.4, 6.5
duration: 88
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '410'
ht-degree: 0%

---


# Utveckla resursstatus {#developing-resource-statuses-in-aem-sites}

Adobe Experience Manager resursstatus-API:er är ett anslutningsbart ramverk för att visa statusmeddelanden AEM olika redigeringswebbgränssnitt.

## Ökning {#overview}

Resursstatus för redigeringsramverket innehåller API:er på serversidan och klientsidan för att visa och interagera med redigeringsstatus på ett standardiserat och enhetligt sätt.

Statusfälten för redigeraren är inbyggda i redigerarna Sida, Upplevelsefragment och Mall i AEM.

Exempel på användningsexempel för anpassade resursstatusprovidrar är:

* Meddela författare när en sida är inom två timmar efter den schemalagda aktiveringen
* Meddela författare om att en sida har aktiverats under de senaste 15 minuterna
* Meddela författare om att en sida har redigerats inom de senaste fem minuterna och av vem

![Översikt över resursstatus för AEM](assets/sample-editor-resource-status-screenshot.png)

## Ramverk för resursstatusprovider {#resource-status-provider-framework}

När du utvecklar anpassade resursstatusar består utvecklingsarbetet av:

1. Implementeringen av ResourceStatusProvider, som avgör om en status krävs, och grundläggande information om status: titel, meddelande, prioritet, variant, ikon och tillgängliga åtgärder.
2. GraniteUI JavaScript som implementerar funktionaliteten för alla tillgängliga åtgärder kan också användas.

   ![resursstatusarkitektur](assets/sample-editor-resource-status-application-architecture.png)

3. Statusresursen som tillhandahålls som en del av redigerarna för sidan, Experience Fragment och Template ges en typ via resurserna &quot;[!DNL statusType]&quot;.

   * Sidredigerare: `editor`
   * Experience Fragment editor: `editor`
   * Mallredigerare: `template-editor`

4. Statusresursens `statusType` matchas till registrerad `CompositeStatusType` OSGi har konfigurerats `name` -egenskap.

   För alla matchningar visas `CompositeStatusType's` typerna samlas in och används för att samla in `ResourceStatusProvider` implementeringar som har den här typen, via `ResourceStatusProvider.getType()`.

5. Matchningen `ResourceStatusProvider` har skickats `resource` i redigeraren och avgör om `resource` har status som ska visas. Om status krävs ansvarar den här implementeringen för att skapa 0 eller många `ResourceStatuses` för att returnera, där var och en representerar en status som ska visas.

   Oftast är `ResourceStatusProvider` returnerar 0 eller 1 `ResourceStatus` per `resource`.

6. ResourceStatus är ett gränssnitt som kan implementeras av kunden eller det praktiska `com.day.cq.wcm.commons.status.EditorResourceStatus.Builder` kan användas för att konstruera en status. En status består av:

   * Titel
   * Meddelande
   * Ikon
   * Variant
   * Prioritet
   * Åtgärder
   * Data

7. Alternativt, om `Actions` finns för `ResourceStatus` -objekt, det krävs stödklienter för att binda funktioner till åtgärdslänkarna i statusfältet.

   ```js
   (function(jQuery, document) {
       'use strict';
   
       $(document).on('click', '.editor-StatusBar-action[data-status-action-id="do-something"]', function () {
           // Do something on the click of the resource status action
   
       });
   })(jQuery, document);
   ```

8. Alla JavaScript- och CSS-funktioner som stöder åtgärderna måste proxideras genom varje redigerares respektive klientbibliotek för att se till att koden finns tillgänglig i redigeraren.

   * Sidredigeringskategori: `cq.authoring.editor.sites.page`
   * Experience Fragment editor-kategori: `cq.authoring.editor.sites.page`
   * Mallredigerarkategori: `cq.authoring.editor.sites.template`

## Visa koden {#view-the-code}

[Se kod på GitHub](https://github.com/Adobe-Consulting-Services/acs-aem-samples/tree/master/bundle/src/main/java/com/adobe/acs/samples/resourcestatus/impl/SampleEditorResourceStatusProvider.java)

## Ytterligare resurser {#additional-resources}

* [`com.adobe.granite.resourcestatus` JavaDocs](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/resourcestatus/package-summary.html)
* [`com.day.cq.wcm.commons.status.EditorResourceStatus` JavaDocs](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/wcm/commons/status/EditorResourceStatus.html)
