---
title: Distribuera ett AEM UI-tillägg
description: Lär dig hur du distribuerar ett AEM UI-tillägg.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
jira: KT-11603
last-substantial-update: 2023-06-02T00:00:00Z
exl-id: 2e37165d-c003-4206-8133-54e37ca35b8e
duration: 166
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '765'
ht-degree: 0%

---

# Distribuera ett tillägg

För användning i AEM as a Cloud Service-miljöer måste tillägget App Builder installeras och godkännas.

Det finns flera saker att tänka på när du distribuerar tillägg till App Builder-program:

+ Tillägg distribueras till Adobe Developer Console projektarbetsyta. Standardarbetsytorna är:
   + Arbetsytan i __produktionen__ innehåller tilläggsdistributioner som är tillgängliga i alla AEM as a Cloud Service.
   + __Stage__-arbetsytan fungerar som en utvecklararbetsyta. Tillägg som distribueras till scenarbetsytan är inte tillgängliga i AEM as a Cloud Service.
Adobe Developer Console arbetsytor har ingen direkt koppling till AEM as a Cloud Service miljötyper.
+ Ett tillägg som distribueras till arbetsytan Produktion visas i alla AEM as a Cloud Service-miljöer i Adobe Org som tillägget finns i.
Ett tillägg kan inte begränsas till de miljöer som det är registrerat med genom att lägga till [villkorlig logik som kontrollerar AEM as a Cloud Service värdnamn](https://developer.adobe.com/uix/docs/guides/publication/#enabling-extension-only-on-specific-aem-environments).
+ Flera tillägg kan användas på AEM as a Cloud Service. Adobe rekommenderar att App Builder-apparna används för att uppnå ett enda affärsmål. Med det sagt kan en App Builder-app med ett enda tillägg implementera flera tilläggspunkter som stöder ett gemensamt affärsmål.

## Inledande distribution

För att ett tillägg ska vara tillgängligt i AEM as a Cloud Service-miljöer måste det distribueras till Adobe Developer Console.

Distributionsprocessen delas upp i två logiska steg:

1. Distribuera App Builder-tilläggsappen till Adobe Developer Console av en utvecklare.
1. Godkännande av tillägget av en driftsättningschef eller affärsägare.

### Distribuera tillägget

Distribuera tillägget till arbetsytan Produktion. Tillägg som distribueras till arbetsytan Produktion läggs automatiskt till i alla AEM as a Cloud Service Author-tjänster i Adobe Org som tillägget distribueras till.

1. Öppna en kommandorad i roten för det uppdaterade tillägget App Builder.
1. Kontrollera att arbetsytan Produktion är aktiv

   ```shell
   $ aio app use -w Production
   ```

   Sammanfoga alla ändringar i `.env` och `.aio`.

1. Distribuera det uppdaterade tillägget i App Builder-appen.

   ```shell
   $ aio app deploy
   ```

#### Begär godkännande av distribution

![Skicka tillägg för godkännande](./assets/deploy/submit-for-approval.png){align="center"}

1. Logga in på [Adobe Developer Console](https://developer.adobe.com)
1. Välj __konsol__
1. Navigera till __Projekt__
1. Välj det projekt som är associerat med tillägget
1. Välj arbetsytan __Produktion__
1. Välj __Skicka för godkännande__
1. Fyll i och skicka formuläret och uppdatera fälten efter behov.

### Godkännande av distribution

![Godkännande av tillägg](./assets/deploy/adobe-exchange.png){align="center"}

1. Logga in på [Adobe Exchange](https://exchange.adobe.com/)
1. Navigera till __Hantera__ > __Program som väntar på granskning__
1. __Granska__ tillägget i App Builder
1. Om tilläggets ändringar är godtagbara __Acceptera__ granskningen. Detta lägger omedelbart in tillägget på alla AEM as a Cloud Service Author-tjänster i Adobe.

När tilläggsbegäran har godkänts aktiveras tillägget omedelbart i AEM as a Cloud Service Author-tjänsterna.

## Uppdatera ett tillägg

Uppdatering och tillägg av App Builder-programmet följer samma process som den [initiala distributionen](#initial-deployment), med avvikelsen att den befintliga tilläggsdistributionen först måste återkallas.

### Återkalla tillägget

Om du vill distribuera en ny version av ett tillägg måste det först återkallas (eller tas bort). Tillägget återkallas men är inte tillgängligt i AEM-konsoler.

1. Logga in på [Adobe Exchange](https://exchange.adobe.com/)
1. Navigera till __Hantera__ > __App Builder-appar__
1. __Återkalla__ det tillägg som ska uppdateras

### Distribuera tillägget

Distribuera tillägget till arbetsytan Produktion. Tillägg som distribueras till arbetsytan Produktion läggs automatiskt till i alla AEM as a Cloud Service Author-tjänster i Adobe Org som tillägget distribueras till.

1. Öppna en kommandorad i roten för det uppdaterade tillägget App Builder.
1. Kontrollera att arbetsytan Produktion är aktiv

   ```shell
   $ aio app use -w Production
   ```

   Sammanfoga alla ändringar i `.env` och `.aio`.

1. Distribuera det uppdaterade tillägget i App Builder-appen.

   ```shell
   $ aio app deploy
   ```

#### Begär godkännande av distribution

![Skicka tillägg för godkännande](./assets/deploy/submit-for-approval.png){align="center"}

1. Logga in på [Adobe Developer Console](https://developer.adobe.com)
1. Välj __konsol__
1. Navigera till __Projekt__
1. Välj det projekt som är associerat med tillägget
1. Välj arbetsytan __Produktion__
1. Välj __Skicka för godkännande__
1. Fyll i och skicka formuläret och uppdatera fälten efter behov.

#### Godkänn distributionsbegäran

![Godkännande av tillägg](./assets/deploy/adobe-exchange.png){align="center"}

1. Logga in på [Adobe Exchange](https://exchange.adobe.com/)
1. Navigera till __Hantera__ > __Program som väntar på granskning__
1. __Granska__ tillägget i App Builder
1. Om tilläggets ändringar är godtagbara __Acceptera__ granskningen. Detta lägger omedelbart in tillägget på alla AEM as a Cloud Service Author-tjänster i Adobe.

När tilläggsbegäran har godkänts aktiveras tillägget omedelbart i AEM as a Cloud Service Author-tjänsterna.

## Ta bort ett tillägg

![Ta bort ett tillägg](./assets/deploy/revoke.png)

Om du vill ta bort ett tillägg återkallar (eller tar bort) du det från Adobe Exchange. När tillägget återkallas tas det bort från alla AEM as a Cloud Service Author-tjänster.

1. Logga in på [Adobe Exchange](https://exchange.adobe.com/)
1. Navigera till __Hantera__ > __App Builder-appar__
1. __Återkalla__ tillägget som ska tas bort
