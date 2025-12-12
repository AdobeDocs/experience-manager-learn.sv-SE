---
title: Sammanställa PDF-filer med hjälp av DX-åtgärden invoke
description: Gör en POST-begäran om att anropa DDX-slutpunkten med de nödvändiga parametrarna
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Output Service
topic: Development
jira: KT-9980
exl-id: 693dac88-84f3-4051-8e46-3105093711a3
duration: 56
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '124'
ht-degree: 0%

---

# Ring POST


Nästa steg är att göra ett HTTP POST-anrop till slutpunkten med de nödvändiga parametrarna. DDX- och pdf-filerna tillhandahålls som resursfiler. Slutpunkten har tokenbaserad autentisering. Vi skickar åtkomsttoken i begärandehuvudet.
När du använder Assembler-tjänsten ska du använda ett XML-baserat språk som kallas för dokumentbeskrivnings-XML (DDX) för att beskriva de utdata du vill använda. DDX är ett deklarativt kodspråk vars element representerar byggstenar i dokument. Följande DDX användes för att sammanfoga de två PDF-dokument som identifieras i PDF källelement.

```xml
<DDX xmlns="http://ns.adobe.com/DDX/1.0/">
<PDF result="doc3.pdf"> 
  <PDF source="CA-Drivers-Handbook.pdf"/>
  <PDF source="CA-Parent-Teen-Handbook.pdf"/>
  </PDF>
</DDX>
```

Följande kod användes för att kombinera PDF-filer

```java
package com.aemformscs.documentservices;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

public class AssemblePDFFiles {
  public String SAVE_LOCATION = "c:\\assembledpdf";

  public void assemblePDF(String postURL) {

    HttpPost httpPost = new HttpPost(postURL);
    CredentialUtilites cu = new CredentialUtilites();
    String accessToken = cu.getAccessToken();
    httpPost.addHeader("Authorization", "Bearer " + accessToken);
    ClassLoader classLoader = DocumentGeneration.class.getClassLoader();
    URL ddxFile = classLoader.getResource("ddxfiles/assemble2pdfs.ddx");
    MultipartEntityBuilder builder = MultipartEntityBuilder.create();

    builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);

    File ddx = new File(ddxFile.getPath());
    builder.addBinaryBody("ddx", ddx, ContentType.create("application/xml"), ddx.getName());
    URL url = classLoader.getResource("pdffiles");
    System.out.println(url.getPath());
    File files[] = new File(url.getPath()).listFiles();

    for (int i = 0; i < files.length; i++) {
      System.out.println("Added  " + files[i].getName());
      builder.addBinaryBody(files[i].getName(), files[i], ContentType.APPLICATION_OCTET_STREAM, files[i].getName());
    }
    try {

      HttpEntity entity = builder.build();
      httpPost.setEntity(entity);
      CloseableHttpClient httpclient = HttpClients.createDefault();
      CloseableHttpResponse response = httpclient.execute(httpPost);
      System.out.println("The success code is " + response.getStatusLine().getStatusCode());
      InputStream generatedPDF = response.getEntity().getContent();
      byte[] bytes = IOUtils.toByteArray(generatedPDF);
      File saveLocation = new File(SAVE_LOCATION);
      if (!saveLocation.exists()) {
        saveLocation.mkdirs();
      }
      File outputFile = new File(SAVE_LOCATION + File.separator + "assembledPDF.pdf");
      FileOutputStream outputStream = new FileOutputStream(outputFile);
      outputStream.write(bytes);
      outputStream.close();
      System.out.println("AssembledPDF.pdf saved to " + SAVE_LOCATION);

    } catch (Exception e) {
      System.out.println("The message is " + e.getMessage());
    }
  }

}
```
