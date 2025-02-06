---
title: AEM API:er - översikt
description: Lär dig mer om de olika typerna av API:er i Adobe Experience Manager (AEM) och få en översikt över OpenAPI-specifikationsbaserade API:er, som ofta kallas OpenAPI-baserade AEM API:er.
version: Cloud Service
feature: Developing
topic: Development, Architecture, Content Management
role: Architect, Developer, Leader
level: Beginner
doc-type: Article
jira: KT-16515
thumbnail: KT-16515.jpeg
last-substantial-update: 2024-11-20T00:00:00Z
duration: 0
exl-id: 23b2be0d-a8d4-4521-96ba-78b70f4e9cba
source-git-commit: 2b5f7a033921270113eb7f41df33444c4f3d7723
workflow-type: tm+mt
source-wordcount: '1024'
ht-degree: 0%

---

# AEM API:er - översikt{#aem-apis-overview}

Lär dig mer om de olika typerna av API:er i Adobe Experience Manager (AEM) as a Cloud Service och få en översikt över [OAS ](https://swagger.io/specification/)-baserade (OpenAPI Specification) AEM API:er, som ofta kallas OpenAPI-baserade AEM API:er.

AEM as a Cloud Service har ett stort antal API:er för att skapa, läsa, uppdatera och ta bort innehåll, resurser och formulär. Med dessa API:er kan utvecklare skapa anpassade program som interagerar med AEM.

Låt oss utforska de olika typerna av API:er i AEM och förstå de viktigaste begreppen för att komma åt Adobe API:er.

## Typer av AEM API:er{#types-of-aem-apis}

AEM erbjuder både äldre och moderna API:er för interaktion med författare och publiceringstjänster.

- **Äldre API:er**: Infördes i tidigare AEM versioner, men äldre API:er stöds fortfarande för bakåtkompatibilitet.

- **Moderna API:er**: Baserat på REST, OpenAPI-specifikationen följer dessa API:er aktuella API-designstandarder och rekommenderas för nya integreringar.


| AEM API-typ | Specifikationer | Tillgänglighet | Användningsfall | Exempel |
| --- | --- | --- | --- | --- |
| Traditionella (icke-RESTful) API:er | Sling Servlets | AEM 6.X, AEM as a Cloud Service | Äldre integreringar, bakåtkompatibilitet | [API:t för frågebyggaren](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/full-stack/search/query-builder-api) med flera |
| RESTful API:er | HTTP, JSON | AEM 6.X, AEM as a Cloud Service | CRUD-åtgärder, moderna program | [Assets HTTP API](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/assets/admin/mac-api-assets), [REST API för arbetsflöde](https://experienceleague.adobe.com/en/docs/experience-manager-65/content/implementing/developing/extending-aem/extending-workflows/workflows-program-interaction#using-the-workflow-rest-api), [JSON Exporter för innehållstjänster](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/full-stack/components-templates/json-exporter) med flera |
| GraphQL API:er | GraphQL | AEM 6.X, AEM as a Cloud Service | Headless CMS, SPA, mobile apps | [GraphQL API](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/headless/graphql-api/content-fragments) |
| OpenAPI-baserade AEM API:er | REST, OpenAPI | **Endast AEM as a Cloud Service** | API-utveckling först, moderna program | [Assets Author API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/), [Mappar API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/folders/), [AEM Sites API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/sites/delivery/), [Forms Acrobat Services](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/document/) med flera |

>[!IMPORTANT]
>
>OpenAPI-baserade AEM-API:er är bara tillgängliga i AEM as a Cloud Service och är inte kompatibla med AEM 6.X.

Mer information om AEM API:er finns i [Adobe Experience Manager as a Cloud Service API:er](https://developer.adobe.com/experience-cloud/experience-manager-apis/).

Låt oss titta närmare på OpenAPI-baserade API:er för AEM och de viktiga begreppen för att komma åt Adobe API:er.

## OpenAPI-baserade AEM API:er{#openapi-based-aem-apis}

>[!AVAILABILITY]
>
>OpenAPI-baserade AEM API:er är tillgängliga som en del av ett program för tidig åtkomst. Om du är intresserad av att få tillgång till dem bör du skicka ett e-postmeddelande till [aem-apis@adobe.com](mailto:aem-apis@adobe.com) med en beskrivning av ditt användningsfall.

[OpenAPI-specifikationen ](https://swagger.io/specification/) (tidigare Swagger) är en vanlig standard för att definiera RESTful-API:er. AEM as a Cloud Service innehåller flera OpenAPI-specifikationsbaserade API:er (eller helt enkelt OpenAPI-baserade AEM API:er), vilket gör det enklare att skapa anpassade program som interagerar med AEM författare eller publiceringstjänsttyper. Nedan följer några exempel:

**Webbplatser**

- [Webbplatser-API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/sites/delivery/): API:er för arbete med innehållsfragment.

**Assets**

- [Mappar-API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/folders/): API:er för att arbeta med mappar som att skapa, lista och ta bort mappar.

- [Assets Author API](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/assets/author/): API:er för att arbeta med resurser och metadata.

**Forms**

- [Forms Communications API:er](https://developer.adobe.com/experience-cloud/experience-manager-apis/api/experimental/document/): API:er för att arbeta med formulär och dokument.

I framtida versioner kommer fler OpenAPI-baserade AEM-API:er att läggas till som stöd för fler användningsfall.

### Autentiseringsstöd{#authentication-support}

OpenAPI-baserade AEM-API:er har stöd för följande autentiseringsmetoder:

- **Autentiseringsuppgifter för OAuth Server-till-Server**: Perfekt för backend-tjänster som behöver API-åtkomst utan användarinteraktion. Den använder anslagstypen _client_credentials_, vilket möjliggör säker åtkomsthantering på servernivå. Mer information finns i [Autentiseringsuppgifter för OAuth Server-till-server](https://developer.adobe.com/developer-console/docs/guides/authentication/ServerToServerAuthentication/#oauth-server-to-server-credential).

- **Autentiseringsuppgifter för OAuth-webbprogram**: Passar för webbprogram med klientkomponenter och _backend_-komponenter som använder AEM API:er åt användare. Den använder anslagstypen _permission_code_, där serverdelsservern hanterar hemligheter och token på ett säkert sätt. Mer information finns i [Autentiseringsuppgifter för OAuth-webbprogram](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/implementation/#oauth-web-app-credential).

- **Autentiseringsuppgifter för Fristående sidprogram**: Skapat för SPA som körs i webbläsaren, som behöver komma åt API:er för en användare utan serverdelsserver. Den använder anslagstypen _permission_code_ och förlitar sig på säkerhetsmekanismer på klientsidan med PKCE (Proof Key for Code Exchange) för att skydda auktoriseringskodflödet. Mer information finns i [Autentiseringsuppgifter för fristående program för OAuth](https://developer.adobe.com/developer-console/docs/guides/authentication/UserAuthentication/implementation/#oauth-single-page-app-credential).

### Skillnad mellan autentiseringsuppgifter för OAuth Server-to-Server och OAuth Web App/Single Page App{#difference-between-oauth-server-to-server-and-oauth-web-app-single-page-app-credentials}

| | OAuth server-till-server | OAuth-användarautentisering (webbprogram) |
| --- | --- | --- |
| Autentiseringssyfte | Utformad för interaktion mellan dator och dator. | Utformad för användardrivna interaktioner. |
| Tokenbeteende | Utfärdar åtkomsttoken som representerar själva klientprogrammet. | Utfärdar åtkomsttoken för en autentiserad användare. |
| Användningsexempel | Backend-tjänster som behöver API-åtkomst utan användarinteraktion. | Webbprogram med klientkomponenter och backend-komponenter som använder API:er å användarnas vägnar. |
| Säkerhetsaspekter | Lagra känsliga autentiseringsuppgifter (`client_id`, `client_secret`) säkert i backend-system. | Användarens autentisering och får en egen temporär åtkomsttoken. Lagra känsliga autentiseringsuppgifter (`client_id`, `client_secret`) säkert i backend-system. |
| Typ av bidrag | _client_credentials_ | _authentication_code_ |

### Åtkomst till Adobe API:er och relaterade koncept{#accessing-adobe-apis-and-related-concepts}

Innan du får åtkomst till API:er för Adobe är det viktigt att du förstår dessa viktiga begrepp:

- **[Adobe Developer Console](https://developer.adobe.com/)**: Utvecklarhubben för åtkomst till Adobe API:er, SDK:er, realtidshändelser, serverlösa funktioner med mera. Observera att den skiljer sig från _AEM_ Developer Console, som används för att felsöka AEM program.

- **[Adobe Developer Console Project](https://developer.adobe.com/developer-console/docs/guides/projects/)**: Central plats för hantering av API-integreringar, händelser och körningsfunktioner. Här konfigurerar du API:er, anger autentisering och genererar nödvändiga autentiseringsuppgifter.

- **[Produktprofiler](https://helpx.adobe.com/enterprise/using/manage-product-profiles.html)**: Produktprofiler innehåller en behörighetsförinställning som gör att du kan styra användar- eller programåtkomst till Adobe-produkter som AEM, Adobe Target, Adobe Analytics och andra. Alla Adobe-produkter har fördefinierade produktprofiler.

- **Tjänster**: Tjänsterna definierar de faktiska behörigheterna och är associerade med produktprofilen. Om du vill minska eller öka behörighetsförinställningen kan du avmarkera eller välja de tjänster som är kopplade till produktprofilen. Det innebär att du kan styra åtkomstnivån för produkten och dess API:er. I AEM as a Cloud Service representerar tjänster användargrupper med fördefinierade åtkomstkontrollistor (ACL) för databasnoder, vilket möjliggör detaljerad behörighetshantering.

## Nästa steg{#next-steps}

Med förståelse för de olika AEM API-typerna, inklusive
OpenAPI-baserade AEM-API:er och de viktigaste begreppen för att få åtkomst till Adobe API:er är nu färdiga att börja skapa anpassade program som interagerar med AEM.

Vi börjar med:

- [Anropa OpenAPI-baserade AEM-API:er för server-till-server-autentisering](invoke-openapi-based-aem-apis.md), som demonstrerar hur du får åtkomst till OpenAPI-baserade AEM-API:er _med hjälp av OAuth Server-till-Server-autentiseringsuppgifter_.
- [Anropa OpenAPI-baserade AEM-API:er med användarautentisering från en webbapp](invoke-openapi-based-aem-apis-from-web-app.md) som demonstrerar hur du får åtkomst till OpenAPI-baserade AEM-API:er från ett _webbprogram med hjälp av OAuth Web App-autentiseringsuppgifter_.
