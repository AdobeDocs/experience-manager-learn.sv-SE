---
title: Integrera taggar i Adobe Experience Platform och AEM
description: Taggar i Experience Platform Data Collection är nästa generations tagghanteringslösning för Adobe och det bästa sättet att driftsätta Adobe Analytics, Target, Audience Manager och många fler lösningar. Få en översikt över taggar i Adobe Experience Platform och den rekommenderade integreringen med Adobe Experience Manager.
solution: Experience Manager, Data Collection, Experience Platform
jira: KT-5979
thumbnail: 39090.jpg
topic: Integrations
feature: Integrations
role: Developer
level: Intermediate
last-substantial-update: 2022-07-10T00:00:00Z
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: bdae56d8-96e7-4b05-9b8b-3c6c2e998bd8
duration: 230
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '270'
ht-degree: 0%

---

# Integrera taggar och AEM för datainsamling från Experience Platform {#overview}

Lär dig hur du integrerar taggar i Adobe Experience Platform med Adobe Experience Manager.

Taggar är Adobe Experience Platform nästa generation av tagghanteringsteknik. Taggar är det enklaste sättet att driftsätta Adobe Analytics, Target, Audience Manager och många andra lösningar. Få en översikt över taggar och den rekommenderade integreringen med Adobe Experience Manager.

>[!VIDEO](https://video.tv.adobe.com/v/3445204?quality=12&learn=on&captions=swe)

## Förutsättningar

Följande krävs när du integrerar taggar för Experience Platform-datainsamling.

+ AEM administratörsåtkomst till AEM as a Cloud Service-miljön
+ En referenswebbplats som [WKND](https://github.com/adobe/aem-guides-wknd) har distribuerats till den.
+ Tillgång till Adobe Experience Platform datainsamling
+ Systemadministratörsåtkomst till [Adobe Developer Console](https://developer.adobe.com/developer-console/)


## Stegen på hög nivå

+ Skapa en taggegenskap i Adobe Experience Platform Data Collection och redigera den till _Lägg till regel_. _Lägg till bibliotek_, markera den nya regeln, godkänn och publicera den.
+ Anslut AEM och taggar med befintlig (eller ny) IMS-konfiguration
+ I AEM skapar du en tagg i molntjänstkonfigurationen, tillämpar den sedan på en befintlig plats och kontrollerar slutligen att taggegenskapen och dess bibliotek läses in på webbplatsen Publicerad eller Författare.

## Nästa steg

[Skapa en taggegenskap](create-tag-property.md)

## Ytterligare resurser {#additional-resources}

+ [Integrering med Experience Platform med Experience Cloud-program](https://experienceleague.adobe.com/docs/platform-learn/tutorials/intro-to-platform/integrations-with-experience-cloud-applications.html?lang=sv-SE)
+ [Översikt över taggar](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html?lang=sv-SE)
+ [Implementera Experience Cloud på webbplatser med taggar](https://experienceleague.adobe.com/docs/platform-learn/implement-in-websites/overview.html?lang=sv-SE)
