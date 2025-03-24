---
title: Anpassa anteckningar i AEM Assets
description: AEM Assets format och format för utdata till PDF kan konfigureras av AEM-utvecklare.
feature: Collaboration
version: Experience Manager 6.4, Experience Manager 6.5
topic: Collaboration
role: Developer
level: Intermediate
last-substantial-update: 2022-06-03T00:00:00Z
doc-type: Feature Video
exl-id: 972737dd-8ca6-47b4-a4ec-b73355c09cec
duration: 13
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '60'
ht-degree: 0%

---

# Anpassa anteckningar i AEM Assets{#using-annotations-in-aem-assets}

AEM stöder anpassning av anteckningens utdata till PDF.

## PDF anteckningssling:OsgiConfig-definition

Om du vill anpassa PDF-anteckningar skapar du en **sling:OsgiConfig** -nod i ditt AEM-projekt under

`/apps/my-project/config.author/com.day.cq.dam.core.impl.annotation.pdf.AnnotationPdfConfig.xml` och justera värdena efter behov:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
    jcr:primaryType="sling:OsgiConfig"

    cq.dam.config.annotation.pdf.document.padding.vertical="{Long}20"
    cq.dam.config.annotation.pdf.reviewStatus.color.changesRequested="fad269"
    cq.dam.config.annotation.pdf.document.height="{Long}792"
    cq.dam.config.annotation.pdf.document.width="{Long}612"
    cq.dam.config.annotation.pdf.reviewStatus.width="{Long}150"
    cq.dam.config.annotation.pdf.font.size="{Long}7"
    cq.dam.config.annotation.pdf.font.color="3B3B3B"
    cq.dam.config.annotation.pdf.font.light="A4A4A4"
    cq.dam.config.annotation.pdf.reviewStatus.color.rejected="fa7d73"
    cq.dam.config.annotation.pdf.minImageHeight="{Long}100"
    cq.dam.config.annotation.pdf.reviewStatus.color.approved="009933"
    cq.dam.config.annotation.pdf.marginTextImage="{Long}14"
    cq.dam.config.annotation.pdf.document.padding.horizontal="{Long}20"
    cq.dam.config.annotation.pdf.annotationMarker.width="{Long}5"
    />
```
