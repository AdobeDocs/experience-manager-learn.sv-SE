---
title: Koppla sidkomponent till den nya adaptiva formulärmallen
description: Skapa en ny sidkomponent
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
source-git-commit: 52c8d96a03b4d6e4f2a0a3c92f4307203e236417
workflow-type: tm+mt
source-wordcount: '151'
ht-degree: 0%

---

# Koppla sidkomponenten till mallen

Nästa steg är att koppla sidkomponenten till den nya adaptiva formulärmallen. Detta garanterar att koden i sidkomponenten körs varje gång ett adaptivt formulär som är baserat på den nya mallen återges. I den här självstudiekursen finns en ny adaptiv formulärmall som kallas **StoreAndRestoreFromAzure** skapades i **AzurePortalStorage** mapp.
Navigera till /conf/AzurePortalStorage/settings/wcm/templates/storeandrestorefromazure/initial/jcr:content-nod, lägg till följande egenskap och spara ändringarna.

| **Egenskapsnamn** | **Egenskapstyp** | **Egenskapsvärde** |
|--------------------|-------------------|-------------------------------------------------------|
| sling:resourceType | Sträng | azureportalpagecomponent/component/page/storeandfetch |

Navigera till /conf/AzurePortalStorage/settings/wcm/templates/storeandrestorefromazure/structure/jcr:content-nod, lägg till följande egenskap och spara ändringarna.
| **Egenskapsnamn**  | **Egenskapstyp** | **Egenskapsvärde**                                    | |—|—|—| | sling:resourceType | Sträng | azureportalpagecomponent/komponent/sida/storeandfetch |


## Nästa steg

[Skapa integrering med Azure Storage](./create-fdm.md)
