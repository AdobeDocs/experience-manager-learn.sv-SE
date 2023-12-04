---
title: Kör batchkonfigurationen
description: Starta dokumentgenereringsprocessen genom att köra batchen
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Output Service
topic: Development
jira: KT-9674
exl-id: 17f91f81-96d8-49d6-b1e3-53d8899695ae
duration: 233
source-git-commit: af928e60410022f12207082467d3bd9b818af59d
workflow-type: tm+mt
source-wordcount: '81'
ht-degree: 0%

---

# Kör gruppkonfiguration

Kör gruppen genom att göra en POST-förfrågan till följande API

```xml
<baseURL>/confi/<configName>/execution
```

Denna API förväntar sig ett tomt json-objekt som en parameter i begärandetexten.
Detta API returnerar en unik URL i svarshuvudet som identifieras av **plats** -tangenten.
En GET-begäran till den här unika URL:en talar om batchkörningens status

I följande video visas hur batchkonfigurationen aktiveras

>[!VIDEO](https://video.tv.adobe.com/v/340242?quality=12&learn=on)
