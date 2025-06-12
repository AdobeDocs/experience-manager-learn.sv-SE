---
title: Möjliggör frontend-pipeline för AEM standardprojekttyp
description: Lär dig hur du aktiverar en frontpipeline för vanliga AEM-projekt för snabbare driftsättning av statiska resurser som CSS, JavaScript, Fonts, Icons. Dessutom separeras front-end-utveckling från backend-utveckling i helhög på AEM.
version: Experience Manager as a Cloud Service
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
source-git-commit: dbf63f30ccfd06e4f4d7883c2f7bc4ac78245364
workflow-type: tm+mt
source-wordcount: '428'
ht-degree: 0%

---

# Möjliggör frontend-pipeline för AEM standardprojekttyp{#enable-front-end-pipeline-standard-aem-project}

{{traditional-aem}}

Lär dig hur du aktiverar [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) (även kallat AEM Standard Project) som skapats med [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) för att distribuera frontresurser som CSS, JavaScript, Fonts och Icons med hjälp av en frontpipeline för en snabbare utvecklingscykel. Avgränsningen mellan front-end-utveckling och backend-utveckling i full-stack på AEM. Du kan också lära dig hur dessa front end-resurser __inte__ hanteras från AEM-databasen utan från CDN, en ändring i leveransparadigm.


En ny frontendpipeline skapas i Adobe Cloud Manager som endast skapar och distribuerar `ui.frontend`-artefakter till det inbyggda CDN-nätverket och informerar AEM om dess plats. På AEM under webbsidans HTML-generering hänvisar taggarna `<link>` och `<script>` till den här artefaktplatsen i attributvärdet `href`.

Efter WKND Sites AEM-projektkonverteringen kan utvecklarna arbeta separat från och parallellt med all backend-utveckling i AEM, som har egna driftsättningspipelines.

>[!IMPORTANT]
>
>Generellt sett används frontendspipelinen vanligtvis med [AEM Quick Site Creation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/site-creation/quick-site/overview.html?lang=sv-SE). Det finns en självstudiekurs [Getting Started with AEM Sites - Quick Site Creation](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/overview.html?lang=sv-SE) som du kan lära dig mer om. Så i den här självstudiekursen och tillhörande videor som du hittar referenser till den är det för att se till att små skillnader verkligen uppstår och att det finns en direkt eller indirekt jämförelse som förklarar viktiga koncept.


En relaterad självstudiekurs i [flera steg](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/overview.html?lang=sv-SE) går igenom implementeringen av en AEM-webbplats för ett fiktivt livsstilsmärke som WKND med hjälp av funktionen Skapa snabbwebbplats. Det är också praktiskt att granska arbetsflödet [Tema](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/theming.html?lang=sv-SE) för att förstå arbetsuppgifterna för pipeline i frontend.

## Översikt, fördelar och överväganden för frontendpipeline

>[!VIDEO](https://video.tv.adobe.com/v/3409343?quality=12&learn=on)


>[!NOTE]
>
>Detta gäller endast AEM as a Cloud Service och inte AMS-baserade Adobe Cloud Manager-distributioner.

## Förutsättningar

Distributionssteget i den här självstudiekursen äger rum i en Adobe Cloud Manager. Se till att du har en __Distributionshanterarroll__, se [Rolldefinitioner för molnet](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/requirements/users-and-roles.html?lang=sv-SE#role-definitions).

Var noga med att använda [sandlådeprogrammet](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-sandbox-programs.html?lang=sv-SE) och [utvecklingsmiljön](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments.html?lang=sv-SE) när du slutför den här självstudiekursen.

## Nästa steg {#next-steps}

En stegvis självstudiekurs går igenom [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) -konverteringen för att aktivera den för frontendpipeline.

Vad väntar du på? Starta självstudiekursen genom att gå till kapitlet [Granska projekt i full hög](review-uifrontend-module.md) och gå igenom utvecklingscykeln i början av standardprojektet för AEM Sites.
