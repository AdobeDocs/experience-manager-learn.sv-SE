---
title: iOS App - AEM Headless-exempel
description: Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I det här iOS-programmet visas hur du använder AEM GraphQL-API:er med beständiga frågor.
version: Experience Manager as a Cloud Service
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
duration: 278
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '917'
ht-degree: 0%

---

# iOS

Exempelprogram är ett bra sätt att utforska de headless-funktionerna i Adobe Experience Manager (AEM). I det här iOS-programmet visas hur du använder AEM GraphQL-API:er med beständiga frågor.

![iOS SwiftUI-app med AEM Headless](./assets/ios-swiftui-app/ios-app.png)

Visa [källkoden på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-app)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Xcode](https://developer.apple.com/xcode/) (kräver macOS)
+ [Git](https://git-scm.com/)

## AEM

IOS fungerar med följande distributionsalternativ för AEM. Alla distributioner kräver att [WKND-platsen v3.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) är installerad.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html?lang=sv-SE)
+ Lokal konfiguration med [SDK för AEM Cloud-tjänsten](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html?lang=sv-SE)

IOS-programmet är utformat för att ansluta till en __AEM Publish__ -miljö, men det kan hämta innehåll från AEM Author om autentisering anges i iOS-programmets konfiguration.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql`-databasen:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna [Xcode](https://developer.apple.com/xcode/) och öppna mappen `ios-app`
1. Ändra filen `Config.xcconfig` och uppdatera `AEM_SCHEME` och `AEM_HOST` så att den matchar AEM-målpubliceringstjänsten.

   ```plain
   // The http/https protocol scheme used to access the AEM_HOST
   AEM_SCHEME = https
   // Target hostname for AEM environment, do not include http:// or https://
   AEM_HOST = publish-p123-e456.adobeaemcloud.com
   ```

   Om du ansluter till AEM Author lägger du till autentiseringsegenskaperna `AEM_AUTH_TYPE` och tillhörande autentiseringsegenskaper i `Config.xcconfig`.

   __Grundläggande autentisering__

   `AEM_USERNAME` och `AEM_PASSWORD` autentiserar en lokal AEM-användare med åtkomst till WKND GraphQL-innehåll.

   ```plain
   AEM_AUTH_TYPE = basic
   AEM_USERNAME = admin
   AEM_PASSWORD = admin
   ```

   __Tokenautentisering__

   `AEM_TOKEN` är en [åtkomsttoken](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html?lang=sv-SE) som autentiserar en AEM-användare med åtkomst till WKND GraphQL-innehåll.

   ```plain
   AEM_AUTH_TYPE = token
   AEM_TOKEN = abcd...0123
   ```

1. Bygg applikationen med Xcode och distribuera den till iOS-simulatorn
1. En lista över äventyr från WKND-webbplatsen ska visas i programmet. Om du väljer ett äventyr öppnas äventyrsinformationen. Uppdatera data från AEM genom att dra i äventyrslistvyn.

## Koden

Nedan följer en sammanfattning av hur iOS-programmet byggs, hur det ansluter till AEM Headless för att hämta innehåll med GraphQL beständiga frågor och hur dessa data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-app).

### Beständiga frågor

I enlighet med bästa praxis för AEM Headless använder iOS-programmet AEM GraphQL-beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

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

+ `wknd/adventure-by-slug` beständig fråga, som returnerar ett enskilt äventyr från `slug` (en anpassad egenskap som unikt identifierar ett äventyr) med en fullständig uppsättning egenskaper. Den här beständiga frågan styr äventyrsdetaljvyerna.

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

AEM beständiga frågor körs över HTTP GET och därför kan vanliga GraphQL-bibliotek som använder HTTP POST, till exempel Apollo, inte användas. Skapa i stället en anpassad klass som kör den beständiga frågan från HTTP GET till AEM.

`AEM/Aem.swift` instansierar klassen `Aem` som används för alla interaktioner med AEM Headless. Mönstret är:

1. Varje beständig fråga har en motsvarande offentlig funktion (t.ex. `getAdventures(..)` eller `getAdventureBySlug(..)`) iOS-programmets vyer anropas för att hämta äventyrsdata.
1. Funktionen public anropar en privat funktion `makeRequest(..)` som anropar en asynkron HTTP GET-begäran till AEM Headless och returnerar JSON-data.
1. Varje offentlig funktion avkodar sedan JSON-data och utför alla nödvändiga kontroller eller omvandlingar innan Adventure-data returneras till vyn.

   + AEM GraphQL JSON-data avkodas med hjälp av de strukturer/klasser som definieras i `AEM/Models.swift`, som mappar till JSON-objekten som returnerade mitt AEM Headless.

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

`src/AEM/Models.swift` definierar de [decoeable](https://developer.apple.com/documentation/swift/decodable) Swift-strukturer och klasser som mappar till AEM JSON-svaren som returneras av AEM JSON-svar.

### Vyer

SwiftUI används för de olika vyerna i programmet. I Apple finns en självstudiekurs för att komma igång med [skapa listor och navigering med SwiftUI](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation).

+ `WKNDAdventuresApp.swift`

  Programposten och innehåller `AdventureListView` vars `.onAppear`-händelsehanterare används för att hämta alla äventyrsdata via `aem.getAdventures()`. Det delade `aem`-objektet initieras här och exponeras för andra vyer som ett [EnvironmentObject](https://developer.apple.com/documentation/swiftui/environmentobject).

+ `Views/AdventureListView.swift`

  Visar en lista med äventyr (baserat på data från `aem.getAdventures()`) och visar ett listobjekt för varje äventyr med hjälp av `AdventureListItemView`.

+ `Views/AdventureListItemView.swift`

  Visar varje objekt i äventyrslistan (`Views/AdventureListView.swift`).

+ `Views/AdventureDetailView.swift`

  Visar information om ett äventyr, inklusive titel, beskrivning, pris, aktivitetstyp och primär bild. Den här vyn frågar AEM efter fullständig äventyrsinformation med hjälp av `aem.getAdventureBySlug(slug: slug)`, där parametern `slug` skickas baserat på urvalslistraden.

### Fjärrbilder

Bilder som refereras av äventyrliga innehållsfragment hanteras av AEM. Den här iOS-appen använder sökvägsfältet `_dynamicUrl` i GraphQL-svaret och prefixerar `AEM_SCHEME` och `AEM_HOST` för att skapa en fullständigt kvalificerad URL. Om du utvecklar mot AE SDK returnerar `_dynamicUrl` null, så för utveckling återgår du till bildens `_path`-fält.

Om du ansluter till skyddade resurser på AEM som kräver auktorisering, måste autentiseringsuppgifter också läggas till i bildbegäranden.

[SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) och [SDWebImage](https://github.com/SDWebImage/SDWebImage) används för att läsa in fjärrbilder från AEM som fyller i Adventure-bilden i vyerna `AdventureListItemView` och `AdventureDetailView`.

Klassen `aem` (i `AEM/Aem.swift`) underlättar användningen av AEM-bilder på två sätt:

1. `aem.imageUrl(path: String)` används i vyer för att lägga till prepend för AEM-schemat och vara värd för bildens sökväg, vilket skapar en fullständigt kvalificerad URL.

   ```swift
   // adventure.image() => /adobe/dynamicmedia/deliver/dm-aid--741ed388-d5f8-4797-8095-10c896dc9f1d/example.jpg?quality=80&preferwebp=true
   
   let imageUrl = aem.imageUrl(path: adventure.image()) 
   // imageUrl => https://publish-p123-e456.adobeaemcloud.com/adobe/dynamicmedia/deliver/dm-aid--741ed388-d5f8-4797-8095-10c896dc9f1d/example.jpg?quality=80&preferwebp=true
   ```

2. `convenience init(..)` i `Aem` anger rubriker för HTTP-auktorisering på avbildningens HTTP-begäran, baserat på iOS-programkonfigurationen.

   + Om __grundläggande autentisering__ har konfigurerats bifogas grundläggande autentisering till alla bildbegäranden.

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

   + Om __tokenautentisering__ har konfigurerats kopplas tokenautentisering till alla bildbegäranden.

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

   + Om __ingen autentisering__ har konfigurerats bifogas ingen autentisering till bildbegäranden.

En liknande metod kan användas med SwiftUI-inbyggt [AsyncImage](https://developer.apple.com/documentation/swiftui/asyncimage). `AsyncImage` stöds i iOS 15.0+.

## Ytterligare resurser

+ [Komma igång med AEM Headless - självstudiekurs för GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html?lang=sv-SE)
+ [SwiftUI Lists and Navigation Tutorial](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)
