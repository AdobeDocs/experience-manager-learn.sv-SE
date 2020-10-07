---
title: Vattenstämplar i AEM Assets
description: AEM som en Cloud Services vattenstämpelfunktioner gör att anpassade bildåtergivningar kan vattenstämplas med vilken PNG-bild som helst.
feature: watermark
topics: images
audience: all
doc-type: feature video
activity: use
version: cloud-service
kt: 6357
thumbnail: 41536.jpg
translation-type: tm+mt
source-git-commit: 10784dce34443adfa1fc6dc324242b1c021d2a17
workflow-type: tm+mt
source-wordcount: '58'
ht-degree: 0%

---


# Vattenstämplar

AEM som en Cloud Services vattenstämpelfunktioner gör att anpassade bildåtergivningar kan vattenstämplas med vilken PNG-bild som helst.

>[!VIDEO](https://video.tv.adobe.com/v/41536/?quality=12&learn=on)

## OSGi-konfiguration

Följande OSGi-konfigurationsstub kan uppdateras och läggas till i AEM projekt `ui.config` .

`/apps/example/osgiconfig/config.author/com.adobe.cq.assetcompute.impl.profile.WatermarkingProfileServiceImpl.cfg.json`

```json
{
    "watermark": "/content/dam/path/to/watermark.png",
     "scale": 1.0
}
```
