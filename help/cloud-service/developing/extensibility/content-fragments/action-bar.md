---
title: AEM tillägg till åtgärdsfältet i konsolen för innehållsfragment
description: Lär dig hur du skapar ett AEM tillägg för åtgärdsfältet i Content Fragment-konsolen.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
kt: 11603
last-substantial-update: 2022-12-01T00:00:00Z
exl-id: 97d26a1f-f9a7-4e57-a5ef-8bb2f3611088
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '333'
ht-degree: 0%

---

# Åtgärdsfältets tillägg

![Åtgärdsfältets tillägg](./assets/action-bar/action-bar.png){align="center"}

Tillägg som innehåller ett åtgärdsfält, lägger till en knapp i åtgärden för AEM Content Fragment Console som visas när __1 eller fler__ Innehållsfragment markeras. Eftersom tilläggsknappar i åtgärdsfältet endast visas när minst ett innehållsfragment är markerat, fungerar de vanligtvis på de valda innehållsfragmenten. Exempel:

+ Anropa en affärsprocess eller ett arbetsflöde för de valda innehållsfragmenten.
+ Uppdatera eller ändra data för markerade innehållsfragment.

## Tilläggsregistrering

`ExtensionRegistration.js` är startpunkten för AEM och definierar

1. Tilläggstypen. om det är en knapp i åtgärdsfältet.
1. Tilläggsknappens definition i `getButton()` funktion.
1. Knappens klickningshanterare i `onClick()` funktion.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  const init = async () => {
    const guestConnection = await register({
      id: extensionId,
      methods: {
        // Configure your Action Bar button here
        actionBar: {
          getButton() {
            return {
              'id': 'example.my-action-bar-button',     // Unique ID for the button
              'label': 'My action bar button',          // Button label 
              'icon': 'Edit'                            // Button icon; get name from: https://spectrum.adobe.com/page/icons/ (Remove spaces, keep uppercase)
            }
          },
          // Click handler for the Action Bar extension button
          onClick(selections) {
            // Action Bar buttons require the selection of at least 1 Content Fragment, 
            // so we can assume the extension will do something with these selections

            // Collect the selected content fragment paths from the selections parameter
            const selectionIds = selections.map(selection => selection.id);
            
            // Do some work with the selected content fragments
            doWork(selectionIds);          
        }
      }
    })
  }
  init().catch(console.error)
```

## Modal

![Modal](./assets/modal/modal.png)

AEM Content Fragment Console-tillägg kan kräva:

+ Ytterligare indata från användaren för att utföra önskad åtgärd.
+ Möjligheten att ge användaren detaljerad information om åtgärdens resultat.

För att uppfylla dessa krav tillåter tillägget AEM Content Fragment Console en anpassad modal som återges som ett React-program.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  ...
  onClick(selections) {
    // Collect the selected content fragment paths 
    const contentFragmentPaths = selections.map(selection => selection.id);

    // Create a URL that maps to the React route to be rendered in the modal 
    const modalURL = "/index.html#" + generatePath(
      "/content-fragment/:selection/my-extension",
      {
        // Set the :selection React route parameter to an encoded, delimited list of paths of the selected content fragments
        selection: encodeURIComponent(contentFragmentPaths.join('|'))
      }
    );

    // Open the modal and display the React route created above
    guestConnection.host.modal.showUrl({
      title: "My modal title",
      url: modalURL
    })     
  } ...     
} ...
```

<div class="column is-8-desktop is-full-mobile is-half-tablet" style="
    border: solid 1px #ccc;
    border-radius: 10px;
    margin: 4rem auto;
">
  <div class="is-flex is-padded-small is-padded-big-mobile">
    <div>
      <p class="has-text-weight-bold is-size-36 is-size-27-touch is-margin-bottom-big has-text-blackest">Hoppa till att skapa en modal</p>
      <p class="has-text-blackest">Lär dig hur du skapar en modal som visas när du klickar på tilläggsknappen för åtgärdsfältet.</p>
      <div class="has-align-start is-margin-top-big">
        <a href="./modal.md" target="_blank" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
          <span class="spectrum-Button-label has-no-wrap has-text-weight-bold" title="Lär dig skapa en modal">Lär dig skapa en modal</span>
        </a>
      </div>
    </div>
  </div>
</div>

## Ingen modal

Det händer AEM att tillägg för åtgärdsfältet i Content Fragment-konsolen inte kräver ytterligare interaktion med användaren, till exempel:

+ Anropa en back-end-process som inte kräver användarindata, t.ex. import eller export.

I dessa fall kräver inte tillägget AEM Content Fragment-konsolen ett [modal](#modal)och utför arbetet direkt i åtgärdsfältets knappar `onClick` hanterare.

Med konsoltillägget AEM innehållsfragment kan en förloppsindikator täcka över konsolen AEM innehållsfragment medan arbetet utförs, vilket blockerar användaren från att utföra ytterligare åtgärder. Det är valfritt att använda förloppsindikatorn, men det är användbart om du vill förmedla förloppet för synkront arbete till användaren.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  guestConnection: { ...
    methods: { ...
      actionBar: { ...
        onClick(selections) {
          // Collect the selected content fragment paths 
          const contentFragmentPaths = selections.map(selection => selection.id);

          // Optionally, show the progress indicator overlay on the AEM Content Fragment console
          guestConnection.host.progressCircle.start();
          // Perform work on the selected Content Fragments
          doWork(contentFragmentPaths);
          // Hide the progress indicator overlay on the AEM Content Fragment console when the work is done
          guestConnection.host.progressCircle.stop();
        }
      }
    }
  }
}
```
