---
title: Kapitel 1 - Självstudiekurser - Konfigurera och hämta
seo-title: Komma igång med AEM Content Services - Kapitel 1 - Komma igång med självstudiekurser
description: Kapitel 1 i självstudiekursen AEM Headless. Baslinjeinställningen för den AEM instansen av självstudiekursen.
seo-description: Kapitel 1 i självstudiekursen AEM Headless. Baslinjeinställningen för den AEM instansen av självstudiekursen.
translation-type: tm+mt
source-git-commit: ecbd4d21c5f41b2bc6db3b409767b767f00cc5d1
workflow-type: tm+mt
source-wordcount: '436'
ht-degree: 0%

---


# Inställning av självstudiekurs

Den senaste versionen av AEM och AEM WCM Core Components rekommenderas alltid.

* AEM 6.5 eller senare
* AEM WCM Core Components 2.4.0 eller senare
   * Ingår i [WKND Mobile AEM Application Content Package below](#wknd-mobile-application-packages)

Innan du startar den här självstudiekursen kontrollerar du att följande AEM [instanser är installerade och körs på din lokala dator](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/deploy.html#Default%20Local%20Install):

* **AEM** Authoron  **port 4502**
* **AEM** Publishon  **port 4503**

## WKND-mobilprogrampaket{#wknd-mobile-application-packages}

Installera följande AEM innehållspaket på **både** AEM Author och AEM Publish med [!DNL AEM Package Manager].

* [ui.apps: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.ui.apps-x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
   * [!DNL WKND Mobile Empty Template Type]
   * [!DNL WKND Mobile] Proxykomponent för AEM WCM-kärnkomponenter
   * [!DNL WKND Mobile] AEM Content Services pages&#39;CSS (for minor styling)
* [ui.content: GitHub > com.adobe.aem.guides.wknd-mobile.ui.content-x.x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
   * [!DNL WKND Mobile] Platsstruktur
   * [!DNL WKND Mobile] DAM-mappstruktur
   * [!DNL WKND Mobile] bildresurser

I [Kapitel 7](./chapter-7.md) kör vi [!DNL WKND Mobile] Android-mobilappen med [Android Studio](https://developer.android.com/studio) och det medföljande APK-paketet (Android-programpaket):

* [[!DNL Android Mobile App: GitHub > Assets > wknd-mobile.x.x.x.apk]](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## AEM

Den här uppsättningen innehållspaket skapar innehåll och konfiguration som beskrivs i det associerade kapitlet och alla föregående kapitel. Dessa paket är valfria men kan göra det lättare att skapa innehåll.

* [Kapitel 2 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-2.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 3 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 4 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 5 Innehåll: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## Källkod

Källkoden för både det AEM projektet och [!DNL Android Mobile App] är tillgänglig i [[!DNL AEM Guides - WKND Mobile GitHub Project]](https://github.com/adobe/aem-guides-wknd-mobile). Källkoden behöver inte byggas eller ändras för den här självstudiekursen, utan finns för att ge fullständig genomskinlighet i hur alla delar av självstudiekursen byggs.

Om du har problem med självstudiekursen eller koden lämnar du ett [GitHub-problem](https://github.com/adobe/aem-guides-wknd-mobile/issues).

## Hoppa till slutet

Om du vill gå till slutet av självstudiekursen kan du installera innehållspaketet [com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) på **både** AEM Author och AEM Publish. Observera att innehåll och konfiguration inte visas som de publicerats i AEM Author, men på grund av den manuella distributionen kommer allt nödvändigt innehåll och all nödvändig konfiguration att vara tillgänglig i AEM Publish så att [!DNL WKND Mobile App] kan komma åt innehållet.


## Nästa steg

* [Kapitel 2 - Definiera fragmentmodeller för händelseinnehåll](./chapter-2.md)
