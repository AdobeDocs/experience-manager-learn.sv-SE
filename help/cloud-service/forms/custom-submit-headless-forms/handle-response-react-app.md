---
title: Extrahera svar från anpassad sändning
description: Extrahera anpassat svar när formulär skickas
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
kt: 13520
source-git-commit: 2dceb4dd4ee1079c100c9cbca94332d61d17ef57
workflow-type: tm+mt
source-wordcount: '51'
ht-degree: 0%

---


# Extrahera json-objektet från svaret

När du skickar ett headless adaptivt formulär till en anpassad överföringshanterare kan data som returneras av överföringshanteraren extraheras och visas i din svarsapp. Följande kodfragment visar

```javascript
// associate event handler for the onSubmitSuccess event
<AdaptiveForm mappings={extendMappings} onSubmitSuccess={onSuccess} formJson={selectedForm}/>
```

```javascript
// extract the json returned by the custom submit service
const onSuccess=(action) =>{
        let body = action.payload?.body;
        let FirstName = JSON.parse(body.metadata.json).firstName;
        setThankYouMessage(FirstName+" your request has been received");
        
      }
```











