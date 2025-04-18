---
title: Lagra och hämta formulärdata från introduktionen till MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
exl-id: 95795102-4278-4556-8e0f-1b8a359ab093
last-substantial-update: 2019-07-07T00:00:00Z
duration: 236
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '165'
ht-degree: 0%

---

# Lagra och hämta adaptiva formulärdata från MySQL-databasen

I den här självstudiekursen får du hjälp med att spara och hämta anpassade formulärdata från databasen. I den här självstudien användes MySQL-databasen för att lagra data för adaptiva formulär. Databas kan användas för att lagra data så länge du har distribuerat databasspecifika drivrutiner i AEM. På en hög nivå krävs följande steg för att uppnå användningsfallet:

* Använd API:t för GuideBridge för att få åtkomst till data i det adaptiva formuläret

* Gör ett POST-anrop till en servlet. Den här servern lagrar data i databasen. De lagrade data är associerade med ett GUID

* När du vill fylla i det adaptiva formuläret med lagrade data hämtar du data som är kopplade till GUID och fyller i det adaptiva formuläret med metoden **request.setAttribute**.

## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/27829?quality=12&learn=on)


