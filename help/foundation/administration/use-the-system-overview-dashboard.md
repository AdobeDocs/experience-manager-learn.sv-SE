---
title: Använda kontrollpanelen för systemöversikt i AEM
description: I tidigare versioner av AEM behövde administratörer undersöka olika platser för att få en fullständig bild av AEM-instansen. Systemöversikten syftar till att lösa detta genom att tillhandahålla en översikt över AEM-instansens konfiguration, maskinvara och hälsa från en enda kontrollpanel.
version: Experience Manager 6.4, Experience Manager 6.5
feature: Operations
doc-type: Technical Video
topic: Administration
role: Admin
level: Beginner
exl-id: af8f499c-4955-44b5-8f21-085263ca31a3
duration: 357
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '131'
ht-degree: 0%

---

# Använda kontrollpanelen för systemöversikt

Adobe Experience Manager (AEM) [!UICONTROL System Overview] ger en översikt över konfiguration, maskinvara och hälsa för AEM-instansen från en enda instrumentpanel.

>[!VIDEO](https://video.tv.adobe.com/v/21340?quality=12&learn=on)

1. Systemöversikt kan nås från: **AEM Start** > **[!UICONTROL Tools]** > **[!UICONTROL Operations]** > **[!UICONTROL System Overview]**

   Direkt **`<server-host>/libs/granite/operations/content/systemoverview.html`**

1. Du kan exportera informationen från [!UICONTROL System Overview] genom att klicka på knappen [!UICONTROL Download]. Informationen visas även via följande [!DNL REST]-slutpunkt:
1. Nedan visas ett exempel på JSON-utdata som exporteras från [!UICONTROL System Overview]:

   ```json
   {
       "Health Checks": {
           "1 Critical": "System Maintenance",
           "3 Warn": "Replication Queue, Log Errors, Sling/Granite Content Access Check"
       },
       "Instance": {
           "Adobe Experience Manager": "6.4.0",
           "Run Modes": "s7connect, crx3, non-composite, author, samplecontent, crx3tar",
           "Instance Up Since": "2018-01-22 10:50:37"
       },
       "Repository": {
           "Apache Jackrabbit Oak": "1.8.0",
           "Node Store": "Segment Tar",
           "Repository Size": "0.26 GB",
           "File Data Store": "crx-quickstart/repository/datastore"
       },
       "Maintenance Tasks": {
           "Failed": "AuditLog Maintenance Task, Project Purge, Workflow Purge",
           "Succeeded": "Data Store Garbage Collection, Lucene Binaries Cleanup, Revision Clean Up, Version Purge, Purge of ad-hoc tasks"
       },
       "System Information": {
           "Mac OS X": "10.12.6",
           "System Load Average": "2.29",
           "Usable Disk Space": "89.44 GB",
           "Maximum Heap": "0.97 GB"
       },
       "Estimated Node Counts": {
           "Total": "232448",
           "Tags": "62",
           "Assets": "267",
           "Authorizables": "210",
           "Pages": "1592"
       },
       "Replication Agents": {
           "Blocked": "publish, publish2",
           "Idle": "offloading_b3deb296-9b28-4f60-8587-c06afa2e632c, offloading_outbox, offloading_reverse_b3deb296-9b28-4f60-8587-c06afa2e632c, publish_reverse, scene7, screens, screens2, test_and_target"
       },
       "Distribution Agents": {
           "Blocked": "publish"
       },
       "Workflows": {
           "Running Workflows": "15",
           "Failed Workflows": "15",
           "Failed Jobs": "150"
       },
       "Sling Jobs": {
           "Failed": "305"
       }
   }
   ```
