---
title: AEM as a Cloud Service integreringar med Adobe Experience Cloud
description: Läs om AEM as a Cloud Service integreringar som stöds med andra Adobe Experience Cloud-produkter.
version: Cloud Service
feature: Integrations
topic: Integrations
role: Leader, Architect, Admin, Developer
level: Beginner
jira: KT-10718
thumbnail: KT-10718.png
last-substantial-update: 2022-11-17T00:00:00Z
mini-toc-levels: 1
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM as a Cloud Service" before-title="false"
exl-id: 9e856dcc-f042-4e9d-bf97-dd4f72e837e3
duration: 218
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '684'
ht-degree: 1%

---

# AEM as a Cloud Service integreringar med Adobe Experience Cloud

Läs om AEM as a Cloud Service integreringar som stöds med andra Adobe Experience Cloud-produkter.
Klicka på Experience Cloud för att få dokumentation om hur du konfigurerar och använder integreringarna.

|                                                                   | AEM Sites | AEM Assets | AEM Forms |
|-------------------------------------------------------------------|:---------:|:----------:|:---------:|
| [Acrobat Sign](#adobe-acrobat-sign) |           |            | ✔ |
| Reklam |           |            |          |
| [Analyser](#adobe-analytics) | ✔ | ✔ | ✔ |
| Audience Manager |           |            |          |
| Campaign Classic |           |            |          |
| Campaign Standard |           |            |          |
| [Handel](#adobe-commerce) | ✔ | ✔ |          |
| Customer Journey Analytics |           |            |          |
| [Experience Platform-taggar](#adobe-experience-platform-tags) | ✔ |            | ✔ |
| [Journey Optimizer](#adobe-journey-optimizer) |           | ✔ |          |
| [Utbildningschef](#adobe-learning-manager) | ✔ |            |          |
| Marketo Engage |           |            |          |
| CDP i realtid |           |            |          |
| [Sensei](#adobe-sensei) | ✔ | ✔ | ✔ |
| [Mål](#adobe-target) | ✔ |            |          |
| [Workfront](#adobe-workfront) |           | ✔ |          |


## Adobe Acrobat Sign

Adobe Acrobat Sign (tidigare Acrobat Sign) möjliggör e-signaturarbetsflöden för AEM Forms adaptiva formulär genom att förbättra arbetsflödena för att bearbeta dokument inom juridik, försäljning, lön, HR och andra områden.

### AEM Forms

+ [Konfigurera Adobe Acrobat Sign-integrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/forms/adobe-sign-integration-adaptive-forms.html)
+ [AEM Forms och Adobe Acrobat Sign - självstudiekurs](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/forms-and-sign/introduction.html)

## Adobe Analytics

Adobe Analytics integrering med AEM as a Cloud Service gör att ni kan spåra innehållsaktivitet och analysera data var som helst under kundresan. Dessutom får du smidig rapportering, prediktiv information med mera.

### AEM Sites

+ [Konfigurera Adobe Analytics-integrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-analytics.html)
+ [AEM Sites och Analytics, genomgång](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/analytics/collect-data-analytics.html)
+ Adobe-klientdatalager (ACDL)

   + [Utöka ACDL i AEM WCM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/extending.html)
   + [Integrera ACDL med AEM WCM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/data-layer/integrations.html)
   + [Händelsestyrd datahantering med ACDL](https://experienceleague.adobe.com/docs/adobe-developers-live-events/events/2021/oct2021/adobe-client-data-layer.html)
   + [Självstudiekurs om Adobe Client Data Layer (ACDL)](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/adobe-client-data-layer/data-layer-overview.html)

### AEM Assets

+ [Översikt över resursinsikter](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/manage/assets-insights.html)
+ [Konfigurera resursinsikter](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/manage/assets-insights.html#configure-asset-insights)
+ [Självstudiekurs om insikter om resurser](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/advanced/asset-insights-launch-tutorial.html)

### AEM Forms

+ [Konfigurera Adobe Analytics-integrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/forms/integrate-aem-forms-with-adobe-analytics.html)

### AEM Sites

+ [Integrera med Adobe Campaign Classic](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-campaign-classic.html#configure-user)
+ [Skapa ett Adobe Experience Manager Newsletter](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/creating-newsletter.html)
+ [Dokumentation för AEM e-postkärnkomponenter](https://github.com/adobe/aem-core-email-components#aem-email-core-components)

## Adobe Commerce

Tack vare Adobe Commerce integrering med AEM as a Cloud Service kan varumärken skalas om och förnya snabbare för att särskilja handelsupplevelser och fånga upp ökade webbutgifter. AEM med Commerce kombinerar de engagerande, flerkanaliga och personaliserade upplevelserna i Experience Manager med valfritt antal handelslösningar för att ge alla delar av kundresan olika upplevelser, minska tiden till värde och öka konverteringsgraden.

### AEM Sites

+ [Användarhandbok för AEM och e-handel](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/content-and-commerce/home.html)


## Adobe Experience Platform-taggar

Adobe Experience Platform-taggar (tidigare Adobe Launch, DTM) integreras smidigt med AEM, vilket är ett enkelt sätt att driftsätta och hantera [analys](#adobe-analytics), [målinriktning](#adobe-target)taggar för marknadsföring och annonsering krävs för engagerande kundupplevelser.

### AEM Sites

+ [Användarhandbok för Experience Platform-taggar](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html)
+ [Experience Platform taggar, genomgång](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html)

### AEM Forms

+ [Användarhandbok för Experience Platform-taggar](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html)
+ [Experience Platform taggar, genomgång](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html)

## Adobe Journey Optimizer

Adobe Journey Optimizer hjälper er att schemalägga flerkanalskampanjer och en-till-en-stund med miljontals kunder från ett och samma program - och hela kundresan optimeras med smarta beslut och insikter.

### AEM Assets

+ [Integrera AEM Assets Essentials med Adobe Journey Optimizer](https://experienceleague.adobe.com/docs/journey-optimizer-learn/tutorials/create-messages/create-email-content-with-the-message-editor.html)

## Adobe Learning Manager

Adobe Learning Manager (tidigare Adobe Captivate Prime) ger skräddarsydd inlärning till kunder och medarbetare.

### AEM Sites

+ [Integrera AEM Sites med Adobe Learning Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-learning-manager.html)

## Adobe Sensei

Adobe Sensei erbjuder AI- och maskininlärningsteknik för att omvandla processen för innehållshantering via smarta taggar, Smart Crop, Visual Search med mera!

### AEM Sites

+ [Sammanfatta text i innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/content-fragments/content-fragments-variations.html#summarizing-text)

### AEM Assets

+ [Smarta taggar för bilder](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/metadata/image-smart-tags.html)
+ [Anpassade smarta taggar för bilder](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/metadata/custom-smart-tags.html)
+ [Smarta taggar för videoklipp](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/metadata/video-smart-tags.html)
+ [Smart beskärning](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/dynamic-media/smart-crop-feature-video-use.html)
+ [Visuell sökning](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/search-and-discovery/search.html)

### AEM Forms

+ [Tjänsten Automated forms conversion](https://experienceleague.adobe.com/docs/aem-forms-automated-conversion-service/using/configure-service.html)


## Adobe Target

Adobe Target integreras med AEM as a Cloud Service för att leverera optimerad webbupplevelse för alla slutanvändare, som alla drivs av innehåll från AEM.

### AEM Sites

+ [Konfigurera Adobe Target-integrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-target.html)
+ Upplev fragment till mål

   + [Publicera Experience Fragments till Target](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-target.html)
   + [Publicera upplevelsefragment som JSON till mål](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-target.html)

+ [Använd AEM kontextnav med mål](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/personalization/audiences.html#creating-an-adobe-target-audience-using-the-audience-console)
+ [Självstudiekurs om AEM Sites och Target](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/target/overview.html)

## Adobe Workfront

Adobe Workfront integreringar med AEM är en Cloud Service som effektiviserar arbetet med att skapa digitala resurser, samarbeta och livscykelhantering.

### AEM Assets

+ [Konfigurera den utökade Workfront-kontakten](https://experienceleague.adobe.com/docs/experience-manager-learn/assets-essentials/workfront/configure.html)
+ [Workfront förbättrade anslutningsvideor](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/workfront/enhanced-connector/basics.html)
+ AEM Assets Essentials

   + [Användarhandbok för Adobe Workfront for Assets Essentials](https://one.workfront.com/s/document-item?bundleId=the-new-workfront-experience&amp;topicId=Content%2FDocuments%2FAdobe_Workfront_for_Experience_Manager_Assets_Essentials%2F_workfront-for-aem-asset-essentials.htm)
   + [Adobe Workfront och Assets Essentials](https://experienceleague.adobe.com/docs/experience-manager-learn/assets-essentials/workfront/configure.html)
