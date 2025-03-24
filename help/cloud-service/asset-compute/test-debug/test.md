---
title: Testa en Asset Compute-arbetare
description: Asset Compute-projektet definierar ett mönster för att enkelt skapa och köra tester av Asset Compute-arbetare.
feature: Asset Compute Microservices
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-6284
thumbnail: KT-6284.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 04992caf-b715-4701-94a8-6257e9bd300c
duration: 142
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '613'
ht-degree: 0%

---

# Testa en Asset Compute-arbetare

Asset Compute-projektet definierar ett mönster för att enkelt skapa och köra [test av Asset Compute-arbetare](https://experienceleague.adobe.com/docs/asset-compute/using/extend/test-custom-application.html).

## Anatomi i ett arbetartest

Asset Compute arbetares tester delas upp i testsviter och inom varje testsvit finns ett eller flera testfall där ett villkor ska testas.

Teststrukturen i ett Asset Compute-projekt är följande:

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
   + Source-fil att testa (tillägg kan vara vad som helst förutom `.link`)
   + Obligatoriskt
+ `rendition.<extension>`
   + Förväntad återgivning
   + Obligatoriskt, utom för feltestning
+ `params.json`
   + JSON-instruktioner för en rendering
   + Valfritt
+ `validate`
   + Ett skript som får förväntade och faktiska sökvägar för återgivningsfilen som argument och måste returnera avslutningskod 0 om resultatet är OK, eller en avslutningskod som inte är noll om valideringen eller jämförelsen misslyckas.
   + Valfritt, används som standard kommandot `diff`
   + Använd ett skalskript som omsluter ett dockningskommando för olika valideringsverktyg
+ `mock-<host-name>.json`
   + JSON formaterade HTTP-svar för [att slå av externa tjänstanrop](https://www.mock-server.com/mock_server/creating_expectations.html).
   + Valfritt, används bara om arbetskoden gör egna HTTP-begäranden

## Skriva ett testfall

Det här testfallet kontrollerar parametriserade indata (`params.json`) för indatafilen (`file.jpg`) och genererar den förväntade PNG-återgivningen (`rendition.png`).

1. Ta först bort det automatiskt genererade `simple-worker`-testfallet vid `/test/asset-compute/simple-worker` eftersom det är ogiltigt, eftersom vår arbetare inte längre bara kopierar källan till återgivningen.
1. Skapa en ny testfallsmapp på `/test/asset-compute/worker/success-parameterized` för att testa en lyckad körning av arbetaren som genererar en PNG-återgivning.
1. Lägg till [indatafilen](./assets/test/success-parameterized/file.jpg) för testet i mappen `success-parameterized` och ge det namnet `file.jpg`.
1. I mappen `success-parameterized` lägger du till en ny fil med namnet `params.json` som definierar arbetarens indataparametrar:

   ```json
   { 
       "size": "400",
       "contrast": "0.25",
       "brightness": "-0.50"
   }
   ```

   Det här är samma nyckel/värden som skickas till Asset Compute-profildefinitionen för [utvecklingsverktyget](../develop/development-tool.md), minus `worker`.

1. Lägg till den förväntade [återgivningsfilen](./assets/test/success-parameterized/rendition.png) i det här testfallet och ge den namnet `rendition.png`. Den här filen representerar förväntade utdata för arbetaren för den angivna inmatningen `file.jpg`.
1. Kör testerna av projektroten från kommandoraden genom att köra `aio app test`
   + Kontrollera att [Docker Desktop](../set-up/development-environment.md#docker) och tillhörande Docker-bilder är installerade och startade
   + Avsluta alla instanser av utvecklingsverktyget som körs

![Test - lyckades ](./assets/test/success-parameterized/result.png)

## Skriva ett fel vid kontroll av testfall

Det här testfallet testar för att säkerställa att arbetaren genererar rätt fel när parametern `contrast` är inställd på ett ogiltigt värde.

1. Skapa en ny testfallsmapp på `/test/asset-compute/worker/error-contrast` för att testa en felkörning av arbetaren på grund av ett ogiltigt `contrast`-parametervärde.
1. Lägg till [indatafilen](./assets/test/error-contrast/file.jpg) för testet i mappen `error-contrast` och ge det namnet `file.jpg`. Innehållet i den här filen är inte väsentligt för det här testet. Det behöver bara finnas för att komma förbi kontrollen &quot;Skadad källa&quot;, för att kunna nå de `rendition.instructions`-valideringskontroller som det här testfallet validerar.
1. I mappen `error-contrast` lägger du till en ny fil med namnet `params.json` som definierar arbetarens indataparametrar med innehållet:

   ```json
   {
       "contrast": "10",
       "errorReason": "rendition_instructions_error"
   }
   ```

   + Ange `contrast`-parametrar till `10`, ett ogiltigt värde eftersom kontrasten måste vara mellan -1 och 1, för att generera `RenditionInstructionsError`.
   + Kontrollera att rätt fel genereras i tester genom att ange nyckeln `errorReason` till &quot;reason&quot; som är associerad med det förväntade felet. Den här ogiltiga kontrastparametern genererar det [anpassade felet ](../develop/worker.md#errors), `RenditionInstructionsError`, och därför anges `errorReason` till felets orsak, eller `rendition_instructions_error` för att bekräfta att det genereras.

1. Eftersom ingen återgivning ska genereras under en körning krävs ingen `rendition.<extension>`-fil.
1. Kör testsviten från projektets rot genom att köra kommandot `aio app test`
   + Kontrollera att [Docker Desktop](../set-up/development-environment.md#docker) och tillhörande Docker-bilder är installerade och startade
   + Avsluta alla instanser av utvecklingsverktyget som körs

![Testa - Felkontrast](./assets/test/error-contrast/result.png)

## Testfall på Github

De sista testfallen finns på Github:

+ [aem-guides-wknd-asset-compute/test/asset-compute/worker](https://github.com/adobe/aem-guides-wknd-asset-compute/tree/master/test/asset-compute/worker)

## Felsökning

+ [Ingen återgivning genererades under testkörningen](../troubleshooting.md#test-no-rendition-generated)
+ [Test genererar felaktig återgivning](../troubleshooting.md#tests-generates-incorrect-rendition)
