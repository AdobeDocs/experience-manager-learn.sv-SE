---
title: Felsöka utbyggbarhet av tillgångsberäkning för AEM Assets
description: Nedan följer ett index över vanliga problem och fel, samt lösningar som kan uppstå när du utvecklar och distribuerar anpassade resurser för AEM Assets.
feature: asset-compute
topics: renditions, metadata, development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5802
thumbnail: KT-5802.jpg
translation-type: tm+mt
source-git-commit: 6f5df098e2e68a78efc908c054f9d07fcf22a372
workflow-type: tm+mt
source-wordcount: '1146'
ht-degree: 0%

---


# Felsöka utbyggbarhet av tillgångsberäkning

Nedan följer ett index över vanliga problem och fel, samt lösningar som kan uppstå när du utvecklar och distribuerar anpassade resurser för AEM Assets.

## Utveckla{#develop}

### Återgivningen returneras delvis ritad/skadad{#rendition-returned-partially-drawn-or-corrupt}

+ __Fel__: Återgivningen återges ofullständigt (när en bild) eller är skadad och kan inte öppnas.

   ![Återgivning returneras delvis ritad](./assets/troubleshooting/develop__await.png)

+ __Orsak__: Arbetarens `renditionCallback` funktion avslutas innan återgivningen kan skrivas till `rendition.path`.
+ __Upplösning__: Granska den anpassade arbetskoden och se till att alla asynkrona anrop görs synkrona med `await`.

## Utvecklingsverktyg{#development-tool}

### Felaktigt YAML-indrag i manifest.yml{#incorrect-yaml-indentation}

+ __Fel:__ YAMLException: felaktigt indrag för en mappningspost på rad X, kolumn Y:(via standard ut från `aio app run` kommando)
+ __Orsak:__ Yaml-filer är känsliga med vitt mellanrum, vilket kan innebära att indraget är felaktigt.
+ __Upplösning:__ Granska `manifest.yml` och se till att allt indrag är korrekt.

### gränsen för memorySize är för låg{#memorysize-limit-is-set-too-low}

+ __Fel:__  Local Dev Server OpenWhiskError: PUT https://adobeioruntime.net/api/v1/namespaces/xxx-xxx-xxx/actions/xxx-0.0.1/__secured_workeroverwrite=true returnerade HTTP 400 (Ogiltig begäran) —> &quot;Innehållet i begäran hade felaktigt format:krav misslyckades: minne 64 MB under det tillåtna tröskelvärdet 134217728 B&quot;
+ __Orsak:__ En `memorySize` gräns för arbetaren i `manifest.yml` angavs under det lägsta tillåtna tröskelvärdet som rapporterades i felmeddelandet i byte.
+ __Upplösning:__  Granska `memorySize` gränserna i `manifest.yml` och se till att alla är större än det lägsta tillåtna tröskelvärdet.

### Utvecklingsverktyget kan inte starta eftersom private.key saknas{#missing-private-key}

+ __Fel:__ Local Dev ServerError: Nödvändiga filer saknas vid validatePrivateKeyFile... (via standard ut från `aio app run` kommando)
+ __Orsak:__ Värdet `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` i `.env` filen pekar inte på `private.key` eller `private.key` är inte läsbart av den aktuella användaren.
+ __Upplösning:__ Granska `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` värdet i `.env` filen och se till att den innehåller den fullständiga, absoluta sökvägen till `private.key` filsystemet.

### Felaktig listruta för källfiler{#source-files-dropdown-incorrect}

Verktyget Resursberäkning kan försättas i ett läge där inaktuella data hämtas och är mest märkbart i listrutan __Källfil__ med felaktiga objekt.

+ __Fel:__ I listrutan Källfil visas felaktiga objekt.
+ __Orsak:__ Inaktuellt cachelagrat webbläsarläge orsakar
+ __Upplösning:__ I webbläsaren rensar du helt webbläsarflikens &quot;programtillstånd&quot;, webbläsarens cache, lokal lagring och servicearbetare.

### Frågeparametern devToolToken saknas eller är ogiltig{#missing-or-invalid-devtooltoken-query-parameter}

+ __Fel:__ Meddelande om&quot;obehörig&quot; i verktyget Resursberäkning
+ __Orsak:__ `devToolToken` saknas eller är ogiltigt
+ __Upplösning:__ Stäng webbläsarfönstret för verktyget Resursberäkning, avsluta alla processer som körs i utvecklingsverktyget och som har initierats via `aio app run` kommandot, och starta om utvecklingsverktyget (med `aio app run`).

### Det går inte att ta bort källfiler{#unable-to-remove-source-files}

+ __Fel:__ Det finns inget sätt att ta bort tillagda källfiler från utvecklingsverktygets användargränssnitt
+ __Orsak:__ Den här funktionen har inte implementerats
+ __Upplösning:__ Logga in på din molnlagringsleverantör med de autentiseringsuppgifter som anges i `.env`. Leta reda på den behållare som används av utvecklingsverktygen (anges även i `.env`), navigera till __källmappen__ och ta bort alla källbilder. Du kan behöva utföra de steg som beskrivs i [Källfiler för att visa en felaktig](#source-files-dropdown-incorrect) lista om de borttagna källfilerna fortfarande visas i listrutan eftersom de kan cachas lokalt i utvecklingsverktygets &quot;programtillstånd&quot;.

   ![Microsoft Azure Blob Storage](./assets/troubleshooting/dev-tool__remove-source-files.png)

## Testa{#test}

### Ingen återgivning genererades under testkörningen{#test-no-rendition-generated}

+ __Fel:__ Fel: Ingen återgivning genererades.
+ __Orsak:__ Arbetaren kunde inte generera en återgivning på grund av ett oväntat fel, till exempel ett JavaScript-syntaxfel.
+ __Upplösning:__ Granska testkörningen `test.log` på `/build/test-results/test-worker/test.log`. Leta reda på avsnittet i den här filen som motsvarar det misslyckade testfallet och granska felen.

   ![Felsökning - Ingen återgivning genererades](./assets/troubleshooting/test__no-rendition-generated.png)

### Testet genererar felaktig återgivning vilket gör att testet misslyckas{#tests-generates-incorrect-rendition}

+ __Fel:__ Fel: Renderingen &#39;rendition.xxx&#39; är inte som förväntat.
+ __Orsak:__ Arbetaren returnerar en återgivning som inte var densamma som `rendition.<extension>` i testfallet.
   + Om den förväntade `rendition.<extension>` filen inte skapas på exakt samma sätt som den lokalt genererade återgivningen i testfallet, kan testet misslyckas eftersom det kan finnas vissa skillnader i bitarna. Om arbetaren Resursberäkning till exempel ändrar kontrasten med hjälp av API:er och det förväntade resultatet skapas genom att justera kontrasten i Adobe Photoshop CC, kan filerna se likadana ut, men mindre bitvariationer kan vara annorlunda.
+ __Upplösning:__ Granska återgivningsutdata från testet genom att navigera till `/build/test-worker/<worker-name>/<test-run-timestamp>/<test-case>/rendition.<extension>`och jämföra dem med den förväntade återgivningsfilen i testfallet. Så här skapar du en exakt förväntad resurs:
   + Använd utvecklingsverktyget för att generera en återgivning, verifiera att den är korrekt och använd den som den förväntade återgivningsfilen
   + Du kan också validera den testgenererade filen på `/build/test-worker/<worker-name>/<test-run-timestamp>/<test-case>/rendition.<extension>`, verifiera att den är korrekt och använda den som den förväntade återgivningsfilen

## Felsök


### Felsökaren är inte kopplad{#debugger-does-not-attach}

+ __Fel__: Fel vid start: Fel: Det gick inte att ansluta till felsökningsmålet vid..
+ __Orsak__: Docker Desktop körs inte på det lokala systemet. Verifiera detta genom att granska VS Code Debug Console (Visa > Debug Console) och bekräfta att felet har rapporterats.
+ __Upplösning__: Starta [Docker Desktop och kontrollera att de nödvändiga Docker-bilderna är installerade](./set-up/development-environment.md#docker).

### Brytpunkter pausas inte{#breakpoints-no-pausing}

+ __Fel__: VS-koden pausar inte vid brytpunkter när arbetaren för beräkning av tillgångar körs från det felsökningsbara utvecklingsverktyget.

#### Felsökning för VS-kod är inte bifogad{#vs-code-debugger-not-attached}

+ __Orsak:__ Felsökningsprogrammet för VS-kod stoppades/kopplades från.
+ __Upplösning:__ Starta om felsökaren för VS-koden och verifiera den genom att titta på konsolen för VS-kodsfelsökning (Visa > Felsökningskonsol)

#### VS-kodfelsökning bifogad efter att körningen av arbetaren påbörjats{#vs-code-debugger-attached-after-worker-execution-began}

+ __Orsak:__ Felsökningsprogrammet för VS-koden kopplades inte innan användaren knackade på __Kör__ i utvecklingsverktyget.
+ __Upplösning:__ Kontrollera att felsökaren har bifogats genom att granska VS-kodens felsökningskonsol (Visa > Felsökningskonsol) och kör sedan om resursens beräkningsarbetare från utvecklingsverktyget.

### Arbetarens timeout vid felsökning{#worker-times-out-while-debugging}

+ __Fel__: Felsökningskonsolen rapporterar &quot;Åtgärd kommer att timeout i -XXX millisekunder&quot; eller [Resursberäkningsutvecklingsverktygets](./develop/development-tool.md) förhandsgranskningsintervall för återgivning varar oändligt eller
+ __Orsak__: Arbetarens timeout som definieras i [manifest.yml](./develop/manifest.md) överskrids under felsökningen.
+ __Upplösning__: Öka tillfälligt arbetarens timeout i [manifest.yml](./develop/manifest.md) eller snabba upp felsökningsaktiviteterna.

### Det går inte att avsluta felsökningsprocessen{#cannot-terminate-debugger-process}

+ __Fel__: `Ctrl-C` på kommandoraden avbryter inte felsökningsprocessen (`npx adobe-asset-compute devtool`).
+ __Orsak__: Ett fel i `@adobe/aio-cli-plugin-asset-compute` 1.3.x gör att det `Ctrl-C` inte känns igen som ett avslutningskommando.
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

+ __Fel:__ Tillgångsbearbetningen misslyckades, märke visas på resursen
+ __Orsak:__ Ett fel uppstod när den anpassade arbetaren kördes
+ __Upplösning:__ Följ anvisningarna om hur du [felsöker Adobe I/O Runtime-aktiveringar](./test-debug/debug.md#aio-app-logs) med `aio app logs`.


