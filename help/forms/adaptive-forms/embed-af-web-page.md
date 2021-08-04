---
title: Bädda in adaptiva Forms/HTML5-formulär på webbsidor
description: Konfigurationssteg som behövs för att bädda in adaptiva Forms- eller HTML5-formulär på en icke-AEM webbsida.
feature: Adaptiv Forms
feature-set: Adaptive Forms
topics: development
audience: developer
doc-type: Tutorial
activity: implement
version: 6.4,6.5
topic: Administration
role: Admin
level: Beginner
kt: 8390
source-git-commit: 2fc4f748fd3b8f820d1451d08c5fe01d11892029
workflow-type: tm+mt
source-wordcount: '149'
ht-degree: 0%

---


# Bädda in anpassat formulär eller HTML5-formulär på webbsidan

Det inbäddade adaptiva formuläret fungerar fullt ut och användarna kan fylla i och skicka formuläret utan att behöva lämna sidan. Det hjälper användaren att stanna kvar i sitt sammanhang för andra element på webbsidan och interagera med formuläret samtidigt.

I följande video förklaras stegen som krävs för att bädda in ett adaptivt eller HTML5-formulär på en webbsida.
Läs [dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-64/forms/adaptive-forms-basic-authoring/embed-adaptive-form-external-web-page.html?lang=en) om du vill ha information om de bästa förutsättningarna, god praxis osv.
>[!VIDEO](https://video.tv.adobe.com/v/335893?quality=9&learn=on)

Du kan hämta exempelfilerna som används i videon [härifrån](assets/embedding-af-web-page.zip)

Följande kod används för att hämta det adaptiva formuläret och bädda in formuläret i behållaren som identifieras av klassnamnet **right**

```javascript
$(document).ready(function(){
  
	var formName = $( "#xfaform" ).val();
    $.get("http://localhost/content/dam/formsanddocuments/newslettersubscription/jcr:content?wcmmode=disabled", function(data, status){
	console.log(formName);
	$(".right").append(data);
      
    });
  
});
```














