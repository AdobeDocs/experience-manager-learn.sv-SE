---
title: Integrera AEM Headless och Target
description: Lär dig integrera AEM Headless och Adobe Target för att personalisera headless-upplevelser med Experience Platform Web SDK.
version: Cloud Service
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
duration: 1644
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1618'
ht-degree: 0%

---

# Integrera AEM Headless och Target

Lär dig integrera AEM Headless med Adobe Target genom att exportera AEM Content Fragments till Adobe Target och använda dem för att personalisera headless-upplevelser med Adobe Experience Platform Web SDK:s alloy.js. The [Reagera WKND-app](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/how-to/example-apps/react-app.html) används för att utforska hur en anpassad Target-aktivitet med Content Fragments Offers kan läggas till i upplevelsen för att marknadsföra ett WKND-äventyr.

>[!VIDEO](https://video.tv.adobe.com/v/3416585/?quality=12&learn=on)

Självstudiekursen beskriver de steg som krävs för att konfigurera AEM och Adobe Target:

1. [Skapa Adobe IMS-konfiguration för Adobe Target](#adobe-ims-configuration) i AEM
2. [Skapa Adobe Target-Cloud Service](#adobe-target-cloud-service) i AEM
3. [Använd Adobe Target-Cloud Service på AEM Assets-mappar](#configure-asset-folders) i AEM
4. [Behörighet för Adobe Target-Cloud Servicen](#permission) i ADOBE ADMIN CONSOLE
5. [Exportera innehållsfragment](#export-content-fragments) från AEM författare till mål
6. [Skapa en aktivitet med hjälp av erbjudanden för innehållsfragment](#activity) i ADOBE TARGET
7. [Skapa ett Experience Platform-datastream](#datastream-id) i EXPERIENCE PLATFORM
8. [Integrera personalisering i en React-baserad AEM Headless-app](#code) med Adobe Web SDK.

## Adobe IMS-konfiguration{#adobe-ims-configuration}

En Adobe IMS-konfiguration som underlättar autentiseringen mellan AEM och Adobe Target.

Granska [dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integration-adobe-target-ims.html) steg-för-steg-instruktioner för hur du skapar en Adobe IMS-konfiguration.

>[!VIDEO](https://video.tv.adobe.com/v/3416495/?quality=12&learn=on)

## Adobe Target Cloud Service{#adobe-target-cloud-service}

En Adobe Target-Cloud Service skapas i AEM för att underlätta export av innehållsfragment till Adobe Target.

Granska [dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-target.html) om du vill ha stegvisa instruktioner om hur du skapar en Adobe Target-Cloud Service.

>[!VIDEO](https://video.tv.adobe.com/v/3416499/?quality=12&learn=on)


## Konfigurera resursmappar{#configure-asset-folders}

Adobe Target-Cloud Servicen, som konfigureras i en kontextmedveten konfiguration, måste tillämpas på AEM Assets-mapphierarkin som innehåller de innehållsfragment som ska exporteras till Adobe Target.

+++Expandera för steg-för-steg-instruktioner

1. Logga in på __AEM Author Service__ som DAM-administratör
1. Navigera till __Assets > Files__, leta reda på resursmappen som har `/conf` använt på
1. Markera resursmappen och välj __Egenskaper__ i det övre åtgärdsfältet
1. Välj __Cloud Service__ tab
1. Kontrollera att molnkonfigurationen är inställd på den kontextmedvetna konfigurationen (`/conf`) som innehåller konfigurationen för Adobe Target-Cloud Service.
1. Välj __Adobe Target__ från __Cloud Service Configurations__ nedrullningsbar meny.
1. Välj __Spara och stäng__ längst upp till höger

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416504/?quality=12&learn=on)

## Behörighet för integrering av AEM Target{#permission}

Integrationen med Adobe Target, som visas som ett developer.adobe.com-projekt, måste beviljas __Redigerare__ produktroll i Adobe Admin Console för att exportera innehållsfragment till Adobe Target.

+++Expandera för steg-för-steg-instruktioner

1. Logga in på Experience Cloud som användare som kan administrera Adobe Target-produkten i Adobe Admin Console
1. Öppna [Adobe Admin Console](https://adminconsole.adobe.com)
1. Välj __Produkter__ öppna __Adobe Target__
1. På __Produktprofiler__ flik, välja __*DefaultWorkspace*__
1. Välj __API-autentiseringsuppgifter__ tab
1. Leta reda på din developer.adobe.com i den här listan och ange dess __Produktroll__ till __Redigerare__

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416505/?quality=12&learn=on)

## Exportera innehållsfragment till mål{#export-content-fragments}

Innehållsfragment som finns under [konfigurerad AEM Assets-mapphierarki](#apply-adobe-target-cloud-service-to-aem-assets-folders) kan exporteras till Adobe Target som Content Fragment Offers. Dessa Content Fragment Offers, en speciell form av JSON-erbjudanden i Target, kan användas i Target-aktiviteter för att leverera personaliserade upplevelser i headless-appar.

+++Expandera för steg-för-steg-instruktioner

1. Logga in på __AEM__ som DAM-användare
1. Navigera till __Assets > Files__ och leta upp de innehållsfragment som ska exporteras som JSON till Target i mappen&quot;Adobe Target enabled&quot;
1. Markera de innehållsfragment som ska exporteras till Adobe Target
1. Välj __Exportera till Adobe Target__ i det övre åtgärdsfältet
   + Den här åtgärden exporterar den fullständigt hydrerade JSON-representationen av Content Fragment till Adobe Target som ett&quot;Content Fragment Offer&quot;
   + Den fullständigt hydrerade JSON-representationen kan granskas i AEM
      + Markera innehållsavsnittet
      + Expandera sidopanelen
      + Välj __Förhandsgranska__ ikonen i den vänstra panelen
      + JSON-representationen som exporteras till Adobe Target visas i huvudvyn
1. Logga in på [Adobe Experience Cloud](https://experience.adobe.com) med en användare i redigeringsrollen för Adobe Target
1. Från [Experience Cloud](https://experience.adobe.com), markera __Mål__ från produktväljaren uppe till höger för att öppna Adobe Target.
1. Kontrollera att standardarbetsytan är markerad i __Arbetsyteväxlare__ längst upp till höger.
1. Välj __Erbjudanden__ i den övre navigeringen
1. Välj __Typ__ listruta och markera __Innehållsfragment__
1. Kontrollera att det innehållsfragment som exporteras från AEM visas i listan
   + Hovra över erbjudandet och välj __Visa__ knapp
   + Granska __Erbjudandeinformation__ och se __AEM djuplänk__ som öppnar innehållsfragment direkt i AEM författartjänst

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416506/?quality=12&learn=on)

## Målaktivitet med Content Fragment Offers{#activity}

I Adobe Target kan en aktivitet skapas som använder Content Fragment Offer JSON som innehåll, vilket ger personaliserade upplevelser i headless-appar med innehåll som skapas och hanteras i AEM.

I det här exemplet använder vi en enkel A/B-aktivitet, men alla Target-aktiviteter kan användas.

+++Expandera för steg-för-steg-instruktioner

1. Välj __Verksamhet__ i den övre navigeringen
1. Välj __+ Skapa aktivitet__ och välj sedan den typ av aktivitet som ska skapas.
   + I det här exemplet skapas en enkel __A/B-test__ men Content Fragment Offers kan användas för alla aktivitetstyper
1. I __Skapa aktivitet__ guide
   + Välj __Webb__
   + I __Välj Experience Composer__, markera __Formulär__
   + I __Välj arbetsyta__, markera __Standardarbetsyta__
   + I __Välj egenskap__ markerar du den egenskap som aktiviteten är tillgänglig i, eller väljer __Inga egenskapsbegränsningar__ för att den ska kunna användas i alla egenskaper.
   + Välj __Nästa__ för att skapa aktiviteten
1. Byt namn på aktiviteten genom att välja __byt namn__ längst upp till vänster
   + Ge aktiviteten ett beskrivande namn
1. I den inledande upplevelsen anger du __Plats 1__ för aktiviteten att rikta sig till
   + I det här exemplet anger du en anpassad plats med namnet `wknd-adventure-promo`
1. Under __Innehåll__ markera standardinnehållet och markera __Ändra innehållsfragment__
1. Välj det exporterade innehållsfragment som ska användas för den här upplevelsen och välj __Klar__
1. Granska JSON-erbjudandet för innehållsfragment i textområdet Innehåll. Det är samma JSON som finns i AEM Author-tjänsten via funktionen Förhandsgranska för innehållsfragment.
1. Lägg till en upplevelse i den vänstra listen och välj ett annat erbjudande om innehållsfragment som ska användas
1. Välj __Nästa__ och konfigurera målreglerna efter behov för aktiviteten
   + I det här exemplet lämnar du A/B-testningen som en manuell delning på 50/50.
1. Välj __Nästa__ och slutföra aktivitetsinställningarna
1. Välj __Spara och stäng__ och ge den ett beskrivande namn
1. I Aktivitet i Adobe Target väljer du __Aktivera__ i listrutan Inaktiv/Aktivera/Arkiv i det övre högra hörnet.

Den Adobe Target-aktivitet som riktar sig till `wknd-adventure-promo` plats kan nu integreras och visas i en AEM Headless-app.

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416507/?quality=12&learn=on)

## Experience Platform DataStream ID{#datastream-id}

An [Adobe Experience Platform Datastream](https://experienceleague.adobe.com/docs/platform-learn/implement-web-sdk/initial-configuration/configure-datastream.html) ID krävs för att AEM Headless-appar ska kunna interagera med Adobe Target med [Adobe Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/fundamentals/configuring-the-sdk.html).

+++Expandera för steg-för-steg-instruktioner

1. Navigera till [Adobe Experience Cloud](https://experience.adobe.com/)
1. Öppna __Experience Platform__
1. Välj __Datainsamling > Datastreams__ och markera __Ny datastream__
1. I guiden New DataStream anger du:
   + Namn: `AEM Target integration`
   + Beskrivning: `Datastream used by the Adobe Web SDK to serve personalized Content Fragments Offers.`
   + Händelseschema: `Leave blank`
1. Välj __Spara__
1. Välj __Lägg till tjänst__
1. I __Tjänst__ välj __Adobe Target__
   + Aktiverad: __Ja__
   + Egenskapstoken: __Lämna tomt__
   + Målmiljö-ID: __Lämna tomt__
      + Målmiljön kan ställas in i Adobe Target på __Administration > Värdar__.
   + Tredjeparts-ID-namnområde för mål: __Lämna tomt__
1. Välj __Spara__
1. Till höger kopierar du __Dataström-ID__ för användning i [Adobe Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/fundamentals/configuring-the-sdk.html) konfigurationsanrop.

+++

<br/>

>[!VIDEO](https://video.tv.adobe.com/v/3416500/?quality=12&learn=on)

## Lägg till personalisering i en AEM Headless-app{#code}

I den här självstudiekursen utforskas hur du personaliserar en enkel React-app med Content Fragment-erbjudanden i Adobe Target via [Adobe Experience Platform Web SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/home.html). Den här metoden kan användas för att personalisera alla JavaScript-baserade webbupplevelser.

Mobilupplevelserna i Android™ och iOS kan personaliseras enligt liknande mönster med [Adobe Mobile SDK](https://developer.adobe.com/client-sdks/documentation/).

### Förutsättningar

+ Node.js 14
+ Git
+ [WKND delad 2.1.4+](https://github.com/adobe/aem-guides-wknd-shared/releases/latest) installeras på AEM som molnförfattare och publiceringstjänster

### Konfigurera

1. Hämta källkoden för exempelappen React från [Github.com](https://github.com/adobe/aem-guides-wknd-graphql)

   ```shell
   $ mkdir -p ~/Code
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna kodbasen på `~/Code/aem-guides-wknd-graphql/personalization-tutorial` i din favoritutvecklingsmiljö
1. Uppdatera värddatorn för AEM som du vill att programmet ska ansluta till `~/Code/aem-guides-wknd-graphql/personalization-tutorial/src/.env.development`

   ```
   ...
   REACT_APP_HOST_URI=https://publish-p1234-e5678.adobeaemcloud.com/
   ...
   ```

1. Kör programmet och kontrollera att det är anslutet till den konfigurerade AEM. Kör från kommandoraden:

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

   + `edgeConfigId` som är [Dataström-ID](#datastream-id)
   + `orgId` AEM as a Cloud Service/Target Adobe-organisations-ID som finns på __Experience Cloud > Profil > Kontoinformation > Aktuellt Org-ID__

   När du anropar Web SDK är Adobe Target aktivitetsplats (i vårt exempel: `wknd-adventure-promo`) måste anges som värdet i `decisionScopes` array.

   ```javascript
   import { createInstance } from "@adobe/alloy";
   const alloy = createInstance({ name: "alloy" });
   ...
   alloy("config", { ... });
   alloy("sendEvent", { ... });
   ```

### Implementering

1. Skapa en React-komponent `AdobeTargetActivity.js` för att ta del av Adobe Target verksamhet.

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

1. Skapa en React-komponent `AdventurePromo.js` för att återge äventyret med JSON Adobe Target.

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

1. Lägg till AdobeTargetActivity-komponenten i React-appens `Home.js` ovanför listan över äventyr.

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

1. Om React-appen inte körs kan du börja använda igen `npm run start`.

   Öppna appen React i två olika webbläsare så att A/B-testet kan leverera de olika upplevelserna till olika webbläsare. Om båda webbläsarna visar samma äventyr kan du prova att stänga/öppna en av webbläsarna igen tills den andra visas.

   Bilden nedan visar två olika Content Fragment-erbjudanden för `wknd-adventure-promo` Aktivitet som bygger på Adobe Target logik.

   ![Upplevelserbjudanden](./assets/target/offers-in-app.png)

## Grattis!

Nu när vi har konfigurerat AEM as a Cloud Service att exportera innehållsfragment till Adobe Target, använde vi Content Fragments i en Adobe Target Activity och hittade den aktiviteten i en AEM Headless-app för att personalisera upplevelsen.
