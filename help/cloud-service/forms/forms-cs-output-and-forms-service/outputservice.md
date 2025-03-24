---
title: Generera PDF-dokument med hjälp av utdatatjänst
description: Sammanfoga data med XDP-mall för att generera icke-interaktiv PDF
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Output Service
topic: Development
jira: KT-16384
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: 8a5a4d11-12a2-462d-8684-a0c6ec0cac0e
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '207'
ht-degree: 0%

---

# Generera PDF-dokument med hjälp av utdatatjänst

[Utdatatjänsten](https://javadoc.io/static/com.adobe.aem/aem-forms-sdk-api/2024.07.31.00-240800/com/adobe/fd/output/api/OutputService.html) är en OSGi-tjänst som ingår i AEM Document Services. Det stöder olika utformat och designfunktioner i AEM Forms Designer. Output-tjänsten konverterar XFA-mallar och XML-data för att generera utskriftsdokument i olika format.

Output-tjänsten i AEM Forms as a Cloud Service liknar den i AEM Forms 6.5, så om du är van vid att använda Output-tjänsten i AEM Forms 6.5 bör det vara enkelt att gå över till AEM Forms as a Cloud Service.

Med tjänsten Output kan du skapa program som gör att du kan:

+ Generera slutliga formulärdokument genom att fylla i mallfiler med XML-data.
+ Generera utdataformulär i olika format, inklusive icke-interaktiva PDF-, PostScript-, PCL- och ZPL-utskriftsströmmar.
+ Generera utskrifts-PDF:er från XFA-formulär-PDF:er.
+ Generera flera olika PDF-, PostScript-, PCL- och ZPL-dokument genom att slå samman olika datauppsättningar med medföljande mallar.

Den här tjänsten är avsedd att användas i ett AEM Forms as a Cloud Service-sammanhang. Följande kodfragment genererar ett PDF-dokument i en serverlet med `OutputService`.

```java
import com.adobe.fd.output.api.OutputService;
import com.adobe.fd.output.api.PDFOutputOptions;
import com.adobe.fd.output.api.AcrobatVersion;
import com.adobe.aemfd.docmanager.Document;
import org.apache.sling.api.servlets.HttpConstants;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.api.servlets.SlingServletPaths;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@Component(service = Servlet.class,
           property = {
               "sling.servlet.methods=" + HttpConstants.METHOD_POST,
               "sling.servlet.paths=/bin/generateStatement"
           })
public class GenerateStatementServlet extends SlingAllMethodsServlet {

    @Reference
    private OutputService outputService;

    @Override
    protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) throws IOException {
        // Access the submitted form data
        String formData = request.getParameter("formData");

        // Define the XDP template document
        String templateName = "/content/dam/formsanddocuments/adobe/statement.xdp";
        Document xdpDocument = new Document(templateName);

        // Set the PDF output options
        PDFOutputOptions pdfOutputOptions = new PDFOutputOptions();
        pdfOutputOptions.setAcrobatVersion(AcrobatVersion.Acrobat_10);

        // Create the submitted data document from the form data
        InputStream inputStream = new ByteArrayInputStream(formData.getBytes(StandardCharsets.UTF_8));
        Document submittedData = new Document(inputStream);

        // Use the output service to generate the PDF output
        Document generatedPDF = outputService.generatePDFOutput(xdpDocument, submittedData, pdfOutputOptions);

        // Process the generated PDF as per your use case        
    }
}
```
