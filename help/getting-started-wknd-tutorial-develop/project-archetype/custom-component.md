---
title: Egen komponent
description: Täcker det kompletta skapandet av en anpassad bytekomponent som visar redigerat innehåll. Innehåller utveckling av en Sling-modell för inkapsling av affärslogik för att fylla i den inkapslade komponenten och motsvarande HTML för återgivning av komponenten.
version: 6.5, Cloud Service
feature: Core Components, APIs
topic: Content Management, Development
role: Developer
level: Beginner
jira: KT-4072
mini-toc-levels: 1
thumbnail: 30181.jpg
doc-type: Tutorial
exl-id: f54f3dc9-6ec6-4e55-9043-7a006840c905
duration: 1270
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '3869'
ht-degree: 0%

---

# Egen komponent {#custom-component}

Den här självstudiekursen handlar om hur du skapar en egen `Byline` AEM Component (Komponent) som visar innehåll som har skapats i en dialogruta, och som utforskar utvecklingen av en Sling-modell för att kapsla in affärslogik som fyller i komponentens HTML-kod.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Startprojekt

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Kolla in `tutorial/custom-component-start` förgrening från [GitHub](https://github.com/adobe/aem-guides-wknd)

   ```shell
   $ cd aem-guides-wknd
   $ git checkout tutorial/custom-component-start
   ```

1. Distribuera kodbasen till en lokal AEM med dina Maven-kunskaper:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 ska du lägga till `classic` för alla Maven-kommandon.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/custom-component-solution) eller checka ut koden lokalt genom att växla till grenen `tutorial/custom-component-solution`.

## Syfte

1. Förstå hur du skapar en anpassad AEM
1. Lär dig kapsla in affärslogik med Sling Models
1. Förstå hur du använder en segmenteringsmodell i ett HTML-skript

## Vad du ska bygga {#what-build}

I den här delen av WKND-självstudien skapas en Byline-komponent som används för att visa redigerad information om en artikels medverkande.

![exempel på byline-komponent](assets/custom-component/byline-design.png)

*Byline-komponent*

Implementeringen av komponenten Byline innehåller en dialogruta som samlar in innehållet och en anpassad Sling-modell som hämtar information som:

* Namn
* Bild
* Yrken

## Skapa Byline-komponent {#create-byline-component}

Skapa först nodstrukturen för Byline-komponenten och definiera en dialogruta. Detta representerar komponenten i AEM och definierar implicit komponentens resurstyp genom sin placering i JCR-läsaren.

Dialogrutan visar gränssnittet som innehållsförfattare kan använda. För den här implementeringen AEM WCM Core Component **Bild** -komponenten används för att hantera redigering och återgivning av Byline-bilden, så den måste anges som den här komponentens `sling:resourceSuperType`.

### Skapa komponentdefinition {#create-component-definition}

1. I **ui.apps** modul, navigera till `/apps/wknd/components` och skapa en mapp med namnet `byline`.
1. Innanför `byline` mapp, lägga till en fil med namnet `.content.xml`

   ![dialogruta för att skapa nod](assets/custom-component/byline-node-creation.png)

1. Fyll i `.content.xml` fil med följande:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
       <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Byline"
       jcr:description="Displays a contributor's byline."
       componentGroup="WKND Sites Project - Content"
       sling:resourceSuperType="core/wcm/components/image/v2/image"/>
   ```

   Ovanstående XML-fil innehåller definitionen för komponenten, inklusive rubrik, beskrivning och grupp. The `sling:resourceSuperType` pekar på `core/wcm/components/image/v2/image`, vilket är [Core Image Component](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/image.html).

### Skapa HTML-skriptet {#create-the-htl-script}

1. Innanför `byline` mapp, lägga till en fil `byline.html`, som ansvarar för komponentens HTML-presentation. Det är viktigt att ge filen samma namn som mappen eftersom det blir standardskriptet som Sling använder för att återge den här resurstypen.

1. Lägg till följande kod i `byline.html`.

   ```html
   <!--/* byline.html */-->
   <div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html">
   </div>
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=true}"></sly>
   ```

The `byline.html` är [granskad senare](#byline-htl)när Sling Model har skapats. HTML-filens aktuella läge gör att komponenten kan visas i ett tomt läge i AEM Sites sidredigerare när den dras och släpps på sidan.

### Skapa dialogdefinitionen {#create-the-dialog-definition}

Definiera sedan en dialogruta för den inbyggda komponenten med följande fält:

* **Namn**: ett textfält som medarbetarens namn tillhör.
* **Bild**: en referens till medverkarens biobild.
* **Yrken**: en lista över yrken som tillskrivs medarbetaren. Ytor ska sorteras alfabetiskt i stigande ordning (a till z).

1. Innanför `byline` mapp, skapa en mapp med namnet `_cq_dialog`.
1. Innanför `byline/_cq_dialog`, lägga till en fil med namnet `.content.xml`. Det här är XML-definitionen för dialogrutan. Lägg till följande XML:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
           jcr:primaryType="nt:unstructured"
           jcr:title="Byline"
           sling:resourceType="cq/gui/components/authoring/dialog">
       <content
               jcr:primaryType="nt:unstructured"
               sling:resourceType="granite/ui/components/coral/foundation/container">
           <items jcr:primaryType="nt:unstructured">
               <tabs
                       jcr:primaryType="nt:unstructured"
                       sling:resourceType="granite/ui/components/coral/foundation/tabs"
                       maximized="{Boolean}false">
                   <items jcr:primaryType="nt:unstructured">
                       <asset
                               jcr:primaryType="nt:unstructured"
                               sling:hideResource="{Boolean}false"/>
                       <metadata
                               jcr:primaryType="nt:unstructured"
                               sling:hideResource="{Boolean}true"/>
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
                                               <name
                                                       jcr:primaryType="nt:unstructured"
                                                       sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                                                       emptyText="Enter the contributor's name to display."
                                                       fieldDescription="The contributor's name to display."
                                                       fieldLabel="Name"
                                                       name="./name"
                                                       required="{Boolean}true"/>
                                               <occupations
                                                       jcr:primaryType="nt:unstructured"
                                                       sling:resourceType="granite/ui/components/coral/foundation/form/multifield"
                                                       fieldDescription="A list of the contributor's occupations."
                                                       fieldLabel="Occupations"
                                                       required="{Boolean}false">
                                                   <field
                                                           jcr:primaryType="nt:unstructured"
                                                           sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                                                           emptyText="Enter an occupation"
                                                           name="./occupations"/>
                                               </occupations>
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

   De här noddefinitionerna i dialogrutan använder [Samla resurser](https://sling.apache.org/documentation/bundles/resource-merger.html) för att styra vilka dialogrutor som ärvs från `sling:resourceSuperType` -komponenten, i det här fallet **Komponenten Core Components&#39; Image**.

   ![slutförd dialogruta för byline](assets/custom-component/byline-dialog-created.png)

### Skapa dialogrutan Princip {#create-the-policy-dialog}

På samma sätt som när du skapar en dialogruta skapar du en principdialogruta (tidigare kallad designdialogruta) som döljer oönskade fält i principkonfigurationen som ärvts från kärnkomponentens image-komponent.

1. Innanför `byline` mapp, skapa en mapp med namnet `_cq_design_dialog`.
1. Innanför `byline/_cq_design_dialog`, skapa en fil med namnet `.content.xml`. Uppdatera filen med följande: med följande XML. Det är enklast att öppna `.content.xml` och kopiera/klistra in XML-koden nedan i den.

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:granite="http://www.adobe.com/jcr/granite/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="nt:unstructured"
       jcr:title="Byline"
       sling:resourceType="cq/gui/components/authoring/dialog">
       <content
               jcr:primaryType="nt:unstructured">
           <items jcr:primaryType="nt:unstructured">
               <tabs
                       jcr:primaryType="nt:unstructured">
                   <items jcr:primaryType="nt:unstructured">
                       <properties
                               jcr:primaryType="nt:unstructured">
                           <items jcr:primaryType="nt:unstructured">
                               <content
                                       jcr:primaryType="nt:unstructured">
                                   <items jcr:primaryType="nt:unstructured">
                                       <decorative
                                               jcr:primaryType="nt:unstructured"
                                               sling:hideResource="{Boolean}true"/>
                                       <altValueFromDAM
                                               jcr:primaryType="nt:unstructured"
                                               sling:hideResource="{Boolean}true"/>
                                       <titleValueFromDAM
                                               jcr:primaryType="nt:unstructured"
                                               sling:hideResource="{Boolean}true"/>
                                       <displayCaptionPopup
                                               jcr:primaryType="nt:unstructured"
                                               sling:hideResource="{Boolean}true"/>
                                       <disableUuidTracking
                                               jcr:primaryType="nt:unstructured"
                                               sling:hideResource="{Boolean}true"/>
                                   </items>
                               </content>
                           </items>
                       </properties>
                       <features
                               jcr:primaryType="nt:unstructured">
                           <items jcr:primaryType="nt:unstructured">
                               <content
                                       jcr:primaryType="nt:unstructured">
                                   <items jcr:primaryType="nt:unstructured">
                                       <accordion
                                               jcr:primaryType="nt:unstructured">
                                           <items jcr:primaryType="nt:unstructured">
                                               <orientation
                                                       jcr:primaryType="nt:unstructured"
                                                       sling:hideResource="{Boolean}true"/>
                                               <crop
                                                       jcr:primaryType="nt:unstructured"
                                                       sling:hideResource="{Boolean}true"/>
                                           </items>
                                       </accordion>
                                   </items>
                               </content>
                           </items>
                       </features>
                   </items>
               </tabs>
           </items>
       </content>
   </jcr:root>
   ```

   Grunden för föregående **Dialogrutan Princip** XML hämtades från [Komponenten Core Components Image](https://github.com/adobe/aem-core-wcm-components/blob/main/content/src/content/jcr_root/apps/core/wcm/components/image/v2/image/_cq_design_dialog/.content.xml).

   Precis som i Dialog-konfigurationen [Samla resurser](https://sling.apache.org/documentation/bundles/resource-merger.html) används för att dölja irrelevanta fält som annars ärvs från `sling:resourceSuperType`, som noddefinitionerna visar med `sling:hideResource="{Boolean}true"` -egenskap.

### Distribuera koden {#deploy-the-code}

1. Synkronisera ändringarna i `ui.apps` med din utvecklingsmiljö eller dina Maven-kunskaper.

   ![Exportera till AEM serverkomponent](assets/custom-component/export-byline-component-aem.png)

## Lägga till komponenten på en sida {#add-the-component-to-a-page}

Om du vill hålla saker enkla och fokusera på AEM komponentutveckling kan du lägga till komponenten Byline i det aktuella läget på en artikelsida för att verifiera `cq:Component` noddefinitionen är korrekt. Verifiera också att AEM känner igen den nya komponentdefinitionen och att komponentens dialogruta fungerar för redigering.

### Lägga till en bild i AEM Assets

Ladda först upp ett provhuvud som tagits till AEM Assets för att fylla i bilden i Byline-komponenten.

1. Gå till mappen LA Skateparks i AEM Assets: [http://localhost:4502/assets.html/content/dam/wknd/en/magazine/la-skateparks](http://localhost:4502/assets.html/content/dam/wknd/en/magazine/la-skateparks).

1. Ladda upp huvudbilden för  **[stacey-roswells.jpg](assets/custom-component/stacey-roswells.jpg)** till mappen.

   ![Headshot uploaded to AEM Assets](assets/custom-component/stacey-roswell-headshot-assets.png)

### Skapa komponenten {#author-the-component}

Lägg sedan till komponenten Byline på en sida i AEM. Eftersom komponenten Byline läggs till i **WKND Sites Project - Content** Komponentgrupp, via `ui.apps/src/main/content/jcr_root/apps/wknd/components/byline/.content.xml` definition, den blir automatiskt tillgänglig för alla **Behållare** vars **Policy** tillåter **WKND Sites Project - Content** komponentgrupp. Det är alltså tillgängligt i artikelsidans layoutbehållare.

1. Gå till LA Skatepark-artikeln på: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html)

1. Dra och släpp en **Byline-komponent** till **nederkant** i layoutbehållaren för den öppnade artikelsidan.

   ![lägg till en bitlinjekomponent på sidan](assets/custom-component/add-to-page.png)

1. Kontrollera att vänster sidofält är öppet **och synliga, och** Resurssökaren** har valts.

1. Välj **Platshållare för lönekomponent**, som i sin tur visar åtgärdsfältet och trycker på **wrench** för att öppna dialogrutan.

1. Öppna dialogrutan och den första fliken (Tillgång) aktiv, öppna det vänstra sidofältet och dra en bild till bildens släppzon från resurssökaren. Sök efter&quot;stacey&quot; för att hitta biobilden Stacey Roswells som finns i WKND-paketet ui.content.

   ![lägg till bild i dialogruta](assets/custom-component/add-image.png)

1. När du har lagt till en bild klickar du på **Egenskaper** för att ange **Namn** och **Yrken**.

   När du anger yrken anger du dem i **omvänd alfabetisk ordning** så att den alfabetiska affärslogik som implementeras i Sling Model verifieras.

   Tryck på **Klar** längst ned till höger för att spara ändringarna.

   ![fyll i egenskaper för instickskomponenten](assets/custom-component/add-properties.png)

   AEM konfigurerar och redigerar komponenter via dialogrutorna. I nuläget ingår dialogrutorna för datainsamling i utvecklingen av komponenten Byline, men logiken för att återge det redigerade innehållet har ännu inte lagts till. Därför visas bara platshållaren.

1. När du har sparat dialogrutan går du till [CRXDE Lite](http://localhost:4502/crx/de/index.jsp#/content/wknd/us/en/magazine/guide-la-skateparks/jcr%3Acontent/root/container/container/byline) och granska hur komponentens innehåll lagras på innehållsnoden för instickskomponenten under AEM.

   Hitta innehållsnoden för komponenten Byline under sidan LA Skate Parks, dvs. `/content/wknd/us/en/magazine/guide-la-skateparks/jcr:content/root/container/container/byline`.

   Observera egenskapsnamnen `name`, `occupations`och `fileReference` lagras på **byline-nod**.

   Lägg också märke till `sling:resourceType` för noden är inställd på `wknd/components/content/byline` vilket är vad som binder den här innehållsnoden till implementeringen av komponenten Byline.

   ![bytegenskaper i CRXDE](assets/custom-component/byline-properties-crxde.png)

## Skapa Byline Sling Model {#create-sling-model}

Sedan skapar vi en Sling-modell som fungerar som datamodell och lagrar affärslogiken för Byline-komponenten.

Sling Models är anteckningsdrivna Java™ POJOs (Plain Old Java™ Objects) som gör det enklare att mappa data från JCR till Java™-variabler och som ger ökad effektivitet vid utveckling i AEM.

### Granska Maven Dependencies {#maven-dependency}

Byline Sling Model bygger på flera Java™-API:er från AEM. Dessa API:er är tillgängliga via `dependencies` som anges i `core` modulens POM-fil. Det projekt som används för den här självstudiekursen har skapats för AEM as a Cloud Service. Den är dock unik eftersom den är bakåtkompatibel med AEM 6.5/6.4. Därför ingår både beroenden för Cloud Service och AEM 6.x.

1. Öppna `pom.xml` fil under `<src>/aem-guides-wknd/core/pom.xml`.
1. Hitta beroendet för `aem-sdk-api` - **Endast AEM as a Cloud Service**

   ```xml
   <dependency>
       <groupId>com.adobe.aem</groupId>
       <artifactId>aem-sdk-api</artifactId>
   </dependency>
   ```

   The [aem-sdk-api](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/aem-as-a-cloud-service-sdk.html?lang=en) innehåller alla offentliga Java™-API:er som exponeras av AEM. The `aem-sdk-api` används som standard när du skapar det här projektet. Versionen finns kvar i den överordnade reaktorversionen från projektets rot på `aem-guides-wknd/pom.xml`.

1. Hitta beroendet för `uber-jar` - **Endast AEM 6.5/6.4**

   ```xml
   ...
       <dependency>
           <groupId>com.adobe.aem</groupId>
           <artifactId>uber-jar</artifactId>
           <classifier>apis</classifier>
       </dependency>
   ...
   ```

   The `uber-jar` tas endast med när `classic` profilen anropas, dvs `mvn clean install -PautoInstallSinglePackage -Pclassic`. Detta är unikt för det här projektet. I ett verkligt projekt som genererats av AEM Project Archetype `uber-jar` är standard om den angivna AEM är 6.5 eller 6.4.

   The [uber-jar](https://experienceleague.adobe.com/docs/experience-manager-65/developing/devtools/ht-projects-maven.html#experience-manager-api-dependencies) innehåller alla Java™-API:er som exponeras av AEM 6.x. Versionen bibehålls i den överordnade reaktorversionen från projektets rot `aem-guides-wknd/pom.xml`.

1. Hitta beroendet för `core.wcm.components.core`:

   ```xml
    <!-- Core Component Dependency -->
       <dependency>
           <groupId>com.adobe.cq</groupId>
           <artifactId>core.wcm.components.core</artifactId>
       </dependency>
   ```

   Detta är de fullständiga Java™-API:erna som exponeras av AEM Core Components. AEM kärnkomponenter är ett projekt som underhålls utanför AEM och därför har en separat releasecykel. Därför är det ett beroende som måste tas med separat och är **not** ingår i `uber-jar` eller `aem-sdk-api`.

   Precis som för uber-jar finns versionen för det här beroendet kvar i den överordnade reaktorns PDF-fil från `aem-guides-wknd/pom.xml`.

   Senare i den här självstudiekursen används klassen Core Component Image för att visa bilden i komponenten Byline. Det är nödvändigt att ha beroendet av kärnkomponenten för att kunna skapa och kompilera Sling-modellen.

### Byline-gränssnitt {#byline-interface}

Skapa ett publikt Java™-gränssnitt för Byline. The `Byline.java` definierar de publika metoder som krävs för att köra `byline.html` HTL-skript.

1. Insidan av `core` i `core/src/main/java/com/adobe/aem/guides/wknd/core/models` mapp skapa en fil med namnet `Byline.java`

   ![skapa ett nytt gränssnitt](assets/custom-component/create-byline-interface.png)

1. Uppdatera `Byline.java` med följande metoder:

   ```java
   package com.adobe.aem.guides.wknd.core.models;
   
   import java.util.List;
   
   /**
   * Represents the Byline AEM Component for the WKND Site project.
   **/
   public interface Byline {
       /***
       * @return a string to display as the name.
       */
       String getName();
   
       /***
       * Occupations are to be sorted alphabetically in a descending order.
       *
       * @return a list of occupations.
       */
       List<String> getOccupations();
   
       /***
       * @return a boolean if the component has enough content to display.
       */
       boolean isEmpty();
   }
   ```

   De första två metoderna visar värdena för **name** och **yrken** för komponenten Byline.

   The `isEmpty()` -metoden används för att avgöra om komponenten har något innehåll att återge eller om den väntar på att konfigureras.

   Observera att det inte finns någon metod för bilden. [detta granskas senare](#tackling-the-image-problem).

1. Java™-paket som innehåller publika Java™-klasser, i det här fallet en Sling-modell, måste versionshanteras med paketets  `package-info.java` -fil.

   Sedan WKND-källans Java™-paket `com.adobe.aem.guides.wknd.core.models` deklarerar version av `1.0.0`, och ett hårt offentligt gränssnitt och metoder läggs till, måste versionen ökas till `1.1.0`. Öppna filen på `core/src/main/java/com/adobe/aem/guides/wknd/core/models/package-info.java` och uppdatera `@Version("1.0.0")` till `@Version("2.1.0")`.

   ```
   @Version("2.1.0")
   package com.adobe.aem.guides.wknd.core.models;
   
   import org.osgi.annotation.versioning.Version;
   ```

När filerna i det här paketet ändras [paketversionen måste justeras semantiskt](https://semver.org/). Om inte, Maven-projektets [bnd-baseline-maven-plugin](https://github.com/bndtools/bnd) identifierar en ogiltig paketversion och bryter den skapade versionen. Som tur är rapporterar Maven-pluginen den ogiltiga Java™-paketversionen och den version den ska vara. Uppdatera `@Version("...")` -deklarationen i Java™-paketets `package-info.java` till den version som rekommenderas av det plugin-program som ska korrigeras.

### Byline implementation {#byline-implementation}

The `BylineImpl.java` är implementeringen av Sling-modellen som implementerar `Byline.java` tidigare definierat gränssnitt. Den fullständiga koden för `BylineImpl.java` finns längst ned i det här avsnittet.

1. Skapa en mapp med namnet `impl` under `core/src/main/java/com/adobe/aem/guides/core/models`.
1. I `impl` mapp, skapa en fil `BylineImpl.java`.

   ![Byline Impl-fil](assets/custom-component/byline-impl-file.png)

1. Öppna `BylineImpl.java`. Ange att den implementerar `Byline` gränssnitt. Använd de automatiska funktionerna för IDE eller uppdatera filen manuellt för att inkludera de metoder som krävs för att implementera `Byline` gränssnitt:

   ```java
   package com.adobe.aem.guides.wknd.core.models.impl;
   import java.util.List;
   import com.adobe.aem.guides.wknd.core.models.Byline;
   
   public class BylineImpl implements Byline {
   
       @Override
       public String getName() {
           // TODO Auto-generated method stub
           return null;
       }
   
       @Override
       public List<String> getOccupations() {
           // TODO Auto-generated method stub
           return null;
       }
   
       @Override
       public boolean isEmpty() {
           // TODO Auto-generated method stub
           return false;
       }
   }
   ```

1. Lägga till Sling-modellanteckningar genom att uppdatera `BylineImpl.java` med följande anteckningar på klassnivå. Detta `@Model(..)`anteckningen är det som gör klassen till en Sling-modell.

   ```java
   import org.apache.sling.api.SlingHttpServletRequest;
   import org.apache.sling.models.annotations.Model;
   import org.apache.sling.models.annotations.DefaultInjectionStrategy;
   ...
   @Model(
           adaptables = {SlingHttpServletRequest.class},
           adapters = {Byline.class},
           resourceType = {BylineImpl.RESOURCE_TYPE},
           defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL
   )
   public class BylineImpl implements Byline {
       protected static final String RESOURCE_TYPE = "wknd/components/byline";
       ...
   }
   ```

   Låt oss granska den här kommentaren och dess parametrar:

   * The `@Model` Anteckningen registrerar BylineImpl som en Sling-modell när den distribueras till AEM.
   * The `adaptables` parametern anger att den här modellen kan anpassas av begäran.
   * The `adapters` -parametern tillåter att implementeringsklassen registreras under Byline-gränssnittet. Detta gör att HTML-skriptet kan anropa Sling-modellen via gränssnittet (i stället för direkt implementering). [Mer information om adaptrar finns här](https://sling.apache.org/documentation/bundles/models.html#specifying-an-alternate-adapter-class-since-110).
   * The `resourceType` pekar på Byline-komponentens resurstyp (skapades tidigare) och hjälper till att lösa rätt modell om det finns flera implementeringar. [Mer information om hur du associerar en modellklass med en resurstyp finns här](https://sling.apache.org/documentation/bundles/models.html#associating-a-model-class-with-a-resource-type-since-130).

### Implementera Sling Model-metoder {#implementing-the-sling-model-methods}

#### getName() {#implementing-get-name}

Den första metoden som implementeras är `getName()`returnerar det värde som lagras till bylines JCR-innehållsnod under egenskapen `name`.

För det här: `@ValueMapValue` Lingmodellanteckning används för att mata in värdet i ett Java™-fält med hjälp av Resursens ValueMap.


```java
import org.apache.sling.models.annotations.injectorspecific.ValueMapValue;

public class BylineImpl implements Byline {
    ...
    @ValueMapValue
    private String name;

    ...
    @Override
    public String getName() {
        return name;
    }
    ...
}
```

Eftersom JCR-egenskapen delar namn som Java™-fält (båda är &quot;name&quot;), `@ValueMapValue` löser automatiskt associationen och injicerar egenskapens värde i Java™-fältet.

#### getOccupations() {#implementing-get-occupations}

Nästa metod som ska implementeras är `getOccupations()`. Den här metoden läser in de yrken som lagras i JCR-egenskapen `occupations` och returnerar en sorterad (i bokstavsordning) samling av dem.

Använda samma teknik som beskrivs i `getName()` egenskapsvärdet kan injiceras i fältet för Sling-modellen.

När JCR-egenskapsvärdena är tillgängliga i Sling Model via det inmatade Java™-fältet `occupations`kan sorteringslogiken användas i `getOccupations()` -metod.


```java
import java.util.ArrayList;
import java.util.Collections;
  ...

public class BylineImpl implements Byline {
    ...
    @ValueMapValue
    private List<String> occupations;
    ...
    @Override
    public List<String> getOccupations() {
        if (occupations != null) {
            Collections.sort(occupations);
            return new ArrayList<String>(occupations);
        } else {
            return Collections.emptyList();
        }
    }
    ...
}
  ...
```


#### isEmpty() {#implementing-is-empty}

Den sista publika metoden är `isEmpty()` som bestämmer när komponenten ska se sig själv som&quot;tillräckligt skapad&quot; för att återges.

För den här komponenten är affärskraven alla tre fält, `name, image and occupations` måste fyllas i *före* komponenten kan återges.


```java
import org.apache.commons.lang3.StringUtils;
  ...
public class BylineImpl implements Byline {
    ...
    @Override
    public boolean isEmpty() {
        if (StringUtils.isBlank(name)) {
            // Name is missing, but required
            return true;
        } else if (occupations == null || occupations.isEmpty()) {
            // At least one occupation is required
            return true;
        } else if (/* image is not null, logic to be determined */) {
            // A valid image is required
            return true;
        } else {
            // Everything is populated, so this component is not considered empty
            return false;
        }
    }
    ...
}
```


#### Hantering av &quot;Bildproblem&quot; {#tackling-the-image-problem}

Att kontrollera namn och yrkesförhållanden är enkelt och Apache Commons Lang3 är praktiskt [StringUtils](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html) klassen. Men det är oklart hur **bildens närvaro** kan valideras eftersom bildkomponenten Core Components används för att visa bilden.

Det finns två sätt att ta itu med detta:

Kontrollera om `fileReference` JCR-egenskapen löses till en resurs. *ELLER* Konvertera den här resursen till en Core Component Image Sling-modell och kontrollera att `getSrc()` -metoden är inte tom.

Låt oss använda **sekund** -strategi. Det första tillvägagångssättet är förmodligen tillräckligt, men i den här självstudien används det senare för att vi ska kunna utforska andra funktioner i Sling Models.

1. Skapa en privat metod som hämtar bilden. Den här metoden är privat eftersom det inte finns något behov av att visa bildobjektet i själva HTML-koden, och den används bara för att köra `isEmpty().`

   Lägg till följande privata metod för `getImage()`:

   ```java
   import com.adobe.cq.wcm.core.components.models.Image;
   ...
   private Image getImage() {
       Image image = null;
       // Figure out how to populate the image variable!
       return image;
   }
   ```

   Som tidigare nämnts finns det ytterligare två metoder för att få **Image Sling Model**:

   Den första använder `@Self` anteckning, för att automatiskt anpassa den aktuella begäran till kärnkomponentens `Image.class`

   Den andra använder [Apache Sling ModelFactory](https://sling.apache.org/apidocs/sling10/org/apache/sling/models/factory/ModelFactory.html) OSGi-tjänsten, som är en praktisk tjänst, och hjälper oss att skapa Sling-modeller av andra typer i Java™-kod.

   Låt oss använda den andra metoden.

   >[!NOTE]
   >
   >I en implementering i verkligheten använder du metoden&quot;One&quot; med `@Self` är att föredra eftersom det är en enklare och mer elegant lösning. I den här självstudiekursen används den andra metoden eftersom den kräver att du utforskar fler aspekter av Sling Models som är användbara är mer komplexa komponenter!

   Eftersom Sling Models är Java™ POJOs, inte OSGi Services, är de vanliga OSGi injektionsanteckningarna `@Reference` **inte** i stället, Sling Models ger **[@OSGiService](https://sling.apache.org/documentation/bundles/models.html#injector-specific-annotations)** anteckning som ger liknande funktioner.

1. Uppdatera `BylineImpl.java` som innehåller `OSGiService` anteckning för att mata in `ModelFactory`:

   ```java
   import org.apache.sling.models.factory.ModelFactory;
   import org.apache.sling.models.annotations.injectorspecific.OSGiService;
   ...
   public class BylineImpl implements Byline {
       ...
       @OSGiService
       private ModelFactory modelFactory;
   }
   ```

   Med `ModelFactory` som finns kan du skapa en Core Component Image Sling-modell med:

   ```java
   modelFactory.getModelFromWrappedRequest(SlingHttpServletRequest request, Resource resource, java.lang.Class<T> targetClass)
   ```

   Den här metoden kräver dock både en begäran och en resurs, som ännu inte är tillgänglig i Sling-modellen. Fler Sling Model-anteckningar används för att få dessa.

   Om du vill hämta den aktuella begäran **[@Self](https://sling.apache.org/documentation/bundles/models.html#injector-specific-annotations)** kan användas för att mata in `adaptable` (som definieras i `@Model(..)` as `SlingHttpServletRequest.class`, till ett Java™-klassfält.

1. Lägg till **@Self** anteckning för att hämta **SlingHttpServletRequest-begäran**:

   ```java
   import org.apache.sling.models.annotations.injectorspecific.Self;
   ...
   @Self
   private SlingHttpServletRequest request;
   ```

   Kom ihåg, använda `@Self Image image` för att injicera Core Component Image Sling Model var ett alternativ ovan - `@Self` Anteckningen försöker att mata in det anpassningsbara objektet (i det här fallet en SlingHttpServletRequest) och anpassa sig till anteckningens fälttyp. Eftersom Core Component Image Sling Model kan anpassas från SlingHttpServletRequest-objekt, har detta fungerat och är mindre kod än mer utforskande `modelFactory` -strategi.

   Nu injiceras de variabler som krävs för att instansiera Image-modellen via API:t ModelFactory. Låt oss använda Sling Model **[@PostConstruct](https://sling.apache.org/documentation/bundles/models.html#postconstruct-methods)** anteckning för att hämta det här objektet efter att Sling Model har instansierats.

   `@PostConstruct` är mycket användbart och fungerar i liknande kapacitet som en konstruktor, men anropas efter att klassen har initierats och alla kommenterade Java™-fält har injicerats. Andra Sling Model-anteckningar kommenterar Java™-klassfält (variabler). `@PostConstruct` annoterar en void-parametermetod, noll, som vanligtvis kallas `init()` (men kan namnges vad som helst).

1. Lägg till **@PostConstruct** metod:

   ```java
   import javax.annotation.PostConstruct;
   ...
   public class BylineImpl implements Byline {
       ...
       private Image image;
   
       @PostConstruct
       private void init() {
           image = modelFactory.getModelFromWrappedRequest(request,
                                                           request.getResource(),
                                                           Image.class);
       }
       ...
   }
   ```

   Kom ihåg att Sling Models är **NOT** OSGi Services, så det är säkert att underhålla klasstillstånd. Ojämna `@PostConstruct` hämtar och ställer in Sling Model-klasstillstånd för senare användning, på samma sätt som en vanlig konstruktor gör.

   Om `@PostConstruct` metoden genererar ett undantag, Sling Model instansieras inte och är null.

1. **getImage()** kan nu uppdateras för att returnera bildobjektet.

   ```java
   /**
       * @return the Image Sling Model of this resource, or null if the resource cannot create a valid Image Sling Model.
   */
   private Image getImage() {
       return image;
   }
   ```

1. Vi går tillbaka till `isEmpty()` och slutföra implementeringen:

   ```java
   @Override
   public boolean isEmpty() {
      final Image componentImage = getImage();
   
       if (StringUtils.isBlank(name)) {
           // Name is missing, but required
           return true;
       } else if (occupations == null || occupations.isEmpty()) {
           // At least one occupation is required
           return true;
       } else if (componentImage == null || StringUtils.isBlank(componentImage.getSrc())) {
           // A valid image is required
           return true;
       } else {
           // Everything is populated, so this component is not considered empty
           return false;
       }
   }
   ```

   Anteckna flera samtal till `getImage()` är inte problematisk eftersom returnerar den initierade `image` klassvariabel och anropar inte `modelFactory.getModelFromWrappedRequest(...)` vilket inte är något för dyrt, utan värt att undvika att ringa i onödan.

1. Den slutliga `BylineImpl.java` ska se ut så här:


   ```java
   package com.adobe.aem.guides.wknd.core.models.impl;
   
   import java.util.ArrayList;
   import java.util.Collections;
   import java.util.List;
   import javax.annotation.PostConstruct;
   import org.apache.commons.lang3.StringUtils;
   import org.apache.sling.api.SlingHttpServletRequest;
   import org.apache.sling.models.annotations.DefaultInjectionStrategy;
   import org.apache.sling.models.annotations.Model;
   import org.apache.sling.models.annotations.injectorspecific.OSGiService;
   import org.apache.sling.models.annotations.injectorspecific.Self;
   import org.apache.sling.models.annotations.injectorspecific.ValueMapValue;
   import org.apache.sling.models.factory.ModelFactory;
   import com.adobe.aem.guides.wknd.core.models.Byline;
   import com.adobe.cq.wcm.core.components.models.Image;
   
   @Model(
           adaptables = {SlingHttpServletRequest.class},
           adapters = {Byline.class},
           resourceType = {BylineImpl.RESOURCE_TYPE},
           defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL
   )
   public class BylineImpl implements Byline {
       protected static final String RESOURCE_TYPE = "wknd/components/byline";
   
       @Self
       private SlingHttpServletRequest request;
   
       @OSGiService
       private ModelFactory modelFactory;
   
       @ValueMapValue
       private String name;
   
       @ValueMapValue
       private List<String> occupations;
   
       private Image image;
   
       /**
       * @PostConstruct is immediately called after the class has been initialized
       * but BEFORE any of the other public methods. 
       * It is a good method to initialize variables that is used by methods in the rest of the model
       *
       */
       @PostConstruct
       private void init() {
           // set the image object
           image = modelFactory.getModelFromWrappedRequest(request, request.getResource(), Image.class);
       }
   
       @Override
       public String getName() {
           return name;
       }
   
       @Override
       public List<String> getOccupations() {
           if (occupations != null) {
               Collections.sort(occupations);
               return new ArrayList<String>(occupations);
           } else {
               return Collections.emptyList();
           }
       }
   
       @Override
       public boolean isEmpty() {
           final Image componentImage = getImage();
   
           if (StringUtils.isBlank(name)) {
               // Name is missing, but required
               return true;
           } else if (occupations == null || occupations.isEmpty()) {
               // At least one occupation is required
               return true;
           } else if (componentImage == null || StringUtils.isBlank(componentImage.getSrc())) {
               // A valid image is required
               return true;
           } else {
               // Everything is populated, so this component is not considered empty
               return false;
           }
       }
   
       /**
       * @return the Image Sling Model of this resource, or null if the resource cannot create a valid Image Sling Model.
       */
       private Image getImage() {
           return image;
       }
   }
   ```


## Byline HTML {#byline-htl}

I `ui.apps` modul, öppna `/apps/wknd/components/byline/byline.html` som skapades i den tidigare installationen av AEM.

```html
<div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html">
</div>
<sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=false}"></sly>
```

Låt oss se vad detta HTML-skript gör hittills:

* The `placeholderTemplate` pekar på Core Components platshållare, som visas när komponenten inte är helt konfigurerad. Det här återger i AEM Sites Page Editor som en ruta med komponenttiteln, enligt definitionen ovan i `cq:Component`&#39;s  `jcr:title` -egenskap.

* The `data-sly-call="${placeholderTemplate.placeholder @ isEmpty=false}` läser in `placeholderTemplate` definieras ovan och skickas i ett booleskt värde (för närvarande hårdkodat till `false`) till platshållarmallen. När `isEmpty` är true återges den grå rutan av platshållarmallen, annars återges ingenting.

### Uppdatera textmarkör-HTML

1. Uppdatera **byline.html** med följande HTML-struktur i skelettet:

   ```html
   <div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       class="cmp-byline">
           <div class="cmp-byline__image">
               <!--/* Include the Core Components Image Component */-->
           </div>
           <h2 class="cmp-byline__name"><!--/* Include the name */--></h2>
           <p class="cmp-byline__occupations"><!--/* Include the occupations */--></p>
   </div>
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=true}"></sly>
   ```

   Observera att CSS-klasserna följer [BEM-namnkonvention](https://getbem.com/naming/). BEM-konventioner är inte obligatoriska, men BEM rekommenderas eftersom det används i CSS-klasser för kärnkomponenter och i allmänhet leder till rena, läsbara CSS-regler.

### Instansierar Sling Model-objekt i HTML {#instantiating-sling-model-objects-in-htl}

The [Använd blockprogramsats](https://github.com/adobe/htl-spec/blob/master/SPECIFICATION.md#221-use) används för att instansiera Sling Model-objekt i HTL-skriptet och tilldela det till en HTL-variabel.

The `data-sly-use.byline="com.adobe.aem.guides.wknd.models.Byline"` använder Byline-gränssnittet (com.adobe.aem.guides.wknd.models.Byline) som implementeras av BylineImpl och anpassar aktuell SlingHttpServletRequest till det, och resultatet lagras i en Byline för HTL-variabelnamn ( `data-sly-use.<variable-name>`).

1. Uppdatera det yttre `div` referera till **Byline** Sling Model efter det publika gränssnittet:

   ```xml
   <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       class="cmp-byline">
       ...
   </div>
   ```

### Åtkomst till Sling Model-metoder {#accessing-sling-model-methods}

HTML lånar från JSTL och använder samma förkortning av Java™-get-metodnamn.

Anropa till exempel Byline Sling-modellens `getName()` metoden kan förkortas till `byline.name`, i stället för `byline.isEmpty`kan det här förkortas till `byline.empty`. Använda fullständiga metodnamn `byline.getName` eller `byline.isEmpty`, fungerar också. Anteckna `()` används aldrig för att anropa metoder i HTML (som JSTL).

Java™-metoder som kräver en parameter **inte** användas i HTML. Detta är utformat för att göra logiken i HTML enkel.

1. Du kan lägga till namnet Byline i komponenten genom att anropa `getName()` i Byline Sling Model eller i HTML: `${byline.name}`.

   Uppdatera `h2` tagg:

   ```xml
   <h2 class="cmp-byline__name">${byline.name}</h2>
   ```

### Använda alternativ för HTML-uttryck {#using-htl-expression-options}

[Alternativ för HTML-uttryck](https://github.com/adobe/htl-spec/blob/master/SPECIFICATION.md#12-available-expression-options) fungerar som modifierare för innehållet i HTML och varierar från datumformatering till i18n-översättning. Uttryck kan också användas för att sammanfoga listor eller värdematriser, vilket är vad som behövs för att visa arbetsuppgifterna i ett kommaavgränsat format.

Uttryck läggs till via `@` -operatorn i HTL-uttrycket.

1. Om du vill gå med i listan över yrken med &quot;, &quot; används följande kod:

   ```html
   <p class="cmp-byline__occupations">${byline.occupations @ join=', '}</p>
   ```

### Villkorlig visning av platshållaren {#conditionally-displaying-the-placeholder}

De flesta HTML-skript för AEM-komponenter använder **platshållarparadigm** för att skapa en visuell referenspunkt för författare **som anger att en komponent är felaktigt skapad och inte visas AEM publicering**. Konventionen för att driva detta beslut är att implementera en metod på komponentens bakomliggande Sling Model, i detta fall: `Byline.isEmpty()`.

The `isEmpty()` -metoden anropas i Byline Sling-modellen och resultatet (eller snarare negativt, via `!` operatorn) sparas till en HTML-variabel med namnet `hasContent`:

1. Uppdatera det yttre `div` spara en HTML-variabel med namnet `hasContent`:

   ```html
    <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
         data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
         data-sly-test.hasContent="${!byline.empty}"
         class="cmp-byline">
         ...
   </div>
   ```

   Observera användningen av `data-sly-test`, HTML `test` block is key, it both sets an HTL variable and renders/does not render the HTML element it is on. Den baseras på resultatet av utvärderingen av HTML-uttrycket. Om värdet är &quot;true&quot; återges elementet HTML, annars återges det inte.

   Denna HTML-variabel `hasContent` kan nu återanvändas för att villkorligt visa/dölja platshållaren.

1. Uppdatera det villkorliga anropet till `placeholderTemplate` längst ned i filen med följande:

   ```html
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!hasContent}"></sly>
   ```

### Visa bilden med hjälp av kärnkomponenter {#using-the-core-components-image}

HTML-skriptet för `byline.html` är nu nästan färdigt och bilden saknas bara.

Som `sling:resourceSuperType` pekar på kärnkomponentens Image-komponent för att skapa bilden. Core-komponentens Image-komponent kan användas för att återge bilden.

För detta ska vi inkludera den aktuella bylineresursen, men tvinga resurstypen för kärnkomponentens image-komponent, med hjälp av resurstypen `core/wcm/components/image/v2/image`. Det här är ett kraftfullt mönster för återanvändning av komponenter. För detta är HTML `data-sly-resource` -block används.

1. Ersätt `div` med en klass `cmp-byline__image` med följande:

   ```html
   <div class="cmp-byline__image"
       data-sly-resource="${ '.' @ resourceType = 'core/wcm/components/image/v2/image' }"></div>
   ```

   Detta `data-sly-resource`, inkluderar den aktuella resursen via den relativa sökvägen `'.'`och tvingar att den aktuella resursen (eller den ursprungliga innehållsresursen) inkluderas med resurstypen för `core/wcm/components/image/v2/image`.

   Core Component-resurstypen används direkt, inte via en proxy, eftersom detta är en skriptbaserad användning som aldrig bevaras i innehållet.

2. Slutförd `byline.html` nedan:

   ```html
   <!--/* byline.html */-->
   <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline" 
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       data-sly-test.hasContent="${!byline.empty}"
       class="cmp-byline">
       <div class="cmp-byline__image"
           data-sly-resource="${ '.' @ resourceType = 'core/wcm/components/image/v2/image' }">
       </div>
       <h2 class="cmp-byline__name">${byline.name}</h2>
       <p class="cmp-byline__occupations">${byline.occupations @ join=', '}</p>
   </div>
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!hasContent}"></sly>
   ```

3. Distribuera kodbasen till en lokal AEM. Sedan ändringarna gjordes `core` och `ui.apps` båda modulerna måste distribueras.

   ```shell
   $ cd aem-guides-wknd/ui.apps
   $ mvn clean install -PautoInstallPackage
   ```

   ```shell
   $ cd ../core
   $ mvn clean install -PautoInstallBundle
   ```

   För att distribuera till AEM 6.5/6.4 anropar du `classic` profil:

   ```shell
   $ cd ../core
   $ mvn clean install -PautoInstallBundle -Pclassic
   ```

   >[!CAUTION]
   >
   > Du kan också skapa hela projektet från roten med profilen Maven `autoInstallSinglePackage` men detta kan skriva över innehållsändringarna på sidan. Det beror på att `ui.content/src/main/content/META-INF/vault/filter.xml` har ändrats för att självstudiekursens startkod ska skriva över det befintliga AEM. I ett verkligt scenario är detta inte något problem.

### Granska den oformaterade Byline-komponenten {#reviewing-the-unstyled-byline-component}

1. När du distribuerat uppdateringen går du till [Ultimate Guide to LA Skateparks](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html) eller var du än lade till den inbyggda komponenten tidigare i kapitlet.

1. The **image**, **name** och **yrken** visas nu och är inte formaterad, men det finns en fungerande Byline-komponent.

   ![ej formaterad byline-komponent](assets/custom-component/unstyled.png)

### Granska registreringen av försäljningsmodellen {#reviewing-the-sling-model-registration}

The [Statusvy för AEM-webbkonsolens delningsmodeller](http://localhost:4502/system/console/status-slingmodels) visar alla registrerade Sling Models i AEM. Byline Sling Model kan valideras som installerad och identifieras genom att läsa den här listan.

Om **BylineImpl** visas inte i den här listan, det är troligtvis ett problem med Sling Model-anteckningarna eller modellen lades inte till i rätt paket (`com.adobe.aem.guides.wknd.core.models`) i kärnprojektet.

![Byline Sling Model är registrerad](assets/custom-component/osgi-sling-models.png)

*<http://localhost:4502/system/console/status-slingmodels>*

## Format för pyline {#byline-styles}

Om du vill justera den inbyggda komponenten mot den medföljande kreativa designen formaterar vi den. Detta uppnås genom att använda SCSS-filen och uppdatera filen i **ui.front** -modul.

### Lägga till ett standardformat

Lägg till standardstilar för komponenten Byline.

1. Återgå till utvecklingsmiljön och **ui.front** projekt under `/src/main/webpack/components`:
1. Skapa en fil med namnet `_byline.scss`.

   ![byline project explorer](assets/custom-component/byline-style-project-explorer.png)

1. Lägg till CSS-implementeringar (skrivna som SCSS) i dialogrutan `_byline.scss`:

   ```scss
   .cmp-byline {
       $imageSize: 60px;
   
       .cmp-byline__image {
           float: left;
   
       /* This class targets a Core Component Image CSS class */
       .cmp-image__image {
           width: $imageSize;
           height: $imageSize;
           border-radius: $imageSize / 2;
           object-fit: cover;
           }
       }
   
       .cmp-byline__name {
           font-size: $font-size-medium;
           font-family: $font-family-serif;
           padding-top: 0.5rem;
           margin-left: $imageSize + 25px;
           margin-bottom: .25rem;
           margin-top:0rem;
       }
   
       .cmp-byline__occupations {
           margin-left: $imageSize + 25px;
           color: $gray;
           font-size: $font-size-xsmall;
           text-transform: uppercase;
       }
   }
   ```

1. Öppna en terminal och navigera till `ui.frontend` -modul.
1. Starta `watch` bearbeta med följande npm-kommando:

   ```shell
   $ cd ui.frontend/
   $ npm run watch
   ```

1. Återgå till webbläsaren och navigera till [LA SkateParks-artikel](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html). Du bör se de uppdaterade formaten för komponenten.

   ![avslutad byline-komponent](assets/custom-component/final-byline-component.png)

   >[!TIP]
   >
   > Du kan behöva rensa webbläsarens cacheminne för att vara säker på att inaktuell CSS inte hanteras, och uppdatera sidan med den inbyggda komponenten för att få den fullständiga formateringen.

## Grattis! {#congratulations}

Grattis! Du har skapat en egen komponent från grunden med Adobe Experience Manager!

### Nästa steg {#next-steps}

Fortsätt att lära dig mer om AEM komponentutveckling genom att utforska hur du skriver JUnit-tester för Byline Java™-koden för att säkerställa att allt utvecklas på rätt sätt och att implementerad affärslogik är korrekt och fullständig.

* [Skriva enhetstester eller AEM](unit-testing.md)

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/custom-component-solution`.

1. Klona [github.com/adobe/aem-guides-wknd](https://github.com/adobe/aem-guides-wknd) databas.
1. Kolla in `tutorial/custom-component-solution` bankkontor
