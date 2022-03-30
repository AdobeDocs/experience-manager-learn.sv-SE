---
title: Konfigurera App Builder för Asset compute-utbyggbarhet
description: asset compute-projekt är särskilt definierade App Builder-projekt, och därför måste du ha tillgång till App Builder på Adobe Developer Console för att kunna konfigurera och distribuera dem.
feature: Asset Compute Microservices
topics: renditions, development
version: Cloud Service
activity: develop
audience: developer
doc-type: tutorial
kt: 6268
thumbnail: 40183.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 2b1d8786-592e-41f2-80cc-bc0b1c7e1b49
source-git-commit: eb6a7ef343a43000855f8d5cc69bde0fae81d3e6
workflow-type: tm+mt
source-wordcount: '539'
ht-degree: 0%

---

# Konfigurera App Builder

asset compute-projekt är särskilt definierade App Builder-projekt, och därför måste du ha tillgång till App Builder på Adobe Developer Console för att kunna konfigurera och distribuera dem.

## Skapa och konfigurera App Builder i Adobe Developer Console{#set-up}

>[!VIDEO](https://video.tv.adobe.com/v/40183/?quality=12&learn=on)

_Klicka igenom konfigurationen av App Builder (inget ljud)_

1. Logga in på [Adobe Developer Console](https://console.adobe.io) med den Adobe ID som är associerad med den tilldelade [konton och tjänster](./accounts-and-services.md). Se till att du är __Systemadministratör__ eller i __Utvecklarroll__ för rätt Adobe Org.
1. Skapa ett App Builder-projekt genom att trycka __Skapa nytt projekt > Projekt från mall > App Builder__

   _Om__ Skapa nytt projekt __eller__ App Builder __typen är inte tillgänglig, det innebär att din Adobe Org inte är tillgänglig [tillhandahålls med App Builder](#request-adobe-project-app-builder)._

   + __Projektets titel__: `WKND AEM Asset Compute`
   + __Programnamn__: `wkndAemAssetCompute<YourName>`
      + The __Programnamn__ måste vara unik för alla FApp Builderirefly-projekt och kan inte ändras senare. Att lägga till prefix för företagets eller organisationens namn och efterhandskorrigering med ett meningsfullt suffix är ett bra tillvägagångssätt, till exempel: `wkndAemAssetCompute`.
      + För självaktivering är det oftast bäst att lägga ditt namn på __Programnamn__, till exempel `wkndAemAssetComputeJaneDoe` för att undvika kollisioner med andra App Builder-projekt.
   + Under __Arbetsytor__ lägg till en ny miljö med namnet `Development`
   + Under __Adobe I/O Runtime__ säkerställa __Inkludera körtid i varje arbetsyta__ är markerat
   + Tryck __Spara__ spara projektet
1. I App Builder-projektet väljer du `Development` från arbetsyteväljaren
1. Tryck __+ Lägg till tjänst > API__ för att öppna __Lägg till ett API__ använder du den här metoden för att lägga till följande API:er:

   + __Experience Cloud > Asset compute__
      + Välj __Generera ett nyckelpar__ och tryck på __Generera nyckelpar__ och spara de hämtade `config.zip` till en säker plats för [senare använda](#private-key)
      + Tryck __Nästa__
      + Välj produktprofil __Integreringar - Cloud Service__ och trycka __Spara konfigurerat API__
   + __Adobe Services > I/O Events__ och trycka __Spara konfigurerat API__
   + __Adobe Services > I/O Management API__ och trycka __Spara konfigurerat API__

## Öppna private.key{#private-key}

När du ställer in [API-integrering för asset compute](#set-up) ett nytt nyckelpar skapades och en `config.zip` filen laddades ned automatiskt. Detta `config.zip` innehåller det genererade offentliga certifikatet och matchningen `private.key` -fil.

1. Zippa upp `config.zip` till en säker plats i filsystemet som `private.key` är [används senare](../develop/environment-variables.md)
   + Hemligheter och privata nycklar bör aldrig läggas till i Git som en säkerhetsfråga.

## Granska JWT-autentiseringsuppgifterna (Service Account)

Det här Adobe I/O-projektets autentiseringsuppgifter används av den lokala [asset compute Development Tool](../develop/development-tool.md) för att interagera med Adobe I/O Runtime och måste införlivas i Asset compute. Bekanta dig med JWT-autentiseringsuppgifterna (Service Account).

![Adobe Developer Service Account-autentiseringsuppgifter](./assets/app-builder/service-account.png)

1. I Adobe I/O Project App Builder-projektet ser du till att `Development` arbetsytan är markerad
1. Tryck på __Tjänstkonto (JWT)__ under __Autentiseringsuppgifter__
1. Granska inloggningsuppgifterna för Adobe I/O som visas
   + The __publik nyckel__ längst ned finns __private.key__ motpart i `config.zip` laddas ned när __asset compute API__ har lagts till i det här projektet.
      + Om den privata nyckeln förloras eller komprometteras kan den matchande offentliga nyckeln tas bort och ett nytt nyckelpar genereras i eller överförs till Adobe I/O med det här gränssnittet.
