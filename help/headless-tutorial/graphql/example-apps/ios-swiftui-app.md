---
title: iOS App - AEM Headless-exempel
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här iOS-programmet visas hur du använder AEM GraphQL-API:er med beständiga frågor.
version: Cloud Service
mini-toc-levels: 2
jira: KT-10587
thumbnail: KT-10587.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
last-substantial-update: 2023-05-10T00:00:00Z
badgeVersions: label="AEM Headless as a Cloud Service" before-title="false"
exl-id: 6c5373db-86ec-410b-8a3b-9d4f86e06812
duration: 356
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '917'
ht-degree: 0%

---

# iOS

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här iOS-programmet visas hur du använder AEM GraphQL-API:er med beständiga frågor.

![iOS SwiftUI-app med AEM Headless](./assets/ios-swiftui-app/ios-app.png)

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-app)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Xcode](https://developer.apple.com/xcode/) (kräver macOS)
+ [Git](https://git-scm.com/)

## AEM

IOS fungerar med följande AEM driftsättningsalternativ. Alla distributioner kräver [WKND Site v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) installeras.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html)
+ Lokal installation med [AEM Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html)

IOS är utformat för att ansluta till en __AEM Publish__ -miljön kan däremot hämta innehåll från AEM författare om autentisering anges i iOS-programmets konfiguration.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql` databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Starta [Xcode](https://developer.apple.com/xcode/) och öppna mappen `ios-app`
1. Ändra filen `Config.xcconfig` fil och uppdatera `AEM_SCHEME` och `AEM_HOST` för att matcha AEM publiceringstjänst.

   ```plain
   // The http/https protocol scheme used to access the AEM_HOST
   AEM_SCHEME = https
   // Target hostname for AEM environment, do not include http:// or https://
   AEM_HOST = publish-p123-e456.adobeaemcloud.com
   ```

   Lägg till `AEM_AUTH_TYPE` och tillhörande autentiseringsegenskaper för `Config.xcconfig`.

   __Grundläggande autentisering__

   The `AEM_USERNAME` och `AEM_PASSWORD` autentisera en lokal AEM med åtkomst till WKND GraphQL-innehåll.

   ```plain
   AEM_AUTH_TYPE = basic
   AEM_USERNAME = admin
   AEM_PASSWORD = admin
   ```

   __Tokenautentisering__

   The `AEM_TOKEN` är en [åtkomsttoken](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html) som autentiserar en AEM med åtkomst till WKND GraphQL-innehåll.

   ```plain
   AEM_AUTH_TYPE = token
   AEM_TOKEN = abcd...0123
   ```

1. Bygg applikationen med Xcode och distribuera den till iOS-simulatorn
1. En lista över äventyr från WKND-webbplatsen ska visas i programmet. Om du väljer ett äventyr öppnas äventyrsinformationen. Uppdatera data från AEM genom att dra i äventyrslistvyn.

## Koden

Nedan följer en sammanfattning av hur iOS-programmet byggs, hur det ansluter till AEM Headless för att hämta innehåll med GraphQL beständiga frågor och hur dessa data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-app).

### Beständiga frågor

Efter AEM Headless-metodtips använder iOS-programmet AEM GraphQL beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

+ `wknd/adventures-all` beständig fråga, som returnerar alla äventyr i AEM med en förkortad uppsättning egenskaper. Den här beständiga frågan styr den inledande vyns äventyrslista.

```
# Retrieves a list of all Adventures
#
# Optional query variables:
# - { "offset": 10 }
# - { "limit": 5 }
# - { 
#    "imageFormat": "JPG",
#    "imageWidth": 1600,
#    "imageQuality": 90 
#   }

query ($offset: Int, $limit: Int, $sort: String, $imageFormat: AssetTransformFormat=JPG, $imageWidth: Int=1200, $imageQuality: Int=80) {
  adventureList(
    offset: $offset
    limit: $limit
    sort: $sort
    _assetTransform: {
      format: $imageFormat
      width: $imageWidth
      quality: $imageQuality
      preferWebp: true
  }) {
    items {
      _path
      slug
      title
      activity
      price
      tripLength
      primaryImage {
        ... on ImageRef {
          _path
          _dynamicUrl
        }
      }
    }
  }
}
```

+ `wknd/adventure-by-slug` beständig fråga, som returnerar ett enda äventyr av `slug` (en anpassad egenskap som unikt identifierar ett äventyr) med en komplett uppsättning egenskaper. Den här beständiga frågan styr äventyrsdetaljvyerna.

```
query ($slug: String!, $imageFormat:AssetTransformFormat=JPG, $imageSeoName: String, $imageWidth: Int=1200, $imageQuality: Int=80) {
  adventureList(
    filter: {slug: {_expressions: [{value: $slug}]}}
    _assetTransform: {
      format: $imageFormat
      seoName: $imageSeoName
      width: $imageWidth
      quality: $imageQuality
      preferWebp: true
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
          _path
          _dynamicUrl
        }
      }
      description {
        json
        plaintext
        html
      }
      itinerary {
        json
        plaintext
        html
      }
    }
    _references {
      ... on AdventureModel {
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

AEM beständiga frågor körs via HTTP-GET och därför kan vanliga GraphQL-bibliotek som använder HTTP-POST som Apollo inte användas. Skapa i stället en anpassad klass som kör den beständiga frågan från HTTP GET till AEM.

`AEM/Aem.swift` instansierar `Aem` klass som används för all interaktion med AEM Headless. Mönstret är:

1. Varje beständig fråga har en motsvarande offentlig funktion (t.ex. `getAdventures(..)` eller `getAdventureBySlug(..)`) iOS-programmets vyer anropas för att få fram äventyrsdata.
1. Den offentliga funktionen anropar en privat funktion `makeRequest(..)` som anropar en asynkron HTTP GET-begäran till AEM Headless och returnerar JSON-data.
1. Varje offentlig funktion avkodar sedan JSON-data och utför alla nödvändiga kontroller eller omvandlingar innan Adventure-data returneras till vyn.

   + AEM GraphQL JSON-data avkodas med hjälp av de strukturer/klasser som definieras i `AEM/Models.swift`, som mappas till JSON-objekten returnerade min AEM Headless.

```swift
    /// # getAdventures(..)
    /// Returns all WKND adventures using the `wknd-shared/adventures-all` persisted query.
    /// For this func call to work, the `wknd-shared/adventures-all` query must be deployed to the AEM environment/service specified by the host.
    /// 
    /// Since HTTP requests are async, the completion syntax is used.
    func getAdventures(params: [String:String], completion: @escaping ([Adventure]) ->  ()) {
               
        let request = makeRequest(persistedQueryName: "wknd-shared/adventures-all", params: params)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if ((error) != nil) {
                print("Unable to connect to AEM GraphQL endpoint")
                completion([])
            } else if (!data!.isEmpty) {
                let adventures = try! JSONDecoder().decode(Adventures.self, from: data!)
                DispatchQueue.main.async {
                    completion(adventures.data.adventureList.items)
                }
            }
        }.resume();
    }
    
    ...

    /// #makeRequest(..)
    /// Generic method for constructing and executing AEM GraphQL persisted queries
    private func makeRequest(persistedQueryName: String, params: [String: String] = [:]) -> URLRequest {
        // Encode optional parameters as required by AEM
        let persistedQueryParams = params.map { (param) -> String in
            encode(string: ";\(param.key)=\(param.value)")
        }.joined(separator: "")
        
        // Construct the AEM GraphQL persisted query URL, including optional query params
        let url: String = "\(self.scheme)://\(self.host)/graphql/execute.json/" + persistedQueryName + persistedQueryParams;

        var request = URLRequest(url: URL(string: url)!);

        // Add authentication to the AEM GraphQL persisted query requests as defined by the iOS application's configuration
        request = addAuthHeaders(request: request)
        
        return request
    }
    
    ...
```

### GraphQL svarsdatamodeller

iOS föredrar att mappa JSON-objekt till datamodeller.

The `src/AEM/Models.swift` definierar [avkodningsbar](https://developer.apple.com/documentation/swift/decodable) Swift-strukturer och klasser som mappar till AEM JSON-svar som returneras av AEM JSON-svar.

### Vyer

SwiftUI används för de olika vyerna i programmet. Apple har en självstudiekurs för att komma igång [bygga listor och navigering med SwiftUI](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation).

+ `WKNDAdventuresApp.swift`

  Ansökan innehåller följande uppgifter: `AdventureListView` vars `.onAppear` händelsehanteraren används för att hämta alla äventyrsdata via `aem.getAdventures()`. Den delade `aem` objektet initieras här och exponeras för andra vyer som ett [EnvironmentObject](https://developer.apple.com/documentation/swiftui/environmentobject).

+ `Views/AdventureListView.swift`

  Visar en lista över äventyr (baserat på data från `aem.getAdventures()`) och visar ett listobjekt för varje äventyr med `AdventureListItemView`.

+ `Views/AdventureListItemView.swift`

  Visar varje objekt i äventyrslistan (`Views/AdventureListView.swift`).

+ `Views/AdventureDetailView.swift`

  Visar information om ett äventyr, inklusive titel, beskrivning, pris, aktivitetstyp och primär bild. Den här vyn AEM om du vill ha fullständig äventyrsinformation med `aem.getAdventureBySlug(slug: slug)`, där `slug` parametern skickas in baserat på urvalslisteraden.

### Fjärrbilder

Bilder som refereras av äventyrliga innehållsfragment hanteras av AEM. Den här iOS-appen använder sökvägen `_dynamicUrl` i GraphQL och prefix `AEM_SCHEME` och `AEM_HOST` för att skapa en fullständig URL. Om du utvecklar mot AE SDK `_dynamicUrl` returnerar null, så för utvecklarreserv till bildens `_path` fält.

Om du ansluter till skyddade resurser på AEM som kräver auktorisering, måste autentiseringsuppgifter också läggas till i bildbegäranden.

[SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) och [SDWebImage](https://github.com/SDWebImage/SDWebImage) används för att läsa in fjärrbilder från AEM som fyller i Adventure-bilden på `AdventureListItemView` och `AdventureDetailView` vyer.

The `aem` klass (in `AEM/Aem.swift`) underlättar användningen av AEM bilder på två sätt:

1. `aem.imageUrl(path: String)` används i vyer för att lägga till prepend-schemat i AEM och vara värd för bildens sökväg, vilket skapar en fullständigt kvalificerad URL.

   ```swift
   // adventure.image() => /adobe/dynamicmedia/deliver/dm-aid--741ed388-d5f8-4797-8095-10c896dc9f1d/example.jpg?quality=80&preferwebp=true
   
   let imageUrl = aem.imageUrl(path: adventure.image()) 
   // imageUrl => https://publish-p123-e456.adobeaemcloud.com/adobe/dynamicmedia/deliver/dm-aid--741ed388-d5f8-4797-8095-10c896dc9f1d/example.jpg?quality=80&preferwebp=true
   ```

2. The `convenience init(..)` in `Aem` ange rubriker för HTTP-auktorisering på image-HTTP-begäran, baserat på iOS-programkonfigurationen.

   + If __grundläggande autentisering__ är konfigurerat kopplas grundläggande autentisering till alla bildbegäranden.

   ```swift
   /// AEM/Aem.swift
   ///
   /// # Basic authentication init
   /// Used when authenticating to AEM using local accounts (basic auth)
   convenience init(scheme: String, host: String, username: String, password: String) {
       ...
   
       // Add basic auth headers to all Image requests, as they are (likely) protected as well
       SDWebImageDownloader.shared.setValue("Basic \(encodeBasicAuth(username: username, password: password))", forHTTPHeaderField: "Authorization")
   }
   ```

   + If __tokenautentisering__ är konfigurerat kopplas tokenautentisering till alla bildbegäranden.

   ```swift
   /// AEM/Aem.swift
   ///
   /// # Token authentication init
   ///  Used when authenticating to AEM using token authentication (Dev Token or access token generated from Service Credentials)
   convenience init(scheme: String, host: String, token: String) {
       ...
   
       // Add token auth headers to all Image requests, as they are (likely) protected as well
       SDWebImageDownloader.shared.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
   }
   ```

   + If __ingen autentisering__ är konfigurerad, ingen autentisering är kopplad till bildbegäranden.

Ett liknande tillvägagångssätt kan användas med SwiftUI-inbyggt [AsyncImage](https://developer.apple.com/documentation/swiftui/asyncimage). `AsyncImage` stöds i iOS 15.0+.

## Ytterligare resurser

+ [Komma igång med AEM Headless - självstudiekurs om GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html)
+ [SwiftUI Lists and Navigation Tutorial](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)
