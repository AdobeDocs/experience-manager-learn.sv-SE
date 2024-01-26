---
title: Konfigurera Rapid Development Environment
description: Lär dig hur du konfigurerar en snabb utvecklingsmiljö för AEM as a Cloud Service.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-11861
thumbnail: KT-11861.png
last-substantial-update: 2023-02-15T00:00:00Z
exl-id: ab9ee81a-176e-4807-ba39-1ea5bebddeb2
duration: 512
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '453'
ht-degree: 0%

---

# Konfigurera Rapid Development Environment

Läs **konfigurera** Rapid Development Environment (RDE) på AEM as a Cloud Service.

I den här videon visas:

- Lägga till en RDE i ditt program med hjälp av Cloud Manager
- Inloggningsflöde för RDE med Adobe IMS, på samma sätt som andra AEM as a Cloud Service miljöer
- Inställningar för [Adobe I/O Runtime Extensible CLI](https://developer.adobe.com/runtime/docs/guides/tools/cli_install/) även känt som `aio CLI`
- Konfigurera AEM RDE och Cloud Manager `aio CLI` plugin

>[!VIDEO](https://video.tv.adobe.com/v/3415490?quality=12&learn=on)

## Förutsättning

Följande bör installeras lokalt:

- [Node.js](https://nodejs.org/en/) (LTS - långsiktig support)
- [npm 8+](https://docs.npmjs.com/)

## Lokal installation

Så här distribuerar du [WKND Sites Project&#39;s](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) Kod och innehåll till RDE från din lokala dator, utför följande steg.

### Adobe I/O Runtime Extensible CLI

Installera Adobe I/O Runtime Extensible CLI, även kallat `aio CLI` genom att köra följande kommando från kommandoraden.

```shell
$ npm install -g @adobe/aio-cli
```

### AEM plugin-program

Installera plugin-program för Cloud Manager och AEM RDE med `aio cli`&#39;s `plugins:install` -kommando.

```shell
$ aio plugins:install @adobe/aio-cli-plugin-cloudmanager

$ aio plugins:install @adobe/aio-cli-plugin-aem-rde
```

Med plugin-programmet Cloud Manager kan utvecklare interagera med Cloud Manager från kommandoraden.

Med AEM RDE plugin kan utvecklare distribuera kod och innehåll från den lokala datorn.

Om du vill uppdatera plugin-programmen använder du `aio plugins:update` -kommando.

## Konfigurera AEM

AEM plugin-program måste konfigureras för att interagera med din RDE. Först kopierar du värdena för organisations-, program- och miljö-ID med hjälp av användargränssnittet i Cloud Manager.

1. Organisations-ID: Kopiera värdet från **Profilbild > Kontoinformation (intern) > Modal Window > Current Org ID**

   ![Organisations-ID](./assets/Org-ID.png)

1. Program-ID: Kopiera värdet från **Programöversikt > Miljöer > {ProgramName}-rde > Webbläsar-URI > tal mellan `program/` och`/environment`**

1. Miljö-ID: Kopiera värdet från **Programöversikt > Miljöer > {ProgramName}-rde > Browser URI > numbers after`environment/`**

   ![Program- och miljö-ID](./assets/Program-Environment-Id.png)

1. Genom att använda `aio cli`&#39;s `config:set` genom att köra följande kommando.

   ```shell
   $ aio config:set cloudmanager_orgid <org-id>
   
   $ aio config:set cloudmanager_programid <program-id>
   
   $ aio config:set cloudmanager_environmentid <env-id>
   ```

Du kan verifiera de aktuella konfigurationsvärdena genom att köra följande kommando.

```shell
$ aio config:list
```

Om du vill växla eller veta vilken organisation du är inloggad på kan du använda kommandot nedan.

```shell
$ aio where
```

## Verifiera RDE-åtkomst

Kontrollera installationen och konfigurationen av AEM RDE-plugin-programmet genom att köra följande kommando.

```shell
$ aio aem:rde:status
```

Statusinformationen för RDE visas som miljöstatus, listan med _ditt AEM_ paket och konfigurationer för författare och publiceringstjänst.

## Nästa steg

Läs [använda](./how-to-use.md) en utvecklingsmiljö för att driftsätta kod och innehåll från din favoritutvecklingsmiljö (Integrated Development Environment, IDE) för snabbare utvecklingscykler.


## Ytterligare resurser

[Aktivera RDE i en programdokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/rapid-development-environments.html#enabling-rde-in-a-program)

Inställningar för [Adobe I/O Runtime Extensible CLI](https://developer.adobe.com/runtime/docs/guides/tools/cli_install/) även känt som `aio CLI`

[Användning och kommandon i AIR CLI](https://github.com/adobe/aio-cli#usage)

[Adobe I/O Runtime CLI Plugin för interaktion med AEM Rapid Development Environment](https://github.com/adobe/aio-cli-plugin-aem-rde#aio-cli-plugin-aem-rde)

[CLI-plugin för Cloud Manager AIO](https://github.com/adobe/aio-cli-plugin-cloudmanager)
