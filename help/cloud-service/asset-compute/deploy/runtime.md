---
title: Distribuera Asset Compute-arbetare till Adobe I/O Runtime för användning med AEM as a Cloud Service
description: Asset Compute-projekt och de arbetare de innehåller måste driftsättas i Adobe I/O Runtime för att kunna användas av AEM as a Cloud Service.
feature: Asset Compute Microservices
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-6286
thumbnail: KT-6286.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 0327cf61-fd51-4fa7-856d-3febd49c01a0
duration: 128
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '645'
ht-degree: 0%

---

# Distribuera till Adobe I/O Runtime

Asset Compute-projekt, och de medarbetare de innehåller, måste driftsättas till Adobe I/O Runtime via Adobe I/O CLI för att kunna användas av AEM as a Cloud Service.

Vid distribution till Adobe I/O Runtime för användning av AEM as a Cloud Service Author services krävs endast två miljövariabler:

+ `AIO_runtime_namespace` poäng som App Builder Workspace ska distribueras till
+ `AIO_runtime_auth` är autentiseringsuppgifter för App Builder-arbetsytan

De andra standardvariablerna som definieras i filen `.env` tillhandahålls implicit av AEM as a Cloud Service när Asset Compute-arbetaren anropas.

## Arbetsyta för utveckling

Eftersom det här projektet genererades med `aio app init` med arbetsytan `Development`, ställs `AIO_runtime_namespace` automatiskt in på `81368-wkndaemassetcompute-development` med matchande `AIO_runtime_auth` i vår lokala `.env`-fil.  Om det finns en `.env`-fil i den katalog som används för att utfärda distributionskommandot, används dess värden, såvida de inte ersätter en variabelexport på operativsystemnivå, vilket är det som [stage- och production](#stage-and-production) -arbetsytorna anges som mål.

![AIO-appdistribution med hjälp av .env-variabler](./assets/runtime/development__aio.png)

Så här distribuerar du till arbetsytan som definieras i projektfilen `.env`:

1. Öppna kommandoraden i roten av Asset Compute-projektet
1. Kör kommandot `aio app deploy`
1. Kör kommandot `aio app get-url` för att hämta arbetarens URL för användning i AEM as a Cloud Service bearbetningsprofil för att referera till den här anpassade Asset Compute-arbetaren. Om projektet innehåller flera arbetare visas separata URL:er för varje arbetare.

Om lokala utvecklings- och AEM as a Cloud Service-utvecklingsmiljöer använder separata Asset Compute-distributioner kan distributioner till AEM as a Cloud Service Dev hanteras på samma sätt som [scen- och produktionsdistributioner](#stage-and-production).

## Arbetsytor för scen och produktion{#stage-and-production}

Distributionen till arbetsytorna Stage och Production görs vanligtvis av valfritt CI/CD-system. Asset Compute-projektet måste distribueras separat till varje Workspace (Stage och sedan Production).

Om du anger true-miljövariabler åsidosätts värden för variabler med samma namn i `.env`.

![AIR-appdistribution med exportvariabler](./assets/runtime/stage__export-and-aio.png)

Det allmänna tillvägagångssättet, som vanligtvis automatiseras av ett CI/CD-system, för distribution till scen- och produktionsmiljöer är:

1. Kontrollera att [Adobe I/O CLI npm-modulen och Asset Compute-plugin](../set-up/development-environment.md#aio) är installerade
1. Ta en titt på Asset Compute-projektet att distribuera från Git
1. Ange miljövariablerna med de värden som motsvarar målarbetsytan (scen eller produktion)
   + De två obligatoriska variablerna är `AIO_runtime_namespace` och `AIO_runtime_auth` och hämtas per arbetsyta i Adobe I/O Developer Console via Workspace __Ladda ned alla__-funktion.

![Adobe Developer Console - Namnområde för AIO-körningsmiljö och autentisering](./assets/runtime/stage-auth-namespace.png)

Du kan ange värden för dessa tangenter genom att ange exportkommandon från kommandoraden:

```
$ export AIO_runtime_namespace=81368-wkndaemassetcompute-stage
$ export AIO_runtime_auth=27100f9f-2676-4cce-b73d-b3fb6bac47d1:0tDu307W6MboQf5VWB1BAK0RHp8xWqSy1CQc3lKe7f63o3aNtAu0Y3nAmN56502W
```

Om dina Asset Compute-arbetare behöver några andra variabler, till exempel molnlagring, bör de också exporteras som miljövariabler.

1. När alla miljövariabler har ställts in för målarbetsytan att distribuera till kör du kommandot deploy:
   + `aio app deploy`
1. URL:erna till arbetaren som AEM as a Cloud Service-bearbetningsprofilen refererar till är också tillgängliga via:
   + `aio app get-url`.

Om Asset Compute-projektversionen ändrar arbetarens URL:er så att de motsvarar den nya versionen, och URL:en måste uppdateras i bearbetningsprofilerna.

## Workspace API-etablering{#workspace-api-provisioning}

När [konfigurerade App Builder-projektet i Adobe I/O](../set-up/app-builder.md) med stöd för lokal utveckling skapades en ny arbetsyta för utveckling och __API:er för Asset Compute, I/O-händelser__ och __I/O-händelsehanteringsAPI:er__ lades till i den.

API:erna __Asset Compute, I/O Events__ och __I/O Events Management__ läggs bara till explicit i arbetsytorna som används för lokal utveckling. Arbetsytor som integreras (exklusivt) med AEM as a Cloud Service-miljöer behöver __inte__ dessa API:er som läggs till explicit eftersom API:erna görs naturligt tillgängliga för AEM as a Cloud Service.
