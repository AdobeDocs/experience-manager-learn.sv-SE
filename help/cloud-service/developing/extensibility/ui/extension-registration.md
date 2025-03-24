---
title: Registrering av AEM UI-tillägg
description: Lär dig hur du registrerar ett AEM UI-tillägg.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
jira: KT-11603
last-substantial-update: 2023-06-02T00:00:00Z
exl-id: ef2290d9-ba40-429b-b10d-e82d6c1c20f6
duration: 85
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '299'
ht-degree: 0%

---

# Tillägg - registrering

AEM UI-tillägg är en specialiserad App Builder-app som baseras på React och använder gränssnittsramverket [React Spectrum](https://react-spectrum.adobe.com/react-spectrum/) .

För att definiera var och hur AEM UI-tillägget ska visas krävs två konfigurationer i tilläggets App Builder-app: approutning och tilläggsregistrering.

## Appvägar{#app-routes}

Tilläggets `App.js` deklarerar [Reaktionsroutern](https://reactrouter.com/en/main) som innehåller en indexväg som registrerar tillägget i AEM-gränssnittet.

Indexflödet anropas när AEM-användargränssnittet läses in första gången och målet för den här vägen definierar hur tillägget visas i konsolen.

+ `./src/aem-ui-extension/web-src/src/components/App.js`

```javascript
import ExtensionRegistration from "./ExtensionRegistration"
...            
function App(props) {
  return (
    <Router>
      <ErrorBoundary onError={onError} FallbackComponent={fallbackComponent}>
        <Routes>
          {/* The index route maps to the extension registration */}
          <Route index element={<ExtensionRegistration />} />
          ...                                   
        </Routes>
      </ErrorBoundary>
    </Router>
  )
  ...
}
```

## Tillägg - registrering

`ExtensionRegistration.js` måste läsas in omedelbart via tilläggets indexflöde och fungerar som registreringspunkt för tillägget.

Baserat på AEM UI-tilläggsmallen som valdes när [App Builder-programtillägget ](./app-initialization.md) initierades stöds olika tilläggspunkter.

+ [Tillägg för innehållsfragment i användargränssnittet](./content-fragments/overview.md#extension-points)

## Inkludera tillägg villkorligt

AEM UI-tillägg kan utföra anpassad logik för att begränsa de AEM-miljöer som tillägget finns i. Den här kontrollen utförs före anropet `register` i komponenten `ExtensionRegistration` och returnerar omedelbart om tillägget inte ska visas.

Den här kontrollen har begränsad kontext:

+ Den AEM-värd som tillägget läses in på.
+ Den aktuella användarens AEM-åtkomsttoken.

De vanligaste kontrollerna för att läsa in ett tillägg är:

+ Använder AEM-värden (`new URLSearchParams(window.location.search).get('repo')`) för att avgöra om tillägget ska läsas in.
   + Visa bara tillägget i AEM-miljöer som ingår i ett visst program (som visas i exemplet nedan).
   + Visa bara tillägget i en viss AEM-miljö (AEM-värd).
+ Använder en [Adobe I/O Runtime-åtgärd](./runtime-action.md) för att göra ett HTTP-anrop till AEM för att avgöra om den aktuella användaren ska se tillägget.

I exemplet nedan visas hur du begränsar tillägget till alla miljöer i programmet `p12345`.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  const PROGRAM_ID = 'p12345';

  // Get the current AEM Host (author-pXXX-eYYY.adobeaemcloud.com) the extension is loading on
  const aemHost = new URLSearchParams(window.location.search).get('repo');

  // Create a check to determine if the current AEM host matches the AEM program that uses this extension 
  const aemHostRegex = new RegExp(`^author-${PROGRAM_ID}-e[\\d]+\\.adobeaemcloud\\.com$`)

  // Disable the extension if the Cloud Manager Program Id doesn't match the regex.
  if (!aemHostRegex.test(aemHost)) {
    return; // Skip extension registration if the environment is not in program p12345.
  }

  // Else, continue initializing the extension
  const init = async () => { .. };
  
  init().catch(console.error);
}
```
