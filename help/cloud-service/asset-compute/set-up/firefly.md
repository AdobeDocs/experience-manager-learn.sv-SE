---
title: Konfigurera Adobe Project Fire för utbyggbarhet av tillgångsberäkning
description: Resursberäkningsprogram är särskilt definierade Adobe Project Fire-program, och därför krävs åtkomst till Adobe Project Fire i Adobe Developer Console för att de ska kunna installeras och distribueras.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6268
thumbnail: 40183.jpg
translation-type: tm+mt
source-git-commit: 50519b9526182b528047069f211498099e3a4c88
workflow-type: tm+mt
source-wordcount: '546'
ht-degree: 0%

---


# Konfigurera Adobe Project Fire

Resursberäkningsprogram är särskilt definierade Adobe Project Fire-program, och därför krävs åtkomst till Adobe Project Fire i Adobe Developer Console för att de ska kunna installeras och distribueras.

## Skapa och konfigurera Adobe Project Fire i Adobe Developer Console{#set-up}

>[!VIDEO](https://video.tv.adobe.com/v/40183/?quality=12&learn=on)
_Klicka igenom konfigurationen av Adobe Project Fire (inget ljud)_

1. Logga in på [Adobe Developer Console](https://console.adobe.io) med den Adobe ID som är kopplad till de tilldelade [kontona och tjänsterna](./accounts-and-services.md). Kontrollera att du är __systemadministratör__ eller utvecklarroll ____ för rätt Adobe-organisation.
1. Skapa ett Firefoly-projekt genom att trycka på __Create new project > Project from template > Project Fire__

   _Om knappen__ Skapa nytt projekt __eller typen__ Projektguide __inte är tillgänglig innebär det att din Adobe-organisation inte är[tilldelad med Project Fire](#request-adobe-project-firefly)._

   + __Projektets titel__: `WKND AEM Asset Compute`
   + __Programnamn__: `wkndAemAssetCompute<YourName>`
      + Appnamnet __måste vara unikt för alla__ Fireworks-program och kan inte ändras senare. Att lägga till prefix för företagets eller organisationens namn och efterhandskorrigering med ett meningsfullt suffix är ett bra tillvägagångssätt, till exempel: `wkndAemAssetCompute`.
      + För självaktivering är det oftast bäst att skjuta upp ditt namn till __programnamnet__, t.ex. `wkndAemAssetComputeJaneDoe` för att undvika kollisioner med andra Project Fire-program.
   + Lägg till en ny miljö med namnet under __Arbetsytor__ `Development`
   + Under __Adobe I/O Runtime__ ser du till att alternativet __Inkludera körtid för varje arbetsyta__ är markerat
   + Tryck på __Spara__ för att spara projektet
1. I projektet Adobe Firefoly väljer du `Development` en arbetsyteväljare
1. Tryck på __+ Add Service > API__ för att öppna guiden __Add an API__ (Lägg till en API-guide) och använd den här metoden för att lägga till följande API:er:

   + __Experience Cloud > Beräkna tillgångar__
      + Välj __Generera ett nyckelpar__ och tryck på knappen __Generera nyckelpar__ och spara det hämtade `config.zip` på en säker plats för [senare bruk](#private-key)
      + Tryck på __Nästa__
      + Markera produktprofilens __integreringar - Cloud Service__ och tryck på __Spara konfigurerat API__
   + __Adobe Services > I/O Events__ och tryck på __Save configured API__
   + __Adobe Services > I/O Management API__ och tryck på __Save configure API__

## Öppna private.key{#private-key}

När API-integreringen [för](#set-up) tillgångsberäkning konfigurerades genererades ett nytt nyckelpar och en `config.zip` fil hämtades automatiskt. Detta `config.zip` innehåller det genererade offentliga certifikatet och den matchande `private.key` filen.

1. Zippa upp `config.zip` på en säker plats i filsystemet när `private.key` det [används senare](../develop/environment-variables.md)
   + Hemligheter och privata nycklar bör aldrig läggas till i Git som en säkerhetsfråga.

## Granska JWT-autentiseringsuppgifterna (Service Account)

I/O-projektets autentiseringsuppgifter för Adobe används av det lokala [verktyget](../develop/development-tool.md) för beräkning av tillgångar för att interagera med Adobe I/O Runtime och måste införlivas i projektet för beräkning av tillgångar. Bekanta dig med JWT-autentiseringsuppgifterna (Service Account).

![Adobe Developer Service Account-autentiseringsuppgifter](./assets/firefly/service-account.png)

1. Kontrollera att arbetsytan är markerad i Adobe I/O-projekt och att den är markerad `Development`
1. Tryck på __tjänstkonto (JWT)__ under __Autentiseringsuppgifter__
1. Granska inloggningsuppgifterna för Adobe
   + Den __offentliga nyckeln__ som anges längst ned har motsvarande __private.key__ i den `config.zip` nedladdade filen när API:t för __tillgångsberäkning__ lades till i det här projektet.
      + Om den privata nyckeln förloras eller komprometteras kan den matchande offentliga nyckeln tas bort och ett nytt nyckelpar som genereras i eller överförs till Adobe I/O med det här gränssnittet.
