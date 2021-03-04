---
title: Konfigurera en lokal utvecklingsmiljö för utbyggbarhet i Asset compute
description: För att kunna utveckla Asset compute-arbetare, som är Node.js JavaScript-program, krävs särskilda utvecklingsverktyg som skiljer sig från traditionell AEM, från Node.js och olika npm-moduler till Docker Desktop och Microsoft Visual Studio Code.
feature: asset compute Microservices
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6266
thumbnail: KT-6266.jpg
topic: Integrering, utveckling
role: Developer
level: Mellan, erfaren
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '498'
ht-degree: 0%

---


# Konfigurera lokal utvecklingsmiljö

Projekt i Adobe Asset compute kan inte integreras med den lokala AEM som AEM SDK tillhandahåller och utvecklas med sin egen verktygskedja, som skiljer sig från den som krävs för AEM program som baseras på AEM Maven-projekttyp.

Följande verktyg måste vara installerade på den lokala utvecklingsdatorn för att du ska kunna utöka Asset compute-mikrotjänsterna.

## Instruktioner för tillagd konfiguration

Här följer en instruktion för att konfigurera en förkortning. Information om dessa utvecklingsverktyg beskrivs i separata avsnitt nedan.

1. [Installera Docker ](https://www.docker.com/products/docker-desktop) Desktop och hämta de Docker-bilder som behövs:

   ```
   $ docker pull openwhisk/action-nodejs-v12:latest
   $ docker pull adobeapiplatform/adobe-action-nodejs-v12:latest
   ```

1. [Installera Visual Studio Code](https://code.visualstudio.com/download)
1. [Installera Node.js 10+](../../local-development-environment/development-tools.md#node-js)
1. Installera nödvändiga npm-moduler och Adobe I/O CLI-plugin-program från kommandoraden:

   ```
   $ npm i -g @adobe/aio-cli @openwhisk/wskdebug ngrok --unsafe-perm=true \
   && aio plugins:install @adobe/aio-cli-plugin-asset-compute
   ```

Mer information om de förkortade installationsanvisningarna finns i avsnitten nedan.

## Installera Visual Studio-kod{#vscode}

[Microsoft Visual Studio ](https://code.visualstudio.com/download) Codeis används för att utveckla och felsöka Asset compute. Medan annan [JavaScript-kompatibel IDE](../../local-development-environment/development-tools.md#set-up-the-development-ide) kan användas för att utveckla arbetaren, kan endast Visual Studio Code integreras med [debug](../test-debug/debug.md) Asset compute worker.

_Visual Studio Code 1.48.x+ krävs för att  [](#wskdebug) wskdebugto ska fungera._

I den här självstudiekursen antas att Visual Studio Code används som den bästa utvecklarupplevelsen för att utöka Asset compute.

## Installera Docker Desktop{#docker}

Hämta och installera den senaste, stabila [Docker Desktop](https://www.docker.com/products/docker-desktop) eftersom detta krävs för att [testa](../test-debug/test.md) och [felsöka](../test-debug/debug.md) Asset compute-projekt lokalt.

När du har installerat Docker Desktop startar du programmet och installerar följande Docker-bilder från kommandoraden:

```
$ docker pull openwhisk/action-nodejs-v12:latest
$ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
```

Utvecklare på Windows-datorer bör kontrollera att de använder Linux-behållare för bilderna ovan. Stegen för att växla till Linux-behållare beskrivs i [Docker för Windows-dokumentationen](https://docs.docker.com/docker-for-windows/).

## Installera Node.js (och npm){#node-js}

asset compute är [Node.js](https://nodejs.org/)-baserade, och därför måste Node.js 10+ (och npm) utvecklas och byggas.

+ [Installera Node.js (och npm)](../../local-development-environment/development-tools.md#node-js) på samma sätt som för traditionell AEM.

## Installera Adobe I/O CLI{#aio}

[Installera Adobe I/O CLI](../../local-development-environment/development-tools.md#aio-cli), eller  ____ aiois an command-line (CLI) npm module, som underlättar användning av och interaktion med Adobe I/O, och som används både för att generera och lokalt utveckla skräddarsydda Asset compute-arbetare.

```
$ npm install -g @adobe/aio-cli
```

## Installera plugin-programmet Adobe I/O CLI Asset compute{#aio-asset-compute}

Insticksprogrammet [Adobe I/O CLI Asset compute](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Installera wskdebug{#wskdebug}

Ladda ned och installera [Apache OpenWhisk-felsökning](https://www.npmjs.com/package/@openwhisk/wskdebug) npm-modulen för att underlätta lokal felsökning av Asset compute.

_Visual Studio Code 1.48.x+ krävs för att  [](#wskdebug) wskdebugto ska fungera._

```
$ npm install -g @openwhisk/wskdebug
```

## Installera grupp{#ngrok}

Hämta och installera [ngrok](https://www.npmjs.com/package/ngrok) npm-modulen, som ger allmän tillgång till din lokala utvecklingsdator, för att underlätta lokal felsökning av Asset compute.

```
$ npm install -g ngrok --unsafe-perm=true
```
