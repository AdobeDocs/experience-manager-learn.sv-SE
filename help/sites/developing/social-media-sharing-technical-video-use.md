---
title: Använda delning av sociala medier i AEM Sites
description: Upptäck hur du konfigurerar och använder komponenten Delning i sociala medier.
feature: Core Components
topics: integrations
audience: developer, implementer
doc-type: technical video
activity: setup
version: 6.4, 6.5
topic: Content Management
role: Developer
level: Intermediate
exl-id: 569069e8-7964-49f1-96ed-7dfa4f8ed96c
source-git-commit: b3e9251bdb18a008be95c1fa9e5c79252a74fc98
workflow-type: tm+mt
source-wordcount: '203'
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

[AEM externalizer](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/externalizer.html) bör konfigureras på både AEM Author och AEM Publish för att mappa publiceringsmiljön till den allmänt tillgängliga domän som används för åtkomst till AEM Publish.

I den här videon använder vi `/etc/hosts` till spoof *www.example.com* för att lösa till localhost och använda [grundläggande AEM Dispatcher-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/getting-started/dispatcher-install.html) så att www.example.com kan användas framför AEM Publish.

## Stödmaterial {#supporting-materials}

* [Ladda ned AEM kärnkomponenter](https://github.com/adobe/aem-core-wcm-components/releases)
* [Ladda ned webb.butik](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail/releases)
* [Installerar Dispatcher](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/getting-started/dispatcher-install.html)
