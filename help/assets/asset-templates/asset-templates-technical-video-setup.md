---
title: Konfigurera resursmallar med AEM Assets och InDesign Server
description: Med hjälp av resursmallar kan marknadsförarna skapa, hantera och leverera digitala resurser för digitala och tryckta medier. Det är mycket enklare att skapa marknadsföringsbroschyrer, visitkort, flygblad, annonser och postkort med tillgångsmallar när de integreras med InDesign-servern. Konfiguration av InDesign-server med AEM beskrivs i det här avsnittet.
version: 6.3, 6.4, 6.5
topic: Innehållshantering
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '161'
ht-degree: 0%

---


# Ställ in resursmallar med AEM Assets och InDesign Server{#set-up-asset-templates-with-aem-assets-and-indesign-server}

Med hjälp av resursmallar kan marknadsförarna skapa, hantera och leverera digitala resurser för digitala och tryckta medier. Det är mycket enklare att skapa marknadsföringsbroschyrer, visitkort, flygblad, annonser och postkort med tillgångsmallar när de integreras med InDesign-servern. Konfiguration av InDesign-server med AEM beskrivs i det här avsnittet.

>[!VIDEO](https://video.tv.adobe.com/v/17069/?quality=9&learn=on)

>[!NOTE]
>
>AEM **måste** vara ansluten till en InDesign-server som körs när INDD-mallen överförs. En del av den inledande bearbetningen i INDD-filen kräver InDesign-servern.

## Hämta testversionen av InDesign Server {#download-indesign-server-trial}

Hämta [InDesign Server webbplats för nedladdning av testversion](https://www.adobe.com/devnet/indesign/indesign-server-trial-downloads.html)

## Startar InDesign Server {#starting-indesign-server}

```shell
# macOS command

$ /Applications/Adobe\ InDesign\ CC\ Server\ 2017/InDesignServer -port 8080
```
