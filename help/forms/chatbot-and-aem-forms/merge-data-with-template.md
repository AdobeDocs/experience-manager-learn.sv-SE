---
title: Sammanfoga data med XDP-mallen
description: Skapa PDF-dokument genom att sammanfoga data med mallen
feature: Adaptive Forms
version: 6.5
jira: KT-15344
topic: Development
role: User
level: Intermediate
source-git-commit: eb4463ae0270725c5b0bd96e9799bada25b06303
workflow-type: tm+mt
source-wordcount: '80'
ht-degree: 0%

---

# Sammanfoga data med XDP-mallen

Nästa steg är att sammanfoga XML-data med mallen för att skapa PDF. PDF skickas sedan för signering med Adobe Sign.

## Använda OutputService för att generera PDF

The [generatePDF](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javadocs/com/adobe/fd/output/api/OutputService.html#generatePDFOutput-com.adobe.aemfd.docmanager.Document-com.adobe.aemfd.docmanager.Document-com.adobe.fd.output.api.PDFOutputOptions-) OutputService-metoden användes för att generera PDF.
Det genererade PDF skickades sedan för signering med Adobe Sign REST API.

