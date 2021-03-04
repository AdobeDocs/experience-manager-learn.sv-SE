---
title: Lagra och hämta formulärdata från MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '169'
ht-degree: 1%

---


# Lagra och hämta adaptiva formulärdata från MySQL-databasen

I den här självstudiekursen får du hjälp med att spara och hämta anpassade formulärdata från databasen. I den här självstudien användes MySQL-databasen för att lagra data för adaptiva formulär. Du kan använda valfri databas för att lagra data så länge du har distribuerat databasspecifika drivrutiner i AEM. På en hög nivå krävs följande steg för att uppnå användningsfallet:

* Använd API:t för GuideBridge för att få åtkomst till data i det adaptiva formuläret

* Ring en POST till en servett. Den här servern lagrar data i databasen. De lagrade data är associerade med ett GUID

* När du vill fylla i det adaptiva formuläret med lagrade data hämtar du data som är kopplade till GUID och fyller i det adaptiva formuläret med metoden **request.setAttribute**.

## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/27829?quality=9&learn=on)
