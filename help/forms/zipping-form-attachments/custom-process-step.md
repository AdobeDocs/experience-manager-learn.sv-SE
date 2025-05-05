---
title: Anpassat processsteg till ZIP-filbilagor
description: Anpassat steg för att lägga till adaptiva formulärbilagor i en ZIP-fil och lagra ZIP-filen i en arbetsflödesvariabel
feature: Adaptive Forms
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
kt: kt-8049
exl-id: 1131dca8-882d-4904-8691-95468fb708b7
duration: 75
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '149'
ht-degree: 0%

---


# Anpassat processsteg

Ett anpassat processsteg implementerades för att skapa ZIP-filen som innehåller de bifogade formulären. [Följ de här instruktionerna](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/creating-your-first-osgi-bundle/create-your-first-osgi-bundle.html?lang=sv-SE) om du inte är van vid att skapa ett OSGi-paket.

Koden i det anpassade processsteget gör följande:

- Fråga efter alla adaptiva formulärbilagor under nyttolastmappen. Mappnamnet skickas som ett processargument till processsteget.
- Skapa en ZIP-fil som innehåller de bifogade formulären och lagra den i nyttolastmappen.
- Ange värdet för arbetsflödesvariabeln (no_of_attachments).

```java
package com.aemforms.formattachments.core;

import javax.jcr.Binary;
import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.ValueFactory;

import javax.jcr.Node;
import javax.jcr.Session;

import org.osgi.framework.Constants;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.adobe.aemfd.docmanager.Document;
import com.adobe.granite.workflow.WorkflowException;
import com.adobe.granite.workflow.WorkflowSession;
import com.adobe.granite.workflow.exec.WorkItem;
import com.adobe.granite.workflow.exec.WorkflowProcess;
import com.adobe.granite.workflow.metadata.MetaDataMap;
import com.day.cq.search.PredicateGroup;
import com.day.cq.search.Query;
import com.day.cq.search.QueryBuilder;
import com.day.cq.search.result.Hit;
import com.day.cq.search.result.SearchResult;

@Component(property = {
        Constants.SERVICE_DESCRIPTION + "=Zip form attachments",
        Constants.SERVICE_VENDOR + "=Adobe Systems",
        "process.label" + "=Zip form attachments"
})

public class ZipFormAttachments implements WorkflowProcess {

     private static final Logger log = LoggerFactory.getLogger(ZipFormAttachments.class);
     @Reference
     QueryBuilder queryBuilder;

     @Override
     public void execute(WorkItem workItem, WorkflowSession workflowSession, MetaDataMap processArguments) throws WorkflowException {
             String payloadPath = workItem.getWorkflowData().getPayload().toString();
             log.debug("The payload path is " + payloadPath);
             MetaDataMap metaDataMap = workItem.getWorkflow().getWorkflowData().getMetaDataMap();
             Session session = workflowSession.adaptTo(Session.class);
             Map<String, String> map = new HashMap<String, String>();
             map.put("path", workItem.getWorkflowData().getPayload().toString() + "/" + processArguments.get("PROCESS_ARGS", "string").toString());
             map.put("type", "nt:file");
             Query query = queryBuilder.createQuery(PredicateGroup.create(map), workflowSession.adaptTo(Session.class));
             query.setStart(0);
             query.setHitsPerPage(20);
             SearchResult result = query.getResult();
             log.debug("Get result hits " + result.getHits().size());
             ByteArrayOutputStream baos = new ByteArrayOutputStream();
             ZipOutputStream zipOut = new ZipOutputStream(baos);
             int no_of_attachments = result.getHits().size();
             for (Hit hit: result.getHits()) {
                     try {
                             String attachmentPath = hit.getPath();
                             log.debug("The hit path is " + hit.getPath());
                             Node attachmentNode = session.getNode(attachmentPath + "/jcr:content");
                             InputStream attachmentStream = attachmentNode.getProperty("jcr:data").getBinary().getStream();
                             ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                             int nRead;
                             byte[] data = new byte[1024];
                             while ((nRead = attachmentStream.read(data, 0, data.length)) != -1) {
                                     buffer.write(data, 0, nRead);
                             }

                             buffer.flush();
                             byte[] byteArray = buffer.toByteArray();
                             ZipEntry zipEntry = new ZipEntry(hit.getTitle());
                             zipOut.putNextEntry(zipEntry);
                             zipOut.write(byteArray);
                             zipOut.closeEntry();

                     } catch (Exception e) {
                             log.debug("The error message is " + e.getMessage());
                     }
             }
             try {
                    zipOut.close();
                    Node payloadNode = session.getNode(payloadPath);
                    Node zippedFileNode =  payloadNode.addNode("zipped_attachments.zip", "nt:file");
                    javax.jcr.Node resNode = zippedFileNode.addNode("jcr:content", "nt:resource");

                    ValueFactory valueFactory = session.getValueFactory();
                    Document zippedDocument = new Document(baos.toByteArray());

                    Binary contentValue = valueFactory.createBinary(zippedDocument.getInputStream());
                    metaDataMap.put("no_of_attachments", no_of_attachments);

                    workflowSession.updateWorkflowData(workItem.getWorkflow(), workItem.getWorkflow().getWorkflowData());
                    log.debug("Updated workflow");
                    resNode.setProperty("jcr:data", contentValue);
                    session.save();
                    zippedDocument.close();

             } catch (IOException | RepositoryException e) {
                     log.error("Error in closing zipout", e);
             }
     }
}
```

>[!NOTE]
>
> Kontrollera att du har en variabel som heter _no_of_attachments_ av typen Double i arbetsflödet för att koden ska fungera.

## Nästa steg

[Fyll i ArrayList-arbetsflödesvariabler med bilagor och namn på bifogad fil](./custom-process-step.md)


