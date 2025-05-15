---
title: Konfigurera OpenAPI-baserade AEM API:er
description: Lär dig hur du konfigurerar AEM as a Cloud Service-miljön för att ge åtkomst till OpenAPI-baserade AEM API:er.
version: Experience Manager as a Cloud Service
feature: Developing
topic: Development, Architecture, Content Management
role: Architect, Developer, Leader
level: Beginner
doc-type: Article
jira: KT-17426
thumbnail: KT-17426.jpeg
last-substantial-update: 2025-02-28T00:00:00Z
duration: 0
exl-id: 1df4c816-b354-4803-bb6c-49aa7d7404c6
source-git-commit: 34a22580db6dc32b5c4c5945af83600be2e0a852
workflow-type: tm+mt
source-wordcount: '1440'
ht-degree: 0%

---

# Konfigurera OpenAPI-baserade AEM API:er

Lär dig hur du konfigurerar AEM as a Cloud Service-miljön för att ge åtkomst till OpenAPI-baserade AEM API:er.

I det här exemplet används AEM Assets-API:t som använder autentiseringsmetoden Server-till-server för att demonstrera konfigurationsprocessen. Samma steg kan följas för andra OpenAPI-baserade AEM-API:er.

>[!VIDEO](https://video.tv.adobe.com/v/3457510?quality=12&learn=on)

Konfigurationsprocessen på hög nivå omfattar följande steg:

1. Modernisering av AEM as a Cloud Service-miljön.
1. Aktivera åtkomst till AEM API:er.
1. Skapa Adobe Developer Console-projekt (ADC).
1. Konfigurera ADC-projekt.
1. Konfigurera AEM-instansen för att aktivera ADC-projektkommunikation.

## Modernisering av AEM as a Cloud Service miljö{#modernization-of-aem-as-a-cloud-service-environment}

Moderniseringen av AEM as a Cloud Service-miljön är en engångsåtgärd per miljö som omfattar följande steg:

- Uppdatera till AEM-utgåvan **2024.10.18459.20241031T210302Z** eller senare.
- Lägg till nya produktprofiler i den om miljön skapades före utgåvan 2024.10.18459.20241031T210302Z.

### Uppdatera AEM-instans{#update-aem-instance}

Om du vill uppdatera AEM-instansen väljer du _ellipsikonen_ bredvid miljönamnet i Adobe [Cloud Manager](https://my.cloudmanager.adobe.com/)s _Environment_ och sedan alternativet **Update** .

![Uppdatera AEM-instans](./assets/setup/update-aem-instance.png)

Klicka sedan på knappen **Skicka** och kör den _föreslagna_ kompletta stackpipeline.

![Välj den senaste versionen av AEM](./assets/setup/select-latest-aem-release.png)

I det här fallet heter Pipeline i helhög **Dev :: Fullstack-Deploy** och AEM-miljön kallas **wknd-program-dev**. Dina namn kan vara olika.

### Lägg till nya produktprofiler{#add-new-product-profiles}

Om du vill lägga till nya produktprofiler i AEM-instansen går du till avsnittet _Miljö_ för Adobe [Cloud Manager](https://my.cloudmanager.adobe.com/) och markerar ikonen _ellips_ bredvid miljönamnet. Välj sedan alternativet **Lägg till produktprofiler** .

![Lägg till nya produktprofiler](./assets/setup/add-new-product-profiles.png)

Du kan granska de nya produktprofilerna genom att klicka på ikonen _ellips_ bredvid miljönamnet och välja **Hantera åtkomst** > **Författarprofiler**.

Fönstret _Admin Console_ visar de nya produktprofilerna.

![Granska nya produktprofiler](./assets/setup/review-new-product-profiles.png)

Ovanstående steg avslutar moderniseringen av AEM as a Cloud Service-miljön.

## Aktivera åtkomst till AEM API:er{#enable-aem-apis-access}

Förekomsten av de _nya produktprofilerna_ aktiverar OpenAPI-baserad AEM API-åtkomst i Adobe Developer Console (ADC). Kom ihåg att [Adobe Developer Console (ADC)](./overview.md#accessing-adobe-apis-and-related-concepts) är utvecklarnavet för åtkomst till Adobe API:er, SDK:er, realtidshändelser, serverlösa funktioner med mera.

De nya produktprofilerna är kopplade till _tjänsterna_ som representerar _AEM-användargrupper med fördefinierade åtkomstkontrollistor_. _Tjänsterna_ används för att styra åtkomstnivån för AEM API:er.

Du kan också markera eller avmarkera de _tjänster_ som är kopplade till produktprofilen för att minska eller öka åtkomstnivån.

Granska associationen genom att klicka på ikonen _Visa detaljer_ bredvid produktprofilens namn.

![Granska tjänster som är kopplade till produktprofilen](./assets/setup/review-services-associated-with-product-profile.png)

### Aktivera åtkomst till AEM Assets API:er{#enable-aem-assets-apis-access}

Som standard är **AEM Assets API-användartjänsten** inte kopplad till någon produktprofil. Låt oss associera det med den nya produktprofilen **AEM Assets Collaborator Users - författare - Program XXX - Miljö XXX** eller någon annan produktprofil som du vill använda för AEM Assets API-åtkomst.

![Koppla AEM Assets API-användartjänst till produktprofil](./assets/setup/associate-aem-assets-api-users-service-with-product-profile.png)

### Aktivera autentisering från server till server

Om du vill aktivera autentisering från server till server för de AEM-API:er du vill använda måste användaren som konfigurerar integrering med Adobe Developer Console (ADC) läggas till som utvecklare i den produktprofil där tjänsten är kopplad.

Om du till exempel vill aktivera autentisering från server till server för AEM Assets API måste användaren läggas till som utvecklare i produktprofilen för **AEM Assets Collaborator Users - författare - Program XXX - Miljö XXX**.

![Koppla utvecklare till produktprofil](./assets/setup/associate-developer-to-product-profile.png)

Efter den här associationen kan ADC-projektets _API för tillgångsförfattare_ konfigurera den önskade autentiseringen från server till server och associera autentiseringskontot från ADC-projektet (som skapas i nästa steg) med produktprofilen.

>[!IMPORTANT]
>
>Ovanstående steg är viktigt för att aktivera autentisering från server till server för önskat AEM API. Utan den här associationen kan AEM API inte användas med autentiseringsmetoden Server-till-server.

## Skapa Adobe Developer Console-projekt (ADC){#adc-project}

ADC-projektet används för att lägga till önskade API:er, konfigurera autentiseringen och associera autentiseringskontot med produktprofilen.

Så här skapar du ett ADC-projekt:

1. Logga in på [Adobe Developer Console](https://developer.adobe.com/console) med din Adobe ID.

   ![Adobe Developer Console](./assets/setup/adobe-developer-console.png)

1. I avsnittet _Snabbstart_ klickar du på knappen **Skapa nytt projekt** .

   ![Skapa nytt projekt](./assets/setup/create-new-project.png)

1. Ett nytt projekt med standardnamnet skapas.

   ![Nytt projekt har skapats](./assets/setup/new-project-created.png)

1. Redigera projektnamnet genom att klicka på knappen **Redigera projekt** i det övre högra hörnet. Ange ett beskrivande namn och klicka på **Spara**.

   ![Redigera projektnamn](./assets/setup/edit-project-name.png)

## Konfigurera ADC-projekt{#configure-adc-project}

När du har skapat ADC-projektet måste du lägga till de AEM-API:er du vill använda, konfigurera autentiseringen och associera autentiseringskontot med produktprofilen.

1. Om du vill lägga till AEM API:er klickar du på knappen **Lägg till API** .

   ![Lägg till API](./assets/s2s/add-api.png)

1. I dialogrutan _Lägg till API_ filtrerar du efter _Experience Cloud_ och väljer önskat AEM-API. I det här fallet har till exempel _API:t för resursförfattare_ valts.

   ![Lägg till AEM API](./assets/s2s/add-aem-api.png)

1. I dialogrutan _Konfigurera API_ väljer du sedan önskat autentiseringsalternativ. I det här fallet är autentiseringsalternativet **Server-till-server** markerat.

   ![Välj autentisering](./assets/s2s/select-authentication.png)

   Server-till-server-autentiseringen är idealisk för backend-tjänster som behöver API-åtkomst utan användarinteraktion. Autentiseringsalternativen Web App och Single Page App är lämpliga för program som behöver API-åtkomst åt användarna. Mer information finns i [Skillnaden mellan autentiseringsuppgifter för OAuth Server-to-Server och Web App respektive Single Page App ](./overview.md#difference-between-oauth-server-to-server-vs-web-app-vs-single-page-app-credentials).

   >[!TIP]
   >
   >Om du inte ser autentiseringsalternativet Server-till-server betyder det att användaren som ställer in integreringen inte läggs till som utvecklare i den produktprofil där tjänsten är kopplad. Mer information finns i [Aktivera autentisering från server till server](#enable-server-to-server-authentication).


1. Om det behövs kan du byta namn på API:t för enklare identifiering. I demosyfte används standardnamnet.

   ![Byt namn på autentiseringsuppgifter](./assets/s2s/rename-credential.png)

1. I det här fallet är autentiseringsmetoden **OAuth Server-to-Server** så du måste associera autentiseringskontot med produktprofilen. Välj **AEM Assets Collaborator Users - författare - Program XXX - Miljö XXX** Produktprofil och klicka på **Spara**.

   ![Välj produktprofil](./assets/s2s/select-product-profile.png)

1. Granska AEM API och autentiseringskonfigurationen.

   ![AEM API-konfiguration](./assets/s2s/aem-api-configuration.png)

   ![Autentiseringskonfiguration](./assets/s2s/authentication-configuration.png)

Om du väljer autentiseringsmetoden **OAuth Web App** eller **OAuth Single Page App** uppmanas inte associationen för produktprofilen, men en omdirigerings-URI krävs. Omdirigerings-URI för programmet används för att dirigera om användaren till programmet efter autentisering med en auktoriseringskod. De relevanta självstudiekurserna för användningsfall visar sådana autentiseringsspecifika konfigurationer.

## Konfigurera AEM-instansen för att aktivera ADC-projektkommunikation{#configure-aem-instance}

Om du vill att ADC-projektets ClientID ska kunna kommunicera med AEM-instansen måste du konfigurera AEM-instansen.

Detta görs genom att definiera API-konfigurationen i en YAML-fil och distribuera den med Config Pipeline i Cloud Manager. YAML-filen definierar de tillåtna klient-ID:n från ADC-projektet som kan kommunicera med AEM-instansen.

1. Leta reda på eller skapa filen `api.yaml` från mappen `config` i AEM Project.

   ![Hitta API YAML](./assets/setup/locate-api-yaml.png){width="500" zoomable="no"}

1. Lägg till följande konfiguration i filen `api.yaml`.

   ```yaml
   kind: "API"
   version: "1.0"
   metadata: 
       envTypes: ["dev", "stage", "prod"]
   data:
       allowedClientIDs:
           author:
           - "<ADC Project's Credentials ClientID>"
   ```

   Ersätt `<ADC Project's Credentials ClientID>` med det faktiska klient-ID:t för ADC-projektets autentiseringsuppgifter-värde. API-slutpunkten som används i den här självstudiekursen är bara tillgänglig på författarnivån, men för andra API:er kan yaml-konfigurationen också ha en _publish_ - eller _preview_ -nod.

   >[!CAUTION]
   >
   > För demoändamål används samma ClientID för alla miljöer. Vi rekommenderar att du använder ett separat ClientID per miljö (dev, stage, prod) för bättre säkerhet och kontroll.

1. Bekräfta konfigurationsändringarna och skicka ändringarna till Git-fjärrdatabasen som Cloud Manager pipeline är ansluten till.

1. Distribuera ovanstående ändringar med Config Pipeline i Cloud Manager. Observera att filen `api.yaml` också kan installeras i en RDE med kommandoradsverktyg.

   ![Distribuera YAML](./assets/setup/config-pipeline.png)

## Nästa steg

När AEM-instansen har konfigurerats för att aktivera ADC-projektkommunikation kan du börja använda de OpenAPI-baserade AEM-API:erna. Lär dig hur du använder OpenAPI-baserade AEM API:er med olika OAuth-autentiseringsmetoder:

<!-- CARDS
{target = _self}

* ./use-cases/invoke-api-using-oauth-s2s.md
  {title = Invoke API using Server-to-Server authentication}
  {description = Learn how to invoke OpenAPI-based AEM APIs from a custom NodeJS application using OAuth Server-to-Server authentication.}
  {image = ./assets/s2s/OAuth-S2S.png}
* ./use-cases/invoke-api-using-oauth-web-app.md
  {title = Invoke API using Web App authentication}
  {description = Learn how to invoke OpenAPI-based AEM APIs from a custom web application using OAuth Web App authentication.}
  {image = ./assets/web-app/OAuth-WebApp.png}
* ./use-cases/invoke-api-using-oauth-single-page-app.md
  {title = Invoke API using Single Page App authentication}
  {description = Learn how to invoke OpenAPI-based AEM APIs from a custom Single Page App (SPA) using OAuth 2.0 PKCE flow.}
  {image = ./assets/spa/OAuth-SPA.png}  
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Invoke API using Server-to-Server authentication">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/invoke-api-using-oauth-s2s.md" title="Anropa API med autentisering från server till server" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/s2s/OAuth-S2S.png" alt="Anropa API med autentisering från server till server"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/invoke-api-using-oauth-s2s.md" target="_self" rel="referrer" title="Anropa API med autentisering från server till server">Anropa API med autentisering från server till server</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anropar OpenAPI-baserade AEM-API:er från ett anpassat NodeJS-program med OAuth Server-till-Server-autentisering.</p>
                </div>
                <a href="./use-cases/invoke-api-using-oauth-s2s.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Invoke API using Web App authentication">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/invoke-api-using-oauth-web-app.md" title="Anropa API med autentisering i webbapp" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/web-app/OAuth-WebApp.png" alt="Anropa API med autentisering i webbapp"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/invoke-api-using-oauth-web-app.md" target="_self" rel="referrer" title="Anropa API med autentisering i webbapp">Anropa API med autentisering via webbapp</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anropar OpenAPI-baserade AEM-API:er från ett anpassat webbprogram med OAuth Web App-autentisering.</p>
                </div>
                <a href="./use-cases/invoke-api-using-oauth-web-app.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Invoke API using Single Page App authentication">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/invoke-api-using-oauth-single-page-app.md" title="Anropa API med autentisering för Single Page App" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/spa/OAuth-SPA.png" alt="Anropa API med autentisering för Single Page App"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/invoke-api-using-oauth-single-page-app.md" target="_self" rel="referrer" title="Anropa API med autentisering för Single Page App">Anropa API med autentisering för Single Page-app</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anropar OpenAPI-baserade AEM-API:er från en anpassad Single Page App (SPA) med OAuth 2.0 PKCE-flöde.</p>
                </div>
                <a href="./use-cases/invoke-api-using-oauth-single-page-app.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->
