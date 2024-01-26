---
title: Implementera funktioner för att spara och återuppta i ett anpassat formulär
description: Lär dig hur du lagrar och hämtar adaptiva formulärdata från Azure-lagringskontot.
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
jira: KT-13717
exl-id: b40b0ef4-efa9-400e-82d8-aa0c7feb7be4
duration: 36
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '151'
ht-degree: 0%

---

# Introduktion

I den här självstudiekursen implementerar vi ett enkelt exempel där de som fyller i formuläret kan spara och återuppta ifyllningsprocessen. Flödet för användningsexemplet är följande

* Användaren börjar fylla i ett anpassat formulär.
* Användaren sparar formuläret och vill fortsätta fylla i formuläret vid ett senare datum.
* Användaren får ett e-postmeddelande med en länk till det sparade formuläret.

## Krav

* Upplev AEM Forms CS, särskilt när det gäller att skapa formulärdatamodeller.
* Upplev hur man driftsätter kod med hjälp av molnhanteraren.
* Tillgång till en molnklar instans av AEM Forms CS.

För att implementera ovanstående användningsexempel i AEM Forms CS behöver du följande

* [AEM Forms CS cloud ready instance](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/intellij-and-aem-sync.html?lang=en#set-up-aem-author-instance)
* [Azure Portal-konto](https://portal.azure.com/)
* [SendGrid-konto](https://sendgrid.com/)

### Nästa steg

[Skapa sidkomponent](./page-component.md)
