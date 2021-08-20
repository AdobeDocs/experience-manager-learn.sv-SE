---
title: Skapa databastabeller
description: Skapa databas som ska användas av formulärdatamodell
feature: Adaptiv Forms
version: 6.4,6.5
kt: 5811
thumbnail: kt-5811.jpg
topic: Utveckling
role: Developer
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '102'
ht-degree: 0%

---


# Skapa databastabeller

Formulärdatamodellen kan baseras på RDBMS-, RESTfull-, SOAP- eller OData-källor. Kursen fokuserar på att förfylla adaptiva formulär med hjälp av formulärdatamodell som stöds av RDBMS-datakällan. I den här självstudiekursen användes MYSQL-databasen. Vi skapade följande två tabeller för att visa användningsfallet

* **** newhiretable - Den här tabellen lagrar all information

   ![newhire](assets/newhire-table.png)


* **Kan** användas - Här lagras alla mottagare

   ![stödmottagare](assets/beneficiaries-table.png)

Du kan importera [sql-filen](assets/db-schema.sql) med MySQL workbench för att skapa till tabeller med exempeldata.