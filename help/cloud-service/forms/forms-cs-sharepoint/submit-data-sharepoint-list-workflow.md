---
title: Skicka data till SharePoint-listan med hjälp av arbetsflödessteg
description: Infoga data i SharePoint-listan med hjälp av arbetsflödessteget invadera FDM
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
jira: KT-15126
source-git-commit: 3dc1aea74e2a7cf30da9f6fb96ecc5c7edcf6e34
workflow-type: tm+mt
source-wordcount: '245'
ht-degree: 0%

---

# Infoga data i SharePoint-listan med hjälp av arbetsflödessteget invecklad FDM


I den här artikeln beskrivs stegen som krävs för att infoga data i SharePoint-listan med hjälp av steget invoke FDM i AEM arbetsflöde.

Den här artikeln förutsätter att du har [anpassat formulär för att skicka data till SharePoint lista har konfigurerats.](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/forms/adaptive-forms-authoring/authoring-adaptive-forms-core-components/create-an-adaptive-form-on-forms-cs/configure-submit-actions-core-components.html?lang=en#connect-af-sharepoint-list)


## Skapa en formulärdatamodell baserad på SharePoint listdatakälla

* Skapa en ny formulärdatamodell baserad på SharePoint listdatakälla.
* Lägg till lämplig modell och få service för formulärdatamodellen.
* Konfigurera infogningstjänsten för att infoga modellobjektet på den översta nivån.
* Testa infogningstjänsten.


## Skapa ett arbetsflöde

* Skapa ett enkelt arbetsflöde med ett FDM-steg.
* Konfigurera steget invoke FDM för att använda formulärdatamodellen som skapades i föregående steg.
* ![associate-fdm](assets/fdm-insert-1.png)

* ![map-input-parameters](assets/fdm-insert-2.png)
* Observera användningen av JSON-punktnotation. De data som har skickats har formatet nedan och vi extraherar ContactUS-objektet från de data som har skickats.

```json
{
  "ContactUS": {
    "Title": "Mr",
    "Products": "Photoshop",
    "HighNetWorth": "1",
    "SubmitterName": "John Does"
  }
}
```



## Konfigurera anpassat formulär för att aktivera AEM arbetsflöde

* Skapa anpassat formulär med den formulärdatamodell som skapades i det tidigare steget.
* Dra och släpp fält från datakällan till formuläret.
* Konfigurera skicka-åtgärden för formuläret enligt nedan
* ![skicka-åtgärd](assets/configure-af.png)



## Testa formuläret

Förhandsgranska formuläret som skapades i föregående steg. Fyll i formuläret och skicka. Informationen i blanketten ska infogas i SharePoint-listan.

