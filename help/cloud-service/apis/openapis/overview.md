---
title: OpenAPI-baserade AEM API:er
description: Lär dig mer om OpenAPI-baserade AEM API:er, inklusive autentiseringsstöd, viktiga koncept och hur du får tillgång till Adobe API:er.
version: Cloud Service
feature: Developing
topic: Development, Architecture, Content Management
role: Architect, Developer, Leader
level: Beginner
doc-type: Article
jira: KT-16515
thumbnail: KT-16515.jpeg
last-substantial-update: 2025-02-28T00:00:00Z
duration: 0
source-git-commit: e4cf47e14fa7dfc39ab4193d35ba9f604eabf99f
workflow-type: tm+mt
source-wordcount: '835'
ht-degree: 0%

---


# OpenAPI-baserade AEM API:er

>[!IMPORTANT]
>
>OpenAPI-baserade AEM-API:er är bara tillgängliga i AEM as a Cloud Service och är inte kompatibla med AEM 6.X.

Lär dig mer om OpenAPI-baserade AEM API:er, inklusive autentiseringsstöd, viktiga koncept och hur du får tillgång till Adobe API:er.

[OpenAPI-specifikationen ](https://swagger.io/specification/) (tidigare Swagger) är en vanlig standard för att definiera RESTful-API:er. AEM as a Cloud Service tillhandahåller flera OpenAPI-specifikationsbaserade API:er (eller helt enkelt OpenAPI-baserade AEM API:er), vilket gör det enklare att skapa anpassade program som interagerar med AEM författare eller publiceringstjänsttyper. Nedan följer några exempel:

**Webbplatser**

- [Webbplatser-API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/stable/sites/): API:er för arbete med innehållsfragment.

**Assets**

- [Mappar-API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/folders/): API:er för att arbeta med mappar som att skapa, lista och ta bort mappar.

- [Assets Author API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/): API:er för att arbeta med resurser och metadata.

**Forms**

- [Forms Communications API:er](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/document/): API:er för att arbeta med formulär och dokument.

I framtida versioner kommer fler OpenAPI-baserade AEM-API:er att läggas till som stöd för fler användningsfall.

>[!AVAILABILITY]
>
>OpenAPI-baserade AEM API:er är tillgängliga som en del av ett program för tidig åtkomst. Om du är intresserad av att få tillgång till dem bör du skicka ett e-postmeddelande till [aem-apis@adobe.com](mailto:aem-apis@adobe.com) med en beskrivning av ditt användningsfall.

## Autentiseringsstöd{#authentication-support}

OpenAPI-baserade AEM-API:er stöder OAuth 2.0-autentisering, inklusive följande typer av bidrag:

- **Autentiseringsuppgifter för OAuth Server-till-Server**: Perfekt för backend-tjänster som behöver API-åtkomst utan användarinteraktion. Den använder anslagstypen _client_credentials_, vilket möjliggör säker åtkomsthantering på servernivå. Mer information finns i [Autentiseringsuppgifter för OAuth Server-till-server](https://developer.adobe.com/developer-console/docs/guides/authentication/ServerToServerAuthentication/#oauth-server-to-server-credential).

- **Autentiseringsuppgifter för OAuth-webbprogram**: Passar för webbprogram med klientkomponenter och _backend_-komponenter som har åtkomst till AEM API:er för användare. Den använder anslagstypen _permission_code_, där serverdelsservern hanterar hemligheter och token på ett säkert sätt. Mer information finns i [Autentiseringsuppgifter för OAuth-webbprogram](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/implementation/#oauth-web-app-credential).

- **Autentiseringsuppgifter för fristående program för OAuth**: Avsett för SPA som körs i webbläsaren, som behöver komma åt API:er för en användare utan serverdel. Den använder anslagstypen _permission_code_ och förlitar sig på säkerhetsmekanismer på klientsidan med PKCE (Proof Key for Code Exchange) för att skydda auktoriseringskodflödet. Mer information finns i [Autentiseringsuppgifter för fristående program för OAuth](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/implementation/#oauth-single-page-app-credential).

## Skillnad mellan autentiseringsuppgifter för OAuth Server-to-Server och OAuth Web App/Single Page App{#difference-between-oauth-server-to-server-and-oauth-web-app-single-page-app-credentials}

| | OAuth server-till-server | OAuth-användarautentisering (webbprogram) |
| --- | --- | --- |
| Autentiseringssyfte | Utformad för interaktion mellan dator och dator. | Utformad för användardrivna interaktioner. |
| Tokenbeteende | Utfärdar åtkomsttoken som representerar själva klientprogrammet. | Utfärdar åtkomsttoken för en autentiserad användare. |
| Användningsexempel | Backend-tjänster som behöver API-åtkomst utan användarinteraktion. | Webbprogram med klientkomponenter och backend-komponenter som använder API:er å användarnas vägnar. |
| Säkerhetsaspekter | Lagra känsliga autentiseringsuppgifter (`client_id`, `client_secret`) säkert i backend-system. | Användarens autentisering och får en egen temporär åtkomsttoken. Lagra känsliga autentiseringsuppgifter (`client_id`, `client_secret`) säkert i backend-system. |
| Typ av bidrag | _client_credentials_ | _authentication_code_ |

## Åtkomst till Adobe API:er och relaterade koncept{#accessing-adobe-apis-and-related-concepts}

Innan du får åtkomst till Adobe API:er är det viktigt att du förstår dessa viktiga konstruktioner:

- **[Adobe Developer Console](https://developer.adobe.com/)**: Utvecklarhubben för åtkomst till Adobe API:er, SDK:er, realtidshändelser, serverlösa funktioner med mera. Observera att den skiljer sig från _AEM_ Developer Console, som används för att felsöka AEM-program.

- **[Adobe Developer Console Project](https://developer.adobe.com/developer-console/docs/guides/projects/)**: Central plats för hantering av API-integreringar, händelser och körningsfunktioner. Här konfigurerar du API:er, anger autentisering och genererar nödvändiga autentiseringsuppgifter.

- **[Produktprofiler](https://helpx.adobe.com/enterprise/using/manage-product-profiles.html)**: Produktprofiler innehåller en behörighetsförinställning som gör att du kan styra användar- eller programåtkomst till Adobe-produkter som AEM, Adobe Target, Adobe Analytics och andra. Alla Adobe-produkter har fördefinierade produktprofiler.

- **Tjänster**: Tjänsterna definierar de faktiska behörigheterna och är associerade med produktprofilen. Om du vill minska eller öka behörighetsförinställningen kan du avmarkera eller välja de tjänster som är kopplade till produktprofilen. Det innebär att du kan styra åtkomstnivån för produkten och dess API:er. I AEM as a Cloud Service representerar tjänster användargrupper med fördefinierade åtkomstkontrollistor (ACL) för databasnoder, vilket möjliggör detaljerad behörighetshantering.

## Kom igång

Lär dig hur du konfigurerar AEM as a Cloud Service-miljön och ett Adobe Developer Console-projekt för att ge åtkomst till OpenAPI-baserade AEM API:er. Du kan även använda AEM API med webbläsare för att kontrollera konfigurationen och granska begäran och svar.

<!-- CARDS
{target = _self}

* ./setup.md
  {title = Set up OpenAPI-based AEM APIs}
  {description = Learn how to set up your AEM as a Cloud Service environment to enable access to the OpenAPI-based AEM APIs.}
  {image = ./assets/setup/OpenAPI-Setup.png}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Set up OpenAPI-based AEM APIs">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./setup.md" title="Konfigurera OpenAPI-baserade AEM API:er" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/setup/OpenAPI-Setup.png" alt="Konfigurera OpenAPI-baserade AEM API:er"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./setup.md" target="_self" rel="referrer" title="Konfigurera OpenAPI-baserade AEM API:er">Konfigurera OpenAPI-baserade AEM API:er</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du konfigurerar AEM as a Cloud Service-miljön för att ge åtkomst till OpenAPI-baserade AEM API:er.</p>
                </div>
                <a href="./setup.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->


## API-självstudier

Lär dig hur du använder OpenAPI-baserade AEM API:er med olika OAuth-autentiseringsmetoder:

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
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

