---
title: Developing with the AEM SPA Editor - Hello World Tutorial
description: AEM SPA Editor har stöd för kontextredigering av ett Single Page-program eller SPA. Den här självstudiekursen är en introduktion till SPA utveckling som ska användas med AEM SPA Editor JS SDK. I självstudiekursen utökas appen We.Retail Journal genom att en anpassad Hello World-komponent läggs till. Användare kan slutföra självstudiekursen med React eller Angular.
sub-product: webbplatser, innehållstjänster
feature: Spa Editor
topics: development, single-page-applications
audience: developer
doc-type: tutorial
activity: use
version: 6.3, 6.4, 6.5
topic: SPA
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '3148'
ht-degree: 0%

---


# Utveckla med AEM SPA Editor - Hello World Tutorial {#developing-with-the-aem-spa-editor-hello-world-tutorial}

>[!WARNING]
>
> Den här självstudiekursen är **inaktuell**. Vi rekommenderar att du följer något av följande: [Komma igång med AEM och Angular](https://docs.adobe.com/content/help/en/experience-manager-learn/spa-angular-tutorial/overview.html) eller [Komma igång med AEM SPA och Reagera](https://docs.adobe.com/content/help/en/experience-manager-learn/spa-react-tutorial/overview.html)

AEM SPA Editor har stöd för kontextredigering av ett Single Page-program eller SPA. Den här självstudiekursen är en introduktion till SPA utveckling som ska användas med AEM SPA Editor JS SDK. I självstudiekursen utökas appen We.Retail Journal genom att en anpassad Hello World-komponent läggs till. Användare kan slutföra självstudiekursen med React eller Angular.

>[!NOTE]
>
> Funktionen SPA (Single-Page Application Editor) kräver AEM 6.4 Service Pack 2 eller senare.
>
> SPA Editor är den rekommenderade lösningen för projekt som kräver SPA ramverksbaserad återgivning på klientsidan (t.ex. Reaktion eller Angular).

## Nödvändig läsning {#prereq}

Den här självstudiekursen är avsedd att markera de steg som behövs för att mappa en SPA till en AEM för att aktivera kontextredigering. Användare som börjar med den här självstudiekursen bör känna till grundläggande begrepp för utveckling med Adobe Experience Manager, AEM och att utveckla med React of Angular-ramverk. Självstudiekursen omfattar både back-end- och front-end-utvecklingsuppgifter.

Du bör granska följande resurser innan du startar den här självstudiekursen:

* [SPA Editor Feature Video](spa-editor-framework-feature-video-use.md)  - En videoöversikt av SPA Editor och appen We.Retail Journal.
* [Självstudiekurs](https://reactjs.org/tutorial/tutorial.html)  i React.js - en introduktion till hur du utvecklar med React Framework.
* [Självstudiekurs](https://angular.io/tutorial)  om angular - en introduktion till att utveckla med Angular

## Lokal utvecklingsmiljö {#local-dev}

Den här självstudiekursen är utformad för:

[Adobe Experience Manager 6.5](https://helpx.adobe.com/experience-manager/6-5/release-notes.html)  eller  [Adobe Experience Manager 6.4](https://helpx.adobe.com/experience-manager/6-4/sites/deploying/using/technical-requirements.html) +  [Service Pack 5](https://helpx.adobe.com/experience-manager/6-4/release-notes/sp-release-notes.html)

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

Populära ramverk [React JS](https://reactjs.org/) och [Angular](https://angular.io/) stöds inte. Användare kan slutföra den här självstudiekursen i Angular eller Reagera, beroende på vilket ramverk de är mest bekväma med.

## Projektinställningar {#project-setup}

SPA har en fot AEM utveckling och en annan. Målet är att tillåta SPA utveckling att ske oberoende av varandra och (huvudsakligen) agnostiskt för AEM.

* SPA kan fungera oberoende av det AEM projektet under utvecklingsfasen.
* Verktyg och tekniker som Webpack, NPM, [!DNL Grunt] och [!DNL Gulp]fortsätter att användas.
* För att bygga för AEM kompileras det SPA projektet och inkluderas automatiskt i det AEM projektet.
* AEM som används för att distribuera SPA till AEM.

![Översikt över artefakter och distribution](assets/spa-editor-helloworld-tutorial-use/spa-artifact-deployment.png)

*SPA har en fots i AEM utveckling, och en annan utåt, vilket gör att SPA utvecklas oberoende och (huvudsakligen) agnostiskt för AEM.*

Målet med den här självstudiekursen är att utöka appen We.Retail Journal med en ny komponent. Börja med att hämta källkoden för appen We.Retail Journal och distribuera den till en lokal AEM.

1. **Ladda** ned den senaste  [journalkoden för webb.butik från GitHub](https://github.com/adobe/aem-sample-we-retail-journal).

   Eller klona databasen från kommandoraden:

   ```shell
   $ git clone git@github.com:adobe/aem-sample-we-retail-journal.git
   ```

   >[!NOTE]
   >
   >Självstudiekursen fungerar mot grenen **överordnad** med **1.2.1-SNAPSHOT** för projektet.

1. Följande struktur ska vara synlig:

   ![Projektmappstruktur](assets/spa-editor-helloworld-tutorial-use/folder-structure.png)

   Projektet innehåller följande maven-moduler:

   * `all`: Bäddar in och installerar hela projektet i ett enda paket.
   * `bundles`: Innehåller två OSGi-paket: som innehåller  [!DNL Sling Models] och annan Java-kod.
   * `ui.apps`: innehåller /apps-delar av projektet, t.ex. JS- och CSS-klientlibs, komponenter, runmode-specifika konfigurationer.
   * `ui.content`: innehåller strukturinnehåll och konfigurationer (`/content`,  `/conf`)
   * `react-app`: Reaktionsprogram för webbutiksjournal. Det här är både en Maven-modul och ett webpack-projekt.
   * `angular-app`: Vi.Retail Journal Angular application. Detta är både en [!DNL Maven]-modul och ett webbpaketprojekt.

1. Öppna ett nytt terminalfönster och kör följande kommando för att skapa och distribuera hela programmet till en lokal AEM som körs på [http://localhost:4502](http://localhost:4502).

   ```shell
   $ cd <src>/aem-sample-we-retail-journal
   $ mvn -PautoInstallSinglePackage clean install
   ```

   >[!NOTE]
   >
   > I det här projektet är Maven-profilen för att bygga och paketera hela projektet `autoInstallSinglePackage`

   >[!CAUTION]
   >
   > Om du får ett felmeddelande när du skapar filen [kontrollerar du att filen Maven settings.xml innehåller Adobe Maven-artefaktdatabasen](https://helpx.adobe.com/experience-manager/kb/SetUpTheAdobeMavenRepository.html).

1. Navigera till:

   * [http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html)
   * [http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html)

   The We.Retail Journal App should be displayed within the AEM Sites editor.

1. I [!UICONTROL Edit]-läget markerar du en komponent som du vill redigera och gör en uppdatering av innehållet.

   ![Redigera en komponent](assets/spa-editor-helloworld-tutorial-use/editcontent.png)

1. Välj ikonen [!UICONTROL Page Properties] för att öppna [!UICONTROL Page Properties]. Välj [!UICONTROL Edit Template] för att öppna sidans mall.

   ![Meny för sidegenskaper](assets/spa-editor-helloworld-tutorial-use/page-properties.png)

1. I den senaste versionen av SPA Editor kan [Redigerbara mallar](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/page-templates-editable.html) användas på samma sätt som vid implementering av traditionella webbplatser. Detta kommer att granskas senare med vår anpassade komponent.

   >[!NOTE]
   >
   > Endast AEM 6.5 och AEM 6.4 + **Service Pack 5** stöder redigerbara mallar.

## Utvecklingsöversikt {#development-overview}

![Översiktsutveckling](assets/spa-editor-helloworld-tutorial-use/diagramv2.png)

SPA utvecklingsiterationer inträffar oberoende av AEM. När SPA är klar att distribueras till AEM utförs följande steg på hög nivå (se bilden ovan).

1. Det AEM projektet anropas, vilket i sin tur utlöser ett bygge av det SPA projektet. We.Retail Journal använder [**front-maven-plugin**](https://github.com/eirslett/frontend-maven-plugin).
1. Det SPA projektets [**aem-clientlib-generator**](https://www.npmjs.com/package/aem-clientlib-generator) bäddar in den kompilerade SPA som ett AEM klientbibliotek i AEM.
1. Det AEM projektet genererar ett AEM paket, inklusive den kompilerade SPA, plus annan AEM kod som stöds.

## Skapa AEM {#aem-component}

**Persona: AEM Developer**

En AEM kommer att skapas först. Komponenten AEM ansvarar för att återge de JSON-egenskaper som läses av komponenten React. Komponenten AEM ansvarar också för att tillhandahålla en dialogruta för alla redigerbara egenskaper i komponenten.

Importera projektet We.Retail Journal Maven med [!DNL Eclipse] eller någon annan [!DNL IDE].

1. Uppdatera reaktorn **pom.xml** för att ta bort plugin-programmet [!DNL Apache Rat]. Denna plugin kontrollerar varje fil för att se om det finns en licensrubrik. För våra syften behöver vi inte bekymra oss om den här funktionen.

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

1. I modulen **we-retail-journal-content** (`<src>/aem-sample-we-retail-journal/ui.apps`) skapar du en ny nod under `ui.apps/jcr_root/apps/we-retail-journal/components` med namnet **heloworld** av typen **cq:Component**.
1. Lägg till följande egenskaper i **heloworld**-komponenten, som representeras i XML (`/helloworld/.content.xml`) nedan:

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
   > För att illustrera funktionen Redigerbara mallar har vi angett `componentGroup="Custom Components"`. I ett verkligt projekt är det bäst att minimera antalet komponentgrupper, så en bättre grupp är &quot;[!DNL We.Retail Journal]&quot; för att matcha övriga innehållskomponenter.
   >
   > Endast AEM 6.5 och AEM 6.4 + **Service Pack 5** stöder redigerbara mallar.

1. Därefter skapas en dialogruta som tillåter att ett anpassat meddelande konfigureras för **Hello World**-komponenten. Under `/apps/we-retail-journal/components/helloworld` lägger du till ett nodnamn **cq:dialog** av **nt:ostrukturerad**.
1. **cq:dialog** visar ett textfält som består av text till egenskapen **[!DNL message]**. Under den nyligen skapade **cq:dialog** lägger du till följande noder och egenskaper, som representeras i XML nedan (`helloworld/_cq_dialog/.content.xml`):

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

   Ovanstående XML-noddefinition skapar en dialogruta med ett textfält där användaren kan skriva ett &quot;meddelande&quot;. Observera egenskapen `name="./message"` i noden `<message />`. Detta är namnet på den egenskap som ska lagras i den JCR som finns i AEM.

1. Därefter skapas en tom principdialogruta (`cq:design_dialog`). Dialogrutan Regler behövs för att visa komponenten i mallredigeraren. I det här enkla fallet är det en tom dialogruta.

   Under `/apps/we-retail-journal/components/helloworld` lägger du till ett nodnamn `cq:design_dialog` av `nt:unstructured`.

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

   I [CRXDE Lite](http://localhost:4502/crx/de/index.jsp#/apps/we-retail-journal/global/components/helloworld) validerar du att komponenten har distribuerats genom att undersöka mappen under `/apps/we-retail-journal/components:`

   ![Distribuerad komponentstruktur i CRXDE Lite](assets/spa-editor-helloworld-tutorial-use/updated-component-withdialogs.png)

## Skapa segmentmodell {#create-sling-model}

**Persona: AEM Developer**

Därefter skapas en [!DNL Sling Model]-komponent för att backa komponenten [!DNL Hello World]. I traditionell WCM-användning implementerar [!DNL Sling Model] all affärslogik och ett återgivningsskript på serversidan (HTL) anropar [!DNL Sling Model]. Detta gör återgivningsskriptet relativt enkelt.

[!DNL Sling Models] används också i SPA för att implementera affärslogik på serversidan. Skillnaden är att i [!DNL SPA]-användningsfallet visar [!DNL Sling Models] dess metoder som serialiserade JSON.

>[!NOTE]
>
>Som en god praxis bör utvecklare titta efter om det är möjligt att använda [AEM kärnkomponenter](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html). Bland annat innehåller Core Components [!DNL Sling Models] JSON-utdata som är&quot;SPA-klara&quot;, vilket gör att utvecklare kan fokusera mer på själva presentationen.

1. Öppna **we-retail-journal-Commons**-projektet ( `<src>/aem-sample-we-retail-journal/bundles/commons`) i valfri redigerare.
1. I paketet `com.adobe.cq.sample.spa.commons.impl.models`:
   * Skapa en ny klass med namnet `HelloWorld`.
   * Lägg till ett implementeringsgränssnitt för `com.adobe.cq.export.json.ComponentExporter.`

   ![Guiden Ny Java-klass](assets/spa-editor-helloworld-tutorial-use/fig5.png)

   Gränssnittet `ComponentExporter` måste implementeras för att [!DNL Sling Model] ska vara kompatibelt med AEM Content Services.

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

1. Lägg till en statisk variabel med namnet `RESOURCE_TYPE` för att identifiera [!DNL HelloWorld]-komponentens resurstyp:

   ```java
    ...
    public class HelloWorld implements ComponentExporter {
   
        static final String RESOURCE_TYPE = "we-retail-journal/components/helloworld";
   
        ...
    }
   ```

1. Lägg till OSGi-anteckningarna för `@Model` och `@Exporter`. `@Model`-anteckningen registrerar klassen som [!DNL Sling Model]. `@Exporter`-anteckningen visar metoderna som serialiserade JSON med [!DNL Jackson Exporter]-ramverket.

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

1. Implementera metoden `getDisplayMessage()` för att returnera JCR-egenskapen `message`. Använd [!DNL Sling Model]-anteckningen för `@ValueMapValue` för att göra det enkelt att hämta egenskapen `message` som lagras under komponenten. `@Optional`-anteckningen är viktig eftersom `message` inte fylls i när komponenten läggs till på sidan för första gången.

   Som en del av affärslogiken läggs strängen &quot;**Hello**&quot; till i meddelandet.

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
   > Metodnamnet `getDisplayMessage` är viktigt. När [!DNL Sling Model] har serialiserats med [!DNL Jackson Exporter] visas den som en JSON-egenskap: `displayMessage`. [!DNL Jackson Exporter] serialiserar och visar alla `getter`-metoder som inte tar någon parameter (såvida de inte uttryckligen markerats för att ignorera). Senare i appen React/Angular läser vi egenskapsvärdet och visar det som en del av programmet.

   Metoden `getExportedType` är också viktig. Värdet för komponenten `resourceType` används för att mappa JSON-data till front end-komponenten (Angular/React). Vi kommer att undersöka detta i nästa avsnitt.

1. Implementera metoden `getExportedType()` för att returnera resurstypen för `HelloWorld`-komponenten.

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

   Kontrollera distributionen och registreringen av [!DNL Sling Model] genom att gå till [[!UICONTROL Status] > [!UICONTROL Sling Models]](http://localhost:4502/system/console/status-slingmodels) i OSGi-konsolen.

   Du bör se att `HelloWorld`-delningsmodellen är bunden till resurstypen `we-retail-journal/components/helloworld` Sling och att den är registrerad som [!DNL Sling Model Exporter Servlet]:

   ```shell
   com.adobe.cq.sample.spa.commons.impl.models.HelloWorld - we-retail-journal/components/helloworld
   com.adobe.cq.sample.spa.commons.impl.models.HelloWorld exports 'we-retail-journal/components/helloworld' with selector 'model' and extension '[Ljava.lang.String;@6480f3e5' with exporter 'jackson'
   ```

## Skapa reaktionskomponent {#react-component}

**Persona: Front End Developer**

Därefter skapas komponenten React. Öppna **responsapp**-modulen ( `<src>/aem-sample-we-retail-journal/react-app`) med valfri redigerare.

>[!NOTE]
>
> Du kan hoppa över det här avsnittet om du bara är intresserad av [Angular-utveckling](#angular-component).

1. I mappen `react-app` navigerar du till mappen src. Expandera komponentmappen för att visa de befintliga React-komponentfilerna.

   ![struktur för reaktionskomponentfil](assets/spa-editor-helloworld-tutorial-use/react-components.png)

1. Lägg till en ny fil under komponentmappen `HelloWorld.js`.
1. Öppna `HelloWorld.js`. Lägg till en import-sats för att importera React-komponentbiblioteket. Lägg till en andra import-sats för att importera `MapTo`-hjälpen från Adobe. Hjälpprogrammet `MapTo` innehåller en mappning av React-komponenten till den AEM komponentens JSON.

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/cq-react-editable-components';
   ```

1. Under importen skapas en ny klass med namnet `HelloWorld` som utökar gränssnittet React `Component`. Lägg till den obligatoriska `render()`-metoden i klassen `HelloWorld`.

   ```js
   import React, {Component} from 'react';
   import {MapTo} from '@adobe/cq-react-editable-components';
   
   class HelloWorld extends Component {
   
       render() {
   
       }
   }
   ```

1. Hjälpprogrammet `MapTo` inkluderar automatiskt ett objekt med namnet `cqModel` som en del av React-komponentens förlopp. `cqModel` innehåller alla egenskaper som exponeras av [!DNL Sling Model].

   Kom ihåg att [!DNL Sling Model] som skapades tidigare innehåller metoden `getDisplayMessage()`. `getDisplayMessage()` översätts som en JSON-nyckel med namnet  `displayMessage` vid utskrift.

   Implementera metoden `render()` för att få en `h1`-tagg som innehåller värdet `displayMessage`. [JSX](https://reactjs.org/docs/introducing-jsx.html), som är ett syntaxtillägg till JavaScript, används för att returnera den slutliga koden för komponenten.

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

1. Implementera en redigeringskonfigurationsmetod. Den här metoden skickas via `MapTo`-hjälpen och ger AEM redigerare information om att visa en platshållare om komponenten är tom. Detta inträffar när komponenten läggs till i SPA men ännu inte har skapats. Lägg till följande under klassen `HelloWorld`:

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

1. I slutet av filen anropar du hjälpprogrammet `MapTo` och skickar klassen `HelloWorld` och `HelloWorldEditConfig`. Detta mappar React-komponenten till AEM utifrån AEM-komponentens resurstyp: `we-retail-journal/components/helloworld`.

   ```js
   MapTo('we-retail-journal/components/helloworld')(HelloWorld, HelloWorldEditConfig);
   ```

   Den färdiga koden för [**HelloWorld.js** finns här.](https://github.com/Adobe-Marketing-Cloud/aem-guides/blob/master/spa-helloworld-guide/src/react-app/components/HelloWorld.js)

1. Öppna filen `ImportComponents.js`. Den finns på `<src>/aem-sample-we-retail-journal/react-app/src/ImportComponents.js`.

   Lägg till en linje som kräver `HelloWorld.js` med de andra komponenterna i det kompilerade JavaScript-paketet:

   ```js
   ...
     require('./components/Text');
     require('./components/Image');
     require('./components/HelloWorld');
   ...
   ```

1. I mappen `components` skapar du en ny fil med namnet `HelloWorld.css` som en jämställd `HelloWorld.js.` Fyll filen med följande för att skapa en grundläggande formatering för `HelloWorld`-komponenten:

   ```css
   /* HelloWorld.css to style HelloWorld component */
   
   .cmp-helloworld_message {
       text-align: center;
       color: #ff505e;
       text-transform: unset;
       letter-spacing: unset;
   }
   ```

1. Öppna `HelloWorld.js` igen och uppdatera under importsatserna så att `HelloWorld.css` krävs:

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

1. Öppna `/apps/we-retail-journal/react/clientlibs/we-retail-journal-react/js/app.js` i [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/apps/we-retail-journal/react/clientlibs/we-retail-journal-react/js/app.js). Utför en snabbsökning efter HelloWorld i app.js för att kontrollera att React-komponenten ingår i den kompilerade appen.

   >[!NOTE]
   >
   > **app.** jsis the bundled React app. Koden är inte längre läsbar för människor. Kommandot `npm run build` har utlöst en optimerad version som genererar kompilerad JavaScript som kan tolkas av moderna webbläsare.


## Skapa Angular-komponent {#angular-component}

**Persona: Front End Developer**

>[!NOTE]
>
> Du kan hoppa över det här avsnittet om du bara är intresserad av React-utveckling.

Därefter skapas komponenten Angular. Öppna modulen **angular-app** (`<src>/aem-sample-we-retail-journal/angular-app`) med valfri redigerare.

1. I mappen `angular-app` navigerar du till mappen `src`. Expandera komponentmappen för att visa de befintliga komponentfilerna för Angularna.

   ![Angularnas filstruktur](assets/spa-editor-helloworld-tutorial-use/angular-file-structure.png)

1. Lägg till en ny mapp under komponentmappen `helloworld`. Under mappen `helloworld` lägger du till nya filer med namnet `helloworld.component.css, helloworld.component.html, helloworld.component.ts`.

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

1. Öppna `helloworld.component.ts`. Lägg till en import-sats för att importera klasserna `Component` och `Input` för Angularna. Skapa en ny komponent som pekar på `styleUrls` och `templateUrl` till `helloworld.component.css` och `helloworld.component.html`. Exportera slutligen klassen `HelloWorldComponent` med den förväntade inmatningen `displayMessage`.

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
   > Om du kommer ihåg [!DNL Sling Model] som skapades tidigare fanns det en metod **getDisplayMessage()**. Den serialiserade JSON-koden för den här metoden är **displayMessage**, som vi nu läser i appen Angular.

1. Öppna `helloworld.component.html` om du vill inkludera en `h1`-tagg som ska skriva ut egenskapen `displayMessage`:

   ```html
   <h1 *ngIf="displayMessage" class="cmp-helloworld_message">
       {{displayMessage}}
   </h1>
   ```

1. Uppdatera `helloworld.component.css` om du vill ta med några grundläggande format för komponenten.

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

1. Nästa uppdatering `src/components/mapping.ts` som inkluderar `HelloWorldComponent`. Lägg till en `HelloWorldEditConfig` som markerar platshållaren i AEM redigerare innan komponenten har konfigurerats. Lägg slutligen till en linje för att mappa AEM till komponenten Angular med `MapTo`-hjälpen.

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

1. Uppdatera `src/app.module.ts` för att uppdatera **NgModule**. Lägg till **`HelloWorldComponent`** som en **deklaration** som tillhör **AppModule**. Lägg också till `HelloWorldComponent` som en **entryComponent** så att den kompileras och inkluderas dynamiskt i programmet när JSON-modellen bearbetas.

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

1. Öppna `/apps/we-retail-journal/angular/clientlibs/we-retail-journal-angular/js/main.js` i [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/apps/we-retail-journal/angular/clientlibs/we-retail-journal-angular/js/main.js). Gör en snabbsökning i **HelloWorld** i `main.js` för att kontrollera att komponenten för Angular har inkluderats.

   >[!NOTE]
   >
   > **main.** jsis the bundled Angular app. Koden är inte längre läsbar för människor. Kommandot npm run build har utlöst en optimerad build som genererar kompilerat JavaScript som kan tolkas av moderna webbläsare.

## Uppdaterar mallen {#template-update}

1. Navigera till Redigerbar mall för versionerna React och/eller Angular:

   * (Angular) [http://localhost:4502/editor.html/conf/we-retail-journal/angular/settings/wcm/templates/we-retail-angular-weather-template/structure.html](http://localhost:4502/editor.html/conf/we-retail-journal/angular/settings/wcm/templates/we-retail-angular-weather-template/structure.html)
   * (Reagera) [http://localhost:4502/editor.html/conf/we-retail-journal/react/settings/wcm/templates/we-retail-react-weather-template/structure.html](http://localhost:4502/editor.html/conf/we-retail-journal/react/settings/wcm/templates/we-retail-react-weather-template/structure.html)

1. Markera huvudikonen [!UICONTROL Layout Container] och välj ikonen [!UICONTROL Policy] för att öppna profilen:

   ![Välj layoutprofil](assets/spa-editor-helloworld-tutorial-use/select-page-policy.png)

   Under **[!UICONTROL Properties]** > **[!UICONTROL Allowed Components]** söker du efter **[!DNL Custom Components]**. Du bör se **[!DNL Hello World]**-komponenten och markera den. Spara ändringarna genom att klicka i kryssrutan i det övre högra hörnet.

   ![Konfiguration av layoutbehållarprincip](assets/spa-editor-helloworld-tutorial-use/layoutcontainer-update.png)

1. När du har sparat bör du se **[!DNL HelloWorld]**-komponenten som en tillåten komponent i [!UICONTROL Layout Container].

   ![Tillåtna komponenter har uppdaterats](assets/spa-editor-helloworld-tutorial-use/allowed-components.png)

   >[!NOTE]
   >
   > Endast AEM 6.5 och AEM 6.4.5 har stöd för funktionen Redigerbar mall i SPA Editor. Om du använder AEM 6.4 måste du konfigurera principen för tillåtna komponenter manuellt via CRXDE Lite: `/conf/we-retail-journal/react/settings/wcm/policies/wcm/foundation/components/responsivegrid/default` eller `/conf/we-retail-journal/angular/settings/wcm/policies/wcm/foundation/components/responsivegrid/default`

   CRXDE Lite som visar de uppdaterade principkonfigurationerna för [!UICONTROL Allowed Components] i [!UICONTROL Layout Container]:

   ![CRXDE Lite som visar de uppdaterade principkonfigurationerna för tillåtna komponenter i layoutbehållaren](assets/spa-editor-helloworld-tutorial-use/editable-template-policy.png)

## Samla allt {#putting-together}

1. Navigera till Angularna eller Reagera-sidorna:

   * [http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/react/en/home.html)
   * [http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html](http://localhost:4502/editor.html/content/we-retail-journal/angular/en/home.html)

1. Leta reda på komponenten **[!DNL Hello World]** och dra och släpp komponenten **[!DNL Hello World]** på sidan.

   ![hej, dra och släpp](assets/spa-editor-helloworld-tutorial-use/fig7.png)

   Platshållaren ska visas.

   ![Hello World-platshållare](assets/spa-editor-helloworld-tutorial-use/fig10.png)

1. Markera komponenten och lägg till ett meddelande i dialogrutan, t.ex. &quot;World&quot; eller &quot;Your Name&quot;. Spara ändringarna.

   ![återgiven komponent](assets/spa-editor-helloworld-tutorial-use/fig11.png)

   Observera att strängen &quot;Hello&quot; alltid föregås av meddelandet. Detta är ett resultat av logiken i `HelloWorld.java` [!DNL Sling Model].

## Nästa steg {#next-steps}

[Slutförd lösning för komponenten HelloWorld](assets/spa-editor-helloworld-tutorial-use/aem-sample-we-retail-journal-HelloWorldSolution.zip)

* Fullständig källkod för [[!DNL We.Retail Journal] på GitHub](https://github.com/adobe/aem-sample-we-retail-journal)
* Titta på en mer ingående självstudiekurs om hur du utvecklar React med [[!DNL Getting Started with the AEM SPA Editor - WKND Tutorial]](https://helpx.adobe.com/experience-manager/kt/sites/using/getting-started-spa-wknd-tutorial-develop.html)

## Felsökning {#troubleshooting}

### Det gick inte att skapa projektet i Eclipse {#unable-to-build-project-in-eclipse}

**Fel:** Ett fel uppstod vid import av  [!DNL We.Retail Journal] projektet till Eclipse för okända målkörningar:

`Execution npm install, Execution npm run build, Execution default-analyze-classes*`

![Guiden för förmörkning](assets/spa-editor-helloworld-tutorial-use/fig9.png)

**Upplösning**: Klicka på Slutför för att lösa de här senare. Detta bör inte hindra att självstudiekursen slutförs.

**Fel**: Reaktionsmodulen  `react-app`fungerar inte som den ska under en Maven-byggnad.

**Upplösning:** Prova att ta bort  `node_modules` mappen under  **responsappen**. Kör kommandot Apache Maven `mvn  clean install -PautoInstallSinglePackage` från projektets rot igen.

### Otillfredsställda beroenden i AEM {#unsatisfied-dependencies-in-aem}

![Beroendefel för pakethanteraren](assets/spa-editor-helloworld-tutorial-use/we-retail-journal-package-dependency.png)

Om ett AEM inte uppfylls, antingen i **[!UICONTROL AEM Package Manager]** eller i **[!UICONTROL AEM Web Console]** (Felix Console), anger detta att funktionen SPA Editor inte är tillgänglig.

### Komponenten visas inte

**Fel**: Även efter en lyckad distribution och verifiering av att de kompilerade versionerna av React/Angular-programmen har den uppdaterade  `helloworld` komponenten visas inte min komponent när jag drar den till sidan. Jag kan se komponenten i AEM.

**Upplösning**: Rensa webbläsarens historik/cacheminne och/eller öppna en ny webbläsare eller använd läget Incognito. Om det inte fungerar gör du klientbibliotekscachen ogiltig på den lokala AEM. AEM försöker cache-lagra stora klientbibliotek för att vara effektiva. Ibland behövs det att manuellt göra cachen ogiltig för att åtgärda problem där inaktuell kod cachelagras.

Navigera till: [http://localhost:4502/libs/granite/ui/content/dumplibs.rebuild.html](http://localhost:4502/libs/granite/ui/content/dumplibs.rebuild.html) och klicka på Invalidera cache. Gå tillbaka till sidan Reagera/Angular och uppdatera sidan.

![Återskapa klientbibliotek](assets/spa-editor-helloworld-tutorial-use/invalidatecache.png)
