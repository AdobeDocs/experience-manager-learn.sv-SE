---
title: Skapa databastabeller
description: Skapa databas som ska användas av formulärdatamodell
feature: adaptive-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5811
thumbnail: kt-5811.jpg
translation-type: tm+mt
source-git-commit: b085a2c75f8e0b4860d503774ea01a108773ad09
workflow-type: tm+mt
source-wordcount: '99'
ht-degree: 0%

---


# Skapa databastabeller

Formulärdatamodellen kan baseras på RDBMS-, RESTfull-, SOAP- eller OData-källor. Kursen fokuserar på att förfylla adaptiva formulär med hjälp av formulärdatamodell som stöds av RDBMS-datakällan. I den här självstudiekursen användes MYSQL-databasen. Vi skapade följande två tabeller för att visa användningsfallet

* **newhere** table - This table stores the newhere information

   ![newhire](assets/newhire-table.png)


* **mottagarregister** - Här lagras alla mottagare

   ![stödmottagare](assets/beneficiaries-table.png)

Du kan importera [sql-filen](assets/db-schema.sql) med MySQL Workbench för att skapa till tabeller med exempeldata.