---
title: Integrera taggar för Experience Platform-datainsamling (Launch) och AEM
description: Taggar i Experience Platform Data Collection är nästa generations tagghanteringslösning för Adobe och det bästa sättet att driftsätta Adobe Analytics, Target, Audience Manager och många fler lösningar. Få en översikt över taggar (tidigare Launch) och den rekommenderade integrationen med Adobe Experience Manager.
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
duration: 256
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '320'
ht-degree: 0%

---

# Integrera taggar och AEM för datainsamling från Experience Platform {#overview}

Lär dig integrera Experience Platform _Taggar för datainsamling_ (tidigare Launch) med Adobe Experience Manager.

>[!NOTE]
>
>Adobe Experience Platform Launch har omklassificerats som en serie datainsamlingstekniker i Adobe Experience Platform. Som ett resultat av detta har flera terminologiska förändringar införts i produktdokumentationen. Se följande [dokument](https://experienceleague.adobe.com/docs/experience-platform/tags/term-updates.html) för en konsoliderad hänvisning till terminologiska förändringar.


Taggar är Adobe Experience Platform nästa generation av tagghanteringsteknik. Taggar är det enklaste sättet att driftsätta Adobe Analytics, Target, Audience Manager och många andra lösningar. Få en översikt över taggar och den rekommenderade integreringen med Adobe Experience Manager.

>[!VIDEO](https://video.tv.adobe.com/v/3417061?quality=12&learn=on)


## Förutsättningar

Följande krävs när du integrerar taggar för Experience Platform-datainsamling.

+ AEM administratörsåtkomst till AEM as a Cloud Service miljö
+ En referenswebbplats som [WKND](https://github.com/adobe/aem-guides-wknd) distribueras på den.
+ Tillgång till Adobe Experience Platform datainsamling
+ Systemadministratörsåtkomst till [Adobe Developer Console](https://developer.adobe.com/developer-console/)


## Stegen på hög nivå

+ I Adobe Experience Platform Data Collection skapar du en taggegenskap och redigerar den till _Lägg till regel_. Sedan _Lägg till bibliotek_, markera den nya regeln, godkänn och publicera den.
+ Anslut AEM och taggar med befintlig (eller ny) IMS-konfiguration
+ I AEM skapar du en konfiguration för Launch-molntjänster, tillämpar den sedan på en befintlig webbplats och kontrollerar slutligen att taggegenskapen och dess bibliotek läses in på webbplatsen Publicerad eller Författare.

## Nästa steg

[Skapa en taggegenskap](create-tag-property.md)

## Ytterligare resurser {#additional-resources}

+ [Integrering med Experience Platform med program från Experience Cloud](https://experienceleague.adobe.com/docs/platform-learn/tutorials/intro-to-platform/integrations-with-experience-cloud-applications.html)
+ [Översikt över taggar](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html)
+ [Implementera Experience Cloud på webbplatser med taggar](https://experienceleague.adobe.com/docs/platform-learn/implement-in-websites/overview.html)
