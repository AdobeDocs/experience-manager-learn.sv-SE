---
title: Extrahera svar från anpassad sändning
description: Extrahera anpassat svar när formulär skickas
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-13520
exl-id: e5f76d6a-2ea8-4909-9cfb-b673077cf8fd
duration: 16
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
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
