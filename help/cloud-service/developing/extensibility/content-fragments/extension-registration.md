---
title: Tilläggsregistrering för AEM Content Fragment Console
description: Lär dig hur du registrerar tillägg för konsolen Innehållsfragment.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
kt: 11603
last-substantial-update: 2022-12-01T00:00:00Z
source-git-commit: f19cdc7d551f20b35550e7d25bd168a2eaa43b6a
workflow-type: tm+mt
source-wordcount: '569'
ht-degree: 0%

---


# Tilläggsregistrering

AEM Content Fragment Console-tillägg är en specialiserad App Builder-app som baseras på React och använder [Reagera spektrum](https://react-spectrum.adobe.com/react-spectrum/) Gränssnittsramverk.

För att definiera var och hur AEM Content Fragment Console tillägget visas krävs två specifika konfigurationer i appen App Builder: approutning och tilläggsregistrering.

## Appvägar{#app-routes}

Tillägget `App.js` deklarerar [Reagera router](https://reactrouter.com/en/main) som innehåller ett indexflöde som registrerar tillägget i AEM Content Fragment Console.

Indexflödet anropas när AEM Content Fragment Console först läses in och målet för den här vägen definierar hur tillägget visas i konsolen.

+ `./src/aem-cf-console-admin-1/web-src/src/components/App.js`

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

## Tilläggsregistrering

`ExtensionRegistration.js` måste omedelbart läsas in via tilläggets indexflöde, och fungerar som registreringspunkt för tillägget och definierar

1. Tilläggstypen. a [rubrikmeny](./header-menu.md) eller [åtgärdsfält](./action-bar.md) -knappen.
   + [Sidhuvudsmenyn](./header-menu.md#extension-registration) tillägg anges av `headerMenu` egenskap under `methods`.
   + [Åtgärdsfält](./action-bar.md#extension-registration) tillägg anges av `actionBar` egenskap under `methods`.
1. Tilläggsknappens definition i `getButton()` funktion. Den här funktionen returnerar ett objekt med fält:
   + `id` är ett unikt ID för knappen
   + `label` är tilläggsknappens etikett i konsolen AEM innehållsfragment
   + `icon` är tilläggsknappens ikon i AEM Content Fragment-konsolen. Ikonen är en [Reagera spektrum](https://spectrum.adobe.com/page/icons/) ikonnamn, med blanksteg borttagna.
1. Knappens klickningshanterare, som definieras i en `onClick()` funktion.
   + [Sidhuvud-menyn](./header-menu.md#extension-registration) extensions skickar inte parametrar till click-hanteraren.
   + [Åtgärdsfält](./action-bar.md#extension-registration) tillägg innehåller en lista med valda sökvägar för innehållsfragment i `selections` parameter.

### Tillägg för rubrikmeny

![Tillägg för rubrikmeny](./assets/extension-registration/header-menu.png)

Tilläggsknapparna för rubrikmenyn visas när inga innehållsfragment är markerade. Eftersom tilläggen för rubrikmenyn inte påverkar valet av innehållsfragment, kommer inga innehållsfragment att anges till dem `onClick()` hanterare.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  const init = async () => {
    const guestConnection = await register({
      id: extensionId, // A unique ID for the extension
      methods: {
        // Configure your Action Bar button here
        headerMenu: {
          getButton() {
            return {
              'id': 'example.my-header-menu-extension', // Unique ID for the button
              'label': 'My header menu extension',      // Button label 
              'icon': 'Edit'                            // Button icon from https://spectrum.adobe.com/page/icons/
            }
          },

          // Click handler for the extension button
          // Header Menu extensions do not pass parameters to the click handler
          onClick() { ... }
        }
      }
    })
  }
  init().catch(console.error)
}
```

<div class="column is-8-desktop is-full-mobile is-half-tablet" style="
    border: solid 1px #ccc;
    border-radius: 10px;
    margin: 4rem auto;
">
  <div class="is-flex is-padded-small is-padded-big-mobile">
    <div>
      <p class="has-text-weight-bold is-size-36 is-size-27-touch is-margin-bottom-big has-text-blackest">Bläddra till att skapa ett sidhuvudsmenytillägg</p>
      <p class="has-text-blackest">Lär dig hur du registrerar och definierar ett tillägg för en rubrikmeny i AEM Content Fragments Console.</p>
      <div class="has-align-start is-margin-top-big">
        <a href="./header-menu.md" target="_blank" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
          <span class="spectrum-Button-label has-no-wrap has-text-weight-bold" title="Lär dig att skapa ett tillägg för en rubrikmeny">Lär dig att skapa ett tillägg för en rubrikmeny</span>
        </a>
      </div>
    </div>
  </div>
</div>

### Tillägg för åtgärdsfält

![Tillägg för åtgärdsfält](./assets/extension-registration/action-bar.png)

Tilläggsknappar i åtgärdsfältet visas när ett eller flera innehållsfragment är markerade. Banorna för det markerade innehållsfragmentet görs tillgängliga för tillägget via `selections` -parameter, i knappens `onClick(..)` hanterare.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  const init = async () => {
    const guestConnection = await register({
      id: extensionId, // A unique ID for the extension
      methods: {
        // Configure your Action Bar button here
        actionBar: {
          getButton() {
            return {
              'id': 'example.my-action-bar-extension',  // Unique ID for the button
              'label': 'My action bar extension',       // Button label 
              'icon': 'Edit'                            // Button icon from https://spectrum.adobe.com/page/icons/
            }
          },

          // Click handler for the extension button
          // Only Action Bar buttons populate the selections parameter
          onClick(selections) { ... }
        }
      }
    })
  }
  init().catch(console.error)
}
```

<div class="column is-8-desktop is-full-mobile is-half-tablet" style="
    border: solid 1px #ccc;
    border-radius: 10px;
    margin: 4rem auto;
">
  <div class="is-flex is-padded-small is-padded-big-mobile">
    <div>
      <p class="has-text-weight-bold is-size-36 is-size-27-touch is-margin-bottom-big has-text-blackest">Hoppa till att skapa ett tillägg för åtgärdsfältet</p>
      <p class="has-text-blackest">Lär dig hur du registrerar och definierar ett tillägg för ett åtgärdsfält i AEM Content Fragments Console.</p>
      <div class="has-align-start is-margin-top-big">
        <a href="./action-bar.md" target="_blank" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
          <span class="spectrum-Button-label has-no-wrap has-text-weight-bold" title="Lär dig hur du skapar ett tillägg för ett åtgärdsfält">Lär dig hur du skapar ett tillägg för ett åtgärdsfält</span>
        </a>
      </div>
    </div>
  </div>
</div>

## Inkludera tillägg villkorligt

AEM tillägg för Content Fragment Console kan utföra anpassad logik för att begränsa när tillägget visas i AEM Content Fragment Console. Den här kontrollen utförs före `register` ring i `ExtensionRegistration` och returnerar omedelbart om tillägget inte ska visas.

Den här kontrollen har begränsad kontext:

+ Den AEM värd som tillägget läses in på.
+ Den aktuella användarens AEM åtkomsttoken.

De vanligaste kontrollerna för att läsa in ett tillägg är:

+ Använda AEM (`new URLSearchParams(window.location.search).get('repo')`) för att avgöra om tillägget ska läsas in.
   + Visa bara tillägget i AEM miljöer som ingår i ett visst program (som visas i exemplet nedan).
   + Visa bara tillägget i en viss AEM (d.v.s. AEM).
+ Använda en [Adobe I/O Runtime action](./runtime-action.md) för att göra ett HTTP-anrop till AEM för att avgöra om den aktuella användaren ska se tillägget.

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
