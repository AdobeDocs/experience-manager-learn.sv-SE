---
title: AEM Content Fragment console header menu extensions
description: Lär dig hur du skapar ett AEM Content Fragment-konsolens rubrikmenytillägg.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
kt: 11603
last-substantial-update: 2022-12-01T00:00:00Z
exl-id: 92d6e98e-24d0-4229-9d30-850f6b72ab43
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '366'
ht-degree: 0%

---

# Tillägg för rubrikmeny

![Tillägg för rubrikmeny](./assets/header-menu/header-menu.png){align="center"}

Tillägg som innehåller en rubrikmeny lägger till en knapp i sidhuvudet i AEM Content Fragment Console som visas när __no__ Innehållsfragment markeras. Eftersom knappar för rubrikmenytillägg endast visas när inga innehållsfragment är markerade, fungerar de vanligtvis inte på befintliga innehållsfragment. Tillägg för rubrikmenyer brukar i stället vara:

+ Skapa nya innehållsfragment med hjälp av anpassad logik, som att skapa en uppsättning innehållsfragment, länkade via innehållsreferenser.
+ Använda en programmatiskt vald uppsättning innehållsfragment, till exempel export av alla innehållsfragment som skapats den senaste veckan.

## Tilläggsregistrering

`ExtensionRegistration.js` är startpunkten för AEM och definierar

1. Tilläggstypen. om det är en rubrikmenyknapp.
1. Tilläggsknappens definition i `getButton()` funktion.
1. Knappens klickningshanterare i `onClick()` funktion.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  const init = async () => {
    const guestConnection = await register({
      id: extensionId, // Must be unique
      methods: {
        // Configure your Header Menu button here
        headerMenu: {
          getButton() {
            return {
              'id': 'example.my-header-menu-button',    // Unique ID for the button
              'label': 'My header menu button',         // Button label 
              'icon': 'Bookmark'                        // Button icon; get name from: https://spectrum.adobe.com/page/icons/ (Remove spaces, keep uppercase)
            }
          },

          // Click handler for the Header Menu extension button
          onClick() {
            // Header Menu buttons are not associated with selected Content Fragment, and thus are not provided a selection parameter.        
            // Do work like importing data from a well known location, or exporting a welll known set of data
            doWork();            
          },
        }
      }
    }
  }
  init().catch(console.error);
}
```

## Modal

![Modal](./assets/modal/modal.png)

AEM Content Fragment Console header menu extensions may require:

+ Ytterligare indata från användaren för att utföra önskad åtgärd.
+ Möjligheten att ge användaren detaljerad information om åtgärdens resultat.

För att uppfylla dessa krav tillåter tillägget AEM Content Fragment Console en anpassad modal som återges som ett React-program.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  ...
  onClick() {
    // Create a URL that maps to the React route to be rendered in the modal
    const modalURL = "/index.html#/content-fragment/my-extension";

    // Open the modal and display the React route created above
    guestConnection.host.modal.showUrl({
      title: "My modal title",
      url: modalURL
    })     
  }
  ...     
}...
```

<div class="column is-8-desktop is-full-mobile is-half-tablet" style="
    border: solid 1px #ccc;
    border-radius: 10px;
    margin: 4rem auto;
">
  <div class="is-flex is-padded-small is-padded-big-mobile">
    <div>
      <p class="has-text-weight-bold is-size-36 is-size-27-touch is-margin-bottom-big has-text-blackest">Hoppa till att skapa en modal</p>
      <p class="has-text-blackest">Lär dig hur du skapar ett modalt värde som visas när du klickar på knappen för rubrikmenytillägg.</p>
      <div class="has-align-start is-margin-top-big">
        <a href="./modal.md" target="_blank" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
          <span class="spectrum-Button-label has-no-wrap has-text-weight-bold" title="Lär dig skapa en modal">Lär dig skapa en modal</span>
        </a>
      </div>
    </div>
  </div>
</div>

## Ingen modal

Ibland AEM tillägg för sidhuvudet i Content Fragment-konsolen inte kräver ytterligare interaktion med användaren, till exempel:

+ Anropa en back-end-process som inte kräver användarindata, t.ex. import eller export.
+ Öppna en ny webbsida, t.ex. intern dokumentation om riktlinjer för innehåll.

I dessa fall kräver inte tillägget AEM Content Fragment Console något [modal](#modal)och kan utföra arbetet direkt i menyknappens `onClick` hanterare.

Tillägget AEM Content Fragment Console gör att en förloppsindikator kan täcka över AEM Content Fragment Console medan arbetet utförs, vilket blockerar användaren från att utföra fler åtgärder. Det är valfritt att använda förloppsindikatorn, men det är användbart om du vill förmedla förloppet för synkront arbete till användaren.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  guestConnection: { ...
    methods: { ...
      headerMenu: { ...
        onClick() {
          // Optionally, show the progress indicator overlay on the AEM Content Fragment console
          guestConnection.host.progressCircle.start();
          // Perform work on the selected Content Fragments
          doWork();
          // Hide the progress indicator overlay on the AEM Content Fragment console when the work is done
          guestConnection.host.progressCircle.stop();
        }
      }
    }
  }
}
```
