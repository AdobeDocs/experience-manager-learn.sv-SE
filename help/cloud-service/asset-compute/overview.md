---
title: Resursberäkning - mikrotjänster, utbyggbarhet för AEM som Cloud Service
description: I den här självstudiekursen går du igenom hur du skapar en enkel resursåtergivning som skapar en resursåtergivning genom att beskära den ursprungliga resursen till en cirkel och tillämpar konfigurerbar kontrast och intensitet. Även om arbetaren själv är grundläggande använder den här självstudien den för att utforska hur en anpassad resursberäkningarbetare skapas, utvecklas och distribueras för användning med AEM som Cloud Service.
feature: asset-compute
topics: renditions, development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5802
thumbnail: KT-5802.jpg
translation-type: tm+mt
source-git-commit: ecee5f83dc778b016b6d236c1e3bcc4919ee55a7
workflow-type: tm+mt
source-wordcount: '944'
ht-degree: 0%

---


# Resursberäkning - mikrotjänster, utbyggbarhet

AEM som Cloud Servicens Asset Compute-mikrotjänster stöder utveckling och driftsättning av specialarbetare som används för att läsa och hantera binära data för resurser som lagras i AEM, vanligtvis för att skapa anpassade resursåtergivningar.

I AEM 6.x användes anpassade AEM arbetsflödesprocesser för att läsa, omvandla och skriva tillbaka resursrenderingar, AEM som en Cloud Service Asset Compute-arbetare tillgodoser detta behov.

## Vad du ska göra

>[!VIDEO](https://video.tv.adobe.com/v/40965?quality=12&learn=on)

I den här självstudiekursen går du igenom hur du skapar en enkel resursåtergivning som skapar en resursåtergivning genom att beskära den ursprungliga resursen till en cirkel och tillämpar konfigurerbar kontrast och intensitet. Även om arbetaren själv är grundläggande använder den här självstudien den för att utforska hur en anpassad resursberäkningarbetare skapas, utvecklas och distribueras för användning med AEM som Cloud Service.

### Mål {#objective}

1. Tillhandahålla och konfigurera nödvändiga konton och tjänster för att skapa och distribuera en Asset Compute-arbetare
1. Skapa och konfigurera ett tillgångsberäkningsprojekt
1. Arbetare för att skapa en anpassad återgivning för am Asset Compute
1. Skriv tester för och lär dig hur du felsöker arbetaren för beräkning av anpassade resurser
1. Distribuera resurshanteringsarbetaren och integrera den AEM som en Cloud Service Author-tjänst via Bearbeta profiler

## Konfigurera

Lär dig hur du förbereder dig för att utöka tillgångsberäkningspersonal och hur du förstår vilka tjänster och konton som måste etableras och konfigureras samt vilken programvara som ska installeras lokalt för utveckling.

### Konto- och tjänsteetablering

Följande konton och tjänster kräver etablering och åtkomst för att kunna slutföra självstudiekursen, AEM som en Cloud Service Dev-miljö eller sandlådeprogram, tillgång till Adobe Project Fire och Microsoft Azure Blob Storage.

+ [Konton och tjänster](./set-up/accounts-and-services.md)

### Lokal utvecklingsmiljö

Lokal utveckling av applikationer för Asset Compute kräver en särskild uppsättning utvecklingsverktyg, som skiljer sig från traditionell AEM, som: Microsoft Visual Studio Code, Docker Desktop, Node.js och tillhörande npm-moduler.

+ [Konfigurera lokal utvecklingsmiljö](./set-up/development-environment.md)

### Adobe Project Fire

Resursberäkningsprojekt är särskilt definierade Adobe Project Fire-program, och därför krävs åtkomst till Adobe Project Fire i Adobe Developer Console för att de ska kunna installeras och distribueras.

+ [Konfigurera Adobe Project Fire](./set-up/firefly.md)

## Utveckla

Lär dig hur du skapar och konfigurerar ett tillgångsberäkningsprojekt och sedan utvecklar en anpassad arbetare som genererar en skräddarsydd resursåtergivning.

### Skapa ett nytt tillgångsberäkningsprojekt

Resursberäkningsprojekt, som innehåller en eller flera tillgångsberäkningspersonal, genereras med den interaktiva Adobe I/O CLI. Resursberäkningsprogram är särskilt strukturerade Adobe Project Fire-program, som i sin tur är Node.js-program.

+ [Skapa ett nytt tillgångsberäkningsprojekt](./develop/project.md)

### Konfigurera miljövariabler

Miljövariabler lagras i filen för lokal utveckling och används för att ange Adobe I/O-autentiseringsuppgifter och autentiseringsuppgifter för molnlagring som krävs för lokal utveckling. `.env`

+ [Konfigurera miljövariabler](./develop/environment-variables.md)

### Konfigurera manifest.yml

Programmen för tillgångsberäkning innehåller manifest som definierar alla tillgångsberäkningspersonal som finns i projektet, samt vilka resurser de har tillgängliga när de distribueras till Adobe I/O Runtime för körning.

+ [Konfigurera manifest.yml](./develop/manifest.md)

### Utveckla en arbetare

Att utveckla en Asset Compute-arbetare är kärnan i att utöka Asset Compute-mikrotjänsterna eftersom arbetaren innehåller den anpassade koden som genererar, eller koordinerar, genereringen av den resulterande resursåtergivningen.

+ [Utveckla en Asset Compute-arbetare](./develop/worker.md)

### Använda verktyget Resursberäkning

Verktyget Resursberäkning ger en lokal webbfunktion för driftsättning, körning och förhandsgranskning av arbetarangivna återgivningar, med stöd för snabb och iterativ utveckling av resursberäknande arbetare.

+ [Använda verktyget Resursberäkning](./develop/development-tool.md)

## Testa och felsöka

Lär dig hur du testar arbetare som utför en anpassad tillgångsberäkning för att vara säkra på hur de fungerar, och felsök arbetare som arbetar med tillgångsberäkning för att förstå och felsöka hur den anpassade koden körs.

### Testa en arbetare

Asset Compute är ett testramverk för att skapa testsviter för arbetare, vilket gör det enkelt att definiera tester som säkerställer korrekt beteende.

+ [Testa en arbetare](./test-debug/test.md)

### Felsöka en arbetare

Programmen för tillgångsberäkning erbjuder olika nivåer av felsökning, från traditionella `console.log(..)` utdata till integreringar med __VS-kod__ och __wskdebug__, vilket gör att utvecklare kan stega igenom arbetskoden när den körs i realtid.

+ [Felsöka en arbetare](./test-debug/debug.md)

## Distribuera

Lär dig hur du integrerar skräddarsydda tillgångsberäkningspersonal med AEM som Cloud Service genom att först distribuera dem till Adobe I/O Runtime och sedan anropa dem från AEM som Cloud Service Author via AEM Assets Processing Profiles.

### Distribuera till Adobe I/O Runtime

Resursberäkningspersonal måste distribueras till Adobe I/O Runtime för att kunna användas med AEM som Cloud Service.

+ [Använda Bearbeta profiler](./deploy/runtime.md)

### Integrera arbetare via AEM

När de distribuerats till Adobe I/O Runtime kan resursberäkningspersonal registreras i AEM som en Cloud Service via [resursbearbetningsprofiler](../../assets/configuring/processing-profiles.md). Bearbetningsprofiler tillämpas i sin tur på resursmappar som tillämpas på resurserna i dem.

+ [Integrera med AEM bearbetningsprofiler](./deploy/processing-profiles.md)

## Ytterligare resurser

Nedan följer olika Adobe-resurser som ger mer information och användbara API:er och SDK:er för att utveckla resurshanteringspersonal.

### Dokumentation

+ [Dokumentation för tjänsten Resursberäkning](https://docs.adobe.com/content/help/en/asset-compute/using/extend/understand-extensibility.html)
+ [Viktigt om verktyget för beräkning av tillgångar](https://github.com/adobe/asset-compute-devtool)

### Andra kodexempel

+ [Exempelarbetare för tillgångsberäkning](https://github.com/adobe/asset-compute-example-workers)

### API:er och SDK:er

+ [SDK för tillgångsberäkning](https://github.com/adobe/asset-compute-sdk)
   + [Kommandon för beräkning av tillgångar](https://github.com/adobe/asset-compute-commons)
+ [Adobe Cloud Blobstore Wrapper-bibliotek](https://github.com/adobe/node-cloud-blobstore-wrapper)
+ [Bibliotek för hämtning av Adobe-nod](https://github.com/adobe/node-fetch-retry)
