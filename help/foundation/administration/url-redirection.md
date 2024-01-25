---
title: URL-omdirigeringar
description: Läs mer om de olika alternativen för att utföra URL-omdirigering i AEM.
version: 6.4, 6.5, Cloud Service
topic: Development, Administration
feature: Operations, Dispatcher
role: Developer, Architect
level: Intermediate
jira: KT-11466
last-substantial-update: 2022-10-14T00:00:00Z
index: y
doc-type: Article
exl-id: 8e64f251-e5fd-4add-880e-9d54f8e501a6
duration: 192
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '781'
ht-degree: 0%

---

# URL-omdirigeringar

URL-omdirigering är en vanlig aspekt vid webbplatsåtgärder. Arkitekter och administratörer uppmanas att hitta den bästa lösningen för hur och var de ska hantera URL-omdirigeringar som ger flexibilitet och snabb omdirigeringstid.

Se till att du känner till [AEM (6.x) även AEM Classic](https://experienceleague.adobe.com/docs/experience-manager-learn/dispatcher-tutorial/chapter-2.html#the-%E2%80%9Clegacy%E2%80%9D-setup) och [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/overview/architecture.html#runtime-architecture) infrastruktur. De viktigaste skillnaderna är:

1. AEM as a Cloud Service har [inbyggd CDN](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn.html)Men man kan också tillhandahålla ett CDN (BYOCDN) framför AEM CDN.
1. AEM 6.x vare sig på plats eller i Adobe Managed Services (AMS) inte innehåller ett AEM-hanterat CDN, och kunderna måste ta med sig sina egna.

De andra AEM (AEM Författare/Publicera och Dispatcher) är i övrigt lika konceptuellt mellan AEM 6.x och AEM as a Cloud Service.

AEM URL-omdirigeringslösningar:

|                                                   | Hanteras och distribueras som AEM projektkod | Möjlighet att ändra per marknadsförings-/innehållsteam | AEM som Cloud Service-kompatibel | Var körning av omdirigering sker |
|---------------------------------------------------|:-----------------------:|:---------------------:|:---------------------:| :---------------------:|
| [I Edge via din egen CDN](#at-edge-via-bring-your-own-cdn) | ✘ | ✘ | ✔ | Edge/CDN |
| [Apache `mod_rewrite` regler som Dispatcher-konfiguration](#apache-mod_rewrite-module) | ✔ | ✘ | ✔ | Dispatcher |
| [ACS-kommandon - Omdirigeringshanteraren](#redirect-map-manager) | ✘ | ✔ | ✘ | Dispatcher |
| [ACS-kommandon - omdirigeringshanteraren](#redirect-manager) | ✘ | ✔ | ✔ | AEM |
| [The `Redirect` page, egenskap](#the-redirect-page-property) | ✘ | ✔ | ✔ | AEM |


## Lösningsalternativ

Här följer några alternativ för att komma närmare besökarens webbläsare.

### I Edge via din egen CDN

Vissa CDN-tjänster erbjuder lösningar för omdirigering på edge-nivå och reducerar därmed antalet rundresor till ursprungsläget. Se [Akamai Edge Redirector](https://techdocs.akamai.com/cloudlets/docs/what-edge-redirector), [Funktioner i AWS CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cloudfront-functions.html). Kontakta din CDN-tjänsteleverantör för att få hjälp med omdirigering på edge-nivå.

Hantering av omdirigeringar på edge- eller CDN-nivå har prestandafördelar, men de hanteras inte som en del av AEM utan snarare som separata projekt. En genomtänkt process för att hantera och införa omdirigeringsregler är avgörande för att undvika problem.


### Apache `mod_rewrite` modul

En vanlig lösning använder [Apache Module mod_rewrite](https://httpd.apache.org/docs/current/mod/mod_rewrite.html). The [AEM Project Archettype](https://github.com/adobe/aem-project-archetype) innehåller en Dispatcher-projektstruktur för båda [AEM 6.x](https://github.com/adobe/aem-project-archetype/tree/develop/src/main/archetype/dispatcher.ams#file-structure) och [AEM as a Cloud Service](https://github.com/adobe/aem-project-archetype/tree/develop/src/main/archetype/dispatcher.cloud#file-structure) projekt. Standardreglerna (ej ändringsbara) och anpassade omskrivningsregler definieras i `conf.d/rewrites` och omskrivningsmotorn är PÅ `virtualhosts` som lyssnar på port `80` via `conf.d/dispatcher_vhost.conf` -fil. Ett exempel på implementering finns i [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd/tree/main/dispatcher/src/conf.d/rewrites).

På AEM as a Cloud Service hanteras dessa omdirigeringsregler som en del AEM kod och distribueras via Cloud Manager [Konfigurationsflöde för webbnivå](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html#web-tier-config-pipelines) eller [Pipeline i full hög](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html#full-stack-pipeline). Det innebär att den projektspecifika AEM processen är på gång för att hantera, distribuera och spåra omdirigeringsreglerna.

De flesta CDN-tjänster cachelagrar HTTP 301- och 302-omdirigeringarna beroende på deras `Cache-Control` eller `Expires` sidhuvuden. Detta bidrar till att undvika den rundade resan efter den initiala omdirigeringen från Apache/Dispatcher.


### ACS AEM Commons

Det finns två funktioner i [ACS AEM Commons](https://adobe-consulting-services.github.io/acs-aem-commons/) för att hantera URL-omdirigeringar. Observera att ACS AEM Commons är ett öppen källkodsprojekt som drivs av communityn och inte stöds av Adobe.

#### Omdirigeringshanteraren

[Omdirigeringshanteraren](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-map-manager/index.html) gör att AEM 6.x-administratörer enkelt kan underhålla och publicera [Apache RewriteMap](https://httpd.apache.org/docs/2.4/rewrite/rewritemap.html) filer utan direkt åtkomst till Apache-webbservern eller som kräver att en Apache-webbserver startas om. Med den här funktionen kan behörighetsanvändare skapa, uppdatera och ta bort omdirigeringsregler från en konsol i AEM, utan hjälp av utvecklingsteamet eller en AEM distribution. Omdirigeringshanteraren är **NOT AEM as a Cloud Service-kompatibel**.

#### Omdirigeringshanteraren

[Omdirigeringshanteraren](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-manager/index.html) gör att användare i AEM enkelt kan underhålla och publicera omdirigeringar från AEM. Implementeringen baseras på Java™-serverfiltret, vilket är en vanlig JVM-resursförbrukning. Den här funktionen eliminerar också beroendet av AEM utvecklingsteam och AEM driftsättningar. Omdirigeringshanteraren är båda **AEM as a Cloud Service** och **AEM 6.x** kompatibel. Medan den initialt omdirigerade begäran måste trycka på AEM Publish-tjänsten för att generera cacheminnet 301/302 (de flesta) för CDN 301/302 som standard, så att efterföljande begäranden kan omdirigeras till edge/CDN.

### The `Redirect` page, egenskap

OTB (inte helt installerat) `Redirect` page property from the [Fliken Avancerat](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/fundamentals/page-properties.html#advanced) gör att innehållsförfattare kan definiera omdirigeringsplatsen för den aktuella sidan. Den här lösningen är bäst för omdirigeringsscenarier per sida och har ingen central plats för att visa och hantera sidomdirigeringar.

## Vilken lösning passar bäst för implementering

Nedan finns några kriterier som avgör vilken lösning som är rätt. Organisationens IT- och marknadsföringsprocess bör också hjälpa er att välja rätt lösning.

1. Gör det möjligt för marknadsföringsteamet eller superanvändare att hantera omdirigeringsregler utan AEM utvecklingsteam och AEM driftsättningar.
1. Processen för att hantera, verifiera, spåra och återställa ändringar eller riskreducering.
1. Tillgänglighet för _Ämnesexpertis_ for **At Edge via CDN Service** lösning.
