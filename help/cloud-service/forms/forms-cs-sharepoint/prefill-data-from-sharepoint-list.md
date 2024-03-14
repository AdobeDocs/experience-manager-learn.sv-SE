---
title: Fyll i anpassat formulär i förväg med data från SharePoint-lista
description: Lär dig fylla i anpassade formulär i förväg med hjälp av formulärdatamodell som backas upp av en lista med delpunkter
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
jira: KT-14795
duration: 60
exl-id: 9abe9f9d-8fb3-4e01-a830-1dad1c27274d
source-git-commit: 3dc1aea74e2a7cf30da9f6fb96ecc5c7edcf6e34
workflow-type: tm+mt
source-wordcount: '234'
ht-degree: 0%

---

# Fyll i anpassat formulär i förväg med data från Share Point List

I den tidigare versionen av AEM Form(6.5) behövde man skriva egen kod för att förifylla formulärdatamodellen med hjälp av attributet request. I AEM Forms som molntjänst behöver du inte längre skriva egen kod.

I den här artikeln beskrivs stegen som krävs för att förifylla/förifylla anpassningsbara formulär med data som hämtats från SharePoint lista med hjälp av förifyllningstjänsten för formulärdatamodellen.

Den här artikeln förutsätter att du har [anpassat formulär för att skicka data till SharePoint lista har konfigurerats.](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/forms/adaptive-forms-authoring/authoring-adaptive-forms-core-components/create-an-adaptive-form-on-forms-cs/configure-submit-actions-core-components.html?lang=en#connect-af-sharepoint-list)

Följande data finns i listan över SharePoint
![sharepoint-list](assets/list-data.png)

Om du vill förifylla ett anpassat formulär med data som är kopplade till en viss stödlinje måste du utföra följande steg:

## Konfigurera tjänsten get

* Skapa en get-tjänst för formulärets datamodell på den översta nivån med hjälp av attributet guid
  ![get-service](assets/mapping-request-attribute.png)

I den här skärmbilden är GUID-kolumnen bunden via ett request-attribut som kallas `submissionid`.

Den fullständigt konfigurerade get-tjänsten ser ut så här

![get-service](assets/fdm-request-attribute.png)

## Konfigurera det adaptiva formuläret så att det använder förifyllningstjänsten för formulärdatamodell

* Öppna ett adaptivt formulär baserat på datamodellen för delningspunktslistan. Koppla tjänsten för förifyllning av formulärdatamodell
  ![form-prefill-service](assets/form-prefill-service.png)

## Testa formuläret

Förhandsgranska formuläret genom att inkludera `submissionid` i den URL som visas nedan

```html
http://localhost:4502/content/dam/formsanddocuments/contactusform/jcr:content?wcmmode=disabled&submissionid=57e12249-751a-4a38-a81f-0a4422b24412
```
