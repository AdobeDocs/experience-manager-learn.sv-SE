---
title: Arbetsflöde för teman | AEM Skapa snabbt webbplatser
description: Lär dig hur du uppdaterar temakällorna för en Adobe Experience Manager-webbplats för att använda varumärkesspecifika format. Lär dig hur du använder en proxyserver för att visa en direktförhandsvisning av CSS- och JavaScript-uppdateringar. Den här självstudiekursen handlar också om hur du distribuerar temauppdateringar till en AEM webbplats med Adobe Cloud Managers frontpipeline.
version: Cloud Service
feature: Core Components
topic: Content Management, Development
role: Developer
level: Beginner
jira: KT-7498
thumbnail: KT-7498.jpg
doc-type: Tutorial
exl-id: 98946462-1536-45f9-94e2-9bc5d41902d4
recommendations: noDisplay, noCatalog
duration: 1311
source-git-commit: af928e60410022f12207082467d3bd9b818af59d
workflow-type: tm+mt
source-wordcount: '458'
ht-degree: 0%

---

# Arbetsflöde för teman {#theming}

I det här kapitlet uppdaterar vi temakällorna för en Adobe Experience Manager-webbplats för att tillämpa varumärkesspecifika format. Vi lär oss hur du använder en proxyserver för att förhandsgranska CSS- och Javascript-uppdateringar när vi kodar mot den aktiva webbplatsen. Den här självstudiekursen handlar också om hur du distribuerar temauppdateringar till en AEM webbplats med Adobe Cloud Managers frontpipeline.

Slutligen uppdateras vår webbplats med format som matchar WKND-varumärket.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att stegen som beskrivs i [Sidmallar](./page-templates.md) kapitlet har slutförts.

## Mål

1. Lär dig hur temakällorna för en webbplats kan hämtas och ändras.
1. Lär dig hur koden mot den publicerade webbplatsen ser ut i realtid.
1. Förstå hela arbetsflödet med att leverera kompilerade CSS- och JavaScript-uppdateringar som en del av ett tema med Adobe Cloud Managers frontpipeline.

## Uppdatera ett tema {#theme-update}

Gör sedan ändringar i temakällorna så att webbplatsen matchar utseendet och känslan hos WKND-varumärket.

>[!VIDEO](https://video.tv.adobe.com/v/332918?quality=12&learn=on)

Stegen på hög nivå för videon:

1. Skapa en lokal användare i AEM som kan användas med en proxyutvecklingsserver.
1. Hämta temakällorna från AEM och öppna med en lokal utvecklingsmiljö, som VSCode.
1. Ändra temakällorna och använd en proxydev-server för att förhandsgranska CSS- och JavaScript-ändringar i realtid.
1. Uppdatera temakällorna så att tidskriftsartikeln matchar WKND-profilerade stilar och dummies.

### Lösningsfiler

Hämta de färdiga formaten för [Exempeltema för WKND](assets/theming/WKND-THEME-src-1.1.zip)

## Distribuera ett tema med hjälp av en frontpipeline {#deploy-theme}

Distribuera uppdateringar av ett tema till en AEM miljö med Cloud Managers frontpipeline.

>[!VIDEO](https://video.tv.adobe.com/v/338722?quality=12&learn=on)

Stegen på hög nivå för videon:

1. Skapa en ny Git [databas i Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/using/managing-code/cloud-manager-repositories.html)
1. Lägg till ditt temakällprojekt i Cloud Managers Git-databas:

   ```shell
   $ cd <PATH_TO_THEME_SOURCES_FOLDER>
   $ git init -b main
   $ git add .
   $ git commit -m "initial commit"
   $ git remote add origin <CLOUD_MANAGER_GIT_REPOSITORY_URL>
   ```

1. Konfigurera en [Front End Pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html) i Cloud Manager för att distribuera slutkoden.
1. Kör Front End Pipeline för att distribuera uppdateringar till AEM.

### Exempelrapporter

Det finns några exempel på GitHub-repor som kan användas som referens:

* [aem-site-template-standard](https://github.com/adobe/aem-site-template-standard)
* [aem-site-template-basic-theme-e2e](https://github.com/adobe/aem-site-template-basic-theme-e2e) - Används som exempel för&quot;verkliga&quot; projekt.

## Grattis! {#congratulations}

Grattis, du har precis uppdaterat och distribuerat ett tema till AEM!

### Nästa steg {#next-steps}

Gör en djupdykning AEM utvecklingen och förstå mer av den underliggande tekniken genom att skapa en webbplats med [AEM Project Archettype](../project-archetype/overview.md).
