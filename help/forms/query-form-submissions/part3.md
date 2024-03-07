---
title: Skapa frågegränssnitt
description: Multidelad självstudiekurs som visar hur du går igenom stegen för att fråga efter formuläröverföringar som lagras i Azure Portal
feature: Adaptive Forms
doc-type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Experienced
jira: kt-14884
last-substantial-update: 2024-03-03T00:00:00Z
source-git-commit: ae2a2cbde1bf21314cc77863014cb0f013b6e0bb
workflow-type: tm+mt
source-wordcount: '130'
ht-degree: 0%

---

# Skapa frågegränssnitt

Ett enkelt frågegränssnitt har skapats för att tillåta &quot;Administratör&quot; att ange sökvillkor för att kunna hämta in specifika formulärinskickade formulär. Resultatet visas sedan i ett enkelt tabellformat med alternativet att visa en viss formulärskickning.

![query-sending](assets/query-submissions.png)

Listrutorna i det här gränssnittet är listrutor med överlappande alternativ. De alternativ som är tillgängliga i listrutan ändras baserat på de val som gjordes i den föregående listrutan.

Listrutorna fylls i med RESTful-datakällor.

Sökresultaten visas i en anpassad komponent som kallas &quot;SearchResults&quot;. När användaren klickar på visningsknappen fylls formuläret i förväg med skickade data och bilagor.

## Nästa steg

[Skriv förifyllningstjänsten](./part4.md)
