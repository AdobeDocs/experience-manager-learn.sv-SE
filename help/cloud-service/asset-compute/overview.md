---
title: asset compute mikrotjänster för AEM as a Cloud Service
description: I den här självstudiekursen går du igenom hur du skapar en enkel Asset compute-arbetare som skapar en resursåtergivning genom att beskära den ursprungliga resursen till en cirkel och tillämpar konfigurerbar kontrast och ljusstyrka. Även om arbetaren själv är grundläggande används den här självstudien för att utforska hur du skapar, utvecklar och distribuerar en anpassad Asset compute-arbetare för användning med AEM as a Cloud Service.
feature: Asset Compute Microservices
topics: renditions, development
version: Cloud Service
doc-type: tutorial
activity: develop
audience: developer
kt: 5802
thumbnail: KT-5802.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 575b12f9-b57f-41f7-bd39-56d242de4747
source-git-commit: eb6a7ef343a43000855f8d5cc69bde0fae81d3e6
workflow-type: tm+mt
source-wordcount: '1020'
ht-degree: 0%

---

# Utbyggbarhet för mikrotjänster från asset compute

AEM som Cloud Servicens Asset compute-mikrotjänster stöder utveckling och driftsättning av specialarbetare som används för att läsa och hantera binära data för resurser som lagras i AEM, vanligtvis för att skapa anpassade resursåtergivningar.

I AEM 6.x användes anpassade AEM arbetsflödesprocesser för att läsa, omvandla och skriva tillbaka återgivningar av resurser, men AEM as a Cloud Service Asset compute-arbetare tillgodoser detta behov.

## Vad du ska göra

>[!VIDEO](https://video.tv.adobe.com/v/40965?quality=12&learn=on)

I den här självstudiekursen går du igenom hur du skapar en enkel Asset compute-arbetare som skapar en resursåtergivning genom att beskära den ursprungliga resursen till en cirkel och tillämpar konfigurerbar kontrast och ljusstyrka. Även om arbetaren själv är grundläggande används den här självstudien för att utforska hur du skapar, utvecklar och distribuerar en anpassad Asset compute-arbetare för användning med AEM as a Cloud Service.

### Mål {#objective}

1. Tillhandahålla och upprätta nödvändiga konton och tjänster för att bygga och driftsätta en Asset compute-arbetare
1. Skapa och konfigurera ett Asset compute-projekt
1. Utveckla am Asset compute-arbetare som skapar en anpassad återgivning
1. Skriv tester för och lär dig hur du felsöker den anpassade Asset compute-arbetaren
1. Distribuera Asset compute-arbetaren och integrera den AEM as a Cloud Service Author-tjänsten via Bearbeta profiler

## Konfigurera

Lär dig hur du förbereder dig för att utöka Asset compute och förstå vilka tjänster och konton som måste tillhandahållas och konfigureras samt vilken programvara som ska installeras lokalt för utveckling.

### Konto- och tjänsteetablering{#accounts-and-services}

Följande konton och tjänster kräver etablering och åtkomst för att kunna slutföra självstudiekursen, AEM as a Cloud Service Dev-miljön eller sandbox-programmet, åtkomst till App Builder och Microsoft Azure Blob Storage.

+ [Konton och tjänster](./set-up/accounts-and-services.md)

### Lokal utvecklingsmiljö

Lokal utveckling av projekt i Asset compute kräver en särskild uppsättning utvecklingsverktyg, som skiljer sig från traditionell AEM, bland annat: Microsoft Visual Studio Code, Docker Desktop, Node.js och tillhörande npm-moduler.

+ [Konfigurera lokal utvecklingsmiljö](./set-up/development-environment.md)

### App Builder

asset compute-projekt är särskilt definierade App Builder-projekt, och därför måste du ha tillgång till App Builder på Adobe Developer Console för att kunna konfigurera och distribuera dem.

+ [Konfigurera App Builder](./set-up/app-builder.md)

## Utveckla

Lär dig hur du skapar och konfigurerar ett Asset compute-projekt och sedan utvecklar en anpassad arbetare som genererar en skräddarsydd resursåtergivning.

### Skapa ett nytt Asset compute-projekt

asset compute-projekt, som innehåller en eller flera Asset compute-arbetare, genereras med den interaktiva CLI-funktionen för Adobe I/O. asset compute-projekt är särskilt strukturerade App Builder-projekt, som i sin tur är Node.js-projekt.

+ [Skapa ett nytt Asset compute-projekt](./develop/project.md)

### Konfigurera miljövariabler

Miljövariabler bevaras i `.env` -fil för lokal utveckling, och används för att ange autentiseringsuppgifter för Adobe I/O och molnlagring som krävs för lokal utveckling.

+ [Konfigurera miljövariabler](./develop/environment-variables.md)

### Konfigurera manifest.yml

asset compute-projekt innehåller manifest som definierar alla arbetare i Asset compute som projektet omfattar, samt vilka resurser de har tillgängliga när de distribueras till Adobe I/O Runtime för utförande.

+ [Konfigurera manifest.yml](./develop/manifest.md)

### Utveckla en arbetare

Att utveckla en Asset compute-arbetare är kärnan i att utöka Asset compute-mikrotjänsterna, eftersom arbetaren innehåller den anpassade kod som genererar, eller koordinerar, genereringen av den resulterande resursåtergivningen.

+ [Utveckla en Asset compute-arbetare](./develop/worker.md)

### Använda utvecklingsverktyget Asset compute

Asset compute Development Tool är en lokal webbfunktion för driftsättning, körning och förhandsgranskning av arbetarangivna renderingar som stöder snabb och iterativ utveckling av Asset compute-arbetare.

+ [Använda utvecklingsverktyget Asset compute](./develop/development-tool.md)

## Testa och felsöka

Lär dig hur du testar arbetare på Asset compute för att vara säkra på hur de fungerar och felsöker Asset compute för att förstå och felsöka hur den anpassade koden körs.

### Testa en arbetare

asset compute tillhandahåller ett testramverk för att skapa testsviter för arbetare, vilket gör det enkelt att definiera tester som säkerställer korrekt beteende.

+ [Testa en arbetare](./test-debug/test.md)

### Felsöka en arbetare

asset compute-arbetare erbjuder olika nivåer av felsökning från traditionella `console.log(..)` till integreringar med __VS-kod__ och  __wskdebug__, vilket gör att utvecklare kan stega igenom arbetskoden när den körs i realtid.

+ [Felsöka en arbetare](./test-debug/debug.md)

## Distribuera

Lär dig hur du integrerar anpassade Asset compute-arbetare med AEM as a Cloud Service genom att först distribuera dem till Adobe I/O Runtime och sedan starta från AEM as a Cloud Service författare via AEM Assets-bearbetningsprofiler.

### Distribuera till Adobe I/O Runtime

asset compute-arbetare måste placeras i Adobe I/O Runtime för att kunna användas tillsammans med AEM as a Cloud Service.

+ [Använda Bearbeta profiler](./deploy/runtime.md)

### Integrera arbetare via AEM

När de har driftsatts i Adobe I/O Runtime kan Asset compute-arbetare registreras i AEM as a Cloud Service via [Resurshanteringsprofiler](../../assets/configuring/processing-profiles.md). Bearbetningsprofiler tillämpas i sin tur på resursmappar som tillämpas på resurserna i dem.

+ [Integrera med AEM bearbetningsprofiler](./deploy/processing-profiles.md)

## Avancerat

De här förkortade självstudiekurserna tar upp mer avancerade användningsfall som bygger på grundläggande inlärningar i de föregående kapitlen.

+ [Utveckla en metadataarbetare i Asset compute](./advanced/metadata.md) som kan skriva tillbaka metadata till

## Codebase on Github

Självstudiekursens kodbas finns på Github:

+ [adobe/aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute) @ överordnad gren

Källkoden innehåller inte den nödvändiga `.env` eller `config.json` filer. Dessa måste läggas till och konfigureras med [konton och tjänster](#accounts-and-services) information.

## Ytterligare resurser

Nedan följer olika Adobe-resurser som ger mer information och användbara API:er och SDK:er för att utveckla Asset compute.

### Dokumentation

+ [asset compute Service-dokumentation](https://experienceleague.adobe.com/docs/asset-compute/using/extend/understand-extensibility.html)
+ [Viktigt om verktyget asset compute Development Tool](https://github.com/adobe/asset-compute-devtool)
+ [asset compute exempelarbetare](https://github.com/adobe/asset-compute-example-workers)

### API:er och SDK:er

+ [asset compute SDK](https://github.com/adobe/asset-compute-sdk)
   + [asset compute Commons](https://github.com/adobe/asset-compute-commons)
   + [asset compute XMP](https://github.com/adobe/asset-compute-xmp#readme)
+ [Adobe Cloud Blobstore Wrapper-bibliotek](https://github.com/adobe/node-cloud-blobstore-wrapper)
+ [Bibliotek för hämtning av Adobe-nod](https://github.com/adobe/node-fetch-retry)
+ [asset compute exempelarbetare](https://github.com/adobe/asset-compute-example-workers)
