---
title: Distribuera SPA för AEM GraphQL
description: Läs mer om distributionsaspekter för single-page-program (SPA) AEM Headless-distributioner.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10587
thumbnail: KT-10587.jpg
mini-toc-levels: 2
exl-id: 3fe175f7-6213-439a-a02c-af3f82b6e3b7
duration: 220
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '655'
ht-degree: 0%

---

# AEM driftsättning av SPA utan headless

AEM Headless single-page app (SPA) deployment omfattar JavaScript-baserade applikationer som byggts med ramverk som React eller Vue och som konsumerar och interagerar med AEM på ett headless sätt.

För att driftsätta en SPA som interagerar AEM utan att vara i kö måste du vara värd för SPA och göra den tillgänglig via en webbläsare.

## SPA

En SPA består av en samling med inbyggda webbresurser: **HTML, CSS och JavaScript**. De här resurserna genereras under _bygg_ process (till exempel `npm run build`) och distribueras till en värd för att konsumeras av slutanvändare.

Det finns olika **hosting** alternativ beroende på organisationens krav:

1. **Molnleverantörer** som **Azure** eller **AWS**.

2. **Lokal** värdtjänster i ett företag **datacenter**

3. **Värdplattformar på klientsidan** som **AWS Amplify**, **Azure App Service**, **Netlify**, **Heroku**, **Vercel**, osv.

## Distributionskonfigurationer

Det viktigaste att tänka på när du är värd för en SPA som interagerar med AEM utan huvud är om SPA nås via AEM domän (eller värd), eller på en annan domän.  Orsaken är SPA webbprogram som körs i webbläsare och därför omfattas av webbläsarens säkerhetsprofiler.

### Delad domän

En SPA och AEM delar domäner när båda är åtkomliga för slutanvändare från samma domän. Till exempel:

+ AEM nås via: `https://wknd.site/`
+ SPA öppnas via `https://wknd.site/spa`

Eftersom både AEM och SPA är åtkomliga från samma domän kan SPA göra XHR till AEM Headless-slutpunkter utan CORS, och tillåta delning av HTTP-cookies (till exempel AEM `login-token` cookie).

Det är upp till dig att dirigera SPA- och AEM-trafik till den delade domänen: CDN med flera ursprung, HTTP-server med omvänd proxy, som är värd för SPA direkt i AEM och så vidare.

Nedan visas distributionskonfigurationer som krävs för SPA produktionsdistributioner, när de finns på samma domän som AEM.

| SPA ansluter till | AEM | AEM Publish | AEM |
|---------------------------------------------------:|:----------:|:-----------:|:-----------:|
| [Dispatcher-filter](./configurations/dispatcher-filters.md) | ✘ | ✔ | ✔ |
| Cross-origin resource sharing (CORS) | ✘ | ✘ | ✘ |
| AEM | ✘ | ✘ | ✘ |

### Olika domäner

En SPA och AEM har olika domäner när slutanvändare från olika domäner har åtkomst till dem. Till exempel:

+ AEM nås via: `https://wknd.site/`
+ SPA öppnas via `https://wknd-app.site/`

Eftersom AEM och SPA används från olika domäner tillämpar webbläsare säkerhetsprofiler som [resursdelning mellan ursprung (CORS)](./configurations/cors.md)och förhindra delning av HTTP-cookies (till exempel AEM `login-token` cookie).

Nedan visas distributionskonfigurationer som krävs för SPA av produktionsdistributioner, när dessa lagras på en annan domän än AEM.

| SPA ansluter till | AEM | AEM Publish | AEM |
|---------------------------------------------------:|:----------:|:-----------:|:-----------:|
| [Dispatcher-filter](./configurations/dispatcher-filters.md) | ✘ | ✔ | ✔ |
| [Cross-origin resource sharing (CORS)](./configurations/cors.md) | ✔ | ✔ | ✔ |
| [AEM](./configurations/aem-hosts.md) | ✔ | ✔ | ✔ |

#### Exempel SPA distribution på olika domäner

I det här exemplet distribueras SPA till en Netlify-domän (`https://main--sparkly-marzipan-b20bf8.netlify.app/`) och SPA använder GraphQL-API:er från AEM publiceringsdomän (`https://publish-p65804-e666805.adobeaemcloud.com`). Skärmbilderna nedan visar CORS-kraven.

1. SPA hanteras från en Netlify-domän, men gör ett XHR-anrop till AEM GraphQL API:er på en annan domän. Denna begäran över flera webbplatser kräver [CORS](./configurations/cors.md) som ska konfigureras AEM att tillåta begäran från Netlify-domänen att få åtkomst till dess innehåll.

   ![SPA som betjänats av SPA och AEM ](assets/spa/cors-requirement.png)

2. Inspektera XHR-begäran till AEM GraphQL API, `Access-Control-Allow-Origin` finns, vilket anger för webbläsaren att AEM tillåter begäran från den här Netlify-domänen att få åtkomst till dess innehåll.

   Om AEM [CORS](./configurations/cors.md) saknades eller innehöll inte Netlify-domänen, webbläsaren kunde inte utföra XHR-begäran och rapportera ett CORS-fel.

   ![CORS-svarshuvud AEM GraphQL API](assets/spa/cors-response-headers.png)

## Exempel på enkelsidig app

Adobe tillhandahåller ett exempel på en enkelsidig app som kodats i React.

<div class="columns is-multiline">
<!-- React app -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="React app" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="../example-apps/react-app.md" title="Reagera-app" tabindex="-1">
                   <img class="is-bordered-r-small" src="../example-apps/assets/react-app/react-app-card.png" alt="Reagera-app">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="../example-apps/react-app.md" title="Reagera-app">Reagera-app</a></p>
               <p class="is-size-6">Ett exempel på en enda sida, skrivet i React, som använder innehåll från AEM Headless GraphQL API:er.</p>
               <a href="../example-apps/react-app.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exempel</span>
               </a>
           </div>
       </div>
   </div>
</div>
<!-- Next.js app -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Next.js app" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="../example-apps/next-js.md" title="Next.js-appen" tabindex="-1">
                   <img class="is-bordered-r-small" src="../example-apps/assets/next-js/next-js-card.png" alt="Next.js-appen">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="../example-apps/next-js.md" title="Next.js-appen">Next.js-appen</a></p>
               <p class="is-size-6">Ett exempel på en enkelsidig app, skrivet i Next.js, som använder innehåll från AEM Headless GraphQL API:er.</p>
               <a href="../example-apps/next-js.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exempel</span>
               </a>
           </div>
       </div>
   </div>
</div>
</div>
