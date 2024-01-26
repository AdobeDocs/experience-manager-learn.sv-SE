---
title: Använda fragment i utdatatjänsten
description: Generera PDF-dokument med fragment i crx-databasen
feature: Output Service
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
last-substantial-update: 2022-07-09T00:00:00Z
exl-id: d7887e2e-c2d4-4f0c-b117-ba7c41ea539a
duration: 125
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '432'
ht-degree: 0%

---

# Generera PDF-dokument med fragment{#developing-with-output-and-forms-services-in-aem-forms}


I den här artikeln använder vi utdatatjänsten för att generera PDF-filer med hjälp av xdp-fragment. Den huvudsakliga xdp-filen och fragmenten finns i crx-databasen. Det är viktigt att efterlikna filsystemets mappstruktur i AEM. Om du till exempel använder ett fragment i fragmentmappen i xdp måste du skapa en mapp med namnet **fragment** under din AEM. Basmappen kommer att innehålla din bas-xdp-mall. Om du till exempel har följande struktur i filsystemet
* c:\xdptemplates - Detta kommer att innehålla xdp-basmallen
* c:\xdptemplates\fragments - Den här mappen innehåller fragment och huvudmallen refererar till fragmentet enligt nedan
  ![fragment-xdp](assets/survey-fragment.png).
* Mappens xdpdokument kommer att innehålla din basmall och fragmenten i **fragment** mapp

Du kan skapa den struktur som behövs med hjälp av [formulär och dokumentgränssnitt](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)

Nedan följer mappstrukturen för exempelkoden xdp som använder 2 fragment
![formulär&amp;dokument](assets/fragment-folder-structure-ui.png)


* Utdatatjänst - Vanligtvis används den här tjänsten för att sammanfoga XML-data med xdp-mall eller pdf för att generera sammanlagd pdf. Mer information finns i [javadoc](https://helpx.adobe.com/experience-manager/6-5/forms/javadocs/index.html?com/adobe/fd/output/api/OutputService.html) för Output-tjänsten. I det här exemplet använder vi fragment som finns i crx-databasen.


Följande kod användes för att inkludera fragment i PDF-filen

```java
System.out.println("I am in using fragments POST.jsp");
// contentRootURI is the base folder. All fragments are relative to this folder
String contentRootURI = request.getParameter("contentRootURI");
String xdpName = request.getParameter("xdpName");
javax.servlet.http.Part xmlDataPart = request.getPart("xmlDataFile");
System.out.println("Got xml file");
String filePath = request.getParameter("saveLocation");
java.io.InputStream xmlIS = xmlDataPart.getInputStream();
com.adobe.aemfd.docmanager.Document xmlDocument = new com.adobe.aemfd.docmanager.Document(xmlIS);
com.adobe.fd.output.api.OutputService outputService = sling.getService(com.adobe.fd.output.api.OutputService.class);

if (outputService == null) {
  System.out.println("The output service is  null.....");
} else {
  System.out.println("The output service is  not null.....");

}
com.adobe.fd.output.api.PDFOutputOptions pdfOptions = new com.adobe.fd.output.api.PDFOutputOptions();
pdfOptions.setAcrobatVersion(com.adobe.fd.output.api.AcrobatVersion.Acrobat_11);

pdfOptions.setContentRoot(contentRootURI);

com.adobe.aemfd.docmanager.Document generatedDocument = outputService.generatePDFOutput(xdpName, xmlDocument, pdfOptions);
generatedDocument.copyToFile(new java.io.File(filePath));
out.println("Document genreated and saved to " + filePath);
```

**Testa exempelpaketet på datorn**

* [Hämta och importera xdp-exempelfiler till AEM](assets/xdp-templates-fragments.zip)
* [Hämta och installera paketet med AEM pakethanterare](assets/using-fragments-assets.zip)
* [Exemplet xdp och fragment kan laddas ned härifrån](assets/xdptemplates.zip)

**När du har installerat paketet måste du tillåtslista följande URL:er i Adobe Granite CSRF-filtret.**

1. Följ stegen nedan för att tillåtslista de sökvägar som nämns ovan.
1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter Adobe Granite CSRF-filter
1. Lägg till följande sökväg i de uteslutna avsnitten och spara
1. /content/AemFormsSamples/usingFrments

Du kan testa exempelkoden på flera olika sätt. Det snabbaste och enklaste är att använda Postman. Med Postman kan du göra förfrågningar om POST till servern. Installera Postman-appen på datorn.
Starta programmet och ange följande URL för att testa API:t för exportdata

Se till att du har valt &quot;POST&quot; i listrutan http://localhost:4502/content/AemFormsSamples/usingfragments.html Kontrollera att du har angett &quot;Auktorisering&quot; som &quot;Grundläggande autentisering&quot;. Ange AEM användarnamn och lösenord Navigera till fliken &quot;Brödtext&quot; och ange parametrarna för begäran enligt bilden nedan
![export](assets/using-fragment-postman.png)
Klicka sedan på knappen Skicka

[Du kan importera den här postmansamlingen för att testa API:t](assets/usingfragments.postman_collection.json)
