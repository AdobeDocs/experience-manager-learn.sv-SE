---
title: Utveckla en metadataarbetare i Asset compute
description: Lär dig hur du skapar en Asset compute-metadataarbetare som härleder de vanligaste färgerna i en bildresurs och skriver tillbaka namnen på färgerna till resursens metadata i AEM.
feature: asset-compute
topics: metadata, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6448
thumbnail: 327313.jpg
translation-type: tm+mt
source-git-commit: c2a8e6c3ae6dcaa45816b1d3efe569126c6c1e60
workflow-type: tm+mt
source-wordcount: '1434'
ht-degree: 0%

---


# Utveckla en metadataarbetare i Asset compute

Anpassade Asset compute-arbetare kan producera XMP (XML)-data som skickas tillbaka till AEM och lagras som metadata för en resurs.

Exempel på vanliga användningsområden:

+ Integrering med system från tredje part, t.ex. PIM (Product Information Management System), där ytterligare metadata måste hämtas och lagras på resursen
+ Integrering med Adobe-tjänster, som Content and Commerce AI, för att förbättra metadata för resurser med ytterligare maskininlärningsattribut
+ Hämta metadata om resursen från dess binärfil och lagra den som metadata i AEM som en Cloud Service

## Vad du ska göra

>[!VIDEO](https://video.tv.adobe.com/v/327313?quality=12&learn=on)

I den här självstudiekursen skapar vi en metadataarbetare för Asset compute som hämtar de vanligaste färgerna i en bildresurs och skriver tillbaka namnen på färgerna till resursens metadata i AEM. Även om arbetaren själv är grundläggande används den här självstudiekursen för att utforska hur Asset compute-arbetare kan användas för att skriva tillbaka metadata till resurser i AEM som en Cloud Service.

## Logiskt flöde för anrop av metadataarbetare för Asset compute

Anropet av metadataarbetare för Asset compute är nästan identiskt med anropet av arbetare [för](../develop/worker.md)binär återgivning, där den primära skillnaden är returtypen är en XMP (XML)-återgivning vars värden också skrivs till resursens metadata.

asset compute-arbetare implementerar Asset compute SDK-arbetarens API-kontrakt i `renditionCallback(...)` funktionen, som är begreppsmässigt:

+ __Indata:__ En AEM ursprungliga binära parametrar och parametrar för Bearbetningsprofil
+ __Utdata:__ En XMP (XML) återgivning beständig till AEM som återgivning och till resursens metadata

![Logiskt arbetsflöde för Asset compute-metadataarbetare](./assets/metadata/logical-flow.png)

1. AEM Author-tjänsten anropar metadataarbetaren i Asset compute, med objektets ursprungliga binärfil __(1a)__ och __(1b)__ alla parametrar som definierats i Bearbetningsprofilen.
1. Asset compute SDK hanterar körningen av den anpassade arbetarens `renditionCallback(...)` funktion för Asset compute-metadata och härleder en XMP (XML)-återgivning baserat på resursens binära __(1a)__ och eventuella parametrar för bearbetningsprofil __(1b)__.
1. Arbetaren i Asset compute sparar XMP (XML) till `rendition.path`.
1. De XMP (XML)-data som skrivs till `rendition.path` överförs via Asset compute SDK till AEM Author Service och visar dem som __(4a)__ en textåtergivning och __(4b)__ beständiga till objektets metadatanod.

## Konfigurera manifest.yml{#manifest}

Alla Asset compute-arbetare måste registreras i [manifest.yml](../develop/manifest.md).

Öppna projektets `manifest.yml` arbetsplats och lägg till en arbetspost som konfigurerar den nya arbetaren, i det här fallet `metadata-colors`.

_Kom ihåg `.yml` att blankstegskänsligt är._

```
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: 
      worker:
        function: actions/worker/index.js 
        web: 'yes' 
        runtime: 'nodejs:12'
        limits:
          timeout: 60000 # in ms
          memorySize: 512 # in MB
          concurrency: 10 
        annotations:
          require-adobe-auth: true
      metadata-colors:
        function: actions/metadata-colors/index.js 
        web: 'yes' 
        runtime: 'nodejs:12'
        limits:
          memorySize: 512 # in MB   
```

`function` pekar på arbetsimplementeringen som skapades i [nästa steg](#metadata-worker). Namnge arbetare semantiskt (t.ex. `actions/worker/index.js` kan ha fått ett bättre namn `actions/rendition-circle/index.js`), eftersom dessa visas i [arbetarens URL](#deploy) och även avgör [arbetarens testsvitens mappnamn](#test).

De `limits` och `require-adobe-auth` konfigureras separat per arbetare. I den här arbetaren tilldelas `512 MB` minne när koden undersöker (eventuellt) stora binära bilddata. Den andra `limits` tas bort för att använda standardvärden.

## Utveckla en metadataarbetare{#metadata-worker}

Skapa en ny JavaScript-fil för metadataarbetare i Asset compute-projektet på den [definierade manifest.yml-sökvägen för den nya arbetaren](#manifest)på `/actions/metadata-colors/index.js`

### Installera npm-moduler

Installera de extra npm-modulerna ([@adobe/asset-compute-xmp](https://www.npmjs.com/package/@adobe/asset-compute-xmp?activeTab=versions), [get-image-colors](https://www.npmjs.com/package/get-image-colors)och [color-namer](https://www.npmjs.com/package/color-namer)) som ska användas i den här Asset compute-arbetaren.

```
$ npm install @adobe/asset-compute-xmp
$ npm install get-image-colors
$ npm install color-namer
```

### Metadata worker code

Den här arbetaren ser ut ungefär som den [återgivningsgenererande arbetaren](../develop/worker.md). Den största skillnaden är att den skriver XMP (XML) data till `rendition.path` för att sparas AEM.


```javascript
"use strict";

const { worker, SourceCorruptError } = require("@adobe/asset-compute-sdk");
const fs = require("fs").promises;

// Require the @adobe/asset-compute-xmp module to create XMP 
const { serializeXmp } = require("@adobe/asset-compute-xmp");

// Require supporting npm modules to derive image colors from image data
const getColors = require("get-image-colors");
// Require supporting npm modules to convert image colors to color names
const namer = require("color-namer");

exports.main = worker(async (source, rendition, params) => {
  // Perform any necessary source (input) checks
  const stats = await fs.stat(source.path);
  if (stats.size === 0) {
    // Throw appropriate errors whenever an erring condition is met
    throw new SourceCorruptError("source file is empty");
  }
  const MAX_COLORS = 10;
  const DEFAULT_COLORS_FAMILY = 'basic';

  // Read the color family parameter to use to derive the color names
  let colorsFamily = rendition.instructions.colorsFamily || DEFAULT_COLORS_FAMILY;

  if (['basic', 'hex', 'html', 'ntc', 'pantone', 'roygbiv'].indexOf(colorsFamily) === -1) { 
      colorsFamily = DEFAULT_COLORS_FAMILY;
  }
  
  // Use the `get-image-colors` module to derive the most common colors from the image
  let colors = await getColors(source.path, { options: MAX_COLORS });

  // Convert the color Chroma objects to their closest names
  let colorNames = colors.map((color) => getColorName(colorsFamily, color));

  // Serialize the data to XMP metadata
  // These properties are written to the [dam:Asset]/jcr:content/metadata resource
  // This stores
  // - The list of color names is stored in a JCR property named `wknd:colors`
  // - The colors family used to derive the color names is stored in a JCR property named `wknd:colorsFamily`
  const xmp = serializeXmp({
      // Use a Set to de-duplicate color names
      "wknd:colors": [...new Set(colorNames)],
      "wknd:colorsFamily": colorsFamily
    }, {
      // Define any property namespaces used in the above property/value definition
      // These namespaces will be automatically registered in AEM if they do not yet exist
      namespaces: {
        wknd: "https://wknd.site/assets/1.0/",
      },
    }
  );

  // Save the XMP metadata to be written back to the asset's metadata node
  await fs.writeFile(rendition.path, xmp, "utf-8");
});

/**
 * Helper function that derives the closest color name for the color, based on the colors family
 * 
 * @param {*} colorsFamily the colors name family to use
 * @param {*} color the color to convert to a name
 */
function getColorName(colorsFamily, color) {
    if ('hex' === colorsFamily) {  return color; }

    let names = namer(color.rgb())[colorsFamily];

    if (names.length >= 1) { return names[0].name; }
}
```

## Kör metadataarbetaren lokalt{#development-tool}

När koden för arbetaren är klar kan den köras med det lokala utvecklingsverktyget i Asset compute.

Eftersom vårt Asset compute-projekt innehåller två arbetare (den tidigare [cirkelrenderingen](../develop/worker.md) och den här `metadata-colors` arbetaren) listas körningsprofiler för båda arbetarna i [Asset compute Development Tool](../develop/development-tool.md) -profildefinitionen. Den andra profildefinitionen pekar på den nya `metadata-colors` arbetaren.

![XML-metadataåtergivning](./assets/metadata/metadata-rendition.png)

1. Från Asset compute-projektets rot
1. Kör `aio app run` för att starta utvecklingsverktyget Asset compute
1. I __Välj en fil..__ listruta, välj en [exempelbild](../assets/samples/sample-file.jpg) som ska bearbetas
1. I den andra profildefinitionskonfigurationen, som pekar på `metadata-colors` arbetaren, kan du uppdatera `"name": "rendition.xml"` allt eftersom arbetaren genererar en XMP (XML) återgivning. Du kan också lägga till en `colorsFamily` parameter (värden som stöds `basic`, `hex`, `html`, `ntc`, `pantone`, `roygbiv`).

   ```json
   {
       "renditions": [
           {
               "worker": "...",
               "name": "rendition.xml",
               "colorsFamily": "pantone"
           }
       ]
   }
   ```
1. Tryck på __Kör__ och vänta på att XML-återgivningen ska generera
   + Eftersom båda arbetarna är listade i profildefinitionen genereras båda återgivningarna. Den övre profildefinitionen som pekar på den [cirkelformade återgivningsarbetaren](../develop/worker.md) kan också tas bort, så att den inte körs i utvecklingsverktyget.
1. I avsnittet __Återgivningar__ förhandsvisas den återgivning som genereras. Tryck på `rendition.xml` för att ladda ned den och öppna den i VS-koden (eller din favoritredigerare för XML/text) för att granska.

## Testa arbetaren{#test}

Metadataarbetare kan testas med [samma Asset compute-testmiljö som binära renderingar](../test-debug/test.md). Den enda skillnaden är att `rendition.xxx` filen i testfallet måste vara den förväntade XMP (XML) återgivningen.

1. Skapa följande struktur i Asset compute-projektet:

   ```
   /test/asset-compute/metadata-colors/success-pantone/
   
       file.jpg
       params.json
       rendition.xml
   ```

2. Använd [exempelfilen](../assets/samples/sample-file.jpg) som testskiftläge `file.jpg`.
3. Lägg till följande JSON i `params.json`.

   ```
   {
       "fmt": "xml",
       "colorsFamily": "pantone"
   }
   ```

   Observera att `"fmt": "xml"` det krävs för att instruera testsviten att generera en `.xml` textbaserad återgivning.

4. Ange förväntad XML i `rendition.xml` filen. Detta kan erhållas genom att
   + Kör testindatafilen med utvecklingsverktyget och spara den (validerade) XML-återgivningen.

   ```
   <?xml version="1.0" encoding="UTF-8"?><rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:wknd="https://wknd.site/assets/1.0/"><rdf:Description><wknd:colors><rdf:Seq><rdf:li>Silver</rdf:li><rdf:li>Black</rdf:li><rdf:li>Outer Space</rdf:li></rdf:Seq></wknd:colors><wknd:colorsFamily>pantone</wknd:colorsFamily></rdf:Description></rdf:RDF>
   ```

5. Kör `aio app test` från roten av Asset compute-projektet för att köra alla testsviter.

### Distribuera arbetaren till Adobe I/O Runtime{#deploy}

Om du vill anropa den här nya metadataarbetaren från AEM Assets måste den distribueras till Adobe I/O Runtime med kommandot:

```
$ aio app deploy
```

![driftsättning av aio-appar](./assets/metadata/aio-app-deploy.png)

Observera att detta distribuerar alla arbetare i projektet. Granska de [ej förkortade distributionsinstruktionerna](../deploy/runtime.md) för hur du distribuerar till arbetsytorna Stage och Production.

### Integrera med AEM bearbetningsprofiler{#processing-profile}

Anropa arbetaren från AEM genom att skapa en ny, eller ändra en befintlig, anpassad bearbetningsprofiltjänst som anropar den här distribuerade arbetaren.

![Bearbetar profil](./assets/metadata/processing-profile.png)

1. Logga in på AEM som Cloud Service Author Service som __AEM Administrator__
1. Navigera till __Verktyg > Resurser > Bearbeta profiler__
1. __Skapa__ en ny, eller __redigera__ och befintlig, bearbetningsprofil
1. Tryck på fliken __Egen__ och tryck sedan på __Lägg till ny__
1. Definiera den nya tjänsten
   + __Skapa metadataåtergivning__: Växla till aktiv
   + __Slutpunkt:__ `https://...adobeioruntime.net/api/v1/web/wkndAemAssetCompute-0.0.1/metadata-colors`
      + Det här är URL:en till arbetaren som hämtas under [distributionen](#deploy) eller med kommandot `aio app get-url`. Kontrollera URL-punkterna på rätt arbetsyta baserat på AEM som en Cloud Service.
   + __Tjänsteparametrar__
      + Tryck på __Lägg till parameter__
         + Nyckel: `colorFamily`
         + Värde: `pantone`
            + Värden som stöds: `basic`, `hex`, `html`, `ntc`, `pantone`, `roygbiv`
   + __Mime-typer__
      + __Innehåller:__ `image/jpeg`, `image/png`, `image/gif`, `image/svg`
         + Detta är de enda MIME-typer som stöds av npm-moduler från tredje part som används för att härleda färgerna.
      + __Exkluderar:__ `Leave blank`
1. Tryck på __Spara__ längst upp till höger
1. Använd bearbetningsprofilen på en AEM Assets-mapp om detta inte redan är gjort

### Uppdatera metadataschemat{#metadata-schema}

Om du vill granska färgmetadata mappar du två nya fält i bildens metadataram till de nya metadataegenskaper som arbetaren fyller i.

![Metadataschema](./assets/metadata/metadata-schema.png)

1. Gå till __Verktyg > Resurser > Metadatascheman i tjänsten AEM Author.__
1. Navigera till __standard__ och markera och redigera __bilden__ och lägg till skrivskyddade formulärfält för att visa de genererade färgmetadata
1. Lägga till en __enkelradstext__
   + __Fältetikett__: `Colors Family`
   + __Mappa till egenskap__: `./jcr:content/metadata/wknd:colorsFamily`
   + __Regler > Fält > Inaktivera redigering__: Markerad
1. Lägga till en __flervärdestext__
   + __Fältetikett__: `Colors`
   + __Mappa till egenskap__: `./jcr:content/metadata/wknd:colors`
1. Tryck på __Spara__ längst upp till höger

## Bearbetar resurser

![Tillgångsinformation](./assets/metadata/asset-details.png)

1. Gå till __Resurser > Filer i tjänsten AEM Author.__
1. Navigera till mappen, eller undermappen, som Bearbetningsprofilen tillämpas på
1. Överför en ny bild (JPEG, PNG, GIF eller SVG) till mappen eller bearbeta om befintliga bilder med den uppdaterade [bearbetningsprofilen](#processing-profile)
1. När bearbetningen är klar markerar du resursen och trycker på __egenskaperna__ i det övre åtgärdsfältet för att visa dess metadata
1. Granska `Colors Family` - och `Colors` metadatafälten [](#metadata-schema) för metadata som skrivits tillbaka från den anpassade metadataarbetaren i Asset compute.

När färgmetadata skrivs till resursens metadata indexeras dessa metadata, vilket gör det möjligt att identifiera resurser med dessa termer via sökning. De kan även skrivas tillbaka till resursens binärfil om arbetsflödet för `[dam:Asset]/jcr:content/metadata` DAM-metadataåterställning ____ anropas.

### Metadataåtergivning i AEM Assets

![AEM Assets metadataåtergivningsfil](./assets/metadata/cqdam-metadata-rendition.png)

Den faktiska XMP som genereras av metadataarbetaren i Asset compute lagras också som en separat återgivning av resursen. Den här filen används vanligtvis inte, i stället används de värden som används för objektets metadatanod, men rå XML-utdata från arbetaren är tillgängliga i AEM.

## metadata-colors worker code on Github

Slutversionen `metadata-colors/index.js` finns på Github:

+ [aem-guides-wknd-asset-compute/actions/metadata-colors/index.js](https://github.com/adobe/aem-guides-wknd-asset-compute/blob/master/actions/metadata-colors/index.js)

Den sista `test/asset-compute/metadata-colors` testsviten finns på Github:

+ [aem-guides-wknd-asset-compute/test/asset-compute/metadata-colors](https://github.com/adobe/aem-guides-wknd-asset-compute/blob/master/test/asset-compute/metadata-colors)
