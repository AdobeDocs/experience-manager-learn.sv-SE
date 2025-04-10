---
title: AEM Headless snabbinstallation av AEM as a Cloud Service
description: Med snabbinstallationen AEM Headless får du tillgång till AEM Headless med hjälp av innehåll från exempelprojektet WKND Site, och en React App som förbrukar materialet via AEM Headless GraphQL API:er.
version: Experience Manager as a Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-9442
thumbnail: 339073.jpg
exl-id: 62e807b7-b1a4-4344-9b1e-2c626b869e10
duration: 781
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1078'
ht-degree: 0%

---

# AEM Headless snabbinstallation av AEM as a Cloud Service

Med snabbinstallationen AEM Headless får du tillgång till AEM Headless med hjälp av innehåll från exempelprojektet WKND Site, och ett exempel på en React App (SPA) som förbrukar innehållet i AEM Headless GraphQL API:er.

## Förutsättningar

Följande krävs för att följa den här snabbinstallationen:

+ AEM as a Cloud Service sandlådemiljö (helst Utveckling)
+ Tillgång till AEM as a Cloud Service och Cloud Manager
   + __AEM Administrator__ åtkomst till AEM as a Cloud Service
   + __Cloud Manager - Deployment Manager__ åtkomst till Cloud Manager
+ Följande verktyg måste installeras lokalt:
   + [Node.js v18](https://nodejs.org/en/)
   + [Git](https://git-scm.com/)
   + En IDE (till exempel [Microsoft® Visual Studio Code](https://code.visualstudio.com/))

## 1. Skapa en Cloud Manager Git-databas

Skapa först en Cloud Manager Git-databas som används för att distribuera WKND-webbplatsen. WKND-webbplatsen är ett exempel på ett AEM-webbplatsprojekt som innehåller innehåll (innehållsfragment) och en GraphQL AEM-slutpunkt som används av snabbinstallationsprogrammets React App (React App).

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339073?quality=12&learn=on)

1. Navigera till [https://my.cloudmanager.adobe.com](https://my.cloudmanager.adobe.com)
1. Välj den __Program__ för Cloud Manager som innehåller den AEM as a Cloud Service-miljö som ska användas för den här snabbinstallationen
1. Skapa en Git-databas för WKND-webbplatsprojektet
   1. Välj __Databaser__ i den övre navigeringen
   1. Välj __Lägg till databas__ i det övre åtgärdsfältet
   1. Namnge den nya Git-databasen: `aem-headless-quick-setup-wknd`
      + Git-databasnamn måste vara unika för varje Adobe-organisation,
   1. Välj __Spara__ och vänta tills Git-databasen initieras

## 2. Push sample WKND Site project to Cloud Manager Git Repository

När Cloud Manager Git-databasen har skapats klonar du WKND Site-projektets källkod från GitHub och skickar den till Cloud Manager Git-databasen. Nu kan Cloud Manager komma åt och driftsätta WKND Site-projektet i AEM as a Cloud Service.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339074?quality=12&learn=on)

1. Klona WKND-webbplatsprojektets källkod från GitHub från kommandoraden

   ```shell
   $ mkdir -p ~/Code
   $ cd ~/Code
   $ git clone git@github.com:adobe/aem-guides-wknd.git
   ```

1. Lägg till Cloud Manager Git-databasen som en fjärrserver
   1. Välj __Databaser__ i den övre navigeringen
   1. Välj __Åtkomst till replikinformation__ i det övre åtgärdsfältet
   1. Kommandot Kör hittades i __Lägg till en fjärranslutning till Git-databasen__ från kommandoraden

      ```shell
      $ cd aem-guides-wknd
      $ git remote add adobe https://git.cloudmanager.adobe.com/<YOUR ADOBE ORGANIZATION>/aem-headless-quick-setup-wknd/
      ```

1. Överför exempelprojektets källkod från din lokala Git-databas till Cloud Manager Git-databasen

   ```shell
   $ git push adobe main:main
   ```

   Ange __användarnamn__ och __lösenord__ från Cloud Manager __databasinformation__ när du uppmanas att ange autentiseringsuppgifter.

## 3. Distribuera WKND-webbplatsen till AEM as a Cloud Service

När WKND Site-projektet skickas till Cloud Manager Git-databasen kan det inte distribueras till AEM as a Cloud Service med Cloud Manager-pipelines.

Tänk på att WKND Site-projektet innehåller exempelinnehåll som React-appen förbrukar jämfört med AEM Headless GraphQL API:er.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339075?quality=12&learn=on)

1. Bifoga en __icke-produktionsdistributionspipeline__ till den nya Git-databasen
   1. Välj __Förgreningar__ i den övre navigeringen
   1. Välj __Lägg till pipeline__ i det övre åtgärdsfältet
   1. På fliken __Konfiguration__
      1. Välj alternativet __Distributionspipeline__
      1. Ange __icke-produktionsförloppsnamnet__ till `Dev Deployment pipeline`
      1. Välj __Distributionsutlösare > Vid Git-ändringar__
      1. Välj __Beteende vid viktiga mätfel > Fortsätt omedelbart__
      1. Välj __Fortsätt__
   1. På fliken __Source Code__
      1. Välj alternativet __Fullständig stackkod__
      1. Välj __AEM as a Cloud Service-utvecklingsmiljö__ i rutan __Berättigade distributionsmiljöer__
      1. Välj `aem-headless-quick-setup-wknd` i valrutan __Databas__
      1. Välj `main` i __Git-grenen__
      1. Välj __Spara__
1. Kör __Dev Deployment Pipeline__
   1. Markera __Översikt__ i den övre navigeringen
   1. Leta reda på den nyskapade __Dev Deployment-pipelinen__ i avsnittet __Pipelines__
   1. Välj __..__ till höger om pipeline-posten
   1. Välj __Kör__ och bekräfta i den modala
   1. Välj __..__ till höger om den pipeline som nu körs
   1. Välj __Visa information__
1. Övervaka förloppet tills det har slutförts utifrån information om pipelinekörningen. Körning av pipeline bör ta mellan 30 och 40 minuter.

## 4. Ladda ned och kör appen WKND React

När AEM as a Cloud Service har startat med innehållet från WKND Site-projektet hämtar och startar du exempelappen WKND React som använder WKND Site-innehållet via AEM Headless GraphQL API:er.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339076?quality=12&learn=on)

1. Från kommandoraden klonar du React Apps källkod från GitHub.

   ```shell
   $ cd ~/Code
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna mappen `~/Code/aem-guides-wknd-graphql/react-app` i din IDE.
1. Öppna filen `.env.development` i IDE.
1. Peka på AEM as a Cloud Service __Publish__-tjänstens värd-URI från egenskapen `REACT_APP_HOST_URI`.

   ```plain
   REACT_APP_HOST_URI=https://publish-pXXXX-eYYYY.adobeaemcloud.com
   ...
   ```

   Så här hittar du AEM as a Cloud Service Publish-tjänstens värd-URI:

   1. I Cloud Manager väljer du __Miljö__ i den översta navigeringen
   1. Välj __Utvecklingsmiljö__
   1. Leta reda på tabellen __Publiceringstjänst (AEM &amp; Dispatcher)__ link __Miljösegment__
   1. Kopiera länkens adress och använd den som URI för AEM as a Cloud Service Publish-tjänsten

1. I IDE sparar du ändringarna i `.env.development`
1. Kör React App från kommandoraden

   ```shell
   $ cd ~/Code/aem-guides-wknd-graphql/react-app
   $ npm install
   $ npm start
   ```

1. React-appen, som körs lokalt, börjar [http://localhost:3000](http://localhost:3000) och visar en lista över äventyren som kommer från AEM as a Cloud Service med AEM Headless GraphQL API:er.

## 5. Redigera innehåll i AEM

Med exempelappen WKND React App som ansluter till och förbrukar innehåll från AEM Headless GraphQL API:er kan du skapa innehåll i tjänsten AEM Author och se hur upplevelsen av React App uppdateras i samförstånd.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339077?quality=12&learn=on)

1. Logga in på tjänsten AEM as a Cloud Service Author
1. Navigera till __Assets > Filer > WKND Delad > Engelska > Tillägg__
1. Öppna mappen __Cycling Southern Utah__
1. Markera innehållsavsnittet __Cycling Southern Utah__ och välj __Redigera__ i det övre åtgärdsfältet
1. Uppdatera vissa fält i innehållsfragmentet, till exempel:
   + Titel: `Cycling Utah's National Parks`
   + Reselängd: `6 Days`
   + Svårighet: `Intermediate`
   + Pris: `3500`
   + Primär bild: `/content/dam/wknd-shared/en/activities/cycling/mountain-biking.jpg`
1. Välj __Spara__ i det övre åtgärdsfältet
1. Välj __Snabbpublicering__ i det övre åtgärdsfältets __..__
1. Uppdatera React App som körs [http://localhost:3000](http://localhost:3000).
1. I React App (Reagera app) markerar du det nu uppdaterade Cycling-äventyret och verifierar innehållsändringarna i Content Fragment.

1. På samma sätt som i tjänsten AEM Author:
   1. Avpublicera ett befintligt Adventure-innehållsfragment och verifiera att det har tagits bort från upplevelsen React App
   1. Skapa och publicera ett nytt Adventure Content Fragment och verifiera att det visas i React App Experience

   >[!TIP]
   >
   > Om du inte är bekant med att skapa och publicera nya eller att avpublicera befintliga innehållsfragment tittar du på skärmbilden ovan.

## Grattis!

Grattis! Du har använt AEM Headless för att driva en React App!

Om du vill veta mer om hur React App konsumerar innehåll från AEM as a Cloud Service kan du titta på [den kostnadsfria självstudiekursen för AEM](../multi-step/overview.md). I självstudiekursen utforskas hur innehållsfragment i AEM har skapats och hur denna React App använder sitt innehåll som JSON.

### Nästa steg

+ [Starta självstudiekursen AEM Headless](../multi-step/overview.md)
