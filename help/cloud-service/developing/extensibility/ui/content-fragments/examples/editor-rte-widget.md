---
title: Lägga till widgetar i RTF-redigeraren
description: Lär dig hur du lägger till widgetar i textredigeraren i AEM innehållsfragmentredigeraren
feature: Developer Tools, Content Fragments
version: Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-13465
thumbnail: KT-13465.jpg
doc-type: article
last-substantial-update: 2023-06-12T00:00:00Z
exl-id: 167a4b11-1202-4c7a-b022-f3f996348a4e
duration: 475
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '553'
ht-degree: 0%

---

# Lägga till widgetar i RTF-redigeraren

Lär dig hur du lägger till widgetar i RTF-redigeraren i AEM Content Fragment Editor.

>[!VIDEO](https://video.tv.adobe.com/v/3420822?quality=12&learn=on)

Om du vill lägga till det dynamiska innehållet i RTF-redigeraren väljer du **widgetar** kan användas. Widgetarna hjälper dig att integrera det enkla eller komplexa användargränssnittet i RTE och användargränssnittet kan skapas med valfritt JS-ramverk. De kan ses som dialogrutor som öppnas genom att man trycker `{` specialtangenten i textredigeraren.

I vanliga fall används widgetarna för att infoga det dynamiska innehållet som har ett externt systemberoende eller som kan ändras baserat på det aktuella sammanhanget.

The **widgetar** läggs till i **RTE** i Content Fragment Editor med `rte` tilläggspunkt. Använda `rte` tilläggspunkter `getWidgets()` metod en eller flera widgetar läggs till. De aktiveras genom att du trycker på `{` specialtangenten för att öppna snabbmenyalternativet och markera sedan önskad widget för att läsa in det anpassade användargränssnittet i dialogrutan.

I det här exemplet visas hur du lägger till en widget som kallas _Rabattkodlista_ för att hitta, välja och lägga till WKND-annonsspecifik rabattkod i ett RTE-innehåll. Dessa rabattkoder kan hanteras i ett externt system som Orderhanteringssystem (OMS), Product Information Management (PIM), hemmabruk eller en Adobe AppBuilder-åtgärd.

I det här exemplet används [Adobe React Spectrum](https://react-spectrum.adobe.com/react-spectrum/index.html) för att utveckla widgeten eller dialoggränssnittet och hårdkodat WKND-äventynamn, rabattkodsdata.

## Tilläggspunkt

Det här exemplet utökar till tilläggspunkten `rte` om du vill lägga till en widget i textredigeraren i Content Fragment Editor.

| AEM UI Extended | Tilläggspunkt |
| ------------------------ | --------------------- | 
| [Innehållsfragmentsredigerare](https://developer.adobe.com/uix/docs/services/aem-cf-editor/) | [Widgetar för textredigeraren](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-widgets/) |

## Exempel på tillägg

I följande exempel skapas en _Rabattkodlista_ widget. Tryck på `{` specialtangenten i textredigeraren öppnas snabbmenyn, och sedan väljer du _Rabattkodlista_ på snabbmenyn öppnas dialogrutans användargränssnitt.

WKND-innehållsförfattarna kan hitta, välja och lägga till aktuell Adventure-specifik rabattkod, om sådan finns.

### Tillägg - registrering

`ExtensionRegistration.js`, som mappas till flödet index.html, är startpunkten för tillägget AEM och definierar:

+ Widgetdefinitionen i `getWidgets()` function with `id, label and url` attribut.
+ The `url` attributvärde, en relativ URL-sökväg (`/index.html#/discountCodes`) för att läsa in dialogrutans användargränssnitt.

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

          // RTE Widgets
          getWidgets: () => [
            {
              id: "discountcode-list-widget",       // Provide a unique ID for the widget
              label: "Discount Code List",          // Provide a label for the widget
              url: "/index.html#/discountCodes",     // Provide the "relative" URL to the widget content. It will be resolved as `/index.html#/discountCodes`
            },
          ],
      }
    });
  };
  
  init().catch(console.error);

  return <Text>IFrame for integration with Host (AEM)...</Text>;
}
```

### Lägg till `discountCodes` rutt in `App.js`{#add-widgets-route}

I huvudkomponenten React `App.js`, lägg till `discountCodes` för att återge användargränssnittet för ovanstående relativa URL-sökväg.

`src/aem-cf-editor-1/web-src/src/components/App.js`

```javascript
...

<Routes>
  <Route index element={<ExtensionRegistration />} />
  <Route
    exact path="index.html"
    element={<ExtensionRegistration />}
  />

  {/* Content Fragment RTE routes that support the Discount Codes Widget functionality*/}
  <Route path="/discountCodes" element={<DiscountCodes />} />
</Routes>
...
```

### Skapa `DiscountCodes` Reaktionskomponent{#create-widget-react-component}

Widgeten eller dialogrutans gränssnitt skapas med [Adobe React Spectrum](https://react-spectrum.adobe.com/react-spectrum/index.html) ramverk. The `DiscountCodes` är som nedan, här är viktiga markeringar:

+ Gränssnittet återges med React Spectrum-komponenter, som [ComboBox](https://react-spectrum.adobe.com/react-spectrum/ComboBox.html), [ButtonGroup](https://react-spectrum.adobe.com/react-spectrum/ButtonGroup.html), [Knapp](https://react-spectrum.adobe.com/react-spectrum/Button.html)
+ The `adventureDiscountCodes` -matrisen har hårdkodad mappning av annonsnamn och rabattkod. I verkligheten kan dessa data hämtas från Adobe AppBuilder-åtgärd eller externa system som PIM, OMS eller hemmabruk eller molnproviderbaserad API-gateway.
+ The `guestConnection` initieras med `useEffect` [Reaktionskrok](https://react.dev/reference/react/useEffect) och hanteras som komponentläge. Den används för att kommunicera med AEM.
+ The `handleDiscountCodeChange` hämtar rabattkoden för det valda äventyrsnamnet och uppdaterar lägesvariabeln.
+ The `addDiscountCode` funktion använda `guestConnection` -objektet innehåller RTE-instruktioner som ska köras. I detta fall `insertContent` instruktion och kodfragment för HTML av faktisk rabattkod som ska infogas i textredigeraren.

`src/aem-cf-editor-1/web-src/src/components/DiscountCodes.js`

```javascript
import {
  Button,
  ButtonGroup,
  ComboBox,
  Content,
  Divider,
  Flex, Form,
  Item,
  Provider,
  Text,
  defaultTheme
} from '@adobe/react-spectrum';
import { attach } from '@adobe/uix-guest';
import React, { useEffect, useState } from 'react';
import { extensionId } from './Constants';

const DiscountCodes = () => {

  // The Adventure Discount Code list
  // In this example its hard coded, however you can call an Adobe AppBuilder Action or even make an AJAX call to load it from 3rd party system
  const adventureDiscountCodes = [
    { id: 1, adventureName: 'BALI SURF CAMP', discountCode: 'BALI2023' },
    { id: 2, adventureName: 'BEERVANA IN PORTLAND', discountCode: 'PORTFEST' },
    { id: 3, adventureName: 'NAPA WINE TASTING', discountCode: 'WINEINSPRING' },
    { id: 4, adventureName: 'RIVERSIDE CAMPING', discountCode: 'SUMMERSCAPE' },
    { id: 5, adventureName: 'TAHOE SKIING', discountCode: 'EPICPASS' },
  ];

  // Set up state used by the React component
  const [guestConnection, setGuestConnection] = useState();

  // State hooks to manage the component state
  const [discountCode, setDiscountCode] = useState(null);

  // Asynchronously attach the extension to AEM, we must wait or the guestConnection to be set before doing anything in the modal
  useEffect(() => {
    (async () => {
      const myGuestConnection = await attach({ id: extensionId });

      setGuestConnection(myGuestConnection);
    })();
  }, []);

  // Handle the `discountCodeList` Dropdown change
  const handleDiscountCodeChange = (key) => {

    if (key) {
      //console.log(`DiscountCode Key: ${key}`);
      //console.log(`DiscountCode Value: ${adventureDiscountCodes[key-1].discountCode}`);

      //Get discount code value using selected key/index
      let discountCodeValue = adventureDiscountCodes[key - 1].discountCode;

      //update the `discountCode` state
      setDiscountCode(discountCodeValue);
    }
  };

  // Add the selected Adventure's Discount Code into the RTE
  const addDiscountCode = () => {

    if (discountCode) {
      // Use `guestConnection.host.rte.applyInstructions` method and provide RTE instruction to execute.
      // The instructions are passed as an array of object, that has `type` and `value` keys
      guestConnection.host.rte.applyInstructions([{ type: "insertContent", value: `<strong>Discount Code: ${discountCode}</strong>` }]);
    }

  };

  // Adobe React Spectrum (HTML code) that renders the Discount Code dropdown list, see https://react-spectrum.adobe.com/react-spectrum/index.html
  return (
    <Provider theme={defaultTheme}>
      <Content width="100%">
        <Flex width="100%">

          <Form width="50%">

            <Text>Selected Discount Code: <strong>{discountCode}</strong></Text>

            <p />

            <Divider size="M" />


            <ComboBox
              name="discountCodeList"
              label="Type or Select an Adventure name"
              defaultItems={adventureDiscountCodes}
              onSelectionChange={handleDiscountCodeChange}>
              {item => <Item>{item.adventureName}</Item>}
            </ComboBox>

            <p />

            <ButtonGroup align="right">
              <Button variant="accent" onPress={addDiscountCode} autoFocus>Add</Button>
              <Button variant="secondary" onPress={() => setDiscountCode(null)}>Clear</Button>
            </ButtonGroup>

          </Form>
        </Flex>
      </Content>
    </Provider>
  );
}

export default DiscountCodes;
```
