---
title: AEM driftsättningar av webbkomponenter utan headless
description: Ta reda på vad som gäller vid driftsättning av webbkomponenter/helt JS-baserade AEM Headless-distributioner.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10797
thumbnail: kt-10797.jpg
exl-id: 9d4aab4c-82af-4917-8c1b-3935f19691e6
duration: 54
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '164'
ht-degree: 0%

---

# AEM driftsättningar av webbkomponenter utan headless

AEM Headless [Webbkomponent](https://developer.mozilla.org/en-US/docs/Web/Web_Components)/JS-distributioner är rena JavaScript-program som körs i en webbläsare och som använder och interagerar med innehåll i AEM på ett headless sätt. Webbkomponent-/JS-distributioner skiljer sig från [SPA](./spa.md) på så sätt att de inte använder ett robust SPA ramverk och förväntas vara inbäddade i sammanhanget för någon webbplats, leverera till innehåll från AEM.


## Distributionskonfigurationer

Följande distributionskonfiguration måste finnas på plats för Web Component/JS-distributioner.

| Webbkomponent/JS-program ansluter till | AEM | AEM Publish | AEM |
|---------------------------------------------------:|:----------:|:-----------:|:-----------:|
| [Dispatcher-filter](./configurations/dispatcher-filters.md) | ✘ | ✔ | ✔ |
| [Cross-origin resource sharing (CORS)](./configurations/cors.md) | ✔ | ✔ | ✔ |
| [AEM](./configurations/aem-hosts.md) | ✔ | ✔ | ✔ |

## Exempel på webbkomponent

Adobe tillhandahåller en exempelwebbkomponent.

<div class="columns is-multiline">
    <!-- Web Component -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Web Component" tabindex="0">
       <div class="card">
           <div class="card-image">
               <figure class="image is-16by9">
                   <a href="../example-apps/web-component.md" title="Webbkomponent" tabindex="-1">
                       <img class="is-bordered-r-small" src="../example-apps/assets/web-component/web-component-card.png" alt="Webbkomponent">
                   </a>
               </figure>
           </div>
           <div class="card-content is-padded-small">
               <div class="content">
                   <p class="headline is-size-6 has-text-weight-bold"><a href="../example-apps/web-component.md" title="Webbkomponent">Webbkomponent</a></p>
                   <p class="is-size-6">Ett exempel på en webbkomponent som är skriven i rent JavaScript och som använder innehåll från AEM Headless GraphQL API:er.</p>
                   <a href="../example-apps/web-component.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                       <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exempel</span>
                   </a>
               </div>
           </div>
       </div>
    </div>
</div>
