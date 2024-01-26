---
title: Felsöka utbyggbarhet för Asset compute i AEM Assets
description: Nedan följer ett index över vanliga problem och fel, samt lösningar som kan uppstå när du utvecklar och distribuerar anpassade Asset compute-arbetare för AEM Assets.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-5802
thumbnail: KT-5802.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: d851d315-ed0e-46b8-bcd8-417e1e58c0c4
duration: 335
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1230'
ht-degree: 0%

---

# Felsöka utbyggbarhet för Asset compute

Nedan följer ett index över vanliga problem och fel, samt lösningar som kan uppstå när du utvecklar och distribuerar anpassade Asset compute-arbetare för AEM Assets.

## Utveckla{#develop}

### Återgivningen returneras delvis ritad/skadad{#rendition-returned-partially-drawn-or-corrupt}

+ __Fel__: Återgivningen återges ofullständigt (när en bild) eller är skadad och kan inte öppnas.

  ![Återgivning returneras delvis ritad](./assets/troubleshooting/develop__await.png)

+ __Orsak__: Arbetarens `renditionCallback` funktionen avslutas innan återgivningen kan skrivas till `rendition.path`.
+ __Upplösning__: Granska den anpassade arbetskoden och se till att alla asynkrona anrop görs synkrona med `await`.

## Utvecklingsverktyg{#development-tool}

### Console.json-filen saknas i Asset compute-projektet{#missing-console-json}

+ __Fel:__ Fel: Nödvändiga filer saknas vid verifiering (../node_modules/@adobe/asset-compute-client/lib/integrationConfiguration.js:XX:YY) vid async setupAssetCompute (../node_modules/@adobe/asset-compute-devtool/src/assetComputeDevTool.js:XX:YY)
+ __Orsak:__ The `console.json` filen saknas i roten av Asset compute-projektet
+ __Upplösning:__ Ladda ned en ny `console.json` från ditt Adobe I/O-projekt
   1. I console.adobe.io öppnar du det Adobe I/O-projekt som Asset compute har konfigurerats att använda
   1. Tryck på __Ladda ned__ knappen längst upp till höger
   1. Spara den hämtade filen i roten av Asset compute-projektet med hjälp av filnamnet `console.json`

### Ogiltig YAML-indrag i manifest.yml{#incorrect-yaml-indentation}

+ __Fel:__ YAMLException: felaktigt indrag för en mappningspost på rad X, kolumn Y:(via standard ut från `aio app run` kommando)
+ __Orsak:__ Yaml-filer är känsliga med vitt mellanrum, vilket kan innebära att indraget är felaktigt.
+ __Upplösning:__ Granska `manifest.yml` och se till att allt indrag är korrekt.

### gränsen för memorySize är för låg{#memorysize-limit-is-set-too-low}

+ __Fel:__  Local Dev Server OpenWhiskError: PUT https://adobeioruntime.net/api/v1/namespaces/xxx-xxx-xxx/actions/xxx-0.0.1/__secured_workeroverwrite=true Returned HTTP 400 (Bad Request) —> &quot;Begäraninnehållet hade fel format:required failed: memory 64 MB below allowed threshold of 134217728 B&quot;
+ __Orsak:__ A `memorySize` gräns för arbetaren i `manifest.yml` har angetts till ett värde under det lägsta tillåtna tröskelvärdet enligt felmeddelandet i byte.
+ __Upplösning:__  Granska `memorySize` i `manifest.yml` och se till att alla är större än det lägsta tillåtna tröskelvärdet.

### Utvecklingsverktyget kan inte starta eftersom private.key saknas{#missing-private-key}

+ __Fel:__ Lokalt serverfel: Nödvändiga filer saknas vid validatePrivateKeyFile... (via standard ut från `aio app run` kommando)
+ __Orsak:__ The `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` värde i `.env` fil, pekar inte på `private.key` eller `private.key` kan inte läsas av den aktuella användaren.
+ __Upplösning:__ Granska `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` värde i `.env` och se till att den innehåller den fullständiga, absoluta sökvägen till `private.key` i filsystemet.

### Felaktig listruta för källfiler{#source-files-dropdown-incorrect}

Asset compute Development Tool kan försättas i ett läge där inaktuella data hämtas, vilket märks mest i __Källfil__ listruta med felaktiga objekt.

+ __Fel:__ I listrutan Källfil visas felaktiga objekt.
+ __Orsak:__ Inaktuellt cachelagrat webbläsarläge orsakar
+ __Upplösning:__ I webbläsaren rensar du helt webbläsarflikens &quot;programtillstånd&quot;, webbläsarens cache, lokal lagring och servicearbetare.

### Frågeparametern devToolToken saknas eller är ogiltig{#missing-or-invalid-devtooltoken-query-parameter}

+ __Fel:__ Meddelande om&quot;obehörig&quot; i Asset compute Development Tool
+ __Orsak:__ `devToolToken` saknas eller är ogiltigt
+ __Upplösning:__ Stäng webbläsarfönstret för Asset compute Development Tool och avsluta alla processer som körs med Development Tool som initierats via `aio app run` och starta om utvecklingsverktyget (med `aio app run`).

### Det går inte att ta bort källfiler{#unable-to-remove-source-files}

+ __Fel:__ Det finns inget sätt att ta bort tillagda källfiler från utvecklingsverktygets användargränssnitt
+ __Orsak:__ Den här funktionen har inte implementerats
+ __Upplösning:__ Logga in på din molnlagringsleverantör med inloggningsuppgifterna som anges i `.env`. Leta reda på behållaren som används av utvecklingsverktygen (anges även i `.env`), navigera till __källa__ och ta bort alla källbilder. Du kan behöva utföra de steg som beskrivs i [Felaktig listruta för källfiler](#source-files-dropdown-incorrect) om de borttagna källfilerna fortsätter att visas i listrutan eftersom de kan cachas lokalt i utvecklingsverktygets &quot;programtillstånd&quot;.

  ![Microsoft Azure Blob Storage](./assets/troubleshooting/dev-tool__remove-source-files.png)

## Testa{#test}

### Ingen återgivning genererades under testkörningen{#test-no-rendition-generated}

+ __Fel:__ Fel: Ingen återgivning genererades.
+ __Orsak:__ Arbetaren kunde inte generera en återgivning på grund av ett oväntat fel, till exempel ett JavaScript-syntaxfel.
+ __Upplösning:__ Granska testkörningens `test.log` på `/build/test-results/test-worker/test.log`. Leta reda på avsnittet i den här filen som motsvarar det misslyckade testfallet och granska felen.

  ![Felsökning - Ingen återgivning genererades](./assets/troubleshooting/test__no-rendition-generated.png)

### Testet genererar felaktig återgivning vilket gör att testet misslyckas{#tests-generates-incorrect-rendition}

+ __Fel:__ Fel: Återgivningen &#39;rendition.xxx&#39; är inte som förväntad.
+ __Orsak:__ Arbetaren returnerar en återgivning som inte var densamma som `rendition.<extension>` anges i testfallet.
   + If the expected `rendition.<extension>` filen inte skapas på exakt samma sätt som den lokalt genererade återgivningen i testfallet, eftersom det kan finnas vissa skillnader i bitarna. Om Asset compute-arbetaren till exempel ändrar kontrasten med hjälp av API:er och det förväntade resultatet skapas genom att justera kontrasten i Adobe Photoshop CC, kan filerna se likadana ut, men mindre bitvariationer kan vara annorlunda.
+ __Upplösning:__ Granska återgivningsutdata från testet genom att gå till `/build/test-worker/<worker-name>/<test-run-timestamp>/<test-case>/rendition.<extension>`och jämför med den förväntade återgivningsfilen i testfallet. Så här skapar du en exakt förväntad resurs:
   + Använd utvecklingsverktyget för att generera en återgivning, verifiera att den är korrekt och använd den som den förväntade återgivningsfilen
   + Eller validera den testgenererade filen på `/build/test-worker/<worker-name>/<test-run-timestamp>/<test-case>/rendition.<extension>`, validera att det är korrekt och använd det som den förväntade återgivningsfilen

## Felsök

### Felsökaren är inte kopplad{#debugger-does-not-attach}

+ __Fel__: Fel vid start av bearbetning: Fel: Det gick inte att ansluta till felsökningsmålet på..
+ __Orsak__: Docker Desktop körs inte på det lokala systemet. Verifiera detta genom att granska VS Code Debug Console (Visa > Debug Console) och bekräfta att felet har rapporterats.
+ __Upplösning__: Start [Docker Desktop och kontrollera att nödvändiga Docker-bilder är installerade](./set-up/development-environment.md#docker).

### Brytpunkter pausas inte{#breakpoints-no-pausing}

+ __Fel__: När du kör Asset compute-arbetaren från det felsökningsbara utvecklingsverktyget pausas inte VS-koden vid brytpunkter.

#### Felsökning för VS-kod är inte bifogad{#vs-code-debugger-not-attached}

+ __Orsak:__ Felsökningsprogrammet för VS-kod stoppades/kopplades från.
+ __Upplösning:__ Starta om felsökaren för VS-koden och verifiera den genom att titta på konsolen för VS-kodsfelsökning (Visa > Felsökningskonsol)

#### VS-kodfelsökning bifogad efter att körningen av arbetaren påbörjats{#vs-code-debugger-attached-after-worker-execution-began}

+ __Orsak:__ Felsökningsprogrammet för VS-koden kopplades inte före tryck __Kör__ in Development Tool.
+ __Upplösning:__ Kontrollera att felsökaren har bifogats genom att granska VS-kodens felsökningskonsol (Visa > Felsökningskonsol) och kör sedan Asset compute-arbetaren igen från utvecklingsverktyget.

### Arbetarens timeout vid felsökning{#worker-times-out-while-debugging}

+ __Fel__: Felsökningskonsolen rapporterar &quot;Åtgärd timeout inom -XXX millisekunder&quot; eller [Asset compute Development Tool&#39;s](./develop/development-tool.md) förhandsgranskning av återgivning snurrar oändligt eller
+ __Orsak__: Arbetarens timeout enligt definitionen i [manifest.yml](./develop/manifest.md) har överskridits under felsökning.
+ __Upplösning__: Öka tillfälligt arbetarens timeout i [manifest.yml](./develop/manifest.md) eller snabba upp felsökningen.

### Det går inte att avsluta felsökningsprocessen{#cannot-terminate-debugger-process}

+ __Fel__: `Ctrl-C` på kommandoraden avbryter inte felsökningsprocessen (`npx adobe-asset-compute devtool`).
+ __Orsak__: Ett fel i `@adobe/aio-cli-plugin-asset-compute` 1.3.x, resulterar i `Ctrl-C` inte identifieras som ett avslutande kommando.
+ __Upplösning__: Uppdatera `@adobe/aio-cli-plugin-asset-compute` till version 1.4.1+

  ```
  $ aio update
  ```

  ![Felsökning - aio-uppdatering](./assets/troubleshooting/debug__terminate.png)

## Distribuera{#deploy}

### Anpassad återgivning saknas för resurs i AEM{#custom-rendition-missing-from-asset}

+ __Fel:__ Ny och ombearbetad resursprocess har slutförts, men den anpassade återgivningen saknas

#### Bearbetningsprofilen används inte för den överordnade mappen

+ __Orsak:__ Resursen finns inte i en mapp med bearbetningsprofilen som använder den anpassade arbetaren
+ __Upplösning:__ Använd bearbetningsprofilen på en överordnad mapp för resursen

#### Bearbetningsprofil ersatt av en lägre bearbetningsprofil

+ __Orsak:__ Resursen finns under en mapp där den anpassade arbetarens bearbetningsprofil används, men en annan bearbetningsprofil som inte använder kundarbetaren har tillämpats mellan den mappen och resursen.
+ __Upplösning:__ Kombinera, eller på annat sätt stämma av, de två bearbetningsprofilerna och ta bort den mellanliggande bearbetningsprofilen

### Resursbearbetning misslyckas i AEM{#asset-processing-fails}

+ __Fel:__ Tillgångsbearbetningen misslyckades, märket visas på resursen
+ __Orsak:__ Ett fel uppstod vid körningen av den anpassade arbetaren
+ __Upplösning:__ Följ instruktionerna på [felsöka Adobe I/O Runtime-aktiveringar](./test-debug/debug.md#aio-app-logs) använda `aio app logs`.
