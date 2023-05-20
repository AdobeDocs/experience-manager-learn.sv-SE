---
title: Rapportera inskickade formulärdatafält med Adobe Analytics
description: Integrera AEM Forms CS med Adobe Analytics för att rapportera formulärdatafält
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
kt: 12557
exl-id: b9dc505d-72c8-4b6a-974b-fc619ff7c256
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '129'
ht-degree: 0%

---

# Skapa lämpliga dataelement

I taggegenskapen lade vi till två nya dataelement (ApplicantsStateOfResidence och validationError).

![adaptiv form](assets/data_elements.png)

## SökandeRegionVaraktighet

The **SökandeRegionVaraktighet** dataelement konfigurerades genom att markera **Core** i listrutan för tillägg och **Egen kod** för dataelementtypen enligt skärmbilden nedan
![sökande-stat-bosättning](assets/applicantstateofresidence.png)

Följande anpassade kod användes för att hämta värdet från **_läge_** adaptivt formulärfält.

```javascript
// use the GuideBridge API to access adaptive form elements
//The state field's SOM expression is used to access the state field
var ApplicantsStateOfResidence = guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].state[0]").value;
_satellite.logger.log(" Returning  Applicants State Of Residence is "+ApplicantsStateOfResidence);
return ApplicantsStateOfResidence;
```

## validationError

The **ValidationError** dataelement konfigurerades genom att markera **Core** i listrutan för tillägg och **Egen kod** för dataelementtypen enligt skärmbilden nedan

![validation-error](assets/validation-error.png)

Följande anpassade kod skrevs för att ställa in data-elementvärdet validationError.

```javascript
var validationError = "";
// Using GuideBridge API to access adaptive forms fields using the fields SOM expression
var tel = guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].telephone[0]");
var email = guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].email[0]");
_satellite.logger.log("Got tel in Tags custom script "+tel.isValid)
_satellite.logger.log("Got email in Tags custom script "+email.isValid)
if(tel.isValid == false)
{  
  validationError = "error: telephone number";
  _satellite.logger.log("Validation error is "+ validationError);
}

if(email.isValid == false)
{  
  validationError = "error: invalid email";
  _satellite.logger.log("Validation error is "+ validationError);
}

return validationError;
```
