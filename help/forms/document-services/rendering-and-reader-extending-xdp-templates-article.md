---
title: Rendera XDP till PDF med användarrättigheter
description: Använd användningsbehörighet för PDF
version: 6.4,6.5
feature: Forms Service
topic: Development
role: Developer
level: Experienced
exl-id: ce1793d1-f727-4bc4-9994-f495b469d1e3
last-substantial-update: 2020-07-07T00:00:00Z
duration: 154
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '411'
ht-degree: 0%

---

# Rendera XDP till PDF med användarrättigheter{#rendering-xdp-into-pdf-with-usage-rights}

Ett vanligt användningssätt är att återge xdp i PDF och använda Reader-tillägg på det återgivna PDF.

När en användare klickar på XDP i till exempel AEM Forms formulärportal kan vi återge XDP som PDF och Reader utöka PDF.


För att uppnå detta måste vi göra följande.

* Lägg till certifikatet för Reader Extensions till användaren fd-service. Stegen för att lägga till autentiseringsuppgifter för Reader Extensions visas [här](https://experienceleague.adobe.com/docs/experience-manager-65/forms/install-aem-forms/osgi-installation/install-configure-document-services.html?lang=en)


* Du kan även se videon om [konfigurera autentiseringsuppgifter för Reader Extensions](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/document-services/configuring-reader-extension-osgi.html)


* Skapa en anpassad OSGi-tjänst som återger och tillämpar användarrättigheter. Koden för att uppnå detta visas nedan

## Rendera XDP och Använd användarrättigheter {#render-xdp-and-apply-usage-rights}

* Rad 7: Med FormsTjänsts renderPDFForm genererar vi PDF från XDP.

* Rader 8-14: Lämpliga användningsrättigheter har angetts. Dessa användningsrättigheter hämtas från OSGi-konfigurationsinställningarna.

* Rad 20: Använd den resurslösning som är associerad med tjänstanvändarens fd-service

* Rad 24: DocumentAssuranceTjänstens secureDocument-metod används för att tillämpa användningsrättigheterna

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

![Konfigurationsegenskaper](assets/configurationproperties.gif)

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

## Skapa serverström för att strömma PDF {#create-servlet-to-stream-the-pdf}

Nästa steg är att skapa en servlet med en GET-metod som returnerar läsaren extended PDF till användaren. I det här fallet uppmanas användaren att spara PDF i sitt filsystem. Detta beror på att PDF återges som dynamiskt PDF och att PDF-visningsprogrammen som medföljer webbläsarna inte hanterar dynamiska PDF-filer.

Här följer koden för serverleten. Vi skickar sökvägen till XDP i CRX-databasen till den här servern.

Vi anropar sedan metoden renderAndExtendXdp för com.aemformssamples.documents.core.DocumentServices.

Läsaren extended PDF direktuppspelas sedan till det anropande programmet

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

1. [Hämta den anpassade portalmallens html](assets/render-and-extend-template.zip)
1. [Hämta och importera resurser som är relaterade till den här artikeln till AEM med hjälp av pakethanteraren](assets/renderandextendxdp.zip)
   * Paketet har en exempelportal och en xdp-fil
1. Lägg till certifikat för Reader-tillägg till användaren fd-service
1. Peka webbläsaren till [portalwebbsida](http://localhost:4502/content/AemForms/ReaderExtensionsXdp.html)
1. Klicka på pdf-ikonen för att återge xdp som en pdf-fil med användningsbehörighet.
