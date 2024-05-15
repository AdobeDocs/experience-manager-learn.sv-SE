---
title: Skapa en anpassad komponent | Komma igång med AEM SPA Editor och Angular
description: Lär dig hur du skapar en anpassad komponent som ska användas med AEM SPA. Lär dig hur du utvecklar redigeringsdialogrutor och Sling-modeller för att utöka JSON-modellen så att den fyller i en anpassad komponent.
feature: SPA Editor
version: Cloud Service
jira: KT-5831
thumbnail: 5831-spa-angular.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 6c1c7f2b-f574-458c-b744-b92419c46f23
duration: 308
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1321'
ht-degree: 0%

---

# Skapa en anpassad komponent {#custom-component}

Lär dig hur du skapar en anpassad komponent som ska användas med AEM SPA. Lär dig hur du utvecklar redigeringsdialogrutor och Sling-modeller för att utöka JSON-modellen så att den fyller i en anpassad komponent.

## Syfte

1. Förstå Sling Models roll när det gäller att hantera JSON-modellens API som tillhandahålls av AEM.
2. Lär dig hur du skapar AEM komponentdialogrutor.
3. Lär dig skapa en **anpassad** AEM som är kompatibel med det SPA redigeringsramverket.

## Vad du ska bygga

Fokus på tidigare kapitel var att utveckla SPA komponenter och mappa dem till *befintlig* AEM kärnkomponenter. Det här kapitlet fokuserar på hur du skapar och utökar *new* AEM komponenter och manipulera JSON-modellen som hanteras av AEM.

Ett enkelt `Custom Component` visar de steg som behövs för att skapa en ny AEM.

![Meddelande som visas i versaler](assets/custom-component/message-displayed.png)

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Hämta koden

1. Hämta startpunkten för den här självstudiekursen via Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
   $ cd aem-guides-wknd-spa
   $ git checkout Angular/custom-component-start
   ```

2. Distribuera kodbasen till en lokal AEM med Maven:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Om du använder [AEM 6.x](overview.md#compatibility) lägg till `classic` profil:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

3. Installera det färdiga paketet för det traditionella [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest). Bilderna från [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest) återanvänds på WKND-SPA. Paketet kan installeras med [AEM](http://localhost:4502/crx/packmgr/index.jsp).

   ![Package Manager install wknd.all](./assets/map-components/package-manager-wknd-all.png)

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/custom-component-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/custom-component-solution`.

## Definiera AEM

En AEM definieras som en nod och egenskaper. I projektet representeras dessa noder och egenskaper som XML-filer i `ui.apps` -modul. Skapa sedan AEM i `ui.apps` -modul.

>[!NOTE]
>
> En snabb uppdatering på [AEM kan vara till hjälp](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/component-basics.html).

1. Öppna `ui.apps` i valfri IDE.
2. Navigera till `ui.apps/src/main/content/jcr_root/apps/wknd-spa-angular/components` och skapa en mapp med namnet `custom-component`.
3. Skapa en fil med namnet `.content.xml` under `custom-component` mapp. Fyll i `custom-component/.content.xml` med följande:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Custom Component"
       componentGroup="WKND SPA Angular - Content"/>
   ```

   ![Skapa anpassad komponentdefinition](assets/custom-component/aem-custom-component-definition.png)

   `jcr:primaryType="cq:Component"` - identifierar att den här noden är en AEM.

   `jcr:title` är värdet som visas för innehållsförfattare och `componentGroup` bestämmer grupperingen av komponenter i redigeringsgränssnittet.

4. Under `custom-component` mapp, skapa en annan mapp med namnet `_cq_dialog`.
5. Under `_cq_dialog` mapp skapa en fil med namnet `.content.xml` och fylla i den med följande:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:granite="http://www.adobe.com/jcr/granite/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="nt:unstructured"
       jcr:title="Custom Component"
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
                                               <message
                                                   jcr:primaryType="nt:unstructured"
                                                   sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                                                   fieldDescription="The text to display on the component."
                                                   fieldLabel="Message"
                                                   name="./message"/>
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

   XML-filen ovan genererar en enkel dialogruta för `Custom Component`. Den kritiska delen av filen är den inre `<message>` nod. Den här dialogrutan innehåller en enkel `textfield` namngiven `Message` och bibehåller textfältets värde för en egenskap med namnet `message`.

   En Sling-modell skapas bredvid för att visa värdet för `message` via JSON-modellen.

   >[!NOTE]
   >
   > Du kan visa mycket mer [exempel på dialogrutor genom att visa definitionerna för kärnkomponenten](https://github.com/adobe/aem-core-wcm-components/tree/master/content/src/content/jcr_root/apps/core/wcm/components). Du kan även visa ytterligare formulärfält, som `select`, `textarea`, `pathfield`, tillgängligt under `/libs/granite/ui/components/coral/foundation/form` in [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/libs/granite/ui/components/coral/foundation/form).

   Med en traditionell AEM [HTL](https://experienceleague.adobe.com/docs/experience-manager-htl/content/overview.html) skript krävs vanligtvis. Eftersom SPA återger komponenten behövs inget HTML-skript.

## Skapa segmentmodellen

Sling Models är annoteringsdrivna Java™ &quot;POJOs&quot; (Plain Old Java™ Objects) som gör det enklare att mappa data från JCR till Java™-variabler. [Sling Models](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/component-basics.html#sling-models) används vanligtvis för att kapsla in komplex affärslogik på serversidan för AEM.

I SPA Editor visar Sling Models en komponents innehåll via JSON-modellen via en funktion som använder [Export av försäljningsmodell](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/develop-sling-model-exporter.html).

1. I den utvecklingsmiljö du väljer öppnar du `core` -modul. `CustomComponent.java` och `CustomComponentImpl.java` har redan skapats och lagts till som en del av kapitelstartkoden.

   >[!NOTE]
   >
   > Om du använder Visual Studio Code IDE kan det vara praktiskt att installera [tillägg för Java™](https://code.visualstudio.com/docs/java/extensions).

2. Öppna Java™ `CustomComponent.java` på `core/src/main/java/com/adobe/aem/guides/wknd/spa/angular/core/models/CustomComponent.java`:

   ![Gränssnittet CustomComponent.java](assets/custom-component/custom-component-interface.png)

   Detta är det Java™-gränssnitt som implementeras av Sling Model.

3. Uppdatera `CustomComponent.java` så att den utökar `ComponentExporter` gränssnitt:

   ```java
   package com.adobe.aem.guides.wknd.spa.angular.core.models;
   import com.adobe.cq.export.json.ComponentExporter;
   
   public interface CustomComponent extends ComponentExporter {
   
       public String getMessage();
   
   }
   ```

   Implementera `ComponentExporter` -gränssnittet är ett krav för att Sling-modellen ska hämtas automatiskt av JSON-modellens API.

   The `CustomComponent` -gränssnittet innehåller en enda get-metod `getMessage()`. Det här är metoden som visar värdet för författardialogrutan via JSON-modellen. Endast get-metoder med tomma parametrar `()` exporteras i JSON-modellen.

4. Öppna `CustomComponentImpl.java` på `core/src/main/java/com/adobe/aem/guides/wknd/spa/angular/core/models/impl/CustomComponentImpl.java`.

   Detta är genomförandet av `CustomComponent` gränssnitt. The `@Model` kommentaren identifierar Java™-klassen som en Sling Model. The `@Exporter` Anteckning gör att Java™-klassen kan serialiseras och exporteras via Sling Model Exporter.

5. Uppdatera den statiska variabeln `RESOURCE_TYPE` för att peka på AEM `wknd-spa-angular/components/custom-component` som skapats i föregående övning.

   ```java
   static final String RESOURCE_TYPE = "wknd-spa-angular/components/custom-component";
   ```

   Komponentens resurstyp är den som binder Sling-modellen till AEM-komponenten och mappar slutligen till komponenten Angular.

6. Lägg till `getExportedType()` metoden till `CustomComponentImpl` klass som returnerar komponentresurstypen:

   ```java
   @Override
   public String getExportedType() {
       return CustomComponentImpl.RESOURCE_TYPE;
   }
   ```

   Den här metoden krävs vid implementering av `ComponentExporter` gränssnitt och visar den resurstyp som tillåter mappning till Angularna.

7. Uppdatera `getMessage()` metod som returnerar värdet för `message` egenskapen beständig av författardialogrutan. Använd `@ValueMap` anteckningen är mappad till JCR-värdet `message` till en Java™-variabel:

   ```java
   import org.apache.commons.lang3.StringUtils;
   ...
   
   @ValueMapValue
   private String message;
   
   @Override
   public String getMessage() {
       return StringUtils.isNotBlank(message) ? message.toUpperCase() : null;
   }
   ```

   Ytterligare&quot;affärslogik&quot; läggs till för att returnera värdet för meddelandet som versal. På så sätt kan vi se skillnaden mellan det råvärde som lagras av författardialogrutan och det värde som exponeras av Sling-modellen.

   >[!NOTE]
   >
   > Du kan visa [slut CustomComponentImpl.java här](https://github.com/adobe/aem-guides-wknd-spa/blob/Angular/custom-component-solution/core/src/main/java/com/adobe/aem/guides/wknd/spa/angular/core/models/impl/CustomComponentImpl.java).

## Uppdatera Angular-komponenten

Koden för den anpassade Angularna har redan skapats. Därefter gör du några uppdateringar för att mappa Angularna till AEM.

1. I `ui.frontend` öppna filen i modulen `ui.frontend/src/app/components/custom/custom.component.ts`
2. Observera `@Input() message: string;` linje. Det omformade versalvärdet förväntas mappas till den här variabeln.
3. Importera `MapTo` -objekt från AEM JS SDK för redigeraren och använd det för att mappa till den AEM komponenten:

   ```diff
   + import {MapTo} from '@adobe/cq-angular-editable-components';
   
    ...
    export class CustomComponent implements OnInit {
        ...
    }
   
   + MapTo('wknd-spa-angular/components/custom-component')(CustomComponent, CustomEditConfig);
   ```

4. Öppna `cutom.component.html` och observera att `{{message}}` visas på sidan en `<h2>` -tagg.
5. Öppna `custom.component.css` och lägg till följande regel:

   ```css
   :host-context {
       display: block;
   }
   ```

   För AEM Editor-platshållaren visas korrekt när komponenten är tom `:host-context` eller en annan `<div>` måste anges till `display: block;`.

6. Distribuera uppdateringarna i en lokal AEM från projektets rot med hjälp av dina Maven-kunskaper:

   ```shell
   $ cd aem-guides-wknd-spa
   $ mvn clean install -PautoInstallSinglePackage
   ```

## Uppdatera mallprincipen

Navigera sedan till AEM för att verifiera uppdateringarna och tillåta `Custom Component` som ska läggas till i SPA.

1. Verifiera registreringen av den nya Sling-modellen genom att navigera till [http://localhost:4502/system/console/status-slingmodels](http://localhost:4502/system/console/status-slingmodels).

   ```plain
   com.adobe.aem.guides.wknd.spa.angular.core.models.impl.CustomComponentImpl - wknd-spa-angular/components/custom-component
   
   com.adobe.aem.guides.wknd.spa.angular.core.models.impl.CustomComponentImpl exports 'wknd-spa-angular/components/custom-component' with selector 'model' and extension '[Ljava.lang.String;@6fb4a693' with exporter 'jackson'
   ```

   Du bör se de två raderna ovan som anger `CustomComponentImpl` är associerad med `wknd-spa-angular/components/custom-component` och att den är registrerad via Sling Model Exporter.

2. Navigera till SPA sidmall på [http://localhost:4502/editor.html/conf/wknd-spa-angular/settings/wcm/templates/spa-page-template/structure.html](http://localhost:4502/editor.html/conf/wknd-spa-angular/settings/wcm/templates/spa-page-template/structure.html).
3. Uppdatera layoutbehållarens profil för att lägga till den nya `Custom Component` som en tillåten komponent:

   ![Princip för behållare för uppdaterad layout](assets/custom-component/custom-component-allowed.png)

   Spara ändringarna i profilen och observera `Custom Component` som en tillåten komponent:

   ![Anpassad komponent som en tillåten komponent](assets/custom-component/custom-component-allowed-layout-container.png)

## Skapa den anpassade komponenten

Nästa steg är att skapa `Custom Component` med AEM SPA Editor.

1. Navigera till [http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html](http://localhost:4502/editor.html/content/wknd-spa-angular/us/en/home.html).
2. I `Edit` läge, lägga till `Custom Component` till `Layout Container`:

   ![Infoga ny komponent](assets/custom-component/insert-custom-component.png)

3. Öppna komponentens dialogruta och skriv ett meddelande som innehåller gemener.

   ![Konfigurera den anpassade komponenten](assets/custom-component/enter-dialog-message.png)

   Det här är den dialogruta som skapades baserat på XML-filen tidigare i kapitlet.

4. Spara ändringarna. Observera att det visade meddelandet är i versaler.

   ![Meddelande som visas i versaler](assets/custom-component/message-displayed.png)

5. Visa JSON-modellen genom att navigera till [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json). Sök efter `wknd-spa-angular/components/custom-component`:

   ```json
   "custom_component_208183317": {
       "message": "HELLO WORLD",
       ":type": "wknd-spa-angular/components/custom-component"
   }
   ```

   Observera att JSON-värdet är inställt på alla versala bokstäver baserat på den logik som lagts till i Sling-modellen.

## Grattis! {#congratulations}

Grattis! Du har lärt dig att skapa en anpassad AEM och att Sling-modeller och dialogrutor fungerar med JSON-modellen.

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd-spa/tree/Angular/custom-component-solution) eller checka ut koden lokalt genom att växla till grenen `Angular/custom-component-solution`.

### Nästa steg {#next-steps}

[Utöka en kärnkomponent](extend-component.md) - Lär dig hur du utökar en befintlig Core Component som ska användas med AEM SPA Editor. Att förstå hur du lägger till egenskaper och innehåll i en befintlig komponent är en kraftfull teknik som utökar funktionerna i en AEM redigeringsimplementering.
