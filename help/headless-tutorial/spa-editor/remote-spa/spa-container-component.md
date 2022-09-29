---
title: Lägg till redigerbara behållarkomponenter i en SPA
description: Lär dig hur du lägger till redigerbara behållarkomponenter i en SPA som gör att AEM kan dra och släppa komponenter i dem.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
kt: 7635
thumbnail: kt-7635.jpeg
exl-id: e5e6204c-d88c-4e79-a7f4-0cfc140bc51c
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '1167'
ht-degree: 0%

---

# Redigerbara behållarkomponenter

[Fasta komponenter](./spa-fixed-component.md) ger viss flexibilitet vid framtagning SPA innehåll, men det här tillvägagångssättet är stelt och kräver att utvecklare definierar den exakta sammansättningen av det redigerbara innehållet. SPA Editor stöder användningen av behållarkomponenter i SPA för att skapa exceptionella upplevelser för författare. Med behållarkomponenter kan författare dra och släppa tillåtna komponenter i behållaren och redigera dem, precis som i traditionell AEM Sites-redigering!

![Redigerbara behållarkomponenter](./assets/spa-container-component/intro.png)

I det här kapitlet lägger vi till en redigerbar behållare i hemvyn som gör att författare kan skapa och layouta avancerat innehåll med hjälp AEM React Core Components direkt i SPA.

## Uppdatera WKND-appen

Så här lägger du till en behållarkomponent i hemvyn:

+ Importera AEM React Editable-komponentens ResponsiveGrid-komponent
+ Importera och registrera AEM React Core-komponenter (text och bild) för användning i behållarkomponenten

### Importera i behållarkomponenten ResponsiveGrid

Om du vill placera ett redigerbart område i hemvyn måste du:

1. Importera komponenten ResponsiveGrid från `@adobe/aem-react-editable-components`
1. Registrera det med `withMappable` så att utvecklare kan placera den i SPA
1. Registrera dig även med `MapTo` så att det kan återanvändas i andra Container-komponenter, vilket effektivt kapslar in behållare.

Så här gör du:

1. Öppna SPA i din utvecklingsmiljö
1. Skapa en React-komponent på `src/components/aem/AEMResponsiveGrid.js`
1. Lägg till följande kod i `AEMResponsiveGrid.js`

   ```
   // Import the withMappable API provided bu the AEM SPA Editor JS SDK
   import { withMappable, MapTo } from '@adobe/aem-react-editable-components';
   
   // Import the base ResponsiveGrid component
   import { ResponsiveGrid } from "@adobe/aem-react-editable-components";
   
   // The sling:resourceType for which this Core Component is registered with in AEM
   const RESOURCE_TYPE = "wcm/foundation/components/responsivegrid";
   
   // Create an EditConfig to allow the AEM SPA Editor to properly render the component in the Editor's context
   const EditConfig = {
       emptyLabel: "Layout Container",  // The component placeholder in AEM SPA Editor
       isEmpty: function(props) { 
           return props.cqItemsOrder == null || props.cqItemsOrder.length === 0;
       },                              // The function to determine if this component has been authored
       resourceType: RESOURCE_TYPE     // The sling:resourceType this SPA component is mapped to
   };
   
   // MapTo allows the AEM SPA Editor JS SDK to dynamically render components added to SPA Editor Containers
   MapTo(RESOURCE_TYPE)(ResponsiveGrid, EditConfig);
   
   // withMappable allows the component to be hardcoded into the SPA; <AEMResponsiveGrid .../>
   const AEMResponsiveGrid = withMappable(ResponsiveGrid, EditConfig);
   
   export default AEMResponsiveGrid;
   ```

Koden är liknande `AEMTitle.js` att [importerade komponenten AEM kärnkärnkomponenterna](./spa-fixed-component.md).


The `AEMResponsiveGrid.js` filen ska se ut så här:

![AEMResponsiveGrid.js](./assets/spa-container-component/aem-responsive-grid-js.png)

### Använda SPA AEMResponsiveGrid

Nu när AEM ResponsiveGrid-komponenten är registrerad i och tillgänglig för användning i SPA kan vi placera den i hemvyn.

1. Öppna och redigera `react-app/src/Home.js`
1. Importera `AEMResponsiveGrid` och placera den ovanför `<AEMTitle ...>` -komponenten.
1. Ange följande attribut för `<AEMResponsiveGrid...>` komponent
   + `pagePath = '/content/wknd-app/us/en/home'`
   + `itemPath = 'root/responsivegrid'`

   Detta instruerar `AEMResponsiveGrid` för att hämta dess innehåll från AEM:

   + `/content/wknd-app/us/en/home/jcr:content/root/responsivegrid`

   The `itemPath` mappar till `responsivegrid` noden som definieras i `Remote SPA Page` AEM och skapas automatiskt på nya AEM sidor som skapas från `Remote SPA Page` AEM.

   Uppdatera `Home.js` för att lägga till `<AEMResponsiveGrid...>` -komponenten.

   ```
   ...
   import AEMResponsiveGrid from './aem/AEMResponsiveGrid';
   ...
   
   function Home() {
       return (
           <div className="Home">
               <AEMResponsiveGrid
                   pagePath='/content/wknd-app/us/en/home' 
                   itemPath='root/responsivegrid'/>
   
               <AEMTitle
                   pagePath='/content/wknd-app/us/en/home' 
                   itemPath='title'/>
               <Adventures />
           </div>
       );
   }
   ```

The `Home.js` filen ska se ut så här:

![Home.js](./assets/spa-container-component/home-js.png)

## Skapa redigerbara komponenter

För att få full effekt av de flexibla redigeringsfunktionerna i SPA Editor. Vi har redan skapat en redigerbar Title-komponent, men vi ska göra några till så att författarna kan använda Text och Image AEM WCM Core Components i den nya behållarkomponenten.

### Textkomponent

1. Öppna SPA i din utvecklingsmiljö
1. Skapa en React-komponent på `src/components/aem/AEMText.js`
1. Lägg till följande kod i `AEMText.js`

   ```
   import { withMappable, MapTo } from '@adobe/aem-react-editable-components';
   import { TextV2, TextV2IsEmptyFn } from "@adobe/aem-core-components-react-base";
   
   const RESOURCE_TYPE = "wknd-app/components/text";
   
   const EditConfig = {    
       emptyLabel: "Text",
       isEmpty: TextV2IsEmptyFn,
       resourceType: RESOURCE_TYPE
   };
   
   MapTo(RESOURCE_TYPE)(TextV2, EditConfig);
   
   const AEMText = withMappable(TextV2, EditConfig);
   
   export default AEMText;
   ```

The `AEMText.js` filen ska se ut så här:

![AEMText.js](./assets/spa-container-component/aem-text-js.png)

### Bildkomponent

1. Öppna SPA i din utvecklingsmiljö
1. Skapa en React-komponent på `src/components/aem/AEMImage.js`
1. Lägg till följande kod i `AEMImage.js`

   ```
   import { withMappable, MapTo } from '@adobe/aem-react-editable-components';
   import { ImageV2, ImageV2IsEmptyFn } from "@adobe/aem-core-components-react-base";
   
   const RESOURCE_TYPE = "wknd-app/components/image";
   
   const EditConfig = {    
       emptyLabel: "Image",
       isEmpty: ImageV2IsEmptyFn,
       resourceType: RESOURCE_TYPE
   };
   
   MapTo(RESOURCE_TYPE)(ImageV2, EditConfig);
   
   const AEMImage = withMappable(ImageV2, EditConfig);
   
   export default AEMImage;
   ```

1. Skapa en SCSS-fil `src/components/aem/AEMImage.scss` som innehåller anpassade format för `AEMImage.scss`. Dessa format har CSS-klasserna BEM-notation för AEM React Core-komponenten.
1. Lägg till följande SCSS i `AEMImage.scss`

   ```
   .cmp-image__image {
       margin: 1rem 0;
       width: 100%;
       border: 0;
    }
   ```

1. Importera `AEMImage.scss` in `AEMImage.js`

   ```
   ...
   import './AEMImage.scss';
   ...
   ```

The `AEMImage.js` och `AEMImage.scss` ska se ut så här:

![AEMImage.js och AEMImage.scss](./assets/spa-container-component/aem-image-js-scss.png)

### Importera redigerbara komponenter

Den nyskapade `AEMText` och `AEMImage` SPA komponenter refereras i SPA och instansieras dynamiskt baserat på den JSON som returneras av AEM. Om du vill vara säker på att de här komponenterna är tillgängliga för SPA skapar du importprogramsatser för dem i `Home.js`

1. Öppna SPA i din utvecklingsmiljö
1. Öppna filen `src/Home.js`
1. Lägg till importprogramsatser för `AEMText` och `AEMImage`

   ```
   ...
   import AEMText from './components/aem/AEMText';
   import AEMImage from './components/aem/AEMImage';
   ...
   ```


Resultatet ska se ut så här:

![Home.js](./assets/spa-container-component/home-js-imports.png)

Om denna import _not_ har lagts till, `AEMText` och `AEMImage` Koden anropas inte av SPA och komponenterna registreras därför inte mot de angivna resurstyperna.

## Konfigurera behållaren i AEM

AEM behållarkomponenter använder profiler för att styra deras tillåtna komponenter. Detta är en viktig konfiguration när du använder SPA Editor, eftersom endast AEM WCM Core Components som har mappade SPA komponentmotsvarigheter kan återges av SPA. Se till att endast de komponenter som vi har SPA implementeringar för tillåts:

+ `AEMTitle` mappad till `wknd-app/components/title`
+ `AEMText` mappad till `wknd-app/components/text`
+ `AEMImage` mappad till `wknd-app/components/image`

Så här konfigurerar du SPA på fjärrsidmallens reponsivegrid-behållare:

1. Logga in på AEM Author
1. Navigera till __Verktyg > Allmänt > Mallar > WKND-app__
1. Redigera __SPA__

   ![Principer för responsiva stödraster](./assets/spa-container-component/templates-remote-spa-page.png)

1. Välj __Struktur__ i lägesväljaren längst upp till höger
1. Tryck för att välja __Layoutbehållare__
1. Tryck på __Policy__ ikon i popup-fältet

   ![Principer för responsiva stödraster](./assets/spa-container-component/templates-policies-action.png)

1. Till höger, under __Tillåtna komponenter__ flik, expandera __WKND APP - INNEHÅLL__
1. Se till att endast följande är markerade:
   + Bild
   + Text
   + Titel

   ![SPA](./assets/spa-container-component/templates-allowed-components.png)

1. Tryck __Klar__

## Redigera behållaren i AEM

Efter att SPA uppdaterats för att bädda in `<AEMResponsiveGrid...>`, omslag för tre AEM React Core-komponenter (`AEMTitle`, `AEMText`och `AEMImage`), och AEM uppdateras med en matchande mallprincip, kan vi börja skapa innehåll i behållarkomponenten.

1. Logga in på AEM Author
1. Navigera till __Sites > WKND App__
1. Tryck __Startsida__ och markera __Redigera__ i det övre åtgärdsfältet
   + En&quot;Hello World&quot;-textkomponent visas, eftersom den lades till automatiskt när projektet genererades från den AEM projekttypen
1. Välj __Redigera__ från lägesväljaren i det övre högra hörnet i sidredigeraren
1. Leta reda på __Layoutbehållare__ redigerbart område under titeln
1. Öppna __Sidredigerarens sidlist__ och väljer __Komponentvy__
1. Dra följande komponenter till __Layoutbehållare__
   + Bild
   + Titel
1. Dra komponenterna för att ordna om dem till följande ordning:
   1. Titel
   1. Bild
   1. Text
1. __Upphovsman__ den __Titel__ komponent
   1. Tryck på komponenten Title (Rubrik) och tryck på __wrench__ ikon till __redigera__ komponenten Title
   1. Lägg till följande text:
      + Titel: __Sommaren kommer, vi får ut det mesta av den!__
      + Typ: __H1__
   1. Tryck __Klar__
1. __Upphovsman__ den __Bild__ komponent
   1. Dra en bild i från sidofältet (efter växling till resursvyn) på komponenten Bild
   1. Tryck på komponenten Image (Bild) och tryck på __wrench__ ikon som ska redigeras
   1. Kontrollera __Bilden är dekorativ__ kryssruta
   1. Tryck __Klar__
1. __Upphovsman__ den __Text__ komponent
   1. Redigera Text-komponenten genom att trycka på Text-komponenten och trycka på __wrench__ icon
   1. Lägg till följande text:
      + _Just nu kan ni få 15 % på alla veckolånga äventyr och 20 % rabatt på alla äventyr som är två veckor eller längre! I kassan lägger du till kampanjkoden SUMMERISCOMING för att få rabatterna!_
   1. Tryck __Klar__

1. Dina komponenter är nu redigerade, men staplas lodrätt.

   ![Skapade komponenter](./assets/spa-container-component/authored-components.png)

   Använd AEM layoutläge för att justera komponenternas storlek och layout.

1. Växla till __Layoutläge__ med lägesväljaren i det övre högra hörnet
1. __Ändra storlek__ Bild- och textkomponenterna, så att de visas sida vid sida
   + __Bild__ ska vara __8 kolumner bred__
   + __Text__ ska vara __3 kolumner bred__

   ![Layoutkomponenter](./assets/spa-container-component/layout-components.png)

1. __Förhandsgranska__ dina ändringar AEM sidredigeraren
1. Uppdatera WKND-appen som körs lokalt på [http://localhost:3000](http://localhost:3000) om du vill se ändringarna du skrivit!

   ![Behållarkomponent i SPA](./assets/spa-container-component/localhost-final.png)


## Grattis!

Du har lagt till en behållarkomponent som gör att redigerbara komponenter kan läggas till av författare i WKND-appen! Nu kan du:

+ Använd AEM React Editable Components ResponsiveGrid-komponent i SPA
+ Registrera AEM React Core-komponenter (text och bild) för användning i SPA via behållarkomponenten
+ Konfigurera SPA för att tillåta de SPA kärnkomponenterna
+ Lägga till redigerbara komponenter i behållarkomponenten
+ Författar och layoutkomponenter i SPA Editor

## Nästa steg

I nästa steg används samma teknik för att [lägga till en redigerbar komponent i en Adventure Details-väg](./spa-dynamic-routes.md) i SPA.
