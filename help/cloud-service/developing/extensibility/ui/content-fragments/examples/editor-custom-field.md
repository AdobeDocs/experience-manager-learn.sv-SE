---
title: Konsol för innehållsfragment - anpassade fält
description: Lär dig hur du skapar ett anpassat fält i AEM Content Fragment Editor.
feature: Developer Tools, Content Fragments
version: Experience Manager as a Cloud Service
role: Developer
level: Intermediate
doc-type: Tutorial
duration: 315
last-substantial-update: 2024-02-27T00:00:00Z
jira: KT-14903
thumbnail: KT-14903.jpeg
exl-id: 563bab0e-21e3-487c-9bf3-de15c3a81aba
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '473'
ht-degree: 0%

---

# Anpassade fält

Lär dig skapa anpassade fält i AEM Content Fragment Editor.

>[!VIDEO](https://video.tv.adobe.com/v/3427585?learn=on)

AEM UI-tillägg bör utvecklas med ramverket [Adobe React Spectrum](https://react-spectrum.adobe.com/react-spectrum/index.html) eftersom det bibehåller ett konsekvent utseende och en enhetlig känsla med resten av AEM och har ett omfattande bibliotek med fördefinierade funktioner, vilket minskar utvecklingstiden.

## Tilläggspunkt

Det här exemplet ersätter ett befintligt fält i Content Fragment Editor med en anpassad implementering.

| AEM UI Extended | Tilläggspunkt |
| ------------------------ | --------------------- |
| [Innehållsfragmentsredigeraren](https://developer.adobe.com/uix/docs/services/aem-cf-editor/) | [Egen återgivning av formulärelement](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/custom-fields/) |

## Exempel på tillägg

I det här exemplet visas en begränsning av fältvärden i redigeraren för innehållsfragment till en fördefinierad uppsättning genom att ersätta standardfältet med en anpassad listruta med fördefinierade SKU:er. Författare kan välja i den här specifika SKU-listan. SKU:er kommer vanligtvis från ett PIM-system (Product Information Management), men det här exemplet förenklar genom att en statisk lista över SKU:er finns.

Källkoden för det här exemplet är [tillgänglig för hämtning](./assets/editor-custom-field/content-fragment-editor-custom-field-src.zip).

### Modelldefinition för innehållsfragment

Det här exemplet binder till ett fält för innehållsfragment vars namn är `sku` (via ett [reguljärt uttryck som matchar](#extension-registration) av `^sku$`) och ersätter det med ett anpassat fält. I exemplet används WKND Adventure Content Fragment-modellen som har uppdaterats och definitionen är följande:

![Modelldefinition för innehållsfragment](./assets/editor-custom-field/content-fragment-editor.png)

Trots att det anpassade SKU-fältet visas som en listruta konfigureras dess underliggande modell som ett textfält. Implementeringen av anpassade fält behöver bara justeras mot rätt egenskapsnamn och egenskapstyp, vilket gör det lättare att ersätta standardfältet med den anpassade listruteversionen.


### Appvägar

I huvudkomponenten `App.js` tar du med `/sku-field`-vägen för att återge React-komponenten `SkuField`.

`src/aem-cf-editor-1/web-src/src/components/App.js`

```javascript
import React from "react";
import ErrorBoundary from "react-error-boundary";
import { HashRouter as Router, Routes, Route } from "react-router-dom";
import ExtensionRegistration from "./ExtensionRegistration";
import SkuField from "./SkuField"; // Custom component implemented below

function App() {
  return (
    <Router>
      <ErrorBoundary onError={onError} FallbackComponent={fallbackComponent}>
        <Routes>
          <Route index element={<ExtensionRegistration />} />
          <Route
            exact path="index.html"
            element={<ExtensionRegistration />}
          />
          {/* This is the React route that maps to the custom field */}
          <Route
            exact path="/sku-field"
            element={<SkuField />}/>
        </Routes>
      </ErrorBoundary>
    </Router>
  )
  ...
}
...
```

Den här anpassade vägen för `/sku-field` mappar till komponenten `SkuField` används nedan i [tilläggsregistreringen](#extension-registration).

### Tillägg - registrering

`ExtensionRegistration.js`, mappad till metoden index.html, är startpunkten för AEM-tillägget och definierar:

+ Widgetdefinitionen i funktionen `getDefinitions()` med attributen `fieldNameExp` och `url`. Den fullständiga listan över tillgängliga attribut finns i [API-referens för anpassade formulärelementåtergivning](https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/custom-fields/#api-reference).
+ Attributvärdet `url`, en relativ URL-sökväg (`/index.html#/skuField`) som läser in fältets användargränssnitt.

`src/aem-cf-editor-1/web-src/src/components/ExtensionRegistration.js`

```javascript
import { Text } from "@adobe/react-spectrum";
import { register } from "@adobe/uix-guest";
import { extensionId } from "./Constants";

function ExtensionRegistration() {
  const init = async () => {
    const guestConnection = await register({
      id: extensionId,
      methods: {
        field: {
          getDefinitions() {
            return [
              // Multiple fields can be registered here.
              {
                fieldNameExp: '^sku$',  // This is a regular expression that matches the field name in the Content Fragment Model to replace with React component specified in the `url` key.
                url: '/#/sku-field',    // The URL, which is mapped vai the Route in App.js, to the React component that will be used to render the field.
              },
              // Other bindings besides fieldNameExp, other bindings can be used as well as defined here:
              // https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/custom-fields/#api-reference
            ];
          },
        },
      }
    });
  };
  init().catch(console.error);

  return <Text>IFrame for integration with Host (AEM)...</Text>;
}

export default ExtensionRegistration;
```

### Anpassat fält

Komponenten `SkuField` React uppdaterar innehållsfragmentredigeraren med ett anpassat användargränssnitt, och använder Adobe React Spectrum för sin väljarform. Högdagrarna är följande:

+ Använder `useEffect` för initiering och anslutning till AEM Content Fragment Editor, med ett inläsningstillstånd som visas tills installationen är klar.
+ Rendering inuti en iFrame, justerar den dynamiskt iFrame-höjden via funktionen `onOpenChange` för att passa listrutan för Adobe React Spectrum Picker.
+ Kommunicerar tillbaka fältval till värden med `connection.host.field.onChange(value)` i funktionen `onSelectionChange` och ser till att det valda värdet valideras och sparas automatiskt enligt riktlinjerna i Content Fragment Model.

Anpassade fält återges i en iFrame som injiceras i Content Fragment Editor. Kommunikationen mellan den anpassade fältkoden och innehållsfragmentredigeraren sker enbart via objektet `connection`, som etableras av funktionen `attach` från paketet `@adobe/uix-guest`.

`src/aem-cf-editor-1/web-src/src/components/SkuField.js`

```javascript
import React, { useEffect, useState } from "react";
import { extensionId } from "./Constants";
import { attach } from "@adobe/uix-guest";
import { Provider, View, lightTheme } from "@adobe/react-spectrum";
import { Picker, Item } from "@adobe/react-spectrum";

const SkuField = (props) => {
  const [connection, setConnection] = useState(null);
  const [validationState, setValidationState] = useState(null);
  const [value, setValue] = useState(null);
  const [model, setModel] = useState(null);
  const [items, setItems] = useState(null);

  /**
   * Mock function that gets a list of Adventure SKUs to display.
   * The data could come anywhere, AEM's HTTP APIs, a PIM, or other system.
   * @returns a list of items for the picker
   */
  async function getItems() {
    // Data to drive input field validation can come from anywhere.
    // Fo example this commented code shows how it could be fetched from an HTTP API.
    // fetch(MY_API_URL).then((response) => response.json()).then((data) => { return data; }

    // In this example, for simplicity, we generate a list of 25 SKUs.
    return Array.from({ length: 25 }, (_, i) => ({ 
        name: `WKND-${String(i + 1).padStart(3, '0')}`, 
        id: `WKND-${String(i + 1).padStart(3, '0')}` 
    }));
  }

  /**
   * When the fields changes, update the value in the Content Fragment Editor
   * @param {*} value the selected value in the picker
   */
  const onSelectionChange = async (value) => {
    // This sets the value in the React state of the custom field
    setValue(value);
    // This calls the setValue method on the host (AEM's Content Fragment Editor)
    connection.host.field.onChange(value);
  };

  /**
   * Some widgets, like the Picker, have a variable height.
   * In these cases adjust the Content Fragment Editor's iframe's height so the field doesn't get cut off.     *
   * @param {*} isOpen true if the picker is open, false if it's closed
   */
  const onOpenChange = (isOpen) => {
    if (isOpen) {
      // Calculate the height of the picker box and its label, and surrounding padding.
      const pickerHeight = Number(document.body.clientHeight.toFixed(0));
      // Calculate the height of the picker options dropdown, and surrounding padding.
      // We do this  by multiplying the number of items by the height of each item (32px) and adding 12px for padding.
      const optionsHeight = items.length * 32 + 12;

      // Set the height of the iframe to the height of the picker + the height of the options, or 400px, whichever is smaller.
      // The options will scroll if they they cannot fit into 400px
      const height = Math.min(pickerHeight + optionsHeight, 400);

      // Set the height of the iframe in the Content Fragment Editor
      connection.host.field.setStyles({
        current: { height, },
        parent: { height, },
      })
    } else {
      connection.host.field.setStyles({
        current: { height: 74 },
        parent: { height: 74 },
      })
    }
  };

  useEffect(() => {
    const init = async () => {
      // Connect to the host (AEM's Content Fragment Editor)
      const conn = await attach({ id: extensionId });
      setConnection(conn);

      // get the Content Fragment Model
      setModel(await conn.host.field.getModel());

      // Share the validation state back to the client.
      // When conn.host.field.setValue(value) is called, the
      await conn.host.field.onValidationStateChange((state) => {
        // state can be `valid` or `invalid`.
        setValidationState(state);
      });
      // Get default value from the Content Fragment Editor
      // (either the default value set in the model, or a perviously set value)
      setValue(await conn.host.field.getDefaultValue());

      // Get the list of items for the picker; in this case its a list of adventure SKUs 
      // This could come from elsewhere in AEM or from an external system.
      setItems(await getItems());
    };

    init().catch(console.error);
  }, []);

  // If the component is not yet initialized, return a loading state.
  if (!connection || !model || !items) {
    // Put whatever loader you like here...
    return <Provider theme={lightTheme}>Loading custom field...</Provider>;
  }

  // Wrap the Spectrum UI component in a Provider theme, such that it is styled appropriately.
  // Render the picker, and bind to the data and custom event handlers.

  // Set as much of the model as we can, to allow maximum authoring flexibility without developer support.
  return (
    <Provider theme={lightTheme}>
      <View width="100%">
        <Picker
          label={model.fieldLabel}
          isRequired={model.required}
          placeholder={model.emptyText}
          errorMessage={model.customErrorMsg}
          selectedKey={value}
          necessityIndicator="icon"
          shouldFlip={false}
          width={"90%"}
          items={items}
          isInvalid={validationState === "invalid"}
          onSelectionChange={onSelectionChange}
          onOpenChange={onOpenChange}
        >
          {(item) => <Item key={item.value}>{item.name}</Item>}
        </Picker>
      </View>
    </Provider>
  );
};

export default SkuField;
```
