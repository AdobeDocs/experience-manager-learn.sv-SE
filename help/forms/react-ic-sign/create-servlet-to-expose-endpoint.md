---
title: Visa slutpunkt som kan anropas för att returnera webbformulärets URL
description: Skapa AEM-server för att returnera webbformulärets URL
feature: Adaptive Forms,Acrobat Sign
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-13099
last-substantial-update: 2023-04-13T00:00:00Z
exl-id: 3b7632bd-3820-4c1e-aa3f-8a6a4fc26847
duration: 38
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '70'
ht-degree: 0%

---

# Skapa webbformulär-URL för Acrobat Sign

Följande kod skrevs för att visa en POST-slutpunkt. Den här slutpunkten extraherar icTemplateName från skickade data och returnerar en webbformulärs-URL för Acrobat Sign så att slutanvändaren kan signera.


```java
package com.acrobatsign.core.servlets;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;

import javax.servlet.Servlet;

import org.apache.commons.io.IOUtils;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;

import com.acrobatsign.core.PrintChannelDocumentHelperMethods;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
@Component(service = {
  Servlet.class
}, property = {
  "sling.servlet.methods=post",
  "sling.servlet.paths=/bin/getwidgeturl"
})
public class GetWidgetUrl extends SlingAllMethodsServlet {
  private static final long serialVersionUID = 1 L;
  private static final Logger log = org.slf4j.LoggerFactory.getLogger(GetWidgetUrl.class);
  @Reference
  PrintChannelDocumentHelperMethods printChannelDocument;
  protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
    String jsonString;
    try {

      jsonString = IOUtils.toString(request.getInputStream(), StandardCharsets.UTF_8.name());
      log.debug("####Form Data is  " + jsonString);
      JsonObject jsonObject = JsonParser.parseString(jsonString).getAsJsonObject();
      log.debug("The json object is " + jsonObject.toString());
      String icTemplate = jsonObject.get("icTemplate").getAsString();
      log.debug("The icTemplate is " + icTemplate);

      //InputStream targetStream = IOUtils.toInputStream(jsonObject.toString());
      InputStream targetStream = new ByteArrayInputStream(jsonString.getBytes());
      String widgetURL = printChannelDocument.getPrintChannelDocument(icTemplate, targetStream);
      log.debug("The widget url is " + widgetURL);

      JsonObject jsonResponse = new JsonObject();
      jsonResponse.addProperty("widgetURL", widgetURL);

      PrintWriter out = response.getWriter();
      response.setContentType("application/json");
      response.setCharacterEncoding("utf-8");
      out.println(jsonResponse.toString());
      out.flush();
    } catch (Exception e) {
      
      log.error("Error while getting the widget URL, details are :" + e.getMessage());
    }

  }

}
```

## Nästa steg

[Distribuera självstudieresurserna på ditt lokala system](./deploy-assets-on-your-server.md)
