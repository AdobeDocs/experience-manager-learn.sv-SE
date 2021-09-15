---
title: Anpassa Adobe-klientdatalagret med AEM
description: Lär dig hur du anpassar datalagret för klienten i Adobe med innehåll från anpassade AEM. Lär dig hur du använder API:er från AEM Core Components för att utöka och anpassa datalagret.
version: Cloud Service
topic: Integrations
feature: Adobe Client Data Layer, Core Components
role: Developer
level: Intermediate, Experienced
kt: 6265
thumbnail: KT-6265.jpg
exl-id: 80e4cf2e-dff6-41e8-b09b-187cf2e18e00
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '2021'
ht-degree: 0%

---

# Anpassa Adobe-klientdatalagret med AEM {#customize-data-layer}

Lär dig hur du anpassar datalagret för klienten i Adobe med innehåll från anpassade AEM. Lär dig hur du använder API:er från [AEM Core Components för att utöka](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/extending.html) och anpassa datalagret.

## Vad du ska bygga

![Byline Data Layer](assets/adobe-client-data-layer/byline-data-layer-html.png)

I den här självstudiekursen utforskar du olika alternativ för att utöka datalagret för Adobe-klienten genom att uppdatera WKND [Byline-komponenten](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/custom-component.html). Det här är en anpassad komponent och lektioner som du lär dig i den här självstudiekursen kan användas i andra anpassade komponenter.

### Mål {#objective}

1. Mata in komponentdata i datalagret genom att utöka en Sling-modell och komponent-HTML
1. Använd Core Component Data Layer-verktyg för att minska arbetsinsatsen
1. Använd Core Component-dataattribut för att knyta till befintliga datalagerhändelser

## Förutsättningar {#prerequisites}

En **lokal utvecklingsmiljö** krävs för att slutföra den här självstudiekursen. Skärmbilder och video hämtas med AEM som en Cloud Service-SDK som körs på ett macOS. Kommandon och kod är oberoende av det lokala operativsystemet om inget annat anges.

**Är du inte AEM som Cloud Service?** Ta en titt på  [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM som Cloud Service-SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).

**Har du inte använt AEM 6.5 tidigare?** Ta en titt på  [följande guide för att konfigurera en lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

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
   > Om du använder AEM 6.5 och det senaste Service Pack-paketet lägger du till profilen `classic` i Maven-kommandot:
   >
   > `mvn clean install -PautoInstallSinglePackage -Pclassic`

1. Öppna ett nytt webbläsarfönster och logga in på AEM. Öppna en **tidskriftssida** som: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html).

   ![Byline-komponent på sida](assets/adobe-client-data-layer/byline-component-onpage.png)

   Du bör se ett exempel på den Byline-komponent som har lagts till på sidan som en del av ett Experience Fragment. Du kan visa Experience Fragment på [http://localhost:4502/editor.html/content/experience-fragments/wknd/language-masters/en/contributors/stacey-roswells/byline.html](http://localhost:4502/editor.html/content/experience-fragments/wknd/language-masters/en/contributors/stacey-roswells/byline.html)
1. Öppna dina utvecklingsverktyg och ange följande kommando i **konsolen**:

   ```js
   window.adobeDataLayer.getState();
   ```

   Inspect svaret för att se det aktuella läget för datalagret på en AEM. Du bör se information om sidan och enskilda komponenter.

   ![Adobe datalagersvar](assets/data-layer-state-response.png)

   Observera att komponenten Byline inte finns med i datalagret.

## Uppdatera modellen Byline Sling {#sling-model}

Om du vill mata in data om komponenten i datalagret måste vi först uppdatera komponentens Sling Model. Uppdatera sedan implementeringen av Java- och Sling Model i Byline för att lägga till en ny metod `getData()`. Den här metoden innehåller de egenskaper som vi vill mata in i datalagret.

1. Öppna `aem-guides-wknd`-projektet i den utvecklingsmiljö du väljer. Navigera till modulen `core`.
1. Öppna filen `Byline.java` på `core/src/main/java/com/adobe/aem/guides/wknd/core/models/Byline.java`.

   ![Byline Java Interface](assets/adobe-client-data-layer/byline-java-interface.png)

1. Lägg till en ny metod i gränssnittet:

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

1. Öppna filen `BylineImpl.java` på `core/src/main/java/com/adobe/aem/guides/wknd/core/models/impl/BylineImpl.java`.

   Detta är implementeringen av gränssnittet `Byline` och implementeras som en Sling-modell.

1. Lägg till följande importsatser i början av filen:

   ```java
   import java.util.HashMap;
   import java.util.Map;
   import org.apache.sling.api.resource.Resource;
   import com.fasterxml.jackson.core.JsonProcessingException;
   import com.fasterxml.jackson.databind.ObjectMapper;
   import com.adobe.cq.wcm.core.components.util.ComponentUtils;
   ```

   API:erna för `fasterxml.jackson` används för att serialisera de data som ska visas som JSON. `ComponentUtils` för AEM kärnkomponenter används för att kontrollera om datalagret är aktiverat.

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

   I ovanstående metod används ett nytt `HashMap` för att hämta de egenskaper som ska visas som JSON. Observera att befintliga metoder som `getName()` och `getOccupations()` används. `@type` representerar komponentens unika resurstyp, vilket gör att en klient enkelt kan identifiera händelser och/eller utlösare baserat på komponenttypen.

   `ObjectMapper` används för att serialisera egenskaperna och returnera en JSON-sträng. Denna JSON-sträng kan sedan infogas i datalagret.

1. Öppna ett terminalfönster. Bygg och driftsätt endast modulen `core` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/core
   $ mvn clean install -PautoInstallBundle
   ```

## Uppdatera Byline-HTML {#htl}

Uppdatera sedan `Byline` [HTML](https://experienceleague.adobe.com/docs/experience-manager-htl/using/htl/block-statements.html?lang=en#htl). HTML (HTML-mallspråk) är den mall som används för att återge komponentens HTML.

Ett särskilt dataattribut `data-cmp-data-layer` för varje AEM-komponent används för att visa dess datalager.  JavaScript som tillhandahålls av AEM Core Components söker efter det här dataattributet, vars värde fylls med JSON-strängen som returneras av metoden `getData()` för Byline Sling Model och matar in värdena i datalagret för Adobe Client.

1. Öppna projektet `aem-guides-wknd` i utvecklingsmiljön. Navigera till modulen `ui.apps`.
1. Öppna filen `byline.html` på `ui.apps/src/main/content/jcr_root/apps/wknd/components/byline/byline.html`.

   ![Byline HTML](assets/adobe-client-data-layer/byline-html-template.png)

1. Uppdatera `byline.html` så att attributet `data-cmp-data-layer` ingår:

   ```diff
     <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       data-sly-test.hasContent="${!byline.empty}"
   +   data-cmp-data-layer="${byline.data}"
       class="cmp-byline">
       ...
   ```

   Värdet `data-cmp-data-layer` har angetts till `"${byline.data}"` där `byline` är den tidigare uppdaterade delningsmodellen. `.data` är standardnoteringen för anrop av Java Getter-metoden i HTML som  `getData()` implementerats i föregående övning.

1. Öppna ett terminalfönster. Bygg och driftsätt endast modulen `ui.apps` med dina Maven-kunskaper:

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

1. Navigera under svaret under `component` för att hitta instansen av `byline`-komponenten som har lagts till i datalagret:

   ![En del av datalagret](assets/adobe-client-data-layer/byline-part-of-datalayer.png)

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

Adobe-klientdatalagret är händelsestyrt och en av de vanligaste händelserna som utlöser en åtgärd är händelsen `cmp:click`. AEM Core-komponenterna gör det här enkelt att registrera komponenten med hjälp av dataelementet: `data-cmp-clickable`.

Klickbara element är vanligtvis en CTA-knapp eller en navigeringslänk. Tyvärr har inte komponenten Byline någon av dessa men vi registrerar den ändå eftersom det kan vara vanligt för andra anpassade komponenter.

1. Öppna modulen `ui.apps` i din IDE
1. Öppna filen `byline.html` på `ui.apps/src/main/content/jcr_root/apps/wknd/components/byline/byline.html`.

1. Uppdatera `byline.html` om du vill inkludera attributet `data-cmp-clickable` i elementet **name** i Byline:

   ```diff
     <h2 class="cmp-byline__name" 
   +    data-cmp-clickable="${byline.data ? true : false}">
        ${byline.name}
     </h2>
   ```

1. Öppna en ny terminal. Bygg och driftsätt endast modulen `ui.apps` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/ui.apps
   $ mvn clean install -PautoInstallPackage
   ```

1. Gå tillbaka till webbläsaren och öppna sidan igen med komponenten Byline tillagd: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html).

   För att testa vår händelse lägger vi till JavaScript manuellt med utvecklarkonsolen. Se [Använda Adobe-klientdatalagret med AEM kärnkomponenter](data-layer-overview.md) för en video om hur du gör detta.

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
   > Det är viktigt att **inte** uppdatera webbläsaren under övningen, annars försvinner konsolens JavaScript.

1. I webbläsaren klickar du på författarens namn i Byline-komponenten med **konsolen** öppen:

   ![Byline-komponent klickad](assets/adobe-client-data-layer/byline-component-clicked.png)

   Du bör se konsolmeddelandet `Byline Clicked!` och namnet på bytet.

   `cmp:click`-händelsen är den enklaste att ansluta till. För mer komplexa komponenter och för att spåra andra beteenden är det möjligt att lägga till egna javascript för att lägga till och registrera nya händelser. Ett bra exempel är Carousel-komponenten, som utlöser en `cmp:show`-händelse när en bild växlas. Mer information finns i [källkoden](https://github.com/adobe/aem-core-wcm-components/blob/master/content/src/content/jcr_root/apps/core/wcm/components/carousel/v1/carousel/clientlibs/site/js/carousel.js#L219).

## Använda verktyget DataLayerBuilder {#data-layer-builder}

När Sling Model [uppdaterades](#sling-model) tidigare i kapitlet valde vi att skapa JSON-strängen med en `HashMap` och ange var och en av egenskaperna manuellt. Den här metoden fungerar bra för små engångskomponenter, men för komponenter som utökar AEM Core Components kan det resultera i mycket extra kod.

En verktygsklass, `DataLayerBuilder`, finns för att utföra de flesta grovjobbet. Detta gör att implementeringar kan utöka bara de egenskaper de vill ha. Låt oss uppdatera Sling-modellen så att den använder `DataLayerBuilder`.

1. Återgå till IDE och navigera till modulen `core`.
1. Öppna filen `Byline.java` på `core/src/main/java/com/adobe/aem/guides/wknd/core/models/Byline.java`.
1. Ändra metoden `getData()` om du vill returnera typen `ComponentData`

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

   `ComponentData` är ett objekt som tillhandahålls av AEM kärnkomponenter. Det resulterar i en JSON-sträng, precis som i det föregående exemplet, men utför även en hel del extraarbete.

1. Öppna filen `BylineImpl.java` på `core/src/main/java/com/adobe/aem/guides/wknd/core/models/impl/BylineImpl.java`.

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

   Komponenten Byline återanvänder delar av Image Core Component för att visa en bild som representerar författaren. I ovanstående kodutdrag används [DataLayerBuilder](https://javadoc.io/doc/com.adobe.cq/core.wcm.components.core/latest/com/adobe/cq/wcm/core/components/models/datalayer/builder/ComponentDataBuilder.html) för att utöka datalagret för komponenten `Image`. JSON-objektet fylls i automatiskt med alla data om bilden som används. Den utför även några av de rutinfunktioner som att ställa in `@type` och komponentens unika identifierare. Observera att metoden är mycket liten!

   Den enda egenskapen utökade `withTitle` som ersätts med värdet `getName()`.

1. Öppna ett terminalfönster. Bygg och driftsätt endast modulen `core` med dina Maven-kunskaper:

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

1. Öppna ett terminalfönster. Bygg och driftsätt endast modulen `ui.apps` med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd/ui.apps
   $ mvn clean install -PautoInstallPackage
   ```

1. Gå tillbaka till webbläsaren och öppna sidan igen med komponenten Byline tillagd: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html).
1. Öppna webbläsarens utvecklarverktyg och ange följande kommando i **konsolen**:

   ```js
   window.adobeDataLayer.getState();
   ```

1. Navigera under svaret under `component` för att hitta instansen av `byline`-komponenten:

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

   Observera att det nu finns ett `image`-objekt i `byline`-komponentposten. Här finns mycket mer information om resursen i DAM. Observera också att `@type` och det unika ID:t (i det här fallet `byline-136073cfcb`) har fyllts i automatiskt, liksom `repo:modifyDate` som anger när komponenten ändrades.

## Ytterligare exempel {#additional-examples}

1. Ett annat exempel på hur du utökar datalagret kan visas genom att undersöka komponenten `ImageList` i WKND-kodbasen:
   * `ImageList.java` - Java-gränssnittet i  `core` modulen.
   * `ImageListImpl.java` - Sling Model i  `core` modulen.
   * `image-list.html` - HTML-mall i  `ui.apps` modulen.

   >[!NOTE]
   >
   > Det är lite svårare att ta med anpassade egenskaper som `occupation` när du använder [DataLayerBuilder](https://javadoc.io/doc/com.adobe.cq/core.wcm.components.core/latest/com/adobe/cq/wcm/core/components/models/datalayer/builder/ComponentDataBuilder.html). Men om du utökar en Core-komponent som innehåller en bild eller sida sparar verktyget mycket tid.

   >[!NOTE]
   >
   > Om du skapar ett avancerat datalager för objekt som återanvänds under en implementering rekommenderar vi att du extraherar datalagerelementen till deras egna datalagerspecifika Java-objekt. Commerce Core-komponenter har till exempel lagt till gränssnitt för `ProductData` och `CategoryData` eftersom de kan användas på många komponenter i en Commerce-implementering. Mer information finns i [koden i aem-cif-core-components repo](https://github.com/adobe/aem-core-cif-components/tree/master/bundles/core/src/main/java/com/adobe/cq/commerce/core/components/datalayer).

## Grattis! {#congratulations}

Du har utforskat några sätt att utöka och anpassa datalagret för klienten i Adobe med AEM komponenter!

## Ytterligare resurser {#additional-resources}

* [Dokumentation för Adobe-klientdatalager](https://github.com/adobe/adobe-client-data-layer/wiki)
* [Datalagerintegrering med kärnkomponenterna](https://github.com/adobe/aem-core-wcm-components/blob/master/DATA_LAYER_INTEGRATION.md)
* [Använda Adobe Client Data Layer och Core Components Documentation](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/overview.html)
