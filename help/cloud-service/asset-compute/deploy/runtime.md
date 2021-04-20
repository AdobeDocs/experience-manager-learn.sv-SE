---
title: Distribuera Asset compute-arbetare till Adobe I/O Runtime för användning med AEM som Cloud Service
description: 'asset compute-projekt, och de arbetare de innehåller, måste driftsättas i Adobe I/O Runtime för att AEM ska kunna användas som Cloud Service. '
feature: Asset Compute Microservices
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6286
thumbnail: KT-6286.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '656'
ht-degree: 0%

---


# Distribuera till Adobe I/O Runtime

asset compute-projekt, och de arbetare de innehåller, måste driftsättas i Adobe I/O Runtime via Adobe I/O CLI för att AEM ska kunna användas som Cloud Service.

Vid distribution till Adobe I/O Runtime för användning av AEM som Cloud Service Author-tjänster krävs endast två miljövariabler:

+ `AIO_runtime_namespace` leder till att arbetsytan Adobe Project Fire ska distribueras till
+ `AIO_runtime_auth` är autentiseringsuppgifterna för arbetsytan Adobe Project Fire

De andra standardvariablerna som definieras i filen `.env` anges implicit av AEM som en Cloud Service när den anropar Asset compute-arbetaren.

## Arbetsyta för utveckling

Eftersom det här projektet genererades med `aio app init` med arbetsytan `Development` ställs `AIO_runtime_namespace` automatiskt in på `81368-wkndaemassetcompute-development` med matchande `AIO_runtime_auth` i vår lokala `.env`-fil.  Om det finns en `.env`-fil i den katalog som användes för att utfärda kommandot deploy, används dess värden, såvida de inte ersätts via en variabelexport på operativsystemnivå, vilket är det som är målet för arbetsytorna [stage och production](#stage-and-production).

![driftsättning av aio-program med hjälp av .env-variabler](./assets/runtime/development__aio.png)

Så här distribuerar du till arbetsytan som definieras i projektfilen `.env`:

1. Öppna kommandoraden i roten av Asset compute-projektet
1. Kör kommandot `aio app deploy`
1. Kör kommandot `aio app get-url` för att hämta arbetarens URL för användning i AEM som en Cloud Service Processing Profile som referens till den här anpassade Asset compute-arbetaren. Om projektet innehåller flera arbetare visas separata URL:er för varje arbetare.

Om lokal utveckling och AEM som en Cloud Service Development-miljö använder separata Asset compute-distributioner, kan distributioner som ska AEM som en Cloud Service Dev hanteras på samma sätt som [Stage- och Production-distributioner](#stage-and-production).

## Arbetsytor för scen och produktion{#stage-and-production}

Distributionen till arbetsytorna Stage och Production görs vanligtvis av valfritt CI/CD-system. Asset compute-projektet måste distribueras separat till varje arbetsyta (Stage och sedan Production).

Om du anger true-miljövariabler åsidosätts värden för variabler med samma namn i `.env`.

![driftsättning av aio-appar med exportvariabler](./assets/runtime/stage__export-and-aio.png)

Det allmänna tillvägagångssättet, som vanligtvis automatiseras av ett CI/CD-system, för distribution till scen- och produktionsmiljöer är:

1. Kontrollera att [Adobe I/O CLI npm-modulen och Asset compute-plugin](../set-up/development-environment.md#aio) är installerade
1. Kolla in Asset compute-projektet att distribuera från Git
1. Ange miljövariablerna med de värden som motsvarar målarbetsytan (scen eller produktion)
   + De två obligatoriska variablerna är `AIO_runtime_namespace` och `AIO_runtime_auth` och hämtas per arbetsyta i Adobe I/O Developer Console via funktionen __Hämta alla__ i arbetsytan.

![Adobe Developer Console - Namespace och Auth för AIO Runtime](./assets/runtime/stage-auth-namespace.png)

Du kan ange värden för dessa tangenter genom att ange exportkommandon från kommandoraden:

```
$ export AIO_runtime_namespace=81368-wkndaemassetcompute-stage
$ export AIO_runtime_auth=27100f9f-2676-4cce-b73d-b3fb6bac47d1:0tDu307W6MboQf5VWB1BAK0RHp8xWqSy1CQc3lKe7f63o3aNtAu0Y3nAmN56502W
```

Om dina Asset compute-arbetare behöver några andra variabler, till exempel molnlagring, bör de också exporteras som miljövariabler.

1. När alla miljövariabler har ställts in för målarbetsytan att distribuera till kör du kommandot deploy:
   + `aio app deploy`
1. Arbetar-URL:erna som AEM refererar till som en Cloud Service Processing Profile är också tillgängliga via:
   + `aio app get-url`.

Om projektversionen för Asset compute ändrar arbetarens URL:er ändras också så att de återspeglar den nya versionen, och URL:en måste uppdateras i bearbetningsprofilerna.

## API-etablering för arbetsyta{#workspace-api-provisioning}

När [du konfigurerade Project Fire-projektet i Adobe I/O](../set-up/firefly.md) för att stödja lokal utveckling skapades en ny arbetsyta för utveckling och __API:er för Asset compute, I/O-händelser__ och __I/O-händelsehantering__ lades till i den.

API:erna __för I/O-händelser__ och __I/O-händelsehantering__ för Asset compute läggs endast uttryckligen till i arbetsytorna som används för lokal utveckling. Arbetsytor som integreras (exklusivt) med AEM som en Cloud Service-miljö behöver __inte__ dessa API:er som läggs till explicit eftersom API:erna görs naturligt tillgängliga för AEM som en Cloud Service.
