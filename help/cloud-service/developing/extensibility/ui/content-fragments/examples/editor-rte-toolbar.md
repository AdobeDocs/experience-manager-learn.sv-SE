---
title: Lägg till anpassad knapp i verktygsfältet RTF (Rich Text Editor)
description: Lär dig hur du lägger till en anpassad knapp i verktygsfältet RTF (Rich Text Editor) i AEM Content Fragment Editor
feature: Developer Tools, Content Fragments
version: Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-13464
thumbnail: KT-13464.jpg
doc-type: article
last-substantial-update: 2023-06-12T00:00:00Z
exl-id: 6fd93d3b-6d56-43c5-86e6-2e2685deecc9
duration: 354
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '406'
ht-degree: 0%

---

# Lägg till anpassad knapp i verktygsfältet RTF (Rich Text Editor)

Lär dig hur du lägger till en anpassad knapp i verktygsfältet RTE (Rich Text Editor) i AEM Content Fragment Editor.

>[!VIDEO](https://video.tv.adobe.com/v/3420768?quality=12&learn=on)

Anpassade knappar kan läggas till i **RTE-verktygsfält** i Content Fragment Editor med `rte` tilläggspunkt. I det här exemplet visas hur du lägger till en anpassad knapp med namnet _Lägg till tips_ till RTE-verktygsfältet och ändra innehållet i RTE.

Använda `rte` tilläggspunkter `getCustomButtons()` metod en eller flera anpassade knappar kan läggas till i **RTE-verktygsfält**. Det går också att lägga till eller ta bort standardknappar för RTE som _Kopiera, Klistra in, Fet och Kursiv_ använda `getCoreButtons()` och `removeButtons)` metoder.

I det här exemplet visas hur du infogar en markerad anteckning eller ett markerat tips med hjälp av anpassad _Lägg till tips_ i verktygsfältet. Det markerade antecknings- eller tipsinnehållet har en speciell formatering som används via elementen HTML och de associerade CSS-klasserna. Platshållarinnehållet och HTML-koden infogas med `onClick()` callback-metoden för `getCustomButtons()`.

## Tilläggspunkt

Det här exemplet utökar till tilläggspunkten `rte` om du vill lägga till en anpassad knapp i verktygsfältet för textredigering i redigeraren för innehållsfragment.

| AEM UI Extended | Tilläggspunkt |
| ------------------------ | --------------------- | 
| [Innehållsfragmentsredigerare](https://developer.adobe.com/uix/docs/services/aem-cf-editor/) | [Verktygsfältet för textredigeraren](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-toolbar/) |

## Exempel på tillägg

I följande exempel skapas en _Lägg till tips_ egen knapp i verktygsfältet för textredigering. Klicka-åtgärden för att infoga platshållartexten vid den aktuella inmatningspositionen i textredigeraren.

I koden visas hur du lägger till den anpassade knappen med en ikon och registrerar klickhanterarfunktionen.

### Tillägg - registrering

`ExtensionRegistration.js`, som mappas till flödet index.html, är startpunkten för tillägget AEM och definierar:

+ The RTE toolbar button&#39;s definition in `getCustomButtons()` function with `id, tooltip and icon` attribut.
+ Knappens klickningshanterare i `onClick()` funktion.
+ Klickhanterarfunktionen tar emot `state` -objekt som ett argument för att hämta RTE-filens innehåll i HTML eller textformat. I det här exemplet används det dock inte.
+ click-hanterarfunktionen returnerar en instruktionsarray. Den här arrayen har ett objekt med `type` och `value` attribut. Om du vill infoga innehållet `value` attribut HTML-kodfragment, `type` attributet använder `insertContent`. Om det finns ett användningsfall för att ersätta innehållet ska du använda skiftläget `replaceContent` instruktionstyp.

The `insertContent` värdet är en HTML-sträng, `<div class=\"cmp-contentfragment__element-tip\"><div>TIP</div><div>Add your tip text here...</div></div>`. CSS-klasserna `cmp-contentfragment__element-tip` som används för att visa värdet definieras inte i widgeten, utan implementeras i webbupplevelsen. Det här fältet Innehållsfragment visas i.


`src/aem-cf-editor-1/web-src/src/components/ExtensionRegistration.js`

```javascript
import { Text } from "@adobe/react-spectrum";
import { register } from "@adobe/uix-guest";
import { extensionId } from "./Constants";

// This function is called when the extension is registered with the host and runs in an iframe in the Content Fragment Editor browser window.
function ExtensionRegistration() {

  const init = async () => {
    const guestConnection = await register({
      id: extensionId,
      methods: {
        rte: {

          // RTE Toolbar custom button
          getCustomButtons: () => ([
            {
              id: "wknd-cf-tip",       // Provide a unique ID for the custom button
              tooltip: "Add Tip",      // Provide a label for the custom button
              icon: 'Note',            // Provide an icon for the button (see https://spectrum.adobe.com/page/icons/ for a list of available icons)
              onClick: (state) => {    // Provide a click handler function that returns the instructions array with type and value. This example inserts the HTML snippet for TIP content.
                return [{
                  type: "insertContent",
                  value: "<div class=\"cmp-contentfragment__element-tip\"><div>TIP</div><div>Add your tip text here...</div></div>"
                }];
              },
            },
          ]),
      }
    });
  };
  
  init().catch(console.error);

  return <Text>IFrame for integration with Host (AEM)...</Text>;
}
```
