---
title: Android-app - Exempel AEM Headless
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Det här Android-programmet visar hur du frågar efter innehåll med hjälp av GraphQL API:er för AEM.
version: Cloud Service
mini-toc-levels: 2
jira: KT-10588
thumbnail: KT-10588.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
last-substantial-update: 2023-05-10T00:00:00Z
badgeVersions: label="AEM Headless as a Cloud Service" before-title="false"
exl-id: 7873e263-b05a-4170-87a9-59e8b7c65faa
duration: 190
source-git-commit: adf3fe30474bcfe5fc1a1e2a8a3d49060067726d
workflow-type: tm+mt
source-wordcount: '614'
ht-degree: 0%

---

# Android-app

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Det här Android-programmet visar hur du frågar efter innehåll med hjälp av GraphQL API:er för AEM. The [AEM Headless Client for Java](https://github.com/adobe/aem-headless-client-java) används för att köra GraphQL-frågor och mappa data till Java-objekt för att styra programmet.

![Android Java-app med AEM Headless](./assets/android-java-app/android-app.png)


Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/android-app)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Android Studio](https://developer.android.com/studio)
+ [Git](https://git-scm.com/)

## AEM

Android-programmet fungerar med följande AEM distributionsalternativ. Alla distributioner kräver [WKND Site v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) installeras.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html)

Android-programmet är utformat för att ansluta till en __AEM Publish__ -miljön kan däremot hämta innehåll från AEM författare om autentisering anges i Android-programmets konfiguration.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql` databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna [Android Studio](https://developer.android.com/studio) och öppna mappen `android-app`
1. Ändra filen `config.properties` på `app/src/main/assets/config.properties` och uppdatera `contentApi.endpoint` för att matcha AEM målmiljö:

   ```plain
   contentApi.endpoint=https://publish-p123-e456.adobeaemcloud.com
   ```

   __Grundläggande autentisering__

   The `contentApi.user` och `contentApi.password` autentisera en lokal AEM med åtkomst till WKND GraphQL-innehåll.

   ```plain
   contentApi.endpoint=https://author-p123-e456.adobeaemcloud.com
   contentApi.user=my-special-android-app-user
   contentApi.password=password123
   ```

1. Hämta en [Virtuell Android-enhet](https://developer.android.com/studio/run/managing-avds) (minst API 28).
1. Skapa och distribuera appen med Android-emulatorn.


### Ansluta till AEM

Om du ansluter till en AEM författarmiljö [auktorisation](https://github.com/adobe/aem-headless-client-java#using-authorization) är obligatoriskt. The [AEMHeadlessClientBuilder](https://github.com/adobe/aem-headless-client-java/blob/main/client/src/main/java/com/adobe/aem/graphql/client/AEMHeadlessClientBuilder.java) ger möjlighet att använda [tokenbaserad autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html). Så här använder du tokenbaserad klientbyggare för uppdatering av autentisering i `AdventureLoader.java` och `AdventuresLoader.java`:

```java
/* Comment out basicAuth
 if (user != null && password != null) {
   builder.basicAuth(user, password);
 }
*/

// use token-authentication where `token` is a String representing the token
builder.tokenAuth(token)
```

## Koden

Nedan följer en kort sammanfattning av de filer och den kod som är viktiga för programmet. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/android-app).

### Beständiga frågor

Efter AEM Headless-metodtips använder iOS-programmet AEM GraphQL beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

+ `wknd/adventures-all` beständig fråga, som returnerar alla äventyr i AEM med en förkortad uppsättning egenskaper. Den här beständiga frågan styr den inledande vyns äventyrslista.

```
# Retrieves a list of all adventures
{
    adventureList {
        items {
            _path
            slug
            title
            price
            tripLength
            primaryImage {
                ... on ImageRef {
                _dynamicUrl
                _path
                }
            }
        }
    }
}
```

+ `wknd/adventure-by-slug` beständig fråga, som returnerar ett enda äventyr av `slug` (en anpassad egenskap som unikt identifierar ett äventyr) med en komplett uppsättning egenskaper. Den här beständiga frågan styr äventyrsdetaljvyerna.

```
# Retrieves an adventure Content Fragment based on it's slug
# Example query variables: 
# {"slug": "bali-surf-camp"} 
# Technically returns an adventure list but since the the slug 
# property is set to be unique in the CF Model, only a single CF is expected

query($slug: String!) {
  adventureList(filter: {
        slug: {
          _expressions: [ { value: $slug } ]
        }
      }) {
    items {
      _path
      title
      slug
      activity
      adventureType
      price
      tripLength
      groupSize
      difficulty
      price
      primaryImage {
        ... on ImageRef {
          _dynamicUrl
          _path
        }
      }
      description {
        json
        plaintext
      }
      itinerary {
        json
        plaintext
      }
    }
    _references {
      ...on AdventureModel {
        _path
        slug
        title
        price
        __typename
      }
    }
  }
}
```

### Kör GraphQL beständig fråga

AEM beständiga frågor körs via HTTP-GET och därmed [AEM Headless-klient för Java](https://github.com/adobe/aem-headless-client-java) används för att köra beständiga GraphQL-frågor mot AEM och läsa in äventyrsinnehållet i appen.

Varje beständig fråga har en motsvarande&quot;loader&quot;-klass, som asynkront anropar den AEM HTTP-GETENS slutpunkt och returnerar äventyrsdata med hjälp av den anpassade definierade [datamodell](#data-models).

+ `loader/AdventuresLoader.java`

  Hämtar listan med tillägg på programmets startsida med hjälp av `wknd-shared/adventures-all` beständig fråga.

+ `loader/AdventureLoader.java`

  Hämtar ett enskilt äventyr som markerar det via `slug` parameter, använda `wknd-shared/adventure-by-slug` beständig fråga.

```java
//AdventuresLoader.java

public static final String PERSISTED_QUERY_NAME = "/wknd-shared/adventures-all";
...
AEMHeadlessClientBuilder builder = AEMHeadlessClient.builder().endpoint(config.getContentApiEndpoint());

// Optional authentication for basic auth
String user = config.getContentApiUser();
String password = config.getContentApiPassword();

if (user != null && password != null) {
    builder.basicAuth(user, password);
}

AEMHeadlessClient client = builder.build();
// run a persistent query and get a response
GraphQlResponse response = client.runPersistedQuery(PERSISTED_QUERY_NAME);
```

### GraphQL svarsdatamodeller{#data-models}

`Adventure.java` är en Java POJO som initieras med JSON-data från GraphQL-begäran och modellerar ett äventyr för användning i Android-programmets vyer.

### Vyer

Android-programmet använder två vyer för att presentera äventyrsdata i mobilupplevelsen.

+ `AdventureListFragment.java`

  Anropar `AdventuresLoader` och visar de returnerade äventyren i en lista.

+ `AdventureDetailFragment.java`

  Anropar `AdventureLoader` med `slug` param som skickas via äventyret på `AdventureListFragment` och visar information om ett enskilt äventyr.

### Fjärrbilder

`loader/RemoteImagesCache.java` är en verktygsklass som hjälper till att förbereda fjärrbilder i ett cacheminne så att de kan användas med Android-gränssnittselement. Innehållet i äventyret refererar till bilder i AEM Assets via en URL och den här klassen används för att visa innehållet.

## Ytterligare resurser

+ [Komma igång med AEM Headless - självstudiekurs om GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html)
+ [AEM Headless Client for Java](https://github.com/adobe/aem-headless-client-java)
