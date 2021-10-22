---
title: iOS SwiftUI App - AEM Headless-exempel
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Ett iOS-program som demonstrerar hur du frågar efter innehåll med GraphQL-API:er för AEM. Apollo Client iOS används för att generera GraphQL-frågor och mappa data till Swift-objekt för att driva programmet. SwiftUI används för att återge en enkel list- och detaljvy av innehållet.
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
source-wordcount: '960'
ht-degree: 0%

---


# iOS SwiftUI-app

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). I det här iOS-programmet visas hur du frågar efter innehåll med GraphQL-API:er för AEM. Apollo Client iOS används för att generera GraphQL-frågor och mappa data till Swift-objekt för att driva programmet. SwiftUI används för att återge en enkel list- och detaljvy av innehållet.

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-swiftui-app)

>[!VIDEO](https://video.tv.adobe.com/v/338042/?quality=12&learn=on)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

* [Xcode 9.3+](https://developer.apple.com/xcode/)
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

1. Starta [Xcode](https://developer.apple.com/xcode/) och öppna mappen `ios-swiftui-app`
1. Ändra filen `Config.xcconfig` fil och uppdatera `AEM_HOST` för att matcha målmiljön för AEM-publicering

   ```plain
   // Target hostname for AEM environment, do not include http:// or https://
   AEM_HOST = localhost:4503
   // GraphQL Endpoint
   AEM_GRAPHQL_ENDPOINT = /content/cq:graphql/wknd/endpoint.json
   ```

1. Bygg applikationen med Xcode och distribuera den till iOS-simulatorn
1. En lista över äventyr från WKND-referensplatsen ska visas i programmet.

## Koden

Nedan följer en kort sammanfattning av de filer och den kod som är viktiga för programmet. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-swiftui-app).

### Apollo iOS

The [Apollo iOS](https://www.apollographql.com/docs/ios/) klienten används av programmet för att köra GraphQL-frågan mot AEM. Tjänstemannen [Apollo Tutorial](https://www.apollographql.com/docs/ios/tutorial/tutorial-introduction/) har mycket mer information om hur du installerar och använder.

`schema.json` är en fil som representerar GraphQL-schemat från en AEM med WKND-referensplatsen installerad. `schema.json` har hämtats från AEM och lagts till i projektet. Apollo-klienten undersöker alla filer med tillägget `.graphql` som en del av en anpassad byggfas. Apollo-klienten använder sedan `schema.json` och alla `.graphql` frågor som automatiskt genererar filen `API.swift`.

Detta ger programmet en starkt typifierad modell för att köra frågan och modellerna som representerar resultaten.

![Anpassad Xcode-byggfas](assets/ios-swiftui-app/xcode-build-phase-apollo.png)

`AdventureList.graphql` innehåller frågan som används för att fråga efter äventyren:

```
query AdventureList
{
  adventureList {
    items {
      _path
      adventureTitle
      adventurePrice
      adventureActivity
      adventureDescription {
        plaintext
        markdown
      }
      adventureDifficulty
      adventureTripLength
      adventurePrimaryImage {
        ...on ImageRef {
          _authorUrl
          _publishUrl
        }
      }
    }
  }
}
```

`Network.swift` skapar `ApolloClient`. The `endpointURL` som används konstrueras genom att värdena för `Config.xcconfig` -fil. Om du vill ansluta till en AEM **Upphovsman** -instans och om du behöver lägga till ytterligare rubriker för autentisering, vill du ändra `ApolloClient` här.

```swift
// Network.swift
private(set) lazy var apollo: ApolloClient = {
        // The cache is necessary to set up the store, which we're going to hand to the provider
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
  
        let client = URLSessionClient()
        let provider = DefaultInterceptorProvider(client: client, shouldInvalidateClientOnDeinit: true, store: store)
        let url = Connection.baseURL // from Configx.xcconfig 

        // no additional headers, public instances by default require no additional authentication
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)

        return ApolloClient(networkTransport: requestChainTransport,store: store)
    }()
}
```

### Adventure Data

Programmet är utformat för att visa en lista med annonser och sedan en detaljvy över varje äventyr.

`AdventuresDataModel.swift` är en klass som innehåller en funktion `fetchAdventures()`. Den här funktionen använder `ApolloClient` för att köra frågan. Vid en slutförd fråga kommer resultatarrayen att vara av typen `AdventureListQuery.Data.AdventureList.Item`, autogenereras av `API.swift` -fil.

```swift
func fetchAdventures() {
        Network.shared.apollo
            //AdventureListQuery() generated based on AdventureList.graphql file
           .fetch(query: AdventureListQuery()) { [weak self] result in
           
             guard let self = self else {
               return
             }
                   
             switch result {
             case .success(let graphQLResult):
                print("Success AdventureListQuery() from: \(graphQLResult.source)")

                if let adventureDataItems =  graphQLResult.data?.adventureList.items {
                    // map graphQL items to an array of Adventure objects
                    self.adventures = adventureDataItems.compactMap { Adventure(adventureData: $0!) }
                }
                ...
             }
           }
}
```

Det är möjligt att använda `AdventureListQuery.Data.AdventureList.Item` direkt för att driva programmet. Det är dock mycket möjligt att vissa data är ofullständiga och därför kan vissa egenskaper vara null.

`Adventure.swift` är en anpassad modell som introduceras som en wrapper av modellen som genereras av Apollo. `Adventure` initieras med `AdventureListQuery.Data.AdventureList.Item`. A `typealias` används för att göra koden mer läsbar:

```
// use typealias
typealias AdventureData = AdventureListQuery.Data.AdventureList.Item
```

The `Adventure` -strukturen initieras med en `AdventureData` objekt:

```swift
struct Adventure: Identifiable {
    let id: String
    let adventureTitle: String
    let adventurePrice: String
    let adventureDescription: String
    let adventureActivity: String
    let adventurePrimaryImageUrl: String
    
    // initialize with AdventureData object aka AdventureListQuery.Data.AdventureList.Item
    init(adventureData: AdventureData) {
        // use path as unique idenitifer, otherwise
        self.id = adventureData._path ?? UUID().uuidString
        self.adventureTitle = adventureData.adventureTitle ?? "Untitled"
        self.adventurePrice = adventureData.adventurePrice ?? "Free"
        self.adventureActivity = adventureData.adventureActivity ?? ""
        ...
```

På så sätt kan vi ange standardvärden och utföra ytterligare kontroller för ofullständiga data. Vi kan sedan använda `Adventure` modellera säkert för att driva olika UI-element och behöver inte hela tiden kontrollera om det finns null-värden.

I AEM identifieras innehållsdelar unikt av `_path`. I `Adventure.swift` vi fyller `id` egenskap med värdet för `_path`. Detta gör att `Adventure` att implementera `Identifiable` och gör det enklare att iterera över en array eller lista.

### Vyer

SwiftUI används för de olika vyerna i programmet. En bra självstudiekurs för [bygglistor och navigering](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation) finns på Apple utvecklingswebbplats. Koden för det här programmet härleds löst från den.

`WKNDAdventuresApp.swift` är den uppgift som anges i ansökan. Den innehåller `AdventureListView` och `.onAppear` -händelsen används för att hämta äventyrsdata.

`AdventureListView.swift` - skapar en `NavigationView` och en lista över äventyr ifyllda av `AdventureRowView`. Navigering till en `AdventureDetailView` är konfigurerad här.

`AdventureRowView` - visar Adventure-företagets primära bild och Adventure Title i rad.

`AdventureDetailView` - visar en fullständig beskrivning av det enskilda äventyret, inklusive titel, beskrivning, pris, aktivitetstyp och primär bild.

När Apollo CLI körs och genereras om `API.swift` gör att förhandsgranskningen avbryts. Om du vill använda funktionen Automatisk förhandsvisning måste du uppdatera **Apollo CLI** Bygg fas och kontrollera att skriptet körs **Endast för installationsbyggen**.

![Kontrollera endast om det finns installationsversioner](assets/ios-swiftui-app/update-build-phases.png)

### Fjärrbilder

[SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) och [SDWEbImage](https://github.com/SDWebImage/SDWebImage) används för att läsa in fjärrbilder från AEM som fyller i den primära Adventure-bilden i vyerna Rad och Detalj.

The [AsyncImage](https://developer.apple.com/documentation/swiftui/asyncimage) är en inbyggd SwiftUI-vy som också kan användas. `AsyncImage` stöds bara för iOS 15.0+.

## Ytterligare resurser

* [Komma igång med AEM Headless - kursen GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/multi-step/overview.html)
* [SwiftUI Lists and Navigation Tutorial](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)
* [Apollo iOS Client Tutorial](https://www.apollographql.com/docs/ios/tutorial/tutorial-introduction/)

