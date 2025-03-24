---
title: Konfigurera resursmallar med AEM Assets och InDesign Server
description: Med hjälp av resursmallar kan marknadsförarna skapa, hantera och leverera digitala resurser för digitala och tryckta medier. Att skapa marknadsföringsbroschyrer, visitkort, flygblad, annonser och vykort är mycket enklare med tillgångsmallar när de integreras med InDesign-servern. Konfiguration av InDesign-server med AEM beskrivs i det här avsnittet.
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
feature: Templates
role: Developer
level: Intermediate
doc-type: Technical Video
exl-id: 5b764d86-8ced-46ed-838e-4bd2e75fd64c
duration: 428
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '153'
ht-degree: 0%

---

# Konfigurera resursmallar med AEM Assets och InDesign Server{#set-up-asset-templates-with-aem-assets-and-indesign-server}

Med hjälp av resursmallar kan marknadsförarna skapa, hantera och leverera digitala resurser för digitala och tryckta medier. Att skapa marknadsföringsbroschyrer, visitkort, flygblad, annonser och vykort är mycket enklare med tillgångsmallar när de integreras med InDesign-servern. Konfiguration av InDesign-server med AEM beskrivs i det här avsnittet.

>[!VIDEO](https://video.tv.adobe.com/v/17069?quality=12&learn=on)

>[!NOTE]
>
>AEM **måste** vara ansluten till en InDesign-server som körs när INDD-mallen överförs. En del av den inledande bearbetningen i INDD-filen kräver en InDesign-server.

## Ladda ned testversion av InDesign Server {#download-indesign-server-trial}

Hämta [InDesign Server webbplats för nedladdning av testversion](https://www.adobeprerelease.com/)

## Startar InDesign Server {#starting-indesign-server}

```shell
# macOS command

$ /Applications/Adobe\ InDesign\ CC\ Server\ 2017/InDesignServer -port 8080
```
