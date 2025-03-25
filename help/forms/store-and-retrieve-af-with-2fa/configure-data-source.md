---
title: Konfigurera Source
description: Skapa en datakälla som pekar på MySQL-databasen
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-6541
thumbnail: 6541.jpg
topic: Development
role: Developer
level: Beginner
exl-id: a87ff428-15f7-43c9-ad03-707eab6216a9
duration: 64
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '302'
ht-degree: 0%

---

# Konfigurera Source

Det finns många sätt på vilka AEM kan integreras med en extern databas. En av de vanligaste och vanligaste sätten att integrera databaser är att använda konfigurationsegenskaperna för Apache Sling Connection-poolad DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att hämta och distribuera lämpliga [MySQL-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) till AEM.
Ange sedan de egenskaper för datakälla för Sling-anslutning som är specifika för databasen. På följande skärmbild visas de inställningar som används för den här självstudiekursen. Databasschemat är en del av den här självstudiekursen.

>[!NOTE]
>Kontrollera att du namnger datakällan `StoreAndRetrieveAfData` eftersom det här är namnet som används i OSGi-tjänsten.


![datakälla](assets/data-source.JPG)

| Egenskapsnamn | Egenskapsvärde |   |
|---------------------|------------------------------------------------------------------------------------|---|
| Datakällans namn | `StoreAndRetrieveAfData` |   |
| JDBC-enhetsklass | `jdbc:mysql://localhost:3306/aemformstutorial` |   |
| URI för JDBC-anslutning | `jdbc:mysql://localhost:3306/aemformstutorial?serverTimezone=UTC&autoReconnect=true` |   |
|                     |                                                                                    |   |


## Skapa databas


Följande databas användes för det här användningsfallet. Databasen har en tabell med namnet `formdatawithattachments` och de fyra kolumnerna som visas på skärmbilden nedan.
![databas](assets/table-schema.JPG)

* Kolumnen **afdata** kommer att innehålla adaptiva formulärdata.
* Kolumnen **attachmentsInfo** innehåller information om de bifogade formulären.
* Kolumnerna **phoneNumber** innehåller mobilnumret för den person som fyller i formuläret.

Skapa databasen genom att importera [databasschemat](assets/data-base-schema.sql)
med MySQL Workbench.

## Skapa formulärdatamodell

Skapa formulärdatamodellen och basera den på datakällan som skapades i föregående steg.
Konfigurera **get**-tjänsten för den här formulärdatamodellen så som visas på skärmbilden nedan.
Kontrollera att du inte returnerar en matris i tjänsten **get**.

Syftet med den här **get**-tjänsten är att hämta det telefonnummer som är associerat med program-ID:t.

![get-service](assets/get-service.JPG)

Den här formulärdatamodellen används sedan i **MyAccountForm** för att hämta telefonnumret som är kopplat till program-ID:t.

## Nästa steg

[Skriv kod för att spara formulärbilagor](./store-form-attachments.md)
