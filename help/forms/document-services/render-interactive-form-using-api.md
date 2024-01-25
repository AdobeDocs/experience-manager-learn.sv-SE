---
title: Återgivning av interaktiv PDF med Forms Services i AEM Forms
description: Använda Forms Service API i AEM Forms för att återge interaktiv PDF
feature: Forms Service
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 9b2ef4c9-8360-480d-9165-f56a959635fb
last-substantial-update: 2020-07-07T00:00:00Z
duration: 87
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '341'
ht-degree: 0%

---

# Återgivning av interaktiv PDF med Forms Services i AEM Forms

Använda Forms Service API i AEM Forms för att återge interaktiv PDF

I den här artikeln ska vi ta en titt på följande tjänst

* FormsService - Det här är en mycket mångsidig tjänst som gör att du kan exportera/importera data från och till PDF-fil och även generera interaktiv PDF genom att sammanfoga XML-data i xdp-mall

Tjänstemannen [javadoc for AEM Forms API finns här](https://helpx.adobe.com/aem-forms/6/javadocs/com/adobe/fd/output/api/package-summary.html)

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

Rad 7: Generera interaktivt PDF med hjälp av tjänsten renderPDFForm i FormsService

Rad 1: Returnerar den genererade interaktiva PDF-filen till det anropande programmet

**Testa exempelpaketet på datorn**
1. [Hämta och installera DevelopingWithServiceUserBundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
1. [Hämta och installera exempelpaketet för Document Services med Felix Web Console](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
1. [Hämta och installera paketet med AEM pakethanterare](assets/downloadinteractivepdffrommobileform.zip)

1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter Adobe Granite CSRF-filter
1. Lägg till följande sökväg i de uteslutna avsnitten och spara
1. /bin/generateinteractivepdf
1. Sök efter _Användarmappningstjänsten för Apache Sling-tjänsten_ och klicka för att öppna egenskaperna
   1. Klicka på *+* ikon (plus) för att lägga till följande Service Mapping
      * DevelopingWithServiceUser.core:getformsresourceresolver=fd-service
   1. Klicka på Spara
1. [Öppna mobilformuläret](http://localhost:4502/content/dam/formsanddocuments/schengen.xdp/jcr:content)
1. Fyll i några fält och klicka sedan på ***Hämta och fyll i...*** knapp
1. Den interaktiva PDF-filen bör laddas ned till ditt lokala system


Exempelpaketet innehåller den anpassade profil som är associerad med mobilformuläret. Utforska [custom toolbar.jsp](http://localhost:4502/apps/AEMFormsDemoListings/customprofiles/addImageToMobileForm/demo/customtoolbar.jsp) -fil. Detta jsp extraherar data från mobilformuläret och gör en begäran om POST till serverutrymmet som är monterat på ***/bin/generateinteractivepdf*** bana. Servern returnerar den interaktiva PDF-filen till det anropande programmet. Koden i det anpassade verktygsfältet.jsp hämtar sedan filen till ditt lokala system
