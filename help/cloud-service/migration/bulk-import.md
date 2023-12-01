---
title: Använda massimport med AEM Assets
description: Med verktyget för massimport i AEM as a Cloud Service kan administratörer importera resurser i bulk från molnlagring (Azure Blob Storage eller Amazon S3) på ett säkert och effektivt sätt.
version: Cloud Service
doc-type: technical-video
topics: Migration
feature: Migration
activity: develop
audience: developer
jira: KT-6729
thumbnail: 329680.jpg
topic: Migration
role: Architect, Developer
level: Beginner
last-substantial-update: 2022-10-05T00:00:00Z
exl-id: 28644af8-babc-467d-afdb-8538728dc176
source-git-commit: 30d6120ec99f7a95414dbc31c0cb002152bd6763
workflow-type: tm+mt
source-wordcount: '146'
ht-degree: 0%

---

# Använda massimport

Med verktyget för massimport i AEM as a Cloud Service kan administratörer importera resurser i bulk från molnlagring på ett säkert och effektivt sätt.

>[!TIP]
>
> Indatakällorna i den här videon visar bara Azure Blob Storage och Amazon S3, men de tillgängliga källorna fortsätter att växa med tiden. En fullständig lista över indatakällor som stöds finns i produktens tillgängliga alternativ. [dokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/manage/add-assets.html#bulk-upload).

>[!VIDEO](https://video.tv.adobe.com/v/329680?quality=12&learn=on)

## Schemalägg bulkimport

Massimport stöder schemalagd körning av konfigurationer, inklusive:

+ Enskild körning vid ett definierat datum och tid
+ Periodkörningar varje timme, dag eller vecka

![Schema för massimport](./assets/bulk-import/schedule.png)
