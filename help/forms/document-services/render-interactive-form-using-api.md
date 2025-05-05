---
title: Rendering Interactive PDF using Forms Services in AEM Forms
description: Använda Forms Service API i AEM Forms för att återge interaktiva PDF
feature: Forms Service
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 9b2ef4c9-8360-480d-9165-f56a959635fb
last-substantial-update: 2020-07-07T00:00:00Z
duration: 75
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '341'
ht-degree: 0%

---

# Rendering Interactive PDF using Forms Services in AEM Forms

Använda Forms Service API i AEM Forms för att återge interaktiva PDF

I den här artikeln ska vi ta en titt på följande tjänst

* FormsService - Det här är en mycket mångsidig tjänst som gör att du kan exportera/importera data från och till PDF-filer och även generera interaktiv PDF genom att sammanfoga XML-data i xdp-mallen

Tjänstemannen [javadoc för AEM Forms API visas här](https://helpx.adobe.com/se/aem-forms/6/javadocs/com/adobe/fd/output/api/package-summary.html)

Följande kodfragment återger interaktiv pdf med hjälp av åtgärden renderPDFForm i FormsService. Schishing.xdp är en mall som används för att sammanfoga xml-data.

```java
String uri = "crx:///content/dam/formsanddocuments";
PDFFormRenderOptions renderOptions = new PDFFormRenderOptions();
renderOptions.setAcrobatVersion(AcrobatVersion.Acrobat_11);
renderOptions.setContentRoot(uri);
Document interactivePDF = null;
try {
interactivePDF = formsService.renderPDFForm("schengen.xdp", xmlData, renderOptions);
} catch (FormsServiceException e) {
 e.printStackTrace();
}
return interactivePDF;
```

Rad 1: Sökväg till mappen som innehåller xdp-mallen

Line2-4: Skapa PDFormRenderOptions och ange dess egenskaper

Rad 7: Generera interaktiv PDF med tjänsten renderPDFForm i FormsService

Rad 1: Returnerar den genererade interaktiva PDF-filen till det anropande programmet

**Testa exempelpaketet på datorn**
1. [Hämta och installera DevelopingWithServiceUserBundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
1. [Hämta och installera exempelpaketet för Document Services med Felix Web Console](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
1. [Hämta och installera paketet med AEM pakethanterare](assets/downloadinteractivepdffrommobileform.zip)

1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter Adobe Granite CSRF-filter
1. Lägg till följande sökväg i de uteslutna avsnitten och spara
1. /bin/generateinteractivepdf
1. Sök efter _användarmappningstjänsten för Apache Sling-tjänsten_ och klicka för att öppna egenskaperna
   1. Klicka på ikonen *+* (plus) för att lägga till följande tjänstmappning
      * DevelopingWithServiceUser.core:getformsresourceresolver=fd-service
   1. Klicka på Spara
1. [Öppna mobilformuläret](http://localhost:4502/content/dam/formsanddocuments/schengen.xdp/jcr:content)
1. Fyll i några fält och klicka sedan på ***Hämta och fyll i ...***-knapp
1. Den interaktiva PDF-filen bör laddas ned till ditt lokala system


Exempelpaketet innehåller den anpassade profil som är associerad med mobilformuläret. Utforska filen [custom toolbar.jsp](http://localhost:4502/apps/AEMFormsDemoListings/customprofiles/addImageToMobileForm/demo/customtoolbar.jsp). Denna jsp extraherar data från det mobila formuläret och gör en POST-begäran till en servlet som är monterad på sökvägen ***/bin/generateinteractivepdf***. Servern returnerar den interaktiva PDF-filen till det anropande programmet. Koden i det anpassade verktygsfältet.jsp hämtar sedan filen till ditt lokala system
