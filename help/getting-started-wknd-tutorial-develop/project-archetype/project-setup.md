---
title: Kom igång med AEM Sites - projektinställningar
description: Skapa ett Maven Multi Module-projekt för att hantera koden och konfigurationerna för en Experience Manager-webbplats.
version: 6.5, Cloud Service
feature: AEM Project Archetype
topic: Content Management, Development
role: Developer
level: Beginner
mini-toc-levels: 1
jira: KT-3418
thumbnail: 30152.jpg
doc-type: Tutorial
exl-id: bb0cae58-79bd-427f-9116-d46afabdca59
recommendations: noDisplay, noCatalog
duration: 502
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1684'
ht-degree: 0%

---

# Projektinställningar {#project-setup}

I den här självstudiekursen beskrivs hur du skapar ett Maven Multi Module-modulprojekt för att hantera kod och konfigurationer för en Adobe Experience Manager-webbplats.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](./overview.md#local-dev-environment). Se till att du har en ny instans av Adobe Experience Manager tillgänglig lokalt och att inga fler exempel-/demopaket har installerats (förutom obligatoriska Service Pack).

## Syfte {#objective}

1. Lär dig hur du skapar ett nytt AEM med en Maven-arkityp.
1. Förstå de olika moduler som genereras av den AEM projekttypen och hur de fungerar tillsammans.
1. Förstå hur AEM kärnkomponenter inkluderas i ett AEM projekt.

## Vad du ska bygga {#what-build}

>[!VIDEO](https://video.tv.adobe.com/v/30152?quality=12&learn=on)

I det här kapitlet skapar du ett nytt Adobe Experience Manager-projekt med [AEM Project Archettype](https://github.com/adobe/aem-project-archetype). Ditt AEM innehåller fullständig kod, fullständigt innehåll och konfigurationer som används för en webbplatsimplementering. Det projekt som genereras i detta kapitel utgör grunden för en implementering av WKND-webbplatsen och är byggt på i framtida kapitel.

**Vad är ett Maven-projekt?** - [Apache Maven](https://maven.apache.org/) är ett programhanteringsverktyg för att skapa projekt. *Alla Adobe Experience Manager* implementeringar använder Maven-projekt för att skapa, hantera och distribuera anpassad kod utöver AEM.

**Vad är en Maven-arketype?** - A [Maven Archetype](https://maven.apache.org/archetype/index.html) är en mall eller ett mönster för generering av nya projekt. Den AEM projekttypen hjälper till att generera ett nytt projekt med ett anpassat namnutrymme och innehåller en projektstruktur som följer bästa praxis, vilket avsevärt snabbar upp projektutvecklingen.

## Skapa projektet {#create}

Det finns ett par sätt att skapa ett flermodulsprojekt i Maven för AEM. I den här självstudiekursen används [Maven AEM Project Archetype **35**](https://github.com/adobe/aem-project-archetype). Cloud Manager ingår också [innehåller en gränssnittsguide](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/getting-started/project-creation/using-the-wizard.html) för att initiera skapandet av ett AEM. Det underliggande projektet som skapas av användargränssnittet i Cloud Manager resulterar i samma struktur som när du använder typen av arkiv direkt.

>[!NOTE]
>
>Den här självstudiekursen använder version **35** av arkitypen. Det är alltid en god vana att använda **senaste** version av arkitypen för att generera ett nytt projekt.

Nästa serie steg kommer att utföras med en UNIX®-baserad kommandoradsterminal, men de bör vara lika om en Windows-terminal används.

1. Öppna en kommandoradsterminal. Kontrollera att Maven är installerad:

   ```shell
   $ mvn --version
   Apache Maven 3.6.2
   Maven home: /Library/apache-maven-3.6.2
   Java version: 11.0.4, vendor: Oracle Corporation, runtime: /Library/Java/JavaVirtualMachines/jdk-11.0.4.jdk/Contents/Home
   ```

1. Navigera till en katalog där du vill generera AEM. Detta kan vara vilken katalog som helst där du vill underhålla projektets källkod. En katalog med namnet `code` under användarens hemkatalog:

   ```shell
   $ cd ~/code
   ```

1. Klistra in följande i kommandoraden för att [generera projektet i batchläge](https://maven.apache.org/archetype/maven-archetype-plugin/examples/generate-batch.html):

   ```shell
   mvn -B org.apache.maven.plugins:maven-archetype-plugin:3.2.1:generate \
       -D archetypeGroupId=com.adobe.aem \
       -D archetypeArtifactId=aem-project-archetype \
       -D archetypeVersion=39 \
       -D appTitle="WKND Sites Project" \
       -D appId="wknd" \
       -D groupId="com.adobe.aem.guides" \
       -D artifactId="aem-guides-wknd" \
       -D package="com.adobe.aem.guides.wknd" \
       -D version="0.0.1-SNAPSHOT" \
       -D aemVersion="cloud"
   ```

   >[!NOTE]
   >
   > För AEM 6.5.14+ Ersätt `aemVersion="cloud"` med `aemVersion="6.5.14"`.
   >
   > Använd alltid den senaste `archetypeVersion` genom att referera till [AEM Project Archetype > Usage](https://github.com/adobe/aem-project-archetype#usage)

   En fullständig lista över tillgängliga egenskaper för konfiguration av ett projekt [finns här](https://github.com/adobe/aem-project-archetype#available-properties).

1. Följande mapp- och filstruktur genereras av Maven-typen i det lokala filsystemet:

   ```plain
    ~/code/
       |--- aem-guides-wknd/
           |--- all/
           |--- core/
           |--- ui.apps/
           |--- ui.apps.structure/
           |--- ui.config/
           |--- ui.content/
           |--- ui.frontend/
           |--- ui.tests /
           |--- it.tests/
           |--- dispatcher/
           |--- pom.xml
           |--- README.md
           |--- .gitignore
   ```

## Distribuera och skapa projektet {#build}

Skapa och distribuera projektkoden till en lokal instans av AEM.

1. Kontrollera att du har en författarinstans av AEM som körs lokalt på porten **4502**.
1. Gå till kommandoraden `aem-guides-wknd` projektkatalog.

   ```shell
   $ cd aem-guides-wknd
   ```

1. Kör följande kommando för att skapa och distribuera hela projektet till AEM:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Byggnaden tar ca en minut och ska avslutas med följande meddelande:

   ```
   ...
   [INFO] ------------------------------------------------------------------------
   [INFO] Reactor Summary for WKND Sites Project 0.0.1-SNAPSHOT:
   [INFO] 
   [INFO] WKND Sites Project ................................. SUCCESS [  0.113 s]
   [INFO] WKND Sites Project - Core .......................... SUCCESS [  3.136 s]
   [INFO] WKND Sites Project - UI Frontend ................... SUCCESS [  4.461 s]
   [INFO] WKND Sites Project - Repository Structure Package .. SUCCESS [  0.359 s]
   [INFO] WKND Sites Project - UI apps ....................... SUCCESS [  1.732 s]
   [INFO] WKND Sites Project - UI content .................... SUCCESS [  0.956 s]
   [INFO] WKND Sites Project - UI config ..................... SUCCESS [  0.064 s]
   [INFO] WKND Sites Project - All ........................... SUCCESS [  8.229 s]
   [INFO] WKND Sites Project - Integration Tests ............. SUCCESS [  3.329 s]
   [INFO] WKND Sites Project - Dispatcher .................... SUCCESS [  0.027 s]
   [INFO] WKND Sites Project - UI Tests ...................... SUCCESS [  0.032 s]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  23.189 s
   [INFO] Finished at: 2023-01-10T11:12:23-05:00
   [INFO] ------------------------------------------------------------------------    
   ```

   Profilen Maven `autoInstallSinglePackage` kompilerar de enskilda modulerna i projektet och distribuerar ett paket till AEM. Det här paketet distribueras som standard till en AEM som körs lokalt på porten **4502** och med inloggningsuppgifterna för `admin:admin`.

1. Navigera till Package Manager på den lokala AEM instansen: [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp). Paket för `aem-guides-wknd.ui.apps`, `aem-guides-wknd.ui.config`, `aem-guides-wknd.ui.content`och `aem-guides-wknd.all`.

1. Gå till webbplatskonsolen: [http://localhost:4502/sites.html/content](http://localhost:4502/sites.html/content). WKND-platsen är en av platserna. Den innehåller en webbplatsstruktur med hierarkin USA och Språkmallsidor. Den här platshierarkin baseras på värdena för `language_country` och `isSingleCountryWebsite` när du genererar projektet med arkitypen.

1. Öppna **USA** `>` **Engelska** genom att markera sidan och klicka på **Redigera** på menyraden:

   ![webbplatskonsol](assets/project-setup/aem-sites-console.png)

1. Startinnehåll har redan skapats och flera komponenter är tillgängliga för att läggas till på en sida. Experimentera med de här komponenterna för att få en uppfattning om funktionerna. Du får lära dig grunderna för en komponent i nästa kapitel.

   ![Startinnehåll för startsida](assets/project-setup/start-home-page.png)

   *Exempelinnehåll som genererats av Arketypen*

## Inspect projektet {#project-structure}

Det genererade AEM består av enskilda Maven-moduler, var och en med olika roller. Den här självstudiekursen och den mesta utvecklingsinriktningen på dessa moduler:

* [kärna](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/core.html) - Java Code, främst serverutvecklare.
* [ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html) - Innehåller källkod för CSS, JavaScript, Sass och TypeScript, främst för gränssnittsutvecklare.
* [ui.apps](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uiapps.html) - Innehåller komponent- och dialogdefinitioner, bäddar in kompilerad CSS och JavaScript som klientbibliotek.
* [ui.content](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uicontent.html) - innehåller strukturellt innehåll och konfigurationer som redigerbara mallar, metadatamallar (/content, /conf).

* **alla** - det här är en tom Maven-modul som kombinerar ovanstående moduler till ett enda paket som kan distribueras till en AEM miljö.

![Maven Project Diagram](assets/project-setup/project-pom-structure.png)

Se [AEM Project Archetype-dokumentation](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html) om du vill veta mer om **alla** Maven-modulerna.

### Inkludering av kärnkomponenter {#core-components}

[AEM kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html) är en uppsättning standardiserade WCM-komponenter (Web Content Management) för AEM. Dessa komponenter utgör en basuppsättning av en funktion och är formaterade, anpassade och utökade för enskilda projekt.

AEM as a Cloud Service miljö innehåller den senaste versionen av [AEM kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html). Projekt som genererats för AEM as a Cloud Service gör därför **not** innehåller en inbäddning av AEM kärnkomponenter.

För AEM 6.5/6.4-projekt bäddas arrayen in automatiskt [AEM kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html) i projektet. Det är en god vana för AEM 6.5/6.4 att bädda in AEM Core Components för att säkerställa att den senaste versionen distribueras med ditt projekt. Mer information om hur kärnkomponenter är [som ingår i projektet finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/using.html#core-components).

## Hantering av källkontroll {#source-control}

Det är alltid en bra idé att använda någon form av källkontroll för att hantera koden i programmet. I den här självstudien används git och GitHub. Det finns flera filer som genereras av Maven och/eller valfri IDE som ska ignoreras av SCM.

Maven skapar en målmapp när du skapar och installerar kodpaketet. Målmappen och innehållet ska uteslutas från SCM.

Under `ui.apps` modulen observerar många `.content.xml` filer skapas. Dessa XML-filer mappar nodtyperna och egenskaperna för innehåll som är installerat i JCR-läsaren. Dessa filer är viktiga och **inte** ignoreras.

Den AEM projekttypen genererar ett exempel `.gitignore` fil som kan användas som startpunkt för vilken filer kan ignoreras. Filen genereras på `<src>/aem-guides-wknd/.gitignore`.

## Grattis! {#congratulations}

Grattis, du har skapat ditt första AEM projekt!

### Nästa steg {#next-steps}

Förstå den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Components via en enkel `HelloWorld` exempel med [Grundläggande om komponenter](component-basics.md) självstudie.

## Avancerade Maven-kommandon (Bonus) {#advanced-maven-commands}

Under utvecklingen kanske du bara arbetar med en av modulerna och vill undvika att bygga upp hela projektet för att spara tid. Du kanske också vill distribuera direkt till en AEM Publish-instans eller kanske till en instans av AEM som inte körs på port 4502.

Nu ska vi granska några av de Maven-profiler och kommandon du kan använda för större flexibilitet under utvecklingen.

### Kärnmodul {#core-module}

The **[kärna](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/core.html)** -modulen innehåller all Java™-kod som är kopplad till projektet. Bygget av **kärna** -modulen distribuerar ett OSGi-paket till AEM. Så här skapar du bara denna modul:

1. Navigera till `core` mapp (under `aem-guides-wknd`):

   ```shell
   $ cd core/
   ```

1. Kör följande kommando:

   ```shell
   $ mvn clean install -PautoInstallBundle
   ...
   [INFO] --- sling-maven-plugin:2.4.0:install (install-bundle) @ aem-guides-wknd.core ---
   [INFO] Installing Bundle aem-guides-wknd.core(~/code/aem-guides-wknd/core/target/aem-guides-wknd.core-0.0.1-SNAPSHOT.jar) to http://localhost:4502/system/console via WebConsole
   [INFO] Bundle installed
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  8.558 s
   ```

1. Navigera till [http://localhost:4502/system/console/bundles](http://localhost:4502/system/console/bundles). Det här är OSGi-webbkonsolen och innehåller information om alla paket som är installerade på AEM.

1. Växla **ID** sorteringskolumnen så ser du WKND-paketet installerat och aktivt.

   ![Kärnpaket](assets/project-setup/wknd-osgi-console.png)

1. Där ser du var burken finns [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/apps/wknd-packages/application/install/aem-guides-wknd.core-1.0.0-SNAPSHOT.jar):

   ![CRXDE-plats för JAR](assets/project-setup/jcr-bundle-location.png)

### Ui.apps och Ui.content-moduler {#apps-content-module}

The **[ui.apps](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uiapps.html)** maven-modulen innehåller all återgivningskod som behövs för webbplatsen under `/apps`. Detta inkluderar CSS/JS som lagras i ett AEM som kallas [klientlibs](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html). Detta innefattar även [HTL](https://experienceleague.adobe.com/docs/experience-manager-htl/content/overview.html) skript för återgivning av dynamiska HTML. Du kan tänka dig **ui.apps** som en karta till strukturen i JCR men i ett format som kan lagras i ett filsystem och implementeras i källkontrollen. The **ui.apps** -modulen innehåller bara kod.

Så här skapar du bara denna modul:

1. Från kommandoraden. Navigera till `ui.apps` mapp (under `aem-guides-wknd`):

   ```shell
   $ cd ../ui.apps
   ```

1. Kör följande kommando:

   ```shell
   $ mvn clean install -PautoInstallPackage
   ...
   Package installed in 70ms.
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  2.987 s
   [INFO] Finished at: 2023-01-10T11:35:28-05:00
   [INFO] ------------------------------------------------------------------------
   ```

1. Navigera till [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp). Du borde se `ui.apps` paketet som det första installerade paketet och det bör ha en senare tidsstämpel än något av de andra paketen.

   ![Ui.apps-paketet är installerat](assets/project-setup/ui-apps-package.png)

1. Återgå till kommandoraden och kör följande kommando (inom `ui.apps` mapp):

   ```shell
   $ mvn -PautoInstallPackagePublish clean install
   ...
   [INFO] --- content-package-maven-plugin:1.0.2:install (install-package-publish) @ aem-guides-wknd.ui.apps ---
   [INFO] Installing aem-guides-wknd.ui.apps (/Users/sachinmali/Desktop/code/wknd-tutorial/aem-guides-wknd/ui.apps/target/aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip) to http://localhost:4503/crx/packmgr/service.jsp
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD FAILURE
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  2.812 s
   [INFO] Finished at: 2023-01-10T11:37:28-05:00
   [INFO] ------------------------------------------------------------------------
   [ERROR] Failed to execute goal com.day.jcr.vault:content-package-maven-plugin:1.0.2:install (install-package-publish) on project aem-guides-wknd.ui.apps: Connection refused (Connection refused) -> [Help 1]
   ```

   Profilen `autoInstallPackagePublish` är avsedd att distribuera paketet till en publiceringsmiljö som körs på port **4503**. Ovanstående fel förväntas om det inte går att hitta en AEM som körs på http://localhost:4503.

1. Kör slutligen följande kommando för att distribuera `ui.apps` paket på port **4504**:

   ```shell
   $ mvn -PautoInstallPackage clean install -Daem.port=4504
   ...
   [INFO] --- content-package-maven-plugin:1.0.2:install (install-package) @ aem-guides-wknd.ui.apps ---
   [INFO] Installing aem-guides-wknd.ui.apps (/Users/dgordon/code/aem-guides-wknd/ui.apps/target/aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip) to http://localhost:4504/crx/packmgr/service.jsp
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD FAILURE
   [INFO] --------------------------------------------------------------------
   ```

   Återigen förväntas ett byggfel inträffa om ingen AEM körs på porten **4504** är tillgängligt. Parametern `aem.port` definieras i POM-filen på `aem-guides-wknd/pom.xml`.

The **[ui.content](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uicontent.html)** modulen är strukturerad på samma sätt som **ui.apps** -modul. Den enda skillnaden är att **ui.content** module contains what is known as **oföränderlig** innehåll. **Mutable** innehåll avser i huvudsak icke-kodade konfigurationer som mallar, profiler eller mappstrukturer som lagras i källkontrollen **men** kan ändras direkt på en AEM. Detta beskrivs mer ingående i kapitlet om sidor och mallar.

Samma Maven-kommandon som användes för att skapa **ui.apps** kan användas för att skapa **ui.content** -modul. Upprepa stegen ovan inifrån **ui.content** mapp.

## Felsökning

Om det uppstår problem när du skapar ett projekt med hjälp av den AEM projektarkitekturen, se listan över [kända problem](https://github.com/adobe/aem-project-archetype#known-issues) och lista över öppna [problem](https://github.com/adobe/aem-project-archetype/issues).

## Grattis igen! {#congratulations-bonus}

Grattis, för att du gått igenom bonusmaterialet.

### Nästa steg {#next-steps-bonus}

Förstå den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Components via en enkel `HelloWorld` exempel med [Grundläggande om komponenter](component-basics.md) självstudie.
