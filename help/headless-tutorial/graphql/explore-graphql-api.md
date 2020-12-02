---
title: Utforska GraphQL API:er - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Utforska AEM GraphQL API:er med den inbyggda GrapiQL IDE. Lär dig hur AEM automatiskt genererar ett GraphQL-schema baserat på en Content Fragment-modell. Experimentera med att skapa grundläggande frågor med GraphQL-syntaxen.
sub-product: resurser
topics: headless
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
mini-toc-levels: 1
kt: null
thumbnail: null
translation-type: tm+mt
source-git-commit: 5012433a5f1c7169b1a3996453bfdbd5d78e5b1c
workflow-type: tm+mt
source-wordcount: '1003'
ht-degree: 0%

---


# Utforska GraphQL API:er {#explore-graphql-apis}

>[!CAUTION]
>
> AEM GraphQL API for Content Fragment Delivery släpps i början av 2021.
> Den relaterade dokumentationen är tillgänglig för förhandsgranskning.

GraphQL API i AEM tillhandahåller ett kraftfullt frågespråk för att visa data från innehållsfragment för program längre fram i kedjan. Modeller för innehållsfragment definierar det dataschema som används av innehållsfragment. När en innehållsfragmentmodell skapas eller uppdateras översätts schemat och läggs till i det diagram som utgör GraphQL-API:t.

I det här kapitlet ska vi undersöka några vanliga GraphQL-frågor för att samla in innehåll. Inbyggd i AEM är en IDE som heter [GraphiQL](https://github.com/graphql/graphiql). Med GraphiQL IDE kan du snabbt testa och finjustera frågor och data som returneras. GraphiQL ger också enkel åtkomst till dokumentationen vilket gör det enkelt att ta reda på vilka metoder som finns tillgängliga.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att de steg som beskrivs i [Skapa innehållsfragment](./author-content-fragments.md) har slutförts.

## Mål {#objectives}

* Lär dig att använda GraphiQL-verktyget för att skapa en fråga med GraphQL-syntax.
* Lär dig hur du hämtar en lista med innehållsfragment och ett enda innehållsfragment.
* Lär dig hur du filtrerar och begär specifika dataattribut.
* Lär dig hur du frågar efter en variant av ett innehållsfragment.
* Lär dig hur du sammanfogar en fråga med flera innehållsfragmentmodeller

## Fråga en lista över innehållsfragment {#query-list-cf}

Ett vanligt krav är att fråga efter flera innehållsfragment.

1. Gå till GraphiQL IDE på [http://localhost:4502/content/graphiql.html](http://localhost:4502/content/graphiql.html).
1. Klistra in följande fråga i den vänstra panelen (nedanför kommentarlistan):

   ```graphql
   {
     contributorList {
       items {
           _path
         }
     }
   }
   ```

1. Tryck på knappen **Play** på den översta menyn för att köra frågan. Resultatet av innehållsavsnitten i Contributor från föregående kapitel bör visas:

   ![Resultat av Contributor-lista](assets/explore-graphql-api/contributorlist-results.png)

1. Placera markören under texten `_path` och skriv **CTRL+Space** för att utlösa kodtipsen. Lägg till `fullName` och `occupation` i frågan.

   ![Uppdatera fråga med kodtips](assets/explore-graphql-api/update-query-codehinting.png)

1. Kör frågan igen genom att trycka på knappen **Spela upp** så ser du resultatet som innehåller ytterligare egenskaper för `fullName` och `occupation`.

   ![Fullständigt namn och yrkesresultat](assets/explore-graphql-api/updated-query-fullname-occupation.png)

   `fullName` och  `occupation` är enkla egenskaper. Kom ihåg följande i kapitlet [Defining Content Fragment Models](./content-fragment-models.md): `fullName` och `occupation` är de värden som används när du definierar **egenskapsnamnet** för respektive fält.

1. `pictureReference` och  `biography` representerar mer komplexa fält. Uppdatera frågan med följande om du vill returnera data om fälten `pictureReference` och `biography`.

   ```graphql
   {
   contributorList {
       items {
         _path
         fullName
         occupation
         biography {
           html
         }
         pictureReference {
           ... on ImageRef {
               _path
               width
               height
               }
           }
       }
     }
   }
   ```

   `biography` är ett textfält med flera rader och med GraphQL API kan vi välja olika format för resultaten, till exempel  `html`,  `markdown`eller  `json`   `plaintext`.

   `pictureReference` är en innehållsreferens och förväntas vara en bild. Därför används det inbyggda  `ImageRef` objektet. Detta gör att vi kan begära ytterligare data om bilden som ska refereras, som `width` och `height`.

1. Experimentera sedan med att fråga efter en lista med **annonser**. Kör följande fråga:

   ```graphql
   {
     adventureList {
       items {
         adventureTitle
         adventureType
         adventurePrimaryImage {
           ...on ImageRef {
             _path
             mimeType
           }
         }
       }
     }
   }
   ```

   Du bör se en lista över **annonser** som returnerats. Experimentera fritt genom att lägga till fler fält i frågan.

## Filtrera en lista med innehållsfragment {#filter-list-cf}

Sedan ska vi titta på hur det går att filtrera resultatet till en delmängd av Content Fragments baserat på ett egenskapsvärde.

1. Ange följande fråga i användargränssnittet för GraphiQL:

   ```graphql
   {
   contributorList(filter: {
     occupation: {
       _expressions: {
         value: "Photographer"
         }
       }
     }) {
       items {
         _path
         fullName
         occupation
       }
     }
   }
   ```

   Frågan ovan utför en sökning mot alla deltagare i systemet. Det tillagda filtret i början av frågan kommer att utföra en jämförelse av fältet `occupation` och strängen **Fotograf**.

1. Kör frågan. Endast en **Contributor** förväntas returneras.
1. Ange följande fråga för att fråga efter en lista med **Adventures** där `adventureActivity` är **inte** lika med **&quot;Surfing&quot;**:

   ```graphql
   {
     adventureList(filter: {
       adventureActivity: {
           _expressions: {
               _operator: EQUALS_NOT
               value: "Surfing"
           }
       }
   }) {
       items {
       _path
       adventureTitle
       adventureActivity
       }
     }
   }
   ```

1. Kör frågan och kontrollera resultatet. Observera att inget av resultaten innehåller en `adventureType` som är lika med **&quot;Surfing&quot;**.

Det finns många andra alternativ för att filtrera och skapa komplexa frågor. Ovanför är bara några exempel.

## Fråga ett enskilt innehållsfragment {#query-single-cf}

Det går också att ställa frågor direkt till ett enda innehållsfragment. Innehåll i AEM lagras hierarkiskt och den unika identifieraren för ett fragment baseras på fragmentets sökväg. Om målet är att returnera data om ett enskilt fragment är det att föredra att använda sökvägen och fråga modellen direkt. Om du använder den här syntaxen kommer frågans komplexitet att bli mycket låg och ge ett snabbare resultat.

1. Ange följande fråga i GraphiQL-redigeraren:

   ```graphql
   {
    contributorByPath(_path: "/content/dam/wknd/en/contributors/stacey-roswells") {
       item {
         _path
         fullName
         biography {
           html
         }
       }
     }
   }
   ```

1. Kör frågan och observera att det enskilda resultatet för **Stacey Roswells**-fragmentet returneras.

   I föregående övning använde du ett filter för att begränsa en resultatlista. Du kan använda en liknande syntax för att filtrera efter sökväg, men av prestandaskäl föredras syntaxen ovan.

1. Kom ihåg i kapitlet [Authoring Content Fragments](./author-content-fragments.md) att en **Summary**-variant skapades för **Stacey Roswells**. Uppdatera frågan för att returnera varianten **Sammanfattning**:

   ```graphql
   {
   contributorByPath
   (
       _path: "/content/dam/wknd/en/contributors/stacey-roswells"
       variation: "summary"
   ) {
       item {
         _path
         fullName
         biography {
           html
         }
       }
     }
   }
   ```

   Även om variationen hade namnet **Sammanfattning**, bevaras variationerna i gemener och `summary` används därför.

1. Kör frågan och observera att `biography`-fältet innehåller ett mycket kortare `html`-resultat.

## Fråga efter modeller för flera innehållsfragment {#query-multiple-models}

Det går också att kombinera olika frågor i en enda fråga. Detta är användbart för att minimera antalet HTTP-begäranden som krävs för att köra programmet. Vyn *Hem* för ett program kan till exempel visa innehåll baserat på **två** olika modeller för innehållsfragment. I stället för att köra **två** separata frågor kan vi kombinera frågorna i en enda begäran.

1. Ange följande fråga i GraphiQL-redigeraren:

   ```graphql
   {
     adventureList {
       items {
         _path
         adventureTitle
       }
     }
     contributorList {
       items {
         _path
         fullName
       }
     }
   }
   ```

1. Kör frågan och observera att resultatuppsättningen innehåller data från **Adventures** och **Contributors**:

```json
{
  "data": {
    "adventureList": {
      "items": [
        {
          "_path": "/content/dam/wknd/en/adventures/bali-surf-camp/bali-surf-camp",
          "adventureTitle": "Bali Surf Camp"
        },
        {
          "_path": "/content/dam/wknd/en/adventures/beervana-portland/beervana-in-portland",
          "adventureTitle": "Beervana in Portland"
        },
        ...
      ]
    },
    "contributorList": {
      "items": [
        {
          "_path": "/content/dam/wknd/en/contributors/jacob-wester",
          "fullName": "Jacob Wester"
        },
        {
          "_path": "/content/dam/wknd/en/contributors/stacey-roswells",
          "fullName": "Stacey Roswells"
        }
      ]
    }
  }
}
```

## Grattis! {#congratulations}

Grattis! Du har precis skapat och kört flera GraphQL-frågor!

## Nästa steg {#next-steps}

I nästa kapitel, [Fråga AEM från en React-app](./graphql-and-external-app.md), ska du undersöka hur ett externt program kan fråga AEM GraphQL-slutpunkter. Den externa appen som ändrar exempelappen WKND GraphQL React för att lägga till filtreringsfrågor för GraphQL, så att appens användare kan filtrera äventyren efter aktivitet. Du kommer också att få en del grundläggande felhantering.
