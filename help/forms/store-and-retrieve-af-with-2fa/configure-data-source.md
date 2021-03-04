---
title: Konfigurera datakälla
description: Skapa en datakälla som pekar på MySQL-databasen
feature: adaptiva formulär
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6541
thumbnail: 6541.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '292'
ht-degree: 0%

---


# Konfigurera datakälla

Det finns många sätt att integrera AEM med externa databaser. En av de vanligaste standardmetoderna för databasintegrering är att använda konfigurationsegenskaperna för Apache Sling Connection-poolad DataSource via [configMgr](http://localhost:4502/system/console/configMgr).
Det första steget är att hämta och distribuera lämpliga [MySQL-drivrutiner](https://mvnrepository.com/artifact/mysql/mysql-connector-java) till AEM.
Ange sedan de egenskaper för datakälla för Sling-anslutning som är specifika för databasen. På följande skärmbild visas de inställningar som används för den här självstudiekursen. Databasschemat är en del av den här självstudiekursen.

![datakälla](assets/data-source.JPG)


* JDBC-drivrutinsklass: `com.mysql.cj.jdbc.Driver`
* JDBC-anslutnings-URI: `jdbc:mysql://localhost:3306/aemformstutorial`

>[!NOTE]
>Ange ett namn för datakällan `StoreAndRetrieveAfData` eftersom det är det namn som används i OSGi-tjänsten.


## Skapa databas


Följande databas användes för det här användningsfallet. Databasen har en tabell med namnet `formdatawithattachments` och de fyra kolumnerna som visas i skärmbilden nedan.
![databas](assets/table-schema.JPG)

* Kolumnen **afdata** kommer att innehålla adaptiva formulärdata.
* Kolumnen **attachmentsInfo** innehåller information om de bifogade formulären.
* Kolumnerna **phoneNumber** innehåller mobilnumret för den person som fyller i formuläret.

Skapa databasen genom att importera [databasschemat](assets/data-base-schema.sql)
med MySQL Workbench.

## Skapa formulärdatamodell

Skapa formulärdatamodell och basera den på datakällan som skapades i föregående steg.
Konfigurera tjänsten **get** för den här formulärdatamodellen så som visas på skärmbilden nedan.
Kontrollera att du inte returnerar en matris i **get**-tjänsten.

Den här **get**-tjänsten används för att hämta det telefonnummer som är associerat med program-ID:t.

![get-service](assets/get-service.JPG)

Den här formulärdatamodellen används sedan i **MyAccountForm** för att hämta telefonnumret som är kopplat till program-ID:t.
