---
title: Skapa din första OSGi-tjänst med AEM Forms
description: 'Bygg din första OSGi-tjänst med AEM Forms '
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: article
activity: setup
version: 6.4,6.5
topic: Utveckling
role: Developer
level: Beginner
source-git-commit: c74c6f5627e69e32bbf0098d6b6bab122cace798
workflow-type: tm+mt
source-wordcount: '345'
ht-degree: 0%

---


# OSGi Service

En OSGi-tjänst är en Java-klass eller ett Java-tjänstgränssnitt tillsammans med ett antal tjänsteegenskaper som namn/värde-par. Tjänstegenskaperna skiljer sig mellan olika tjänsteleverantörer som tillhandahåller tjänster med samma gränssnitt.

En OSGi-tjänst definieras semantiskt av dess tjänstgränssnitt och implementeras som ett serviceobjekt. En tjänsts funktionalitet definieras av de gränssnitt som den implementerar. Olika program kan alltså implementera samma tjänst. Tjänstgränssnitten gör det möjligt att interagera genom att binda gränssnitt, inte implementeringar. Ett tjänstgränssnitt ska anges med så få implementeringsdetaljer som möjligt.

## Definiera gränssnittet

Ett enkelt gränssnitt med en metod för att sammanfoga data med <span class="x x-first x-last">XDP</span>-mallen.

```java
package com.learningaemforms.adobe.core;

import com.adobe.aemfd.docmanager.Document;

public interface MyfirstInterface {
  public Document mergeDataWithXDPTemplate(Document xdpTemplate, Document xmlDocument);
} 
```

## Implementera gränssnittet

Skapa ett nytt paket med namnet `com.learningaemforms.adobe.core.impl` för implementeringen av gränssnittet.

```java
package com.learningaemforms.adobe.core.impl;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.adobe.aemfd.docmanager.Document;
import com.adobe.fd.output.api.OutputService;
import com.adobe.fd.output.api.OutputServiceException;
import com.learningaemforms.adobe.core.MyfirstInterface;
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

`@Reference`-anteckningen ingår i OSGi-deklarativa tjänster och används för att mata in en referens för [OutputService](https://helpx.adobe.com/experience-manager/6-5/forms/javadocs/index.html?com/adobe/fd/output/api/OutputService.html) i variabeln `outputService`.


## Bygg och distribuera paketet

* Öppna **kommandotolkfönstret**
* Navigera till `c:\aemformsbundles\learningaemforms\core`
* Kör kommandot `mvn clean install -PautoInstallBundle`
* Kommandot ovan skapar och distribuerar automatiskt paketet till din AEM som körs på localhost:4502

Paketet kommer också att vara tillgängligt på följande plats `C:\AEMFormsBundles\learningaemforms\core\target`. Paketet kan också distribueras till AEM med webbkonsolen [Felix.](http://localhost:4502/system/console/bundles)

## Använda tjänsten

Du kan nu använda tjänsten på JSP-sidan. Följande kodutdrag visar hur du får åtkomst till tjänsten och använder de metoder som implementerats av tjänsten

```java
MyFirstAEMFormsService myFirstAEMFormsService = sling.getService(com.learningaemforms.adobe.core.MyFirstAEMFormsService.class);
com.adobe.aemfd.docmanager.Document generatedDocument = myFirstAEMFormsService.mergeDataWithXDPTemplate(xdp_or_pdf_template,xmlDocument);
```

Exempelpaketet som innehåller JSP-sidan kan ![hämtas här](assets/learning-aem-forms.zip)

## Testa paketet

Importera och installera paketet i AEM med [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)

Använd postman för att ringa ett POST-samtal och ange indataparametrarna som visas på bilden nedan
![postman](assets/test-service-postman.JPG)
