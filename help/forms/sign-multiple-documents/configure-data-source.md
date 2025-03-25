---
title: Konfigurera AEM Data Source
description: Konfigurera den MySQL-baserade datakällan för att lagra och hämta formulärdata
feature: Adaptive Forms
topic: Development
role: Developer
level: Beginner
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-6899
thumbnail: 6899.jpg
exl-id: 2e851ae5-6caa-42e3-8af2-090766a6f36a
duration: 39
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '191'
ht-degree: 0%

---

# Konfigurera datakälla

Det finns många sätt att integrera AEM med externa databaser. Ett av de vanligaste sätten att integrera en databas är att använda konfigurationsegenskaperna för Apache Sling Connection-poolad DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att hämta och distribuera lämpliga [MySql-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) i AEM.
Skapa den poolade datakällan för Apache Sling-anslutningen och ange de egenskaper som anges i skärmbilden nedan. Databasschemat är en del av den här självstudiekursen.

![datakälla](assets/data-source.PNG)

Databasen har en tabell som heter formdata med de tre kolumnerna som visas på skärmbilden nedan.

![databas](assets/data-base.PNG)


>[!NOTE]
>Kontrollera att du namnger datakällan **aemformstutorial**. Exempelkoden använder namnet för att ansluta till databasen.

| Egenskapsnamn | Värde |
| ------------------------|--------------------------------------- |
| Namn på datakälla | `SaveAndContinue` |
| JDBC-drivrutinsklass | `com.mysql.cj.jdbc.Driver` |
| JDBC-anslutnings-URI | `jdbc:mysql://localhost:3306/aemformstutorial` |

## Assets

SQL-filen som ska skapa schemat kan [hämtas här](assets/sign-multiple-forms.sql). Du måste importera den här filen med MySQL Workbench för att skapa schemat och tabellen.

## Nästa steg

[Skapa en OSGi-tjänst för att lagra och hämta data i databasen](./create-osgi-service.md)
