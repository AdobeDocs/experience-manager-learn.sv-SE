---
title: Rendera XDP till PDF med användningsbehörighet
seo-title: Rendera XDP till PDF med användningsbehörighet
description: Använd användningsbehörighet för PDF
seo-description: Använd användningsbehörighet för PDF
uuid: 5e60c61e-821d-439c-ad89-ab169ffe36c0
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
feature: Forms Service
discoiquuid: aefb4124-91a0-4548-94a3-86785ea04549
topic: Development
role: Developer
level: Experienced
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '435'
ht-degree: 0%

---


# Renderar XDP till PDF med användningsbehörighet{#rendering-xdp-into-pdf-with-usage-rights}

Ett vanligt användningssätt är att återge xdp till PDF och använda Reader-tillägg på den återgivna PDF-filen.

När en användare klickar på XDP i t.ex. AEM Forms formulärportal kan vi återge XDP som PDF och läsa PDF-filen.

Om du vill testa den här funktionen kan du prova den här [länken](https://forms.enablementadobe.com/content/samples/samples.html?query=0). Exempelnamnet är &quot;Rendera XDP med RE&quot;

För att uppnå detta måste vi göra följande.

* Lägg till certifikatet för Reader Extensions till användaren fd-service. Stegen för att lägga till autentiseringsuppgifter för Reader Extensions visas [här](https://helpx.adobe.com/experience-manager/6-3/forms/using/configuring-document-services.html)

* Skapa en anpassad OSGi-tjänst som återger och tillämpar användarrättigheter. Koden som ska användas anges nedan

## Återge XDP och använd användningsbehörighet {#render-xdp-and-apply-usage-rights}

* Rad 7: Med hjälp av FormsTjänsts renderPDFForm genererar vi PDF från XDP.

* Raderna 8-14: Lämpliga användningsrättigheter har angetts. Dessa användningsrättigheter hämtas från OSGi-konfigurationsinställningarna.

* Rad 20: Använd resurshanteraren som är associerad med tjänstanvändarens fd-service

* Rad 24: Metoden secureDocument i DocumentAssuranceService används för att tillämpa användningsrättigheterna

```java
 public Document renderAndExtendXdp(String xdpPath) {
  // TODO Auto-generated method stub
  log.debug("In renderAndExtend xdp the alias is " + docConfig.ReaderExtensionAlias());
  PDFFormRenderOptions renderOptions = new PDFFormRenderOptions();
  renderOptions.setAcrobatVersion(AcrobatVersion.Acrobat_11);
  try {
   Document xdpRenderedAsPDF = formsService.renderPDFForm("crx://" + xdpPath, null, renderOptions);
   UsageRights usageRights = new UsageRights();
   usageRights.setEnabledBarcodeDecoding(docConfig.BarcodeDecoding());
   usageRights.setEnabledFormFillIn(docConfig.FormFill());
   usageRights.setEnabledComments(docConfig.Commenting());
   usageRights.setEnabledEmbeddedFiles(docConfig.EmbeddingFiles());
   usageRights.setEnabledDigitalSignatures(docConfig.DigitialSignatures());
   usageRights.setEnabledFormDataImportExport(docConfig.FormDataExportImport());
   ReaderExtensionsOptionSpec reOptionsSpec = new ReaderExtensionsOptionSpec(usageRights, "Sample ARES");
   UnlockOptions unlockOptions = null;
   ReaderExtensionOptions reOptions = ReaderExtensionOptions.getInstance();
   reOptions.setCredentialAlias(docConfig.ReaderExtensionAlias());
   log.debug("set the credential");
   reOptions.setResourceResolver(getResolver.getFormsServiceResolver());
   
   reOptions.setReOptions(reOptionsSpec);
   log.debug("set the resourceResolver and re spec");
   xdpRenderedAsPDF = docAssuranceService.secureDocument(xdpRenderedAsPDF, null, null, reOptions,
     unlockOptions);

   return xdpRenderedAsPDF;
  } catch (FormsServiceException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  } catch (Exception e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }
  return null;

 }
```

I följande skärmbild visas de konfigurationsegenskaper som visas. De flesta vanliga användningsrättigheter visas genom den här konfigurationen.

![](assets/configurationproperties.gif)

I följande kod visas koden som används för att skapa OSGi-konfigurationsinställningarna

```java
package com.aemformssamples.configuration;

import org.osgi.service.metatype.annotations.AttributeDefinition;
import org.osgi.service.metatype.annotations.AttributeType;
import org.osgi.service.metatype.annotations.ObjectClassDefinition;

@ObjectClassDefinition(name = "AEM Forms Samples Doc Services Configuration", description = "AEM Forms Samples Doc Services Configuration")
public @interface DocSvcConfiguration {
 @AttributeDefinition(name = "Allow Form Fill", description = "Allow Form Fill", type = AttributeType.BOOLEAN)
 boolean FormFill() default false;

 @AttributeDefinition(name = "Allow BarCode Decoding", description = "Allow BarCode Decoding", type = AttributeType.BOOLEAN)
 boolean BarcodeDecoding() default false;

 @AttributeDefinition(name = "Allow File Embedding", description = "Allow File Embedding", type = AttributeType.BOOLEAN)
 boolean EmbeddingFiles() default false;

 @AttributeDefinition(name = "Allow Commenting", description = "Allow Commenting", type = AttributeType.BOOLEAN)
 boolean Commenting() default false;

 @AttributeDefinition(name = "Allow DigitialSignatures", description = "Allow File DigitialSignatures", type = AttributeType.BOOLEAN)
 boolean DigitialSignatures() default false;

 @AttributeDefinition(name = "Allow FormDataExportImport", description = "Allow FormDataExportImport", type = AttributeType.BOOLEAN)
 boolean FormDataExportImport() default false;

 @AttributeDefinition(name = "Reader Extension Alias", description = "Alias of your Reader Extension")
 String ReaderExtensionAlias() default "";

}
```

## Skapa tjänstför att strömma PDF-filen {#create-servlet-to-stream-the-pdf}

Nästa steg är att skapa en server med en GET-metod som returnerar den utökade PDF-filen till läsaren. I så fall blir användaren ombedd att spara PDF-filen i sitt filsystem. Det beror på att PDF-filen återges som en dynamisk PDF-fil och att PDF-visningsprogrammen som medföljer webbläsarna inte hanterar dynamiska PDF-filer.

Här följer koden för serverleten. Vi skickar sökvägen till XDP i CRX-databasen till den här servern.

Vi anropar sedan metoden renderAndExtendXdp för com.aemformssamples.documents.core.DocumentServices.

Den utökade PDF-filen för läsaren direktuppspelas sedan till det anropande programmet

```java
package com.aemformssamples.documentservices.core.servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.Servlet;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingSafeMethodsServlet;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.adobe.aemfd.docmanager.Document;
import com.adobe.fd.forms.api.FormsService;
import com.aemformssamples.documentservices.core.DocumentServices;

@Component(service = Servlet.class, property = {

  "sling.servlet.methods=get",

  "sling.servlet.paths=/bin/renderandextend"

})
public class RenderAndReaderExtend extends SlingSafeMethodsServlet {
 @Reference
 FormsService formsService;
 @Reference
 DocumentServices documentServices;
 private static final Logger log = LoggerFactory.getLogger(RenderAndReaderExtend.class);
 private static final long serialVersionUID = 1L;

 protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) {
  log.debug("The path of the XDP I got was " + request.getParameter("xdpPath"));
  Document renderedPDF = documentServices.renderAndExtendXdp(request.getParameter("xdpPath"));
  response.setContentType("application/pdf");
  response.addHeader("Content-Disposition", "attachment; filename=AemFormsRocks.pdf");
  try {
   response.setContentLength((int) renderedPDF.length());
   InputStream fileInputStream = null;
   fileInputStream = renderedPDF.getInputStream();
   OutputStream responseOutputStream = null;
   responseOutputStream = response.getOutputStream();
   int bytes;
   while ((bytes = fileInputStream.read()) != -1) {
    {
     responseOutputStream.write(bytes);
    }

   }
  } catch (IOException e2) {
   // TODO Auto-generated catch block
   e2.printStackTrace();
  }

 }

}
```

Följ de här stegen för att testa detta på den lokala servern
1. [Hämta och installera paketet DevelopingWithServiceUser](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
1. [Hämta och installera paketet AEMFormsDocumentServices](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
1. [Hämta och importera resurser som är relaterade till den här artikeln till AEM med hjälp av pakethanteraren](assets/renderandextendxdp.zip)
   * Paketet har en exempelportal och en xdp-fil
1. Lägg till certifikat för Reader-tillägg till användaren fd-service
1. Peka webbläsaren på [portalwebbsidan](http://localhost:4502/content/AemForms/ReaderExtensionsXdp.html)
1. Klicka på pdf-ikonen för att återge xdp och hämta pdf som är Reader Extended



