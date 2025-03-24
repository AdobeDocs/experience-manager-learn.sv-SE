---
title: Skapa innehållsanalys
description: Skapa JSON-delen som innehåller information om indataparametrarna för REST-anropet.
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
thumbnail: 7836.jpg
jira: KT-7836
exl-id: 548a21b9-5487-4b48-9782-19b537a48f98
duration: 23
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '55'
ht-degree: 0%

---

# Skapa analysförfrågningar

Skapa ett JSON-fragment som definierar:

+ input
+ parameters
+ utdata.

Information om den här [formulärparametern finns här.](https://documentcloud.adobe.com/document-services/index.html#post-createPDF)

Den exempelkod som visas nedan genererar JSON-fragmentet för alla Office 365-dokumenttyper.

```java
package com.aemforms.doccloud.core.impl;

import com.google.gson.JsonObject;

public class GetContentAnalyser {
	public static String getContentAnalyserRequest(String fileName)
	{
		JsonObject outerWrapper = new JsonObject();
		
		
		JsonObject documentIn = new JsonObject();
		documentIn.addProperty("cpf:location", "InputFile0");

		if(fileName.endsWith(".pptx"))
		{
			documentIn.addProperty("dc:format","application/vnd.openxmlformats-officedocument.presentationml.presentation");
		}

		if(fileName.endsWith(".docx"))
		{
			
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
