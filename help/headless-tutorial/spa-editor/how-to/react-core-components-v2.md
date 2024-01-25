---
title: Så här använder du AEM React Editable Components v2
description: Lär dig hur du använder AEM React Editable Components v2 för att driva en React-app.
version: Cloud Service
topic: Headless
feature: SPA Editor
role: Developer
level: Intermediate
jira: KT-10900
thumbnail: kt-10900.jpeg
doc-type: Tutorial
exl-id: e055b356-dd26-4366-8608-5a0ccf5b4c49
duration: 244
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '525'
ht-degree: 0%

---

# Så här använder du AEM React Editable Components v2

{{edge-delivery-services}}

AEM tillhandahåller [AEM React Editable Components v2](https://www.npmjs.com/package/@adobe/aem-react-editable-components), en Node.js-baserad SDK som gör det möjligt att skapa React-komponenter som stöder kontextredigering av komponenter med AEM redigeraren SPA.

+ [npm-modul](https://www.npmjs.com/package/@adobe/aem-react-editable-components)
+ [Github](https://github.com/adobe/aem-react-editable-components)
+ [Adobe dokumentation](https://experienceleague.adobe.com/docs/experience-manager-65/developing/spas/spa-reference-materials.html)


Mer information och kodexempel för AEM React Editable Components v2 finns i den tekniska dokumentationen:

+ [Integrering med AEM](https://github.com/adobe/aem-react-editable-components/tree/master/src/core)
+ [Redigerbar komponentdokumentation](https://github.com/adobe/aem-react-editable-components/tree/master/src/components)
+ [Hjälpdokumentation](https://github.com/adobe/aem-react-editable-components/tree/master/src/api)

## AEM sidor

AEM React Editable Components fungerar med både SPA Editor och Remote SPA React. Innehåll som fyller i de redigerbara React-komponenterna måste visas via AEM sidor som utökar [SPA](https://experienceleague.adobe.com/docs/experience-manager-65/developing/headless/spas/spa-page-component.html). AEM komponenter som mappar till redigerbara React-komponenter måste implementera AEM [Komponentexporterarramverket](https://experienceleague.adobe.com/docs/experience-manager-65/developing/components/json-exporter-components.html) - som [WCM-komponenter AEM kärna](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html).


## Beroenden

Kontrollera att React-appen körs på Node.js 14+.

Den minsta uppsättningen beroenden för React-appen som ska använda AEM React Editable Components v2 är: `@adobe/aem-react-editable-components`, `@adobe/aem-spa-component-mapping`och  `@adobe/aem-spa-page-model-manager`.


+ `package.json`

```json
{
  ...
  "dependencies": {
    "@adobe/aem-react-editable-components": "^2.0.1",
    "@adobe/aem-spa-component-mapping": "^1.1.1",
    "@adobe/aem-spa-page-model-manager": "^1.4.4",
    ...
  },
  ...
}
```

>[!WARNING]
>
> [Bas för WCM-komponenter för AEM-React Core](https://github.com/adobe/aem-react-core-wcm-components-base) och [AEM React Core WCM Components SPA](https://github.com/adobe/aem-react-core-wcm-components-spa) är inte kompatibla med AEM React Editable Components v2.

## SPA

När du använder AEM React Editable Components med en SPA Editor-baserad React-app AEM `ModelManager` SDK, som SDK:

1. Hämtar innehåll från AEM
1. Fyller i komponenterna React Edible med AEM innehåll

Lägg in React-appen med en initierad ModelManager och återge React-appen. React-appen ska innehålla en instans av `<Page>` som exporterats från `@adobe/aem-react-editable-components`. The `<Page>` -komponenten har logik för att dynamiskt skapa React-komponenter baserat på `.model.json` tillhandahålls av AEM.

+ `src/index.js`

```javascript
import { Constants, ModelManager } from '@adobe/aem-spa-page-model-manager';
import { Page } from '@adobe/aem-react-editable-components';
...
document.addEventListener('DOMContentLoaded', () => {
  ModelManager.initialize().then(pageModel => {
    const history = createBrowserHistory();
    render(
      <Router history={history}>    
        <Page
          history={history}
          cqChildren={pageModel[Constants.CHILDREN_PROP]}
          cqItems={pageModel[Constants.ITEMS_PROP]}
          cqItemsOrder={pageModel[Constants.ITEMS_ORDER_PROP]}
          cqPath={pageModel[Constants.PATH_PROP]}
          locationPathname={window.location.pathname}
        />
      </Router>,
      document.getElementById('spa-root')
    );
  });
});
```

The `<Page>` skickas som AEM sidas representation som JSON, via `pageModel` tillhandahålls av `ModelManager`. The `<Page>` skapar dynamiskt Reagera-komponenter för objekt i `pageModel` genom att matcha `resourceType` med en React-komponent som registrerar sig för resurstypen via `MapTo(..)`.

## Redigerbara komponenter

The `<Page>` skickas AEM sidans representation som JSON, via `ModelManager`. The `<Page>` skapar sedan dynamiskt React-komponenter för varje objekt i JSON genom att matcha JS-objektets `resourceType` med en React-komponent som registrerar sig själv för resurstypen via komponentens `MapTo(..)` anrop. Följande skulle till exempel användas för att instansiera en instans

+ `HTTP GET /content/.../home.model.json`

```json
...
    ":items": {
        "example_123": {
                  "id": "example-a647cec03a",
                  "message": "Hello from an authored example component!",
                  ":type": "wknd-examples/components/example"
                }
    } 
...
```

Ovanstående JSON från AEM kan användas för att dynamiskt instansiera och fylla i en redigerbar React-komponent.

```javascript
import React from "react";
import { EditableComponent, MapTo } from "@adobe/aem-react-editable-components";

/**
 * The component's EditConfig is used by AEM's SPA Editor to determine if and how authoring placeholders should be displayed.
 */
export const ExampleEditConfig = {
  emptyLabel: "Example component",

  isEmpty: function (props) => {
    return props?.message?.trim().length < 1;
  }
};

/** 
 * Define a React component. The `props` passed into the component are derived form the
 * fields returned by AEM's JSON response for this component instance.
 */
export const Example = (props) => {
  // Return null if the component is considered empty. 
  // This is used to ensure an un-authored component does not break the experience outside the AEM SPA Editor
  if (ExampleEditConfig.isEmpty(props)) { return null; }

  // Render the component JSX. 
  // The authored component content is available on the `props` object.
  return (<p className="example__message">{props.message}</p>);
};

/**
 * Wrap the React component with <EditableComponent> to make it available for authoring in the AEM SPA Editor.
 * Provide the EditConfig the AEM SPA Editor uses to manage creation of authoring placeholders.
 * Provide the props that are automatically passed in via the parent component
 */
const EditableExample = (props) => {
  return (
    <EditableComponent config={ExampleEditConfig} {...props}>
      {/* Pass the ...props through to the Example component, since this is what does the actual component rendering */}
      <Example {...props} />
    </EditableComponent>
  );
};

/**
 * Map the editable component to a resourceType and export it as default.
 * If this component is embedded in another editable component (as show below), make sure to 
 * import the "non-editable" component instance for use in the embedding component.
 */
export default MapTo("wknd-examples/components/example")(EditableExample);
```

## Bädda in komponenter

Redigerbara komponenter kan återanvändas och bäddas in i varandra. Det finns två viktiga saker att tänka på när du bäddar in en redigerbar komponent i en annan:

1. JSON-innehållet från AEM för inbäddningskomponenten måste innehålla innehållet för att de inbäddade komponenterna ska uppfyllas. Det gör du genom att skapa en dialogruta för den AEM komponenten som samlar in nödvändiga data.
1. Instansen&quot;icke-redigerbar&quot; för React-komponenten måste bäddas in, i stället för den&quot;redigerbara&quot; instansen som omsluts med `<EditableComponent>`. Orsaken är om den inbäddade komponenten har `<EditableComponent>` wrapper, försöker SPA Editor att klä den inre komponenten med redigeringskanalen (blå hover box), i stället för den yttre inbäddningskomponenten.

+ `HTTP GET /content/.../home.model.json`

```json
...
    ":items": {
        "embedding_456": {
                  "id": "example-a647cec03a",
                  "message": "Hello from an authored example component!",
                  "title": "A title for an embedding component!",
                  ":type": "wknd-examples/components/embedding"
                }
    } 
...
```

Ovanstående JSON från AEM kan användas för att dynamiskt instansiera och fylla i en redigerbar React-komponent som bäddar in en annan React-komponent.


```javascript
import React from "react";
import { EditableComponent, MapTo } from "@adobe/aem-react-editable-components";
// Import the "non-editable" (not wrapped with <EditableComponent>) instance of the component 
import { Example } from "./Example.js";

export const EmbeddingEditConfig = {
  emptyLabel: "Embedding component",

  isEmpty: function (props) => {
    return props?.title?.trim().length < 1;
  }
};

export const Embedding = (props) => {
  if (EmbeddingEditConfig.isEmpty(props)) { return null; }

  return (<div className="embedding">
            {/* Embed the other components. Pass through props they need. */}
            <Example message={props.message}/>
            <p className="embedding__title">{props.title}</p>
        </div>);
};

const EditableEmbedding = (props) => {
  return (
    <EditableComponent config={EmbeddingEditConfig} {...props}>
      {/* Pass the ...props through to the Embedding component */}
      <Embedding {...props} />
    </EditableComponent>
  );
};

// Export as default the mapped EditableEmbedding
export default MapTo("wknd-examples/components/embedding")(EditableEmbedding);
```
