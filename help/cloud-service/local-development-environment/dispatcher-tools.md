---
title: Ställ in Dispatcher Tools för AEM as a Cloud Service Development
description: AEM SDKs Dispatcher Tools underlättar den lokala utvecklingen av Adobe Experience Manager-projekt (AEM) genom att göra det enkelt att installera, köra och felsöka Dispatcher lokalt.
version: Cloud Service
topic: Development
feature: Dispatcher, Developer Tools
role: Developer
level: Beginner
jira: KT-4679
thumbnail: 30603.jpg
last-substantial-update: 2023-03-14T00:00:00Z
exl-id: 9320e07f-be5c-42dc-a4e3-aab80089c8f7
duration: 624
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1621'
ht-degree: 0%

---

# Konfigurera lokala Dispatcher-verktyg {#set-up-local-dispatcher-tools}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_dispatcher"
>title="Local Dispatcher Tools"
>abstract="Dispatcher är en viktig del av den övergripande Experience Manager-arkitekturen och bör ingå i den lokala utvecklingsmiljön. AEM as a Cloud Service SDK innehåller den rekommenderade versionen av Dispatcher Tools som gör det lättare att konfigurera validering och simulera Dispatcher lokalt."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/disp-overview.html" text="Dispatcher i molnet"
>additional-url="https://experienceleague.adobe.com/docs/experience-cloud/software-distribution/home.html" text="Hämta AEM as a Cloud Service SDK"

Adobe Experience Manager (AEM) Dispatcher är en Apache HTTP-webbservermodul som tillhandahåller ett säkerhets- och prestandalager mellan CDN- och AEM-publiceringsskiktet. Dispatcher är en viktig del av den övergripande Experience Manager-arkitekturen och bör ingå i den lokala utvecklingsmiljön.

AEM as a Cloud Service SDK innehåller den rekommenderade versionen av Dispatcher Tools som gör det lättare att konfigurera validering och simulera Dispatcher lokalt. Dispatcher Tools består av:

+ en basuppsättning med konfigurationsfiler för Apache HTTP-webbserver och Dispatcher, som finns på `.../dispatcher-sdk-x.x.x/src`
+ en konfigurationsvaliderare för CLI-verktyg, som finns på `.../dispatcher-sdk-x.x.x/bin/validate`
+ ett CLI-verktyg för konfigurationsgenerering som finns på `.../dispatcher-sdk-x.x.x/bin/validator`
+ ett CLI-verktyg för konfigurationsdistribution, som finns på `.../dispatcher-sdk-x.x.x/bin/docker_run`
+ en oföränderlig konfigurationsfil som skriver över CLI-verktyget, finns på `.../dispatcher-sdk-x.x.x/bin/update_maven`
+ en Docker-bild som kör Apache HTTP Web Server med modulen Dispatcher

Observera att `~` används som kortskrift för användarkatalogen. I Windows motsvarar detta `%HOMEPATH%`.

>[!NOTE]
>
> Videorna på den här sidan spelades in på macOS. Windows-användare kan följa med, men använda motsvarande Dispatcher Tools Windows-kommandon som finns i varje video.

## Förutsättningar

1. Windows-användare måste använda Windows 10 Professional (eller en version som stöder Docker)
1. Installera [Experience Manager Publish Quickstart JAR](./aem-runtime.md) på den lokala utvecklingsdatorn.

+ Du kan också installera den senaste [AEM webbplats](https://github.com/adobe/aem-guides-wknd/releases) på den lokala AEM. Den här webbplatsen används i den här självstudiekursen för att visualisera en fungerande Dispatcher.

1. Installera och starta den senaste versionen av [Docker](https://www.docker.com/) (Docker Desktop 2.2.0.5+ / Docker Engine v19.03.9+) på den lokala utvecklingsdatorn.

## Ladda ned Dispatcher Tools (som en del av AEM SDK)

Den AEM as a Cloud Service SDK, eller AEM SDK, innehåller Dispatcher-verktygen som används för att köra Apache HTTP-webbservern med Dispatcher-modulen lokalt för utveckling, och den kompatibla QuickStart Jar.

Om AEM as a Cloud Service SDK redan har hämtats till [konfigurera lokal AEM](./aem-runtime.md)behöver den inte laddas ned på nytt.

1. Logga in på [experience.adobe.com/#/downloads](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=AEM*+SDK*&amp;1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;order.sort=desc&amp;layout=list&amp;list p.offset=0&amp;p.limit=1) med din Adobe ID
   + Din Adobe-organisation __måste__ etableras för AEM as a Cloud Service för att ladda ned AEM as a Cloud Service SDK
1. Klicka på den senaste __AEM SDK__ resultatrad som ska hämtas

## Extrahera Dispatcher-verktygen från AEM SDK

>[!TIP]
>
> Windows-användare kan inte ha blanksteg eller specialtecken i sökvägen till mappen som innehåller Lokala Dispatcher-verktyg. Om det finns blanksteg i sökvägen `docker_run.cmd` misslyckas.

Versionen av Dispatcher Tools skiljer sig från AEM SDK. Kontrollera att versionen av Dispatcher Tools finns i den AEM SDK-version som matchar den AEM as a Cloud Service versionen.

1. Zippa upp det nedladdade `aem-sdk-xxx.zip` fil
1. Packa upp Dispatcher Tools i `~/aem-sdk/dispatcher`

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ chmod a+x aem-sdk-dispatcher-tools-x.x.x-unix.sh
$ ./aem-sdk-dispatcher-tools-x.x.x-unix.sh
```

>[!TAB Windows]

Zippa upp `aem-sdk-dispatcher-tools-x.x.x-windows.zip` till `C:\Users\<My User>\aem-sdk\dispatcher` (skapar saknade mappar efter behov).

>[!TAB Linux®]

```shell
$ chmod a+x aem-sdk-dispatcher-tools-x.x.x-unix.sh
$ ./aem-sdk-dispatcher-tools-x.x.x-unix.sh
```

>[!ENDTABS]

Alla kommandon som anges nedan förutsätter att den aktuella arbetskatalogen innehåller det expanderande Dispatcher-verktygsinnehållet.

>[!VIDEO](https://video.tv.adobe.com/v/30601?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat.*

## Förstå Dispatcher-konfigurationsfilerna

>[!TIP]
> Experience Manager-projekt skapade från [AEM Project Maven Archetype](https://github.com/adobe/aem-project-archetype) är förifyllda i den här uppsättningen Dispatcher-konfigurationsfiler, så du behöver inte kopiera över från Src-mappen Dispatcher Tools.

Dispatcher Tools innehåller en uppsättning konfigurationsfiler för Apache HTTP Web Server och Dispatcher som definierar beteendet för alla miljöer, inklusive lokal utveckling.

Filerna ska kopieras till ett Experience Manager Maven-projekt till `dispatcher/src` om de inte finns i Experience Manager Maven-projektet.

En fullständig beskrivning av konfigurationsfilerna finns i de opackade Dispatcher-verktygen som `dispatcher-sdk-x.x.x/docs/Config.html`.

## Validera konfigurationer

Alternativt kan du konfigurera webbservern Dispatcher och Apache (via `httpd -t`) kan valideras med `validate` skript (ska inte blandas ihop med `validator` körbar). The `validate` är ett praktiskt sätt att köra [tre faser](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/validation-debug.html?lang=en) i `validator`.


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

AEM Dispatcher körs lokalt med Docker mot `src` Dispatcher och konfigurationsfiler för webbservern Apache.


>[!BEGINTABS]

>[!TAB macOS]

```shell
$ ./bin/docker_run_hot_reload.sh <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>
```

The `docker_run_hot_reload` körbar fil föredras framför `docker_run` när konfigurationsfiler läses in igen när de ändras, utan att du behöver avsluta och starta om manuellt `docker_run`. Alternativt `docker_run` kan användas, men manuell avslutning och omstart krävs `docker_run` när konfigurationsfiler ändras.

>[!TAB Windows]

```shell
$ bin\docker_run <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>
```

>[!TAB Linux®]

```shell
$ ./bin/docker_run_hot_reload.sh <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>
```

The `docker_run_hot_reload` körbar fil föredras framför `docker_run` när konfigurationsfiler läses in igen när de ändras, utan att du behöver avsluta och starta om manuellt `docker_run`. Alternativt `docker_run` kan användas, men manuell avslutning och omstart krävs `docker_run` när konfigurationsfiler ändras.

>[!ENDTABS]

The `<aem-publish-host>` kan anges till `host.docker.internal`, innehåller en särskild DNS-namnDocker i behållaren som matchar värddatorns IP-adress. Om `host.docker.internal` inte går att lösa, se [felsökning](#troubleshooting-host-docker-internal) nedan.

Om du till exempel vill starta Dispatcher Docker-behållaren med de standardkonfigurationsfiler som finns i Dispatcher-verktygen:

Starta Dispatcher Docker-behållaren med sökvägen till Dispatcher-konfigurationens src-mapp:

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

Den AEM as a Cloud Service SDK:s publiceringstjänst som körs lokalt på port 4503 är tillgänglig via Dispatcher på `http://localhost:8080`.

Om du vill köra Dispatcher Tools mot Dispatcher-konfigurationen för ett Experience Manager-projekt pekar du på projektets `dispatcher/src` mapp.

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


## Loggar för Dispatcher Tools

Distributionsloggar är användbara under lokal utveckling för att förstå om och varför HTTP-begäranden blockeras. Loggnivån kan ställas in genom att prefix för körningen av `docker_run` med miljöparametrar.

Loggar för utskicksverktyg skickas till standard-out när `docker_run` är körd.

Användbara parametrar för felsökning av Dispatcher är:

+ `DISP_LOG_LEVEL=Debug` anger att inloggning i modulen Dispatcher ska vara felsökningsnivå
   + Standardvärdet är: `Warn`
+ `REWRITE_LOG_LEVEL=Debug` anger Apache HTTP Web server rewrite module loggning till Felsökningsnivå
   + Standardvärdet är: `Warn`
+ `DISP_RUN_MODE` anger körningsläget för Dispatcher-miljön och läser in motsvarande körningslägen Dispatcher-konfigurationsfiler.
   + Standardvärdet är `dev`
+ Giltiga värden: `dev`, `stage`, eller `prod`

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

Du kan komma åt Apache-webbservern och AEM Dispatcher-loggarna direkt i Docker-behållaren:

+ [Åtkomst till loggar i Docker-behållaren](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-access-logs)
+ [Kopiera Docker-loggarna till det lokala filsystemet](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-copy-logs)

## När Dispatcher Tools ska uppdateras{#dispatcher-tools-version}

Dispatcher Tools-versionerna ökar inte lika ofta som Experience Manager och Dispatcher Tools kräver därför färre uppdateringar i den lokala utvecklingsmiljön.

Den rekommenderade versionen av Dispatcher Tools är den som medföljer AEM as a Cloud Service SDK som överensstämmer med den as a Cloud Service Experience Manager-versionen. Versionen av AEM as a Cloud Service finns via [Cloud Manager](https://my.cloudmanager.adobe.com/).

+ __Cloud Manager > Miljöer__, per miljö som anges av __AEM__ label

![Experience Manager version](./assets/dispatcher-tools/aem-version.png)

*Observera att Dispatcher Tools-versionen inte överensstämmer med Experience Manager.*

## Så här uppdaterar du baslinjeuppsättningen med Apache- och Dispatcher-konfigurationer

Baslinjeuppsättningen av konfigurationen för Apache och Dispatcher förbättras regelbundet och släpps med den AEM as a Cloud Service SDK-versionen. Det är bästa sättet att införliva förbättringarna av baslinjekonfigurationen i AEM projekt och undvika [lokal validering](#validate-configurations) och fel i molnhanterarens pipeline. Uppdatera dem med `update_maven.sh` skript `.../dispatcher-sdk-x.x.x/bin` mapp.

>[!VIDEO](https://video.tv.adobe.com/v/3416744?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat.*


Låt oss anta att du tidigare har skapat ett AEM projekt med [AEM Project Archettype](https://github.com/adobe/aem-project-archetype)var de ursprungliga konfigurationerna för Apache och Dispatcher aktuella. Med hjälp av dessa baslinjekonfigurationer har dina projektspecifika konfigurationer skapats genom att återanvända och kopiera filer som `*.vhost`, `*.conf`, `*.farm` och `*.any` från `dispatcher/src/conf.d` och `dispatcher/src/conf.dispatcher.d` mappar. Din lokala Dispatcher-validering och Cloud Manager-pipelines fungerade som de ska.

Samtidigt har Apache- och Dispatcher-konfigurationerna förbättrats för baslinjen av olika skäl, till exempel nya funktioner, säkerhetskorrigeringar och optimering. De släpps via en nyare version av Dispatcher Tools som en del av den AEM as a Cloud Service versionen.

När du validerar projektspecifika Dispatcher-konfigurationer mot den senaste Dispatcher Tools-versionen börjar de nu misslyckas. För att lösa detta måste baslinjekonfigurationerna uppdateras genom att följa stegen nedan:

+ Verifiera att valideringen inte fungerar med den senaste versionen av Dispatcher Tools

  ```shell
  $ ./bin/validate.sh ${YOUR-AEM-PROJECT}/dispatcher/src
  
  ...
  Phase 3: Immutability check
  empty mode param, assuming mode = 'check'
  ...
  ** error: immutable file 'conf.d/available_vhosts/default.vhost' has been changed!
  ```

+ Uppdatera oföränderliga filer med `update_maven.sh` script

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

+ Verifiera uppdaterade oföränderliga filer som `dispatcher_vhost.conf`, `default.vhost`och `default.farm` och vid behov göra relevanta ändringar i dina anpassade filer som härleds från dessa filer.

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

The `host.docker.internal` är ett värdnamn som tillhandahålls Docker-behållaren som löses till värden. Per docs.docker.com ([macOS](https://docs.docker.com/desktop/networking/), [Windows](https://docs.docker.com/desktop/networking/)):

> Från och med Docker 18.03 rekommenderar vi att du ansluter till det särskilda DNS-namnet host.docker.internal, som matchar den interna IP-adressen som används av värden

När `bin/docker_run src host.docker.internal:4503 8080` i meddelandet __Väntar tills host.docker.internal är tillgänglig__ och sedan:

1. Kontrollera att den installerade versionen av Docker är 18.03 eller senare
1. Det kan finnas en lokal dator som förhindrar registrering/upplösning av `host.docker.internal` namn. Använd i stället din lokala IP-adress.

>[!BEGINTABS]

>[!TAB macOS]

+ Från Terminal, kör `ifconfig` och registrera värden __inet__ IP-adress, vanligtvis __en0__ enhet.
+ Kör sedan `docker_run` med hjälp av värdens IP-adress: `$ bin/docker_run_hot_reload.sh src <HOST IP>:4503 8080`

>[!TAB Windows]

+ Kör från kommandotolken `ipconfig`och registrera värddatorns __IPv4-adress__ värddatorn.
+ Kör sedan `docker_run` med denna IP-adress: `$ bin\docker_run src <HOST IP>:4503 8080`

>[!TAB Linux®]

+ Från Terminal, kör `ifconfig` och registrera värden __inet__ IP-adress, vanligtvis __en0__ enhet.
+ Kör sedan `docker_run` med hjälp av värdens IP-adress: `$ bin/docker_run_hot_reload.sh src <HOST IP>:4503 8080`

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
+ [Ladda ned Docker](https://www.docker.com/)
+ [Ladda ned AEM webbplats (WKND)](https://github.com/adobe/aem-guides-wknd/releases)
+ [Experience Manager Dispatcher-dokumentation](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/dispatcher.html)
