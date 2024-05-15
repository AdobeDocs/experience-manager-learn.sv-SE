---
title: Skapa en komponent för att lista formulärdata
description: Självstudiekurs för att skapa en sammanfattningskomponent för att granska formulärdata innan de skickas in.
feature: Adaptive Forms
doc-type: Tutorial
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
last-substantial-update: 2023-01-22T00:00:00Z
exl-id: d537a80a-de61-4d43-bdef-f7d661c43dc8
duration: 33
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '169'
ht-degree: 0%

---

# Skapa komponent för att summera formulärdata

En enkel komponent skapades för att lista formulärdata för granskning. The [API:ns besöksfunktion för guidebridge](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javascript-api/GuideBridge.html?q=visit) har använts för att iterera igenom formulärfälten. Koden i det klientbibliotek som är associerat med den här komponenten hämtar panels-/tabellkomponenterna i formuläret. Från de underordnade elementen för den här panel-/tabellkomponentens formulärfältsrubrik, hämtas värdet och SOM-uttrycket med API-metoderna för GuidBridge. En enkel HTML-tabell skapas sedan med titel, värde och SOM-uttryck för att slutanvändaren ska kunna granska/redigera formulärdata innan formuläret skickas.

På skärmbilden nedan visas den tabell som skapats för att visa fälten och deras värden för **DinDetaljer**. Den sista TD:n i TR används för att redigera fältets värde med hjälp av fältet SOM-uttryck.

![besök-func](assets/visit-function.png)

## Nästa steg

[Testa lösningen på ditt lokala system](./deploy-on-your-system.md)
