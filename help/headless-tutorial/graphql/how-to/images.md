---
title: Använda bilder med AEM Headless
description: Lär dig hur du begär en referens till URL:er för bildinnehåll och använder anpassade återgivningar med AEM Headless.
version: Cloud Service
topic: Headless
feature: GraphQL API
role: Developer
level: Intermediate
kt: 10253
thumbnail: KT-10253.jpeg
exl-id: 6dbeec28-b84c-4c3e-9922-a7264b9e928c
source-git-commit: ae49fb45db6f075a34ae67475f2fcc5658cb0413
workflow-type: tm+mt
source-wordcount: '1177'
ht-degree: 0%

---

# Bilder med AEM Headless {#images-with-aem-headless}

Bilder är en viktig aspekt av [utveckla multimediala, övertygande AEM headless-upplevelser](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html). AEM Headless hanterar bildresurser och optimerad leverans.

Content Fragments used in AEM Headless content modeling, ofta reference image assets intended for display in the headless experience. AEM GraphQL-frågor kan skrivas för att ange URL:er till bilder baserat på varifrån bilden refereras.

The `ImageRef` -typen har tre URL-alternativ för innehållsreferenser:

+ `_path` är den refererade sökvägen i AEM och innehåller inte AEM (värdnamn)
+ `_authorUrl` är den fullständiga URL:en till bildresursen på AEM Author
   + [AEM Author](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/underlying-technology/introduction-author-publish.html) kan användas för att skapa en förhandsvisning av programmet utan huvud.
+ `_publishUrl` är den fullständiga URL:en till bildresursen på AEM Publish
   + [AEM Publish](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/underlying-technology/introduction-author-publish.html) är vanligtvis där produktionsdistributionen av det headless-programmet visar bilder från.

Fälten används bäst utifrån följande kriterier:

| ImageRef-fält | Klientwebbprogram som hanteras från AEM | Kundappar frågar AEM Author | Kundappfrågor AEM Publish |
|--------------------|:------------------------------:|:-----------------------------:|:------------------------------:|
| `_path` | ✔ | ✔ (App måste ange värd i URL) | ✔ (App måste ange värd i URL) |
| `_authorUrl` | ✘ | ✔ | ✘ |
| `_publishUrl` | ✘ | ✘ | ✔ |

Användning av `_authorUrl` och `_publishUrl` ska anpassas till den AEM GraphQL-slutpunkt som används för att hämta GraphQL-svar.

>[!CONTEXTUALHELP]
>id="aemcloud_learn_headless_graphql_images"
>title="Bilder med AEM Headless"
>abstract="Läs om hur AEM Headless hanterar bildresurser och optimerad leverans."

## Content Fragment Model

Kontrollera att fältet Innehållsfragment som innehåller bildreferensen är av __innehållsreferens__ datatyp.

Fälttyperna granskas i [Content Fragment Model](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-models.html)genom att markera fältet och kontrollera __Egenskaper__ till höger.

![Content Fragment Model med innehållsreferens till en bild](./assets/images/content-fragment-model.jpeg)

## GraphQL beständig fråga

I GraphQL-frågan returnerar du fältet som `ImageRef` skriv och begära lämpliga fält `_path`, `_authorUrl`, eller `_publishUrl` krävs av ditt program. Du kan till exempel ställa frågor till ett äventyr i [WKND-webbplatsprojekt](https://github.com/adobe/aem-guides-wknd) och inkludera bildens URL för bildresursens referenser i dess `primaryImage` fält, kan utföras med en ny beständig fråga `wknd-shared/adventure-image-by-path` definieras som:

```graphql
query ($path: String!) {
  adventureByPath(_path: $path) {
    item {
      title,
      primaryImage {
        ... on ImageRef {
          _path
          _authorUrl
          _publishUrl
        }
      }
    }
  }
}
```

The `$path` variabel som används i `_path` filtret kräver den fullständiga sökvägen till innehållsfragmentet (till exempel `/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp`).

## GraphQL svar

Det resulterande JSON-svaret innehåller de begärda fälten som innehåller URL:erna till bildresurserna.

```json
{
  "data": {
    "adventureByPath": {
      "item": {
        "adventurePrimaryImage": {
          "_path": "/content/dam/wknd-shared/en/adventures/bali-surf-camp/adobestock-175749320.jpg",
          "_authorUrl": "https://author-p123-e456.adobeaemcloud.com/content/dam/wknd-shared/en/adventures/bali-surf-camp/adobestock-175749320.jpg",
          "_publishUrl": "https://publish-p123-e789.adobeaemcloud.com/content/dam/wknd-shared/en/adventures/bali-surf-camp/adobestock-175749320.jpg"
        }
      }
    }
  }
}
```

Använd lämpligt fält för att läsa in den refererade bilden i programmet `_path`, `_authorUrl`, eller `_publishUrl` i `adventurePrimaryImage` som bildens käll-URL.

Domänerna för `_authorUrl` och `_publishUrl` definieras automatiskt av AEM as a Cloud Service med [Externalizer](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developer-tools/externalizer.html).

I Reagera ser bilden från AEM Publish ut så här:

```html
<img src={ data.adventureByPath.item.primaryImage._publishUrl } />
```

## Bildåtergivningar

Bildresurser kan anpassas [återgivningar](../../../assets/authoring/renditions.md), som är alternativa representationer av den ursprungliga resursen. Anpassade renderingar kan underlätta optimeringen av en headless-upplevelse. I stället för att begära den ursprungliga bildresursen, som ofta är en stor högupplöst fil, kan optimerade återgivningar begäras av programmet utan rubriker.

### Skapa återgivningar

AEM Assets-administratörer definierar anpassade återgivningar med Bearbeta profiler. Bearbetningsprofilerna kan sedan användas direkt på specifika mappträd eller resurser för att generera återgivningarna för dessa resurser.

#### Bearbetar profiler

Specifikationer för resursåtergivningar definieras i [Bearbetar profiler](../../../assets/configuring/processing-profiles.md) av AEM Assets administratörer.

Skapa eller uppdatera en Bearbetningsprofil och lägg till återgivningsdefinitioner för de bildstorlekar som krävs för det headless-programmet. Återgivningar kan namnges vad som helst, men bör namnges semantiskt.

![AEM Headless-optimerade renderingar](./assets/images/processing-profiles.png)

I det här exemplet skapas tre renderingar:

| Återgivningsnamn | Tillägg | Maximal bredd |
|-----------------------|:---------:|----------:|
| webboptimerad-stor | webp | 1 200 px |
| webboptimerad-medel | webp | 900 px |
| webboptimerad-liten | webp | 600 px |

Attributen som anropas i tabellen ovan är viktiga:

+ __Återgivningsnamn__ används för att begära återgivningen.
+ __Tillägg__ är tillägget som används för att begära __renderingsnamn__. Föredra `webp` renderingar eftersom dessa är optimerade för webben.
+ __Maximal bredd__ används för att informera utvecklaren om vilken återgivning som ska användas baserat på dess användning i den headless-applikationen.

Återgivningsdefinitioner beror på ditt headless-programs behov, så se till att definiera den optimala återgivningsuppsättningen för ditt användningsfall och att de får semantiska namn med avseende på hur de används.

#### Bearbeta resurser{#reprocess-assets}

När Bearbetningsprofilen har skapats (eller uppdaterats) bearbetar du om materialet för att generera de nya återgivningarna som har definierats i Bearbetningsprofilen. Det finns inga nya återgivningar förrän resurserna har bearbetats med bearbetningsprofilen.

+ Helst [tilldelat bearbetningsprofilen till en mapp](../../../assets/configuring//processing-profiles.md) så att alla nya resurser som överförs till den mappen automatiskt genererar återgivningarna. Befintliga mediefiler måste bearbetas på nytt enligt metoden&quot;a hoc&quot; nedan.

+ Eller, vid behov, genom att välja en mapp eller resurs, välja __Bearbeta resurser igen__ och väljer det nya namnet på bearbetningsprofilen.

   ![Ad hoc-resurser för ombearbetning](./assets/images/ad-hoc-reprocess-assets.jpg)

#### Granska återgivningar

Återgivningar kan valideras av [öppna en återgivningsvy för en resurs](../../../assets/authoring/renditions.md)och välja de nya renderingarna för förhandsgranskning i renderingslisten. Om återgivningarna saknas [se till att resurserna bearbetas med bearbetningsprofilen](#reprocess-assets).

![Granska återgivningar](./assets/images/review-renditions.png)

#### Publicera resurser

Kontrollera att resurserna med de nya återgivningarna är [(re)publicerad](../../../assets/sharing/publish.md) så att de nya återgivningarna är tillgängliga i AEM Publish.

### Åtkomst till renderingar

Återgivningar nås direkt genom att lägga till __renderingsnamn__ och __återgivningstillägg__ som definieras i Bearbetningsprofilen till resursens URL.

| Resurs-URL | Delbana för återgivningar | Återgivningsnamn | Återgivningstillägg |  | Återgivnings-URL |
|-----------|:------------------:|:--------------:|--------------------:|:--:|---|
| https://publish-p123-e789.adobeaemcloud.com/content/dam/example.jpeg | /_jcr_content/renditions/ | webboptimerad-stor | .webp | → | https://publish-p123-e789.adobeaemcloud.com/content/dam/example.jpeg/_jcr_content/renditions/web-optimized-large.webp |
| https://publish-p123-e789.adobeaemcloud.com/content/dam/example.jpeg | /_jcr_content/renditions/ | webboptimerad-medel | .webp | → | https://publish-p123-e789.adobeaemcloud.com/content/dam/example.jpeg/_jcr_content/renditions/web-optimized-medium.webp |
| https://publish-p123-e789.adobeaemcloud.com/content/dam/example.jpeg | /_jcr_content/renditions/ | webboptimerad-liten | .webp | → | https://publish-p123-e789.adobeaemcloud.com/content/dam/example.jpeg/_jcr_content/renditions/web-optimized-small.webp |

{style=&quot;table-layout:auto&quot;}

### GraphQL query{#renditions-graphl-query}

AEM GraphQL kräver ingen extra syntax för att begära bildåtergivningar. Istället [bilderna efterfrågas](#images-graphql-query) på vanligt sätt och önskad återgivning anges i koden. Det är viktigt att [se till att bildresurser som används av det headless-programmet har samma namn på återgivningar](#reprocess-assets).

### Reaktionsexempel

Låt oss skapa ett enkelt React-program som visar tre renderingar, webboptimerade små, webboptimerade, medelstora och webboptimerade stora, av en enda bildresurs.

![Exempel på återgivningar av bildresurser](./assets/images/react-example-renditions.jpg)

#### Skapa bildkomponent{#react-example-image-component}

Skapa en React-komponent som återger bilderna. Komponenten accepterar fyra egenskaper:

+ `assetUrl`: URL:en för bildresursen som anges via svaret från GraphQL-frågan.
+ `renditionName`: Namnet på den återgivning som ska läsas in.
+ `renditionExtension`: Tillägget för återgivningen som ska läsas in.
+ `alt`: Alt-texten för bilden. tillgänglighet är viktigt!

Den här komponenten konstruerar [återgivnings-URL med det format som beskrivs i __Åtkomst till renderingar__](#access-renditions). An `onError` hanteraren är inställd på att visa den ursprungliga resursen om återgivningen saknas.

I det här exemplet används den ursprungliga resursens URL som reserv i `onError` hanteraren, i händelse, saknas en återgivning.

```javascript
// src/Image.js

export default function Image({ assetUrl, renditionName, renditionExtension, alt }) {
  // Construct the rendition Url in the format:
  //   <ASSET URL>/_jcr_content/renditions<RENDITION NAME>.<RENDITION EXTENSION>
  const renditionUrl = `${assetUrl}/_jcr_content/renditions/${renditionName}.${renditionExtension}`;

  // Load the original image asset in the event the named rendition is missing
  const handleOnError = (e) => { e.target.src = assetUrl; }

  return (
    <>
      <img src={renditionUrl} 
            alt={alt} 
            onError={handleOnError}/>
    </>
  );
}
```

#### Definiera `App.js`{#app-js}

Detta enkla `App.js` frågar AEM efter en Adventure-bild och visar sedan bildens tre renderingar: webboptimerad - liten, webboptimerad - medel och webboptimerad - stor.

Fråga mot AEM utförs i den anpassade React-kroken [useAdventureByPath som använder AEM Headless SDK](./aem-headless-sdk.md#graphql-persisted-queries).

Resultatet av frågan och de specifika återgivningsparametrarna skickas till [Bildreaktionskomponent](#react-example-image-component).

```javascript
// src/App.js

import "./App.css";
import { useAdventureByPath } from './api/persistedQueries'
import Image from "./Image";

function App() {

  // Get data from AEM using GraphQL persisted query as defined above 
  // The details of defining a React useEffect hook are explored in How to > AEM Headless SDK
  let { data, error } = useAdventureByPath("/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp");

  // Wait for GraphQL to provide data
  if (!data) { return <></> }

  return (
    <div className="app">
      
      <h2>Small rendition</h2>
      {/* Render the web-optimized-small rendition for the Adventure Primary Image */}
      <Image
        assetUrl={data.adventureByPath.item.primaryImage._publishUrl}
        renditionName="web-optimized-small"
        renditionExtension="webp"
        alt={data.adventureByPath.item.title}
      />

      <hr />

      <h2>Medium rendition</h2>
      {/* Render the web-optimized-medium rendition for the Adventure Primary Image */}
      <Image
        assetUrl={data.adventureByPath.item.primaryImage._publishUrl}
        renditionName="web-optimized-medium"
        renditionExtension="webp"
        alt={data.adventureByPath.item.title}
      />

      <hr />

      <h2>Large rendition</h2>
      {/* Render the web-optimized-large rendition for the Adventure Primary Image */}
      <Image
        assetUrl={data.adventureByPath.item.primaryImage._publishUrl}
        renditionName="web-optimized-large"
        renditionExtension="webp"
        alt={data.adventureByPath.item.title}
      />
    </div>
  );
}

export default App;
```
