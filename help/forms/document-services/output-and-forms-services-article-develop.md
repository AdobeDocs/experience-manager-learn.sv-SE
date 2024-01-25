---
title: Utveckla med Output och Forms Services i AEM Forms
description: Använda API:er för Output och Forms Service i AEM Forms
feature: Output Service
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: d268d5d6-f24f-4db9-b8e0-07dd769c6005
last-substantial-update: 2020-07-07T00:00:00Z
duration: 138
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '552'
ht-degree: 0%

---

# Utveckla med Output och Forms Services i AEM Forms{#developing-with-output-and-forms-services-in-aem-forms}

Använda API:er för Output och Forms Service i AEM Forms

I den här artikeln ska vi titta på följande

* Utdatatjänst - Vanligtvis används den här tjänsten för att sammanfoga XML-data med xdp-mall eller pdf för att generera sammanlagd pdf. Mer information finns här [javadoc](https://helpx.adobe.com/experience-manager/6-5/forms/javadocs/index.html?com/adobe/fd/output/api/OutputService.html) för Output-tjänsten.
* FormsService - Det här är en mycket mångsidig tjänst som gör att du kan exportera/importera data från och till PDF. Mer information finns här [javadoc](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javadocs/com/adobe/fd/forms/api/FormsService.html) för Forms.


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

[Hämta och installera paketet med AEM pakethanterare](assets/outputandformsservice.zip)




**När du har installerat paketet måste du tillåtslista följande URL:er i Adobe Granite CSRF-filtret.**

1. Följ stegen nedan för att tillåtslista de sökvägar som nämns ovan.
1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter Adobe Granite CSRF-filter
1. Lägg till följande tre banor i de uteslutna avsnitten och spara
1. /content/AemFormsSamples/mergedata
1. /content/AemFormsSamples/exportdata
1. /content/help/seFormsSamples/outputService
1. Sök efter filtret &quot;Sling Referrer&quot;
1. Markera kryssrutan Tillåt tomt. (Den här inställningen bör endast användas i testsyfte) Det finns flera sätt att testa exempelkoden. Det snabbaste och enklaste är att använda Postman. Med Postman kan du göra förfrågningar om POST till servern. Installera Postman-appen på datorn.
Starta programmet och ange följande URL för att testa API:t för exportdata

Se till att du har valt &quot;POST&quot; i listrutan http://localhost:4502/content/AemFormsSamples/exportdata.html Kontrollera att du har angett &quot;Auktorisering&quot; som &quot;Grundläggande autentisering&quot;. Ange AEM användarnamn och lösenord Navigera till fliken &quot;Brödtext&quot; och ange parametrarna för begäran enligt bilden nedan
![export](assets/postexport.png)
Klicka sedan på knappen Skicka

Paketet innehåller 3 exempel. I följande stycken förklaras när utdatatjänsten eller Forms-tjänsten ska användas, tjänstens URL, indataparametrar som förväntas av varje tjänst

## Lägg samman data och förenkla utdata

* Använd Utdatatjänst för att sammanfoga data med xdp- eller pdf-dokument för att generera sammanlagd PDF
* **POSTS-URL**: http://localhost:4502/content/AemFormsSamples/outputservice.html
* **Begäranparametrar -**

   * **xdp_or_pdf_file** : Den xdp- eller pdf-fil som du vill sammanfoga data med
   * **xmlfile**: XML-datafilen som sammanfogas med xdp_or_pdf_file
   * **saveLocation**: Den plats där det återgivna dokumentet ska sparas i filsystemet. Till exempel c:\\documents\\sample.pdf

### Importera data till PDF-fil

* Använd FormsService för att importera data till PDF-filen
* **POSTS-URL** - http://localhost:4502/content/AemFormsSamples/mergedata.html
* **Begärandeparametrar:**

   * **pdffile** : Den PDF-fil som du vill sammanfoga data med
   * **xmlfile**: XML-datafilen som sammanfogas med PDF-filen
   * **saveLocation**: Den plats där det återgivna dokumentet ska sparas i filsystemet. Till exempel `c:\\outputsample.pdf`.

**Exportera data från PDF-fil**
* Använd FormsService för att exportera data från PDF-fil
* **POST-UR** L - http://localhost:4502/content/AemFormsSamples/exportdata.html
* **Begärandeparametrar:**

   * **pdffile** : Den PDF-fil som du vill exportera data från
   * **saveLocation**: Den plats där exporterade data ska sparas i filsystemet. Till exempel c:\\documents\\exported_data.xml

[Du kan importera den här postmansamlingen för att testa API:t](assets/document-services-postman-collection.json)
