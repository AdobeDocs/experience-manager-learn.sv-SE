---
title: Skapa ett Asset compute-projekt för utbyggbarhet i Asset compute
description: Asset Compute-projekt är Node.js-projekt som genereras med Adobe I/O CLI och som följer en viss struktur som gör att de kan användas i Adobe I/O Runtime och integreras med AEM as a Cloud Service.
jira: KT-6269
thumbnail: 40197.jpg
topic: Integrations, Development
feature: Asset Compute Microservices
role: Developer
level: Intermediate, Experienced
exl-id: ebb11eab-1412-4af5-bc09-e965b9116ac9
duration: 177
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '577'
ht-degree: 0%

---

# Skapa ett Asset compute-projekt

Asset Compute-projekt är Node.js-projekt som genereras med Adobe I/O CLI och som följer en viss struktur som gör att de kan driftsättas i Adobe I/O Runtime och integreras med AEM as a Cloud Service. Ett enda Asset Compute-projekt kan innehålla en eller flera Asset compute-arbetare, där var och en har en separat HTTP-slutpunktsreferens från en AEM as a Cloud Service-bearbetningsprofil.

## Generera ett projekt

>[!VIDEO](https://video.tv.adobe.com/v/40197?quality=12&learn=on)

_Klicka igenom för att generera ett Asset compute-projekt (inget ljud)_

Använd plugin-programmet [Adobe I/O CLI Asset compute ](../set-up/development-environment.md#aio-cli) för att generera ett nytt, tomt Asset compute-projekt.

1. Navigera från kommandoraden till den mapp som projektet ska finnas i.
1. Kör `aio app init` från kommandoraden för att påbörja den interaktiva projektgenereringen av CLI.
   + Det här kommandot kan resultera i att en webbläsare begär autentisering till Adobe I/O. Om den gör det, anger du dina inloggningsuppgifter för Adobe som är kopplade till de [obligatoriska Adobe-tjänsterna och -produkterna](../set-up/accounts-and-services.md). Om du inte kan logga in följer du [dessa instruktioner för hur du skapar ett projekt](https://developer.adobe.com/app-builder/docs/getting_started/first_app/#42-developer-is-not-logged-in-as-enterprise-organization-user).
1. __Välj organisation__
   + Markera den Adobe-organisation som har AEM as a Cloud Service, App Builder är registrerad hos
1. __Välj projekt__
   + Leta reda på och markera projektet. Det här är [projekttiteln ](../set-up/app-builder.md) som skapats från App Builder projektmall, i det här fallet `WKND AEM Asset Compute`
1. __Välj Workspace__
   + Välj arbetsytan `Development`
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

Utvecklarverktyget kräver en fil med namnet `console.json` som innehåller de nödvändiga autentiseringsuppgifterna för att ansluta till Adobe I/O. Den här filen hämtas från Adobe I/O-konsolen.

1. Öppna Asset compute-arbetarens [Adobe I/O](https://console.adobe.io)-projekt
1. Välj den projektarbetsyta som du vill hämta autentiseringsuppgifterna för `console.json`, välj i det här fallet `Development`
1. Gå till roten för Adobe I/O-projektet och tryck på __Hämta alla__ i det övre högra hörnet.
1. En fil laddas ned som en `.json`-fil som har prefixet med projektet och arbetsytan, till exempel: `wkndAemAssetCompute-81368-Development.json`
1. Du kan antingen
   + Byt namn på filen till `console.json` och flytta den i roten för ditt Asset Compute Worker-projekt. Det här är metoden i den här självstudien.
   + Flytta den till en godtycklig mapp OCH referera till den mappen från din `.env`-fil med en konfigurationspost `ASSET_COMPUTE_INTEGRATION_FILE_PATH`. Filsökvägen kan vara absolut eller relativ till projektets rot. Till exempel:
      + `ASSET_COMPUTE_INTEGRATION_FILE_PATH=/Users/example-user/secrets/wkndAemAssetCompute-81368-Development.json`

     eller
      + `ASSET_COMPUTE_INTEGRATION_FILE_PATH=../../secrets/wkndAemAssetCompute-81368-Development.json.json`

> ANMÄRKNING
> Filen innehåller autentiseringsuppgifter. Om du lagrar filen i ditt projekt måste du lägga till den i din `.gitignore`-fil för att inte kunna delas. Samma sak gäller för filen `.env`: Dessa inloggningsuppgifter får inte delas eller lagras i Git.

## Asset Compute-projekt på GitHub

Det sista Asset compute-projektet är tillgängligt på GitHub på:

+ [aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute)

_GitHub innehåller projektets sluttillstånd, fullständigt ifyllt med arbetaren och testfall, men innehåller inga autentiseringsuppgifter, det vill säga `.env`, `console.json` eller `.aio`._
