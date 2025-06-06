---
title: Skapa frågegränssnitt
description: Multidelad självstudiekurs som visar hur du går igenom stegen för att fråga efter formuläröverföringar som lagras i Azure Portal
feature: Adaptive Forms
doc-type: Tutorial
version: Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
jira: kt-14884
last-substantial-update: 2024-03-03T00:00:00Z
exl-id: 570a8176-ecf8-4a57-ab58-97190214c53f
duration: 25
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
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
