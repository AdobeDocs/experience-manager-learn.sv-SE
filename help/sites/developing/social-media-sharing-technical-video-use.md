---
title: Använda delning av sociala medier i AEM Sites
description: Upptäck hur du konfigurerar och använder komponenten Delning i sociala medier.
feature: core-components
topics: integrations
audience: developer, implementer
doc-type: technical video
activity: setup
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 67ca08bf386a217807da3755d46abed225050d02
workflow-type: tm+mt
source-wordcount: '209'
ht-degree: 3%

---


# Använda delning av sociala medier {#using-social-media-sharing-in-aem-sites}

Upptäck hur du konfigurerar och använder komponenten Delning i sociala medier.

>[!VIDEO](https://video.tv.adobe.com/v/18897/?quality=9&learn=on)

I den här videon utforskas följande funktioner i Social Media Sharing-komponenten (ingår i [AEM Core Components](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html)) med exempelwebbplatsen [We.Retail](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail#weretail).

* 0:00 - Lägga till och konfigurera komponenten Delning i sociala medier
* 1:00 - Dela på Facebook
* 3:10 - Dela till Pinterest
* 6:25 - Använda komponenten Delning via sociala medier på en produktsida

## Inställningar för externalisering {#externalizer-setup}

![Day CQ Link Externalizer](assets/externalizer.png)

[http://localhost:4502/system/console/configMgr/com.day.cq.commons.impl.ExternalizerImpl](http://localhost:4502/system/console/configMgr/com.day.cq.commons.impl.ExternalizerImpl)

[AEM ](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/externalizer.html) externalizer bör konfigureras på både AEM Author och AEM Publish för att mappa publiceringsläget till den offentliga domän som används för åtkomst till AEM Publish.

I den här videon använder vi `/etc/hosts` för att hitta *www.example.com* för att matcha till localhost, och använder en [grundläggande AEM Dispatcher-konfiguration](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/getting-started/dispatcher-install.html) för att tillåta www.example.com till AEM-publicering framför.

## Stödmaterial {#supporting-materials}

* [Ladda ned AEM kärnkomponenter](https://github.com/adobe/aem-core-wcm-components/releases)
* [Ladda ned webb.butik](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail/releases)
* [Installerar Dispatcher](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/getting-started/dispatcher-install.html)
