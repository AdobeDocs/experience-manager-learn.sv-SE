---
title: URL-omdirigeringar
description: Lär dig mer om de olika alternativen för att utföra URL-omdirigering i AEM.
version: Experience Manager 6.4, Experience Manager 6.5, Experience Manager as a Cloud Service
topic: Development, Administration
feature: Operations, Dispatcher
role: Developer, Architect
level: Intermediate
jira: KT-11466
last-substantial-update: 2024-10-22T00:00:00Z
index: y
doc-type: Article
exl-id: 8e64f251-e5fd-4add-880e-9d54f8e501a6
duration: 164
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '961'
ht-degree: 0%

---

# URL-omdirigeringar

URL-omdirigering är en vanlig aspekt vid webbplatsåtgärder. Arkitekter och administratörer uppmanas att hitta den bästa lösningen för hur och var de ska hantera URL-omdirigeringar som ger flexibilitet och snabb omdirigeringstid.

Kontrollera att du känner till [AEM (6.x) alias AEM Classic](https://experienceleague.adobe.com/en/docs/experience-manager-learn/dispatcher-tutorial/chapter-2) och [AEM as a Cloud Service](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/overview/architecture) . De viktigaste skillnaderna är:

1. AEM as a Cloud Service har [inbyggt CDN](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn), men kunder kan tillhandahålla ett CDN (BYOCDN) framför AEM-hanterat CDN.
1. AEM 6.x, vare sig det är lokalt eller Adobe Managed Services (AMS), innehåller inte ett CDN som hanteras av AEM, och kunderna måste ta med sig sina egna.

De andra AEM-tjänsterna (AEM Author/Publish och Dispatcher) liknar på andra sätt konceptuellt AEM 6.x och AEM as a Cloud Service.

AEM URL-omdirigeringslösningar:

|                                                   | Hanteras och distribueras som AEM-projektkod | Möjlighet att ändra per marknadsförings-/innehållsteam | AEM som Cloud Service-kompatibel | Var körning av omdirigering sker |
|---------------------------------------------------|:-----------------------:|:---------------------:|:---------------------:| :---------------------:|
| [På Edge via AEM-hanterad CDN](#at-edge-via-aem-managed-cdn) | ✔ | ✘ | ✔ | Edge/CDN (inbyggt) |
| [Gå till Edge via ditt eget CDN (BYOCDN)](#at-edge-via-bring-your-own-cdn) | ✘ | ✘ | ✔ | Edge/CDN (BYOCDN) |
| [Apache `mod_rewrite` regler som Dispatcher config](#apache-mod_rewrite-module) | ✔ | ✘ | ✔ | Dispatcher |
| [ACS-kommandon - Omdirigeringshanteraren](#redirect-map-manager) | ✘ | ✔ | ✔ | Dispatcher |
| [ACS-kommandon - Omdirigeringshanteraren](#redirect-manager) | ✘ | ✔ | ✔ | AEM/Dispatcher |
| [Sidegenskapen `Redirect`](#the-redirect-page-property) | ✘ | ✔ | ✔ | AEM |


## Lösningsalternativ

Här följer några alternativ för att komma närmare besökarens webbläsare.

### På Edge via AEM-hanterad CDN {#at-edge-via-aem-managed-cdn}

Det här alternativet är endast tillgängligt för AEM as a Cloud Service-kunder.

[CDN](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn) som hanteras av AEM tillhandahåller en omdirigeringslösning på Edge-nivå, vilket reducerar antalet rundresor till ursprungsläget. Med funktionen [Omdirigering på klientsidan](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn-configuring-traffic#client-side-redirectors) kan du konfigurera omdirigeringsreglerna i AEM-projektkoden och distribuera med [konfigurationspipeline](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/how-to-setup#deploy-rules-through-cloud-manager). CDN-konfigurationsfilen (`cdn.yaml`) får inte vara större än 100 kB.

Det finns prestandafördelar med att hantera omdirigeringar på Edge- eller CDN-nivå.

### På Edge via din egen CDN

Vissa CDN-tjänster erbjuder omdirigeringslösningar på Edge-nivå, vilket minskar antalet rundresor till ursprungsläget. Se [Akamai Edge Redirector](https://techdocs.akamai.com/cloudlets/docs/what-edge-redirector), [AWS CloudFront-funktioner](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cloudfront-functions.html). Kontakta din CDN-leverantör för att få information om omdirigeringsmöjligheter på Edge-nivå.

Hantering av omdirigeringar på Edge- eller CDN-nivå har prestandafördelar, men de hanteras inte som en del av AEM utan snarare som separata projekt. En väldefinierad process för att hantera och tillämpa omdirigeringsregler är avgörande för att undvika problem.


### Apache `mod_rewrite`-modul

En vanlig lösning använder [Apache Module mod_rewrite](https://httpd.apache.org/docs/current/mod/mod_rewrite.html). [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) innehåller en Dispatcher-projektstruktur för både [AEM 6.x](https://github.com/adobe/aem-project-archetype/tree/develop/src/main/archetype/dispatcher.ams#file-structure)- och [AEM as a Cloud Service](https://github.com/adobe/aem-project-archetype/tree/develop/src/main/archetype/dispatcher.cloud#file-structure)-projekt. Standardreglerna (ej ändringsbara) och anpassade omskrivningsregler definieras i mappen `conf.d/rewrites` och omskrivningsmotorn aktiveras för `virtualhosts` som avlyssnar port `80` via filen `conf.d/dispatcher_vhost.conf`. Det finns ett exempel på implementering i [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd/tree/main/dispatcher/src/conf.d/rewrites).

I AEM as a Cloud Service hanteras dessa omdirigeringsregler som en del av AEM-koden och distribueras via Cloud Manager [konfigurationsflöde för webbnivån](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines) eller [pipeline i full hög](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines). Därför är er projektspecifika AEM-process att spela upp för att hantera, driftsätta och spåra omdirigeringsreglerna.

De flesta CDN-tjänster cachelagrar HTTP 301- och 302-omdirigeringar beroende på deras `Cache-Control`- eller `Expires`-huvuden. Det hjälper till att undvika rundtur efter den initiala omdirigeringen från Apache/Dispatcher.


### ACS AEM Commons

Det finns två tillgängliga funktioner i [ACS AEM Commons](https://adobe-consulting-services.github.io/acs-aem-commons/) för att hantera URL-omdirigeringar. Observera att ACS AEM Commons är ett öppen källkodsprojekt som drivs av en community och inte stöds av Adobe.

#### Omdirigeringshanteraren

[Redirect Map Manager](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-map-manager/index.html) hjälper AEM-administratörer att enkelt underhålla och publicera [Apache RewriteMap](https://httpd.apache.org/docs/2.4/rewrite/rewritemap.html) -filer utan att direkt behöva komma åt Apache-webbservern eller kräva att en Apache-webbserver startas om. Med den här funktionen kan behörighetsanvändare skapa, uppdatera och ta bort omdirigeringsregler från en konsol i AEM, utan hjälp av utvecklingsteamet eller en AEM-distribution. Omdirigeringshanteraren är både **AEM as a Cloud Service** (se [Gratis URL-omdirigeringar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/pipeline-free-url-redirects) och relaterad [självstudiekurs](https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/administration/implementing-pipeline-free-url-redirects#acs-commons---redirect-map-manager)) och **AEM 6.x** -kompatibel.

#### Omdirigeringshanteraren

Med [Omdirigeringshanteraren](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-manager/index.html) kan användare i AEM enkelt underhålla och publicera omdirigeringar från AEM. Implementeringen baseras på Java™-serverfiltret, vilket är en vanlig JVM-resursförbrukning. Den här funktionen eliminerar också beroendet av AEM utvecklingsteam och AEM-driftsättningar. Omdirigeringshanteraren är kompatibel med både **AEM as a Cloud Service** och **AEM 6.x**. Medan den initialt omdirigerade begäran måste trycka på AEM Publish-tjänsten för att generera cacheminnet 301/302 (de flesta) för CDN 301/302 som standard, vilket gör att efterföljande begäranden kan omdirigeras till edge/CDN.

[Omdirigeringshanteraren](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-manager/index.html) har även stöd för [Pipeline-fria URL-omdirigeringar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/pipeline-free-url-redirects)-strategier för **AEM as a Cloud Service** genom [att kompilera omdirigeringar till en textfil](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-manager/subpages/rewritemap.html) för [Apache RewriteMap](https://httpd.apache.org/docs/2.4/rewrite/rewritemap.html), vilket gör att omdirigeringar som används på Apache-webbservern kan uppdateras utan att den behöver hämtas direkt eller startas om. Mer information finns i [självstudiekursen](https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/administration/implementing-pipeline-free-url-redirects#acs-commons---redirect-manager). I det här fallet kommer den initiala omdirigeringsbegäran att drabba Apache-webbservern, inte AEM Publish-tjänsten.

### Sidegenskapen `Redirect`

Med egenskapen för OTB-sidan `Redirect` som är klar att användas från fliken [Avancerat](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/sites-console/page-properties.html) kan innehållsförfattare definiera omdirigeringsplatsen för den aktuella sidan. Den här lösningen är bäst för omdirigeringsscenarier per sida och har ingen central plats för att visa och hantera sidomdirigeringar.

## Vilken lösning passar bäst för implementering

Nedan finns några kriterier som avgör vilken lösning som är rätt. Organisationens IT- och marknadsföringsprocess bör också hjälpa er att välja rätt lösning.

1. Marknadsföringsteamet eller superanvändare kan hantera omdirigeringsregler utan AEM utvecklingsteam och AEM driftsättningar.
1. Processen för att hantera, verifiera, spåra och återställa ändringar eller riskreducering.
1. Tillgänglighet för _Subject Matter Expertis_ för **På Edge via CDN Service**-lösning.
