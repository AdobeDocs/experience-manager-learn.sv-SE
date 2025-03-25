---
title: Starta AEM-arbetsflödet i introduktionen av HTML5 Form Submit
description: Starta ett AEM-arbetsflöde när du skickar in mobilformulär
feature: Mobile Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
last-substantial-update: 2024-09-17T00:00:00Z
jira: kt-16215
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: ce51b25f-6069-4799-9a61-98c0a672e821
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '195'
ht-degree: 0%

---

# Starta AEM-arbetsflödet vid inskickning av mobilformulär

Ett vanligt användningsexempel är att återge XDP som HTML för datainhämtning. När det här formuläret skickas in kan du behöva starta ett AEM-arbetsflöde. I AEM-arbetsflödet kan du sammanfoga data med XDP-mallen och presentera den genererade PDF för granskning och godkännande. Formuläret återges i en publiceringsinstans och arbetsflödet aktiveras i en AEM-bearbetningsinstans.

Följande steg ingår i användningsexemplet

* Användaren fyller i och skickar ett HTML5-formulär (HTML5-återgivning av XDP).
* Överföringen hanteras av en serverlet i publiceringsinstansen.
* Servern lagrar data i en fördefinierad mapp i databasen för AEM-bearbetningsinstansen.
* Startprogrammet för arbetsflöden är konfigurerat för att utlösa ett AEM-arbetsflöde varje gång en ny fil läggs till i en viss mapp.

I den här självstudiekursen går du igenom de steg som krävs för att slutföra användningsfallet ovan. Exempelkod och resurser för den här självstudiekursen är [tillgängliga här.](./deploy-assets.md)


## Nästa steg

[Hantera inlämning av formulär](./handle-form-submission.md)
