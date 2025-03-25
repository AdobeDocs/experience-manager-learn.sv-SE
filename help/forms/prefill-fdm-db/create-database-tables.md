---
title: Skapa databastabeller
description: Skapa databas som ska användas av formulärdatamodell
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-5811
thumbnail: kt-5811.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 1136244a-c3e6-45f6-8af8-eb3c100f838e
duration: 21
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '105'
ht-degree: 0%

---

# Skapa databastabeller

Formulärdatamodellen kan baseras på RDBMS-, RESTfull-, SOAP- eller OData-källor. Kursen fokuserar på att förfylla adaptiva formulär med hjälp av formulärdatamodell som stöds av RDBMS-datakällan. I den här självstudiekursen användes MYSQL-databasen. Vi skapade följande två tabeller för att visa användningsfallet

* tabellen **ne** - den här tabellen lagrar information om nyheter

  ![Nwire](assets/newhire-table.png)


* Tabellen **mottagare** - Här lagras alla mottagare

  ![mottagare](assets/beneficiaries-table.png)

Du kan importera [sql-filen](assets/db-schema.sql) med MySQL workbench för att skapa till tabeller med exempeldata.

## Nästa steg

[Konfigurera formulärdatamodell](./configuring-form-data-model.md)
