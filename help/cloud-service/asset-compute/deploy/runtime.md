---
title: Distribuera Asset compute-arbetare till Adobe I/O Runtime för användning med AEM as a Cloud Service
description: Asset compute-projekt, och de arbetare de innehåller, måste driftsättas i Adobe I/O Runtime för att kunna användas av AEM as a Cloud Service.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-6286
thumbnail: KT-6286.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 0327cf61-fd51-4fa7-856d-3febd49c01a0
duration: 128
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '645'
ht-degree: 0%

---

# Distribuera till Adobe I/O Runtime

Asset compute-projekt, och de arbetare de innehåller, måste driftsättas i Adobe I/O Runtime via Adobe I/O CLI för att kunna användas av AEM as a Cloud Service.

Vid distribution till Adobe I/O Runtime för användning av AEM as a Cloud Service författartjänster krävs bara två miljövariabler:

+ `AIO_runtime_namespace` pekar på arbetsytan i App Builder att distribuera till
+ `AIO_runtime_auth` är autentiseringsuppgifter för arbetsytan i App Builder

De andra standardvariablerna som definieras i `.env` filen anges implicit av AEM as a Cloud Service när den anropar Asset compute-arbetaren.

## Arbetsyta för utveckling

Eftersom det här projektet genererades med `aio app init` med `Development` arbetsyta, `AIO_runtime_namespace` ställs in automatiskt på `81368-wkndaemassetcompute-development` med matchningen `AIO_runtime_auth` på vår lokala `.env` -fil.  Om en `.env` filen finns i den katalog som används för att utfärda kommandot deploy, och dess värden används, såvida de inte ersätts via en variabelexport på operativsystemnivå, vilket är så [stadium och produktion](#stage-and-production) är avsedda för arbetsytor.

![driftsättning av aio-program med hjälp av .env-variabler](./assets/runtime/development__aio.png)

Distribuera till arbetsytan som definieras i projekten `.env` fil:

1. Öppna kommandoraden i roten av Asset compute-projektet
1. Kör kommandot `aio app deploy`
1. Kör kommandot `aio app get-url` för att hämta arbetarens URL för användning i den AEM as a Cloud Service bearbetningsprofilen som referens för den här anpassade Asset compute-arbetaren. Om projektet innehåller flera arbetare visas separata URL:er för varje arbetare.

Om lokala utvecklings- och AEM as a Cloud Service utvecklingsmiljöer använder separata Asset compute-distributioner kan distributioner till AEM as a Cloud Service Dev hanteras på samma sätt som [Distributioner av scen och produktion](#stage-and-production).

## Arbetsytor för scen och produktion{#stage-and-production}

Distributionen till arbetsytorna Stage och Production görs vanligtvis av valfritt CI/CD-system. Asset compute-projektet måste distribueras separat till varje arbetsyta (Stage och sedan Production).

Om du anger true-miljövariabler åsidosätts värden för variabler med samma namn i `.env`.

![driftsättning av aio-appar med exportvariabler](./assets/runtime/stage__export-and-aio.png)

Det allmänna tillvägagångssättet, som vanligtvis automatiseras av ett CI/CD-system, för distribution till scen- och produktionsmiljöer är:

1. Kontrollera [Adobe I/O CLI npm-modulen och Asset compute-plugin](../set-up/development-environment.md#aio) är installerade
1. Kolla in Asset compute-projektet att distribuera från Git
1. Ange miljövariablerna med de värden som motsvarar målarbetsytan (scen eller produktion)
   + De två variablerna som krävs är `AIO_runtime_namespace` och `AIO_runtime_auth` och hämtas per arbetsyta i Adobe I/O Developer Console via arbetsytans __Hämta alla__ -funktion.

![Adobe Developer Console - Namnutrymme för AIO-miljön och autentisering](./assets/runtime/stage-auth-namespace.png)

Du kan ange värden för dessa tangenter genom att ange exportkommandon från kommandoraden:

```
$ export AIO_runtime_namespace=81368-wkndaemassetcompute-stage
$ export AIO_runtime_auth=27100f9f-2676-4cce-b73d-b3fb6bac47d1:0tDu307W6MboQf5VWB1BAK0RHp8xWqSy1CQc3lKe7f63o3aNtAu0Y3nAmN56502W
```

Om dina Asset compute-arbetare behöver några andra variabler, till exempel molnlagring, bör de också exporteras som miljövariabler.

1. När alla miljövariabler har ställts in för målarbetsytan att distribuera till kör du kommandot deploy:
   + `aio app deploy`
1. URL:erna för arbetare som den AEM as a Cloud Service bearbetningsprofilen refererar till är också tillgängliga via:
   + `aio app get-url`.

Om projektversionen för Asset compute ändrar arbetarens URL:er ändras också så att de återspeglar den nya versionen, och URL:en måste uppdateras i bearbetningsprofilerna.

## API-etablering för arbetsyta{#workspace-api-provisioning}

När [konfigurera App Builder-projektet i Adobe I/O](../set-up/app-builder.md) en ny arbetsyta för utveckling skapades och __Asset compute, I/O-händelser__ och __API:er för I/O-händelsehantering__ har lagts till i den.

The __Asset compute, I/O-händelser__ och __API:er för I/O-händelsehantering__ APIS läggs bara till explicit i arbetsytorna som används för lokal utveckling. Arbetsytor som integreras (exklusivt) med AEM as a Cloud Service miljöer gör __not__ behöver dessa API:er läggas till explicit eftersom API:er görs naturligt tillgängliga för AEM as a Cloud Service.
