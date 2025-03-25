---
title: Skapa en komponent för att lista formulärdata
description: Självstudiekurs för att skapa en sammanfattningskomponent för att granska formulärdata innan de skickas in.
feature: Adaptive Forms
doc-type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
last-substantial-update: 2023-01-22T00:00:00Z
exl-id: d537a80a-de61-4d43-bdef-f7d661c43dc8
duration: 33
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '169'
ht-degree: 0%

---

# Skapa komponent för att summera formulärdata

En enkel komponent skapades för att lista formulärdata för granskning. API:t [för vägbeskrivningar användes för att iterera igenom formulärfälten.](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javascript-api/GuideBridge.html?q=visit) Koden i det klientbibliotek som är associerat med den här komponenten hämtar panels-/tabellkomponenterna i formuläret. Från de underordnade elementen för den här panel-/tabellkomponentens formulärfältsrubrik, hämtas värdet och SOM-uttrycket med API-metoderna för GuidBridge. En enkel HTML-tabell skapas sedan med titel, värde och SOM-uttryck för att slutanvändaren ska kunna granska/redigera formulärdata innan formuläret skickas.

På skärmbilden nedan visas den tabell som skapats för att visa fälten och deras värden för **YourDetails**. Den sista TD:n i TR används för att redigera fältets värde med hjälp av fältet SOM-uttryck.

![besök-func](assets/visit-function.png)

## Nästa steg

[Testa lösningen på ditt lokala system](./deploy-on-your-system.md)
