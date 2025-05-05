---
title: Anpassa Adobe Client Data Layer med AEM Components
description: Lär dig hur du anpassar Adobe Client Data Layer med innehåll från anpassade AEM-komponenter. Lär dig hur du använder API:er från AEM Core Components för att utöka och anpassa datalagret.
version: Experience Manager as a Cloud Service
topic: Integrations
feature: Adobe Client Data Layer, Core Components
role: Developer
level: Intermediate, Experienced
jira: KT-6265
thumbnail: KT-6265.jpg
last-substantial-update: 2022-09-20T00:00:00Z
doc-type: Tutorial
exl-id: 80e4cf2e-dff6-41e8-b09b-187cf2e18e00
duration: 452
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1813'
ht-degree: 0%

---

# Anpassa Adobe Client Data Layer med AEM Components {#customize-data-layer}

Lär dig hur du anpassar Adobe Client Data Layer med innehåll från anpassade AEM-komponenter. Lär dig hur du använder API:er från [AEM Core Components för att utöka](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/extending.html?lang=sv-SE) och anpassa datalagret.

## Vad du ska bygga

![Byline Data Layer](assets/adobe-client-data-layer/byline-data-layer-html.png)

I den här självstudiekursen ska vi utforska olika alternativ för att utöka Adobe Client Data Layer genom att uppdatera WKND-komponenten [Byline](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/custom-component.html?lang=sv-SE). Komponenten _Byline_ är en **anpassad komponent** och lektioner som du lär dig i den här självstudiekursen kan användas i andra anpassade komponenter.

### Mål {#objective}

1. Mata in komponentdata i datalagret genom att utöka en Sling-modell och komponent-HTML
1. Använd Core Component Data Layer-verktyg för att minska arbetsinsatsen
1. Använd Core Component-dataattribut för att knyta till befintliga datalagerhändelser

## Förutsättningar {#prerequisites}

En **lokal utvecklingsmiljö** krävs för att slutföra den här självstudien. Skärmbilder och video spelas in med AEM as a Cloud Service SDK som körs på en macOS. Kommandon och kod är oberoende av det lokala operativsystemet om inget annat anges.

**Ny på AEM as a Cloud Service?** Titta i [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html?lang=sv-SE).

**Har du inte använt AEM 6.5 tidigare?** Titta i [följande guide för att konfigurera en lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=sv-SE).

## Hämta och distribuera WKND Reference-webbplatsen {#set-up-wknd-site}

Den här självstudien utökar Byline-komponenten på WKND-referensplatsen. Klona och installera WKND-kodbasen i din lokala miljö.

1. Starta en lokal QuickStart **author**-instans av AEM som körs på [http://localhost:4502](http://localhost:4502).
1. Öppna ett terminalfönster och klona WKND-kodbasen med Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd.git
   ```

1. Distribuera WKND-kodbasen till en lokal instans av AEM:

   ```shell
   $ cd aem-guides-wknd
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > För AEM 6.5 och den senaste Service Pack-versionen lägger du till profilen `classic` i kommandot Maven:
   >
   > `mvn clean install -PautoInstallSinglePackage -Pclassic`

1. Öppna ett nytt webbläsarfönster och logga in på AEM. Öppna en **tidskriftssida** som: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html).

   ![Byline-komponent på sida](assets/adobe-client-data-layer/byline-component-onpage.png)

   Du bör se ett exempel på den Byline-komponent som har lagts till på sidan som en del av ett Experience Fragment. Du kan visa Experience Fragment på [http://localhost:4502/editor.html/content/experience-fragments/wknd/language-masters/en/contributors/stacey-roswells/byline.html](http://localhost:4502/editor.html/content/experience-fragments/wknd/language-masters/en/contributors/stacey-roswells/byline.html)
1. Öppna dina utvecklarverktyg och ange följande kommando i **konsolen**:

   ```js
   window.adobeDataLayer.getState();
   ```

   Om du vill se det aktuella läget för datalagret på en AEM-plats kontrollerar du svaret. Du bör se information om sidan och enskilda komponenter.

   ![Adobe datalagersvar](assets/data-layer-state-response.png)

   Observera att komponenten Byline inte finns med i datalagret.

## Uppdatera modellen Byline Sling {#sling-model}

Om du vill mata in data om komponenten i datalagret uppdaterar vi först komponentens Sling Model. Uppdatera sedan Bylines Java™-gränssnitt och Sling Model-implementering så att den nya metoden `getData()` finns. Den här metoden innehåller de egenskaper som ska injiceras i datalagret.

1. Öppna projektet `aem-guides-wknd` i den utvecklingsmiljö du vill använda. Navigera till modulen `core`.
1. Öppna filen `Byline.java` vid `core/src/main/java/com/adobe/aem/guides/wknd/core/models/Byline.java`.

   ![Gränssnitt för Java-penna](assets/adobe-client-data-layer/byline-java-interface.png)

1. Lägg till nedanstående metod i gränssnittet:

   ```java
   public interface Byline {
       ...
       /***
        * Return data about the Byline Component to populate the data layer
        * @return String
        */
       String getData();
   }
   ```

1. Öppna filen `BylineImpl.java` vid `core/src/main/java/com/adobe/aem/guides/wknd/core/models/impl/BylineImpl.java`. Det är implementeringen av gränssnittet `Byline` och implementeras som en Sling-modell.

1. Lägg till följande importsatser i början av filen:

   ```java
   import java.util.HashMap;
   import java.util.Map;
   import org.apache.sling.api.resource.Resource;
   import com.fasterxml.jackson.core.JsonProcessingException;
   import com.fasterxml.jackson.databind.ObjectMapper;
   import com.adobe.cq.wcm.core.components.util.ComponentUtils;
   ```

   `fasterxml.jackson` API:er används för att serialisera data som ska visas som JSON. `ComponentUtils` av AEM Core Components används för att kontrollera om datalagret är aktiverat.

1. Lägg till den oimplementerade metoden `getData()` i `BylineImple.java`:

   ```java
   public class BylineImpl implements Byline {
       ...
       @Override
       public String getData() {
           Resource bylineResource = this.request.getResource();
           // Use ComponentUtils to verify if the DataLayer is enabled
           if (ComponentUtils.isDataLayerEnabled(bylineResource)) {
   
               //Create a map of properties we want to expose
               Map<String, Object> bylineProperties = new HashMap<String,Object>();
               bylineProperties.put("@type", bylineResource.getResourceType());
               bylineProperties.put("name", this.getName());
               bylineProperties.put("occupation", this.getOccupations());
               bylineProperties.put("fileReference", image.getFileReference());
   
               //Use AEM Core Component utils to get a unique identifier for the Byline component (in case multiple are on the page)
               String bylineComponentID = ComponentUtils.getId(bylineResource, this.currentPage, this.componentContext);
   
               // Return the bylineProperties as a JSON String with a key of the bylineResource's ID
               try {
                   return String.format("{\"%s\":%s}",
                       bylineComponentID,
                       // Use the ObjectMapper to serialize the bylineProperties to a JSON string
                       new ObjectMapper().writeValueAsString(bylineProperties));
               } catch (JsonProcessingException e) {
   
                   LOGGER.error("Unable to generate dataLayer JSON string", e);
               }
   
           }
           // return null if the Data Layer is not enabled
           return null;
       }
   }
   ```

   I ovanstående metod används en ny `HashMap` för att hämta de egenskaper som ska visas som JSON. Observera att befintliga metoder som `getName()` och `getOccupations()` används. `@type` representerar komponentens unika resurstyp, vilket gör att en klient enkelt kan identifiera händelser och/eller utlösare baserat på komponenttypen.

   `ObjectMapper` används för att serialisera egenskaperna och returnera en JSON-sträng. Denna JSON-sträng kan sedan infogas i datalagret.

1. Öppna ett terminalfönster. Skapa och distribuera bara modulen `core` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/core
   $ mvn clean install -PautoInstallBundle
   ```

## Uppdatera Byline-HTML {#htl}

Uppdatera sedan `Byline` [HTML](https://experienceleague.adobe.com/docs/experience-manager-htl/content/specification.html?lang=sv-SE). HTML (HTML Template Language) är den mall som används för att återge komponentens HTML.

Ett särskilt dataattribut `data-cmp-data-layer` på varje AEM-komponent används för att visa dess datalager. JavaScript som tillhandahålls av AEM Core Components letar efter det här dataattributet. Värdet för det här dataattributet fylls i med JSON-strängen som returneras av Byline Sling-modellens `getData()`-metod och injiceras i Adobe-klientdatalagret.

1. Öppna projektet `aem-guides-wknd` i IDE. Navigera till modulen `ui.apps`.
1. Öppna filen `byline.html` vid `ui.apps/src/main/content/jcr_root/apps/wknd/components/byline/byline.html`.

   ![Byline HTML](assets/adobe-client-data-layer/byline-html-template.png)

1. Uppdatera `byline.html` om du vill inkludera attributet `data-cmp-data-layer`:

   ```diff
     <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       data-sly-test.hasContent="${!byline.empty}"
   +   data-cmp-data-layer="${byline.data}"
       class="cmp-byline">
       ...
   ```

   Värdet för `data-cmp-data-layer` har angetts till `"${byline.data}"` där `byline` är den tidigare uppdaterade delningsmodellen. `.data` är standardnotation för anrop av Java™ Getter-metoden i HTML-koden för `getData()` som implementerades i föregående övning.

1. Öppna ett terminalfönster. Skapa och distribuera bara modulen `ui.apps` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/ui.apps
   $ mvn clean install -PautoInstallPackage
   ```

1. Gå tillbaka till webbläsaren och öppna sidan igen med en Byline-komponent: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html).

1. Öppna utvecklingsverktygen och kontrollera HTML-källan för sidan för att se om det finns en Byline-komponent:

   ![Byline Data Layer](assets/adobe-client-data-layer/byline-data-layer-html.png)

   Du bör se att `data-cmp-data-layer` har fyllts i med JSON-strängen från Sling-modellen.

1. Öppna webbläsarens utvecklarverktyg och ange följande kommando i **konsolen**:

   ```js
   window.adobeDataLayer.getState();
   ```

1. Navigera under svaret under `component` för att hitta instansen av komponenten `byline` som har lagts till i datalagret:

   ![En del av datalagret ](assets/adobe-client-data-layer/byline-part-of-datalayer.png) med penna

   Du bör se ett inlägg som följande:

   ```json
   byline-136073cfcb:
       @type: "wknd/components/byline"
       fileReference: "/content/dam/wknd/en/contributors/stacey-roswells.jpg"
       name: "Stacey Roswells"
       occupation: (3) ["Artist", "Photographer", "Traveler"]
       parentId: "page-30d989b3f8"
   ```

   Observera att de egenskaper som visas är samma som läggs till i `HashMap` i segmentmodellen.

## Lägg till en klickningshändelse {#click-event}

Adobe-klientdatalagret är händelsestyrt och en av de vanligaste händelserna som utlöser en åtgärd är `cmp:click`-händelsen. AEM Core-komponenterna gör det här enkelt att registrera komponenten med hjälp av dataelementet: `data-cmp-clickable`.

Klickbara element är vanligtvis en CTA-knapp eller en navigeringslänk. Tyvärr har inte komponenten Byline någon av dessa men vi måste registrera den ändå eftersom det kan vara vanligt för andra anpassade komponenter.

1. Öppna modulen `ui.apps` i din IDE
1. Öppna filen `byline.html` vid `ui.apps/src/main/content/jcr_root/apps/wknd/components/byline/byline.html`.

1. Uppdatera `byline.html` så att attributet `data-cmp-clickable` inkluderas i Bylines **name**-element:

   ```diff
     <h2 class="cmp-byline__name" 
   +    data-cmp-clickable="${byline.data ? true : false}">
        ${byline.name}
     </h2>
   ```

1. Öppna en ny terminal. Skapa och distribuera bara modulen `ui.apps` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/ui.apps
   $ mvn clean install -PautoInstallPackage
   ```

1. Gå tillbaka till webbläsaren och öppna sidan igen med komponenten Byline tillagd: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html).

   För att testa vår aktivitet lägger vi till JavaScript manuellt med hjälp av utvecklarkonsolen. Se [Använda Adobe-klientdatalagret med AEM Core Components](data-layer-overview.md) för en video om hur du gör detta.

1. Öppna webbläsarens utvecklarverktyg och ange följande metod i **konsolen**:

   ```javascript
   function bylineClickHandler(event) {
       var dataObject = window.adobeDataLayer.getState(event.eventInfo.path);
       if (dataObject != null && dataObject['@type'] === 'wknd/components/byline') {
           console.log("Byline Clicked!");
           console.log("Byline name: " + dataObject['name']);
       }
   }
   ```

   Den här enkla metoden bör hantera klickningen på namnet på komponenten Byline.

1. Ange följande metod i **konsolen**:

   ```javascript
   window.adobeDataLayer.push(function (dl) {
        dl.addEventListener("cmp:click", bylineClickHandler);
   });
   ```

   Ovanstående metod överför en händelseavlyssnare till datalagret för att avlyssna händelsen `cmp:click` och anropar `bylineClickHandler`.

   >[!CAUTION]
   >
   > Det är viktigt **inte** att uppdatera webbläsaren under övningen, annars försvinner konsolen JavaScript.

1. I webbläsaren klickar du på författarens namn i Byline-komponenten när **konsolen** är öppen:

   ![Byline-komponenten klickade](assets/adobe-client-data-layer/byline-component-clicked.png)

   Du bör se konsolmeddelandet `Byline Clicked!` och namnet på byteboken.

   Händelsen `cmp:click` är enklast att koppla in sig i. För mer komplexa komponenter och för att spåra andra beteenden är det möjligt att lägga till anpassade JavaScript för att lägga till och registrera nya händelser. Ett bra exempel är Carousel-komponenten, som utlöser en `cmp:show`-händelse när en bild växlas. Mer information finns i [källkoden](https://github.com/adobe/aem-core-wcm-components/blob/main/content/src/content/jcr_root/apps/core/wcm/components/carousel/v1/carousel/clientlibs/site/js/carousel.js).

## Använda verktyget DataLayerBuilder {#data-layer-builder}

När Sling Model [uppdaterades](#sling-model) tidigare i kapitlet valde vi att skapa JSON-strängen med en `HashMap` och ange var och en av egenskaperna manuellt. Den här metoden fungerar bra för små engångskomponenter, men för komponenter som utökar AEM Core Components kan det resultera i mycket extra kod.

Det finns en verktygsklass, `DataLayerBuilder`, som kan utföra de flesta grova lyftningarna. Detta gör att implementeringar kan utöka bara de egenskaper de vill ha. Vi uppdaterar Sling-modellen så att `DataLayerBuilder` används.

1. Återgå till IDE och navigera till modulen `core`.
1. Öppna filen `Byline.java` vid `core/src/main/java/com/adobe/aem/guides/wknd/core/models/Byline.java`.
1. Ändra metoden `getData()` för att returnera typen `ComponentData`

   ```java
   import com.adobe.cq.wcm.core.components.models.datalayer.ComponentData;
   ...
   public interface Byline {
       ...
       /***
        * Return data about the Byline Component to populate the data layer
        * @return ComponentData
        */
       ComponentData getData();
   }
   ```

   `ComponentData` är ett objekt från AEM Core Components. Det resulterar i en JSON-sträng, precis som i det föregående exemplet, men utför även en hel del extraarbete.

1. Öppna filen `BylineImpl.java` vid `core/src/main/java/com/adobe/aem/guides/wknd/core/models/impl/BylineImpl.java`.

1. Lägg till följande importsatser:

   ```java
   import com.adobe.cq.wcm.core.components.models.datalayer.ComponentData;
   import com.adobe.cq.wcm.core.components.models.datalayer.builder.DataLayerBuilder;
   ```

1. Ersätt metoden `getData()` med följande:

   ```java
   @Override
   public ComponentData getData() {
       Resource bylineResource = this.request.getResource();
       // Use ComponentUtils to verify if the DataLayer is enabled
       if (ComponentUtils.isDataLayerEnabled(bylineResource)) {
   
           return DataLayerBuilder.extending(getImage().getData()).asImageComponent()
               .withTitle(this::getName)
               .build();
   
       }
       // return null if the Data Layer is not enabled
       return null;
   }
   ```

   Komponenten Byline återanvänder delar av Image Core Component för att visa en bild som representerar författaren. I ovanstående kodutdrag används [DataLayerBuilder](https://javadoc.io/doc/com.adobe.cq/core.wcm.components.core/latest/com/adobe/cq/wcm/core/components/models/datalayer/builder/ComponentDataBuilder.html) för att utöka datalagret för komponenten `Image`. JSON-objektet fylls i automatiskt med alla data om bilden som används. Den utför även några av rutinfunktionerna som att ställa in `@type` och komponentens unika identifierare. Observera att metoden är liten!

   Den enda egenskapen utökade `withTitle` som ersätts med värdet `getName()`.

1. Öppna ett terminalfönster. Skapa och distribuera bara modulen `core` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/core
   $ mvn clean install -PautoInstallBundle
   ```

1. Återgå till IDE och öppna filen `byline.html` under `ui.apps`
1. Uppdatera HTML så att `byline.data.json` används för att fylla i attributet `data-cmp-data-layer`:

   ```diff
     <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       data-sly-test.hasContent="${!byline.empty}"
   -   data-cmp-data-layer="${byline.data}"
   +   data-cmp-data-layer="${byline.data.json}"
   ```

   Kom ihåg att vi nu returnerar ett objekt av typen `ComponentData`. Det här objektet innehåller en get-metod `getJson()` och det används för att fylla i attributet `data-cmp-data-layer`.

1. Öppna ett terminalfönster. Skapa och distribuera bara modulen `ui.apps` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/ui.apps
   $ mvn clean install -PautoInstallPackage
   ```

1. Gå tillbaka till webbläsaren och öppna sidan igen med komponenten Byline tillagd: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html).
1. Öppna webbläsarens utvecklarverktyg och ange följande kommando i **konsolen**:

   ```js
   window.adobeDataLayer.getState();
   ```

1. Navigera under svaret under `component` för att hitta instansen av komponenten `byline`:

   ![Byline Data Layer Updated](assets/adobe-client-data-layer/byline-data-layer-builder.png)

   Du bör se ett inlägg som följande:

   ```json
   byline-136073cfcb:
       @type: "wknd/components/byline"
       dc:title: "Stacey Roswells"
       image:
           @type: "image/jpeg"
           repo:id: "142658f8-4029-4299-9cd6-51afd52345c0"
           repo:modifyDate: "2019-10-25T23:49:51Z"
           repo:path: "/content/dam/wknd/en/contributors/stacey-roswells.jpg"
           xdm:tags: []
       parentId: "page-30d989b3f8"
       repo:modifyDate: "2019-10-18T20:17:24Z"
   ```

   Observera att det nu finns ett `image`-objekt i `byline`-komponentposten. Här finns mycket mer information om resursen i DAM. Observera också att `@type` och det unika ID:t (i det här fallet `byline-136073cfcb`) har fyllts i automatiskt och att `repo:modifyDate` anger när komponenten ändrades.

## Ytterligare exempel {#additional-examples}

1. Ett annat exempel på hur du utökar datalagret kan visas genom att undersöka komponenten `ImageList` i WKND-kodbasen:
   * `ImageList.java` - Java-gränssnittet i modulen `core`.
   * `ImageListImpl.java` - Sling Model i modulen `core`.
   * `image-list.html` - HTML-mall i modulen `ui.apps`.

   >[!NOTE]
   >
   > Det är lite svårare att inkludera anpassade egenskaper som `occupation` när [ DataLayerBuilder](https://javadoc.io/doc/com.adobe.cq/core.wcm.components.core/latest/com/adobe/cq/wcm/core/components/models/datalayer/builder/ComponentDataBuilder.html) används. Men om du utökar en Core-komponent som innehåller en bild eller sida sparar verktyget mycket tid.

   >[!NOTE]
   >
   > Om du skapar ett avancerat datalager för objekt som återanvänds under en implementering bör du extrahera datalagrets element till deras egna datalagerspecifika Java™-objekt. Commerce Core Components har till exempel lagt till gränssnitt för `ProductData` och `CategoryData` eftersom dessa kan användas på många komponenter i en Commerce-implementering. Granska [koden i rapporten om aem-cif-core-components](https://github.com/adobe/aem-core-cif-components/tree/master/bundles/core/src/main/java/com/adobe/cq/commerce/core/components/datalayer) om du vill ha mer information.

## Grattis! {#congratulations}

Du har utforskat några sätt att utöka och anpassa Adobe Client Data Layer med AEM-komponenter!

## Ytterligare resurser {#additional-resources}

* [Adobe Client Data Layer Documentation](https://github.com/adobe/adobe-client-data-layer/wiki)
* [Datalagerintegrering med kärnkomponenterna](https://github.com/adobe/aem-core-wcm-components/blob/main/DATA_LAYER_INTEGRATION.md)
* [Använda Adobe Client Data Layer och Core Components Documentation](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html?lang=sv-SE)
