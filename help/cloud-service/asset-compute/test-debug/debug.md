---
title: Felsöka en Asset compute-arbetare
description: Asset compute-arbetare kan felsökas på flera olika sätt, från enkla felsökningsloggsatser till kopplad VS-kod som fjärrfelsökare, till att dra loggar för aktiveringar i Adobe I/O Runtime som initierats från AEM as a Cloud Service.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-6285
thumbnail: 40383.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 4dea9cc4-2133-4ceb-8ced-e9b9874f6d89
duration: 268
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '618'
ht-degree: 0%

---

# Felsöka en Asset compute-arbetare

Asset compute-arbetare kan felsökas på flera olika sätt, från enkla felsökningsloggsatser till kopplad VS-kod som fjärrfelsökare, till att dra loggar för aktiveringar i Adobe I/O Runtime som initierats från AEM as a Cloud Service.

## Loggning

Den mest grundläggande formen av felsökning i Asset compute använder traditionella `console.log(..)` -programsatser i arbetskoden. The `console` JavaScript-objektet är ett implicit, globalt objekt så det finns inget behov av att importera eller kräva det, eftersom det alltid finns i alla sammanhang.

De här loggsatserna är tillgängliga för granskning på olika sätt beroende på hur Asset compute-arbetaren körs:

+ Från `aio app run`, loggar ut som standard och [Utvecklingsverktyg](../develop/development-tool.md) Aktiveringsloggar
  ![AIO-appkörningen console.log(...)](./assets/debug/console-log__aio-app-run.png)
+ Från `aio app test`, loggar ut till `/build/test-results/test-worker/test.log`
  ![aio app test console.log(..)](./assets/debug/console-log__aio-app-test.png)
+ Använda `wskdebug`, loggar programsatser som skrivs ut på VS-kodens felsökningskonsol (Visa > Felsökningskonsol), standard-out
  ![wskdebug console.log(..)](./assets/debug/console-log__wskdebug.png)
+ Använda `aio app logs`, loggutdrag som skrivs ut i aktiveringsloggen

## Fjärrfelsökning via ansluten felsökning

>[!WARNING]
>
>Använd Microsoft Visual Studio Code 1.48.0 eller senare för kompatibilitet med wskdebug

The [wskdebug](https://www.npmjs.com/package/@openwhisk/wskdebug) npm-modulen har stöd för att bifoga en felsökare till Asset compute-arbetare, inklusive möjligheten att ange brytpunkter i VS-koden och stega igenom koden.

>[!VIDEO](https://video.tv.adobe.com/v/40383?quality=12&learn=on)

_Klicka igenom felsökningen av en Asset compute-arbetare med wskdebug (inget ljud)_

1. Säkerställ [wskdebug](../set-up/development-environment.md#wskdebug) och [ngrok](../set-up/development-environment.md#ngork) npm-moduler installeras
1. Säkerställ [Docker Desktop och tillhörande Docker-bilder](../set-up/development-environment.md#docker) installeras och körs
1. Stäng alla aktiva instanser av utvecklingsverktyget som körs.
1. Distribuera den senaste koden med `aio app deploy`  och registrera namnet på den distribuerade åtgärden (namn mellan `[...]`). Detta används för att uppdatera `launch.json` i steg 8.

   ```
   ℹ Info: Deploying package [wkndAemAssetCompute-0.0.1]...
   ```


1. Starta en ny instans av Asset compute Development Tool med kommandot `npx adobe-asset-compute devtool`
1. I VS-kod trycker du på ikonen Debug (Felsökning) i den vänstra navigeringen
   + Tryck på __skapa en launch.json-fil > Node.js__ för att skapa en ny `launch.json` -fil.
   + Annars trycker du på __Kugghjul__ ikonen till höger om __Starta program__ listruta för att öppna den befintliga `launch.json` i redigeraren.
1. Lägg till följande JSON-objektkonfiguration i `configurations` array:

   ```json
   {
       "type": "pwa-node",
       "request": "launch",
       "name": "wskdebug",
       "attachSimplePort": 0,
       "runtimeExecutable": "wskdebug",
       "args": [
           "wkndAemAssetCompute-0.0.1/__secured_worker",  // Version must match your Asset Compute worker's version
           "${workspaceFolder}/actions/worker/index.js",  // Points to your worker
           "-l",
           "--ngrok"
       ],
       "localRoot": "${workspaceFolder}",
       "remoteRoot": "/code",
       "outputCapture": "std",
       "timeout": 30000
   }
   ```

1. Välj den nya __wskdebug__ från listrutan
1. Tryck på den gröna __Kör__ till vänster om __wskdebug__ listruta
1. Öppna `/actions/worker/index.js` och tryck till vänster om radnumren för att lägga till brytpunkter 1. Navigera till webbläsarfönstret Asset compute Development Tool som öppnas i steg 6
1. Tryck på __Kör__ knapp för att köra arbetaren
1. Navigera tillbaka till VS-koden, till `/actions/worker/index.js` och stega igenom koden
1. Om du vill avsluta utvecklingsverktyget vid felsökning trycker du på `Ctrl-C` i terminalen som körde `npx adobe-asset-compute devtool` kommando i steg 6

## Åtkomst till loggar från Adobe I/O Runtime{#aio-app-logs}

[AEM as a Cloud Service utnyttjar Asset compute-arbetare via Bearbetningsprofiler](../deploy/processing-profiles.md) genom att anropa dem direkt i Adobe I/O Runtime. Eftersom dessa anrop inte innefattar lokal utveckling kan deras körningar inte felsökas med lokala verktyg som Asset compute Development Tool eller wskdebug. I stället kan Adobe I/O CLI användas för att hämta loggar från arbetaren som körs på en viss arbetsyta i Adobe I/O Runtime.

1. Kontrollera [arbetsytespecifika miljövariabler](../deploy/runtime.md) anges via `AIO_runtime_namespace` och `AIO_runtime_auth`, baserat på arbetsytan som kräver felsökning.
1. Kör från kommandoraden `aio app logs`
   + Om arbetsytan är hårt trafikerad kan du utöka antalet aktiveringsloggar via `--limit` flagga:
     `$ aio app logs --limit=25`
1. Den senaste (upp till den angivna `--limit`)-aktiveringsloggar returneras som utdata från kommandot för granskning.

   ![AIO-apploggar](./assets/debug/aio-app-logs.png)

## Felsökning

+ [Felsökaren är inte kopplad](../troubleshooting.md#debugger-does-not-attach)
+ [Brytpunkter pausas inte](../troubleshooting.md#breakpoints-no-pausing)
+ [Felsökning för VS-kod är inte bifogad](../troubleshooting.md#vs-code-debugger-not-attached)
+ [VS-kodfelsökning bifogad efter att körningen av arbetaren påbörjats](../troubleshooting.md#vs-code-debugger-attached-after-worker-execution-began)
+ [Arbetarens timeout vid felsökning](../troubleshooting.md#worker-times-out-while-debugging)
+ [Det går inte att avsluta felsökningsprocessen](../troubleshooting.md#cannot-terminate-debugger-process)
