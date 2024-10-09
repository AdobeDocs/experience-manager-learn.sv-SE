---
title: AEM Headless-driftsättningar
description: Läs mer om driftsättningsaspekter för mobila AEM Headless-driftsättningar.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10796
thumbnail: KT-10796.jpg
exl-id: 1f536079-b3ce-4807-be88-804378e75d37
duration: 31
source-git-commit: 23ea95cfdf7e4c9fde4b53e9f68079b4d267ca20
workflow-type: tm+mt
source-wordcount: '161'
ht-degree: 0%

---

# AEM Headless-driftsättningar

AEM Headless-driftsättningar är inbyggda mobilappar för iOS, Android™ osv. som konsumerar och interagerar med innehåll i AEM på ett headless sätt.

Mobila distributioner kräver minimal konfiguration eftersom HTTP-anslutningar till AEM Headless API:er inte initieras i webbläsarkontexten.

## Distributionskonfigurationer

Följande distributionskonfiguration måste finnas på plats för mobilappsdistributioner.

| Mobilappen är ansluten till → | AEM | AEM Publish | AEM |
|---------------------------------------------------:|:----------:|:-----------:|:-----------:|
| [Dispatcher-filter](./configurations/dispatcher-filters.md) | ✘ | ✔ | ✔ |
| Cross-origin resource sharing (CORS) | ✘ | ✘ | ✘ |
| [AEM värdar](./configurations/aem-hosts.md) | ✔ | ✔ | ✔ |

## Exempel på mobilappar

Adobe tillhandahåller exempel på iOS- och Android™-mobilappar.

<div class="columns is-multiline">
    <!-- iOS app -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="iOS app" tabindex="0">
       <div class="card">
           <div class="card-image">
               <figure class="image is-16by9">
                   <a href="../example-apps/ios-swiftui-app.md" title="iOS" tabindex="-1">
                       <img class="is-bordered-r-small" src="../example-apps/assets/ios-swiftui-app/ios-app-card.png" alt="iOS">
                   </a>
               </figure>
           </div>
           <div class="card-content is-padded-small">
               <div class="content">
                   <p class="headline is-size-6 has-text-weight-bold"><a href="../example-apps/ios-swiftui-app.md" title="iOS">iOS</a></p>
                   <p class="is-size-6">Ett exempel på en iOS-app, skriven i SwiftUI, som konsumerar innehåll från AEM Headless GraphQL API:er.</p>
                   <a href="../example-apps/ios-swiftui-app.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                       <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Visa exempel </span>
                   </a>
               </div>
           </div>
       </div>
    </div>
    <!-- Android app -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Android app" tabindex="0">
       <div class="card">
           <div class="card-image">
               <figure class="image is-16by9">
                   <a href="../example-apps/android-app.md" title="Android™" tabindex="-1">
                       <img class="is-bordered-r-small" src="../example-apps/assets/android-java-app/android-app-card.png" alt="Android">
                   </a>
               </figure>
           </div>
           <div class="card-content is-padded-small">
               <div class="content">
                   <p class="headline is-size-6 has-text-weight-bold"><a href="../example-apps/android-app.md" title="Android™">Android™</a></p>
                   <p class="is-size-6">Ett exempel på en Java™ Android™-app som använder innehåll från AEM Headless GraphQL API:er.</p>
                   <a href="../example-apps/android-app.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                       <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Visa exempel </span>
                   </a>
               </div>
           </div>
       </div>
    </div>
</div>
