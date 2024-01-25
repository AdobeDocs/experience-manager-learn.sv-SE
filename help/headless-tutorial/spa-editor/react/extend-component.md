---
title: Utöka en kärnkomponent | Komma igång med AEM SPA Editor och React
description: Lär dig hur du utökar JSON-modellen för en befintlig Core-komponent som ska användas med AEM SPA. Att förstå hur du lägger till egenskaper och innehåll i en befintlig komponent är en kraftfull teknik som utökar funktionerna i en AEM redigeringsimplementering. Lär dig använda delegeringsmönstret för att utöka Sling-modeller och funktioner i Sling Resource Merger.
feature: SPA Editor, Core Components
version: Cloud Service
jira: KT-5879
thumbnail: 5879-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 44433595-08bc-4a82-9232-49d46c31b07b
duration: 409
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1058'
ht-degree: 0%

---

# Utöka en kärnkomponent {#extend-component}

Lär dig hur du utökar en befintlig Core Component som ska användas med AEM SPA Editor. Att förstå hur man utökar en befintlig komponent är en kraftfull teknik för att anpassa och utöka funktionerna i en AEM redigeringsimplementering.

## Syfte

1. Utöka en befintlig Core Component med ytterligare egenskaper och innehåll.
2. Förstå grunderna för komponentarv med användning av `sling:resourceSuperType`.
3. Lär dig använda [Delegeringsmönster](https://github.com/adobe/aem-core-wcm-components/wiki/Delegation-Pattern-for-Sling-Models) för Sling Models för att återanvända befintlig logik och funktionalitet.

## Vad du ska bygga

I det här kapitlet visas den ytterligare kod som behövs för att lägga till en extra egenskap i en standard `Image` för att uppfylla kraven för en ny `Banner` -komponenten. The `Banner` -komponenten innehåller alla samma egenskaper som standarden `Image` men innehåller en extra egenskap som användare kan använda för att fylla i **Banderolltext**.

![Slutgiltig banderollkomponent](assets/extend-component/final-author-banner-component.png)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment). I det här skedet antas att användarna har en god förståelse för AEM redigeringsfunktion SPA självstudiekursen.

## Arv med SSling Resource Super Type {#sling-resource-super-type}

Utöka en befintlig komponentuppsättning med en egenskap med namnet `sling:resourceSuperType` på komponentens definition.  `sling:resourceSuperType`är en [property](https://sling.apache.org/documentation/the-sling-engine/resources.html#resource-properties) som kan anges för en AEM som pekar på en annan komponent. Detta anger uttryckligen att komponenten ska ärva alla funktioner i komponenten som identifieras som `sling:resourceSuperType`.

Om vi vill utöka `Image` komponent vid `wknd-spa-react/components/image` måste koden i `ui.apps` -modul.

1. Skapa en ny mapp under `ui.apps` modul för `banner` på `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components/banner`.
1. Under `banner` skapa en komponentdefinition (`.content.xml`) på följande sätt:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Banner"
       sling:resourceSuperType="wknd-spa-react/components/image"
       componentGroup="WKND SPA React - Content"/>
   ```

   Detta anger `wknd-spa-react/components/banner` ärva alla funktioner i `wknd-spa-react/components/image`.

## cq:editConfig {#cq-edit-config}

The `_cq_editConfig.xml` -filen styr dra och släpp-beteendet i AEM. När du utökar bildkomponenten är det viktigt att resurstypen matchar själva komponenten.

1. I `ui.apps` modulen skapa en annan fil under `banner` namngiven `_cq_editConfig.xml`.
1. Fylla `_cq_editConfig.xml` med följande XML:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="cq:EditConfig">
       <cq:dropTargets jcr:primaryType="nt:unstructured">
           <image
               jcr:primaryType="cq:DropTargetConfig"
               accept="[image/gif,image/jpeg,image/png,image/webp,image/tiff,image/svg\\+xml]"
               groups="[media]"
               propertyName="./fileReference">
               <parameters
                   jcr:primaryType="nt:unstructured"
                   sling:resourceType="wknd-spa-react/components/banner"
                   imageCrop=""
                   imageMap=""
                   imageRotate=""/>
           </image>
       </cq:dropTargets>
       <cq:inplaceEditing
           jcr:primaryType="cq:InplaceEditingConfig"
           active="{Boolean}true"
           editorType="image">
           <inplaceEditingConfig jcr:primaryType="nt:unstructured">
               <plugins jcr:primaryType="nt:unstructured">
                   <crop
                       jcr:primaryType="nt:unstructured"
                       supportedMimeTypes="[image/jpeg,image/png,image/webp,image/tiff]"
                       features="*">
                       <aspectRatios jcr:primaryType="nt:unstructured">
                           <wideLandscape
                               jcr:primaryType="nt:unstructured"
                               name="Wide Landscape"
                               ratio="0.6180"/>
                           <landscape
                               jcr:primaryType="nt:unstructured"
                               name="Landscape"
                               ratio="0.8284"/>
                           <square
                               jcr:primaryType="nt:unstructured"
                               name="Square"
                               ratio="1"/>
                           <portrait
                               jcr:primaryType="nt:unstructured"
                               name="Portrait"
                               ratio="1.6180"/>
                       </aspectRatios>
                   </crop>
                   <flip
                       jcr:primaryType="nt:unstructured"
                       supportedMimeTypes="[image/jpeg,image/png,image/webp,image/tiff]"
                       features="-"/>
                   <map
                       jcr:primaryType="nt:unstructured"
                       supportedMimeTypes="[image/jpeg,image/png,image/webp,image/tiff,image/svg+xml]"
                       features="*"/>
                   <rotate
                       jcr:primaryType="nt:unstructured"
                       supportedMimeTypes="[image/jpeg,image/png,image/webp,image/tiff]"
                       features="*"/>
                   <zoom
                       jcr:primaryType="nt:unstructured"
                       supportedMimeTypes="[image/jpeg,image/png,image/webp,image/tiff]"
                       features="*"/>
               </plugins>
               <ui jcr:primaryType="nt:unstructured">
                   <inline
                       jcr:primaryType="nt:unstructured"
                       toolbar="[crop#launch,rotate#right,history#undo,history#redo,fullscreen#fullscreen,control#close,control#finish]">
                       <replacementToolbars
                           jcr:primaryType="nt:unstructured"
                           crop="[crop#identifier,crop#unlaunch,crop#confirm]"/>
                   </inline>
                   <fullscreen jcr:primaryType="nt:unstructured">
                       <toolbar
                           jcr:primaryType="nt:unstructured"
                           left="[crop#launchwithratio,rotate#right,flip#horizontal,flip#vertical,zoom#reset100,zoom#popupslider]"
                           right="[history#undo,history#redo,fullscreen#fullscreenexit]"/>
                       <replacementToolbars jcr:primaryType="nt:unstructured">
                           <crop
                               jcr:primaryType="nt:unstructured"
                               left="[crop#identifier]"
                               right="[crop#unlaunch,crop#confirm]"/>
                           <map
                               jcr:primaryType="nt:unstructured"
                               left="[map#rectangle,map#circle,map#polygon]"
                               right="[map#unlaunch,map#confirm]"/>
                       </replacementToolbars>
                   </fullscreen>
               </ui>
           </inplaceEditingConfig>
       </cq:inplaceEditing>
   </jcr:root>
   ```

1. Den unika aspekten av filen är `<parameters>` nod som ställer in resourceType på `wknd-spa-react/components/banner`.

   ```xml
   <parameters
       jcr:primaryType="nt:unstructured"
       sling:resourceType="wknd-spa-react/components/banner"
       imageCrop=""
       imageMap=""
       imageRotate=""/>
   ```

   De flesta komponenter kräver ingen `_cq_editConfig`. Bildkomponenter och underordnade är undantag.

## Utöka dialogrutan {#extend-dialog}

Våra `Banner` -komponenten kräver ett extra textfält i dialogrutan för att hämta `bannerText`. Eftersom vi använder arv från Sling kan vi använda funktionerna i [Samla resurser](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/sling-resource-merger.html) om du vill åsidosätta eller utöka delar av dialogrutan. I det här exemplet har en ny flik lagts till i dialogrutan för att hämta ytterligare data från en författare som ska fylla i kortkomponenten.

1. I `ui.apps` -modul, under `banner` mapp, skapa en mapp med namnet `_cq_dialog`.
1. Under `_cq_dialog` skapa en dialogrutedefinitionsfil `.content.xml`. Fyll den med följande:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:granite="http://www.adobe.com/jcr/granite/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="nt:unstructured"
       jcr:title="Banner"
       sling:resourceType="cq/gui/components/authoring/dialog">
       <content jcr:primaryType="nt:unstructured">
           <items jcr:primaryType="nt:unstructured">
               <tabs jcr:primaryType="nt:unstructured">
                   <items jcr:primaryType="nt:unstructured">
                       <text
                           jcr:primaryType="nt:unstructured"
                           jcr:title="Text"
                           sling:orderBefore="asset"
                           sling:resourceType="granite/ui/components/coral/foundation/container"
                           margin="{Boolean}true">
                           <items jcr:primaryType="nt:unstructured">
                               <columns
                                   jcr:primaryType="nt:unstructured"
                                   sling:resourceType="granite/ui/components/coral/foundation/fixedcolumns"
                                   margin="{Boolean}true">
                                   <items jcr:primaryType="nt:unstructured">
                                       <column
                                           jcr:primaryType="nt:unstructured"
                                           sling:resourceType="granite/ui/components/coral/foundation/container">
                                           <items jcr:primaryType="nt:unstructured">
                                               <textGroup
                                                   granite:hide="${cqDesign.titleHidden}"
                                                   jcr:primaryType="nt:unstructured"
                                                   sling:resourceType="granite/ui/components/coral/foundation/well">
                                                   <items jcr:primaryType="nt:unstructured">
                                                       <bannerText
                                                           jcr:primaryType="nt:unstructured"
                                                           sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                                                           fieldDescription="Text to display on top of the banner."
                                                           fieldLabel="Banner Text"
                                                           name="./bannerText"/>
                                                   </items>
                                               </textGroup>
                                           </items>
                                       </column>
                                   </items>
                               </columns>
                           </items>
                       </text>
                   </items>
               </tabs>
           </items>
       </content>
   </jcr:root>
   ```

   XML-definitionen ovan skapar en ny flik med namnet **Text** och beställa *före* befintlig **Tillgång** -fliken. Det kommer att innehålla ett enda fält **Banderolltext**.

1. Dialogrutan ser ut så här:

   ![Slutlig dialogruta för banderoll](assets/extend-component/banner-dialog.png)

   Observera att vi inte behövde definiera flikarna för **Tillgång** eller **Metadata**. Dessa ärvs via `sling:resourceSuperType` -egenskap.

   Innan vi kan förhandsgranska dialogen måste vi implementera SPA och `MapTo` funktion.

## Implementera SPA {#implement-spa-component}

För att du ska kunna använda komponenten Banner med SPA Editor måste en ny SPA skapas som ska mappas till `wknd-spa-react/components/banner`. Detta görs i `ui.frontend` -modul.

1. I `ui.frontend` skapa en ny mapp för `Banner` på `ui.frontend/src/components/Banner`.
1. Skapa en ny fil med namnet `Banner.js` under `Banner` mapp. Fyll den med följande:

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/aem-react-editable-components';
   
   export const BannerEditConfig = {
       emptyLabel: 'Banner',
   
       isEmpty: function(props) {
           return !props || !props.src || props.src.trim().length < 1;
       }
   };
   
   export default class Banner extends Component {
   
       get content() {
           return <img     
                   className="Image-src"
                   src={this.props.src}
                   alt={this.props.alt}
                   title={this.props.title ? this.props.title : this.props.alt} />;
       }
   
       // display our custom bannerText property!
       get bannerText() {
           if(this.props.bannerText) {
               return <h4>{this.props.bannerText}</h4>;
           }
   
           return null;
       }
   
       render() {
           if (BannerEditConfig.isEmpty(this.props)) {
               return null;
           }
   
           return (
               <div className="Banner">
                   {this.bannerText}
                   <div className="BannerImage">{this.content}</div>
               </div>
           );
       }
   }
   
   MapTo('wknd-spa-react/components/banner')(Banner, BannerEditConfig);
   ```

   Den här SPA-komponenten mappar till AEM `wknd-spa-react/components/banner` skapades tidigare.

1. Uppdatera `import-components.js` på `ui.frontend/src/components/import-components.js` att inkludera nya `Banner` SPA:

   ```diff
     import './ExperienceFragment/ExperienceFragment';
     import './OpenWeather/OpenWeather';
   + import './Banner/Banner';
   ```

1. Nu kan projektet distribueras till AEM och dialogen kan testas. Driftsätt projektet med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa.react
   $ mvn clean install -PautoInstallSinglePackage
   ```

1. Uppdatera SPA-mallens princip för att lägga till `Banner` som **tillåten komponent**.

1. Navigera till en SPA och lägg till `Banner` till någon av de SPA sidorna:

   ![Lägg till banderollkomponent](assets/extend-component/add-banner-component.png)

   >[!NOTE]
   >
   > Du kan spara ett värde för **Banderolltext** men det här värdet återspeglas inte i SPA. För att aktivera måste vi utöka komponentens Sling-modell.

## Lägg till Java-gränssnitt {#java-interface}

För att slutligen visa värdena från komponentdialogrutan för React-komponenten måste vi uppdatera Sling-modellen som fyller i JSON för `Banner` -komponenten. Detta görs i `core` -modul som innehåller all Java-kod för vårt SPA.

Först skapar vi ett nytt Java-gränssnitt för `Banner` som utökar `Image` Java-gränssnitt.

1. I `core` modul skapa en ny fil med namnet `BannerModel.java` på `core/src/main/java/com/adobe/aem/guides/wkndspa/react/core/models`.
1. Fylla `BannerModel.java` med följande:

   ```java
   package com.adobe.aem.guides.wkndspa.react.core.models;
   
   import com.adobe.cq.wcm.core.components.models.Image;
   import org.osgi.annotation.versioning.ProviderType;
   
   @ProviderType
   public interface BannerModel extends Image {
   
       public String getBannerText();
   
   }
   ```

   Detta ärver alla metoder från kärnkomponenten `Image` gränssnitt och en ny metod `getBannerText()`.

## Implementera segmenteringsmodell {#sling-model}

Implementera sedan Sling-modellen för `BannerModel` gränssnitt.

1. I `core` modul skapa en ny fil med namnet `BannerModelImpl.java` på `core/src/main/java/com/adobe/aem/guides/wkndspa/react/core/models/impl`.

1. Fylla `BannerModelImpl.java` med följande:

   ```java
   package com.adobe.aem.guides.wkndspa.react.core.models.impl;
   
   import com.adobe.aem.guides.wkndspa.react.core.models.BannerModel;
   import com.adobe.cq.export.json.ComponentExporter;
   import com.adobe.cq.export.json.ExporterConstants;
   import com.adobe.cq.wcm.core.components.models.Image;
   import org.apache.sling.models.annotations.*;
   import org.apache.sling.api.SlingHttpServletRequest;
   import org.apache.sling.models.annotations.Model;
   import org.apache.sling.models.annotations.injectorspecific.Self;
   import org.apache.sling.models.annotations.injectorspecific.ValueMapValue;
   import org.apache.sling.models.annotations.via.ResourceSuperType;
   
   @Model(
       adaptables = SlingHttpServletRequest.class, 
       adapters = { BannerModel.class,ComponentExporter.class}, 
       resourceType = BannerModelImpl.RESOURCE_TYPE, 
       defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL
   )
   @Exporter(name = ExporterConstants.SLING_MODEL_EXPORTER_NAME, extensions = ExporterConstants.SLING_MODEL_EXTENSION)
   public class BannerModelImpl implements BannerModel {
   
       // points to the the component resource path in ui.apps
       static final String RESOURCE_TYPE = "wknd-spa-react/components/banner";
   
       @Self
       private SlingHttpServletRequest request;
   
       // With sling inheritance (sling:resourceSuperType) we can adapt the current resource to the Image class
       // this allows us to re-use all of the functionality of the Image class, without having to implement it ourself
       // see https://github.com/adobe/aem-core-wcm-components/wiki/Delegation-Pattern-for-Sling-Models
       @Self
       @Via(type = ResourceSuperType.class)
       private Image image;
   
       // map the property saved by the dialog to a variable named `bannerText`
       @ValueMapValue
       private String bannerText;
   
       // public getter to expose the value of `bannerText` via the Sling Model and JSON output
       @Override
       public String getBannerText() {
           return bannerText;
       }
   
       // Re-use the Image class for all other methods:
   
       @Override
       public String getSrc() {
           return null != image ? image.getSrc() : null;
       }
   
       @Override
       public String getAlt() {
           return null != image ? image.getAlt() : null;
       }
   
       @Override
       public String getTitle() {
           return null != image ? image.getTitle() : null;
       }
   
       // method required by `ComponentExporter` interface
       // exposes a JSON property named `:type` with a value of `wknd-spa-react/components/banner`
       // required to map the JSON export to the SPA component props via the `MapTo`
       @Override
       public String getExportedType() {
           return BannerModelImpl.RESOURCE_TYPE;
       }
   }
   ```

   Lägg märke till att `@Model` och `@Exporter` kommentarer för att säkerställa att Sling Model kan serialiseras som JSON via Sling Model Exporter.

   `BannerModelImpl.java` använder [Delegeringsmönster för segmenteringsmodeller](https://github.com/adobe/aem-core-wcm-components/wiki/Delegation-Pattern-for-Sling-Models) för att undvika att skriva om all logik från Image-kärnkomponenten.

1. Granska följande rader:

   ```java
   @Self
   @Via(type = ResourceSuperType.class)
   private Image image;
   ```

   Anteckningen ovan instansierar ett bildobjekt med namnet `image` baserat på `sling:resourceSuperType` arv av `Banner` -komponenten.

   ```java
   @Override
   public String getSrc() {
       return null != image ? image.getSrc() : null;
   }
   ```

   Då kan du helt enkelt använda `image` -objekt som implementerar metoder som definieras av `Image` utan att behöva skriva själva logiken. Den här tekniken används för `getSrc()`, `getAlt()` och `getTitle()`.

1. Öppna ett terminalfönster och distribuera bara uppdateringarna till `core` modul som använder Maven `autoInstallBundle` från `core` katalog.

   ```shell
   $ cd core/
   $ mvn clean install -PautoInstallBundle
   ```

## Sammanställ allt {#put-together}

1. Återgå till AEM och öppna SPA som har `Banner` -komponenten.
1. Uppdatera `Banner` komponent som ska inkluderas **Banderolltext**:

   ![Banderolltext](assets/extend-component/banner-text-dialog.png)

1. Fyll komponenten med en bild:

   ![Lägg till bild i banderolldialogrutan](assets/extend-component/banner-dialog-image.png)

   Spara uppdateringarna i dialogrutan.

1. Du bör nu se det återgivna värdet för **Banderolltext**:

![Banderolltext visas](assets/extend-component/banner-text-displayed.png)

1. Visa JSON-modellsvaret på: [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json) och söka efter `wknd-spa-react/components/card`:

   ```json
   "banner": {
       "bannerText": "My Banner Text",
       "src": "/content/wknd-spa-react/us/en/home/_jcr_content/root/responsivegrid/banner.coreimg.jpeg/1622167884688/sport-climbing.jpeg",
       "alt": "alt banner rock climber",
       ":type": "wknd-spa-react/components/banner"
    },
   ```

   Observera att JSON-modellen uppdateras med ytterligare nyckel-/värdepar efter implementering av Sling-modellen i `BannerModelImpl.java`.

## Grattis! {#congratulations}

Grattis! Du lärde dig att utöka en AEM med hjälp av och hur Sling-modeller och dialogrutor fungerar med JSON-modellen.
