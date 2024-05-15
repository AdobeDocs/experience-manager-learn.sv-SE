---
title: Ställ in resursmallar med AEM Assets och InDesign Server
description: Med hjälp av resursmallar kan marknadsförarna skapa, hantera och leverera digitala resurser för digitala och tryckta medier. Det är mycket enklare att skapa marknadsföringsbroschyrer, visitkort, flygblad, annonser och postkort med tillgångsmallar när de integreras med InDesignen. Konfiguration av InDesign server med AEM beskrivs i det här avsnittet.
version: 6.4, 6.5
topic: Content Management
feature: Templates
role: Developer
level: Intermediate
doc-type: Technical Video
exl-id: 5b764d86-8ced-46ed-838e-4bd2e75fd64c
duration: 428
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '153'
ht-degree: 0%

---

# Ställ in resursmallar med AEM Assets och InDesign Server{#set-up-asset-templates-with-aem-assets-and-indesign-server}

Med hjälp av resursmallar kan marknadsförarna skapa, hantera och leverera digitala resurser för digitala och tryckta medier. Det är mycket enklare att skapa marknadsföringsbroschyrer, visitkort, flygblad, annonser och postkort med tillgångsmallar när de integreras med InDesignen. Konfiguration av InDesign server med AEM beskrivs i det här avsnittet.

>[!VIDEO](https://video.tv.adobe.com/v/17069?quality=12&learn=on)

>[!NOTE]
>
>AEM **måste** anslutas till en InDesign som körs när INDD-mallen överförs. En del av den inledande bearbetningen i INDD-filen kräver en InDesign-server.

## Ladda ned testversion av InDesign Server {#download-indesign-server-trial}

Ladda ned [Ladda ned webbplats för testversioner av InDesigner Server](https://www.adobeprerelease.com/)

## Startar InDesign Server {#starting-indesign-server}

```shell
# macOS command

$ /Applications/Adobe\ InDesign\ CC\ Server\ 2017/InDesignServer -port 8080
```
