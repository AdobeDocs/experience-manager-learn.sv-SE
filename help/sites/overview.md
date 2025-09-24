---
title: Videor och självstudiekurser om AEM Sites
description: Bläddra bland videor och självstudiekurser om Adobe Experience Manager Sites funktioner. AEM Sites är en ledande plattform för upplevelsehantering.
solution: Experience Manager, Experience Manager Sites
sub-product: Experience Manager Sites
topic: Content Management
doc-type: Catalog
exl-id: cde4ce7f-0afe-4632-8c1c-354586f296d5
source-git-commit: 999bbe542e5c71ae537f93a4c89acf6d304a4292
workflow-type: tm+mt
source-wordcount: '786'
ht-degree: 1%

---

# AEM Sites videor och självstudiekurser {#overview}

{{edge-delivery-services}}

Adobe Experience Manager (AEM) Sites är en Adobe plattform för upplevelsehantering, som gör det möjligt att skapa, hantera och leverera digitala upplevelser, oavsett om det sker via en webbplats, mobilapp eller någon annan digital kanal.

## Tre sätt att leverera upplevelser med AEM Sites

AEM Sites erbjuder tre sätt att bygga, skapa och leverera upplevelser. Oavsett om du skapar webbplatser, optimerar för bästa prestanda eller använder headless-appar erbjuder AEM Sites flexibla alternativ som passar dina projektbehov:

1. **Edge Delivery Services**-upplevelser använder Adobe Edge Network för att leverera innehåll med hög hastighet och låg latens. Tjänsten optimerar automatiskt innehållet för den förbrukande enheten, sökmotorer och GenAI-agenter. Man skapar material med Adobe Universal Editor eller dokumentbaserad redigering.
1. **Headless/API-first** -upplevelser använder AEM Publish för att leverera innehåll som JSON över HTTP-API:er för mobilappar, SPA:er (single page applications) eller andra headless-klienter. Författare skapar innehåll med Content Fragment Editor eller Universal Editor.
1. **Traditionella AEM**-upplevelser använder AEM Publish för att leverera innehåll som HTML webbsidor. Författare skapar innehåll med AEM Authors sidredigerare. Det här alternativet passar bäst för befintliga projekt eller projekt som redan har migrerats.

Alla tre alternativen är kraftfulla strategier, och det bästa valet beror på ditt användningssätt och organisationens behov. Med varje strategi kan team leverera personaliserade, engagerande upplevelser i hastighet och i stor skala över alla kanaler och enheter.

>[!IMPORTANT]
>
> **Edge Delivery Services** är det senaste och mest avancerade sättet att leverera webbplatser med AEM. Här kombineras snabbheten och skalbarheten i Adobe Edge Network med moderna redigeringsfunktioner. Edge Delivery Services rekommenderas för nya projekt, men AEM Sites har fortfarande stöd för headless och traditionella metoder så att du kan välja den väg som passar dina behov bäst.

I följande diagram visas de olika alternativen för att skapa upplevelser med AEM Sites:

![AEM-Sites-Content-Authoring-and-Experience-Delivery-Paths.png](./assets/aem-sites-authoring-and-experience-delivery-paths.png){width="700" zoomable="yes"}

### Jämför olika sätt att bygga med AEM Sites

I följande tabell visas en jämförelse på hög nivå av de tre banorna. Det fokuserar på de olika banornas innehållsutveckling och upplevelseleverans.

|            | Edge Delivery Services | Headless / API-First | Traditionell AEM |
|---------------------|------------------------------|---------------------------------|---------------------------------------------|
| **Bäst för** | Webbplatser med hög trafik, höga prestanda och skalbarhet | Mobilappar, SPA och andra headless-applikationer | Befintliga projekt eller migrerade projekt |
| **Redigeringsverktyg** | Dokumentbaserad redigering, Universal Editor, Page Editor | Content Fragments, Universal Editor | Page Editor, Universal Editor |
| **Skapat innehållsarkiv** | Dokument eller AEM Author (JCR) | AEM Author (JCR) | AEM Author (JCR) |
| **Leverans** | Edge Delivery Services | AEM Publish (w/ Adobe CDN + Dispatcher) | AEM Publish (w/ Adobe CDN + Dispatcher) |
| **Leveransinnehåll, butik** | Edge Delivery Services | AEM Publish (JCR) | AEM Publish (JCR) |
| **Leveransformat** | HTML | JSON | HTML |
| **Utvecklingsteknik** | JavaScript, CSS | Valfritt (t.ex. virvel, reaktion) | Java™, HTL, JavaScript, CSS |
| **Stöd för sökrut och GenAI-agent** | Optimerad för bots, sökmotorer och GenAI-agenter | Fungerar för robotar och agenter, men kan kräva SSR eller ytterligare konfiguration | Passar för botar, men prestanda kan vara långsammare jämfört med Edge Delivery Services |

## Migrera från AMS eller On-Premise

Om du migrerar från AMS eller OTP till AEM as a Cloud Service rekommenderar Adobe att du utvärderar möjligheten att gå direkt till Edge Delivery Services. Arbetet är vanligtvis inte större än att migrera till AEM as a Cloud Service Publish, samtidigt som det ger bättre prestanda och skalbarhet. Om du bestämmer dig för att Edge Delivery Services inte är rätt val för dig just nu, eller om de andra strategierna bättre motsvarar dina behov, fortsätter de att ha full support och giltiga alternativ för ditt projekt.

## Självstudiekurser

Utforska de tre sätten att bygga med AEM Sites i detalj. Självstudiekurserna nedan visar hur de olika alternativen fungerar, vilka verktyg som används och när de ska användas.

<!-- CARDS

* https://www.aem.live/docs/
  {title = Edge Delivery Services - Guides}
  {description = Explore Edge Delivery Services with comprehensive guides. The Build, Publish, and Launch guides cover everything you need to get started with Edge Delivery Services.}
  {image = ./assets/edge-delivery-services.png}
  {target = _blank}
* https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/overview
  {title = Headless/API-First - Tutorials}
  {description = Learn how to build headless applications powered by AEM content. Tutorials cover frameworks like iOS, Android, and React—choose what fits your stack.}
  {image = ./assets/headless.png}
  {target = _self}
* https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview
  {title = Traditional AEM - WKND Tutorial}
  {description = Learn how to build a sample AEM Sites project using the WKND tutorial. This guide walks you through project setup, Core Components, Editable Templates, client-side libraries, and component development.}
  {image = ./assets/aem-wknd-spa-editor-tutorial.png}
  {target = _self}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Edge Delivery Services - Guides">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://www.aem.live/docs/" title="Edge Delivery Services - stödlinjer" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/edge-delivery-services.png" alt="Edge Delivery Services - stödlinjer"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://www.aem.live/docs/" target="_blank" rel="referrer" title="Edge Delivery Services - stödlinjer">Edge Delivery Services - stödlinjer</a>
                    </p>
                    <p class="is-size-6">Utforska Edge Delivery Services med omfattande guider. Handböckerna Build, Publish och Launch täcker allt du behöver för att komma igång med Edge Delivery Services.</p>
                </div>
                <a href="https://www.aem.live/docs/" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Headless/API-First - Tutorials">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/overview" title="Headless/API-First - Tutorials" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/headless.png" alt="Headless/API-First - Tutorials"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/overview" target="_self" rel="referrer" title="Headless/API-First - Tutorials">Headless/API-First - Tutorials</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skapar headless-applikationer som bygger på AEM-material. Självstudiekurserna omfattar ramverk som iOS, Android och React - välj vad som passar er bäst.</p>
                </div>
                <a href="https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-with-aem-headless/overview" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Traditional AEM - WKND Tutorial">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview" title="Traditionell AEM - WKND självstudiekurs" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/aem-wknd-spa-editor-tutorial.png" alt="Traditionell AEM - WKND självstudiekurs"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview" target="_self" rel="referrer" title="Traditionell AEM - WKND självstudiekurs">Traditionell AEM - WKND-självstudiekurs</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du bygger ett AEM Sites-projekt med WKND-självstudiekursen. I den här guiden får du hjälp med projektinställningar, kärnkomponenter, redigerbara mallar, klientbibliotek och komponentutveckling.</p>
                </div>
                <a href="https://experienceleague.adobe.com/sv/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->


## Ytterligare resurser

* [AEM Sites redigeringsdokumentation](https://experienceleague.adobe.com/sv/docs/experience-manager-65/content/sites/authoring/essentials/first-steps)
* [AEM Sites Developing documentation](https://experienceleague.adobe.com/sv/docs/experience-manager-65/content/implementing/developing/introduction/getting-started)
* [AEM Sites Administering-dokumentation](https://experienceleague.adobe.com/sv/docs/experience-manager-65/content/sites/administering/home)
* [AEM Sites distributionsdokumentation](https://experienceleague.adobe.com/sv/docs/experience-manager-65/content/implementing/deploying/introduction/platform)
* [AEM as a Cloud Service självstudiekurser](/help/cloud-service/overview.md)
* [AEM Assets självstudiekurser](/help/assets/overview.md)
* [AEM Forms självstudiekurser](/help/forms/overview.md)
* [AEM Foundation - självstudiekurser](/help/foundation/overview.md)
