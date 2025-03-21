---
title: Starta AEM arbetsflöde vid introduktion av formulärinskickning från HTML5
description: Starta ett AEM arbetsflöde när du skickar in mobilformulär
feature: Mobile Forms
doc-type: article
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
last-substantial-update: 2024-09-17T00:00:00Z
jira: kt-16215
badgeVersions: label="AEM Forms 6.5" before-title="false"
source-git-commit: c6ffa8f7a398b01fc12e1e2efe4382c941900496
workflow-type: tm+mt
source-wordcount: '195'
ht-degree: 0%

---

# AEM arbetsflöde vid inskickning av mobilformulär

Ett vanligt användningsexempel är att återge XDP som HTML för datainhämtningsaktiviteter. När det här formuläret skickas in kan du behöva starta ett AEM arbetsflöde. I det AEM arbetsflödet kan du sammanfoga data med XDP-mallen och presentera det genererade PDF för granskning och godkännande. Formuläret återges i en publiceringsinstans och arbetsflödet aktiveras för en AEM.

Följande steg ingår i användningsexemplet

* Användaren fyller i och skickar ett HTML5-formulär (HTML5-renderingen av XDP).
* Överföringen hanteras av en serverlet i publiceringsinstansen.
* Servern lagrar data i en fördefinierad mapp i databasen för AEM.
* Arbetsflödets startprogram är konfigurerat för att utlösa ett AEM arbetsflöde varje gång en ny fil läggs till under en viss mapp.

I den här självstudiekursen går du igenom de steg som krävs för att slutföra användningsfallet ovan. Exempelkod och resurser för den här självstudiekursen är [tillgängliga här.](./deploy-assets.md)


## Nästa steg

[Hantera inlämning av formulär](./handle-form-submission.md)
