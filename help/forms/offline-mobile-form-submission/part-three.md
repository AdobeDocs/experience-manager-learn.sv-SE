---
title: AEM arbetsflöde vid HTML5-formuläröverföring
seo-title: AEM arbetsflödet vid inskickning av HTML5-formulär
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
seo-description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
feature: mobilformulär
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '190'
ht-degree: 0%

---


# Arbetsflöde för att granska och godkänna den skickade PDF-filen

Det sista och sista steget är att skapa AEM arbetsflöde som genererar en statisk eller icke-interaktiv PDF för granskning och godkännande. Arbetsflödet utlöses via en AEM som konfigurerats på noden `/content/pdfsubmissions`.

Följande skärmbild visar de steg som ingår i arbetsflödet.

![arbetsflöde](assets/workflow.PNG)

## Skapa icke-interaktivt PDF-arbetsflödessteg

XDP-mallen och de data som ska sammanfogas med mallen anges här. De data som ska sammanfogas är de data som skickas från PDF-filen. Dessa skickade data lagras under noden `/content/pdfsubmissions`.

![arbetsflöde](assets/generate-pdf1.PNG)

Den genererade PDF-filen tilldelas arbetsflödesvariabeln `submittedPDF`.

![arbetsflöde](assets/generate-pdf2.PNG)

### Tilldela den genererade PDF-filen för granskning och godkännande

Tilldela arbetsflödeskomponent för uppgift används här för att tilldela den genererade PDF-filen för granskning och godkännande. Variabeln `submittedPDF` används på fliken Forms och dokument i arbetsflödeskomponenten Tilldela uppgift.

![arbetsflöde](assets/assign-task.PNG)
