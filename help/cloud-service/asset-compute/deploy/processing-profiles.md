---
title: Integrera Asset compute-arbetare med AEM Bearbetningsprofiler
description: AEM som Cloud Service kan integreras med Asset compute-arbetare som driftsätts i Adobe I/O Runtime via AEM Assets bearbetningsprofiler. Bearbetningsprofiler konfigureras i redigeringstjänsten för att bearbeta specifika resurser med hjälp av anpassade arbetare och lagra de filer som arbetarna genererar som resursrenderingar.
feature: Asset Compute Microservices
topics: renditions, development
version: Cloud Service
activity: develop
audience: developer
doc-type: tutorial
kt: 6287
thumbnail: KT-6287.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 1b398c8c-6b4e-4046-b61e-b44c45f973ef
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '630'
ht-degree: 1%

---

# Integrera med AEM bearbetningsprofiler

För att Asset compute-arbetare ska kunna generera anpassade återgivningar i AEM som en Cloud Service måste de registreras i AEM som en Cloud Service Author-tjänst via Bearbeta profiler. För alla resurser som omfattas av den bearbetningsprofilen anropas arbetaren vid överföring eller ombearbetning, och den anpassade återgivningen genereras och görs tillgänglig via resursens återgivningar.

## Definiera en bearbetningsprofil

Skapa först en ny bearbetningsprofil som anropar arbetaren med konfigurerbara parametrar.

![Bearbetar profil](./assets/processing-profiles/new-processing-profile.png)

1. Logga in som Cloud Service Author-tjänst som __AEM Administrator__. Eftersom det här är en självstudiekurs rekommenderar vi att du använder en Dev-miljö eller en miljö i en sandlåda.
1. Navigera till __Verktyg > Resurser > Bearbeta profiler__
1. Tryck på knappen __Skapa__
1. Namnge bearbetningsprofilen, `WKND Asset Renditions`
1. Tryck på fliken __Anpassad__ och tryck på __Lägg till ny__
1. Definiera den nya tjänsten
   + __Återgivningsnamn:__ `Circle`
      + Filnamnsrenderingen som ska användas för att identifiera den här renderingen i AEM Assets
   + __Tillägg:__ `png`
      + Tillägget för den återgivning som ska genereras. Ange `png` eftersom det här är det utdataformat som stöds av arbetarens webbtjänst, och ger en genomskinlig bakgrund bakom cirkeln som klipps ut.
   + __Slutpunkt:__ `https://...adobeioruntime.net/api/v1/web/wkndAemAssetCompute-0.0.1/worker`
      + Det här är URL:en till arbetaren som hämtas via `aio app get-url`. Kontrollera URL-punkterna på rätt arbetsyta baserat på AEM som en Cloud Service.
      + Kontrollera att arbetarens URL pekar på rätt arbetsyta. AEM som Cloud Service ska använda arbetsytans URL och AEM som Cloud Service Production bör använda arbetsytans URL.
   + __Tjänsteparametrar__
      + Tryck på __Lägg till parameter__
         + Nyckel: `size`
         + Värde: `1000`
      + Tryck på __Lägg till parameter__
         + Nyckel: `contrast`
         + Värde: `0.25`
      + Tryck på __Lägg till parameter__
         + Nyckel: `brightness`
         + Värde: `0.10`
      + Dessa nyckel/värde-par som skickas till Asset compute-arbetaren och är tillgängliga via JavaScript-objektet `rendition.instructions`.
   + __Mime-typer__
      + __Innehåller:__ `image/jpeg`,  `image/png`,  `image/gif`,  `image/bmp`,  `image/tiff`
         + Dessa MIME-typer är de enda som arbetarens npm-moduler är. Den här listan begränsar vilka resurser som ska bearbetas av den anpassade arbetaren.
      + __Exkluderar:__ `Leave blank`
         + Bearbeta aldrig resurser med dessa MIME-typer med den här tjänstkonfigurationen. I det här fallet använder vi bara tillåtelselista.
1. Tryck på __Spara__ överst till höger

## Tillämpa och anropa en bearbetningsprofil

1. Välj den nya bearbetningsprofilen, `WKND Asset Renditions`
1. Tryck på __Använd profil för mapp(ar)__ i det övre åtgärdsfältet
1. Välj en mapp som bearbetningsprofilen ska användas på, till exempel `WKND` och tryck på __Använd__
1. Navigera till den mapp där bearbetningsprofilen inte tillämpades via __AEM > Resurser > Filer__ och tryck på `WKND`.
1. Överför några nya bildresurser ([sample-1.jpg](../assets/samples/sample-1.jpg), [sample-2.jpg](../assets/samples/sample-2.jpg) och [sample-3.jpg](../assets/samples/sample-3.jpg)) till en mapp under mappen där Bearbetningsprofilen används, och vänta tills den överförda resursen har bearbetats.
1. Tryck på resursen för att öppna dess information
   + Standardåtergivningar kan generera och visas snabbare i AEM än anpassade återgivningar.
1. Öppna vyn __Återgivningar__ från vänster sidofält
1. Tryck på resursen `Circle.png` och granska den genererade återgivningen

   ![Genererad återgivning](./assets/processing-profiles/rendition.png)

## Klart!

Grattis! Du har slutfört [självstudiekursen](../overview.md) om hur du utökar AEM som Cloud Service Asset compute-mikrotjänster! Nu bör du ha möjlighet att konfigurera, utveckla, testa, felsöka och distribuera anpassade Asset compute-arbetare som kan användas av din AEM som Cloud Service Author-tjänst.

### Granska den fullständiga projektkällkoden på Github

Det slutliga Asset compute-projektet finns på Github:

+ [aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute)

_Github innehåller projektets sluttillstånd, som är fullt ifyllt med arbetaren och testfall, men som inte innehåller några autentiseringsuppgifter, t.ex. `.env`,  `.config.json` eller  `.aio`._

## Felsökning

+ [Anpassad återgivning saknas för resurs i AEM](../troubleshooting.md#custom-rendition-missing-from-asset)
+ [Resursbearbetning misslyckas i AEM](../troubleshooting.md#asset-processing-fails)
