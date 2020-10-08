---
title: Felsöka en Asset Compute-arbetare
description: Resursberäkningspersonal kan felsökas på flera olika sätt, från enkla felsökningsloggsatser till bifogad VS-kod som fjärrfelsökare, till att dra loggar för aktiveringar i Adobe I/O Runtime som initierats från AEM som Cloud Service.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6285
thumbnail: 40383.jpg
translation-type: tm+mt
source-git-commit: 3a3832a05ed9598d970915adbc163254c6eb83f1
workflow-type: tm+mt
source-wordcount: '836'
ht-degree: 0%

---


# Felsöka en Asset Compute-arbetare

Resursberäkningspersonal kan felsökas på flera olika sätt, från enkla felsökningsloggsatser till bifogad VS-kod som fjärrfelsökare, till att dra loggar för aktiveringar i Adobe I/O Runtime som initierats från AEM som Cloud Service.

## Loggning

Den mest grundläggande formen av felsökning av Asset Compute-arbetare använder traditionella `console.log(..)` programsatser i arbetskoden. JavaScript- `console` objektet är ett implicit, globalt objekt, så det finns inget behov av att importera eller kräva det, vilket alltid finns i alla sammanhang.

De här loggsatserna är tillgängliga för granskning på olika sätt beroende på hur Asset Compute-arbetaren körs:

+ Från `aio app run`loggar utskrift till standardutskrift och aktiveringsloggar för [utvecklingsverktyget](../develop/development-tool.md)
   ![AIO-appkörningen console.log(...)](./assets/debug/console-log__aio-app-run.png)
+ Från `aio app test`loggar utskrift till `/build/test-results/test-worker/test.log`
   ![aio app test console.log(..)](./assets/debug/console-log__aio-app-test.png)
+ Med `wskdebug`loggar du programsatser som skrivs ut på VS-kodens felsökningskonsol (Visa > Felsökningskonsol), som standard
   ![wskdebug console.log(..)](./assets/debug/console-log__wskdebug.png)
+ Använd `aio app logs`loggsatser som skrivs ut i aktiveringsloggen

## Fjärrfelsökning via ansluten felsökning

>[!WARNING]
>
>Använd Microsoft Visual Studio Code 1.48.0 eller senare för kompatibilitet med wskdebug

Modulen [wskdebug](https://www.npmjs.com/package/@openwhisk/wskdebug) npm har stöd för att bifoga en felsökare till Assets Compute-arbetare, inklusive möjligheten att ange brytpunkter i VS-koden och stega igenom koden.

>[!VIDEO](https://video.tv.adobe.com/v/40383/?quality=12&learn=on)

_Klicka igenom felsökningen av en Asset Compute-arbetare med wskdebug (inget ljud)_

1. Kontrollera att [wskdebug](../set-up/development-environment.md#wskdebug) - och [ngrok](../set-up/development-environment.md#ngork) npm-moduler är installerade
1. Kontrollera att [Docker Desktop och tillhörande Docker-bilder](../set-up/development-environment.md#docker) är installerade och igång
1. Stäng alla aktiva instanser av utvecklingsverktyget som körs.
1. Distribuera den senaste koden med `aio app deploy` och registrera namnet på den distribuerade åtgärden (namnet mellan `[...]`). Detta används för att uppdatera `launch.json` i steg 8.

   ```
   ℹ Info: Deploying package [wkndAemAssetCompute-0.0.1]...
   ```
1. Starta en ny instans av verktyget Resursberäkning med kommandot `npx adobe-asset-compute devtool`
1. I VS-kod trycker du på ikonen Debug (Felsökning) i den vänstra navigeringen
   + Tryck på __Skapa en launch.json-fil > Node.js__ för att skapa en ny `launch.json` fil om du uppmanas till detta.
   + Annars trycker du på ikonen __Kugga__ till höger om listrutan __Starta program__ för att öppna den befintliga `launch.json` i redigeraren.
1. Lägg till följande JSON-objektkonfiguration i `configurations` arrayen:

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
1. Tryck på den gröna __Kör__ -knappen till vänster om listrutan __wskdebug__
1. Öppna `/actions/worker/index.js` och tryck till vänster om radnumren för att lägga till brytpunkter 1. Navigera till webbläsarfönstret Resursberäkningsverktyget som öppnas i steg 6
1. Tryck på knappen __Kör__ för att köra arbetaren
1. Navigera tillbaka till VS-koden `/actions/worker/index.js` och stega igenom koden
1. Om du vill avsluta det felsökningsbara utvecklingsverktyget trycker du `Ctrl-C` i terminalen som körde `npx adobe-asset-compute devtool` kommandot i steg 6

## Åtkomst till loggar från Adobe I/O Runtime{#aio-app-logs}

[AEM som Cloud Service använder sig av Asset Compute-arbetare via Bearbetningsprofiler](../deploy/processing-profiles.md) genom att anropa dem direkt i Adobe I/O Runtime. Eftersom dessa anrop inte innefattar lokal utveckling kan deras körningar inte felsökas med lokala verktyg som verktyget för utveckling av tillgångsberäkning eller wskdebug. I stället kan Adobe I/O CLI användas för att hämta loggar från arbetaren som körs på en viss arbetsyta i Adobe I/O Runtime.

1. Se till att de [arbetsytespecifika miljövariablerna](../deploy/runtime.md) ställs in via `AIO_runtime_namespace` och `AIO_runtime_auth`baserat på arbetsytan som kräver felsökning.
1. Kör från kommandoraden `aio app logs`
   + Om arbetsytan är hårt trafikerad kan du utöka antalet aktiveringsloggar med `--limit` flaggan:
      `$ aio app logs --limit=25`
1. De senaste (upp till de angivna) aktiveringsloggarna returneras som utdata för kommandot som ska granskas. `--limit`

   ![AIO-apploggar](./assets/debug/aio-app-logs.png)

## Felsökning

### Felsökaren är inte kopplad

+ __Fel__: Fel vid start: Fel: Det gick inte att ansluta till felsökningsmålet vid..
+ __Orsak__: Docker Desktop körs inte på det lokala systemet. Verifiera detta genom att granska VS Code Debug Console (Visa > Debug Console) och bekräfta att felet har rapporterats.
+ __Upplösning__: Starta [Docker Desktop och kontrollera att de nödvändiga Docker-bilderna är installerade](../set-up/development-environment.md#docker).

### Brytpunkter pausas inte

+ __Fel__: VS-koden pausar inte vid brytpunkter när arbetaren för beräkning av tillgångar körs från det felsökningsbara utvecklingsverktyget.

#### Felsökningsprogrammet för VS-kod är inte bifogat

+ __Orsak:__ Felsökningsprogrammet för VS-kod stoppades/kopplades från.
+ __Upplösning:__ Starta om felsökaren för VS-koden och verifiera den genom att titta på konsolen för VS-kodsfelsökning (Visa > Felsökningskonsol)

#### VS-kodfelsökning bifogad efter att körningen av arbetaren påbörjats

+ __Orsak:__ Felsökningsprogrammet för VS-koden kopplades inte innan användaren knackade på __Kör__ i utvecklingsverktyget.
+ __Upplösning:__ Kontrollera att felsökaren har bifogats genom att granska VS-kodens felsökningskonsol (Visa > Felsökningskonsol) och kör sedan om resursens beräkningsarbetare från utvecklingsverktyget.

### Arbetarens timeout vid felsökning

+ __Fel__: Felsökningskonsolen rapporterar &quot;Åtgärd kommer att timeout i -XXX millisekunder&quot; eller [Resursberäkningsutvecklingsverktygets](../develop/development-tool.md) förhandsgranskningsintervall för återgivning varar oändligt eller
+ __Orsak__: Arbetarens timeout som definieras i [manifest.yml](../develop/manifest.md) överskrids under felsökningen.
+ __Upplösning__: Öka tillfälligt arbetarens timeout i [manifest.yml](../develop/manifest.md) eller snabba upp felsökningsaktiviteterna.

### Det går inte att avsluta felsökningsprocessen

+ __Fel__: `Ctrl-C` på kommandoraden avbryter inte felsökningsprocessen (`npx adobe-asset-compute devtool`).
+ __Orsak__: Ett fel i `@adobe/aio-cli-plugin-asset-compute` 1.3.x gör att det `Ctrl-C` inte känns igen som ett avslutningskommando.
+ __Upplösning__: Uppdatera `@adobe/aio-cli-plugin-asset-compute` till version 1.4.1+

   ```
   $ aio update
   ```

   ![Felsökning - aio-uppdatering](./assets/debug/troubleshooting__terminate.png)