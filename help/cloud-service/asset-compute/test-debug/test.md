---
title: Testa en Asset Compute-arbetare
description: I projektet Asset Compute definieras ett mönster för att enkelt skapa och köra tester av Asset Compute-arbetare.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6284
thumbnail: KT-6284.jpg
translation-type: tm+mt
source-git-commit: af610f338be4878999e0e9812f1d2a57065d1829
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---


# Testa en Asset Compute-arbetare

I projektet Asset Compute definieras ett mönster som gör det enkelt att skapa och köra [tester av Asset Compute-arbetare](https://docs.adobe.com/content/help/en/asset-compute/using/extend/test-custom-application.html).

## Anatomi i ett arbetartest

Resursberäkningspersonalens tester delas upp i testsviter, och inom varje testsvit finns ett eller flera testfall där ett villkor ska testas.

Strukturen för testerna i ett projekt för beräkning av tillgångar är följande:

```
/actions/<worker-name>/index.js
...
/test/
  asset-compute/
    <worker-name>/           <--- Test suite for the worker
        <test-case-1>/       <--- Specific test case 
            file.jpg         <--- Input file (ie. `source.path` or `source.url`)
            params.json      <--- Parameters (ie. `rendition.instructions`)
            rendition.png    <--- Expected output file (ie. `rendition.path`)
        <test-case-2>/       <--- Another specific test case for this worker
            ...
```

Varje testskiftning kan ha följande filer:

+ `file.<extension>`
   + Källfil som ska testas (tillägget kan vara vad som helst utom `.link`)
   + Krävs
+ `rendition.<extension>`
   + Förväntad återgivning
   + Obligatoriskt, utom för feltestning
+ `params.json`
   + JSON-instruktioner för en rendering
   + Valfritt
+ `validate`
   + Ett skript som får förväntade och faktiska sökvägar för återgivningsfilen som argument och måste returnera avslutningskod 0 om resultatet är OK, eller en avslutningskod som inte är noll om valideringen eller jämförelsen misslyckas.
   + Valfritt, används som standard för `diff` kommandot
   + Använd ett skalskript som omsluter ett dockningskommando för olika valideringsverktyg
+ `mock-<host-name>.json`
   + JSON-formaterade HTTP-svar för [att skapa en modell för externa tjänstanrop](https://www.mock-server.com/mock_server/creating_expectations.html).
   + Valfritt, används bara om arbetskoden gör egna HTTP-begäranden

## Skriva ett testfall

Detta testfall kontrollerar att parametriserade indata (`params.json`) för indatafilen (`file.jpg`) genererar den förväntade PNG-återgivningen (`rendition.png`).

1. Ta först bort det automatiskt genererade `simple-worker` testfallet `/test/asset-compute/simple-worker` eftersom det är ogiltigt, eftersom vår arbetare inte längre bara kopierar källan till återgivningen.
1. Skapa en ny testfallsmapp på `/test/asset-compute/worker/success-parameterized` för att testa en lyckad körning av arbetaren som genererar en PNG-återgivning.
1. Lägg till `success-parameterized` indatafilen [för testfallet i](./assets/test/success-parameterized/file.jpg) mappen och ge den ett namn `file.jpg`.
1. I `success-parameterized` mappen lägger du till en ny fil med namnet `params.json` som definierar arbetarens indataparametrar:

   ```json
   { 
       "size": "400",
       "contrast": "0.25",
       "brightness": "-0.50"
   }
   ```
   Detta är samma nyckel/värden som skickas till [utvecklingsverktygets definition](../develop/development-tool.md)av resursberäkningsprofilen, minus `worker` nyckeln.
1. Lägg till den förväntade [återgivningsfilen](./assets/test/success-parameterized/rendition.png) i det här testfallet och ge den ett namn `rendition.png`. Den här filen representerar förväntade utdata för arbetaren för angivna indata `file.jpg`.
1. Kör testerna i projektets rot från kommandoraden genom att köra `aio app test`
   + Kontrollera att [Docker Desktop](../set-up/development-environment.md#docker) och tillhörande Docker-bilder har installerats och startats
   + Avsluta alla instanser av utvecklingsverktyget som körs

![Test - lyckades ](./assets/test/success-parameterized/result.png)

## Skriva ett fel vid kontroll av testfall

Det här testfallet testar för att säkerställa att arbetaren genererar rätt fel när parametern är inställd på ett ogiltigt `contrast` värde.

1. Skapa en ny testfallsmapp på `/test/asset-compute/worker/error-contrast` för att testa en felkörning av arbetaren på grund av ett ogiltigt `contrast` parametervärde.
1. Lägg till `error-contrast` indatafilen [för testfallet i](./assets/test/error-contrast/file.jpg) mappen och ge den ett namn `file.jpg`. Innehållet i den här filen är inte väsentligt för det här testet. Det behöver bara finnas för att komma förbi kontrollen &quot;Skadad källa&quot;, för att kunna komma åt de `rendition.instructions` valideringskontroller som det här testfallet validerar.
1. I `error-contrast` mappen lägger du till en ny fil med namnet `params.json` som definierar arbetarens indataparametrar med innehållet:

   ```json
   {
       "contrast": "10",
       "errorReason": "rendition_instructions_error"
   }
   ```

   + Ställ in `contrast` parametrarna på `10`, ett ogiltigt värde, eftersom kontrasten måste vara mellan -1 och 1, för att generera ett `RenditionInstructionsError`värde.
   + Kontrollera att rätt fel genereras i tester genom att ange nyckeln till &quot;orsak&quot; som är associerad med det förväntade felet. `errorReason` Den här ogiltiga kontrastparametern genererar det [anpassade felet](../develop/worker.md#errors), `RenditionInstructionsError`därför anges `errorReason` till felets orsak eller`rendition_instructions_error` så att det bekräftas.

1. Eftersom ingen återgivning ska genereras vid en körning av en återgivning behövs ingen `rendition.<extension>` fil.
1. Kör testsviten från projektets rot genom att köra kommandot `aio app test`
   + Kontrollera att [Docker Desktop](../set-up/development-environment.md#docker) och tillhörande Docker-bilder har installerats och startats
   + Avsluta alla instanser av utvecklingsverktyget som körs

![Test - felkontrast](./assets/test/error-contrast/result.png)

## Testfall på Github

De sista testfallen finns på Github:

+ [aem-guides-wknd-asset-compute/test/asset-compute/worker](https://github.com/adobe/aem-guides-wknd-asset-compute/tree/master/test/asset-compute/worker)

## Felsökning

### Ingen återgivning har genererats

Testfall misslyckas utan att en återgivning genereras.

+ __Fel:__ Fel: Ingen återgivning genererades.
+ __Orsak:__ Arbetaren kunde inte generera en återgivning på grund av ett oväntat fel, till exempel ett JavaScript-syntaxfel.
+ __Upplösning:__ Granska testkörningen `test.log` på `/build/test-results/test-worker/test.log`. Leta reda på avsnittet i den här filen som motsvarar det misslyckade testfallet och granska felen.

   ![Felsökning - Ingen återgivning genererades](./assets/test/troubleshooting__no-rendition-generated.png)

### Test genererar felaktig återgivning

Testfall kan inte generera en felaktig återgivning.

+ __Fel:__ Fel: Renderingen &#39;rendition.xxx&#39; är inte som förväntat.
+ __Orsak:__ Arbetaren returnerar en återgivning som inte var densamma som `rendition.<extension>` i testfallet.
   + Om den förväntade `rendition.<extension>` filen inte skapas på exakt samma sätt som den lokalt genererade återgivningen i testfallet, kan testet misslyckas eftersom det kan finnas vissa skillnader i bitarna. Om den förväntade renderingen i testfallet sparas från utvecklingsverktyget, vilket innebär att den genereras i Adobe I/O Runtime, kan bitarna tekniskt sett vara olika, vilket gör att testet misslyckas, även om de förväntade och faktiska renderingsfilerna är identiska ur ett mänskligt perspektiv.
+ __Upplösning:__ Granska återgivningsutdata från testet genom att navigera till `/build/test-worker/<worker-name>/<test-run-timestamp>/<test-case>/rendition.<extension>`och jämföra dem med den förväntade återgivningsfilen i testfallet.
