---
title: Konfigurera Dispatcher Tools for AEM as a Cloud Service Development
description: AEM SDK Dispatcher Tools underlättar den lokala utvecklingen av Adobe Experience Manager-projekt (AEM) genom att göra det enkelt att installera, köra och felsöka Dispatcher lokalt.
version: Experience Manager as a Cloud Service
topic: Development
feature: Dispatcher, Developer Tools
role: Developer
level: Beginner
jira: KT-4679
thumbnail: 30603.jpg
last-substantial-update: 2023-03-14T00:00:00Z
exl-id: 9320e07f-be5c-42dc-a4e3-aab80089c8f7
duration: 624
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1620'
ht-degree: 0%

---

# Konfigurera lokala Dispatcher-verktyg {#set-up-local-dispatcher-tools}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_dispatcher"
>title="Dispatcher verktyg lokalt"
>abstract="Dispatcher är en integrerad del av Experience Manager övergripande arkitektur och bör ingå i den lokala utvecklingsmiljön. AEM as a Cloud Service SDK innehåller den rekommenderade Dispatcher Tools-versionen som underlättar konfigurering av validering och simulering av Dispatcher lokalt."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/disp-overview.html" text="Dispatcher i molnet"
>additional-url="https://experienceleague.adobe.com/docs/experience-cloud/software-distribution/home.html" text="Hämta AEM as a Cloud Service SDK"

Adobe Experience Manager (AEM) Dispatcher är en Apache HTTP-webbservermodul som tillhandahåller ett säkerhets- och prestandalager mellan CDN och AEM Publish-nivån. Dispatcher är en integrerad del av Experience Manager övergripande arkitektur och bör ingå i den lokala utvecklingsmiljön.

AEM as a Cloud Service SDK innehåller den rekommenderade Dispatcher Tools-versionen som underlättar konfigurering av validering och simulering av Dispatcher lokalt. Dispatcher Tools består av:

+ en basuppsättning med Apache HTTP-webbserver och Dispatcher konfigurationsfiler, som finns på `.../dispatcher-sdk-x.x.x/src`
+ ett CLI-verktyg för konfigurationsvalideraren, som finns på `.../dispatcher-sdk-x.x.x/bin/validate`
+ ett CLI-verktyg för konfigurationsgenerering som finns på `.../dispatcher-sdk-x.x.x/bin/validator`
+ ett CLI-verktyg för konfigurationsdistribution, som finns på `.../dispatcher-sdk-x.x.x/bin/docker_run`
+ en oföränderlig konfigurationsfil som skriver över CLI-verktyget, som finns på `.../dispatcher-sdk-x.x.x/bin/update_maven`
+ en Docker-bild som kör Apache HTTP Web Server med modulen Dispatcher

Observera att `~` används som kortskrift för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`.

>[!NOTE]
>
> Videorna på den här sidan spelades in på macOS. Windows-användare kan följa med, men använda motsvarande Dispatcher Tools Windows-kommandon, som medföljer varje video.

## Förutsättningar

1. Windows-användare måste använda Windows 10 Professional (eller en version som stöder Docker)
1. Installera [Experience Manager Publish Quickstart Jar](./aem-runtime.md) på den lokala utvecklingsdatorn.

+ Du kan även installera den senaste [AEM-referenswebbplatsen](https://github.com/adobe/aem-guides-wknd/releases) på den lokala AEM Publish-tjänsten. Den här webbplatsen används i den här självstudiekursen för att visualisera en fungerande Dispatcher.

1. Installera och starta den senaste versionen av [Docker](https://www.docker.com/) (Docker Desktop 2.2.0.5+ / Docker Engine v19.03.9+) på den lokala utvecklingsdatorn.

## Ladda ned Dispatcher Tools (som en del av AEM SDK)

AEM as a Cloud Service SDK, eller AEM SDK, innehåller de Dispatcher-verktyg som används för att köra Apache HTTP-webbservern med Dispatcher-modulen lokalt för utveckling, samt den kompatibla QuickStart Jar.

Om AEM as a Cloud Service SDK redan har laddats ned för att [installera den lokala AEM-miljön](./aem-runtime.md) behöver den inte laddas ned igen.

1. Logga in på [experience.adobe.com/#/downloads](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=AEM*+SDK*&amp;1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;order.sort=desc&amp;layout=list&amp;list p.offset=0&amp;p.limit=1) med din Adobe ID
   + Din Adobe-organisation __måste__ etableras för att AEM as a Cloud Service ska kunna hämta AEM as a Cloud Service SDK
1. Klicka på den senaste __AEM SDK__-resultatraden för hämtning

## Extrahera Dispatcher Tools från AEM SDK zip

>[!TIP]
>
> Windows-användare får inte ha blanksteg eller specialtecken i sökvägen till den mapp som innehåller de lokala Dispatcher-verktygen. Om det finns blanksteg i sökvägen misslyckas `docker_run.cmd`.

Dispatcher Tools är en annan version än AEM SDK. Kontrollera att den version av Dispatcher Tools som finns i den version av AEM SDK som överensstämmer med AEM as a Cloud Service.

1. Zippa upp den hämtade `aem-sdk-xxx.zip`-filen
1. Packa upp Dispatcher Tools i `~/aem-sdk/dispatcher`

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ chmod a+x aem-sdk-dispatcher-tools-x.x.x-unix.sh
$ ./aem-sdk-dispatcher-tools-x.x.x-unix.sh
```

>[!TAB Windows]

Zippa upp `aem-sdk-dispatcher-tools-x.x.x-windows.zip` i `C:\Users\<My User>\aem-sdk\dispatcher` (skapar saknade mappar efter behov).

>[!TAB Linux®]

```shell
$ chmod a+x aem-sdk-dispatcher-tools-x.x.x-unix.sh
$ ./aem-sdk-dispatcher-tools-x.x.x-unix.sh
```

>[!ENDTABS]

Alla kommandon som anges nedan förutsätter att den aktuella arbetskatalogen innehåller det expanderande Dispatcher Tools-innehållet.

>[!VIDEO](https://video.tv.adobe.com/v/30601?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat.*

## Förstå Dispatcher konfigurationsfiler

>[!TIP]
> Experience Manager-projekt som skapats från [AEM Project Maven Archetype](https://github.com/adobe/aem-project-archetype) är förifyllda den här uppsättningen Dispatcher-konfigurationsfiler, och du behöver därför inte kopiera över dem från Dispatcher Tools Src-mappen.

Dispatcher Tools innehåller en uppsättning konfigurationsfiler för Apache HTTP Web Server och Dispatcher som definierar beteendet för alla miljöer, inklusive lokal utveckling.

Dessa filer är avsedda att kopieras till ett Experience Manager Maven-projekt till mappen `dispatcher/src`, om de inte finns i Experience Manager Maven-projektet.

En fullständig beskrivning av konfigurationsfilerna finns i de opackade Dispatcher-verktygen som `dispatcher-sdk-x.x.x/docs/Config.html`.

## Validera konfigurationer

Dispatcher- och Apache-webbserverkonfigurationerna (via `httpd -t`) kan valideras med skriptet `validate` (ska inte blandas ihop med den körbara filen `validator`). Skriptet `validate` är ett praktiskt sätt att köra [ tre faser ](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/validation-debug.html?lang=en) i `validator`.


>[!BEGINTABS]

>[!TAB macOS]

```shell
$ ./bin/validate.sh ./src
```

>[!TAB Windows]

```shell
$ bin\validate src
```

>[!TAB Linux®]

```shell
$ ./bin/validate.sh ./src
```

>[!ENDTABS]

## Kör Dispatcher lokalt

AEM Dispatcher körs lokalt med Docker mot konfigurationsfilerna för `src` Dispatcher- och Apache-webbservrar.


>[!BEGINTABS]

>[!TAB macOS]

```shell
$ ./bin/docker_run_hot_reload.sh <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>
```

Den körbara filen `docker_run_hot_reload` är att föredra framför `docker_run` eftersom den läser in konfigurationsfiler igen när de ändras, utan att behöva avsluta och starta om `docker_run` manuellt. Du kan också använda `docker_run`, men det kräver att `docker_run` avslutas manuellt och startas om när konfigurationsfiler ändras.

>[!TAB Windows]

```shell
$ bin\docker_run <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>
```

>[!TAB Linux®]

```shell
$ ./bin/docker_run_hot_reload.sh <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>
```

Den körbara filen `docker_run_hot_reload` är att föredra framför `docker_run` eftersom den läser in konfigurationsfiler igen när de ändras, utan att behöva avsluta och starta om `docker_run` manuellt. Du kan också använda `docker_run`, men det kräver att `docker_run` avslutas manuellt och startas om när konfigurationsfiler ändras.

>[!ENDTABS]

`<aem-publish-host>` kan anges till `host.docker.internal`. En speciell DNS-namnDocker tillhandahåller i behållaren som matchar värddatorns IP-adress. Om `host.docker.internal` inte kan lösas kan du läsa avsnittet [felsökning](#troubleshooting-host-docker-internal) nedan.

Du kan till exempel starta Dispatcher Docker-behållaren med standardkonfigurationsfilerna som finns i Dispatcher-verktygen:

Starta Dispatcher Docker-behållaren och ange sökvägen till Dispatcher konfigurationsmapp:

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ ./bin/docker_run_hot_reload.sh ./src host.docker.internal:4503 8080
```

>[!TAB Windows]

```shell
$ bin\docker_run src host.docker.internal:4503 8080
```

>[!TAB Linux®]

```shell
$ ./bin/docker_run_hot_reload.sh ./src host.docker.internal:4503 8080
```

>[!ENDTABS]

Publiceringstjänsten för AEM as a Cloud Service SDK, som körs lokalt på port 4503, är tillgänglig via Dispatcher på `http://localhost:8080`.

Om du vill köra Dispatcher-verktyg mot ett Experience Manager-projekts Dispatcher-konfiguration pekar du på projektets `dispatcher/src`-mapp.

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ ./bin/docker_run_hot_reload.sh ~/code/my-project/dispatcher/src host.docker.internal:4503 8080
```

>[!TAB Windows]

```shell
$ bin\docker_run <User Directory>/code/my-project/dispatcher/src host.docker.internal:4503 8080
```

>[!TAB Linux®]

```shell
$ ./bin/docker_run_hot_reload.sh ~/code/my-project/dispatcher/src host.docker.internal:4503 8080
```

>[!ENDTABS]


## Dispatcher Tools-loggar

Dispatcher loggar är användbara vid lokal utveckling för att förstå om och varför HTTP-begäranden blockeras. Loggnivån kan anges genom att köra `docker_run` med miljöparametrar som prefix.

Loggar för Dispatcher-verktyg skickas till standard-out när `docker_run` körs.

Användbara parametrar för felsökning av Dispatcher är:

+ `DISP_LOG_LEVEL=Debug` ställer in Dispatcher modulinloggning på Felsökningsnivå
   + Standardvärdet är: `Warn`
+ `REWRITE_LOG_LEVEL=Debug` anger Apache HTTP Web Server Rewrite Module-loggning till Felsökningsnivå
   + Standardvärdet är: `Warn`
+ `DISP_RUN_MODE` anger körningsläget för Dispatcher-miljön och läser in motsvarande Dispatcher-konfigurationsfiler för körningslägen.
   + Standardvärdet är `dev`
+ Giltiga värden: `dev`, `stage` eller `prod`

En eller flera parametrar kan skickas till `docker_run`

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ DISP_LOG_LEVEL=Debug REWRITE_LOG_LEVEL=Debug ./bin/docker_run_hot_reload.sh ~/code/my-project/dispatcher/src host.docker.internal:4503 8080
```

>[!TAB Windows]

```shell
$ DISP_LOG_LEVEL=Debug REWRITE_LOG_LEVEL=Debug bin\docker_run <User Directory>/code/my-project/dispatcher/src host.docker.internal:4503 8080
```

>[!TAB Linux®]

```shell
$ DISP_LOG_LEVEL=Debug REWRITE_LOG_LEVEL=Debug ./bin/docker_run_hot_reload.sh ~/code/my-project/dispatcher/src host.docker.internal:4503 8080
```

>[!ENDTABS]

### Loggfilsåtkomst

Webbservern Apache och loggarna för AEM Dispatcher kan nås direkt i Docker-behållaren:

+ [Åtkomst till loggar i Docker-behållaren](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-access-logs)
+ [Kopiera Docker-loggarna till det lokala filsystemet](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-copy-logs)

## När Dispatcher Tools ska uppdateras{#dispatcher-tools-version}

Dispatcher Tools-versionerna ökar inte lika ofta som Experience Manager och därför kräver Dispatcher Tools färre uppdateringar i den lokala utvecklingsmiljön.

Den rekommenderade Dispatcher Tools-versionen är den som medföljer AEM as a Cloud Service SDK som överensstämmer med Experience Manager as a Cloud Service-versionen. Versionen av AEM as a Cloud Service finns via [Cloud Manager](https://my.cloudmanager.adobe.com/).

+ __Cloud Manager > Miljöer__, per miljö som anges av etiketten __AEM Release__

![Experience Manager-version](./assets/dispatcher-tools/aem-version.png)

*Observera att Dispatcher Tools-versionen inte matchar Experience Manager-versionen.*

## Så här uppdaterar du baslinjeuppsättningen med Apache- och Dispatcher-konfigurationer

Baslinjeuppsättningen av Apache och Dispatcher förbättras regelbundet och släpps med AEM as a Cloud Service SDK-versionen. Det är en god vana att inkludera förbättringarna av baslinjekonfigurationen i ditt AEM-projekt och undvika [lokal validering](#validate-configurations) och Cloud Manager-pipeline-fel. Uppdatera dem med skriptet `update_maven.sh` från mappen `.../dispatcher-sdk-x.x.x/bin`.

>[!VIDEO](https://video.tv.adobe.com/v/3416744?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat.*


Vi antar att du tidigare har skapat ett AEM-projekt med [AEM Project Archetype](https://github.com/adobe/aem-project-archetype). Baslinjen var Apache och Dispatcher konfigurationer aktuella. Med hjälp av dessa baslinjekonfigurationer skapades dina projektspecifika konfigurationer genom att återanvända och kopiera filer som `*.vhost`, `*.conf`, `*.farm` och `*.any` från mapparna `dispatcher/src/conf.d` och `dispatcher/src/conf.dispatcher.d`. Din lokala Dispatcher-validering och Cloud Manager-rörledningar fungerade bra.

Samtidigt har Apache- och Dispatcher-konfigurationerna förbättrats av olika skäl, till exempel nya funktioner, säkerhetskorrigeringar och optimering. De släpps via en nyare version av Dispatcher Tools som en del av AEM as a Cloud Service.

När du validerar dina projektspecifika Dispatcher-konfigurationer mot den senaste Dispatcher Tools-versionen börjar de nu misslyckas. För att lösa detta måste baslinjekonfigurationerna uppdateras genom att följa stegen nedan:

+ Verifiera att valideringen misslyckas mot den senaste Dispatcher Tools-versionen

  ```shell
  $ ./bin/validate.sh ${YOUR-AEM-PROJECT}/dispatcher/src
  
  ...
  Phase 3: Immutability check
  empty mode param, assuming mode = 'check'
  ...
  ** error: immutable file 'conf.d/available_vhosts/default.vhost' has been changed!
  ```

+ Uppdatera de oföränderliga filerna med skriptet `update_maven.sh`

  ```shell
  $ ./bin/update_maven.sh ${YOUR-AEM-PROJECT}/dispatcher/src
  
  ...
  Updating dispatcher configuration at folder 
  running in 'extract' mode
  running in 'extract' mode
  reading immutable file list from /etc/httpd/immutable.files.txt
  preparing 'conf.d/available_vhosts/default.vhost' immutable file extraction
  ...
  immutable files extraction COMPLETE
  fd72f4521fa838daaaf006bb8c9c96ed33a142a2d63cc963ba4cc3dd228948fe
  Cloud manager validator 2.0.53
  ```

+ Verifiera de uppdaterade oföränderliga filerna som `dispatcher_vhost.conf`, `default.vhost` och `default.farm` och gör vid behov relevanta ändringar i dina anpassade filer som härleds från dessa filer.

+ Verifiera konfigurationen på nytt, det bör gå

```shell
$ ./bin/validate.sh ${YOUR-AEM-PROJECT}/dispatcher/src

...
checking 'conf.dispatcher.d/renders/default_renders.any' immutability (if present)
checking existing 'conf.dispatcher.d/renders/default_renders.any' for changes
checking 'conf.dispatcher.d/virtualhosts/default_virtualhosts.any' immutability (if present)
checking existing 'conf.dispatcher.d/virtualhosts/default_virtualhosts.any' for changes
no immutable file has been changed - check is SUCCESSFUL
Phase 3 finished
```

+ Efter lokal verifiering av ändringar implementerar du de uppdaterade konfigurationsfilerna

## Felsökning

### docker_run resulterar i meddelandet&quot;Väntar tills host.docker.internal är tillgänglig&quot;{#troubleshooting-host-docker-internal}

`host.docker.internal` är ett värdnamn som anges för Docker-behållaren som löses till värden. Per docs.docker.com ([macOS](https://docs.docker.com/desktop/networking/), [Windows](https://docs.docker.com/desktop/networking/)):

> Från och med Docker 18.03 rekommenderar vi att du ansluter till det särskilda DNS-namnet host.docker.internal, som matchar den interna IP-adressen som används av värden

När `bin/docker_run src host.docker.internal:4503 8080` resulterar i meddelandet __Väntar tills host.docker.internal är tillgänglig__:

1. Kontrollera att den installerade versionen av Docker är 18.03 eller senare
1. Du kan ha konfigurerat en lokal dator som förhindrar registrering/upplösning av namnet `host.docker.internal`. Använd i stället din lokala IP-adress.

>[!BEGINTABS]

>[!TAB macOS]

+ Kör `ifconfig` från Terminal och spela in IP-adressen för värddatorn __inet__, vanligtvis __en0__-enheten.
+ Kör sedan `docker_run` med IP-värdadressen: `$ bin/docker_run_hot_reload.sh src <HOST IP>:4503 8080`

>[!TAB Windows]

+ Kör `ipconfig` från kommandotolken och registrera värddatorns __IPv4-adress__.
+ Kör sedan `docker_run` med följande IP-adress: `$ bin\docker_run src <HOST IP>:4503 8080`

>[!TAB Linux®]

+ Kör `ifconfig` från Terminal och spela in IP-adressen för värddatorn __inet__, vanligtvis __en0__-enheten.
+ Kör sedan `docker_run` med IP-värdadressen: `$ bin/docker_run_hot_reload.sh src <HOST IP>:4503 8080`

>[!ENDTABS]

#### Exempel på fel

```shell
$ docker_run src host.docker.internal:4503 8080

Running script /docker_entrypoint.d/10-check-environment.sh
Running script /docker_entrypoint.d/20-create-docroots.sh
Running script /docker_entrypoint.d/30-wait-for-backend.sh
Waiting until host.docker.internal is available
```

## Ytterligare resurser

+ [Hämta AEM SDK](https://experience.adobe.com/#/downloads)
+ [Adobe Cloud Manager](https://my.cloudmanager.adobe.com/)
+ [Hämta Docker](https://www.docker.com/)
+ [Hämta AEM referenswebbplats (WKND)](https://github.com/adobe/aem-guides-wknd/releases)
+ [Experience Manager Dispatcher Documentation](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/dispatcher.html)
