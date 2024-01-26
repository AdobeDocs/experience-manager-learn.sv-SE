---
title: Skicka bilagor i ett e-postmeddelande
description: Extrahera och skicka bilagor i e-postmeddelanden med automatiserat arbetsflöde
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-11077
exl-id: 1be90d9b-3669-44a0-84fb-cbdec44074d8
duration: 393
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '72'
ht-degree: 0%

---

# Extrahera formulärbilagor från skickade formulärdata

Extrahera bilagor och skicka dem i ett e-postmeddelande i ett automatiserat arbetsflöde.
I följande video förklaras stegen som krävs för att skapa bilagor från skickade data.
>[!VIDEO](https://video.tv.adobe.com/v/3409017?quality=12&learn=on)

Följande är det bilageobjektschema som du behöver använda i JSON-schemasteget Parse

```json
{
    "type": "object",
    "properties": {
        "filename": {
            "type": "string"
        },
        "data": {
            "type": "string"
        },
        "contentType": {
            "type": "string"
        },
        "size": {
            "type": "integer"
        }
    }
}
```
