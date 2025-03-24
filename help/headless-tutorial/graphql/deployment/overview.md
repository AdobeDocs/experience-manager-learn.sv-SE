---
title: AEM Headless-driftsättningar
description: Läs mer om de olika distributionsaspekterna för AEM Headless-appar.
version: Experience Manager as a Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10794
thumbnail: kt-10794.jpg
last-substantial-update: 2022-08-26T00:00:00Z
exl-id: 6de58ca0-9444-4272-9487-15a9e3c89231
duration: 59
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '315'
ht-degree: 0%

---

# AEM Headless-driftsättningar

AEM Headless-klientdriftsättningar har många former: AEM-värdbaserade SPA, extern SPA, webbplats, mobilapp eller till och med server-till-server-process.

Beroende på klienten och hur den distribueras har AEM Headless-distributioner olika överväganden.

## AEM tjänstearkitektur

Innan du utforskar olika aspekter av driftsättningen är det viktigt att du förstår AEM logiska arkitektur och hur de olika tjänstenivåerna i AEM as a Cloud Service är uppdelade och har olika roller. AEM as a Cloud Service består av två logiska tjänster:

+ __AEM Author__ är den tjänst där team skapar, samarbetar och publicerar innehållsfragment (och andra resurser).
+ __AEM Publish__ är den tjänst som publicerades som innehållsfragment (och andra resurser) som replikeras för allmän användning.
+ __AEM Preview__ är den tjänst som liknar AEM Publish i beteendet, men som har innehåll publicerat till den för förhandsgranskning eller granskning. AEM Preview är avsett för interna målgrupper och inte för allmän distribution av innehåll. Det är valfritt att använda AEM Preview beroende på vilket arbetsflöde du vill använda.

![AEM tjänstarkitektur](./assets/overview/aem-service-architecture.png)

Typiskt AEM as a Cloud Service headless-driftsättningsarkitektur_

AEM Headless-klienter som arbetar i produktionskapacitet interagerar vanligtvis med AEM Publish, som innehåller det godkända publicerade materialet. Kunder som interagerar med AEM Author måste vara särskilt försiktiga, eftersom AEM Author är säkert som standard, kräver godkännande för alla förfrågningar och kan även innehålla pågående arbete eller icke godkänt innehåll.

## Huvudlösa klientdistributioner

<div class="columns is-multiline">
    <!-- Single-page App (SPA) -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Single-page App (SPA)" tabindex="0">
       <div class="card">
           <div class="card-image">
               <figure class="image is-16by9">
                   <a href="./spa.md" title="Single-page App (SPA)" tabindex="-1">
                       <img class="is-bordered-r-small" src="./assets/spa/spa-card.png" alt="Single-page apps (SPA)">
                   </a>
               </figure>
           </div>
           <div class="card-content is-padded-small">
               <div class="content">
                   <p class="headline is-size-6 has-text-weight-bold"><a href="./spa.md" title="Single-page App (SPA)">Single-page app (SPA)</a></p>
                   <p class="is-size-6">Läs mer om distributionsaspekter för fristående program (SPA).</p>
                   <a href="./spa.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                       <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig</span>
                   </a>
               </div>
           </div>
       </div>
    </div>
<!-- Web component/JS -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Web component/JS" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="./web-component.md" title="Webbkomponent/JS" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/web-component/web-component-card.png" alt="Webbkomponent/JS">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="./web-component.md" title="Webbkomponent/JS">Webbkomponent/JS</a></p>
               <p class="is-size-6">Läs om driftsättningsaspekter för webbkomponenter och webbläsarbaserade hemlösa JavaScript-kunder.</p>
               <a href="./web-component.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig</span>
               </a>
           </div>
       </div>
   </div>
</div>
<!-- Mobile apps -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Mobile apps" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="./mobile.md" title="Mobilappar" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/mobile/mobile-card.png" alt="Mobilappar">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="./mobile.md" title="Mobilappar">Mobilapp</a></p>
               <p class="is-size-6">Läs mer om distributionsaspekter för mobilappar.</p>
               <a href="./mobile.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig</span>
               </a>
           </div>
       </div>
   </div>
</div>
<!-- Server-to-server apps -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Server-to-server apps" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="./server-to-server.md" title="Server-till-server-appar" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/server-to-server/server-to-server-card.png" alt="Server-till-server-appar">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="./server-to-server.md" title="Server-till-server-appar">Server-till-server-app</a></p>
               <p class="is-size-6">Läs mer om distributionsaspekter för server-till-server-appar</p>
               <a href="./server-to-server.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig</span>
               </a>
           </div>
       </div>
   </div>
</div>
</div>
