---
title: Använda delning av sociala medier i AEM Sites
description: Upptäck hur du konfigurerar och använder komponenten Delning i sociala medier.
feature: Core Components
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
role: Developer
level: Intermediate
doc-type: Technical Video
exl-id: 569069e8-7964-49f1-96ed-7dfa4f8ed96c
duration: 511
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '162'
ht-degree: 0%

---

# Använda delning av sociala medier {#using-social-media-sharing-in-aem-sites}

Upptäck hur du konfigurerar och använder komponenten Delning i sociala medier.

>[!VIDEO](https://video.tv.adobe.com/v/18897?quality=12&learn=on)

I den här videon utforskas följande funktioner i komponenten Delning i sociala medier (ingår i [AEM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)) med exempelwebbplatsen [We.Retail](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail#weretail) .

* 0:00 - Lägga till och konfigurera komponenten Delning i sociala medier
* 1:00 - Dela på Facebook
* 3:10 - Dela till Pinterest
* 6:25 - Använda komponenten Delning via sociala medier på en produktsida

## Inställningar för externalisering {#externalizer-setup}

![Dagens CQ Link Externalizer](assets/externalizer.png)

[http://localhost:4502/system/console/configMgr/com.day.cq.commons.impl.ExternalizerImpl](http://localhost:4502/system/console/configMgr/com.day.cq.commons.impl.ExternalizerImpl)

[AEM externalizer](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/externalizer.html) bör konfigureras på både AEM Author och AEM Publish för att mappa publiceringsläget till den offentliga domän som används för åtkomst till AEM Publish.

I den här videon använder vi `/etc/hosts` för att hitta *www.example.com* för att lösa problemet med localhost och använder en [grundläggande AEM Dispatcher-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/getting-started/dispatcher-install.html) för att tillåta www.example.com att publicera i AEM.

## Stödmaterial {#supporting-materials}

* [Hämta AEM Core-komponenterna](https://github.com/adobe/aem-core-wcm-components/releases)
* [Ladda ned We.Retail](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail/releases)
* [Installerar Dispatcher](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/getting-started/dispatcher-install.html)
