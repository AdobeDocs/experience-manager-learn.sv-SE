---
title: Konfigurera AEM datakälla
description: Konfigurera den MySQL-baserade datakällan för att lagra och hämta formulärdata
feature: Adaptiv Forms
topic: Utveckling
role: Developer
level: Beginner
version: 6.4,6.5
kt: 6899
thumbnail: 6899.jpg
source-git-commit: 3569d8b2a38d1cce02f6f4ff8b0c583f4dc118b6
workflow-type: tm+mt
source-wordcount: '193'
ht-degree: 1%

---

# Konfigurera datakälla

Det finns många sätt att integrera AEM med en extern databas. Ett av de vanligaste sätten att integrera en databas är att använda konfigurationsegenskaperna för Apache Sling Connection-poolad DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att hämta och distribuera lämpliga [MySql-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) i AEM.
Skapa den poolade datakällan för Apache Sling-anslutningen och ange de egenskaper som anges i skärmbilden nedan. Databasschemat är en del av den här självstudiekursen.

![datakälla](assets/data-source.PNG)

Databasen har en tabell som heter formdata med de tre kolumnerna som visas på skärmbilden nedan.

![databas](assets/data-base.PNG)


>[!NOTE]
>Ange ett namn för datakällan **aemformstutorial**. Exempelkoden använder namnet för att ansluta till databasen.

| Egenskapsnamn | Värde |
| ------------------------|--------------------------------------- |
| Namn på datakälla | SparaOchFortsätt |
| JDBC-drivrutinsklass | com.mysql.cj.jdbc.Driver |
| JDBC-anslutnings-URI | jdbc:mysql://localhost:3306/aemformstutorial |

## Assets

SQL-filen som schemat ska skapas från kan [hämtas här](assets/sign-multiple-forms.sql). Du måste importera den här filen med MySQL Workbench för att skapa schemat och tabellen.
