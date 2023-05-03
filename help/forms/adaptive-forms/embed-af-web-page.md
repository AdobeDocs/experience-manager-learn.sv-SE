---
title: Bädda in adaptiva Forms/HTML 5-formulär på webbsidor
description: Konfigurationssteg som behövs för att bädda in adaptiva Forms- eller HTML 5-formulär på en icke-AEM webbsida.
feature: Adaptive Forms
type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: 8390
exl-id: 068e38df-9c71-4f55-b6d6-e1486c29d0a9
last-substantial-update: 2020-06-09T00:00:00Z
source-git-commit: 53af8fbc20ff21abf8778bbc165b5ec7fbdf8c8f
workflow-type: tm+mt
source-wordcount: '144'
ht-degree: 0%

---

# Bädda in anpassat formulär eller HTML5-formulär på webbsidan

Det inbäddade adaptiva formuläret fungerar fullt ut och användarna kan fylla i och skicka formuläret utan att behöva lämna sidan. Det hjälper användaren att stanna kvar i sitt sammanhang för andra element på webbsidan och interagera med formuläret samtidigt.

I följande video förklaras stegen som krävs för att bädda in ett adaptivt eller HTML5-formulär på en webbsida.
Se [dokumentation](https://experienceleague.adobe.com/docs/experience-manager-65/forms/adaptive-forms-basic-authoring/embed-adaptive-form-external-web-page.html) för bästa förutsättningar, bästa praxis osv.
>[!VIDEO](https://video.tv.adobe.com/v/335893?quality=12&learn=on)

Du kan hämta exempelfilerna som används i videon [härifrån](assets/embedding-af-web-page.zip)

Följande kod används för att hämta det adaptiva formuläret och bädda in formuläret i behållaren som identifieras av klassnamnet **höger**

```javascript
$(document).ready(function(){
  
    var formName = $( "#xfaform" ).val();
    $.get("http://localhost/content/dam/formsanddocuments/newslettersubscription/jcr:content?wcmmode=disabled", function(data, status){
    console.log(formName);
    $(".right").append(data);
      
    });
  
});
```
