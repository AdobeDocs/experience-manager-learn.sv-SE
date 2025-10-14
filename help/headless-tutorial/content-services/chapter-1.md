---
title: Kapitel 1 - Ställa in och hämta självstudier - Innehållstjänster
description: Kapitel 1 i självstudiekursen AEM Headless. Baslinjeinställningen för den AEM instansen av självstudiekursen.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: f24a75f6-9062-498c-b782-7d9011aa0bcf
duration: 85
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '366'
ht-degree: 0%

---

# Ställa in självstudiekurs

Den senaste versionen av AEM och AEM WCM Core Components rekommenderas alltid.

* AEM 6.5 eller senare
* AEM WCM Core Components 2.4.0 eller senare
   * Ingår i innehållspaketet för [WKND-AEM &#x200B;](#wknd-mobile-application-packages) nedan

Innan du startar den här självstudiekursen kontrollerar du att följande AEM har [installerats och körs på din lokala dator](https://helpx.adobe.com/se/experience-manager/6-5/sites/deploying/using/deploy.html#Default%20Local%20Install):

* **AEM Författare** på **port 4502**
* **AEM Publish** på **port 4503**

## WKND Mobile-programpaket{#wknd-mobile-application-packages}

Installera följande AEM innehållspaket på **både** AEM författare och AEM Publish med [!DNL AEM Package Manager].

* [ui.apps: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.ui.apps-x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
   * [!DNL WKND Mobile Empty Template Type]
   * [!DNL WKND Mobile]-proxykomponent för AEM WCM-kärnkomponenter
   * [!DNL WKND Mobile] AEM Content Services-sidornas CSS (för mindre formatering)
* [ui.content: GitHub > com.adobe.aem.guides.wknd-mobile.ui.content-x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
   * [!DNL WKND Mobile] Platsstruktur
   * [!DNL WKND Mobile] DAM-mappstruktur
   * [!DNL WKND Mobile] bildresurser

I [Kapitel 7](./chapter-7.md) kör vi [!DNL WKND Mobile] Android-mobilappen med [Android Studio](https://developer.android.com/studio) och den medföljande APK-filen (Android Application Package):

* [[!DNL Android Mobile App: GitHub > Assets > wknd-mobile.x.x.x.apk]](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## Kapitel AEM innehållspaket

Den här uppsättningen innehållspaket skapar innehåll och konfiguration som beskrivs i det associerade kapitlet och alla föregående kapitel. Dessa paket är valfria men kan göra det lättare att skapa innehåll.

* [Kapitel 2 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-2.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 3 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 4 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 5 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## Source Code

Källkoden för både AEM och [!DNL Android Mobile App] är tillgänglig på [[!DNL AEM Guides - WKND Mobile GitHub Project]](https://github.com/adobe/aem-guides-wknd-mobile). Källkoden behöver inte byggas eller ändras för den här självstudiekursen, utan finns för att ge fullständig genomskinlighet i hur alla delar av självstudiekursen byggs.

Om du har problem med självstudiekursen eller koden lämnar du ett [GitHub-problem](https://github.com/adobe/aem-guides-wknd-mobile/issues).

## Hoppa till slutet

Om du vill gå till slutet av självstudiekursen kan innehållspaketet [com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) installeras på **både** AEM Author och AEM Publish. Observera att innehåll och konfiguration inte visas som publicerade i AEM författare, men på grund av den manuella distributionen är allt nödvändigt innehåll och konfiguration tillgängligt på AEM Publish, vilket ger [!DNL WKND Mobile App] åtkomst till innehållet.


## Nästa steg

* [Kapitel 2 - Definiera fragmentmodeller för händelseinnehåll](./chapter-2.md)
