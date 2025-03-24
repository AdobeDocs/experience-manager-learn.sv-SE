---
title: Integrera AEM Headless och Target
description: Läs om hur du integrerar AEM Headless och Adobe Target för att personalisera headless-upplevelser med Experience Platform Web SDK.
version: Experience Manager as a Cloud Service
feature: Content Fragments, Integrations
topic: Personalization, Headless
role: Admin, Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-05-09T00:00:00Z
jira: KT-12433
thumbnail: KT-12433.jpeg
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Headless as a Cloud Service" before-title="false"
exl-id: be886c64-9b8e-498d-983c-75f32c34be4b
duration: 1549
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1618'
ht-degree: 0%

---

# Integrera AEM Headless och Target

Lär dig integrera AEM Headless med Adobe Target genom att exportera AEM Content Fragments till Adobe Target och använda dem för att personalisera headless-upplevelser med Adobe Experience Platform Web SDK alloy.js. [React WKND-appen](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/how-to/example-apps/react-app.html) används för att utforska hur en anpassad Target-aktivitet med hjälp av Content Fragments Offers kan läggas till i upplevelsen för att marknadsföra ett WKND-äventyr.

>[!VIDEO](https://video.tv.adobe.com/v/3416585/?quality=12&learn=on)

Självstudiekursen beskriver de steg som krävs för att konfigurera AEM och Adobe Target:

1. [Skapa Adobe IMS-konfiguration för Adobe Target](#adobe-ims-configuration) i AEM Author
2. [Skapa Adobe Target Cloud Service](#adobe-target-cloud-service) i AEM Author
3. [Använd Adobe Target Cloud Service på AEM Assets-mappar](#configure-asset-folders) i AEM Author
4. [Behörighet för Adobe Target Cloud Service](#permission) i Adobe Admin Console
5. [Exportera innehållsfragment](#export-content-fragments) från AEM Author till Target
6. [Skapa en aktivitet med Content Fragment-erbjudanden](#activity) i Adobe Target
7. [Skapa en Experience Platform Datastream](#datastream-id) i Experience Platform
8. [Integrera personalisering i en React-baserad AEM Headless-app](#code) med Adobe Web SDK.

## Adobe IMS-konfiguration{#adobe-ims-configuration}

En Adobe IMS-konfiguration som underlättar autentiseringen mellan AEM och Adobe Target.

Granska [dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integration-adobe-target-ims.html) om du vill ha stegvisa instruktioner om hur du skapar en Adobe IMS-konfiguration.

>[!VIDEO](https://video.tv.adobe.com/v/3416495/?quality=12&learn=on)

## Adobe Target Cloud Service{#adobe-target-cloud-service}

En Adobe Target Cloud Service skapas i AEM för att underlätta exporten av innehållsfragment till Adobe Target.

Granska [dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-target.html) om du vill ha stegvisa instruktioner om hur du skapar en Adobe Target Cloud Service.

>[!VIDEO](https://video.tv.adobe.com/v/3416499/?quality=12&learn=on)


## Konfigurera resursmappar{#configure-asset-folders}

Adobe Target Cloud Service, som konfigurerats i en kontextmedveten konfiguration, måste tillämpas på AEM Assets mapphierarki som innehåller de innehållsfragment som ska exporteras till Adobe Target.

+++Expandera för steg-för-steg-instruktioner

1. Logga in på __AEM Author Service__ som DAM-administratör
1. Navigera till __Assets > Filer__ och leta upp resursmappen som `/conf` har tillämpats på
1. Markera resursmappen och välj __Egenskaper__ i det övre åtgärdsfältet
1. Välj fliken __Molntjänster__
1. Kontrollera att molnkonfigurationen är inställd på den kontextmedvetna konfiguration (`/conf`) som innehåller Adobe Target Cloud Services-konfigurationen.
1. Välj __Adobe Target__ i listrutan __Cloud Service Configurations__.
1. Välj __Spara och stäng__ längst upp till höger

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416504/?quality=12&learn=on)

## Behörighet för integrering av AEM Target{#permission}

Adobe Target-integreringen, som visas som ett developer.adobe.com-projekt, måste beviljas produktrollen __Editor__ i Adobe Admin Console för att innehållsfragment ska kunna exporteras till Adobe Target.

+++Expandera för steg-för-steg-instruktioner

1. Logga in på Experience Cloud som användare som kan administrera Adobe Target-produkten i Adobe Admin Console
1. Öppna [Adobe Admin Console](https://adminconsole.adobe.com)
1. Välj __Produkter__ och öppna sedan __Adobe Target__
1. Välj __*DefaultWorkspace*__ på fliken __Produktprofiler__
1. Välj fliken __API-autentiseringsuppgifter__
1. Leta reda på din developer.adobe.com i den här listan och ställ in dess __produktroll__ på __Redigeraren__

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416505/?quality=12&learn=on)

## Exportera innehållsfragment till mål{#export-content-fragments}

Innehållsfragment som finns under den [konfigurerade AEM Assets-mapphierarkin](#apply-adobe-target-cloud-service-to-aem-assets-folders) kan exporteras till Adobe Target som innehållsfragmenterbjudanden. Dessa Content Fragment Offers, en speciell form av JSON-erbjudanden i Target, kan användas i Target-aktiviteter för att leverera personaliserade upplevelser i headless-appar.

+++Expandera för steg-för-steg-instruktioner

1. Logga in på __AEM Author__ som DAM-användare
1. Navigera till __Assets > Filer__ och leta upp Content Fragments som ska exporteras som JSON till Target under mappen&quot;Adobe Target enabled&quot;
1. Markera de innehållsfragment som ska exporteras till Adobe Target
1. Välj __Exportera till Adobe Target-erbjudanden__ i det övre åtgärdsfältet
   + Den här åtgärden exporterar den fullständigt hydrerade JSON-representationen av Content Fragment till Adobe Target som ett&quot;Content Fragment Offer&quot;
   + Den fullständigt hydrerade JSON-representationen kan granskas i AEM
      + Markera innehållsavsnittet
      + Expandera sidopanelen
      + Välj ikonen __Förhandsgranska__ på den vänstra panelen
      + JSON-representationen som exporteras till Adobe Target visas i huvudvyn
1. Logga in på [Adobe Experience Cloud](https://experience.adobe.com) med en användare i redigeringsrollen för Adobe Target
1. I [Experience Cloud](https://experience.adobe.com) väljer du __Mål__ i produktväljaren i det övre högra hörnet för att öppna Adobe Target.
1. Kontrollera att Workspace-standardinställningen är markerad i __Workspace-väljaren__ i det övre högra hörnet.
1. Välj fliken __Erbjudanden__ i den övre navigeringen
1. Markera listrutan __Typ__ och välj __Innehållsfragment__
1. Kontrollera att det innehållsfragment som exporteras från AEM visas i listan
   + Hovra över erbjudandet och välj knappen __Visa__
   + Granska __erbjudandeinformationen__ och se den __djupa AEM-länken__ som öppnar innehållsfragmentet direkt i AEM författartjänst

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416506/?quality=12&learn=on)

## Målaktivitet med Content Fragment Offers{#activity}

I Adobe Target kan en aktivitet skapas som använder Content Fragment Offer JSON som innehåll, vilket ger personaliserade upplevelser i headless-appar med innehåll som skapas och hanteras i AEM.

I det här exemplet använder vi en enkel A/B-aktivitet, men alla Target-aktiviteter kan användas.

+++Expandera för steg-för-steg-instruktioner

1. Välj fliken __Aktiviteter__ i den övre navigeringen
1. Välj __+ Skapa aktivitet__ och välj sedan den typ av aktivitet som ska skapas.
   + I det här exemplet skapas ett enkelt __A/B-test__, men Content Fragment-erbjudanden kan påverka alla aktivitetstyper
1. I guiden __Skapa aktivitet__
   + Välj __Webb__
   + Välj __Formulär__ i __Välj Experience Composer__
   + I __Välj Workspace__ väljer du __Workspace (standard)__
   + I __Välj egenskap__ markerar du den egenskap som aktiviteten är tillgänglig i eller väljer __Inga egenskapsbegränsningar__ för att den ska kunna användas i alla egenskaper.
   + Välj __Nästa__ för att skapa aktiviteten
1. Byt namn på aktiviteten genom att välja __Byt namn__ överst till vänster
   + Ge aktiviteten ett beskrivande namn
1. Ange __Plats 1__ för aktiviteten som mål i den initiala upplevelsen
   + I det här exemplet anger du en anpassad plats med namnet `wknd-adventure-promo` som mål
1. Under __Innehåll__ markerar du standardinnehållet och väljer __Ändra innehållsfragment__
1. Markera det exporterade innehållsfragment som ska användas för den här upplevelsen och välj __Klar__
1. Granska JSON-erbjudandet om innehållsfragment i textområdet Innehåll. Det är samma JSON som finns i AEM Author-tjänsten via funktionen Förhandsgranska i innehållsfragment.
1. Lägg till en upplevelse i den vänstra listen och välj ett annat erbjudande om innehållsfragment som ska användas
1. Välj __Nästa__ och konfigurera målreglerna som krävs för aktiviteten
   + I det här exemplet lämnar du A/B-testningen som en manuell delning på 50/50.
1. Välj __Nästa__ och fyll i aktivitetsinställningarna
1. Välj __Spara och stäng__ och ge den ett beskrivande namn
1. I Aktivitet i Adobe Target väljer du __Aktivera__ i listrutan Inaktiv/Aktivera/arkiv i det övre högra hörnet.

Adobe Target-aktiviteten som riktar sig till platsen `wknd-adventure-promo` kan nu integreras och visas i en AEM Headless-app.

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416507/?quality=12&learn=on)

## Experience Platform Datastream ID{#datastream-id}

Ett [Adobe Experience Platform Datastream](https://experienceleague.adobe.com/docs/platform-learn/implement-web-sdk/initial-configuration/configure-datastream.html)-ID krävs för att AEM Headless-appar ska kunna interagera med Adobe Target med [Adobe Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/fundamentals/configuring-the-sdk.html).

+++Expandera för steg-för-steg-instruktioner

1. Navigera till [Adobe Experience Cloud](https://experience.adobe.com/)
1. Öppna __Experience Platform__
1. Välj __Datasamling > Datastreams__ och välj __Ny datastream__
1. I guiden New DataStream anger du:
   + Namn: `AEM Target integration`
   + Beskrivning: `Datastream used by the Adobe Web SDK to serve personalized Content Fragments Offers.`
   + Händelseschema: `Leave blank`
1. Välj __Spara__
1. Välj __Lägg till tjänst__
1. In __Service__ select __Adobe Target__
   + Aktiverad: __Ja__
   + Egenskapstoken: __Lämna tomt__
   + Målmiljö-ID: __Lämna tomt__
      + Målmiljön kan anges i Adobe Target på __Administration > Värdar__.
   + Tredjeparts-ID-målnamnområde: __Lämna tomt__
1. Välj __Spara__
1. Till höger kopierar du __Datastream ID__ för användning i konfigurationsanropet för [Adobe Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/fundamentals/configuring-the-sdk.html).

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416500/?quality=12&learn=on)

## Lägg till personalisering i en AEM Headless-app{#code}

I den här självstudiekursen utforskas hur du anpassar en enkel React-app med Content Fragment-erbjudanden i Adobe Target via [Adobe Experience Platform Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/home.html). Den här metoden kan användas för att personalisera alla JavaScript-baserade webbupplevelser.

Android™- och iOS-mobilupplevelser kan anpassas efter liknande mönster med [Adobe Mobile SDK](https://developer.adobe.com/client-sdks/documentation/).

### Förutsättningar

+ Node.js 14
+ Git
+ [WKND Shared 2.1.4+](https://github.com/adobe/aem-guides-wknd-shared/releases/latest) har installerats på AEM som molnförfattare och publiceringstjänster

### Konfigurera

1. Hämta källkoden för exempelappen React från [Github.com](https://github.com/adobe/aem-guides-wknd-graphql)

   ```shell
   $ mkdir -p ~/Code
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna kodbasen på `~/Code/aem-guides-wknd-graphql/personalization-tutorial` i din favoritutvecklingsmiljö
1. Uppdatera den värddator för AEM-tjänsten som du vill att appen ska ansluta till `~/Code/aem-guides-wknd-graphql/personalization-tutorial/src/.env.development`

   ```
   ...
   REACT_APP_HOST_URI=https://publish-p1234-e5678.adobeaemcloud.com/
   ...
   ```

1. Kör programmet och kontrollera att det är anslutet till den konfigurerade AEM-tjänsten. Kör från kommandoraden:

   ```shell
   $ cd ~/Code/aem-guides-wknd-graphql/personalization-tutorial
   $ npm install
   $ npm run start
   ```

1. Installera [Adobe Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/fundamentals/installing-the-sdk.html#option-3%3A-using-the-npm-package) som ett NPM-paket.

   ```shell
   $ cd ~/Code/aem-guides-wknd-graphql/personalization-tutorial
   $ npm install @adobe/alloy
   ```

   Web SDK kan användas i kod för att hämta JSON-erbjudandet för innehållsfragment per aktivitetsplats.

   När du konfigurerar Web SDK krävs två ID:

   + `edgeConfigId` som är [DataStream ID](#datastream-id)
   + `orgId` det AEM as a Cloud Service/Target Adobe Org ID som finns på __Experience Cloud > Profil > Kontoinformation > Aktuellt Org ID__

   När du anropar Web SDK måste aktivitetsplatsen för Adobe Target (i vårt exempel `wknd-adventure-promo`) anges som värdet i arrayen `decisionScopes`.

   ```javascript
   import { createInstance } from "@adobe/alloy";
   const alloy = createInstance({ name: "alloy" });
   ...
   alloy("config", { ... });
   alloy("sendEvent", { ... });
   ```

### Implementering

1. Skapa en React-komponent `AdobeTargetActivity.js` för att visa Adobe Target-aktiviteter.

   __src/components/AdobeTargetActivity.js__

   ```javascript
   import React, { useEffect } from 'react';
   import { createInstance } from '@adobe/alloy';
   
   const alloy = createInstance({ name: 'alloy' });
   
   alloy('configure', { 
     'edgeConfigId': 'e3db252d-44d0-4a0b-8901-aac22dbc88dc', // AEP Datastream ID
     'orgId':'7ABB3E6A5A7491460A495D61@AdobeOrg',
     'debugEnabled': true,
   });
   
   export default function AdobeTargetActivity({ activityLocation, OfferComponent }) { 
     const [offer, setOffer] = React.useState();
   
     useEffect(() => {
       async function sendAlloyEvent() {
         // Get the activity offer from Adobe Target
         const result = await alloy('sendEvent', {
           // decisionScopes is set to an array containing the Adobe Target activity location
           'decisionScopes': [activityLocation],
         });
   
         if (result.propositions?.length > 0) {
           // Find the first proposition for the active activity location
           var proposition = result.propositions?.filter((proposition) => { return proposition.scope === activityLocation; })[0];
   
           // Get the Content Fragment Offer JSON from the Adobe Target response
           const contentFragmentOffer = proposition?.items[0]?.data?.content || { status: 'error', message: 'Personalized content unavailable'};
   
           if (contentFragmentOffer?.data) {
             // Content Fragment Offers represent a single Content Fragment, hydrated by
             // the byPath GraphQL query, we must traverse the JSON object to retrieve the 
             // Content Fragment JSON representation
             const byPath = Object.keys(contentFragmentOffer.data)[0];
             const item = contentFragmentOffer.data[byPath]?.item;
   
             if (item) {
               // Set the offer to the React state so it can be rendered
               setOffer(item);
   
               // Record the Content Fragment Offer as displayed for Adobe Target Activity reporting
               // If this request is omitted, the Target Activity's Reports will be blank
               alloy("sendEvent", {
                   xdm: {
                       eventType: "decisioning.propositionDisplay",
                       _experience: {
                           decisioning: {
                               propositions: [proposition]
                           }
                       }
                   }
               });          
             }
           }
         }
       };
   
       sendAlloyEvent();
   
     }, [activityLocation, OfferComponent]);
   
     if (!offer) {
       // Adobe Target offer initializing; we render a blank component (which has a fixed height) to prevent a layout shift
       return (<OfferComponent></OfferComponent>);
     } else if (offer.status === 'error') {
       // If Personalized content could not be retrieved either show nothing, or optionally default content.
       console.error(offer.message);
       return (<></>);
     }
   
     console.log('Activity Location', activityLocation);
     console.log('Content Fragment Offer', offer);
   
     // Render the React component with the offer's JSON
     return (<OfferComponent content={offer} />);
   };
   ```

   Komponenten AdobeTargetActivity React anropas med följande:

   ```jsx
   <AdobeTargetActivity activityLocation={"wknd-adventure-promo"} OfferComponent={AdventurePromo}/>
   ```

1. Skapa en React-komponent `AdventurePromo.js` för att återge äventyret med JSON Adobe Target-servrar.

   Den här React-komponenten tar det fullständigt hydrerade JSON-programmet som representerar ett äventyrligt innehållsfragment och visas på ett kampanjsätt. Reaktionskomponenterna som visar JSON som betjänas från Adobe Target Content Fragment Offers kan vara så varierade och komplexa som krävs baserat på de innehållsfragment som exporteras till Adobe Target.

   __src/components/AdventurePromo.js__

   ```javascript
   import React from 'react';
   
   import './AdventurePromo.scss';
   
   /**
   * @param {*} content is the fully hydrated JSON data for a WKND Adventure Content Fragment
   * @returns the Adventure Promo component
   */
   export default function AdventurePromo({ content }) {
       if (!content) {
           // If content is still loading, then display an empty promote to prevent layout shift when Target loads the data
           return (<div className="adventure-promo"></div>)
       }
   
       const title = content.title;
       const description = content?.description?.plaintext;
       const image = content.primaryImage?._publishUrl;
   
       return (
           <div className="adventure-promo">
               <div className="adventure-promo-text-wrapper">
                   <h3 className="adventure-promo-eyebrow">Promoted adventure</h3>
                   <h2 className="adventure-promo-title">{title}</h2>
                   <p className="adventure-promo-description">{description}</p>
               </div>
               <div className="adventure-promo-image-wrapper">
                   <img className="adventure-promo-image" src={image} alt={title} />
               </div>
           </div>
       )
   }
   ```

   __src/components/AdventurePromo.scss__

   ```css
   .adventure-promo {
       display: flex;
       margin: 3rem 0;
       height: 400px;
   }
   
   .adventure-promo-text-wrapper {
       background-color: #ffea00;
       color: black;
       flex-grow: 1;
       padding: 3rem 2rem;
       width: 55%;
   }
   
   .adventure-promo-eyebrow {
       font-family: Source Sans Pro,Helvetica Neue,Helvetica,Arial,sans-serif;
       font-weight: 700;
       font-size: 1rem;
       margin: 0;
       text-transform: uppercase;
   }
   
   .adventure-promo-description {
       line-height: 1.75rem;
   }
   
   .adventure-promo-image-wrapper {
       height: 400px;
       width: 45%;
   }
   
   .adventure-promo-image {
       height: 100%;
       object-fit: cover;
       object-position: center center;
       width: 100%;
   }
   ```

   Reaktionskomponenten anropas enligt följande:

   ```jsx
   <AdventurePromo adventure={adventureJSON}/>
   ```

1. Lägg till AdobeTargetActivity-komponenten i React-appens `Home.js` ovanför listan med äventyr.

   __src/components/Home.js__

   ```javascript
   import AdventurePromo from './AdventurePromo';
   import AdobeTargetActivity from './AdobeTargetActivity';
   ... 
   export default function Home() {
       ...
       return(
           <div className="Home">
   
             <AdobeTargetActivity activityLocation={"wknd-adventure-promo"} OfferComponent={AdventurePromo}/>
   
             <h2>Current Adventures</h2>
             ...
       )
   }
   ```

1. Om React-appen inte körs kan du börja använda `npm run start` igen.

   Öppna appen React i två olika webbläsare så att A/B-testet kan leverera de olika upplevelserna till olika webbläsare. Om båda webbläsarna visar samma äventyr kan du prova att stänga/öppna en av webbläsarna igen tills den andra visas.

   Bilden nedan visar de två olika Content Fragment-erbjudandena som visas för aktiviteten `wknd-adventure-promo`, baserat på Adobe Target logik.

   ![Upplevelserbjudanden](./assets/target/offers-in-app.png)

## Grattis!

Nu när vi har konfigurerat AEM as a Cloud Service att exportera innehållsfragment till Adobe Target, använde vi Content Fragments i en Adobe Target Activity och hittade den aktiviteten i en AEM Headless-app för att personalisera upplevelsen.
