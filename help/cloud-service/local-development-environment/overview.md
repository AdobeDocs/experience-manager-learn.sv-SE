---
title: Lokal utvecklingsmiljö för AEM as a Cloud Service
description: Översikt över den lokala utvecklingsmiljön i Adobe Experience Manager (AEM).
feature: Developer Tools
version: Cloud Service
doc-type: article
jira: KT-3290
thumbnail: 32565.jpg
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2022-09-01T00:00:00Z
exl-id: 8b12f34c-be98-4f47-853c-411bb601990c
duration: 851
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '530'
ht-degree: 0%

---

# Lokal utvecklingsmiljö - konfiguration {#local-development-environment-set-up}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_overview"
>title="Ökning"
>abstract="Att konfigurera en lokal utvecklingsmiljö för AEM as a Cloud Service omfattar utvecklingsverktyg som krävs för att utveckla, skapa och kompilera AEM projekt, samt lokala körtider som gör att utvecklare snabbt kan validera nya funktioner lokalt innan de distribueras till AEM as a Cloud Service via Adobe Cloud Manager."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/development-guidelines.html" text="Utvecklingsriktlinjer"
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/basics/aem-sdk.html" text="Grundläggande om utveckling"

I den här självstudiekursen går du igenom hur du konfigurerar en lokal utvecklingsmiljö för Adobe Experience Manager (AEM) med AEM as a Cloud Service SDK. Utvecklingsverktygen som behövs för att utveckla, bygga och kompilera AEM-projekt ingår, liksom lokala körtider som gör att utvecklare snabbt kan validera nya funktioner lokalt innan de distribueras till AEM as a Cloud Service via Adobe Cloud Manager.

>[!VIDEO](https://video.tv.adobe.com/v/32565?quality=12&learn=on)

![AEM as a Cloud Service Local Development Environment Technology Stack](./assets/overview/aem-sdk-technology-stack.png)

Den lokala utvecklingsmiljön för AEM kan delas upp i tre logiska grupper:

+ The __AEM__ innehåller den anpassade koden, konfigurationen och innehållet som är det anpassade AEM.
+ The __Local AEM Runtime__ som kör en lokal version av AEM författar- och publiceringstjänster lokalt.
+ The __Local Dispatcher Runtime__ som kör en lokal version av Apache HTTP Web Server och Dispatcher.

I den här självstudiekursen går du igenom hur du installerar och ställer in de markerade objekten i ovanstående diagram, vilket ger en stabil lokal utvecklingsmiljö för AEM.

## Filsystemsorganisation

I den här självstudien fastställdes platsen för de AEM as a Cloud Service SDK-artefakterna och AEM projektkoden enligt följande:

+ `~/aem-sdk` är en organisationsmapp som innehåller de olika verktygen i AEM as a Cloud Service SDK
+ `~/aem-sdk/author` innehåller AEM författartjänst
+ `~/aem-sdk/publish` innehåller AEM publiceringstjänst
+ `~/aem-sdk/dispatcher` innehåller Dispatcher Tools
+ `~/code/<project name>` innehåller den anpassade AEM Project-källkoden

Observera att `~` är kortskrift för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`;

## Utvecklingsverktyg för AEM projekt

Det AEM projektet är den anpassade kodbasen som innehåller koden, konfigurationen och innehållet som distribueras via Cloud Manager till AEM as a Cloud Service. Grundläggande projektstruktur genereras via [AEM Project Maven Archetype](https://github.com/adobe/aem-project-archetype).

I det här avsnittet av självstudiekursen visas hur du:

+ Installera [!DNL Java]
+ Installera [!DNL Node.js] (och npm)
+ Installera [!DNL Maven]
+ Installera [!DNL Git]

[Konfigurera utvecklingsverktyg för AEM projekt](./development-tools.md)

## Local AEM Runtime

AEM as a Cloud Service SDK innehåller en [!DNL QuickStart Jar] som kör en lokal AEM. The [!DNL QuickStart Jar] kan användas för att köra antingen AEM författartjänst eller AEM publiceringstjänst lokalt. Observera att medan [!DNL QuickStart Jar] har en lokal utvecklingsupplevelse, och inte alla funktioner som finns i AEM as a Cloud Service ingår i [!DNL QuickStart Jar].

I det här avsnittet av självstudiekursen visas hur du:

+ Installera [!DNL Java]
+ Ladda ned AEM SDK
+ Kör [!DNL AEM Author Service]
+ Kör [!DNL AEM Publish Service]

[Konfigurera den lokala AEM](./aem-runtime.md)

## Lokal [!DNL Dispatcher] Körning

AEM as a Cloud Service SDK&#39;s Dispatcher Tools innehåller allt som krävs för att konfigurera lokala [!DNL Dispatcher] runtime. [!DNL Dispatcher] Verktygen är [!DNL Docker]-baserat och innehåller kommandoradsverktyg för att implementera [!DNL Apache HTTP] Webbserver och [!DNL Dispatcher] konfigurationsfiler i kompatibla format och distribuera dem till [!DNL Dispatcher] som körs i [!DNL Docker] behållare.

I det här avsnittet av självstudiekursen visas hur du:

+ Ladda ned AEM SDK
+ Installera [!DNL Dispatcher] verktyg
+ Kör den lokala [!DNL Dispatcher] runtime

[Konfigurera den lokala [!DNL Dispatcher] Körning](./dispatcher-tools.md)
