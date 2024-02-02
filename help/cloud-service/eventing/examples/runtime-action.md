---
title: Adobe I/O Runtime Action and AEM Events
description: Lär dig hur du tar emot AEM händelser med Adobe I/O Runtime-åtgärd och granskar händelseinformation som nyttolast, huvuden och metadata.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 0
last-substantial-update: 2024-01-29T00:00:00Z
jira: KT-14878
thumbnail: KT-14878.jpeg
source-git-commit: f0930e517254b6353fe50c3bbf9ae915d9ef6ca3
workflow-type: tm+mt
source-wordcount: '729'
ht-degree: 0%

---


# Adobe I/O Runtime Action and AEM Events

Lär dig hur du tar emot AEM med [Adobe I/O Runtime](https://developer.adobe.com/runtime/docs/guides/overview/what_is_runtime/) Åtgärda och granska händelseinformation som nyttolast, huvuden och metadata.

>[!VIDEO](https://video.tv.adobe.com/v/3427053?quality=12&learn=on)

Adobe I/O Runtime är en serverlös plattform som tillåter exekvering av kod som svar på Adobe I/O Events. Detta hjälper dig att bygga händelsestyrda program utan att behöva bekymra dig om infrastrukturen.

I det här exemplet skapar du en Adobe I/O Runtime [Åtgärd](https://developer.adobe.com/runtime/docs/guides/using/creating_actions/) som tar emot AEM händelser och loggar händelseinformationen.
https://developer.adobe.com/runtime/docs/guides/overview/what_is_runtime/

Stegen på hög nivå är:

- Skapa projekt i Adobe Developer Console
- Initiera projekt för lokal utveckling
- Konfigurera projekt i Adobe Developer Console
- Utlös AEM Event och verifiera åtgärdskörning

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service miljö med [AEM Eventing aktiverad](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment).

- Åtkomst till [Adobe Developer Console](https://developer.adobe.com/developer-console/docs/guides/getting-started/).

- [ADOBE DEVELOPER CLI](https://developer.adobe.com/runtime/docs/guides/tools/cli_install/) installeras på din lokala dator.

>[!IMPORTANT]
>
>AEM as a Cloud Service Eventing är bara tillgängligt för registrerade användare i förhandsversionsläge. Om du vill aktivera AEM på din AEM as a Cloud Service miljö kontaktar du [AEM](mailto:grp-aem-events@adobe.com).

## Skapa projekt i Adobe Developer Console

Så här skapar du ett projekt i Adobe Developer Console:

- Navigera till [Adobe Developer Console](https://developer.adobe.com/) och klicka **Konsol** -knappen.

- I **Snabbstart** avsnitt, klicka **Skapa projekt från mall**. Sedan i **Bläddra bland mallar** dialogruta, välja **App Builder** mall.

- Uppdatera projekttitel, appnamn och Lägg till arbetsyta om det behövs. Klicka sedan på **Spara**.

  ![Skapa projekt i Adobe Developer Console](../assets/examples/runtime-action/create-project.png)


## Initiera projekt för lokal utveckling

Om du vill lägga till Adobe I/O Runtime Action i projektet måste du initiera projektet för lokal utveckling. Navigera till den plats där du vill initiera projektet på den lokala datorn och följ dessa steg:

- Initiera projekt genom att köra

  ```bash
  aio app init
  ```

- Välj `Organization`, `Project` som du skapade i föregående steg och arbetsytan. I `What templates do you want to search for?` steg, välja `All Templates` alternativ.

  ![Projektval - Initiera projekt](../assets/examples/runtime-action/all-templates.png)

- I malllistan väljer du `@adobe/generator-app-excshell` alternativ.

  ![Utbyggbarhetsmall - Initiera projekt](../assets/examples/runtime-action/extensibility-template.png)

- Öppna projektet i din favoritutvecklingsmiljö, till exempel VSCode.

- Den markerade _Utbyggbarhetsmall_ (`@adobe/generator-app-excshell`) innehåller en allmän körningsåtgärd, koden finns i `src/dx-excshell-1/actions/generic/index.js` -fil. Låt oss uppdatera den så att den blir enkel, logga händelseinformationen och returnera ett svar om att åtgärden lyckades. I nästa exempel förbättras dock bearbetningen av mottagna AEM händelser.

  ```javascript
  const fetch = require("node-fetch");
  const { Core } = require("@adobe/aio-sdk");
  const {
  errorResponse,
  getBearerToken,
  stringParameters,
  checkMissingRequestInputs,
  } = require("../utils");
  
  // main function that will be executed by Adobe I/O Runtime
  async function main(params) {
  // create a Logger
  const logger = Core.Logger("main", { level: params.LOG_LEVEL || "info" });
  
  try {
      // 'info' is the default level if not set
      logger.info("Calling the main action");
  
      // log parameters, only if params.LOG_LEVEL === 'debug'
      logger.debug(stringParameters(params));
  
      const response = {
      statusCode: 200,
      body: {
          message: "Received AEM Event, it will be processed in next example",
      },
      };
  
      // log the response status code
      logger.info(`${response.statusCode}: successful request`);
      return response;
  } catch (error) {
      // log any server errors
      logger.error(error);
      // return with 500
      return errorResponse(500, "server error", logger);
  }
  }
  
  exports.main = main;
  ```

- Distribuera slutligen den uppdaterade åtgärden på Adobe I/O Runtime genom att köra.

  ```bash
  aio app deploy
  ```

## Konfigurera projekt i Adobe Developer Console

Om du vill ta emot AEM händelser och köra Adobe I/O Runtime-åtgärden som skapades i föregående steg konfigurerar du projektet i Adobe Developer Console.

- I Adobe Developer Console går du till [projekt](https://developer.adobe.com/console/projects) som skapades i föregående steg och klicka för att öppna det. Välj `Stage` arbetsytan, det är här som åtgärden har distribuerats.

- Klicka **Lägg till tjänst** knapp och markera **API** alternativ. I **Lägg till ett API** modal, välj **Adobes tjänster** > **API för I/O-hantering** och klicka **Nästa** följer du ytterligare konfigurationssteg och klickar på **Spara konfigurerat API**.

  ![Lägg till tjänst - Konfigurera projekt](../assets/examples/runtime-action/add-io-management-api.png)

- Klicka på samma sätt **Lägg till tjänst** knapp och markera **Händelse** alternativ. I **Lägg till händelser** dialogruta, välja **Experience Cloud** > **AEM Sites** och klicka **Nästa**. Följ ytterligare konfigurationssteg, välj AEMCS-instans, händelsetyper och annan information.

- Äntligen i **Så här tar du emot händelser** steg, expandera **Körningsåtgärd** och väljer _generisk_ åtgärd som skapades i föregående steg. Klicka **Spara konfigurerade händelser**.

  ![Körningsåtgärd - Konfigurera projekt ](../assets/examples/runtime-action/select-runtime-action.png)

- Granska informationen om eventregistrering, även **Felsökningsspårning** och verifiera **Utmaningsanalys** begäran och svar.

  ![Information om händelseregistrering](../assets/examples/runtime-action/debug-tracing-challenge-probe.png)


## Utlös AEM

Så här utlöser du AEM händelser från din AEM as a Cloud Service miljö som har registrerats i ovanstående Adobe Developer Console-projekt:

- Få åtkomst till och logga in i AEM as a Cloud Service redigeringsmiljö via [Cloud Manager](https://my.cloudmanager.adobe.com/).

- Beroende på din **Prenumererade händelser**, skapa, uppdatera, ta bort, publicera eller avpublicera ett innehållsfragment.

## Granska händelseinformation

När du har slutfört ovanstående steg bör du se de AEM händelser som levereras till den allmänna åtgärden.

Du kan granska händelseinformationen i **Felsökningsspårning** -fliken i informationen om händelseregistrering.

![Information om AEM](../assets/examples/runtime-action/aem-event-details.png)


## Nästa steg

I nästa exempel ska vi förbättra den här åtgärden för att bearbeta AEM händelser, ringa AEM författartjänsten för att få innehållsinformation, lagra information i Adobe I/O Runtime-lagring och visa dem via Single Page Application (SPA).

