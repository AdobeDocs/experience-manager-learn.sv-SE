---
title: Konfigurera utvecklingsverktygen för AEM as a Cloud Service utveckling
description: Konfigurera en lokal utvecklingsmaskin med alla grundläggande verktyg som behövs för att utveckla mot AEM lokalt.
feature: Developer Tools
version: Cloud Service
jira: KT-4267
thumbnail: 25907.jpg
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2022-09-03T00:00:00Z
exl-id: 6fb3199a-02c9-48bc-a6fa-1f767cfd2f2a
duration: 3592
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1278'
ht-degree: 0%

---

# Konfigurera utvecklingsverktyg {#set-up-development-tools}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_devtools"
>title="Installationsutvecklingsverktyg"
>abstract="Utvecklingsverktyg för Adobe Experience Manager (AEM) kräver en minimalistisk uppsättning utvecklingsverktyg som ska installeras och konfigureras på utvecklingsdatorn. Bland dessa verktyg finns Java, Maven, Adobe I/O CLI, Development IDE med flera."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/development-guidelines.html" text="Utvecklingsriktlinjer"
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/basics/aem-sdk.html" text="Grundläggande om utveckling"

Utvecklingsverktyg för Adobe Experience Manager (AEM) kräver en minimalistisk uppsättning utvecklingsverktyg som ska installeras och konfigureras på utvecklingsdatorn. Dessa verktyg har stöd för utveckling och byggande av AEM projekt.

Observera att `~` används som kortskrift för användarkatalogen. I Windows motsvarar detta `%HOMEPATH%`.

## Installera Java

Experience Manager är ett Java-program och kräver därför Java SDK för att stödja utveckling och AEM as a Cloud Service SDK.

1. [Hämta och installera den senaste versionen av Java 11 SDK](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
1. Kontrollera att Oraclet Java 11 SDK är installerat genom att köra kommandot:

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ java --version
```

>[!TAB Windows]

```shell
$ java -version
```

>[!TAB Linux]

```shell
$ java --version
```

>[!ENDTABS]

![Java](./assets/development-tools/java.png)

## Installera homebrew

_Användning av Homebrew är valfri, men rekommenderas._

Homebrew är en pakethanterare med öppen källkod för macOS, Windows och Linux. Alla stödverktyg kan installeras separat. Homebrew är ett bekvämt sätt att installera och uppdatera en mängd olika utvecklingsverktyg som krävs för utveckling av Experience Manager.

1. Öppna terminalen
1. Kontrollera om Homebrew redan är installerat genom att köra kommandot: `brew --version`.
1. Installera Homebrew om det inte finns installerat

>[!BEGINTABS]

>[!TAB macOS]

[Homebrew on macOS](https://brew.sh/) kräver [Xcode](https://apps.apple.com/us/app/xcode/id497799835) eller [Kommandoradsverktyg](https://developer.apple.com/download/more/), kan installeras via kommandot:

```shell
$ xcode-select --install
```

>[!TAB Windows]

[Installera homebrew i Windows 10](https://docs.brew.sh/Installation#linux-or-windows-10-subsystem-for-linux)

>[!TAB Linux]

[Installera Homebrew i Linux](https://docs.brew.sh/Installation#linux-or-windows-10-subsystem-for-linux)

>[!ENDTABS]

1. Kontrollera att Homebrew är installerat genom att köra kommandot: `brew --version`

![Homebreiska](./assets/development-tools/homebrew.png)

Om du använder Homebrew ska du följa __Installera med Homebrew__ instruktionerna i avsnitten nedan. Om du __not__ installera verktygen med hjälp av operativsystemspecifika länkar med Homebrew.

## Installera Git

[Git](https://git-scm.com/) är det system för hantering av källkontroll som används av [Adobe Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/using/requirements/source-code-repository.html)och därför krävs för utveckling.

>[!BEGINTABS]

>[!TAB Installera Git med Homebrew]

1. Öppna terminalen/kommandotolken
1. Kör kommandot: `$ brew install git`
1. Kontrollera att Git är installerat med kommandot: `$ git --version`

>[!TAB Hämta och installera Git]

1. [Hämta och installera Git](https://git-scm.com/downloads)
1. Öppna terminalen/kommandotolken
1. Kontrollera att Git är installerat med kommandot: `$ git --version`

>[!ENDTABS]

![Git](./assets/development-tools/git.png)

## Installera Node.js (och npm){#node-js}

[Node.js](https://nodejs.org) är en JavaScript-körningsmiljö som används för att arbeta med de viktigaste resurserna i ett AEM __ui.front__ delprojekt. Node.js distribueras med [npm](https://www.npmjs.com/), är defacto-pakethanteraren Node.js som används för att hantera JavaScript-beroenden.

>[!BEGINTABS]

>[!TAB Installera Node.js med Homebrew]

1. Öppna terminalen/kommandotolken
1. Kör kommandot: `$ brew install node`
1. Kontrollera att Node.js är installerat med kommandot: `$ node -v`
1. Kontrollera att npm är installerat med kommandot: `$ npm -v`

>[!TAB Hämta och installera Node.js]

1. [Hämta och installera Node.js](https://nodejs.org/en/download/)
2. Öppna terminalen/kommandotolken
3. Kontrollera att Node.js är installerat med kommandot: `$ node -v`
4. Kontrollera att npm är installerat med kommandot: `$ npm -v`

>[!ENDTABS]

![Node.js och npm](./assets/development-tools/nodejs-and-npm.png)

>[!TIP]
>
>[AEM Project Archettype](https://github.com/adobe/aem-project-archetype)-baserade AEM installerar en isolerad version av Node.js vid byggtillfället. Det är bra att ha det lokala utvecklingssystemets version synkroniserad (eller nära) med de Node.js- och npm-versioner som anges i ditt AEM Maven-projekts Reactor pom.xml.
>
>Se exemplet [AEM projektreaktor pom.xml](https://github.com/adobe/aem-guides-wknd/blob/9ac94f3f40c978a53ec88fae79fbc17dd2db72f2/pom.xml#L117-L118) för att hitta byggversionerna av Node.js och npm.

## Installera Maven

Apache Maven är ett kommandoradsverktyg för Java med öppen källkod som används för att skapa AEM projekt som genereras från AEM Project Maven Archetype. Alla viktiga IDE:er ([IntelliJ IDEA](https://www.jetbrains.com/idea/), [Visual Studio Code](https://code.visualstudio.com/), [Eclipse](https://www.eclipse.org/), osv.) har integrerat stöd för Maven.


>[!BEGINTABS]

>[!TAB Installera Maven med Homebrew]

1. Öppna terminalen/kommandotolken
1. Kör kommandot: `$ brew install maven`
1. Kontrollera att Maven är installerad med kommandot: `$ mvn -v`

>[!TAB Hämta och installera Maven]

1. [Ladda ned Maven](https://maven.apache.org/download.cgi)
1. [Installera Maven](https://maven.apache.org/install.html)
1. Öppna terminalen/kommandotolken
1. Kontrollera att Maven är installerad med kommandot: `$ mvn -v`

>[!ENDTABS]

![Maven](./assets/development-tools/maven.png)

## Konfigurera Adobe I/O CLI{#aio-cli}

The [ADOBE I/O CLI](https://github.com/adobe/aio-cli), eller `aio`, ger kommandoradsåtkomst till en mängd olika Adobe-tjänster, inklusive [Cloud Manager](https://github.com/adobe/aio-cli-plugin-cloudmanager) och [Asset compute](https://github.com/adobe/aio-cli-plugin-asset-compute). CLI för Adobe I/O spelar en viktig roll för utvecklingen på AEM as a Cloud Service eftersom den ger utvecklarna möjlighet att

+ Loggar från AEM som Cloud Service
+ Hantera Cloud Manager-pipelines från CLI
+ Distribuera till [AEM miljöer för snabb utveckling](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/overview.html)

### Installera Adobe I/O CLI

1. Säkerställ [Node.js är installerat](#node-js) eftersom CLI för Adobe I/O är en npm-modul
   + Kör `node --version` bekräfta
1. Kör `npm install -g @adobe/aio-cli` för att installera `aio` npm-modul globalt

### Konfigurera plugin-programmet Adobe I/O CLI Cloud Manager{#aio-cloud-manager}

Med pluginprogrammet Adobe I/O Cloud Manager kan AIO CLI interagera med Adobe Cloud Manager via `aio cloudmanager` -kommando.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-cloudmanager` för att installera [Insticksprogram för aio Cloud Manager](https://github.com/adobe/aio-cli-plugin-cloudmanager).

#### Ställa in Adobe I/O CLI-autentisering

För att Adobe I/O CLI ska kunna kommunicera med Cloud Manager måste [Integrering med Cloud Manager måste skapas i Adobe I/O Console](https://github.com/adobe/aio-cli-plugin-cloudmanager)och autentiseringsuppgifter måste hämtas för att autentiseringen ska lyckas.

1. Logga in på [console.adobe.io](https://console.adobe.io)
1. Se till att din organisation som innehåller den Cloud Manager-produkt som du vill ansluta till är aktiv i Adobe Org-växlaren
1. Skapa ett nytt eller öppna ett befintligt [Adobe I/O](https://www.adobe.io/apis/experienceplatform/console/docs.html#!AdobeDocs/adobeio-console/master/projects.md)
   + Adobe I/O Console-program är helt enkelt grupperingar av integreringar, skapar eller använder befintliga program baserat på hur du vill hantera dina integreringar
   + Om du skapar ett nytt projekt väljer du Tomt projekt om du uppmanas till det (jämfört med Skapa från mall)
   + Adobe I/O Console-program är olika koncept för Cloud Manager-program
1. Skapa en ny API-integrering för Cloud Manager med profilen &quot;Developer - Cloud Service&quot;
1. Hämta JWT-autentiseringsuppgifterna (Service Account) måste fylla i Adobe I/O CLI:ns [config.json](https://github.com/adobe/aio-cli-plugin-cloudmanager#authentication)
1. Läs in `config.json` till Adobe I/O CLI
   + `$ aio config:set ims.contexts.aio-cli-plugin-cloudmanager PATH_TO_CONFIG_JSON_FILE --file --json`
1. Läs in `private.key` till Adobe I/O CLI
   + `$ aio config:set ims.contexts.aio-cli-plugin-cloudmanager.private_key PATH_TO_PRIVATE_KEY_FILE --file`

Börja [köra kommandon](https://github.com/adobe/aio-cli-plugin-cloudmanager#commands) för Cloud Manager via Adobe I/O CLI.

### Konfigurera plugin-programmet AEM Rapid Development Environment{#rde}

Med pluginen AEM Rapid Development Environment kan AIO CLI interagera med AEM as a Cloud Service [Snabba utvecklingsmiljöer](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/overview.html) via `aio aem:rde` -kommando.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-aem-rde` för att installera [AEM Rapid Development Environment plugin](https://github.com/adobe/aio-cli-plugin-aem-rde).

### Konfigurera plugin-programmet Adobe I/O CLI Asset compute{#aio-asset-compute}

Adobe I/O Cloud Manager-pluginen gör det möjligt för aio CLI att generera och köra Asset compute-arbetare via `aio asset-compute` -kommando.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-asset-compute` för att installera [aio Asset compute plug-in](https://github.com/adobe/aio-cli-plugin-asset-compute).

## Ställ in utvecklingsmiljön

AEM består främst av utveckling av Java och Front-end (JavaScript, CSS osv.) samt XML-hantering. Nedan följer de vanligaste utvecklingsmiljöerna för AEM.

### IntelliJ IDEA

__[IntelliJ IDEA](https://www.jetbrains.com/idea/)__ är en kraftfull utvecklingsmiljö för Java-utveckling. IntelliJ IDEA finns i två versioner: en kostnadsfri utgåva av gemenskapen och en kommersiell (betald) version av Ultimate. Den kostnadsfria gemenskapsversionen räcker AEM utvecklingen, men Ultimate [utökar sin funktionsuppsättning](https://www.jetbrains.com/idea/download).

>[!VIDEO](https://video.tv.adobe.com/v/26089?quality=12&learn=on)

+ [Ladda ned IntelliJ IDEA](https://www.jetbrains.com/idea/download)
+ [Ladda ned Repo-verktyget](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#installation)

### Microsoft Visual Studio Code

__[Visual Studio Code](https://code.visualstudio.com/)__ (VS Code) är ett kostnadsfritt verktyg med öppen källkod för gränssnittsutvecklare. Visual Studio Code kan konfigureras för att integrera innehållssynkronisering med AEM med hjälp av ett Adobe-verktyg, __[repo](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#integration-into-visual-studio-code)__.

Visual Studio Code är det idealiska alternativet för gränssnittsutvecklare som i första hand vill skapa front-end-kod: JavaScript, CSS och HTML. VS-koden har Java-stöd via [tillägg](https://code.visualstudio.com/docs/java/java-tutorial), kanske saknar vissa av de avancerade funktioner som finns i mer Java-specifika.

>[!VIDEO](https://video.tv.adobe.com/v/25907?quality=12&learn=on)

+ [Ladda ned Visual Studio Code](https://code.visualstudio.com/Download)
+ [Ladda ned Repo-verktyget](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#integration-into-visual-studio-code)
+ [Hämta namngivet VS-kodtillägg](https://aemfed.io/)
+ [Hämta AEM Synkronisera VS-kodtillägg](https://marketplace.visualstudio.com/items?itemName=Yinkai15.aemsync)

### Eclipse

__[Eclipse IDE](https://www.eclipse.org/ide/)__ är en populär IDE för Java-utveckling och stöder  __[AEM Developer Tools](https://experienceleague.adobe.com/docs/experience-manager-65/developing/devtools/aem-eclipse.html)__ plugin-program från Adobe som tillhandahåller ett in-IDE-GUI för redigering och synkronisering av JCR-innehåll med en lokal AEM.

>[!VIDEO](https://video.tv.adobe.com/v/25906?quality=12&learn=on)

+ [Hämta Eclipse](https://www.eclipse.org/ide/)
+ [Hämta Eclipse Dev Tools](https://experienceleague.adobe.com/docs/experience-manager-65/developing/devtools/aem-eclipse.html)
