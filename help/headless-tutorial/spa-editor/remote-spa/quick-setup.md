---
title: Snabbredigeraren SPA fjärrinstallation och SPA
description: Lär dig hur du kommer igång med en SPA och AEM SPA på 15 minuter!
topic: Headless, SPA, Development
feature: SPA, kärnkomponenter, API:er, utveckling
role: Developer, Architect
level: Beginner
kt: 7629
thumbnail: kt-7629.jpeg
translation-type: tm+mt
source-git-commit: b6f63110f14ede51fa2dd740aea7cbb623cbec60
workflow-type: tm+mt
source-wordcount: '729'
ht-degree: 1%

---


# Snabbinställningar

Snabbinstallation är en snabb genomgång som visar hur du installerar och kör WKND-appen och som SPA och redigerar den med AEM SPA.

Snabbinstallation tar dig direkt till kursens slutstatus.

## Förutsättningar

Den här självstudiekursen kräver följande:

+ [SDK för AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html?lang=en)
+ [Node.js v14+](https://nodejs.org/en/)
+ [npm v7+](https://www.npmjs.com/)
+ [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
+ [Maven 3.6+](https://maven.apache.org/)
+ [Git](https://git-scm.com/downloads)
+ [aem-guides-wknd.all.0.3.0.zip eller högre](https://github.com/adobe/aem-guides-wknd/releases)
+ [källkoden aem-guides-wknd-graphql](https://github.com/adobe/aem-guides-wknd-graphql)

I den här självstudiekursen förutsätts:

+ [Microsoft® Visual Studio ](https://visualstudio.microsoft.com/) Codeas the IDE
+ En arbetskatalog för `~/Code/wknd-app`
+ Köra AEM SDK som en författartjänst på `http://localhost:4502`
+ Kör AEM SDK med det lokala `admin`-kontot med lösenordet `admin`
+ Kör SPA på `http://localhost:3000`

## Starta AEM SDK QuickStart

Hämta och installera AEM SDK Quickstart på port 4502, med standardautentiseringsuppgifterna `admin/admin`.

1. [Hämta senaste AEM SDK](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=AEM*+SDK*&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=1)
1. Zippa upp AEM SDK till `~/aem-sdk`
1. Kör AEM SDK QuickStart Jar

   ```
   $ java -jar aem-sdk-quickstart-xxx.jar
   
   # Provide `admin` as the admin user's password
   ```

AEM SDK startar och startar automatiskt den [http://localhost:4502](http://localhost:4502). Logga in med följande inloggningsuppgifter:

+ Användarnamn: `admin`
+ Lösenord: `admin`

## Hämta och installera WKND-webbplatspaket

Den här självstudiekursen är beroende av __WKND 0.3.0+&#39;s__-projekt (för innehåll).

1. [Ladda ned den senaste versionen av  `aem-guides-wknd.all.x.x.x.zip`](https://github.com/adobe/aem-guides-wknd/releases)
1. Logga in på AEM SDK:s Package Manager på [http://localhost:4502/crx/packmgr](http://localhost:4502/crx/packmgr) med `admin`-inloggningsuppgifterna.
1. __Ladda__ upp  `aem-guides-wknd.all.x.x.x.zip` nedladdat i steg 1
1. Tryck på __Install__-knappen för posten `aem-guides-wknd.all-x.x.x.zip`

## Hämta och installera WKND-SPA

För att göra en snabb konfiguration tillhandahålls AEM som innehåller den slutliga AEM och det färdiga innehållet.

1. [Hämta  `wknd-app.all.x.x.x.zip`](./assets/quick-setup/wknd-app.all-1.0.0-SNAPSHOT.zip)
1. [Hämta  `wknd-app.ui.content.sample.x.x.x.zip`](./assets/quick-setup/wknd-app.ui.content.sample-1.0.0.zip)
1. Logga in på AEM SDK:s Package Manager på [http://localhost:4502/crx/packmgr](http://localhost:4502/crx/packmgr) med `admin`-inloggningsuppgifterna.
1. __Ladda__ upp  `wknd-app.all.x.x.x.zip` nedladdat i steg 1
1. Tryck på __Install__-knappen för posten `wknd-app.all.x.x.x.zip`
1. __Ladda__ upp  `wknd-app.ui.content.sample.x.x.x.zip` nedladdat i steg 2
1. Tryck på __Install__-knappen för posten `wknd-app.ui.content.sample.x.x.x.zip`

## Ladda ned WKND App-källan

Hämta WKND-appens källkod från Github.com och byt gren som innehåller ändringarna till SPA som utfördes i den här självstudiekursen.

```
$ mkdir -p ~/Code/wknd-app
$ cd ~/Code/wknd-app
$ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
$ git checkout -b feature/spa-editor
```

## Starta SPA

Installera npm-beroenden för SPA från projektets rot och kör programmet.

```
$ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
$ npm install
$ npm run start
```

Om det uppstår fel när du kör `npm install` ska du göra följande:

```
$ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
$ rm -f package-lock.json
$ npm install --legacy-peer-deps
$ npm run start
```

Kontrollera att SPA körs på [http://localhost:3000](http://localhost:3000).

## Skapa innehåll i AEM SPA Editor

Innan du skapar innehåll måste du ordna webbläsarfönstren så att AEM Author (`http://localhost:4502`) finns till vänster och SPA (`http://localhost:3000`) körs till höger. På så sätt kan du se hur ändringar i AEM innehåll återspeglas direkt i SPA.

1. Logga in på [AEM SDK Author service](http://localhost:4502) som `admin`
1. Navigera till __Sites > WKND App > us > en__
1. Redigera __WKND-appens startsida__
1. Växla till läget __Redigera__

### Skapa hemvyns fasta komponent

1. Tryck på texten __WKND Adventures__ för att aktivera den fasta titelkomponenten (hårdkodad i SPA hemvy)
1. Tryck på ikonen __skiftnyckel__ i namnkomponentens åtgärdsfält
1. Ändrar rubrikkomponentens innehåll och sparar
1. Uppdatera SPA som körs på `http://localhost:3000` och se att ändringarna återspeglas

### Skapa behållarkomponenten för hemvyn

1. Medan du fortfarande redigerar startsidan för __WKND-programmet__...
1. Expandera sidlisten __SPA Editor__ (till vänster)
1. Tryck på ikonerna __Komponenter__
1. Lägga till, ändra eller ta bort komponenter från behållarkomponenten som finns under WKND-logotypen och ovanför den fasta Title-komponenten
1. Uppdatera SPA som körs på `http://localhost:3000` och se att ändringarna återspeglas

### Skapa en behållarkomponent på en dynamisk väg

1. Växla till läget __Förhandsgranska__ i SPA Editor
1. Tryck på __Bali Surf Camp__-kortet och navigera till dess dynamiska väg
1. Lägg till, ändra eller ta bort komponenter från behållarkomponenten som finns ovanför rubriken __Intervär__
1. Uppdatera SPA som körs på `http://localhost:3000` och se att ändringarna återspeglas

## Grattis!

Du har fått en snabb försmak av hur AEM redigeraren kan förbättra dina SPA med kontrollerade, redigerbara områden! Om du är intresserad - läs igenom resten av självstudiekursen, men se till att du kommer igång på nytt, eftersom den lokala utvecklingsmiljön nu är i slutläge för självstudiekursen i den här snabbkonfigurationen!
