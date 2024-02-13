---
title: Utveckla en metadataarbetare i Asset compute
description: Lär dig hur du skapar en Asset compute-metadataarbetare som härleder de vanligaste färgerna i en bildresurs och skriver tillbaka namnen på färgerna till resursens metadata i AEM.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-6448
thumbnail: 327313.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 6ece6e82-efe9-41eb-adf8-78d9deed131e
duration: 500
source-git-commit: 0400242f6a99bc5209a8b483469d5fd88eac077e
workflow-type: tm+mt
source-wordcount: '1405'
ht-degree: 0%

---

# Utveckla en metadataarbetare i Asset compute

Anpassade Asset compute-arbetare kan producera XMP (XML)-data som skickas tillbaka till AEM och lagras som metadata för en resurs.

Exempel på vanliga användningsområden:

+ Integrering med system från tredje part, t.ex. PIM (Product Information Management System), där ytterligare metadata måste hämtas och lagras på resursen
+ Integrering med Adobes tjänster, som Content and Commerce AI, för att förstärka metadata för resurser med ytterligare inlärningsattribut
+ Hämta metadata om resursen från dess binärfil och lagra den som metadata för resursen AEM as a Cloud Service

## Vad du ska göra

>[!VIDEO](https://video.tv.adobe.com/v/327313?quality=12&learn=on)

I den här självstudiekursen skapar vi en metadataarbetare för Asset compute som hämtar de vanligaste färgerna i en bildresurs och skriver tillbaka namnen på färgerna till resursens metadata i AEM. Även om arbetaren själv är grundläggande används den här självstudien för att utforska hur Asset compute-arbetare kan användas för att skriva tillbaka metadata till resurser på AEM as a Cloud Service.

## Logiskt flöde för anrop av metadataarbetare för Asset compute

Anropet av metadataarbetare i Asset compute är nästan identiskt med anropet från [arbetare för generering av binär återgivning](../develop/worker.md), där den största skillnaden är returtypen är en XMP (XML)-återgivning vars värden också skrivs till resursens metadata.

Asset compute-arbetare implementerar Asset compute SDK-arbetarens API-kontrakt i `renditionCallback(...)` funktion, vilket är begreppsmässigt:

+ __Indata:__ En AEM ursprungliga binära parametrar och parametrar för Bearbetningsprofil
+ __Utdata:__ En XMP (XML) återgivning beständig till AEM som återgivning och till resursens metadata

![Logiskt arbetsflöde för Asset compute-metadataarbetare](./assets/metadata/logical-flow.png)

1. AEM Author anropar metadataarbetaren Asset compute, förutsatt att resursens __(1a)__ originalbinärfil, och __(1b)__ Alla parametrar som har definierats i Bearbetningsprofilen.
1. Asset compute SDK hanterar körningen av den anpassade Asset compute-metadataarbetarens `renditionCallback(...)` funktion, härleda en XMP (XML) återgivning utifrån resursens binära __(1a)__ och eventuella parametrar för bearbetningsprofil __(1b)__.
1. Arbetaren i Asset compute sparar XMP (XML) till `rendition.path`.
1. De XMP (XML)-data som skrivs till `rendition.path` transporteras via Asset compute SDK till AEM Author Service och exponerar det som __(4a)__ en textåtergivning och __(4b)__ beständig till resursens metadatanod.

## Konfigurera manifest.yml{#manifest}

Alla Asset compute-arbetare måste vara registrerade i [manifest.yml](../develop/manifest.md).

Öppna projektets `manifest.yml` och lägga till en arbetarpost som konfigurerar den nya arbetaren, i det här fallet `metadata-colors`.

_Kom ihåg `.yml` är blankstegskänslig._

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

`function` pekar på den arbetarimplementering som har skapats i [nästa steg](#metadata-worker). Namnge arbetare semantiskt (till exempel `actions/worker/index.js` kan ha fått ett bättre namn `actions/rendition-circle/index.js`), som de här visas i [arbetarens URL](#deploy) och även fastställa [arbetarens testsvitens mappnamn](#test).

The `limits` och `require-adobe-auth` konfigureras separat per arbetare. I denna arbetare `512 MB` minne tilldelas när koden inspekterar (eventuellt) stora binära bilddata. Den andra `limits` tas bort för att använda standardvärden.

## Utveckla en metadataarbetare{#metadata-worker}

Skapa en ny JavaScript-fil för metadataarbetare i Asset compute-projektet vid sökvägen [definierad manifest.yml för den nya arbetaren](#manifest), på `/actions/metadata-colors/index.js`

### Installera npm-moduler

Installera de extra npm-modulerna ([@adobe/asset-compute-xmp](https://www.npmjs.com/package/@adobe/asset-compute-xmp?activeTab=versions), [get-image-colors](https://www.npmjs.com/package/get-image-colors)och [color-namer](https://www.npmjs.com/package/color-namer)) som används i denna Asset compute-arbetare.

```
$ npm install @adobe/asset-compute-xmp
$ npm install get-image-colors
$ npm install color-namer
```

### Metadata worker code

Den här arbetaren ser ut ungefär som [återgivningsgenererande arbetare](../develop/worker.md), den största skillnaden är att det skriver XMP (XML)-data till `rendition.path` för att bli sparad i AEM.


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
      // These namespaces are automatically registered in AEM if they do not yet exist
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

Eftersom vårt Asset compute-projekt innehåller två arbetare (föregående [cirkelåtergivning](../develop/worker.md) och `metadata-colors` arbetare), [Asset compute Development Tool&#39;s](../develop/development-tool.md) profildefinitionen listar körningsprofiler för båda arbetarna. Den andra profildefinitionen pekar på den nya `metadata-colors` arbetare.

![XML-metadataåtergivning](./assets/metadata/metadata-rendition.png)

1. Från Asset compute-projektets rot
1. Kör `aio app run` för att starta utvecklingsverktyget Asset compute
1. I __Välj en fil..__ nedrullningsbar meny, välj [exempelbild](../assets/samples/sample-file.jpg) bearbeta
1. I den andra profildefinitionskonfigurationen, som pekar på `metadata-colors` arbetare, uppdatera `"name": "rendition.xml"` eftersom den här arbetaren genererar en XMP (XML) återgivning. Du kan också lägga till en `colorsFamily` parameter (värden som stöds) `basic`, `hex`, `html`, `ntc`, `pantone`, `roygbiv`).

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

1. Tryck __Kör__ och vänta på att XML-återgivningen ska generera
   + Eftersom båda arbetarna är listade i profildefinitionen genereras båda återgivningarna. Den övre profildefinitionen kan också peka på [circle rendering worker](../develop/worker.md) kan tas bort, så att det inte körs från utvecklingsverktyget.
1. The __Återgivningar__ -avsnittet förhandsvisar den genererade återgivningen. Tryck på `rendition.xml` för att ladda ned den och öppna den i VS-koden (eller din favoritredigerare för XML/text) för att granska den.

## Testa arbetaren{#test}

Metadataarbetare kan testas med [samma Asset compute-testningsmiljö som binära återgivningar](../test-debug/test.md). Den enda skillnaden är `rendition.xxx` filen i testfallet måste vara den förväntade XMP (XML) återgivningen.

1. Skapa följande struktur i Asset compute-projektet:

   ```
   /test/asset-compute/metadata-colors/success-pantone/
   
       file.jpg
       params.json
       rendition.xml
   ```

2. Använd [exempelfil](../assets/samples/sample-file.jpg) som testfallet `file.jpg`.
3. Lägg till följande JSON i `params.json`.

   ```
   {
       "fmt": "xml",
       "colorsFamily": "pantone"
   }
   ```

   Anteckna `"fmt": "xml"` måste instruera testsviten att generera en `.xml` textbaserad återgivning.

4. Ange förväntad XML i `rendition.xml` -fil. Detta kan erhållas genom att
   + Kör testindatafilen med utvecklingsverktyget och spara den (validerade) XML-återgivningen.

   ```
   <?xml version="1.0" encoding="UTF-8"?><rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:wknd="https://wknd.site/assets/1.0/"><rdf:Description><wknd:colors><rdf:Seq><rdf:li>Silver</rdf:li><rdf:li>Black</rdf:li><rdf:li>Outer Space</rdf:li></rdf:Seq></wknd:colors><wknd:colorsFamily>pantone</wknd:colorsFamily></rdf:Description></rdf:RDF>
   ```

5. Kör `aio app test` från Asset compute-projektets rot för att köra alla testsviter.

### Distribuera arbetaren till Adobe I/O Runtime{#deploy}

Om du vill anropa den här nya metadataarbetaren från AEM Assets måste den distribueras till Adobe I/O Runtime med kommandot:

```
$ aio app deploy
```

![driftsättning av aio-appar](./assets/metadata/aio-app-deploy.png)

Observera att detta distribuerar alla arbetare i projektet. Granska [ej förkortade distributionsanvisningar](../deploy/runtime.md) för hur du distribuerar till arbetsytorna Stage och Production.

### Integrera med AEM bearbetningsprofiler{#processing-profile}

Anropa arbetaren från AEM genom att skapa en ny, eller ändra en befintlig, anpassad bearbetningsprofiltjänst som anropar den här distribuerade arbetaren.

![Bearbetar profil](./assets/metadata/processing-profile.png)

1. Logga in på AEM as a Cloud Service Author-tjänst som en __AEM__
1. Navigera till __Verktyg > Resurser > Bearbeta profiler__
1. __Skapa__ en ny, eller __redigera__ och befintlig, Bearbetar profil
1. Tryck på __Egen__ och trycka på __Lägg till ny__
1. Definiera den nya tjänsten
   + __Skapa metadataåtergivning__: Växla till aktiv
   + __Slutpunkt:__ `https://...adobeioruntime.net/api/v1/web/wkndAemAssetCompute-0.0.1/metadata-colors`
      + Det här är URL:en till arbetaren som hämtas under [driftsätta](#deploy) eller med kommandot `aio app get-url`. Kontrollera URL-punkterna på rätt arbetsyta baserat på den AEM as a Cloud Service miljön.
   + __Tjänsteparametrar__
      + Tryck __Lägg till parameter__
         + Nyckel: `colorFamily`
         + Värde: `pantone`
            + Värden som stöds: `basic`, `hex`, `html`, `ntc`, `pantone`, `roygbiv`
   + __Mime-typer__
      + __Innehåller:__ `image/jpeg`, `image/png`, `image/gif`, `image/svg`
         + Detta är de enda MIME-typer som stöds av npm-moduler från tredje part som används för att härleda färgerna.
      + __Exkluderar:__ `Leave blank`
1. Tryck __Spara__ längst upp till höger
1. Använd bearbetningsprofilen på en AEM Assets-mapp om detta inte redan är gjort

### Uppdatera metadataschemat{#metadata-schema}

Om du vill granska färgmetadata mappar du två nya fält i bildens metadataram till de nya metadataegenskaper som arbetaren fyller i.

![Metadataschema](./assets/metadata/metadata-schema.png)

1. I AEM Author går du till __Verktyg > Resurser > Metadata Schemas__
1. Navigera till __standard__ och markera och redigera __image__ och lägg till skrivskyddade formulärfält för att visa genererade färgmetadata
1. Lägg till en __Enkelradstext__
   + __Fältetikett__: `Colors Family`
   + __Mappa till egenskap__: `./jcr:content/metadata/wknd:colorsFamily`
   + __Regler > Fält > Inaktivera redigering__: Markerad
1. Lägg till en __Flervärdestext__
   + __Fältetikett__: `Colors`
   + __Mappa till egenskap__: `./jcr:content/metadata/wknd:colors`
1. Tryck __Spara__ längst upp till höger

## Bearbetar resurser

![Tillgångsinformation](./assets/metadata/asset-details.png)

1. I AEM Author går du till __Assets > Files__
1. Navigera till mappen, eller undermappen, som Bearbetningsprofilen tillämpas på
1. Överför en ny bild (JPEG, PNG, GIF eller SVG) till mappen eller bearbeta om befintliga bilder med den uppdaterade [Bearbetar profil](#processing-profile)
1. När bearbetningen är klar markerar du resursen och trycker på __egenskaper__ i det övre åtgärdsfältet för att visa dess metadata
1. Granska `Colors Family` och `Colors` [metadatafält](#metadata-schema) för metadata som skrivits tillbaka från den anpassade metadataarbetaren i Asset compute.

Med färgmetadata skrivna till resursens metadata på `[dam:Asset]/jcr:content/metadata` resurs, är dessa metadata indexerade och ger större möjlighet att upptäcka resurser genom att använda dessa termer via sökning, och de kan även skrivas tillbaka till resursens binärfil om så är fallet __DAM-metadataåterställning__ arbetsflödet anropas.

### Metadataåtergivning i AEM Assets

![AEM Assets metadataåtergivningsfil](./assets/metadata/cqdam-metadata-rendition.png)

Den faktiska XMP som genereras av metadataarbetaren i Asset compute lagras också som en separat återgivning av resursen. Den här filen används vanligtvis inte, i stället används de värden som används för objektets metadatanod, men rå XML-utdata från arbetaren är tillgängliga i AEM.

## metadata-colors worker code on Github

Den slutliga `metadata-colors/index.js` finns på Github:

+ [aem-guides-wknd-asset-compute/actions/metadata-colors/index.js](https://github.com/adobe/aem-guides-wknd-asset-compute/blob/master/actions/metadata-colors/index.js)

Den slutliga `test/asset-compute/metadata-colors` finns på Github:

+ [aem-guides-wknd-asset-compute/test/asset-compute/metadata-colors](https://github.com/adobe/aem-guides-wknd-asset-compute/blob/master/test/asset-compute/metadata-colors)
