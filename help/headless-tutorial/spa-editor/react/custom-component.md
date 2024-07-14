---
title: Skapa en anpassad väderkomponent | Komma igång med AEM SPA Editor och React
description: Lär dig hur du skapar en anpassad väderkomponent som ska användas med AEM SPA. Lär dig hur du utvecklar redigeringsdialogrutor och Sling-modeller för att utöka JSON-modellen så att den fyller i en anpassad komponent. Komponenterna Open Weather API och React Open Weather används.
feature: SPA Editor
version: Cloud Service
jira: KT-5878
thumbnail: 5878-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 82466e0e-b573-440d-b806-920f3585b638
duration: 323
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1105'
ht-degree: 0%

---

# Skapa en anpassad WeatherComponent {#custom-component}

Lär dig hur du skapar en anpassad väderkomponent som ska användas med AEM SPA. Lär dig hur du utvecklar redigeringsdialogrutor och Sling-modeller för att utöka JSON-modellen så att den fyller i en anpassad komponent. API:t [Open Weather ](https://openweathermap.org) och [React Open Weather ](https://www.npmjs.com/package/react-open-weather) används.

## Syfte

1. Förstå Sling Models roll när det gäller att hantera JSON-modellens API som tillhandahålls av AEM.
2. Lär dig hur du skapar nya AEM komponentdialogrutor.
3. Lär dig att skapa en **anpassad** AEM-komponent som är kompatibel med SPA redigeringsramverk.

## Vad du ska bygga

En enkel väderkomponent byggs. Den här komponenten kan läggas till i SPA av innehållsförfattare. Med hjälp av en AEM kan författare ange var vädret ska visas.  Implementeringen av den här komponenten illustrerar de steg som behövs för att skapa en ny AEM som är kompatibel med det AEM SPA redigeringsramverket.

![Konfigurera komponenten Open Weather](assets/custom-component/enter-dialog.png)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Det här kapitlet är en fortsättning på kapitlet [Navigering och routning](navigation-routing.md), men för att följa med i det du behöver finns ett SPA-aktiverat AEM-projekt som distribuerats till en lokal AEM.

### Öppna API-nyckel för väder

En API-nyckel från [Open Weather](https://openweathermap.org/) behövs för att följa med i självstudiekursen. [Registreringen är kostnadsfri](https://home.openweathermap.org/users/sign_up) för ett begränsat antal API-anrop.

## Definiera AEM

En AEM definieras som en nod och egenskaper. I projektet representeras dessa noder och egenskaper som XML-filer i modulen `ui.apps`. Skapa sedan AEM i modulen `ui.apps`.

>[!NOTE]
>
> En snabb uppdatering av [grunderna i AEM kan vara användbar](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/component-basics.html).

1. Öppna mappen `ui.apps` i den utvecklingsmiljö du väljer.
2. Navigera till `ui.apps/src/main/content/jcr_root/apps/wknd-spa-react/components` och skapa en ny mapp med namnet `open-weather`.
3. Skapa en ny fil med namnet `.content.xml` under mappen `open-weather`. Fyll i `open-weather/.content.xml` med följande:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Open Weather"
       componentGroup="WKND SPA React - Content"/>
   ```

   ![Skapa anpassad komponentdefinition](assets/custom-component/aem-custom-component-definition.png)

   `jcr:primaryType="cq:Component"` - identifierar att den här noden är en AEM.

   `jcr:title` är det värde som visas för innehållsförfattare och `componentGroup` bestämmer grupperingen av komponenter i redigeringsgränssnittet.

4. Skapa en annan mapp med namnet `_cq_dialog` under mappen `custom-component`.
5. Under mappen `_cq_dialog` skapar du en ny fil med namnet `.content.xml` och fyller i den med följande:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:granite="http://www.adobe.com/jcr/granite/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="nt:unstructured"
       jcr:title="Open Weather"
       sling:resourceType="cq/gui/components/authoring/dialog">
       <content
           jcr:primaryType="nt:unstructured"
           sling:resourceType="granite/ui/components/coral/foundation/container">
           <items jcr:primaryType="nt:unstructured">
               <tabs
                   jcr:primaryType="nt:unstructured"
                   sling:resourceType="granite/ui/components/coral/foundation/tabs"
                   maximized="{Boolean}true">
                   <items jcr:primaryType="nt:unstructured">
                       <properties
                           jcr:primaryType="nt:unstructured"
                           jcr:title="Properties"
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
                                               <label
                                                   jcr:primaryType="nt:unstructured"
                                                   sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                                                   fieldDescription="The label to display for the component"
                                                   fieldLabel="Label"
                                                   name="./label"/>
                                               <lat
                                                   jcr:primaryType="nt:unstructured"
                                                   sling:resourceType="granite/ui/components/coral/foundation/form/numberfield"
                                                   fieldDescription="The latitude of the location."
                                                   fieldLabel="Latitude"
                                                   step="any"
                                                   name="./lat" />
                                               <lon
                                                   jcr:primaryType="nt:unstructured"
                                                   sling:resourceType="granite/ui/components/coral/foundation/form/numberfield"
                                                   fieldDescription="The longitude of the location."
                                                   fieldLabel="Longitude"
                                                   step="any"
                                                   name="./lon"/>
                                           </items>
                                       </column>
                                   </items>
                               </columns>
                           </items>
                       </properties>
                   </items>
               </tabs>
           </items>
       </content>
   </jcr:root>
   ```

   ![Anpassad komponentdefinition](assets/custom-component/dialog-custom-component-defintion.png)

   XML-filen ovan genererar en mycket enkel dialogruta för `Weather Component`. Den kritiska delen av filen är noderna `<label>`, `<lat>` och `<lon>`. Den här dialogrutan innehåller två `numberfield` och en `textfield` som gör att en användare kan konfigurera vädret som ska visas.

   En Sling-modell skapas bredvid för att visa värdet för egenskaperna `label`, `lat` och `long` via JSON-modellen.

   >[!NOTE]
   >
   > Du kan visa fler [exempel på dialogrutor genom att visa Core Component Definition](https://github.com/adobe/aem-core-wcm-components/tree/master/content/src/content/jcr_root/apps/core/wcm/components). Du kan även visa ytterligare formulärfält, som `select`, `textarea`, `pathfield`, som är tillgängliga under `/libs/granite/ui/components/coral/foundation/form` i [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/libs/granite/ui/components/coral/foundation/form).

   I en traditionell AEM krävs vanligtvis ett [HTML](https://experienceleague.adobe.com/docs/experience-manager-htl/using/overview.html)-skript. Eftersom SPA återger komponenten behövs inget HTML-skript.

## Skapa segmentmodellen

Sling Models är anteckningsdrivna Java &quot;POJO&#39;s&quot; (Plain Old Java Objects) som underlättar mappningen av data från JCR till Java-variabler. [Sling Models](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/component-basics.html?lang=en#sling-models) fungerar vanligtvis för att kapsla in komplex affärslogik på serversidan för AEM komponenter.

I SPA Editor visar Sling Models en komponents innehåll via JSON-modellen via en funktion som använder [Sling Model Exporter](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/develop-sling-model-exporter.html).

1. Öppna modulen `core` på `aem-guides-wknd-spa.react/core` i den IDE du väljer.
1. Skapa en fil med namnet `OpenWeatherModel.java` vid `core/src/main/java/com/adobe/aem/guides/wkndspa/react/core/models`.
1. Fyll i `OpenWeatherModel.java` med följande:

   ```java
   package com.adobe.aem.guides.wkndspa.react.core.models;
   
   import com.adobe.cq.export.json.ComponentExporter;
   
   // Sling Models intended to be used with SPA Editor must extend ComponentExporter interface
   public interface OpenWeatherModel extends ComponentExporter {
       public String getLabel();
       public double getLat();
       public double getLon();
   }
   ```

   Detta är Java-gränssnittet för vår komponent. För att vår Sling Model ska vara kompatibel med SPA Editor-ramverket måste den utöka klassen `ComponentExporter`.

1. Skapa en mapp med namnet `impl` under `core/src/main/java/com/adobe/aem/guides/wkndspa/react/core/models`.
1. Skapa en fil med namnet `OpenWeatherModelImpl.java` under `impl` och fyll i med följande:

   ```java
   package com.adobe.aem.guides.wkndspa.react.core.models.impl;
   
   import org.apache.sling.models.annotations.*;
   import org.apache.sling.models.annotations.injectorspecific.ValueMapValue;
   import com.adobe.cq.export.json.ComponentExporter;
   import com.adobe.cq.export.json.ExporterConstants;
   import org.apache.commons.lang3.StringUtils;
   import org.apache.sling.api.SlingHttpServletRequest;
   import com.adobe.aem.guides.wkndspa.react.core.models.OpenWeatherModel;
   
   // Sling Model annotation
   @Model(
       adaptables = SlingHttpServletRequest.class, 
       adapters = { OpenWeatherModel.class, ComponentExporter.class }, 
       resourceType = OpenWeatherModelImpl.RESOURCE_TYPE, 
       defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL
   )
   @Exporter( //Exporter annotation that serializes the modoel as JSON
       name = ExporterConstants.SLING_MODEL_EXPORTER_NAME, 
       extensions = ExporterConstants.SLING_MODEL_EXTENSION
   )
   public class OpenWeatherModelImpl implements OpenWeatherModel {
   
       @ValueMapValue
       private String label; //maps variable to jcr property named "label" persisted by Dialog
   
       @ValueMapValue
       private double lat; //maps variable to jcr property named "lat"
   
       @ValueMapValue
       private double lon; //maps variable to jcr property named "lon"
   
       // points to AEM component definition in ui.apps
       static final String RESOURCE_TYPE = "wknd-spa-react/components/open-weather";
   
       // public getter method to expose value of private variable `label`
       // adds additional logic to default the label to "(Default)" if not set.
       @Override
       public String getLabel() {
           return StringUtils.isNotBlank(label) ? label : "(Default)";
       }
   
       // public getter method to expose value of private variable `lat`
       @Override
       public double getLat() {
           return lat;
       }
   
       // public getter method to expose value of private variable `lon`
       @Override
       public double getLon() {
           return lon;
       }
   
       // method required by `ComponentExporter` interface
       // exposes a JSON property named `:type` with a value of `wknd-spa-react/components/open-weather`
       // required to map the JSON export to the SPA component props via the `MapTo`
       @Override
       public String getExportedType() {
           return OpenWeatherModelImpl.RESOURCE_TYPE;
       }
   } 
   ```

   Den statiska variabeln `RESOURCE_TYPE` måste peka på sökvägen i `ui.apps` för komponenten. `getExportedType()` används för att mappa JSON-egenskaperna till SPA via `MapTo`. `@ValueMapValue` är en anteckning som läser jcr-egenskapen som har sparats i dialogrutan.

## Uppdatera SPA

Uppdatera sedan React-koden så att den innehåller komponenten [React Open Weather](https://www.npmjs.com/package/react-open-weather) och mappa den till AEM som skapades i föregående steg.

1. Installera komponenten React Open Weather som ett **npm** -beroende:

   ```shell
   $ cd aem-guides-wknd-spa.react/ui.frontend
   $ npm i react-open-weather
   ```

1. Skapa en ny mapp med namnet `OpenWeather` på `ui.frontend/src/components/OpenWeather`.
1. Lägg till en fil med namnet `OpenWeather.js` och fyll i den med följande:

   ```js
   import React from 'react';
   import {MapTo} from '@adobe/aem-react-editable-components';
   import ReactWeather, { useOpenWeather } from 'react-open-weather';
   
   // Open weather API Key
   // For simplicity it is hard coded in the file, ideally this is extracted in to an environment variable
   const API_KEY = 'YOUR_API_KEY';
   
   // Logic to render placeholder or component
   const OpenWeatherEditConfig = {
   
       emptyLabel: 'Weather',
       isEmpty: function(props) {
           return !props || !props.lat || !props.lon || !props.label;
       }
   };
   
   // Wrapper function that includes react-open-weather component
   function ReactWeatherWrapper(props) {
       const { data, isLoading, errorMessage } = useOpenWeather({
           key: API_KEY,
           lat: props.lat, // passed in from AEM JSON
           lon: props.lon, // passed in from AEM JSON
           lang: 'en',
           unit: 'imperial', // values are (metric, standard, imperial)
       });
   
       return (
           <div className="cmp-open-weather">
               <ReactWeather
                   isLoading={isLoading}
                   errorMessage={errorMessage}
                   data={data}
                   lang="en"
                   locationLabel={props.label} // passed in from AEM JSON
                   unitsLabels={{ temperature: 'F', windSpeed: 'mph' }}
                   showForecast={false}
                 />
           </div>
       );
   }
   
   export default function OpenWeather(props) {
   
           // render nothing if component not configured
           if (OpenWeatherEditConfig.isEmpty(props)) {
               return null;
           }
   
           // render ReactWeather component if component configured
           // pass props to ReactWeatherWrapper. These props include the mapped properties from AEM JSON
           return ReactWeatherWrapper(props);
   
   }
   
   // Map OpenWeather to AEM component
   MapTo('wknd-spa-react/components/open-weather')(OpenWeather, OpenWeatherEditConfig);
   ```

1. Uppdatera `import-components.js` vid `ui.frontend/src/components/import-components.js` för att inkludera komponenten `OpenWeather`:

   ```diff
     // import-component.js
     import './Container/Container';
     import './ExperienceFragment/ExperienceFragment';
   + import './OpenWeather/OpenWeather';
   ```

1. Distribuera alla uppdateringar i en lokal AEM från projektets rot med dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa.react
   $ mvn clean install -PautoInstallSinglePackage
   ```

## Uppdatera mallprincipen

Navigera sedan till AEM för att verifiera uppdateringarna och tillåt att komponenten `OpenWeather` läggs till i SPA.

1. Verifiera registreringen av den nya Sling-modellen genom att gå till [http://localhost:4502/system/console/status-slingmodels](http://localhost:4502/system/console/status-slingmodels).

   ```plain
   com.adobe.aem.guides.wkndspa.react.core.models.impl.OpenWeatherModelImpl - wknd-spa-react/components/open-weather
   
   com.adobe.aem.guides.wkndspa.react.core.models.impl.OpenWeatherModelImpl exports 'wknd-spa-react/components/open-weather' with selector 'model' and extension '[Ljava.lang.String;@2fd80fc5' with exporter 'jackson'
   ```

   Du bör se de två raderna ovan som anger att `OpenWeatherModelImpl` är associerad med komponenten `wknd-spa-react/components/open-weather` och att den är registrerad via Sling Model Exporter.

1. Navigera till SPA sidmall på [http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-react/settings/wcm/templates/spa-page-template/structure.html).
1. Uppdatera layoutbehållarens princip så att den nya `Open Weather` läggs till som en tillåten komponent:

   ![Uppdatera behållarprincipen för layout](assets/custom-component/custom-component-allowed.png)

   Spara ändringarna i principen och observera `Open Weather` som en tillåten komponent:

   ![Anpassad komponent som en tillåten komponent](assets/custom-component/custom-component-allowed-layout-container.png)

## Skapa komponenten Open Weather

Därefter redigerar du komponenten `Open Weather` med AEM SPA Editor.

1. Gå till [http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-react/us/en/home.html).
1. I `Edit`-läget lägger du till `Open Weather` i `Layout Container`:

   ![Infoga ny komponent](assets/custom-component/insert-custom-component.png)

1. Öppna komponentens dialogruta och ange en **etikett**, **Latitude** och **longitud**. Exempel: **San Diego**, **,32.7157** och **-117.1611**. Nummer på västra halvklotet och södra halvklotet representeras som negativa tal med Open Weather API

   ![Konfigurera komponenten Open Weather](assets/custom-component/enter-dialog.png)

   Det här är den dialogruta som skapades baserat på XML-filen tidigare i kapitlet.

1. Spara ändringarna. Observera att vädret för **San Diego** nu visas:

   ![Väderkomponenten har uppdaterats](assets/custom-component/weather-updated.png)

1. Visa JSON-modellen genom att gå till [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Sök efter `wknd-spa-react/components/open-weather`:

   ```json
   "open_weather": {
       "label": "San Diego",
       "lat": 32.7157,
       "lon": -117.1611,
       ":type": "wknd-spa-react/components/open-weather"
   }
   ```

   JSON-värdena genereras av Sling-modellen. Dessa JSON-värden skickas till React-komponenten som utkast.

## Grattis! {#congratulations}

Du har lärt dig att skapa en anpassad AEM som ska användas med SPA Editor. Du lärde dig också hur dialogrutor, JCR-egenskaper och Sling-modeller interagerar för att skapa JSON-modellen.

### Nästa steg {#next-steps}

[Utöka en kärnkomponent](extend-component.md) - Lär dig hur du utökar en befintlig AEM kärnkomponent som ska användas med AEM SPA. Att förstå hur du lägger till egenskaper och innehåll i en befintlig komponent är en kraftfull teknik som utökar funktionerna i en AEM redigeringsimplementering.
