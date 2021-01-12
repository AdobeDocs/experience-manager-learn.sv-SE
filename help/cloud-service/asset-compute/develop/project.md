---
title: Skapa ett Asset compute-projekt för utbyggbarhet i Asset compute
description: asset compute-projekt är Node.js-projekt som genereras med Adobe I/O CLI och som följer en viss struktur som gör att de kan användas i Adobe I/O Runtime och integreras med AEM som Cloud Service.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6269
thumbnail: 40197.jpg
translation-type: tm+mt
source-git-commit: 676d4bfceaaec3ae8d4feb9f66294ec04e1ecd2b
workflow-type: tm+mt
source-wordcount: '772'
ht-degree: 0%

---


# Skapa ett Asset compute-projekt

asset compute-projekt är Node.js-projekt som genereras med Adobe I/O CLI och som följer en viss struktur som gör att de kan användas i Adobe I/O Runtime och integreras med AEM som Cloud Service. Ett enda Asset compute-projekt kan innehålla en eller flera Asset compute-arbetare, där var och en har en separat HTTP-slutpunkt som kan refereras från en AEM som en Cloud Service Processing Profile.

## Generera ett projekt

>[!VIDEO](https://video.tv.adobe.com/v/40197/?quality=12&learn=on)

_Klicka igenom för att generera ett Asset compute-projekt (inget ljud)_

Använd [Adobe I/O CLI Asset compute plugin](../set-up/development-environment.md#aio-cli) för att generera ett nytt, tomt Asset compute-projekt.

1. Navigera från kommandoraden till mappen som projektet ska innehålla.
1. Kör `aio app init` från kommandoraden för att påbörja den interaktiva projektgenereringen CLI.
   + Detta kan medföra att en webbläsare uppmanas att autentisera Adobe I/O. Om den gör det anger du dina inloggningsuppgifter för Adobe som är kopplade till de [Adobe-tjänster och -produkter som krävs](../set-up/accounts-and-services.md). Om du inte kan logga in följer du [dessa instruktioner för hur du skapar ett projekt](https://github.com/AdobeDocs/project-firefly/blob/master/getting_started/first_app.md#42-developer-is-not-logged-in-as-enterprise-organization-user).
1. __Välj organisation__
   + Markera den Adobe-organisation som har AEM som Cloud Service och som Project Fireworks är registrerad på
1. __Välj projekt__
   + Leta reda på och markera projektet. Det här är [projekttiteln](../set-up/firefly.md) som skapats från projektmallen Firefly, i det här fallet `WKND AEM Asset Compute`
1. __Välj arbetsyta__
   + Välj arbetsytan `Development`
1. __Vilka Adobe I/O App-funktioner vill du aktivera för det här projektet? Välj komponenter som ska inkluderas__
   + Välj `Actions: Deploy runtime actions`
   + Använd piltangenterna för att markera och avmarkera/markera samt Retur för att bekräfta markeringen
1. __Välj vilken typ av åtgärder som ska genereras__
   + Välj `Adobe Asset Compute Worker`
   + Använd piltangenterna för att markera, blanksteg för att avmarkera/markera och Retur för att bekräfta markeringen
1. __Hur vill du namnge den här åtgärden?__
   + Använd standardnamnet `worker`.
   + Om projektet innehåller flera arbetare som utför olika tillgångsberäkningar namnger du dem semantiskt

## Generera console.json

Kör följande kommando från roten för det nyskapade Asset compute-projektet för att generera ett `console.json`-värde.

```
$ aio app use
```

Kontrollera att den aktuella informationen om arbetsytan är korrekt, tryck på `Y` eller ange för att generera en `console.json`. Om `.env` och `.aio` identifieras som befintliga trycker du på `x` för att hoppa över skapandet av dem.

Om du skapar nya eller skriver över `.env` lägger du till nycklar/värden som saknas i nya `.env`:

```
## please provide the following environment variables for the Asset Compute devtool. You can use AWS or Azure, not both:
#ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH=
#S3_BUCKET=
#AWS_ACCESS_KEY_ID=
#AWS_SECRET_ACCESS_KEY=
#AWS_REGION=
#AZURE_STORAGE_ACCOUNT=
#AZURE_STORAGE_KEY=
#AZURE_STORAGE_CONTAINER_NAME=
```

## Granska projektets status

Det genererade Asset compute-projektet är ett Node.js-projekt för ett specialiserat Adobe Project Fire-projekt, och följande är idiosynkratiskt för Asset compute:

+ `/actions` innehåller undermappar och varje undermapp definierar en Asset compute-arbetare.
   + `/actions/<worker-name>/index.js` definierar det JavaScript som körs för att utföra arbetarens arbete.
      + Mappnamnet `worker` är standard och kan vara vad som helst, förutsatt att det är registrerat i `manifest.yml`.
      + Mer än en arbetsmapp kan definieras under `/actions` efter behov, men de måste registreras i `manifest.yml`.
+ `/test/asset-compute` innehåller testsviter för varje arbetare. Precis som mappen `/actions` kan `/test/asset-compute` innehålla flera undermappar, som alla motsvarar den arbetare som testas.
   + `/test/asset-compute/worker`, som representerar en testsvit för en viss arbetare, innehåller undermappar som representerar ett specifikt testfall, tillsammans med testindata, parametrar och förväntade utdata.
+ `/build` innehåller utdata, loggar och artefakter från Asset compute testfall.
+ `/manifest.yml` definierar vilka Asset compute-arbetare projektet ger. Varje implementering av arbetare måste räknas upp i den här filen för att de ska vara tillgängliga för AEM som en Cloud Service.
+ `/console.json` definierar Adobe I/O-konfigurationer
   + Filen kan genereras/uppdateras med kommandot `aio app use`.
+ `/.aio` innehåller konfigurationer som används av AIR CLI-verktyget.
   + Filen kan genereras/uppdateras med kommandot `aio app use`.
+ `/.env` definierar miljövariabler i en  `key=value` syntax och innehåller hemligheter som inte ska delas. Detta kan genereras eller För att skydda dessa hemligheter ska den här filen INTE checkas in i Git och ignoreras via projektets `.gitignore` standardfil.
   + Filen kan genereras/uppdateras med kommandot `aio app use`.
   + Variabler som definieras i den här filen kan åsidosättas av [export av variabler](../deploy/runtime.md) på kommandoraden.

Mer information om granskning av projektstruktur finns i [Anatomin för ett Adobe Project Firefoly-projekt](https://github.com/AdobeDocs/project-firefly/blob/master/getting_started/first_app.md#5-anatomy-of-a-project-firefly-application).

Huvuddelen av utvecklingen äger rum i `/actions`-mappen där arbetarna implementeras och i `/test/asset-compute` där tester för anpassade Asset compute-arbetare skrivs.

## asset compute-projekt på Github

Det slutliga Asset compute-projektet finns på Github:

+ [aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute)

_Github innehåller projektets sluttillstånd, som är fullt ifyllt med arbetaren och testfall, men som inte innehåller några autentiseringsuppgifter, t.ex. `.env`,  `console.json` eller  `.aio`._

