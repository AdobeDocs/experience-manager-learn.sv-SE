---
title: Konfigurera utvecklingsverktygen för AEM som en Cloud Service
description: Konfigurera en lokal utvecklingsmaskin med alla grundläggande verktyg som behövs för att utveckla mot AEM lokalt.
feature: Utvecklarverktyg
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 4267
thumbnail: 25907.jpg
topic: Utveckling
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: 9a78cbdb5fd35e4aa7169382494dd014aa8098e9
workflow-type: tm+mt
source-wordcount: '1426'
ht-degree: 0%

---


# Konfigurera utvecklingsverktyg

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_devtools"
>title="Installationsutvecklingsverktyg"
>abstract="Utvecklingsverktyg för Adobe Experience Manager (AEM) kräver en minimalistisk uppsättning utvecklingsverktyg som ska installeras och konfigureras på utvecklingsdatorn. Bland dessa verktyg finns Java, Maven, Adobe I/O CLI, Development IDE med flera."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/development-guidelines.html" text="Utvecklingsriktlinjer"
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/basics/aem-sdk.html" text="Grundläggande om utveckling"

Utvecklingsverktyg för Adobe Experience Manager (AEM) kräver en minimalistisk uppsättning utvecklingsverktyg som ska installeras och konfigureras på utvecklingsdatorn. Dessa verktyg har stöd för utveckling och byggande av AEM projekt.

Observera att `~` används som kortskrift för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`.

## Installera Java

Experience Manager är ett Java-program och kräver därför Java SDK för att stödja utveckling och AEM som en Cloud Service SDK.

1. [Hämta och installera den senaste versionen av Java 11 SDK](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
1. Kontrollera att Java 11 SDK är installerat genom att köra kommandot:
   + Windows: `java -version`
   + macOS / Linux: `java --version`

![Java](./assets/development-tools/java.png)

## Installera homebrew

_Användning av Homebrew är valfri, men rekommenderas._

Homebrew är en pakethanterare med öppen källkod för macOS, Windows och Linux. Alla stödverktyg kan installeras separat. Homebrew är ett bekvämt sätt att installera och uppdatera en mängd olika utvecklingsverktyg som krävs för utveckling av Experience Manager.

1. Öppna terminalen
1. Kontrollera om Homebrew redan är installerat genom att köra kommandot: `brew --version`.
1. Installera Homebrew om det inte finns installerat
   + [Installera homebrew på macOS](https://brew.sh/)
      + Homebrew i macOS kräver [Xcode](https://apps.apple.com/us/app/xcode/id497799835) eller [Command Line Tools](https://developer.apple.com/download/more/), kan installeras via kommandot:
         + `xcode-select --install`
   + [Installera Homebrew i Linux](https://docs.brew.sh/Installation#linux-or-windows-10-subsystem-for-linux)
   + [Installera homebrew i Windows 10](https://docs.brew.sh/Installation#linux-or-windows-10-subsystem-for-linux)
1. Kontrollera att Homebrew är installerat genom att köra kommandot: `brew --version`

![Homebreiska](./assets/development-tools/homebrew.png)

Om du använder Homebrew följer du instruktionerna i avsnitten nedan för __Installera med Homebrew__. Om du __inte__ använder Homebrew installerar du verktygen med operativsystemspecifika länkar.

## Installera Git

[Det ](https://git-scm.com/) här är det system för källkontroll som används av  [Adobe Cloud Manager](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/requirements/source-code-repository.html), och därför krävs för utveckling.

+ Installera Git med Homebrew
   1. Öppna terminalen/kommandotolken
   1. Kör kommandot: `brew install git`
   1. Kontrollera att Git är installerat med kommandot: `git --version`
+ Eller ladda ned och installera Git (macOS, Linux eller Windows)
   1. [Hämta och installera Git](https://git-scm.com/downloads)
   1. Öppna terminalen/kommandotolken
   1. Kontrollera att Git är installerat med kommandot: `git --version`

![Git](./assets/development-tools/git.png)

## Installera Node.js (och npm){#node-js}

[Node.](https://nodejs.org) jis a JavaScript runtime environment used to work with the front-end assets of an AEM project’s  __ui.__ front-sub-project. Node.js distribueras med [npm](https://www.npmjs.com/), är den defacto-pakethanterare för Node.js som används för att hantera JavaScript-beroenden.

+ Installera Node.js med Homebrew
   1. Öppna terminalen/kommandotolken
   1. Kör kommandot: `brew install node`
   1. Kontrollera att Node.js är installerat med kommandot: `node -v`
   1. Kontrollera att npm är installerat med kommandot: `npm -v`
+ Eller ladda ned och installera Node.js (macOS, Linux eller Windows)
   1. [Hämta och installera Node.js](https://nodejs.org/en/download/)
   1. Öppna terminalen/kommandotolken
   1. Kontrollera att Node.js är installerat med kommandot: `node -v`
   1. Kontrollera att npm är installerat med kommandot: `npm -v`

![Node.js och npm](./assets/development-tools/nodejs-and-npm.png)

>[!TIP]
>
>[AEM Project Archetype](https://github.com/adobe/aem-project-archetype)-baserade AEM Projects installerar en isolerad version av Node.js vid byggtillfället. Det är bra att ha det lokala utvecklingssystemets version synkroniserad (eller nära) med de Node.js- och npm-versioner som anges i ditt AEM Maven-projekts Reactor pom.xml.
>
>I det här exemplet [AEM Project Reactor pom.xml](https://github.com/adobe/aem-guides-wknd/blob/9ac94f3f40c978a53ec88fae79fbc17dd2db72f2/pom.xml#L117-L118) hittar du var du hittar byggversionerna Node.js och npm.

## Installera Maven

Apache Maven är ett kommandoradsverktyg för Java med öppen källkod som används för att skapa AEM projekt som genereras från AEM Project Maven Archetype. Alla större IDE:er ([IntelliJ IDEA](https://www.jetbrains.com/idea/), [Visual Studio Code](https://code.visualstudio.com/), [Eclipse](https://www.eclipse.org/), osv.) har integrerat stöd för Maven.

+ Installera Maven med Homebrew
   1. Öppna terminalen/kommandotolken
   1. Kör kommandot: `brew install maven`
   1. Kontrollera att Maven är installerad med kommandot: `mvn -v`
+ Eller ladda ned och installera Maven (macOS, Linux eller Windows)
   1. [Ladda ned Maven](https://maven.apache.org/download.cgi)
   1. [Installera Maven](https://maven.apache.org/install.html)
   1. Öppna terminalen/kommandotolken
   1. Kontrollera att Maven är installerad med kommandot: `mvn -v`

![Maven](./assets/development-tools/maven.png)

## Konfigurera Adobe I/O CLI{#aio-cli}

Med [Adobe I/O CLI](https://github.com/adobe/aio-cli), eller `aio`, får du kommandoradsåtkomst till en mängd olika Adobe-tjänster, inklusive [Cloud Manager](https://github.com/adobe/aio-cli-plugin-cloudmanager) och [Asset compute](https://github.com/adobe/aio-cli-plugin-asset-compute). CLI för Adobe I/O spelar en viktig roll när det gäller utveckling av AEM som en Cloud Service eftersom den ger utvecklarna möjlighet att

+ Loggar från AEM som Cloud Services
+ Hantera Cloud Manager-pipelines från CLI

### Installera Adobe I/O CLI

1. Kontrollera att [Node.js är installerat](#node-js) eftersom Adobe I/O CLI är en npm-modul
   + Kör `node --version` för att bekräfta
1. Kör `npm install -g @adobe/aio-cli` om du vill installera npm-modulen globalt`aio`

### Konfigurera plugin-programmet Adobe I/O CLI Cloud Manager{#aio-cloud-manager}

Med plugin-programmet Adobe I/O Cloud Manager kan AIO CLI interagera med Adobe Cloud Manager via kommandot `aio cloudmanager`.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-cloudmanager` för att installera [aio Cloud Manager-plugin](https://github.com/adobe/aio-cli-plugin-cloudmanager).

### Konfigurera plugin-programmet Adobe I/O CLI Asset compute{#aio-asset-compute}

Med plugin-programmet Adobe I/O Cloud Manager kan AIO CLI generera och köra Asset compute-arbetare via kommandot `aio asset-compute`.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-asset-compute` för att installera [aio Asset compute plug-in](https://github.com/adobe/aio-cli-plugin-asset-compute).

### Ställa in Adobe I/O CLI-autentisering

För att Adobe I/O CLI ska kunna kommunicera med Cloud Manager måste en integrering med Cloud Manager skapas i Adobe I/O Console, och autentiseringsuppgifter måste hämtas för att autentiseringen ska lyckas.

>[!VIDEO](https://video.tv.adobe.com/v/35094?quality=12&learn=on)

1. Logga in på [console.adobe.io](https://console.adobe.io)
1. Se till att din organisation som innehåller den Cloud Manager-produkt som du vill ansluta till är aktiv i Adobe Org-växlaren
1. Skapa ett nytt eller öppna ett befintligt [Adobe I/O-program](https://www.adobe.io/apis/experienceplatform/console/docs.html#!AdobeDocs/adobeio-console/master/projects.md)
   + Adobe I/O Console-program är helt enkelt grupperingar av integreringar, skapar eller använder befintliga program baserat på hur du vill hantera dina integreringar
   + Om du skapar ett nytt projekt väljer du Tomt projekt om du uppmanas till det (till skillnad från Skapa från mall)
   + Adobe I/O Console-program är olika koncept för Cloud Manager-program
1. Skapa en ny API-integrering för Cloud Manager med profilen &quot;Developer - Cloud Service&quot;
1. Hämta JWT-autentiseringsuppgifterna (Service Account) måste fylla i Adobe I/O CLI:s [config.json](https://github.com/adobe/aio-cli-plugin-cloudmanager#authentication)
1. Läs in `config.json`-filen i Adobe I/O CLI
   + `$ aio config:set jwt-auth PATH_TO_CONFIG_JSON_FILE --file --json`
1. Läs in `private.key`-filen i Adobe I/O CLI
   + `$ aio config:set jwt-auth.jwt_private_key PATH_TO_PRIVATE_KEY_FILE --file`

Börja [köra kommandon](https://github.com/adobe/aio-cli-plugin-cloudmanager#commands) för Cloud Manager via Adobe I/O CLI.

## Konfigurera utvecklingsmiljön

AEM består främst av utveckling av Java och Front-end (JavaScript, CSS osv.) samt XML-hantering. Nedan följer de vanligaste utvecklingsmiljöerna för AEM.

### IntelliJ IDEA

__[IntelliJ ](https://www.jetbrains.com/idea/)__ IDEA är en kraftfull utvecklingsmiljö för Java-utveckling. IntelliJ IDEA finns i två versioner: en kostnadsfri utgåva av gemenskapen och en kommersiell (betald) version av Ultimate. Den kostnadsfria communityversionen räcker AEM utvecklingen, men Ultimate [utökar sin funktionsuppsättning](https://www.jetbrains.com/idea/download).

>[!VIDEO](https://video.tv.adobe.com/v/26089/?quality=12&learn=on)

+ [Ladda ned IntelliJ IDEA](https://www.jetbrains.com/idea/download)
+ [Ladda ned Repo-verktyget](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#installation)

### Microsoft Visual Studio Code

__[Visual Studio Code](https://code.visualstudio.com/)__  (VS Code) är ett kostnadsfritt verktyg med öppen källkod för gränssnittsutvecklare. Visual Studio Code kan konfigureras för att integrera innehållssynkronisering med AEM med hjälp av ett Adobe-verktyg, __[repo](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#integration-into-visual-studio-code)__.

Visual Studio Code är det idealiska alternativet för gränssnittsutvecklare som i första hand vill skapa kod i gränssnittet. JavaScript, CSS och HTML. VS-koden har Java-stöd via [tillägg](https://code.visualstudio.com/docs/java/java-tutorial), men saknar kanske vissa avancerade funktioner som finns i mer Java-specifika.

>[!VIDEO](https://video.tv.adobe.com/v/25907?quality=12&learn=on)

+ [Ladda ned Visual Studio Code](https://code.visualstudio.com/Download)
+ [Ladda ned Repo-verktyget](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#integration-into-visual-studio-code)
+ [Hämta namngivet VS-kodtillägg](https://aemfed.io/)
+ [Hämta AEM Synkronisera VS-kodtillägg](https://marketplace.visualstudio.com/items?itemName=Yinkai15.aemsync)

### Eclipse

__[Eclipse ](https://www.eclipse.org/ide/)__ IDE är en populär IDE för Java-utveckling och har stöd för   __[AEM Developer ](https://eclipse.adobe.com/aem/dev-tools/)__ Toolsplug-in från Adobe, som tillhandahåller ett in-IDE-gränssnitt för redigering och synkronisering av JCR-innehåll med en lokal AEM.

>[!VIDEO](https://video.tv.adobe.com/v/25906?quality=12&learn=on)

+ [Hämta Eclipse](https://www.eclipse.org/ide/)
+ [Hämta Eclipse Dev Tools](https://eclipse.adobe.com/aem/dev-tools/)
