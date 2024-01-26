---
title: Använda optimerade bilder med AEM Headless
description: Lär dig hur du begär optimerade bild-URL:er med AEM Headless.
version: Cloud Service
topic: Headless
feature: GraphQL API
role: Developer
level: Intermediate
jira: KT-10253
thumbnail: KT-10253.jpeg
last-substantial-update: 2023-04-19T00:00:00Z
exl-id: 6dbeec28-b84c-4c3e-9922-a7264b9e928c
duration: 377
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '901'
ht-degree: 0%

---

# Optimerade bilder med AEM Headless {#images-with-aem-headless}

Bilder är en viktig aspekt av [utveckla multimediala, övertygande AEM headless-upplevelser](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html). AEM Headless hanterar bildresurser och optimerad leverans.

Content Fragments used in AEM Headless content modeling, ofta reference image assets intended for display in the headless experience. AEM GraphQL-frågor kan skrivas för att ange URL:er till bilder baserat på varifrån bilden refereras.

The `ImageRef` -typen har fyra URL-alternativ för innehållsreferenser:

+ `_path` är den refererade sökvägen i AEM och innehåller inte AEM (värdnamn)
+ `_dynamicUrl` är den fullständiga URL:en till den webboptimerade bildresursen.
   + The `_dynamicUrl` innehåller inte AEM ursprung, så domänen (AEM författare eller AEM publiceringstjänst) måste anges av klientprogrammet.
+ `_authorUrl` är den fullständiga URL:en till bildresursen på AEM författare
   + [AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/underlying-technology/introduction-author-publish.html) kan användas för att skapa en förhandsvisning av programmet utan huvud.
+ `_publishUrl` är den fullständiga URL:en till bildresursen vid AEM
   + [AEM Publish](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/underlying-technology/introduction-author-publish.html) är vanligtvis där produktionsdistributionen av det headless-programmet visar bilder från.

The `_dynamicUrl` är den URL som ska användas för bildresurser och bör ersätta användningen av `_path`, `_authorUrl`och `_publishUrl` om möjligt.

|                                | AEM as a Cloud Service | AEM as a Cloud Service RDE | AEM SDK | AEM 6.5 |
| ------------------------------ |:----------------------:|:--------------------------:|:-------:|:-------:|
| Stöder webboptimerade bilder? | ✔ | ✔ | ✘ | ✘ |


>[!CONTEXTUALHELP]
>id="aemcloud_learn_headless_graphql_images"
>title="Bilder med AEM Headless"
>abstract="Läs om hur AEM Headless hanterar bildresurser och optimerad leverans."

## Content Fragment Model

Kontrollera att fältet Innehållsfragment som innehåller bildreferensen är av __innehållsreferens__ datatyp.

Fälttyperna granskas i [Content Fragment Model](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-models.html)genom att markera fältet och kontrollera __Egenskaper__ till höger.

![Content Fragment Model med innehållsreferens till en bild](./assets/images/content-fragment-model.jpeg)

## GraphQL beständig fråga

I GraphQL-frågan returnerar du fältet `ImageRef` och begär `_dynamicUrl` fält. Du kan till exempel ställa frågor till ett äventyr i [WKND-webbplatsprojekt](https://github.com/adobe/aem-guides-wknd) och inkludera bildens URL för bildresursens referenser i dess `primaryImage` fält, kan utföras med en ny beständig fråga `wknd-shared/adventure-image-by-path` definieras som:

```graphql {highlight="11"}
query($path: String!, $imageFormat: AssetTransformFormat=JPG, $imageSeoName: String, $imageWidth: Int, $imageQuality: Int) {
  adventureByPath(
    _path: $path
    _assetTransform: {
      format: $imageFormat
      width: $imageWidth
      quality: $imageQuality
      preferWebp: true
    }
  ) {
    item {
      _path
      title
      primaryImage {
        ... on ImageRef {
          _dynamicUrl
        }
      }
    }
  }
}
```

### Frågevariabler

```json
{ 
  "path": "/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp",
  "imageFormat": "JPG",
  "imageWidth": 1000,
}
```

The `$path` variabel som används i `_path` filtret kräver den fullständiga sökvägen till innehållsfragmentet (till exempel `/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp`).

The `_assetTransform` definierar hur `_dynamicUrl` är konstruerad för att optimera den serverade bildåtergivningen. Webbadresserna för webboptimerade bilder kan också justeras på klienten genom att URL-adressens frågeparametrar ändras.

| GraphQL-parameter | URL-parameter | Beskrivning | Obligatoriskt | GraphQL variabelvärden | URL-parametervärden | Exempel på URL-parameter |
|:---------|:----------|:-------------------------------|:--:|:--------------------------|:---|:--|
| `format` | Ej tillämpligt | Bildresursens format. | ✔ | `GIF`, `PNG`, `PNG8`, `JPG`, `PJPG`, `BJPG`,  `WEBP`, `WEBPLL`, `WEBPLY` | Ej tillämpligt | Ej tillämpligt |
| `seoName` | Ej tillämpligt | Namn på filsegment i URL. Om inget anges används bildresursnamnet. | ✘ | Alfanumeriska, `-`, eller `_` | Ej tillämpligt | Ej tillämpligt |
| `crop` | `crop` | Beskär bildrutor som tagits ut från bilden, måste vara inom bildens storlek | ✘ | Positiva heltal som definierar ett beskärningsområde inom gränserna för de ursprungliga bilddimensionerna | Kommaavgränsad sträng med numeriska koordinater `<X_ORIGIN>,<Y_ORIGIN>,<CROP_WIDTH>,<CROP_HEIGHT>` | `?crop=10,20,300,400` |
| `size` | `size` | Storlek på utdatabilden (både höjd och bredd) i pixlar. | ✘ | Positiva heltal | Kommaavgränsade positiva heltal i ordningen `<WIDTH>,<HEIGHT>` | `?size=1200,800` |
| `rotation` | `rotate` | Bildens rotation i grader. | ✘ | `R90`, `R180`, `R270` | `90`, `180`, `270` | `?rotate=90` |
| `flip` | `flip` | Vänd bilden. | ✘ | `HORIZONTAL`, `VERTICAL`, `HORIZONTAL_AND_VERTICAL` | `h`, `v`, `hv` | `?flip=h` |
| `quality` | `quality` | Bildkvaliteten i procent av den ursprungliga kvaliteten. | ✘ | 1-100 | 1-100 | `?quality=80` |
| `width` | `width` | Utdatabildens bredd i pixlar. När `size` anges `width` ignoreras. | ✘ | Positivt heltal | Positivt heltal | `?width=1600` |
| `preferWebP` | `preferwebp` | If `true` och AEM fungerar som en WebP om webbläsaren stöder det, oavsett `format`. | ✘ | `true`, `false` | `true`, `false` | `?preferwebp=true` |

## GraphQL svar

Det resulterande JSON-svaret innehåller de begärda fälten som innehåller den webboptimerade URL:en till bildresurserna.

```json {highlight="8"}
{
  "data": {
    "adventureByPath": {
      "item": {
        "_path": "/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp",
        "title": "Bali Surf Camp",
        "primaryImage": {
          "_dynamicUrl": "/adobe/dynamicmedia/deliver/dm-aid--a38886f7-4537-4791-aa20-3f6ef0ac3fcd/adobestock_175749320.jpg?preferwebp=true&width=1000&quality=80"
        }
      }
    }
  }
}
```

Om du vill läsa in den webboptimerade bilden av den refererade bilden i ditt program använder du `_dynamicUrl` i `primaryImage` som bildens käll-URL.

I Reagera ser det ut så här när en webboptimerad bild från AEM Publicera visas:

```jsx
// The AEM host is usually read from a environment variable of the SPA.
const AEM_HOST = "https://publish-p123-e456.adobeaemcloud.com";
...
let dynamicUrl = AEM_HOST + data.adventureByPath.item.primaryImage._dynamicUrl;
...
<img src={dynamicUrl} alt={data.adventureByPath.item.title}/>
```

Kom ihåg: `_dynamicUrl` innehåller inte den AEM domänen, så du måste ange det önskade ursprunget för den bild-URL som ska tolkas.

## Responsiva URL:er

Exemplet ovan visar hur du använder en bild med en storlek, men i webbupplevelser krävs ofta responsiva bilduppsättningar. Responsiva bilder kan implementeras med [img srcsets](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset) eller [bildelement](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset). Följande kodfragment visar hur du använder `_dynamicUrl` som en baserad bild, och som tillägg till olika breddparametrar, för att driva olika responsiva vyer. Inte bara `width` frågeparametern kan användas, men andra frågeparametrar kan läggas till av klienten för att ytterligare optimera bildresursen utifrån dess behov.

```javascript
// The AEM host is usually read from a environment variable of the SPA.
const AEM_HOST = "https://publish-p123-e456.adobeaemcloud.com";
...
// Read the data from GraphQL response
let dynamicUrl = AEM_HOST + data.adventureByPath.item.primaryImage._dynamicUrl;
let alt = data.adventureByPath.item.title;
...
{/*-- Example img srcset --*/}
document.body.innerHTML=`<img>
    alt="${alt}"
    src="${dynamicUrl}&width=1000}"
    srcset="`
      ${dynamicUrl}&width=1000 1000w,
      ${dynamicUrl}&width=1600 1600w,
      ${dynamicUrl}&width=2000 2000w,
      `"
    sizes="calc(100vw - 10rem)"/>`;
...
{/*-- Example picture --*/}
document.body.innerHTML=`<picture>
      <source srcset="${dynamicUrl}&width=2600" media="(min-width: 2001px)"/>
      <source srcset="${dynamicUrl}&width=2000" media="(min-width: 1000px)"/>
      <img src="${dynamicUrl}&width=400" alt="${alt}"/>
    </picture>`;
```

## Reaktionsexempel

Låt oss skapa ett enkelt React-program som visar webboptimerade bilder efter [responsiva bildmönster](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/). Det finns två huvudmönster för responsiva bilder:

+ [Img-element med srset](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset) för bättre prestanda
+ [Bildelement](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-picture) för designkontroll

### Img-element med srset

>[!VIDEO](https://video.tv.adobe.com/v/3418556/?quality=12&learn=on)

[Bildelement med skärpa](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset) används med `sizes` för att tillhandahålla olika bildresurser för olika skärmstorlekar. Bilduppsättningar är användbara när du tillhandahåller olika bildresurser för olika skärmstorlekar.

### Bildelement

[Bildelement](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-picture) används med flera `source` -element om du vill ha olika bildresurser för olika skärmstorlekar. Bildelement är användbara när du vill ha olika bildåtergivningar för olika skärmstorlekar.

>[!VIDEO](https://video.tv.adobe.com/v/3418555/?quality=12&learn=on)

### Exempelkod

Den här enkla React-appen använder [AEM Headless SDK](./aem-headless-sdk.md) för att fråga AEM Headless API:er om ett Adventure-innehåll och visa den webboptimerade bilden med [img-element med resurs](#img-element-with-srcset) och [bildelement](#picture-element). The `srcset` och `sources` använda en anpassad `setParams` funktion för att lägga till den webboptimerade parametern för leveransfråga i `_dynamicUrl` av bilden, så ändra den bildåtergivning som levereras baserat på webbklientens behov.

Fråga mot AEM utförs i den anpassade React-kroken [useAdventureByPath som använder AEM Headless SDK](./aem-headless-sdk.md#graphql-persisted-queries).

```javascript
// src/App.js

import "./App.css";
import { useAdventureByPath } from './api/persistedQueries'

const AEM_HOST = process.env.AEM_HOST;

function App() {

  /**
   * Update the dynamic URL with client-specific query parameters
   * @param {*} imageUrl the image URL
   * @param {*} params the AEM web-optimized image query parameters
   * @returns the dynamic URL with the query parameters
   */
  function setOptimizedImageUrlParams(imageUrl, params) {
    let url = new URL(imageUrl);
    Object.keys(params).forEach(key => {
      url.searchParams.set(key, params[key]);
    });
    return url.toString();
  }

  // Get data from AEM using GraphQL persisted query as defined above 
  // The details of defining a React useEffect hook are explored in How to > AEM Headless SDK
  // The 2nd parameter define the base GraphQL query parameters used to request the web-optimized image
  let { data, error } = useAdventureByPath(
        "/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp", 
        { imageFormat: "JPG" }
      );

  // Wait for AEM Headless APIs to provide data
  if (!data) { return <></> }

  const alt = data.adventureByPath.item.title;
  const imageUrl =  AEM_HOST + data.adventureByPath.item.primaryImage._dynamicUrl;

  return (
    <div className="app">
      
      <h1>Web-optimized images</h1>

      {/* Render the web-optimized image img with srcset for the Adventure Primary Image */}
      <h2>Img srcset</h2>

      <img
        alt={alt}
        src={setOptimizedImageUrlParams(imageUrl, { width: 1000 })}
        srcSet={
            `${setOptimizedImageUrlParams(imageUrl, { width: 1000 })} 1000w,
             ${setOptimizedImageUrlParams(imageUrl, { width: 1600 })} 1600w,
             ${setOptimizedImageUrlParams(imageUrl, { width: 2000 })} 2000w`
        }
        sizes="calc(100vw - 10rem)"/>

       {/* Render the web-optimized picture for the Adventure Primary Image */}
        <h2>Picture element</h2>

        <picture>
          {/* When viewport width is greater than 2001px */}
          <source srcSet={setOptimizedImageUrlParams(imageUrl, { width : 2600 })} media="(min-width: 2001px)"/>        
          {/* When viewport width is between 1000px and 2000px */}
          <source srcSet={setOptimizedImageUrlParams(imageUrl, { width : 2000})} media="(min-width: 1000px)"/>
          {/* When viewport width is less than 799px */}
          <img src={setOptimizedImageUrlParams(imageUrl, { width : 400, crop: "550,300,400,400" })} alt={alt}/>
        </picture>
    </div>
  );
}

export default App;
```
