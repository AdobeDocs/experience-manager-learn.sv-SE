---
title: Lagra och hämta formulärdata från MySQL-databasen - Konfigurera datakälla
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
version: 6.4,6.5
feature: Adaptive Forms
topic: Development
role: Developer
level: Experienced
exl-id: dccca658-3373-4de2-8589-21ccba2b7ba6
duration: 36
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '187'
ht-degree: 0%

---

# Konfigurera datakälla

Det finns många sätt att integrera AEM med externa databaser. En av de vanligaste och vanligaste sätten att integrera databaser är att använda konfigurationsegenskaperna för Apache Sling Connection-poolad DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att ladda ned och installera rätt [MySql-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) AEM.
Skapa den poolade datakällan för Apache Sling-anslutningen och ange de egenskaper som anges i skärmbilden nedan. Databasschemat är en del av den här självstudiekursen.

![datakälla](assets/save-continue.PNG)

Databasen har en tabell som heter formdata med de tre kolumnerna som visas på skärmbilden nedan.

![databas](assets/data-base-tables.PNG)

SQL-filen som ska skapa schemat kan vara [hämtad härifrån](assets/form-data-db.sql). Du måste importera den här filen med MySQL Workbench för att skapa schemat och tabellen.

>[!NOTE]
>Ge datakällan ett namn **SparaOchFortsätt**. Exempelkoden använder namnet för att ansluta till databasen.

| Egenskapsnamn | Värde |
| ------------------------|---------------------------------------|
| Namn på datakälla | `SaveAndContinue` |
| JDBC-drivrutinsklass | `com.mysql.cj.jdbc.Driver` |
| JDBC-anslutnings-URI | `jdbc:mysql://localhost:3306/aemformstutorial` |
