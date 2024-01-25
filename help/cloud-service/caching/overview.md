---
title: AEM as a Cloud Service cachning
description: Allmän översikt över AEM as a Cloud Service cachning.
version: Cloud Service
feature: Dispatcher, Developer Tools
topic: Performance
role: Architect, Developer
level: Intermediate
doc-type: Article
last-substantial-update: 2023-08-28T00:00:00Z
jira: KT-13858
thumbnail: KT-13858.jpeg
exl-id: e76ed4c5-3220-4274-a315-a75e549f8b40
duration: 71
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '206'
ht-degree: 0%

---

# AEM as a Cloud Service cachning

På AEM as a Cloud Service är det avgörande att förstå cachelagring. Cachelagring innebär att tidigare hämtade data lagras och återanvänds för att förbättra systemets effektivitet och minska inläsningstiden. Den här mekanismen snabbar upp innehållsleveransen, förbättrar webbplatsens prestanda och optimerar användarupplevelsen.

AEM as a Cloud Service har flera cachelagringslager och strategier som skiljer sig åt mellan författar- och publiceringstjänsterna.

![Översikt över as a Cloud Service cachning AEM](./assets/overview/all.png){align="center"}

## AEM cachning

AEM as a Cloud Service har en robust, konfigurerbar strategi för cachelagring i flera lager, inklusive ett CDN, AEM Dispatcher och eventuellt ett kundhanterat CDN. Cachelagring mellan lager kan finjusteras för att optimera prestanda och säkerställa att AEM bara levererar de bästa upplevelserna. AEM har olika problem med cachelagring för författaren och publiceringstjänsten. Titta närmare på cachningsstrategierna för varje tjänst nedan.


<div class="columns is-multiline" style="margin-top: 2rem">
    <div class="column is-half-tablet is-half-desktop is-half-widescreen" aria-label="AEM Publish service caching">
    <div class="card is-padded-small is-padded-big-mobile" style="height: 100%">
        <div class="card-image">
          <figure class="image is-16by9">
            <a href="./publish.md" title="AEM Publiceringstjänst" tabindex="-1">
              <img class="is-bordered-r-small" src="./assets/overview/publish-card.png" alt="AEM Publish service caching">
            </a>
          </figure>
        </div>
        <div class="card-content is-padded-small">
          <div class="content">
            <p class="headline is-size-6 has-text-weight-bold"><a href="./publish.md" title="AEM Publish service caching">AEM Publish service caching</a></p>
            <p class="is-size-6">AEM Publish-tjänsten använder ett hanterat CDN och AEM Dispatcher för att optimera slutanvändarnas webbupplevelser.</p>
            <a href="./publish.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
              <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs</span>
            </a>
          </div>
        </div>
      </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-half-widescreen" aria-label="AEM Author service caching">
        <div class="card is-padded-small is-padded-big-mobile" style="height: 100%">
            <div class="card-image">
            <figure class="image is-16by9">
                <a href="./author.md" title="Cachelagring av AEM Author Service" tabindex="-1">
                <img class="is-bordered-r-small" src="./assets/overview/author-card.png" alt="Cachelagring av AEM Author Service">
                </a>
            </figure>
            </div>
            <div class="card-content is-padded-small">
            <div class="content">
                <p class="headline is-size-6 has-text-weight-bold"><a href="./author.md" title="Cachelagring av AEM Author Service">Cachelagring av AEM Author Service</a></p>
                <p class="is-size-6">Tjänsten AEM Author använder ett hanterat CDN för att ge optimerade redigeringsupplevelser.</p>
                <a href="./author.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs</span>
                </a>
            </div>
            </div>
        </div>
    </div>
</div>
