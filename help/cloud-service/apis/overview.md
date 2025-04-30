---
title: AEM API:er - översikt
description: Lär dig mer om de olika typerna av API:er i Adobe Experience Manager (AEM) och förstå vilket API du ska välja för integreringen.
version: Experience Manager as a Cloud Service
feature: Developing
topic: Development, Architecture, Content Management
role: Architect, Developer, Leader
level: Beginner
doc-type: Article
jira: KT-17425
thumbnail: KT-17425.jpeg
last-substantial-update: 2025-02-28T00:00:00Z
duration: 0
exl-id: 23b2be0d-a8d4-4521-96ba-78b70f4e9cba
source-git-commit: 7cd9efb62d1afdcc089e1e6260d6cf2fc5495afe
workflow-type: tm+mt
source-wordcount: '999'
ht-degree: 0%

---

# AEM API:er - översikt{#aem-apis-overview}

Lär dig mer om de olika typerna av API:er i Adobe Experience Manager (AEM) och förstå vilket API du ska välja för integreringen.

För att skapa, läsa, uppdatera och ta bort innehåll, resurser och formulär i AEM kan utvecklare använda ett stort antal API:er. Med dessa API:er kan utvecklare skapa anpassade program som interagerar med AEM.

Låt oss utforska de olika typerna av API:er i AEM och förstå vilket API som du ska välja för integreringen.

## Typer av AEM API:er{#types-of-aem-apis}

AEM erbjuder följande API:er för interaktion med författare och publiceringstjänster.

| AEM API-typ | Beskrivning | Tillgänglighet | Användningsfall | API-exempel |
| --- | --- | --- | --- | --- |
| OpenAPI-baserade AEM API:er | Standardiserade, maskinläsbara API:er för Assets, Sites och Forms. | **Endast AEM as a Cloud Service** | API-utveckling först, moderna program | [API:t för Assets-författare](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/), [API:t för mappar](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/folders/), [API:t för AEM Sites](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/stable/sites/), [API:t för Forms Document Services](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/document/) med flera |
| RESTful API:er | Traditionella REST-slutpunkter för interaktion med AEM-resurser. | AEM 6.X, AEM as a Cloud Service | CRUD-åtgärder, moderna program | [Assets HTTP API](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/assets/admin/mac-api-assets), [REST API för arbetsflöde](https://experienceleague.adobe.com/en/docs/experience-manager-65/content/implementing/developing/extending-aem/extending-workflows/workflows-program-interaction#using-the-workflow-rest-api), [JSON Exporter för innehållstjänster](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/full-stack/components-templates/json-exporter) med flera |
| GraphQL API:er | Optimerad för att effektivt hämta strukturerat innehåll med flexibla frågor. | AEM 6.X, AEM as a Cloud Service | Headless CMS, SPA, mobile apps | [GraphQL API](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/headless/graphql-api/content-fragments) |
| Traditionella (icke-RESTful) API:er | Äldre API:er som JCR, Sling Models, Query Builder med flera. | AEM 6.X, AEM as a Cloud Service | Äldre integreringar, bakåtkompatibilitet | [API:t för frågebyggaren](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/full-stack/search/query-builder-api) med flera |

Mer information finns på sidan [Adobe Experience Manager as a Cloud Service API:er](https://developer.adobe.com/experience-cloud/experience-manager-apis/).

## Vilken API du ska välja{#which-api-to-choose}

Tänk på följande när du väljer ett API för integreringen:

- **Användningsfall**: Kontrollera om AEM-API:t stöder ditt användningsfall. _Använd, när det är möjligt, OpenAPI-baserade AEM-API:er_ eftersom de ger ett standardiserat, modernt sätt att interagera med AEM. Om OpenAPI-baserade API:er inte är tillgängliga bör du använda RESTful API:er eller GraphQL API:er och som en sista utväg även traditionella API:er.

- **Kompatibilitet**: Kontrollera att det valda API:t är kompatibelt med din AEM-version. _OpenAPI-baserade AEM-API:er är till exempel bara för AEM as a Cloud Service_ och är inte tillgängliga i AEM 6.X.

- **AEM tjänsttyp: Författare kontra Publicera**: Vilken API som ska användas beror också på om den körs på författaren eller publiceringstjänsten, eftersom deras åtkomstmodeller är olika. AEM Author-tjänsten används för att skapa innehåll och kräver alltid autentisering. AEM Publish-tjänsten används för innehållsleverans och behöver kanske inte autentiseras, beroende på användningsfallet.

- **Autentisering**: Verifiera att API:t har stöd för den autentiseringsmetod du tänker använda. Till exempel:
   - **OpenAPI-baserade AEM-API:er**: stöd för OAuth 2.0-autentisering, inklusive klientautentiseringsuppgifter (Server-to-Server), auktoriseringskod (Web App) och korrekturnyckel för tilldelningstyper för kodutbyte (Single Page App). Andra AEM-API:er stöder inte OAuth 2.0-autentisering.
   - **RESTful API:er**: stöder JSON Web Token-autentisering (JWT) och fungerar även som tokenbaserad autentisering.

## Skillnad mellan JSON Web Token (JWT) och OAuth 2.0{#difference-between-jwt-and-oauth}

Låt oss jämföra JSON Web Token (JWT) och OAuth 2.0, två vanliga autentiseringsmekanismer som används i AEM API:er:

| Funktion | JSON Web Token (JWT) | OAuth 2.0 |
| --- | --- | --- |
| Används i | RESTful API:er | OpenAPI-baserade AEM-API:er (stöds inte i RESTful eller andra API:er) |
| Syfte | Tjänstautentisering | Autentisering av användare eller tjänst |
| Användarinteraktion | Ingen användarinteraktion krävs | Användarinteraktion krävs för behörighetskoden och anslagstyperna för Single Page App |
| Passar bäst för | API-anrop från server till server | Säker, tillåten åtkomst för appar och användare |
| Nödvändig information | Privat nyckel för signering av JWT | Klient-ID och klienthemlighet för OAuth 2.0 |
| Token förfaller | Kortlivad, behöver ofta uppdateras | Åtkomsttoken är kortlivad. Uppdateringstoken är långvarig och används för att hämta en ny åtkomsttoken |
| Hantering av autentiseringsuppgifter | [AEM Developer Console](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/debugging/debugging-aem-as-a-cloud-service/developer-console) | [Adobe Developer Console](https://developer.adobe.com/developer-console/) |

## OpenAPI-baserade AEM API:er

Läs mer om de OpenAPI-baserade AEM-API:erna och de viktiga begreppen för att komma åt Adobe-API:er i [OpenAPI-baserade AEM API:er](./openapis/overview.md) .

### Användningsexempel

<!-- CARDS
{target = _self}

* ./openapis/use-cases/invoke-api-using-oauth-s2s.md
  {title = Invoke API using Server-to-Server authentication}
  {description = Learn how to invoke OpenAPI-based AEM APIs from a custom NodeJS application using OAuth Server-to-Server authentication.}
  {image = ./openapis/assets/s2s/OAuth-S2S.png}
* ./openapis/use-cases/invoke-api-using-oauth-web-app.md
  {title = Invoke API using Web App authentication}
  {description = Learn how to invoke OpenAPI-based AEM APIs from a custom web application using OAuth Web App authentication.}
  {image = ./openapis/assets/web-app/OAuth-WebApp.png} 
* ./openapis/use-cases/invoke-api-using-oauth-single-page-app.md
  {title = Invoke API using OAuth Single Page App}
  {description = Learn how to invoke OpenAPI-based AEM APIs from a custom Single Page App (SPA) using OAuth 2.0 PKCE flow.}
  {image = ./openapis/assets/spa/OAuth-SPA.png}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Invoke API using Server-to-Server authentication">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./openapis/use-cases/invoke-api-using-oauth-s2s.md" title="Anropa API med autentisering från server till server" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./openapis/assets/s2s/OAuth-S2S.png" alt="Anropa API med autentisering från server till server"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./openapis/use-cases/invoke-api-using-oauth-s2s.md" target="_self" rel="referrer" title="Anropa API med autentisering från server till server">Anropa API med autentisering från server till server</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anropar OpenAPI-baserade AEM-API:er från ett anpassat NodeJS-program med OAuth Server-till-Server-autentisering.</p>
                </div>
                <a href="./openapis/use-cases/invoke-api-using-oauth-s2s.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Invoke API using Web App authentication">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./openapis/use-cases/invoke-api-using-oauth-web-app.md" title="Anropa API med autentisering i webbapp" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./openapis/assets/web-app/OAuth-WebApp.png" alt="Anropa API med autentisering i webbapp"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./openapis/use-cases/invoke-api-using-oauth-web-app.md" target="_self" rel="referrer" title="Anropa API med autentisering i webbapp">Anropa API med autentisering via webbapp</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anropar OpenAPI-baserade AEM-API:er från ett anpassat webbprogram med OAuth Web App-autentisering.</p>
                </div>
                <a href="./openapis/use-cases/invoke-api-using-oauth-web-app.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Invoke API using OAuth Single Page App">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./openapis/use-cases/invoke-api-using-oauth-single-page-app.md" title="Anropa API med OAuth Single Page App" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./openapis/assets/spa/OAuth-SPA.png" alt="Anropa API med OAuth Single Page App"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./openapis/use-cases/invoke-api-using-oauth-single-page-app.md" target="_self" rel="referrer" title="Anropa API med OAuth Single Page App">Anropa API med OAuth Single Page App</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anropar OpenAPI-baserade AEM-API:er från en anpassad Single Page App (SPA) med OAuth 2.0 PKCE-flöde.</p>
                </div>
                <a href="./openapis/use-cases/invoke-api-using-oauth-single-page-app.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->



## GraphQL API:er - exempel

Läs mer om GraphQL API:er och hur du använder dem i [Komma igång med AEM Headless - GraphQL](https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview)

### Användningsexempel

<!-- CARDS
{target = _self}

* https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/spa#example-single-page-app
  {title = Single Page Application (SPA)}
  {description = Learn how to build a Single Page Application (SPA) that fetches content from AEM using GraphQL APIs.}
  {image = ./assets/react-app-card.png}
* https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/mobile#example-mobile-apps
  {title = Mobile App}
  {description = Learn how to build a mobile app that fetches content from AEM using GraphQL APIs.}
  {image = ./assets/ios-app-card.png}
* https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/web-component#example-web-component
  {title = Web Component}
  {description = Learn how to build a web component that fetches content from AEM using GraphQL APIs.}
  {image = ./assets/web-component-card.png}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Single Page Application (SPA)">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/spa#example-single-page-app" title="Single Page Application (SPA)" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/react-app-card.png" alt="Single Page Application (SPA)"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/spa#example-single-page-app" target="_self" rel="referrer" title="Single Page Application (SPA)">Single Page Application (SPA)</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skapar ett SPA-program (Single Page Application) som hämtar innehåll från AEM med GraphQL API:er.</p>
                </div>
                <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/spa#example-single-page-app" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Mobile App">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/mobile#example-mobile-apps" title="Mobilapp" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/ios-app-card.png" alt="Mobilapp"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/mobile#example-mobile-apps" target="_self" rel="referrer" title="Mobilapp">Mobilapp</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skapar en mobilapp som hämtar innehåll från AEM med GraphQL API:er.</p>
                </div>
                <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/mobile#example-mobile-apps" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Web Component">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/web-component#example-web-component" title="Webbkomponent" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/web-component-card.png" alt="Webbkomponent"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/web-component#example-web-component" target="_self" rel="referrer" title="Webbkomponent">Webbkomponent</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skapar en webbkomponent som hämtar innehåll från AEM med GraphQL API:er.</p>
                </div>
                <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/web-component#example-web-component" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## RESTful APIs - Exempel

Läs mer om RESTful-API:er, till exempel [Assets HTTP API](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/assets/admin/mac-api-assets) och [JSON Exporter](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/full-stack/components-templates/json-exporter).

### Användningsexempel

<!-- CARDS
{target = _self}

* https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview
  {title = Using Content Services for Headless App}
  {description = Learn how to build a native mobile app that fetches content from AEM using Content Services RESTful APIs.}
  {image = ./assets/RESTful-Content-Service.png}
* https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview
  {title = Token-based Authentication for RESTful APIs}
  {description = Learn how to invoke RESTful APIs using JSON Web Token (JWT) authentication.}
  {image = ./assets/RESTful-TokenAuth.png}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Using Content Services for Headless App">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview" title="Använda innehållstjänster för Headless-appar" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/RESTful-Content-Service.png" alt="Använda innehållstjänster för Headless-appar"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview" target="_self" rel="referrer" title="Använda innehållstjänster för Headless-appar">Använda innehållstjänster för den kostnadsfria appen</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skapar en intern mobilapp som hämtar innehåll från AEM med hjälp av RESTful-API:er i Content Services.</p>
                </div>
                <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Token-based Authentication for RESTful APIs">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview" title="Tokenbaserad autentisering för RESTful API:er" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/RESTful-TokenAuth.png" alt="Tokenbaserad autentisering för RESTful API:er"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview" target="_self" rel="referrer" title="Tokenbaserad autentisering för RESTful API:er">Tokenbaserad autentisering för RESTful API:er</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anropar RESTful-API:er med JSON Web Token-autentisering (JWT).</p>
                </div>
                <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->


