---
title: Android-app - Exempel AEM Headless
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Ett Android-program tillhandahålls som demonstrerar hur du frågar efter innehåll med GraphQL API:er för AEM. Apollo Client Android används för att generera GraphQL-frågor och mappa data till Swift-objekt för att driva programmet. SwiftUI används för att återge en enkel list- och detaljvy av innehållet.
version: Cloud Service
mini-toc-levels: 1
kt: 9166
thumbnail: KT-9166.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
source-git-commit: 9b1e38c8d4a0301c124c6f1607a9e4362b0e9cd1
workflow-type: tm+mt
source-wordcount: '734'
ht-degree: 1%

---


# Android-app

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Ett Android-program tillhandahålls som demonstrerar hur du frågar efter innehåll med GraphQL API:er för AEM. The [AEM Headless Client for Java](https://github.com/adobe/aem-headless-client-java) används för att köra GraphQL-frågor och mappa data till Java-objekt för att styra programmet.

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/android-app)

>[!VIDEO](https://video.tv.adobe.com/v/338093/?quality=12&learn=on)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

* [Android Studio](https://developer.android.com/studio)
* [Git](https://git-scm.com/)

## AEM

Programmet är utformat för att ansluta till en AEM **Publicera** med den senaste versionen av [WKND-referensplats](https://github.com/adobe/aem-guides-wknd/releases/latest) installerade.

* [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/overview/introduction.html)
* [AEM 6.5.10+](https://experienceleague.adobe.com/docs/experience-manager-65/release-notes/service-pack/new-features-latest-service-pack.html)

Vi rekommenderar [distribuera WKND-referensplatsen till en Cloud Service-miljö](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/overview.html#coding-against-the-right-aem-version). En lokal konfiguration med [AEM Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html) eller [AEM 6.5 QuickStart jar](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=en#install-local-aem-instances) kan också användas.

## Så här använder du

1. Klona `aem-guides-wknd-graphql` databas:

   ```shell
   git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Starta [Android Studio](https://developer.android.com/studio) och öppna mappen `android-app`
1. Ändra filen `config.properties` på `app/src/main/assets/config.properties` och uppdatera `contentApi.endpoint` för att matcha AEM målmiljö:

   ```plain
   contentApi.endpoint=http://10.0.2.2:4502
   contentApi.user=admin
   contentApi.password=admin
   ```

1. Ladda ned en [Virtuell Android-enhet](https://developer.android.com/studio/run/managing-avds) (min-API 28)
1. Bygg och distribuera appen med Android-emulatorn.


### Ansluta till AEM

`10.0.2.2` är en [specialalias](https://developer.android.com/studio/run/emulator-networking) för localhost när emulatorn används. Så `10.0.2.2:4502` motsvarar `localhost:4502`. Om du ansluter till en AEM publiceringsmiljö (rekommenderas) krävs ingen behörighet och `contentAPi.user` och `contentApi.password` kan lämnas tom.

Om du ansluter till en AEM författarmiljö [auktorisation](https://github.com/adobe/aem-headless-client-java#using-authorization) krävs. Som standard är programmet konfigurerat att använda grundläggande autentisering med användarnamnet och lösenordet `admin:admin`. The [AEMHeadlessClientBuilder](https://github.com/adobe/aem-headless-client-java/blob/main/client/src/main/java/com/adobe/aem/graphql/client/AEMHeadlessClientBuilder.java) ger möjlighet att använda [tokenbaserad autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html). Så här använder du tokenbaserad klientbyggare för uppdatering av autentisering i `AdventureLoader.java` och `AdventuresLoader.java`:

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

### Hämtar innehåll

The [AEM Headless Client for Java](https://github.com/adobe/aem-headless-client-java) används av programmet för att köra GraphQL-frågan mot AEM och läsa in äventyrsinnehållet i appen.

`AdventuresLoader.java` är den fil som hämtar och läser in den inledande listan med annonser på programmets startskärm. Den använder [Beständiga frågor](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/video-series/graphql-persisted-queries.html) som [färdigförpackad](https://github.com/adobe/aem-guides-wknd/tree/master/ui.content/src/main/content/jcr_root/conf/wknd/settings/graphql/persistentQueries/adventures-all/_jcr_content) med WKND-referenswebbplatsen. Slutpunkten är `/wknd/adventures-all`. `AEMHeadlessClientBuilder` instansierar en ny instans baserat på API-slutpunktsuppsättningen i `config.properties`.

```java
//AdventuresLoader.java

public static final String PERSISTED_QUERY_NAME = "/wknd/adventures-all";
...
AEMHeadlessClientBuilder builder = AEMHeadlessClient.builder().endpoint(config.getContentApiEndpoint());
// optional authentication for basic auth
String user = config.getContentApiUser();
String password = config.getContentApiPassword();
if (user != null && password != null) {
    builder.basicAuth(user, password);
}

AEMHeadlessClient client = builder.build();
// run a persistent query and get a response
GraphQlResponse response = client.runPersistedQuery(PERSISTED_QUERY_NAME);
```

`AdventureLoader.java` är den fil som hämtar och läser in Adventure-innehållet för var och en av detaljvyerna. Igen `AEMHeadlessClient` används för att köra frågan. En vanlig graphQL-fråga körs baserat på sökvägen till Adventure-innehållets fragment. Frågan finns i en separat fil med namnet [adventureByPath.query](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/android-app/app/src/main/assets/adventureByPath.query)

```java
AEMHeadlessClientBuilder builder = AEMHeadlessClient.builder().endpoint(config.getContentApiEndpoint());
String user = config.getContentApiUser();
String password = config.getContentApiPassword();
if (user != null && password != null) {
    builder.basicAuth(user, password);
}
AEMHeadlessClient client = builder.build();

// based on the file adventureByPath.query
String query = readFile(getContext(), QUERY_FILE_NAME);

// construct a parameter map to dynamically pass in adventure path
Map<String, Object> params = new HashMap<>();
params.put("adventurePath", this.path);

// execute the query based on the adventureByPath query and passed in parameters
GraphQlResponse response = client.runQuery(query, params);
```

`Adventure.java` är en POJO som initieras med JSON-data från GraphQL-begäran.

`RemoteImagesCache.java` är en verktygsklass som hjälper till att förbereda fjärrbilder i ett cacheminne så att de kan användas med Android-gränssnittselement. Adventure-innehållet refererar till bilder i AEM Assets via en URL och den här klassen används för att visa det innehållet.

### Vyer

`AdventureListFragment.java` - vid anrop utlöses `AdventuresLoader` och visar de returnerade äventyren i en lista.

`AdventureDetailFragment.java` - initialiserar `AdventureLoader` och visar information om ett enskilt äventyr.

## Ytterligare resurser

* [Komma igång med AEM Headless - kursen GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html)
* [AEM Headless Client for Java](https://github.com/adobe/aem-headless-client-java)

