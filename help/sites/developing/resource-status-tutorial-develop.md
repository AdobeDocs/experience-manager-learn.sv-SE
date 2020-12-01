---
title: Utveckla resursstatus i AEM Sites
description: 'Adobe Experience Manager resursstatus-API:er är ett anslutningsbart ramverk för att visa statusmeddelanden AEM olika redigeringswebbgränssnitt. '
topics: development
audience: developer
doc-type: tutorial
activity: develop
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 03db12de4d95ced8fabf36b8dc328581ec7a2749
workflow-type: tm+mt
source-wordcount: '446'
ht-degree: 1%

---


# Utvecklar resursstatus {#developing-resource-statuses-in-aem-sites}

Adobe Experience Manager resursstatus-API:er är ett anslutningsbart ramverk för att visa statusmeddelanden AEM olika redigeringswebbgränssnitt.

## Översikt {#overview}

Resursstatus för redigeringsramverket innehåller API:er på serversidan och klientsidan för att visa och interagera med redigeringsstatus på ett standardiserat och enhetligt sätt.

Statusfälten för redigeraren är inbyggda i redigerarna Sida, Upplevelsefragment och Mall i AEM.

Exempel på användningsexempel för anpassade resursstatusprovidrar är:

* Meddela författare när en sida är inom två timmar efter den schemalagda aktiveringen
* Meddela författare om att en sida har aktiverats under de senaste 15 minuterna
* Meddela författare om att en sida har redigerats inom de senaste fem minuterna och av vem

![Översikt över resursstatus för AEM](assets/sample-editor-resource-status-screenshot.png)

## Resursstatusproviderns ramverk {#resource-status-provider-framework}

När du utvecklar anpassade resursstatusar består utvecklingsarbetet av:

1. Implementeringen ResourceStatusProvider, som avgör om en status krävs, och grundläggande information om statusen: titel, meddelande, prioritet, variant, ikon och tillgängliga åtgärder.
2. GraniteUI JavaScript som implementerar funktionaliteten för alla tillgängliga åtgärder kan också användas.

   ![resursstatusarkitektur](assets/sample-editor-resource-status-application-architecture.png)

3. Statusresursen som tillhandahålls som en del av redigerarna för sidan, upplevelsefragment och mall får en typ via egenskapen [!DNL statusType] för resurserna.

   * Sidredigerare: `editor`
   * Experience Fragment editor: `editor`
   * Mallredigerare: `template-editor`

4. Statusresursens `statusType` matchar den registrerade egenskapen `CompositeStatusType` OSGi konfigurerad `name`.

   För alla matchningar samlas `CompositeStatusType's`-typerna in och används för att samla in `ResourceStatusProvider`-implementeringar som har den här typen, via `ResourceStatusProvider.getType()`.

5. Matchande `ResourceStatusProvider` skickas som `resource` i redigeraren och avgör om `resource` har status att visa. Om status krävs ansvarar den här implementeringen för att skapa 0 eller många `ResourceStatuses` som ska returneras, och var och en representerar en status som ska visas.

   Vanligtvis returnerar en `ResourceStatusProvider` 0 eller 1 `ResourceStatus` per `resource`.

6. ResourceStatus är ett gränssnitt som kan implementeras av kunden eller så kan hjälpmedlet `com.day.cq.wcm.commons.status.EditorResourceStatus.Builder` användas för att konstruera en status. En status består av:

   * Titel
   * Meddelande
   * Ikon
   * Variant
   * Prioritet
   * Åtgärder
   * Data

7. Om `Actions` anges för `ResourceStatus`-objektet krävs stödklienter för att binda funktioner till åtgärdslänkarna i statusfältet.

   ```js
   (function(jQuery, document) {
       'use strict';
   
       $(document).on('click', '.editor-StatusBar-action[data-status-action-id="do-something"]', function () {
           // Do something on the click of the resource status action
   
       });
   })(jQuery, document);
   ```

8. Alla JavaScript- och CSS-funktioner som stöder åtgärderna måste proxideras genom varje redigerares respektive klientbibliotek för att säkerställa att koden finns tillgänglig i redigeraren.

   * Sidredigeringskategori: `cq.authoring.editor.sites.page`
   * Experience Fragment editor-kategori: `cq.authoring.editor.sites.page`
   * Mallredigerarkategori: `cq.authoring.editor.sites.template`

## Visa koden {#view-the-code}

[Se kod på GitHub](https://github.com/Adobe-Consulting-Services/acs-aem-samples/tree/master/bundle/src/main/java/com/adobe/acs/samples/resourcestatus/impl/SampleEditorResourceStatusProvider.java)

## Ytterligare resurser {#additional-resources}

* [`com.adobe.granite.resourcestatus` JavaDocs](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/resourcestatus/package-summary.html)
* [`com.day.cq.wcm.commons.status.EditorResourceStatus` JavaDocs](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/wcm/commons/status/EditorResourceStatus.html)
