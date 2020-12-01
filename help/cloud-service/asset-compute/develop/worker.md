---
title: Utveckla en Asset compute-arbetare
description: asset compute är kärnan i ett Asset compute-projekt och tillhandahåller anpassade funktioner som utför, eller koordinerar, det arbete som utförs på en resurs för att skapa en ny rendering.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6282
thumbnail: KT-6282.jpg
translation-type: tm+mt
source-git-commit: 6f5df098e2e68a78efc908c054f9d07fcf22a372
workflow-type: tm+mt
source-wordcount: '1418'
ht-degree: 0%

---


# Utveckla en Asset compute-arbetare

Arbetare i asset compute är kärnan i ett Asset compute-projekt och tillhandahåller anpassade funktioner som utför, eller koordinerar, det arbete som utförs på en resurs för att skapa en ny rendering.

Asset compute-projektet genererar automatiskt en enkel arbetare som kopierar resursens ursprungliga binärfil till en namngiven återgivning, utan några omformningar. I den här självstudiekursen ska vi modifiera den här arbetaren för att göra en intressantare rendering, för att illustrera Asset compute arbetares styrka.

Vi kommer att skapa en Asset compute-arbetare som genererar en ny vågrät bildåtergivning, som omfattar tomt utrymme till vänster och höger om resursåtergivningen med en oskarp version av resursen. Bredden, höjden och oskärpan för den slutliga återgivningen parametriseras.

## Logiskt flöde för ett anrop till en Asset compute-arbetare

asset compute-arbetare implementerar Asset compute SDK-arbetarens API-kontrakt i funktionen `renditionCallback(...)`, som är begreppsmässigt:

+ __Indata:__ En AEM ursprungliga binära parametrar och parametrar för Bearbeta profil
+ __Utdata:__ en eller flera återgivningar som ska läggas till i AEM

![Logiskt flöde för asset compute-arbetare](./assets/worker/logical-flow.png)

1. AEM Author anropar Asset compute-arbetaren, förutsatt att resursens __(1a)__ ursprungliga binära (`source` parameter) och __(1b)__ alla parametrar som definierats i Bearbetningsprofilen (`rendition.instructions` parameter).
1. Asset compute SDK hanterar körningen av den anpassade Asset compute-metadataarbetarens `renditionCallback(...)`-funktion och genererar en ny binär återgivning baserat på resursens ursprungliga binära __(1a)__ och eventuella parametrar __(1b)__.

   + I den här självstudiekursen skapas renderingen&quot;i arbete&quot;, vilket innebär att arbetaren komponerar renderingen, men källbinärfilen kan skickas till andra webbtjänste-API:er för att renderingen ska genereras.

1. Asset compute-arbetaren sparar den nya återgivningens binära data till `rendition.path`.
1. Binära data som skrivs till `rendition.path` transporteras via Asset compute SDK till AEM Author Service och visas som __(4a)__ en textåtergivning och __(4b)__ beständiga till objektets metadatanod.

Diagrammet ovan redogör för de problem som Asset compute utvecklare står inför och det logiska flödet till Asset compute arbetares anrop. Av nyfikenhet följer att den interna informationen för exekvering av Asset compute[ är tillgänglig, men endast Asset compute SDK API-kontrakt kan vara beroende av.](https://docs.adobe.com/content/help/en/asset-compute/using/extend/custom-application-internals.html)

## Anatomi för en arbetare

Alla Asset compute-arbetare följer samma grundläggande struktur och in-/utdatakontrakt.

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

1. Kontrollera att Asset compute-projektet är öppet i VS-kod
1. Navigera till mappen `/actions/worker`
1. Öppna filen `index.js`

Det här är den JavaScript-fil för arbetare som vi kommer att ändra i den här självstudiekursen.

## Installera och importera stödda npm-moduler

Node.js-baserade projekt i Asset compute har nytta av det stabila [npm-modulens ekosystem](https://npmjs.com). För att kunna utnyttja npm-moduler måste vi först installera dem i vårt Asset compute-projekt.

I den här arbetaren använder vi [jimp](https://www.npmjs.com/package/jimp) för att skapa och ändra återgivningsbilden direkt i Node.js-koden.

>[!WARNING]
>
>Alla NPM-moduler för tillgångsändring stöds inte av Asset compute. npm-moduler som är beroende av befintliga program som ImageMagick eller operativsystemsberoende bibliotek. Det är bäst att begränsa användningen av npm-moduler som bara är för JavaScript.

1. Öppna kommandoraden i roten av ditt Asset compute-projekt (detta kan göras i VS-koden via __Terminal > New Terminal__) och kör kommandot:

   ```
   $ npm install jimp
   ```

1. Importera modulen `jimp` till arbetskoden så att den kan användas via JavaScript-objektet `Jimp`.
Uppdatera `require`-direktiven högst upp i arbetarens `index.js` för att importera `Jimp`-objektet från modulen `jimp`:

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

asset compute kan läsa in parametrar som kan skickas via Bearbeta profiler som definieras i AEM som en författartjänst för Cloud Service. Parametrarna skickas till arbetaren via objektet `rendition.instructions`.

Du kan läsa dessa genom att gå till `rendition.instructions.<parameterName>` i arbetskoden.

Här läser vi i den konfigurerbara återgivningens `SIZE`, `BRIGHTNESS` och `CONTRAST` som tillhandahåller standardvärden om ingen har angetts via Bearbetningsprofilen. Observera att `renditions.instructions` skickas som strängar när de anropas från AEM som en Cloud Service Processing Profiles, så att de omvandlas till rätt datatyper i arbetskoden.

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

## Utlöser fel{#errors}

asset compute-arbetare kan stöta på situationer som leder till fel. Adobe Asset compute SDK innehåller [en serie fördefinierade fel](https://github.com/adobe/asset-compute-commons#asset-compute-errors) som kan genereras när sådana situationer uppstår. Om ingen specifik feltyp finns kan `GenericError` användas eller specifika anpassade `ClientErrors` definieras.

Innan du börjar bearbeta återgivningen bör du kontrollera att alla parametrar är giltiga och stöds i den här arbetarens kontext:

+ Kontrollera att återgivningsinstruktionsparametrarna för `SIZE`, `CONTRAST` och `BRIGHTNESS` är giltiga. Om inte, kan du skapa ett anpassat fel `RenditionInstructionsError`.
   + En anpassad `RenditionInstructionsError`-klass som utökar `ClientError` definieras längst ned i den här filen. Användning av ett specifikt, anpassat fel är användbart när [test](../test-debug/test.md) skrivs för arbetaren.

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

1. Skapa en ny arbetsyta i fyrkantiga dimensioner som anges med parametern `renditionImage`.`size`
1. Skapa ett `image`-objekt från källresursens binärfil
1. Använd biblioteket __Jimp__ för att omforma bilden:
   + Beskär originalbilden till en centrerad kvadrat
   + Klipp ut en cirkel från mitten av den fyrkantiga bilden
   + Anpassa till de dimensioner som definieras av `SIZE`-parametervärdet
   + Justera kontrast baserat på parametervärdet `CONTRAST`
   + Justera intensiteten baserat på parametervärdet `BRIGHTNESS`
1. Placera den omformade `image` mitt i `renditionImage` som har en genomskinlig bakgrund
1. Skriv den sammansatta `renditionImage` till `rendition.path` så att den kan sparas i AEM som en resursåtergivning.

Den här koden använder [Jimp API:er](https://github.com/oliver-moran/jimp#jimp) för att utföra dessa bildomformningar.

asset compute-arbetare måste slutföra sitt arbete synkront och `rendition.path` måste skrivas tillbaka helt till innan arbetarens `renditionCallback` slutförs. Detta kräver att asynkrona funktionsanrop görs synkrona med operatorn `await`. Om du inte är bekant med asynkrona JavaScript-funktioner och hur de ska köras synkront, kan du bekanta dig med [JavaScript-operatorn await](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await).

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

Nu när arbetskoden är klar och har registrerats och konfigurerats i [manifest.yml](./manifest.md) kan den köras med det lokala utvecklingsverktyget i Asset compute för att se resultatet.

1. Från Asset compute-projektets rot
1. Kör `aio app run`
1. Vänta tills Asset compute Development Tool öppnas i ett nytt fönster
1. I __Markera en fil..__ väljer du en exempelbild som ska bearbetas
   + Välj en exempelbildfil som ska användas som källresursens binärfil
   + Om det inte finns någon ännu trycker du på __(+)__ till vänster och överför en [exempelbild](../assets/samples/sample-file.jpg)-fil och uppdaterar webbläsarfönstret för utvecklingsverktyg
1. Uppdatera `"name": "rendition.png"` som den här arbetaren för att skapa en genomskinlig PNG.
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
1. Avsnittet __Återgivningar__ förhandsvisar den återgivning som genereras. Tryck på renderingsförhandsvisningen för att hämta den fullständiga renderingen

   ![PNG-standardåtergivning](./assets/worker/default-rendition.png)

### Kör arbetaren med parametrar

Parametrar, som skickas via Bearbeta profilkonfigurationer, kan simuleras i Asset compute Development Tools genom att tillhandahålla dem som nyckel/värde-par i återgivningsparametern JSON.

>[!WARNING]
>
>Vid lokal utveckling kan värden skickas med olika datatyper, när de skickas från AEM som Cloud Service Processing Profiles as strings, så se till att rätt datatyper analyseras om det behövs.
> Jimps `crop(width, height)`-funktion kräver till exempel att dess parametrar är `int`. Om `parseInt(rendition.instructions.size)` inte tolkas till ett int-värde misslyckas anropet till `jimp.crop(SIZE, SIZE)` eftersom parametrarna inte är kompatibla med typen String.

I vår kod accepteras parametrar för:

+ `size` definierar återgivningens storlek (höjd och bredd som heltal)
+ `contrast` definierar kontrastjusteringen, måste vara mellan -1 och 1, som flyttal
+ `brightness`  definierar den ljusa justeringen, måste vara mellan -1 och 1, som flyttal

Dessa läses i arbetaren `index.js` via:

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

1. Överför andra bilder till listrutan __Källfil__ och försök köra arbetaren mot dem med andra parametrar!

## Worker index.js on Github

Den sista `index.js` finns på Github:

+ [aem-guides-wknd-asset-compute/actions/worker/index.js](https://github.com/adobe/aem-guides-wknd-asset-compute/blob/master/actions/worker/index.js)

## Felsökning

+ [Återgivningen returnerade delvis ritad/skadad](../troubleshooting.md#rendition-returned-partially-drawn-or-corrupt)
