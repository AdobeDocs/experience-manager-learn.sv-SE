---
title: Använda AEM Experience Fragment-erbjudanden i Adobe Target
seo-title: Använda AEM Experience Fragment-erbjudanden i Adobe Target
description: Adobe Experience Manager 6.4 förnyar personaliseringsarbetsflödet mellan AEM och Target. Upplevelser som skapats i AEM kan nu levereras direkt till Adobe Target som HTML-erbjudanden. Marknadsförarna kan smidigt testa och personalisera innehåll i olika kanaler.
seo-description: Adobe Experience Manager 6.4 förnyar personaliseringsarbetsflödet mellan AEM och Target. Upplevelser som skapats i AEM kan nu levereras direkt till Adobe Target som HTML-erbjudanden. Marknadsförarna kan smidigt testa och personalisera innehåll i olika kanaler.
sub-product: content-services
feature: Experience Fragments
topics: integrations, personalization
audience: all
doc-type: feature video
activity: setup
version: 6.4, 6.5
uuid: 7b91f65d-5a35-419a-8cf7-be850165dd33
discoiquuid: 45fc8d83-73fb-42e5-9c92-ce588c085ed4
topic: Personanpassning
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '459'
ht-degree: 1%

---


# Använda Experience Fragment-erbjudanden i Adobe Target{#using-experience-fragment-offers-within-adobe-target}

Adobe Experience Manager 6.4 förnyar personaliseringsarbetsflödet mellan AEM och Target. Upplevelser som skapats i AEM kan nu levereras direkt till Adobe Target som HTML-erbjudanden. Marknadsförarna kan smidigt testa och personalisera innehåll i olika kanaler.

>[!VIDEO](https://video.tv.adobe.com/v/22383/?quality=12&learn=on)

>[!NOTE]
>
>Rekommenderas att använda klientbiblioteket at.js och det bästa sättet är att använda tagghanteringslösningar som Launch by Adobe, Adobe DTM eller någon annan tagghanteringslösning från tredje part för att lägga till målbibliotek på webbplatsens sidor

>[!NOTE]
>
>AEM Experience Fragment-erbjudanden i Adobe Target finns också som funktionspaket för AEM 6.3-användare. Se avsnittet nedan för funktionspaket och beroenden.


* Adobe Experience Manager lättanvända och kraftfulla mekanism för innehållsframtagning tillsammans med Adobe Target Artificial Intelligence (AI) och Machine Learning hjälper skribenter att skapa och hantera innehåll för alla kanaler på en central plats. Med möjligheten att exportera Experience Fragments till Adobe Target som HTML-erbjudanden har marknadsförarna nu större flexibilitet att skapa en mer personaliserad upplevelse med hjälp av dessa erbjudanden och kan nu testa och skala varje upplevelse de skapar.
* Den största skillnaden mellan HTML-erbjudandena och Experience Fragment-erbjudandena är att redigering för de senare bara kan göras i AEM och sedan synkroniseras med Adobe Target
* Konfigurationen av målmolntjänsten som tillämpas på Experience Fragment-mappen ärver alla Experience Fragments som skapats direkt under den överordnade mappen. Den underordnade mappen ärver inte den överordnade molntjänstkonfigurationen.
* För att skapa ett personaliserat erbjudande kan vi nu enkelt utnyttja innehåll som lagras i AEM.
* Du kan skapa olika typer av Target-aktiviteter, bland annat Sensei-baserade aktiviteter som Automatisk allokering, Automatiskt mål och Automated Personalization

## AEM 6.3 - funktionspaket och beroenden {#aem-feature-packs-and-dependencies}

| AEM 6.3 Feature Pack | Beroenden |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| [CQ-6.3.0-FEATUREPACK-18961](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-18961) | adobe/cq630/servicepack:aem-service-pkg:6.3.2 |
| [CQ-6.3.0-FEATUREPACK-24442](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-24442) | adobe/cq630/servicepack:aem-service-pkg:6.3.2 adobe/cq630/kumulativefixpack:aem-6.3.2-cfp:1.0 |
| [CQ-6.3.0-FEATUREPACK-24640](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq630/featurepack/cq-6.3.0-featurepack-24640) | adobe/cq630/servicepack:aem-service-pkg:6.3.2 adobe/cq630/kumulativefixpack:aem-6.3.2-cfp:2.0 |

## Ytterligare resurser {#additional-resources}

* [Dokumentation för Experience Fragments](https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/experience-fragments.html)
* [Använda Experience Fragments](/help/sites/experience-fragments/experience-fragments-feature-video-use.md)
