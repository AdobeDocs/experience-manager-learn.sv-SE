---
title: Skapa projekt | Komma igång med AEM SPA Editor och React
description: Lär dig hur du skapar ett Adobe Experience Manager (AEM) Maven-projekt som utgångspunkt för ett React-program som är integrerat med AEM SPA Editor.
feature: SPA Editor, AEM Project Archetype
version: Experience Manager as a Cloud Service
jira: KT-413
thumbnail: 413-spa-react.jpg
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 57c8fc16-fed5-4af4-b98b-5c3f0350b240
duration: 250
hide: true
source-git-commit: 5b008419d0463e4eaa1d19c9fe86de94cba5cb9a
workflow-type: tm+mt
source-wordcount: '974'
ht-degree: 0%

---

# Skapa projekt {#spa-editor-project}

{{spa-editor-deprecation}}

Lär dig hur du skapar ett Adobe Experience Manager (AEM) Maven-projekt som utgångspunkt för ett React-program som är integrerat med AEM SPA Editor.

## Syfte

1. Skapa ett SPA Editor-aktiverat projekt med AEM Project Archetype.
2. Distribuera startprojektet till en lokal instans av AEM.

## Vad du ska bygga {#what-build}

I det här kapitlet skapas ett nytt AEM-projekt baserat på [AEM Project Archetype](https://github.com/adobe/aem-project-archetype). AEM-projektet har en mycket enkel startpunkt för React SPA.

**Vad är ett Maven-projekt?** - [Apache Maven](https://maven.apache.org/) är ett programhanteringsverktyg för att skapa projekt. *Alla Adobe Experience Manager*-implementeringar använder Maven-projekt för att skapa, hantera och distribuera anpassad kod ovanpå AEM.

**Vad är en Maven-arketype?** - En [Maven-arketyp](https://maven.apache.org/archetype/index.html) är en mall eller ett mönster för generering av nya projekt. Med AEM Project Archetype kan vi generera ett nytt projekt med ett anpassat namnutrymme och inkludera en projektstruktur som följer bästa praxis, vilket avsevärt snabbar upp vårt projekt.

## Förutsättningar

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Kontrollera att en ny instans av Adobe Experience Manager, som har startats i läget **författare**, körs lokalt.

## Skapa projektet {#create}

>[!NOTE]
>
>I den här självstudien används version **35** av arketypen.

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
   > Ersätt `aemVersion="cloud"` med `aemVersion="6.5.5"` om du har AEM 6.5.5+ som mål. Använd `aemVersion="6.4.8"` om du har 6.4.8+ som mål.

   Observera egenskapen `frontendModule=react`. Detta anger att AEM Project Archetype ska starta projektet med startkoden [React code base](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend-react.html) som ska användas med AEM SPA Editor. Egenskaper som `appTitle`, `appId`, `artifactId` och `groupId` används för att identifiera projektet och syftet.

   En fullständig lista över tillgängliga egenskaper för konfigurering av projektet [finns här](https://github.com/adobe/aem-project-archetype#available-properties).

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

   Varje mapp representerar en enskild Maven-modul. I den här självstudiekursen arbetar vi primärt med modulen `ui.frontend`, som är React-appen. Mer information om enskilda moduler finns i [AEM Project Archetype-dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html).

## Distribuera och skapa projektet

Därefter kompilerar, bygger och distribuerar du projektkoden till en lokal instans av AEM med hjälp av Maven.

1. Kontrollera att en instans av AEM körs lokalt på port **4502**.
1. Gå till projektkatalogen `aem-guides-wknd-spa.react` från kommandoraden.

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

   Maven-profilen `autoInstallSinglePackage` kompilerar de enskilda modulerna i projektet och distribuerar ett paket till AEM-instansen. Som standard distribueras det här paketet till en AEM-instans som körs lokalt på port **4502** och med autentiseringsuppgifterna `admin:admin`.

1. Navigera till **Package Manager** på din lokala AEM-instans: [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp).

1. Du bör se flera paket som har prefixet `aem-guides-wknd-spa.react`.

   ![WKND SPA-paket](assets/create-project/package-manager.png)

   *AEM Package Manager*

   All anpassad kod som krävs för projektet paketeras i dessa paket och installeras i AEM-miljön.

## Författarinnehåll

Öppna sedan den första SPA-filen som genererades av typen och uppdatera en del av innehållet.

1. Gå till konsolen **Platser**: [http://localhost:4502/sites.html/content](http://localhost:4502/sites.html/content).

   WKND SPA innehåller en grundläggande webbplatsstruktur med land, språk och hemsida. Den här hierarkin baseras på arkivtypens standardvärden för `language_country` och `isSingleCountryWebsite`. Dessa värden kan skrivas över genom att uppdatera de [tillgängliga egenskaperna](https://github.com/adobe/aem-project-archetype#available-properties) när du genererar ett projekt.

2. Öppna sidan **us** > **en** > **WKND SPA React Home Page** genom att markera sidan och klicka på knappen **Redigera** i menyraden:

   ![platskonsol](./assets/create-project/open-home-page.png)

3. En **Text**-komponent har redan lagts till på sidan. Du kan redigera den här komponenten precis som andra komponenter i AEM.

   ![Uppdatera textkomponent](./assets/create-project/update-text-component.gif)

4. Lägg till ytterligare en **Text**-komponent på sidan.

   Observera att redigeringsupplevelsen liknar den på en traditionell AEM Sites-sida. För närvarande finns ett begränsat antal komponenter att använda. Mer läggs till under kursen.

## Inspektera enkelsidigt program

Verifiera sedan att det här är ett Single Page-program med hjälp av webbläsarens utvecklarverktyg.

1. Klicka på knappen **Sidinformation** > **Visa som publicerad** i **sidredigeraren**:

   ![Knappen Visa som publicerad](./assets/create-project/view-as-published.png)

   Då öppnas en ny flik med frågeparametern `?wcmmode=disabled` som inaktiverar AEM-redigeraren: [http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled](http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled)

2. Visa sidans källa och observera att textinnehållet **[!DNL Hello World]** eller något annat innehåll inte hittas. Du ska i stället se HTML på följande sätt:

   ```html
   ...
   <body>
       <noscript>You need to enable JavaScript to run this app.</noscript>
       <div id="spa-root"></div>
       <script type="text/javascript" src="/etc.clientlibs/wknd-spa-react/clientlibs/clientlib-react.lc-xxxx-lc.min.js"></script>
   </body>
   ...
   ```

   `clientlib-react.min.js` är den SPA för Reaktion som läses in på sidan och som ansvarar för återgivningen av innehållet.

   *Varifrån kommer innehållet?*

3. Återgå till fliken: [http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled](http://localhost:4502/content/wknd-spa-react/us/en/home.html?wcmmode=disabled)
4. Öppna utvecklarverktygen i webbläsaren och inspektera nätverkstrafiken på sidan under en uppdatering. Visa **XHR**-begäranden:

   ![XHR-förfrågningar](./assets/create-project/xhr-requests.png)

   Det bör finnas en begäran till [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json). Detta innehåller allt innehåll, formaterat i JSON, som kommer att driva SPA.

5. Öppna [http://localhost:4502/content/wknd-spa-react/us/en.model.json](http://localhost:4502/content/wknd-spa-react/us/en.model.json) på en ny flik

   Begäran `en.model.json` representerar innehållsmodellen som kör programmet. Kontrollera JSON-utdata och du bör kunna hitta fragmentet som representerar **[!UICONTROL Text]**-komponenten.

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

   I nästa kapitel kommer vi att undersöka hur detta JSON-innehåll mappas från AEM Components till SPA Components för att utgöra grunden för AEM SPA Editor.

   >[!NOTE]
   >
   > Det kan vara praktiskt att installera ett webbläsartillägg som automatiskt formaterar JSON-utdata.

## Grattis! {#congratulations}

Grattis! Du har skapat ditt första AEM SPA Editor-projekt!

SÄRSKILDA ANVÄNDNINGSAKTIVITETER är ganska enkla. I de följande kapitlen läggs fler funktioner till.

### Nästa steg {#next-steps}

[Integrera en SPA](integrate-spa.md) - Lär dig hur SPA-källkoden integreras med AEM Project och förstå verktyg som finns för att snabbt utveckla SPA.
