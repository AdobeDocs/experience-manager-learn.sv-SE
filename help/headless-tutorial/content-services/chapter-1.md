---
title: Kapitel 1 - Ställa in och hämta självstudier - Innehållstjänster
description: Kapitel 1 i självstudiekursen AEM Headless. Baslinjeinställningen för den AEM instansen av självstudiekursen.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: f24a75f6-9062-498c-b782-7d9011aa0bcf
duration: 110
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '366'
ht-degree: 0%

---

# Ställa in självstudiekurs

Den senaste versionen av AEM och AEM WCM Core Components rekommenderas alltid.

* AEM 6.5 eller senare
* AEM WCM Core Components 2.4.0 eller senare
   * Ingår i [WKND Mobile AEM Application Content Package below](#wknd-mobile-application-packages)

Innan du startar den här självstudiekursen bör du kontrollera att följande AEM förekomster [installerat och körs på din lokala dator](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/deploy.html#Default%20Local%20Install):

* **AEM** på **port 4502**
* **AEM Publish** på **port 4503**

## WKND Mobile-programpaket{#wknd-mobile-application-packages}

Installera följande AEM i **båda** AEM författare och AEM publicera, använda [!DNL AEM Package Manager].

* [ui.apps: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.ui.apps-x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
   * [!DNL WKND Mobile Empty Template Type]
   * [!DNL WKND Mobile] Proxykomponent för AEM WCM-kärnkomponenter
   * [!DNL WKND Mobile] AEM Content Services pages&#39;CSS (for minor styling)
* [ui.content: GitHub > com.adobe.aem.guides.wknd-mobile.ui.content-x.x.x.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
   * [!DNL WKND Mobile] Platsstruktur
   * [!DNL WKND Mobile] DAM-mappstruktur
   * [!DNL WKND Mobile] bildresurser

I [Kapitel 7](./chapter-7.md) vi ska köra [!DNL WKND Mobile] Android-mobilapp som använder [Android Studio](https://developer.android.com/studio) och det medföljande APK-paketet (Android-programpaket):

* [[!DNL Android Mobile App: GitHub > Assets > wknd-mobile.x.x.x.apk]](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## Kapitel AEM innehållspaket

Den här uppsättningen innehållspaket skapar innehåll och konfiguration som beskrivs i det associerade kapitlet och alla föregående kapitel. Dessa paket är valfria men kan göra det lättare att skapa innehåll.

* [Kapitel 2 Innehåll: GitHub > Resurser > com.adobe.aem.guides.wknd-mobile.content.chapter-2.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 3 Innehåll: GitHub > Resurser > com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 4 Innehåll: GitHub > Resurser > com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
* [Kapitel 5 Innehåll: GitHub > Resurser > com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

## Källkod

Källkoden för både AEM och [!DNL Android Mobile App] finns på [[!DNL AEM Guides - WKND Mobile GitHub Project]](https://github.com/adobe/aem-guides-wknd-mobile). Källkoden behöver inte byggas eller ändras för den här självstudiekursen, utan finns för att ge fullständig genomskinlighet i hur alla delar av självstudiekursen byggs.

Om du har problem med självstudiekursen eller koden kan du lämna en [GitHub-problem](https://github.com/adobe/aem-guides-wknd-mobile/issues).

## Hoppa till slutet

Om du vill gå till slutet av självstudiekursen går du till [com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) innehållspaketet kan installeras på **båda** AEM Författare och AEM Publicera. Observera att innehåll och konfiguration inte visas som de publicerats i AEM Author, men på grund av manuell distribution är allt innehåll och all konfiguration som krävs tillgängligt i AEM Publish, vilket innebär att [!DNL WKND Mobile App] för att komma åt innehållet.


## Nästa steg

* [Kapitel 2 - Definiera fragmentmodeller för händelseinnehåll](./chapter-2.md)
