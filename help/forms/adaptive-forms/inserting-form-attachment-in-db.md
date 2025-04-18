---
title: Infoga formulärbilaga i databas
description: Infoga formulärbilagor i databasen med hjälp av AEM-arbetsflöde.
feature: Adaptive Forms
version: Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
jira: KT-10488
exl-id: e8a6cab8-423b-4a8e-b2b7-9b24ebe23834
last-substantial-update: 2020-06-09T00:00:00Z
duration: 82
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '351'
ht-degree: 0%

---

# Infoga formulärbilaga i databas

Den här artikeln går igenom hur du lagrar bifogade formulär i MySQL-databasen.

En vanlig fråga från kunderna är att lagra inhämtade formulärdata och den bifogade formulärfilen i en databastabell.
För att uppnå detta har följande steg utförts:

## Skapa databastabell för formulärdata och bilagor

En tabell som anropades när den skapades för att innehålla formulärdata. Lägg märke till kolumnnamnsbilden av typen **LONGBLOB** för att lagra den bifogade formulärfilen
![table-schema](assets/insert-picture-table.png)

## Skapa formulärdatamodell

En formulärdatamodell skapades för att kommunicera med MySQL-databasen. Du måste skapa följande

* [JDBC-datakälla i AEM](./data-integration-technical-video-setup.md)
* [Formulärdatamodell baserad på JDBC-datakällan](./jdbc-data-model-technical-video-use.md)

## Skapa arbetsflöde

Om du konfigurerar ditt adaptiva formulär så att det skickas till ett AEM-arbetsflöde kan du välja att spara formulärbilagorna i en arbetsflödesvariabel eller spara de bifogade filerna i en angiven mapp under nyttolasten. I det här fallet måste vi spara de bifogade filerna i en arbetsflödesvariabel av typen ArrayList of Document. Från denna ArrayList måste vi extrahera det första objektet och initiera en dokumentvariabel. Arbetsflödesvariablerna **listOfDocuments** och **employeePhoto** skapades.
När det adaptiva formuläret skickas för att utlösa arbetsflödet initierar ett steg i arbetsflödet variabeln employeePhoto med ECMA-skriptet. Följande är ECMA-skriptkoden

```javascript
log.info("executing script now...");
var metaDataMap = graniteWorkItem.getWorkflow().getWorkflowData().getMetaDataMap();
var listOfAttachments = [];
// Make sure you have a workflow variable caled listOfDocuments defined
listOfAttachments = metaDataMap.get("listOfDocuments");
log.info("$$$  got listOfAttachments");
//Make sure you have a workflow variable caled employeePhoto defined
var employeePhoto = listOfAttachments[0];
metaDataMap.put("employeePhoto", employeePhoto);
log.info("Employee Photo updated");
```

Nästa steg i arbetsflödet är att infoga data och den bifogade formuläret i tabellen med hjälp av tjänstkomponenten Anropa formulärdatamodell.
![insert-pic](assets/fdm-insert-pic.png)
[Det fullständiga arbetsflödet med exempelskriptet för eCHA kan hämtas här](assets/add-new-employee.zip).

>[!NOTE]
> Du måste skapa en ny JDBC-baserad formulärdatamodell och använda den formulärdatamodellen i arbetsflödet

## Skapa anpassat formulär

Skapa ett anpassat formulär baserat på formulärdatamodellen som skapades i det tidigare steget. Dra och släpp elementen i formulärdatamodellen i formuläret. Konfigurera formuläröverföringen för att utlösa arbetsflödet och ange följande egenskaper enligt skärmbilden nedan
![formulärbilagor](assets/form-attachments.png)
