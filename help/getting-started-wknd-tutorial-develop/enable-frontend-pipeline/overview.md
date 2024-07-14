---
title: Aktivera frontendpipeline för standardprojekttypen AEM
description: Lär dig hur du aktiverar en frontpipeline för AEM standardprojekt för snabbare driftsättning av statiska resurser som CSS, JavaScript, Fonts, Icons. Dessutom separeras front-end-utveckling från backend-utveckling i full-stack på AEM.
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
duration: 206
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '428'
ht-degree: 0%

---

# Aktivera frontendpipeline för standardprojekttypen AEM{#enable-front-end-pipeline-standard-aem-project}

Lär dig hur du aktiverar [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) (även kallat Standard AEM Project) som skapats med [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) för att distribuera frontresurser som CSS, JavaScript, Fonts och Icons med hjälp av en frontpipeline för en snabbare utveckling-till-driftsättningscykel. Avgränsningen mellan frontend-utveckling och fullstacksutveckling på AEM. Du kan också lära dig hur de här frontendresurserna __inte__ hanteras från AEM utan från CDN, en ändring i leveransparadigm.


En ny frontendpipeline skapas i Adobe Cloud Manager som endast skapar och distribuerar `ui.frontend`-artefakter till det inbyggda CDN-nätverket och informerar AEM om dess plats. AEM under webbsidans HTML-generering refererar taggarna `<link>` och `<script>` till den här artefaktplatsen i attributvärdet `href`.

Men efter WKND Sites AEM projektkonverteringen kan gränssnittsutvecklarna arbeta separat från och parallellt med all backend-utveckling i en hel stack på AEM, som har egna driftsättningspipelines.

>[!IMPORTANT]
>
>Generellt sett används frontendpipeline vanligtvis med [AEM snabbwebbplatsgenereringen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/site-creation/quick-site/overview.html?lang=en), det finns en relaterad självstudiekurs [Komma igång med AEM Sites - Skapa snabbwebbplats](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/overview.html) för att lära dig mer om det. Så i den här självstudiekursen och tillhörande videor som du hittar referenser till den är det för att se till att små skillnader verkligen uppstår och att det finns en direkt eller indirekt jämförelse som förklarar viktiga koncept.


En relaterad självstudiekurs i [flera steg](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/overview.html) går igenom implementeringen av en AEM webbplats för ett fiktivt livsstilsmärke som WKND med hjälp av funktionen Skapa snabbwebbplats. Det är också praktiskt att granska arbetsflödet [Tema](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/theming.html) för att förstå arbetsuppgifterna för pipeline i frontend.

## Översikt, fördelar och överväganden för frontendpipeline

>[!VIDEO](https://video.tv.adobe.com/v/3409343?quality=12&learn=on)


>[!NOTE]
>
>Detta gäller endast AEM as a Cloud Service och inte för AMS-baserade Adobe Cloud Manager-distributioner.

## Förutsättningar

Distributionssteget i den här självstudiekursen äger rum i en Adobe Cloud Manager. Se till att du har en __Distributionshanterarroll__, se [Rolldefinitioner för molnet](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/requirements/users-and-roles.html?lang=en#role-definitions).

Var noga med att använda [sandlådeprogrammet](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-sandbox-programs.html) och [utvecklingsmiljön](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments.html) när du slutför den här självstudiekursen.

## Nästa steg {#next-steps}

En stegvis självstudiekurs går igenom konverteringen av [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) för att aktivera den för frontendpipeline.

Vad väntar du på? Starta självstudiekursen genom att gå till kapitlet [Granska projekt i full hög](review-uifrontend-module.md) och gå igenom utvecklingscykeln i början av standardprojektet för AEM Sites.
