---
title: Konfigurera en lokal utvecklingsmiljö för resursberäkningens utbyggbarhet
description: För att kunna utveckla Asset Compute-arbetare, som är Node.js JavaScript-program, krävs särskilda utvecklingsverktyg som skiljer sig från traditionell AEM, från Node.js och olika npm-moduler till Docker Desktop och Microsoft Visual Studio Code.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6266
thumbnail: KT-6266.jpg
translation-type: tm+mt
source-git-commit: 53e4235c55d890765e9f13ffeb37a2c805fb307b
workflow-type: tm+mt
source-wordcount: '478'
ht-degree: 0%

---


# Konfigurera lokal utvecklingsmiljö

Adobe Asset Compute-applikationer kan inte integreras med den lokala AEM-miljön från AEM SDK och utvecklas med en egen verktygskedja, som är skild från den som krävs för AEM applikationer som baseras på AEM Maven-projekttyp.

För att utöka mikrotjänsterna för tillgångsberäkning måste följande verktyg vara installerade på den lokala utvecklingsdatorn.

## Instruktioner för tillagd konfiguration

Här följer en instruktion för att konfigurera en förkortning. Information om dessa utvecklingsverktyg beskrivs i separata avsnitt nedan.

1. [Installera Docker Desktop](https://www.docker.com/products/docker-desktop) och hämta de dockningsbilder som behövs:

   ```
   $ docker pull openwhisk/action-nodejs-v10:latest
   $ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
   ```

1. [Installera Visual Studio Code](https://code.visualstudio.com/download)
1. [Installera Node.js 10+](../../local-development-environment/development-tools.md#node-js)
1. Installera nödvändiga npm-moduler och Adobe I/O CLI-plugin-program från kommandoraden:

   ```
   $ npm i -g @adobe/aio-cli @openwhisk/wskdebug ngrok --unsafe-perm=true \
   && aio plugins:install @adobe/aio-cli-plugin-asset-compute
   ```

## Installera Visual Studio Code{#vscode}

[Microsoft Visual Studio Code](https://code.visualstudio.com/download) används för utveckling och felsökning av program för beräkning av tillgångar. Även om annan [JavaScript-kompatibel IDE](../../local-development-environment/development-tools.md#set-up-the-development-ide) kan användas för att utveckla programmet kan bara Visual Studio Code integreras för att [felsöka](../test-debug/debug.md) applikationer för tillgångsberäkning.

_Visual Studio Code 1.48.x+ krävs för att[wskdebug](#wskdebug)ska fungera._

I den här självstudiekursen antas användningen av Visual Studio Code som den ger den bästa utvecklarupplevelsen när det gäller att utöka Assets Compute.

## Installera Docker Desktop{#docker}

Ladda ned och installera de senaste stabila [Docker Desktop](https://www.docker.com/products/docker-desktop)eftersom detta krävs för att [testa](../test-debug/test.md) och [felsöka](../test-debug/debug.md) resursberäkningsprojekt lokalt.

När du har installerat Docker Desktop startar du programmet och installerar följande Docker-bilder från kommandoraden:

```
$ docker pull openwhisk/action-nodejs-v10:latest
$ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
```

Utvecklare på Windows-datorer bör kontrollera att de använder Linux-behållare för bilderna ovan. Stegen för att växla till Linux-behållare beskrivs i dokumentationen [för](https://docs.docker.com/docker-for-windows/)Docker för Windows.

## Installera Node.js (och npm){#node-js}

Resursberäkningspersonal är [Node.js](https://nodejs.org/) -program, och därför krävs Node.js 10+ (och npm) för att utveckla och bygga.

+ [Installera Node.js (och npm)](../../local-development-environment/development-tools.md#node-js) på samma sätt som för traditionell AEM.

## Installera Adobe I/O CLI{#aio}

[Installera Adobe I/O CLI](../../local-development-environment/development-tools.md#aio-cli), eller __aio__ är en kommandoradsmodul (CLI) npm som underlättar användning av och interaktion med Adobe I/O-tekniker, och som används både för att generera och lokalt utveckla anpassade resurser för att beräkna arbetare.

```
$ npm install -g @adobe/aio-cli
```

## Installera plugin-programmet Adobe I/O CLI Asset Compute{#aio-asset-compute}

Plugin-programmet [Adobe I/O CLI Asset Compute](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Installera wskdebug{#wskdebug}

Ladda ned och installera [Apache OpenWhisk-felsökningsmodulen](https://www.npmjs.com/package/@openwhisk/wskdebug) npm för att underlätta lokal felsökning av program för tillgångsberäkning.

_Visual Studio Code 1.48.x+ krävs för att[wskdebug](#wskdebug)ska fungera._

```
$ npm install -g @openwhisk/wskdebug
```

## Installera anteckning{#ngrok}

Hämta och installera modulen [nGroup](https://www.npmjs.com/package/ngrok) NPM, som ger allmänheten tillgång till din lokala utvecklingsdator, för att underlätta lokal felsökning av program för beräkning av tillgångar.

```
$ npm install -g ngrok --unsafe-perm=true
```
