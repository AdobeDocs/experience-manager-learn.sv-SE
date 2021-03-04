---
title: Variabler i AEM [del 4]
seo-title: Variabler i AEM [del 4]
description: Använda variabler av typen xml,json,arraylist,dokument i aem-arbetsflöde
seo-description: Använda variabler av typen xml,json,arraylist,dokument i aem-arbetsflöde
feature: Arbetsflöde
topics: development
audience: developer
doc-type: tutorial
activity: understand
version: 6.5
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '475'
ht-degree: 0%

---


# Variabeln ArrayList i AEM arbetsflöde

Variabler av typen ArrayList har introducerats i AEM Forms 6.5. Ett vanligt användningsexempel för ArrayList-variabeln är att definiera anpassade vägar som ska användas i AssignTask.

Om du vill använda variabeln ArrayList i ett AEM arbetsflöde måste du skapa ett adaptivt formulär som genererar upprepade element i skickade data. Ett vanligt tillvägagångssätt är att definiera ett schema som innehåller ett arrayelement. I den här artikeln har jag skapat ett enkelt JSON-schema som innehåller arrayelement. Användningsexemplet är att en anställd fyller i en utgiftsrapport. I utgiftsrapporten tar vi reda på vem som har skickat in inskickarens namn och chefens namn. Hanterarens namn lagras i en array som kallas hanterarkedja. På skärmbilden nedan visas utgiftsrapportformuläret och data från inskickandet av Adaptiv Forms.

![expensereport](assets/expensereport.jpg)

Nedan följer data från den adaptiva formuläröverföringen. Det adaptiva formuläret baserades på JSON-schema. De data som är bundna till schemat lagras under elementet data i afBoundData-elementet. Hanterkedjan är en array och vi måste fylla i ArrayList med objektets name-element inuti hanterarkedjearrayen.

```json
{
    "afData": {
        "afUnboundData": {
            "data": {
                "numericbox_2762582281554154833426": 700
            }
        },
        "afBoundData": {
            "data": {
                "Employee": {
                    "Name": "Conrad Simms",
                    "Department": "IT",
                    "managerchain": [{
                        "name": "Gloria Rios"
                    }, {
                        "name": "John Jacobs"
                    }]
                },
                "expense": [{
                    "description": "Hotel",
                    "amount": 300
                }, {
                    "description": "Air Fare",
                    "amount": 400
                }]
            }
        },
        "afSubmissionInfo": {
            "computedMetaInfo": {},
            "stateOverrides": {},
            "signers": {},
            "afPath": "/content/dam/formsanddocuments/helpx/travelexpensereport",
            "afSubmissionTime": "20190402102953"
            }
        }
}
```

Om du vill initiera ArrayList-variabeln för en deltypssträng kan du antingen använda JSON-punktnotationsläget eller XPath-mappningsläget. På följande skärmbild visas hur du fyller i en ArrayList-variabel som kallas CustomRoutes med JSON Dot Notation. Se till att du pekar på ett element i ett arrayobjekt så som visas på skärmbilden nedan. Vi fyller i CustomRoutes ArrayList med namnen på arrayobjektet managementChain.
ArrayList för CustomRoutes används sedan för att fylla i rutorna i komponenten AssignTask
![anpassade vägar](assets/arraylist.jpg)
När variabeln CustomRoutes ArrayList initieras med värden från skickade data fylls rutorna för komponenten AssignTask i med variabeln CustomRoutes. På skärmbilden nedan visas de anpassade vägarna i en AssignTask
![asingtask](assets/customactions.jpg)

Så här testar du arbetsflödet på datorn:

* Hämta och spara filen ArrayListVariable.zip i filsystemet
* [Importera zip-](assets/arraylistvariable.zip) filen med AEM Package Manager
* [Öppna formuläret TravelExpenseReport](http://localhost:4502/content/dam/formsanddocuments/helpx/travelexpensereport/jcr:content?wcmmode=disabled)
* Ange ett par utgifter och namnen på de två cheferna
* Tryck på skicka-knappen
* [Öppna din inkorg](http://localhost:4502/aem/inbox)
* En ny uppgift med namnet&quot;Tilldela till utgiftsadministratör&quot; ska visas
* Öppna formuläret som är associerat med uppgiften
* Du bör se två anpassade vägar med chefsnamnen
   [Utforska arbetsflödet ReviewExpenseReportWorkflow.](http://localhost:4502/editor.html/conf/global/settings/workflow/models/ReviewExpenseReport.html) I det här arbetsflödet används variabeln ArrayList, variabeln JSON-typ, regelredigeraren i komponenten Or-Split
