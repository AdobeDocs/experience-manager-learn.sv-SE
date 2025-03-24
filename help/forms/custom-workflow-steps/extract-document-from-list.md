---
title: Extrahera dokument från en lista med dokument i ett AEM-arbetsflöde
description: Anpassad arbetsflödeskomponent som extraherar ett specifikt dokument från en lista med dokument
feature: Adaptive Forms
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
kt: kt-13918
last-substantial-update: 2023-09-12T00:00:00Z
exl-id: b0baac71-3074-49d5-9686-c9955b096abb
duration: 56
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '278'
ht-degree: 0%

---

# Extrahera dokument från en lista med dokument

Ett vanligt användningssätt är att skicka formulärdata och den bifogade blanketten till ett externt system med steget Anropa formulärdatamodell i ett AEM-arbetsflöde. Om du till exempel skapar ett ärende i ServiceNow vill du skicka in ärendeinformation med ett stöddokument. De bilagor som läggs till i det adaptiva formuläret lagras i en variabel av typen arraylist med dokument och för att extrahera ett specifikt dokument från den här arraylistan måste du skriva egen kod.

I den här artikeln får du hjälp med att använda den anpassade arbetsflödeskomponenten för att extrahera och lagra dokumentet i en dokumentvariabel.

## Skapa arbetsflöde

Ett arbetsflöde måste skapas för att kunna hantera formuläröverföringen. Arbetsflödet måste ha följande variabler definierade

* En variabel av typen ArrayList of Document (den här variabeln innehåller formulärbilagor som lagts till av användaren)
* En variabel av typen Dokument.(Den här variabeln innehåller dokumentet som extraherats från ArrayList)

* Lägg till den anpassade komponenten i arbetsflödet och konfigurera dess egenskaper
  ![extract-item-workflow](assets/extract-document-array-list.png)

## Konfigurera anpassat formulär

* Konfigurera skicka-åtgärden för det adaptiva formuläret för att utlösa AEM-arbetsflödet
  ![submit-action](assets/store-attachments.png)

## Testa lösningen

[Distribuera det anpassade paketet med OSGi-webbkonsolen](assets/ExtractItemsFromArray.core-1.0.0-SNAPSHOT.jar)

[Importera arbetsflödeskomponenten med pakethanteraren](assets/Extract-item-from-documents-list.zip)

[Importera exempelarbetsflödet](assets/extract-item-sample-workflow.zip)

[Importera det anpassningsbara formuläret](assets/test-attachment-extractions-adaptive-form.zip)

[Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/testattachmentsextractions/jcr:content?wcmmode=disabled)

Lägg till en bifogad fil i formuläret och skicka det.

>[!NOTE]
>
>Det extraherade dokumentet kan sedan användas i andra arbetsflödessteg som Skicka e-post eller Anropa FDM-steg
