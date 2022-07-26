---
title: AEM as a Cloud Service integreringar med Adobe Experience Cloud
description: Läs om AEM as a Cloud Service integreringar som stöds med andra Adobe Experience Cloud-produkter.
version: Cloud Service
feature: Integrations
topic: Integrations
role: Leader, Architect, Admin, Developer
level: Beginner
kt: 10718
thumbnail: KT-10718.jpeg
mini-toc-levels: 1
exl-id: 9e856dcc-f042-4e9d-bf97-dd4f72e837e3
source-git-commit: 4a902d838c99b3452581066ee568876ad16ec1a3
workflow-type: tm+mt
source-wordcount: '902'
ht-degree: 2%

---

# AEM as a Cloud Service integreringar med Adobe Experience Cloud

Läs om AEM as a Cloud Service integreringar som stöds med andra Adobe Experience Cloud-produkter.
Klicka på Experience Cloud för att få dokumentation om hur du konfigurerar och använder integreringarna.

|  | AEM Sites | AEM Assets | AEM Forms |
|-------------------------------------------------------------------|:---------:|:----------:|:---------:|
| [Acrobat Sign](#adobe-acrobat-sign) |  |  | ✔ |
| [Analyser](#adobe-analytics) | ✔ | ✔ | ✔ |
| Audience Manager |  |  |  |
| [Campaign Classic](#adobe-campaign-classic) | ✔ |  |  |
| Campaign Standard |  |  |  |
| [Handel](#adobe-commerce) | ✔ | ✔ |  |
| Customer Journey Analytics |  |  |  |
| [Experience Platform-taggar](#adobe-experience-platform-tags) | ✔ |  | ✔ |
| [Journey Optimizer](#adobe-journey-optimizer) |  | ✔ |  |
| Utbildningschef |  |  |  |
| Marketo Engage |  |  |  |
| CDP i realtid |  |  |  |
| [Sensei](#adobe-sensei) | ✔ | ✔ | ✔ |
| [Mål](#adobe-target) | ✔ |  |  |
| [Workfront](#adobe-workfront) |  | ✔ |  |


## Adobe Acrobat Sign

Adobe Acrobat Sign (tidigare Adobe Sign) möjliggör e-signaturarbetsflöden för AEM Forms adaptiva formulär genom att förbättra arbetsflödena för att bearbeta dokument inom juridik, försäljning, lön, HR och andra områden.

### AEM Forms

+ [Konfigurera Adobe Acrobat Sign-integrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/forms/adobe-sign-integration-adaptive-forms.html)
+ [AEM Forms och Adobe Acrobat Sign - självstudiekurs](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/forms-and-sign/introduction.html)

## Adobe Analytics

Adobe Analytics integrering med AEM as a Cloud Service gör att ni kan spåra innehållsaktivitet och analysera data var som helst under kundresan. Dessutom får du smidig rapportering, prediktiv information med mera.

### AEM Sites

+ [Konfigurera Adobe Analytics-integrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/integrations/integrating-adobe-analytics.html)
+ [Självstudiekurs om AEM Sites och Analytics](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/analytics/collect-data-analytics.html)
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

## Adobe Campaign Classic

Tack vare Adobe Campaign Classic integrering med AEM as a Cloud Service kan ni hantera e-postinnehåll och formulär direkt i Adobe Experience Manager, samtidigt som ni använder Adobe Campaign Classic för att personalisera och leverera e-postmeddelanden.

### AEM Sites

+ [Konfigurera Adobe Campaign Classic-integrering](https://experienceleague.adobe.com/docs/experience-manager-65/administering/integration/campaignonpremise.html)
   + __Dokumentationslänkar till AEM 6.5, men stegen är desamma på AEM as a Cloud Service__
+ [Integrera AEM Sites med Adobe Campaign Classic](https://github.com/adobe/aem-core-email-components/wiki/Integrating-AEM-with-ACC)
+ [Skicka e-post från AEM Sites med Adobe Campaign Classic](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/aem-adobe-campaign/campaign.html)
+ [Dokumentation AEM e-postkärnkomponenter](https://github.com/adobe/aem-core-email-components#aem-email-core-components)


## Adobe Commerce

Tack vare Adobe Commerce integrering med AEM as a Cloud Service kan varumärken skalas om och förnya snabbare för att särskilja handelsupplevelser och fånga upp ökade webbutgifter. AEM med Commerce kombinerar de engagerande, flerkanaliga och personaliserade upplevelserna i Experience Manager med valfritt antal handelslösningar för att ge alla delar av kundresan olika upplevelser, minska tiden till värde och öka konverteringsgraden.

### AEM Sites

+ [Användarhandbok för AEM och e-handel](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/content-and-commerce/home.html)


## Adobe Experience Platform-taggar

Adobe Experience Platform-taggar (tidigare Adobe Launch, DTM) integreras smidigt med AEM, vilket är ett enkelt sätt att driftsätta och hantera [analys](#adobe-analytics), [mål](#adobe-target)taggar för marknadsföring och annonsering krävs för engagerande kundupplevelser.

### AEM Sites

+ [Användarhandbok för Experience Platform-taggar](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html)
+ [Experience Platform taggar, genomgång](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html)

### AEM Forms

+ [Användarhandbok för Experience Platform-taggar](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html)
+ [Experience Platform taggar, genomgång](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html)


## Adobe Workfront

Adobe Workfront integreringar med AEM är en Cloud Service som effektiviserar arbetet med att skapa digitala resurser, samarbeta och livscykelhantering.

### AEM Assets

+ [Konfigurera den utökade Workfront-kontakten](https://experienceleague.adobe.com/docs/experience-manager-learn/assets-essentials/workfront/configure.html)
+ [Workfront förbättrade anslutningsvideor](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/workfront/enhanced-connector/basics.html)
+ AEM Assets Essentials

   + [Användarhandbok för Adobe Workfront for Assets Essentials](https://one.workfront.com/s/document-item?bundleId=the-new-workfront-experience&amp;topicId=Content%2FDocuments%2FAdobe_Workfront_for_Experience_Manager_Assets_Essentials%2F_workfront-for-aem-asset-essentials.htm)
   + [Adobe Workfront- och Assets Essentials-videor](https://experienceleague.adobe.com/docs/experience-manager-learn/assets-essentials/workfront/configure.html)

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
