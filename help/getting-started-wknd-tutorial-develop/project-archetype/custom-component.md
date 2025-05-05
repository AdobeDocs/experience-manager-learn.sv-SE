---
title: Egen komponent
description: Täcker det kompletta skapandet av en anpassad bytekomponent som visar redigerat innehåll. Innehåller utveckling av en Sling-modell för inkapsling av affärslogik för att fylla i den inkapslade komponenten och motsvarande HTML för återgivning av komponenten.
version: Experience Manager 6.5, Experience Manager as a Cloud Service
feature: Core Components, APIs
topic: Content Management, Development
role: Developer
level: Beginner
jira: KT-4072
mini-toc-levels: 1
thumbnail: 30181.jpg
doc-type: Tutorial
exl-id: f54f3dc9-6ec6-4e55-9043-7a006840c905
duration: 1039
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '3869'
ht-degree: 0%

---

# Egen komponent {#custom-component}

I den här självstudiekursen beskrivs hur du skapar en anpassad `Byline` AEM-komponent som visar innehåll som har skapats i en dialogruta och utforskar hur du utvecklar en delningsmodell för att kapsla in affärslogik som fyller i komponentens HTML-kod.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Startprojekt

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Kolla in grenen `tutorial/custom-component-start` från [GitHub](https://github.com/adobe/aem-guides-wknd)

   ```shell
   $ cd aem-guides-wknd
   $ git checkout tutorial/custom-component-start
   ```

1. Distribuera kodbasen till en lokal AEM-instans med dina Maven-kunskaper:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 lägger du till profilen `classic` till eventuella Maven-kommandon.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/custom-component-solution) eller checka ut koden lokalt genom att växla till grenen `tutorial/custom-component-solution`.

## Syfte

1. Förstå hur man bygger en anpassad AEM-komponent
1. Lär dig kapsla in affärslogik med Sling Models
1. Förstå hur du använder en segmenteringsmodell i ett HTML-skript

## Vad du ska bygga {#what-build}

I den här delen av WKND-självstudien skapas en Byline-komponent som används för att visa redigerad information om en artikels medverkande.

![exempel på instickskomponent](assets/custom-component/byline-design.png)

*Byline-komponent*

Implementeringen av komponenten Byline innehåller en dialogruta som samlar in innehållet och en anpassad Sling-modell som hämtar information som:

* Namn
* Bild
* Yrken

## Skapa Byline-komponent {#create-byline-component}

Skapa först nodstrukturen för Byline-komponenten och definiera en dialogruta. Detta representerar komponenterna i AEM och definierar implicit komponentens resurstyp genom sin placering i JCR.

Dialogrutan visar gränssnittet som innehållsförfattare kan använda. För den här implementeringen används AEM WCM Core Components **Image** -komponent för att hantera redigering och återgivning av Bylines bild, så den måste anges som den här komponentens `sling:resourceSuperType`.

### Skapa komponentdefinition {#create-component-definition}

1. Navigera till `/apps/wknd/components` i modulen **ui.apps** och skapa en mapp med namnet `byline`.
1. Lägg till en fil med namnet `.content.xml` i mappen `byline`

   ![dialogruta för att skapa nod](assets/custom-component/byline-node-creation.png)

1. Fyll i filen `.content.xml` med följande:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
       <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Byline"
       jcr:description="Displays a contributor's byline."
       componentGroup="WKND Sites Project - Content"
       sling:resourceSuperType="core/wcm/components/image/v2/image"/>
   ```

   Ovanstående XML-fil innehåller definitionen för komponenten, inklusive rubrik, beskrivning och grupp. `sling:resourceSuperType` pekar på `core/wcm/components/image/v2/image`, som är [kärnbildkomponenten](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/image.html?lang=sv-SE).

### Skapa HTML-skriptet {#create-the-htl-script}

1. I mappen `byline` lägger du till filen `byline.html` som ansvarar för komponentens HTML-presentation. Det är viktigt att ge filen samma namn som mappen eftersom det blir standardskriptet som Sling använder för att återge den här resurstypen.

1. Lägg till följande kod i `byline.html`.

   ```html
   <!--/* byline.html */-->
   <div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html">
   </div>
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=true}"></sly>
   ```

`byline.html` [revideras senare](#byline-htl) när delningsmodellen har skapats. HTML-filens aktuella läge gör att komponenten kan visas i ett tomt läge i AEM Sites sidredigerare när den dras och släpps på sidan.

### Skapa dialogdefinitionen {#create-the-dialog-definition}

Definiera sedan en dialogruta för den inbyggda komponenten med följande fält:

* **Namn**: ett textfält som medarbetarens namn tillhör.
* **Bild**: en referens till medarbetarens biobild.
* **Ytor**: en lista över yrken som har tilldelats medarbetaren. Ytor ska sorteras alfabetiskt i stigande ordning (a till z).

1. I mappen `byline` skapar du en mapp med namnet `_cq_dialog`.
1. I `byline/_cq_dialog` lägger du till en fil med namnet `.content.xml`. Det här är XML-definitionen för dialogrutan. Lägg till följande XML:

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

   De här noddefinitionerna i dialogrutan använder [Dela resurssammanfogning](https://sling.apache.org/documentation/bundles/resource-merger.html) för att kontrollera vilka dialogrutor som ärvs från komponenten `sling:resourceSuperType`, i det här fallet **kärnkomponenterna&#39; Image component** .

   ![slutförd dialogruta för byline](assets/custom-component/byline-dialog-created.png)

### Skapa dialogrutan Princip {#create-the-policy-dialog}

På samma sätt som när du skapar en dialogruta skapar du en principdialogruta (tidigare kallad designdialogruta) som döljer oönskade fält i principkonfigurationen som ärvts från kärnkomponentens image-komponent.

1. I mappen `byline` skapar du en mapp med namnet `_cq_design_dialog`.
1. I `byline/_cq_design_dialog` skapar du en fil med namnet `.content.xml`. Uppdatera filen med följande: med följande XML. Det är enklast att öppna `.content.xml` och kopiera/klistra in XML-filen nedan i den.

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

   Basen för föregående **principdialogruta** XML hämtades från [kärnkomponentavbildningskomponenten](https://github.com/adobe/aem-core-wcm-components/blob/main/content/src/content/jcr_root/apps/core/wcm/components/image/v2/image/_cq_design_dialog/.content.xml).

   Precis som i dialogrutan används [Dela resurssammanslagning](https://sling.apache.org/documentation/bundles/resource-merger.html) för att dölja irrelevanta fält som annars ärvs från `sling:resourceSuperType`, vilket visas i noddefinitionerna med egenskapen `sling:hideResource="{Boolean}true"`.

### Distribuera koden {#deploy-the-code}

1. Synkronisera ändringarna i `ui.apps` med din IDE eller med dina Maven-kunskaper.

   ![Exportera till AEM-serverns originalkomponent](assets/custom-component/export-byline-component-aem.png)

## Lägga till komponenten på en sida {#add-the-component-to-a-page}

Om du vill hålla saker enkla och fokusera på komponentutveckling för AEM lägger du till komponenten Byline i det aktuella läget på en artikelsida för att kontrollera att noddefinitionen `cq:Component` är korrekt. Verifiera också att AEM känner igen den nya komponentdefinitionen och att komponentens dialogruta fungerar för redigering.

### Lägga till en bild i AEM Assets

Ladda först upp ett provhuvud som tagits till AEM Assets för att fylla i bilden i Byline-komponenten.

1. Navigera till mappen LA Skateparks i AEM Assets: [http://localhost:4502/assets.html/content/dam/wknd/en/magazine/la-skateparks](http://localhost:4502/assets.html/content/dam/wknd/en/magazine/la-skateparks).

1. Överför huvudbilden för **[stacey-roswells.jpg](assets/custom-component/stacey-roswells.jpg)** till mappen.

   ![Headshot uploaded to AEM Assets](assets/custom-component/stacey-roswell-headshot-assets.png)

### Skapa komponenten {#author-the-component}

Lägg sedan till komponenten Byline på en sida i AEM. Eftersom komponenten Byline läggs till i komponentgruppen **WKND-platser - innehåll**, via definitionen `ui.apps/src/main/content/jcr_root/apps/wknd/components/byline/.content.xml`, är den automatiskt tillgänglig för alla **behållare** vars **princip** tillåter komponentgruppen **WKND-platser - innehåll** . Det är alltså tillgängligt i artikelsidans layoutbehållare.

1. Gå till LA Skatepark-artikeln på: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html)

1. Dra och släpp en **Byline-komponent** från vänster sidofält till **nederst** i layoutbehållaren för den öppnade artikelsidan.

   ![lägg till en instickskomponent på sidan](assets/custom-component/add-to-page.png)

1. Kontrollera att vänster sidofält är öppet **och synligt och att** Resurssökaren** är markerat.

1. Välj platshållaren **för instickskomponenten**, som i sin tur visar åtgärdsfältet och trycker på ikonen **skiftnyckel** för att öppna dialogrutan.

1. Öppna dialogrutan och den första fliken (Tillgång) aktiv, öppna det vänstra sidofältet och dra en bild till bildens släppzon från resurssökaren. Sök efter&quot;stacey&quot; för att hitta biobilden Stacey Roswells som finns i WKND-paketet ui.content.

   ![lägg till bild i dialogrutan](assets/custom-component/add-image.png)

1. När du har lagt till en bild klickar du på fliken **Egenskaper** för att ange **Namn** och **Yrken**.

   När du anger befattningar anger du dem i **omvänd alfabetisk** ordning så att den alfabetiska affärslogik som implementeras i försäljningsmodellen verifieras.

   Tryck på knappen **Klar** längst ned till höger för att spara ändringarna.

   ![fyll i egenskaperna för den inbyggda komponenten](assets/custom-component/add-properties.png)

   AEM författare konfigurerar och redigerar komponenter via dialogrutorna. I nuläget ingår dialogrutorna för datainsamling i utvecklingen av komponenten Byline, men logiken för att återge det redigerade innehållet har ännu inte lagts till. Därför visas bara platshållaren.

1. När du har sparat dialogrutan går du till [CRXDE Lite](http://localhost:4502/crx/de/index.jsp#/content/wknd/us/en/magazine/guide-la-skateparks/jcr%3Acontent/root/container/container/byline) och granskar hur komponentens innehåll lagras på innehållsnoden för instickskomponenten under AEM-sidan.

   Hitta innehållsnoden för komponenten Byline under sidan LA Skate Parks, dvs. `/content/wknd/us/en/magazine/guide-la-skateparks/jcr:content/root/container/container/byline`.

   Observera att egenskapsnamnen `name`, `occupations` och `fileReference` lagras på **byline-noden**.

   Observera också att noden `sling:resourceType` är inställd på `wknd/components/content/byline` vilket är det som binder den här innehållsnoden till implementeringen av komponenten Byline.

   ![byline-egenskaper i CRXDE](assets/custom-component/byline-properties-crxde.png)

## Skapa Byline Sling Model {#create-sling-model}

Sedan skapar vi en Sling-modell som fungerar som datamodell och lagrar affärslogiken för Byline-komponenten.

Sling Models är anteckningsdrivna Java™ POJOs (Plain Old Java™ Objects) som underlättar datamappningen från JCR till Java™-variabler och som ger ökad effektivitet vid utveckling i AEM-sammanhang.

### Granska Maven Dependencies {#maven-dependency}

Byline Sling Model bygger på flera Java™-API:er från AEM. Dessa API:er är tillgängliga via `dependencies` som anges i POM-filen för modulen `core`. Det projekt som används för den här självstudiekursen har skapats för AEM as a Cloud Service. Men den är unik eftersom den är bakåtkompatibel med AEM 6.5/6.4. Därför ingår både beroenden för Cloud Service och AEM 6.x.

1. Öppna filen `pom.xml` under `<src>/aem-guides-wknd/core/pom.xml`.
1. Hitta beroendet för `aem-sdk-api` - **endast AEM as a Cloud Service**

   ```xml
   <dependency>
       <groupId>com.adobe.aem</groupId>
       <artifactId>aem-sdk-api</artifactId>
   </dependency>
   ```

   [aem-sdk-api](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/aem-as-a-cloud-service-sdk.html?lang=sv-SE) innehåller alla offentliga Java™-API:er som exponeras av AEM. `aem-sdk-api` används som standard när det här projektet skapas. Versionen finns kvar i den överordnade reaktorversionen från projektets rot vid `aem-guides-wknd/pom.xml`.

1. Hitta beroendet för `uber-jar` - **endast AEM 6.5/6.4**

   ```xml
   ...
       <dependency>
           <groupId>com.adobe.aem</groupId>
           <artifactId>uber-jar</artifactId>
           <classifier>apis</classifier>
       </dependency>
   ...
   ```

   `uber-jar` inkluderas bara när profilen `classic` anropas, dvs. `mvn clean install -PautoInstallSinglePackage -Pclassic`. Detta är unikt för det här projektet. I ett verkligt projekt som genererats från AEM Project Archetype är `uber-jar` standardvärdet om den version av AEM som anges är 6.5 eller 6.4.

   [uber-jar](https://experienceleague.adobe.com/docs/experience-manager-65/developing/devtools/ht-projects-maven.html?lang=sv-SE#experience-manager-api-dependencies) innehåller alla Java™-API:er som exponeras av AEM 6.x. Versionen bibehålls i den överordnade reaktorversionen från projektets rot `aem-guides-wknd/pom.xml` .

1. Hitta beroendet för `core.wcm.components.core`:

   ```xml
    <!-- Core Component Dependency -->
       <dependency>
           <groupId>com.adobe.cq</groupId>
           <artifactId>core.wcm.components.core</artifactId>
       </dependency>
   ```

   Detta är de fullständiga Java™-API:erna som finns i AEM Core Components. AEM Core Components är ett projekt som underhålls utanför AEM och därför har en separat releasecykel. Därför är det ett beroende som måste inkluderas separat och **ingår inte** i `uber-jar` eller `aem-sdk-api`.

   Precis som för uber-jar bevaras versionen för det här beroendet i den överordnade reaktorns PDF-fil från `aem-guides-wknd/pom.xml`.

   Senare i den här självstudiekursen används klassen Core Component Image för att visa bilden i komponenten Byline. Det är nödvändigt att ha beroendet av kärnkomponenten för att kunna skapa och kompilera Sling-modellen.

### Byline-gränssnitt {#byline-interface}

Skapa ett publikt Java™-gränssnitt för Byline. `Byline.java` definierar de publika metoder som krävs för att köra HTML-skriptet `byline.html`.

1. I `core`-modulen i mappen `core/src/main/java/com/adobe/aem/guides/wknd/core/models` skapas en fil med namnet `Byline.java`

   ![skapa gränssnitt ](assets/custom-component/create-byline-interface.png)

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

   De första två metoderna visar värdena för **name** och **ockupationer** för Byline-komponenten.

   Metoden `isEmpty()` används för att avgöra om komponenten har något innehåll att återge eller om den väntar på att konfigureras.

   Observera att det inte finns någon metod för bilden. [Den granskas senare](#tackling-the-image-problem).

1. Java™-paket som innehåller offentliga Java™-klasser, i det här fallet en Sling-modell, måste versionshanteras med paketets `package-info.java`-fil.

   Eftersom WKND-källans Java™-paket `com.adobe.aem.guides.wknd.core.models` deklarerar version av `1.0.0` och ett hårt offentligt gränssnitt och metoder läggs till, måste versionen ökas till `1.1.0`. Öppna filen på `core/src/main/java/com/adobe/aem/guides/wknd/core/models/package-info.java` och uppdatera `@Version("1.0.0")` till `@Version("2.1.0")`.

   ```
   @Version("2.1.0")
   package com.adobe.aem.guides.wknd.core.models;
   
   import org.osgi.annotation.versioning.Version;
   ```

När du ändrar filerna i det här paketet måste [paketversionen justeras semantiskt](https://semver.org/). Annars identifieras en ogiltig paketversion av Maven-projektets [bnd-baseline-maven-plugin](https://github.com/bndtools/bnd) och den inbyggda versionen bryts. Som tur är rapporterar Maven-pluginen den ogiltiga Java™-paketversionen och den version den ska vara. Uppdatera deklarationen `@Version("...")` i det felaktiga Java™-paketets `package-info.java` till den version som rekommenderas av plugin-programmet för att korrigera.

### Byline implementation {#byline-implementation}

`BylineImpl.java` är implementeringen av Sling-modellen som implementerar gränssnittet `Byline.java` som definierats tidigare. Den fullständiga koden för `BylineImpl.java` finns längst ned i det här avsnittet.

1. Skapa en mapp med namnet `impl` under `core/src/main/java/com/adobe/aem/guides/core/models`.
1. Skapa en fil `BylineImpl.java` i mappen `impl`.

   ![Byline Impl-fil](assets/custom-component/byline-impl-file.png)

1. Öppna `BylineImpl.java`. Ange att gränssnittet `Byline` implementeras. Använd de automatiska funktionerna för IDE eller uppdatera filen manuellt för att inkludera de metoder som krävs för att implementera gränssnittet `Byline`:

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

1. Lägg till Sling Model-anteckningar genom att uppdatera `BylineImpl.java` med följande anteckningar på klassnivå. Den här `@Model(..)`anteckningen är det som gör klassen till en Sling-modell.

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

   * `@Model`-anteckningen registrerar BylineImpl som en Sling-modell när den distribueras till AEM.
   * Parametern `adaptables` anger att modellen kan anpassas av begäran.
   * Parametern `adapters` tillåter att implementeringsklassen registreras under Byline-gränssnittet. Detta gör att HTML-skriptet kan anropa Sling-modellen via gränssnittet (i stället för direkt implementering). [Mer information om adaptrar finns här](https://sling.apache.org/documentation/bundles/models.html#specifying-an-alternate-adapter-class-since-110).
   * `resourceType` pekar på typen av Byline-komponentresurs (som skapades tidigare) och hjälper till att lösa rätt modell om det finns flera implementeringar. [Mer information om hur du associerar en modellklass med en resurstyp finns här](https://sling.apache.org/documentation/bundles/models.html#associating-a-model-class-with-a-resource-type-since-130).

### Implementera Sling Model-metoder {#implementing-the-sling-model-methods}

#### getName() {#implementing-get-name}

Den första metoden som implementeras är `getName()`, men returnerar helt enkelt det värde som lagras till bylines JCR-innehållsnod under egenskapen `name`.

För detta används `@ValueMapValue` Sling Model-anteckningen för att mata in värdet i ett Java™-fält med hjälp av Request-resursens ValueMap.


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

Eftersom JCR-egenskapen delar namn som Java™-fält (båda är &quot;namn&quot;), löser `@ValueMapValue` automatiskt associationen och injicerar egenskapens värde i Java™-fältet.

#### getOccupations() {#implementing-get-occupations}

Nästa metod som ska implementeras är `getOccupations()`. Den här metoden läser in de befattningar som lagras i JCR-egenskapen `occupations` och returnerar en sorterad (i bokstavsordning) samling av dem.

Om du använder samma teknik som beskrivs i `getName()` kan egenskapsvärdet injiceras i fältet för delningsmodellen.

När JCR-egenskapsvärdena är tillgängliga i Sling Model via det inmatade Java™-fältet `occupations` kan sorteringsaffärslogiken användas i metoden `getOccupations()`.


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

Den sista publika metoden är `isEmpty()`, som avgör när komponenten ska se sig själv som&quot;tillräckligt skapad&quot; för att kunna återge.

För den här komponenten är affärskravet alla tre fält, `name, image and occupations` måste fyllas i *innan* komponenten kan återges.


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

Det är enkelt att kontrollera namn och villkor för yrket och Apache Commons Lang3 innehåller den praktiska klassen [StringUtils](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html). Det är dock oklart hur **närvaron av bilden** kan valideras eftersom kärnkomponentavbildningskomponenten används för att visa bilden.

Det finns två sätt att ta itu med detta:

Kontrollera om JCR-egenskapen `fileReference` matchar en resurs. *OR* Konvertera den här resursen till en Core Component Image Sling Model och kontrollera att metoden `getSrc()` inte är tom.

Vi använder metoden **second**. Det första tillvägagångssättet är förmodligen tillräckligt, men i den här självstudien används det senare för att vi ska kunna utforska andra funktioner i Sling Models.

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

   Som vi nämnt ovan finns det ytterligare två sätt att hämta **Image Sling Model**:

   Den första använder anteckningen `@Self` för att automatiskt anpassa den aktuella begäran till kärnkomponentens `Image.class`

   Den andra använder [Apache Sling ModelFactory](https://sling.apache.org/apidocs/sling10/org/apache/sling/models/factory/ModelFactory.html) OSGi-tjänsten, som är en praktisk tjänst, och hjälper oss att skapa Sling-modeller av andra typer i Java™-kod.

   Låt oss använda den andra metoden.

   >[!NOTE]
   >
   >I en implementering i verkligheten är det bäst att använda metoden One, med `@Self` eftersom det är den enklare och mer eleganta lösningen. I den här självstudiekursen används den andra metoden eftersom den kräver att du utforskar fler aspekter av Sling Models som är användbara är mer komplexa komponenter!

   Eftersom Sling Models är Java™ POJO och inte OSGi Services, kan de vanliga OSGi-injektionskommentarerna `@Reference` **inte** användas, i stället tillhandahåller Sling Models en speciell **[@OSGiService ](https://sling.apache.org/documentation/bundles/models.html#injector-specific-annotations)** -anteckning som ger liknande funktioner.

1. Uppdatera `BylineImpl.java` så att den innehåller anteckningen `OSGiService` för att mata in `ModelFactory`:

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

   När `ModelFactory` är tillgängligt kan en Core Component Image Sling-modell skapas med:

   ```java
   modelFactory.getModelFromWrappedRequest(SlingHttpServletRequest request, Resource resource, java.lang.Class<T> targetClass)
   ```

   Den här metoden kräver dock både en begäran och en resurs, som ännu inte är tillgänglig i Sling-modellen. Fler Sling Model-anteckningar används för att få dessa.

   För att hämta den aktuella begäran kan anteckningen **[@Self](https://sling.apache.org/documentation/bundles/models.html#injector-specific-annotations)** användas för att mata in `adaptable` (som definieras i `@Model(..)` som `SlingHttpServletRequest.class`) i ett Java™-klassfält.

1. Lägg till anteckningen **@Self** för att hämta begäran **SlingHttpServletRequest**:

   ```java
   import org.apache.sling.models.annotations.injectorspecific.Self;
   ...
   @Self
   private SlingHttpServletRequest request;
   ```

   Kom ihåg att när du använder `@Self Image image` för att mata in Core Component Image Sling Model var ett alternativ ovan - `@Self`-anteckningen försöker mata in det adapterbara objektet (i det här fallet en SlingHttpServletRequest) och anpassa sig till anteckningsfältstypen. Eftersom Core Component Image Sling Model kan anpassas från SlingHttpServletRequest-objekt, skulle detta ha fungerat och är mindre kod än mer utforskande `modelFactory`-metod.

   Nu injiceras de variabler som krävs för att instansiera Image-modellen via API:t ModelFactory. Låt oss använda Sling Model-anteckningen **[@PostConstruct](https://sling.apache.org/documentation/bundles/models.html#postconstruct-methods)** för att hämta det här objektet efter att Sling Model har instansierats.

   `@PostConstruct` är mycket användbart och fungerar i liknande kapacitet som en konstruktor, men anropas när klassen har instansierats och alla kommenterade Java™-fält har injicerats. Medan andra Sling Model-anteckningar kommenterar Java™-klassfält (variabler), kommenterar `@PostConstruct` en void, noll-parametermetod, vanligtvis med namnet `init()` (men kan namnges vad som helst).

1. Lägg till metoden **@PostConstruct**:

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

   Kom ihåg att Sling Models är **NOT** OSGi Services, så det är säkert att behålla klasstillstånd. `@PostConstruct` hämtar och ställer ofta in Sling Model-klasstillstånd för senare användning, som liknar det som en vanlig konstruktor gör.

   Om metoden `@PostConstruct` genererar ett undantag skapas ingen instans av Sling-modellen och den är null.

1. **getImage()** kan nu uppdateras för att returnera bildobjektet.

   ```java
   /**
       * @return the Image Sling Model of this resource, or null if the resource cannot create a valid Image Sling Model.
   */
   private Image getImage() {
       return image;
   }
   ```

1. Vi går tillbaka till `isEmpty()` och slutför implementeringen:

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

   Observera att flera anrop till `getImage()` inte är problematiska eftersom returnerar den initierade `image` class-variabeln och inte anropar `modelFactory.getModelFromWrappedRequest(...)` som inte är alltför dyr, men som bör undvikas att anropa i onödan.

1. Den sista `BylineImpl.java` ska se ut så här:


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

Öppna `/apps/wknd/components/byline/byline.html` som skapades i den tidigare installationen av AEM-komponenten i modulen `ui.apps`.

```html
<div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html">
</div>
<sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=false}"></sly>
```

Låt oss se vad detta HTML-skript gör hittills:

* `placeholderTemplate` pekar på Core Components platshållare, som visas när komponenten inte är helt konfigurerad. Det här återger i AEM Sites Page Editor som en ruta med komponenttiteln, enligt definitionen ovan i `jcr:title`-egenskapen för `cq:Component`.

* `data-sly-call="${placeholderTemplate.placeholder @ isEmpty=false}` läser in `placeholderTemplate` som definierats ovan och skickar ett booleskt värde (som för närvarande är hårdkodat till `false`) till platshållarmallen. När `isEmpty` är true återges den grå rutan av platshållarmallen, annars återges ingenting.

### Uppdatera textmarkör-HTML

1. Uppdatera **byline.html** med följande HTML-struktur för skelett:

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

   Observera att CSS-klasserna följer [BEM-namnkonventionen](https://getbem.com/naming/). BEM-konventioner är inte obligatoriska, men BEM rekommenderas eftersom det används i CSS-klasser för kärnkomponenter och i allmänhet leder till rena, läsbara CSS-regler.

### Instansierar Sling Model-objekt i HTML {#instantiating-sling-model-objects-in-htl}

[Använd blockprogramsats](https://github.com/adobe/htl-spec/blob/master/SPECIFICATION.md#221-use) används för att instansiera Sling Model-objekt i HTL-skriptet och tilldela den till en HTL-variabel.

`data-sly-use.byline="com.adobe.aem.guides.wknd.models.Byline"` använder det Byline-gränssnitt (com.adobe.aem.guides.wknd.models.Byline) som implementeras av BylineImpl och anpassar den aktuella SlingHttpServletRequest till det, och resultatet lagras i en HTML-variabelnamnsbit ( `data-sly-use.<variable-name>`).

1. Uppdatera den yttre `div` så att den refererar till **Byline** Sling Model via dess publika gränssnitt:

   ```xml
   <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       class="cmp-byline">
       ...
   </div>
   ```

### Åtkomst till Sling Model-metoder {#accessing-sling-model-methods}

HTML lånar från JSTL och använder samma förkortning av Java™-get-metodnamn.

Anrop av `getName()`-metoden för insticksmodellen kan till exempel förkortas till `byline.name`, i stället för till `byline.isEmpty` kan det förkortas till `byline.empty`. Fullständiga metodnamn, `byline.getName` eller `byline.isEmpty`, fungerar också. Observera att `()` aldrig används för att anropa metoder i HTML (liknande JSTL).

Java™-metoder som kräver parametern **kan inte** användas i HTML. Detta är utformat för att göra logiken i HTML enkel.

1. Du kan lägga till namnet Byline i komponenten genom att anropa metoden `getName()` i modellen Byline Sling eller i HTML: `${byline.name}`.

   Uppdatera taggen `h2`:

   ```xml
   <h2 class="cmp-byline__name">${byline.name}</h2>
   ```

### Använda alternativ för HTML-uttryck {#using-htl-expression-options}

[Alternativ för HTML-uttryck](https://github.com/adobe/htl-spec/blob/master/SPECIFICATION.md#12-available-expression-options) fungerar som modifierare för innehållet i HTML och varierar från datumformatering till i18n-översättning. Uttryck kan också användas för att sammanfoga listor eller värdematriser, vilket är vad som behövs för att visa arbetsuppgifterna i ett kommaavgränsat format.

Uttryck läggs till via operatorn `@` i HTL-uttrycket.

1. Om du vill gå med i listan över yrken med &quot;, &quot; används följande kod:

   ```html
   <p class="cmp-byline__occupations">${byline.occupations @ join=', '}</p>
   ```

### Villkorlig visning av platshållaren {#conditionally-displaying-the-placeholder}

De flesta HTML-skript för AEM Components använder **platshållarparadigm** för att ge en visuell referens till författare **som anger att en komponent är felaktigt skapad och inte visas i AEM Publish**. Konventionen som styr det här beslutet är att implementera en metod på komponentens bakomliggande Sling Model, i det här fallet: `Byline.isEmpty()`.

Metoden `isEmpty()` anropas i Byline Sling Model och resultatet (eller snarare negativt, via operatorn `!`) sparas i en HTML-variabel med namnet `hasContent`:

1. Uppdatera den yttre `div` för att spara en HTML-variabel med namnet `hasContent`:

   ```html
    <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
         data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
         data-sly-test.hasContent="${!byline.empty}"
         class="cmp-byline">
         ...
   </div>
   ```

   Observera att `data-sly-test` används, att HTL `test`-blocket är nyckel, att det båda anger en HTML-variabel och återger/inte det HTML-element det är på. Den baseras på resultatet av utvärderingen av HTML-uttrycket. Om värdet är &quot;true&quot; återges HTML-elementet, annars återges det inte.

   Den här HTML-variabeln `hasContent` kan nu återanvändas för att villkorligt visa/dölja platshållaren.

1. Uppdatera det villkorliga anropet till `placeholderTemplate` längst ned i filen med följande:

   ```html
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!hasContent}"></sly>
   ```

### Visa bilden med hjälp av kärnkomponenter {#using-the-core-components-image}

HTML-skriptet för `byline.html` är nu nästan färdigt och saknar bara bilden.

När `sling:resourceSuperType` pekar på kärnkomponentens Image-komponent för att skapa bilden, kan kärnkomponentens Image-komponent användas för att återge bilden.

För detta ska vi ta med den aktuella bylineresursen, men tvinga resurstypen för kärnkomponentens avbildningskomponent med resurstypen `core/wcm/components/image/v2/image`. Det här är ett kraftfullt mönster för återanvändning av komponenter. För detta används HTL:s `data-sly-resource`-block.

1. Ersätt `div` med klassen `cmp-byline__image` med följande:

   ```html
   <div class="cmp-byline__image"
       data-sly-resource="${ '.' @ resourceType = 'core/wcm/components/image/v2/image' }"></div>
   ```

   Denna `data-sly-resource` innehåller den aktuella resursen via den relativa sökvägen `'.'` och tvingar den aktuella resursen (eller den ursprungliga innehållsresursen) att inkluderas med resurstypen `core/wcm/components/image/v2/image`.

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

3. Distribuera kodbasen till en lokal AEM-instans. Eftersom ändringar gjordes i `core` och `ui.apps` måste båda modulerna distribueras.

   ```shell
   $ cd aem-guides-wknd/ui.apps
   $ mvn clean install -PautoInstallPackage
   ```

   ```shell
   $ cd ../core
   $ mvn clean install -PautoInstallBundle
   ```

   Om du vill distribuera till AEM 6.5/6.4 anropar du profilen `classic`:

   ```shell
   $ cd ../core
   $ mvn clean install -PautoInstallBundle -Pclassic
   ```

   >[!CAUTION]
   >
   > Du kan också skapa hela projektet från roten med hjälp av Maven-profilen `autoInstallSinglePackage`, men detta kan skriva över innehållsändringarna på sidan. Detta beror på att `ui.content/src/main/content/META-INF/vault/filter.xml` har ändrats för att självstudiekursens startkod ska skriva över det befintliga AEM-innehållet. I ett verkligt scenario är detta inte något problem.

### Granska den oformaterade Byline-komponenten {#reviewing-the-unstyled-byline-component}

1. När du har distribuerat uppdateringen navigerar du till sidan [Ultimate Guide till LA Skateparks](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html) eller till den plats där du lade till Byline-komponenten tidigare i kapitlet.

1. **bild**, **namn** och **funktioner** visas nu och har en ogiltig formatering, men det finns en fungerande Byline-komponent.

   ![Informningskomponent som inte är formaterad](assets/custom-component/unstyled.png)

### Granska registreringen av försäljningsmodellen {#reviewing-the-sling-model-registration}

Statusvyn [AEM Web Console’s Sling Models](http://localhost:4502/system/console/status-slingmodels) visar alla registrerade Sling Models i AEM. Byline Sling Model kan valideras som installerad och identifieras genom att läsa den här listan.

Om **BylineImpl** inte visas i den här listan är det troligtvis ett problem med Sling-modellens anteckningar eller så har modellen inte lagts till i rätt paket (`com.adobe.aem.guides.wknd.core.models`) i huvudprojektet.

![Byline Sling Model registrerad](assets/custom-component/osgi-sling-models.png)

*<http://localhost:4502/system/console/status-slingmodels>*

## Format för pyline {#byline-styles}

Om du vill justera den inbyggda komponenten mot den medföljande kreativa designen formaterar vi den. Detta uppnås genom att använda SCSS-filen och uppdatera filen i modulen **ui.front**.

### Lägga till ett standardformat

Lägg till standardstilar för komponenten Byline.

1. Återgå till IDE och projektet **ui.front** under `/src/main/webpack/components`:
1. Skapa en fil med namnet `_byline.scss`.

   ![Byline project explorer](assets/custom-component/byline-style-project-explorer.png)

1. Lägg till CSS för Byline-implementeringar (skrivet som SCSS) i `_byline.scss`:

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

1. Öppna en terminal och navigera till modulen `ui.frontend`.
1. Starta `watch`-processen med följande npm-kommando:

   ```shell
   $ cd ui.frontend/
   $ npm run watch
   ```

1. Återgå till webbläsaren och gå till [LA SkateParks-artikeln](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html). Du bör se de uppdaterade formaten för komponenten.

   ![har slutfört den inbyggda komponenten](assets/custom-component/final-byline-component.png)

   >[!TIP]
   >
   > Du kan behöva rensa webbläsarens cacheminne för att vara säker på att inaktuell CSS inte hanteras, och uppdatera sidan med den inbyggda komponenten för att få den fullständiga formateringen.

## Grattis! {#congratulations}

Grattis! Du har skapat en egen komponent från grunden med Adobe Experience Manager!

### Nästa steg {#next-steps}

Lär dig mer om AEM Component Development genom att utforska hur du skriver JUnit-tester för Byline Java™-koden för att säkerställa att allt utvecklas på rätt sätt och att implementerad affärslogik är korrekt och fullständig.

* [Skriva enhetstester eller AEM-komponenter](unit-testing.md)

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/custom-component-solution`.

1. Klona [github.com/adobe/aem-guides-wknd](https://github.com/adobe/aem-guides-wknd)-databasen.
1. Kolla in grenen `tutorial/custom-component-solution`
