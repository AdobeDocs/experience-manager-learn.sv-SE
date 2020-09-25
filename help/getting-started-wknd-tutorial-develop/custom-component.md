---
title: Egen komponent
description: Täcker hela skapandet av en anpassad infallskomponent som visar redigerat innehåll. Innehåller utveckling av en Sling-modell för inkapsling av affärslogik för att fylla i den inkapslade komponenten och motsvarande HTML för återgivning av komponenten.
sub-product: platser
feature: sling-models
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 4072
mini-toc-levels: 1
thumbnail: 30181.jpg
translation-type: tm+mt
source-git-commit: defefc1451e2873e81cd81e3cccafa438aa062e3
workflow-type: tm+mt
source-wordcount: '4011'
ht-degree: 0%

---


# Egen komponent {#custom-component}

I den här självstudiekursen beskrivs hur du skapar en anpassad AEM Byline-komponent som visar innehåll som har skapats i en dialogruta och utforskar hur du utvecklar en Sling-modell för att kapsla in affärslogik som fyller komponentens HTML-kod.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Startprojekt

>[!NOTE]
>
> Om du har följt med i tidigare delar av kursen kommer du att märka att startprojektet för det här kapitlet snabbar upp implementeringen. Det innehåller några fler mallar och mycket mer innehåll. Som bonus kan du utforska det nya innehållet och andra områden i implementeringen, utanför den anpassade komponentutvecklingen.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Klona [github.com/adobe/aem-guides-wknd](https://github.com/adobe/aem-guides-wknd) .
1. Kolla in `custom-component/start` grenen

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd.git ~/code/aem-guides-wknd
   $ cd ~/code/aem-guides-wknd
   $ git checkout custom-component/start
   ```

1. Distribuera kodbasen till en lokal AEM med dina Maven-kunskaper:

   ```shell
   $ cd ~/code/aem-guides-wknd
   $ mvn clean install -PautoInstallSinglePackage
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/custom-component/solution) eller checka ut koden lokalt genom att växla till grenen `custom-component/solution`.

## Syfte

1. Förstå hur du skapar en anpassad AEM
1. Lär dig kapsla in affärslogik med Sling Models
1. Förstå hur du använder en segmenteringsmodell i ett HTML-skript

## Vad du ska bygga {#byline-component}

>[!VIDEO](https://video.tv.adobe.com/v/30181/?quality=12&learn=on)

I den här delen av WKND-självstudiekursen skapas en Byline-komponent som används för att visa redigerad information om en artikels medverkande.

![exempel på byline-komponent](./assets/custom-component/byline-design.png)

*Visual design av instickskomponenter från WKND-designteam*

Implementeringen av komponenten Byline innehåller en dialogruta som samlar in byline-innehållet och en anpassad Sling-modell som hämtar bylines:

* Namn
* Bild
* Yrken

för visning med ett HTML-skript, som återger den HTML-kod som webbläsaren slutligen visar.

![bindekomposition](./assets/custom-component/byline-decomposition.png)

*Nedbrytning av inkubationskomponent*

## Skapa Byline-komponent {#create-byline-component}

Skapa först nodstrukturen för Byline-komponenten och definiera en dialogruta. Detta representerar komponenten i AEM och definierar implicit komponentens resurstyp genom sin placering i JCR-läsaren.

Dialogrutan visar gränssnittet som innehållsförfattare kan använda. För den här implementeringen kommer AEM WCM Core Components **Image** -komponent att användas för att hantera redigering och återgivning av Bylines bild, så den kommer att anges som vår komponents `sling:resourceSuperType`.

### Skapa komponentnod {#create-component-node}

1. I modulen **ui.apps** navigerar du till `/apps/wknd/components/content` och skapar en ny nod med namnet **byline** av typen `cq:Component`.

   ![dialogruta för att skapa nod](./assets/custom-component/byline-node-creation.png)

1. Lägg till följande egenskaper i Byline-komponentens `cq:Component` nod.

   ```plain
   jcr:title = Byline
   jcr:description = Displays a contributor's byline.
   componentGroup = WKND.Content
   sling:resourceSuperType =  core/wcm/components/image/v2/image
   ```

   ![Egenskaper för komponenten Byline](./assets/custom-component/byline-component-properties.png)

   Detta resulterar i denna `.content.xml` XML:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root
       xmlns:sling="https://sling.apache.org/jcr/sling/1.0" xmlns:jcr="https://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:Component"
       jcr:title="Byline"
       jcr:description="Displays a contributor's byline."
       componentGroup="WKND.Content"
       sling:resourceSuperType="core/wcm/components/image/v2/image"/>
   ```

### Skapa HTML-skriptet {#create-the-htl-script}

1. Under `byline` noden lägger du till en ny fil `byline.html`som ansvarar för HTML-presentationen av komponenten. Det är viktigt att namnge filen på samma sätt som noden eftersom det blir standardskriptet som Sling använder för att återge den här resurstypen. `cq:Component`

1. Lägg till följande kod i `byline.html`.

   ```xml
   <!--/* byline.html */-->
   <div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html">
   </div>
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=true}"></sly>
   ```

`byline.html` kommer att [granskas senare](#byline-htl)när Sling Model har skapats. HTML-filens aktuella läge gör att komponenten kan visas i ett tomt läge i sidredigeraren i AEM Sites när den dras och släpps på sidan.

### Skapa dialogdefinitionen {#create-the-dialog-definition}

Definiera sedan en dialogruta för den inbyggda komponenten med följande fält:

* **Namn**: ett textfält som medarbetarens namn.
* **Bild**: en referens till medverkarens biobild.
* **Yrken**: en lista över de yrken som tillskrivs medarbetaren. Ytor ska sorteras alfabetiskt i stigande ordning (a till z).

1. Under `byline` komponentnoden skapar du en ny nod med namnet `cq:dialog` av typen `nt:unstructured`.
1. Uppdatera `cq:dialog` med följande XML. Det är enklast att öppna `.content.xml` och kopiera/klistra in följande XML i den.

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
           xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
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

   Dessa noddefinitioner använder [Sling Resource Merger](https://sling.apache.org/documentation/bundles/resource-merger.html) för att styra vilka dialogrutor som ärvs från `sling:resourceSuperType` komponenten, i det här fallet **Core Components Image-komponent**.

   ![slutförd dialogruta för byline](./assets/custom-component/byline-dialog-created.png)

### Skapa dialogrutan Princip {#create-the-policy-dialog}

På samma sätt som när du skapar en dialogruta skapar du en principdialogruta (tidigare kallad designdialogruta) som döljer oönskade fält i principkonfigurationen som ärvts från kärnkomponentens image-komponent.

1. Skapa en ny nod med namnet `byline` av typen under `cq:Component` noden `cq:design_dialog` `nt:unstructured`.
1. Uppdatera `cq:design_dialog` med följande XML. Det är enklast att öppna `.content.xml` och kopiera/klistra in XML-filen nedan i den.

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

   Basen för föregående **principdialogruta** XML hämtades från bildkomponenten [](https://github.com/adobe/aem-core-wcm-components/blob/master/content/src/content/jcr_root/apps/core/wcm/components/image/v2/image/_cq_design_dialog/.content.xml)Core Components.

   Precis som i dialogrutan används [Sling Resource Merger](https://sling.apache.org/documentation/bundles/resource-merger.html) för att dölja irrelevanta fält som i övrigt ärvs från `sling:resourceSuperType`, vilket visas i noddefinitionerna med `sling:hideResource="{Boolean}true"` egenskapen.

### Distribuera koden {#deploy-the-code}

1. Distribuera den uppdaterade kodbasen till en lokal AEM med dina Maven-kunskaper:

   ```shell
   $ cd ~/code/aem-guides-wknd
   $ mvn clean install -PautoInstallPackage
   ```

### Lägga till komponenten på en sida {#add-the-component-to-a-page}

För att hålla saker och ting enkla och fokuserade på AEM komponentutveckling lägger vi till komponenten Byline i det aktuella läget på en artikelsida för att verifiera att `cq:Component` noddefinitionen är distribuerad och korrekt, AEM känner igen den nya komponentdefinitionen och komponentens dialogruta fungerar för redigering.

Eftersom vi [har lagt till komponenten Byline i **komponentgruppen** WKND.Content](#create-component-node), via `/apps/wknd/components/content/byline@componentGroup=WKND.Content` egenskapen, är den automatiskt tillgänglig för alla **layoutbehållare** vars **policy** tillåter **** komponentgruppen WKND.Content¥, som artikelsidans layoutbehållare är.

#### Dra och släpp komponenten på sidan {#drag-and-drop-the-component-onto-the-page}

1. **Redigera** artikelsidan på **AEM > Sites > WKND Site > Language Överordnad > English > Magazine > Ultimate Guide to LA Skateparks**.
1. Dra och släpp en **infallskomponent** från den vänstra sidofältet **längst ned** på den öppnade artikelsidans layoutbehållare.

   ![lägg till en bitlinjekomponent på sidan](assets/custom-component/add-to-page.png)

#### Skapa komponenten {#author-the-component}

AEM konfigurerar och redigerar komponenter via dialogrutorna. I nuläget ingår dialogrutorna för datainsamling i utvecklingen av komponenten Byline, men logiken för att återge det redigerade innehållet har ännu inte lagts till.

1. Kontrollera att den **vänstra sidopanelen är öppen** och synlig och att **Resurssökaren** är markerad.

   ![öppna tillgångssökare](assets/custom-component/open-asset-finder.png)

1. Markera platshållaren **för** länskomponenten, som i sin tur visar åtgärdsfältet och trycker på ikonen för **skiftnyckel** för att öppna dialogrutan.

   ![åtgärdsfält för komponent](assets/custom-component/action-bar.png)

1. Öppna dialogrutan och den första fliken (Tillgång) aktiv, öppna det vänstra sidofältet och dra en bild till bildens släppzon från resurssökaren. Sök efter&quot;stacey&quot; för att hitta biobilden Stacey Roswells som finns i WKND-paketet ui.content.

   **[stacey-roswells.jpg](assets/custom-component/stacey-roswells.jpg)**

   ![lägg till bild i dialogruta](assets/custom-component/add-image.png)

1. När du har lagt till en bild klickar du på fliken **Egenskaper** för att ange **Namn** och **yrken**.

   När du anger yrken anger du dem i **omvänd alfabetisk** ordning så att den alfabetiska affärslogik som vi implementerar i Sling Model är tydlig.

   Tryck på knappen **Klar** längst ned till höger för att spara ändringarna.

   ![fyll i egenskaper för instickskomponenten](assets/custom-component/add-properties.png)

1. När du har sparat dialogrutan går du till [CRXDE Lite](http://localhost:4502/crx/de/index.jsp#/content/wknd/language-masters/en/magazine/guide-la-skateparks/jcr:content/root/responsivegrid/responsivegrid/byline) och granskar hur komponentens innehåll lagras på noden för bylinekomponentens innehåll under AEM.

   Hitta innehållsnoden för komponenten Byline under `jcr:content/root/responsivegrid/responsivegrid` noden, d.v.s. `/content/wknd/language-masters/en/magazine/guide-la-skateparks/jcr:content/root/responsivegrid/responsivegrid/byline`.

   Observera egenskapsnamnen `name`, `occupations`och `fileReference` lagras på **byline-noden**.

   Observera också att noden är inställd `sling:resourceType` på `wknd/components/content/byline` vilket är det som binder den här innehållsnoden till implementeringen av komponenten Byline.

   ![bytegenskaper i CRXDE](assets/custom-component/byline-properties-crxde.png)

   */content/wknd/language-masters/en/magazine/guide-la-skateparks/jcr:content/root/responsivegrid/responsivegrid/byline*

## Skapa Byline Sling Model {#create-sling-model}

Sedan skapar vi en Sling-modell som fungerar som datamodell och lagrar affärslogiken för Byline-komponenten.

Sling Models är anteckningsdrivna Java &quot;POJO&#39;s&quot; (Plain Old Java Objects) som underlättar mappningen av data från JCR till Java-variabler och som ger ett antal andra instanser vid utveckling i AEM.

### Granska Maven Dependencies {#maven-dependency}

Byline Sling Model förlitar sig på flera Java-API:er som tillhandahålls av AEM. Dessa API:er är tillgängliga via de `dependencies` som anges i `core` modulens POM-fil.

1. Öppna `pom.xml` filen under `<src>/aem-guides-wknd/core/pom.xml`.
1. Hitta beroendet för `uber-jar` i beroendeavsnittet i POM-filen:

   ```xml
   ...
       <dependency>
           <groupId>com.adobe.aem</groupId>
           <artifactId>uber-jar</artifactId>
           <classifier>apis</classifier>
       </dependency>
   ...
   ```

   Den [uber-jar](https://docs.adobe.com/content/help/en/experience-manager-65/developing/devtools/ht-projects-maven.html#experience-manager-api-dependencies) innehåller alla publika Java-API:er som AEM exponerar. Observera att ingen version har angetts i `core/pom.xml` filen. Versionen bibehålls i stället i den överordnade reaktorversionen som finns i projektets rot `aem-guides-wknd/pom.xml`.

1. Hitta beroendet för `core.wcm.components.core`:

   ```xml
    <!-- Core Component Dependency -->
       <dependency>
           <groupId>com.adobe.cq</groupId>
           <artifactId>core.wcm.components.core</artifactId>
       </dependency>
   ```

   Detta är alla offentliga Java-API:er som exponeras av AEM Core Components. AEM är ett projekt som underhålls utanför AEM och därför har en separat releasecykel. Därför är det ett beroende som måste tas med separat och **inte** ingår i behållaren.

   Liksom för uber-jar finns versionen för detta beroende kvar i filen Parent-reaktor i `aem-guides-wknd/pom.xml`.

   Senare i den här självstudiekursen använder vi klassen Core Component Image för att visa bilden i komponenten Byline. Det är nödvändigt att ha beroendet av kärnkomponenten för att kunna skapa och kompilera vår Sling-modell.

### Byline-gränssnitt {#byline-interface}

Skapa ett publikt Java-gränssnitt för Byline. `Byline.java` definierar de publika metoder som behövs för att köra `byline.html` HTML-skriptet.

1. I modulen `aem-guides-wknd.core` under `src/main/java,` skapar du ett nytt Java-gränssnitt med namnet `Byline.java` genom att högerklicka på `com.adobe.aem.guides.wknd.core.models` paketet > Nytt > Gränssnitt ****. Ange **Byline** som gränssnittsnamn och klicka på Finish (Slutför).

   ![skapa gränssnitt](assets/custom-component/create-byline-interface.png)

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

   De första två metoderna visar värdena för **namnet** och **uppsättningarna** för komponenten Byline.

   Metoden används för att avgöra om komponenten har något innehåll att återge eller om den väntar på att konfigureras. `isEmpty()`

   Observera att det inte finns någon metod för bilden. [vi ska titta på varför det är senare](#tackling-the-image-problem).

### Byline-implementering {#byline-implementation}

`BylineImpl.java` är implementeringen av Sling-modellen som implementerar det gränssnitt som definierats tidigare `Byline.java` . Den fullständiga koden för `BylineImpl.java` finns längst ned i det här avsnittet.

1. I modulen `core` under `src/main/java`skapar du en ny klassfil med namnet **BylineImpl.java** genom att högerklicka på `com.adobe.aem.guides.wknd.core.models.impl` paketet och välja **Ny > Klass**.

   Ange **BylineImpl som namn**. Lägg till **gränssnittet** Byline som implementeringsgränssnitt.

   ![skapa byline-implementering](assets/custom-component/create-byline-impl.png)

1. Öppna `BylineImpl.java`. Den fylls i automatiskt med alla metoder som definierats i gränssnittet `Byline.java`. Lägg till Sling Model-anteckningar genom att uppdatera `BylineImpl.java` med följande anteckningar på klassnivå. Den här `@Model(..)`anteckningen är vad som gör klassen till en Sling-modell.

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
       protected static final String RESOURCE_TYPE = "wknd/components/content/byline";
       ...
   }
   ```

   Låt oss granska den här kommentaren och dess parametrar:

   * Anteckningen registrerar BylineImpl som en Sling-modell när den distribueras till AEM. `@Model`
   * Parametern anger `adaptables` att den här modellen kan anpassas av begäran.
   * Parametern `adapters` tillåter att implementeringsklassen registreras under Byline-gränssnittet. Detta gör att HTML-skriptet kan anropa Sling-modellen via gränssnittet (i stället för impl direkt). [Mer information om adaptrar finns här](https://sling.apache.org/documentation/bundles/models.html#specifying-an-alternate-adapter-class-since-110).
   * Poängen `resourceType` pekar på typen av Byline-komponentresurs (skapades tidigare) och hjälper till att lösa rätt modell om det finns flera implementeringar. [Mer information om hur du associerar en modellklass med en resurstyp finns här](https://sling.apache.org/documentation/bundles/models.html#associating-a-model-class-with-a-resource-type-since-130).

### Implementera Sling Model-metoder {#implementing-the-sling-model-methods}

#### getName() {#implementing-get-name}

Den första metoden vi ska ta itu med är `getName()` att helt enkelt returnera värdet som lagras till bylines JCR-innehållsnod under egenskapen `name`.

För detta används anteckningen för `@ValueMapValue` Sling-modellen för att mata in värdet i ett Java-fält med hjälp av Request-resursens ValueMap.

```java
...
import org.apache.sling.models.annotations.injectorspecific.ValueMapValue;
...
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

Eftersom JCR-egenskapen har samma namn som Java-fältet (båda är &quot;name&quot;), tolkas associationen `@ValueMapValue` automatiskt och egenskapens värde infogas i Java-fältet.

#### getOccupations() {#implementing-get-occupations}

Nästa metod som ska implementeras är `getOccupations()`. Den här metoden samlar in alla funktioner som lagras i JCR-egenskapen `occupations` och returnerar en sorterad (i bokstavsordning) samling av dem.

Om du använder samma teknik som beskrivs i egenskapsvärdet kan `getName()` du injicera det i fältet för delningsmodellen.

När JCR-egenskapsvärdena är tillgängliga i Sling Model via det inmatade Java-fältet `occupations`kan sorteringsaffärslogiken användas i `getOccupations()` metoden.

```java
import java.util.ArrayList;
import java.util.Collections;
...

public class BylineImpl implements Byline {
    ...
    @ValueMapValue
    private List<String> occupations;
    ...
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

Den sista publika metoden är `isEmpty()` som avgör när komponenten ska se sig själv som&quot;skapad tillräckligt&quot; för att återge.

För den här komponenten har vi affärskrav som anger att alla tre fält, namn, bild och yrken måste fyllas i *innan* komponenten kan återges.

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

Det är enkelt att kontrollera namn- och yrkesförhållandena (och klassen [StringUtils](https://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/StringUtils.html) finns alltid i Apache Commons Lang3), men det är oklart hur Image **-komponentens** närvaro kan valideras eftersom bildkomponenten Core Components Image används för att visa bilden.

Det finns två sätt att ta itu med detta:

1. Kontrollera om `fileReference` JCR-egenskapen matchar en resurs.
1. Konvertera den här resursen till en Core Component Image Sling-modell och kontrollera att `getSrc()` metoden inte är tom.

   Vi kommer att välja den **andra** metoden. Det första tillvägagångssättet är förmodligen tillräckligt, men i den här självstudien kommer det senare att användas för att vi ska kunna utforska andra funktioner i Sling Models.

1. Skapa en privat metod som hämtar bilden. Den här metoden är privat eftersom vi inte behöver visa bildobjektet i själva HTML-koden och bara använder den för att köra `isEmpty().`

   Följande privata metod för `getImage()`:

   ```java
   import com.adobe.cq.wcm.core.components.models.Image;
   ...
   private Image getImage() {
       Image image = null;
       // Figure out how to populate the image variable!
       return image;
   }
   ```

   Som vi nämnt ovan finns det ytterligare två sätt att hämta **Image Sling-modellen**:

   Den första använder anteckningen för att automatiskt anpassa den aktuella begäran till kärnkomponentens `@Self` `Image.class`

   ```java
   @Self
   private Image image;
   ```

   Den andra använder [Apache Sling ModelFactory](https://sling.apache.org/apidocs/sling10/org/apache/sling/models/factory/ModelFactory.html) OSGi-tjänsten, som är en mycket praktisk tjänst, och hjälper oss att skapa Sling-modeller av andra typer i Java-kod.

   Vi väljer den andra metoden.

   >[!NOTE]
   >
   >I en implementering i verkligheten är metoden&quot;One&quot; att föredra eftersom `@Self` det är den enklare och mer eleganta lösningen. I den här självstudiekursen ska vi använda den andra metoden, eftersom den kräver att vi utforskar fler aspekter av Sling Models som är extremt användbara är mer komplexa komponenter!

   Eftersom Sling Models är Java POJOs, inte OSGi Services, `@Reference` kan de vanliga OSGi-injektionsanteckningarna inte **användas, utan Sling Models har en speciell** @OSGiService **[](https://sling.apache.org/documentation/bundles/models.html#injector-specific-annotations)** -anteckning som ger liknande funktionalitet.

1. Uppdatera `BylineImpl.java` så att anteckningen `OSGiService` inkluderas så att `ModelFactory`:

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

   Med det `ModelFactory` här alternativet kan du skapa en Core Component Image Sling-modell med:

   ```java
   modelFactory.getModelFromWrappedRequest(SlingHttpServletRequest request, Resource resource, java.lang.Class<T> targetClass)
   ```

   Den här metoden kräver dock både en begäran och en resurs, som ännu inte är tillgänglig i segmentmodellen. Fler Sling Model-anteckningar används för att få dessa.

   För att hämta den aktuella begäran kan anteckningen **[@Self](https://sling.apache.org/documentation/bundles/models.html#injector-specific-annotations)** användas för att mata in `adaptable` (som definieras i `@Model(..)` som `SlingHttpServletRequest.class`) i ett Java-klassfält.

1. Lägg till **@Self** -anteckningen för att hämta **SlingHttpServletRequest-begäran**:

   ```java
   import org.apache.sling.models.annotations.injectorspecific.Self;
   ...
   @Self
   private SlingHttpServletRequest request;
   ```

   Kom ihåg att när du använder för `@Self Image image` att mata in Core Component Image Sling Model var ett alternativ ovan - `@Self` kommentaren försöker mata in det adapterbara objektet (i vårt fall en SlingHttpServletRequest) och anpassa sig till anteckningsfältstypen. Eftersom Core Component Image Sling Model är anpassningsbar från SlingHttpServletRequest-objekt, skulle detta ha fungerat och är mindre kod än vår mer utforskande metod.

   Nu har vi injicerat de variabler som krävs för att skapa en instans av vår Image-modell via API:t för ModelFactory. Vi använder Sling Model **[@PostConstruct](https://sling.apache.org/documentation/bundles/models.html#postconstruct-methods)** -anteckning för att hämta det här objektet efter att Sling Model har instansierats.

   `@PostConstruct` är mycket användbart och fungerar i liknande kapacitet som en konstruktor, men anropas när klassen har instansierats och alla kommenterade Java-fält har injicerats. Medan andra Sling Model-anteckningar kommenterar Java-klassfält (variabler), kommenterar `@PostConstruct` en void, zero-parametermetod, vanligtvis namngiven `init()` (men kan namnges vad som helst).

1. Metoden Add **@PostConstruct** :

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

   Kom ihåg att Sling Models är **INTE** OSGi Services, så det är säkert att upprätthålla klasstillstånd. Skapar och ställer ofta in Sling Model-klassens tillstånd för senare användning, på samma sätt som en vanlig konstruktor gör. `@PostConstruct`

   Observera att om metoden genererar ett undantag kommer inte Sling-modellen att instansiera (den kommer att vara null). `@PostConstruct`

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
       ...
       } else if (getImage() == null || StringUtils.isBlank(getImage().getSrc())) {
           // A valid image is required
           return true;
       } else {
       ...
   }
   ```

   Observera att flera anrop till `getImage()` inte är problematiska eftersom returnerar den initierade `image` klassvariabeln och inte anropar `modelFactory.getModelFromWrappedRequest(...)` som inte är alltför dyr, men som bör undvikas att anropa i onödan.

1. Den sista `BylineImpl.java` bör se ut så här:

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
       protected static final String RESOURCE_TYPE = "wknd/components/content/byline";
   
       @Self
       private SlingHttpServletRequest request;
   
       @OSGiService
       private ModelFactory modelFactory;
   
       @ValueMapValue
       private String name;
   
       @ValueMapValue
       private List<String> occupations;
   
       private Image image;
   
       @PostConstruct
       private void init() {
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
           final Image image = getImage();
   
           if (StringUtils.isBlank(name)) {
               // Name is missing, but required
               return true;
           } else if (occupations == null || occupations.isEmpty()) {
               // At least one occupation is required
               return true;
           } else if (image == null || StringUtils.isBlank(image.getSrc())) {
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

I `ui.apps` modulen öppnar `/apps/wknd/components/content/byline/byline.html` vi den tidigare inställningen av AEM.

```html
<div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html">
</div>
<sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=false}"></sly>
```

Låt oss se vad detta HTML-skript gör hittills:

* Poängen `placeholderTemplate` pekar på Core Components platshållare, som visas när komponenten inte är helt konfigurerad. Det här återger i AEM Sites Page Editor som en ruta med komponenttiteln, enligt definitionen ovan i `cq:Component`dess `jcr:title` egenskap.

* Den `data-sly-call="${placeholderTemplate.placeholder @ isEmpty=false}` laddar det `placeholderTemplate` som definieras ovan och skickar ett booleskt värde (som för närvarande är hårdkodat till `false`) till platshållarmallen. När `isEmpty` är true återges den grå rutan av platshållarmallen, annars återges ingenting.

### Uppdatera textmarkör-HTML

1. Uppdatera **byline.html** med följande HTML-struktur för skelett:

   ```xml
   <div data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       class="cmp-byline">
           <div class="cmp-byline__image">
               <!-- Include the Core Components Image Component -->
           </div>
           <h2 class="cmp-byline__name"><!-- Include the name --></h2>
           <p class="cmp-byline__occupations"><!-- Include the occupations --></p>
   </div>
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=true}"></sly>
   ```

   Observera att CSS-klasserna följer [BEM-namnkonventionen](https://getbem.com/naming/). BEM-konventioner är inte obligatoriska, men BEM rekommenderas eftersom det används i CSS-klasser för kärnkomponenter och i allmänhet leder till rena, läsbara CSS-regler.

#### Instansierar Sling Model-objekt i HTML {#instantiating-sling-model-objects-in-htl}

Programsatsen [](https://github.com/adobe/htl-spec/blob/master/SPECIFICATION.md#221-use) Use block används för att instansiera Sling Model-objekt i HTL-skriptet och tilldela den till en HTL-variabel.

`data-sly-use.byline="com.adobe.aem.guides.wknd.models.Byline"` använder Byline-gränssnittet (com.adobe.aem.guides.wknd.models.Byline) som implementeras av BylineImpl och anpassar den aktuella SlingHttpServletRequest till det, och resultatet lagras i en HTML-variabelnamnsbit ( `data-sly-use.<variable-name>`).

1. Uppdatera yttersidan `div` så att den refererar till **Byline** Sling Model via det publika gränssnittet:

   ```xml
   <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       class="cmp-byline">
       ...
   </div>
   ```

#### Åtkomst till Sling Model-metoder {#accessing-sling-model-methods}

HTL lånar från JSTL och använder samma förkortning av Java-get-metodnamn.

Anrop av metoden Inline Sling Model kan till exempel förkortas till `getName()` , i stället för `byline.name`så kan det förkortas `byline.isEmpty``byline.empty`. Att använda fullständiga metodnamn `byline.getName` eller `byline.isEmpty`fungerar också. Observera att metoden aldrig `()` används för att anropa metoder i HTML (som JSTL).

Java-metoder som kräver en parameter **kan inte** användas i HTML. Detta är utformat för att göra logiken i HTML enkel.

1. Du kan lägga till namnet Byline i komponenten genom att anropa metoden `getName()` i Byline Sling Model eller i HTML: `${byline.name}`.

   Uppdatera `h2` -taggen:

   ```xml
   <h2 class="cmp-byline__name">${byline.name}</h2>
   ```

#### Använda alternativ för HTML-uttryck {#using-htl-expression-options}

[Alternativen](https://github.com/adobe/htl-spec/blob/master/SPECIFICATION.md#12-available-expression-options) för HTML-uttryck fungerar som modifierare för innehållet i HTML och varierar från datumformatering till i18n-översättning. Uttryck kan också användas för att sammanfoga listor eller värdematriser, vilket är vad som behövs för att visa arbetsuppgifterna i ett kommaavgränsat format.

Uttryck läggs till via operatorn `@` i HTL-uttrycket.

1. Om du vill gå med i listan över yrken med &quot;, &quot; används följande kod:

   ```html
   <p class="cmp-byline__occupations">${byline.occupations @ join=', '}</p>
   ```

#### Villkorlig visning av platshållaren {#conditionally-displaying-the-placeholder}

De flesta HTML-skript för AEM Components använder **platshållarparadigm** för att ge en visuell indikation till författare **som anger att en komponent är felaktigt skriven och inte visas i AEM Publish**. Konventionen för att driva detta beslut är att implementera en metod på komponentens bakomliggande Sling Model, i vårt fall: `Byline.isEmpty()`.

`isEmpty()` anropas i Byline Sling-modellen och resultatet (eller snarare negativt, via operatorn `!` ) sparas i en HTML-variabel med namnet `hasContent`:

1. Uppdatera det yttre `div` för att spara en HTML-variabel med namnet `hasContent`:

   ```html
    <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
         data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
         data-sly-test.hasContent="${!byline.empty}"
         class="cmp-byline">
         ...
   </div>
   ```

   Observera att `data-sly-test`HTML- `test` blocket är intressant eftersom det båda ställer in en HTML-variabel OCH återger/inte det HTML-element det är på, baserat på om resultatet av HTML-uttrycket är sant eller inte. Om värdet är&quot;true&quot; återges HTML-elementet, annars återges det inte.

   Den här HTML-variabeln `hasContent` kan nu återanvändas för att villkorligt visa/dölja platshållaren.

1. Uppdatera det villkorliga anropet till `placeholderTemplate` längst ned i filen med följande:

   ```html
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!hasContent}"></sly>
   ```

#### Visa bilden med kärnkomponenter {#using-the-core-components-image}

HTML-skriptet för `byline.html` är nu nästan färdigt och saknar bara bilden.

```html
<!--/* current progress of byline.html */-->
<div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
     data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
     data-sly-test.hasContent="${!byline.empty}"
     class="cmp-byline">
    <div class="cmp-byline__image">
        <!-- Include the Core Components Image component -->
    </div>
    <h2 class="cmp-byline__name">${byline.name}</h2>
    <p class="cmp-byline__occupations">${byline.occupations @ join=', '}</p>
</div>
<sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!hasContent}"></sly>
```

Eftersom vi använder `sling:resourceSuperType` bildkomponenten Core Components Image för att skapa bilden kan vi även använda bildkomponenten Core Component Image för att återge bilden!

Därför måste vi ta med den aktuella bylineresursen, men tvinga resurstypen för kärnkomponentavbildningskomponenten med resurstypen `core/wcm/components/image/v2/image`. Detta är ett kraftfullt mönster för återanvändning av komponenter. För detta används HTL:s `data-sly-resource` block.

1. Ersätt `div` med en klass av `cmp-byline__image` med följande:

   ```html
   <div class="cmp-byline__image"
       data-sly-resource="${ '.' @ resourceType = 'core/wcm/components/image/v2/image' }"></div>
   ```

   Detta `data-sly-resource`inkluderade den aktuella resursen via den relativa sökvägen `'.'`och tvingar den aktuella resursen (eller den ursprungliga innehållsresursen) att inkluderas med resurstypen för `core/wcm/components/image/v2/image`.

   Core Component-resurstypen används direkt, inte via en proxy, eftersom detta är en skriptbaserad användning som aldrig bevaras i vårt innehåll.

2. Slutförd `byline.html` nedan:

   ```html
   <div data-sly-use.byline="com.adobe.aem.guides.wknd.core.models.Byline"
       data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
       data-sly-test.hasContent="${!byline.empty}"
       class="cmp-byline">
       <div class="cmp-byline__image"
            data-sly-resource="${ '.' @ resourceType = 'core/wcm/components/image/v2/image' }">
       </div>
           <h2 class="cmp-byline__name">${byline.name}</h2>
           <p class="cmp-byline__occupations">${byline.occupations @ join=','}</p>
   </div>
   <sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!hasContent}"></sly>
   ```

3. Distribuera kodbasen till en lokal AEM. Sedan du gjort större ändringar i POM-filerna utför du en fullständig version av Maven från projektets rotkatalog.

   >[!WARNING]
   >
   > Observera att WKND-projektet är konfigurerat så att alla ändringar i JCR-filen skrivs över. Därför vill vi se till att vi bara distribuerar `ui.content` `ui.apps` projektet för att undvika att Byline-komponenten som lagts till på artikelsidan tidigare tas bort.

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.apps
   $ mvn -PautoInstallPackage clean install
   ...
   Package imported.
   Package installed in 338ms.
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   ```

#### Granska den oformaterade Byline-komponenten {#reviewing-the-unstyled-byline-component}

1. När du distribuerat uppdateringen navigerar du till [Ultimate Guide till LA Skateparks- ](http://localhost:4502/editor.html/content/wknd/language-masters/en/magazine/guide-la-skateparks.html) sidan eller till den plats där du lade till Byline-komponenten tidigare i kapitlet.

1. Nu visas **bilden**, **namnet** och **arbetsuppgifterna** , och vi har en informaterad men fungerande Byline-komponent.

   ![ej formaterad byline-komponent](assets/custom-component/unstyled.png)

#### Granska registreringen av försäljningsmodellen {#reviewing-the-sling-model-registration}

Statusvyn [för Sling Models på](http://localhost:4502/system/console/status-slingmodels) AEM Web Console visar alla registrerade Sling Models i AEM. Byline Sling Model kan valideras som installerad och identifieras genom att läsa den här listan.

Om **BylineImpl** inte visas i den här listan uppstod troligen ett problem med Sling Models anteckningar eller så lades Sling Model inte till i det registrerade Sling Models-paketet (com.adobe.aem.guides.wknd.core.models) i huvudprojektet.

![Byline Sling Model är registrerad](assets/custom-component/osgi-sling-models.png)

*http://localhost:4502/system/console/status-slingmodels*

## Format för pyline {#byline-styles}

Byline-komponenten måste vara formaterad så att den överensstämmer med den kreativa designen för Byline-komponenten. Detta uppnås genom att använda SCSS, som AEM stöder via delprojektet **ui.front** Maven.

Efter formateringen ska den biylinbaserade komponenten anta följande estetik.

![byline-modellformat](./assets/custom-component/byline-design.png)

*Designen av instickskomponenter så som den definieras av WKND:s kreativa team*

### Lägga till ett standardformat

Lägg till standardstilar för komponenten Byline. I **ui.front** -projektet under `/src/main/webpack/components/content`:

1. Skapa en ny mapp med namnet `byline`.
1. Skapa en ny mapp under `byline` mappen `scss`.
1. Skapa en ny fil under `byline/scss` mappen `byline.scss`.
1. Skapa en ny mapp under `byline/scss` mappen `styles`.
1. Skapa en ny fil under `byline/scss/styles` mappen `default.scss`.

   ![byline project explorer](assets/custom-component/byline-style-project-explorer.png)

1. Börja med att fylla i **byline.scss** för att inkludera standardformatet:

   ```scss
    /* WKND Byline styles */
   @import 'styles/default';
   ```

1. Lägg till CSS för Byline-implementeringar (skrivet som SCSS) i `default.scss`:

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
           font-size: $font-size-large;
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

1. Öppna filen `main.scss` i **ui.front** -projektet under `/src/main/webpack/site` och lägg till följande rad i `/* Components */` avsnittet:

   ```scss
   @import '../components/content/byline/scss/byline.scss';
   ```

1. Bygg och kompilera `ui.frontend` modulen med NPM:

   ```shell
    $ cd ~/code/aem-guides-wknd/ui.frontend
    $ npm run dev
   ```

1. Bygg och driftsätt `ui.apps` projektet, som kommer att omfatta `ui.frontend` projektet, i en lokal AEM med Maven:

   ```shell
    $ cd ~/code/aem-guides-wknd/ui.apps
    $ mvn clean install -PautoInstallPackage
   ```

   >[!TIP]
   >
   >Du kan behöva rensa webbläsarens cacheminne för att vara säker på att inaktuell CSS inte hanteras, och uppdatera sidan med den inbyggda komponenten för att få den fullständiga formateringen.

## Sammanfoga {#putting-it-together}

Nedan visas hur den helt skapade och formaterade Byline-komponenten ska se ut på AEM.

![avslutad byline-komponent](assets/custom-component/final-byline-component.png)

Titta på videon nedan för att få en snabb genomgång av vad som har byggts i den här självstudiekursen.

>[!VIDEO](https://video.tv.adobe.com/v/30174/?quality=12&learn=on)

## Grattis! {#congratulations}

Grattis! Du har just skapat en egen komponent från grunden med Adobe Experience Manager!

### Nästa steg {#next-steps}

Fortsätt att lära dig mer om AEM komponentutveckling genom att utforska hur du skriver JUnit-tester för Byline Java-koden för att säkerställa att allt utvecklas på rätt sätt och att implementerad affärslogik är korrekt och fullständig.

* [Skriva enhetstester eller AEM](unit-testing.md)

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `custom-component/solution`.

1. Klona [github.com/adobe/aem-guides-wknd](https://github.com/adobe/aem-guides-wknd) .
1. Kolla in `custom-component/solution` grenen

## Felsökning {#troubleshooting}

### Källmappar saknas

Om du inte ser `src/main/java` källmappen i Eclipse kan du lägga till mapparna genom att högerklicka på src och lägga till mappar för huvud och java. När du har lagt till mapparna visas paketet `src/main/java` .

### Olösta paket

![felsöka olösta paket](assets/custom-component/troubleshoot-unresolved-packages.png)

>[!NOTE]
>
> Om du inte har löst paketimporter för några av de nya beroendena som lagts till i huvudprojektet kan du försöka uppdatera maven-projektet aem-guides-wknd, som i sin tur uppdaterar alla delprojekt. Du kan göra detta genom att högerklicka på **aem-guides-wknd > Maven > Uppdatera projekt**.
