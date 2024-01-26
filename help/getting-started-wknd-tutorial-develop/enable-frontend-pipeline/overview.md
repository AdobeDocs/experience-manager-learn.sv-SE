---
title: Aktivera frontendpipeline för standardprojekttypen AEM
description: Lär dig hur du aktiverar en frontpipeline för AEM standardprojekt för snabbare distribution av statiska resurser som CSS, JavaScript, teckensnitt och ikoner. Dessutom separeras front-end-utveckling från backend-utveckling i full-stack på AEM.
version: Cloud Service
feature: AEM Project Archetype, Cloud Manager, CI-CD Pipeline
topic: Content Management, Development, Development, Architecture
role: Developer, Architect, Admin
level: Intermediate
jira: KT-10689
mini-toc-levels: 1
index: y
recommendations: disable
thumbnail: 53409343.jpg
last-substantial-update: 2022-09-23T00:00:00Z
doc-type: Tutorial
exl-id: b795e7e8-f611-4fc3-9846-1d3f1a28ccbc
duration: 227
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '428'
ht-degree: 0%

---

# Aktivera frontendpipeline för standardprojekttypen AEM{#enable-front-end-pipeline-standard-aem-project}

Lär dig hur du aktiverar [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) (även kallat Standard AEM Project) som skapats med [AEM Project Archettype](https://github.com/adobe/aem-project-archetype) för att driftsätta frontresurser som CSS, JavaScript, Fonts och Icons med hjälp av en pipeline för snabbare utveckling till driftsättning. Avgränsningen mellan frontend-utveckling och fullstacksutveckling på AEM. Du får också lära dig hur dessa resurser __not__ från AEM, men från CDN, en förändring i leveransparadigm.


En ny pipeline skapas i Adobe Cloud Manager som endast bygger och distribuerar `ui.frontend` artefakter till det inbyggda CDN och informerar AEM om var det finns. AEM under webbsidans HTML-generation `<link>` och `<script>` -taggar, referera till den här artefaktplatsen i `href` attributvärde.

Men efter WKND Sites AEM projektkonverteringen kan gränssnittsutvecklarna arbeta separat från och parallellt med all backend-utveckling i en hel stack på AEM, som har egna driftsättningspipelines.

>[!IMPORTANT]
>
>Generellt sett används front end-pipelinen vanligtvis med [Skapa AEM](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/site-creation/quick-site/overview.html?lang=en)finns det en självstudiekurs [Komma igång med AEM Sites - skapa webbplatser snabbt](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/overview.html) om du vill veta mer om det. Så i den här självstudiekursen och tillhörande videor som du hittar referenser till den är det för att se till att små skillnader verkligen uppstår och att det finns en direkt eller indirekt jämförelse som förklarar viktiga koncept.


En relaterad [flerstegskurs](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/overview.html) leder igenom implementeringen av en AEM sajt för ett fiktivt livsstilsmärke, WKND, med hjälp av funktionen för att skapa snabbwebbplatser. Granska [Arbetsflöde för teman](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/theming.html) Det är också bra att förstå hur rörliga delar fungerar på framsidan.

## Översikt, fördelar och överväganden för frontendpipeline

>[!VIDEO](https://video.tv.adobe.com/v/3409343?quality=12&learn=on)


>[!NOTE]
>
>Detta gäller endast AEM as a Cloud Service och inte för AMS-baserade Adobe Cloud Manager-distributioner.

## Förutsättningar

Distributionssteget i den här självstudiekursen äger rum i en hanterare för Adobe Cloud, se till att du har en __Distributionshanteraren__ roll, se Molnhantering [Rolldefinitioner](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/requirements/users-and-roles.html?lang=en#role-definitions).

Se till att du använder [Sandlådeprogram](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-sandbox-programs.html) och [Utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments.html) när du slutför den här självstudiekursen.

## Nästa steg {#next-steps}

En stegvis självstudiekurs leder dig igenom [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) konvertering för att aktivera den för frontendpipeline.

Vad väntar du på? Starta självstudiekursen genom att gå till [Granska projekt i full hög](review-uifrontend-module.md) kapitlet och dra nytta av utvecklingscykeln i början av AEM Sites Project.
