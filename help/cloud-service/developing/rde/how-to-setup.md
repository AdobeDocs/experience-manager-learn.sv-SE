---
title: Konfigurera Rapid Development Environment
description: Lär dig hur du konfigurerar Rapid Development Environment för AEM as a Cloud Service.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-11861
thumbnail: KT-11861.png
last-substantial-update: 2024-06-04T00:00:00Z
exl-id: ab9ee81a-176e-4807-ba39-1ea5bebddeb2
duration: 485
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '668'
ht-degree: 0%

---

# Konfigurera Rapid Development Environment

Lär dig **hur du konfigurerar** Rapid Development Environment (RDE) i AEM as a Cloud Service.

I den här videon visas:

- Lägga till en RDE i programmet med Cloud Manager
- Inloggningsflöde för RDE med Adobe IMS, som liknar andra AEM as a Cloud Service-miljöer
- Inställning av [Adobe I/O Runtime Extensible CLI](https://developer.adobe.com/runtime/docs/guides/tools/cli_install/) kallas även `aio CLI`
- Konfigurera AEM RDE- och Cloud Manager `aio CLI`-plugin-programmet med icke-interaktivt läge. Information om interaktivt läge finns i [installationsanvisningarna](#setup-the-aem-rde-plugin)

>[!VIDEO](https://video.tv.adobe.com/v/3415490?quality=12&learn=on)

## Förutsättning

Följande bör installeras lokalt:

- [Node.js](https://nodejs.org/en/) (LTS - långsiktig support)
- [npm 8+](https://docs.npmjs.com/)

## Lokal installation

Utför följande steg om du vill distribuera [&#128279;](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project)-koden och innehållet för WKND Sites Project på den lokala datorn.

### Adobe I/O Runtime Extensible CLI

Installera Adobe I/O Runtime Extensible CLI, även kallat `aio CLI`, genom att köra följande kommando från kommandoraden.

```shell
$ npm install -g @adobe/aio-cli
```

### Installera och konfigurera plugin-program för AIR

AIO CLI måste ha plugin-program installerade och konfigurerade med Organization, Program och RDE Environment ID för att kunna interagera med din RDE. Installationen kan göras via AIO CLI i det enklare interaktiva läget eller icke-interaktiva läget.

>[!BEGINTABS]

>[!TAB Interaktivt läge]

Installera och konfigurera AEM RDE-plugin-program med kommandot `plugins:install` för `aio cli`.

1. Installera aio CLI-programmets AEM RDE-plugin med `plugins:install`-kommandot för `aio cli`.

   ```shell
   $ aio plugins:install @adobe/aio-cli-plugin-aem-rde    
   $ aio plugins:update
   ```

   Med AEM RDE plugin kan utvecklare distribuera kod och innehåll från den lokala datorn.

2. Logga in på Adobe I/O Runtime Extensible CLI genom att köra följande kommando för att få åtkomsttoken. Se till att du loggar in på samma Adobe Org som din Cloud Manager.

   ```shell
   $ aio login
   ```

3. Kör följande kommando för att konfigurera RDE i interaktivt läge.

   ```shell
   $ aio aem:rde:setup
   ```

4. CLI uppmanar dig att ange organisations-ID, program-ID och miljö-ID.

   ```shell
   Setup the CLI configuration necessary to use the RDE commands.
   ? Do you want to store the information you enter in this setup procedure locally? (y/N)
   ```

   - Välj __Nej__ om du bara arbetar med en enda RDE och vill lagra RDE-konfigurationen globalt på den lokala datorn.

   - Välj __Ja__ om du arbetar med flera RDE:er, eller om du vill lagra RDE-konfigurationen lokalt, i den aktuella mappens `.aio` -fil, för varje projekt.

5. Välj organisations-ID, program-ID och RDE Environment ID i listan över tillgängliga alternativ.

6. Kontrollera att rätt organisation, program och miljö är konfigurerad genom att köra följande kommando.

   ```shell
   $ aio aem rde setup --show
   ```

>[!TAB Icke-interaktivt läge]

Installera och konfigurera Cloud Manager- och AEM RDE-plugin-program med kommandot `plugins:install` för `aio cli`.

```shell
$ aio plugins:install @adobe/aio-cli-plugin-cloudmanager
$ aio plugins:install @adobe/aio-cli-plugin-aem-rde
$ aio plugins:update
```

Med Cloud Manager plugin kan utvecklare interagera med Cloud Manager från kommandoraden.

Med AEM RDE plugin kan utvecklare distribuera kod och innehåll från den lokala datorn.

AIO CLI-pluginerna måste konfigureras för att interagera med din RDE.

1. I Cloud Manager kopierar du först värdena för Organization, Program, and Environment ID.

   - Organisations-ID: Kopiera värdet från **Profilbild > Kontoinformation (intern) > Modalt fönster > Aktuellt organisations-ID**

   ![Organisations-ID](./assets/Org-ID.png)

   - Program-ID: Kopiera värdet från **Programöversikt > Miljöer > {ProgramName}-rde > Webbläsar-URI > tal mellan `program/` och`/environment`**

   ![Program- och miljö-ID](./assets/Program-Environment-Id.png)

   - Miljö-ID: Kopiera värdet från **Programöversikt > Miljöer > {ProgramName}-rde > Webbläsar-URI > nummer efter`environment/`**

   ![Program- och miljö-ID](./assets/Program-Environment-Id.png)

1. Använd kommandot `config:set` för `aio cli` för att ange dessa värden genom att köra följande kommando.

   ```shell
   $ aio config:set cloudmanager_orgid <ORGANIZATION ID>
   $ aio config:set cloudmanager_programid <PROGRAM ID>
   $ aio config:set cloudmanager_environmentid <ENVIRONMENT ID>
   ```

1. Kontrollera de aktuella konfigurationsvärdena genom att köra följande kommando.

   ```shell
   $ aio config:list
   ```

1. Växla eller granska vilken organisation du är inloggad på:

   ```shell
   $ aio where
   ```

>[!ENDTABS]

## Verifiera RDE-åtkomst

Kontrollera installationen och konfigurationen av plugin-programmet för AEM RDE genom att köra följande kommando.

```shell
$ aio aem:rde:status
```

Statusinformationen för RDE visas som miljöstatus, listan över _ditt AEM-projekt_ som innehåller paket och konfigurationer för författaren och publiceringstjänsten.

## Nästa steg

Lär dig [hur du använder](./how-to-use.md) en RDE för att distribuera kod och innehåll från din favoritintegrerade utvecklingsmiljö (IDE) för snabbare utvecklingscykler.


## Ytterligare resurser

[Aktivera RDE i en programdokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/rapid-development-environments.html?lang=sv-SE#enabling-rde-in-a-program)

Inställning av [Adobe I/O Runtime Extensible CLI](https://developer.adobe.com/runtime/docs/guides/tools/cli_install/) kallas även `aio CLI`

[Användning och kommandon för AIR CLI](https://github.com/adobe/aio-cli#usage)

[Adobe I/O Runtime CLI-plugin för interaktion med AEM Rapid Development Environment](https://github.com/adobe/aio-cli-plugin-aem-rde#aio-cli-plugin-aem-rde)

[Cloud Manager aio CLI plugin](https://github.com/adobe/aio-cli-plugin-cloudmanager)
