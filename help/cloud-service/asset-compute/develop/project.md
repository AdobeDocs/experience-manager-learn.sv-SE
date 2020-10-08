---
title: Skapa ett tillgångsberäkningsprojekt för resursberäkningens utbyggbarhet
description: Beräkningsprojekt för tillgångar är Node.js-projekt, som genereras med Adobe I/O CLI, som följer en viss struktur som gör att de kan distribueras till Adobe I/O Runtime och integreras med AEM som en Cloud Service.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6269
thumbnail: 40197.jpg
translation-type: tm+mt
source-git-commit: 3a3832a05ed9598d970915adbc163254c6eb83f1
workflow-type: tm+mt
source-wordcount: '675'
ht-degree: 0%

---


# Skapa ett tillgångsberäkningsprojekt

Beräkningsprojekt för tillgångar är Node.js-projekt, som genereras med Adobe I/O CLI, som följer en viss struktur som gör att de kan distribueras till Adobe I/O Runtime och integreras med AEM som en Cloud Service. Ett enskilt tillgångsberäkningsprojekt kan innehålla en eller flera tillgångsberäkningarbetare, där var och en har en separat HTTP-slutpunktsreferens från en AEM som en Cloud Service Processing Profile.

## Generera ett projekt

>[!VIDEO](https://video.tv.adobe.com/v/40197/?quality=12&learn=on)

_Klicka igenom för att generera ett tillgångsberäkningsprojekt (inget ljud)_


Använd plugin-programmet [för beräkning av CLI-tillgångar i](../set-up/development-environment.md#aio-cli) Adobe för att generera ett nytt, tomt resursberäkningsprojekt.

1. Navigera från kommandoraden till mappen som projektet ska innehålla.
1. Kör från kommandoraden `aio app init` för att påbörja genereringen av det interaktiva projektet CLI.
   + Detta kan leda till att en webbläsare uppmanas att autentisera sig för Adobe I/O. Om så är fallet anger du dina inloggningsuppgifter för Adobe som är kopplade till de [Adobe-tjänster och -produkter](../set-up/accounts-and-services.md)som krävs. Om du inte kan logga in följer du dessa instruktioner för hur du skapar ett projekt.
1. __Välj organisation__
   + Markera den Adobe-organisation som har AEM som Cloud Service och som Project Fireworks är registrerad på
1. __Välj projekt__
   + Leta reda på och markera projektet. Det här är [projekttiteln](../set-up/firefly.md) som skapats från projektmallen Firefly, i det här fallet `WKND AEM Asset Compute`
1. __Välj arbetsyta__
   + Markera `Development` arbetsytan
1. __Vilka Adobe I/O-appfunktioner vill du aktivera för det här projektet? Välj komponenter som ska inkluderas__
   + Välj `Actions: Deploy runtime actions`
   + Använd piltangenterna för att markera och avmarkera/markera samt Retur för att bekräfta markeringen
1. __Välj vilken typ av åtgärder som ska genereras__
   + Välj `Adobe Asset Compute Worker`
   + Använd piltangenterna för att markera, blanksteg för att avmarkera/markera och Retur för att bekräfta markeringen
1. __Hur vill du namnge den här åtgärden?__
   + Använd standardnamnet `worker`.
   + Om projektet innehåller flera arbetare som utför olika tillgångsberäkningar namnger du dem semantiskt

## Granska projektets status

Det genererade projektet Asset Compute är ett Node.js-projekt för ett specialiserat projekt i Adobe Project Fire. Följande är idiosynkratiskt med projektet Asset Compute:

+ `/actions` innehåller undermappar och varje undermapp definierar en Asset Compute-arbetare.
   + `/actions/<worker-name>/index.js` definierar det JavaScript som körs för att utföra arbetarens arbete.
      + Mappnamnet `worker` är standard och kan vara vad som helst, så länge som det är registrerat i `manifest.yml`.
      + Mer än en arbetsmapp kan definieras under `/actions` efter behov, men de måste registreras i `manifest.yml`.
+ `/test/asset-compute` innehåller testsviter för varje arbetare. På samma sätt som `/actions` mappen kan `/test/asset-compute` innehålla flera undermappar, som alla motsvarar den arbetare som testas.
   + `/test/asset-compute/worker`, som representerar en testsvit för en viss arbetare, innehåller undermappar som representerar ett specifikt testfall, tillsammans med testindata, parametrar och förväntade utdata.
+ `/build` innehåller utdata, loggar och artefakter från testkörningar av tillgångar.
+ `/manifest.yml` definierar vilka tillgångsberäkningarbetare projektet ger. Varje implementering av arbetare måste räknas upp i den här filen för att de ska vara tillgängliga för AEM som en Cloud Service.
+ `/.aio` innehåller konfigurationer som används av AIR CLI-verktyget. Den här filen kan konfigureras via `aio config` kommandot.
+ `/.env` definierar miljövariabler i en `key=value` syntax och innehåller hemligheter som inte ska delas. För att skydda dessa hemligheter bör den här filen INTE checkas in i Git och ignoreras via projektets standardfil `.gitignore` .
   + Variabler som definieras i den här filen kan åsidosättas genom [att variabler](../deploy/runtime.md) exporteras på kommandoraden.

Mer information om granskning av projektstruktur finns i [Anatomin för ett projekt](https://github.com/AdobeDocs/project-firefly/blob/master/getting_started/first_app.md#5-anatomy-of-a-project-firefly-application)i Adobe Project Firefoly.

Största delen av utvecklingen sker i mappen där arbetarna implementeras och i `/actions` `/test/asset-compute` skrivtest för de anpassade resurshanteringspersonerna.

## Resursberäkningsprojekt på Github

Det slutliga projektet Asset Compute finns på Github:

+ [aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute)

_Github innehåller projektets sluttillstånd, som är fullt ifyllt med arbetaren och testfall, men som inte innehåller några autentiseringsuppgifter, t.ex.`.env`,`.config.json`eller`.aio`._