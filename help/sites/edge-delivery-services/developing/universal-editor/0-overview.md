---
title: Edge Delivery Services och Universal Editor, självstudiekurs
description: Lär dig grunderna i hur du utvecklar en ny webbplats som har skapats i AEM Universal Editor och levereras med Edge Delivery Services.
version: Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Catalog
jira: KT-15832
duration: 89
source-git-commit: e8ce91b0be577ec6cf8f3ab07ba9ff09c7e7a6ab
workflow-type: tm+mt
source-wordcount: '453'
ht-degree: 0%

---


# Edge Delivery Services och Universal Editor, självstudiekurs

![Edge Delivery Services och Universal Editor, självstudiekurs](./assets/0-overview/hero.png)

I den här självstudiekursen får du lära dig grunderna i att skapa en AEM webbplats som kombinerar kraftfull redigering med Universal Editor och blixtsnabb leverans med hjälp av Edge Delivery Services. Slutligen får du grundläggande kunskaper om hur du skapar ett nytt projekt, konfigurerar en lokal utvecklingsmiljö och skapar ett nytt block.

## Projektinställningar

Lär dig hur du skapar ett kodprojekt och konfigurerar en ny webbplats i AEM as a Cloud Service. Med den här konfigurationen kan du utveckla material smidigt med den universella redigeraren för att skapa innehåll och snabbt leverera innehåll via Edge Delivery Services.

<!-- CARDS 

* ./1-new-code-project.md
  {}
* ./2-new-aem-site.md

-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Create a new project">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./1-new-code-project.md" title="Skapa ett nytt projekt" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/1-new-project/new-project.png" alt="Skapa ett nytt projekt"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./1-new-code-project.md" target="_blank" rel="referrer" title="Skapa ett nytt projekt">Skapa ett nytt projekt</a>
                    </p>
                    <p class="is-size-6">Skapa ett nytt projekt för Edge Delivery Services för Universal Editor</p>
                </div>
                <a href="./1-new-code-project.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Create a new site">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./2-new-aem-site.md" title="Skapa en ny plats" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/2-new-aem-site/new-site.png" alt="Skapa en ny plats"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./2-new-aem-site.md" target="_blank" rel="referrer" title="Skapa en ny plats">Skapa en ny plats</a>
                    </p>
                    <p class="is-size-6">Skapa en ny webbplats i AEM Sites for Edge Delivery Services for Universal Editor</p>
                </div>
                <a href="./2-new-aem-site.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Utvecklingsinställning

Lär dig hur du konfigurerar din lokala utvecklingsmiljö för snabb webbplatsutveckling. Med den här konfigurationen kan du skapa webbplatser smidigt med den universella redigeraren och leverera effektivt innehåll via Edge Delivery Services, vilket ger ett smidigt och optimerat utvecklingsarbetsflöde.
<!-- CARDS 

* ./3-local-development-environment.md
* ./4-website-branding.md

-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Set up a local dev environment">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./3-local-development-environment.md" title="Konfigurera en lokal utvecklingsmiljö" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/3-local-development-environment/aem-up.png" alt="Konfigurera en lokal utvecklingsmiljö"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./3-local-development-environment.md" target="_blank" rel="referrer" title="Konfigurera en lokal utvecklingsmiljö">Konfigurera en lokal utvecklingsmiljö</a>
                    </p>
                    <p class="is-size-6">Skapa ett nytt projekt för Edge Delivery Services för Universal Editor</p>
                </div>
                <a href="./3-local-development-environment.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Website branding">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./4-website-branding.md" title="Webbplatsmärkning" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/4-website-branding/github-issues.png" alt="Webbplatsmärkning"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./4-website-branding.md" target="_blank" rel="referrer" title="Webbplatsmärkning">Webbplatsmärkning</a>
                    </p>
                    <p class="is-size-6">Konfigurera global CSS, CSS-variabler och webbteckensnitt.</p>
                </div>
                <a href="./4-website-branding.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Blockutveckling

Lär dig hur du skapar ett nytt block genom att definiera dess innehållsmodell och konfigurera exempelinnehåll för testning och utveckling. Upptäck två metoder för återgivning av blocket och förstå hur du strukturerar det för optimala prestanda och flexibilitet i AEM och Edge Delivery Services.

<!-- CARDS 

* ./5-new-block.md
* ./6-author-block.md
* ./7a-block-css.md
* ./7b-block-js-css.md

-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Create a new block for Universal Editor">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./5-new-block.md" title="Skapa ett nytt block för Universal Editor" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/5-new-block/teaser-block.png" alt="Skapa ett nytt block för Universal Editor"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./5-new-block.md" target="_blank" rel="referrer" title="Skapa ett nytt block för Universal Editor">Skapa ett nytt block för Universal Editor</a>
                    </p>
                    <p class="is-size-6">Bygg ett nytt block.</p>
                </div>
                <a href="./5-new-block.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Author the block">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./6-author-block.md" title="Författare till blocket" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/6-author-block/open-new-site.png" alt="Författare till blocket"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./6-author-block.md" target="_blank" rel="referrer" title="Författare till blocket">Skapa blocket</a>
                    </p>
                    <p class="is-size-6">Skapa det nya blocket så att det kan utvecklas mot det.</p>
                </div>
                <a href="./6-author-block.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Block development with CSS">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./7a-block-css.md" title="Blockera utveckling med CSS" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/7a-block-css/inspect-block-dom.png" alt="Blockera utveckling med CSS"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./7a-block-css.md" target="_blank" rel="referrer" title="Blockera utveckling med CSS">Blockera utveckling med CSS</a>
                    </p>
                    <p class="is-size-6">Bygg blocket med enbart CSS.</p>
                </div>
                <a href="./7a-block-css.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Block development with CSS and JS">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./7b-block-js-css.md" title="Blockera utveckling med CSS och JS" target="_blank" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/7a-block-css/inspect-block-dom.png" alt="Blockera utveckling med CSS och JS"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./7b-block-js-css.md" target="_blank" rel="referrer" title="Blockera utveckling med CSS och JS">Blockera utveckling med CSS och JS</a>
                    </p>
                    <p class="is-size-6">Skapa ett block med CSS och JS.</p>
                </div>
                <a href="./7b-block-js-css.md" target="_blank" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->
