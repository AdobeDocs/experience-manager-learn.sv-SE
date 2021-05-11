---
title: Felsöka en Asset compute-arbetare
description: asset compute-arbetare kan felsökas på flera olika sätt, från enkla felsökningsloggsatser till kopplad VS-kod som fjärrfelsökare, till att dra loggar för aktiveringar i Adobe I/O Runtime som initierats från AEM som Cloud Service.
feature: asset compute Microservices
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6285
thumbnail: 40383.jpg
topic: Integrering, utveckling
role: Developer
level: Intermediate, Experienced
translation-type: tm+mt
source-git-commit: dbc0a35ae96594fec1e10f411d57d2a3812c1cf2
workflow-type: tm+mt
source-wordcount: '623'
ht-degree: 0%

---


# Felsöka en Asset compute-arbetare

asset compute-arbetare kan felsökas på flera olika sätt, från enkla felsökningsloggsatser till kopplad VS-kod som fjärrfelsökare, till att dra loggar för aktiveringar i Adobe I/O Runtime som initierats från AEM som Cloud Service.

## Loggning

Den mest grundläggande formen av felsökning av arbetare på Asset compute använder traditionella `console.log(..)`-satser i arbetskoden. JavaScript-objektet `console` är ett implicit, globalt objekt, så det finns inget behov av att importera eller kräva det, vilket alltid finns i alla sammanhang.

De här loggsatserna är tillgängliga för granskning på olika sätt beroende på hur Asset compute-arbetaren körs:

+ Från `aio app run` loggar utskrift till standardutskrift och [aktiveringsloggar för utvecklingsverktyget](../develop/development-tool.md)
   ![AIO-appkörningen console.log(...)](./assets/debug/console-log__aio-app-run.png)
+ Loggar som skrivs ut från `aio app test` till `/build/test-results/test-worker/test.log`
   ![aio app test console.log(..)](./assets/debug/console-log__aio-app-test.png)
+ Med `wskdebug` skrivs satser ut i loggarna till VS-kodens felsökningskonsol (Visa > Felsökningskonsol), som standard
   ![wskdebug console.log(..)](./assets/debug/console-log__wskdebug.png)
+ Med `aio app logs` skriver loggsatser ut till aktiveringsloggutdata

## Fjärrfelsökning via ansluten felsökning

>[!WARNING]
>
>Använd Microsoft Visual Studio Code 1.48.0 eller senare för kompatibilitet med wskdebug

Modulen [wskdebug](https://www.npmjs.com/package/@openwhisk/wskdebug) npm stöder koppling av en felsökare till Asset compute-arbetare, inklusive möjligheten att ange brytpunkter i VS-koden och stega igenom koden.

>[!VIDEO](https://video.tv.adobe.com/v/40383/?quality=12&learn=on)

_Klicka igenom felsökningen av en Asset compute-arbetare med wskdebug (inget ljud)_

1. Kontrollera att [wskdebug](../set-up/development-environment.md#wskdebug) och [ngrok](../set-up/development-environment.md#ngork) npm-modulerna är installerade
1. Kontrollera att [Docker Desktop och tillhörande Docker-bilder](../set-up/development-environment.md#docker) är installerade och körs
1. Stäng alla aktiva instanser av utvecklingsverktyget som körs.
1. Distribuera den senaste koden med `aio app deploy` och registrera namnet på den distribuerade åtgärden (namn mellan `[...]`). Detta används för att uppdatera `launch.json` i steg 8.

   ```
   ℹ Info: Deploying package [wkndAemAssetCompute-0.0.1]...
   ```


1. Starta en ny instans av Asset compute Development Tool med kommandot `npx adobe-asset-compute devtool`
1. I VS-kod trycker du på ikonen Debug (Felsökning) i den vänstra navigeringen
   + Om du uppmanas till det trycker du på __Skapa en launch.json-fil > Node.js__ för att skapa en ny `launch.json`-fil.
   + Annars trycker du på ikonen __Kugga__ till höger om listrutan __Starta program__ för att öppna den befintliga `launch.json` i redigeraren.
1. Lägg till följande JSON-objektkonfiguration i `configurations`-arrayen:

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

1. Välj den nya __wskdebug__ i listrutan
1. Tryck på den gröna __Kör__-knappen till vänster om listrutan __wskdebug__
1. Öppna `/actions/worker/index.js` och tryck till vänster om radnumren för att lägga till brytpunkter 1. Navigera till webbläsarfönstret Asset compute Development Tool som öppnas i steg 6
1. Tryck på knappen __Kör__ för att köra arbetaren
1. Navigera tillbaka till VS-koden till `/actions/worker/index.js` och stega igenom koden
1. Om du vill avsluta det felsökningsbara utvecklingsverktyget trycker du på `Ctrl-C` i terminalen som körde kommandot `npx adobe-asset-compute devtool` i steg 6

## Åtkomst till loggar från Adobe I/O Runtime{#aio-app-logs}

[AEM som Cloud Service utnyttjar Asset compute-arbetare via ](../deploy/processing-profiles.md) Bearbeta profiler genom att anropa dem direkt i Adobe I/O Runtime. Eftersom dessa anrop inte innefattar lokal utveckling kan deras körningar inte felsökas med lokala verktyg som Asset compute Development Tool eller wskdebug. I stället kan Adobe I/O CLI användas för att hämta loggar från arbetaren som körs på en viss arbetsyta i Adobe I/O Runtime.

1. Kontrollera att de [arbetsytespecifika miljövariablerna](../deploy/runtime.md) är inställda via `AIO_runtime_namespace` och `AIO_runtime_auth`, baserat på den arbetsyta som kräver felsökning.
1. Kör `aio app logs` från kommandoraden
   + Om arbetsytan har stor trafik kan du utöka antalet aktiveringsloggar via flaggan `--limit`:
      `$ aio app logs --limit=25`
1. De senaste (upp till de angivna `--limit`) aktiveringsloggarna returneras som utdata för kommandot för granskning.

   ![AIO-apploggar](./assets/debug/aio-app-logs.png)

## Felsökning

+ [Felsökaren är inte kopplad](../troubleshooting.md#debugger-does-not-attach)
+ [Brytpunkter pausas inte](../troubleshooting.md#breakpoints-no-pausing)
+ [Felsökning för VS-kod är inte bifogad](../troubleshooting.md#vs-code-debugger-not-attached)
+ [VS-kodfelsökning bifogad efter att körningen av arbetaren påbörjats](../troubleshooting.md#vs-code-debugger-attached-after-worker-execution-began)
+ [Arbetarens timeout vid felsökning](../troubleshooting.md#worker-times-out-while-debugging)
+ [Det går inte att avsluta felsökningsprocessen](../troubleshooting.md#cannot-terminate-debugger-process)
