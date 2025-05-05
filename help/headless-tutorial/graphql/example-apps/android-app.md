---
title: Android App - AEM Headless-exempel
description: Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I det här Android-programmet visas hur du frågar efter innehåll med GraphQL API:er för AEM.
version: Experience Manager as a Cloud Service
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
duration: 160
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '614'
ht-degree: 0%

---

# Android App

Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I det här Android-programmet visas hur du frågar efter innehåll med GraphQL API:er för AEM. [AEM Headless Client för Java](https://github.com/adobe/aem-headless-client-java) används för att köra GraphQL-frågor och mappa data till Java-objekt för att styra programmet.

![Android Java-appen med AEM Headless](./assets/android-java-app/android-app.png)


Visa [källkoden på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/android-app)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Android Studio](https://developer.android.com/studio)
+ [Git](https://git-scm.com/)

## AEM

Android fungerar med följande distributionsalternativ för AEM. Alla distributioner kräver att [WKND-platsen v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) är installerad.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html?lang=sv-SE)

Android-programmet är utformat för att ansluta till en __AEM Publish__ -miljö, men det kan hämta innehåll från AEM Author om autentisering anges i Android-programmets konfiguration.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql`-databasen:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna [Android Studio](https://developer.android.com/studio) och öppna mappen `android-app`
1. Ändra filen `config.properties` vid `app/src/main/assets/config.properties` och uppdatera `contentApi.endpoint` så att den matchar AEM-målmiljön:

   ```plain
   contentApi.endpoint=https://publish-p123-e456.adobeaemcloud.com
   ```

   __Grundläggande autentisering__

   `contentApi.user` och `contentApi.password` autentiserar en lokal AEM-användare med åtkomst till WKND GraphQL-innehåll.

   ```plain
   contentApi.endpoint=https://author-p123-e456.adobeaemcloud.com
   contentApi.user=my-special-android-app-user
   contentApi.password=password123
   ```

1. Hämta en [virtuell Android-enhet](https://developer.android.com/studio/run/managing-avds) (minst API 28).
1. Bygg och distribuera appen med Android-emulatorn.


### Ansluta till AEM-miljöer

Om du ansluter till en AEM-redigeringsmiljö krävs [behörighet](https://github.com/adobe/aem-headless-client-java#using-authorization). [AEMHeadlessClientBuilder](https://github.com/adobe/aem-headless-client-java/blob/main/client/src/main/java/com/adobe/aem/graphql/client/AEMHeadlessClientBuilder.java) ger möjlighet att använda [tokenbaserad autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html?lang=sv-SE). Så här använder du tokenbaserad klientbyggare för uppdatering av autentisering i `AdventureLoader.java` och `AdventuresLoader.java`:

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

I enlighet med bästa praxis för AEM Headless använder iOS-programmet AEM GraphQL-beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

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

+ `wknd/adventure-by-slug` beständig fråga, som returnerar ett enskilt äventyr från `slug` (en anpassad egenskap som unikt identifierar ett äventyr) med en fullständig uppsättning egenskaper. Den här beständiga frågan styr äventyrsdetaljvyerna.

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

AEM beständiga frågor körs över HTTP GET och därför används klienten [AEM Headless för Java](https://github.com/adobe/aem-headless-client-java) för att köra beständiga GraphQL-frågor mot AEM och läsa in äventyret i appen.

Varje beständig fråga har en motsvarande inläsarklass, som asynkront anropar AEM HTTP GET-slutpunkten och returnerar äventyrsdata med den anpassade definierade [datamodellen](#data-models).

+ `loader/AdventuresLoader.java`

  Hämtar listan med tillägg på programmets startskärm med hjälp av den `wknd-shared/adventures-all` beständiga frågan.

+ `loader/AdventureLoader.java`

  Hämtar ett enskilt äventyr som markerar det via parametern `slug`, med hjälp av den `wknd-shared/adventure-by-slug` beständiga frågan.

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

`Adventure.java` är en Java POJO som initieras med JSON-data från GraphQL-begäran och modellerar ett äventyr som ska användas i Android-programmets vyer.

### Vyer

Android-programmet använder två vyer för att presentera äventyrsdata i mobilupplevelsen.

+ `AdventureListFragment.java`

  Anropar `AdventuresLoader` och visar de returnerade äventyren i en lista.

+ `AdventureDetailFragment.java`

  Anropar `AdventureLoader` med den `slug`-parameter som skickas via äventyvalet i vyn `AdventureListFragment` och visar information om ett enskilt äventyr.

### Fjärrbilder

`loader/RemoteImagesCache.java` är en verktygsklass som hjälper till att förbereda fjärrbilder i ett cacheminne så att de kan användas med Android UI-element. Innehållet i äventyret refererar till bilder i AEM Assets via en URL och den här klassen används för att visa innehållet.

## Ytterligare resurser

+ [Komma igång med AEM Headless - självstudiekurs för GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html?lang=sv-SE)
+ [AEM Headless Client för Java](https://github.com/adobe/aem-headless-client-java)
