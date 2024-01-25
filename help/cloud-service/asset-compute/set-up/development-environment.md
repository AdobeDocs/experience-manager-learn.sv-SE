---
title: Konfigurera en lokal utvecklingsmiljö för utbyggbarhet i Asset compute
description: För att kunna utveckla Asset compute-arbetare, som är Node.js JavaScript-program, krävs särskilda utvecklingsverktyg som skiljer sig från traditionell AEM, från Node.js och olika npm-moduler till Docker Desktop och Microsoft Visual Studio Code.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-6266
thumbnail: KT-6266.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 162e10e5-fcb0-4f16-b6d1-b951826209d9
duration: 111
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '459'
ht-degree: 0%

---

# Konfigurera lokal utvecklingsmiljö

Projekt i Adobe Asset compute kan inte integreras med den lokala AEM som AEM SDK tillhandahåller och utvecklas med sin egen verktygskedja, som skiljer sig från den som krävs för AEM program som baseras på AEM Maven-projekttyp.

Följande verktyg måste vara installerade på den lokala utvecklingsdatorn för att du ska kunna utöka Asset compute-mikrotjänsterna.

## Instruktioner för tillagd konfiguration

Här följer en instruktion för att konfigurera en förkortning. Information om dessa utvecklingsverktyg beskrivs i separata avsnitt nedan.

1. [Installera Docker Desktop](https://www.docker.com/products/docker-desktop) och hämta de Docker-bilder som behövs:

   ```
   $ docker pull openwhisk/action-nodejs-v12:latest
   $ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
   ```

1. [Installera Visual Studio Code](https://code.visualstudio.com/download)
1. [Installera Node.js 10+](../../local-development-environment/development-tools.md#node-js)
1. Installera nödvändiga npm-moduler och Adobe I/O CLI-plugin-program från kommandoraden:

   ```
   $ npm i -g @adobe/aio-cli @openwhisk/wskdebug ngrok --unsafe-perm=true \
   && aio plugins:install @adobe/aio-cli-plugin-asset-compute
   ```

Mer information om de förkortade installationsanvisningarna finns i avsnitten nedan.

## Installera Visual Studio Code{#vscode}

[Microsoft Visual Studio Code](https://code.visualstudio.com/download) används för att utveckla och felsöka Asset compute. Med annan [JavaScript-kompatibel IDE](../../local-development-environment/development-tools.md#set-up-the-development-ide) kan användas för att utveckla arbetaren, endast Visual Studio Code kan integreras i [debug](../test-debug/debug.md) Asset compute-arbetare.

I den här självstudiekursen antas att Visual Studio Code används som den bästa utvecklarupplevelsen för att utöka Asset compute.

## Installera Docker Desktop{#docker}

Ladda ned och installera den senaste, stabila [Docker Desktop](https://www.docker.com/products/docker-desktop), eftersom detta krävs för att [test](../test-debug/test.md) och [debug](../test-debug/debug.md) Asset compute projekt lokalt.

När du har installerat Docker Desktop startar du programmet och installerar följande Docker-bilder från kommandoraden:

```
$ docker pull openwhisk/action-nodejs-v12:latest
$ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
```

Utvecklare på Windows-datorer bör kontrollera att de använder Linux-behållare för bilderna ovan. Stegen för att växla till Linux-behållare beskrivs i [Dokumentation för Docker for Windows](https://docs.docker.com/docker-for-windows/).

## Installera Node.js (och npm){#node-js}

Asset compute arbetare är [Node.js](https://nodejs.org/)-baserat och därför krävs Node.js 10+ (och npm) för att utveckla och bygga.

+ [Installera Node.js (och npm)](../../local-development-environment/development-tools.md#node-js) på samma sätt som för traditionell AEM.

## Installera Adobe I/O CLI{#aio}

[Installera Adobe I/O CLI](../../local-development-environment/development-tools.md#aio-cli), eller __aio__ är en kommandoradsmodul (CLI) npm som underlättar användningen av och interaktionen med Adobe I/O och som används både för att generera och lokalt utveckla anpassade Asset compute-arbetare.

```
$ npm install -g @adobe/aio-cli
```

## Installera plugin-programmet Adobe I/O CLI Asset compute{#aio-asset-compute}

The [Adobe I/O CLI Asset compute plugin](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Installera wskdebug{#wskdebug}

Hämta och installera [Apache OpenWhisk-felsökning](https://www.npmjs.com/package/@openwhisk/wskdebug) npm-modul för att underlätta lokal felsökning av Asset compute.

_Visual Studio Code 1.48.x+ krävs för [wskdebug](#wskdebug) till jobbet._

```
$ npm install -g @openwhisk/wskdebug
```

## Installera anteckning{#ngrok}

Hämta och installera [ngrok](https://www.npmjs.com/package/ngrok) npm-modulen, som ger allmänheten tillgång till din lokala utvecklingsmaskin, för att underlätta lokal felsökning av Asset compute.

```
$ npm install -g ngrok --unsafe-perm=true
```
