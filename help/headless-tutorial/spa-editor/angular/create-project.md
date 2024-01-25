---
title: SPA | Komma igång med AEM SPA Editor och Angular
description: Lär dig hur du använder ett Adobe Experience Manager (AEM) Maven-projekt som startpunkt för en Angular som är integrerad med AEM SPA Editor.
feature: SPA Editor, AEM Project Archetype
version: Cloud Service
jira: KT-5309
thumbnail: 5309-spa-angular.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 49fcd603-ab1a-4f1e-ae1f-49d3ff373439
duration: 312
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '988'
ht-degree: 0%

---

# SPA {#create-project}

Lär dig hur du använder ett Adobe Experience Manager (AEM) Maven-projekt som startpunkt för en Angular som är integrerad med AEM SPA Editor.

## Syfte

1. Förstå strukturen i ett nytt AEM SPA redigeringsprojekt som byggts från en Maven-arketype.
2. Distribuera startprojektet till en lokal instans av AEM.

## Vad du ska bygga

I det här kapitlet distribueras ett nytt AEM baserat på [AEM Project Archettype](https://github.com/adobe/aem-project-archetype). Det AEM projektet har en mycket enkel startpunkt för SPA. Det projekt som används i detta kapitel kommer att utgöra grunden för en implementering av WKND-SPA och är byggt på i framtida kapitel.

![WKND SPA Angular Starter Project](./assets/create-project/what-you-will-build.png)

*Ett klassiskt Hello World-meddelande.*

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Se till att en ny instans av Adobe Experience Manager börjar på **författare** körs lokalt.

## Hämta projektet

Det finns flera alternativ för att skapa ett flermodulsprojekt i Maven för AEM. I den här självstudien användes den senaste [AEM Project Archettype](https://github.com/adobe/aem-project-archetype) som grund för självstudiekurskoden. Projektkoden har ändrats för att stödja flera versioner av AEM. Granska [anmärkningen om bakåtkompatibilitet](overview.md#compatibility).

>[!CAUTION]
>
>Det är bäst att använda **senaste** version av [arketype](https://github.com/adobe/aem-project-archetype) för att skapa ett nytt projekt för en implementering i verkligheten. AEM ska ha en enda version av AEM som mål med `aemVersion` egenskapen för arkitypen.

1. Hämta startpunkten för den här självstudiekursen via Git:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-spa.git
   $ cd aem-guides-wknd-spa
   $ git checkout Angular/create-project-start
   ```

2. Följande mapp- och filstruktur representerar det AEM projektet som genererades av Maven-typen i det lokala filsystemet:

   ```plain
   |--- aem-guides-wknd-spa
       |--- all/
       |--- core/
       |--- dispatcher/
       |--- ui.apps/
       |--- ui.apps.structure/
       |--- ui.content/
       |--- ui.frontend /
       |--- it.tests/
       |--- pom.xml
       |--- README.md
       |--- .gitignore
       |--- archetype.properties
   ```

3. Följande egenskaper användes när det AEM projektet genererades från [AEM projekttyp](https://github.com/Adobe-Marketing-Cloud/aem-project-archetype/releases/tag/aem-project-archetype-14):

   | Egenskap | Värde |
   |-----------------|---------------------------------------|
   | aemVersion | molnet |
   | appTitle | WKND SPA Angular |
   | appId | wknd-spa-angular |
   | groupId | com.adobe.aem.guides |
   | frontModule | angular |
   | package | com.adobe.aem.guides.wknd.spa.angular |
   | includeExamples | n |

   >[!NOTE]
   >
   > Lägg märke till `frontendModule=angular` -egenskap. Detta anger att AEM Project Archetype ska starta projektet med en startare [Angularnas kodbas](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend-angular.html) som ska användas med AEM SPA.

## Bygg projektet

Därefter kompilerar, bygger och distribuerar du projektkoden till en lokal instans av AEM med Maven.

1. Kontrollera att en instans av AEM körs lokalt på porten **4502**.
2. Kontrollera att Maven är installerad från kommandoradsterminalen:

   ```shell
   $ mvn --version
   Apache Maven 3.6.2
   Maven home: /Library/apache-maven-3.6.2
   Java version: 11.0.4, vendor: Oracle Corporation, runtime: /Library/Java/JavaVirtualMachines/jdk-11.0.4.jdk/Contents/Home
   ```

3. Kör kommandot under Maven från `aem-guides-wknd-spa` katalog för att skapa och distribuera projektet till AEM:

   ```shell
   $ mvn -PautoInstallSinglePackage clean install
   ```

   Om du använder [AEM 6.x](overview.md#compatibility):

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

   Projektets flera moduler ska kompileras och distribueras till AEM.

   ```plain
   [INFO] ------------------------------------------------------------------------
   [INFO] Reactor Summary for wknd-spa-angular 1.0.0-SNAPSHOT:
   [INFO] 
   [INFO] wknd-spa-angular ................................... SUCCESS [  0.473 s]
   [INFO] WKND SPA Angular - Core ............................ SUCCESS [ 54.866 s]
   [INFO] wknd-spa-angular.ui.frontend - UI Frontend ......... SUCCESS [02:10 min]
   [INFO] WKND SPA Angular - Repository Structure Package .... SUCCESS [  0.694 s]
   [INFO] WKND SPA Angular - UI apps ......................... SUCCESS [  6.351 s]
   [INFO] WKND SPA Angular - UI content ...................... SUCCESS [  2.885 s]
   [INFO] WKND SPA Angular - All ............................. SUCCESS [  1.736 s]
   [INFO] WKND SPA Angular - Integration Tests Bundles ....... SUCCESS [  2.563 s]
   [INFO] WKND SPA Angular - Integration Tests Launcher ...... SUCCESS [  1.846 s]
   [INFO] WKND SPA Angular - Dispatcher ...................... SUCCESS [  0.270 s]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   ```

   Profilen Maven ***autoInstallSinglePackage*** kompilerar de enskilda modulerna i projektet och distribuerar ett paket till AEM. Det här paketet distribueras som standard till en AEM som körs lokalt på porten **4502** och med inloggningsuppgifterna för **admin:admin**.

4. Navigera till **[!UICONTROL Package Manager]** på din lokala AEM: [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp).

5. Tre paket för `wknd-spa-angular.all`, `wknd-spa-angular.ui.apps` och `wknd-spa-angular.ui.content`.

   ![WKND-SPA](./assets/create-project/package-manager.png)

   All anpassad kod som krävs för projektet paketeras i dessa paket och installeras i AEM.

6. Du bör också se flera paket för `spa.project.core` och `core.wcm.components`. Detta är beroenden som automatiskt inkluderas av arketypen. Mer information om [AEM kärnkomponenter finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html).

## Författarinnehåll

Öppna sedan SPA som skapades av arkivtypen och uppdatera en del av innehållet.

1. Navigera till **[!UICONTROL Sites]** konsol: [http://localhost:4502/sites.html/content](http://localhost:4502/sites.html/content).

   WKND-SPA innehåller en grundläggande webbplatsstruktur med land, språk och hemsida. Den här hierarkin baseras på arkivtypens standardvärden för `language_country` och `isSingleCountryWebsite`. Dessa värden kan skrivas över genom att uppdatera [tillgängliga egenskaper](https://github.com/adobe/aem-project-archetype#available-properties) när ett projekt genereras.

2. Öppna **[!DNL us]** > **[!DNL en]** > **[!DNL WKND SPA Angular Home Page]** genom att markera sidan och klicka på **[!UICONTROL Edit]** på menyraden:

   ![webbplatskonsol](./assets/create-project/open-home-page.png)

3. A **[!UICONTROL Text]** har redan lagts till på sidan. Du kan redigera den här komponenten på samma sätt som andra komponenter i AEM.

   ![Uppdatera textkomponent](./assets/create-project/update-text-component.gif)

4. Lägg till ytterligare **[!UICONTROL Text]** till sidan.

   Observera att redigeringsupplevelsen liknar den på en traditionell AEM Sites-sida. För närvarande finns ett begränsat antal komponenter att använda. Mer läggs till under kursen.

## Inspect för Single Page

Verifiera sedan att det här är ett Single Page-program med hjälp av webbläsarens utvecklarverktyg.

1. I **[!UICONTROL Page Editor]** klickar du på **[!UICONTROL Page Information]** meny > **[!UICONTROL View as Published]**:

   ![Knappen Visa som publicerad](./assets/create-project/view-as-published.png)

   Då öppnas en ny flik med frågeparametern `?wcmmode=disabled` som i praktiken stänger av AEM redigerare: [http://localhost:4502/content/wknd-spa-angular/us/en/home.html?wcmmode=disabled](http://localhost:4502/content/wknd-spa-angular/us/en/home.html?wcmmode=disabled)

2. Visa sidans källa och lägg märke till att textinnehållet **[!DNL Hello World]** eller något annat innehåll inte hittas. Du ska i stället se HTML så här:

   ```html
   ...
   <body>
       <noscript>You need to enable JavaScript to run this app.</noscript>
       <div id="spa-root"></div>
       <script type="text/javascript" src="/etc.clientlibs/wknd-spa-angular/clientlibs/clientlib-angular.min.js"></script>
       ...
   </body>
   ...
   ```

   `clientlib-angular.min.js` är den SPA som läses in på Angularna och som ansvarar för återgivningen av innehållet.

   *Var kommer innehållet ifrån?*

3. Återgå till fliken: [http://localhost:4502/content/wknd-spa-angular/us/en/home.html?wcmmode=disabled](http://localhost:4502/content/wknd-spa-angular/us/en/home.html?wcmmode=disabled)
4. Öppna utvecklarverktygen i webbläsaren och inspektera nätverkstrafiken på sidan under en uppdatering. Visa **XHR** begäranden:

   ![XHR-begäranden](./assets/create-project/xhr-requests.png)

   Det bör finnas en begäran om att [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json). Detta innehåller allt innehåll, formaterat i JSON, som SPA.

5. Öppna på en ny flik [http://localhost:4502/content/wknd-spa-angular/us/en.model.json](http://localhost:4502/content/wknd-spa-angular/us/en.model.json)

   Begäran `en.model.json` representerar innehållsmodellen som ska köra programmet. Inspect JSON-utdata och du bör kunna hitta kodavsnittet som representerar **[!UICONTROL Text]** komponenter.

   ```json
   ...
   ":items": {
       "text": {
           "text": "<p>Hello World! Updated content!</p>\r\n",
           "richText": true,
           ":type": "wknd-spa-angular/components/text"
       },
       "text_98796435": {
           "text": "<p>A new text component.</p>\r\n",
           "richText": true,
           ":type": "wknd-spa-angular/components/text"
   },
   ...
   ```

   I nästa kapitel kommer vi att undersöka hur JSON-innehållet mappas från AEM till SPA komponenter för att utgöra grunden för AEM SPA.

   >[!NOTE]
   >
   > Det kan vara praktiskt att installera ett webbläsartillägg som automatiskt formaterar JSON-utdata.

## Grattis! {#congratulations}

Grattis, du har precis skapat ditt första AEM SPA Editor Project!

Det är ganska enkelt just nu, men i de kommande kapitlen läggs fler funktioner till.

### Nästa steg {#next-steps}

[Integrera SPA](integrate-spa.md) - Lär dig hur SPA källkod är integrerad med det AEM projektet och förstå vilka verktyg som finns för att snabbt utveckla SPA.
