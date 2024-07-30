---
title: Konfigurera utvecklingsverktygen för AEM as a Cloud Service-utveckling
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
duration: 3508
source-git-commit: e7a85e8d072d808683580a201dd10b3a847efaaa
workflow-type: tm+mt
source-wordcount: '1301'
ht-degree: 0%

---

# Konfigurera utvecklingsverktyg {#set-up-development-tools}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_devtools"
>title="Installationsutvecklingsverktyg"
>abstract="Utvecklingsverktyg för Adobe Experience Manager (AEM) kräver en minimalistisk uppsättning utvecklingsverktyg som ska installeras och konfigureras på utvecklingsdatorn. Bland dessa verktyg finns Java, Maven, Adobe I/O CLI, Development IDE med flera."
>additional-url="https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/development-guidelines" text="Utvecklingsriktlinjer"
>additional-url="https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/developing/basics/aem-sdk" text="Grundläggande om utveckling"

Utvecklingsverktyg för Adobe Experience Manager (AEM) kräver en minimalistisk uppsättning utvecklingsverktyg som ska installeras och konfigureras på utvecklingsdatorn. Dessa verktyg har stöd för utveckling och byggande av AEM projekt.

Observera att `~` används som kortskrift för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`.

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

_Användning av Homebrew är valfritt, men rekommenderas._

Homebrew är en pakethanterare med öppen källkod för macOS, Windows och Linux. Alla stödverktyg kan installeras separat. Homebrew är ett bekvämt sätt att installera och uppdatera en mängd olika utvecklingsverktyg som krävs för utveckling av Experience Manager.

1. Öppna terminalen
1. Kontrollera om Homebrew redan är installerat genom att köra kommandot: `brew --version`.
1. Installera Homebrew om det inte finns installerat

>[!BEGINTABS]

>[!TAB macOS]

[Hemma på macOS](https://brew.sh/) kräver [Xcode](https://apps.apple.com/us/app/xcode/id497799835) eller [Command Line Tools](https://developer.apple.com/download/more/) som kan installeras via kommandot:

```shell
$ xcode-select --install
```

>[!TAB Windows]

[Installera homebrew i Windows 10](https://docs.brew.sh/Installation#linux-or-windows-10-subsystem-for-linux)

>[!TAB Linux]

[Installera Homebrew i Linux](https://docs.brew.sh/Installation#linux-or-windows-10-subsystem-for-linux)

>[!ENDTABS]

1. Kontrollera att Homebrew har installerats genom att köra kommandot: `brew --version`

![Hembrew](./assets/development-tools/homebrew.png)

Om du använder Homebrew följer du instruktionerna för __Installera med Homebrew__ i avsnitten nedan. Om du __inte__ använder Homebrew installerar du verktygen med operativsystemspecifika länkar.

## Installera Git

[Git](https://git-scm.com/) är det källkontrollshanteringssystem som används av [Adobe Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/using/requirements/source-code-repository.html) och krävs därför för utveckling.

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

[Node.js](https://nodejs.org) är en JavaScript-körningsmiljö som används för att arbeta med de främsta resurserna i ett AEM __ui.front__ -projekt. Node.js distribueras med [npm](https://www.npmjs.com/), är defacehanteraren för Node.js-paketet som används för att hantera JavaScript-beroenden.

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
>[AEM Project Archetype](https://github.com/adobe/aem-project-archetype)-baserade AEM Projects installerar en isolerad version av Node.js vid byggtid. Det är bra att ha det lokala utvecklingssystemets version synkroniserad (eller nära) med de Node.js- och npm-versioner som anges i ditt AEM Maven-projekts Reactor pom.xml.
>
>I det här exemplet [AEM Project Reactor pom.xml](https://github.com/adobe/aem-guides-wknd/blob/9ac94f3f40c978a53ec88fae79fbc17dd2db72f2/pom.xml#L117-L118) hittar du var du hittar byggversionerna Node.js och npm.

## Installera Maven

Apache Maven är ett kommandoradsverktyg för Java med öppen källkod som används för att skapa AEM projekt som genereras från AEM Project Maven Archetype. Alla större IDE:er ([IntelliJ IDEA](https://www.jetbrains.com/idea/), [Visual Studio Code](https://code.visualstudio.com/), [Eclipse](https://www.eclipse.org/) osv.) har integrerat stöd för Maven.


>[!BEGINTABS]

>[!TAB Installera Maven med Homebrew]

1. Öppna terminalen/kommandotolken
1. Kör kommandot: `$ brew install maven`
1. Kontrollera att Maven är installerad med kommandot: `$ mvn -v`

>[!TAB Hämta och installera Maven]

1. [Hämta Maven](https://maven.apache.org/download.cgi)
1. [Installera Maven](https://maven.apache.org/install.html)
1. Öppna terminalen/kommandotolken
1. Kontrollera att Maven är installerad med kommandot: `$ mvn -v`

>[!ENDTABS]

![Maven](./assets/development-tools/maven.png)

## Konfigurera Adobe I/O CLI{#aio-cli}

[Adobe I/O CLI](https://github.com/adobe/aio-cli), eller `aio`, ger kommandoradsåtkomst till en mängd olika Adobe-tjänster, inklusive [Cloud Manager](https://github.com/adobe/aio-cli-plugin-cloudmanager) och [Asset compute](https://github.com/adobe/aio-cli-plugin-asset-compute). CLI för Adobe I/O spelar en viktig roll för AEM as a Cloud Service utveckling eftersom det ger utvecklarna möjlighet att

+ Loggar från AEM som Cloud Service
+ Hantera Cloud Manager-rörledningar från CLI
+ Distribuera till [AEM snabbutvecklingsmiljöer](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/overview.html)

### Installera Adobe I/O CLI

1. Kontrollera att [Node.js är installerat](#node-js) eftersom Adobe I/O CLI är en npm-modul
   + Kör `node --version` för att bekräfta
1. Kör `npm install -g @adobe/aio-cli` om du vill installera `aio` npm-modulen globalt

### Konfigurera Adobe I/O CLI Cloud Manager plugin{#aio-cloud-manager}

Adobe I/O Cloud Manager-pluginen gör att AIO CLI kan interagera med Adobe Cloud Manager via kommandot `aio cloudmanager`.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-cloudmanager` om du vill installera [aio Cloud Manager-plugin](https://github.com/adobe/aio-cli-plugin-cloudmanager).

#### Ställa in Adobe I/O CLI-autentisering

För att Adobe I/O CLI ska kunna kommunicera med Cloud Manager måste en [Cloud Manager-integrering skapas i Adobe I/O Console](https://github.com/adobe/aio-cli-plugin-cloudmanager) och autentiseringsuppgifter måste hämtas för att autentiseringen ska lyckas.

1. Logga in på [console.adobe.io](https://console.adobe.io)
1. Se till att din organisation som innehåller den Cloud Manager-produkt som du vill ansluta till är aktiv i Adobe Organization Switcher
1. Skapa ett nytt eller öppna ett befintligt [Adobe I/O-program](https://www.adobe.io/apis/experienceplatform/console/docs.html#!AdobeDocs/adobeio-console/master/projects.md)
   + Adobe I/O Console-projekt är helt enkelt organisatoriska grupperingar av integreringar, skapa eller använda och befintliga projekt baserat på hur du vill hantera dina integreringar.
   + Om du skapar ett nytt projekt väljer du Tomt projekt om du uppmanas till det (jämfört med Skapa från mall)
   + Adobe I/O Console-program är olika koncept för Cloud Manager-program
1. Skapa en ny integrering med Cloud Manager API
   + Välj den inaktuella autentiseringstypen &quot;Tjänstkonto (JWT)&quot; (OAuth stöds inte för CLI just nu).
   + Skapa eller ladda upp nycklar.
   + Välj produktprofilen &quot;Utvecklare - Cloud Service&quot;
1. Hämta JWT-autentiseringsuppgifterna (Service Account) måste fylla i Adobe I/O CLI:s [config.json](https://github.com/adobe/aio-cli-plugin-cloudmanager#authentication)

   ```json
   //config.json 
   {
      "client_id": "Client ID from Service Account (JWT) credential",
      "client_secret": "Client Secret from Service Account (JWT) credential",
      "technical_account_id": "Technical Account ID from Service Account (JWT) credential",
      "ims_org_id": "Organization ID from Service Account (JWT) credential",
      "meta_scopes": [
        "ent_cloudmgr_sdk"
      ]
   }
   ```

1. Läs in filen `config.json` i Adobe I/O CLI
   + `$ aio config:set ims.contexts.aio-cli-plugin-cloudmanager ./path/to/config.json --file --json`
1. Läs in filen `private.key` i Adobe I/O CLI
   + `$ aio config:set ims.contexts.aio-cli-plugin-cloudmanager.private_key ./path/to/private.key --file`

Börja [köra kommandon](https://github.com/adobe/aio-cli-plugin-cloudmanager#commands) för Cloud Manager via Adobe I/O CLI.

### Konfigurera plugin-programmet AEM Rapid Development Environment{#rde}

Med plugin-programmet AEM Rapid Development Environment kan AIO CLI interagera med AEM as a Cloud Service [Rapid Development Environment](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/overview.html) via kommandot `aio aem:rde`.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-aem-rde` för att installera plugin-programmet [AEM Rapid Development Environment](https://github.com/adobe/aio-cli-plugin-aem-rde).

### Konfigurera plugin-programmet Adobe I/O CLI Asset compute{#aio-asset-compute}

Adobe I/O Cloud Manager-pluginen gör att AIO CLI kan generera och köra Asset Compute-arbetare via kommandot `aio asset-compute`.

1. Kör `aio plugins:install @adobe/aio-cli-plugin-asset-compute` om du vill installera plugin-programmet [aio Asset compute](https://github.com/adobe/aio-cli-plugin-asset-compute).

## Ställ in utvecklingsmiljön

AEM består främst av utveckling av Java och Front-end (JavaScript, CSS osv.) samt XML-hantering. Nedan följer de vanligaste utvecklingsmiljöerna för AEM.

### IntelliJ IDEA

__[IntelliJ IDEA](https://www.jetbrains.com/idea/)__ är en kraftfull IDE för Java-utveckling. IntelliJ IDEA finns i två versioner: en kostnadsfri utgåva av gemenskapen och en kommersiell (betald) version av Ultimate. Den kostnadsfria communityversionen räcker AEM utvecklingen, men den slutliga [versionen utökar sin funktionsuppsättning](https://www.jetbrains.com/idea/download).

>[!VIDEO](https://video.tv.adobe.com/v/26089?quality=12&learn=on)

+ [Hämta IntelliJ IDEA](https://www.jetbrains.com/idea/download)
+ [Ladda ned Repo-verktyget](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#installation)

### Microsoft Visual Studio Code

__[Visual Studio Code](https://code.visualstudio.com/)__ (VS-kod) är ett kostnadsfritt verktyg med öppen källkod för gränssnittsutvecklare. Visual Studio Code kan konfigureras för att integrera innehållssynkronisering med AEM med hjälp av ett Adobe-verktyg, __[repo](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#integration-into-visual-studio-code)__.

Visual Studio Code är det idealiska alternativet för gränssnittsutvecklare som i första hand vill skapa slutkod: JavaScript, CSS och HTML. VS-koden har Java-stöd via [extensions](https://code.visualstudio.com/docs/java/java-tutorial), men saknar kanske vissa avancerade funktioner från mer Java-specifika.

>[!VIDEO](https://video.tv.adobe.com/v/25907?quality=12&learn=on)

+ [Hämta Visual Studio-kod](https://code.visualstudio.com/Download)
+ [Ladda ned Repo-verktyget](https://github.com/Adobe-Marketing-Cloud/tools/tree/master/repo#integration-into-visual-studio-code)
+ [Ladda ned VS-kodtillägg som stöds](https://aemfed.io/)
+ [Hämta AEM Synkronisera VS-kodtillägg](https://marketplace.visualstudio.com/items?itemName=Yinkai15.aemsync)

### Eclipse

__[Eclipse IDE](https://www.eclipse.org/ide/)__ är en populär IDE för Java-utveckling och stöder plugin-programmet __[AEM Developer Tools](https://experienceleague.adobe.com/docs/experience-manager-65/developing/devtools/aem-eclipse.html)__ från Adobe, som tillhandahåller ett in-IDE-gränssnitt för redigering och synkronisering av JCR-innehåll med en lokal AEM.

>[!VIDEO](https://video.tv.adobe.com/v/25906?quality=12&learn=on)

+ [Hämta Eclipse](https://www.eclipse.org/ide/)
+ [Hämta Eclipse Dev-verktyg](https://experienceleague.adobe.com/docs/experience-manager-65/developing/devtools/aem-eclipse.html)
