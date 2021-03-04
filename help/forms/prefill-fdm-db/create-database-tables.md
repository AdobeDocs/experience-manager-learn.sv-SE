---
title: Skapa databastabeller
description: Skapa databas som ska användas av formulärdatamodell
feature: adaptiva formulär
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5811
thumbnail: kt-5811.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '100'
ht-degree: 0%

---


# Skapa databastabeller

Formulärdatamodellen kan baseras på RDBMS-, RESTfull-, SOAP- eller OData-källor. Kursen fokuserar på att förfylla adaptiva formulär med hjälp av formulärdatamodell som stöds av RDBMS-datakällan. I den här självstudiekursen användes MYSQL-databasen. Vi skapade följande två tabeller för att visa användningsfallet

* **** newhiretable - Den här tabellen lagrar all information

   ![newhire](assets/newhire-table.png)


* **Kan** användas - Här lagras alla mottagare

   ![stödmottagare](assets/beneficiaries-table.png)

Du kan importera [sql-filen](assets/db-schema.sql) med MySQL workbench för att skapa till tabeller med exempeldata.