---
title: Developing with the AEM SPA Editor - Hello World Tutorial
description: AEM SPA Editor har stöd för kontextredigering av ett Single Page-program eller SPA. Den här självstudiekursen är en introduktion till SPA utveckling som ska användas med AEM SPA Editor JS SDK. I självstudiekursen utökas appen We.Retail Journal genom att en anpassad Hello World-komponent läggs till. Användare kan slutföra självstudiekursen med React eller Angular.
version: 6.3, 6.4, 6.5
topic: SPA
feature: SPA Editor
role: Developer
level: Beginner
exl-id: e900301d-411c-4c02-8443-2a0fa56b65b5
source-git-commit: 631fef25620c84e04c012c8337c9b76613e3ad46
workflow-type: tm+mt
source-wordcount: '3116'
ht-degree: 0%

---

# Developing with the AEM SPA Editor - Hello World Tutorial {#developing-with-the-aem-spa-editor-hello-world-tutorial}

>[!WARNING]
>
> Den här självstudiekursen är **föråldrad**. Vi rekommenderar att du följer något av följande: [Komma igång med AEM SPA Editor och Angular](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/spa-editor/angular/overview.html) eller [Komma igång med AEM SPA Editor och React](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/spa-editor/react/overview.html)

AEM SPA Editor har stöd för kontextredigering av ett Single Page-program eller SPA. Den här självstudiekursen är en introduktion till SPA utveckling som ska användas med AEM SPA Editor JS SDK. I självstudiekursen utökas appen We.Retail Journal genom att en anpassad Hello World-komponent läggs till. Användare kan slutföra självstudiekursen med React eller Angular.

>[!NOTE]
>
> Funktionen SPA (Single-Page Application Editor) kräver AEM 6.4 Service Pack 2 eller senare.
>
> SPA Editor är den rekommenderade lösningen för projekt som kräver SPA ramverksbaserad återgivning på klientsidan (t.ex. Reaktion eller Angular).

## Nödvändig läsning {#prereq}

Den här självstudiekursen är avsedd att markera de steg som behövs för att mappa en SPA till en AEM för att aktivera kontextredigering. Användare som börjar med den här självstudiekursen bör känna till grundläggande begrepp för utveckling med Adobe Experience Manager, AEM och att utveckla med React of Angular-ramverk. Självstudiekursen omfattar både back-end- och front-end-utvecklingsuppgifter.

Du bör granska följande resurser innan du startar den här självstudiekursen:

* [SPA Editor Feature Video](spa-editor-framework-feature-video-use.md) - En videoöversikt av appen SPA Editor och We.Retail Journal.
* [React.js - självstudiekurs](https://reactjs.org/tutorial/tutorial.html) - En introduktion till utvecklingen med React Framework.
* [Självstudiekurs om angular](https://angular.io/tutorial) - En introduktion till att utveckla med Angular

## Lokal utvecklingsmiljö {#local-dev}

Den här självstudiekursen är utformad för:

[Adobe Experience Manager 6.5](https://helpx.adobe.com/experience-manager/6-5/release-notes.html) eller [Adobe Experience Manager 6.4](https://helpx.adobe.com/experience-manager/6-4/sites/deploying/using/technical-requirements.html) + [Service Pack 5](https://helpx.adobe.com/experience-manager/6-4/release-notes/sp-release-notes.html)

I den här självstudiekursen ska följande tekniker och verktyg installeras:

1. [Java 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
2. [Apache Maven - 3.3.1+](https://maven.apache.org/)
3. [Node.js - 8.11.1+](https://nodejs.org/en/) och npm 5.6.0+ (npm installeras med node.js)

Dubbelkontrollera installationen av ovanstående verktyg genom att öppna en ny terminal och köra följande:

```shell
$ java -version
java version "11 +"

$ mvn -version
Apache Maven 3.3.9

$ node --version
v8.11.1

$ npm --version
6.1.0
```

## Översikt {#overview}

Det grundläggande konceptet är att mappa en SPA till en AEM. AEM komponenter, som kör server, exporterar innehåll i form av JSON. JSON-innehållet används av SPA, som kör klientsidan i webbläsaren. En 1:1-mappning skapas mellan SPA och en AEM.

![SPA](assets/spa-editor-helloworld-tutorial-use/mapto.png)

Populära ramverk [Reagera JS](https://reactjs.org/) och [Angular](https://angular.io/) stöds inte direkt. Användare kan slutföra den här självstudiekursen i Angular eller Reagera, beroende på vilket ramverk de är mest bekväma med.

## Projektinställningar {#project-setup}

SPA har en fot AEM utveckling och en annan. Målet är att tillåta SPA utveckling att ske oberoende av varandra och (huvudsakligen) agnostiskt för AEM.

* SPA kan fungera oberoende av det AEM projektet under utvecklingsfasen.
* Bygg verktyg och tekniker som Webpack, NPM, [!DNL Grunt] och [!DNL Gulp]fortsätta att användas.
* För att bygga för AEM kompileras det SPA projektet och inkluderas automatiskt i det AEM projektet.
* AEM som används för att distribuera SPA till AEM.

![Översikt över artefakter och distribution](assets/spa-editor-helloworld-tutorial-use/spa-artifact-deployment.png)

*SPA har en fots i AEM utveckling, och en annan utåt, vilket gör att SPA utvecklas oberoende och (huvudsakligen) agnostiskt för AEM.*

Målet med den här självstudiekursen är att utöka appen We.Retail Journal med en ny komponent. Börja med att hämta källkoden för appen We.Retail Journal och distribuera den till en lokal AEM.

1. **Hämta** senaste [Journal-kod för återförsäljning från GitHub](https://github.com/adobe/aem-sample-we-retail-journal).

   Eller klona databasen från kommandoraden:

   ```shell
   $ git clone git@github.com:adobe/aem-sample-we-retail-journal.git
   ```

   >[!NOTE]
   >
   >Självstudiekursen kommer att arbeta mot **överordnad** förgrening med **1.2.1-ÖGONBLICKSBILD** version av projektet.

1. Följande struktur ska vara synlig:

   ![Projektmappstruktur](assets/spa-editor-helloworld-tutorial-use/folder-structure.png)

   Projektet innehåller följande maven-moduler:

   * `all`: Bäddar in och installerar hela projektet i ett enda paket.
   * `bundles`: Innehåller två OSGi-paket: som innehåller [!DNL Sling Models] och annan Java-kod.
   * `ui.apps`: innehåller /apps-delar av projektet, t.ex. JS- och CSS-klientlibs, komponenter, runmode-specifika konfigurationer.
   * `ui.content`: innehåller strukturinnehåll och konfigurationer (`/content`, `/conf`)
   * `react-app`: Reaktionsprogram för webbutiksjournal. Det här är både en Maven-modul och ett webpack-projekt.
   * `angular-app`: Vi.Retail Journal Angular application. Det här är båda en [!DNL Maven] och ett webbpaketprojekt.

1. Öppna ett nytt terminalfönster och kör följande kommando för att skapa och distribuera hela programmet till en lokal AEM som körs på [http://localhost:4502](http://localhost:4502).

   ```shell
   $ cd <src>/aem-sample-we-retail-journal
   $ mvn -PautoInstallSinglePackage clean install
   ```

   >[!NOTE]
   >
   > I det här projektet är Maven-profilen att bygga och paketera hela projektet `autoInstallSinglePackage`

1. Navigera till:

   * [http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html)
   * [http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html)

   The We.Retail Journal App should be displayed within the AEM Sites editor.

1. I [!UICONTROL Edit] markerar du en komponent som du vill redigera och gör en uppdatering av innehållet.

   ![Redigera en komponent](assets/spa-editor-helloworld-tutorial-use/editcontent.png)

1. Välj [!UICONTROL Page Properties] -ikonen för att öppna [!UICONTROL Page Properties]. Välj [!UICONTROL Edit Template] för att öppna sidans mall.

   ![Meny för sidegenskaper](assets/spa-editor-helloworld-tutorial-use/page-properties.png)

1. I den senaste versionen av SPA [Redigerbara mallar](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/page-templates-editable.html) kan användas på samma sätt som med traditionella implementeringar av webbplatser. Detta kommer att granskas senare med vår anpassade komponent.

   >[!NOTE]
   >
   > Endast AEM 6.5 och AEM 6.4 + **Service Pack 5** stöder redigerbara mallar.

## Utvecklingsöversikt {#development-overview}

![Översiktsutveckling](assets/spa-editor-helloworld-tutorial-use/diagramv2.png)

SPA utvecklingsiterationer inträffar oberoende av AEM. När SPA är klar att distribueras till AEM utförs följande steg på hög nivå (se bilden ovan).

1. Det AEM projektet anropas, vilket i sin tur utlöser ett bygge av det SPA projektet. We.Retail Journal använder [**front-maven-plugin**](https://github.com/eirslett/frontend-maven-plugin).
1. SPA [**aem-clientlib-generator**](https://www.npmjs.com/package/aem-clientlib-generator) bäddar in den kompilerade SPA som ett AEM klientbibliotek i det AEM projektet.
1. Det AEM projektet genererar ett AEM paket, inklusive den kompilerade SPA, plus annan AEM kod som stöds.

## Skapa AEM {#aem-component}

**Persona: AEM Developer**

En AEM kommer att skapas först. Komponenten AEM ansvarar för att återge de JSON-egenskaper som läses av komponenten React. Komponenten AEM ansvarar också för att tillhandahålla en dialogruta för alla redigerbara egenskaper i komponenten.

Använda [!DNL Eclipse]eller andra [!DNL IDE], importera projektet We.Retail Journal Maven.

1. Uppdatera reaktorn **pom.xml** för att ta bort [!DNL Apache Rat] plugin. Denna plugin kontrollerar varje fil för att se om det finns en licensrubrik. För våra syften behöver vi inte bekymra oss om den här funktionen.

   I **aem-sample-we-retail-journal/pom.xml** ta bort **apache-rate-plugin**:

   ```xml
   <!-- Remove apache-rat-plugin -->
   <plugin>
           <groupId>org.apache.rat</groupId>
           <artifactId>apache-rat-plugin</artifactId>
           <configuration>
               <excludes combine.children="append">
                   <exclude>*</exclude>
                       ...
               </excludes>
           </configuration>
           <executions>
                   <execution>
                       <phase>verify</phase>
                       <goals>
                           <goal>check</goal>
                       </goals>
               </execution>
           </executions>
       </plugin>
   ```

1. I **webbutiker-journal-content** (`<src>/aem-sample-we-retail-journal/ui.apps`) skapar du en ny nod under `ui.apps/jcr_root/apps/we-retail-journal/components` namngiven **helig** av typen **cq:Component**.
1. Lägg till följande egenskaper i **helig** -komponent, i XML-format (`/helloworld/.content.xml`) nedan:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
       jcr:description="Hello World Component for We.Retail Journal"
       jcr:primaryType="cq:Component"
       jcr:title="Hello World"
       componentGroup="We.Retail Journal" />
   ```

   ![Hello World-komponent](assets/spa-editor-helloworld-tutorial-use/hello-world-component.png)

   >[!NOTE]
   >
   > För att illustrera funktionen Redigerbara mallar har vi ställt in `componentGroup="Custom Components"`. I ett verkligt projekt är det bäst att minimera antalet komponentgrupper, så en bättre grupp är[!DNL We.Retail Journal]&quot; för att matcha övriga innehållskomponenter.
   >
   > Endast AEM 6.5 och AEM 6.4 + **Service Pack 5** stöder redigerbara mallar.

1. Därefter skapas en dialogruta som tillåter att ett anpassat meddelande konfigureras för **Hello World** -komponenten. Under `/apps/we-retail-journal/components/helloworld` lägg till ett nodnamn **cq:dialog** av **nt:ostrukturerad**.
1. The **cq:dialog** visar ett textfält som består av text till en egenskap med namnet **[!DNL message]**. Under den nyskapade **cq:dialog** lägg till följande noder och egenskaper, som representeras i XML nedan (`helloworld/_cq_dialog/.content.xml`) :

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="nt:unstructured"
       jcr:title="We.Retail Journal - Hello World"
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
                                                   fieldLabel="Message"
                                                   name="./message"
                                                   required="{Boolean}true"/>
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

   ![filstruktur](assets/spa-editor-helloworld-tutorial-use/updated-with-dialog.png)

   Ovanstående XML-noddefinition skapar en dialogruta med ett textfält där användaren kan skriva ett &quot;meddelande&quot;. Observera egenskapen `name="./message"` inom `<message />` nod. Detta är namnet på den egenskap som ska lagras i den JCR som finns i AEM.

1. Därefter skapas en tom principdialogruta (`cq:design_dialog`). Dialogrutan Regler behövs för att visa komponenten i mallredigeraren. I det här enkla fallet är det en tom dialogruta.

   Under `/apps/we-retail-journal/components/helloworld` lägg till ett nodnamn `cq:design_dialog` av `nt:unstructured`.

   Konfigurationen visas i XML nedan (`helloworld/_cq_design_dialog/.content.xml`)

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
   jcr:primaryType="nt:unstructured" />
   ```

1. Distribuera kodbasen till AEM från kommandoraden:

   ```shell
   $ cd <src>/aem-sample-we-retail-journal/content
   $ mvn -PautoInstallPackage clean install
   ```

   I [CRXDE Lite](http://localhost:4502/crx/de/index.jsp#/apps/we-retail-journal/global/components/helloworld) validera att komponenten har distribuerats genom att inspektera mappen under `/apps/we-retail-journal/components:`

   ![Distribuerad komponentstruktur i CRXDE Lite](assets/spa-editor-helloworld-tutorial-use/updated-component-withdialogs.png)

## Skapa segmentmodell {#create-sling-model}

**Persona: AEM Developer**

Nästa a [!DNL Sling Model] skapas för att backa [!DNL Hello World] -komponenten. I traditionell WCM-användning [!DNL Sling Model] implementerar all affärslogik och ett återgivningsskript (HTL) på serversidan anropar [!DNL Sling Model]. Detta gör återgivningsskriptet relativt enkelt.

[!DNL Sling Models] används också i SPA för att implementera affärslogik på serversidan. Skillnaden är att i [!DNL SPA] use case, [!DNL Sling Models] visar dess metoder som serialiserade JSON.

>[!NOTE]
>
>Det bästa sättet för utvecklare är att använda [AEM kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html) när det är möjligt. Bland annat innehåller kärnkomponenterna [!DNL Sling Models] med JSON-utdata som är&quot;SPA-klara&quot;, vilket gör att utvecklarna kan fokusera mer på själva presentationen.

1. Öppna **vi-retail-journal-Commons** projekt ( `<src>/aem-sample-we-retail-journal/bundles/commons`).
1. I paketet `com.adobe.cq.sample.spa.commons.impl.models`:
   * Skapa en ny klass med namnet `HelloWorld`.
   * Lägg till ett implementeringsgränssnitt för `com.adobe.cq.export.json.ComponentExporter.`

   ![Guiden Ny Java-klass](assets/spa-editor-helloworld-tutorial-use/fig5.png)

   The `ComponentExporter` -gränssnittet måste implementeras för att [!DNL Sling Model] för att vara kompatibel med AEM Content Services.

   ```java
    package com.adobe.cq.sample.spa.commons.impl.models;
   
    import com.adobe.cq.export.json.ComponentExporter;
   
    public class HelloWorld implements ComponentExporter {
   
        @Override
        public String getExportedType() {
            return null;
        }
    }
   ```

1. Lägg till en statisk variabel med namnet `RESOURCE_TYPE` för att identifiera [!DNL HelloWorld] komponentens resurstyp:

   ```java
    ...
    public class HelloWorld implements ComponentExporter {
   
        static final String RESOURCE_TYPE = "we-retail-journal/components/helloworld";
   
        ...
    }
   ```

1. Lägg till OSGi-anteckningar för `@Model` och `@Exporter`. The `@Model` anteckningen registrerar klassen som [!DNL Sling Model]. The `@Exporter` -anteckningen visar metoderna som serialiserade JSON med [!DNL Jackson Exporter] ramverk.

   ```java
   import org.apache.sling.api.SlingHttpServletRequest;
   import org.apache.sling.models.annotations.Exporter;
   import org.apache.sling.models.annotations.Model;
   import com.adobe.cq.export.json.ExporterConstants;
   ...
   
   @Model(
           adaptables = SlingHttpServletRequest.class,
           adapters = {ComponentExporter.class},
           resourceType = HelloWorld.RESOURCE_TYPE
   )
   @Exporter(
           name = ExporterConstants.SLING_MODEL_EXPORTER_NAME, 
           extensions = ExporterConstants.SLING_MODEL_EXTENSION
   )
   public class HelloWorld implements ComponentExporter {
   
   ...
   ```

1. Implementera metoden `getDisplayMessage()` för att returnera JCR-egenskapen `message`. Använd [!DNL Sling Model] anteckning till `@ValueMapValue` för att göra det enkelt att hämta egenskapen `message` lagras under komponenten. The `@Optional` anteckningen är viktig eftersom komponenten läggs till på sidan första gången,  `message`  fylls inte i.

   Som en del av affärslogiken, en sträng, &quot;**Hej**&quot;, kommer att föregås av meddelandet.

   ```java
   import org.apache.sling.models.annotations.injectorspecific.ValueMapValue;
   import org.apache.sling.models.annotations.Optional;
   
   ...
   
   public class HelloWorld implements ComponentExporter {
   
      static final String RESOURCE_TYPE = "we-retail-journal/components/helloworld";
   
      private static final String PREPEND_MSG = "Hello";
   
       @ValueMapValue @Optional
       private String message;
   
       public String getDisplayMessage() {
           if(message != null && message.length() > 0) {
               return PREPEND_MSG + " "  + message;
           }
           return null;
       }
   
   ...
   ```

   >[!NOTE]
   >
   > Metodnamnet `getDisplayMessage` är viktigt. När [!DNL Sling Model] är serialiserad med [!DNL Jackson Exporter] den kommer att visas som en JSON-egenskap: `displayMessage`. The [!DNL Jackson Exporter] kommer att serialisera och visa alla `getter` metoder som inte tar någon parameter (om de inte uttryckligen markerats för att ignoreras). Senare i appen React/Angular läser vi egenskapsvärdet och visar det som en del av programmet.

   Metoden `getExportedType` är också viktigt. Komponentens värde `resourceType` används för att&quot;mappa&quot; JSON-data till front end-komponenten (Angular/React). Vi kommer att undersöka detta i nästa avsnitt.

1. Implementera metoden `getExportedType()` för att returnera resurstypen för `HelloWorld` -komponenten.

   ```java
    @Override
       public String getExportedType() {
           return RESOURCE_TYPE;
       }
   ```

   Den fullständiga koden för [**HelloWorld.java** finns här.](https://github.com/Adobe-Marketing-Cloud/aem-guides/blob/master/spa-helloworld-guide/src/bundles/commons/HelloWorld.java)

1. Distribuera koden till AEM med Apache Maven:

   ```shell
   $ cd <src>/sample-we-retail-spa-content/bundles/commons
   $ mvn -PautoInstallPackage clean install
   ```

   Verifiera distributionen och registreringen av [!DNL Sling Model] genom att navigera till [[!UICONTROL Status] > [!UICONTROL Sling Models]](http://localhost:4502/system/console/status-slingmodels) i OSGi-konsolen.

   Du borde se att `HelloWorld` Sling Model är bunden till `we-retail-journal/components/helloworld` Sling-resurstyp och att den är registrerad som [!DNL Sling Model Exporter Servlet]:

   ```shell
   com.adobe.cq.sample.spa.commons.impl.models.HelloWorld - we-retail-journal/components/helloworld
   com.adobe.cq.sample.spa.commons.impl.models.HelloWorld exports 'we-retail-journal/components/helloworld' with selector 'model' and extension '[Ljava.lang.String;@6480f3e5' with exporter 'jackson'
   ```

## Skapa reaktionskomponent {#react-component}

**Persona: Front End Developer**

Därefter skapas komponenten React. Öppna **responsapp** modul ( `<src>/aem-sample-we-retail-journal/react-app`) med valfri redigerare.

>[!NOTE]
>
> Hoppa över det här avsnittet om du bara är intresserad av [Angular](#angular-component).

1. Innanför `react-app` mappen navigerar till sin src-mapp. Expandera komponentmappen för att visa de befintliga React-komponentfilerna.

   ![struktur för reaktionskomponentfil](assets/spa-editor-helloworld-tutorial-use/react-components.png)

1. Lägg till en ny fil under komponentmappen med namnet `HelloWorld.js`.
1. Öppna `HelloWorld.js`. Lägg till en import-sats för att importera React-komponentbiblioteket. Lägg till en andra import-sats för att importera `MapTo` Hjälp från Adobe. The `MapTo` hjälper dig att mappa React-komponenten till den AEM komponentens JSON.

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/cq-react-editable-components';
   ```

1. Under importen skapas en ny klass med namnet `HelloWorld` som utökar Reaktionen `Component` gränssnitt. Lägg till de obligatoriska `render()` till `HelloWorld` klassen.

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/cq-react-editable-components';
   
   class HelloWorld extends Component {
   
       render() {
   
       }
   }
   ```

1. The `MapTo` hjälpfunktionen tar automatiskt med ett objekt med namnet `cqModel` som en del av React-komponentens proppar. The `cqModel` innehåller alla egenskaper som exponeras av [!DNL Sling Model].

   Kom ihåg [!DNL Sling Model] som skapades tidigare innehåller en metod `getDisplayMessage()`. `getDisplayMessage()` översätts som en JSON-nyckel med namnet `displayMessage` vid utskrift.

   Implementera `render()` metod för att skapa utdata för `h1` -tagg som innehåller värdet för `displayMessage`. [JSX](https://reactjs.org/docs/introducing-jsx.html), som är ett syntaxtillägg till JavaScript, används för att returnera den slutliga koden för komponenten.

   ```js
   ...
   
   class HelloWorld extends Component {
       render() {
   
           if(this.props.displayMessage) {
               return (
                   <div className="cmp-helloworld">
                       <h1 className="cmp-helloworld_message">{this.props.displayMessage}</h1>
                   </div>
               );
           }
           return null;
       }
   }
   ```

1. Implementera en redigeringskonfigurationsmetod. Den här metoden skickas via `MapTo` hjälper och förser AEM redigeraren med information som visar en platshållare om komponenten är tom. Detta inträffar när komponenten läggs till i SPA men ännu inte har skapats. Lägg till följande nedanför `HelloWorld` klass:

   ```js
   ...
   
   class HelloWorld extends Component {
       ...
   }
   
   const HelloWorldEditConfig = {
   
       emptyLabel: 'Hello World',
   
       isEmpty: function(props) {
           return !props || !props.displayMessage || props.displayMessage.trim().length < 1;
       }
   };
   
   ...
   ```

1. I slutet av filen ringer du `MapTo` hjälpare, skicka `HelloWorld` -klassen och `HelloWorldEditConfig`. Detta mappar React-komponenten till AEM utifrån AEM-komponentens resurstyp: `we-retail-journal/components/helloworld`.

   ```js
   MapTo('we-retail-journal/components/helloworld')(HelloWorld, HelloWorldEditConfig);
   ```

   Den färdiga koden för [**HelloWorld.js** finns här.](https://github.com/Adobe-Marketing-Cloud/aem-guides/blob/master/spa-helloworld-guide/src/react-app/components/HelloWorld.js)

1. Öppna filen `ImportComponents.js`. Den finns på `<src>/aem-sample-we-retail-journal/react-app/src/ImportComponents.js`.

   Lägg till en rad som kräver `HelloWorld.js` med övriga komponenter i det kompilerade JavaScript-paketet:

   ```js
   ...
     require('./components/Text');
     require('./components/Image');
     require('./components/HelloWorld');
   ...
   ```

1. I  `components`  mapp skapa en ny fil med namnet `HelloWorld.css` som en syskon `HelloWorld.js.` Fyll filen med följande för att skapa en grundläggande formatering för `HelloWorld` komponent:

   ```css
   /* HelloWorld.css to style HelloWorld component */
   
   .cmp-helloworld_message {
       text-align: center;
       color: #ff505e;
       text-transform: unset;
       letter-spacing: unset;
   }
   ```

1. Öppna igen `HelloWorld.js` och uppdatera under importprogramsatserna för att kräva `HelloWorld.css`:

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/cq-react-editable-components';
   
   require('./HelloWorld.css');
   
   ...
   ```

1. Distribuera koden till AEM med Apache Maven:

   ```shell
   $ cd <src>/sample-we-retail-spa-content
   $ mvn -PautoInstallSinglePackage clean install
   ```

1. I [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/apps/we-retail-journal/react/clientlibs/we-retail-journal-react/js/app.js) open `/apps/we-retail-journal/react/clientlibs/we-retail-journal-react/js/app.js`. Utför en snabbsökning efter HelloWorld i app.js för att kontrollera att React-komponenten ingår i den kompilerade appen.

   >[!NOTE]
   >
   > **app.js** är den paketerade React-appen. Koden är inte längre läsbar för människor. The `npm run build` -kommandot har utlöst en optimerad version som genererar kompilerat JavaScript som kan tolkas av moderna webbläsare.


## Skapa Angular-komponent {#angular-component}

**Persona: Front End Developer**

>[!NOTE]
>
> Du kan hoppa över det här avsnittet om du bara är intresserad av React-utveckling.

Därefter skapas komponenten Angular. Öppna **angular-app** modul (`<src>/aem-sample-we-retail-journal/angular-app`) med valfri redigerare.

1. Innanför `angular-app` mapp navigera till dess `src` mapp. Expandera komponentmappen för att visa de befintliga komponentfilerna för Angularna.

   ![Angularnas filstruktur](assets/spa-editor-helloworld-tutorial-use/angular-file-structure.png)

1. Lägg till en ny mapp under komponentmappen med namnet `helloworld`. Under `helloworld` mapp lägga till nya filer namngivna `helloworld.component.css, helloworld.component.html, helloworld.component.ts`.

   ```plain
   /angular-app
       /src
           /app
               /components
   +                /helloworld
   +                    helloworld.component.css
   +                    helloworld.component.html
   +                    helloworld.component.ts
   ```

1. Öppna `helloworld.component.ts`. Lägga till en importsats för att importera Angularna `Component` och `Input` klasser. Skapa en ny komponent som pekar på `styleUrls` och `templateUrl` till `helloworld.component.css` och `helloworld.component.html`. Exportera slutligen klassen `HelloWorldComponent` med förväntad inmatning av `displayMessage`.

   ```js
   //helloworld.component.ts
   
   import { Component, Input } from '@angular/core';
   
   @Component({
     selector: 'app-helloworld',
     host: { 'class': 'cmp-helloworld' },
     styleUrls:['./helloworld.component.css'],
     templateUrl: './helloworld.component.html',
   })
   
   export class HelloWorldComponent {
     @Input() displayMessage: string;
   }
   ```

   >[!NOTE]
   >
   > Om du minns [!DNL Sling Model] skapades tidigare, det fanns en metod **getDisplayMessage()**. Den serialiserade JSON för den här metoden kommer att **displayMessage** som vi nu läser i appen Angular.

1. Öppna `helloworld.component.html` att inkludera `h1` -taggen som ska skriva ut `displayMessage` egenskap:

   ```html
   <h1 *ngIf="displayMessage" class="cmp-helloworld_message">
       {{displayMessage}}
   </h1>
   ```

1. Uppdatera `helloworld.component.css` om du vill ta med vissa grundläggande format för komponenten.

   ```css
   :host-context {
       display: block;
   };
   
   .cmp-helloworld {
       display:block;
   }
   .cmp-helloworld_message {
       text-align: center;
       color: #ff505e;
       text-transform: unset;
       letter-spacing: unset;
   }
   ```

1. Uppdatera `helloworld.component.spec.ts` med följande testbädd:

   ```js
   import { async, ComponentFixture, TestBed } from '@angular/core/testing';
   
   import { HelloWorldComponent } from './helloworld.component';
   
       describe('HelloWorld', () => {
       let component: HelloWorldComponent;
       let fixture: ComponentFixture<HelloWorldComponent>;
   
       beforeEach(async(() => {
           TestBed.configureTestingModule({
           declarations: [ HelloWorldComponent ]
           })
           .compileComponents();
       }));
   
       beforeEach(() => {
           fixture = TestBed.createComponent(HelloWorldComponent);
           component = fixture.componentInstance;
           fixture.detectChanges();
       });
   
       it('should create', () => {
           expect(component).toBeTruthy();
       });
   });
   ```

1. Nästa uppdatering `src/components/mapping.ts` som innehåller `HelloWorldComponent`. Lägg till en `HelloWorldEditConfig` som markerar platshållaren i AEM redigerare innan komponenten har konfigurerats. Lägg slutligen till en linje för att mappa AEM till komponenten Angular med `MapTo` hjälpare.

   ```js
   // src/components/mapping.ts
   
   import { HelloWorldComponent } from "./helloworld/helloworld.component";
   
   ...
   
   const HelloWorldEditConfig = {
   
       emptyLabel: 'Hello World',
   
       isEmpty: function(props) {
           return !props || !props.displayMessage || props.displayMessage.trim().length < 1;
       }
   };
   
   ...
   
   MapTo('we-retail-journal/components/helloworld')(HelloWorldComponent, HelloWorldEditConfig);
   ```

   Den fullständiga koden för [**mapping.ts** finns här.](https://github.com/Adobe-Marketing-Cloud/aem-guides/blob/master/spa-helloworld-guide/src/angular-app/mapping.ts)

1. Uppdatera `src/app.module.ts` för att uppdatera **NgModule**. Lägg till **`HelloWorldComponent`** som **deklaration** som tillhör **AppModule**. Lägg även till `HelloWorldComponent` som **entryComponent** så att den kompileras och inkluderas dynamiskt i programmet när JSON-modellen bearbetas.

   ```js
   import { HelloWorldComponent } from './components/helloworld/helloworld.component';
   
   ...
   
   @NgModule({
     imports: [BrowserModule.withServerTransition({ appId: 'we-retail-sample-angular' }),
       SpaAngularEditableComponentsModule,
     AngularWeatherWidgetModule.forRoot({
       key: "37375c33ca925949d7ba331e52da661a",
       name: WeatherApiName.OPEN_WEATHER_MAP,
       baseUrl: 'http://api.openweathermap.org/data/2.5'
     }),
       AppRoutingModule,
       BrowserTransferStateModule],
     providers: [ModelManagerService,
       { provide: APP_BASE_HREF, useValue: '/' }],
     declarations: [AppComponent,
       TextComponent,
       ImageComponent,
       WeatherComponent,
       NavigationComponent,
       MenuComponent,
       MainContentComponent,
       HelloWorldComponent],
     entryComponents: [TextComponent,
       ImageComponent,
       WeatherComponent,
       NavigationComponent,
       MainContentComponent,
       HelloWorldComponent],
     bootstrap: [AppComponent]
    })
   ```

   Den färdiga koden för [**app.module.ts** finns här.](https://github.com/Adobe-Marketing-Cloud/aem-guides/blob/master/spa-helloworld-guide/src/angular-app/app.module.ts)

1. Distribuera koden till AEM med Maven:

   ```shell
   $ cd <src>/sample-we-retail-spa-content
   $ mvn -PautoInstallSinglePackage clean install
   ```

1. I [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/apps/we-retail-journal/angular/clientlibs/we-retail-journal-angular/js/main.js) open `/apps/we-retail-journal/angular/clientlibs/we-retail-journal-angular/js/main.js`. Gör en snabbsökning efter **HelloWorld** in `main.js` för att verifiera att Angularna har inkluderats.

   >[!NOTE]
   >
   > **main.js** är den paketerade Angularna. Koden är inte längre läsbar för människor. Kommandot npm run build har utlöst en optimerad build som genererar kompilerat JavaScript som kan tolkas av moderna webbläsare.

## Uppdatera mallen {#template-update}

1. Navigera till Redigerbar mall för versionerna React och/eller Angular:

   * (Angular) [http://localhost:4502/editor.html/conf/we-retail-journal/angular/settings/wcm/templates/we-retail-angular-weather-template/structure.html](http://localhost:4502/editor.html/conf/we-retail-journal/angular/settings/wcm/templates/we-retail-angular-weather-template/structure.html)
   * (React) [http://localhost:4502/editor.html/conf/we-retail-journal/react/settings/wcm/templates/we-retail-react-weather-template/structure.html](http://localhost:4502/editor.html/conf/we-retail-journal/react/settings/wcm/templates/we-retail-react-weather-template/structure.html)

1. Markera huvudsidan [!UICONTROL Layout Container] och väljer [!UICONTROL Policy] ikon för att öppna profilen:

   ![Välj layoutprofil](assets/spa-editor-helloworld-tutorial-use/select-page-policy.png)

   Under **[!UICONTROL Properties]** > **[!UICONTROL Allowed Components]** utför en sökning efter **[!DNL Custom Components]**. Du borde se **[!DNL Hello World]** markerar du den. Spara ändringarna genom att klicka i kryssrutan i det övre högra hörnet.

   ![Konfiguration av layoutbehållarprincip](assets/spa-editor-helloworld-tutorial-use/layoutcontainer-update.png)

1. När du har sparat bör du se **[!DNL HelloWorld]** som en tillåten komponent i [!UICONTROL Layout Container].

   ![Tillåtna komponenter har uppdaterats](assets/spa-editor-helloworld-tutorial-use/allowed-components.png)

   >[!NOTE]
   >
   > Endast AEM 6.5 och AEM 6.4.5 har stöd för funktionen Redigerbar mall i SPA Editor. Om du använder AEM 6.4 måste du konfigurera principen för tillåtna komponenter manuellt via CRXDE Lite: `/conf/we-retail-journal/react/settings/wcm/policies/wcm/foundation/components/responsivegrid/default` eller `/conf/we-retail-journal/angular/settings/wcm/policies/wcm/foundation/components/responsivegrid/default`

   CRXDE Lite visar de uppdaterade principkonfigurationerna för [!UICONTROL Allowed Components] i [!UICONTROL Layout Container]:

   ![CRXDE Lite som visar de uppdaterade principkonfigurationerna för tillåtna komponenter i layoutbehållaren](assets/spa-editor-helloworld-tutorial-use/editable-template-policy.png)

## Sammanställ allt {#putting-together}

1. Navigera till Angularna eller Reagera-sidorna:

   * [http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html)
   * [http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html)

1. Hitta **[!DNL Hello World]** och dra och släppa **[!DNL Hello World]** till sidan.

   ![hej, dra och släpp](assets/spa-editor-helloworld-tutorial-use/fig7.png)

   Platshållaren ska visas.

   ![Hello World-platshållare](assets/spa-editor-helloworld-tutorial-use/fig10.png)

1. Markera komponenten och lägg till ett meddelande i dialogrutan, t.ex. &quot;World&quot; eller &quot;Your Name&quot;. Spara ändringarna.

   ![återgiven komponent](assets/spa-editor-helloworld-tutorial-use/fig11.png)

   Observera att strängen &quot;Hello&quot; alltid föregås av meddelandet. Detta är ett resultat av logiken i `HelloWorld.java` [!DNL Sling Model].

## Nästa steg {#next-steps}

[Slutförd lösning för komponenten HelloWorld](assets/spa-editor-helloworld-tutorial-use/aem-sample-we-retail-journal-HelloWorldSolution.zip)

* Fullständig källkod för [[!DNL We.Retail Journal] på GitHub](https://github.com/adobe/aem-sample-we-retail-journal)
* Se en mer ingående självstudiekurs om hur du utvecklar React med [[!DNL Getting Started with the AEM SPA Editor - WKND Tutorial]](https://helpx.adobe.com/experience-manager/kt/sites/using/getting-started-spa-wknd-tutorial-develop.html)

## Felsökning {#troubleshooting}

### Det gick inte att skapa projektet i Eclipse {#unable-to-build-project-in-eclipse}

**Fel:** Ett fel uppstod vid import av [!DNL We.Retail Journal] projektet till Eclipse för okända målkörningar:

`Execution npm install, Execution npm run build, Execution default-analyze-classes*`

![Guiden för förmörkning](assets/spa-editor-helloworld-tutorial-use/fig9.png)

**Upplösning**: Klicka på Slutför för att lösa de här senare. Detta bör inte hindra att självstudiekursen slutförs.

**Fel**: Reaktionsmodulen, `react-app`, fungerar inte korrekt under en Maven-byggnad.

**Upplösning:** Prova att ta bort `node_modules` mappen under **responsapp**. Kör kommandot Apache Maven igen `mvn  clean install -PautoInstallSinglePackage` från projektets rot.

### Otillfredsställda beroenden i AEM {#unsatisfied-dependencies-in-aem}

![Beroendefel för pakethanteraren](assets/spa-editor-helloworld-tutorial-use/we-retail-journal-package-dependency.png)

Om ett AEM-beroende inte uppfylls finns det i **[!UICONTROL AEM Package Manager]** eller i **[!UICONTROL AEM Web Console]** (Felix Console) betyder det att SPA redigeringsfunktion inte är tillgänglig.

### Komponenten visas inte

**Fel**: Även efter en lyckad driftsättning och verifiering av att de kompilerade versionerna av React/Angular-programmen har uppdaterats `helloworld` -komponenten visas inte min komponent när jag drar den till sidan. Jag kan se komponenten i AEM.

**Upplösning**: Rensa webbläsarens historik/cacheminne och/eller öppna en ny webbläsare eller använd läget Incognito. Om det inte fungerar gör du klientbibliotekscachen ogiltig på den lokala AEM. AEM försöker cache-lagra stora klientbibliotek för att vara effektiva. Ibland behövs det att manuellt göra cachen ogiltig för att åtgärda problem där inaktuell kod cachelagras.

Navigera till: [http://localhost:4502/libs/granite/ui/content/dumplibs.rebuild.html](http://localhost:4502/libs/granite/ui/content/dumplibs.rebuild.html) och klicka på Ovalidera cache. Gå tillbaka till sidan Reagera/Angular och uppdatera sidan.

![Återskapa klientbibliotek](assets/spa-editor-helloworld-tutorial-use/invalidatecache.png)
