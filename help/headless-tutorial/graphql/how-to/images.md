---
title: Använda optimerade bilder med AEM Headless
description: Lär dig hur du begär optimerade bild-URL:er med AEM Headless.
version: Experience Manager as a Cloud Service
topic: Headless
feature: GraphQL API
role: Developer
level: Intermediate
jira: KT-10253
thumbnail: KT-10253.jpeg
last-substantial-update: 2023-04-19T00:00:00Z
exl-id: 6dbeec28-b84c-4c3e-9922-a7264b9e928c
duration: 300
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '843'
ht-degree: 0%

---

# Optimerade bilder med AEM Headless {#images-with-aem-headless}

Bilder är en viktig aspekt när det gäller att [utveckla engagerande AEM headless-upplevelser](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html?lang=sv-SE). AEM Headless har stöd för hantering av bildresurser och optimerad leverans.

Content Fragments used in AEM Headless content modeling, ofta reference image assets intended for display in the headless experience. AEM GraphQL-frågor kan skrivas för att ange URL:er till bilder baserat på varifrån bilden refereras.

Typen `ImageRef` har fyra URL-alternativ för innehållsreferenser:

+ `_path` är den refererade sökvägen i AEM och innehåller inte något AEM-ursprung (värdnamn)
+ `_dynamicUrl` är URL:en till för webboptimerad leverans av bildresurser.
   + `_dynamicUrl` innehåller inte något AEM-ursprung, så domänen (AEM Author eller AEM Publish Service) måste anges av klientprogrammet.
+ `_authorUrl` är den fullständiga URL:en till bildresursen på AEM Author
   + [AEM Author](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/underlying-technology/introduction-author-publish.html?lang=sv-SE) kan användas för att skapa en förhandsgranskning av det headless-programmet.
+ `_publishUrl` är den fullständiga URL:en till bildresursen i AEM Publish
   + [AEM Publish](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/underlying-technology/introduction-author-publish.html?lang=sv-SE) är vanligtvis där produktionsdistributionen av det headless-programmet visar bilder från.

`_dynamicUrl` är den rekommenderade URL-adressen som ska användas för leverans av bildresurser och bör ersätta användningen av `_path`, `_authorUrl` och `_publishUrl` när det är möjligt.

|                                | AEM as a Cloud Service | AEM as a Cloud Service RDE | AEM SDK | AEM 6.5 |
| ------------------------------ |:----------------------:|:--------------------------:|:-------:|:-------:|
| Stöder webboptimerade bilder? | ✔ | ✔ | ✘ | ✘ |


>[!CONTEXTUALHELP]
>id="aemcloud_learn_headless_graphql_images"
>title="Bilder med AEM Headless"
>abstract="Läs om hur AEM Headless hanterar bildresurser och optimerad leverans."

## Content Fragment Model

Kontrollera att fältet Innehållsfragment som innehåller bildreferensen har datatypen __content reference__.

Fälttyperna granskas i [Content Fragment Model](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-models.html?lang=sv-SE) genom att markera fältet och kontrollera fliken __Properties__ till höger.

![Modell för innehållsfragment med innehållsreferens till en bild](./assets/images/content-fragment-model.jpeg)

## GraphQL beständig fråga

I GraphQL-frågan returnerar du fältet som `ImageRef`-typ och begär fältet `_dynamicUrl`. Du kan till exempel ställa frågor om ett äventyr i [WKND-platsprojektet](https://github.com/adobe/aem-guides-wknd) och inkludera bild-URL för bildresursreferenserna i fältet `primaryImage` med en ny beständig fråga `wknd-shared/adventure-image-by-path` som definieras som:

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

Variabeln `$path` som används i filtret `_path` kräver den fullständiga sökvägen till innehållsfragmentet (till exempel `/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp`).

`_assetTransform` definierar hur `_dynamicUrl` är konstruerad för att optimera den serverade bildåtergivningen. Webbadresserna för webboptimerade bilder kan också justeras på klienten genom att URL-adressens frågeparametrar ändras.

| GraphQL-parameter | Beskrivning | Obligatoriskt | GraphQL variabelvärden |
|-------------------|------------------------------------------------------------------------------------------------------|----------|-------------------------------------------------------------|
| `format` | Bildresursens format. | ✔ | `GIF`, `PNG`, `PNG8`, `JPG`, `PJPG`, `BJPG`, `WEBP`, `WEBPLL`, `WEBPLY` |
| `seoName` | Namn på filsegment i URL. Om inget anges används bildresursnamnet. | ✘ | Alfanumerisk, `-` eller `_` |
| `crop` | Beskär bildrutor som tagits ut från bilden, måste vara inom bildens storlek | ✘ | Positiva heltal som definierar ett beskärningsområde inom gränserna för de ursprungliga bilddimensionerna |
| `size` | Storlek på utdatabilden (både höjd och bredd) i pixlar. | ✘ | Positiva heltal |
| `rotation` | Bildens rotation i grader. | ✘ | `R90`, `R180`, `R270` |
| `flip` | Vänd bilden. | ✘ | `HORIZONTAL`, `VERTICAL`, `HORIZONTAL_AND_VERTICAL` |
| `quality` | Bildkvaliteten i procent av den ursprungliga kvaliteten. | ✘ | 1-100 |
| `width` | Utdatabildens bredd i pixlar. När `size` anges ignoreras `width`. | ✘ | Positivt heltal |
| `preferWebP` | Om `true` och AEM skickar en WebP om webbläsaren stöder det, oavsett `format`. | ✘ | `true`, `false` |


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

Om du vill läsa in den webboptimerade bilden av den refererade bilden i ditt program använder du `_dynamicUrl` för `primaryImage` som bildens käll-URL.

I Reagera ser det ut så här när en webboptimerad bild från AEM Publish visas:

```jsx
// The AEM host is usually read from a environment variable of the SPA.
const AEM_HOST = "https://publish-p123-e456.adobeaemcloud.com";
...
let dynamicUrl = AEM_HOST + data.adventureByPath.item.primaryImage._dynamicUrl;
...
<img src={dynamicUrl} alt={data.adventureByPath.item.title}/>
```

Kom ihåg att `_dynamicUrl` inte innehåller AEM-domänen, så du måste ange det önskade ursprung som image-URL:en ska matcha.

## Responsiva URL:er

Exemplet ovan visar hur du använder en bild med en storlek, men i webbupplevelser krävs ofta responsiva bilduppsättningar. Responsiva bilder kan implementeras med [img-uppsättningar](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset) eller [picture-element](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset). Följande kodfragment visar hur du använder `_dynamicUrl` som bas. `width` är en URL-parameter som du sedan kan lägga till i `_dynamicUrl` för att driva olika responsiva vyer.

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

+ [Bildelement med resurs](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset) för bättre prestanda
+ [Bildelement](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-picture) för designkontroll

### Img-element med srset

>[!VIDEO](https://video.tv.adobe.com/v/3418556/?quality=12&learn=on)

[Bildelement med raduppsättningen](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-srcset) används med attributet `sizes` för att tillhandahålla olika bildresurser för olika skärmstorlekar. Bilduppsättningar är användbara när du tillhandahåller olika bildresurser för olika skärmstorlekar.

### Bildelement

[Bildelement](https://css-tricks.com/a-guide-to-the-responsive-images-syntax-in-html/#using-picture) används med flera `source`-element för att tillhandahålla olika bildresurser för olika skärmstorlekar. Bildelement är användbara när du vill ha olika bildåtergivningar för olika skärmstorlekar.

>[!VIDEO](https://video.tv.adobe.com/v/3418555/?quality=12&learn=on)

### Exempelkod

Den här enkla React-appen använder [AEM Headless SDK](./aem-headless-sdk.md) för att fråga AEM Headless-API:er efter ett Adventure-innehåll och visar den webboptimerade bilden med hjälp av [img-elementet med srcset](#img-element-with-srcset) och [picture-elementet](#picture-element). `srcset` och `sources` använder en anpassad `setParams`-funktion för att lägga till den webboptimerade frågeparametern för leverans till `_dynamicUrl` för bilden, så ändra den bildåtergivning som levereras baserat på webbklientens behov.

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
