---
title: Felsöka AEM som en Cloud Service
description: på självbetjäning, skalbar molninfrastruktur, vilket gör att AEM utvecklare måste förstå och felsöka olika aspekter av AEM som en Cloud Service, från att bygga och driftsätta till att få information om AEM program som körs.
feature: null
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5346
translation-type: tm+mt
source-git-commit: debb65a218ae0b9e5105c3f63018358902330b34
workflow-type: tm+mt
source-wordcount: '308'
ht-degree: 1%

---


# Felsöka AEM som en Cloud Service

AEM som Cloud Service är det molnbaserade sättet att utnyttja de AEM programmen. AEM som Cloud Service använder självbetjäning, skalbar molninfrastruktur, vilket kräver att AEM utvecklare förstår och felsöker olika delar av AEM som en Cloud Service, från att bygga och driftsätta till att få information om hur AEM körs.

## Loggar

Loggarna innehåller information om hur ditt program fungerar i AEM som en Cloud Service, samt information om distributioner.

[Felsöka AEM som en Cloud Service med hjälp av loggar](./logs.md)

## Bygg och driftsätt

Adobe Cloud Manager-pipelines distribuerar AEM program genom en serie steg för att fastställa kodkvalitet och lönsamhet när de distribueras till AEM som en Cloud Service. Vart och ett av stegen kan resultera i fel, vilket gör det viktigt att förstå hur du felsöker byggen för att kunna fastställa grundorsaken till och hur du löser eventuella fel.

[Felsöka AEM som Cloud Service och driftsättning](./build-and-deployment.md)

## Developer Console

Developer Console innehåller en mängd information och introspectioner i AEM som en Cloud Service som är användbara för att förstå hur programmet känns igen av och fungerar i AEM som en Cloud Service.

[Felsöka AEM som en Cloud Service med Developer Console](./developer-console.md)

## CRXDE Lite

CRXDE Lite är ett klassiskt men ändå kraftfullt verktyg för felsökning AEM som utvecklingsmiljöer för Cloud Service. CRXDE Lite tillhandahåller en uppsättning funktioner som hjälper till att felsöka från att inspektera alla resurser och egenskaper, manipulera de ändringsbara delarna av den gemensamma handboken, undersöka behörigheter och utvärdera frågor.

[Felsöka AEM som en Cloud Service med CRXDE Lite](./crxde-lite.md)
