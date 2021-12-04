---
title: AEM Headless quick setup for AEM as a Cloud Service
description: Med snabbinstallationen AEM Headless får du tillgång till AEM Headless med innehåll från exempelprojektet WKND Site och en React App som förbrukar innehållet AEM Headless GraphQL API:er.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
kt: 9442
thumbnail: 339073.jpg
source-git-commit: 0dae6243f2a30147bed7079ad06144ad35b781d8
workflow-type: tm+mt
source-wordcount: '1075'
ht-degree: 0%

---


# AEM Headless-konfiguration för AEM as a Cloud Service

Med snabbinstallationen AEM Headless får du tillgång till AEM Headless med innehåll från exempelprojektet WKND Site, och ett exempel på React App (SPA) som förbrukar innehållet framför Headless GraphQL API:er.

## Förutsättningar

Följande krävs för att följa den här snabbinstallationen:

+ AEM as a Cloud Service sandlådemiljö (helst Development)
+ Åtkomst till AEM as a Cloud Service och Cloud Manager
   + `AEM Administrator` åtkomst till AEM as a Cloud Service
   + `Cloud Manager - Deployment Manager` åtkomst till Cloud Manager
+ Följande verktyg måste installeras lokalt:
   + [Node.js v10+](https://nodejs.org/en/)
   + [npm 6+](https://www.npmjs.com/)
   + [Git](https://git-scm.com/)
   + En IDE (till exempel [Microsoft® Visual Studio Code](https://code.visualstudio.com/)

## 1. Skapa en Cloud Manager Git-databas

Skapa först en Cloud Manager Git-databas som används för att distribuera WKND-webbplatsen. WKND-platsen är ett exempel AEM ett webbplatsprojekt som innehåller innehåll (innehållsfragment) och en GraphQL-AEM som används av snabbinställningens React App.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339073/?quality=12&learn=on)

1. Navigate to [https://my.cloudmanager.adobe.com](https://my.cloudmanager.adobe.com)
1. Välj Cloud Manager __Program__ som innehåller den AEM as a Cloud Service miljön som ska användas för den här snabbinstallationen
1. Skapa en Git-databas för WKND-webbplatsprojektet
   1. Välj __Databaser__ i den övre navigeringen
   1. Välj __Lägg till databas__ i det övre åtgärdsfältet
   1. Namnge den nya Git-databasen: `aem-headless-quick-setup`
   1. Välj __Spara__ och vänta på att Git-databasen ska initieras

## 2. Push sample WKND Site project to Cloud Manager Git Repository

När Cloud Manager Git-databasen har skapats klonar du WKND-webbplatsens källkod från GitHub och skickar den till Cloud Manager Git-databasen. Nu kan Cloud Manager komma åt och driftsätta WKND Site-projektet i den AEM as a Cloud Service miljön.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339074/?quality=12&learn=on)

1. From the command line, clone the sample WKND Site project&#39;s source code from GitHub

   ```shell
   $ mkdir -p ~/Code
   $ cd ~/Code
   $ git clone git@github.com:adobe/aem-guides-wknd.git
   ```

1. Lägg till Cloud Manager Git-databasen som en fjärrserver
   1. Välj __Databaser__ i den övre navigeringen
   1. Välj __Åtkomst till svarsinformation__ i det övre åtgärdsfältet
   1. Kör kommando hittades i __Lägg till en fjärranslutning till din Git-databas__ från kommandoraden

      ```shell
      $ cd aem-guides-wknd
      $ git remote add adobe https://git.cloudmanager.adobe.com/<YOUR ADOBE ORGANIZATION>/aem-headless-quick-setup/
      ```

1. Skicka exempelprojektets källkod till Cloud Manager Git-databasen

   1. Skicka koden från din lokala Git-databas till Cloud Manager Git-databasen

      ```shell
      $ git push adobe master:main
      ```

      När du uppmanas att ange autentiseringsuppgifter anger du __Användarnamn__ och __Lösenord__ från Cloud Managers __Databasinformation__ modal.

## 3. Distribuera WKND-webbplatsen till AEM as a Cloud Service

Med WKND-webbplatsprojektet överfört till Cloud Manager Git-databasen kan det inte distribueras till AEM as a Cloud Service med hjälp av Cloud Manager-pipelines.

Tänk på att WKND Site-projektet innehåller exempelinnehåll som React-appen förbrukar AEM Headless GraphQL API:er.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339075/?quality=12&learn=on)

1. Bifoga en __Distributionsförlopp som inte är i produktion__ till den nya Git-databasen
   1. Välj __Pipelines__ i den övre navigeringen
   1. Select __Add Pipeline__ from the top action bar
   1. På __Konfiguration__ tab
      1. Välj __Distributionsförlopp__ option
      1. Set the __Non-Production Pipeline Name__ to `Dev Deployment pipeline`
      1. Select __Deployment Trigger > On Git Changes__
      1. Välj __Beteende vid viktiga måttfel > Fortsätt omedelbart__
      1. Select __Continue__
   1. På __Källkod__ tab
      1. Select __Full Stack Code__ option
      1. Select the __AEM as a Cloud Service development environment__ from the __Eligible Deployment Environments__ select box
      1. Välj `aem-headless-quick-setup` i __Databas__ välj ruta
      1. Välj `main` från __Git-gren__ välj ruta
      1. Välj __Spara__
1. Kör __Utveckla distributionskanal__
   1. Välj __Översikt__ i den övre navigeringen
   1. Leta reda på den nyskapade __Utveckla distributionsförlopp__ i __Pipelines__ section
   1. Välj __...__ till höger om pipeline-posten
   1. Välj __Kör__ och bekräfta i modala
   1. Välj __...__ till höger om den nu pågående pipeline
   1. Select __View details__
1. Övervaka förloppet tills det har slutförts utifrån information om pipelinekörningen. Körning av pipeline bör ta mellan 45 och 60 minuter.

## 4. Ladda ned och kör appen WKND React

När AEM as a Cloud Service har startats med innehållet från WKND Site-projektet hämtar och startar du exempelappen WKND React som använder WKND Site-innehållet i AEM Headless GraphQL API:er.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339076/?quality=12&learn=on)

1. Från kommandoraden klonar du React Apps källkod från GitHub.

   ```shell
   $ cd ~/Code
   $ git clone --branch tutorial/react git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna mappen `~/Code/aem-guides-wknd-graphql` i din utvecklingsmiljö.
1. Öppna filen i IDE `react-app/.env.development`.
1. Peka på AEM as a Cloud Service __Publicera__ tjänstens värd-URI från  `REACT_APP_HOST_URI` -egenskap.

   ```plain
   REACT_APP_HOST_URI=https://publish-pXXXX-eYYYY.adobeaemcloud.com/
   ...
   ```

   Så här hittar du AEM as a Cloud Service Publish-tjänstens värd-URI:

   1. I Cloud Manager väljer du __Miljö__ i den övre navigeringen
   1. Välj __Utveckling__ miljö
   1. Leta reda på __Publiceringstjänst (AEM &amp; Dispatcher)__ link __Miljösegment__ table
   1. Kopiera länkens adress och använd den som den AEM as a Cloud Service publiceringstjänstens URI

1. I IDE sparar du ändringarna i `.env.development`
1. Kör React App från kommandoraden

   ```shell
   $ cd ~/Code/aem-guides-wknd-graphql/react-app
   $ npm install
   $ npm start
   ```

1. The React App, running locally, starts on [http://localhost:3000](http://localhost:3000) and displays a listing of adventures, which are sourced from AEM as a Cloud Service using AEM Headless&#39; GraphQL APIs.

## 5. Redigera innehåll i AEM

Med exempelappen WKND React App som ansluter till och förbrukar innehåll från de AEM Headless GraphQL API:erna kan du skapa innehåll i AEM Author-tjänsten och se hur React Apps upplevelse uppdateras i samförstånd.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339077/?quality=12&learn=on)

1. Logga in på AEM as a Cloud Service Author Service
1. Navigera till __Assets > Files > WKND > English > Adventures__
1. Öppna __Cycling Southern Utah__ Mapp
1. Select the __Cycling Southern Utah__ Content Fragment, and select __Edit__ from the top action bar
1. Update some of the fields of the Content Fragment, for example:
   + Titel: `Cycling Utah's National Parks`
   + Trip Length: `6 Days`
   + Difficulty: `Intermediate`
   + Pris: `$3500`
   + Primär bild: `/content/dam/wknd/en/activities/cycling/mountain-biking.jpg`
1. Välj __Spara__ i det övre åtgärdsfältet
1. Välj __Snabbpublicering__ i det övre åtgärdsfältets __...__
1. Uppdatera React App som körs den [http://localhost:3000](http://localhost:3000).
1. I React App (Reagera app) markerar du den nu uppdaterade versionen och verifierar innehållsändringarna i Content Fragment.

1. Using the same approach, in AEM Author service:
   1. Avpublicera ett befintligt Adventure-innehållsfragment och verifiera att det har tagits bort från upplevelsen React App
   1. Skapa och publicera ett nytt Adventure Content Fragment och verifiera att det visas i React App Experience

   >[!TIP]
   >
   > Om du inte är bekant med att skapa och publicera nya eller att avpublicera befintliga innehållsfragment tittar du på skärmbilden ovan.

## Grattis!

Grattis! You&#39;ve successfully used AEM Headless to power a React App!

Om du vill veta mer om hur React App konsumerar innehåll från AEM as a Cloud Service kan du kolla [den AEM självstudiekursen Headless](../multi-step/overview.md). I självstudiekursen utforskas hur innehållsfragment i AEM har skapats och hur denna React App konsumerar sitt innehåll som JSON.

### Nästa steg

+ [Starta självstudiekursen AEM Headless](../multi-step/overview.md)
