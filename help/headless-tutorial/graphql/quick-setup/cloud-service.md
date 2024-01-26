---
title: AEM Headless-konfiguration för AEM as a Cloud Service
description: Med snabbinstallationen AEM Headless får du tillgång till AEM Headless med innehåll från exempelprojektet WKND Site, och en React App som förbrukar innehållet AEM Headless GraphQL API:er.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-9442
thumbnail: 339073.jpg
exl-id: 62e807b7-b1a4-4344-9b1e-2c626b869e10
duration: 850
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1078'
ht-degree: 0%

---

# AEM Headless-konfiguration för AEM as a Cloud Service

Med snabbinstallationen AEM Headless får du tillgång till AEM Headless med innehåll från exempelprojektet WKND Site, och ett exempel på React App (SPA) som förbrukar innehållet i AEM Headless GraphQL API:er.

## Förutsättningar

Följande krävs för att följa den här snabbinstallationen:

+ AEM as a Cloud Service sandlådemiljö (helst Development)
+ Åtkomst till AEM as a Cloud Service och Cloud Manager
   + __AEM__ åtkomst till AEM as a Cloud Service
   + __Cloud Manager - Distributionshanteraren__ åtkomst till Cloud Manager
+ Följande verktyg måste installeras lokalt:
   + [Node.js v18](https://nodejs.org/en/)
   + [Git](https://git-scm.com/)
   + En IDE (till exempel [Microsoft® Visual Studio Code](https://code.visualstudio.com/))

## 1. Skapa en Cloud Manager Git-databas

Skapa först en Cloud Manager Git-databas som används för att distribuera WKND-webbplatsen. WKND-webbplatsen är ett exempel AEM ett webbplatsprojekt som innehåller innehåll (innehållsfragment) och en GraphQL AEM-slutpunkt som används av snabbinställningens React App (Reagera-app).

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339073?quality=12&learn=on)

1. Navigera till [https://my.cloudmanager.adobe.com](https://my.cloudmanager.adobe.com)
1. Välj Cloud Manager __Program__ som innehåller den AEM as a Cloud Service miljön som ska användas för den här snabbinstallationen
1. Skapa en Git-databas för WKND-webbplatsprojektet
   1. Välj __Databaser__ i den övre navigeringen
   1. Välj __Lägg till databas__ i det övre åtgärdsfältet
   1. Namnge den nya Git-databasen: `aem-headless-quick-setup-wknd`
      + Git-databasnamn måste vara unika per Adobe-organisation,
   1. Välj __Spara__ och vänta på att Git-databasen ska initieras

## 2. Överför exempelprojektet WKND Site till Cloud Manager Git Repository

När Cloud Manager Git-databasen har skapats klonar du WKND-webbplatsens källkod från GitHub och skickar den till Cloud Manager Git-databasen. Nu kan Cloud Manager komma åt och driftsätta WKND Site-projektet i den AEM as a Cloud Service miljön.

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
   1. Välj __Åtkomst till svarsinformation__ i det övre åtgärdsfältet
   1. Kör kommando hittades i __Lägg till en fjärranslutning till din Git-databas__ från kommandoraden

      ```shell
      $ cd aem-guides-wknd
      $ git remote add adobe https://git.cloudmanager.adobe.com/<YOUR ADOBE ORGANIZATION>/aem-headless-quick-setup-wknd/
      ```

1. Överför exempelprojektets källkod från din lokala Git-databas till Cloud Manager Git-databasen

   ```shell
   $ git push adobe main:main
   ```

   När du uppmanas att ange autentiseringsuppgifter anger du __Användarnamn__ och __Lösenord__ från Cloud Managers __Databasinformation__ modal.

## 3. Distribuera WKND-webbplatsen till AEM as a Cloud Service

Med WKND-webbplatsprojektet överfört till Cloud Manager Git-databasen kan det inte distribueras till AEM as a Cloud Service med hjälp av Cloud Manager-pipelines.

Kom ihåg att WKND Site-projektet innehåller exempelinnehåll som React-appen förbrukar AEM Headless GraphQL API:er.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339075?quality=12&learn=on)

1. Bifoga en __Distributionsförlopp som inte är i produktion__ till den nya Git-databasen
   1. Välj __Pipelines__ i den övre navigeringen
   1. Välj __Lägg till pipeline__ i det övre åtgärdsfältet
   1. På __Konfiguration__ tab
      1. Välj __Distributionsförlopp__ option
      1. Ange __Namn på icke-produktionsförlopp__ till `Dev Deployment pipeline`
      1. Välj __Deployment Trigger > On Git Changes__
      1. Välj __Beteende vid viktiga måttfel > Fortsätt omedelbart__
      1. Välj __Fortsätt__
   1. På __Källkod__ tab
      1. Välj __Fullständig stapelkod__ option
      1. Välj __AEM as a Cloud Service utvecklingsmiljö__ från __Berättigade driftsättningsmiljöer__ välj ruta
      1. Välj `aem-headless-quick-setup-wknd` i __Databas__ välj ruta
      1. Välj `main` från __Git-gren__ välj ruta
      1. Välj __Spara__
1. Kör __Utveckla distributionskanal__
   1. Välj __Ökning__ i den övre navigeringen
   1. Leta reda på den nyskapade __Utveckla distributionsförlopp__ i __Pipelines__ section
   1. Välj __...__ till höger om pipeline-posten
   1. Välj __Kör__ och bekräfta i modala
   1. Välj __...__ till höger om den nu pågående pipeline
   1. Välj __Visa detaljer__
1. Övervaka förloppet tills det har slutförts utifrån information om pipelinekörningen. Körning av pipeline bör ta mellan 30 och 40 minuter.

## 4. Ladda ned och kör appen WKND React

När AEM as a Cloud Service har startat med innehållet från WKND Site-projektet hämtar och startar du exempelappen WKND React som använder WKND-webbplatsens innehåll i AEM Headless GraphQL API:er.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339076?quality=12&learn=on)

1. Från kommandoraden klonar du React Apps källkod från GitHub.

   ```shell
   $ cd ~/Code
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna mappen `~/Code/aem-guides-wknd-graphql/react-app` i din utvecklingsmiljö.
1. Öppna filen i IDE `.env.development`.
1. Peka på AEM as a Cloud Service __Publicera__ tjänstens värd-URI från  `REACT_APP_HOST_URI` -egenskap.

   ```plain
   REACT_APP_HOST_URI=https://publish-pXXXX-eYYYY.adobeaemcloud.com
   ...
   ```

   Så här hittar du AEM as a Cloud Service Publish-tjänstens värd-URI:

   1. I Cloud Manager väljer du __Miljö__ i den övre navigeringen
   1. Välj __Utveckling__ miljö
   1. Leta reda på __Publiceringstjänst (AEM &amp; Dispatcher)__ link __Miljösegment__ table
   1. Kopiera länkens adress och använd den som den AEM as a Cloud Service publiceringstjänstens URI

1. Spara ändringarna i IDE `.env.development`
1. Kör React App från kommandoraden

   ```shell
   $ cd ~/Code/aem-guides-wknd-graphql/react-app
   $ npm install
   $ npm start
   ```

1. React-appen som körs lokalt börjar på [http://localhost:3000](http://localhost:3000) och visar en lista med äventyr, som kommer från AEM as a Cloud Service med AEM Headless GraphQL API:er.

## 5. Redigera innehåll i AEM

Med exempelappen WKND React App som ansluter till och förbrukar innehåll från de AEM Headless-API:erna för GraphQL kan du redigera innehåll i AEM Author-tjänsten och se hur React App-upplevelsen uppdateras i samförstånd.

_Genomgång av steg_
>[!VIDEO](https://video.tv.adobe.com/v/339077?quality=12&learn=on)

1. Logga in på AEM as a Cloud Service Author Service
1. Navigera till __Assets > Files > WKND Shared > English > Adventures__
1. Öppna __Cycling Southern Utah__ Mapp
1. Välj __Cycling Southern Utah__ Innehållsfragment och markera __Redigera__ i det övre åtgärdsfältet
1. Uppdatera vissa fält i innehållsfragmentet, till exempel:
   + Titel: `Cycling Utah's National Parks`
   + Resans längd: `6 Days`
   + Svårighet: `Intermediate`
   + Pris: `3500`
   + Primär bild: `/content/dam/wknd-shared/en/activities/cycling/mountain-biking.jpg`
1. Välj __Spara__ i det övre åtgärdsfältet
1. Välj __Snabbpublicering__ i det övre åtgärdsfältets __...__
1. Uppdatera React App som körs den [http://localhost:3000](http://localhost:3000).
1. I React App (Reagera app) markerar du det nu uppdaterade Cycling-äventyret och verifierar innehållsändringarna i Content Fragment.

1. På samma sätt i AEM Author-tjänsten:
   1. Avpublicera ett befintligt Adventure-innehållsfragment och verifiera att det har tagits bort från upplevelsen React App
   1. Skapa och publicera ett nytt Adventure Content Fragment och verifiera att det visas i React App Experience

   >[!TIP]
   >
   > Om du inte är bekant med att skapa och publicera nya eller att avpublicera befintliga innehållsfragment tittar du på skärmbilden ovan.

## Grattis!

Grattis! Du har använt AEM Headless för att driva en React App!

Om du vill veta mer om hur React App konsumerar innehåll från AEM as a Cloud Service kan du kolla [den AEM självstudiekursen Headless](../multi-step/overview.md). I självstudiekursen utforskas hur innehållsfragment i AEM har skapats och hur denna React App konsumerar sitt innehåll som JSON.

### Nästa steg

+ [Starta självstudiekursen AEM Headless](../multi-step/overview.md)
