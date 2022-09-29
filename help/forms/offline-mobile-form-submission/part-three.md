---
title: Starta AEM arbetsflöde för att skicka HTML5-formulär - Granska och godkänn PDF
seo-title: Trigger AEM Workflow on HTML5 Form Submission
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
seo-description: Continue filling mobile form in offline mode and submit mobile form to trigger AEM workflow
feature: Mobile Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: a767d8f8-d75e-4472-9139-c08d804ee076
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '170'
ht-degree: 0%

---

# Arbetsflöde för att granska och godkänna det inskickade PDF

Det sista och sista steget är att skapa AEM arbetsflöde som genererar ett statiskt eller icke-interaktivt PDF för granskning och godkännande. Arbetsflödet utlöses via en AEM som konfigurerats på noden `/content/pdfsubmissions`.

Följande skärmbild visar de steg som ingår i arbetsflödet.

![arbetsflöde](assets/workflow.PNG)

## Skapa icke-interaktivt arbetsflödessteg för PDF

XDP-mallen och de data som ska sammanfogas med mallen anges här. De data som ska sammanfogas är de data som har skickats från PDF. Dessa skickade data lagras under noden `/content/pdfsubmissions`.

![arbetsflöde](assets/generate-pdf1.PNG)

Det genererade PDF tilldelas arbetsflödesvariabeln som anropas `submittedPDF`.

![arbetsflöde](assets/generate-pdf2.PNG)

### Tilldela den genererade PDF-filen för granskning och godkännande

Tilldela arbetsflödeskomponent för uppgift används här för att tilldela den genererade PDF för granskning och godkännande. Variabeln `submittedPDF` används på fliken Forms och Dokument i arbetsflödeskomponenten Tilldela uppgift.

![arbetsflöde](assets/assign-task.PNG)
