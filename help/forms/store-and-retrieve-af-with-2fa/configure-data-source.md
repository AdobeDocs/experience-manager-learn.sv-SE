---
title: Konfigurera datakälla
description: Skapa en datakälla som pekar på MySQL-databasen
feature: Adaptive Forms
type: Tutorial
version: 6.4,6.5
jira: KT-6541
thumbnail: 6541.jpg
topic: Development
role: Developer
level: Beginner
exl-id: a87ff428-15f7-43c9-ad03-707eab6216a9
duration: 87
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '313'
ht-degree: 0%

---

# Konfigurera datakälla

Det finns många sätt på vilka AEM kan integreras med en extern databas. En av de vanligaste och vanligaste sätten att integrera databaser är att använda konfigurationsegenskaperna för Apache Sling Connection Pooled DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att ladda ned och installera rätt [MySQL-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) till AEM.
Ange sedan de egenskaper för datakälla för Sling-anslutning som är specifika för databasen. På följande skärmbild visas de inställningar som används för den här självstudiekursen. Databasschemat är en del av den här självstudiekursen.

>[!NOTE]
>Ge datakällan ett namn `StoreAndRetrieveAfData` eftersom detta är namnet som används i OSGi-tjänsten.


![datakälla](assets/data-source.JPG)

| Egenskapsnamn | Egenskapsvärde |   |
|---------------------|------------------------------------------------------------------------------------|---|
| Datakällans namn | StoreAndRetrieveAfData |   |
| JDBC-enhetsklass | jdbc:mysql://localhost:3306/aemformstutorial |   |
| URI för JDBC-anslutning | jdbc:mysql://localhost:3306/aemformstutorial?serverTimezone=UTC&amp;autoReconnect=true |   |
|                     |                                                                                    |   |


## Skapa databas


Följande databas användes för det här användningsfallet. Databasen har en tabell som heter `formdatawithattachments` med de fyra kolumnerna som visas på skärmbilden nedan.
![databas](assets/table-schema.JPG)

* Kolumnen **afdata** kommer att innehålla adaptiva formulärdata.
* Kolumnen **attachmentsInfo** innehåller information om de bifogade formulären.
* Kolumnerna **phoneNumber** innehåller det mobila numret för den person som fyller i formuläret.

Skapa databasen genom att importera [databasschema](assets/data-base-schema.sql)
med MySQL Workbench.

## Skapa formulärdatamodell

Skapa formulärdatamodellen och basera den på datakällan som skapades i föregående steg.
Konfigurera **get** tjänsten för den här formulärdatamodellen som visas på skärmbilden nedan.
Se till att du inte returnerar en array i **get** service.

Syftet med detta **get** är att hämta det telefonnummer som är kopplat till program-ID:t.

![get-service](assets/get-service.JPG)

Den här formulärdatamodellen används sedan i **MyAccountForm** för att hämta det telefonnummer som är kopplat till program-ID:t.

## Nästa steg

[Skriv kod för att spara formulärbilagor](./store-form-attachments.md)
