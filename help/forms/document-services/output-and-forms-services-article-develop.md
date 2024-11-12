---
title: Utveckla med Output och Forms Services i AEM Forms
description: Lär dig hur du utvecklar med Output och Forms Service API i AEM Forms.
feature: Output Service
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
last-substantial-update: 2024-01-29T00:00:00Z
exl-id: d268d5d6-f24f-4db9-b8e0-07dd769c6005
duration: 122
source-git-commit: 12af84e3d9be24fabb01a64eced6279749668599
workflow-type: tm+mt
source-wordcount: '565'
ht-degree: 0%

---

# Utveckla med Output och Forms Services i AEM Forms{#developing-with-output-and-forms-services-in-aem-forms}

Lär dig hur du utvecklar med Output och Forms Service API i AEM Forms.

I den här artikeln ska vi titta på följande

* [Utdatatjänst](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javadocs/index.html?com/adobe/fd/output/api/OutputService.html) - Vanligtvis används den här tjänsten för att sammanfoga XML-data med xdp-mall eller pdf för att generera sammanlagd pdf.
* [FormsService](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javadocs/com/adobe/fd/forms/api/FormsService.html) - Det här är en mycket mångsidig tjänst som gör att du kan återge xdp som pdf och exportera/importera data från och till PDF.


Följande kodfragment exporterar data från PDF-filen

```java
javax.servlet.http.Part pdfPart = request.getPart("pdffile");
String filePath = request.getParameter("saveLocation");
java.io.InputStream pdfIS = pdfPart.getInputStream();
com.adobe.aemfd.docmanager.Document pdfDocument = new com.adobe.aemfd.docmanager.Document(pdfIS);
com.adobe.fd.forms.api.FormsService formsservice = sling.getService(com.adobe.fd.forms.api.FormsService.class);
com.adobe.aemfd.docmanager.Document xmlDocument = formsservice.exportData(pdfDocument,com.adobe.fd.forms.api.DataFormat.Auto);
```

Rad 1 extraherar pdffile från begäran

Line2 extraherar saveLocation från begäran

Rad 5 får plats i FormsService

Rad 6 exporterar xmlData från PDF-filen

**Testa exempelpaketet på datorn**

[Hämta och installera paketet med AEM pakethanterare](assets/using-output-and-form-service-api.zip)




**När du har installerat paketet måste du tillåtslista följande URL:er i Adobe Granite CSRF-filtret.**

1. Följ stegen nedan för att tillåtslista de sökvägar som nämns ovan.
1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter Adobe Granite CSRF-filter
1. Lägg till följande tre banor i de uteslutna avsnitten och spara
1. /content/AemFormsSamples/mergedata
1. /content/AemFormsSamples/exportdata
1. /content/help/seFormsSamples/outputService
1. /content/AemFormsSamples/renderxdp
1. Sök efter filtret &quot;Sling Referrer&quot;
1. Markera kryssrutan Tillåt tomt. (Den här inställningen bör endast användas i testsyfte)

## Testa proverna

Du kan testa exempelkoden på flera olika sätt. Det snabbaste och enklaste är att använda Postman. Med Postman kan du göra förfrågningar om POST till servern.

* Installera Postman-appen på datorn.
* Starta programmet och ange rätt URL
* Se till att du har valt &quot;POST&quot; i listrutan
* Ange&quot;Authorization&quot; som&quot;Basic Auth&quot;. Ange AEM användarnamn och lösenord
* Ange parametrarna för begäran på fliken Innehåll
* Klicka på knappen Skicka

Paketet innehåller fyra exempel. I följande stycken förklaras när utdatatjänsten eller Forms-tjänsten ska användas, tjänstens URL, indataparametrar som förväntas av varje tjänst

## Använda OutputService för att sammanfoga data med xdp-mall

* Använd Utdatatjänst för att sammanfoga data med xdp- eller pdf-dokument för att generera sammanlagd PDF
* **POSTS-URL**: http://localhost:4502/content/AemFormsSamples/outputservice.html
* **Begäranparametrar -**

   * **xdp_or_pdf_file** : Den xdp- eller pdf-fil som du vill sammanfoga data med
   * **xmlfile**: XML-datafilen som sammanfogas med xdp_or_pdf_file
   * **saveLocation**: Den plats där det återgivna dokumentet ska sparas i filsystemet. Till exempel c:\\documents\\sample.pdf

### Använda FormsService API

#### Importera data

* Använd FormsService-importData för att importera data till PDF-filen
* **POST-URL** - http://localhost:4502/content/AemFormsSamples/mergedata.html

* **Begärandeparametrar:**

   * **pdffile** : PDF-filen som du vill sammanfoga data med
   * **xmlfile**: XML-datafilen som sammanfogas med pdf-filen
   * **saveLocation**: Den plats där det återgivna dokumentet ska sparas i filsystemet. Till exempel `c:\\outputsample.pdf`.

#### Exportera data

* Använd FormsService-API:t för export av data från PDF-filen
* **POST-URL** - http://localhost:4502/content/AemFormsSamples/exportdata.html
* **Begärandeparametrar:**

   * **pdffile** : PDF-filen som du vill exportera data från
   * **saveLocation**: Platsen där exporterade data ska sparas i filsystemet. Till exempel c:\\documents\\exported_data.xml

#### Återge XDP

* Återge XDP-mall som statisk/dynamisk pdf
* Använd FormsService-återgivnings-API:t PDFForm för att återge xdp-mallen som PDF
* **POST-URL** - http://localhost:4502/content/AemFormsSamples/renderxdp?xdpName=f1040.xdp
* Begäranparameter:
   * xdpName: Namnet på xdp-filen som ska återges som en pdf

[Du kan importera den här postmansamlingen för att testa API:t](assets/UsingDocumentServicesInAEMForms.postman_collection.json)

