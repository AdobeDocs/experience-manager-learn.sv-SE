---
title: Lägg till märken i RTF-redigeraren
description: Lär dig hur du lägger till märken i RTF-redigeraren i AEM Content Fragment Editor
feature: Developer Tools, Content Fragments
version: Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-13466
thumbnail: KT-13466.jpg
doc-type: article
last-substantial-update: 2023-06-12T00:00:00Z
exl-id: 83acbddb-9168-4d8b-84b5-97577d8a1ead
duration: 538
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '729'
ht-degree: 0%

---

# Lägg till märken i RTF-redigeraren

Lär dig hur du lägger till märken i RTF-redigeraren i AEM Content Fragment Editor.

>[!VIDEO](https://video.tv.adobe.com/v/3420831?quality=12&learn=on)

[Rich Text Editor, märke](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-badges/)  är tillägg som gör att text i textredigeraren inte kan redigeras. Det innebär att ett märke som deklarerats som sådant endast kan tas bort helt och inte delvis redigeras. Dessa märken har också stöd för specialfärgning i textredigeraren, vilket tydligt anger för innehållsförfattarna att texten är en bricka och därför inte kan redigeras. Dessutom ger de visuella indikeringar om märkningstextens betydelse.

Det vanligaste användningsområdet för RTE-emblem är att använda dem tillsammans med [RTE-widgetar](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-widgets/). Detta gör att innehåll som injiceras i RTE-widgeten inte kan redigeras.

Märken som är kopplade till widgetarna används vanligtvis för att lägga till dynamiskt innehåll som är beroende av ett externt system, men _innehållsförfattare kan inte ändra_ det infogade dynamiska innehållet för att bevara integriteten. De kan bara tas bort som ett helt objekt.

The **emblem** läggs till i **RTE** i Content Fragment Editor med `rte` tilläggspunkt. Använda `rte` tilläggspunkter `getBadges()` metod ett eller flera emblem läggs till.

I det här exemplet visas hur du lägger till en widget som kallas _Kundtjänst för stora koncernbokningar_ för att hitta, välja ut och lägga till WKND-äventyrsspecifik kundtjänstinformation som **Representantnamn** och **Telefonnummer** inom ett RTE-innehåll. Använda märkesfunktionen i **Telefonnummer** görs **icke-redigerbar** men WKND-innehållsförfattare kan redigera det representativa namnet.

Dessutom finns **Telefonnummer** har olika format (blått) vilket är ett extra användningsfall för emblem-funktionen.

I det här exemplet används [Adobe React Spectrum](https://react-spectrum.adobe.com/react-spectrum/index.html) för att utveckla widgeten eller dialoggränssnittet och hårdkodade telefonnummer till WKND-kundtjänst. Om du vill styra den icke-redigerade och andra formateringsaspekten av innehållet använder du `#` tecken används i `prefix` och `suffix` attribut för definitionen av emblem.

## Tilläggspunkter

Det här exemplet utökar till tilläggspunkten `rte` om du vill lägga till ett märke i textredigeraren i Content Fragment Editor.

| AEM UI Extended | Tilläggspunkter |
| ------------------------ | --------------------- | 
| [Innehållsfragmentsredigerare](https://developer.adobe.com/uix/docs/services/aem-cf-editor/) | [RTF-redigeraremblem](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-badges/) och [Widgetar för textredigeraren](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-widgets/) |

## Exempel på tillägg

I följande exempel skapas en _Kundtjänst för stora koncernbokningar_ widget. Tryck på `{` RTE-widgetarnas snabbmeny öppnas. Genom att välja _Kundtjänst för stora koncernbokningar_ på snabbmenyn öppnas det anpassade modala.

När det önskade kundservicenumret har lagts till från modalen gör badgerna _Telefonnummer kan inte redigeras_ och formaterar den med blå färg.

### Tillägg - registrering

`ExtensionRegistration.js`, mappas till `index.html` rutt, är ingångspunkten för AEM tillägg och definierar:

+ Definitionen av märket definieras i `getBadges()` använda konfigurationsattributen `id`, `prefix`, `suffix`, `backgroundColor` och `textColor`.
+ I det här exemplet `#` tecken används för att definiera den här märkordens gränser, vilket innebär alla strängar i den textredigerare som omges av `#` behandlas som en instans av det här märket.

Se även nyckeldetaljerna för widgeten för textredigering:

+ Widgetdefinitionen i `getWidgets()` function with `id`, `label` och `url` attribut.
+ The `url` attributvärde, en relativ URL-sökväg (`/index.html#/largeBookingsCustomerService`) för att läsa in modal.


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
          // RTE Badges
          getBadges: () => [
            {
              id: "phoneNumber",
              prefix: "#",
              suffix: "#",
              backgroundColor: "",
              textColor: "#071DF8",
            },
          ],

          // RTE Widgets
          getWidgets: () => [
            {
              id: "largegroup-contact-list-widget",
              label: "Large Group Bookings Customer Service",
              url: "/index.html#/largeBookingsCustomerService",
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

### Lägg till `largeBookingsCustomerService` rutt in `App.js`{#add-widgets-route}

I huvudkomponenten React `App.js`, lägg till `largeBookingsCustomerService` för att återge användargränssnittet för ovanstående relativa URL-sökväg.

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
  <Route path="/largeBookingsCustomerService" element={<LargeBookingsCustomerService />} />
</Routes>
...
```

### Skapa `LargeBookingsCustomerService` Reaktionskomponent{#create-widget-react-component}

Widgeten eller dialogrutans gränssnitt skapas med [Adobe React Spectrum](https://react-spectrum.adobe.com/react-spectrum/index.html) ramverk.

Komponentkoden Reagera när du lägger till kundtjänstinformation omger telefonnummervariabeln med `#` registrerade emblem-tecken som konverteras till emblem, som `#${phoneNumber}#`så att det inte går att redigera.

Här är viktiga högdagrar för `LargeBookingsCustomerService` kod:

+ Gränssnittet återges med React Spectrum-komponenter, som [ComboBox](https://react-spectrum.adobe.com/react-spectrum/ComboBox.html), [ButtonGroup](https://react-spectrum.adobe.com/react-spectrum/ButtonGroup.html), [Knapp](https://react-spectrum.adobe.com/react-spectrum/Button.html)
+ The `largeGroupCustomerServiceList` arrayen har hårdkodad mappning av representativt namn och telefonnummer. I verkligheten kan dessa data hämtas från Adobe AppBuilder-åtgärd, externa system eller hemmabruk eller molnproviderbaserad API-gateway.
+ The `guestConnection` initieras med `useEffect` [Reaktionskrok](https://react.dev/reference/react/useEffect) och hanteras som komponentläge. Den används för att kommunicera med AEM.
+ The `handleCustomerServiceChange` funktionen hämtar representativt namn och telefonnummer och uppdaterar komponentlägesvariablerna.
+ The `addCustomerServiceDetails` funktion använda `guestConnection` -objektet innehåller RTE-instruktioner som ska köras. I detta fall `insertContent` instruktion och kodfragment för HTML.
+ Gör **icke-redigerbart telefonnummer** med hjälp av ikoner, `#` specialtecken läggs till före och efter `phoneNumber` variabel, som `...<div><p>Phone Number: #${phoneNumber}#</strong></p></div>`.

`src/aem-cf-editor-1/web-src/src/components/LargeBookingsCustomerService.js`

```javascript
import {
  Button,
  ButtonGroup,
  Text,
  Divider,
  ComboBox,
  Content, Flex, Form,
  Item,
  Provider, defaultTheme
} from '@adobe/react-spectrum';
import { attach } from '@adobe/uix-guest';
import React, { useEffect, useState } from 'react';
import { extensionId } from './Constants';


const LargeBookingsCustomerService = () => {

  // The Large Group Bookings Customer Service
  // In this example its hard coded, however you can call an Adobe AppBuilder Action or even make an AJAX call to load it from 3rd party system
  const largeGroupCustomerServiceList = [
    { id: 1, repName: 'Max', phoneNumber: '1-800-235-1000' },
    { id: 2, repName: 'John', phoneNumber: '1-700-235-2000' },
    { id: 3, repName: 'Leah', phoneNumber: '1-600-235-3000' },
    { id: 4, repName: 'Leno', phoneNumber: '1-500-235-4000' }
  ];

  // Set up state used by the React component
  const [guestConnection, setGuestConnection] = useState();

  // State hooks to manage the component state
  const [repName, setRepName] = useState(null);
  const [phoneNumber, setPhoneNumber] = useState(null);

  // Asynchronously attach the extension to AEM, we must wait or the guestConnection to be set before doing anything in the modal
  useEffect(() => {
    (async () => {
      const myGuestConnection = await attach({ id: extensionId });

      setGuestConnection(myGuestConnection);
    })();
  }, []);

  // Handle the `customerService` Dropdown change
  const handleCustomerServiceChange = (id) => {

    if (id) {
      //Get Customer Service RepName and Phone Number values using selected id

      const rep = largeGroupCustomerServiceList.filter((r) => r.id === id)[0];

      //update the `repName` state
      setRepName(rep?.repName);

      //update the `phoneNumber` state
      setPhoneNumber(rep?.phoneNumber);
    }
  };

  // Add the selected Customer Service details into the RTE
  const addCustomerServiceDetails = () => {

    if (repName && phoneNumber) {
      // Use `guestConnection.host.rte.applyInstructions` method and provide RTE instruction to execute.
      // The instructions are passed as an array of object, that has `type` and `value` keys
      guestConnection.host.rte.applyInstructions([{ type: "insertContent", value: `<div><p>Representative Name: <strong>${repName}</strong></p></div><div><p>Phone Number: #${phoneNumber}#</strong></p></div>` }]);
    }
  };


  // Adobe React Spectrum (HTML code) that renders the Customer Service dropdown list, see https://react-spectrum.adobe.com/react-spectrum/index.html
  return (
    <Provider theme={defaultTheme}>
      <Content width="100%">
        <Flex width="100%">

          <Form width="50%">
            <Text>Representative Name: <strong>{repName}</strong></Text>
            <Text>Phone Number: <strong>{phoneNumber}</strong></Text>

            <p />

            <Divider size="M" />


            <ComboBox
              name="customerService"
              label="Type or Select Phone Number"
              defaultItems={largeGroupCustomerServiceList}
              onSelectionChange={handleCustomerServiceChange}>
              {item => <Item>{item.phoneNumber}</Item>}
            </ComboBox>

            <p />

            <ButtonGroup align="right">
              <Button variant="accent" onPress={addCustomerServiceDetails}>Add</Button>
              <Button variant="secondary" onPress={() => {setPhoneNumber(null); setRepName(null);}}>Clear</Button>
            </ButtonGroup>

          </Form>
        </Flex>
      </Content>
    </Provider>
  );

};

export default LargeBookingsCustomerService;
```
