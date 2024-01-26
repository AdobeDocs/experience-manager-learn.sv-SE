---
title: Använda RTF med AEM Headless
description: Lär dig att skapa innehåll och bädda in refererat innehåll med en multiline textredigerare med Adobe Experience Manager Content Fragments, och hur avancerad text levereras av GraphQL API:er som JSON som kan användas av headless-program.
version: Cloud Service
doc-type: article
jira: KT-9985
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
level: Intermediate
role: Developer
exl-id: 790a33a9-b4f4-4568-8dfe-7e473a5b68b6
duration: 821
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1409'
ht-degree: 0%

---

# RTF med AEM Headless

Flerradigt textfält är en datatyp i Content Fragments som gör att författare kan skapa RTF-innehåll. Referenser till annat innehåll, t.ex. bilder eller andra innehållsfragment, kan infogas dynamiskt textbundet i textflödet. Textfältet En rad är en annan datatyp för innehållsfragment som ska användas för enkla textelement.

AEM GraphQL API har en robust funktion för att returnera RTF som HTML, oformaterad text eller som ren JSON. JSON-representationen är kraftfull eftersom den ger klientprogrammet full kontroll över hur innehållet ska återges.

## Flerradsredigerare

>[!VIDEO](https://video.tv.adobe.com/v/342104?quality=12&learn=on)

I Innehållsfragmentsredigeraren har menyraden för flerradiga textfält försetts med formateringsfunktioner som **fet**, *kursiv* och understrykning. Om du öppnar flerradsfältet i helskärmsläge aktiveras [ytterligare formateringsverktyg som stycketext, sök och ersätt, stavningskontroll med mera](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-variations.html).

>[!NOTE]
>
> Det går inte att anpassa plugin-programmen för RTF-text i flerradsredigeraren.

## Datatyp för flerradig text {#multi-line-data-type}

Använd **Flerradstext** datatyp när du definierar innehållsfragmentmodellen för att aktivera RTF-redigering.

![RTF-datatyp för flera rader](assets/rich-text/multi-line-rich-text.png)

Flera egenskaper för flerradsfältet kan konfigureras.

The **Återge som** -egenskapen kan anges till:

* Textområde - återger ett enskilt fält med flera rader
* Flera fält - återger flera fält med flera rader


The **Standardtyp** kan anges till:

* RTF
* Markering
* Oformaterad text

The **Standardtyp** -alternativet påverkar redigeringsmiljön direkt och avgör om det finns RTF-verktyg.

Du kan också [aktivera textbundna referenser](#insert-fragment-references) till andra innehållsfragment genom att kontrollera **Tillåt fragmentreferens** och konfigurera **Tillåtna modeller för innehållsfragment**.

Kontrollera **Översättningsbar** om innehållet ska lokaliseras. Endast RTF och normal text kan lokaliseras. Se [arbeta med lokaliserat innehåll för mer information](./localized-content.md).

## RTF-svar med GraphQL API

När du skapar en GraphQL-fråga kan utvecklare välja olika svarstyper från `html`, `plaintext`, `markdown`och `json` från ett fält med flera rader.

Utvecklare kan använda [JSON Preview](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-json-preview.html) i Content Fragment-redigeraren för att visa alla värden för det aktuella innehållsfragmentet som kan returneras med GraphQL API.

## GraphQL beständig fråga

Markera `json` svarsformatet för flerradsfältet ger den flexibilitet som krävs när du arbetar med RTF-innehåll. RTF-innehållet levereras som en array med JSON-nodtyper som kan bearbetas unikt baserat på klientplattformen.

Nedan visas en JSON-svarstyp för ett flerradigt fält med namnet `main` som innehåller ett stycke: &quot;*Det här är ett stycke som innehåller **important**innehåll.*&quot; där &quot;important&quot; är markerad som **fet**.

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

The `$path` variabel som används i `_path` filtret kräver den fullständiga sökvägen till innehållsfragmentet (till exempel `/content/dam/wknd/en/magazine/sample-article`).

**GraphQL svar:**

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

Nedan visas flera exempel på svarstyper för ett flerradigt fält med namnet `main` som innehåller ett stycke:&quot;Detta är ett stycke som innehåller **important** innehåll.&quot; där&quot;important&quot; markeras som **fet**.

+++HTML, exempel

**GraphQL beständiga fråga:**

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

**GraphQL svar:**

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

**GraphQL beständiga fråga:**

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

**GraphQL svar:**

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

**GraphQL beständiga fråga:**

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

**GraphQL svar:**

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

The `plaintext` renderingsalternativet tar bort all formatering.

+++


## Återge ett JSON-svar med RTF-text {#render-multiline-json-richtext}

Flerradsfältets RTF-JSON-svar är strukturerat som ett hierarkiskt träd. Varje objekt eller nod representerar ett HTML-block av den formaterade texten.

Nedan visas ett exempel på JSON-svar för ett textfält med flera rader. Observera att varje objekt, eller nod, innehåller en `nodeType` som representerar HTML-blocket från den RTF-text som `paragraph`, `link`och `text`. Varje nod kan innehålla `content` som är en underordnad array som innehåller underordnade noder till den aktuella noden.

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

Det enklaste sättet att återge flerradiga `json` är att bearbeta varje objekt, eller nod, i svaret och sedan bearbeta eventuella underordnade noder till den aktuella noden. En rekursiv funktion kan användas för att gå igenom JSON-trädet.

Nedan visas exempelkod som illustrerar en rekursiv genomgång. Exemplen är JavaScript-baserade och använder React&#39;s [JSX](https://reactjs.org/docs/introducing-jsx.html)programmeringskoncepten kan dock tillämpas på alla språk.

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

`renderNodeList` är en rekursiv funktion som tar en array med `childNodes`. Varje nod i arrayen skickas sedan till en funktion `renderNode`som i sin tur anropar `renderNodeList` om noden har underordnade noder.

```javascript
// renderNode - renders an individual node
function renderNode(node) {

    // if the current node has children, recursively process them
    const children = node.content ? renderNodeList(node.content) : null;

    // use a map to render the current node based on its nodeType
    return nodeMap[node.nodeType]?.(node, children);
}
```

The `renderNode` funktionen förväntar sig ett enda objekt med namnet `node`. En nod kan ha underordnade noder som bearbetas rekursivt med `renderNodeList` funktionen som beskrivs ovan. Äntligen en `nodeMap` används för att återge innehållet i noden baserat på dess `nodeType`.

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

The `nodeMap` är en JavaScript-objektlitteral som används som en karta. Var och en av &quot;tangenterna&quot; representerar olika `nodeType`. Parametrar för `node` och `children` kan skickas till de resulterande funktioner som återger noden. Returtypen som används i det här exemplet är JSX, men metoden kan anpassas för att skapa en stränglitteral som representerar HTML-innehåll.

### Exempel på fullständig kod

Ett återanvändbart RTF-återgivningsverktyg finns i [WKND GraphQL React-exempel](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app).

* [renderRichText.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/utils/renderRichText.js) - återanvändbart verktyg som visar en funktion `mapJsonRichText`. Det här verktyget kan användas av komponenter som vill återge ett JSON-svar med RTF-text som React JSX.
* [AdventureDetail.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/components/AdventureDetail.js) - Exempelkomponent som gör en GraphQL-förfrågan som innehåller RTF-text. Komponenten använder `mapJsonRichText` för att återge den formaterade texten och eventuella referenser.


## Lägga till textbundna referenser i formaterad text {#insert-fragment-references}

I fältet Flera rader kan författare infoga bilder eller andra digitala resurser från AEM Assets i RTF-flödet.

![infoga bild](assets/rich-text/insert-image.png)

Skärmbilden ovan visar en bild som infogats i fältet med flera rader med hjälp av **Infoga resurs** -knappen.

Referenser till andra innehållsfragment kan också länkas eller infogas i flerradsfältet med **Infoga innehållsfragment** -knappen.

![Infoga innehållsfragmentreferens](assets/rich-text/insert-contentfragment.png)

Skärmbilden ovan visar ett annat Content Fragment, Ultimate Guide till LA Skate Parks, som infogas i fältet med flera rader. De typer av innehållsfragment som kan infogas i fält styrs av **Tillåtna modeller för innehållsfragment** i [datatyp med flera rader](#multi-line-data-type) i Content Fragment Model.

## Fråga textbundna referenser med GraphQL

Med GraphQL API kan utvecklare skapa en fråga som innehåller ytterligare egenskaper om referenser som infogats i ett flerradsfält. JSON-svaret innehåller ett separat `_references` objekt som listar de här extra egenskaperna. JSON-svaret ger utvecklarna full kontroll över hur referenserna eller länkarna ska återges i stället för att de ska behöva hantera åskådliggjorda HTML.

Du kanske vill:

* Inkludera anpassad routningslogik för hantering av länkar till andra innehållsfragment vid implementering av ett Single Page-program, som React Router eller Next.js
* Rendera en textbunden bild med den absoluta sökvägen till en AEM publiceringsmiljö som `src` värde.
* Bestäm hur en inbäddad referens ska återges till ett annat innehållsfragment med ytterligare anpassade egenskaper.

Använd `json` returtyp och inkludera `_references` -objekt när en GraphQL-fråga skapas:

**GraphQL beständiga fråga:**

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

I frågan ovan visas `main` fältet returneras som JSON. The `_references` objektet innehåller fragment för hantering av referenser som är av typen `ImageRef` eller av typen `ArticleModel`.

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

JSON-svaret innehåller var referensen infogades i den RTF-text som innehåller `"nodeType": "reference"`. The `_references` innehåller sedan alla referenser.

## Återge textbundna referenser i formaterad text

Om du vill återge textbundna referenser är det rekursiva sättet som beskrivs i [Rendera ett JSON-svar med flera rader](#render-multiline-json-richtext) kan utökas.

Plats `nodeMap` är kartan som återger JSON-noderna.

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

Det övergripande tillvägagångssättet är att inspektera närhelst en `nodeType` är lika med `reference` i Mutli Line JSON-svaret. En anpassad återgivningsfunktion kan sedan anropas som innehåller `_references` som returneras i GraphQL-svaret.

Den textbundna referenssökvägen kan sedan jämföras med motsvarande post i `_references` objekt och en annan anpassad karta `renderReference` kan anropas.

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

The `__typename` i `_references` kan användas för att mappa olika referenstyper till olika återgivningsfunktioner.

### Exempel på fullständig kod

Ett fullständigt exempel på hur du skriver en anpassad referensrenderare finns i [AdventureDetail.js](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/react-app/src/components/AdventureDetail.js) som en del av [WKND GraphQL React-exempel](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/react-app).

## Exempel från början till slut

>[!VIDEO](https://video.tv.adobe.com/v/342105?quality=12&learn=on)

>[!NOTE]
>
> Videon ovan använder `_publishUrl` för att återge bildreferensen. I stället vill du `_dynamicUrl` enligt vad som anges i [webboptimerade bilder](./images.md);


I föregående video visas ett exempel från början till slut:

1. Uppdatera ett textfält med flera rader i en innehållsfragmentmodell så att fragmentreferenser tillåts
2. Använd Content Fragment Editor för att inkludera en bild och referera till ett annat fragment i ett textfält med flera rader.
3. Skapa en GraphQL-fråga som innehåller flerradstextsvar som JSON och alla `_references` används.
4. Skriva en SPA som återger textbundna referenser för RTF-svaret.
