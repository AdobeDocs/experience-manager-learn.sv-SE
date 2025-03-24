---
title: Lägg till anpassad knapp i verktygsfältet RTF (Rich Text Editor)
description: Lär dig hur du lägger till en anpassad knapp i verktygsfältet för textredigeraren i AEM Content Fragment Editor
feature: Developer Tools, Content Fragments
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-13464
thumbnail: KT-13464.jpg
doc-type: article
last-substantial-update: 2023-06-12T00:00:00Z
exl-id: 6fd93d3b-6d56-43c5-86e6-2e2685deecc9
duration: 345
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '406'
ht-degree: 0%

---

# Lägg till anpassad knapp i verktygsfältet RTF (Rich Text Editor)

Lär dig hur du lägger till en anpassad knapp i verktygsfältet för textredigering i AEM Content Fragment Editor.

>[!VIDEO](https://video.tv.adobe.com/v/3420768?quality=12&learn=on)

Du kan lägga till anpassade knappar i verktygsfältet **RTE** i Content Fragment Editor med hjälp av tilläggspunkten `rte`. I det här exemplet visas hur du lägger till en anpassad knapp med namnet _Lägg till tips_ i verktygsfältet för textredigering och ändrar innehållet i textredigeraren.

Med metoden `getCustomButtons()` för tilläggspunkten `rte` kan en eller flera anpassade knappar läggas till i verktygsfältet **RTE**. Det går också att lägga till eller ta bort standardknappar för textredigering som _Kopiera, Klistra in, Fet och Kursiv_ med metoderna `getCoreButtons()` respektive `removeButtons)`.

I det här exemplet visas hur du infogar en markerad anteckning eller ett markerat tips med en anpassad _Lägg till tips_-verktygsfältsknapp. Det markerade antecknings- eller tipsinnehållet har en särskild formatering som används via HTML-element och de associerade CSS-klasserna. Platshållarinnehållet och HTML-koden infogas med callback-metoden `onClick()` för `getCustomButtons()`.

## Tilläggspunkt

Det här exemplet utökas till tilläggspunkten `rte` för att lägga till en anpassad knapp i verktygsfältet för textredigering i redigeraren för innehållsfragment.

| AEM UI Extended | Tilläggspunkt |
| ------------------------ | --------------------- | 
| [Innehållsfragmentsredigeraren](https://developer.adobe.com/uix/docs/services/aem-cf-editor/) | [Verktygsfältet RTF-redigerare](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-toolbar/) |

## Exempel på tillägg

I följande exempel skapas en anpassad _Lägg till tips_-knapp i textredigeringsverktygsfältet. Klicka-åtgärden för att infoga platshållartexten vid den aktuella inmatningspositionen i textredigeraren.

I koden visas hur du lägger till den anpassade knappen med en ikon och registrerar klickhanterarfunktionen.

### Tillägg - registrering

`ExtensionRegistration.js`, mappad till metoden index.html, är startpunkten för AEM-tillägget och definierar:

+ RTE-verktygsfältsknappens definition i funktionen `getCustomButtons()` med `id, tooltip and icon`-attribut.
+ Klickhanteraren för knappen i funktionen `onClick()`.
+ Klickhanterarfunktionen tar emot objektet `state` som ett argument för att hämta RTE-innehållet i HTML- eller textformat. I det här exemplet används det dock inte.
+ click-hanterarfunktionen returnerar en instruktionsarray. Den här arrayen har ett objekt med attributen `type` och `value`. För att infoga innehållet, attributen `value`, HTML-kodfragment, använder attributet `type` `insertContent`. Om det finns ett användningsfall för att ersätta innehållet ska du använda instruktionstypen `replaceContent`.

Värdet `insertContent` är en HTML-sträng, `<div class=\"cmp-contentfragment__element-tip\"><div>TIP</div><div>Add your tip text here...</div></div>`. CSS-klasserna `cmp-contentfragment__element-tip` som används för att visa värdet definieras inte i widgeten, utan implementeras i webbupplevelsen när det här fältet för innehållsfragment visas.


`src/aem-cf-editor-1/web-src/src/components/ExtensionRegistration.js`

```javascript
import React from "react";
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
          getCustomButtons: () => [
            {
              id: "wknd-cf-tip", // Provide a unique ID for the custom button
              tooltip: "Add Tip", // Provide a label for the custom button
              icon: "Note", // Provide an icon for the button (see https://spectrum.adobe.com/page/icons/ for a list of available icons)
              onClick: (state) => {
                // Provide a click handler function that returns the instructions array with type and value. This example inserts the HTML snippet for TIP content.
                return [
                  {
                    type: "insertContent",
                    value:
                      '<div class="cmp-contentfragment__element-tip"><div>TIP</div><div>Add your tip text here...</div></div>',
                  },
                ];
              },
            },
          ],
        },
      },
    });
  };

  init().catch(console.error);

  return <Text>IFrame for integration with Host (AEM)...</Text>;
}

export default ExtensionRegistration;
```
