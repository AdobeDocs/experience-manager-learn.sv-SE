---
title: Distribuera till utvecklingsmiljö
description: Distribuera koden från din molnhanterardatabasgren
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Code Deployment
kt: 8851
exl-id: daf7d316-e9ec-41b5-89c8-fe4f4ada9701
source-git-commit: eecc275e38390b9330464c8ac0750efa2c702c82
workflow-type: tm+mt
source-wordcount: '118'
ht-degree: 0%

---

# Distribuera till utvecklingsmiljö

I föregående steg har vi flyttat vår överordnad gren från vår lokala Git-databas till MyFirstAF-grenen i molnhanterarens databas.

Nästa steg är att distribuera koden till utvecklingsmiljön.
Logga in på molnhanteraren och välj ditt program

Välj Distribuera till utveckling enligt nedan


![första steget](assets/deploy-first-step1.png)


Välj distributionspipeline så som visas
![första steget](assets/deploy1.png)

Välj källkod och lämplig Git-gren
![första steget](assets/deploy2.png)
Se till att du uppdaterar dina ändringar

Kör pipeline
![run-pipeline](assets/run-pipeline.png)

När koden har distribuerats bör du se ändringarna i din molntjänstinstans av AEM Forms.

## Nästa steg

[Uppdaterar projekt av typen mardegarkityp](./updating-project-archetype.md)
