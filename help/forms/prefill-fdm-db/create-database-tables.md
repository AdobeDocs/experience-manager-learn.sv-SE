---
title: Skapa databastabeller
description: Skapa databas som ska användas av formulärdatamodell
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5811
thumbnail: kt-5811.jpg
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '104'
ht-degree: 1%

---


# Skapa databastabeller

Formulärdatamodellen kan baseras på RDBMS-, RESTfull-, SOAP- eller OData-källor. Kursen fokuserar på att förfylla adaptiva formulär med hjälp av formulärdatamodell som stöds av RDBMS-datakällan. I den här självstudiekursen användes MYSQL-databasen. Vi skapade följande två tabeller för att visa användningsfallet

* **** newhiretable - Den här tabellen lagrar all information

   ![newhire](assets/newhire-table.png)


* **Kan** användas - Här lagras alla mottagare

   ![stödmottagare](assets/beneficiaries-table.png)

Du kan importera [sql-filen](assets/db-schema.sql) med MySQL workbench för att skapa till tabeller med exempeldata.