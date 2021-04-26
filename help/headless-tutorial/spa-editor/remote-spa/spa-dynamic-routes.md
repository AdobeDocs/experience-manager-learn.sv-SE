---
title: Lägg till redigerbara komponenter i SPA dynamiska fjärrutter
description: Lär dig hur du lägger till redigerbara komponenter i dynamiska vägar i en SPA.
topic: Headless, SPA, Development
feature: SPA, kärnkomponenter, API:er, utveckling
role: Developer, Architect
level: Beginner
kt: 7636
thumbnail: kt-7636.jpeg
translation-type: tm+mt
source-git-commit: 0eb086242ecaafa53c59c2018f178e15f98dd76f
workflow-type: tm+mt
source-wordcount: '958'
ht-degree: 0%

---


# Dynamiska vägar och redigerbara komponenter

I detta kapitel aktiverar vi två dynamiska informationsvägar för Adventure Detail som stöder redigerbara komponenter. __Bali Surf Camp__ och __Beervana i Portland__.

![Dynamiska vägar och redigerbara komponenter](./assets/spa-dynamic-routes/intro.png)

SPA för Adventure Detail definieras som `/adventure:path` där `path` är sökvägen till WKND Adventure (Content Fragment) för att visa information om.

## Mappa SPA URL:er till AEM sidor

I de föregående två kapitlen mappades redigerbart komponentinnehåll från SPA hemvy till motsvarande SPA i AEM `/content/wknd-app/us/en/`.

Att definiera mappning för redigerbara komponenter för de SPA dynamiska vägarna liknar varandra, men vi måste skapa ett 1:1-mappningsschema mellan instanser av flödet och AEM sidor.

I den här självstudiekursen ska vi ta namnet på WKND Adventure Content Fragment, som är det sista segmentet i banan, och mappa det till en enkel sökväg under `/content/wknd-app/us/en/adventure`.

| SPA | AEM |
|------------------------------------|--------------------------------------------|
| / | /content/wknd-app/us/en/home |
| /adventure/content/dam/wknd/en/adventures/bali-surf-camp/__bali-surf-camp__ | /content/wknd-app/us/en/home/adventure/__bali-surf-camp__ |
| /adventure/content/dam/wknd/en/adventures/beervana-portland/__beervana-portland__ | /content/wknd-app/us/en/home/adventure/__beervana-in-portland__ |

På grundval av den här mappningen måste vi skapa två nya AEM sidor:

+ `/content/wknd-app/us/en/home/adventure/bali-surf-camp`
+ `/content/wknd-app/us/en/home/adventure/beervana-in-portland`

## SPA

Mappningen för begäranden som lämnar SPA konfigureras via konfigurationen `setupProxy` som görs i [Bootstrap i SPA](./spa-bootstrap.md).

## SPA Editor-mappning

Mappningen för SPA begäranden när SPA öppnas via AEM SPA Editor konfigureras via konfigurationen för delningskartor i [Konfigurera AEM](./aem-configure.md).

## Skapa innehållssidor i AEM

Skapa först sidsegmentet för mellanrummet `adventure`:

1. Logga in på AEM Author
1. Navigera till __Sites > WKND App > us > en > WKND App Home Page__
   + Den här AEM är mappad som SPA rot, så här börjar vi skapa den AEM sidstrukturen för andra SPA.
1. Tryck på __Skapa__ och välj __Sida__
1. Välj mallen __SPA__ och tryck på __Nästa__
1. Fyll i Sidegenskaper
   + __Titel__: Adventure
   + __Namn__:  `adventure`
      + Det här värdet definierar AEM sidas URL och måste därför matcha SPA ruttsegment.
1. Tryck på __Klar__

Skapa sedan AEM sidor som motsvarar var och en av de SPA URL:er som kräver redigerbara områden.

1. Navigera till den nya __Adventure__-sidan i Webbplatsadministratören
1. Tryck på __Skapa__ och välj __Sida__
1. Välj mallen __SPA__ och tryck på __Nästa__
1. Fyll i Sidegenskaper
   + __Titel__: Bali Surf Camp
   + __Namn__:  `bali-surf-camp`
      + Det här värdet definierar AEM sidas URL och måste därför matcha SPA rutts sista segment
1. Tryck på __Klar__
1. Upprepa steg 3-6 för att skapa sidan __Beervana i Portland__ med:
   + __Titel__: Beervana i Portland
   + __Namn__:  `beervana-in-portland`
      + Det här värdet definierar AEM sidas URL och måste därför matcha SPA rutts sista segment

Dessa två AEM sidor innehåller respektive redigerat innehåll för sina matchande SPA. Om andra SPA kräver redigering måste nya AEM sidor skapas på SPA URL-adress under SPA fjärrsidans rotsida (`/content/wknd-app/us/en/home`) i AEM.

## Uppdatera WKND-appen

Låt oss placera `<AEMResponsiveGrid...>`-komponenten som skapades i [det sista kapitlet](./spa-container-component.md) i vår `AdventureDetail`-SPA och skapa en redigerbar behållare.

### Placera SPA AEMResponsiveGrid

Om du placerar `<AEMResponsiveGrid...>` i `AdventureDetail`-komponenten skapas en redigerbar behållare i den vägen. Tricket är att eftersom flera vägar använder komponenten `AdventureDetail` för att återge måste vi justera attributet `<AEMResponsiveGrid...>'s pagePath` dynamiskt. `pagePath` måste härledas till motsvarande AEM, baserat på äventyret som flödesinstansen visar.

1. Öppna och redigera `react-app/src/components/AdventureDetail.js`
1. Lägg till följande rad före `AdventureDetail(..)'s`-andra `return(..)`-satsen, som härleder äventyrsnamnet från innehållsfragmentsökvägen.

   ```
   ...
   // Get the last segment of the Adventure Content Fragment path to used to generate the pagePath for the AEMResponsiveGrid
   const adventureName = adventureData._path.split('/').pop();
   ...
   ```

1. Importera `AEMResponsiveGrid`-komponenten och placera den ovanför `<h2>Itinerary</h2>`-komponenten.
1. Ange följande attribut för `<AEMResponsiveGrid...>`-komponenten
   + `pagePath = '/content/wknd-app/us/en/home/adventure/${adventureName}'`
   + `itemPath = 'root/responsivegrid'`

   Detta instruerar `AEMResponsiveGrid`-komponenten att hämta sitt innehåll från den AEM resursen:

   + `/content/wknd-app/us/en/home/adventure/${adventureName}/jcr:content/root/responsivegrid`


Uppdatera `AdventureDetail.js` med följande rader:

```
...
import AEMResponsiveGrid from '../components/aem/AEMResponsiveGrid';
...

function AdventureDetail(props) {
    ...
    // Get the last segment of the Adventure Content Fragment path to used to generate the pagePath for the AEMResponsiveGrid
    const adventureName = adventureData._path.split('/').pop();

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

Filen `AdventureDetail.js` ska se ut så här:

![AdventureDetail.js](./assets/spa-dynamic-routes/adventure-detail-js.png)

## Skapa behållaren i AEM

När `<AEMResponsiveGrid...>` är på plats och `pagePath` är dynamiskt inställt baserat på äventyret som återges, försöker vi att skapa innehåll i den.

1. Logga in på AEM Author
1. Navigera till __Sites > WKND App > us > en__
1. ____ Redigera startsidan för  __WKND-__ appen
   + Navigera till vägen __Bali Surf Camp__ i SPA för att redigera den
1. Välj __Förhandsgranska__ i lägesväljaren i det övre högra hörnet
1. Tryck på __Bali Surf Camp__-kortet i SPA för att navigera till dess väg
1. Välj __Redigera__ i lägesväljaren
1. Gå till det redigerbara området __Layoutbehållare__ precis ovanför __resär__
1. Öppna sidofältet __i sidredigeraren__ och välj vyn __Komponenter__
1. Dra några av de aktiverade komponenterna till __layoutbehållaren__
   + Bild
   + Text
   + Titel

   Och skapa marknadsföringsmaterial. Det kan se ut ungefär så här:

   ![Bali Adventure Detail Authoring](./assets/spa-dynamic-routes/adventure-detail-edit.png)

1. ____ Förhandsgranska ändringarna AEM sidredigeraren
1. Uppdatera WKND-appen som körs lokalt på [http://localhost:3000](http://localhost:3000) genom att navigera till __Bali Surf Camp__-vägen för att se de skapade ändringarna!

   ![SPA](./assets/spa-dynamic-routes/remote-spa-final.png)

När du navigerar till en äventyrsinformationsväg som inte har någon mappad AEM sida, kommer det inte att finnas någon redigeringsmöjlighet för den flödesinstansen. Om du vill aktivera redigering på de här sidorna skapar du bara en AEM sida med det matchande namnet under sidan __Adventure__!

## Grattis!

Grattis! Du har lagt till redigeringsmöjligheter för dynamiska vägar i SPA!

+ AEM React Editable Components ResponsiveGrid-komponent har lagts till på en dynamisk väg
+ Skapade AEM sidor med stöd för utveckling av två specifika rutter i SPA (Bali Surf Camp och Beervana i Portland)
+ Skapat innehåll på den dynamiska Bali Surf Camp-vägen!

Du har nu gått igenom de första stegen i hur AEM kan användas för att lägga till specifika redigerbara områden i en SPA.


>[!NOTE]
>
>Stanna kvar på kanalen! Den här självstudiekursen kommer att utökas för att omfatta Adobe bästa praxis och rekommendationer om hur SPA redigeringslösning ska AEM som Cloud Service och produktionsmiljöer.