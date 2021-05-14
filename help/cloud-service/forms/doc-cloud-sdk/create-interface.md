---
title: Skapa tjänstgränssnitt
description: Definiera de metoder i gränssnittet som du vill visa
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: cloud-service
topic: utveckling
thumbnail: 7825.jpg
kt: 7825
source-git-commit: 84499d5a7c8adac87196f08c6328e8cb428c0130
workflow-type: tm+mt
source-wordcount: '24'
ht-degree: 0%

---

# Gränssnitt

Skapa ett gränssnitt med följande två metoddefinitioner.

```java
package com.aemforms.doccloud.core;

import java.io.InputStream;

import com.adobe.aemfd.docmanager.Document;

public interface DocumentCloudSDKService {
	
	public Document getPDF(String location,String accessToken,String fileName);
	public Document createPDFFromInputStream(InputStream is,String fileName);

}


}
```
