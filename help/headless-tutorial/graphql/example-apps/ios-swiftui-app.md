---
title: iOS SwiftUI App - AEM Headless-exempel
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här iOS-programmet visas hur du använder AEM GraphQL API:er med beständiga frågor.
version: Cloud Service
mini-toc-levels: 1
kt: 9166
thumbnail: KT-9166.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 6c5373db-86ec-410b-8a3b-9d4f86e06812
source-git-commit: bcedb190fba7b6bc044da06bd36d097d553172a1
workflow-type: tm+mt
source-wordcount: '983'
ht-degree: 0%

---

# iOS SwiftUI-app

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här iOS-programmet visas hur du använder AEM GraphQL API:er med beständiga frågor.

![iOS SwiftUI-app med AEM Headless](./assets/ios-swiftui-app/ios-app.png)

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-swiftui-app)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Xcode 9.3+](https://developer.apple.com/xcode/) (kräver macOS)
+ [Git](https://git-scm.com/)

## AEM

iOS fungerar med följande AEM driftsättningsalternativ. Alla distributioner kräver [WKND Site v2.0.0+](https://github.com/adobe/aem-guides-wknd/releases/latest) som ska installeras.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html)
+ Lokal installation med [AEM Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html)
+ [AEM 6.5 SP13+ QuickStart](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=en#install-local-aem-instances)

iOS är utformat för att ansluta till en __AEM Publish__ -miljön kan den dock hämta innehåll från AEM Author om autentisering anges i iOS-programmets konfiguration.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql` databas:

   ```shell
   git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Starta [Xcode](https://developer.apple.com/xcode/) och öppna mappen `ios-swiftui-app`
1. Ändra filen `Config.xcconfig` fil och uppdatera `AEM_SCHEME` och `AEM_HOST` för att matcha din AEM-publiceringstjänst.

   ```plain
   // The http/https protocol scheme used to access the AEM_HOST
   AEM_SCHEME = http
   // Target hostname for AEM environment, do not include http:// or https://
   AEM_HOST = localhost:4503
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

Nedan följer en sammanfattning av hur iOS-programmet byggs, hur det ansluter till AEM Headless för att hämta innehåll med hjälp av beständiga GraphQL-frågor och hur data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-swiftui-app).

### Beständiga frågor

Efter AEM Headless-metodtips använder iOS-programmet AEM GraphQL-beständiga frågor för att fråga efter äventyrsdata. Programmet använder två beständiga frågor:

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
                _path
                mimeType
                width
                height
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
          _path
          mimeType
          width
          height
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

## Kör beständig GraphQL-fråga

AEM beständiga frågor körs över HTTP-GET och därför kan vanliga GraphQL-bibliotek som använder HTTP-POST som Apollo inte användas. Skapa i stället en anpassad klass som kör den beständiga frågan från HTTP GET till AEM.

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
    func getAdventures(completion: @escaping ([Adventure]) ->  ()) {
               
        // Create the HTTP request object representing the persisted query to get all adventures
        let request = makeRequest(persistedQueryName: "wknd-shared/adventures-all")
        
        // Wait fo the HTTP request to return
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Error check as needed
            if ((error) != nil) {
                print("Unable to connect to AEM GraphQL endpoint")
                completion([])
            }
                                    
            if (!data!.isEmpty) {
                // Decode the JSON data into Swift objects
                let adventures = try! JSONDecoder().decode(Adventures.self, from: data!)
                
                DispatchQueue.main.async {
                    // Return the array of Adventure objects
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

### GraphQL-svarsdatamodeller

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

Bilder som refereras av äventyrliga innehållsfragment hanteras av AEM. Den här iOS-appen använder sökvägen `_path` i GraphQL-svaret och prefixerar `AEM_SCHEME` och `AEM_HOST` för att skapa en fullständig URL.

Om du ansluter till skyddade resurser på AEM som kräver auktorisering, måste autentiseringsuppgifter också läggas till i bildbegäranden.

[SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) och [SDWebImage](https://github.com/SDWebImage/SDWebImage) används för att läsa in fjärrbilder från AEM som fyller i Adventure-bilden på `AdventureListItemView` och `AdventureDetailView` vyer.

The `aem` klass (in `AEM/Aem.swift`) underlättar användningen av AEM bilder på två sätt:

1. `aem.imageUrl(path: String)` används i vyer för att lägga till prepend-schemat i AEM och vara värd för bildens sökväg, vilket skapar en fullständigt kvalificerad URL.

   ```swift
   // adventure.image() => /content/dam/path/to/an/image.png
   let imageUrl = aem.imageUrl(path: adventure.image()) 
   // imageUrl => http://localhost:4503/content/dam/path/to/an/image.png
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

+ [Komma igång med AEM Headless - kursen GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html)
+ [SwiftUI Lists and Navigation Tutorial](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)
