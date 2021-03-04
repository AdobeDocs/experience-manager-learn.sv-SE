---
title: Använda PDFG i AEM Forms
seo-title: Använda PDFG i AEM Forms
description: Uppvisa dra och släpp-funktioner för att skapa PDF med AEM Forms
seo-description: Uppvisa dra och släpp-funktioner för att skapa PDF med AEM Forms
uuid: ee54edb4-a7b1-42ed-81ea-cb6bef6cf97f
feature: pdf-generator
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
discoiquuid: 7f570f12-ce43-4da7-a249-ef6bd0fe48e5
topic: Utveckling
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '285'
ht-degree: 0%

---


# Använda PDFG i AEM Forms{#using-pdfg-in-aem-forms}

Uppvisa dra och släpp-funktioner för att skapa PDF med AEM Forms

PDFG står för PDF Generation. Det innebär att du kan konvertera en mängd olika filformat till PDF. De vanligaste är Microsoft Office-dokument. PDFG har varit en del av AEM Forms sedan 6.1.
[Javadoc for PDFG API listas här](https://helpx.adobe.com/experience-manager/6-3/forms/using/aem-document-services-programmatically.html#PDFGeneratorService)

Med resurserna som är kopplade till den här artikeln kan du dra och släppa MS Office-dokument eller JPG-filer i HTML-sidans släppzon. När dokumentet har släppts anropas PDFG-tjänsten och dokumentet konverteras till PDF-format och sparas i filsystemet på AEM Server.

Så här installerar du demoresurserna:

1. Konfigurera PDFG enligt anvisningarna i det här dokumentet [här](https://helpx.adobe.com/experience-manager/6-4/forms/using/install-configure-pdf-generator.html).
1. Följ lämplig dokumentation för din AEM Forms-version.
1. [Importera och installera resurser som är relaterade till den här artikeln med hjälp av pakethanteraren.](assets/createpdfgdemov2.zip)
1. [Navigera till post.](http://localhost:4502/apps/AemFormsSamples/components/createPDF/POST.jsp) jspin i din CRX
1. Ändra platsen där du vill spara (rad 9)
1. Spara ändringarna.
1. Öppna HTML-sidan [](http://localhost:4502/content/DocumentServices/CreatePDFG.html) för att dra och släppa filer för konvertering.
1. Släpp en ordfil eller jpg i släppzonen.
1. Indatadokumentet konverteras till PDF och sparas på samma plats som anges i punkt 4.

I följande kodutdrag visas hur PDFG-tjänsten används för att konvertera filer till PDF

```java
com.adobe.pdfg.service.api.GeneratePDFService pdfService = sling.getService(com.adobe.pdfg.service.api.GeneratePDFService.class);
System.out.println("Got PDF Service");
java.util.Map map = pdfService.createPDF(uploadedDocument,fileName,"","Standard","No Security", null, null);
```

