---
title: Utveckla en Asset Compute-arbetare
description: Resursberäkningspersonal är kärnan i ett tillgångsberäkningsprojekt och tillhandahåller anpassade funktioner som utför, eller koordinerar, arbetet som utförs på en resurs för att skapa en ny återgivning.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6282
thumbnail: KT-6282.jpg
translation-type: tm+mt
source-git-commit: af610f338be4878999e0e9812f1d2a57065d1829
workflow-type: tm+mt
source-wordcount: '1508'
ht-degree: 0%

---


# Utveckla en Asset Compute-arbetare

Resursberäkningspersonal är kärnan i ett tillgångsberäkningsprojekt och tillhandahåller anpassade funktioner som utför, eller koordinerar, arbetet som utförs på en resurs för att skapa en ny återgivning.

Projektet Asset Compute genererar automatiskt en enkel arbetare som kopierar resursens ursprungliga binärfil till en namngiven återgivning, utan några omformningar. I den här självstudiekursen ska vi modifiera den här arbetaren för att göra en intressantare rendering, för att illustrera kraften hos Assets Compute-arbetarna.

Vi kommer att skapa en Asset Compute-arbetare som genererar en ny vågrät bildåtergivning som omfattar tomt utrymme till vänster och höger om resursåtergivningen med en oskarp version av resursen. Bredden, höjden och oskärpan för den slutliga återgivningen parametriseras.

## Logiskt flöde för ett anrop av en Asset Compute-arbetare

Resursberäkningspersonal implementerar ett API för SDK-arbetaren i Asset Compute i `renditionCallback(...)` funktionen, vilket är begreppsmässigt:

+ __Indata:__ En AEM ursprungliga resurs binära och parametrar
+ __Utdata:__ En eller flera återgivningar som ska läggas till i AEM

![Logiskt arbetsflöde för beräkning av tillgångar](./assets/worker/logical-flow.png)

1. När en Asset Compute-arbetare anropas från AEM Author-tjänsten är den mot en AEM resurs via en Bearbetningsprofil. Resursens ursprungliga binärfil __(1a)__ skickas till arbetaren via återgivningsfunktionens `source` parameter och __(1b)__ alla parametrar som definierats i Bearbetningsprofilen via `rendition.instructions` parameteruppsättning.
1. SDK-lagret Resursberäkning accepterar begäran från bearbetningsprofilen och koordinerar körningen av den anpassade `renditionCallback(...)` funktionen Resursberäkning, vilket omformar källans binärfil som anges i __(1a)__ baserat på parametrar som anges i __(1b)__ för att generera en återgivning av källans binärfil.
   + I den här självstudiekursen skapas renderingen&quot;i arbete&quot;, vilket innebär att arbetaren komponerar renderingen, men källbinärfilen kan skickas till andra webbtjänste-API:er för att renderingen ska genereras.
1. Resursberäkningsarbetaren sparar återgivningens binära representation som gör den tillgänglig `rendition.path` för sparande i AEM Author-tjänsten.
1. När de är klara `rendition.path` skickas de binära data som skrivs till via SDK för tillgångsberäkning och visas via AEM Author Service som en rendering i det AEM användargränssnittet.

Diagrammet ovan visar frågor som rör tillgångsberäkningens utvecklare och det logiska flödet för att anropa en tillgångsberäknings-arbetare. Av nyfikenhet att det finns [interna detaljer om hur Resurser körs](https://docs.adobe.com/content/help/en/asset-compute/using/extend/custom-application-internals.html) , men endast API-kontrakt för beräkning av offentliga tillgångar bör vara beroende av.

## Anatomi för en arbetare

Alla tillgångsberäkningspersonal följer samma grundläggande struktur och in-/utdatakontrakt.

```javascript
'use strict';

// Any npm module imports used by the worker
const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

/**
Exports the worker implemented by a custom rendition callback function, which parametrizes the input/output contract for the worker.
 + `source` represents the asset's original binary used as the input for the worker.
 + `rendition` represents the worker's output, which is the creation of a new asset rendition.
 + `params` are optional parameters, which map to additional key/value pairs, including a sub `auth` object that contains Adobe I/O access credentials.
**/
exports.main = worker(async (source, rendition, params) => {
    // Perform any necessary source (input) checks
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        // Throw appropriate errors whenever an erring condition is met
        throw new SourceCorruptError('source file is empty');
    }

    // Access any custom parameters provided via the Processing Profile configuration
    let param1 = rendition.instructions.exampleParam;

    /** 
    Perform all work needed to transform the source into the rendition.
    
    The source data can be accessed:
        + In the worker via a file available at `source.path`
        + Or via a presigned GET URL at `source.url`
    **/
    if (success) {
        // A successful worker must write some data back to `renditions.path`. 
        // This example performs a trivial 1:1 copy of the source binary to the rendition
        await fs.copyFile(source.path, rendition.path);
    } else {
        // Upon failure an Asset Compute Error (exported by @adobe/asset-compute-commons) should be thrown.
        throw new GenericError("An error occurred!", "example-worker");
    }
});

/**
Optionally create helper classes or functions the worker's rendition callback function invokes to help organize code.

Code shared across workers, or to complex to be managed in a single file, can be broken out across supporting JavaScript files in the project and imported normally into the worker. 
**/
function customHelperFunctions() { ... }
```

## Öppnar arbetarens index.js

![Autogenererat index.js](./assets/worker/autogenerated-index-js.png)

1. Se till att projektet Resursberäkning är öppet i VS-kod
1. Navigate to the `/actions/worker` folder
1. Open the `index.js` file

Det här är den JavaScript-fil för arbetare som vi kommer att ändra i den här självstudiekursen.

## Installera och importera stödda npm-moduler

Resursberäkningsprojekt som baseras på Node.js utnyttjar det robusta ekosystemet i [npm-modulen](https://npmjs.com). För att kunna utnyttja npm-moduler måste vi först installera dem i vårt Asset Compute-projekt.

I den här arbetaren använder vi [jimp](https://www.npmjs.com/package/jimp) för att skapa och ändra återgivningsbilden direkt i Node.js-koden.

>[!WARNING]
>
>Alla NPM-moduler för tillgångsändring stöds inte av tillgångsberäkning. npm-moduler som är beroende av befintliga program som ImageMagick eller operativsystemsberoende bibliotek. Det är bäst att begränsa användningen av npm-moduler som bara är för JavaScript.

1. Öppna kommandoraden i roten av projektet Resursberäkning (detta kan göras i VS-koden via __Terminal > New Terminal__) och kör kommandot:

   ```
   $ npm install jimp
   ```

1. Importera `jimp` modulen till arbetskoden så att den kan användas via `Jimp` JavaScript-objektet.
Uppdatera `require` direktiven högst upp i arbetarens `index.js` för att importera `Jimp` objektet från `jimp` modulen:

   ```javascript
   'use strict';
   
   const { Jimp } = require('jimp');
   const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
   const fs = require('fs').promises;
   
   exports.main = worker(async (source, rendition, params) => {
       // Check handle a corrupt input source
       const stats = await fs.stat(source.path);
       if (stats.size === 0) {
           throw new SourceCorruptError('source file is empty');
       }
   
       // Do work here
   });
   ```

## Läsa parametrar

Resursberäkningspersonal kan läsa i parametrar som kan skickas via Bearbeta profiler som definierats i AEM som en författartjänst för Cloud Service. Parametrarna skickas till arbetaren via `rendition.instructions` objektet.

Dessa kan läsas genom åtkomst `rendition.instructions.<parameterName>` i arbetskoden.

Här läser vi de konfigurerbara återgivningarna `SIZE`och `BRIGHTNESS` `CONTRAST`anger standardvärden om ingen har angetts via Bearbetningsprofilen. Observera att `renditions.instructions` skickas som strängar när de anropas från AEM som en Cloud Service Processing Profiles, så se till att de omvandlas till rätt datatyper i arbetskoden.

```javascript
'use strict';

const { Jimp } = require('jimp');
const { worker, SourceCorruptError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Read in parameters and set defaults if parameters are provided
    // Processing Profiles pass in instructions as Strings, so make sure to parse to correct data types
    const SIZE = parseInt(rendition.instructions.size) || 800; 
    const CONTRAST = parseFloat(rendition.instructions.contrast) || 0;
    const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0;

    // Do work here
}
```

## Utlösande fel{#errors}

Resursberäkningspersonal kan stöta på situationer som leder till fel. Adobe Asset Compute SDK innehåller [en serie fördefinierade fel](https://github.com/adobe/asset-compute-commons#asset-compute-errors) som kan genereras när sådana situationer uppstår. Om ingen specifik feltyp finns kan den `GenericError` användas eller `ClientErrors` definieras.

Innan du börjar bearbeta återgivningen bör du kontrollera att alla parametrar är giltiga och stöds i den här arbetarens kontext:

+ Kontrollera att återgivningsinstruktionsparametrarna för `SIZE`, `CONTRAST`och `BRIGHTNESS` är giltiga. Om inte, kan du skapa ett anpassat fel `RenditionInstructionsError`.
   + En anpassad `RenditionInstructionsError` klass som utökas `ClientError` definieras längst ned i den här filen. Användning av ett specifikt, anpassat fel är användbart när du [skriver tester](../test-debug/test.md) för arbetaren.

```javascript
'use strict';

const { Jimp } = require('jimp');
// Import the Asset Compute SDK provided `ClientError` 
const { worker, SourceCorruptError, ClientError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    // Read in parameters and set defaults if parameters are provided
    const SIZE = parseInt(rendition.instructions.size) || 800; 
    const CONTRAST = parseFloat(rendition.instructions.contrast) || 0;
    const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0;

    if (SIZE <= 10 || SIZE >= 10000) {
        // Ensure size is within allowable bounds
        throw new RenditionInstructionsError("'size' must be between 10 and 1,0000");
    } else if (CONTRAST <= -1 || CONTRAST >= 1) {
        // Ensure contrast is valid value
        throw new RenditionInstructionsError("'contrast' must between -1 and 1");
    } else if (BRIGHTNESS <= -1 || BRIGHTNESS >= 1) {
        // Ensure contrast is valid value
        throw new RenditionInstructionsError("'brightness' must between -1 and 1");
    }

    // Do work here
}

// Create a new ClientError to handle invalid rendition.instructions values
class RenditionInstructionsError extends ClientError {
    constructor(message) {
        // Provide a:
        // + message: describing the nature of this erring condition
        // + name: the name of the error; usually same as class name
        // + reason: a short, searchable, unique error token that identifies this error
        super(message, "RenditionInstructionsError", "rendition_instructions_error");

        // Capture the strack trace
        Error.captureStackTrace(this, RenditionInstructionsError);
    }
}
```

## Skapa återgivningen

När parametrarna har lästs, sanerats och validerats skrivs koden för att generera återgivningen. Pseudokoden för återgivningsgenereringen är följande:

1. Skapa en ny `renditionImage` arbetsyta i fyrkantiga dimensioner som anges med `size` parametern.
1. Skapa ett `image` objekt från källresursens binärfil
1. Använd __Jimp__ Library för att omvandla bilden:
   + Beskär originalbilden till en centrerad kvadrat
   + Klipp ut en cirkel från mitten av den fyrkantiga bilden
   + Anpassa till de dimensioner som definieras av `SIZE` parametervärdet
   + Justera kontrast baserat på `CONTRAST` parametervärdet
   + Justera intensiteten baserat på `BRIGHTNESS` parametervärdet
1. Placera den omformade `image` i mitten av den `renditionImage` som har en genomskinlig bakgrund
1. Skriv det sammansatta så att `renditionImage` `rendition.path` det kan sparas i AEM som en resursåtergivning.

I den här koden används [Jimp API:er](https://github.com/oliver-moran/jimp#jimp) för att utföra dessa bildomformningar.

Resursberäkningspersonalen måste slutföra sitt arbete synkront och `rendition.path` måste skrivas tillbaka helt innan arbetarens `renditionCallback` slutförs. Detta kräver att asynkrona funktionsanrop görs synkrona med operatorn `await` . Om du inte känner till asynkrona JavaScript-funktioner och hur de kan köras synkront, kan du bekanta dig med [JavaScript-operatorn](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await)await.

Den färdiga arbetaren `index.js` ska se ut så här:

```javascript
'use strict';

const Jimp = require('jimp');
const { worker, SourceCorruptError, ClientError } = require('@adobe/asset-compute-sdk');
const fs = require('fs').promises;

exports.main = worker(async (source, rendition, params) => {
    const stats = await fs.stat(source.path);
    if (stats.size === 0) {
        throw new SourceCorruptError('source file is empty');
    }

    const SIZE = parseInt(rendition.instructions.size) || 800; 
    const CONTRAST = parseFloat(rendition.instructions.contrast) || 0;
    const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0;

    if (SIZE <= 10 || SIZE >= 10000) {
        throw new RenditionInstructionsError("'size' must be between 10 and 10,000");
    } else if (CONTRAST <= -1 || CONTRAST >= 1) {
        throw new RenditionInstructionsError("'contrast' must between -1 and 1");
    } else if (BRIGHTNESS <= -1 || BRIGHTNESS >= 1) {
        throw new RenditionInstructionsError("'brightness' must between -1 and 1");
    }

    // Create target rendition image of the target size with a transparent background (0x0)
    let renditionImage =  new Jimp(SIZE, SIZE, 0x0);

    // Read and perform transformations on the source binary image
    let image = await Jimp.read(source.path);

    // Crop a circle from the source asset, and then apply contrast and brightness using Jimp
    image.crop(
            image.bitmap.width < image.bitmap.height ? 0 : (image.bitmap.width - image.bitmap.height) / 2,
            image.bitmap.width < image.bitmap.height ? (image.bitmap.height - image.bitmap.width) / 2 : 0,
            image.bitmap.width < image.bitmap.height ? image.bitmap.width : image.bitmap.height,
            image.bitmap.width < image.bitmap.height ? image.bitmap.width : image.bitmap.height
        )   
        .circle()
        .scaleToFit(SIZE, SIZE)
        .contrast(CONTRAST)
        .brightness(BRIGHTNESS);

    // Place the transformed image onto the transparent renditionImage to save as PNG
    renditionImage.composite(image, 0, 0)

    // Write the final transformed image to the asset's rendition
    renditionImage.write(rendition.path);
});

// Custom error used for renditions.instructions parameter checking
class RenditionInstructionsError extends ClientError {
    constructor(message) {
        super(message, "RenditionInstructionsError", "rendition_instructions_error");
        Error.captureStackTrace(this, RenditionInstructionsError);
    }
}
```

## Arbetaren körs

Nu när arbetskoden är klar och har registrerats och konfigurerats i [manifest.yml](./manifest.md)kan den köras med det lokala verktyget för utveckling av resursuppdatering för att se resultatet.

1. Från roten i projektet Asset Compute
1. Kör `app aio run`
1. Vänta tills verktyget Resursberäkning har öppnats i ett nytt fönster
1. I __Välj en fil..__ välj en exempelbild som ska bearbetas
   + Välj en exempelbildfil som ska användas som källresursens binärfil
   + Om det inte finns någon ännu trycker du på __(+)__ till vänster och överför en [exempelbildfil](../assets/samples/sample-file.jpg) , och uppdaterar webbläsarfönstret Utvecklingsverktyg
1. Uppdatera `"name": "rendition.png"` som den här arbetaren för att generera en genomskinlig PNG.
   + Observera att den här&quot;name&quot;-parametern bara används för utvecklingsverktyget och inte ska förlita sig på.

   ```json
   {
       "renditions": [
           {
               "worker": "...",
               "name": "rendition.png"
           }
       ]
   }
   ```
1. Tryck på __Kör__ och vänta tills återgivningen genereras
1. I avsnittet __Återgivningar__ förhandsvisas den återgivning som genereras. Tryck på renderingsförhandsvisningen för att hämta den fullständiga renderingen

   ![PNG-standardåtergivning](./assets/worker/default-rendition.png)

### Kör arbetaren med parametrar

Parametrar, som skickas via Bearbeta profilkonfigurationer, kan simuleras i utvecklingsverktygen för tillgångsberäkning genom att tillhandahålla dem som nyckel/värde-par i återgivningsparametern JSON.

>[!WARNING]
>
>Vid lokal utveckling kan värden skickas med olika datatyper, när de skickas från AEM som Cloud Service Processing Profiles as strings, så se till att rätt datatyper analyseras om det behövs.
> Jimp `crop(width, height)` -funktionen kräver till exempel att dess parametrar är `int`s. Om `parseInt(rendition.instructions.size)` inte parsas till ett int-värde misslyckas anropet till `jimp.crop(SIZE, SIZE)` eftersom parametrarna inte är kompatibla med typen String.

I vår kod accepteras parametrar för:

+ `size` definierar återgivningens storlek (höjd och bredd som heltal)
+ `contrast` definierar kontrastjusteringen, måste vara mellan -1 och 1, som flyttal
+ `brightness`  definierar den ljusa justeringen, måste vara mellan -1 och 1, som flyttal

Dessa läses in i arbetaren `index.js` via:

+ `const SIZE = parseInt(rendition.instructions.size) || 800`
+ `const CONTRAST = parseFloat(rendition.instructions.contrast) || 0`
+ `const BRIGHTNESS = parseFloat(rendition.instructions.brightness) || 0`

1. Uppdatera återgivningsparametrarna för att anpassa storlek, kontrast och intensitet.

   ```json
   {
       "renditions": [
           {
               "worker": "...",
               "name": "rendition.png",
               "size": "450",
               "contrast": "0.30",
               "brightness": "0.15"
           }
       ]
   }
   ```

1. Tryck på __Kör__ igen
1. Tryck på förhandsvisningen av återgivningen för att hämta och granska den genererade återgivningen. Observera dess dimensioner och hur kontrast och intensitet har ändrats jämfört med standardåtergivningen.

   ![Parameteriserad PNG-rendering](./assets/worker/parameterized-rendition.png)

1. Överför andra bilder till listrutan __Källfil__ och försök köra arbetaren mot dem med olika parametrar!

## Worker index.js on Github

Slutversionen `index.js` finns på Github:

+ [aem-guides-wknd-asset-compute/actions/worker/index.js](https://github.com/adobe/aem-guides-wknd-asset-compute/blob/master/actions/worker/index.js)

## Felsökning

### Återgivning returneras delvis ritad

+ __Fel__: Återgivningen återges inte fullständigt när den totala återgivningsfilstorleken är stor

   ![Felsökning - Återgivningen återställs delvis](./assets/worker/troubleshooting__await.png)

+ __Orsak__: Arbetarens `renditionCallback` funktion avslutas innan återgivningen kan skrivas till `rendition.path`.
+ __Upplösning__: Granska den anpassade arbetskoden och se till att alla asynkrona anrop görs synkrona.
