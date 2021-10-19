---
title: Generera interaktiv DoR med data i adaptiv form
description: Sammanfoga adaptiva formulärdata med XDP-mall för att generera en nedladdningsbar PDF
version: 6.4,6.5
feature: Forms Service
topic: Development
role: Developer
level: Experienced
kt: 9226
source-git-commit: 2ed78bb8b122acbe69e98d63caee1115615d568f
workflow-type: tm+mt
source-wordcount: '357'
ht-degree: 0%

---


# Hämta interaktiv DoR

Ett vanligt användningsexempel är att kunna ladda ned en interaktiv DoR med data från adaptiva formulär. Den hämtade versionen av DoR kommer sedan att fyllas i med Adobe Acrobat eller Adobe Reader.

För att uppnå detta måste vi göra följande

## Generera exempeldata för XDP

* Öppna XDP i AEM Forms Designer.
* Klicka på Arkiv | Formuläregenskaper | Förhandsgranska
* Klicka på Generera förhandsgranskningsdata
* Klicka på Generera
* Ange beskrivande filnamn som&quot;form-data.xml&quot;

## Generera XSD från XML-data

Du kan använda vilket som helst av de kostnadsfria onlineverktygen för att [generera XSD](https://www.freeformatter.com/xsd-generator.html) från XML-data som genererats i föregående steg.

## Skapa anpassat formulär

Skapa anpassningsbara formulär baserat på XSD från föregående steg. Koppla formuläret till klientens lib &quot;irs&quot;. Det här klientbiblioteket har koden för att göra ett anrop från POSTEN till servern som returnerar PDF till det anropande programmet. Följande kod aktiveras när _Hämta PDF_ klickas

```javascript
$(document).ready(function() {
    $(".downloadpdf").click(function() {
        window.guideBridge.getDataXML({
            success: function(guideResultObject) {
                var req = new XMLHttpRequest();

                req.open("POST", "/bin/generateinteractivedor", true);
                req.responseType = "blob";

                var formData = new FormData();
                formData.append("dataXml", guideResultObject.data);
                console.log(guideResultObject.data);
                req.send(formData);

                req.onreadystatechange = function() {

                    if (req.readyState == 4 && req.status == 200) {



                        download(this.response, "report.pdf", "application/pdf");


                    }


                }
            }
        });

    });
});
```



## Skapa anpassad servett

Skapa en anpassad servett som sammanfogar data med XDP-mallen och returnerar PDF-filen. Koden för att uppnå detta listas nedan. Den anpassade servern är en del av [AEMFormsDocumentServices.core-1.0-SNAPSHOT-paket](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)).

```java
package com.aemformssamples.documentservices.core.servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringWriter;

import javax.servlet.Servlet;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Node;

import com.adobe.aemfd.docmanager.Document;
import com.adobe.fd.forms.api.FormsService;
import com.adobe.fd.forms.api.FormsServiceException;
import com.aemformssamples.documentservices.core.DocumentServices;

@Component(service = {
        Servlet.class
}, property = {
        "sling.servlet.methods=post",
        "sling.servlet.paths=/bin/generateinteractivedor"
})

public class GenerateIInteractiveDor extends SlingAllMethodsServlet {
        @Reference
        DocumentServices documentServices;
        @Reference
        FormsService formsService;

        private static final Logger log = LoggerFactory.getLogger(GenerateIInteractiveDor.class);

        protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) {
                doPost(request, response);
        }

        protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
                // The xdp name can be passed to this servlet. For now it have been hardocded.

                String xdpName = "f8918-r14e_redo-barcode_3 2.xdp";

                XPathFactory xfact = XPathFactory.newInstance();
                XPath xpath = xfact.newXPath();
                //String dataXml = request.getParameter("formData");
                String dataXml = request.getParameter("dataXml");
                System.out.println("The data xml is " + dataXml);
                org.w3c.dom.Document xmlDataDoc = documentServices.w3cDocumentFromStrng(dataXml);
                System.out.println("The af bound data is " + xmlDataDoc.getElementsByTagName("topmostSubform").getLength());
                try {
                        // get the actual xml data that needs to be merged with the template. This can be made more generic
                        Node res = (Node) xpath.evaluate("afData/afBoundData/topmostSubform", xmlDataDoc, XPathConstants.NODE);
                        StringWriter writer = new StringWriter();
                        Transformer transformer = TransformerFactory.newInstance().newTransformer();
                        transformer.transform(new DOMSource(res), new StreamResult(writer));
                        String xml = writer.toString();
                        System.out.println(xml);
                        xmlDataDoc = documentServices.w3cDocumentFromStrng(xml);
                        Document xmlDataDocument = documentServices.orgw3cDocumentToAEMFDDocument(xmlDataDoc);
                        String xdpTemplatePath = "crx:///content/dam/formsanddocuments";
                        com.adobe.fd.forms.api.PDFFormRenderOptions renderOptions = new com.adobe.fd.forms.api.PDFFormRenderOptions();
                        renderOptions.setAcrobatVersion(com.adobe.fd.forms.api.AcrobatVersion.Acrobat_11);
                        renderOptions.setContentRoot(xdpTemplatePath);
                        renderOptions.setRenderAtClient(com.adobe.fd.forms.api.RenderAtClient.NO);
                        Document xdpPDF = formsService.renderPDFForm(xdpName, xmlDataDocument, renderOptions);
                        InputStream fileInputStream = xdpPDF.getInputStream();
                        System.out.println("Got xdp PDF" + fileInputStream.available());
                        response.setContentType("application/pdf");
                        
                        response.addHeader("Content-Disposition", "attachment; filename=" + xdpName.replace("xdp", "pdf"));
                        response.setContentLength((int) fileInputStream.available());
                        OutputStream responseOutputStream = response.getOutputStream();
                        int bytes;
                        while ((bytes = fileInputStream.read()) != -1) {
                                responseOutputStream.write(bytes);
                        }
                        responseOutputStream.flush();
                        responseOutputStream.close();

                } catch (XPathExpressionException e) {
                        log.debug(e.getMessage());

                } catch (TransformerException e) {

                        log.debug(e.getMessage());
                } catch (FormsServiceException e) {

                        log.debug(e.getMessage());
                } catch (IOException e) {

                        log.debug(e.getMessage());
                }

        }

}
```

I exempelkoden är mallnamnet (f8918-r14e_redo-barcode_3 2.xdp) hårdkodat. Du kan enkelt skicka in mallnamnet till servern för att göra koden generisk och arbeta mot alla mallar.


## Distribuera exemplet på servern

Så här testar du detta på den lokala servern:

1. [Hämta och installera paketet DevelopingWithServiceUser](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
1. Lägg till följande post i användarmappningstjänsten för Apache Sling Service DevelopingWithServiceUser.core:getformsresourceSolver=fd-service
1. [Hämta och installera det anpassade Document Services-paketet](/hep/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar). Detta har serverutrymmet för att sammanfoga data med XDP-mallen och strömma tillbaka PDF-filen
1. [Importera klientbiblioteket](assets/irs.zip)
1. [Importera det adaptiva formuläret](assets/f8918complete.zip)
1. [Importera XDP-mall och -schema](assets/xdp-template-and-xsd.zip)
1. [Förhandsgranska anpassat formulär](http://localhost:4502/content/dam/formsanddocuments/f8918complete/jcr:content?wcmmode=disabled)
1. Fylla i några av formulärfälten
1. Klicka på Hämta PDF för att hämta PDF
