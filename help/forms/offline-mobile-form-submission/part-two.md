---
title: AEM arbetsflöde vid HTML5-formuläröverföring
seo-title: AEM arbetsflödet vid inskickning av HTML5-formulär
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
seo-description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
feature: Mobile Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '260'
ht-degree: 0%

---


# Hantera inskickning av PDF

I den här delen ska vi skapa en enkel server som körs på AEM Publish för att hantera PDF-inlämningen från Acrobat/Reader. Den här servern kommer i sin tur att göra en HTTP-POST-begäran till en server som körs i en AEM författare som är direkt ansvarig för att spara skickade data som en `nt:file`-nod i AEM Authors databas.

Nedan följer koden för den server som hanterar PDF-överföringen. På den här servern gör vi ett anrop till en POST som är monterad på **/bin/startworkflow** i en AEM Author-instans. Den här servern sparar formulärdata i AEM Authors databas.


## AEM Publish servlet

```java
package com.aemforms.handlepdfsubmission.core.servlets;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Servlet;
import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;

import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(
  service={Servlet.class}, 
  property={
    "sling.servlet.methods=post", 
    "sling.servlet.paths=/bin/handlepdfsubmit"
  }
)
public class HandlePDFSubmission extends SlingAllMethodsServlet {

  private static Logger logger = LoggerFactory.getLogger(HandlePDFSubmission.class);
  
  protected void doPost(SlingHttpServletRequest request,SlingHttpServletResponse response) {
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

     HttpPost postReq = new HttpPost("http://localhost:4502/bin/startworkflow");
     // This is the base64 encoding of the admin credetnials. This call should be made over HTTPS in production scenarios to avoid leaking credentials.
     postReq.addHeader("Authorization", "Basic YWRtaW46YWRtaW4=");
     
     CloseableHttpClient httpClient = HttpClients.createDefault();
     List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
     
     logger.debug("added url parameters");
     
     try {
        urlParameters.add(new BasicNameValuePair("xmlData", result.toString(StandardCharsets.UTF_8.name())));
        postReq.setEntity(new UrlEncodedFormEntity(urlParameters));
        httpClient.execute(postReq);
        logger.debug("Sent request to author instance");
        ServletOutputStream sout = response.getOutputStream();
        sout.print("Your form was successfully submitted");
     } catch (UnsupportedEncodingException | ClientProtocolException | IOException e) {
        logger.error("An error occurred", e)
     }
}
```

## AEM Author servlet

Nästa steg är att lagra skickade data i AEM Authors databas. Servern som är monterad på `/bin/startworkflow` sparar skickade data.

```java
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.UUID;

import javax.jcr.Binary;
import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.servlet.Servlet;
import javax.servlet.ServletOutputStream;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.mergeandfuse.getserviceuserresolver.GetResolver;

@Component(
    service = {Servlet.class},
    property = {
            "sling.servlet.methods=get",
            "sling.servlet.paths=/bin/startworkflow"
    }
)
public class StartWorkflow extends SlingAllMethodsServlet {
        private static Logger logger = LoggerFactory.getLogger(StartWorkflow.class);

        @Reference
        private GetResolver getResolver;

        protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
            String xmlData = null;
            System.out.println("in start workflow");
            response.setContentType("text/html;charset=UTF-8");

            if (request.getParameter("xmlData") != null) {
                logger.debug("The form was submitted from Acrobat/Reader");
                xmlData = request.getParameter("xmlData");
                System.out.println("in start workflow" + xmlData);
            } else {
                logger.debug("Mobile Form submission");
                StringBuffer stringBuffer = new StringBuffer();
                String line = null;

                try {
                    InputStreamReader isReader = new InputStreamReader(request.getInputStream(), "UTF-8");
                    BufferedReader reader = new BufferedReader(isReader);
                    while ((line = reader.readLine()) != null)
                        stringBuffer.append(line);
                } catch (Exception e) {
                    logger.debug("Error" + e.getMessage());
                }

                xmlData = new String(stringBuffer);
            }

            Resource r = getResolver.getFormsServiceResolver().getResource("/content/pdfsubmissions");
            Session session = r.getResourceResolver().adaptTo(Session.class);
            logger.debug("Got reosurce pdfsubmissions" + r.getPath());
            UUID uidName = UUID.randomUUID();
            Node xmlDataFilesNode = r.adaptTo(Node.class);
            InputStream is = new ByteArrayInputStream(xmlData.getBytes());
            Binary binary;

            try {
                Node xmlFileNode = xmlDataFilesNode.addNode(uidName.toString(), "nt:file");
                logger.debug("Added nt file node");
                Node jcrContent = xmlFileNode.addNode("jcr:content", "nt:resource");
                logger.debug("Added jcr content");
                binary = session.getValueFactory().createBinary(is);
                jcrContent.setProperty("jcr:data", binary);
                session.save();
            } catch (RepositoryException e) {
                logger.error("Unable to store data to JCR", e);
            }

            response.setContentType("text/plain;charset=UTF-8");

            try {
                ServletOutputStream sout = response.getOutputStream();
                sout.print("Your form was successfully submitted");
            } catch (IOException e) {
                logger.error("Unable write response", e);
            }
        }
}
```

En AEM startfunktion för arbetsflödet är konfigurerad att utlösa varje gång en ny resurs av typen `nt:file` skapas under noden `/content/pdfsubmissions`. Det här arbetsflödet skapar icke-interaktiva eller statiska PDF-filer genom att sammanfoga skickade data med xdp-mallen. Den genererade PDF-filen tilldelas sedan en användare för granskning och godkännande.

För att lagra skickade data under noden `/content/pdfsubmissions` använder vi OSGi-tjänsten `GetResolver` för att spara skickade data med hjälp av `fd-service`-systemanvändaren som finns tillgänglig i alla AEM Forms-installationer.

