---
title: AEM Content Fragment console extension modal
description: Lär dig hur du skapar ett AEM Content Fragment Console-tillägg som är modalt.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
kt: 11603
last-substantial-update: 2022-12-01T00:00:00Z
exl-id: e7376eaf-f7d7-48fe-9387-a0e4089806c2
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '344'
ht-degree: 0%

---

# Förlängning modal

![AEM Content Fragment extension modal](./assets/modal/modal.png){align="center"}

AEM Content Fragment-tillägg är ett sätt att koppla anpassade användargränssnitt till AEM Content Fragment-tillägg, oavsett om det är det [Åtgärdsfält](./action-bar.md) eller [Sidhuvud-menyn](./header-menu.md) knappar.

Modulerna är React-program som bygger på [Reagera spektrum](https://react-spectrum.adobe.com/react-spectrum/)och kan skapa valfritt anpassat användargränssnitt som krävs av tillägget, inklusive men inte begränsat till:

+ Bekräftelsedialogrutor
+ [Inmatningsformulär](https://react-spectrum.adobe.com/react-spectrum/#forms)
+ [Förloppsindikatorer](https://react-spectrum.adobe.com/react-spectrum/#status)
+ [Sammanfattning av resultat](https://react-spectrum.adobe.com/react-spectrum/#collections)
+ Felmeddelanden
+ ... eller till och med ett fullfjädrat React-program med flera vyer!

## Modala vägar

Den modala upplevelsen definieras av appen App Builder React som definieras i `web-src` mapp. Precis som med React-appar är den fullständiga upplevelsen organiserad med [Reaktionsvägar](https://reactrouter.com/en/main/components/routes) som återges [Reagera på komponenter](https://reactjs.org/docs/components-and-props.html).

Minst en väg krävs för att generera den inledande modala vyn. Den här initiala vägen anropas i [tilläggsregistrering](#extension-registration)&#39;s `onClick(..)` enligt nedan.


+ `./src/aem-cf-console-admin-1/web-src/src/components/App.js`

```javascript
import MyModal from './MyModal';
import MyModalResults from './MyModalResults';
...
function App(props) {
  return (
    <Router>
      <ErrorBoundary onError={onError} FallbackComponent={fallbackComponent}>
        <Routes>
          ...         
          {/* 
            Define the entry route to the modal.

            For modals opened from Action Bar extensions, typically a :selection parameter is used to pass in the list of selected Content Fragments.
            Header Menu extensions do not use a selection parameter.
           */}
          <Route
            exact path="content-fragment/:selection/my-modal"
            element={<MyModal />}
          />                    

          {/* Define any other routes the modal may need */}
          <Route
            exact path="content-fragment/my-modal"
            element={<MyOtherModalView />}
          />                    

        </Routes>
      </ErrorBoundary>
    </Router>
  )
  ...
}
```

## Tilläggsregistrering

Om du vill öppna en modal anrop `guestConnection.host.modal.showUrl(..)` görs från tilläggets `onClick(..)` funktion. `showUrl(..)` skickas ett JavaScript-objekt med nyckel/värden:

+ `title` innehåller namnet på namnet på spärrkoden som visas för användaren
+ `url` är den URL som anropar [Reaktionsflöde](#modal-routes) ansvarar för modets inledande vy.

Det är av största vikt att `url` skickat till `guestConnection.host.modal.showUrl(..)` löser problemet så att det går att dirigera i tillägget, annars visas ingenting i det modala.

Granska [rubrikmeny](./header-menu.md#modal) och [åtgärdsfält](./action-bar.md#modal) dokumentation om hur du skapar modala URL:er.

+ `./src/aem-cf-console-admin-1/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  ...
  onClick() {
    // Create a URL that maps to the React route to be rendered in the modal
    const modalURL = "/index.html#/content-fragment/my-modal";

    // Open the modal and display the React route created above
    guestConnection.host.modal.showUrl({
      title: "My modal title",
      url: modalURL
    })     
  }
  ...     
}...
```

## Modal component

Utbyggnadens alla rutter [det där är inte `index` rutt](./extension-registration.md#app-routes), mappar till en React-komponent som kan återges i tilläggets modal.

En modal kan bestå av ett valfritt antal React-rutter, från en enkel enkelvägstrafik till en komplex flervägstrafik.

I följande exempel visas en enkel modal enkelvägsvy, men den här modala vyn kan innehålla React-länkar som anropar andra vägar eller beteenden.

+ `./src/aem-cf-console-admin-1/web-src/src/components/MyModal.js`

```javascript
import React, { useState, useEffect } from 'react'
import { attach } from "@adobe/uix-guest"
import {
  Flex,
  Provider,
  Content,
  defaultTheme,
  Text,
  ButtonGroup,
  Button
} from '@adobe/react-spectrum'
import Spinner from "./Spinner"
import { useParams } from "react-router-dom"
import { extensionId } from "./Constants"

export default function MyModal() {
  // Initial modal views for Action Bar extensions typically pass in the list of selected Content Fragment Paths from ExtensionRegistration.js
  // Get the paths from useParams() and split on delimiter used
  let { selection } = useParams();
  let contentFragmentPaths = selection?.split('|') || [];
  
  // Asynchronously attach the extension to AEM. 
  // Wait or the guestConnection to be set before doing anything in the modal.
  const [guestConnection, setGuestConnection] = useState()

  useEffect(() => {
    (async () => {
      const guestConnection = await attach({ id: extensionId })
      setGuestConnection(guestConnection);
    })()
  }, [])

  if (!guestConnection) {
    // If the guestConnection is not initialized, display a loading spinner
    return <Spinner />
  } else {
    // Else the modal is ready to render!
    return (
        <Provider theme={defaultTheme} colorScheme='light'>
        {/* 
            Use the React Spectrum components to render the modal UI.
            Using React Spectrum ensures a consistent, accessible, future-proof look-and-feel and speeds up development.
        */}
            <Content width="100%">
                <Flex width="100%">
                    <Text>
                        This is the contents in the modal! 
                        Anything can be created in this return statement!

                        The selected Content Fragments are: { contentFragmentPaths.join(', ') }
                    </Text>                    
                    {/*
                        Modals must provide their own Close button, by calling: guestConnection.host.modal.close()
                    */}
                    <ButtonGroup align="end">
                        <Button variant="primary" onPress={() => guestConnection.host.modal.close()}>Close</Button>
                    </ButtonGroup>
                </Flex>
            </Content>
        </Provider>
    )
  }
}
```

## Stäng spärren

![AEM spärrknapp för modal stängning av innehållsfragment](./assets/modal/close.png){align="center"}

Modalerna måste ha sin egen nära kontroll. Detta har gjorts genom att anropa `guestConnection.host.modal.close()`.

```javascript
<ButtonGroup align="end">
    <Button variant="primary" onPress={() => guestConnection.host.modal.close()}>Close</Button>
</ButtonGroup>
```
