---
title: Konfigurera Adobe Project Fire för Asset compute-utbyggbarhet
description: Projekt i asset compute är särskilt definierade projekt i Adobe Project Fire, och därför måste du ha tillgång till Adobe Project Fire i Adobe Developer Console för att kunna konfigurera och driftsätta dem.
feature: asset compute Microservices
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6268
thumbnail: 40183.jpg
topic: Integrering, utveckling
role: Developer
level: Mellan, erfaren
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '553'
ht-degree: 0%

---


# Konfigurera Adobe Project Fire

Projekt i asset compute är särskilt definierade projekt i Adobe Project Fire, och därför måste du ha tillgång till Adobe Project Fire i Adobe Developer Console för att kunna konfigurera och driftsätta dem.

## Skapa och konfigurera Adobe Project Fire i Adobe Developer Console{#set-up}

>[!VIDEO](https://video.tv.adobe.com/v/40183/?quality=12&learn=on)

_Klicka igenom konfigurationen av Adobe Project Fire (inget ljud)_

1. Logga in på [Adobe Developer Console](https://console.adobe.io) med den Adobe ID som är associerad med [konton och tjänster](./accounts-and-services.md). Kontrollera att du är __systemadministratör__ eller i __utvecklarrollen__ för rätt Adobe-organisation.
1. Skapa ett Firefoly-projekt genom att trycka på __Skapa nytt projekt > Projekt från mall > Projekteldy__

   _Om knappen__ Skapa nytt __projekt eller__ Project __Fireflytype inte är tillgänglig innebär det att din Adobe-organisation inte är  [tilldelad med Project Fire](#request-adobe-project-firefly)._

   + __Projektets titel__:  `WKND AEM Asset Compute`
   + __Programnamn__:  `wkndAemAssetCompute<YourName>`
      + __Programnamnet__ måste vara unikt i alla Fireworks och kan inte ändras senare. Att lägga till prefix för företagets eller organisationens namn och efterhandskorrigering med ett meningsfullt suffix är ett bra tillvägagångssätt, till exempel: `wkndAemAssetCompute`.
      + För självaktivering är det oftast bäst att skjuta upp ditt namn till __programnamnet__, till exempel `wkndAemAssetComputeJaneDoe`, för att undvika kollisioner med andra Project Fire-projekt.
   + Under __Arbetsytor__ lägger du till en ny miljö med namnet `Development`
   + Under __Adobe I/O Runtime__ kontrollerar du att __Inkludera körtid med varje arbetsyta__ är markerat
   + Tryck på __Spara__ för att spara projektet
1. I Adobe Firefoly-projektet väljer du `Development` från arbetsyteväljaren
1. Tryck på __+ Add Service > API__ för att öppna guiden __Add an API__ och använd den här metoden för att lägga till följande API:er:

   + __Experience Cloud > Asset compute__
      + Välj __Generera ett nyckelpar__ och tryck på __Generera nyckelpar__ och spara det hämtade `config.zip` på en säker plats för [senare användning](#private-key)
      + Tryck på __Nästa__
      + Markera produktprofilen __Integreringar - Cloud Service__ och tryck på __Spara konfigurerad API__
   + __Adobe Services > I/O__ Events och tryck på  __Save configure API__
   + __Adobe Services > I/O Management API__ och tryck på  __Save configure API__

## Åtkomst till private.key{#private-key}

När du konfigurerade [API-integreringen för Asset compute](#set-up) skapades ett nytt nyckelpar och en `config.zip`-fil hämtades automatiskt. Detta `config.zip` innehåller det genererade offentliga certifikatet och den matchande `private.key`-filen.

1. Zippa upp `config.zip` till en säker plats i filsystemet eftersom `private.key` är [använd senare](../develop/environment-variables.md)
   + Hemligheter och privata nycklar bör aldrig läggas till i Git som en säkerhetsfråga.

## Granska JWT-autentiseringsuppgifterna (Service Account)

Det här Adobe I/O-projektets autentiseringsuppgifter används av det lokala [Asset compute Development Tool](../develop/development-tool.md) för att interagera med Adobe I/O Runtime och måste införlivas i Asset compute. Bekanta dig med JWT-autentiseringsuppgifterna (Service Account).

![Adobe Developer Service Account-autentiseringsuppgifter](./assets/firefly/service-account.png)

1. Kontrollera att arbetsytan `Development` är markerad i projektet Adobe I/O Project Firefoly
1. Tryck på __JWT (Service Account)__ under __Autentiseringsuppgifter__
1. Granska inloggningsuppgifterna för Adobe I/O som visas
   + Den __publika nyckeln__ som anges längst ned har den __private.key__-motsvarigheten i `config.zip` som hämtades när __Asset compute-API__ lades till i det här projektet.
      + Om den privata nyckeln förloras eller komprometteras kan den matchande offentliga nyckeln tas bort och ett nytt nyckelpar genereras i eller överförs till Adobe I/O med det här gränssnittet.
