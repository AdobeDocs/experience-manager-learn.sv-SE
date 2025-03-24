---
title: Konfigurera utbyggbarhet för App Builder för Asset Compute
description: Asset Compute-projekt är särskilt definierade App Builder-projekt, och som sådana kräver de tillgång till App Builder i Adobe Developer Console för att de ska kunna installeras och driftsättas.
feature: Asset Compute Microservices
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-6268
thumbnail: 40183.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 2b1d8786-592e-41f2-80cc-bc0b1c7e1b49
duration: 197
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '538'
ht-degree: 0%

---

# Konfigurera App Builder

Asset Compute-projekt är särskilt definierade App Builder-projekt, och som sådana kräver de tillgång till App Builder i Adobe Developer Console för att de ska kunna installeras och driftsättas.

## Skapa och konfigurera App Builder i Adobe Developer Console{#set-up}

>[!VIDEO](https://video.tv.adobe.com/v/40183?quality=12&learn=on)

_Klicka igenom konfigurationen av App Builder (inget ljud)_

1. Logga in på [Adobe Developer Console](https://console.adobe.io) med den Adobe ID som är kopplad till de [konton och tjänster som är tilldelade](./accounts-and-services.md). Kontrollera att du är __systemadministratör__ eller i __utvecklarrollen__ för rätt Adobe-organisation.
1. Skapa ett App Builder-projekt genom att trycka på __Skapa nytt projekt > Projekt från mall > App Builder__

   _Om knappen__ Skapa nytt projekt __eller typen__ App Builder __inte är tillgänglig innebär det att din Adobe-organisation inte [har etablerats med App Builder](#request-adobe-project-app-builder)._

   + __Projekttitel__: `WKND AEM Asset Compute`
   + __Programnamn__: `wkndAemAssetCompute<YourName>`
      + __Programnamnet__ måste vara unikt för alla FApp Builderirefly-projekt och kan inte ändras senare. Det är bra att lägga till prefix för företagets eller organisationens namn och postfix med ett meningsfullt suffix, till exempel: `wkndAemAssetCompute`.
      + För självaktivering är det oftast bäst att skjuta upp ditt namn till __programnamnet__, till exempel `wkndAemAssetComputeJaneDoe`, för att undvika kollisioner med andra App Builder-projekt.
   + Lägg till en ny miljö med namnet `Development` under __Arbetsytor__
   + Under __Adobe I/O Runtime__ ser du till att __Inkludera körtid med varje arbetsyta__ är markerat
   + Tryck på __Spara__ för att spara projektet
1. I App Builder-projektet väljer du `Development` i arbetsyteväljaren
1. Tryck på __+ Add Service > API__ för att öppna guiden __Add an API__ och använd den här metoden för att lägga till följande API:er:

   + __Experience Cloud > Asset Compute__
      + Välj __Generera ett nyckelpar__ och tryck på knappen __Generera nyckelpar__ och spara det hämtade `config.zip` på en säker plats för [senare användning](#private-key)
      + Tryck på __Nästa__
      + Välj produktprofilen __Integreringar - Cloud Service__ och tryck på __Spara konfigurerat API__
   + __Adobe-tjänster > I/O-händelser__ och tryck på __Spara konfigurerat API__
   + __Adobe-tjänster > I/O-hanterings-API__ och tryck på __Spara konfigurerat API__

## Öppna private.key{#private-key}

När [Asset Compute API-integrationen](#set-up) konfigurerades genererades ett nytt nyckelpar och en `config.zip`-fil hämtades automatiskt. `config.zip` innehåller det genererade offentliga certifikatet och den matchande `private.key`-filen.

1. Zippa upp `config.zip` till en säker plats i filsystemet eftersom `private.key` används [senare](../develop/environment-variables.md)
   + Hemligheter och privata nycklar bör aldrig läggas till i Git som en säkerhetsfråga.

## Granska JWT-autentiseringsuppgifterna (Service Account)

Det här Adobe I/O-projektets autentiseringsuppgifter används av det lokala [Asset Compute Development Tool](../develop/development-tool.md) för att interagera med Adobe I/O Runtime och måste införlivas i Asset Compute-projektet. Bekanta dig med JWT-autentiseringsuppgifterna (Service Account).

![Adobe Developer tjänstkonto - autentiseringsuppgifter](./assets/app-builder/service-account.png)

1. Kontrollera att arbetsytan `Development` är markerad i Adobe I/O Project App Builder-projektet
1. Tryck på __tjänstkonto (JWT)__ under __Autentiseringsuppgifter__
1. Granska de Adobe I/O-autentiseringsuppgifter som visas
   + Den __publika nyckeln__ som visas längst ned har motsvarande __private.key__ i den `config.zip` som hämtades när __Asset Compute API__ lades till i det här projektet.
      + Om den privata nyckeln förloras eller komprometteras kan den matchande offentliga nyckeln tas bort och ett nytt nyckelpar som genereras i eller överförs till Adobe I/O med det här gränssnittet.
