---
title: AEM Headless server-to-server-driftsättningar
description: Ta reda på vad som gäller vid driftsättning av AEM Headless-versioner från server till server.
version: Experience Manager as a Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10798
thumbnail: kt-10798.jpg
exl-id: d4ae08d9-dc43-4414-ab75-26853186a301
duration: 48
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '237'
ht-degree: 0%

---

# AEM Headless server-to-server-driftsättningar

AEM Headless-driftsättning från server till server innefattar serverprogram eller processer som använder och interagerar med innehåll i AEM utan problem.

Server-till-server-distributioner kräver minimal konfiguration eftersom HTTP-anslutningar till AEM Headless-API:er inte initieras i en webbläsare.

## Distributionskonfigurationer

Följande distributionskonfiguration måste finnas på plats för programdistributioner från server till server.

| Server-till-server-appen ansluter till → | AEM Author | AEM Publish | AEM Preview |
|---------------------------------------------------------------:|:----------:|:-----------:|:-----------:|
| [Dispatcher-filter](./configurations/dispatcher-filters.md) | ✘ | ✔ | ✔ |
| Cross-origin resource sharing (CORS) | ✘ | ✘ | ✘ |
| [AEM-värdar](./configurations/aem-hosts.md) | ✔ | ✔ | ✔ |

## Krav för tillstånd

Auktoriserade begäranden till AEM GraphQL API:er som vanligtvis görs i samband med server-till-server-appar, eftersom andra apptyper, som [single-page apps](./spa.md), [mobile](./mobile.md) eller [Web Components](./web-component.md), vanligtvis använder auktorisering eftersom det är svårt att skydda autentiseringsuppgifterna.

När du auktoriserar begäranden till AEM as a Cloud Service ska du använda [tjänstens autentiseringsuppgifter-baserade tokenautentisering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/generating-access-tokens-for-server-side-apis.html?lang=sv-SE). Om du vill veta mer om hur du autentiserar begäranden till AEM as a Cloud Service kan du läsa den [tokenbaserade självstudiekursen för autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html?lang=sv-SE). I självstudien utforskas tokenbaserad autentisering med [AEM Assets HTTP API:er](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/admin/mac-api-assets.html?lang=sv-SE), men samma koncept och tillvägagångssätt gäller för appar som interagerar med AEM Headless GraphQL API:er.

## Exempel på server-till-server-app

Adobe tillhandahåller ett exempel på en server-till-server-app som kodats i Node.js.

<div class="columns is-multiline">
    <!-- Server-to-server app -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Server-to-server app" tabindex="0">
       <div class="card">
           <div class="card-image">
               <figure class="image is-16by9">
                   <a href="../example-apps/server-to-server-app.md" title="Server-till-server-app" tabindex="-1">
                       <img class="is-bordered-r-small" src="../example-apps/assets/server-to-server-app/server-to-server-card.png" alt="Server-till-server-app">
                   </a>
               </figure>
           </div>
           <div class="card-content is-padded-small">
               <div class="content">
                   <p class="headline is-size-6 has-text-weight-bold"><a href="../example-apps/server-to-server-app.md" title="Server-till-server-app">Server-till-server-app</a></p>
                   <p class="is-size-6">Ett exempel på en server-till-server-app, skrivet i Node.js, som använder innehåll från AEM Headless GraphQL API:er.</p>
                   <a href="../example-apps/server-to-server-app.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                       <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Visa exempel </span>
                   </a>
               </div>
           </div>
       </div>
    </div>
</div>
