---
title: AEM Assets event for PIM integration
description: Lär dig hur du integrerar AEM Assets- och PIM-system (Product Information Management) för uppdatering av metadata för mediefiler.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 761
last-substantial-update: 2024-02-13T00:00:00Z
jira: KT-14901
thumbnail: KT-14901.jpeg
exl-id: 070cbe54-2379-448b-bb7d-3756a60b65f0
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1116'
ht-degree: 0%

---

# AEM Assets event for PIM integration

>[!IMPORTANT]
>
>I den här självstudien används experimentella AEM as a Cloud Service API:er. För att få tillgång till dessa API:er måste du godkänna ett förhandsavtal för programvara och ha dessa API:er manuellt aktiverade för din miljö av Adobe-tekniker. Kontakta supporten för att få åtkomst till Adobe.

Lär dig hur du integrerar AEM Assets med ett tredjepartssystem, t.ex. ett PIM-system (Product Information Management) eller PLM-system (Product Line Management), för att uppdatera metadata för resurser **med hjälp av AEM-I/O-händelser**. När du får en AEM Assets-händelse kan metadata för resursen uppdateras i AEM, PIM eller båda systemen, baserat på företagets behov. I det här exemplet visas dock hur metadata för resursen uppdateras i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/3427592?quality=12&learn=on)

Om du vill köra metadatauppdateringen **av resursen utanför AEM**, [Adobe I/O Runtime](https://developer.adobe.com/runtime/docs/guides/overview/what_is_runtime/), används en serverlös plattform.

Händelsebearbetningsflödet är följande:

![AEM Assets-händelser för PIM-integrering](../assets/examples/assets-pim-integration/aem-assets-pim-integration.png)

1. Tjänsten AEM Author utlöser en _händelse om att resursbearbetningen har slutförts_ när en resursöverföring har slutförts och alla resursbearbetningsaktiviteter har slutförts. Om du väntar på att bearbetningen ska slutföras ser du till att all körklar bearbetning, till exempel metadataextrahering, har slutförts.
1. Händelsen skickas till tjänsten [Adobe I/O Events](https://developer.adobe.com/events/).
1. Händelsetjänsten Adobe I/O skickar händelsen till [Adobe I/O Runtime-åtgärden](https://developer.adobe.com/runtime/docs/guides/using/creating_actions/) för bearbetning.
1. Adobe I/O Runtime Action anropar PIM-systemets API för att hämta ytterligare metadata som SKU, leverantörsinformation eller annan information.
1. De ytterligare metadata som hämtas från PIM uppdateras sedan i AEM Assets med [Assets Author API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/).

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service-miljö med [AEM Eventing aktiverat](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment). Dessutom måste exempelprojektet [WKND Sites](https://github.com/adobe/aem-guides-wknd?#aem-wknd-sites-project) distribueras till det.

- Åtkomst till [Adobe Developer Console](https://developer.adobe.com/developer-console/docs/guides/getting-started/).

- [Adobe Developer CLI](https://developer.adobe.com/runtime/docs/guides/tools/cli_install/) är installerat på din lokala dator.

## Utvecklingssteg

Utvecklingsstegen på hög nivå är följande:

1. [Skapa ett projekt i Adobe Developer Console (ADC)](./runtime-action.md#Create-project-in-Adobe-Developer-Console)
1. [Initiera projektet för lokal utveckling](./runtime-action.md#initialize-project-for-local-development)
1. Konfigurera projektet i ADC
1. Konfigurera AEM Author-tjänsten för att aktivera ADC-projektkommunikation
1. Utveckla en körningsåtgärd som hanterar hämtning och uppdatering av metadata
1. Överför en resurs till AEM Author och verifiera att metadata har uppdaterats

Mer information om steg 1-2 finns i exemplet [Adobe I/O Runtime Action och AEM Events](./runtime-action.md#) och för steg 3-6 finns i följande avsnitt.

### Konfigurera projektet i Adobe Developer Console (ADC)

Om du vill ta emot AEM Assets Events och köra Adobe I/O Runtime Action som skapades i föregående steg konfigurerar du projektet i ADC.

- Gå till [projektet](https://developer.adobe.com/console/projects) i ADC. Välj arbetsytan `Stage`. Det är här körningsåtgärden distribuerades.

- Klicka på knappen **Lägg till tjänst** och välj alternativet **Händelse** . I dialogrutan **Lägg till händelser** väljer du **Experience Cloud** > **AEM Assets** och klickar på **Nästa**. Följ ytterligare konfigurationssteg, välj AEMCS-instans, _Resursbearbetning slutförd_ -händelse, OAuth Server-till-server-autentiseringstyp och annan information.

  ![AEM Assets Event - lägg till händelse](../assets/examples/assets-pim-integration/add-aem-assets-event.png)

- I steget **Så här tar du emot händelser** expanderar du alternativet **Körningsåtgärd** och väljer den _generiska_ åtgärden som skapades i föregående steg. Klicka på **Spara konfigurerade händelser**.

  ![AEM Assets Event - ta emot händelse](../assets/examples/assets-pim-integration/receive-aem-assets-event.png)

- Klicka på knappen **Lägg till tjänst** och välj alternativet **API** . I **Lägg till ett API** modal väljer du **Experience Cloud** > **AEM as a Cloud Service API** och klickar på **Nästa**.

  ![Lägg till AEM as a Cloud Service API - Konfigurera projekt](../assets/examples/assets-pim-integration/add-aem-api.png)

- Välj sedan **OAuth Server-to-Server** som autentiseringstyp och klicka på **Nästa**.

- Välj sedan produktprofilen **AEM Administratörer-XXX** och klicka på **Spara konfigurerad API**. Om du vill uppdatera resursen i fråga måste den valda produktprofilen associeras med den AEM Assets-miljö som händelsen skapas från och ha tillräcklig tillgång till för att uppdatera resurserna där.

  ![Lägg till AEM as a Cloud Service API - Konfigurera projekt](../assets/examples/assets-pim-integration/add-aem-api-product-profile-select.png)

### Konfigurera AEM Author Service för att aktivera ADC-projektkommunikation

Om du vill uppdatera metadata för resursen i AEM från ovanstående ADC-projekt konfigurerar du AEM Author-tjänsten med ADC-projektets klient-ID. _Klient-ID:t_ läggs till som miljövariabel med användargränssnittet [Adobe Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/environment-variables.html#add-variables) .

- Logga in på [Adobe Cloud Manager](https://my.cloudmanager.adobe.com/), välj **Program** > **Miljö** > **Ellips** > **Visa detaljer** > fliken **Konfiguration**.

  ![Adobe Cloud Manager - miljökonfiguration](../assets/examples/assets-pim-integration/cloud-manager-environment-configuration.png)

- **Lägg till konfiguration** och ange variabelinformationen som

  | Namn | Värde | AEM | Typ |
  | ----------- | ----------- | ----------- | ----------- |
  | ADOBE_PROVIDED_CLIENT_ID | &lt;COPY_FROM_ADC_PROJECT_CREDENTIALS> | Författare | Variabel |

  ![Adobe Cloud Manager - miljökonfiguration](../assets/examples/assets-pim-integration/add-environment-variable.png)

- Klicka på **Lägg till** och **Spara** konfigurationen.

### Åtgärd vid utveckling av körning

Om du vill hämta och uppdatera metadata börjar du med att uppdatera den automatiskt skapade _generiska_ åtgärdskoden i mappen `src/dx-excshell-1/actions/generic`.

Se den bifogade filen [WKND-Assets-PIM-Integration.zip](../assets/examples/assets-pim-integration/WKND-Assets-PIM-Integration.zip) för den fullständiga koden och i avsnittet nedan markeras de viktigaste filerna.

- Filen `src/dx-excshell-1/actions/generic/mockPIMCommunicator.js` kopplar PIM API-anropet för att hämta ytterligare metadata som SKU och leverantörsnamn. Den här filen används för demoändamål. När du har arbetsflödet från början till slut ersätter du den här funktionen med ett anrop till ditt riktiga PIM-system för att hämta metadata för resursen.

  ```javascript
  /**
   * Mock PIM API to get the product data such as SKU, Supplier, etc.
   *
   * In a real-world scenario, this function would call the PIM API to get the product data.
   * For this example, we are returning mock data.
   *
   * @param {string} assetId - The assetId to get the product data.
   */
  module.exports = {
      async getPIMData(assetId) {
          if (!assetId) {
          throw new Error('Invalid assetId');
          }
          // Mock response data for demo purposes
          const data = {
          SKUID: 'MockSKU 123',
          SupplierName: 'mock-supplier',
          // ... other product data
          };
          return data;
      },
  };
  ```

- Filen `src/dx-excshell-1/actions/generic/aemCommunicator.js` uppdaterar metadata för resursen i AEM med [Assets Author API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/).

  ```javascript
  const fetch = require('node-fetch');
  
  ...
  
  /**
  *  Get IMS Access Token using Client Credentials Flow
  *
  * @param {*} clientId - IMS Client ID from ADC project's OAuth Server-to-Server Integration
  * @param {*} clientSecret - IMS Client Secret from ADC project's OAuth Server-to-Server Integration
  * @param {*} scopes - IMS Meta Scopes from ADC project's OAuth Server-to-Server Integration as comma separated strings
  * @returns {string} - Returns the IMS Access Token
  */
  async function getIMSAccessToken(clientId, clientSecret, scopes) {
    const adobeIMSV3TokenEndpointURL = 'https://ims-na1.adobelogin.com/ims/token/v3';
  
    const options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: `grant_type=client_credentials&client_id=${clientId}&client_secret=${clientSecret}&scope=${scopes}`,
    };
  
    const response = await fetch(adobeIMSV3TokenEndpointURL, options);
    const responseJSON = await response.json();
  
    return responseJSON.access_token;
  }    
  
  async function updateAEMAssetMetadata(metadataDetails, aemAssetEvent, params) {
    ...
    // Transform the metadata details to JSON Patch format,
    // see https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/#operation/patchAssetMetadata
    const transformedMetadata = Object.keys(metadataDetails).map((key) => ({
      op: 'add',
      path: `wknd-${key.toLowerCase()}`,
      value: metadataDetails[key],
    }));
  
    ...
  
    // Get ADC project's OAuth Server-to-Server Integration credentials
    const clientId = params.ADC_CECREDENTIALS_CLIENTID;
    const clientSecret = params.ADC_CECREDENTIALS_CLIENTSECRET;
    const scopes = params.ADC_CECREDENTIALS_METASCOPES;
  
    // Get IMS Access Token using Client Credentials Flow
    const access_token = await getIMSAccessToken(clientId, clientSecret, scopes);
  
    // Call AEM Author service to update the metadata using Assets Author API
    // See https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/
    const res = await fetch(`${aemAuthorHost}/adobe/assets/${assetId}/metadata`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json-patch+json',
        'If-Match': '*',
        'X-Adobe-Accept-Experimental': '1',
        'X-Api-Key': 'aem-assets-management-api', // temporary value
        Authorization: `Bearer ${access_token}`,
      },
      body: JSON.stringify(transformedMetadata),
    });
  
    ...
  }
  
  module.exports = { updateAEMAssetMetadata };
  ```

  Filen `.env` lagrar ADC-projektets autentiseringsuppgifter för OAuth Server-till-Server, och de skickas som parametrar till åtgärden med hjälp av filen `ext.config.yaml`. Mer information om hur du hanterar hemligheter och åtgärdsparametrar finns i [App Builder konfigurationsfiler](https://developer.adobe.com/app-builder/docs/guides/configuration/).

- Mappen `src/dx-excshell-1/actions/model` innehåller `aemAssetEvent.js`- och `errors.js`-filer, som används av åtgärden för att tolka den mottagna händelsen och hantera fel.

- Filen `src/dx-excshell-1/actions/generic/index.js` använder de tidigare nämnda modulerna för att ordna hämtning och uppdatering av metadata.

  ```javascript
  ...
  
  let responseMsg;
  // handle the challenge probe request, they are sent by I/O to verify the action is valid
  if (params.challenge) {
    logger.info('Challenge probe request detected');
    responseMsg = JSON.stringify({ challenge: params.challenge });
  } else {
    logger.info('AEM Asset Event request received');
  
    // create AEM Asset Event object from request parameters
    const aemAssetEvent = new AEMAssetEvent(params);
  
    // Call mock PIM API to get the product data such as SKU, Supplier, etc.
    const mockPIMData = await mockPIMAPI.getPIMData(
      aemAssetEvent.getAssetName(),
    );
    logger.info('Mock PIM API response', mockPIMData);
  
    // Update PIM received data in AEM as Asset metadata
    const aemUpdateStatus = await updateAEMAssetMetadata(
      mockPIMData,
      aemAssetEvent,
      params,
    );
    logger.info('AEM Asset metadata update status', aemUpdateStatus);
  
    if (aemUpdateStatus) {
      // create response message
      responseMsg = JSON.stringify({
        message:
          'AEM Asset Event processed successfully, updated the asset metadata with PIM data.',
        assetdata: {
          assetName: aemAssetEvent.getAssetName(),
          assetPath: aemAssetEvent.getAssetPath(),
          assetId: aemAssetEvent.getAssetId(),
          aemHost: aemAssetEvent.getAEMHost(),
          pimdata: mockPIMData,
        },
      });
    } 
  
    // response object
    const response = {
      statusCode: 200,
      body: responseMsg,
    };
  
    // Return the response to the caller
    return response;
  
    ...
  }
  ```

Distribuera den uppdaterade åtgärden till Adobe I/O Runtime med följande kommando:

```bash
$ aio app deploy
```

### Tillgångsuppladdning och metadataverifiering

Följ de här stegen för att verifiera integreringen mellan AEM Assets och PIM:

- Om du vill visa PIM-modellens metadata, som SKU och leverantörsnamn, skapar du metadataram i AEM Assets i [Metadataschemat](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/configuring/metadata-schemas.html) som visar metadataegenskaperna för SKU och leverantörsnamn.

- Överför en resurs i AEM Author-tjänsten och verifiera metadatauppdateringen.

  ![AEM Assets metadatauppdatering](../assets/examples/assets-pim-integration/aem-assets-metadata-update.png)

## Koncept och viktiga arbetsmoment

Synkronisering av metadata för tillgångar mellan AEM och andra system som PIM krävs ofta i företaget. AEM Eventing kan man uppnå sådana krav.

- Koden för hämtning av metadata om mediematerial körs utanför AEM, vilket undviker belastningen på AEM Author-tjänsten och därmed händelsestyrd arkitektur som skalas oberoende av varandra.
- Det nya API:t för Assets Author används för att uppdatera metadata för resurser i AEM.
- API-autentiseringen använder OAuth server-till-server (kallas klientinloggningsflöde), se [Implementeringsguiden för OAuth Server-till-server-autentiseringsuppgifter](https://developer.adobe.com/developer-console/docs/guides/authentication/ServerToServerAuthentication/implementation/).
- I stället för Adobe I/O Runtime Actions kan andra webhooks eller Amazon EventBridge användas för att ta emot händelsen AEM Assets och bearbeta metadatauppdateringen.
- Tillgångshändelser via AEM Eventing ger företag möjlighet att automatisera och effektivisera kritiska processer, vilket främjar effektivitet och enhetlighet i innehållets ekosystem.
