---
title: Skapa ett Asset compute-projekt för utbyggbarhet i Asset compute
description: asset compute-projekt är Node.js-projekt som genereras med Adobe I/O CLI och som följer en viss struktur som gör att de kan användas i Adobe I/O Runtime och integreras med AEM as a Cloud Service.
kt: 6269
thumbnail: 40197.jpg
topic: Integrations, Development
feature: Asset Compute Microservices
role: Developer
level: Intermediate, Experienced
exl-id: ebb11eab-1412-4af5-bc09-e965b9116ac9
source-git-commit: eb6a7ef343a43000855f8d5cc69bde0fae81d3e6
workflow-type: tm+mt
source-wordcount: '589'
ht-degree: 1%

---

# Skapa ett Asset compute-projekt

asset compute-projekt är Node.js-projekt som genereras med Adobe I/O CLI och som följer en viss struktur som gör att de kan användas i Adobe I/O Runtime och integreras med AEM as a Cloud Service. Ett Asset compute-projekt kan innehålla en eller flera Asset compute-arbetare, där var och en har en separat HTTP-slutpunktsreferens från en AEM as a Cloud Service bearbetningsprofil.

## Generera ett projekt

>[!VIDEO](https://video.tv.adobe.com/v/40197/?quality=12&learn=on)

_Klicka igenom för att generera ett Asset compute-projekt (inget ljud)_

Använd [Adobe I/O CLI Asset compute plug-in](../set-up/development-environment.md#aio-cli) för att skapa ett nytt, tomt Asset compute-projekt.

1. Navigera från kommandoraden till mappen som projektet ska innehålla.
1. Kör från kommandoraden `aio app init` för att starta genereringen av interaktiva projekt i CLI.
   + Det här kommandot kan resultera i att en webbläsare begär autentisering till Adobe I/O. Om så är fallet anger du dina inloggningsuppgifter för Adobe som är kopplade till [Adobes tjänster och produkter](../set-up/accounts-and-services.md). Om du inte kan logga in följer du [dessa instruktioner för hur du skapar ett projekt](https://developer.adobe.com/app-builder/docs/getting_started/first_app/#42-developer-is-not-logged-in-as-enterprise-organization-user).
1. __Välj organisation__
   + Markera den Adobe-organisation som har AEM as a Cloud Service, App Builder är registrerad med
1. __Välj projekt__
   + Leta reda på och markera projektet. Det här är [Projektets titel](../set-up/app-builder.md) som skapats från projektmallen i App Builder, i det här fallet `WKND AEM Asset Compute`
1. __Välj arbetsyta__
   + Välj `Development` arbetsyta
1. __Vilka Adobe I/O App-funktioner vill du aktivera för det här projektet? Välj komponenter som ska inkluderas__
   + Välj `Actions: Deploy runtime actions`
   + Använd piltangenterna för att markera och avmarkera/markera samt Retur för att bekräfta markeringen
1. __Välj vilken typ av åtgärder som ska genereras__
   + Välj `DX Asset Compute Worker v1`
   + Använd piltangenterna för att markera, blanksteg för att avmarkera/markera och Retur för att bekräfta markeringen
1. __Hur vill du namnge den här åtgärden?__
   + Använd standardnamnet `worker`.
   + Om projektet innehåller flera arbetare som utför olika tillgångsberäkningar namnger du dem semantiskt

## Generera console.json

Utvecklarverktyget kräver en fil med namnet `console.json` som innehåller de nödvändiga inloggningsuppgifterna för att ansluta till Adobe I/O. Den här filen hämtas från Adobe I/O-konsolen.

1. Öppna Asset compute arbetarens [Adobe I/O](https://console.adobe.io) projekt
1. Välj den projektarbetsyta som du vill hämta `console.json` autentiseringsuppgifter för, i det här fallet, välj `Development`
1. Gå till roten av Adobe I/O-projektet och tryck på __Hämta alla__ i det övre högra hörnet.
1. En fil hämtas som `.json` fil som har prefixet med projektet och arbetsytan, till exempel: `wkndAemAssetCompute-81368-Development.json`
1. Du kan antingen
   + Byt namn på filen som `config.json` och flytta det till roten av ditt Asset compute-projekt. Det här är metoden i den här självstudiekursen.
   + Flytta den till en godtycklig mapp OCH referera till den mappen från din `.env` fil med en konfigurationspost `ASSET_COMPUTE_INTEGRATION_FILE_PATH`. Filsökvägen kan vara absolut eller relativ till projektets rot. Till exempel:
      + `ASSET_COMPUTE_INTEGRATION_FILE_PATH=/Users/example-user/secrets/wkndAemAssetCompute-81368-Development.json`

      eller
      + `ASSET_COMPUTE_INTEGRATION_FILE_PATH=../../secrets/wkndAemAssetCompute-81368-Development.json.json`


> ANMÄRKNING
> Filen innehåller autentiseringsuppgifter. Om du lagrar filen i ditt projekt måste du lägga till den i `.gitignore` för att förhindra att filer delas. Samma sak gäller för `.env` file - Dessa inloggningsuppgifter får inte delas eller lagras i Git.

## asset compute-projekt på GitHub

Det sista Asset compute-projektet är tillgängligt på GitHub på:

+ [aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute)

_GitHub innehåller projektets sluttillstånd, fullt ifyllt med arbetaren och testfall, men innehåller inga referenser, det vill säga, `.env`, `console.json` eller `.aio`._
