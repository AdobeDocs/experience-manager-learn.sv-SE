---
title: Lägga till redigerbara fasta komponenter i en SPA
description: Lär dig hur du lägger till redigerbara fasta komponenter i en SPA.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
jira: KT-7634
thumbnail: kt-7634.jpeg
last-substantial-update: 2022-11-11T00:00:00Z
recommendations: noDisplay, noCatalog
doc-type: Tutorial
exl-id: edd18f2f-6f24-4299-a31a-54ccc4f6d86e
duration: 212
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '534'
ht-degree: 0%

---

# Redigerbara fasta komponenter

Redigerbara Reaktionskomponenter kan vara&quot;fasta&quot; eller hårdkodade i SPA. Detta gör att utvecklare kan placera SPA redigerarkompatibla komponenter i SPA och tillåta användare att skapa komponenternas innehåll i AEM SPA Editor.

![Fasta komponenter](./assets/spa-fixed-component/intro.png)

I det här kapitlet ersätter vi hemvyns titel&quot;Aktuella anteckningar&quot;, som är hårdkodad text i `Home.js` med en fast, men redigerbar Title-komponent. Fasta komponenter garanterar titelns placering, men tillåter även att titeltexten kan redigeras och ändras utanför utvecklingscykeln.

## Uppdatera WKND-appen

Lägga till en __Fast__ till hemvyn:

+ Skapa en anpassad redigerbar titelkomponent och registrera den i projektets titelresurstyp
+ Placera den redigerbara titelkomponenten i SPA hemvy

### Skapa en redigerbar React Title-komponent

Ersätt den hårdkodade texten i SPA hemvy `<h2>Current Adventures</h2>` med en anpassad redigerbar Title-komponent. Innan komponenten Title kan användas måste vi:

1. Skapa en anpassad titelreaktionskomponent
1. Dekorera den anpassade komponenten Title med metoder från `@adobe/aem-react-editable-components` för att göra det redigerbart.
1. Registrera den redigerbara titelkomponenten med `MapTo` så att den kan användas i [behållarkomponent senare](./spa-container-component.md).

Så här gör du:

1. Öppna SPA på `~/Code/aem-guides-wknd-graphql/remote-spa-tutorial/react-app` i din IDE
1. Skapa en React-komponent på `react-app/src/components/editable/core/Title.js`
1. Lägg till följande kod i `Title.js`.

   ```javascript
   import React from 'react'
   import { RoutedLink } from "./RoutedLink";
   
   const TitleLink = (props) => {
   return (
       <RoutedLink className={props.baseCssClass + (props.nested ? '-' : '__') + 'link'} 
           isRouted={props.routed} 
           to={props.linkURL}>
       {props.text}
       </RoutedLink>
   );
   };
   
   const TitleV2Contents = (props) => {
       if (!props.linkDisabled) {
           return <TitleLink {...props} />
       }
   
       return <>{props.text}</>
   };
   
   export const Title = (props) => {
       if (!props.baseCssClass) {
           props.baseCssClass = 'cmp-title'
       }
   
       const elementType = (!!props.type) ? props.type.toString() : 'h3';
       return (<div className={props.baseCssClass}>
           {
               React.createElement(elementType, {
                       className: props.baseCssClass + (props.nested ? '-' : '__') + 'text',
                   },
                   <TitleV2Contents {...props} />
               )
           }
   
           </div>)
   }
   
   export const titleIsEmpty = (props) => props.text == null || props.text.trim().length === 0
   ```

   Observera att React-komponenten ännu inte kan redigeras med AEM SPA Editor. Denna baskomponent kommer att göras redigerbar i nästa steg.

   Läs igenom kodens kommentarer för mer information om implementeringen.

1. Skapa en React-komponent på `react-app/src/components/editable/EditableTitle.js`
1. Lägg till följande kod i `EditableTitle.js`.

   ```javascript
   // Import the withMappable API provided bu the AEM SPA Editor JS SDK
   import { EditableComponent, MapTo } from '@adobe/aem-react-editable-components';
   import React from 'react'
   
   // Import the AEM the Title component implementation and it's Empty Function
   import { Title, titleIsEmpty } from "./core/Title";
   import { withConditionalPlaceHolder } from "./core/util/withConditionalPlaceholder";
   import { withStandardBaseCssClass } from "./core/util/withStandardBaseCssClass";
   
   // The sling:resourceType of the AEM component used to collected and serialize the data this React component displays
   const RESOURCE_TYPE = "wknd-app/components/title";
   
   // Create an EditConfig to allow the AEM SPA Editor to properly render the component in the Editor's context
   const EditConfig = {
       emptyLabel: "Title",        // The component placeholder in AEM SPA Editor
       isEmpty: titleIsEmpty,      // The function to determine if this component has been authored
       resourceType: RESOURCE_TYPE // The sling:resourceType this component is mapped to
   };
   
   export const WrappedTitle = (props) => {
       const Wrapped = withConditionalPlaceHolder(withStandardBaseCssClass(Title, "cmp-title"), titleIsEmpty, "TitleV2")
       return <Wrapped {...props} />
   }
   
   // EditableComponent makes the component editable by the AEM editor, either rendered statically or in a container
   const EditableTitle = (props) => <EditableComponent config={EditConfig} {...props}><WrappedTitle /></EditableComponent>
   
   // MapTo allows the AEM SPA Editor JS SDK to dynamically render components added to SPA Editor Containers
   MapTo(RESOURCE_TYPE)(EditableTitle);
   
   export default EditableTitle;
   ```

   Detta `EditableTitle` Reaktionskomponenten kapslar in `Title` Reagera på komponenter, kapsla in och dekorera dem och redigera dem AEM redigeraren SPA.

### Använda komponenten React EditableTitle

Nu när React-komponenten EditableTitle är registrerad i och tillgänglig för användning i React-appen ersätter du den hårdkodade titeltexten i hemvyn.

1. Redigera `react-app/src/components/Home.js`
1. I `Home()` längst ned, importera `EditableTitle` och ersätt den hårdkodade titeln med den nya `AEMTitle` komponent:

   ```javascript
   ...
   import EditableTitle from './editable/EditableTitle';
   ...
   function Home() {
       return (
           <div className="Home">
   
           <EditableTitle
               pagePath='/content/wknd-app/us/en/home'
               itemPath='root/title'/>
   
               <Adventures />
           </div>
       );
   }
   ```

The `Home.js` filen ska se ut så här:

![Home.js](./assets/spa-fixed-component/home-js-update.png)

## Skapa komponenten Title i AEM

1. Logga in på AEM författare
1. Navigera till __Sites > WKND App__
1. Tryck __Startsida__ och markera __Redigera__ i det övre åtgärdsfältet
1. Välj __Redigera__ i redigeringslägesväljaren längst upp till höger i sidredigeraren
1. Håll muspekaren över standardtexten under WKND-logotypen och ovanför äventyrslistan tills den blå redigeringsramen visas
1. Tryck för att visa komponentens åtgärdsfält och tryck sedan på __wrench__  för att redigera

   ![Åtgärdsfält för titelkomponent](./assets/spa-fixed-component/title-action-bar.png)

1. Skriv komponenten Title:
   + Titel: __WKND-annonser__
   + Typ/storlek: __H2__

     ![Dialogrutan Titelkomponent](./assets/spa-fixed-component/title-dialog.png)

1. Tryck __Klar__ spara
1. Förhandsgranska ändringarna i AEM SPA
1. Uppdatera WKND-appen som körs lokalt på [http://localhost:3000](http://localhost:3000) och se hur den skrivna texten ändras direkt.

   ![Rubrikkomponent i SPA](./assets/spa-fixed-component/title-final.png)

## Grattis!

Du har lagt till en fast, redigerbar komponent i WKND-appen! Nu kan du:

+ Skapade en fast, men redigerbar, komponent till SPA
+ Skapa den fasta komponenten i AEM
+ Se det innehåll som skapats i SPA

## Nästa steg

Nästa steg är att [lägga till en AEM ResponsiveGrid-behållarkomponent](./spa-container-component.md) till SPA där författaren kan lägga till och redigera komponenter i SPA!
