---
title: Skapa innehållsanalys
description: Skapa JSON-delen som innehåller information om indataparametrarna för REST-anropet.
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: cloud-service
topic: utveckling
thumbnail: 331891.jpg
kt: 7192
translation-type: tm+mt
source-git-commit: dbc0a35ae96594fec1e10f411d57d2a3812c1cf2
workflow-type: tm+mt
source-wordcount: '47'
ht-degree: 0%

---

# contentAnalyserRequests

JSON-delen som innehåller information om indata, parametrar och utdata. Information om den här [formulärparametern finns här.](https://documentcloud.adobe.com/document-services/index.html#post-createPDF)

```java
package com.aemforms.doccloud.core.impl;

import com.google.gson.JsonObject;

public class GetContentAnalyser {
	public static String getContentAnalyserRequest(String fileName)
	{
		JsonObject outerWrapper = new JsonObject();
		
		
		JsonObject documentIn = new JsonObject();
		documentIn.addProperty("cpf:location", "InputFile0");
		System.out.println("The file name is "+fileName);
		if(fileName.endsWith(".docx"))
		{
			System.out.println("This is word document");
			documentIn.addProperty("dc:format","application/vnd.openxmlformats-officedocument.wordprocessingml.document");
		}
		if(fileName.endsWith(".xlsx"))
		{
			documentIn.addProperty("dc:format","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		}
		if(fileName.endsWith(".xml"))
		{
			documentIn.addProperty("dc:format","text/plain");
		}
		if(fileName.endsWith(".jpg"))
		{
			documentIn.addProperty("dc:format","image/jpeg");
		}

		JsonObject cpfinputs = new JsonObject();
		cpfinputs.add("documentIn", documentIn);
		
		
		//documentInWrapper.add("documentIn",documentIn);
		JsonObject cpfengine = new JsonObject();
		cpfengine.addProperty("repo:assetId", "urn:aaid:cpf:Service-1538ece812254acaac2a07799503a430");
		
		JsonObject documentOut = new JsonObject();
		
		documentOut.addProperty("cpf:location", "multipartLabelOut");
		documentOut.addProperty("dc:format", "application/pdf");
		JsonObject documentOutWrapper = new JsonObject();
		documentOutWrapper.add("documentOut",documentOut);
	
		outerWrapper.add("cpf:inputs",cpfinputs);
		outerWrapper.add("cpf:engine", cpfengine);
		outerWrapper.add("cpf:outputs", documentOutWrapper);
		System.out.println("The content Analyser is "+outerWrapper.toString());
		
		return outerWrapper.toString();
		
		
		
		
		
	}

}
```
