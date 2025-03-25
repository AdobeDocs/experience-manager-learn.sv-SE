---
title: Starta AEM i HTML5 Form Submit - Granska och godkänn PDF
description: Arbetsflöde för att granska inskickade PDF
feature: Mobile Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
jira: kt-16215
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: ec60d017-8b29-4185-a097-d809e18df4a7
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '172'
ht-degree: 0%

---

# Arbetsflöde för att granska och godkänna inskickade PDF

Det sista och sista steget är att skapa ett AEM-arbetsflöde som genererar en statisk eller icke-interaktiv PDF för granskning och godkännande. Arbetsflödet utlöses via en AEM Launcher som konfigurerats på noden `/content/formsubmissions`.

Följande skärmbild visar de steg som ingår i arbetsflödet.

![arbetsflöde](assets/workflow.PNG)

## Generera icke-interaktivt PDF-arbetsflödessteg

XDP-mallen och de data som ska sammanfogas med mallen anges här. De data som ska sammanfogas är de data som har skickats från PDF. Dessa skickade data lagras under noden ```/content/formsubmissions```

![arbetsflöde](assets/generate-pdf1.PNG)

Den genererade PDF-variabeln är tilldelad till arbetsflödesvariabeln `submittedPDF`.

![arbetsflöde](assets/generate-pdf2.PNG)

### Tilldela den genererade PDF-filen för granskning och godkännande

Tilldela arbetsflödeskomponent för uppgift används här för att tilldela den genererade PDF för granskning och godkännande. Variabeln `submittedPDF` används på fliken Forms och dokument i arbetsflödeskomponenten Tilldela uppgift.

![arbetsflöde](assets/assign-task.PNG)


## Nästa steg

[Distribuera resurserna i din miljö](./deploy-assets.md)
