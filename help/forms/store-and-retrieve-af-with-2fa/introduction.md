---
title: Lagra och hämta formulärdata med bilagor från MySQL-databasen
description: Flera delars självstudiekurser som visar hur du lagrar och hämtar formulärdata med bilagor
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-6593
thumbnail: 327122.jpg
topic: Development
role: Developer
level: Experienced
exl-id: b278652f-6c09-4abc-b92e-20bfaf2e791a
last-substantial-update: 2020-11-07T00:00:00Z
duration: 148
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '212'
ht-degree: 0%

---

# Lagra och hämta adaptiva formulärdata med 2FA

I den här självstudiekursen får du hjälp med att spara och hämta adaptiva formulärdata med bilagor med hjälp av 2FA. I den här självstudien användes MySQL-databasen för att lagra data för adaptiva formulär. Databas kan användas för att lagra data så länge du har distribuerat databasspecifika drivrutiner i AEM. På en hög nivå krävs följande steg för att uppnå användningsfallet:

* Använd API:t för GuideBridge för att få åtkomst till data i det adaptiva formuläret

* Gör ett POST-anrop till en servlet. Den här servern lagrar data i databasen och formulärbilagor i CRX-databasen. De lagrade data i databasen är kopplade till ett GUID.

* När du vill fylla i det adaptiva formuläret med lagrade data hämtar du data som är kopplade till GUID och fyller i det adaptiva formuläret med metoden **request.setAttribute**.

## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/327122?quality=12&learn=on)

## Förutsättningar

Målgruppen för det här innehållet förväntas ha viss erfarenhet inom följande områden:

* Adaptiv form
* Formulärdatamodell
* OSGi-tjänster/komponenter
* AEM Client Libraries


## Nästa steg

[Konfigurera Data Source](./configure-data-source.md)