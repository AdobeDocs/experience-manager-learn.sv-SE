---
title: Aktivera frontpipeline för standardprojekttypen AEM
description: Konvertera ett standardprojekt AEM snabbare driftsättning av statiska resurser som CSS, JavaScript, Fonts och Icons med hjälp av Front-End-pipeline. Och separering av Front-End-utveckling från backend-utveckling i full-stack på AEM.
sub-product: sites
version: Cloud Service
type: Tutorial
feature: AEM Project Archetype, Cloud Manager, CI-CD Pipeline
topic: Content Management, Development, Development, Architecture
role: Developer, Architect, Admin
level: Intermediate
mini-toc-levels: 1
index: y
recommendations: disable
source-git-commit: 96e1c95b7cd672aa5d4f79707735abc86dae7b8a
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---


# Aktivera frontpipeline för standardprojekttypen AEM{#enable-front-end-pipeline-standard-aem-project}

Lär dig hur du aktiverar AEM som skapats med [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) för att driftsätta statiska resurser som CSS, JavaScript, Fonts och Icons med hjälp av Front-End-pipeline för snabbare utveckling-till-driftsättningscykel. Och separering av Front-End-utveckling från backend-utveckling i full-stack på AEM. Du får också lära dig hur dessa statiska resurser __not__ från AEM men från CDN, en förändring i leveranssätt.

En ny frontendpipeline skapas i Adobe Cloud Manager som endast bygger och distribuerar `ui.frontend` artefakter till CDN och informerar AEM om dess plats. Under webbsidans HTML-generering `<link>` och `<script>` -taggar refererar till den här platsen i `href` attributvärde.

Efter standardkonverteringen av AEM kan utvecklarna arbeta separat från och parallellt med all backend-utveckling i AEM, som har egna driftsättningspipelines.

>[!VIDEO](https://video.tv.adobe.com/v/3409268)

>[!NOTE]
>
>Detta gäller endast AEM as a Cloud Service och inte för AMS-baserade Adobe Cloud Manager-distributioner.

