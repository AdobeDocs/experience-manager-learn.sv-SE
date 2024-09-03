---
title: Starta AEM arbetsflöde vid HTML 5-formulärskickning - granska och godkänn PDF
description: Arbetsflöde för att granska det inskickade PDF
feature: Mobile Forms
doc-type: article
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
jira: kt-16133
exl-id: a767d8f8-d75e-4472-9139-c08d804ee076
duration: 32
source-git-commit: 9545fae5a5f5edd6f525729e648b2ca34ddbfd9f
workflow-type: tm+mt
source-wordcount: '169'
ht-degree: 0%

---

# Arbetsflöde för att granska och godkänna det inskickade PDF

Det sista och sista steget är att skapa AEM arbetsflöde som genererar ett statiskt eller icke-interaktivt PDF för granskning och godkännande. Arbetsflödet utlöses via en AEM startare som konfigurerats på noden `/content/formsubmissions`.

Följande skärmbild visar de steg som ingår i arbetsflödet.

![arbetsflöde](assets/workflow.PNG)

## Generera icke-interaktivt arbetsflödessteg för PDF

XDP-mallen och de data som ska sammanfogas med mallen anges här. De data som ska sammanfogas är de data som har skickats från PDF. Dessa skickade data lagras under noden ```/content/formsubmissions```

![arbetsflöde](assets/generate-pdf1.PNG)

Det genererade PDF tilldelas arbetsflödesvariabeln `submittedPDF`.

![arbetsflöde](assets/generate-pdf2.PNG)

### Tilldela den genererade PDF-filen för granskning och godkännande

Tilldela arbetsflödeskomponent för uppgift används här för att tilldela den genererade PDF för granskning och godkännande. Variabeln `submittedPDF` används på fliken Forms och dokument i arbetsflödeskomponenten Tilldela uppgift.

![arbetsflöde](assets/assign-task.PNG)


## Nästa steg

[Distribuera resurserna i din miljö](./deploy-assets.md)