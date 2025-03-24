---
title: AEM UI-tillägg modal
description: Lär dig hur du skapar ett modalt AEM UI-tillägg.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
jira: KT-11603
last-substantial-update: 2023-06-02T00:00:00Z
exl-id: e7376eaf-f7d7-48fe-9387-a0e4089806c2
duration: 127
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '294'
ht-degree: 0%

---

# Förlängningsmodalt

![AEM UI-tillägg modal](./assets/modal/modal.png){align="center"}

AEM UI-tillägg är ett sätt att koppla anpassade användargränssnitt till AEM UI-tillägg.

Modaler är React-program som baseras på [React Spectrum](https://react-spectrum.adobe.com/react-spectrum/) och kan skapa valfritt anpassat användargränssnitt som krävs av tillägget, inklusive, men inte begränsat till:

+ Bekräftelsedialogrutor
+ [Indataformulär](https://react-spectrum.adobe.com/react-spectrum/#forms)
+ [Förloppsindikatorer](https://react-spectrum.adobe.com/react-spectrum/#status)
+ [Resultatsammanfattning](https://react-spectrum.adobe.com/react-spectrum/#collections)
+ Felmeddelanden
+ ... eller till och med ett fullfjädrat React-program med flera vyer!

## Modala vägar

Den modala upplevelsen definieras av tillägget App Builder React som definieras i mappen `web-src`. Precis som med React-appar är den fullständiga upplevelsen utformad med [React route](https://reactrouter.com/en/main/components/routes) som återger [React components](https://reactjs.org/docs/components-and-props.html).

Minst en väg krävs för att generera den inledande modala vyn. Den här initiala vägen anropas i funktionen `onClick(..)` för [tilläggsregistrering](#extension-registration), vilket visas nedan.


+ `./src/aem-ui-extension/web-src/src/components/App.js`

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

            For modals opened from Action Bar extensions.
            Depending on the extension point, different parameters are passed to the modal.
            This example illustrates a modal for the AEM Content Fragment Console (list view), where typically a :selection parameter is used to pass in the list of selected Content Fragments.
            Where as Header Menu extensions do not use a selection parameter.
           */}
          <Route
            exact path="aem-ui-extension/:selection/my-modal"
            element={<MyModal />}
          />                    

          {/* Define any other routes the modal may need */}
          <Route
            exact path="aem-ui-extension/my-modal"
            element={<MyOtherModalView />}
          />                    

        </Routes>
      </ErrorBoundary>
    </Router>
  )
  ...
}
```

## Tillägg - registrering

Om du vill öppna ett modalt anrop till `guestConnection.host.modal.showUrl(..)` görs det från tilläggets `onClick(..)`-funktion. `showUrl(..)` skickas som ett JavaScript-objekt med nyckelvärden:

+ `title` anger namnet på titeln för spärrformen som visas för användaren
+ `url` är den URL som anropar den [Reaktionsväg](#modal-routes) som är ansvarig för modets inledande vy.

Det är av största vikt att `url` som skickas till `guestConnection.host.modal.showUrl(..)` tolkas så att den dirigeras i tillägget, annars visas inget i modala medier.

+ `./src/aem-ui-extension/web-src/src/components/ExtensionRegistration.js`

```javascript
function ExtensionRegistration() {
  ...
  onClick() {
    // Create a URL that maps to the React route to be rendered in the modal
    const modalURL = "/index.html#/aem-ui-extension/my-modal";

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

Varje väg i tillägget, [, som inte är `index` route](./extension-registration.md#app-routes), mappas till en React-komponent som kan återges i tilläggets modal.

En modal kan bestå av ett valfritt antal React-rutter, från en enkel enkelvägstrafik till en komplex flervägstrafik.

I följande exempel visas en enkel modal enkelvägsvy, men den här modala vyn kan innehålla React-länkar som anropar andra vägar eller beteenden.

+ `./src/aem-ui-extension/web-src/src/components/MyModal.js`

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

![Modal stängningsknapp för AEM UI-tillägg](./assets/modal/close.png){align="center"}

Modalerna måste ha sin egen nära kontroll. Detta görs genom att anropa `guestConnection.host.modal.close()`.

```javascript
<ButtonGroup align="end">
    <Button variant="primary" onPress={() => guestConnection.host.modal.close()}>Close</Button>
</ButtonGroup>
```
