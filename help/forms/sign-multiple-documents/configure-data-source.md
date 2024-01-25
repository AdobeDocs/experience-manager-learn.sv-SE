---
title: Konfigurera AEM datakälla
description: Konfigurera den MySQL-baserade datakällan för att lagra och hämta formulärdata
feature: Adaptive Forms
topic: Development
role: Developer
level: Beginner
version: 6.4,6.5
jira: KT-6899
thumbnail: 6899.jpg
exl-id: 2e851ae5-6caa-42e3-8af2-090766a6f36a
duration: 47
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '197'
ht-degree: 0%

---

# Konfigurera datakälla

Det finns många sätt att integrera AEM med en extern databas. Ett av de vanligaste sätten att integrera en databas är att använda konfigurationsegenskaperna för Apache Sling Connection Pooled DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att ladda ned och installera rätt [MySql-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) AEM.
Skapa den poolade datakällan för Apache Sling-anslutningen och ange de egenskaper som anges i skärmbilden nedan. Databasschemat är en del av den här självstudiekursen.

![datakälla](assets/data-source.PNG)

Databasen har en tabell som heter formdata med de tre kolumnerna som visas på skärmbilden nedan.

![databas](assets/data-base.PNG)


>[!NOTE]
>Ge datakällan ett namn **aemformstutorial**. Exempelkoden använder namnet för att ansluta till databasen.

| Egenskapsnamn | Värde |
| ------------------------|--------------------------------------- |
| Namn på datakälla | SparaOchFortsätt |
| JDBC-drivrutinsklass | com.mysql.cj.jdbc.Driver |
| JDBC-anslutnings-URI | jdbc:mysql://localhost:3306/aemformstutorial |

## Assets

SQL-filen som ska skapa schemat kan vara [hämtad härifrån](assets/sign-multiple-forms.sql). Du måste importera den här filen med MySQL Workbench för att skapa schemat och tabellen.

## Nästa steg

[Skapa en OSGi-tjänst för att lagra och hämta data i databasen](./create-osgi-service.md)
