---
title: Skicka e-post med SendGrid
description: Utlös ett e-postmeddelande med en länk till det sparade formuläret
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Experience Manager as a Cloud Service
topic: Integrations
jira: KT-8474
duration: 25
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '117'
ht-degree: 0%

---

# Skicka e-post

När formulärets data har sparats i Azure Blob Storage skickas ett e-postmeddelande med en länk till det sparade formuläret till användaren. Det här e-postmeddelandet skickas med SendGrid REST API.

Swagger-filen, formulärdatamodellen och den molntjänstkonfiguration som behövs för att skicka e-post tillhandahålls som en del av artikelresurserna.

Du måste skapa ett SendGrid-konto, en dynamisk mall som kan importera data som samlats in i det adaptiva formuläret.


Nedan följer kodfragmentet med HTML-kod som används i den dynamiska mallen. Värdet på parametern blobID skickas med hjälp av formulärdatamodellens anropstjänst.

```html
You can  <a href='https://forms.enablementadobe.com/content/dam/formsanddocuments/azureportalstorage/creditcardapplication/jcr:content?wcmmode=disabled&ampguid={{blobID}}'>access your application here</a> and complete it.
```


