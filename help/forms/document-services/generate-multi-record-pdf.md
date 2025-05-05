---
title: Generera flera PDF-filer från en datafil
description: OutputService innehåller ett antal metoder för att skapa dokument med hjälp av en formulärdesign och data som ska sammanfogas med formulärdesignen. Lär dig att generera flera PDF-filer från en stor XML som innehåller flera enskilda poster.
feature: Output Service
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
exl-id: 58582acd-cabb-4e28-9fd3-598d3cbac43c
last-substantial-update: 2020-01-07T00:00:00Z
duration: 138
jira: KT-16142
badgeVersions: label="AEM Forms 6.5" before-title="false"
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '498'
ht-degree: 0%

---

# Generera en uppsättning PDF-dokument från en XML-datafil

OutputService innehåller ett antal metoder för att skapa dokument med hjälp av en formulärdesign och data som ska sammanfogas med formulärdesignen. I följande artikel förklaras hur du kan generera flera PDF-filer från en stor XML-fil som innehåller flera enskilda poster.
Nedan visas en skärmbild av XML-filen som innehåller flera poster.

![multi-record-xml](assets/multi-record-xml.PNG)

Data-xml har 2 poster. Varje post representeras av elementet form1. Den här xml-filen skickas till OutputService-metoden [generatePDFOutputBatch](https://helpx.adobe.com/se/aem-forms/6/javadocs/com/adobe/fd/output/api/OutputService.html). Vi får en lista över PDF-dokument (en per post)
Signaturen för metoden generatePDFOutputBatch har följande parametrar

* mallar - Karta som innehåller mallen, identifierad med en nyckel
* data - Karta som innehåller XML-datadokument, identifierad med nyckel
* pdfOutputOptions - alternativ för att konfigurera PDF-generering
* batchOptions - options to configure batch



## Använd ärendeinformation{#use-case-details}

I det här fallet kommer vi att tillhandahålla ett enkelt webbgränssnitt för att överföra mallen och XML-filen. När överföringen av filerna är klar och POST-begäran skickas till AEM-servern. Den här servern extraherar dokumenten och anropar metoden generatePDFOutputBatch i OutputService. Den genererade PDF-filen zippas in i en zip-fil och görs tillgänglig för slutanvändaren för hämtning från webbläsaren.

## Servlet Code{#servlet-code}

Nedan följer kodfragmentet från serverleten. Koden extraherar mallen(xdp) och datafilen(xml) från begäran. Mallfilen sparas i filsystemet. Två kartor skapas - templateMap och dataFileMap som innehåller mallen respektive xml(data)-filerna. Därefter anropas metoden generateMultipleRecords för DocumentServices-tjänsten.

```java
for (final java.util.Map.Entry < String, org.apache.sling.api.request.RequestParameter[] > pairs: params
.entrySet()) {
final String key = pairs.getKey();
final org.apache.sling.api.request.RequestParameter[] pArr = pairs.getValue();
final org.apache.sling.api.request.RequestParameter param = pArr[0];
try {
if (!param.isFormField()) {

if (param.getFileName().endsWith("xdp")) {
    final InputStream xdpStream = param.getInputStream();
    com.adobe.aemfd.docmanager.Document xdpDocument = new com.adobe.aemfd.docmanager.Document(xdpStream);

    xdpDocument.copyToFile(new File(saveLocation + File.separator + "fromui.xdp"));
    templateMap.put("key1", "file://///" + saveLocation + File.separator + "fromui.xdp");
    System.out.println("####  " + param.getFileName());

}
if (param.getFileName().endsWith("xml")) {
    final InputStream xmlStream = param.getInputStream();
    com.adobe.aemfd.docmanager.Document xmlDocument = new com.adobe.aemfd.docmanager.Document(xmlStream);
    dataFileMap.put("key1", xmlDocument);
}
}

Document zippedDocument = documentServices.generateMultiplePdfs(templateMap, dataFileMap,saveLocation);
.....
.....
....
```

### Kod för implementering av gränssnitt{#Interface-Implementation-Code}

Följande kod genererar flera PDF-filer med OutputService-genereringenPDFOutputBatch och returnerar en ZIP-fil som innehåller PDF-filerna till den anropande servern

```java
public Document generateMultiplePdfs(HashMap < String, String > templateMap, HashMap < String, Document > dataFileMap, String saveLocation) {
    log.debug("will save generated documents to " + saveLocation);
    com.adobe.fd.output.api.PDFOutputOptions pdfOptions = new com.adobe.fd.output.api.PDFOutputOptions();
    pdfOptions.setAcrobatVersion(com.adobe.fd.output.api.AcrobatVersion.Acrobat_11);
    com.adobe.fd.output.api.BatchOptions batchOptions = new com.adobe.fd.output.api.BatchOptions();
    batchOptions.setGenerateManyFiles(true);
    com.adobe.fd.output.api.BatchResult batchResult = null;
    try {
        batchResult = outputService.generatePDFOutputBatch(templateMap, dataFileMap, pdfOptions, batchOptions);
        FileOutputStream fos = new FileOutputStream(saveLocation + File.separator + "zippedfile.zip");
        ZipOutputStream zipOut = new ZipOutputStream(fos);
        FileInputStream fis = null;

        for (int i = 0; i < batchResult.getGeneratedDocs().size(); i++) {
              com.adobe.aemfd.docmanager.Document dataMergedDoc = batchResult.getGeneratedDocs().get(i);
            log.debug("Got document " + i);
            dataMergedDoc.copyToFile(new File(saveLocation + File.separator + i + ".pdf"));
            log.debug("saved file " + i);
            File fileToZip = new File(saveLocation + File.separator + i + ".pdf");
            fis = new FileInputStream(fileToZip);
            ZipEntry zipEntry = new ZipEntry(fileToZip.getName());
            zipOut.putNextEntry(zipEntry);
            byte[] bytes = new byte[1024];
            int length;
            while ((length = fis.read(bytes)) >= 0) {
                zipOut.write(bytes, 0, length);
            }
            fis.close();
        }
        zipOut.close();
        fos.close();
        Document zippedDocument = new Document(new File(saveLocation + File.separator + "zippedfile.zip"));
        log.debug("Got zipped file from file system");
        return zippedDocument;


    } catch (OutputServiceException | IOException e) {

        e.printStackTrace();
    }
    return null;


}
```

### Distribuera på servern{#Deploy-on-your-server}

Följ instruktionerna nedan om du vill testa den här funktionen på servern:

* [Hämta exempelresurserna](assets/mult-records-template-and-xml-file.zip).Den här zip-filen innehåller mallen och XML-datafilen.
* [Peka din webbläsare på Felix-webbkonsolen](http://localhost:4502/system/console/bundles)
* [Distribuera DevelopingWithServiceUser Bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar).
* Lägg till följande post i användarmappningstjänsten för Apache Sling Service med configMgr.

```java
DevelopingWithServiceUser.core:getformsresourceresolver=fd-service
```



![user-mapper-service](assets/user-mapper-service-fd-service.png)

* [Distribuera anpassat AEMFormsDocumentServices-paket](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar).Anpassat paket som genererar PDF-filerna med OutputService API
* [Peka webbläsaren på pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* [Importera och installera paketet](assets/generate-multiple-pdf-from-xml.zip). Det här paketet innehåller HTML-sidor som gör att du kan släppa mallen och datafilerna.
* [Peka webbläsaren på MultiRecords.html](http://localhost:4502/content/DocumentServices/Multirecord.html?)
* Dra och släpp mallen och XML-datafilen tillsammans
* Ladda ned zip-filen som skapats. Den här zip-filen innehåller de PDF-filer som genereras av utdatatjänsten.

>[!NOTE]
>Det finns flera sätt att aktivera den här funktionen. I det här exemplet har vi använt ett webbgränssnitt för att släppa mallen och datafilen för att demonstrera funktionen.
