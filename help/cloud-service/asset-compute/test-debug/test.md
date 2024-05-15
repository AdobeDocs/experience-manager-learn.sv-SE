---
title: Testa en Asset compute-arbetare
description: I Asset compute-projektet definieras ett mönster för att enkelt skapa och köra tester av Asset compute.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-6284
thumbnail: KT-6284.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 04992caf-b715-4701-94a8-6257e9bd300c
duration: 142
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '613'
ht-degree: 0%

---

# Testa en Asset compute-arbetare

Asset compute-projektet definierar ett mönster för att enkelt skapa och köra [test av arbetare i Asset compute](https://experienceleague.adobe.com/docs/asset-compute/using/extend/test-custom-application.html).

## Anatomi i ett arbetartest

Asset compute arbetares tester delas upp i testsviter och inom varje testsvit finns ett eller flera testfall där ett villkor ska testas.

Teststrukturen i ett Asset compute-projekt är följande:

```
/actions/<worker-name>/index.js
...
/test/
  asset-compute/
    <worker-name>/           <--- Test suite for the worker, must match the yaml key for this worker in manifest.yml
        <test-case-1>/       <--- Specific test case 
            file.jpg         <--- Input file (ie. `source.path` or `source.url`)
            params.json      <--- Parameters (ie. `rendition.instructions`)
            rendition.png    <--- Expected output file (ie. `rendition.path`)
        <test-case-2>/       <--- Another specific test case for this worker
            ...
```

Varje testskiftning kan ha följande filer:

+ `file.<extension>`
   + Källfil som ska testas (tillägg kan vara vad som helst utom `.link`)
   + Obligatoriskt
+ `rendition.<extension>`
   + Förväntad återgivning
   + Obligatoriskt, utom för feltestning
+ `params.json`
   + JSON-instruktioner för en rendering
   + Valfritt
+ `validate`
   + Ett skript som får förväntade och faktiska sökvägar för återgivningsfilen som argument och måste returnera avslutningskod 0 om resultatet är OK, eller en avslutningskod som inte är noll om valideringen eller jämförelsen misslyckas.
   + Valfritt, används som standard `diff` kommando
   + Använd ett skalskript som omsluter ett dockningskommando för olika valideringsverktyg
+ `mock-<host-name>.json`
   + JSON-formaterade HTTP-svar för [koppla externa tjänstanrop](https://www.mock-server.com/mock_server/creating_expectations.html).
   + Valfritt, används bara om arbetskoden gör egna HTTP-begäranden

## Skriva ett testfall

Det här testfallet kontrollerar parametriserade indata (`params.json`) för indatafilen (`file.jpg`) genererar den förväntade PNG-återgivningen (`rendition.png`).

1. Ta först bort den automatiskt genererade `simple-worker` testfall vid `/test/asset-compute/simple-worker` eftersom detta är ogiltigt kopierar vår arbetare inte längre bara källan till återgivningen.
1. Skapa en ny testfallsmapp på `/test/asset-compute/worker/success-parameterized` för att testa en lyckad körning av arbetaren som genererar en PNG-återgivning.
1. I `success-parameterized` mapp, lägg till testet [indatafil](./assets/test/success-parameterized/file.jpg) för det här testfallet och ge det ett namn `file.jpg`.
1. I `success-parameterized` mapp, lägga till en ny fil med namnet `params.json` som definierar arbetarens indataparametrar:

   ```json
   { 
       "size": "400",
       "contrast": "0.25",
       "brightness": "-0.50"
   }
   ```

   Dessa är samma nyckel/värden som skickas till [Definition av Asset compute-profil för utvecklingsverktyget](../develop/development-tool.md), minus `worker` -tangenten.

1. Lägg till förväntat [återgivningsfil](./assets/test/success-parameterized/rendition.png) till det här testfallet och ge det ett namn `rendition.png`. Den här filen representerar förväntade utdata för arbetaren för angivna indata `file.jpg`.
1. Kör testerna i projektets rot från kommandoraden genom att köra `aio app test`
   + Säkerställ [Docker Desktop](../set-up/development-environment.md#docker) och stöd för Docker-bilder installeras och startas
   + Avsluta alla instanser av utvecklingsverktyget som körs

![Test - lyckades ](./assets/test/success-parameterized/result.png)

## Skriva ett fel vid kontroll av testfall

Det här testfallet testar för att säkerställa att arbetaren orsakar rätt fel när `contrast` parametern är inställd på ett ogiltigt värde.

1. Skapa en ny testfallsmapp på `/test/asset-compute/worker/error-contrast` för att testa en felkörning av arbetaren på grund av ett ogiltigt `contrast` parametervärde.
1. I `error-contrast` mapp, lägg till testet [indatafil](./assets/test/error-contrast/file.jpg) för det här testfallet och ge det ett namn `file.jpg`. Innehållet i den här filen är inte viktigt för det här testet. Det behöver bara finnas för att komma förbi kontrollen &quot;Skadad källa&quot; för att nå `rendition.instructions` validering kontrollerar att det här testfallet validerar.
1. I `error-contrast` mapp, lägga till en ny fil med namnet `params.json` som definierar arbetarens indataparametrar med innehållet:

   ```json
   {
       "contrast": "10",
       "errorReason": "rendition_instructions_error"
   }
   ```

   + Ange `contrast` parametrar till `10`, ett ogiltigt värde, eftersom kontrasten måste vara mellan -1 och 1, för att en `RenditionInstructionsError`.
   + Kontrollera att rätt fel genereras i tester genom att ställa in `errorReason` nyckeln till orsaken som är associerad med det förväntade felet. Den här ogiltiga kontrastparametern ger [anpassat fel](../develop/worker.md#errors), `RenditionInstructionsError`därför att ange `errorReason` på grund av felet, eller`rendition_instructions_error` för att bekräfta att det kastas.

1. Eftersom ingen återgivning ska genereras under en körning av en återgivning bör ingen `rendition.<extension>` filen är nödvändig.
1. Kör testsviten från projektets rot genom att köra kommandot `aio app test`
   + Säkerställ [Docker Desktop](../set-up/development-environment.md#docker) och stöd för Docker-bilder installeras och startas
   + Avsluta alla instanser av utvecklingsverktyget som körs

![Test - felkontrast](./assets/test/error-contrast/result.png)

## Testfall på Github

De sista testfallen finns på Github:

+ [aem-guides-wknd-asset-compute/test/asset-compute/worker](https://github.com/adobe/aem-guides-wknd-asset-compute/tree/master/test/asset-compute/worker)

## Felsökning

+ [Ingen återgivning genererades under testkörningen](../troubleshooting.md#test-no-rendition-generated)
+ [Test genererar felaktig återgivning](../troubleshooting.md#tests-generates-incorrect-rendition)
