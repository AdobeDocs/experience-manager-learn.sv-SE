---
title: Felsökning AEM as a Cloud Service
description: på självbetjäning, skalbar molninfrastruktur, vilket gör att AEM utvecklare måste förstå och felsöka olika aspekter av AEM as a Cloud Service, från att bygga och driftsätta till att få information om hur AEM program körs.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
jira: KT-5346
topic: Development
role: Developer
level: Beginner, Intermediate
exl-id: 8092fbb4-234f-472e-a405-8a45734b7c65
duration: 60
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '314'
ht-degree: 0%

---

# Felsökning AEM as a Cloud Service

AEM as a Cloud Service är det molnbaserade sättet att utnyttja de AEM programmen. AEM as a Cloud Service använder självbetjäning, skalbar, molninfrastruktur, vilket kräver att AEM utvecklare förstår och felsöker olika aspekter av AEM as a Cloud Service, från att bygga och driftsätta till att få information om hur AEM körs.

## Loggar

Loggarna innehåller information om hur ditt program fungerar på AEM as a Cloud Service, samt information om problem med distributioner.

[Felsöka AEM as a Cloud Service med loggar](./logs.md)

## Bygg och driftsätt

Adobe Cloud Manager-pipelines distribuerar AEM program genom en serie steg för att fastställa kodkvalitet och lönsamhet när de distribueras till AEM as a Cloud Service. Vart och ett av stegen kan resultera i fel, vilket gör det viktigt att förstå hur du felsöker byggen för att kunna fastställa grundorsaken till och hur du löser eventuella fel.

[Felsökning AEM as a Cloud Service bygge och driftsättning](./build-and-deployment.md)

## Developer Console

På Developer Console finns en mängd information och introduktioner till AEM as a Cloud Service miljöer som är användbara för att förstå hur programmet känns igen av och fungerar på AEM as a Cloud Service.

[Felsökning AEM as a Cloud Service med Developer Console](./developer-console.md)

## Databasläsare

Databasläsaren är ett kraftfullt verktyg som ger synlighet i AEM underliggande datalager, vilket gör det enkelt att felsöka AEM as a Cloud Service miljö. Databasläsaren har stöd för en skrivskyddad vy över resurser och egenskaper för AEM på produktions-, scen- och utvecklingsstadiet samt författar-, publicerings- och förhandsgranskningstjänster.

[Felsöka AEM as a Cloud Service med Databasläsaren](./repository-browser.md)
