---
title: Implementera anpassade processsteg med dialog
description: Skriva adaptiva formulärbilagor till filsystemet med anpassade processsteg
feature: Workflow
version: 6.5
topic: Development
role: Developer
level: Experienced
last-substantial-update: 2021-06-09T00:00:00Z
exl-id: 149d2c8c-bf44-4318-bba8-bec7e25da01b
duration: 135
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '446'
ht-degree: 0%

---

# Anpassat processsteg

Den här självstudiekursen är avsedd för AEM Forms-kunder som behöver implementera en anpassad arbetsflödeskomponent. Det första steget i att skapa en arbetsflödeskomponent är att skriva din Java-kod som ska associeras med arbetsflödeskomponenten. I den här självstudiekursen ska vi skriva en enkel java-klass för att lagra de adaptiva formulärbilagorna i filsystemet. Den här java-koden läser de argument som anges i arbetsflödeskomponenten.

Följande steg krävs för att skriva java-klassen och distribuera klassen som ett OSGi-paket

## Create Maven Project

Det första steget är att skapa ett maven-projekt med lämplig Adobe Maven Archetype. De detaljerade stegen finns i den här [artikel](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/creating-your-first-osgi-bundle/create-your-first-osgi-bundle.html). När du har importerat ditt maven-projekt till förmörkning är du redo att börja skriva din första OSGi-komponent som kan användas i ditt steg i processen.


### Skapa klass som implementerar WorkflowProcess

Öppna maven-projektet i din förmörkade utvecklingsmiljö. Expandera **projectname** > **kärna** mapp. Expandera mappen src/main/java. Du bör se ett paket som avslutas med &quot;core&quot;. Skapa Java-klass som implementerar WorkflowProcess i det här paketet. Du måste åsidosätta körningsmetoden. Den körda metodens signatur är följande offentliga void execute(WorkItem, WorkflowSession workflowSession, MetaDataMap processArguments) orsakar WorkflowException

I den här självstudiekursen ska vi skriva de bilagor som lagts till i det anpassade formuläret i filsystemet som en del av AEM arbetsflöde.

Följande Java-klass har skrivits för att uppnå detta användningsfall

Låt oss titta på koden

```java
package com.mysite.core;
import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
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
  Constants.SERVICE_DESCRIPTION + "=Custom component to wrtie form attachments to file system",
  Constants.SERVICE_VENDOR + "=Adobe Systems",
  "process.label" + "=Custom component to wrtie form attachments to file system"
})
public class WriteFormAttachmentsToFileSystem implements WorkflowProcess {

  private static final Logger log = LoggerFactory.getLogger(WriteFormAttachmentsToFileSystem.class);
  @Reference
  QueryBuilder queryBuilder;

  @Override
  public void execute(WorkItem workItem, WorkflowSession workflowSession, MetaDataMap metaDataMap)
  throws WorkflowException {

    String attachmentsPath = metaDataMap.get("attachmentsPath", String.class);

    log.debug("Got attachments path: " + attachmentsPath);
    String saveToLocation = metaDataMap.get("SaveToLocation", String.class);
    log.debug("Got save location: " + saveToLocation);

    log.debug("The seperator is" + File.separator);
    String payloadPath = workItem.getWorkflowData().getPayload().toString();
    Map < String, String > map = new HashMap < String, String > ();
    map.put("path", payloadPath + "/" + attachmentsPath);
    File saveLocationFolder = new File(saveToLocation);
    if (!saveLocationFolder.exists()) {
      saveLocationFolder.mkdirs();
    }

    map.put("type", "nt:file");
    Query query = queryBuilder.createQuery(PredicateGroup.create(map), workflowSession.adaptTo(Session.class));
    query.setStart(0);
    query.setHitsPerPage(20);

    SearchResult result = query.getResult();
    log.debug("Got  " + result.getHits().size() + " attachments ");
    Node attachmentNode = null;
    for (Hit hit: result.getHits()) {
      try {
        String path = hit.getPath();
        log.debug("The attachment title is  " + hit.getTitle() + " and the attachment path is  " + path);
        attachmentNode = workflowSession.adaptTo(Session.class).getNode(path + "/jcr:content");
        InputStream documentStream = attachmentNode.getProperty("jcr:data").getBinary().getStream();
        Document attachmentDoc = new Document(documentStream);
        attachmentDoc.copyToFile(new File(saveLocationFolder + File.separator + hit.getTitle()));
        attachmentDoc.close();
      } catch (Exception e) {
        log.error("Error saving file " + e.getMessage());
      }
    }
  }
}
```


* attachmentsPath - Det här är samma plats som du angav i det adaptiva formuläret när du konfigurerade skicka-åtgärden för det adaptiva formuläret för att starta AEM. Detta är ett namn på mappen som du vill att de bifogade filerna ska sparas i AEM i förhållande till arbetsflödets nyttolast.

* saveToLocation - Det här är platsen där du vill att de bifogade filerna ska sparas i AEM filsystem.

Dessa två värden skickas som processargument med hjälp av dialogrutan för arbetsflödeskomponenten

![ProcessStep](assets/custom-workflow-component.png)

Tjänsten QueryBuilder används för att fråga efter noder av typen nt:file i mappen attachmentsPath. Resten av koden itererar genom sökresultaten för att skapa ett Document-objekt och spara det i filsystemet


>[!NOTE]
>
>Eftersom vi använder Document-objekt som är specifikt för AEM Forms måste du ta med beroendet aemfd-client-sdk i ditt maven-projekt.

```xml
<dependency>
    <groupId>com.adobe.aemfd</groupId>
    <artifactId>aemfd-client-sdk</artifactId>
    <version>6.0.772</version>
</dependency>
```

#### Bygg och driftsätt

[Bygg paketet enligt beskrivningen här](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/creating-your-first-osgi-bundle/create-your-first-osgi-bundle.html)
[Kontrollera att paketet är distribuerat och i aktivt läge](http://localhost:4502/system/console/bundles)

## Nästa steg

Skapa [anpassad arbetsflödeskomponent](./custom-workflow-component.md)

