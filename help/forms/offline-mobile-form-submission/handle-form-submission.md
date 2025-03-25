---
title: Utlösa AEM-arbetsflöde vid inskickning av HTML5-formulär - hantera inlämning av PDF-formulär
description: Hantera inlämningen av HTML5/PDF-formulär
feature: Mobile Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
jira: kt-16133
badgeVersions: label="AEM Forms 6.5" before-title="false"
level: Experienced
exl-id: ef8ed87d-37c1-4d01-8df6-7a78c328703d
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '146'
ht-degree: 0%

---

# Hantera inlämning av formulär

I det här avsnittet skapar vi en enkel webbtjänst som körs på AEM Publish för att hantera PDF-formuläret eller inskickandet av HTML5-formulär. Den här servern skickar en HTTP POST-begäran till en server som körs i en AEM-författarinstans och som ansvarar för att spara skickade data som en `nt:file`-nod i AEM Authors databas.

Nedan följer koden för den server som hanterar PDF/HTML5-formuläröverföringen. På den här servern gör vi ett POST-anrop till en servlet som är monterad på **/bin/startworkflow** i en AEM Author-instans. Den här servern sparar formulärdata i AEM Authors databas.


## AEM Publish servlet

Följande kod hanterar inskickandet av PDF/HTML5-formulär. Den här koden körs på publiceringsinstansen.

```java
package com.aemforms.mobileforms.core.servlets;
import com.aemforms.mobileforms.core.configuration.service.AemServerCredentialsConfigurationService;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.apache.sling.servlets.annotations.SlingServletResourceTypes;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.Servlet;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Component(service={Servlet.class}, property={"sling.servlet.methods=post", "sling.servlet.paths=/bin/handleformsubmission"})
public class HandleFormSubmission extends SlingAllMethodsServlet implements Serializable {
    private static final long serialVersionUID = 1L;
    private final transient Logger logger = LoggerFactory.getLogger(this.getClass());
    @Reference
    AemServerCredentialsConfigurationService aemServerCredentialsConfigurationService;



    protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
        logger.debug("In do POST of bin/handleformsubmission");
        ByteArrayOutputStream result = new ByteArrayOutputStream();
        try {
            ServletInputStream is = request.getInputStream();
            byte[] buffer = new byte[1024];
            int length;
            while ((length = is.read(buffer)) != -1) {
                result.write(buffer, 0, length);
            }
            logger.debug(result.toString(StandardCharsets.UTF_8.name()));
        } catch (IOException e1) {
            logger.error("An error occurred", e1);
        }
        String postURL = aemServerCredentialsConfigurationService.getWorkflowServer();
        logger.debug("The url to invoke workflow is  "+postURL);
        HttpPost postReq = new HttpPost(postURL);
        // This is the base64 encoding of the admin credentials. This call should be made over HTTPS in production scenarios to avoid leaking credentials.
        String userName = aemServerCredentialsConfigurationService.getUserName();
        String password = aemServerCredentialsConfigurationService.getPassword();
        String credential = userName+":"+password;
        String encodedString = Base64.getEncoder().encodeToString(credential.getBytes());
        postReq.addHeader("Authorization", "Basic "+encodedString);
        System.out.println("The encoded string is "+"Basic "+encodedString);

        CloseableHttpClient httpClient = HttpClients.createDefault();
        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();

        logger.debug("added url parameters");
        try {
            urlParameters.add(new BasicNameValuePair("xmlData", result.toString(StandardCharsets.UTF_8.name())));
            postReq.setEntity(new UrlEncodedFormEntity(urlParameters));
            HttpResponse httpResponse = httpClient.execute(postReq);
            logger.debug("Sent request to author instance");
            String startWorkflowResponse = EntityUtils.toString(httpResponse.getEntity());
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            out.write(startWorkflowResponse);

        } catch (IOException e) {
            logger.error("An error occurred", e);
        }


    }
}
```

## Nästa steg

[Lagra skickade data på författarinstansen](./author-servlet.md)
