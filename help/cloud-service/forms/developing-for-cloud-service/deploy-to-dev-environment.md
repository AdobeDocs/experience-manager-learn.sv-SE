---
title: Distribuera till utvecklingsmiljö
description: Distribuera koden från din molnhanterardatabasgren
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
kt: 8851
source-git-commit: 9063c3dfd9ab9ac537850694ce6545a3fdc840e9
workflow-type: tm+mt
source-wordcount: '112'
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
