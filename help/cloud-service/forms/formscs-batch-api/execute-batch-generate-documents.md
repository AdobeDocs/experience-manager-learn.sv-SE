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
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: 17f91f81-96d8-49d6-b1e3-53d8899695ae
duration: 219
source-git-commit: 426020f59c7103829b7b7b74acb0ddb7159b39fa
workflow-type: tm+mt
source-wordcount: '87'
ht-degree: 0%

---

# Kör gruppkonfiguration

Kör gruppen genom att göra en POST-förfrågan till följande API

```xml
<baseURL>/confi/<configName>/execution
```

Denna API förväntar sig ett tomt json-objekt som en parameter i begärandetexten.
Detta API returnerar en unik URL i svarshuvudet som identifieras av nyckeln **location**.
En GET-begäran till den här unika URL:en talar om batchkörningens status

I följande video visas hur batchkonfigurationen aktiveras

>[!VIDEO](https://video.tv.adobe.com/v/340242?quality=12&learn=on)
