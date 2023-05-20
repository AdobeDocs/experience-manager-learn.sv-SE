---
title: Förhandsgranska innehållsfragment
description: Lär dig hur du använder förhandsgranskning av innehållsfragment för alla författare för att snabbt se hur innehållsändringar påverkar AEM Headless-upplevelser.
version: Cloud Service
feature: Content Fragments
topic: Headless, Content Management, Development
role: Architect, Developer
level: Beginner
doc-type: Tutorial
last-substantial-update: 2023-03-17T00:00:00Z
jira: KT-10841
thumbnail: 3416906.jpeg
exl-id: 247d40a3-ff67-4c1f-86bf-3794d7ce3e32
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '513'
ht-degree: 0%

---

# Förhandsgranska innehållsfragment

AEM Headless-program har stöd för integrerad förhandsgranskning. Förhandsgranskningen länkar AEM Authors Content Fragment-redigerare till din anpassade app (adresserbar via HTTP), vilket ger en djup länk till den app som återger det innehållsfragment som förhandsgranskas.

>[!VIDEO](https://video.tv.adobe.com/v/3416906?quality=12&learn=on)

Om du vill använda förhandsgranskning av innehållsfragment måste flera villkor vara uppfyllda:

1. Appen måste distribueras till en URL som författarna kan komma åt
1. Appen måste konfigureras för att ansluta till AEM Author-tjänsten (i stället för AEM Publish-tjänsten)
1. Appen måste utformas med URL:er eller vägar som kan använda [Sökväg eller ID för innehållsfragment](#url-expressions) för att välja vilka innehållsfragment som ska visas för förhandsgranskning i appupplevelsen.

## Förhandsgranska URL:er

Förhandsgranska URL:er, använda [URL-uttryck](#url-expressions), anges i Egenskaper för innehållsfragmentmodellen.

![URL för förhandsgranskning av innehållsfragmentmodell](./assets/preview/cf-model-preview-url.png)

1. Logga in på AEM Author Service som administratör
1. Navigera till __Verktyg > Allmänt > Modeller för innehållsfragment__
1. Välj __Content Fragment Model__ och markera __Egenskaper__ i det övre åtgärdsfältet.
1. Ange förhandsgransknings-URL:en för innehållsfragmentmodellen med [URL-uttryck](#url-expressions)
   + Förhandsgransknings-URL:en måste peka på en distribution av programmet som ansluter till AEM Author-tjänsten.

### URL-uttryck

Varje Content Fragment Model kan ha en URL för förhandsgranskning. URL:en för förhandsgranskning kan parametriseras per innehållsfragment med hjälp av de URL-uttryck som anges i tabellen nedan. Flera URL-uttryck kan användas i en enda förhandsgransknings-URL.

|  | URL-uttryck | Värde |
| --------------------------------------- | ----------------------------------- | ----------- |
| Sökväg för innehållsfragment | `${contentFragment.path}` | `/content/dam/wknd-shared/en/adventures/surf-camp-bali/surf-camp-bali` |
| ID för innehållsfragment | `${contentFragment.id}` | `12c34567-8901-2aa3-45b6-d7890aa1c23c` |
| Variation i innehållsfragment | `${contentFragment.variation}` | `main` |
| Sökväg till modell för innehållsfragment | `${contentFragment.model.path}` | `/conf/wknd-shared/settings/dam/cfm/models/adventure` |
| Modellnamn för innehållsfragment | `${contentFragment.model.name}` | `adventure` |

Exempel på URL för förhandsgranskning:

+ En förhandsgransknings-URL på __Adventure__ modell kan se ut som `https://preview.app.wknd.site/adventure${contentFragment.path}` som ger `https://preview.app.wknd.site/adventure/content/dam/wknd-shared/en/adventures/surf-camp-bali/surf-camp-bali`
+ En förhandsgransknings-URL på __Artikel__ modell kan se ut som `https://preview.news.wknd.site/${contentFragment.model.name}/${contentFragment.id}.html?variation=${contentFragment.variation}` lösningar `https://preview.news.wknd.site/article/99c34317-1901-2ab3-35b6-d7890aa1c23c.html?variation=main`

## Förhandsgranskning i appen

Alla innehållsfragment som använder den konfigurerade modellen för innehållsfragment har en förhandsgranskningsknapp. Knappen Förhandsgranska öppnar förhandsvisnings-URL:en för innehållsfragmentmodellen och injicerar de öppna värdena för innehållsfragmentet i [URL-uttryck](#url-expressions).

![Knappen Förhandsgranska](./assets/preview/preview-button.png)

Utför en uppdatering (rensning av webbläsarens lokala cache) när du förhandsgranskar ändringar i innehållsfragment i appen.

## Reaktionsexempel

Låt oss utforska WKND-appen, en enkel React-applikation som visar äventyren från AEM med AEM Headless GraphQL API:er.

Exempelkoden finns på [Github.com](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/preview-tutorial).

## URL:er och vägar

De URL:er eller vägar som används för att förhandsgranska ett innehållsfragment måste vara sammansatta med hjälp av [URL-uttryck](#url-expressions). I den här förhandsgranskningsaktiverade versionen av WKND-appen visas äventyrens innehållsfragment via `AdventureDetail` komponent bunden till flödet `/adventure<CONTENT FRAGMENT PATH>`. Därför måste WKND Adventure-modellens preview URL anges till `https://preview.app.wknd.site:3000/adventure${contentFragment.path}` för att matcha den här vägen.

Förhandsgranskning av innehållsfragment fungerar bara om appen har en adresserbar väg som kan fyllas med [URL-uttryck](#url-expressions) som återger det innehållsfragmentet i appen på ett sätt som kan förhandsgranskas.

+ `src/App.js`

```javascript
...
function App() {
  return (
    <Router>
      <div className="App">
        <header>
            <Link to={"/"}>
                <img src={logo} className="logo" alt="WKND Logo"/>
            </Link>        
            <hr />
        </header>
        <Routes>
          {/* The route's path must match the Adventure Model's Preview URL expression. In React since the path has `/` you must use wildcards to match instead of the usual `:path` */}
          <Route path='/adventure/*' element={<AdventureDetail />}/>
          <Route path="/" element={<Home />}/>
        </Routes>
      </div>
    </Router>
  );
}

export default App;
```

### Visa det redigerade innehållet

The `AdventureDetail` analyserar bara sökvägen för innehållsfragment, som matas in i URL:en för förhandsgranskning via `${contentFragment.path}` [URL-uttryck](#url-expressions), från rutten-URL:en, och använder den för att samla in och återge WKND-äventyret.

+ `src/components/AdventureDetail.js`

```javascript
...
function AdventureDetail() {

    // Read the `path` value which is the parameter used to query for the adventure's details
    // since the params value captures the `*` wildcard in `/adventure/*`, or everything after the first `/` in the Content Fragment path.
    const params = useParams();
    const pathParam = params["*"];

    // Add the leading '/' back on 
    const path = '/' + pathParam;
    
    // Query AEM for the Adventures's details, using the Content Fragment's `path`
    const { adventure, references, error } = useAdventureByPath(path);

    // Handle error and loading conditions
    if (error) {
        return <Error errorMessage={error} />;
    } else if (!adventure) {
        return <Loading />;
    }

    return (<div className="adventure-detail">
        ...
        <AdventureDetailRender {...adventure} references={references} />
    </div>);
}
...
```
