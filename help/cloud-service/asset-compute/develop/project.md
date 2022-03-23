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
source-git-commit: 136049776140746c61d42ad1496df15a2d226e3a
workflow-type: tm+mt
source-wordcount: '896'
ht-degree: 0%

---

# Skapa ett Asset compute-projekt

asset compute-projekt är Node.js-projekt som genereras med Adobe I/O CLI och som följer en viss struktur som gör att de kan användas i Adobe I/O Runtime och integreras med AEM as a Cloud Service. Ett Asset compute-projekt kan innehålla en eller flera Asset compute-arbetare, där var och en har en separat HTTP-slutpunktsreferens från en AEM as a Cloud Service bearbetningsprofil.

## Generera ett projekt

>[!VIDEO](https://video.tv.adobe.com/v/40197/?quality=12&learn=on)

_Klicka igenom för att generera ett Asset compute-projekt (inget ljud)_

Använd [Adobe I/O CLI Asset compute plug-in](../set-up/development-environment.md#aio-cli) för att skapa ett nytt, tomt Asset compute-projekt.

1. Navigera från kommandoraden till mappen som projektet ska innehålla.
1. Kör från kommandoraden `aio app init` för att starta genereringen av interaktiva projekt i CLI.
   + Det här kommandot kan resultera i att en webbläsare begär autentisering till Adobe I/O. Om så är fallet anger du dina inloggningsuppgifter för Adobe som är kopplade till [Adobes tjänster och produkter](../set-up/accounts-and-services.md). Om du inte kan logga in följer du [dessa instruktioner för hur du skapar ett projekt](https://www.adobe.io/project-firefly/docs/getting_started/first_app/#42-developer-is-not-logged-in-as-enterprise-organization-user).
1. __Välj organisation__
   + Markera den Adobe-organisation som har AEM as a Cloud Service, projektflaggan är registrerad med
1. __Välj projekt__
   + Leta reda på och markera projektet. Det här är [Projektets titel](../set-up/firefly.md) som skapats från projektmallen Firefly, i det här fallet `WKND AEM Asset Compute`
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

## Granska projektets status

Det genererade Asset compute-projektet är ett Node.js-projekt som används som ett specialiserat Adobe Project Firefoly-projekt. Följande strukturella element är idiosynkratiska för projekt i Asset compute:

+ `/actions` innehåller undermappar och varje undermapp definierar en Asset compute-arbetare.
   + `/actions/<worker-name>/index.js` definierar det JavaScript som används för att utföra arbetarens arbete.
      + Mappnamnet `worker` är standard och kan vara vad som helst, så länge som det är registrerat i `manifest.yml`.
      + Mer än en arbetsmapp kan definieras under `/actions` vid behov, men de måste registreras i `manifest.yml`.
+ `/test/asset-compute` innehåller testsviter för varje arbetare. Liknar `/actions` mapp, `/test/asset-compute` kan innehålla flera undermappar, som var och en motsvarar den arbetare som testas.
   + `/test/asset-compute/worker`, som representerar en testsvit för en viss arbetare, innehåller undermappar som representerar ett specifikt testfall, tillsammans med testindata, parametrar och förväntade utdata.
+ `/build` innehåller utdata, loggar och artefakter från Asset compute testfall.
+ `/manifest.yml` definierar vilka Asset compute-arbetare projektet ger. Varje implementering av arbetare måste räknas upp i den här filen för att göra dem tillgängliga för AEM as a Cloud Service.
+ `/console.json` definierar Adobe I/O-konfigurationer
   + Den här filen kan genereras/uppdateras med `aio app use` -kommando.
+ `/.aio` innehåller konfigurationer som används av AIR CLI-verktyget.
   + Den här filen kan genereras/uppdateras med `aio app use` -kommando.
+ `/.env` definierar miljövariabler i en `key=value` och innehåller hemligheter som inte ska delas. För att skydda dessa hemligheter bör den här filen INTE checkas in i Git och ignoreras via projektets standardinställningar `.gitignore` -fil.
   + Den här filen kan genereras/uppdateras med `aio app use` -kommando.
   + Variabler som definieras i den här filen kan åsidosättas av [exportera variabler](../deploy/runtime.md) på kommandoraden.

Mer information om granskning av projektstruktur finns i [Anatomi i ett projekt inom flygprojektet Adobe](https://www.adobe.io/project-firefly/docs/guides/).

Den största delen av utvecklingen äger rum i `/actions` för att utveckla arbetaranpassningar och `/test/asset-compute` att skriva tester för Asset compute.

## asset compute-projekt på GitHub

Det sista Asset compute-projektet är tillgängligt på GitHub på:

+ [aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute)

_GitHub innehåller projektets sluttillstånd, fullt ifyllt med arbetaren och testfall, men innehåller inga referenser, det vill säga, `.env`, `console.json` eller `.aio`._
