---
title: AEM arbetsflöde vid överföring av HTML5-formulär - Skapa anpassad profil
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
feature: Mobile Forms
doc-type: article
version: 6.4, 6.5
topic: Development
role: Developer
level: Experienced
exl-id: b6e3acee-4a07-4d00-b3a1-f7aedda21e6e
duration: 102
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '301'
ht-degree: 0%

---

# Skapa anpassad profil

I den här delen ska vi skapa en [egen profil.](https://helpx.adobe.com/livecycle/help/mobile-forms/creating-profile.html) En profil ansvarar för att återge XDP-filen som HTML. En standardprofil anges i rutan för återgivning av XDP-filer som HTML. Den representerar en anpassad version av Forms Rendition-tjänsten för mobiler. Du kan använda tjänsten Mobile Form Rendition för att anpassa utseende, beteende och interaktioner för Mobile Forms. I vår anpassade profil samlar vi in data som fyllts i mobilformuläret med hjälp av API:t för vägbeskrivningar. Dessa data skickas sedan till en anpassad server som sedan genererar ett interaktivt PDF och strömmar tillbaka dem till det anropande programmet.

Hämta formulärdata med `formBridge` JavaScript API. Vi använder `getDataXML()` metod:

```javascript
window.formBridge.getDataXML({success:suc,error:err});
```

I hanterarmetoden gör vi ett anrop till en anpassad server som körs i AEM. Den här servern återger och returnerar interaktiv PDF med data från mobilformuläret

```javascript
var suc = function(obj) {
    let xhr = new XMLHttpRequest();
    var data = obj.data;
    console.log("The data: " + data);
    xhr.open('POST','/bin/generateinteractivepdf');
    xhr.responseType = 'blob';
    let formData = new FormData();
    formData.append("formData", data);
    formData.append("xdpPath", window.location.pathname);
    xhr.send(formData);
    xhr.onload = function(e) {
        
        console.log("The data is ready");
        if (this.status == 200) {
            var blob = new Blob([this.response],{type:'image/pdf'});
                let a = document.createElement("a");
                a.style = "display:none";
                document.body.appendChild(a);
                let url = window.URL.createObjectURL(blob);
                a.href = url;
                a.download = "schengenvisaform.pdf";
                a.click();
                window.URL.revokeObjectURL(url);
        }
    }
}
```

## Generera interaktiv PDF

Nedan följer den serletkod som ansvarar för att återge interaktiv PDF och returnera PDF-filen till det anropande programmet. Serleten anropar `mobileFormToInteractivePdf` för den anpassade DocumentServices OSGi-tjänsten.

```java
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.Servlet;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.adobe.aemfd.docmanager.Document;
import com.aemformssamples.documentservices.core.DocumentServices;

@Component(
  service = { Servlet.class }, 
  property = { 
    "sling.servlet.methods=post",
    "sling.servlet.paths=/bin/generateinteractivepdf" 
  }
)
public class GenerateInteractivePDF extends SlingAllMethodsServlet {
    @Reference
    DocumentServices documentServices;

    protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) { 
       doPost(request, response);
    }

    protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
      String dataXml = request.getParameter("formData");
      org.w3c.dom.Document xmlDataDoc = documentServices.w3cDocumentFromStrng(dataXml);
      Document xmlDocument = documentServices.orgw3cDocumentToAEMFDDocument(xmlDataDoc);
      Document generatedPDF = documentServices.mobileFormToInteractivePdf(xmlDocument,request.getParameter("xdpPath"));
      try {
          InputStream fileInputStream = generatedPDF.getInputStream();
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
      } catch (IOException e) {
        // TODO Add proper error logging
      }
    }
}
```

### Återge interaktiv PDF

Följande kod använder [Forms Service API](https://helpx.adobe.com/aem-forms/6/javadocs/com/adobe/fd/forms/api/FormsService.html) för att återge interaktivt PDF med data från mobilformuläret.

```java
public Document mobileFormToInteractivePdf(Document xmlData,String path) {
    // In mobile form to interactive pdf
    
    String uri = "crx:///content/dam/formsanddocuments";
    String xdpName = path.substring(31,path.lastIndexOf("/jcr:content"));
    PDFFormRenderOptions renderOptions = new PDFFormRenderOptions();
    renderOptions.setAcrobatVersion(AcrobatVersion.Acrobat_11);
    renderOptions.setContentRoot(uri);
    Document interactivePDF = null;

    try {
        interactivePDF = formsService.renderPDFForm(xdpName, xmlData, renderOptions);
    } catch (FormsServiceException e) {
        // TODO Add proper error logging
    }
    
    return interactivePDF;
}
```

För att se möjligheten att ladda ned interaktiva PDF från delvis ifyllda mobilformulär, [klicka här](https://forms.enablementadobe.com/content/dam/formsanddocuments/xdptemplates/schengenvisa.xdp/jcr:content).
När PDF har laddats ned är nästa steg att skicka PDF för att starta ett AEM arbetsflöde. Det här arbetsflödet sammanfogar data från det inskickade PDF och genererar icke-interaktiva PDF för granskning.

Den anpassade profil som skapats för det här användningsfallet är tillgänglig som en del av den här självstudiekursen.
