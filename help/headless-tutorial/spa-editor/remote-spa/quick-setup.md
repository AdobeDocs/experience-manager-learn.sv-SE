---
title: Snabbredigerare för SPA och fjärr-SPA
description: Lär dig hur du kommer igång med en fjärr-SPA och AEM SPA Editor på 15 minuter!
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
jira: KT-7629
thumbnail: 333181.jpg
last-substantial-update: 2022-11-11T00:00:00Z
recommendations: noDisplay, noCatalog
doc-type: Tutorial
exl-id: ef7a1dad-993a-4c47-a9fb-91fa73de9b5d
duration: 647
hide: true
source-git-commit: 5b008419d0463e4eaa1d19c9fe86de94cba5cb9a
workflow-type: tm+mt
source-wordcount: '726'
ht-degree: 0%

---

# Snabbinställningar

{{spa-editor-deprecation}}

Snabbinstallation är en snabb genomgång som visar hur man installerar och kör WKND-appen och som en fjärr-SPA, och hur man skapar den med AEM SPA Editor.

Snabbinstallation tar dig direkt till kursens slutstatus.

>[!VIDEO](https://video.tv.adobe.com/v/333181?quality=12&learn=on)

_En videogenomgång av snabbinstallationen_

## Förutsättningar

Den här självstudiekursen kräver följande:

+ [SDK för AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html?lang=sv-SE)
+ [Node.js v18](https://nodejs.org/en/)
+ [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
+ [Maven 3.6+](https://maven.apache.org/)
+ [Git](https://git-scm.com/downloads)
+ Förutsättningar endast för macOS
   + [Xcode](https://developer.apple.com/xcode/) eller [Xcode kommandoradsverktyg](https://developer.apple.com/xcode/resources/)
+ [aem-guides-wknd.all-2.1.0.zip eller större](https://github.com/adobe/aem-guides-wknd/releases)
+ [aem-guides-wknd-graphql-källkod (gren: feature/spa-editor)](https://github.com/adobe/aem-guides-wknd-graphql/tree/feature/spa-editor)


I den här självstudien förutsätts:

+ [Microsoft® Visual Studio Code](https://visualstudio.microsoft.com/) som IDE
+ En arbetskatalog för `~/Code/wknd-app`
+ Köra AEM SDK som en författartjänst på `http://localhost:4502`
+ Kör AEM SDK med det lokala `admin`-kontot med lösenordet `admin`
+ Kör SPA på `http://localhost:3000`

## Starta AEM SDK Quickstart

Hämta och installera AEM SDK Quickstart på port 4502, med standardautentiseringsuppgifterna för `admin/admin`.

1. [Hämta senaste AEM SDK](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=AEM*+SDK*&orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&orderby.sort=desc&layout=list&p.offset=0&p.limit=1)
1. Zippa upp AEM SDK till `~/aem-sdk`
1. Kör AEM SDK Quickstart Jar

   ```
   $ java -jar aem-sdk-quickstart-xxx.jar
   
   # Provide `admin` as the admin user's password
   ```

AEM SDK startas och startas automatiskt [http://localhost:4502](http://localhost:4502). Logga in med följande inloggningsuppgifter:

+ Användarnamn: `admin`
+ Lösenord: `admin`

## Hämta och installera WKND-webbplatspaket

Den här självstudien är beroende av __WKND 2.1.0+__ -projektet (för innehåll).

1. [Hämta den senaste versionen av `aem-guides-wknd.all.x.x.x.zip`](https://github.com/adobe/aem-guides-wknd/releases)
1. Logga in på AEM SDK Package Manager på [http://localhost:4502/crx/packmgr](http://localhost:4502/crx/packmgr) med inloggningsuppgifterna för `admin`.
1. __Överför__ de `aem-guides-wknd.all.x.x.x.zip` som hämtades i steg 1
1. Tryck på knappen __Installera__ för posten `aem-guides-wknd.all-x.x.x.zip`

## Hämta och installera WKND App SPA-paket

För att göra en snabb konfiguration tillhandahålls AEM-paket här som innehåller kursens slutliga AEM-konfiguration och innehåll.

1. [Ladda ned &#x200B;](./assets/quick-setup/wknd-app.all-1.0.0-SNAPSHOT.zip)
1. [Ladda ned &#x200B;](./assets/quick-setup/wknd-app.ui.content.sample-1.0.1.zip)
1. Logga in på AEM SDK Package Manager på [http://localhost:4502/crx/packmgr](http://localhost:4502/crx/packmgr) med inloggningsuppgifterna för `admin`.
1. __Överför__ de `wknd-app.all.x.x.x.zip` som hämtades i steg 1
1. Tryck på knappen __Installera__ för posten `wknd-app.all.x.x.x.zip`
1. __Överför__ den `wknd-app.ui.content.sample.x.x.x.zip` som hämtades i steg 2
1. Tryck på knappen __Installera__ för posten `wknd-app.ui.content.sample.x.x.x.zip`

## Ladda ned WKND App-källan

Hämta WKND-appens källkod från Github.com och växla grenen som innehåller ändringarna i SPA-koden som utfördes i den här självstudiekursen.

```
$ mkdir -p ~/Code/wknd-app
$ cd ~/Code/wknd-app
$ git clone --branch feature/spa-editor https://github.com/adobe/aem-guides-wknd-graphql.git
$ cd aem-guides-wknd-graphql
```

## Starta SPA-programmet

Installera SPA-projektens npm-beroenden från projektets rot och kör programmet.

```
$ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
$ npm install
$ npm run start
```

Om det uppstår fel när `npm install` körs provar du med följande steg:

```
$ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
$ rm -f package-lock.json
$ npm install --legacy-peer-deps
$ npm run start
```

Kontrollera att SPA körs på [http://localhost:3000](http://localhost:3000).

## Skapa innehåll i AEM SPA Editor

Innan du skapar innehåll måste du ordna webbläsarfönstren så att AEM Author (`http://localhost:4502`) finns till vänster och fjärr-SPA (`http://localhost:3000`) körs till höger. På så sätt kan du se hur ändringar i AEM-källinnehåll återspeglas direkt i SPA-avtalet.

1. Logga in på [AEM SDK Author service](http://localhost:4502) som `admin`
1. Navigera till __Sites > WKND App > us > en__
1. Redigera startsidan för __WKND-program__
1. Växla till läget __Redigera__

### Skapa hemvyns fasta komponent

1. Tryck på texten __WKND Adventures__ för att aktivera den fasta titelkomponenten (hårdkodad i SPA:s hemvy)
1. Tryck på ikonen __skiftnyckel__ i namnkomponentens åtgärdsfält
1. Ändrar rubrikkomponentens innehåll och sparar
1. Uppdatera SPA som körs på `http://localhost:3000` och se att ändringarna återspeglas

### Skapa behållarkomponenten för hemvyn

1. Medan du redigerar startsidan för __WKND-programmet__...
1. Expandera __SPA-redigerarens sidofält__ (till vänster)
1. Tryck på ikonerna __Komponenter__
1. Lägga till, ändra eller ta bort komponenter från behållarkomponenten som finns under WKND-logotypen och ovanför den fasta Title-komponenten
1. Uppdatera SPA som körs på `http://localhost:3000` och se att ändringarna återspeglas

### Skapa en behållarkomponent på en dynamisk väg

1. Växla till läget __Förhandsgranska__ i SPA-redigeraren
1. Tryck på __Bali Surf Camp__-kortet och navigera till dess dynamiska väg
1. Lägg till, ändra eller ta bort komponenter från behållarkomponenten som finns ovanför rubriken __Intervär__
1. Uppdatera SPA som körs på `http://localhost:3000` och se att ändringarna återspeglas

Nya AEM-sidor på startsidan för __WKND-appen > Adventure__ _måste_ ha ett AEM-sidnamn som matchar namnet för motsvarande äventyr. Detta beror på att SPA-vägen till AEM Page-mappningen baseras på det sista segmentet i vägen, som är namnet på Content Fragment.

## Grattis!

Du har fått en snabb försmak av hur AEM SPA Editor kan förbättra din SPA med kontrollerade, redigerbara områden! Om du är intresserad - läs igenom resten av självstudiekursen, men se till att du kommer igång på nytt, eftersom den lokala utvecklingsmiljön nu är i slutläge för självstudiekursen i den här snabbkonfigurationen!
