---
title: Hantera AEM för AEM GraphQL
description: Lär dig hur du konfigurerar AEM i AEM Headless-appen.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10831
thumbnail: KT-10831.jpg
exl-id: a932147c-2245-4488-ba1a-99c58045ee2b
duration: 496
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1614'
ht-degree: 0%

---

# Hantera AEM

Distribuering av ett AEM Headless-program kräver uppmärksamhet i hur AEM URL:er skapas för att säkerställa att rätt AEM värd/domän används. Den primära URL/request-typen som ska vara medveten om är:

+ HTTP-begäranden till __[AEM GraphQL API:er](#aem-graphql-api-requests)__
+ __[Bild-URL:er](#aem-image-urls)__ till bildresurser som refereras i innehållsfragment och levereras av AEM

Vanligtvis interagerar en AEM Headless-app med en enda AEM för både GraphQL API och bildbegäranden. AEM ändras baserat på den AEM Headless-appdistributionen:

| AEM driftsättningstyp utan headless | AEM | AEM |
|-------------------------------|:---------------------:|:----------------:|
| Produktion | Produktion | Publish |
| Redigeringsförhandsgranskning | Produktion | Förhandsgranska |
| Utveckling | Utveckling | Publish |

För att hantera permutationer av distributionstyp skapas varje programdistribution med en konfiguration som anger vilken AEM som ska anslutas. Värden/domän för den konfigurerade AEM används sedan för att skapa URL:er för AEM GraphQL och Image URL:er. För att avgöra hur du hanterar byggberoende konfigurationer på rätt sätt, se AEM Headless-appens ramverk (till exempel React, iOS, Android™ och så vidare), eftersom arbetssättet varierar beroende på ramverket.

| Klienttyp | [Enkelsidig app (SPA)](../spa.md) | [Webbkomponent/JS](../web-component.md) | [Mobil](../mobile.md) | [Server-till-server](../server-to-server.md) |
|------------------------------------------:|:---------------------:|:----------------:|:---------:|:----------------:|
| AEM värdkonfiguration | ✔ | ✔ | ✔ | ✔ |

Nedan följer exempel på möjliga strategier för att skapa URL:er för [AEM GraphQL API](#aem-graphql-api-requests) och [image-begäranden](#aem-image-requests) för flera populära headless-ramverk och plattformar.

## AEM GraphQL API-begäranden

HTTP-GET-begäranden från den headless-appen till AEM GraphQL API:er måste konfigureras för att interagera med rätt AEM, vilket beskrivs i [tabellen ovan](#managing-aem-hosts).

När du använder [AEM Headless SDK:er](../../how-to/aem-headless-sdk.md) (tillgängligt för webbläsarbaserade JavaScript, serverbaserade JavaScript och Java™) kan en AEM initiera det AEM Headless-klientobjektet med AEM Service att ansluta till.

När du utvecklar en anpassad AEM Headless-klient måste du se till att AEM är parameteriseringsbar baserat på build-parametrar.

### Exempel

Nedan följer exempel på hur AEM GraphQL API-begäranden kan göra det AEM värdvärdet konfigurerbart för olika headless-appramverk.

+++ Reaktionsexempel

Det här exemplet, som är löst baserat på appen [AEM Headless React](../../example-apps/react-app.md), visar hur AEM GraphQL API-begäranden kan konfigureras för att ansluta till olika AEM tjänster baserat på miljövariabler.

Reaktionsappar bör använda den [AEM Headless Client för JavaScript](../../how-to/aem-headless-sdk.md) för att interagera med AEM GraphQL API:er. Den AEM Headless-klienten som tillhandahålls av den AEM Headless-klienten för JavaScript måste initieras med den AEM Service-värd som den ansluter till.

#### Reagera på miljöfil

Reaktionen använder [anpassade miljöfiler](https://create-react-app.dev/docs/adding-custom-environment-variables/), eller `.env` filer, som lagras i projektets rot för att definiera build-specifika värden. Filen `.env.development` innehåller till exempel värden som används under utvecklingen, medan `.env.production` innehåller värden som används för produktionsbyggen.

+ `.env.development`

```
# Environment variable used to specify the AEM service the React app will connect to when running under this profile
REACT_APP_AEM_HOST=https://publish-p123-e456.adobeaemcloud.com
...
```

`.env` filer för annan användning [kan anges](https://create-react-app.dev/docs/adding-custom-environment-variables/#what-other-env-files-can-be-used) genom att `.env` efterkorrigeras och en semantisk beskrivning, till exempel `.env.stage` eller `.env.production`. Olika `.env`-filer kan användas när du kör eller skapar React-appen genom att ställa in `REACT_APP_ENV` innan du kör ett `npm`-kommando.

En React-apps `package.json` kan till exempel innehålla följande `scripts`-konfiguration:

+ `package.json`

```
...
"scripts": {
  "build:development": "REACT_APP_ENV=development npm run build",
  "build:stage": "REACT_APP_ENV=stage npm run build",
  "build:production": "REACT_APP_ENV=production npm run build"
},
...
```

#### AEM utan huvud

[AEM Headless Client för JavaScript](../../how-to/aem-headless-sdk.md) innehåller en AEM Headless-klient som gör HTTP-begäranden till AEM GraphQL API:er. Den AEM Headless-klienten måste initieras med den AEM värd som den interagerar med, med hjälp av värdet från den aktiva `.env`-filen.

+ `src/api/headlessClient.js`

```
const { AEMHeadless } = require('@adobe/aem-headless-client-js');
...
// Get the environment variables for configuring the headless client, 
// specifically the `REACT_APP_AEM_HOST` which contains the AEM service host.
const {
    REACT_APP_AEM_HOST,         // https://publish-p123-e456.adobeaemcloud.com
    REACT_APP_GRAPHQL_ENDPOINT,
} = process.env;
...

// Initialize the AEM Headless client with the AEM Service host, which dictates the AEM service provides the GraphQL data.
export const aemHeadlessClient = new AEMHeadless({
    serviceURL: REACT_APP_AEM_HOST,        
    endpoint: REACT_APP_GRAPHQL_ENDPOINT
});
```

#### Reagera useEffect(..) krok

Anropar den AEM Headless-klienten, som initieras med AEM, för att återge vyn för React-komponenten.

+ `src/api/persistedQueries.js`

```javascript
import { aemHeadlessClient , mapErrors} from "./headlessClient";
...
// The exported useEffect hook
export const getAdventureByPath = async function(adventurePath) {
    const queryVariables = {'adventurePath': adventurePath};
    return executePersistedQuery('wknd-shared/adventures-by-path', queryVariables);
}
...
// Private function that invokes the aemHeadlessClient
const executePersistedQuery = async function(persistedQueryPath, queryVariables) {
    let data;
    let errors;

    try {
        // Run the persisted query using using the aemHeadlessClient that's initialized with the AEM host
        const response = await aemHeadlessClient.runPersistedQuery(persistedQueryPath, queryVariables);
        // The GraphQL data is stored on the response's data field
        data = response.data;
        errors = response.errors ? mapErrors(response.errors) : undefined;
    } catch (e) {
        console.error(e.toJSON());
        errors = e;
    }

    return {data, errors}; 
}
```

#### Reaktionskomponent

Den anpassade useEffect-kroken, `useAdventureByPath`, importeras och används för att hämta data med den AEM Headless-klienten och återge innehållet till slutanvändaren.

+ src/components/AdventureDetail.js

```javascript
import { useAdventureByPath } from './api/persistedQueries';
...
// Query AEM GraphQL APIs via the useEffect hook that invokes the AEM Headless client initialized with the AEM host
let { data, error } = useAdventureByPath('/content/dam/wknd-shared/en/adventures/bali-surf-camp/adobestock-175749320.jpg')

...
```

+++

+++ iOS™-exempel

Det här exemplet, som baseras på [exemplet AEM Headless iOS™-appen](../../example-apps/ios-swiftui-app.md), visar hur AEM GraphQL API-begäranden kan konfigureras för att ansluta till olika AEM värdar baserat på [build-specifika konfigurationsvariabler](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project?changes=l_3).

iOS™-appar kräver en anpassad AEM Headless-klient för att kunna interagera med AEM GraphQL API:er. Den AEM Headless-klienten måste skrivas så att AEM kan konfigureras.

#### Bygg konfiguration

XCode-konfigurationsfilen innehåller standardkonfigurationsinformationen.

+ `Config.xcconfig`

```swift
// The http/https protocol scheme used to access the AEM_HOST
AEM_SCHEME = https

// Target hostname for AEM service, do not include the scheme: http:// or https://
AEM_HOST = publish-p123-e789.adobeaemcloud.com
...
```

#### Initiera den anpassade AEM headless-klienten

I [exemplet AEM Headless iOS-appen ](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/ios-app) används en anpassad AEM headless-klient som initierats med config-värdena för `AEM_SCHEME` och `AEM_HOST`.

```swift
...
let aemScheme: String = try Configuration.value(for: "AEM_SCHEME")  // https
let aemHost: String = try Configuration.value(for: "AEM_HOST")      // publish-p123-e456.adobeaemcloud.com

let aemHeadlessClient = Aem(scheme: aemScheme, host: aemHost);
```

Den anpassade AEM Headless-klienten (`api/Aem.swift`) innehåller en metod `makeRequest(..)` som prefix AEM GraphQL API:er med den konfigurerade AEM `scheme` och `host`.

+ `api/Aem.swift`

```swift
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
    
    return request;
}
```

[Det går att skapa nya byggkonfigurationsfiler](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project?changes=l_3) för att ansluta till olika AEM. De build-specifika värdena för `AEM_SCHEME` och `AEM_HOST` används baserat på den valda versionen i XCode, vilket gör att den anpassade AEM Headless-klienten ansluter till rätt AEM.

+++

+++ Android™-exempel

I det här exemplet, som baseras på [exemplet AEM Headless Android™-appen](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/android-app), visas hur AEM GraphQL API-begäranden kan konfigureras för att ansluta till olika AEM-tjänster baserat på build-specifika (eller arom) konfigurationsvariabler.

Android™-appar (när de skrivs i Java™) bör använda [AEM Headless Client för Java™](https://github.com/adobe/aem-headless-client-java) för att interagera med AEM GraphQL API:er. Den AEM Headless-klienten som tillhandahålls av den AEM Headless-klienten för Java™ måste initieras med den AEM Service-värd som den ansluter till.

#### Bygg konfigurationsfil

Android™-appar definierar&quot;productFlavors&quot; som används för att skapa artefakter för olika användningsområden.
I det här exemplet visas hur två Android™-produktsmak kan definieras, vilket ger olika värden för AEM (`AEM_HOST`) för utveckling (`dev`) och produktion (`prod`).

En ny `flavorDimension` med namnet `env` skapas i appens `build.gradle`-fil.

I dimensionen `env` definieras två `productFlavors`: `dev` och `prod`. Varje `productFlavor` använder `buildConfigField` för att ange build-specifika variabler som definierar den AEM som ska anslutas.

+ `app/build.gradle`

```gradle
android {
    ...
    flavorDimensions 'env'
    productFlavors {
        dev {
            dimension 'env'
            applicationIdSuffix '.dev'
            buildConfigField "String", "AEM_HOST", '"http://10.0.2.2:4503"'
            ...
        }
        prod {
            dimension 'env'
            buildConfigField "String", "AEM_HOST", '"https://publish-p123-e789.adobeaemcloud.com"'
            ...
        }
    }
    ...
}
```

#### Android™ loader

Initiera `AEMHeadlessClient`-byggaren som tillhandahålls av den AEM Headless Client för Java™ med värdet `AEM_HOST` från fältet `buildConfigField`.

+ `app/src/main/java/com/adobe/wknd/androidapp/loader/AdventuresLoader.java`

```java
public class AdventuresLoader extends AsyncTaskLoader<AdventureList> {
    ...

    @Override
    public AdventureList loadInBackground() {
        ...
        // Initialize the AEM Headless client using the AEM Host exposed via BuildConfig.AEM_HOST
        AEMHeadlessClientBuilder builder = AEMHeadlessClient.builder().endpoint(BuildConfig.AEM_HOST);
        AEMHeadlessClient client = builder.build();
        // With the AEM headless client initialized, make GraphQL persisted query calls to AEM
        ...    
    }
    ...
}
```

När du skapar Android™-appen för olika användningsområden anger du varianten `env` och motsvarande AEM värdvärde används.

+++

## AEM bildens URL:er

Avbildningsbegäranden från den headless-appen till AEM måste konfigureras för att interagera med rätt AEM, enligt beskrivningen i tabellen [ovan](#managing-aem-hosts).

Adobe rekommenderar att du använder [optimerade bilder](../../how-to/images.md) som är tillgängliga via fältet `_dynamicUrl` i AEM GraphQL API:er. Fältet `_dynamicUrl` returnerar en värdlös URL som kan föregås av AEM som används för att fråga AEM GraphQL API:er. Fältet `_dynamicUrl` i GraphQL-svaret ser ut så här:

```json
{
    ...
    "_dynamicUrl": "/adobe/dynamicmedia/deliver/dm-aid--dd42d814-88ec-4c4d-b5ef-e3dc4bc0cb42/example.jpg?preferwebp=true",
    ...
}
```

### Exempel

Nedan följer exempel på hur bild-URL:er kan prefix för AEM värdvärde som kan konfigureras för olika ramverk för headless-appar. Exemplen utgår från användningen av GraphQL-frågor som returnerar bildreferenser i fältet `_dynamicUrl`.

Till exempel:

#### GraphQL beständig fråga

Den här GraphQL-frågan returnerar bildreferensens `_dynamicUrl`. Som framgår i [GraphQL-svaret](#examples-react-graphql-response) som exkluderar en värd.

```graphql
query ($path: String!) {
  adventureByPath(_path: $path, _assetTransform: { format: JPG, preferWebp: true }) {
    item {
      title,
      primaryImage {
        ... on ImageRef {
          _dynamicUrl
        }
      }
    }
  }
}
```

#### GraphQL svar

Det här GraphQL-svaret returnerar bildreferensens `_dynamicUrl`, vilket utesluter en värd.

```json
{
  "data": {
    "adventureByPath": {
      "item": {
        "adventurePrimaryImage": {
          "_dynamicUrl": "/adobe/dynamicmedia/deliver/dm-aid--de43411-88ec-4c4d-b5ef-e3dc4bc0cb42/adobestock-175749320.jpg?preferwebp=true",
        }
      }
    }
  }
}
```

+++ Reaktionsexempel

Det här exemplet, som baseras på [exemplet AEM programmet Headless React](../../example-apps/react-app.md), visar hur bild-URL:er kan konfigureras för att ansluta till rätt AEM Services baserat på miljövariabler.

I det här exemplet visas hur du prefix i bildreferensfältet `_dynamicUrl` med en konfigurerbar `REACT_APP_AEM_HOST`-miljövariabel.

#### Reagera på miljöfil

Reaktionen använder [anpassade miljöfiler](https://create-react-app.dev/docs/adding-custom-environment-variables/), eller `.env` filer, som lagras i projektets rot för att definiera build-specifika värden. Filen `.env.development` innehåller till exempel värden som används under utvecklingen, medan `.env.production` innehåller värden som används för produktionsbyggen.

+ `.env.development`

```
# Environment variable used to specify the AEM service the React app will connect to when running under this profile
REACT_APP_AEM_HOST=https://publish-p123-e456.adobeaemcloud.com
...
```

`.env` filer för annan användning [kan anges](https://create-react-app.dev/docs/adding-custom-environment-variables/#what-other-env-files-can-be-used) genom att `.env` efterkorrigeras och en semantisk beskrivning, till exempel `.env.stage` eller `.env.production`. Olika `.env`-filer kan användas när du kör eller skapar React-appen genom att ställa in `REACT_APP_ENV` innan du kör ett `npm`-kommando.

En React-apps `package.json` kan till exempel innehålla följande `scripts`-konfiguration:

+ `package.json`

```
...
"scripts": {
  "build:development": "REACT_APP_ENV=development npm run build",
  "build:stage": "REACT_APP_ENV=stage npm run build",
  "build:production": "REACT_APP_ENV=production npm run build"
},
...
```

#### Reaktionskomponent

Komponenten React importerar miljövariabeln `REACT_APP_AEM_HOST` och prefixerar värdet för bilden `_dynamicUrl` för att ge en fullt matchningsbar bild-URL.

Samma `REACT_APP_AEM_HOST`-miljövariabel används för att initiera den AEM Headless-klienten som används av den anpassade useEffect-kroken som används för att hämta GraphQL-data från AEM. `useAdventureByPath(..)` Om du använder samma variabel för att konstruera GraphQL API-begäran som bild-URL:en måste du se till att React-appen interagerar med samma AEM för båda användningsfallen.

+ src/components/AdventureDetail.js

```javascript
...
// Import the AEM origin from the app's environment configuration
const AEM_HOST = env.process.REACT_APP_AEM_HOST; // https://publish-p123-e456.adobeaemcloud.com

let { data, error } = useAdventureByPath('/content/dam/wknd-shared/en/adventures/bali-surf-camp/bali-surf-camp')

return (
    // Prefix the image src URL with the AEM host
    <img src={AEM_HOST + data.adventureByPath.item.primaryImage._dynamicUrl }>
    {/* Resulting in: <img src="https://publish-p123-e456.adobeaemcloud.com/adobe/dynamicmedia/deliver/dm-aid--de43411-88ec-4c4d-b5ef-e3dc4bc0cb42/adobestock-175749320.jpg"/>  */}
)
```

+++

+++ iOS™-exempel

Det här exemplet, som baseras på [exemplet AEM Headless iOS™-appen](../../example-apps/ios-swiftui-app.md), visar hur URL:er för AEM kan konfigureras för att ansluta till olika AEM baserade på [build-specifika konfigurationsvariabler](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project?changes=l_3).

#### Bygg konfiguration

XCode-konfigurationsfilen innehåller standardkonfigurationsinformationen.

+ `Config.xcconfig`

```swift
// The http/https protocol scheme used to access the AEM_HOST
AEM_SCHEME = https

// Target hostname for AEM service, do not include the scheme: http:// or https://
AEM_HOST = publish-p123-e789.adobeaemcloud.com
...
```

#### URL-generator för bild

I `Aem.swift`, den anpassade AEM headless-klientimplementeringen, tar en anpassad funktion `imageUrl(..)` bildsökvägen som anges i fältet `_dynamicUrl` i GraphQL-svaret och lägger till den som AEM värd. Den här funktionen anropas sedan i iOS-vyerna när en bild återges.

+ `WKNDAdventures/AEM/Aem.swift`

```swift
class Aem: ObservableObject {
    let scheme: String
    let host: String
    ...
    init(scheme: String, host: String) {
        self.scheme = scheme
        self.host = host
    }
    ...
    /// Prefixes AEM image dynamicUrl with the AEM scheme/host
    func imageUrl(dynamicUrl: String) -> URL {
        return URL(string: "\(self.scheme)://\(self.host)\(dynamicUrl)")!
    }
    ...
}
```

#### iOS view

IOS-vyn och prefixerar bildvärdet `_dynamicUrl` för att ge en fullt matchningsbar bild-URL.

+ `WKNDAdventures/Views/AdventureListItemView.swift`

```swift
import SDWebImageSwiftUI
...
struct AdventureListItemView: View {
    @EnvironmentObject private var aem: Aem

    var adventure: Adventure
    
    var body: some View {
        HStack {
            // Path the image dynamicUrl to `aem.imageUrl(..)` to prepend the AEM service host     
            AdventureRowImage(imageUrl: aem.imageUrl(dynamicUrl: adventure.image()))
            Text(adventure.title)
            Spacer()
        }
    }
}
...
```

[Det går att skapa nya byggkonfigurationsfiler](https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project?changes=l_3) för att ansluta till olika AEM. De build-specifika värdena för `AEM_SCHEME` och `AEM_HOST` används baserat på den valda versionen i XCode, vilket gör att den anpassade AEM Headless-klienten interagerar med rätt AEM.

+++

+++ Android™-exempel

I det här exemplet, som baseras på [exemplet AEM Headless Android™-appen](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/android-app), visas hur URL:er för AEM kan konfigureras för att ansluta till olika AEM tjänster baserat på build-specifika (eller arom) konfigurationsvariabler.

#### Bygg konfigurationsfil

Android™-appar definierar&quot;productFlavors&quot; som används för att skapa artefakter för olika användningsområden.
I det här exemplet visas hur två Android™-produktsmak kan definieras, vilket ger olika värden för AEM (`AEM_HOST`) för utveckling (`dev`) och produktion (`prod`).

En ny `flavorDimension` med namnet `env` skapas i appens `build.gradle`-fil.

I dimensionen `env` definieras två `productFlavors`: `dev` och `prod`. Varje `productFlavor` använder `buildConfigField` för att ange build-specifika variabler som definierar den AEM som ska anslutas.

+ `app/build.gradle`

```gradle
android {
    ...
    flavorDimensions 'env'
    productFlavors {
        dev {
            dimension 'env'
            applicationIdSuffix '.dev'
            buildConfigField "String", "AEM_HOST", '"http://10.0.2.2:4503"'
            ...
        }
        prod {
            dimension 'env'
            buildConfigField "String", "AEM_HOST", '"https://publish-p123-e789.adobeaemcloud.com"'
            ...
        }
    }
    ...
}
```

#### Läsa in AEM

Android™ använder en `ImageGetter` för att hämta och lokalt cachelagra bilddata från AEM. I `prepareDrawableFor(..)` används AEM tjänstvärd, som definieras i den aktiva build-konfigurationen, som prefix till bildsökvägen för att skapa en matchningsbar URL till AEM.

+ `app/src/main/java/com/adobe/wknd/androidapp/loader/RemoteImagesCache.java`

```java
...
public class RemoteImagesCache implements Html.ImageGetter {
    ...
    private final Map<String, Drawable> drawablesByPath = new HashMap<>();
    ...
    public void prepareDrawableFor(String path) {
        ...

        // Prefix the image path with the build config AEM_HOST variable
        String urlStr = BuildConfig.AEM_HOST + path;

        URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        // Get the image data from AEM 
        Drawable drawable = Drawable.createFromStream(is, new File(path).getName());
        ...
        // Save the image data into the cache using the path as the key
        drawablesByPath.put(path, drawable);
        ...    
    }

    @Override
    public Drawable getDrawable(String dynamicUrl) {
        // Get the image data from the cache using the dynamicUrl as the key
        return drawablesByPath.get(dynamicUrl);
    }
}
```

#### Android™-vy

I vyn Android™ hämtas bilddata via `RemoteImagesCache` med hjälp av värdet `_dynamicUrl` från GraphQL-svaret.

+ `app/src/main/java/com/adobe/wknd/androidapp/AdventureDetailFragment.java`

```java
...
public class AdventureDetailFragment extends Fragment implements LoaderManager.LoaderCallbacks<Adventure> {
    ...
    private ImageView adventureDetailImage;
    ...

    private void updateContent() {
        ...
        adventureDetailImage.setImageDrawable(RemoteImagesCache.getInstance().getDrawable(adventure.getPrimaryImageDynamicUrl()));
        ...
    }
...
}
```

När du skapar Android™-appen för olika användningsområden anger du varianten `env` och motsvarande AEM värdvärde används.

+++
