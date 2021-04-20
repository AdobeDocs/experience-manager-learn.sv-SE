---
title: Vattenstämplar i AEM Assets
description: AEM som en Cloud Services vattenstämpelfunktioner gör att anpassade bildåtergivningar kan vattenstämplas med vilken PNG-bild som helst.
feature: Asset Compute Microservices
version: cloud-service
kt: 6357
thumbnail: 41536.jpg
topic: Content Management
role: Developer
level: Intermediate
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '65'
ht-degree: 1%

---


# Vattenstämplar

AEM som en Cloud Services vattenstämpelfunktioner gör att anpassade bildåtergivningar kan vattenstämplas med vilken PNG-bild som helst.

>[!VIDEO](https://video.tv.adobe.com/v/41536/?quality=12&learn=on)

## OSGi-konfiguration

Följande OSGi-konfigurationsstub kan uppdateras och läggas till i ditt AEM `ui.config`-projekt.

`/apps/example/osgiconfig/config.author/com.adobe.cq.assetcompute.impl.profile.WatermarkingProfileServiceImpl.cfg.json`

```json
{
    "watermark": "/content/dam/path/to/watermark.png",
     "scale": 1.0
}
```
