---
title: Komma igång med AEM Sites - Grunderna i komponenter
description: Förstå den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Component genom ett enkelt HelloWorld-exempel. Ämnen som rör HTML, Sling Models, Client-side libraries och författardialogrutor har utforskats.
version: 6.5, Cloud Service
feature: Core Components, Developer Tools
topic: Content Management, Development
role: Developer
level: Beginner
mini-toc-levels: 1
jira: KT-4081
thumbnail: 30177.jpg
doc-type: Tutorial
exl-id: 7fd021ef-d221-4113-bda1-4908f3a8629f
recommendations: noDisplay, noCatalog
source-git-commit: 30d6120ec99f7a95414dbc31c0cb002152bd6763
workflow-type: tm+mt
source-wordcount: '1226'
ht-degree: 0%

---

# Grundläggande om komponenter {#component-basics}

I det här kapitlet ska vi titta närmare på den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Components via en enkel `HelloWorld` exempel. Små ändringar görs i en befintlig komponent, som omfattar ämnen som redigering, HTML, segmenteringsmodeller och klientbibliotek.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](./overview.md#local-dev-environment).

Den utvecklingsmiljö som används i videoklippen är [Visual Studio Code](https://code.visualstudio.com/) och [Synkronisering AEM VSCode](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync) plugin-program.

## Syfte {#objective}

1. Lär dig vilken roll HTML-mallar och Sling-modeller har för att dynamiskt återge HTML.
1. Förstå hur dialogrutor används för att underlätta framtagning av innehåll.
1. Lär dig grunderna i bibliotek på klientsidan som inkluderar CSS och JavaScript som stöd för en komponent.

## Vad du ska bygga {#what-build}

I det här kapitlet gör du flera ändringar av en enkel `HelloWorld` -komponenten. När du uppdaterar `HelloWorld` om du vill veta mer om de viktigaste områdena AEM komponentutveckling.

## Startprojekt för kapitel {#starter-project}

Det här kapitlet bygger på ett allmänt projekt som genererats av [AEM Project Archettype](https://github.com/adobe/aem-project-archetype). Titta på videon nedan och titta på [krav](#prerequisites) för att komma igång!

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

>[!VIDEO](https://video.tv.adobe.com/v/330985?quality=12&learn=on)

Öppna en ny kommandoradsterminal och utför följande åtgärder.

1. Klona [aem-guides-wknd](https://github.com/adobe/aem-guides-wknd) databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd.git --branch tutorial/component-basics-start --single-branch
   ```

   >[!NOTE]
   >
   > Du kan också fortsätta använda det projekt som skapades i föregående kapitel, [Projektinställningar](./project-setup.md).

1. Navigera till  `aem-guides-wknd` mapp.

   ```shell
   $ cd aem-guides-wknd
   ```

1. Bygg och distribuera projektet till en lokal instans av AEM med följande kommando:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 ska du lägga till `classic` för alla Maven-kommandon.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

1. Importera projektet till din egen utvecklingsmiljö genom att följa instruktionerna för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

## Komponentutveckling {#component-authoring}

Komponenter kan ses som små modulära byggstenar på en webbsida. Komponenterna måste vara konfigurerbara för att kunna återanvända dem. Detta sker via författardialogrutan. Låt oss sedan skapa en enkel komponent och kontrollera hur värden från dialogrutan bevaras i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/330986?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. Skapa en sida med namnet **Grundläggande om komponenter** under **WKND-plats** `>` **USA** `>` **en**.
1. Lägg till **Hello World-komponent** till den nya sidan.
1. Öppna komponentens dialogruta och ange text. Spara ändringarna för att visa meddelandet på sidan.
1. Växla till utvecklarläge, visa innehållssökvägen i CRXDE-Lite och kontrollera komponentinstansens egenskaper.
1. Använd CRXDE-Lite för att visa `cq:dialog` och `helloworld.html` skript från `/apps/wknd/components/content/helloworld`.

## HTML (HTML Template Language) och dialogrutor {#htl-dialogs}

HTML mallspråk eller **[HTL](https://experienceleague.adobe.com/docs/experience-manager-htl/content/getting-started.html)** är ett lättviktsmallspråk på serversidan som används av AEM komponenter för att återge innehåll.

**Dialogrutor** Definiera de konfigurationer som är tillgängliga för en komponent.

Vi uppdaterar `HelloWorld` HTML-skript om du vill visa en extra hälsning före textmeddelandet.

>[!VIDEO](https://video.tv.adobe.com/v/330987?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. Växla till IDE och öppna projektet till `ui.apps` -modul.
1. Öppna `helloworld.html` och uppdatera HTML Markup.
1. Använd IDE-verktygen som [Synkronisering AEM VSCode](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync) om du vill synkronisera filändringen med den lokala AEM.
1. Återgå till webbläsaren och observera att komponentåtergivningen har ändrats.
1. Öppna `.content.xml` som definierar dialogrutan för `HelloWorld` komponent vid:

   ```plain
   <code>/aem-guides-wknd/ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/_cq_dialog/.content.xml
   ```

1. Uppdatera dialogrutan för att lägga till ett extra textfält med namnet **Titel** med namnet `./title`:

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

1. Öppna filen igen `helloworld.html`, som representerar det huvudsakliga HTML-skriptet som ansvarar för återgivningen av `HelloWorld` komponent från nedanför bana:

   ```plain
       <code>/aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/helloworld.html
   ```

1. Uppdatera `helloworld.html` för att återge värdet på **Hälsning** textfält som en del av ett `H1` tagg:

   ```html
   <div class="cmp-helloworld" data-cmp-is="helloworld">
       <h1 class="cmp-helloworld__title">${properties.title}</h1>
       ...
   </div>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med utvecklarpluginen eller med dina Maven-kunskaper.

## Sling Models {#sling-models}

Sling Models är annoteringsdrivna Java™ &quot;POJOs&quot; (Plain Old Java™ Objects) som gör det enklare att mappa data från JCR till Java™-variabler. De erbjuder också flera andra institutioner när de utvecklas i samband med AEM.

Nu ska vi göra några uppdateringar i `HelloWorldModel` Sling Model för att tillämpa viss affärslogik på de värden som lagras i JCR innan de skrivs ut på sidan.

>[!VIDEO](https://video.tv.adobe.com/v/330988?quality=12&learn=on)

1. Öppna filen `HelloWorldModel.java`, som används med `HelloWorld` -komponenten.

   ```plain
   <code>/aem-guides-wknd.core/src/main/java/com/adobe/aem/guides/wknd/core/models/HelloWorldModel.java
   ```

1. Lägg till följande importsatser:

   ```java
   import org.apache.commons.lang3.StringUtils;
   import org.apache.sling.models.annotations.DefaultInjectionStrategy;
   ```

1. Uppdatera `@Model` anteckning för att använda en `DefaultInjectionStrategy`:

   ```java
   @Model(adaptables = Resource.class,
      defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL)
      public class HelloWorldModel {
      ...
   ```

1. Lägg till följande rader i `HelloWorldModel` klass för att mappa värdena för komponentens JCR-egenskaper `title` och `text` till Java™-variabler:

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

1. Lägg till följande metod `getTitle()` till `HelloWorldModel` klass, som returnerar värdet för egenskapen med namnet `title`. Den här metoden lägger till ytterligare logik för att returnera strängvärdet &quot;Default Value here!&quot; om egenskapen `title` är null eller tomt:

   ```java
   /***
   *
   * @return the value of title, if null or blank returns "Default Value here!"
   */
   public String getTitle() {
       return StringUtils.isNotBlank(title) ? title : "Default Value here!";
   }
   ```

1. Lägg till följande metod `getText()` till `HelloWorldModel` klass, som returnerar värdet för egenskapen med namnet `text`. Med den här metoden omvandlas strängen till alla versaler.

   ```java
       /***
       *
       * @return All caps variation of the text value
       */
   public String getText() {
       return StringUtils.isNotBlank(this.text) ? this.text.toUpperCase() : null;
   }
   ```

1. Bygg och distribuera paketet från `core` modul:

   ```shell
   $ cd core
   $ mvn clean install -PautoInstallBundle
   ```

   >[!NOTE]
   >
   > För AEM 6.4/6.5 `mvn clean install -PautoInstallBundle -Pclassic`

1. Uppdatera filen `helloworld.html` på `aem-guides-wknd.ui.apps/src/main/content/jcr_root/apps/wknd/components/content/helloworld/helloworld.html` för att använda de nya metoderna i `HelloWorld` modell.

   The `HelloWorld` Modellen instansieras för den här komponentinstansen via HTL-direktivet: `data-sly-use.model="com.adobe.aem.guides.wknd.core.models.HelloWorldModel"`, sparar instansen i variabeln `model`.

   The `HelloWorld` modellinstansen är nu tillgänglig i HTML via `model` variabeln med `HelloWord`. De här metoderna kan anropa med förkortad metodsyntax: `${model.getTitle()}` kan kortas till `${model.title}`.

   På samma sätt injiceras alla HTML-skript med [globala objekt](https://experienceleague.adobe.com/docs/experience-manager-htl/content/global-objects.html) som kan nås med samma syntax som Sling Model-objekten.

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
   </div>
   ```

1. Distribuera ändringarna till en lokal instans av AEM med Eclipse Developer plugin eller med dina Maven-kunskaper.

## Bibliotek på klientsidan {#client-side-libraries}

Bibliotek på klientsidan, `clientlibs` kort och gott: innehåller en mekanism för att organisera och hantera CSS- och JavaScript-filer som behövs för en AEM Sites-implementering. Klientbibliotek är standardsättet att inkludera CSS och JavaScript på en sida i AEM.

The [ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html) modulen är en frikopplad [webbpaket](https://webpack.js.org/) projekt som är integrerat i byggprocessen. Detta gör att du kan använda populära front-end-bibliotek som Sass, LESS och TypeScript. The `ui.frontend` finns mer ingående i [Kapitel om bibliotek på klientsidan](/help/getting-started-wknd-tutorial-develop/project-archetype/client-side-libraries.md).

Uppdatera sedan CSS-formaten för `HelloWorld` -komponenten.

>[!VIDEO](https://video.tv.adobe.com/v/340750?quality=12&learn=on)

Nedan visas de steg på hög nivå som utförs i videon ovan.

1. Öppna ett terminalfönster och navigera till `ui.frontend` katalog

1. Jag är `ui.frontend` katalogen kör `npm install npm-run-all --save-dev` för att installera [npm-run-all](https://www.npmjs.com/package/npm-run-all) nodmodul. Det här steget är **krävs för Archetype 39-genererat AEM** i kommande version av Archetype krävs inte detta.

1. Kör sedan `npm run watch` kommando:

   ```shell
   $ npm run watch
   ```

1. Växla till IDE och öppna projektet till `ui.frontend` -modul.
1. Öppna filen `ui.frontend/src/main/webpack/components/_helloworld.scss`.
1. Uppdatera filen så att den visar en röd titel:

   ```scss
   .cmp-helloworld {}
   .cmp-helloworld__title {
       color: red;
   }
   ```

1. I terminalen ska du se aktivitet som indikerar att `ui.frontend` -modulen kompilerar och synkroniserar ändringarna med den lokala instansen av AEM.

   ```shell
   Entrypoint site 214 KiB = clientlib-site/site.css 8.45 KiB clientlib-site/site.js 206 KiB
   2022-02-22 17:28:51: webpack 5.69.1 compiled successfully in 119 ms
   change:dist/index.html
   + jcr_root/apps/wknd/clientlibs/clientlib-site/css/site.css
   + jcr_root/apps/wknd/clientlibs/clientlib-site/css
   + jcr_root/apps/wknd/clientlibs/clientlib-site/js/site.js
   + jcr_root/apps/wknd/clientlibs/clientlib-site/js
   + jcr_root/apps/wknd/clientlibs/clientlib-site
   + jcr_root/apps/wknd/clientlibs/clientlib-dependencies/css.txt
   + jcr_root/apps/wknd/clientlibs/clientlib-dependencies/js.txt
   + jcr_root/apps/wknd/clientlibs/clientlib-dependencies
   ```

1. Återgå till webbläsaren och observera att titelfärgen har ändrats.

   ![Komponentgrunder - uppdatering](assets/component-basics/color-update.png)

## Grattis! {#congratulations}

Grattis, du har lärt dig grunderna i komponentutveckling i Adobe Experience Manager!

### Nästa steg {#next-steps}

Bekanta dig med Adobe Experience Manager sidor och mallar i nästa kapitel [Sidor och mallar](pages-templates.md). Lär dig mer om hur grundkomponenterna proxideras i projektet och lär dig avancerade policykonfigurationer av redigerbara mallar för att bygga ut en välstrukturerad mall för artikelsidor.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/component-basics-solution`.
