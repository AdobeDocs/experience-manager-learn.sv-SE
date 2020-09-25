---
title: Lagra och hämta formulärdata från MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
translation-type: tm+mt
source-git-commit: 6ae8110d4f4bc80682c35b0dab3fe7a62cad88f3
workflow-type: tm+mt
source-wordcount: '141'
ht-degree: 0%

---

# Konfigurera datakälla

Det finns många sätt att integrera AEM med externa databaser. En av de vanligaste och vanligaste sätten att integrera databaser är att använda konfigurationsegenskaperna för Apache Sling Connection-poolad DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att hämta och distribuera rätt [My SQL-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) i AEM.
Ange sedan egenskaperna för den poolade datakällan för anslutningen. Dessa egenskaper är specifika för din databas. På följande skärmbild visas de inställningar som används för den här självstudiekursen. Databasschemat är en del av den här självstudiekursen.
![datakälla](assets/data-source.png)

Databasen har en tabell som heter formdata med de tre kolumnerna som visas i skärmbilden nedan![i databasen](assets/data-base-tables.PNG)
