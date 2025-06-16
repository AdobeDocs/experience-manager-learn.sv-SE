---
title: Lägg till redigerbara komponenter i fjärr-SPA:s dynamiska vägar
description: Lär dig hur du lägger till redigerbara komponenter i dynamiska vägar i en fjärr-SPA.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
jira: KT-7636
thumbnail: kt-7636.jpeg
last-substantial-update: 2022-11-11T00:00:00Z
recommendations: noDisplay, noCatalog
doc-type: Tutorial
exl-id: 4accc1ca-6f4b-449e-bf2e-06f19d2fe17d
duration: 202
hide: true
source-git-commit: 5b008419d0463e4eaa1d19c9fe86de94cba5cb9a
workflow-type: tm+mt
source-wordcount: '903'
ht-degree: 0%

---

# Dynamiska vägar och redigerbara komponenter

{{spa-editor-deprecation}}

I det här kapitlet aktiverar vi två dynamiska Adventure Detail-vägar som stöder redigerbara komponenter: __Bali Surf Camp__ och __Beervana i Portland__.

![Dynamiska vägar och redigerbara komponenter](./assets/spa-dynamic-routes/intro.png)

SPA-vägen för Adventure Detail definieras som `/adventure/:slug` där `slug` är en unik identifieraregenskap i Adventure Content Fragment.

## Mappa SPA-URL:er till AEM Pages

I de föregående två kapitlen mappades redigerbart komponentinnehåll från SPA:s hemvy till motsvarande fjärr-SPA-rotsida i AEM på `/content/wknd-app/us/en/`.

Att definiera mappning för redigerbara komponenter för SPA:s dynamiska vägar är likartat, men vi måste skapa ett 1:1-mappningsschema mellan instanser av flödet och AEM-sidor.

I den här självstudiekursen tar vi namnet på WKND Adventure Content Fragment, som är det sista segmentet i sökvägen, och mappar det till en enkel sökväg under `/content/wknd-app/us/en/adventure`.

| Fjärr-SPA-väg | AEM-sidsökväg |
|------------------------------------|--------------------------------------------|
| / | /content/wknd-app/us/en/home |
| /adventure/__bali-surf-camp__ | /content/wknd-app/us/en/home/adventure/__bali-surf-camp__ |
| /adventure/__beervana-portland__ | /content/wknd-app/us/en/home/adventure/__beervana-in-portland__ |

Därför måste vi utifrån denna karta skapa två nya AEM-sidor:

* `/content/wknd-app/us/en/home/adventure/bali-surf-camp`
* `/content/wknd-app/us/en/home/adventure/beervana-in-portland`

## Fjärr-SPA-mappning

Mappningen för begäranden som lämnar fjärr-SPA konfigureras via konfigurationen `setupProxy` som görs i [Bootstrap i SPA](./spa-bootstrap.md).

## Mappning av SPA-redigerare

Mappningen för SPA-begäranden när SPA öppnas via AEM SPA Editor konfigureras via konfigurationen för Sling Mappings i [Konfigurera AEM](./aem-configure.md).

## Skapa innehållssidor i AEM

Skapa först mellanliggande sidsegment `adventure`:

1. Logga in på AEM Author
1. Navigera till __Webbplatser > WKND-app > oss > en > WKND-appens startsida__
   1. Denna AEM-sida är mappad som rot till SPA, så här börjar vi bygga ut AEM sidstruktur för andra SPA-vägar.
1. Tryck på __Skapa__ och välj __Sida__
1. Välj mallen __Fjärrsida för SPA-sidor__ och tryck på __Nästa__
1. Fyll i Sidegenskaper
   1. __Titel__: Äventyr
   1. __Namn__: `adventure`
      1. Det här värdet definierar AEM-sidans URL och måste därför matcha SPA-ruttsegmentet.
1. Tryck på __Klar__

Skapa sedan de AEM-sidor som motsvarar de URL:er till SPA som kräver redigerbara områden.

1. Navigera till den nya sidan __Adventure__ i Webbplatsadministratören
1. Tryck på __Skapa__ och välj __Sida__
1. Välj mallen __Fjärrsida för SPA-sidor__ och tryck på __Nästa__
1. Fyll i Sidegenskaper
   1. __Titel__: Bali Surf Camp
   1. __Namn__: `bali-surf-camp`
      1. Detta värde definierar AEM-sidans URL och måste därför matcha SPA-ruttens sista segment
1. Tryck på __Klar__
1. Upprepa steg 3-6 för att skapa sidan __Beervana i Portland__ med:
   1. __Titel__: Beervana i Portland
   1. __Namn__: `beervana-in-portland`
      1. Detta värde definierar AEM-sidans URL och måste därför matcha SPA-ruttens sista segment

Dessa två AEM-sidor innehåller det innehåll som skapats för respektive matchande SPA-vägar. Om andra SPA-vägar kräver redigering måste nya AEM-sidor skapas på deras SPA-URL under fjärr-SPA-sidans rotsida (`/content/wknd-app/us/en/home`) i AEM.

## Uppdatera WKND-appen

Låt oss placera komponenten `<ResponsiveGrid...>` som skapades i det [sista kapitlet](./spa-container-component.md) i vår `AdventureDetail` SPA-komponent och skapa en redigerbar behållare.

### Placera SPA-komponenten för ResponsiveGrid

Om du placerar `<ResponsiveGrid...>` i komponenten `AdventureDetail` skapas en redigerbar behållare i den vägen. Tricket är att eftersom flera vägar använder komponenten `AdventureDetail` för att återge, måste vi justera attributet `<ResponsiveGrid...>'s pagePath` dynamiskt. `pagePath` måste härledas till att peka på motsvarande AEM-sida, baserat på äventyret som flödesinstansen visar.

1. Öppna och redigera `react-app-/src/components/AdventureDetail.js`
1. Importera komponenten `ResponsiveGrid` och placera den ovanför komponenten `<h2>Itinerary</h2>`.
1. Ange följande attribut för komponenten `<ResponsiveGrid...>`. Observera att attributet `pagePath` lägger till den aktuella `slug` som mappar till äventyrssidan enligt mappningen som definieras ovan.
   1. `pagePath = '/content/wknd-app/us/en/home/adventure/${slug}'`
   1. `itemPath = 'root/responsivegrid'`

   Detta instruerar komponenten `ResponsiveGrid` att hämta sitt innehåll från AEM-resursen:

   1. `/content/wknd-app/us/en/home/adventure/${slug}/jcr:content/root/responsivegrid`

Uppdatera `AdventureDetail.js` med följande rader:

```javascript
...
import { ResponsiveGrid } from '@adobe/aem-react-editable-components';
...

function AdventureDetailRender(props) {
    ...
    // Get the slug from the React route parameter, this will be used to specify the AEM Page to store/read editable content from
    const { slug } = useParams();

    return(
        ...
        // Pass the slug in
        function AdventureDetailRender({ title, primaryImage, activity, adventureType, tripLength, 
                groupSize, difficulty, price, description, itinerary, references, slug }) {
            ...
            return (
                ...
                <ResponsiveGrid 
                    pagePath={`/content/wknd-app/us/en/home/adventure/${slug}`}
                    itemPath="root/responsivegrid"/>
                    
                <h2>Itinerary</h2>
                ...
            )
        }
    )
}
```

Filen `AdventureDetail.js` ska se ut så här:

![AdventureDetail.js](./assets/spa-dynamic-routes/adventure-detail-js.png)

## Skapa behållaren i AEM

När `<ResponsiveGrid...>` är på plats och dess `pagePath` dynamiskt anges baserat på det äventyr som återges, försöker vi att skapa innehåll i den.

1. Logga in på AEM Author
1. Navigera till __Sites > WKND App > us > en__
1. __Redigera__ __WKND-appens startsida__
   1. Navigera till __Bali Surf Camp__-vägen i SPA för att redigera den
1. Välj __Förhandsgranska__ i lägesväljaren i det övre högra hörnet
1. Tryck på __Bali Surf Camp__ -kortet i SPA för att navigera till dess väg
1. Välj __Redigera__ i lägesväljaren
1. Leta reda på det redigerbara området __Layoutbehållare__ precis ovanför __Intervär__
1. Öppna sidredigerarens __sidfält__ och välj __vyn Komponenter__
1. Dra några av de aktiverade komponenterna till __layoutbehållaren__
   1. Bild
   1. Text
   1. Titel

   Och skapa marknadsföringsmaterial. Det skulle kunna se ut ungefär så här:

   ![Bali Adventure Detail Authoring](./assets/spa-dynamic-routes/adventure-detail-edit.png)

1. __Förhandsgranska__ dina ändringar i AEM Page Editor
1. Uppdatera WKND-appen som körs lokalt på [http://localhost:3000](http://localhost:3000), navigera till __Bali Surf Camp__ för att se de redigerade ändringarna!

   ![Fjärr-SPA-bali](./assets/spa-dynamic-routes/remote-spa-final.png)

När du navigerar till en äventyrsinformationsväg som inte har någon mappad AEM Page finns det ingen redigeringsmöjlighet för den väginstansen. Om du vill aktivera redigering på de här sidorna skapar du bara en AEM-sida med det matchande namnet på sidan __Adventure__!

## Grattis!

Grattis! Du har lagt till redigeringsmöjligheter för dynamiska vägar i SPA!

* Komponenten ResponsiveGrid för den ändringsbara komponenten för AEM React har lagts till på en dynamisk väg
* Skapade AEM-sidor med stöd för utveckling av två specifika rutter i SPA (Bali Surf Camp och Beervana i Portland)
* Skapat innehåll på den dynamiska Bali Surf Camp-vägen!

Du har nu gått igenom de första stegen i hur AEM SPA Editor kan användas för att lägga till specifika redigerbara områden i en fjärr-SPA!
