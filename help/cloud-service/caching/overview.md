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
duration: 36
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '206'
ht-degree: 0%

---

# AEM as a Cloud Service cachning

I AEM as a Cloud Service är det viktigt att förstå cachelagring. Cachelagring innebär att tidigare hämtade data lagras och återanvänds för att förbättra systemets effektivitet och minska inläsningstiden. Den här mekanismen snabbar upp innehållsleveransen, förbättrar webbplatsens prestanda och optimerar användarupplevelsen.

AEM as a Cloud Service har flera cachelagringslager och strategier som skiljer sig åt mellan författaren och Publish-tjänsterna.

![Översikt över cachelagring i AEM as a Cloud Service](./assets/overview/all.png){align="center"}

## AEM cachning

AEM as a Cloud Service har en robust, konfigurerbar strategi för cachelagring i flera lager, inklusive ett CDN, AEM Dispatcher och eventuellt ett kundhanterat CDN. Cachelagring mellan lager kan finjusteras för att optimera prestanda och säkerställa att AEM bara levererar de bästa upplevelserna. AEM har olika problem med cachelagring för författaren och Publish tjänster. Titta närmare på cachningsstrategierna för varje tjänst nedan.


<div class="columns is-multiline" style="margin-top: 2rem">
    <div class="column is-half-tablet is-half-desktop is-half-widescreen" aria-label="AEM Publish service caching">
    <div class="card is-padded-small is-padded-big-mobile" style="height: 100%">
        <div class="card-image">
          <figure class="image is-16by9">
            <a href="./publish.md" title="AEM Publish-tjänst" tabindex="-1">
              <img class="is-bordered-r-small" src="./assets/overview/publish-card.png" alt="AEM Publish servicecache">
            </a>
          </figure>
        </div>
        <div class="card-content is-padded-small">
          <div class="content">
            <p class="headline is-size-6 has-text-weight-bold"><a href="./publish.md" title="AEM Publish servicecache">AEM Publish servicecache</a></p>
            <p class="is-size-6">AEM Publish-tjänst använder ett hanterat CDN och AEM Dispatcher för att optimera slutanvändarnas webbupplevelser.</p>
            <a href="./publish.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
              <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig</span>
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
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig</span>
                </a>
            </div>
            </div>
        </div>
    </div>
</div>
