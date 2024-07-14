---
title: Använda RTF med AEM Headless
description: Lär dig att skapa innehåll och bädda in refererat innehåll med en multiline textredigerare med Adobe Experience Manager Content Fragments, och hur avancerad text levereras genom att AEM GraphQL API:er som JSON som ska användas av headless-program.
version: Cloud Service
doc-type: article
jira: KT-9985
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
level: Intermediate
role: Developer
exl-id: 790a33a9-b4f4-4568-8dfe-7e473a5b68b6
duration: 785
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1409'
ht-degree: 0%

---

# RTF med AEM Headless

Flerradigt textfält är en datatyp i Content Fragments som gör att författare kan skapa RTF-innehåll. Referenser till annat innehåll, t.ex. bilder eller andra innehållsfragment, kan infogas dynamiskt textbundet i textflödet. Textfältet En rad är en annan datatyp för innehållsfragment som ska användas för enkla textelement.

AEM GraphQL API har en robust funktion för att returnera RTF som HTML, oformaterad text eller som ren JSON. JSON-representationen är kraftfull eftersom den ger klientprogrammet full kontroll över hur innehållet ska återges.

## Flerradsredigerare

>[!VIDEO](https://video.tv.adobe.com/v/342104?quality=12&learn=on)

I Content Fragment Editor ger menyraden för flerradiga textfält författare standardfunktioner för RTF-formatering, som **bold**, *italics* och underline. Om du öppnar flerradsfältet i helskärmsläge aktiveras [ytterligare formateringsverktyg som Stycketyp, sök och ersätt, stavningskontroll och mycket mer](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-variations.html).

>[!NOTE]
>
> Det går inte att anpassa plugin-programmen för RTF-text i flerradsredigeraren.

## Datatyp för flerradig text {#multi-line-data-type}

Använd datatypen **Flerradig text** när du definierar innehållsfragmentmodellen för att aktivera RTF-redigering.

![RTF-datatyp med flera rader](assets/rich-text/multi-line-rich-text.png)

Flera egenskaper för flerradsfältet kan konfigureras.

Egenskapen **Återge som** kan anges till:

* Textområde - återger ett enskilt fält med flera rader
* Flera fält - återger flera fält med flera rader


**Standardtypen** kan anges till:

* RTF
* Markering
* Oformaterad text

Alternativet **Standardtyp** påverkar redigeringsupplevelsen direkt och avgör om RTF-verktygen finns.

Du kan även [aktivera textbundna referenser](#insert-fragment-references) till andra innehållsfragment genom att kontrollera **Tillåt fragmentreferens** och konfigurera **Tillåtna innehållsfragmentmodeller**.

Markera rutan **Översättningsbar** om innehållet ska lokaliseras. Endast RTF och normal text kan lokaliseras. Mer information finns i [Arbeta med lokaliserat innehåll](./localized-content.md).

## RTF-svar med GraphQL API

När du skapar en GraphQL-fråga kan utvecklare välja olika svarstyper från `html`, `plaintext`, `markdown` och `json` från ett flerradsfält.

Utvecklare kan använda [JSON Preview](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-json-preview.html) i redigeraren för innehållsfragment för att visa alla värden i det aktuella innehållsfragmentet som kan returneras med GraphQL API.

## GraphQL beständig fråga

Om du väljer svarsformatet `json` för flerradsfältet blir det mest flexibelt när du arbetar med RTF-innehåll. RTF-innehållet levereras som en array med JSON-nodtyper som kan bearbetas unikt baserat på klientplattformen.

Nedan finns en JSON-svarstyp för ett flerradsfält med namnet `main` som innehåller ett stycke: *Det här är ett stycke som innehåller **important**-innehåll.* där&quot;important&quot; har markerats som **bold**.

```graphql
query ($path: String!) {
  articleByPath(_path: $path)
  {
    item {
      _path
      main {
        json
      }
    }
  }
}
```

Variabeln `$path` som används i filtret `_path` kräver den fullständiga sökvägen till innehållsfragmentet (till exempel `/content/dam/wknd/en/magazine/sample-article`).

**GraphQL-svar:**

```json
{
  "data": {
    "articleByPath": {
      "item": {
        "_path": "/content/dam/wknd/en/magazine/sample-article",
        "main": {
          "json": [
            {
              "nodeType": "paragraph",
              "content": [
                {
                  "nodeType": "text",
                  "value": "This is a paragraph that includes "
                },
                {
                  "nodeType": "text",
                  "value": "important",
                  "format": {
                    "variants": [
                      "bold"
                    ]
                  }
                },
                {
                  "nodeType": "text",
                  "value": " content. "
                }
              ]
            }
          ]
        }
      }
    }
  }
}
```

### Andra exempel

Nedan visas flera exempel på svarstyper för ett flerradsfält med namnet `main` som innehåller ett stycke:&quot;Det här är ett stycke som innehåller **viktigt** -innehåll.&quot; där&quot;important&quot; har markerats som **bold**.

+++HTML, exempel

**GraphQL beständig fråga:**

```graphql
query ($path: String!) {
  articleByPath(_path: $path)
  {
    item {
      _path
      main {
        html
      }
    }
  }
}
```

**GraphQL-svar:**

```json
{
  "data": {
    "articleByPath": {
      "item": {
        "_path": "/content/dam/wknd/en/magazine/sample-article",
        "main": {
            "html": "<p>This is a paragraph that includes <b>important</b> content.&nbsp;</p>\n"
        }
      }
    }
  }
}
```

+++

+++Exempel på markering

**GraphQL beständig fråga:**

```graphql
query ($path: String!) {
  articleByPath(_path: $path)
  {
    item {
      _path
      main {
        markdown
      }
    }
  }
}
```

**GraphQL-svar:**

```json
{
  "data": {
    "articleByPath": {
      "item": {
        "_path": "/content/dam/wknd/en/magazine/sample-article",
        "main": {
            "markdown": "This is a paragraph that includes **important** content. \n\n ",
        }
      }
    }
  }
}
```

+++

+++Exempel på oformaterad text

**GraphQL beständig fråga:**

```graphql
query ($path: String!) {
  articleByPath(_path: $path)
  {
    item {
      _path
      main {
        plaintext
      }
    }
  }
}
```

**GraphQL-svar:**

```json
{
  "data": {
    "articleByPath": {
      "item": {
        "_path": "/content/dam/wknd/en/magazine/sample-article",
        "main": {
            "plaintext": "This is a paragraph that includes important content. ",
        }
      }
    }
  }
}
```

Återgivningsalternativet `plaintext` tar bort all formatering.

+++


## Återge ett JSON-svar med RTF-text {#render-multiline-json-richtext}

Flerradsfältets RTF-JSON-svar är strukturerat som ett hierarkiskt träd. Varje objekt eller nod representerar ett HTML-block av den formaterade texten.

Nedan visas ett exempel på JSON-svar för ett textfält med flera rader. Observera att varje objekt, eller nod, innehåller en `nodeType` som representerar HTML-blocket från RTF-texten som `paragraph`, `link` och `text`. Varje nod kan innehålla `content`, som är en undergrupp som innehåller underordnade noder till den aktuella noden.

```json
"json": [// root "content" or child nodes
            {
                "nodeType": "paragraph", // node for a paragraph
                "content": [ // children of current node
                {
                    "nodeType": "text", // node for a text
                    "value": "This is the first paragraph. "
                },
                {
                    "nodeType": "link",
                    "data": {
                        "href": "http://www.adobe.com"
                    },
                    "value": "An external link"
                }
                ],
            },
            {
                "nodeType": "paragraph",
                "content": [
                {
                    "nodeType": "text",
                    "value": "This is the second paragraph."
                },
                ],
            },
]
```

Det enklaste sättet att återge det flerradiga `json`-svaret är att bearbeta varje objekt, eller nod, i svaret och sedan bearbeta eventuella underordnade noder till den aktuella noden. En rekursiv funktion kan användas för att gå igenom JSON-trädet.

Nedan visas exempelkod som illustrerar en rekursiv genomgång. Exemplen är JavaScript-baserade och använder React [JSX](https://reactjs.org/docs/introducing-jsx.html), men programmeringsbegreppen kan tillämpas på alla språk.

```javascript
// renderNodeList - renders a list of nodes
function renderNodeList(childNodes) {
    
    if(!childNodes) {
        // null check
        return null;
    }

    return childNodes.map(node, index) => {
        return renderNode(node);
    }
}
```

`renderNodeList` är en rekursiv funktion som tar en matris av `childNodes`. Varje nod i arrayen skickas sedan till funktionen `renderNode`, som i sin tur anropar `renderNodeList` om noden har underordnade noder.

```javascript
// renderNode - renders an individual node
function renderNode(node) {

    // if the current node has children, recursively process them
    const children = node.content ? renderNodeList(node.content) : null;

    // use a map to render the current node based on its nodeType
    return nodeMap[node.nodeType]?.(node, children);
}
```

Funktionen `renderNode` förväntar sig ett enskilt objekt med namnet `node`. En nod kan ha underordnade noder som bearbetas rekursivt med funktionen `renderNodeList` som beskrivs ovan. Slutligen används en `nodeMap` för att återge innehållet i noden baserat på dess `nodeType`.

```javascript
// nodeMap - object literal that maps a JSX response based on a given key (nodeType)
const nodeMap = {
    'paragraph': (node, children) => <p>{children}</p>,
    'link': node => <a href={node.data.href} target={node.data.target}>{node.value}</a>,
    'text': node => node.value,
    'unordered-list': (node, children) => <ul>{children}</ul>,
    'ordered-list': (node, children) => <ol>{children}</ol>,
    'list-item': (node, children) => <li>{children}</li>,
    ...
}
```

`nodeMap` är en JavaScript Object-litteral som används som en karta. Var och en av nycklarna representerar en annan `nodeType`. Parametrarna för `node` och `children` kan skickas till de resulterande funktionerna som återger noden. Returtypen som används i det här exemplet är JSX, men metoden kan anpassas för att skapa en stränglitteral som representerar HTML-innehåll.

### Exempel på fullständig kod

Ett återanvändbart RTF-återgivningsverktyg finns i [WKND GraphQL React-exemplet](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app).

* [renderRichText.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/utils/renderRichText.js) - återanvändbart verktyg som visar en funktion `mapJsonRichText`. Det här verktyget kan användas av komponenter som vill återge ett JSON-svar med RTF-text som React JSX.
* [AdventureDetail.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/components/AdventureDetail.js) - Exempelkomponent som gör en GraphQL-begäran som innehåller RTF-text. Komponenten använder verktyget `mapJsonRichText` för att återge den formaterade texten och eventuella referenser.


## Lägga till textbundna referenser i formaterad text {#insert-fragment-references}

I fältet Flera rader kan författare infoga bilder eller andra digitala resurser från AEM Assets i RTF-flödet.

![infoga bild](assets/rich-text/insert-image.png)

Skärmbilden ovan visar en bild som infogats i fältet med flera rader med knappen **Infoga resurs**.

Referenser till andra innehållsfragment kan också länkas eller infogas i flerradsfältet med knappen **Infoga innehållsfragment** .

![Infoga innehållsfragmentreferens](assets/rich-text/insert-contentfragment.png)

Skärmbilden ovan visar ett annat Content Fragment, Ultimate Guide till LA Skate Parks, som infogas i fältet med flera rader. De typer av innehållsfragment som kan infogas i fältet styrs av konfigurationen **Tillåtna modeller för innehållsfragment** i datatypen [Flera rader](#multi-line-data-type) i modellen för innehållsfragment.

## Fråga textbundna referenser med GraphQL

Med GraphQL API kan utvecklare skapa en fråga som innehåller ytterligare egenskaper om referenser som infogats i ett flerradsfält. JSON-svaret innehåller ett separat `_references`-objekt som listar de här extra egenskaperna. JSON-svaret ger utvecklarna full kontroll över hur referenserna eller länkarna ska återges i stället för att de ska behöva hantera åskådliggjorda HTML.

Du kanske vill:

* Inkludera anpassad routningslogik för hantering av länkar till andra innehållsfragment vid implementering av ett Single Page-program, som React Router eller Next.js
* Rendera en textbunden bild med den absoluta sökvägen till en AEM Publish-miljö som `src`-värde.
* Bestäm hur en inbäddad referens ska återges till ett annat innehållsfragment med ytterligare anpassade egenskaper.

Använd returtypen `json` och inkludera objektet `_references` när du skapar en GraphQL-fråga:

**GraphQL beständig fråga:**

```graphql
query ($path: String!) {
  articleByPath(_path: $path, _assetTransform: { format: JPG, preferWebp: true })
  {
    item {
      _path
      main {
        json
      }
    }
    _references {
      ...on ImageRef {
        _dynamicUrl
        __typename
      }
      ...on ArticleModel {
        _path
        author
        __typename
      }  
    }
  }
}
```

I ovanstående fråga returneras fältet `main` som JSON. Objektet `_references` innehåller fragment för hantering av referenser av typen `ImageRef` eller `ArticleModel`.

**JSON-svar:**

```json
{
  "data": {
    "articleByPath": {
      "item": {
        "_path": "/content/dam/wknd/en/magazine/sample-article",
        "main": {
          "json": [
            {
              "nodeType": "paragraph",
              "content": [
                {
                  "nodeType": "text",
                  "value": "This is a paragraph that includes "
                },
                {
                  "nodeType": "text",
                  "value": "important",
                  "format": {
                    "variants": [
                      "bold"
                    ]
                  }
                },
                {
                  "nodeType": "text",
                  "value": " content. "
                }
              ]
            },
            {
              "nodeType": "paragraph",
              "content": [
                {
                  "nodeType": "reference",
                  "data": {
                    "path": "/content/dam/wknd/en/activities/climbing/sport-climbing.jpg",
                    "mimetype": "image/jpeg"
                  }
                }
              ]
            },
            {
              "nodeType": "paragraph",
              "content": [
                {
                  "nodeType": "text",
                  "value": "Reference another Content Fragment: "
                },
                {
                  "nodeType": "reference",
                  "data": {
                    "href": "/content/dam/wknd/en/magazine/la-skateparks/ultimate-guide-to-la-skateparks",
                    "type": "fragment"
                  },
                  "value": "Ultimate Guide to LA Skateparks"
                }
              ]
            }
          ]
        }
      },
      "_references": [
        {
          "_dynamicUrl": "/adobe/dynamicmedia/deliver/dm-aid--dd42d814-88ec-4c4d-b5ef-e3dc4bc0cb42/sport-climbing.jpg?preferwebp=true",
          "__typename": "ImageRef"
        },
        {
          "_path": "/content/dam/wknd/en/magazine/la-skateparks/ultimate-guide-to-la-skateparks",
          "author": "Stacey Roswells",
          "__typename": "ArticleModel"
        }
      ]
    }
  }
}
```

JSON-svaret innehåller var referensen infogades i den RTF-text som innehåller `"nodeType": "reference"`. Objektet `_references` innehåller sedan alla referenser.

## Återge textbundna referenser i formaterad text

För att återge textbundna referenser kan den rekursiva metod som beskrivs i [Återgivning av ett JSON-svar på flera rader](#render-multiline-json-richtext) expanderas.

Där `nodeMap` är kartan som återger JSON-noderna.

```javascript
const nodeMap = {
        'reference': (node, children) => {

            // variable for reference in _references object
            let reference;
            
            // asset reference
            if (node.data.path) {
                // find reference based on path
                reference = references.find( ref => ref._path === node.data.path);
            }
            // Fragment Reference
            if (node.data.href) {
                // find in-line reference within _references array based on href and _path properties
                reference = references.find( ref => ref._path === node.data.href);
            }

            // if reference found, merge properties of reference and current node, then return render method of it using __typename property
            return reference ? renderReference[reference.__typename]({...reference, ...node}) : null;
        }
    }
```

Det övergripande tillvägagångssättet är att inspektera när `nodeType` är lika med `reference` i JSON-svaret för flera rader. En anpassad återgivningsfunktion kan sedan anropas som innehåller det `_references`-objekt som returneras i GraphQL-svaret.

Den infogade referenssökvägen kan sedan jämföras med motsvarande post i objektet `_references` och en annan anpassad mappning `renderReference` kan anropas.

```javascript
const renderReference = {
    // node contains merged properties of the in-line reference and _references object
    'ImageRef': (node) => {
        // when __typename === ImageRef
        return <img src={node._dynamicUrl} alt={'in-line reference'} /> 
    },
    'ArticleModel': (node) => {
        // when __typename === ArticleModel
        return <Link to={`/article:${node._path}`}>{`${node.value}`}</Link>;
    }
    ...
}
```

`__typename` för objektet `_references` kan användas för att mappa olika referenstyper till olika återgivningsfunktioner.

### Exempel på fullständig kod

Ett fullständigt exempel på hur du skriver en anpassad referensrenderare finns i [AdventureDetail.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/components/AdventureDetail.js) som en del av [WKND GraphQL React-exemplet](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app).

## Exempel från början till slut

>[!VIDEO](https://video.tv.adobe.com/v/342105?quality=12&learn=on)

>[!NOTE]
>
> I videon ovan används `_publishUrl` för att återge bildreferensen. Använd i stället `_dynamicUrl` enligt anvisningarna i [webboptimerade bilder ](./images.md);


I föregående video visas ett exempel från början till slut:

1. Uppdatera ett textfält med flera rader i en innehållsfragmentmodell så att fragmentreferenser tillåts
2. Använd Content Fragment Editor för att inkludera en bild och referera till ett annat fragment i ett textfält med flera rader.
3. Skapar en GraphQL-fråga som innehåller flerradssvaret som JSON och eventuella `_references` som används.
4. Skriva en SPA som återger textbundna referenser för RTF-svaret.
