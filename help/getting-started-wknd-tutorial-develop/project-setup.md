---
title: Komma igång med AEM Sites - projektinställningar
seo-title: Komma igång med AEM Sites - projektinställningar
description: Omfattar skapandet av ett Maven Multi Module-projekt för att hantera koden och konfigurationerna för en AEM.
sub-product: platser
feature: AEM Project Archetype
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
mini-toc-levels: 1
kt: 3418
thumbnail: 30152.jpg
topic: Innehållshantering, utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '1895'
ht-degree: 1%

---


# Projektinställningar {#project-setup}

I den här självstudiekursen beskrivs hur du skapar ett Maven Multi Module Module-projekt för att hantera kod och konfigurationer för en Adobe Experience Manager-webbplats.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment). Se till att du har en ny instans av Adobe Experience Manager tillgänglig lokalt och att inga fler exempel-/demopaket har installerats (förutom obligatoriska Service Pack).

## Mål {#objective}

1. Lär dig hur du skapar ett nytt AEM med en Maven-arkityp.
1. Förstå de olika moduler som genereras av den AEM projekttypen och hur de fungerar tillsammans.
1. Förstå hur AEM kärnkomponenter inkluderas i ett AEM projekt.

## Vad du ska bygga {#what-build}

>[!VIDEO](https://video.tv.adobe.com/v/30152/?quality=12&learn=on)

I det här kapitlet genererar du ett nytt Adobe Experience Manager-projekt med [AEM Project Archetype](https://github.com/adobe/aem-project-archetype). Ditt AEM innehåller all kod, allt innehåll och alla konfigurationer som används för en webbplatsimplementering. Det projekt som skapas i detta kapitel kommer att fungera som grund för en implementering av WKND-webbplatsen och kommer att byggas vidare i framtida kapitel.

**Vad är ett Maven-projekt?** -  [Apache ](https://maven.apache.org/) Mavenis är ett programhanteringsverktyg för att skapa projekt. *Alla implementeringar av Adobe Experience* Manager använder Maven-projekt för att skapa, hantera och driftsätta anpassad kod utöver AEM.

**Vad är en Maven-arketype?** - En  [Maven-](https://maven.apache.org/archetype/index.html) arketypeär en mall eller ett mönster för att generera nya projekt. Med den AEM projekttypen kan vi generera ett nytt projekt med ett anpassat namnutrymme och inkludera en projektstruktur som följer bästa praxis, vilket avsevärt snabbar upp vårt projekt.

## Skapa projektet {#create}

Det finns ett par sätt att skapa ett flermodulsprojekt i Maven för AEM. Den här självstudiekursen använder [Maven AEM Project Archetype **25**](https://github.com/adobe/aem-project-archetype). I Cloud Manager finns också en gränssnittsguide [som initierar skapandet av ett AEM programprojekt. ](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/getting-started/create-an-application-project.html) Det underliggande projektet som skapas av användargränssnittet i Cloud Manager resulterar i samma struktur som när du använder typen av arkiv direkt.

>[!NOTE]
>
>I den här självstudiekursen används version **25** av arketypen. Det är alltid en god vana att använda den **senaste** versionen av arkitypen för att generera ett nytt projekt.

Nästa serie steg kommer att utföras med en UNIX-baserad kommandoradsterminal, men de bör vara lika om en Windows-terminal används.

1. Öppna en kommandoradsterminal. Kontrollera att Maven är installerad:

   ```shell
   $ mvn --version
   Apache Maven 3.6.2
   Maven home: /Library/apache-maven-3.6.2
   Java version: 11.0.4, vendor: Oracle Corporation, runtime: /Library/Java/JavaVirtualMachines/jdk-11.0.4.jdk/Contents/Home
   ```

1. Kontrollera att profilen **adobe-public** är aktiv genom att köra följande kommando:

   ```shell
   $ mvn help:effective-settings
       ...
   <activeProfiles>
       <activeProfile>adobe-public</activeProfile>
   </activeProfiles>
   <pluginGroups>
       <pluginGroup>org.apache.maven.plugins</pluginGroup>
       <pluginGroup>org.codehaus.mojo</pluginGroup>
   </pluginGroups>
   </settings>
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  0.856 s
   ```

   Om du **inte** ser **adobe-public** är det en indikation på att Adobe repo inte refereras korrekt i din `~/.m2/settings.xml`-fil. Gå igenom stegen för att installera och konfigurera Apache Maven i [en lokal utvecklingsmiljö](https://docs.adobe.com/content/help/en/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html#install-apache-maven).

1. Navigera till en katalog där du vill generera det AEM projektet. Detta kan vara vilken katalog som helst där du vill underhålla projektets källkod. En katalog med namnet `code` under användarens arbetskatalog:

   ```shell
   $ cd ~/code
   ```

1. Klistra in följande på kommandoraden för att [generera projektet i batchläge](https://maven.apache.org/archetype/maven-archetype-plugin/examples/generate-batch.html):

   ```shell
   mvn -B archetype:generate \
       -D archetypeGroupId=com.adobe.aem \
       -D archetypeArtifactId=aem-project-archetype \
       -D archetypeVersion=25 \
       -D appTitle="WKND Sites Project" \
       -D appId="wknd" \
       -D groupId="com.adobe.aem.guides.wknd" \
       -D artifactId="aem-guides-wknd" \
       -D version="0.0.1-SNAPSHOT" \
       -D aemVersion="cloud"
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5.5.0+ eller 6.4.8.1+ ersätter du `aemVersion="cloud"` med målversionen av AEM, d.v.s. `aemVersion="6.5.5"` eller `aemVersion="6.4.8.1"`

   En fullständig lista över tillgängliga egenskaper för konfigurering av ett projekt [finns här](https://github.com/adobe/aem-project-archetype#available-properties).

1. Följande mapp- och filstruktur genereras av Maven-arkivtypen i det lokala filsystemet:

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
           |--- analyse/
           |--- pom.xml
           |--- README.md
           |--- .gitignore
   ```

## Distribuera och bygg projektet {#build}

Skapa och distribuera projektkoden till en lokal instans av AEM.

1. Kontrollera att du har en författarinstans av AEM som körs lokalt på port **4502**.
1. Gå till projektkatalogen `aem-guides-wknd` från kommandoraden.

   ```shell
   $ cd aem-guides-wknd
   ```

1. Kör följande kommando för att skapa och distribuera hela projektet till AEM:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Byggnaden tar ca en minut och avslutas med följande meddelande:

   ```
   ...
   [INFO] ------------------------------------------------------------------------
   [INFO] Reactor Summary for aem-guides-wknd 0.0.1-SNAPSHOT:
   [INFO]
   [INFO] aem-guides-wknd .................................... SUCCESS [  0.269 s]
   [INFO] WKND Sites Project - Core .......................... SUCCESS [  8.047 s]
   [INFO] WKND Sites Project - UI Frontend ................... SUCCESS [01:02 min]
   [INFO] WKND Sites Project - Repository Structure Package .. SUCCESS [  1.985 s]
   [INFO] WKND Sites Project - UI apps ....................... SUCCESS [  8.037 s]
   [INFO] WKND Sites Project - UI content .................... SUCCESS [  4.672 s]
   [INFO] WKND Sites Project - UI config ..................... SUCCESS [  0.313 s]
   [INFO] WKND Sites Project - All ........................... SUCCESS [  0.270 s]
   [INFO] WKND Sites Project - Integration Tests ............. SUCCESS [ 15.571 s]
   [INFO] WKND Sites Project - Dispatcher .................... SUCCESS [  0.232 s]
   [INFO] WKND Sites Project - UI Tests ...................... SUCCESS [  0.728 s]
   [INFO] WKND Sites Project - Project Analyser .............. SUCCESS [ 33.398 s]
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  02:18 min
   [INFO] Finished at: 2021-01-31T12:33:56-08:00
   [INFO] ------------------------------------------------------------------------
   ```

   Maven-profilen `autoInstallSinglePackage` kompilerar de enskilda modulerna i projektet och distribuerar ett paket till AEM. Som standard distribueras det här paketet till en AEM som körs lokalt på port **4502** och med autentiseringsuppgifterna `admin:admin`.

1. Navigera till Package Manager på den lokala AEM instansen: [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp). Du bör se paket för `aem-guides-wknd.ui.apps`, `aem-guides-wknd.ui.config`, `aem-guides-wknd.ui.content` och `aem-guides-wknd.all`.

1. Gå till webbplatskonsolen: [http://localhost:4502/sites.html/content](http://localhost:4502/sites.html/content). WKND-platsen blir en av platserna. Den kommer att innehålla en webbplatsstruktur med hierarkin USA och Språkmallsidor. Den här platshierarkin baseras på värdena för `language_country` och `isSingleCountryWebsite` när projektet genereras med hjälp av arkivtypen.

1. Öppna sidan **US** `>` **English** genom att markera sidan och klicka på knappen **Redigera** i menyraden:

   ![webbplatskonsol](assets/project-setup/aem-sites-console.png)

1. Startinnehåll har redan skapats och flera komponenter är tillgängliga för att läggas till på en sida. Experimentera med de här komponenterna för att få en uppfattning om funktionaliteten. Du får lära dig grunderna för en komponent i nästa kapitel.

   ![Startinnehåll för startsida](assets/project-setup/start-home-page.png)

   *Exempelinnehåll som genererats av Arketypen*

## Inspect projektet {#project-structure}

Det genererade AEM består av enskilda Maven-moduler, var och en med olika roller. Den här självstudiekursen och en majoritet av utvecklingsfokus ligger på följande moduler:

* [core](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/core.html)  - Java Code, främst serverutvecklare.
* [ui.front](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/uifrontend.html)  - Innehåller källkod för CSS, JavaScript, Sass och Type Script, främst för frontutvecklare.
* [ui.apps](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/uiapps.html)  - Innehåller komponent- och dialogdefinitioner, bäddar in kompilerad CSS och JavaScript som klientbibliotek.
* [ui.content](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/uicontent.html) - innehåller strukturellt innehåll och konfigurationer som redigerbara mallar, metadatamappningar (/content, /conf).

* **all** - det här är en tom Maven-modul som kombinerar ovanstående moduler till ett enda paket som kan distribueras till en AEM miljö.

![Maven Project Diagram](assets/project-setup/project-pom-structure.png)

Mer information om **alla** Maven-modulerna finns i [AEM Project Archetype-dokumentationen](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/overview.html).

### Inkludering av kärnkomponenter {#core-components}

[AEM ](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html) är en uppsättning standardiserade WCM-komponenter (Web Content Management) för AEM. De här komponenterna utgör en basuppsättning med funktioner och är utformade för att formateras, anpassas och utökas för enskilda projekt.

AEM som Cloud Service innehåller den senaste versionen av [AEM Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html). Därför innehåller projekt som genererats för AEM som en Cloud Service **inte** en inbäddning av AEM kärnkomponenter.

För AEM 6.5/6.4-genererade projekt bäddar arkitypen automatiskt in [AEM Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html) i projektet. Det är en god vana för AEM 6.5/6.4 att bädda in AEM Core Components för att säkerställa att den senaste versionen distribueras med ditt projekt. Mer information om hur kärnkomponenter [ingår i projektet finns här](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/using.html#core-components).

## Hantering av källkontroll {#source-control}

Det är alltid en bra idé att använda någon form av källkontroll för att hantera koden i programmet. I den här självstudien används git och GitHub. Det finns flera filer som genereras av Maven och/eller valfri IDE som ska ignoreras av SCM.

Maven skapar en målmapp när du skapar och installerar kodpaketet. Målmappen och innehållet ska uteslutas från SCM.

Under `ui.apps` observerar du att många `.content.xml`-filer skapas. Dessa XML-filer mappar nodtyperna och egenskaperna för innehåll som är installerat i JCR-läsaren. Dessa filer är viktiga och ska **inte** ignoreras.

Den AEM projekttypen genererar en `.gitignore`-exempelfil som kan användas som startpunkt för vilken filer kan ignoreras. Filen genereras på `<src>/aem-guides-wknd/.gitignore`.

## Grattis! {#congratulations}

Grattis, du har just skapat ditt första AEM projekt!

### Nästa steg {#next-steps}

Förstå den underliggande tekniken i en Adobe Experience Manager (AEM) Sites Component genom ett enkelt `HelloWorld`-exempel med självstudiekursen [Component Basics](component-basics.md).

## Avancerade Maven-kommandon (Bonus) {#advanced-maven-commands}

Under utvecklingen kanske du bara arbetar med en av modulerna och vill undvika att bygga upp hela projektet för att spara tid. Du kanske också vill distribuera direkt till en AEM Publish-instans eller kanske till en instans av AEM som inte körs på port 4502.

Därefter ska vi titta på några av de Maven-profiler och kommandon du kan använda för större flexibilitet under utvecklingen.

### Kärnmodul {#core-module}

Modulen **[core](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/core.html)** innehåller all Java-kod som är associerad med projektet. När den byggts distribueras ett OSGi-paket till AEM. Så här skapar du bara den här modulen:

1. Navigera till mappen `core` (under `aem-guides-wknd`):

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

1. Växla sorteringskolumnen **Id** så ser du WKND-paketet som är installerat och aktivt.

   ![Kärnpaket](assets/project-setup/wknd-osgi-console.png)

1. Du kan se var behållaren befinner sig i [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/apps/wknd-packages/application/install/aem-guides-wknd.core-1.0.0-SNAPSHOT.jar):

   ![CRXDE-plats för JAR](assets/project-setup/jcr-bundle-location.png)

### Ui.apps och Ui.content-modulerna {#apps-content-module}

Mappmodulen **[ui.apps](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/uiapps.html)** innehåller all återgivningskod som behövs för webbplatsen under `/apps`. Detta inkluderar CSS/JS som kommer att lagras i ett AEM som heter [clientlibs](https://docs.adobe.com/content/help/en/experience-manager-cloud-service/implementing/developing/clientlibs.html). Detta inkluderar även [HTML](https://docs.adobe.com/content/help/en/experience-manager-htl/using/overview.html)-skript för återgivning av dynamisk HTML. Du kan tänka dig modulen **ui.apps** som en karta till strukturen i JCR-läsaren, men i ett format som kan lagras i ett filsystem och implementeras för källkontroll. Modulen **ui.apps** innehåller bara kod.

Så här skapar du bara den här modulen:

1. Från kommandoraden. Navigera till mappen `ui.apps` (under `aem-guides-wknd`):

   ```shell
   $ cd ../ui.apps
   ```

1. Kör följande kommando:

   ```shell
   $ mvn clean install -PautoInstallPackage
   ...
   Package installed in 122ms.
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  6.972 s
   [INFO] Finished at: 2019-12-06T14:44:12-08:00
   [INFO] ------------------------------------------------------------------------
   ```

1. Navigera till [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp). Du bör se `ui.apps`-paketet som det första installerade paketet och det bör ha en senare tidsstämpel än något av de andra paketen.

   ![Ui.apps-paketet är installerat](assets/project-setup/ui-apps-package.png)

1. Återgå till kommandoraden och kör följande kommando (i mappen `ui.apps`):

   ```shell
   $ mvn -PautoInstallPackagePublish clean install
   ...
   [INFO] --- content-package-maven-plugin:1.0.2:install (install-package-publish) @ aem-guides-wknd.ui.apps ---
   [INFO] Installing aem-guides-wknd.ui.apps (/Users/dgordon/code/aem-guides-wknd/ui.apps/target/aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip) to http://localhost:4503/crx/packmgr/service.jsp
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] I/O exception (java.net.ConnectException) caught when processing request: Connection refused (Connection refused)
   [INFO] Retrying request
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD FAILURE
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  6.717 s
   [INFO] Finished at: 2019-12-06T14:51:45-08:00
   [INFO] ------------------------------------------------------------------------
   ```

   Profilen `autoInstallPackagePublish` är avsedd att distribuera paketet till en publiceringsmiljö som körs på port **4503**. Ovanstående fel förväntas om det inte går att hitta en AEM som körs på http://localhost:4503.

1. Kör slutligen följande kommando för att distribuera `ui.apps`-paketet på port **4504**:

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

   Återigen förväntas ett byggfel inträffa om det inte finns någon AEM som körs på port **4504** tillgänglig. Parametern `aem.port` definieras i POM-filen på `aem-guides-wknd/pom.xml`.

Modulen **[ui.content](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/uicontent.htm)** är strukturerad på samma sätt som modulen **ui.apps**. Den enda skillnaden är att modulen **ui.content** innehåller det som kallas **mutable**-innehåll. **** MutableContent avser i huvudsak icke-kodkonfigurationer som mallar, profiler eller mappstrukturer som lagras i  **** källkontrollsknappar som kan ändras direkt på en AEM. Detta beskrivs mer ingående i kapitlet om sidor och mallar.

Samma Maven-kommandon som används för att skapa modulen **ui.apps** kan användas för att skapa modulen **ui.content**. Upprepa stegen ovan i mappen **ui.content**.