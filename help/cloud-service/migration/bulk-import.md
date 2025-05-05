---
title: Använda massimport med AEM Assets
description: Med verktyget för massimport i AEM as a Cloud Service kan administratörer importera resurser från molnlagring (Azure Blob Storage eller Amazon S3) på ett säkert och effektivt sätt.
version: Experience Manager as a Cloud Service
doc-type: technical-video
feature: Migration
jira: KT-6729, KT-14796
thumbnail: 329680.jpg
topic: Migration
role: Architect, Developer
level: Beginner
last-substantial-update: 2024-01-16T00:00:00Z
exl-id: 28644af8-babc-467d-afdb-8538728dc176
duration: 712
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '175'
ht-degree: 0%

---

# Använda massimport

Med verktyget för massimport i AEM as a Cloud Service kan administratörer importera resurser i bulk från molnlagring på ett säkert och effektivt sätt.

>[!BEGINTABS]

>[!TAB Assets-vy]

Lär dig hur du importerar flera filer till AEM Assets med [resursvyn](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/assets-view/assets-view-introduction.html?lang=sv-SE) [Massimport](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/assets-view/bulk-import-assets-view.html?lang=sv-SE), där Dropbox fungerar som exempelleverantör av molnlagring för en tydlig och lättanvänd integrationsprocess.

>[!VIDEO](https://video.tv.adobe.com/v/3451963/?learn=on&captions=swe)

>[!TAB Administratörsvy]

>[!VIDEO](https://video.tv.adobe.com/v/329680?quality=12&learn=on)

>[!TIP]
>
> Indatakällorna i den här videon visar bara Azure Blob Storage och Amazon S3, men de tillgängliga källorna fortsätter att växa med tiden. En fullständig lista över indatakällor som stöds finns i tillgängliga alternativ i produkten eller i [dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/manage/add-assets.html?lang=sv-SE#bulk-upload).

## Schemalägg bulkimport

Massimport stöder schemalagd körning av konfigurationer, inklusive:

+ Enskild körning vid ett definierat datum och tid
+ Periodkörningar varje timme, dag eller vecka

![Schema för massimport](./assets/bulk-import/schedule.png)

>[!ENDTABS]
