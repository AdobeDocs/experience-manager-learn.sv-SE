---
title: Konfigurera en lokal utvecklingsmiljö för Asset Compute-utbyggbarhet
description: För att kunna utveckla Asset Compute-arbetare, som är Node.js JavaScript-program, krävs särskilda utvecklingsverktyg som skiljer sig från traditionell AEM-utveckling, från Node.js och olika npm-moduler till Docker Desktop och Microsoft Visual Studio Code.
feature: Asset Compute Microservices
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-6266
thumbnail: KT-6266.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 162e10e5-fcb0-4f16-b6d1-b951826209d9
duration: 96
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '459'
ht-degree: 0%

---

# Konfigurera lokal utvecklingsmiljö

Adobe Asset Compute-projekt kan inte integreras med den lokala AEM-miljön som tillhandahålls av AEM SDK och utvecklas med en egen verktygskedja, som är skild från den som krävs av AEM-program som bygger på AEM Maven-projektarkitypen.

Följande verktyg måste vara installerade på den lokala utvecklingsdatorn för att du ska kunna utöka Asset Compute mikrotjänster.

## Instruktioner för tillagd konfiguration

Här följer en instruktion för att konfigurera en förkortning. Information om dessa utvecklingsverktyg beskrivs i separata avsnitt nedan.

1. [Installera Docker Desktop](https://www.docker.com/products/docker-desktop) och hämta nödvändiga Docker-bilder:

   ```
   $ docker pull openwhisk/action-nodejs-v12:latest
   $ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
   ```

1. [Installera Visual Studio-kod](https://code.visualstudio.com/download)
1. [Installera Node.js 10+](../../local-development-environment/development-tools.md#node-js)
1. Installera nödvändiga npm-moduler och Adobe I/O CLI-plugin-program från kommandoraden:

   ```
   $ npm i -g @adobe/aio-cli @openwhisk/wskdebug ngrok --unsafe-perm=true \
   && aio plugins:install @adobe/aio-cli-plugin-asset-compute
   ```

Mer information om de förkortade installationsanvisningarna finns i avsnitten nedan.

## Installera Visual Studio Code{#vscode}

[Microsoft Visual Studio Code](https://code.visualstudio.com/download) används för att utveckla och felsöka Asset Compute-arbetare. Andra [JavaScript-kompatibla IDE](../../local-development-environment/development-tools.md#set-up-the-development-ide) kan användas för att utveckla arbetaren, men bara Visual Studio Code kan integreras med [debug](../test-debug/debug.md) Asset Compute-arbetaren.

I den här självstudiekursen antas användningen av Visual Studio Code som den ger den bästa utvecklarupplevelsen för att utöka Asset Compute.

## Installera Docker Desktop{#docker}

Hämta och installera den senaste, stabila [Docker Desktop](https://www.docker.com/products/docker-desktop) eftersom detta krävs för att [testa](../test-debug/test.md) - och [felsöka](../test-debug/debug.md) Asset Compute-projekt lokalt.

När du har installerat Docker Desktop startar du programmet och installerar följande Docker-bilder från kommandoraden:

```
$ docker pull openwhisk/action-nodejs-v12:latest
$ docker pull adobeapiplatform/adobe-action-nodejs-v12:3.0.22
```

Utvecklare på Windows-datorer bör kontrollera att de använder Linux-behållare för bilderna ovan. Stegen för att växla till Linux-behållare beskrivs i [Docker för Windows-dokumentationen](https://docs.docker.com/docker-for-windows/).

## Installera Node.js (och npm){#node-js}

Asset Compute-arbetare är [Node.js](https://nodejs.org/)-baserade, och kräver därför Node.js 10+ (och npm) för att kunna utveckla och bygga.

+ [Installera Node.js (och npm)](../../local-development-environment/development-tools.md#node-js) på samma sätt som för traditionell AEM-utveckling.

## Installera Adobe I/O CLI{#aio}

[Installera Adobe I/O CLI](../../local-development-environment/development-tools.md#aio-cli), eller __aio__ är en kommandoradsmodul (CLI) som underlättar användning av och interaktion med Adobe I/O-tekniker, och som används både för att generera och lokalt utveckla anpassade Asset Compute-arbetare.

```
$ npm install -g @adobe/aio-cli
```

## Installera Adobe I/O CLI Asset Compute plugin{#aio-asset-compute}

[Adobe I/O CLI Asset Compute-plugin](https://github.com/adobe/aio-cli-plugin-asset-compute)

```
$ aio plugins:install @adobe/aio-cli-plugin-asset-compute
```

## Installera wskdebug{#wskdebug}

Hämta och installera [Apache OpenWhisk-felsökningsmodulen &#x200B;](https://www.npmjs.com/package/@openwhisk/wskdebug) npm för att underlätta lokal felsökning av Asset Compute-arbetare.

_Visual Studio Code 1.48.x+ krävs för att [wskdebug](#wskdebug) ska fungera._

```
$ npm install -g @openwhisk/wskdebug
```

## Installera anteckning{#ngrok}

Hämta och installera modulen [ngrok](https://www.npmjs.com/package/ngrok) npm, som ger offentlig åtkomst till din lokala utvecklingsdator, för att underlätta lokal felsökning av Asset Compute-arbetare.

```
$ npm install -g ngrok --unsafe-perm=true
```
