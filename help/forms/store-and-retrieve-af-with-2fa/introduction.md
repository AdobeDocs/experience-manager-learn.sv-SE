---
title: Lagra och hämta formulärdata med bilagor från MySQL-databasen
description: Flera delars självstudiekurser som visar hur du lagrar och hämtar formulärdata med bilagor
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6593
thumbnail: 327122.jpg
translation-type: tm+mt
source-git-commit: 9d4e864f42fa6c0b2f9b895257db03311269ce2e
workflow-type: tm+mt
source-wordcount: '207'
ht-degree: 0%

---


# Lagra och hämta adaptiva formulärdata med 2FA

I den här självstudiekursen får du hjälp med att spara och hämta adaptiva formulärdata med bilagor med hjälp av 2FA. I den här självstudien användes MySQL-databasen för att lagra data för adaptiva formulär. Du kan använda valfri databas för att lagra data så länge du har distribuerat databasspecifika drivrutiner i AEM. På en hög nivå krävs följande steg för att uppnå användningsfallet:

* Använd API:t för GuideBridge för att få åtkomst till data i det adaptiva formuläret

* Ring en POST till en servett. Den här servern lagrar data i databasen och formulärbilagor i CRX-databasen. De lagrade data i databasen är kopplade till ett GUID.

* När du vill fylla i det adaptiva formuläret med lagrade data hämtar du data som är kopplade till GUID och fyller i det adaptiva formuläret med metoden **request.setAttribute** .

## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/327122?quality=9&learn=on)

## Förutsättningar

Målgruppen för det här innehållet förväntas ha viss erfarenhet inom följande områden:

* Adaptiv form
* Formulärdatamodell
* OSGi-tjänster/komponenter
* AEM Client Libraries
