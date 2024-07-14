---
title: Visa dokument med post textbundet
description: Sammanfoga adaptiva formulärdata med XDP-mall och visa PDF textbundet med dokumentmolnets inbäddade PDF-API.
version: 6.4,6.5
feature: Forms Service
topic: Development
role: Developer
level: Experienced
jira: KT-9411
exl-id: 327ffe26-e88e-49f0-9f5a-63e2a92e1c8a
last-substantial-update: 2021-07-07T00:00:00Z
duration: 165
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '509'
ht-degree: 0%

---

# Visa DoR textbundet

Ett vanligt användningssätt är att visa ett PDF-dokument med de data som användaren har angett.

Vi har använt [Adobe PDF Embed API](https://www.adobe.io/apis/documentcloud/dcsdk/pdf-embed.html) för att uppnå den här användningen.

Följande steg utfördes för att slutföra integreringen

## Skapa en anpassad komponent för att visa PDF textbundet

En anpassad komponent (embed-pdf) skapades för att bädda in den PDF-fil som returneras av POSTEN.

## Klientbibliotek

Följande kod körs när användaren klickar på kryssruteknappen `viewPDF`. Vi skickar adaptiva formulärdata, mallnamn till slutpunkten för att generera PDF-filen. Den genererade PDF-filen visas sedan för formuläranvändaren med hjälp av JavaScript-biblioteket för inbäddning.

```javascript
$(document).ready(function() {

    $(".viewPDF").click(function() {
        console.log("view pdfclicked");
        window.guideBridge.getDataXML({
            success: function(result) {
                var obj = new FormData();
                obj.append("data", result.data);
                obj.append("template", document.querySelector("[data-template]").getAttribute("data-template"));
                const fetchPromise = fetch(document.querySelector("[data-endpoint]").getAttribute("data-endpoint"), {
                        method: "POST",
                        body: obj,
                        contentType: false,
                        processData: false,

                    })
                    .then(response => {

                        var adobeDCView = new AdobeDC.View({
                            clientId: document.querySelector("[data-apikey]").getAttribute("data-apikey"),
                            divId: "adobe-dc-view"
                        });
                        console.log("In preview file");
                        adobeDCView.previewFile(

                            {
                                content: {
                                    promise: response.arrayBuffer()
                                },
                                metaData: {
                                    fileName: document.querySelector("[data-filename]").getAttribute("data-filename")
                                }
                            }
                        );


                        console.log("done")
                    })


            }
        });
    });



});
```

## Generera exempeldata för XDP

* Öppna XDP i AEM Forms Designer.
* Klicka på Arkiv | Formuläregenskaper | Förhandsgranska
* Klicka på Generera förhandsgranskningsdata
* Klicka på Generera
* Ange beskrivande filnamn som&quot;form-data.xml&quot;

## Generera XSD från XML-data

Du kan använda vilket som helst av de kostnadsfria onlineverktygen för att [generera XSD](https://www.freeformatter.com/xsd-generator.html) från de XML-data som genererades i föregående steg.

## Överför mallen

Se till att du överför xdp-mallen till [AEM Forms](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments) med knappen Skapa


## Skapa anpassat formulär

Skapa anpassningsbara formulär baserat på XSD från föregående steg.
Lägg till en ny flik i adaptiven. Lägg till en kryssrutekomponent och bädda in en pdf-komponent på den här fliken
Se till att du namnger kryssrutevyn PDF.
Konfigurera komponenten embed-pdf enligt skärmbilden nedan
![embed-pdf](assets/embed-pdf-configuration.png)

**Bädda in API-nyckel för PDF** - Det här är nyckeln som du kan använda för att bädda in PDF-filen. Den här nyckeln fungerar bara med localhost. Du kan skapa [din egen nyckel](https://www.adobe.io/apis/documentcloud/dcsdk/pdf-embed.html) och associera den med en annan domän.

**Slutpunkten som returnerar PDF-filen** - Det här är den anpassade servern som sammanfogar data med xdp-mallen och returnerar PDF-filen.

**Mallnamn** - Detta är sökvägen till xdp. Vanligtvis lagras den under mappen för formulärsanddokument.

**PDF-filnamn** - Det här är strängen som kommer att visas i den inbäddade PDF-komponenten.

## Skapa anpassad servett

En anpassad servlet skapades för att sammanfoga data med XDP-mallen och returnera PDF-filen. Koden för att uppnå detta listas nedan. Den anpassade servern ingår i det [inbäddade PDF-paketet](assets/embedpdf.core-1.0-SNAPSHOT.jar)

```java
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import javax.servlet.Servlet;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import com.adobe.aemfd.docmanager.Document;
import com.adobe.fd.output.api.OutputService;

package com.embedpdf.core.servlets;
@Component(service = {
   Servlet.class
}, property = {
   "sling.servlet.methods=post",
   "sling.servlet.paths=/bin/getPDFToEmbed"
})
public class StreamPDFToEmbed extends SlingAllMethodsServlet {
   @Reference
   OutputService outputService;
   private static final long serialVersionUID = 1 L;
   private static final Logger log = LoggerFactory.getLogger(StreamPDFToEmbed.class);

   protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) throws IOException {
      String xdpName = request.getParameter("template");
      String formData = request.getParameter("data");
      log.debug("in doPOST of Stream PDF Form Data is >>> " + formData + " template is >>> " + xdpName);

      try {

         XPathFactory xfact = XPathFactory.newInstance();
         XPath xpath = xfact.newXPath();
         DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
         DocumentBuilder builder = factory.newDocumentBuilder();

         org.w3c.dom.Document xmlDataDoc = builder.parse(new InputSource(new StringReader(formData)));

         // get the data to merge with template

         Node afBoundData = (Node) xpath.evaluate("afData/afBoundData", xmlDataDoc, XPathConstants.NODE);
         NodeList afBoundDataChildren = afBoundData.getChildNodes();
         String afDataNodeName = afBoundDataChildren.item(0).getNodeName();
         Node nodeWithDataToMerge = (Node) xpath.evaluate("afData/afBoundData/" + afDataNodeName, xmlDataDoc, XPathConstants.NODE);
         StringWriter writer = new StringWriter();
         Transformer transformer = TransformerFactory.newInstance().newTransformer();
         transformer.transform(new DOMSource(nodeWithDataToMerge), new StreamResult(writer));
         String xml = writer.toString();
         InputStream targetStream = new ByteArrayInputStream(xml.getBytes());
         Document xmlDataDocument = new Document(targetStream);
         // get the template
         Document xdpTemplate = new Document(xdpName);
         log.debug("got the  xdp Template " + xdpTemplate.length());

         // use output service the merge data with template
         com.adobe.fd.output.api.PDFOutputOptions pdfOptions = new com.adobe.fd.output.api.PDFOutputOptions();
         pdfOptions.setAcrobatVersion(com.adobe.fd.output.api.AcrobatVersion.Acrobat_11);
         com.adobe.aemfd.docmanager.Document documentToReturn = outputService.generatePDFOutput(xdpTemplate, xmlDataDocument, pdfOptions);

         // stream pdf to the client

         InputStream fileInputStream = documentToReturn.getInputStream();
         response.setContentType("application/pdf");
         response.addHeader("Content-Disposition", "attachment; filename=AemFormsRocks.pdf");
         response.setContentLength((int) fileInputStream.available());
         OutputStream responseOutputStream = response.getOutputStream();
         int bytes;
         while ((bytes = fileInputStream.read()) != -1) {
            responseOutputStream.write(bytes);
         }
         responseOutputStream.flush();
         responseOutputStream.close();

      } catch (Exception e) {

         System.out.println("Error " + e.getMessage());
      }

   }

}
```


## Distribuera exemplet på servern

Så här testar du detta på den lokala servern:

1. [Hämta och installera det inbäddade PDF-paketet](assets/embedpdf.core-1.0-SNAPSHOT.jar).
Detta har serverleten för att sammanfoga data med XDP-mallen och strömma tillbaka PDF-filen.
1. Lägg till sökvägen /bin/getPDFToEmbed i avsnittet Undantagna sökvägar i Adobe Granite CSRF-filtret med hjälp av [AEM ConfigMgr](http://localhost:4502/system/console/configMgr). I din produktionsmiljö bör du använda [CSRF-skyddsramverket](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/csrf-protection.html?lang=en)
1. [Importera klientbiblioteket och den anpassade komponenten](assets/embed-pdf.zip)
1. [Importera det adaptiva formuläret och mallen](assets/embed-pdf-form-and-xdp.zip)
1. [Förhandsgranska anpassat formulär](http://localhost:4502/content/dam/formsanddocuments/from1040/jcr:content?wcmmode=disabled)
1. Fylla i vissa formulärfält
1. Fliken Visa PDF. Markera kryssrutan Visa PDF. En PDF-fil ska visas i formuläret ifyllt med data från det adaptiva formuläret
