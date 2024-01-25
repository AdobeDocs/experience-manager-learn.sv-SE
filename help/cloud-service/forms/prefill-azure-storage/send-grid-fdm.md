---
title: Skicka e-post med SendGrid
description: Utlös ett e-postmeddelande med en länk till det sparade formuläret
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
jira: KT-13717
exl-id: 4b2d1e50-9fa1-4934-820b-7dae984cee00
duration: 40
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '183'
ht-degree: 0%

---

# Integrera med SendGrid

AEM Forms dataintegrering gör det möjligt att konfigurera och ansluta olika datakällor till AEM Forms. Det ger ett intuitivt användargränssnitt för att skapa ett enhetligt datarepresentationsschema för affärsenheter och tjänster över anslutna datakällor.

Vi har använt SendGrid API för att skicka e-postmeddelanden med hjälp av en dynamisk mall. Du måste känna till API:t för SendGrid för att skicka e-post med dynamiska mallar. Du har fått en swagger-fil som beskriver till API som en del av den här kursen.

## Skapa integreringen

Följ de här stegen för att skapa integreringen mellan AEM Forms och SendGrid

* Skapa en RESTful-datakälla med [swagger-fil](./assets/SendGridWithDynamicTemplate.yaml). [Följ den här videon för detaljerade anvisningar](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html) om att skapa datakällor i AEM Forms
* Skapa formulärdatamodell baserat på den datakälla som skapades i det tidigare steget.[Följ den detaljerade dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/forms/integrate/use-form-data-model/create-form-data-models.html) när formulärdatamodellen skapas.

Den formulärdatamodell som skapats för den här självstudiekursen ingår som en del av artikelresurserna.

### Nästa steg

[Skapa Azure Storage-integrering](./create-fdm.md)
