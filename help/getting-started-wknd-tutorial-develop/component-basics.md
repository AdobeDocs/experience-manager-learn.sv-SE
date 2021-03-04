---
title: Komma igång med AEM Sites - Grunderna i komponenter
description: Förstå den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Component genom ett enkelt HelloWorld-exempel. Ämnen som rör HTML, Sling Models, Client-side libraries och författardialogrutor har utforskats.
sub-product: platser
feature: komponenter, sling-models, htl
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
mini-toc-levels: 1
kt: 4081
thumbnail: 30177.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '1148'
ht-degree: 0%

---


# Grundläggande om komponenter {#component-basics}

I det här kapitlet ska vi utforska den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Component genom ett enkelt `HelloWorld`-exempel. Små ändringar kommer att göras i en befintlig komponent, som omfattar ämnen som utveckling, HTML, segmenteringsmodeller och klientbibliotek.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

Den IDE som används i videoklippen är [Visual Studio Code](https://code.visualstudio.com/) och [VSCode AEM Sync](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync).

## Mål {#objective}

1. Lär dig vilken roll HTML-mallar och Sling-modeller har för att dynamiskt återge HTML.
1. Förstå hur dialogrutor används för att underlätta framtagning av innehåll.
1. Lär dig grunderna i bibliotek på klientsidan som inkluderar CSS och JavaScript som stöd för en komponent.

## Vad du ska bygga {#what-you-will-build}

I det här kapitlet gör du flera ändringar av en mycket enkel `HelloWorld`-komponent. När du uppdaterar `HelloWorld`-komponenten kommer du att lära dig mer om de viktigaste områdena AEM komponentutveckling.

## Startprojekt för kapitel {#starter-project}

Det här kapitlet bygger på ett generiskt projekt som skapats av [AEM Project Archetype](https://github.com/adobe/aem-project-archetype). Titta på videon nedan och se [förutsättningarna](#prerequisites) för att komma igång!

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

>[!VIDEO](https://video.tv.adobe.com/v/330985/?quality=12&learn=on)

Öppna en ny kommandoradsterminal och utför följande åtgärder.

1. I en tom katalog klonar du databasen [aem-guides-wknd](https://github.com/adobe/aem-guides-wknd):

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd.git --branch tutorial/component-basics-start --single-branch
   ```

   >[!NOTE]
   >
   > Du kan också fortsätta använda projektet som skapades i föregående kapitel, [Projektinställningar](./project-setup.md).

1. Navigera till mappen `aem-guides-wknd`.

   ```shell
   $ cd aem-guides-wknd
   ```

1. Bygg och distribuera projektet till en lokal instans av AEM med följande kommando:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 lägger du till profilen `classic` till valfritt Maven-kommando.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

1. Importera projektet till den önskade utvecklingsmiljön genom att följa instruktionerna för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

## Komponentredigering {#component-authoring}

Komponenter kan ses som små modulära byggstenar på en webbsida. För att återanvända komponenter måste komponenterna vara konfigurerbara. Detta sker via författardialogrutan. Därefter skapar vi en enkel komponent och kontrollerar hur värden från dialogrutan bevaras i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/330986/?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. Skapa en ny sida med namnet **Komponentgrunder** under **WKND-plats** `>` **US** `>` **en**.
1. Lägg till **Hello World-komponenten** på den nyligen skapade sidan.
1. Öppna komponentens dialogruta och ange text. Spara ändringarna för att visa meddelandet på sidan.
1. Växla till utvecklarläge, visa innehållssökvägen i CRXDE-Lite och kontrollera komponentinstansens egenskaper.
1. Använd CRXDE-Lite för att visa skriptet `cq:dialog` och `helloworld.html` som finns på `/apps/wknd/components/content/helloworld`.

## HTML (HTML-mallspråk) och dialogrutor {#htl-dialogs}

HTML-mallspråk eller **[HTML](https://docs.adobe.com/content/help/en/experience-manager-htl/using/getting-started/getting-started.html)** är ett lättviktsmallspråk på serversidan som används av AEM komponenter för att återge innehåll.

**** Dialogrutor definierar de konfigurationer som är tillgängliga för en komponent.

Därefter uppdaterar vi HTML-skriptet `HelloWorld` för att visa ytterligare en hälsning före textmeddelandet.

>[!VIDEO](https://video.tv.adobe.com/v/330987/?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. Växla till IDE och öppna projektet i modulen `ui.apps`.
1. Öppna filen `helloworld.html` och gör en ändring i HTML-koden.
1. Använd IDE-verktyg som [VSCode AEM Sync](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync) för att synkronisera filändringen med den lokala AEM.
1. Återgå till webbläsaren och observera att komponentåtergivningen har ändrats.
1. Öppna filen `.content.xml` som definierar dialogrutan för komponenten `HelloWorld` på:

   ```plain
   <code>/aem-guides-wknd/ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/_cq_dialog/.content.xml
   ```

1. Uppdatera dialogrutan för att lägga till ytterligare ett textfält med namnet **Titel** med namnet `./title`:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="nt:unstructured"
       jcr:title="Properties"
       sling:resourceType="cq/gui/components/authoring/dialog">
       <content
           jcr:primaryType="nt:unstructured"
           sling:resourceType="granite/ui/components/coral/foundation/fixedcolumns">
           <items jcr:primaryType="nt:unstructured">
               <column
                   jcr:primaryType="nt:unstructured"
                   sling:resourceType="granite/ui/components/coral/foundation/container">
                   <items jcr:primaryType="nt:unstructured">
                       <title
                           jcr:primaryType="nt:unstructured"
                           sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                           fieldLabel="Title"
                           name="./title"/>
                       <text
                           jcr:primaryType="nt:unstructured"
                           sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                           fieldLabel="Text"
                           name="./text"/>
                   </items>
               </column>
           </items>
       </content>
   </jcr:root>
   ```

1. Öppna filen `helloworld.html` igen, som representerar huvudskriptet för HTML som ansvarar för återgivningen av komponenten `HelloWorld`, som finns på:

   ```plain
       <code>/aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/helloworld.html
   ```

1. Uppdatera `helloworld.html` för att återge värdet för textfältet **Greeting** som en del av en `H1`-tagg:

   ```html
   <div class="cmp-helloworld" data-cmp-is="helloworld">
       <h1 class="cmp-helloworld__title">${properties.title}</h1>
       ...
   </div>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med utvecklarpluginen eller med dina Maven-kunskaper.

## Sling Models {#sling-models}

Sling Models är anteckningsdrivna Java &quot;POJO&#39;s&quot; (Plain Old Java Objects) som underlättar mappningen av data från JCR till Java-variabler och som ger ett antal andra instanser vid utveckling i AEM.

Därefter uppdaterar vi `HelloWorldModel`-delningsmodellen för att tillämpa viss affärslogik på de värden som lagras i JCR innan vi skickar dem till sidan.

>[!VIDEO](https://video.tv.adobe.com/v/330988/?quality=12&learn=on)

1. Öppna filen `HelloWorldModel.java`, som är den Sling-modell som används med komponenten `HelloWorld`.

   ```plain
   <code>/aem-guides-wknd.core/src/main/java/com/adobe/aem/guides/wknd/core/models/HelloWorldModel.java
   ```

1. Lägg till följande importsatser:

   ```java
   import org.apache.commons.lang.StringUtils;
   import org.apache.sling.models.annotations.DefaultInjectionStrategy;
   ```

1. Uppdatera `@Model`-anteckningen så att den använder en `DefaultInjectionStrategy`:

   ```java
   @Model(adaptables = Resource.class,
      defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL)
      public class HelloWorldModel {
      ...
   ```

1. Lägg till följande rader i klassen `HelloWorldModel` för att mappa värdena för komponentens JCR-egenskaper `title` och `text` till Java-variabler:

   ```java
   ...
   @Model(adaptables = Resource.class,
   defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL)
   public class HelloWorldModel {
   
       ...
   
       @ValueMapValue
       private String title;
   
       @ValueMapValue
       private String text;
   
       @PostConstruct
       protected void init() {
           ...
   ```

1. Lägg till följande metod `getTitle()` i klassen `HelloWorldModel` som returnerar värdet för egenskapen `title`. Den här metoden lägger till ytterligare logik för att returnera strängvärdet &quot;Default Value here!&quot; om egenskapen `title` är null eller tom:

   ```java
   /***
   *
   * @return the value of title, if null or blank returns "Default Value here!"
   */
   public String getTitle() {
       return StringUtils.isNotBlank(title) ? title : "Default Value here!";
   }
   ```

1. Lägg till följande metod `getText()` i klassen `HelloWorldModel` som returnerar värdet för egenskapen `text`. Med den här metoden omvandlas strängen till alla versaler.

   ```java
       /***
       *
       * @return All caps variation of the text value
       */
   public String getText() {
       return StringUtils.isNotBlank(this.text) ? this.text.toUpperCase() : null;
   }
   ```

1. Skapa och distribuera paketet från `core`-modulen:

   ```shell
   $ cd core
   $ mvn clean install -PautoInstallBundle
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.4/6.5 ska du använda `mvn clean install -PautoInstallBundle -Pclassic`

1. Uppdatera filen `helloworld.html` på `aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/components/content/helloworld/helloworld.html` om du vill använda de nya metoderna i modellen `HelloWorld`:

   ```html
   <div class="cmp-helloworld" data-cmp-is="helloworld"
   data-sly-use.model="com.adobe.aem.guides.wknd.core.models.HelloWorldModel">
       <h1 class="cmp-helloworld__title">${model.title}</h1>
       <div class="cmp-helloworld__item" data-sly-test="${properties.text}">
           <p class="cmp-helloworld__item-label">Text property:</p>
           <pre class="cmp-helloworld__item-output" data-cmp-hook-helloworld="property">${properties.text}</pre>
       </div>
       <div class="cmp-helloworld__item" data-sly-test="${model.text}">
           <p class="cmp-helloworld__item-label">Sling Model getText() property:</p>
           <pre class="cmp-helloworld__item-output" data-cmp-hook-helloworld="property">${model.text}</pre>
       </div>
       <div class="cmp-helloworld__item"  data-sly-test="${model.message}">
           <p class="cmp-helloworld__item-label">Model message:</p>
           <pre class="cmp-helloworld__item-output"data-cmp-hook-helloworld="model">${model.message}</pre>
       </div>
   </div>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med Eclipse Developer plugin eller med dina Maven-kunskaper.

## Klientbibliotek {#client-side-libraries}

Klientbibliotek, clientlibs for short, erbjuder en funktion för att organisera och hantera CSS- och JavaScript-filer som behövs för en AEM Sites-implementering. Bibliotek på klientsidan är standardsättet att inkludera CSS och JavaScript på en sida i AEM.

Därefter kommer vi att inkludera några CSS-format för `HelloWorld`-komponenten för att förstå grunderna i klientbibliotek.

>[!VIDEO](https://video.tv.adobe.com/v/330989/?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. under `/aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/clientlibs` skapa en ny mapp med namnet `clientlib-helloworld`.
1. Skapa en mapp- och filstruktur som följande under `clientlibs`

   ```plain
   /clientlib-helloworld
       /css/helloworld.css
       /js/helloworld.js
       +js.txt
       +css.txt
       +.content.xml
   ```

1. Fyll i `helloworld.css` med följande:

   ```css
   .cmp-helloworld .cmp-helloworld__title {
       color: red;
   }
   ```

1. Fyll i `helloworld/clientlibs/css.txt` med följande:

   ```plain
   #base=css
   helloworld.css
   ```

1. Fyll i `helloworld/clientlibs/js/helloworld.js` med följande:

   ```js
   console.log("Hello World from Javascript!");
   ```

1. Fyll i `helloworld/clientlibs/js.txt` med följande:

   ```plain
   #base=js
   helloworld.js
   ```

1. Uppdatera `clientlib-helloworld/.conten.xml`-filen så att den innehåller följande egenskaper:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:ClientLibraryFolder"
       allowProxy="{Boolean}true"
       categories="[wknd.helloworld]" />
   ```

1. Uppdatera filen `clientlibs/clientlib-base/.content.xml` till **bädda in** kategorin `wknd.helloworld`:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:ClientLibraryFolder"
       allowProxy="{Boolean}true"
       categories="[wknd.base]"
       embed="[core.wcm.components.accordion.v1,core.wcm.components.tabs.v1,core.wcm.components.carousel.v1,core.wcm.components.image.v2,core.wcm.components.breadcrumb.v2,core.wcm.components.search.v1,core.wcm.components.form.text.v2,core.wcm.components.pdfviewer.v1,core.wcm.components.commons.datalayer.v1,wknd.grid,wknd.helloworld]"/>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med utvecklarpluginen eller med dina Maven-kunskaper.

   >[!NOTE]
   >
   > CSS och JavaScript cachelagras ofta av webbläsaren av prestandaskäl. Om du inte omedelbart ser ändringen för klientbiblioteket utför du en hård uppdatering och rensar webbläsarens cache. Det kan vara praktiskt att använda ett inkognito-fönster för att säkerställa en ny cache.

## Grattis! {#congratulations}

Grattis, du har just lärt dig grunderna i komponentutveckling i Adobe Experience Manager!

### Nästa steg {#next-steps}

Bekanta dig med Adobe Experience Manager sidor och mallar i nästa kapitel [Sidor och mallar](pages-templates.md). Lär dig mer om hur grundkomponenterna proxideras i projektet och lär dig avancerade policykonfigurationer av redigerbara mallar för att bygga ut en välstrukturerad mall för artikelsidor.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/component-basics-solution`.

