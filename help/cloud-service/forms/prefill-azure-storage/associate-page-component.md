---
title: Koppla sidkomponent till den nya adaptiva formulärmallen
description: Skapa en ny sidkomponent
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
exl-id: 7b2b1e1c-820f-4387-a78b-5d889c31eec0
duration: 25
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '150'
ht-degree: 0%

---

# Koppla sidkomponenten till mallen

Nästa steg är att koppla sidkomponenten till den nya adaptiva formulärmallen. Detta garanterar att koden i sidkomponenten körs varje gång ett adaptivt formulär som är baserat på den nya mallen återges. I den här självstudiekursen skapades en ny adaptiv formulärmall med namnet **StoreAndRestoreFromAzure** i mappen **AzurePortalStorage**.
Navigera till /conf/AzurePortalStorage/settings/wcm/templates/storeandrestorefromazure/initial/jcr:content-nod, lägg till följande egenskap och spara ändringarna.

| **Egenskapsnamn** | **Egenskapstyp** | **Egenskapsvärde** |
|--------------------|-------------------|-------------------------------------------------------|
| sling:resourceType | Sträng | azureportalpagecomponent/component/page/storeandfetch |

Navigera till /conf/AzurePortalStorage/settings/wcm/templates/storeandrestorefromazure/structure/jcr:content-nod, lägg till följande egenskap och spara ändringarna.
| **Egenskapsnamn**  | **Egenskapstyp** | **Egenskapsvärde**                                    |
|—|—|—|
| sling:resourceType | Sträng            | azureportalpagecomponent/component/page/storeandfetch |


## Nästa steg

[Skapa integrering med Azure Storage](./create-fdm.md)
