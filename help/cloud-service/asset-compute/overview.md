---
title: Asset Compute mikrotjänster för AEM as a Cloud Service
description: I den här självstudiekursen går du igenom hur du skapar en enkel Asset compute-arbetare som skapar en resursåtergivning genom att beskära den ursprungliga resursen till en cirkel och tillämpar konfigurerbar kontrast och ljusstyrka. Även om arbetaren själv är grundläggande används den här självstudiekursen för att utforska hur du skapar, utvecklar och distribuerar en anpassad Asset compute-arbetare som kan användas med AEM as a Cloud Service.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-5802
thumbnail: KT-5802.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
last-substantial-update: 2022-08-15T00:00:00Z
exl-id: 575b12f9-b57f-41f7-bd39-56d242de4747
duration: 277
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '986'
ht-degree: 0%

---

# Utbyggbarhet för mikrotjänster från asset compute

AEM som Cloud Servicens Asset compute-mikrotjänster stöder utveckling och driftsättning av specialarbetare som används för att läsa och hantera binära data för resurser som lagras i AEM, vanligtvis för att skapa anpassade återgivningar av resurser.

I AEM 6.x användes anpassade AEM arbetsflödesprocesser för att läsa, omvandla och skriva tillbaka resursrenderingar, men i AEM as a Cloud Service Asset compute tillgodoser arbetarna detta behov.

## Vad du ska göra

>[!VIDEO](https://video.tv.adobe.com/v/40965?quality=12&learn=on)

I den här självstudiekursen går du igenom hur du skapar en enkel Asset compute-arbetare som skapar en resursåtergivning genom att beskära den ursprungliga resursen till en cirkel och tillämpar konfigurerbar kontrast och ljusstyrka. Även om arbetaren själv är grundläggande används den här självstudiekursen för att utforska hur du skapar, utvecklar och distribuerar en anpassad Asset compute-arbetare som kan användas med AEM as a Cloud Service.

### Mål {#objective}

1. Tillhandahålla och upprätta nödvändiga konton och tjänster för att bygga och driftsätta en Asset compute-arbetare
1. Skapa och konfigurera ett Asset compute-projekt
1. Utveckla en Asset compute-arbetare som genererar en anpassad återgivning
1. Skriv tester för och lär dig felsöka den anpassade Asset compute-arbetaren
1. Installera Asset Compute-arbetaren och integrera den med AEM as a Cloud Service Author-tjänsten via Bearbeta profiler

## Konfigurera

Lär dig hur du förbereder dig för att utöka Asset compute och förstå vilka tjänster och konton som måste tillhandahållas och konfigureras samt vilken programvara som ska installeras lokalt för utveckling.

### Konto- och tjänsteetablering{#accounts-and-services}

Följande konton och tjänster kräver etablering och åtkomst för att kunna slutföra självstudiekursen, AEM as a Cloud Service Dev-miljön eller sandlådeprogrammet, åtkomst till App Builder och Microsoft Azure Blob Storage.

+ [Tillhandahållningskonton och tjänster](./set-up/accounts-and-services.md)

### Lokal utvecklingsmiljö

Lokal utveckling av projekt i Asset Compute kräver en särskild uppsättning utvecklingsverktyg, som skiljer sig från traditionell AEM, t.ex. Microsoft Visual Studio Code, Docker Desktop, Node.js och stöd för npm-moduler.

+ [Konfigurera lokal utvecklingsmiljö](./set-up/development-environment.md)

### App Builder

Asset Compute-projekt är särskilt definierade App Builder-projekt, och som sådana kräver de tillgång till App Builder i Adobe Developer Console för att de ska kunna installeras och driftsättas.

+ [Konfigurera App Builder](./set-up/app-builder.md)

## Utveckla

Lär dig hur du skapar och konfigurerar ett Asset Compute-projekt och sedan utvecklar en anpassad arbetare som genererar en skräddarsydd resursåtergivning.

### Skapa ett nytt Asset Compute-projekt

Asset Compute-projekt, som innehåller en eller flera Asset compute-arbetare, genereras med den interaktiva CLI-funktionen för Adobe I/O. Asset Compute-projekt är särskilt strukturerade App Builder-projekt, som i sin tur är Node.js-projekt.

+ [Skapa ett nytt Asset Compute-projekt](./develop/project.md)

### Konfigurera miljövariabler

Miljövariabler behålls i filen `.env` för lokal utveckling och används för att ange autentiseringsuppgifter för Adobe I/O och molnlagring som krävs för lokal utveckling.

+ [Konfigurera miljövariabler](./develop/environment-variables.md)

### Konfigurera manifest.yml

Asset Compute-projekt innehåller manifest som definierar alla arbetare i Asset compute som projektet omfattar, samt vilka resurser de har tillgängliga när de distribueras till Adobe I/O Runtime för utförande.

+ [Konfigurera manifest.yml](./develop/manifest.md)

### Utveckla en arbetare

Att utveckla en Asset compute-arbetare är kärnan i att utöka Asset compute-mikrotjänsterna, eftersom arbetaren innehåller den anpassade kod som genererar, eller koordinerar, genereringen av den resulterande resursåtergivningen.

+ [Utveckla en Asset compute-arbetare](./develop/worker.md)

### Använda utvecklingsverktyget Asset compute

Asset Compute Development Tool är en lokal webbfunktion för driftsättning, körning och förhandsgranskning av arbetarangivna renderingar som stöder snabb och iterativ utveckling av Asset compute-arbetare.

+ [Använda utvecklingsverktyget Asset compute](./develop/development-tool.md)

## Testa och felsöka

Lär dig hur du testar arbetare på Asset compute för att vara säkra på hur de fungerar och felsöker Asset compute för att förstå och felsöka hur den anpassade koden körs.

### Testa en arbetare

Asset compute tillhandahåller ett testramverk för att skapa testsviter för arbetare, vilket gör det enkelt att definiera tester som säkerställer korrekt beteende.

+ [Testa en arbetare](./test-debug/test.md)

### Felsöka en arbetare

Asset compute-arbetare erbjuder olika nivåer av felsökning från traditionella `console.log(..)`-utdata, till integrering med __VS-kod__ och __wskdebug__, vilket gör att utvecklare kan stega igenom arbetskoden när den körs i realtid.

+ [Felsöka en arbetare](./test-debug/debug.md)

## Distribuera

Lär dig hur du integrerar egna Asset compute-arbetare med AEM as a Cloud Service genom att först distribuera dem till Adobe I/O Runtime och sedan starta från AEM as a Cloud Service Author via AEM Assets bearbetningsprofiler.

### Distribuera till Adobe I/O Runtime

Asset compute-arbetare måste driftsättas i Adobe I/O Runtime för att kunna användas tillsammans med AEM as a Cloud Service.

+ [Använda Bearbeta profiler](./deploy/runtime.md)

### Integrera arbetare via AEM

När du har distribuerat till Adobe I/O Runtime kan du registrera arbetare från Asset compute i AEM as a Cloud Service via [Assets bearbetningsprofiler](../../assets/configuring/processing-profiles.md). Bearbetningsprofiler tillämpas i sin tur på resursmappar som tillämpas på resurserna i dem.

+ [Integrera med AEM bearbetningsprofiler](./deploy/processing-profiles.md)

## Avancerat

De här förkortade självstudiekurserna tar upp mer avancerade användningsfall som bygger på grundläggande inlärningar i de föregående kapitlen.

+ [Utveckla en metadataarbetare i Asset compute](./advanced/metadata.md) som kan skriva tillbaka metadata till

## Codebase on Github

Självstudiekursens kodbas finns på Github:

+ [adobe/aem-guides-wknd-asset-compute](https://github.com/adobe/aem-guides-wknd-asset-compute) @ huvudgren

Källkoden innehåller inte de nödvändiga `.env`- eller `config.json`-filerna. Dessa måste läggas till och konfigureras med din [konto- och ](#accounts-and-services)-information.

## Ytterligare resurser

Nedan följer olika Adobe-resurser som ger mer information och användbara API:er och SDK:er för att utveckla Asset compute.

### Dokumentation

+ [Asset compute Service-dokumentation](https://experienceleague.adobe.com/docs/asset-compute/using/extend/understand-extensibility.html)
+ [Viktigt om Asset Compute Development Tool](https://github.com/adobe/asset-compute-devtool)
+ [Asset compute exempelarbetare](https://github.com/adobe/asset-compute-example-workers)

### API:er och SDK:er

+ [Asset compute SDK](https://github.com/adobe/asset-compute-sdk)
   + [Kommandon för Asset compute](https://github.com/adobe/asset-compute-commons)
   + [Asset compute XMP](https://github.com/adobe/asset-compute-xmp#readme)
+ [Adobe Cloud Blobstore Wrapper-bibliotek](https://github.com/adobe/node-cloud-blobstore-wrapper)
+ [Adobe Node Fetch Retry Library](https://github.com/adobe/node-fetch-retry)
+ [Asset compute exempelarbetare](https://github.com/adobe/asset-compute-example-workers)
