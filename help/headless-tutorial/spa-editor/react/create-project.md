---
title: Skapa projekt | Komma igång med AEM SPA Editor och React
description: Lär dig hur du skapar ett Adobe Experience Manager (AEM) Maven-projekt som utgångspunkt för ett React-program som är integrerat med AEM SPA Editor.
feature: SPA Editor, AEM Project Archetype
version: Cloud Service
jira: KT-413
thumbnail: 413-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 57c8fc16-fed5-4af4-b98b-5c3f0350b240
duration: 306
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '974'
ht-degree: 0%

---

# Skapa projekt {#spa-editor-project}

Lär dig hur du skapar ett Adobe Experience Manager (AEM) Maven-projekt som utgångspunkt för ett React-program som är integrerat med AEM SPA Editor.

## Syfte

1. Skapa ett projekt som SPA redigeraren har aktiverat med hjälp av AEM Project Archetype.
2. Distribuera startprojektet till en lokal instans av AEM.

## Vad du ska bygga {#what-build}

I det här kapitlet skapas ett nytt AEM baserat på [AEM Project Archettype](https://github.com/adobe/aem-project-archetype). Det AEM projektet inleds med en mycket enkel startpunkt för SPA React.

**Vad är ett Maven-projekt?** - [Apache Maven](https://maven.apache.org/) är ett programhanteringsverktyg för att skapa projekt. *Alla Adobe Experience Manager* implementeringar använder Maven-projekt för att skapa, hantera och distribuera anpassad kod utöver AEM.

**Vad är en Maven-arketype?** - A [Maven Archetype](https://maven.apache.org/archetype/index.html) är en mall eller ett mönster för generering av nya projekt. Med den AEM projekttypen kan vi generera ett nytt projekt med ett anpassat namnutrymme och inkludera en projektstruktur som följer bästa praxis, vilket avsevärt snabbar upp vårt projekt.

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Se till att en ny instans av Adobe Experience Manager börjar på **författare** körs lokalt.

## Skapa projektet {#create}

>[!NOTE]
>
>Den här självstudiekursen använder version **35** av arkitypen.

1. Öppna en kommandoradsterminal och ange följande Maven-kommando:

   ```shell
   mvn -B org.apache.maven.plugins:maven-archetype-plugin:3.2.1:generate \
    -D archetypeGroupId=com.adobe.aem \
    -D archetypeArtifactId=aem-project-archetype \
    -D archetypeVersion=35 \
    -D appTitle="WKND SPA React" \
    -D appId="wknd-spa-react" \
    -D artifactId="aem-guides-wknd-spa.react" \
    -D groupId="com.adobe.aem.guides.wkndspa.react" \
    -D frontendModule="react" \
    -D aemVersion="cloud"
   ```

   >[!NOTE]
   >
   > Om mål AEM 6.5.5+ ersätts `aemVersion="cloud"` med `aemVersion="6.5.5"`. Om mål är 6.4.8+, använd `aemVersion="6.4.8"`.

   Lägg märke till `frontendModule=react` -egenskap. Detta anger att AEM Project Archetype ska starta projektet med en startare [Reaktionskodbas](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend-react.html) som ska användas med AEM SPA. Egenskaper som `appTitle`, `appId`, `artifactId`och `groupId` används för att identifiera projektet och syftet.

   En fullständig lista över tillgängliga egenskaper för konfiguration av ett projekt [finns här](https://github.com/adobe/aem-project-archetype#available-properties).

1. Följande mapp- och filstruktur genereras av Maven-typen i det lokala filsystemet:

   ```plain
   |--- aem-guides-wknd-spa.react/
       |--- LICENSE
       |--- README.md
       |--- all/
       |--- archetype.properties
       |--- core/
       |--- dispatcher/
       |--- it.tests/
       |--- pom.xml
       |--- ui.apps/
       |--- ui.apps.structure/
       |--- ui.config/
       |--- ui.content/
       |--- ui.frontend/
       |--- ui.tests /
       |--- .gitignore
   ```

   Varje mapp representerar en enskild Maven-modul. I den här självstudiekursen kommer vi i första hand att arbeta med `ui.frontend` som är React-appen. Mer information om enskilda moduler finns i [AEM Project Archetype-dokumentation](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html).

## Distribuera och skapa projektet

Därefter kompilerar, bygger och distribuerar du projektkoden till en lokal instans av AEM med Maven.

1. Kontrollera att en instans av AEM körs lokalt på porten **4502**.
1. Navigera från kommandoraden till `aem-guides-wknd-spa.react` projektkatalog.

   ```shell
   $ cd aem-guides-wknd-spa.react
   ```

1. Kör följande kommando för att skapa och distribuera hela projektet till AEM:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Byggnaden tar ca en minut och avslutas med följande meddelande:

   ```shell
   ...
   [INFO] ------------------------------------------------------------------------
   [INFO] Reactor Summary for aem-guides-wknd-spa.react 1.0.0-SNAPSHOT:
   [INFO]
   [INFO] aem-guides-wknd-spa.react .......................... SUCCESS [  0.257 s]
   [INFO] WKND SPA React - Core .............................. SUCCESS [ 12.553 s]
   [INFO] WKND SPA React - UI Frontend ....................... SUCCESS [01:46 min]
   [INFO] WKND SPA React - Repository Structure Package ...... SUCCESS [  1.082 s]
   [INFO] WKND SPA React - UI apps ........................... SUCCESS [  8.237 s]
   [INFO] WKND SPA React - UI content ........................ SUCCESS [  5.633 s]
   [INFO] WKND SPA React - UI config ......................... SUCCESS [  0.234 s]
   [INFO] WKND SPA React - All ............................... SUCCESS [  0.643 s]
   [INFO] WKND SPA React - Integration Tests ................. SUCCESS [ 12.377 s]
   [INFO] WKND SPA React - Dispatcher ........................ SUCCESS [  0.066 s]
   [INFO] WKND SPA React - UI Tests .......................... SUCCESS [  0.074 s]
   [INFO] WKND SPA React - Project Analyser .................. SUCCESS [ 31.287 s]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   ```

   Profilen Maven `autoInstallSinglePackage` kompilerar de enskilda modulerna i projektet och distribuerar ett paket till AEM. Det här paketet distribueras som standard till en AEM som körs lokalt på porten **4502** och med inloggningsuppgifterna för `admin:admin`.

1. Navigera till **Pakethanteraren** på din lokala AEM: [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp).

1. Du bör se flera paket som är prefix med `aem-guides-wknd-spa.react`.

   ![WKND-SPA](assets/create-project/package-manager.png)

   *AEM*

   All anpassad kod som krävs för projektet paketeras i dessa paket och installeras i AEM.

## Författarinnehåll

Öppna sedan SPA som skapades av arkivtypen och uppdatera en del av innehållet.

1. Navigera till **Webbplatser** konsol: [http://localhost:4502/sites.html/content](http://localhost:4502/sites.html/content).

   WKND-SPA innehåller en grundläggande webbplatsstruktur med land, språk och hemsida. Den här hierarkin baseras på arkivtypens standardvärden för `language_country` och `isSingleCountryWebsite`. Dessa värden kan skrivas över genom att uppdatera [tillgängliga egenskaper](https://github.com/adobe/aem-project-archetype#available-properties) när ett projekt genereras.

2. Öppna **oss** > **en** > **WKND SPA React Home Page** genom att markera sidan och klicka på **Redigera** på menyraden:

   ![webbplatskonsol](./assets/create-project/open-home-page.png)

3. A **Text** har redan lagts till på sidan. Du kan redigera den här komponenten på samma sätt som andra komponenter i AEM.

   ![Uppdatera textkomponent](./assets/create-project/update-text-component.gif)

4. Lägg till ytterligare **Text** till sidan.

   Observera att redigeringsupplevelsen liknar den på en traditionell AEM Sites-sida. För närvarande finns ett begränsat antal komponenter att använda. Mer läggs till under kursen.

## Inspect för Single Page

Verifiera sedan att det här är ett Single Page-program med hjälp av webbläsarens utvecklarverktyg.

1. I **Page Editor** klickar du på **Sidinformation** knapp > **Visa som publicerad**:

   ![Knappen Visa som publicerad](./assets/create-project/view-as-published.png)

   Då öppnas en ny flik med frågeparametern `?wcmmode=disabled` som i praktiken stänger av AEM redigerare: [http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled](http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled)

2. Visa sidans källa och lägg märke till att textinnehållet **[!DNL Hello World]** eller något annat innehåll inte hittas. Du ska i stället se HTML så här:

   ```html
   ...
   <body>
       <noscript>You need to enable JavaScript to run this app.</noscript>
       <div id="spa-root"></div>
       <script type="text/javascript" src="/etc.clientlibs/wknd-spa-react/clientlibs/clientlib-react.lc-xxxx-lc.min.js"></script>
   </body>
   ...
   ```

   `clientlib-react.min.js` är SPA som läses in på sidan och som ansvarar för återgivningen av innehållet.

   Men *varifrån kommer innehållet?*

3. Återgå till fliken: [http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled](http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled)
4. Öppna utvecklarverktygen i webbläsaren och inspektera nätverkstrafiken på sidan under en uppdatering. Visa **XHR** begäranden:

   ![XHR-begäranden](./assets/create-project/xhr-requests.png)

   Det bör finnas en begäran om att [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Detta innehåller allt innehåll, formaterat i JSON, som SPA.

5. Öppna en ny flik [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json)

   Begäran `en.model.json` representerar innehållsmodellen som ska köra programmet. Inspect JSON-utdata och du bör kunna hitta kodavsnittet som representerar **[!UICONTROL Text]** komponenter.

   ```json
   ...
   ":items": {
       "text": {
           "text": "<p>Hello World! Updated content!</p>\r\n",
           "richText": true,
           ":type": "wknd-spa-react/components/text"
       },
       "text_98796435": {
           "text": "<p>A new text component.</p>\r\n",
           "richText": true,
           ":type": "wknd-spa-react/components/text"
       },
   }
   ...
   ```

   I nästa kapitel kommer vi att undersöka hur detta JSON-innehåll mappas från AEM komponenter till SPA komponenter för att utgöra grunden för den AEM SPA redigerarupplevelsen.

   >[!NOTE]
   >
   > Det kan vara praktiskt att installera ett webbläsartillägg som automatiskt formaterar JSON-utdata.

## Grattis! {#congratulations}

Grattis, du har precis skapat ditt första AEM SPA Editor Project!

SPA är ganska enkel. I de följande kapitlen läggs fler funktioner till.

### Nästa steg {#next-steps}

[Integrera en SPA](integrate-spa.md) - Lär dig hur SPA källkod är integrerad med det AEM projektet och förstå vilka verktyg som finns för att snabbt utveckla SPA.
