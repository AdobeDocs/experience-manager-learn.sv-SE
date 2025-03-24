---
title: Sammanfoga data med XDP-mallen
description: Skapa PDF-dokument genom att sammanfoga data med mallen
feature: Adaptive Forms
version: Experience Manager 6.5
jira: KT-15344
topic: Development
role: User
level: Intermediate
exl-id: 6a865402-db3d-4e0e-81a0-a15dace6b7ab
duration: 15
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '80'
ht-degree: 0%

---

# Sammanfoga data med XDP-mallen

Nästa steg är att sammanfoga XML-data med mallen för att generera PDF. Denna PDF skickas sedan för signering med Adobe Sign.

## Använda OutputService för att generera PDF

Metoden [generatePDF](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javadocs/com/adobe/fd/output/api/OutputService.html#generatePDFOutput-com.adobe.aemfd.docmanager.Document-com.adobe.aemfd.docmanager.Document-com.adobe.fd.output.api.PDFOutputOptions-) i OutputService användes för att generera PDF.
Den genererade PDF skickades sedan för signering med hjälp av Adobe Sign REST API.
