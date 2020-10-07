---
title: Distribuera Asset Compute-arbetare till Adobe I/O Runtime för användning med AEM som Cloud Service
description: 'Resursberäkningsprojekt, och de arbetare de innehåller, måste distribueras till Adobe I/O Runtime för att kunna användas av AEM som Cloud Service. '
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6286
thumbnail: KT-6286.jpg
translation-type: tm+mt
source-git-commit: af610f338be4878999e0e9812f1d2a57065d1829
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---


# Distribuera till Adobe I/O Runtime

Beräkningsprojekt för tillgångar, och de arbetare de innehåller, måste distribueras till Adobe I/O Runtime via Adobe I/O CLI för att AEM ska kunna användas som Cloud Service.

Vid distribution till Adobe I/O Runtime för användning av AEM som Cloud Service Author-tjänster krävs endast två miljövariabler:

+ `AIO_runtime_namespace` leder till att arbetsytan Adobe Project Fire ska distribueras till
+ `AIO_runtime_auth` är autentiseringsuppgifterna för arbetsytan Adobe Project Fire

De andra standardvariablerna som definieras i `.env` filen tillhandahålls implicit av AEM som en Cloud Service när den anropar Asset Compute-arbetaren.

## Arbetsyta för utveckling

Eftersom det här projektet genererades med hjälp `aio app init` av `Development` arbetsytan `AIO_runtime_namespace` ställs det automatiskt in på `81368-wkndaemassetcompute-development` matchning `AIO_runtime_auth` i vår lokala `.env` fil.  Om det finns en `.env` fil i den katalog som användes för att utfärda kommandot deploy, används dess värden, såvida de inte ersätter en variabelexport på operativsystemnivå, vilket är det som arbetsytorna [för scen och produktion](#stage-and-production) används som mål.

![driftsättning av aio-program med hjälp av .env-variabler](./assets/runtime/development__aio.png)

Så här distribuerar du till arbetsytan som definieras i `.env` projektfilen:

1. Öppna kommandoraden i roten av projektet Resursberäkning
1. Kör kommandot `aio app deploy`
1. Kör kommandot `aio app get-url` för att hämta arbetarens URL för användning i AEM som en Cloud Service Processing Profile som referens till den här anpassade resurshanteringspersonen. Om projektet innehåller flera arbetare visas separata URL:er för varje arbetare.

Om lokal utveckling och AEM som en Cloud Service Development-miljö använder separata distributioner av tillgångsberäkning, kan distributioner som ska AEM som en Cloud Service Dev hanteras på samma sätt som [scen- och produktionsdistributioner](#stage-and-production).

## Arbetsytor för scen och produktion{#stage-and-production}

Distributionen till arbetsytorna Stage och Production görs vanligtvis av valfritt CI/CD-system. Resursberäkningsprojektet måste distribueras separat till varje arbetsyta (Stage och sedan Production).

Om du anger true för miljövariabler åsidosätts värden för variabler med samma namn i `.env`.

![driftsättning av aio-appar med exportvariabler](./assets/runtime/stage__export-and-aio.png)

Det allmänna tillvägagångssättet, som vanligtvis automatiseras av ett CI/CD-system, för distribution till scen- och produktionsmiljöer är:

1. Kontrollera att plugin-programmet [](../set-up/development-environment.md#aio) Adobe I/O CLI npm och Asset Compute är installerade
1. Kolla in projektet Asset Compute som ska distribueras från Git
1. Ange miljövariablerna med de värden som motsvarar målarbetsytan (scen eller produktion)
   + De två variablerna som krävs är `AIO_runtime_namespace` och `AIO_runtime_auth` hämtas per arbetsyta i Adobe I/O Developer Console via funktionen __Hämta alla__ för arbetsytan.

![Adobe Developer Console - Namespace och Auth för AIO Runtime](./assets/runtime/stage-auth-namespace.png)

Du kan ange värden för dessa tangenter genom att ange exportkommandon från kommandoraden:

```
$ export AIO_runtime_namespace=81368-wkndaemassetcompute-stage
$ export AIO_runtime_auth=27100f9f-2676-4cce-b73d-b3fb6bac47d1:0tDu307W6MboQf5VWB1BAK0RHp8xWqSy1CQc3lKe7f63o3aNtAu0Y3nAmN56502W
```

Om dina tillgångsberäkningspersonal behöver andra variabler, till exempel molnlagring, bör de också exporteras som miljövariabler.

1. När alla miljövariabler har ställts in för målarbetsytan att distribuera till kör du kommandot deploy:
   + `aio app deploy`
1. Arbetar-URL:erna som AEM refererar till som en Cloud Service Processing Profile är också tillgängliga via:
   + `aio app get-url`.

Om projektversionen för Resursberäkning ändrar arbetarens URL:er så att de också återspeglar den nya versionen, och URL:en måste uppdateras i bearbetningsprofilerna.

## API-etablering för arbetsyta{#workspace-api-provisioning}

När du [konfigurerade projektet Adobe Project Fire i Adobe i/O](../set-up/firefly.md) för att stödja lokal utveckling skapades en ny arbetsyta för utveckling och API:er __för__ tillgångsberäkning, I/O-händelser __och__ I/O-händelsehantering lades till i den.

API:erna för __tillgångsberäkning, I/O-händelser__ och __I/O-händelsehantering__ läggs bara uttryckligen till i arbetsytorna som används för lokal utveckling. Arbetsytor som integreras (exklusivt) med AEM som en Cloud Service-miljö behöver __inte__ dessa API:er uttryckligen läggas till eftersom API:erna görs naturligt tillgängliga för AEM som en Cloud Service.
