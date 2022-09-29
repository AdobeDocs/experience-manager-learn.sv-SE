---
title: Lägg till redigerbara komponenter i SPA dynamiska fjärrutter
description: Lär dig hur du lägger till redigerbara komponenter i dynamiska vägar i en SPA.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
kt: 7636
thumbnail: kt-7636.jpeg
exl-id: 4accc1ca-6f4b-449e-bf2e-06f19d2fe17d
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '916'
ht-degree: 0%

---

# Dynamiska vägar och redigerbara komponenter

I detta kapitel aktiverar vi två dynamiska informationsvägar för Adventure Detail som stöder redigerbara komponenter. __Bali Surf Camp__ och __Beervana i Portland__.

![Dynamiska vägar och redigerbara komponenter](./assets/spa-dynamic-routes/intro.png)

SPA för Adventure Detail definieras som `/adventure:path` där `path` är sökvägen till WKND Adventure (Content Fragment) för att visa information om.

## Mappa SPA URL:er till AEM sidor

I de föregående två kapitlen mappades redigerbart komponentinnehåll från SPA hemvy till motsvarande SPA i AEM `/content/wknd-app/us/en/`.

Att definiera mappning för redigerbara komponenter för de SPA dynamiska vägarna liknar varandra, men vi måste skapa ett 1:1-mappningsschema mellan instanser av flödet och AEM sidor.

I den här självstudiekursen tar vi namnet på WKND Adventure Content Fragment, som är det sista segmentet i banan, och mappar det till en enkel väg under `/content/wknd-app/us/en/adventure`.

| SPA | AEM |
|------------------------------------|--------------------------------------------|
| / | /content/wknd-app/us/en/home |
| /adventure/content/dam/wknd/en/adventures/bali-surf-camp/__bali-surf-läger__ | /content/wknd-app/us/en/home/adventure/__bali-surf-läger__ |
| /adventure/content/dam/wknd/en/adventures/beervana-portland/__beervana-portland__ | /content/wknd-app/us/en/home/adventure/__beervana-in-portland__ |

På grundval av den här mappningen måste vi skapa två nya AEM sidor:

+ `/content/wknd-app/us/en/home/adventure/bali-surf-camp`
+ `/content/wknd-app/us/en/home/adventure/beervana-in-portland`

## SPA

Mappningen för begäranden som lämnar SPA konfigureras via `setupProxy` konfiguration klar i [Bootstrap the SPA](./spa-bootstrap.md).

## SPA Editor-mappning

Mappningen för SPA begäranden när SPA öppnas via AEM SPA Editor konfigureras via konfigurationen för delningskartor i [Konfigurera AEM](./aem-configure.md).

## Skapa innehållssidor i AEM

Skapa först mellanhanden `adventure` Sidsegment:

1. Logga in på AEM Author
1. Navigera till __Sites > WKND App > us > en > WKND App Home Page__
   + Den här AEM är mappad som SPA rot, så här börjar vi skapa den AEM sidstrukturen för andra SPA.
1. Tryck __Skapa__ och markera __Sida__
1. Välj __SPA__ och trycka på __Nästa__
1. Fyll i Sidegenskaper
   + __Titel__: Adventure
   + __Namn__: `adventure`
      + Det här värdet definierar AEM sidas URL och måste därför matcha SPA ruttsegment.
1. Tryck __Klar__

Skapa sedan AEM sidor som motsvarar var och en av de SPA URL:er som kräver redigerbara områden.

1. Navigera till den nya __Adventure__ sidan i Webbplatsadministratör
1. Tryck __Skapa__ och markera __Sida__
1. Välj __SPA__ och trycka på __Nästa__
1. Fyll i Sidegenskaper
   + __Titel__: Bali Surf Camp
   + __Namn__: `bali-surf-camp`
      + Det här värdet definierar AEM sidas URL och måste därför matcha SPA rutts sista segment
1. Tryck __Klar__
1. Upprepa steg 3-6 för att skapa __Beervana i Portland__ sida, med:
   + __Titel__: Beervana i Portland
   + __Namn__: `beervana-in-portland`
      + Det här värdet definierar AEM sidas URL och måste därför matcha SPA rutts sista segment

Dessa två AEM sidor innehåller det innehåll som har skapats för respektive SPA. Om andra SPA kräver redigering måste nya AEM sidor skapas på SPA URL-adress under SPA fjärrsidans rotsida (`/content/wknd-app/us/en/home`) i AEM.

## Uppdatera WKND-appen

Låt oss placera `<AEMResponsiveGrid...>` som skapats i [sista kapitlet](./spa-container-component.md)i vår `AdventureDetail` SPA, skapa en redigerbar behållare.

### Placera SPA AEMResponsiveGrid

Placera `<AEMResponsiveGrid...>` i `AdventureDetail` skapar en redigerbar behållare i det flödet. Tricket är att flera rutter använder `AdventureDetail` måste vi dynamiskt justera  `<AEMResponsiveGrid...>'s pagePath` -attribut. The `pagePath` måste härledas till en punkt till motsvarande AEM, baserat på äventyret som flödesinstansen visar.

1. Öppna och redigera `react-app/src/components/AdventureDetail.js`
1. Lägg till följande rad före `AdventureDetail(..)'s` sekund `return(..)` -programsats, som härleder äventyrsnamnet från innehållsfragmentsökvägen.

   ```
   ...
   // Get the last segment of the Adventure Content Fragment path to used to generate the pagePath for the AEMResponsiveGrid
   const adventureName = _path.split('/').pop();
   ...
   ```

1. Importera `AEMResponsiveGrid` och placera den ovanför `<h2>Itinerary</h2>` -komponenten.
1. Ange följande attribut för `<AEMResponsiveGrid...>` komponent
   + `pagePath = '/content/wknd-app/us/en/home/adventure/${adventureName}'`
   + `itemPath = 'root/responsivegrid'`

   Detta instruerar `AEMResponsiveGrid` för att hämta dess innehåll från AEM:

   + `/content/wknd-app/us/en/home/adventure/${adventureName}/jcr:content/root/responsivegrid`


Uppdatera `AdventureDetail.js` med följande rader:

```
...
import AEMResponsiveGrid from '../components/aem/AEMResponsiveGrid';
...

function AdventureDetail(props) {
    ...
    // Get the last segment of the Adventure Content Fragment path to used to generate the pagePath for the AEMResponsiveGrid
    const adventureName = _path.split('/').pop();

    return(
        ...
        <AEMResponsiveGrid 
            pagePath={`/content/wknd-app/us/en/home/adventure/${adventureName}`}
            itemPath="root/responsivegrid"/>
            
        <h2>Itinerary</h2>
        ...
    )
}
```

The `AdventureDetail.js` filen ska se ut så här:

![AdventureDetail.js](./assets/spa-dynamic-routes/adventure-detail-js.png)

## Skapa behållaren i AEM

Med `<AEMResponsiveGrid...>` på plats, och `pagePath` dynamiskt inställda baserat på äventyret som återges, försöker vi skapa innehåll i det.

1. Logga in på AEM Author
1. Navigera till __Sites > WKND App > us > en__
1. __Redigera__ den __WKND App - startsida__ page
   + Navigera till __Bali Surf Camp__ för att redigera SPA
1. Välj __Förhandsgranska__ från lägesväljaren i det övre högra hörnet
1. Tryck på __Bali Surf Camp__ kortet i SPA för att navigera till dess väg
1. Välj __Redigera__ från mode-selector
1. Leta reda på __Layoutbehållare__ redigerbart område alldeles ovanför __Itinerary__
1. Öppna __Sidredigerarens sidlist__ och väljer __Komponentvy__
1. Dra några av de aktiverade komponenterna till __Layoutbehållare__
   + Bild
   + Text
   + Titel

   Och skapa marknadsföringsmaterial. Det kan se ut ungefär så här:

   ![Bali Adventure Detail Authoring](./assets/spa-dynamic-routes/adventure-detail-edit.png)

1. __Förhandsgranska__ dina ändringar AEM sidredigeraren
1. Uppdatera WKND-appen som körs lokalt på [http://localhost:3000](http://localhost:3000), navigera till __Bali Surf Camp__ för att se ändringarna!

   ![SPA](./assets/spa-dynamic-routes/remote-spa-final.png)

När du navigerar till en äventyrsinformationsväg som inte har någon mappad AEM finns det ingen redigeringsmöjlighet för den flödesinstansen. Om du vill aktivera redigering på de här sidorna skapar du en AEM sida med det matchande namnet under __Adventure__ sida!

## Grattis!

Grattis! Du har lagt till redigeringsmöjligheter för dynamiska vägar i SPA!

+ AEM React Editable Components ResponsiveGrid-komponent har lagts till på en dynamisk väg
+ Skapade AEM sidor med stöd för utveckling av två specifika rutter i SPA (Bali Surf Camp och Beervana i Portland)
+ Skapat innehåll på den dynamiska Bali Surf Camp-vägen!

Du har nu gått igenom de första stegen i hur AEM kan användas för att lägga till specifika redigerbara områden i en SPA.
