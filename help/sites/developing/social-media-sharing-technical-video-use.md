---
title: Använda delning av sociala medier i AEM Sites
description: Upptäck hur du konfigurerar och använder komponenten Delning i sociala medier.
feature: Core Components
version: 6.4, 6.5
topic: Content Management
role: Developer
level: Intermediate
doc-type: Technical Video
exl-id: 569069e8-7964-49f1-96ed-7dfa4f8ed96c
duration: 523
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '162'
ht-degree: 0%

---

# Använda delning av sociala medier {#using-social-media-sharing-in-aem-sites}

Upptäck hur du konfigurerar och använder komponenten Delning i sociala medier.

>[!VIDEO](https://video.tv.adobe.com/v/18897?quality=12&learn=on)

I den här videon utforskas följande funktioner i komponenten Delning i sociala medier (ingår i [AEM kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)) med [Vi.butik](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail#weretail) exempelwebbplats.

* 0:00 - Lägga till och konfigurera komponenten Delning i sociala medier
* 1:00 - Dela till Facebook
* 3:10 - Dela till Pinterest
* 6:25 - Använda komponenten Delning via sociala medier på en produktsida

## Inställningar för externalisering {#externalizer-setup}

![Day CQ Link Externalizer](assets/externalizer.png)

[http://localhost:4502/system/console/configMgr/com.day.cq.commons.impl.ExternalizerImpl](http://localhost:4502/system/console/configMgr/com.day.cq.commons.impl.ExternalizerImpl)

[AEM externalizer](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/externalizer.html) ska vara konfigurerat på både AEM författare och AEM publicering för att mappa publiceringsmiljön till den offentliga domän som används för att komma åt AEM publicering.

I den här videon använder vi `/etc/hosts` till spoof *www.example.com* för att lösa till localhost och använda [grundläggande AEM Dispatcher-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/getting-started/dispatcher-install.html) för att www.example.com ska kunna AEM publicera.

## Stödmaterial {#supporting-materials}

* [Ladda ned AEM kärnkomponenter](https://github.com/adobe/aem-core-wcm-components/releases)
* [Ladda ned webb.butik](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail/releases)
* [Installerar Dispatcher](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/getting-started/dispatcher-install.html)
