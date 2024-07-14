---
title: Använda PDFG i AEM Forms
description: Uppvisa dra och släpp-funktioner för att skapa PDF med AEM Forms
feature: PDF Generator
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: bc79fcbf-b8b3-4d3a-9cd6-0bcd9321c7d5
last-substantial-update: 2020-07-07T00:00:00Z
duration: 52
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '245'
ht-degree: 0%

---

# Använda PDFG i AEM Forms{#using-pdfg-in-aem-forms}

Uppvisa dra och släpp-funktioner för att skapa PDF med AEM Forms

PDFG står för PDF Generation. Det innebär att du kan konvertera en mängd olika filformat till PDF. De vanligaste är Microsoft Office-dokument. PDFG har tillhört AEM Forms sedan 6.1.
[Javadoc för PDFG API visas här](https://www.adobe.io/experience-manager/reference-materials/6-5/forms/javadocs/index.html?com/adobe/fd/output/api/OutputService.html)

Med de resurser som är kopplade till den här artikeln kan du dra och släppa MS Office-dokument eller JPG-filer i släppzonen på HTML-sidan. När dokumentet har släppts anropas PDFG-tjänsten och dokumentet konverteras till PDF och sparas i filsystemet i AEM Server.

Så här installerar du demoresurserna:

1. Konfigurera PDFG enligt det här dokumentet [här](https://helpx.adobe.com/experience-manager/6-4/forms/using/install-configure-pdf-generator.html).
1. Följ lämplig dokumentation för din AEM Forms-version.
1. [Importera och installera resurser som är relaterade till den här artikeln med hjälp av pakethanteraren.](assets/createpdfgdemov2.zip)
1. [Navigera till post.jsp](http://localhost:4502/apps/AemFormsSamples/components/createPDF/POST.jsp) i din CRX
1. Ändra platsen där du vill spara (rad 9)
1. Spara ändringarna.
1. Öppna [html-sidan](http://localhost:4502/content/DocumentServices/CreatePDFG.html) för att dra och släppa filer för konvertering.
1. Släpp en ordfil eller jpg i släppzonen.
1. Indatadokumentet konverteras till PDF och sparas på samma plats som anges i punkt 4.

Följande kodutdrag visar hur PDFG-tjänsten används för att konvertera filer till PDF

```java
com.adobe.pdfg.service.api.GeneratePDFService pdfService = sling.getService(com.adobe.pdfg.service.api.GeneratePDFService.class);
System.out.println("Got PDF Service");
java.util.Map map = pdfService.createPDF(uploadedDocument,fileName,"","Standard","No Security", null, null);
```
