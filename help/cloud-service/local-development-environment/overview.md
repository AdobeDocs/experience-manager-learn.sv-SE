---
title: Lokal utvecklingsmiljö för AEM as a Cloud Service
description: Översikt över den lokala utvecklingsmiljön i Adobe Experience Manager (AEM).
feature: Developer Tools
version: Experience Manager as a Cloud Service
doc-type: article
jira: KT-3290
thumbnail: 32565.jpg
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2022-09-01T00:00:00Z
exl-id: 8b12f34c-be98-4f47-853c-411bb601990c
duration: 835
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '530'
ht-degree: 0%

---

# Lokal utvecklingsmiljö - konfiguration {#local-development-environment-set-up}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_overview"
>title="Ökning"
>abstract="Att konfigurera en lokal utvecklingsmiljö för AEM as a Cloud Service inkluderar utvecklingsverktyg som krävs för att utveckla, bygga och kompilera AEM-projekt, liksom lokala körtider som gör att utvecklare snabbt kan validera nya funktioner lokalt innan de driftsätter dem i AEM as a Cloud Service via Adobe Cloud Manager."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/development-guidelines.html" text="Utvecklingsriktlinjer"
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/basics/aem-sdk.html" text="Grundläggande om utveckling"

I den här självstudiekursen får du hjälp med att konfigurera en lokal utvecklingsmiljö för Adobe Experience Manager (AEM) med AEM as a Cloud Service SDK. Här finns de utvecklingsverktyg som krävs för att utveckla, bygga och kompilera AEM-projekt, liksom lokala körtider som gör att utvecklare snabbt kan validera nya funktioner lokalt innan de driftsätter dem i AEM as a Cloud Service via Adobe Cloud Manager.

>[!VIDEO](https://video.tv.adobe.com/v/32565?quality=12&learn=on)

![AEM as a Cloud Service Local Development Environment Technology Stack](./assets/overview/aem-sdk-technology-stack.png)

Den lokala utvecklingsmiljön för AEM kan delas upp i tre logiska grupper:

+ __AEM-projektet__ innehåller den anpassade koden, konfigurationen och innehållet som är det anpassade AEM-programmet.
+ __Local AEM Runtime__ som kör en lokal version av AEM Author och Publish services lokalt.
+ __Local Dispatcher Runtime__ som kör en lokal version av Apache HTTP Web Server och Dispatcher.

Den här självstudiekursen går igenom hur du installerar och konfigurerar de markerade objekten i ovanstående diagram, vilket ger en stabil lokal utvecklingsmiljö för AEM-utveckling.

## Filsystemsorganisation

I den här självstudien fastställdes platsen för AEM as a Cloud Service SDK-artefakter och AEM Project-kod enligt följande:

+ `~/aem-sdk` är en organisationsmapp som innehåller de olika verktygen i AEM as a Cloud Service SDK
+ `~/aem-sdk/author` innehåller AEM Author Service
+ `~/aem-sdk/publish` innehåller AEM Publish Service
+ `~/aem-sdk/dispatcher` innehåller Dispatcher Tools
+ `~/code/<project name>` innehåller den anpassade AEM Project-källkoden

Observera att `~` är kort för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`;

## Utvecklingsverktyg för AEM-projekt

AEM-projektet är en anpassad kodbas som innehåller koden, konfigurationen och innehållet som distribueras via Cloud Manager till AEM as a Cloud Service. Grundläggande projektstruktur genereras via [AEM Project Maven Archetype](https://github.com/adobe/aem-project-archetype).

I det här avsnittet av självstudiekursen visas hur du:

+ Installera [!DNL Java]
+ Installera [!DNL Node.js] (och npm)
+ Installera [!DNL Maven]
+ Installera [!DNL Git]

[Konfigurera utvecklingsverktyg för AEM-projekt](./development-tools.md)

## Lokal AEM Runtime

AEM as a Cloud Service SDK tillhandahåller en [!DNL QuickStart Jar] som kör en lokal version av AEM. [!DNL QuickStart Jar] kan användas för att köra AEM Author Service eller AEM Publish Service lokalt. Observera att även om [!DNL QuickStart Jar] tillhandahåller en lokal utvecklingsupplevelse, ingår inte alla funktioner som är tillgängliga i AEM as a Cloud Service i [!DNL QuickStart Jar].

I det här avsnittet av självstudiekursen visas hur du:

+ Installera [!DNL Java]
+ Ladda ned AEM SDK
+ Kör [!DNL AEM Author Service]
+ Kör [!DNL AEM Publish Service]

[Konfigurera den lokala AEM-miljön](./aem-runtime.md)

## Lokal körningsmiljö för [!DNL Dispatcher]

AEM as a Cloud Service SDK Dispatcher Tools innehåller allt som krävs för att konfigurera den lokala [!DNL Dispatcher]-miljön. [!DNL Dispatcher]-verktygen är [!DNL Docker]-baserade och innehåller kommandoradsverktyg för att överföra [!DNL Apache HTTP] webbserver- och [!DNL Dispatcher] konfigurationsfiler till ett kompatibelt format och distribuera dem till [!DNL Dispatcher] som körs i [!DNL Docker] -behållaren.

I det här avsnittet av självstudiekursen visas hur du:

+ Ladda ned AEM SDK
+ Installera [!DNL Dispatcher]-verktyg
+ Kör den lokala [!DNL Dispatcher]-miljön

[Konfigurera lokal  [!DNL Dispatcher] körningsmiljö](./dispatcher-tools.md)
