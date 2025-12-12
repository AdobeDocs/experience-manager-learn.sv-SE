---
title: Lägga till redigerbara React-behållarkomponenter i en fjärr-SPA
description: Lär dig hur du lägger till redigerbara behållarkomponenter i ett fjärr-SPA som gör att AEM-författare kan dra och släppa komponenter i dem.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer
level: Beginner
jira: KT-7635
thumbnail: kt-7635.jpeg
last-substantial-update: 2022-11-11T00:00:00Z
recommendations: noDisplay, noCatalog
doc-type: Tutorial
exl-id: e5e6204c-d88c-4e79-a7f4-0cfc140bc51c
duration: 306
hide: true
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '1112'
ht-degree: 0%

---

# Redigerbara behållarkomponenter

{{spa-editor-deprecation}}

[Fasta komponenter](./spa-fixed-component.md) ger viss flexibilitet vid redigering av SPA-innehåll, men det här tillvägagångssättet är stelt och kräver att utvecklare definierar den exakta sammansättningen av det redigerbara innehållet. SPA Editor stöder användningen av behållarkomponenter i SPA för att skapa exceptionella upplevelser för författare. Med behållarkomponenter kan författare dra och släppa tillåtna komponenter i behållaren och redigera dem, precis som i traditionell AEM Sites-redigering!

![Redigerbara behållarkomponenter](./assets/spa-container-component/intro.png)

I det här kapitlet lägger vi till en redigerbar behållare i hemvyn som gör att författare kan skapa och layouta avancerat innehåll med hjälp av redigerbara React-komponenter direkt i SPA.

## Uppdatera WKND-appen

Så här lägger du till en behållarkomponent i hemvyn:

* Importera AEM React Editable-komponentens `ResponsiveGrid`-komponent
* Importera och registrera anpassade redigerbara React-komponenter (text och bild) för användning i ResponsiveGrid-komponenten

### Använda komponenten ResponsiveGrid

Så här lägger du till ett redigerbart område i hemvyn:

1. Öppna och redigera `react-app/src/components/Home.js`
1. Importera komponenten `ResponsiveGrid` från `@adobe/aem-react-editable-components` och lägg till den i komponenten `Home`.
1. Ange följande attribut för komponenten `<ResponsiveGrid...>`
   1. `pagePath = '/content/wknd-app/us/en/home'`
   1. `itemPath = 'root/responsivegrid'`

   Detta instruerar komponenten `ResponsiveGrid` att hämta sitt innehåll från AEM-resursen:

   1. `/content/wknd-app/us/en/home/jcr:content/root/responsivegrid`

   `itemPath` mappar till `responsivegrid`-noden som definieras i AEM-mallen `Remote SPA Page` och skapas automatiskt på nya AEM-sidor som skapas från AEM-mallen `Remote SPA Page`.

   Uppdatera `Home.js` om du vill lägga till komponenten `<ResponsiveGrid...>`.

   ```javascript
   ...
   import { ResponsiveGrid } from '@adobe/aem-react-editable-components';
   ...
   
   function Home() {
       return (
           <div className="Home">
               <ResponsiveGrid
                   pagePath='/content/wknd-app/us/en/home' 
                   itemPath='root/responsivegrid'/>
   
               <EditableTitle
                   pagePath='/content/wknd-app/us/en/home' 
                   itemPath='title'/>
   
               <Adventures />
           </div>
       );
   }
   ```

Filen `Home.js` ska se ut så här:

![Home.js](./assets/spa-container-component/home-js.png)

## Skapa redigerbara komponenter

För att få full effekt av de flexibla redigeringsfunktionerna i SPA Editor. Vi har redan skapat en redigerbar Title-komponent, men vi ska göra några till så att författarna kan använda redigerbar text och bilder i den nyligen tillagda ResponsiveGrid-komponenten.

De nya redigerbara komponenterna Text och Bildredigering skapas med hjälp av det redigerbara komponentdefinitionsmönstret som exporteras i [redigerbara fasta komponenter](./spa-fixed-component.md).

### Redigerbar textkomponent

1. Öppna SPA-projektet i din utvecklingsmiljö
1. Skapa en React-komponent på `src/components/editable/core/Text.js`
1. Lägg till följande kod i `Text.js`

   ```javascript
   import React from 'react'
   
   const TextPlain = (props) => <div className={props.baseCssClass}><p className="cmp-text__paragraph">{props.text}</p></div>;
   const TextRich = (props) => {
   const text = props.text;
   const id = (props.id) ? props.id : (props.cqPath ? props.cqPath.substr(props.cqPath.lastIndexOf('/') + 1) : "");
       return <div className={props.baseCssClass} id={id} data-rte-editelement dangerouslySetInnerHTML={{ __html: text }} />
   };
   
   export const Text = (props) => {
       if (!props.baseCssClass) {
           props.baseCssClass = 'cmp-text'
       }
   
       const { richText = false } = props
   
       return richText ? <TextRich {...props} /> : <TextPlain {...props} />
       }
   
       export function textIsEmpty(props) {
       return props.text == null || props.text.length === 0;
   }
   ```

1. Skapa en redigerbar React-komponent på `src/components/editable/EditableText.js`
1. Lägg till följande kod i `EditableText.js`

   ```javascript
   import React from 'react'
   import { EditableComponent, MapTo } from '@adobe/aem-react-editable-components';
   import { Text, textIsEmpty } from "./core/Text";
   import { withConditionalPlaceHolder } from "./core/util/withConditionalPlaceholder";
   import { withStandardBaseCssClass } from "./core/util/withStandardBaseCssClass";
   
   const RESOURCE_TYPE = "wknd-app/components/text";
   
   const EditConfig = {
       emptyLabel: "Text",
       isEmpty: textIsEmpty,
       resourceType: RESOURCE_TYPE
   };
   
   export const WrappedText = (props) => {
       const Wrapped = withConditionalPlaceHolder(withStandardBaseCssClass(Text, "cmp-text"), textIsEmpty, "Text V2")
       return <Wrapped {...props} />
   };
   
   const EditableText = (props) => <EditableComponent config={EditConfig} {...props}><WrappedText /></EditableComponent>
   
   MapTo(RESOURCE_TYPE)(EditableText);
   
   export default EditableText;
   ```

Implementeringen av den redigerbara textkomponenten ska se ut så här:

![Redigerbar textkomponent](./assets/spa-container-component/text-js.png)

### Bildkomponent

1. Öppna SPA-projektet i din utvecklingsmiljö
1. Skapa en React-komponent på `src/components/editable/core/Image.js`
1. Lägg till följande kod i `Image.js`

   ```javascript
   import React from 'react'
   import { RoutedLink } from "./RoutedLink";
   
   export const imageIsEmpty = (props) => (!props.src) || props.src.trim().length === 0
   
   const ImageInnerContents = (props) => {
   return (<>
       <img src={props.src}
           className={props.baseCssClass + '__image'}
           alt={props.alt} />
       {
           !!(props.title) && <span className={props.baseCssClass + '__title'} itemProp="caption">{props.title}</span>
       }
       {
           props.displayPopupTitle && (!!props.title) && <meta itemProp="caption" content={props.title} />
       }
       </>);
   };
   
   const ImageContents = (props) => {
       if (props.link && props.link.trim().length > 0) {
           return (
           <RoutedLink className={props.baseCssClass + '__link'} isRouted={props.routed} to={props.link}>
               <ImageInnerContents {...props} />
           </RoutedLink>
           )
       }
       return <ImageInnerContents {...props} />
   };
   
   export const Image = (props) => {
       if (!props.baseCssClass) {
           props.baseCssClass = 'cmp-image'
       }
   
       const { isInEditor = false } = props;
       const cssClassName = (isInEditor) ? props.baseCssClass + ' cq-dd-image' : props.baseCssClass;
   
       return (
           <div className={cssClassName}>
               <ImageContents {...props} />
           </div>
       )
   };
   ```

1. Skapa en redigerbar React-komponent på `src/components/editable/EditableImage.js`
1. Lägg till följande kod i `EditableImage.js`

```javascript
import { EditableComponent, MapTo } from '@adobe/aem-react-editable-components';
import { Image, imageIsEmpty } from "./core/Image";
import React from 'react'

import { withConditionalPlaceHolder } from "./core/util/withConditionalPlaceholder";
import { withStandardBaseCssClass } from "./core/util/withStandardBaseCssClass";

const RESOURCE_TYPE = "wknd-app/components/image";

const EditConfig = {
    emptyLabel: "Image",
    isEmpty: imageIsEmpty,
    resourceType: RESOURCE_TYPE
};

const WrappedImage = (props) => {
    const Wrapped = withConditionalPlaceHolder(withStandardBaseCssClass(Image, "cmp-image"), imageIsEmpty, "Image V2");
    return <Wrapped {...props}/>
}

const EditableImage = (props) => <EditableComponent config={EditConfig} {...props}><WrappedImage /></EditableComponent>

MapTo(RESOURCE_TYPE)(EditableImage);

export default EditableImage;
```


1. Skapa en SCSS-fil `src/components/editable/EditableImage.scss` som innehåller anpassade format för `EditableImage.scss`. Dessa format har CSS-klasserna för den redigerbara React-komponenten som mål.
1. Lägg till följande SCSS i `EditableImage.scss`

   ```css
   .cmp-image__image {
       margin: 1rem 0;
       width: 100%;
       border: 0;
    }
   ```

1. Importera `EditableImage.scss` i `EditableImage.js`

   ```javascript
   ...
   import './EditableImage.scss';
   ...
   ```

Implementeringen av den redigerbara bildkomponenten ska se ut så här:

![Redigerbar bildkomponent](./assets/spa-container-component/image-js.png)


### Importera redigerbara komponenter

De nyskapade komponenterna `EditableText` och `EditableImage` React refereras i SPA och instansieras dynamiskt baserat på den JSON som returneras av AEM. Om du vill vara säker på att de här komponenterna är tillgängliga för SPA skapar du importprogramsatser för dem i `Home.js`

1. Öppna SPA-projektet i din utvecklingsmiljö
1. Öppna filen `src/Home.js`
1. Lägg till importprogramsatser för `AEMText` och `AEMImage`

   ```javascript
   ...
   // The following need to be imported, so that MapTo is run for the components
   import EditableText from './editable/EditableText';
   import EditableImage from './editable/EditableImage';
   ...
   ```

Resultatet ska se ut så här:

![Home.js](./assets/spa-container-component/home-js-imports.png)

Om dessa importer _inte_ läggs till anropas inte koden `EditableText` och `EditableImage` av SPA, och komponenterna mappas därför inte till de angivna resurstyperna.

## Konfigurera behållaren i AEM

AEM behållarkomponenter använder profiler för att bestämma vilka komponenter som tillåts. Detta är en viktig konfiguration när du använder SPA Editor, eftersom endast AEM-komponenter som har mappade SPA-komponentmotsvarigheter kan återges av SPA. Se till att endast de komponenter som vi har skapat SPA-implementeringar för tillåts:

* `EditableTitle` har mappats till `wknd-app/components/title`
* `EditableText` har mappats till `wknd-app/components/text`
* `EditableImage` har mappats till `wknd-app/components/image`

Så här konfigurerar du fjärrsidmallens Reponsivegrid-behållare:

1. Logga in på AEM Author
1. Navigera till __Verktyg > Allmänt > Mallar > WKND-app__
1. Redigera __rapportens SPA-sida__

   ![Principer för responsiva stödraster](./assets/spa-container-component/templates-remote-spa-page.png)

1. Välj __Struktur__ i lägesväljaren i det övre högra hörnet
1. Tryck för att välja __layoutbehållaren__
1. Tryck på ikonen __Policy__ i popup-fältet

   ![Principer för responsiva stödraster](./assets/spa-container-component/templates-policies-action.png)

1. Till höger, under fliken __Tillåtna komponenter__, expanderar du __WKND APP - CONTENT__
1. Se till att endast följande är markerade:
   1. Bild
   1. Text
   1. Titel

   ![Fjärr-SPA-sida](./assets/spa-container-component/templates-allowed-components.png)

1. Tryck på __Klar__

## Redigera behållaren i AEM

När SPA har uppdaterats för att bädda in `<ResponsiveGrid...>`, omslutningar för tre redigerbara React-komponenter (`EditableTitle`, `EditableText` och `EditableImage`), och AEM har uppdaterats med en matchande Template-princip, kan vi börja skapa innehåll i behållarkomponenten.

1. Logga in på AEM Author
1. Navigera till __Webbplatser > WKND-app__
1. Tryck på __Hem__ och välj __Redigera__ i det övre åtgärdsfältet
   1. En&quot;Hello World&quot;-textkomponent visas, eftersom den lades till automatiskt när projektet genererades från AEM Project-arkitypen
1. Välj __Redigera__ i lägesväljaren längst upp till höger i sidredigeraren
1. Leta reda på det redigerbara området __Layoutbehållare__ under rubriken
1. Öppna sidredigerarens __sidfält__ och välj __vyn Komponenter__
1. Dra följande komponenter till __layoutbehållaren__
   1. Bild
   1. Titel
1. Dra komponenterna för att ordna om dem till följande ordning:
   1. Titel
   1. Bild
   1. Text
1. __Författare__ komponenten __Title__
   1. Tryck på komponenten Title (Rubrik) och tryck på ikonen __wrench__ för att __redigera__ komponenten Title (Rubrik)
   1. Lägg till följande text:
      1. Titel: __Sommaren kommer, vi får ut det mesta av den!__
      1. Typ: __H1__
   1. Tryck på __Klar__
1. __Författare__ komponenten __Bild__
   1. Dra en bild i från sidfältet (efter att du växlat till Assets-vyn) på bildkomponenten
   1. Tryck på bildkomponenten och tryck på ikonen __skiftnyckel__ för att redigera
   1. Markera kryssrutan __Bilden är dekorativ__
   1. Tryck på __Klar__
1. __Författare__ komponenten __Text__
   1. Redigera textkomponenten genom att trycka på textkomponenten och trycka på ikonen __skiftnyckel__
   1. Lägg till följande text:
      1. _Just nu kan du få 15 % på alla veckolånga äventyr och 20 % rabatt på alla äventyr som är två veckor eller längre! Lägg till kampanjkoden SUMMERISCOMING för att få dina rabatter i kassan!_
   1. Tryck på __Klar__

1. Dina komponenter är nu redigerade, men staplas lodrätt.

   ![Skapade komponenter](./assets/spa-container-component/authored-components.png)

   Använd AEM layoutläge för att justera komponenternas storlek och layout.

1. Växla till __layoutläge__ med lägesväljaren i det övre högra hörnet
1. __Ändra storlek__ på bild- och textkomponenterna så att de visas sida vid sida
   1. __Bild__-komponenten ska vara __8 kolumner bred__
   1. __Komponenten Text__ ska vara __3 kolumner bred__

   ![Layoutkomponenter](./assets/spa-container-component/layout-components.png)

1. __Förhandsgranska__ dina ändringar i AEM Page Editor
1. Uppdatera WKND-appen som körs lokalt på [http://localhost:3000](http://localhost:3000) om du vill se de ändringar som har skapats.

   ![Behållarkomponent i SPA](./assets/spa-container-component/localhost-final.png)


## Grattis!

Du har lagt till en behållarkomponent som gör att redigerbara komponenter kan läggas till av författare i WKND-appen! Nu kan du:

* Använd AEM React Editable Components `ResponsiveGrid`-komponent i SPA
* Skapa och registrera redigerbara React-komponenter (text och bild) för användning i SPA via behållarkomponenten
* Konfigurera fjärrsidmallen för SPA för att tillåta SPA-aktiverade komponenter
* Lägga till redigerbara komponenter i behållarkomponenten
* Författar och layoutkomponenter i SPA Editor

## Nästa steg

I nästa steg används samma teknik för att [lägga till en redigerbar komponent i en Adventure Details-väg](./spa-dynamic-routes.md) i SPA.
