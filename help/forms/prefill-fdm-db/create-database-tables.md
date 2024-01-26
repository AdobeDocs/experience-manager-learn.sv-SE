---
title: Skapa databastabeller
description: Skapa databas som ska användas av formulärdatamodell
feature: Adaptive Forms
version: 6.4,6.5
jira: KT-5811
thumbnail: kt-5811.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 1136244a-c3e6-45f6-8af8-eb3c100f838e
duration: 28
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '105'
ht-degree: 0%

---

# Skapa databastabeller

Formulärdatamodellen kan baseras på RDBMS-, RESTfull-, SOAP- eller OData-källor. Kursen fokuserar på att förfylla adaptiva formulär med hjälp av formulärdatamodell som stöds av RDBMS-datakällan. I den här självstudiekursen användes MYSQL-databasen. Vi skapade följande två tabeller för att visa användningsfallet

* **newhire** table - This table stores the newhere information

  ![newhire](assets/newhire-table.png)


* **stödmottagare** table - Här lagras alla mottagare

  ![stödmottagare](assets/beneficiaries-table.png)

Du kan importera [SQL-fil](assets/db-schema.sql) använda MySQL workbench för att skapa till tabeller med exempeldata.

## Nästa steg

[Konfigurera formulärdatamodell](./configuring-form-data-model.md)
