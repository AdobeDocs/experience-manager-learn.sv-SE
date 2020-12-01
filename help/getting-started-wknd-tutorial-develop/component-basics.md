---
title: Komma igång med AEM Sites - Grunderna i komponenter
description: Förstå den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Component genom ett enkelt HelloWorld-exempel. Ämnen som rör HTML, Sling Models, Client-side libraries och författardialogrutor har utforskats.
sub-product: platser
feature: components, sling-models, htl
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
mini-toc-levels: 1
kt: 4081
thumbnail: 30177.jpg
translation-type: tm+mt
source-git-commit: 9825f6c82aac6d57477286f651da94f05a672ea8
workflow-type: tm+mt
source-wordcount: '988'
ht-degree: 0%

---


# Grundläggande om komponenter {#component-basics}

I det här kapitlet ska vi utforska den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Component genom ett enkelt `HelloWorld`-exempel. Små ändringar kommer att göras i en befintlig komponent, som omfattar ämnen som utveckling, HTML, segmenteringsmodeller och klientbibliotek.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

## Mål {#objective}

1. Lär dig vilken roll HTML-mallar och Sling-modeller har för att dynamiskt återge HTML.
1. Förstå hur dialogrutor används för att underlätta framtagning av innehåll.
1. Lär dig grunderna i bibliotek på klientsidan som inkluderar CSS och JavaScript som stöd för en komponent.

## Vad du ska bygga {#what-you-will-build}

I det här kapitlet gör du flera ändringar av en mycket enkel `HelloWorld`-komponent. När du uppdaterar `HelloWorld`-komponenten kommer du att lära dig mer om de viktigaste områdena AEM komponentutveckling.

## Startprojekt för kapitel {#starter-project}

Det här kapitlet bygger på ett generiskt projekt som skapats av [AEM Project Archetype](https://github.com/adobe/aem-project-archetype). Titta på videon nedan och se [förutsättningarna](#prerequisites) för att komma igång!

>[!VIDEO](https://video.tv.adobe.com/v/30154/?quality=12&learn=on)

Öppna en ny kommandoradsterminal och utför följande åtgärder.

1. I en tom katalog klonar du databasen [aem-guides-wknd](https://github.com/adobe/aem-guides-wknd):

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd.git
   Cloning into 'aem-guides-wknd'...
   ```

   >[!NOTE]
   >
   > Du kan även hämta grenen [`component-basics/start`](https://github.com/adobe/aem-guides-wknd/archive/component-basics/start.zip) direkt.

1. Navigera till katalogen `aem-guides-wknd`:

   ```shell
   $ cd aem-guides-wknd
   ```

1. Växla till grenen `component-basics/start`:

   ```shell
   $ git checkout component-basics/start
   Branch component-basics/start set up to track remote branch component-basics/start from origin.
   Switched to a new branch 'component-basics/start'
   ```

1. Bygg och distribuera projektet till en lokal instans av AEM med följande kommando:

   ```shell
   $ mvn -PautoInstallSinglePackage clean install
   ...
   [INFO] ------------------------------------------------------------------------
   [INFO] Reactor Summary for aem-guides-wknd 0.0.1-SNAPSHOT:
   [INFO]
   [INFO] aem-guides-wknd .................................... SUCCESS [  0.394 s]
   [INFO] WKND Sites Project - Core .......................... SUCCESS [  7.299 s]
   [INFO] WKND Sites Project - UI Frontend ................... SUCCESS [ 31.938 s]
   [INFO] WKND Sites Project - Repository Structure Package .. SUCCESS [  0.736 s]
   [INFO] WKND Sites Project - UI apps ....................... SUCCESS [  4.025 s]
   [INFO] WKND Sites Project - UI content .................... SUCCESS [  1.447 s]
   [INFO] WKND Sites Project - All ........................... SUCCESS [  0.881 s]
   [INFO] WKND Sites Project - Integration Tests Bundles ..... SUCCESS [  1.052 s]
   [INFO] WKND Sites Project - Integration Tests Launcher .... SUCCESS [  1.239 s]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   ```

1. Importera projektet till den önskade utvecklingsmiljön genom att följa instruktionerna för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

## Komponentredigering {#component-authoring}

Komponenter kan ses som små modulära byggstenar på en webbsida. För att återanvända komponenter måste komponenterna vara konfigurerbara. Detta sker via författardialogrutan. Därefter skapar vi en enkel komponent och kontrollerar hur värden från dialogrutan bevaras i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/30176/?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. Skapa en ny sida med namnet **Komponentgrunder** under **WKND-plats** `>` **US** `>` **en**.
1. Lägg till **Hello World-komponenten** på den nyligen skapade sidan.
1. Öppna komponentens dialogruta och ange text. Spara ändringarna för att visa meddelandet på sidan.
1. Växla till utvecklarläge, visa innehållssökvägen i CRXDE-Lite och kontrollera komponentinstansens egenskaper.
1. Använd CRXDE-Lite för att visa skriptet `cq:dialog` och `helloworld.html` som finns på `/apps/wknd/components/content/helloworld`.

## HTML-mallspråk (HTL) {#htl-templates}

HTML-mallspråk eller [HTML](https://docs.adobe.com/content/help/en/experience-manager-htl/using/getting-started/getting-started.html) är ett lättviktsmallspråk på serversidan som används av AEM komponenter för att återge innehåll.

Därefter uppdaterar vi HTML-skriptet `HelloWorld` för att visa ytterligare en hälsning före textmeddelandet.

>[!VIDEO](https://video.tv.adobe.com/v/30177/?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. Växla till Eclipse IDE och öppna projektet i modulen `ui.apps`.
1. Öppna filen `.content.xml` som definierar dialogrutan för komponenten `HelloWorld` på:

   ```plain
   <code>/aem-guides-wknd/ui.apps/src/main/content/jcr_root/apps/wknd/components/content/helloworld/_cq_dialog/.content.xml
   ```

1. Uppdatera dialogrutan för att lägga till ytterligare ett textfält med namnet **Hälsning** med namnet `./greeting`:

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
                       <greeting
                           jcr:primaryType="nt:unstructured"
                           sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
                           fieldLabel="Greeting"
                           name="./greeting"/>
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

1. Öppna filen `helloworld.html`, som representerar det huvudsakliga HTML-skriptet som ansvarar för återgivningen av komponenten `HelloWorld` som finns på:

   ```plain
       <code>/aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/components/content/helloworld/helloworld.html
   ```

1. Uppdatera `helloworld.html` för att återge värdet för textfältet **Greeting** som en del av en `H1`-tagg:

   ```html
   <h1 data-sly-test="${properties.text && properties.greeting}">${properties.greeting} ${properties.text}</h1>
   <pre data-sly-use.hello="com.adobe.aem.guides.wknd.core.models.HelloWorldModel">
   HelloWorldModel says:
   ${hello.message}
   </pre>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med Eclipse Developer plugin eller med dina Maven-kunskaper.

## Sling Models {#sling-models}

Sling Models är anteckningsdrivna Java &quot;POJO&#39;s&quot; (Plain Old Java Objects) som underlättar mappningen av data från JCR till Java-variabler och som ger ett antal andra instanser vid utveckling i AEM.

Därefter uppdaterar vi `HelloWorldModel`-delningsmodellen för att tillämpa viss affärslogik på de värden som lagras i JCR innan vi skickar dem till sidan.

>[!VIDEO](https://video.tv.adobe.com/v/30189/?quality=12&learn=on)

1. Öppna filen `HelloWorldModel.java`, som är den Sling-modell som används med komponenten `HelloWorld`.

   ```plain
   <code>/aem-guides-wknd.core/src/main/java/com/adobe/aem/guides/wknd/core/models/HelloWorldModel.java
   ```

1. Lägg till följande rader i klassen `HelloWorldModel` för att mappa värdena för komponentens JCR-egenskaper `greeting` och `text` till Java-variabler:

   ```java
   ...
   @Model(adaptables = Resource.class)
   public class HelloWorldModel {
   
       ...
   
       @ValueMapValue(injectionStrategy=InjectionStrategy.OPTIONAL)
       protected String greeting;
   
       @ValueMapValue(injectionStrategy=InjectionStrategy.OPTIONAL)
       protected String text;
   
           @PostConstruct
           protected void init() {
               ...
   ```

1. Lägg till följande metod `getGreeting()` i klassen `HelloWorldModel` som returnerar värdet för egenskapen `greeting`. Den här metoden lägger till ytterligare logik för att returnera strängvärdet &quot;Hello&quot; om egenskapen `greeting` är null eller tom:

   ```java
   /***
   *
   * @return the value of greeting, if null or blank returns "Hello"
   */
   public String getGreeting() {
       return StringUtils.isNotBlank(this.greeting) ? this.greeting : "Hello";
   }
   ```

1. Lägg till följande metod `getTextUpperCase()` i klassen `HelloWorldModel` som returnerar värdet för egenskapen `text`. Den här metoden omvandlar strängen till alla upperCase-tecken.

   ```java
       /***
       *
       * @return All caps variation of the text value
       */
   public String getTextUpperCase() {
       return StringUtils.isNotBlank(this.text) ? this.text.toUpperCase() : null;
   }
   ```

1. Uppdatera filen `helloworld.html` på `aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/components/content/helloworld/helloworld.html` om du vill använda de nya metoderna i modellen `HelloWorld`:

   ```html
   <div class="cmp-helloworld" data-sly-use.hello="com.adobe.aem.guides.wknd.core.models.HelloWorldModel">
       <h1 data-sly-test="${hello.textUpperCase}">${hello.greeting} ${hello.textUpperCase}</h1>
       <pre>
       HelloWorldModel says:
       ${hello.message}
       </pre>
   </div>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med Eclipse Developer plugin eller med dina Maven-kunskaper.

## Klientbibliotek {#client-side-libraries}

Klientbibliotek, clientlibs for short, erbjuder en funktion för att organisera och hantera CSS- och JavaScript-filer som behövs för en AEM Sites-implementering. Bibliotek på klientsidan är standardsättet att inkludera CSS och JavaScript på en sida i AEM.

Därefter kommer vi att inkludera några CSS-format för `HelloWorld`-komponenten för att förstå grunderna i klientbibliotek.

>[!VIDEO](https://video.tv.adobe.com/v/30190/?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. under `/aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/components/content/helloworld` skapar en ny nod med namnet `clientlibs` och nodtypen `cq:ClientLibraryFolder`.
1. Skapa en mapp- och filstruktur som följande under `clientlibs`

   ```plain
   /helloworld
           /clientlibs
               /css/helloworld.css
               /js/helloworld.js
               +js.txt
               +css.txt
   ```

1. Fyll i `helloworld/clientlibs/css/helloworld.css` med följande:

   ```css
   .cmp-helloworld h1 {
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
   console.log("hello world!");
   ```

1. Fyll i `helloworld/clientlibs/js.txt` med följande:

   ```plain
   #base=js
   helloworld.js
   ```

1. Uppdatera nodegenskaperna `clientlibs` så att de omfattar följande två egenskaper:

   | Namn | Typ | Värde |
   |------|------|-------|
   | kategorier | Sträng | wknd.base |
   | allowProxy | Boolesk | true |

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root
       xmlns:sling="http://sling.apache.org/jcr/sling/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:primaryType="cq:ClientLibraryFolder"
       categories="wknd.base"
       allowProxy="{Boolean}true"/>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med Eclipse Developer plugin eller med dina Maven-kunskaper.

## Grattis! {#congratulations}

Grattis, du har just lärt dig grunderna i komponentutveckling i Adobe Experience Manager!

### Nästa steg {#next-steps}

Bekanta dig med Adobe Experience Manager sidor och mallar i nästa kapitel [Sidor och mallar](pages-templates.md). Lär dig mer om hur grundkomponenterna proxideras i projektet och lär dig avancerade policykonfigurationer av redigerbara mallar för att bygga ut en välstrukturerad mall för artikelsidor.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `component-basics/solution`.

1. Klona [github.com/adobe/aem-wknd-guides](https://github.com/adobe/aem-guides-wknd)-databasen.
1. Kolla in grenen `component-basics/solution`
