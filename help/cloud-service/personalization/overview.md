---
title: Personalization - översikt
description: Lär dig hur du anpassar AEM as a Cloud Service webbplatser med Adobe Target- och Adobe Experience Platform-program.
version: Experience Manager as a Cloud Service
feature: Personalization, Integrations
topic: Personalization, Integrations, Architecture
role: Developer, Architect, Leader, Data Architect, User
level: Beginner
doc-type: Tutorial
last-substantial-update: 2025-08-07T00:00:00Z
jira: KT-18717
thumbnail: null
exl-id: c4fb11b9-b613-4522-b9da-18d7ae0826ec
source-git-commit: 4d345ba7b10ea21d7bc7eee89157de782e1c4350
workflow-type: tm+mt
source-wordcount: '492'
ht-degree: 0%

---

# Personalization - översikt

Läs om hur AEM as a Cloud Service (AEMCS) integreras med Adobe Target och Adobe Experience Platform (AEP) för att leverera personaliserade upplevelser. Använd Experience Fragments som personaliserat innehåll, upptäck hur man kör A/B-tester, målgruppsanpassar användare baserat på beteende i realtid eller personaliserar innehåll med hjälp av enhetliga kundprofiler som bygger på data mellan olika system.

## Förutsättningar

I den här självstudien används [AEM WKND](https://github.com/adobe/aem-guides-wknd/) -exempelprojektet för att demonstrera olika personaliseringsscenarier. För att följa med i utvecklingen behöver du:

- En Adobe-organisation med tillgång till:
   - **AEM as a Cloud Service-miljö** - för att skapa och hantera innehåll
   - **Adobe Target** - skapa och leverera personaliserade upplevelser
   - **Adobe Experience Platform-program** - för att hantera kundprofiler och målgrupper
   - **Taggar (tidigare Launch) i AEP** - för att distribuera Web SDK och anpassade JavaScript för datainsamling och personalisering

- En grundläggande förståelse för AEM komponenter och Experience Fragments

- [AEM WKND](https://github.com/adobe/aem-guides-wknd/)-projektet som distribueras till din AEM as a Cloud Service-miljö.

## Live Demo av användningsexempel från Personalization

Upplev personalisering i praktiken på webbplatsen [WKND Enablement](https://wknd.enablementadobe.com/us/en.html){target="wknd"}. Demonstrationssajten visar tre typer av personalisering: A/B-testning, beteendeanpassning och känd användarpersonalisering.

>[!TIP]
>
> Genom att titta på live-demonstrationen först får ni en förståelse för värdet och funktionerna i varje personaliseringsteknik innan ni lägger tid på konfiguration och implementering.

<!-- CARDS
{target = _self}

* ./live-demo.md
  {title = Live Demo of Personalization Use Cases}
  {description = Experience personalization in action on the [WKND Enablement website](https://wknd.enablementadobe.com/us/en.html). The demo site demonstrates three types of personalization: A/B testing, behavioral targeting, and known-user personalization.}
  {image = ./assets/live-demo/live-demo.png}
  {cta = Live Demo}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Live Demo of Personalization Use Cases">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./live-demo.md" title="Live Demo av användningsexempel från Personalization" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/live-demo/live-demo.png" alt="Live Demo av användningsexempel från Personalization"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./live-demo.md" target="_self" rel="referrer" title="Live Demo av användningsexempel från Personalization">Live Demo av Personalization-användningsexempel</a>
                    </p>
                    <p class="is-size-6">Upplev personalisering i praktiken på WKND Enablement-webbplatsen. Demonstrationssajten visar tre typer av personalisering: A/B-testning, beteendeanpassning och känd användarpersonalisering.</p>
                </div>
                <a href="./live-demo.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Live Demo </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Kom igång

Innan du utforskar specifika användningsfall måste du först konfigurera AEM as a Cloud Service för personalisering. Börja med att integrera Adobe Target och taggar för att möjliggöra personalisering på klientsidan med Web SDK. Med dessa grundläggande steg kan era AEM-sidor experimentera, målinrikta och personalisera i realtid.

<!-- CARDS
{target = _self}

* ./setup/integrate-adobe-target.md
  {title = Integrate Adobe Target}
  {description = Integrate AEMCS with Adobe Target to activate personalized content, such as Experience Fragments, as offers.}
  {image = ./assets/setup/integrate-target.png}
  {cta = Integrate Target}

* ./setup/integrate-adobe-tags.md
  {title = Integrate Tags}
  {description = Integrate AEMCS with Tags to inject the Web SDK and custom JavaScript for data collection and personalization.}
  {image = ./assets/setup/integrate-tags.png}
  {cta = Integrate Tags}
  
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Integrate Adobe Target">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./setup/integrate-adobe-target.md" title="Integrera Adobe Target" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/setup/integrate-target.png" alt="Integrera Adobe Target"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./setup/integrate-adobe-target.md" target="_self" rel="referrer" title="Integrera Adobe Target">Integrera Adobe Target</a>
                    </p>
                    <p class="is-size-6">Integrera AEMCS med Adobe Target för att aktivera personaliserat innehåll, som Experience Fragments, som erbjudanden.</p>
                </div>
                <a href="./setup/integrate-adobe-target.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Integrera mål </span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Integrate Tags">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./setup/integrate-adobe-tags.md" title="Integrera taggar" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/setup/integrate-tags.png" alt="Integrera taggar"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./setup/integrate-adobe-tags.md" target="_self" rel="referrer" title="Integrera taggar">Integrera taggar</a>
                    </p>
                    <p class="is-size-6">Integrera AEMCS med taggar för att lägga in Web SDK och JavaScript för datainsamling och personalisering.</p>
                </div>
                <a href="./setup/integrate-adobe-tags.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Integrera taggar </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->



## Användningsexempel

Utforska följande vanliga användningsexempel för personalisering som stöds av AEMCS, Adobe Target och Adobe Experience Platform.

<!-- CARDS
{target = _self}

* ./use-cases/experimentation.md
    {title = Experimentation (A/B Testing)}
    {description = Learn how to test different content variations on an AEMCS website using Adobe Target for A/B testing.}
    {image = ./assets/use-cases/experiment/experimentation.png}
    {cta = Learn Experimentation}

* ./use-cases/behavioral-targeting.md
    {title = Behavioral Targeting}
    {description = Learn how to personalize content based on user behavior using Adobe Experience Platform and Adobe Target.}
    {image = ./assets/use-cases/behavioral-targeting/behavioral-targeting.png}
    {cta = Learn Behavioral Targeting}

* ./use-cases/known-user-personalization.md
    {title = Known-user personalization}
    {description = Learn how to personalize content based on known user data by stitching information from multiple systems into a complete customer profile.}
    {image = ./assets/use-cases/known-user-personalization/known-user-personalization.png}
    {cta = Learn Known-user personalization}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Experimentation (A/B Testing)">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/experimentation.md" title="Experimentation (A/B-testning)" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/use-cases/experiment/experimentation.png" alt="Experimentation (A/B-testning)"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/experimentation.md" target="_self" rel="referrer" title="Experimentation (A/B-testning)">Experimentation (A/B-testning)</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du testar olika innehållsvariationer på en AEMCS-webbplats med Adobe Target för A/B-testning.</p>
                </div>
                <a href="./use-cases/experimentation.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Lär dig experimentera </span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Behavioral Targeting">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/behavioral-targeting.md" title="Beteendeanpassning" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/use-cases/behavioral-targeting/behavioral-targeting.png" alt="Beteendeanpassning"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/behavioral-targeting.md" target="_self" rel="referrer" title="Beteendeanpassning">Beteendeanpassning</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du anpassar innehåll baserat på användarbeteende med Adobe Experience Platform och Adobe Target.</p>
                </div>
                <a href="./use-cases/behavioral-targeting.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Lär dig beteendeanpassning </span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Known-user personalization">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/known-user-personalization.md" title="Känd personalisering för användare" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/use-cases/known-user-personalization/known-user-personalization.png" alt="Känd personalisering för användare"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/known-user-personalization.md" target="_self" rel="referrer" title="Känd personalisering för användare">Känd användaranpassning</a>
                    </p>
                    <p class="is-size-6">Lär dig att personalisera innehåll baserat på kända användardata genom att sammanfoga information från flera system till en komplett kundprofil.</p>
                </div>
                <a href="./use-cases/known-user-personalization.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig mer om användaranpassning</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->
