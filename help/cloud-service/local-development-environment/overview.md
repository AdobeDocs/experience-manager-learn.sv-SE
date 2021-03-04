---
title: Lokal utvecklingsmiljö för AEM som Cloud Service
description: Översikt över den lokala utvecklingsmiljön i Adobe Experience Manager (AEM).
feature: Utvecklarverktyg
topics: development
version: cloud-service
doc-type: article
activity: troubleshoot
audience: developer
kt: 3290
thumbnail: 32565.jpg
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '482'
ht-degree: 0%

---


# Lokal utvecklingsmiljö - konfiguration

I den här självstudiekursen får du hjälp med att konfigurera en lokal utvecklingsmiljö för Adobe Experience Manager (AEM) med AEM som Cloud Service-SDK. Utvecklingsverktygen som behövs för att utveckla, bygga och kompilera AEM-projekt ingår, liksom lokala körtider som gör att utvecklare snabbt kan validera nya funktioner lokalt innan de distribueras till AEM som en Cloud Service via Adobe Cloud Manager.

>[!VIDEO](https://video.tv.adobe.com/v/32565/?quality=12&learn=on)

![AEM som Cloud Service Local Development Environment Technology Stack](./assets/overview/aem-sdk-technology-stack.png)

Den lokala utvecklingsmiljön för AEM kan delas upp i tre logiska grupper:

+ __AEM Project__ innehåller den anpassade koden, konfigurationen och innehållet som är det anpassade AEM-programmet.
+ __Local AEM Runtime__ som kör en lokal version av AEM Author och Publish services lokalt.
+ __Local Dispatcher Runtime__ som kör en lokal version av Apache HTTP Web Server och Dispatcher.

I den här självstudiekursen går du igenom hur du installerar och ställer in de markerade objekten i ovanstående diagram, vilket ger en stabil lokal utvecklingsmiljö för AEM.

## Filsystemsorganisation

I den här självstudien fastställdes platsen för AEM som en SDK-artefakt för Cloud Service och AEM projektkoden enligt följande:

+ `~/aem-sdk` är en organisationsmapp som innehåller de olika verktygen som AEM tillhandahåller som en Cloud Service-SDK
+ `~/aem-sdk/author` innehåller AEM Author Service
+ `~/aem-sdk/publish` innehåller AEM-publiceringstjänsten
+ `~/aem-sdk/dispatcher` innehåller Dispatcher-verktygen
+ `~/code/<project name>` innehåller den anpassade AEM Project-källkoden

Observera att `~` är kort för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`;

## Utvecklingsverktyg för AEM projekt

Det AEM projektet är den anpassade kodbas som innehåller koden, konfigurationen och innehållet som distribueras via Cloud Manager till AEM som en Cloud Service. Grundläggande projektstruktur genereras via [AEM Project Maven Archetype](https://github.com/adobe/aem-project-archetype).

I det här avsnittet av självstudiekursen visas hur du:

+ Installera [!DNL Java]
+ Installera [!DNL Node.js] (och npm)
+ Installera [!DNL Maven]
+ Installera [!DNL Git]

[Konfigurera utvecklingsverktyg för AEM projekt](./development-tools.md)

## Local AEM Runtime

AEM som en Cloud Service-SDK innehåller en [!DNL QuickStart Jar] som kör en lokal version av AEM. [!DNL QuickStart Jar] kan användas för att köra antingen AEM Author Service eller AEM Publish Service lokalt. Observera att även om [!DNL QuickStart Jar] ger en lokal utvecklingsupplevelse, ingår inte alla funktioner som är tillgängliga i AEM som en Cloud Service i [!DNL QuickStart Jar].

I det här avsnittet av självstudiekursen visas hur du:

+ Installera [!DNL Java]
+ Ladda ned AEM SDK
+ Kör [!DNL AEM Author Service]
+ Kör [!DNL AEM Publish Service]

[Konfigurera lokal AEM](./aem-runtime.md)

## Lokal [!DNL Dispatcher]-körningsmiljö

AEM som Cloud Service-SDK:s Dispatcher Tools innehåller allt som krävs för att ställa in den lokala [!DNL Dispatcher]-miljön. [!DNL Dispatcher] Verktygen är  [!DNL Docker]baserade och innehåller kommandoradsverktyg för att överföra  [!DNL Apache HTTP] webbservern och  [!DNL Dispatcher] konfigurationsfiler till kompatibla format och distribuera dem till  [!DNL Dispatcher] körning i  [!DNL Docker] behållaren.

I det här avsnittet av självstudiekursen visas hur du:

+ Ladda ned AEM SDK
+ Installera [!DNL Dispatcher]-verktyg
+ Kör den lokala [!DNL Dispatcher]-miljön

[Konfigurera  [!DNL Dispatcher] LocalRuntime](./dispatcher-tools.md)
