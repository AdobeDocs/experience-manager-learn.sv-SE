---
title: Lagra och hämta formulärdata från MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptiv Forms
type: Tutorial
version: 6.3,6.4,6.5
topic: Utveckling
role: Developer
level: Experienced
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '167'
ht-degree: 0%

---


# Lagra och hämta adaptiva formulärdata från MySQL-databasen

I den här självstudiekursen får du hjälp med att spara och hämta anpassade formulärdata från databasen. I den här självstudien användes MySQL-databasen för att lagra data för adaptiva formulär. Du kan använda valfri databas för att lagra data så länge du har distribuerat databasspecifika drivrutiner i AEM. På en hög nivå krävs följande steg för att uppnå användningsfallet:

* Använd API:t för GuideBridge för att få åtkomst till data i det adaptiva formuläret

* Ring en POST till en servett. Den här servern lagrar data i databasen. De lagrade data är associerade med ett GUID

* När du vill fylla i det adaptiva formuläret med lagrade data hämtar du data som är kopplade till GUID och fyller i det adaptiva formuläret med metoden **request.setAttribute**.

## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/27829?quality=9&learn=on)
