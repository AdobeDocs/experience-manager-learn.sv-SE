---
title: Utforska AEM GraphQL API - Advanced Concepts of AEM Headless - GraphQL
description: Skicka GraphQL-frågor med GraphiQL IDE. Lär dig mer om avancerade frågor med filter, variabler och direktiv. Fråga efter fragment- och innehållsreferenser, inklusive referenser från textfält med flera rader.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Intermediate
source-git-commit: 83e16ea87847182139982ea2378d8ff9f079c968
workflow-type: tm+mt
source-wordcount: '1216'
ht-degree: 0%

---

# Utforska AEM GraphQL API

Med GraphQL API i AEM kan du visa Content Fragment-data för program längre fram i kedjan. I föregående [flerstegssjälvstudiekurs för GraphQL](../multi-step/explore-graphql-api.md)har du utforskat GraphiQL Integrated Development Environment (IDE) där du har testat och finslipat några vanliga GraphQL-frågor. I det här kapitlet ska du använda GraphiQL IDE för att utforska mer avancerade frågor för att samla in data om de innehållsfragment som du skapade i föregående kapitel.

## Förutsättningar {#prerequisites}

Det här dokumentet är en del av en självstudiekurs i flera delar. Se till att föregående kapitel har fyllts i innan du fortsätter med det här kapitlet.

GraphiQL IDE måste vara installerat innan du slutför det här kapitlet. Följ installationsanvisningarna i föregående [flerstegssjälvstudiekurs för GraphQL](../multi-step/explore-graphql-api.md) för mer information.

## Mål {#objectives}

I det här kapitlet får du lära dig att:

* Filtrera en lista med innehållsfragment med referenser som använder frågevariabler
* Filter för innehåll i en fragmentreferens
* Fråga efter textbundet innehåll och fragmentreferenser från ett textfält med flera rader
* Fråga med direktiv
* Fråga efter JSON-objektets innehållstyp

## Filtrera en lista med innehållsfragment med frågevariabler

I föregående [flerstegssjälvstudiekurs för GraphQL](../multi-step/explore-graphql-api.md)har du lärt dig att filtrera en lista med innehållsfragment. Här utökar du kunskapen och filtrerar med hjälp av variabler.

När du utvecklar klientprogram måste du i de flesta fall filtrera innehållsfragment baserat på dynamiska argument. Med AEM GraphQL API kan du skicka dessa argument som variabler i en fråga för att undvika strängkonstruktion på klientsidan vid körning. Mer information om GraphQL-variabler finns i [GraphQL-dokumentation](https://graphql.org/learn/queries/#variables).

I det här exemplet frågar du alla instruktörer som har en viss kompetens.

1. Klistra in följande fråga i den vänstra panelen i GraphiQL IDE:

   ```graphql
   query listPersonBySkill ($skillFilter: String!){
     personList(
       _locale: "en"
       filter: {skills: {_expressions: [{value: $skillFilter}]}}
     ) {
       items {
         fullName
         contactInfo {
           phone
           email
         }
         profilePicture {
           ... on ImageRef {
             _path
           }
         }
         biography {
           plaintext
         }
         instructorExperienceLevel
         skills
       }
     }
   }
   ```

   The `listPersonBySkill` en variabel accepteras i frågan ovan (`skillFilter`) som krävs `String`. Den här frågan utför en sökning mot alla personinnehållsfragment och filtrerar dem baserat på `skills` fält och strängen som skickas `skillFilter`.

   Observera att `listPersonBySkill` innehåller `contactInfo` -egenskap, som är en fragmentreferens till kontaktinformationsmodellen som definieras i föregående kapitel. Kontaktinformationsmodellen innehåller `phone` och `email` fält. Du måste inkludera minst ett av dessa fält i frågan för att det ska fungera korrekt.

   ```graphql
   contactInfo {
           phone
           email
         }
   ```

1. Nästa, låt oss definiera `skillFilter` och få alla instruktörer som är skickliga på skidåkning. Klistra in följande JSON-sträng på panelen Frågevariabler i GraphiQL IDE:

   ```json
   {
   	    "skillFilter": "Skiing"
   }
   ```

1. Kör frågan. Resultatet ska se ut ungefär så här:

   ```json
   {
     "data": {
       "personList": {
         "items": [
           {
             "fullName": "Stacey Roswells",
             "contactInfo": {
               "phone": "209-888-0011",
               "email": "sroswells@wknd.com"
             },
             "profilePicture": {
               "_path": "/content/dam/wknd/en/contributors/stacey-roswells.jpg"
             },
             "biography": {
               "plaintext": "Stacey Roswells is an accomplished rock climber and alpine adventurer.\nBorn in Baltimore, Maryland, Stacey is the youngest of six children. Her father was a lieutenant colonel in the US Navy and her mother was a modern dance instructor. Her family moved frequently with her father’s duty assignments, and she took her first pictures when he was stationed in Thailand. This is also where Stacey learned to rock climb."
             },
             "instructorExperienceLevel": "Advanced",
             "skills": [
               "Rock Climbing",
               "Skiing",
               "Backpacking"
             ]
           }
         ]
       }
     }
   }
   ```

## Filter för innehåll i en fragmentreferens

Med AEM GraphQL API kan du fråga efter kapslade innehållsfragment. I föregående kapitel lade du till tre nya fragmentreferenser till ett Adventure Content Fragment: `location`, `instructorTeam`och `administrator`. Nu ska vi filtrera alla annonser för alla administratörer som har ett visst namn.

>[!CAUTION]
>
>Endast en modell får användas som referens för den här frågan för att den ska fungera korrekt.

1. Klistra in följande fråga i den vänstra panelen i GraphiQL IDE:

   ```graphql
   query getAdventureAdministratorDetailsByAdministratorName ($name: String!){
     adventureList(
     _locale: "en"
       filter: {administrator: {fullName: {_expressions: [{value: $name}]}}}
     ) {
       items {
         adventureTitle
         administrator {
           fullName
           contactInfo {
             phone
             email
           }
           administratorDetails {
             json
           }
         }
       }
     }
   }
   ```

1. Klistra sedan in följande JSON-sträng på panelen Frågevariabler:

   ```json
   {
   	    "name": "Jacob Wester"
   }
   ```

   The `getAdventureAdministratorDetailsByAdministratorName` frågefiltrerar alla annonser för `administrator` av `fullName` &quot;Jacob Wester&quot;, som returnerar information från två kapslade innehållsfragment: Äventyr och instruktör.

1. Kör frågan. Resultatet ska se ut ungefär så här:

   ```json
   {
     "data": {
       "adventureList": {
         "items": [
           {
             "adventureTitle": "Yosemite Backpacking",
             "administrator": {
               "fullName": "Jacob Wester",
               "contactInfo": {
                 "phone": "209-888-0000",
                 "email": "jwester@wknd.com"
               },
               "administratorDetails": {
                 "json": [
                   {
                     "nodeType": "paragraph",
                     "content": [
                       {
                         "nodeType": "text",
                         "value": "Jacob Wester has been coordinating backpacking adventures for 3 years."
                       }
                     ]
                   }
                 ]
               }
             }
           }
         ]
       }
     }
   }
   ```

## Fråga efter textbundna referenser från ett textfält med flera rader {#query-rte-reference}

Med AEM GraphQL API kan du söka efter innehålls- och fragmentreferenser i textfält med flera rader. I föregående kapitel lade du till båda referenstyperna i **Beskrivning** i Yosemite Team Content Fragment. Nu hämtar vi referenserna.

1. Klistra in följande fråga i den vänstra panelen i GraphiQL IDE:

   ```graphql
   query getTeamByAdventurePath ($fragmentPath: String!){
     adventureByPath (_path: $fragmentPath) {
       item {
         instructorTeam {
           _metadata {
             stringMetadata {
               name
               value
             }
         }
           teamFoundingDate
           description {
             plaintext
           }
         }
       }
       _references {
         ... on ImageRef {
           __typename
           _path
         }
         ... on LocationModel {
           __typename
           _path
           name
           address {
             streetAddress
             city
             zipCode
             country
           }
           contactInfo {
             phone
             email
           }
         }
       }
     }
   }
   ```

   The `getTeamByAdventurePath` hämtar alla annonser per sökväg och returnerar data för `instructorTeam` fragmentreferens för ett specifikt Adventure.

   `_references` är ett systemgenererat fält som används för att visa referenser, inklusive de som infogas i textfält med flera rader.

   The `getTeamByAdventurePath` hämtar flera referenser. Först används den inbyggda `ImageRef` objekt som hämtar `_path` och `__typename` av bilder som infogats som innehållsreferenser i textfältet med flera rader. Därefter används `LocationModel` om du vill hämta data för det platsinnehållsfragment som infogats i samma fält.

   Observera att frågan även innehåller `_metadata` fält. På så sätt kan du hämta namnet på teaminnehållsfragmentet och visa det senare i WKND-appen.

1. Klistra sedan in följande JSON-sträng på panelen Frågevariabler för att hämta Yosemite Backpackaging Adventure:

   ```json
   {
   	    "fragmentPath": "/content/dam/wknd/en/adventures/yosemite-backpacking/yosemite-backpacking"
   }
   ```

1. Kör frågan. Resultatet ska se ut ungefär så här:

   ```json
   {
     "data": {
       "adventureByPath": {
         "item": {
           "instructorTeam": {
             "_metadata": {
               "stringMetadata": [
                 {
                   "name": "title",
                   "value": "Yosemite Team"
                 },
                 {
                   "name": "description",
                   "value": ""
                 }
               ]
             },
             "teamFoundingDate": "2016-05-24",
             "description": {
               "plaintext": "\n\nThe team of professional adventurers and hiking instructors working in Yosemite National Park.\n\nYosemite Valley Lodge"
             }
           }
         },
         "_references": [
           {
             "__typename": "LocationModel",
             "_path": "/content/dam/wknd/en/adventures/locations/yosemite-valley-lodge/yosemite-valley-lodge",
             "name": "Yosemite Valley Lodge",
             "address": {
               "streetAddress": "9006 Yosemite Lodge Drive",
               "city": "Yosemite National Park",
               "zipCode": "95389",
               "country": "United States"
             },
             "contactInfo": {
               "phone": "209-992-0000",
               "email": "yosemitelodge@wknd.com"
             }
           },
           {
             "__typename": "ImageRef",
             "_path": "/content/dam/wknd/en/adventures/teams/yosemite-team/team-yosemite-logo.png"
           }
         ]
       }
     }
   }
   ```

   Observera att `_references` visas både logotypbilden och Yosemite Valley Lodge Content Fragment som infogades i **Beskrivning** fält.


## Fråga med direktiv

När du utvecklar klientprogram måste du ibland ändra strukturen för dina frågor på ett villkor. I det här fallet kan du med AEM GraphQL API använda GraphQL-direktiv för att ändra beteendet på dina frågor baserat på de angivna villkoren. Mer information om GraphQL-direktiv finns i [GraphQL-dokumentation](https://graphql.org/learn/queries/#directives).

I [föregående avsnitt](#query-rte-reference)har du lärt dig att söka efter textbundna referenser i textfält med flera rader. Observera att innehållet hämtades från `description` i `plaintext` format. Nu ska vi utöka frågan och använda ett direktiv för att hämta villkorligt `description` i `json` också.

1. Klistra in följande fråga i den vänstra panelen i GraphiQL IDE:

   ```graphql
   query getTeamByAdventurePath ($fragmentPath: String!, $includeJson: Boolean!){
     adventureByPath(_path: $fragmentPath) {
       item {
         instructorTeam {
           _metadata{
             stringMetadata{
               name
               value
             }
           }
           teamFoundingDate
           description {
             plaintext
             json @include(if: $includeJson)
           }
         }
       }
       _references {
         ... on ImageRef {
           __typename
           _path
         }
         ... on LocationModel {
           __typename
           _path
           name
           address {
             streetAddress
             city
             zipCode
             country
           }
           contactInfo {
             phone
             email
           }
         }
       }
     }
   }
   ```

   Frågan ovan accepterar ytterligare en variabel (`includeJson`) som krävs `Boolean`, även kallat frågans direktiv. Ett direktiv kan användas för att villkorligt inkludera data från `description` i `json` baserat på det booleska värde som skickas `includeJson`.

1. Klistra sedan in följande JSON-sträng på panelen Frågevariabler:

   ```json
   {
     "fragmentPath": "/content/dam/wknd/en/adventures/yosemite-backpacking/yosemite-backpacking",
     "includeJson": false
   }
   ```

1. Kör frågan. Du bör få samma resultat som i föregående avsnitt på [fråga efter textbundna referenser i textfält med flera rader](#query-rte-reference).

1. Uppdatera `includeJson` direktiv till `true` och kör frågan igen. Resultatet ska se ut ungefär så här:

   ```json
   {
     "data": {
       "adventureByPath": {
         "item": {
           "instructorTeam": {
             "_metadata": {
               "stringMetadata": [
                 {
                   "name": "title",
                   "value": "Yosemite Team"
                 },
                 {
                   "name": "description",
                   "value": ""
                 }
               ]
             },
             "teamFoundingDate": "2016-05-24",
             "description": {
               "plaintext": "\n\nThe team of professional adventurers and hiking instructors working in Yosemite National Park.\n\nYosemite Valley Lodge",
               "json": [
                 {
                   "nodeType": "paragraph",
                   "content": [
                     {
                       "nodeType": "reference",
                       "data": {
                         "path": "/content/dam/wknd/en/adventures/teams/yosemite-team/team-yosemite-logo.png",
                         "mimetype": "image/png"
                       }
                     }
                   ]
                 },
                 {
                   "nodeType": "paragraph",
                   "content": [
                     {
                       "nodeType": "text",
                       "value": "The team of professional adventurers and hiking instructors working in Yosemite National Park."
                     }
                   ]
                 },
                 {
                   "nodeType": "paragraph",
                   "content": [
                     {
                       "nodeType": "reference",
                       "data": {
                         "href": "/content/dam/wknd/en/adventures/locations/yosemite-valley-lodge/yosemite-valley-lodge",
                         "type": "fragment"
                       },
                       "value": "Yosemite Valley Lodge"
                     }
                   ]
                 }
               ]
             }
           }
         },
         "_references": [
           {
             "__typename": "LocationModel",
             "_path": "/content/dam/wknd/en/adventures/locations/yosemite-valley-lodge/yosemite-valley-lodge",
             "name": "Yosemite Valley Lodge",
             "address": {
               "streetAddress": "9006 Yosemite Lodge Drive",
               "city": "Yosemite National Park",
               "zipCode": "95389",
               "country": "United States"
             },
             "contactInfo": {
               "phone": "209-992-0000",
               "email": "yosemitelodge@wknd.com"
             }
           },
           {
             "__typename": "ImageRef",
             "_path": "/content/dam/wknd/en/adventures/teams/yosemite-team/team-yosemite-logo.png"
           }
         ]
       }
     }
   }
   ```

## Fråga efter JSON-objektets innehållstyp

Kom ihåg att du i föregående kapitel om utveckling av innehållsfragment lade till ett JSON-objekt i **Väder efter säsong** fält. Nu hämtar vi dessa data i Location Content Fragment.

1. Klistra in följande fråga i den vänstra panelen i GraphiQL IDE:

   ```graphql
   query getLocationDetailsByLocationPath ($fragmentPath: String!) {
     locationByPath(_path: $fragmentPath) {
       item {
         name
         description {
           json
         }
         contactInfo {
           phone
           email
         }
         locationImage {
           ... on ImageRef {
             _path
           }
         }
         weatherBySeason
         address {
           streetAddress
           city
           state
           zipCode
           country
         }
       }
     }
   }
   ```

1. Klistra sedan in följande JSON-sträng på panelen Frågevariabler:

   ```json
   {
     "fragmentPath": "/content/dam/wknd/en/adventures/locations/yosemite-national-park/yosemite-national-park"
   }
   ```

1. Kör frågan. Resultatet ska se ut ungefär så här:

   ```json
   {
     "data": {
       "locationByPath": {
         "item": {
           "name": "Yosemite National Park",
           "description": {
             "json": [
               {
                 "nodeType": "paragraph",
                 "content": [
                   {
                     "nodeType": "text",
                     "value": "Yosemite National Park is in California’s Sierra Nevada mountains. It’s famous for its gorgeous waterfalls, giant sequoia trees, and iconic views of El Capitan and Half Dome cliffs."
                   }
                 ]
               },
               {
                 "nodeType": "paragraph",
                 "content": [
                   {
                     "nodeType": "text",
                     "value": "Hiking and camping are the best ways to experience Yosemite. Numerous trails provide endless opportunities for adventure and exploration."
                   }
                 ]
               }
             ]
           },
           "contactInfo": {
             "phone": "209-999-0000",
             "email": "yosemite@wknd.com"
           },
           "locationImage": {
             "_path": "/content/dam/wknd/en/adventures/locations/yosemite-national-park/yosemite-national-park.jpeg"
           },
           "weatherBySeason": {
             "summer": "81 / 89°F",
             "fall": "56 / 83°F",
             "winter": "46 / 51°F",
             "spring": "57 / 71°F"
           },
           "address": {
             "streetAddress": "9010 Curry Village Drive",
             "city": "Yosemite Valley",
             "state": "CA",
             "zipCode": "95389",
             "country": "United States"
           }
         }
       }
     }
   }
   ```

   Observera att `weatherBySeason` -fältet innehåller det JSON-objekt som lagts till i föregående kapitel.

## Fråga om allt innehåll samtidigt

Hittills har flera frågor körts för att illustrera funktionerna i AEM GraphQL API. Samma data kunde bara hämtas med en enda fråga:

```graphql
query getAllAdventureDetails($fragmentPath: String!) {
  adventureByPath(_path: $fragmentPath){
    item {
      _path
      adventureTitle
      adventureActivity
      adventureType
      adventurePrice
      adventureTripLength
      adventureGroupSize
      adventureDifficulty
      adventurePrice
      adventurePrimaryImage{
        ...on ImageRef{
          _path
          mimeType
          width
          height
        }
      }
      adventureDescription {
        html
        json
      }
      adventureItinerary {
        html
        json
      }
      location {
        _path
        name
        description {
          html
          json
        }
        contactInfo{
          phone
          email
        }
        locationImage{
          ...on ImageRef{
            _path
          }
        }
        weatherBySeason
        address{
            streetAddress
            city
            state
            zipCode
            country
        }
      }
      instructorTeam {
        _metadata{
            stringMetadata{
                name
                value
            }
        }        
        teamFoundingDate
        description {
            json
        }
        teamMembers {
            fullName
            contactInfo {
                phone
                email
            }
            profilePicture{
                ...on ImageRef {
                    _path
                }
            }
            instructorExperienceLevel
            skills
            biography {
                html
            }
        }       
     }
      administrator {
            fullName
            contactInfo {
                phone
                email
            }
            biography {
                html
            }
        }
    }
    _references {
        ...on ImageRef {
            _path
        mimeType
        }
        ...on LocationModel {
            _path
                __typename
        }
    }
  }
}

# in Query Variables
{
  "fragmentPath": "/content/dam/wknd/en/adventures/yosemite-backpacking/yosemite-backpacking"
}
```

## Ytterligare frågor för WKND-appen

Följande frågor visas för att hämta alla data som behövs i WKND-appen. De här frågorna demonstrerar inga nya koncept och tillhandahålls bara som referens för att hjälpa dig att bygga implementeringen.

1. **Hämta teammedlemmar för en specifik Adventure**:

   ```graphql
   query getTeamMembersByAdventurePath ($fragmentPath: String!){
     adventureByPath (_path: $fragmentPath ) {
       item {
         instructorTeam {
           teamMembers{
             fullName
             contactInfo{
               phone
               email
             }
           profilePicture {
               ... on ImageRef {
                 _path
               }
           }
             instructorExperienceLevel
             skills
             biography{
               plaintext
             }
           }
         }
       }
     }
   }
   
   # in Query Variables
   {
     "fragmentPath": "/content/dam/wknd/en/adventures/yosemite-backpacking/yosemite-backpacking"
   }
   ```

1. **Hämta platssökväg för en specifik Adventure**

   ```graphql
   query getLocationPathByAdventurePath ($fragmentPath: String!){
     adventureByPath (_path: $fragmentPath){
       item {
         location{
           _path  
         } 
       }
     }
   }
   
   # in Query Variables
   {
     "fragmentPath": "/content/dam/wknd/en/adventures/yosemite-backpacking/yosemite-backpacking"
   }
   ```

1. **Hämta teamets plats via dess sökväg**

   ```graphql
   query getTeamLocationByLocationPath ($fragmentPath: String!){
     locationByPath (_path: $fragmentPath) {
       item {
         name
         description{
           json
         }
         contactInfo{
           phone
           email
         }
           address{
           streetAddress
           city
           state
           zipCode
           country
         }
       }
     }
   }
   
   # in Query Variables
   {
     "fragmentPath": "/content/dam/wknd/en/adventures/locations/yosemite-valley-lodge/yosemite-valley-lodge"
   }
   ```

## Grattis!

Grattis! Du har nu testat avancerade frågor för att samla in data om de innehållsfragment som du skapade i föregående kapitel.

## Nästa steg

I [nästa kapitel](/help/headless-tutorial/graphql/advanced-graphql/graphql-persisted-queries.md)kommer du att lära dig att behålla GraphQL-frågor och varför det är bäst att använda beständiga frågor i dina program.