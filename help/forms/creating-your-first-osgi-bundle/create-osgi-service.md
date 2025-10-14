---
title: Skapa din första OSGi-tjänst med AEM Forms
description: Bygg din första OSGi-tjänst med AEM Forms
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
exl-id: 2f15782e-b60d-40c6-b95b-6c7aa8290691
last-substantial-update: 2021-04-23T00:00:00Z
duration: 87
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '337'
ht-degree: 0%

---

# OSGi Service

En OSGi-tjänst är en Java-klass eller ett Java-tjänstgränssnitt tillsammans med ett antal tjänsteegenskaper som namn/värde-par. Tjänstegenskaperna skiljer sig mellan olika tjänsteleverantörer som tillhandahåller tjänster med samma gränssnitt.

En OSGi-tjänst definieras semantiskt av dess tjänstgränssnitt och implementeras som ett serviceobjekt. En tjänsts funktionalitet definieras av de gränssnitt som den implementerar. Olika program kan alltså implementera samma tjänst. Tjänstgränssnitten gör det möjligt att interagera genom att binda gränssnitt, inte implementeringar. Ett tjänstgränssnitt ska anges med så få implementeringsdetaljer som möjligt.

## Definiera gränssnittet

Ett enkelt gränssnitt med en metod för att sammanfoga data med mallen <span class="x x-first x-last">XDP</span>.

```java
package com.mysite.samples;

import com.adobe.aemfd.docmanager.Document;

public interface MyfirstInterface
{
    public Document mergeDataWithXDPTemplate(Document xdpTemplate, Document xmlDocument);
}
 
```

## Implementera gränssnittet

Skapa ett nytt paket med namnet `com.mysite.samples.impl` för implementeringen av gränssnittet.

```java
package com.mysite.samples.impl;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.adobe.aemfd.docmanager.Document;
import com.adobe.fd.output.api.OutputService;
import com.adobe.fd.output.api.OutputServiceException;
import com.mysite.samples.MyfirstInterface;
@Component(service = MyfirstInterface.class)
public class MyfirstInterfaceImpl implements MyfirstInterface {
  @Reference
  OutputService outputService;

  private static final Logger log = LoggerFactory.getLogger(MyfirstInterfaceImpl.class);

  @Override
  public Document mergeDataWithXDPTemplate(Document xdpTemplate, Document xmlDocument) {
    com.adobe.fd.output.api.PDFOutputOptions pdfOptions = new com.adobe.fd.output.api.PDFOutputOptions();
    pdfOptions.setAcrobatVersion(com.adobe.fd.output.api.AcrobatVersion.Acrobat_11);
    try {
      return outputService.generatePDFOutput(xdpTemplate, xmlDocument, pdfOptions);

    } catch (OutputServiceException e) {

      log.error("Failed to merge data with XDP Template", e);

    }

    return null;
  }

}
```

Anteckningen `@Component(...)` på rad 10 markerar den här Java-klassen som en OSGi-komponent samt registrerar den som en OSGi-tjänst.

Anteckningen `@Reference` ingår i OSGi-deklarativa tjänster och används för att mata in en referens för [&#x200B; OutputService &#x200B;](https://helpx.adobe.com/se/experience-manager/6-5/forms/javadocs/index.html?com/adobe/fd/output/api/OutputService.html) i variabeln `outputService`.


## Bygg och distribuera paketet

* Öppna **kommandotolkfönstret**
* Navigera till `c:\aemformsbundles\mysite\core`
* Kör kommandot `mvn clean install -PautoInstallBundle`
* Ovanstående kommando skapar och distribuerar automatiskt paketet till din AEM-instans som körs på localhost:4502

Paketet kommer också att vara tillgängligt på följande plats `C:\AEMFormsBundles\mysite\core\target`. Paketet kan också distribueras till AEM med webbkonsolen [Felix.](http://localhost:4502/system/console/bundles)

## Använda tjänsten

Du kan nu använda tjänsten på JSP-sidan. Följande kodutdrag visar hur du får åtkomst till tjänsten och använder de metoder som implementerats av tjänsten

```java
MyFirstAEMFormsService myFirstAEMFormsService = sling.getService(com.mysite.samples.MyFirstAEMFormsService.class);
com.adobe.aemfd.docmanager.Document generatedDocument = myFirstAEMFormsService.mergeDataWithXDPTemplate(xdp_or_pdf_template,xmlDocument);
```

Exempelpaketet som innehåller JSP-sidan kan [hämtas här](assets/learning_aem_forms.zip)

[Det fullständiga paketet kan hämtas](assets/mysite.core-1.0.0-SNAPSHOT.jar)

## Testa paketet

Importera och installera paketet i AEM med [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)

Använd postman för att ringa ett POST-anrop och ange indataparametrarna som visas på bilden nedan
![postman](assets/test-service-postman.JPG)

## Nästa steg

[Skapa Sling Servlet](./create-servlet.md)

