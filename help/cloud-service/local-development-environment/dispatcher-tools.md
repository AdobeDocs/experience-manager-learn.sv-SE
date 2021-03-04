---
title: Konfigurera Dispatcher Tools för AEM som en Cloud Service Development
description: AEM SDKs Dispatcher Tools underlättar den lokala utvecklingen av Adobe Experience Manager-projekt (AEM) genom att göra det enkelt att installera, köra och felsöka Dispatcher lokalt.
sub-product: grund
feature: Dispatcher, utvecklingsverktyg
topics: development, caching, security
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 4679
thumbnail: 30603.jpg
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '1572'
ht-degree: 1%

---


# Konfigurera lokala Dispatcher-verktyg

Adobe Experience Manager (AEM) Dispatcher är en Apache HTTP-webbservermodul som tillhandahåller ett säkerhets- och prestandalager mellan CDN- och AEM-publiceringsnivån. Dispatcher är en viktig del av den övergripande Experience Manager-arkitekturen och bör ingå i den lokala utvecklingsmiljön.

AEM som Cloud Service-SDK innehåller den rekommenderade versionen av Dispatcher Tools som gör det lättare att konfigurera, validera och simulera Dispatcher lokalt. Dispatcher Tools består av:

+ en basuppsättning med konfigurationsfiler för Apache HTTP-webbserver och Dispatcher, som finns i `.../dispatcher-sdk-x.x.x/src`
+ ett CLI-verktyg för konfigurationsvaliderare, som finns på `.../dispatcher-sdk-x.x.x/bin/validate` (Dispatcher SDK 2.0.29+)
+ ett CLI-verktyg för konfigurationsgenerering som finns på `.../dispatcher-sdk-x.x.x/bin/validator`
+ ett CLI-verktyg för konfigurationsdistribution, som finns på `.../dispatcher-sdk-x.x.x/bin/docker_run`
+ en Docker-bild som kör Apache HTTP Web Server med modulen Dispatcher

Observera att `~` används som kortskrift för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`.

>[!NOTE]
>
> Videorna på den här sidan spelades in på macOS. Windows-användare kan följa med, men använda motsvarande Dispatcher Tools Windows-kommandon som finns i varje video.

## Förutsättningar

1. Windows-användare måste använda Windows 10 Professional
1. Installera [Experience Manager Publish Quickstart Jar](./aem-runtime.md) på den lokala utvecklingsdatorn.
   + Du kan även installera den senaste [AEM referenswebbplatsen](https://github.com/adobe/aem-guides-wknd/releases) på den lokala AEM Publish-tjänsten. Den här webbplatsen används i den här självstudiekursen för att visualisera en fungerande Dispatcher.
1. Installera och starta den senaste versionen av [Docker](https://www.docker.com/) (Docker Desktop 2.2.0.5+ / Docker Engine v19.03.9+) på den lokala utvecklingsdatorn.

## Ladda ned Dispatcher Tools (som en del av AEM SDK)

AEM som Cloud Service-SDK, eller AEM SDK, innehåller Dispatcher-verktygen som används för att köra Apache HTTP Web-servern med Dispatcher-modulen lokalt för utveckling, liksom den kompatibla QuickStart Jar.

Om AEM som Cloud Service-SDK redan har hämtats till [installerar den lokala AEM](./aem-runtime.md) behöver den inte hämtas igen.

1. Logga in på [experience.adobe.com/#/downloads](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=AEM*+SDK*&amp;1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;order.sort=desc&amp;layout=list&amp;list p.offset=0&amp;p.limit=1) med din Adobe ID
   + Din Adobe-organisation __måste__ etableras för AEM som Cloud Service för att kunna hämta AEM som en Cloud Service-SDK
1. Klicka på den senaste __AEM SDK__-resultatraden som ska hämtas
   + Se till att AEM SDK&#39;s Dispatcher Tools v2.0.29+ anges i nedladdningsbeskrivningen

## Extrahera Dispatcher-verktygen från AEM SDK

>[!TIP]
>
> Windows-användare kan inte ha blanksteg eller specialtecken i sökvägen till mappen som innehåller Lokala Dispatcher-verktyg. Om det finns blanksteg i sökvägen kommer `docker_run.cmd` att misslyckas.

Versionen av Dispatcher Tools skiljer sig från AEM SDK. Kontrollera att versionen av Dispatcher Tools finns i den AEM SDK-version som matchar AEM som en Cloud Service-version.

1. Zippa upp den hämtade `aem-sdk-xxx.zip`-filen
1. Packa upp Dispatcher-verktygen i `~/aem-sdk/dispatcher`
   + Windows: Zippa upp `aem-sdk-dispatcher-tools-x.x.x-windows.zip` i `C:\Users\<My User>\aem-sdk\dispatcher` (skapar saknade mappar efter behov)
   + macOS / Linux: Kör det medföljande gränssnittsskriptet `aem-sdk-dispatcher-tools-x.x.x-unix.sh` för att packa upp Dispatcher-verktygen
      + `chmod a+x aem-sdk-dispatcher-tools-x.x.x-unix.sh && ./aem-sdk-dispatcher-tools-x.x.x-unix.sh`

Observera att alla kommandon som anges nedan förutsätter att den aktuella arbetskatalogen innehåller det expanderande Dispatcher-verktygsinnehållet.

>[!VIDEO](https://video.tv.adobe.com/v/30601/?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat*

## Förstå Dispatcher-konfigurationsfilerna

>[!TIP]
> Projekt i Experience Manager som skapats från [AEM Project Maven Archetype](https://github.com/adobe/aem-project-archetype) är förifyllda med den här uppsättningen Dispatcher-konfigurationsfiler, och du behöver därför inte kopiera över dem från Src-mappen Dispatcher Tools.

Dispatcher Tools innehåller en uppsättning konfigurationsfiler för Apache HTTP Web Server och Dispatcher som definierar beteendet för alla miljöer, inklusive lokal utveckling.

Filerna är avsedda att kopieras till ett Experience Manager Maven-projekt till mappen `dispatcher/src`, om de inte redan finns i Experience Manager Maven-projektet.

>[!VIDEO](https://video.tv.adobe.com/v/30602/?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat*

En fullständig beskrivning av konfigurationsfilerna finns i de opackade Dispatcher Tools som `dispatcher-sdk-x.x.x/docs/Config.html`.

## Validera konfigurationer

Dispatcher- och Apache-webbserverkonfigurationerna (via `httpd -t`) kan valideras med hjälp av `validate`-skriptet (ska inte blandas ihop med den körbara filen `validator`).

+ Användning:
   + Windows: `bin\validate src`
   + macOS / Linux: `./bin/validate.sh ./src`

## Kör Dispatcher lokalt

Om du vill köra Dispatcher lokalt måste Dispatcher-konfigurationsfilerna genereras med Dispatcher-verktygets CLI-verktyg `validator`.

+ Användning:
   + Windows: `bin\validator full -d out src`
   + macOS / Linux: `./bin/validator full -d ./out ./src`

Det här kommandot överför konfigurationerna till en filuppsättning som är kompatibel med Docker-behållarens Apache HTTP Web Server.

När de inbyggda konfigurationerna har skapats körs Dispatcher lokalt i Docker-behållaren. Det är viktigt att se till att de senaste konfigurationerna har validerats med `validate` __och__-utdata med hjälp av validerarens `-d`-alternativ.

+ Användning:
   + Windows: `bin\docker_run <deployment-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>`
   + macOS / Linux: `./bin/docker_run.sh <deployment-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>`

`aem-publish-host` kan anges till `host.docker.internal`, en speciell DNS-namnDocker tillhandahåller i behållaren som matchar värddatorns IP-adress. Om `host.docker.internal` inte löser problemet kan du läsa avsnittet [felsökning](#troubleshooting-host-docker-internal) nedan.

Om du till exempel vill starta Dispatcher Docker-behållaren med de standardkonfigurationsfiler som finns i Dispatcher-verktygen:

1. Generera `deployment-folder` med namnet `out` från början varje gång en konfiguration ändras:

   + Windows: `del /Q out && bin\validator full -d out src`
   + macOS / Linux: `rm -rf ./out && ./bin/validator full -d ./out ./src`

2. (Återuppta)starta Dispatcher Docker-behållaren med sökvägen till distributionsmappen:

   + Windows: `bin\docker_run out host.docker.internal:4503 8080`
   + macOS / Linux: `./bin/docker_run.sh ./out host.docker.internal:4503 8080`

AEM som Cloud Service-SDK:s publiceringstjänst, som körs lokalt på port 4503, är tillgänglig via Dispatcher på `http://localhost:8080`.

Om du vill köra Dispatcher Tools mot Dispatcher-konfigurationen för ett Experience Manager-projekt genererar du bara `deployment-folder` med projektets `dispatcher/src`-mapp.

+ Windows:

   ```shell
   $ del -/Q out && bin\validator full -d out <User Directory>/code/my-project/dispatcher/src
   $ bin\docker_run out host.docker.internal:4503 8080
   ```

+ macOS / Linux:

   ```shell
   $ rm -rf ./out && ./bin/validator full -d ./out ~/code/my-project/dispatcher/src
   $ ./bin/docker_run.sh ./out host.docker.internal:4503 8080
   ```

>[!VIDEO](https://video.tv.adobe.com/v/30603/?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat*

## Loggar för Dispatcher Tools

Distributionsloggar är användbara under lokal utveckling för att förstå om och varför HTTP-begäranden blockeras. Loggnivån kan anges genom att köra `docker_run` med miljöparametrar som prefix.

Loggar för Dispatcher Tools skickas till standard out när `docker_run` körs.

Användbara parametrar för felsökning av Dispatcher är:

+ `DISP_LOG_LEVEL=Debug` anger att inloggning i modulen Dispatcher ska vara felsökningsnivå
   + Standardvärdet är: `Warn`
+ `REWRITE_LOG_LEVEL=Debug` anger Apache HTTP Web server rewrite module loggning till Felsökningsnivå
   + Standardvärdet är: `Warn`
+ `DISP_RUN_MODE` anger körningsläget för Dispatcher-miljön och läser in motsvarande körningslägen Dispatcher-konfigurationsfiler.
   + Standardvärdet är `dev`
+ Giltiga värden: `dev`, `stage` eller `prod`

En eller flera parametrar kan skickas till `docker_run`

+ Windows:

   ```shell
   $ bin\validator full -d out <User Directory>/code/my-project/dispatcher/src
   $ DISP_LOG_LEVEL=Debug REWRITE_LOG_LEVEL=Debug bin\docker_run out host.docker.internal:4503 8080
   ```

+ macOS / Linux:

   ```shell
   $ ./bin/validator full -d out ~/code/my-project/dispatcher/src
   $ DISP_LOG_LEVEL=Debug REWRITE_LOG_LEVEL=Debug ./bin/docker_run.sh out host.docker.internal:4503 8080
   ```

>[!VIDEO](https://video.tv.adobe.com/v/30604/?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat*

### Loggfilsåtkomst

Du kan komma åt Apache-webbservern och AEM Dispatcher-loggarna direkt i Docker-behållaren:

+ [Åtkomst till loggar i Docker-behållaren](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-access-logs)
+ [Kopiera Docker-loggarna till det lokala filsystemet](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-copy-logs)

## När Dispatcher Tools{#dispatcher-tools-version} ska uppdateras

Dispatcher Tools-versionerna ökar inte lika ofta som Experience Manager och Dispatcher Tools kräver därför färre uppdateringar i den lokala utvecklingsmiljön.

Den rekommenderade versionen av Dispatcher Tools är den som medföljer AEM som en Cloud Service-SDK som matchar Experience Manager som en Cloud Service-version. Versionen av AEM som en Cloud Service finns via [Cloud Manager](https://my.cloudmanager.adobe.com/).

+ __Cloud Manager > Miljöer__, per miljö som anges av  __AEM__ Releaselabel

![Experience Manager version](./assets/dispatcher-tools/aem-version.png)

_Observera att Dispatcher Tools-versionen inte överensstämmer med Experience Manager-versionen._

## Felsökning

### docker_run resulterar i meddelandet&quot;Väntar tills host.docker.internal är tillgänglig&quot;{#troubleshooting-host-docker-internal}

`host.docker.internal` är ett värdnamn som tillhandahålls Docker-behållaren som löses till värden. Per docs.docker.com ([macOS](https://docs.docker.com/docker-for-mac/networking/#i-want-to-connect-from-a-container-to-a-service-on-the-host), [Windows](https://docs.docker.com/docker-for-windows/networking/)):

> Från och med Docker 18.03 rekommenderar vi att du ansluter till det särskilda DNS-namnet host.docker.internal, som matchar den interna IP-adressen som används av värden

Om `bin/docker_run out host.docker.internal:4503 8080` resulterar i meddelandet __Väntar tills host.docker.internal är tillgängligt__:

1. Kontrollera att den installerade versionen av Docker är 18.03 eller senare
2. Du kan ha konfigurerat en lokal dator som förhindrar registrering/upplösning av `host.docker.internal`-namnet. Använd i stället din lokala IP-adress.
   + Windows:
      + Kör `ipconfig` från kommandotolken och registrera värddatorns __IPv4-adress__.
      + Kör sedan `docker_run` med den här IP-adressen:
         `bin\docker_run out <HOST IP>:4503 8080`
   + macOS / Linux:
      + Kör `ifconfig` från Terminal och spela in IP-adressen för värddatorn __inet__, vanligtvis enheten __en0__.
      + Kör sedan `docker_run` med IP-värdadressen:
         `bin/docker_run.sh out <HOST IP>:4503 8080`

#### Exempel på fel

```shell
$ docker_run out host.docker.internal:4503 8080

Running script /docker_entrypoint.d/10-check-environment.sh
Running script /docker_entrypoint.d/20-create-docroots.sh
Running script /docker_entrypoint.d/30-wait-for-backend.sh
Waiting until host.docker.internal is available
```

### docker_run resulterar i felet **: Distributionsmappen hittades inte

När du kör `docker_run.cmd` visas ett fel som läser __**-fel: Distributionsmappen hittades inte:__. Det beror ofta på att det finns blanksteg i banan. Om det är möjligt tar du bort blankstegen i mappen eller flyttar mappen `aem-sdk` till en sökväg som inte innehåller blanksteg.

Windows-användarmappar är till exempel ofta `<First name> <Last name>`, med ett mellanrum mellan. I exemplet nedan innehåller mappen `...\My User\...` ett utrymme som bryter den lokala körningen av Dispatcher Tools `docker_run`. Om det finns mellanslag i en Windows-användarmapp ska du inte byta namn på den här mappen eftersom den kommer att bryta Windows, utan i stället flytta mappen `aem-sdk` till en ny plats som användaren har behörighet att ändra helt. Observera att instruktioner som antar att mappen `aem-sdk` finns i användarens arbetskatalog måste justeras till den nya platsen.

#### Exempel på fel

```shell
$ \Users\My User\aem-sdk\dispatcher>bin\docker_run.cmd out host.internal.docker:4503 8080

'User\aem-sdk\dispatcher\out\*' is not recognized as an internal or external command,
operable program or batch file.
** error: Deployment folder not found: c:\Users\My User\aem-sdk\dispatcher\out
```

### docker_run kan inte startas i Windows{#troubleshooting-windows-compatible}

Om du kör `docker_run` i Windows kan följande fel uppstå, vilket förhindrar att Dispatcher startas. Detta är ett rapporterat problem med Dispatcher i Windows och kommer att åtgärdas i en framtida version.

#### Exempel på fel

```shell
$ \Users\MyUser\aem-sdk\dispatcher>bin\docker_run out host.docker.internal:4503 8080

Running script /docker_entrypoint.d/10-check-environment.sh
Running script /docker_entrypoint.d/20-create-docroots.sh
Running script /docker_entrypoint.d/30-wait-for-backend.sh
Waiting until host.docker.internal is available
host.docker.internal resolves to 192.168.65.2
Running script /docker_entrypoint.d/40-generate-allowed-clients.sh
Running script /docker_entrypoint.d/50-check-expiration.sh
Running script /docker_entrypoint.d/60-check-loglevel.sh
Running script /docker_entrypoint.d/70-check-forwarded-host-secret.sh
Starting httpd server
[Sun Feb 09 17:32:22.256020 2020] [dispatcher:warn] [pid 1:tid 140080096570248] Unable to obtain parent directory of /etc/httpd/conf.dispatcher.d/enabled_farms/farms.any: No such file or directory
[Sun Feb 09 17:32:22.256069 2020] [dispatcher:alert] [pid 1:tid 140080096570248] Unable to import config file: /etc/httpd/conf.dispatcher.d/dispatcher.any
[Sun Feb 09 17:32:22.256074 2020] [dispatcher:alert] [pid 1:tid 140080096570248] Dispatcher initialization failed.
AH00016: Configuration Failed
```

## Ytterligare resurser

+ [Hämta AEM SDK](https://experience.adobe.com/#/downloads)
+ [Adobe Cloud Manager](https://my.cloudmanager.adobe.com/)
+ [Ladda ned Docker](https://www.docker.com/)
+ [Ladda ned AEM webbplats (WKND)](https://github.com/adobe/aem-guides-wknd/releases)
+ [Experience Manager Dispatcher-dokumentation](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/dispatcher.html)
