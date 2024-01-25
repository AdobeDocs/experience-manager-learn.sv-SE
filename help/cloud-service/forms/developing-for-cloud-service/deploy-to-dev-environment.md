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
jira: KT-8851
exl-id: daf7d316-e9ec-41b5-89c8-fe4f4ada9701
duration: 27
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '118'
ht-degree: 0%

---

# Distribuera till utvecklingsmiljö

I föregående steg har vi flyttat huvudgrenen från vår lokala Git-databas till MyFirstAF-grenen i molnhanterarens databas.

Nästa steg är att distribuera koden till utvecklingsmiljön.
Logga in på molnhanteraren och välj ditt program

Välj Distribuera till utveckling enligt nedan


![första steget](assets/deploy-first-step1.png)


Välj distributionspipeline så som visas
![första steget](assets/deploy1.png)

Välj källkod och lämplig Git-gren
![första steget](assets/deploy2.png)
Se till att du uppdaterar ändringarna

Kör pipeline
![run-pipeline](assets/run-pipeline.png)

När koden har distribuerats bör du se ändringarna i din molntjänstinstans av AEM Forms.

## Nästa steg

[Uppdaterar projekt av typen mardegarkityp](./updating-project-archetype.md)
