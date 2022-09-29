---
title: Ställ in Dispatcher Tools för AEM as a Cloud Service Development
description: AEM SDKs Dispatcher Tools underlättar den lokala utvecklingen av Adobe Experience Manager-projekt (AEM) genom att göra det enkelt att installera, köra och felsöka Dispatcher lokalt.
version: Cloud Service
topic: Development
feature: Dispatcher, Developer Tools
role: Developer
level: Beginner
kt: 4679
thumbnail: 30603.jpg
exl-id: 9320e07f-be5c-42dc-a4e3-aab80089c8f7
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '1340'
ht-degree: 1%

---

# Konfigurera lokala Dispatcher-verktyg {#set-up-local-dispatcher-tools}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_dispatcher"
>title="Local Dispatcher Tools"
>abstract="Dispatcher är en viktig del av den övergripande Experience Manager-arkitekturen och bör ingå i den lokala utvecklingsmiljön. Den AEM as a Cloud Service SDK-versionen innehåller den rekommenderade versionen av Dispatcher Tools som gör det lättare att konfigurera, validera och simulera Dispatcher lokalt."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/content-delivery/disp-overview.html" text="Dispatcher i molnet"
>additional-url="https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html" text="Hämta AEM as a Cloud Service SDK"

Adobe Experience Manager (AEM) Dispatcher är en Apache HTTP-webbservermodul som tillhandahåller ett säkerhets- och prestandalager mellan CDN- och AEM-publiceringsnivån. Dispatcher är en viktig del av den övergripande Experience Manager-arkitekturen och bör ingå i den lokala utvecklingsmiljön.

Den AEM as a Cloud Service SDK-versionen innehåller den rekommenderade versionen av Dispatcher Tools som gör det lättare att konfigurera, validera och simulera Dispatcher lokalt. Dispatcher Tools består av:

+ en basuppsättning med konfigurationsfiler för Apache HTTP-webbserver och Dispatcher som finns i `.../dispatcher-sdk-x.x.x/src`
+ en konfigurationsvaliderare för CLI-verktyg, som finns på `.../dispatcher-sdk-x.x.x/bin/validate`
+ ett CLI-verktyg för konfigurationsgenerering som finns på `.../dispatcher-sdk-x.x.x/bin/validator`
+ ett CLI-verktyg för konfigurationsdistribution, som finns på `.../dispatcher-sdk-x.x.x/bin/docker_run`
+ en Docker-bild som kör Apache HTTP Web Server med modulen Dispatcher

Observera att `~` används som kortskrift för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`.

>[!NOTE]
>
> Videorna på den här sidan spelades in på macOS. Windows-användare kan följa med, men använda motsvarande Dispatcher Tools Windows-kommandon som finns i varje video.

## Förutsättningar

1. Windows-användare måste använda Windows 10 Professional (eller en version som stöder Docker)
1. Installera [Experience Manager Publish Quickstart JAR](./aem-runtime.md) på den lokala framkallningsmaskinen.
   + Du kan också installera den senaste [AEM webbplats](https://github.com/adobe/aem-guides-wknd/releases) på den lokala AEM Publish-tjänsten. Den här webbplatsen används i den här självstudiekursen för att visualisera en fungerande Dispatcher.
1. Installera och starta den senaste versionen av [Docker](https://www.docker.com/) (Docker Desktop 2.2.0.5+ / Docker Engine v19.03.9+) på den lokala utvecklingsdatorn.

## Ladda ned Dispatcher Tools (som en del av AEM SDK)

Den AEM as a Cloud Service SDK, eller AEM SDK, innehåller Dispatcher-verktygen som används för att köra Apache HTTP-webbservern med Dispatcher-modulen lokalt för utveckling, liksom den kompatibla QuickStart Jar.

Om AEM as a Cloud Service SDK redan har hämtats till [konfigurera lokal AEM](./aem-runtime.md)behöver den inte laddas ned igen.

1. Logga in på [experience.adobe.com/#/downloads](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=AEM*+SDK*&amp;1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;order.sort=desc&amp;layout=list&amp;list p.offset=0&amp;p.limit=1) med din Adobe ID
   + Din Adobe-organisation __måste__ etableras för AEM as a Cloud Service för att hämta AEM as a Cloud Service SDK
1. Klicka på den senaste __AEM SDK__ resultatrad som ska hämtas

## Extrahera Dispatcher-verktygen från AEM SDK

>[!TIP]
>
> Windows-användare kan inte ha blanksteg eller specialtecken i sökvägen till mappen som innehåller Lokala Dispatcher-verktyg. Om det finns blanksteg i sökvägen `docker_run.cmd` kommer att misslyckas.

Versionen av Dispatcher Tools skiljer sig från AEM SDK. Kontrollera att versionen av Dispatcher Tools finns i den AEM SDK-version som matchar den AEM as a Cloud Service versionen.

1. Zippa upp det nedladdade `aem-sdk-xxx.zip` fil
1. Packa upp Dispatcher-verktygen i `~/aem-sdk/dispatcher`
   + Windows: Zippa upp `aem-sdk-dispatcher-tools-x.x.x-windows.zip` till `C:\Users\<My User>\aem-sdk\dispatcher` (skapar saknade mappar efter behov)
   + macOS/Linux: Kör det medföljande gränssnittsskriptet `aem-sdk-dispatcher-tools-x.x.x-unix.sh` för att packa upp Dispatcher-verktygen
      + `chmod a+x aem-sdk-dispatcher-tools-x.x.x-unix.sh && ./aem-sdk-dispatcher-tools-x.x.x-unix.sh`

Observera att alla kommandon som anges nedan förutsätter att den aktuella arbetskatalogen innehåller det expanderande Dispatcher-verktygsinnehållet.

>[!VIDEO](https://video.tv.adobe.com/v/30601/?quality=12&learn=on)

*I den här videon används macOS för illustrativa ändamål. Motsvarande Windows/Linux-kommandon kan användas för att uppnå liknande resultat*

## Förstå Dispatcher-konfigurationsfilerna

>[!TIP]
> Experience Manager-projekt skapade från [AEM Project Maven Archetype](https://github.com/adobe/aem-project-archetype) är förifyllda i den här uppsättningen Dispatcher-konfigurationsfiler, så du behöver inte kopiera över från Src-mappen Dispatcher Tools.

Dispatcher Tools innehåller en uppsättning konfigurationsfiler för Apache HTTP Web Server och Dispatcher som definierar beteendet för alla miljöer, inklusive lokal utveckling.

Filerna ska kopieras till ett Experience Manager Maven-projekt till `dispatcher/src` om de inte redan finns i Experience Manager Maven-projektet.

En fullständig beskrivning av konfigurationsfilerna finns i de opackade Dispatcher-verktygen som `dispatcher-sdk-x.x.x/docs/Config.html`.

## Validera konfigurationer

Alternativt kan du konfigurera webbservern Dispatcher och Apache (via `httpd -t`) kan valideras med `validate` skript (ska inte blandas ihop med `validator` körbar). The `validate` -skript är ett bekvämt sätt att köra [3 faser](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/content-delivery/validation-debug.html?lang=en#local-validation-flexible-mode) i `validator`.

+ Användning:
   + Windows: `bin\validate src`
   + macOS/Linux: `./bin/validate.sh ./src`

## Kör Dispatcher lokalt

AEM Dispatcher körs lokalt med Docker mot `src` Dispatcher och konfigurationsfiler för webbservern Apache.

+ Användning:
   + Windows: `bin\docker_run <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>`
   + macOS/Linux: `./bin/docker_run.sh <src-folder> <aem-publish-host>:<aem-publish-port> <dispatcher-port>`

The `<aem-publish-host>` kan anges till `host.docker.internal`, innehåller en särskild DNS-namnDocker i behållaren som matchar värddatorns IP-adress. Om han `host.docker.internal` inte går att lösa, se [felsökning](#troubleshooting-host-docker-internal) nedan.

Om du till exempel vill starta Dispatcher Docker-behållaren med de standardkonfigurationsfiler som finns i Dispatcher-verktygen:

Starta Dispatcher Docker-behållaren med sökvägen till Dispatcher-konfigurationens src-mapp:

+ Windows: `bin\docker_run src host.docker.internal:4503 8080`
+ macOS/Linux: `./bin/docker_run.sh ./src host.docker.internal:4503 8080`

Den AEM as a Cloud Service SDK:s publiceringstjänst som körs lokalt på port 4503 är tillgänglig via Dispatcher på `http://localhost:8080`.

Om du vill köra Dispatcher Tools mot Dispatcher-konfigurationen för ett Experience Manager-projekt pekar du på projektets `dispatcher/src` mapp.

+ Windows:

   ```shell
   $ bin\docker_run <User Directory>/code/my-project/dispatcher/src host.docker.internal:4503 8080
   ```

+ macOS/Linux:

   ```shell
   $ ./bin/docker_run.sh ~/code/my-project/dispatcher/src host.docker.internal:4503 8080
   ```

## Loggar för Dispatcher Tools

Distributionsloggar är användbara under lokal utveckling för att förstå om och varför HTTP-begäranden blockeras. Loggnivån kan ställas in genom att prefix körs för `docker_run` med miljöparametrar.

Loggar för utskicksverktyg skickas till standard-out när `docker_run` körs.

Användbara parametrar för felsökning av Dispatcher är:

+ `DISP_LOG_LEVEL=Debug` anger att inloggning i modulen Dispatcher ska vara felsökningsnivå
   + Standardvärdet är: `Warn`
+ `REWRITE_LOG_LEVEL=Debug` anger Apache HTTP Web server rewrite module loggning till Felsökningsnivå
   + Standardvärdet är: `Warn`
+ `DISP_RUN_MODE` anger körningsläget för Dispatcher-miljön och läser in motsvarande körningslägen Dispatcher-konfigurationsfiler.
   + Standardvärdet är `dev`
+ Giltiga värden: `dev`, `stage`, eller `prod`

En eller flera parametrar kan skickas till `docker_run`

+ Windows:

   ```shell
   $ DISP_LOG_LEVEL=Debug REWRITE_LOG_LEVEL=Debug bin\docker_run <User Directory>/code/my-project/dispatcher/src host.docker.internal:4503 8080
   ```

+ macOS/Linux:

   ```shell
   $ DISP_LOG_LEVEL=Debug REWRITE_LOG_LEVEL=Debug ./bin/docker_run.sh ~/code/my-project/dispatcher/src host.docker.internal:4503 8080
   ```

### Loggfilsåtkomst

Webbservern och AEM Dispatcher-loggarna är tillgängliga direkt i Docker-behållaren:

+ [Åtkomst till loggar i Docker-behållaren](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-access-logs)
+ [Kopiera Docker-loggarna till det lokala filsystemet](../debugging/aem-sdk-local-quickstart/logs.md#dispatcher-tools-copy-logs)

## När Dispatcher Tools ska uppdateras{#dispatcher-tools-version}

Dispatcher Tools-versionerna ökar inte lika ofta som Experience Manager och Dispatcher Tools kräver därför färre uppdateringar i den lokala utvecklingsmiljön.

Den rekommenderade versionen av Dispatcher Tools är den som medföljer AEM as a Cloud Service SDK som överensstämmer med den as a Cloud Service Experience Manager-versionen. Versionen av AEM as a Cloud Service finns via [Cloud Manager](https://my.cloudmanager.adobe.com/).

+ __Cloud Manager > Miljöer__, per miljö som anges av __AEM__ label

![Experience Manager version](./assets/dispatcher-tools/aem-version.png)

_Observera att Dispatcher Tools-versionen inte överensstämmer med Experience Manager-versionen._

## Felsökning

### docker_run resulterar i meddelandet&quot;Väntar tills host.docker.internal är tillgänglig&quot;{#troubleshooting-host-docker-internal}

`host.docker.internal` är ett värdnamn som tillhandahålls Docker-behållaren som löses till värden. Per docs.docker.com ([macOS](https://docs.docker.com/docker-for-mac/networking/#i-want-to-connect-from-a-container-to-a-service-on-the-host), [Windows](https://docs.docker.com/docker-for-windows/networking/)):

> Från och med Docker 18.03 rekommenderar vi att du ansluter till det särskilda DNS-namnet host.docker.internal, som matchar den interna IP-adressen som används av värden

Om, när `bin/docker_run src host.docker.internal:4503 8080` i meddelandet __Väntar tills host.docker.internal är tillgänglig__ och sedan:

1. Kontrollera att den installerade versionen av Docker är 18.03 eller senare
2. Det kan finnas en lokal dator som förhindrar registrering/upplösning av `host.docker.internal` namn. Använd i stället din lokala IP-adress.
   + Windows:
      + Kör från kommandotolken `ipconfig`och registrera värddatorns __IPv4-adress__ värddatorn.
      + Kör sedan `docker_run` med denna IP-adress:
         `bin\docker_run src <HOST IP>:4503 8080`
   + macOS/Linux:
      + Från Terminal, kör `ifconfig` och registrera värden __inet__ IP-adress, vanligtvis __en0__ enhet.
      + Kör sedan `docker_run` med hjälp av värdens IP-adress:
         `bin/docker_run.sh src <HOST IP>:4503 8080`

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
