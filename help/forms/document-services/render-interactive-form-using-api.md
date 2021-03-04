---
title: Utveckla med Output och Forms Services i AEM Forms
seo-title: Utveckla med Output och Forms Services i AEM Forms
description: Använda API:er för Output och Forms Service i AEM Forms
seo-description: Använda API:er för Output och Forms Service i AEM Forms
feature: form-service
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '348'
ht-degree: 0%

---


# Återge interaktiv PDF med Forms Services i AEM Forms

Använda Forms Service API i AEM Forms för att återge interaktiv PDF

I den här artikeln ska vi ta en titt på följande tjänst

* FormsService - Det här är en mycket mångsidig tjänst som gör att du kan exportera/importera data från och till PDF-fil och även generera interaktiv PDF genom att sammanfoga XML-data i xdp-mall

Den officiella javadoc-filen för AEM Forms API visas [här](https://helpx.adobe.com/aem-forms/6/javadocs/com/adobe/fd/output/api/package-summary.html)

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

Rad2-4: Skapa PDFFormRenderOptions och ange dess egenskaper

Rad 7: Generera interaktiv PDF med tjänsten renderPDFForm i FormsService

Rad 11: Returnerar den genererade interaktiva PDF-filen till det anropande programmet

**Testa exempelpaketet på datorn**
1. [Hämta och installera exempelpaketet för Document Services med Felix Web Console](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
1. [Hämta och installera paketet med AEM pakethanterare](assets/downloadinteractivepdffrommobileform.zip)



1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter Adobe Granite CSRF-filter
1. Lägg till följande sökväg i de uteslutna avsnitten och spara
1. /bin/generateinteractivepdf
1. [Öppna mobilformuläret](http://localhost:4502/content/dam/formsanddocuments/schengen.xdp/jcr:content)
1. Fyll i några fält och klicka sedan på ***Hämta och fyll i ....*** button
1. Den interaktiva PDF-filen bör laddas ned till ditt lokala system


Exempelpaketet innehåller den anpassade profil som är associerad med mobilformuläret. Titta närmare på filen [custom toolbar.jsp](http://localhost:4502/apps/AEMFormsDemoListings/customprofiles/addImageToMobileForm/demo/customtoolbar.jsp). Denna jsp extraherar data från mobilformuläret och gör en begäran om POST till serverlet som är monterad på sökvägen ***/bin/generateinteractivepdf***. Servern returnerar den interaktiva PDF-filen till det anropande programmet. Koden i det anpassade verktygsfältet.jsp hämtar sedan filen till ditt lokala system


