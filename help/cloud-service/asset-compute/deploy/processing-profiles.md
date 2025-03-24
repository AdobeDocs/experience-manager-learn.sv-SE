---
title: Integrera Asset Compute-arbetare med AEM bearbetningsprofiler
description: AEM as a Cloud Service kan integreras med Asset Compute-arbetare som driftsätts i Adobe I/O Runtime via AEM Assets bearbetningsprofiler. Bearbetningsprofiler konfigureras i redigeringstjänsten för att bearbeta specifika resurser med hjälp av anpassade arbetare och lagra de filer som arbetarna genererar som resursrenderingar.
feature: Asset Compute Microservices
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-6287
thumbnail: KT-6287.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 1b398c8c-6b4e-4046-b61e-b44c45f973ef
duration: 126
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '622'
ht-degree: 0%

---

# Integrera med AEM bearbetningsprofiler

För att Asset Compute-arbetare ska kunna generera anpassade renderingar i AEM as a Cloud Service måste de vara registrerade i AEM as a Cloud Service Author-tjänsten via Bearbeta profiler. För alla resurser som omfattas av den bearbetningsprofilen anropas arbetaren vid överföring eller ombearbetning, och den anpassade återgivningen genereras och görs tillgänglig via resursens återgivningar.

## Definiera en bearbetningsprofil

Skapa först en ny bearbetningsprofil som anropar arbetaren med konfigurerbara parametrar.

![Bearbetar profil](./assets/processing-profiles/new-processing-profile.png)

1. Logga in på AEM as a Cloud Service Author som __AEM Administrator__. Eftersom det här är en självstudiekurs rekommenderar vi att du använder en Dev-miljö eller en miljö i en sandlåda.
1. Navigera till __Verktyg > Assets > Bearbeta profiler__
1. Tryck på knappen __Skapa__
1. Namnge bearbetningsprofilen, `WKND Asset Renditions`
1. Tryck på fliken __Egen__ och tryck sedan på __Lägg till ny__
1. Definiera den nya tjänsten
   + __Återgivningsnamn:__ `Circle`
      + Återgivningens filnamn som användes för att identifiera återgivningen i AEM Assets
   + __Tillägg:__ `png`
      + Tillägget för den återgivning som skapas. Ange till `png` eftersom det här är det utdataformat som stöds av arbetarens webbtjänst, och ger en genomskinlig bakgrund bakom cirkeln som klipps ut.
   + __Slutpunkt:__ `https://...adobeioruntime.net/api/v1/web/wkndAemAssetCompute-0.0.1/worker`
      + Det här är URL:en till arbetaren som hämtas via `aio app get-url`. Kontrollera URL-punkterna på rätt arbetsyta baserat på AEM as a Cloud Service-miljön.
      + Kontrollera att arbetarens URL pekar på rätt arbetsyta. AEM as a Cloud Service Stage bör använda arbetsytans URL, och AEM as a Cloud Service Production bör använda arbetsytans URL.
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
      + Dessa nyckel/värde-par som skickas till Asset Compute-arbetaren och är tillgängliga via `rendition.instructions` JavaScript-objekt.
   + __MIME-typer__
      + __Innehåller:__ `image/jpeg`, `image/png`, `image/gif`, `image/bmp`, `image/tiff`
         + Dessa MIME-typer är de enda som arbetarens npm-moduler är. Den här listan begränsar vilka som bearbetas av den anpassade arbetaren.
      + __Utesluter:__ `Leave blank`
         + Bearbeta aldrig resurser med dessa MIME-typer med den här tjänstkonfigurationen. I det här fallet använder vi bara tillåtelselista.
1. Tryck på __Spara__ längst upp till höger

## Tillämpa och anropa en bearbetningsprofil

1. Välj den nya bearbetningsprofilen, `WKND Asset Renditions`
1. Tryck på __Använd profil för mapp(ar)__ i det övre åtgärdsfältet
1. Välj en mapp som bearbetningsprofilen ska användas på, till exempel `WKND`, och tryck på __Använd__
1. Navigera till den mapp där bearbetningsprofilen inte tillämpades via __AEM > Assets > Filer__ och tryck på `WKND`.
1. Överför några nya bildresurser ([sample-1.jpg](../assets/samples/sample-1.jpg), [sample-2.jpg](../assets/samples/sample-2.jpg) och [sample-3.jpg](../assets/samples/sample-3.jpg)) till en mapp under mappen där Bearbetningsprofilen används, och vänta tills den överförda resursen har bearbetats.
1. Tryck på resursen för att öppna dess information
   + Standardåtergivningar kan generera och visas snabbare i AEM än anpassade återgivningar.
1. Öppna vyn __Återgivningar__ från vänster sidofält
1. Tryck på resursen `Circle.png` och granska den genererade återgivningen

   ![Genererad återgivning](./assets/processing-profiles/rendition.png)

## Klart!

Grattis! Du har slutfört [självstudiekursen](../overview.md) om hur du utökar AEM as a Cloud Service Asset Compute mikrotjänster! Nu bör du kunna konfigurera, utveckla, testa, felsöka och driftsätta anpassade Asset Compute-arbetare som kan användas av AEM as a Cloud Service Author-tjänsten.

### Granska den fullständiga projektkällkoden på Github

Det slutliga Asset Compute-projektet finns på Github:

+ [aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute)

_Github innehåller projektets sluttillstånd, som är fullt ifyllt med arbetaren och testfall, men som inte innehåller några autentiseringsuppgifter, till exempel. `.env`, `.config.json` eller `.aio`._

## Felsökning

+ [Anpassad återgivning saknas i resurs i AEM](../troubleshooting.md#custom-rendition-missing-from-asset)
+ [Resursbearbetning misslyckas i AEM](../troubleshooting.md#asset-processing-fails)
