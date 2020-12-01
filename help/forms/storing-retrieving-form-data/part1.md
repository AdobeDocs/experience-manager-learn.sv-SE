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
source-git-commit: 787a79663472711b78d467977d633e3d410803e5
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---

# Konfigurera datakälla

Det finns många sätt att integrera AEM med externa databaser. En av de vanligaste och vanligaste sätten att integrera databaser är att använda konfigurationsegenskaperna för Apache Sling Connection Pooled DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att hämta och distribuera lämpliga [MySql-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) i AEM.
Skapa den poolade datakällan för Apache Sling-anslutningen och ange de egenskaper som anges i skärmbilden nedan. Databasschemat är en del av den här självstudiekursen.

![datakälla](assets/save-continue.PNG)

Databasen har en tabell som heter formdata med de tre kolumnerna som visas på skärmbilden nedan.

![databas](assets/data-base-tables.PNG)

SQL-filen som schemat ska skapas från kan [hämtas här](assets/form-data-db.sql). Du måste importera den här filen med MySQL Workbench för att skapa schemat och tabellen.

>[!NOTE]
>Ange ett namn för datakällan **SaveAndContinue**. Exempelkoden använder namnet för att ansluta till databasen.

| Egenskapsnamn | Värde |
------------------------|---------------------------------------
| Namn på datakälla | SparaOchFortsätt |
| JDBC-drivrutinsklass | com.mysql.cj.jdbc.Driver |
| JDBC-anslutnings-URI | jdbc:mysql://localhost:3306/aemformstutorial |


