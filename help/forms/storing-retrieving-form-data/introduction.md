---
title: Lagra och hämta formulärdata från introduktionen till MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptive Forms
type: Tutorial
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: 95795102-4278-4556-8e0f-1b8a359ab093
source-git-commit: 307ed6cd25d5be1e54145406b206a78ec878d548
workflow-type: tm+mt
source-wordcount: '165'
ht-degree: 0%

---

# Lagra och hämta adaptiva formulärdata från MySQL-databasen

I den här självstudiekursen får du hjälp med att spara och hämta anpassade formulärdata från databasen. I den här självstudien användes MySQL-databasen för att lagra data för adaptiva formulär. Du kan använda valfri databas för att lagra data så länge du har distribuerat databasspecifika drivrutiner i AEM. På en hög nivå krävs följande steg för att uppnå användningsfallet:

* Använd API:t för GuideBridge för att få åtkomst till data i det adaptiva formuläret

* Ring en POST till en servett. Den här servern lagrar data i databasen. De lagrade data är associerade med ett GUID

* När du vill fylla i det adaptiva formuläret med lagrade data hämtar du data som är kopplade till GUID och fyller i det adaptiva formuläret med hjälp av **request.setAttribute** -metod.

## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/27829?quality=9&learn=on)
