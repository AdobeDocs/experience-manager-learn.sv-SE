---
title: Snabbredigeraren SPA fjärrinstallation och SPA
description: Lär dig hur du kommer igång med en SPA och AEM SPA på 15 minuter!
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
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '726'
ht-degree: 0%

---

# Snabbinställningar

Snabbinstallation är en snabb genomgång som visar hur du installerar och kör WKND-appen och som SPA och redigerar den med AEM SPA.

Snabbinstallation tar dig direkt till kursens slutstatus.

>[!VIDEO](https://video.tv.adobe.com/v/333181?quality=12&learn=on)

_En videogenomgång av snabbinstallationen_

## Förutsättningar

Den här självstudiekursen kräver följande:

+ [SDK för AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html?lang=en)
+ [Node.js v18](https://nodejs.org/en/)
+ [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
+ [Maven 3.6+](https://maven.apache.org/)
+ [Git](https://git-scm.com/downloads)
+ Förutsättningar endast för macOS
   + [Xcode](https://developer.apple.com/xcode/) eller [Xcode-kommandoradsverktyg](https://developer.apple.com/xcode/resources/)
+ [aem-guides-wknd.all-2.1.0.zip eller högre](https://github.com/adobe/aem-guides-wknd/releases)
+ [aem-guides-wknd-graphql-källkod (gren: feature/spa-editor)](https://github.com/adobe/aem-guides-wknd-graphql/tree/feature/spa-editor)


I den här självstudien förutsätts:

+ [Microsoft® Visual Studio Code](https://visualstudio.microsoft.com/) som IDE
+ En arbetskatalog för `~/Code/wknd-app`
+ Köra AEM SDK som en författartjänst på `http://localhost:4502`
+ Köra AEM SDK med lokala `admin` konto med lösenord `admin`
+ SPA körs på `http://localhost:3000`

## Starta AEM SDK QuickStart

Hämta och installera AEM SDK QuickStart på port 4502, med standardinställningen `admin/admin` autentiseringsuppgifter.

1. [Hämta senaste AEM SDK](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=AEM*+SDK*&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=1)
1. Zippa upp AEM SDK för att `~/aem-sdk`
1. Kör AEM SDK QuickStart Jar

   ```
   $ java -jar aem-sdk-quickstart-xxx.jar
   
   # Provide `admin` as the admin user's password
   ```

AEM SDK startar och startar automatiskt [http://localhost:4502](http://localhost:4502). Logga in med följande inloggningsuppgifter:

+ Användarnamn: `admin`
+ Lösenord: `admin`

## Hämta och installera WKND-webbplatspaket

Självstudiekursen är beroende av __WKND 2.1.0+__ projekt (för innehåll).

1. [Hämta den senaste versionen av `aem-guides-wknd.all.x.x.x.zip`](https://github.com/adobe/aem-guides-wknd/releases)
1. Logga in AEM SDK:s Package Manager på [http://localhost:4502/crx/packmgr](http://localhost:4502/crx/packmgr) med `admin` autentiseringsuppgifter.
1. __Överför__ den `aem-guides-wknd.all.x.x.x.zip` hämtat i steg 1
1. Tryck på __Installera__ knapp för inmatningen `aem-guides-wknd.all-x.x.x.zip`

## Hämta och installera WKND-SPA

För att göra en snabb konfiguration finns AEM här som innehåller den slutliga AEM och det färdiga innehållet.

1. [Ladda ned ](./assets/quick-setup/wknd-app.all-1.0.0-SNAPSHOT.zip)
1. [Ladda ned ](./assets/quick-setup/wknd-app.ui.content.sample-1.0.1.zip)
1. Logga in AEM SDK:s Package Manager på [http://localhost:4502/crx/packmgr](http://localhost:4502/crx/packmgr) med `admin` autentiseringsuppgifter.
1. __Överför__ den `wknd-app.all.x.x.x.zip` hämtat i steg 1
1. Tryck på __Installera__ knapp för inmatningen `wknd-app.all.x.x.x.zip`
1. __Överför__ den `wknd-app.ui.content.sample.x.x.x.zip` hämtat i steg 2
1. Tryck på __Installera__ knapp för inmatningen `wknd-app.ui.content.sample.x.x.x.zip`

## Ladda ned WKND App-källan

Hämta WKND-appens källkod från Github.com och växla grenen som innehåller ändringarna till SPA som utfördes i den här självstudiekursen.

```
$ mkdir -p ~/Code/wknd-app
$ cd ~/Code/wknd-app
$ git clone --branch feature/spa-editor https://github.com/adobe/aem-guides-wknd-graphql.git
$ cd aem-guides-wknd-graphql
```

## Starta SPA

Installera npm-beroenden för SPA från projektets rot och kör programmet.

```
$ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
$ npm install
$ npm run start
```

Om fel uppstår vid körning `npm install` prova följande steg:

```
$ cd ~/Code/wknd-app/aem-guides-wknd-graphql/react-app
$ rm -f package-lock.json
$ npm install --legacy-peer-deps
$ npm run start
```

Verifiera att SPA körs på [http://localhost:3000](http://localhost:3000).

## Skapa innehåll i AEM SPA Editor

Ordna webbläsarfönstren så att AEM författare (`http://localhost:4502`) finns till vänster och SPA på fjärrkontrollen (`http://localhost:3000`) till höger. På så sätt kan du se hur ändringar i AEM innehåll återspeglas direkt i SPA.

1. Logga in på [AEM SDK Author Service](http://localhost:4502) as `admin`
1. Navigera till __Sites > WKND App > us > en__
1. Redigera __WKND App - startsida__
1. Växla till __Redigera__ läge

### Skapa hemvyns fasta komponent

1. Tryck på texten __WKND-annonser__ för att aktivera den fasta titelkomponenten (hårdkodad i SPA hemvy)
1. Tryck på __wrench__ ikon i namnkomponentens åtgärdsfält
1. Ändrar rubrikkomponentens innehåll och sparar
1. Uppdatera SPA som körs `http://localhost:3000` och se att ändringarna återspeglas

### Skapa behållarkomponenten för hemvyn

1. Medan du fortfarande redigerar __WKND App - startsida__...
1. Expandera __SPA__ (till vänster)
1. Tryck på __Komponenter__ ikoner
1. Lägga till, ändra eller ta bort komponenter från behållarkomponenten som finns under WKND-logotypen och ovanför den fasta Title-komponenten
1. Uppdatera SPA som körs `http://localhost:3000` och se att ändringarna återspeglas

### Skapa en behållarkomponent på en dynamisk väg

1. Växla till __Förhandsgranska__ i SPA Editor
1. Tryck på __Bali Surf Camp__ och navigera till dess dynamiska väg
1. Lägg till, ändra eller ta bort komponenter från behållarkomponenten som placeras ovanför __Itinerary__ rubrik
1. Uppdatera SPA som körs `http://localhost:3000` och se att ändringarna återspeglas

Nya AEM under __WKND App Home page > Adventure__ _måste_ har ett AEM sidnamn som matchar namnet på motsvarande äventyrs Content Fragment. Detta beror på att den SPA vägen till AEM Sidmappning baseras på det sista segmentet i flödet, som är namnet på innehållsfragmentet.

## Grattis!

Du har fått en snabb försmak av hur AEM redigeraren kan förbättra dina SPA med kontrollerade, redigerbara områden! Om du är intresserad - läs igenom resten av självstudiekursen, men se till att du kommer igång på nytt, eftersom den lokala utvecklingsmiljön nu är i slutläge för självstudiekursen i den här snabbkonfigurationen!
