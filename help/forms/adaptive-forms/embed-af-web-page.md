---
title: Bädda in adaptiva Forms/HTML5-formulär på webbsidor
description: Konfigurationssteg som behövs för att bädda in adaptiva Forms- eller HTML5-formulär på en icke-AEM-webbsida.
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-8390
exl-id: 068e38df-9c71-4f55-b6d6-e1486c29d0a9
last-substantial-update: 2020-06-09T00:00:00Z
duration: 398
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '138'
ht-degree: 0%

---

# Bädda in anpassat formulär eller HTML5-formulär på webbsidan

Det inbäddade adaptiva formuläret fungerar fullt ut och användarna kan fylla i och skicka formuläret utan att behöva lämna sidan. Det hjälper användaren att stanna kvar i sitt sammanhang för andra element på webbsidan och interagera med formuläret samtidigt.

I följande video förklaras stegen som krävs för att bädda in ett adaptivt eller HTML5-formulär på en webbsida.
Läs [dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-65/forms/adaptive-forms-basic-authoring/embed-adaptive-form-external-web-page.html?lang=sv-SE) för bästa möjliga förutsättningar, bästa praxis osv.
>[!VIDEO](https://video.tv.adobe.com/v/335893?quality=12&learn=on)

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
