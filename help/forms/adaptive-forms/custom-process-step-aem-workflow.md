---
title: Implementera anpassat processsteg
description: Skriva adaptiva formulärbilagor till filsystemet med anpassade processsteg
feature: Workflow
version: 6.5
topic: Development
role: Developer
level: Experienced
exl-id: 879518db-3f05-4447-86e8-5802537584e5
last-substantial-update: 2021-06-09T00:00:00Z
source-git-commit: 7a2bb61ca1dea1013eef088a629b17718dbbf381
workflow-type: tm+mt
source-wordcount: '813'
ht-degree: 0%

---

# Anpassat processsteg

Den här självstudiekursen är avsedd för AEM Forms-kunder som behöver implementera anpassade processsteg. Ett processteg kan köra ECMA-skript eller anropa anpassad Java-kod för att utföra åtgärder. I den här självstudiekursen beskrivs de steg som behövs för att implementera WorkflowProcess som körs i processteget.

Det främsta skälet till att implementera anpassade processsteg är att utöka AEM arbetsflöde. Om du till exempel använder AEM Forms-komponenter i arbetsflödesmodellen kanske du vill utföra följande åtgärder:

* Spara de anpassade formulärbilagorna i filsystemet
* Bearbeta inskickade data

För att uppnå ovanstående användningsfall skriver du vanligtvis en OSGi-tjänst som körs i processteget.

## Create Maven Project

Det första steget är att skapa ett maven-projekt med lämplig Adobe Maven Archetype. De detaljerade stegen finns i den här [artikel](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/creating-your-first-osgi-bundle/create-your-first-osgi-bundle.html). När du har importerat ditt maven-projekt till förmörkning är du redo att börja skriva din första OSGi-komponent som kan användas i ditt steg i processen.


### Skapa klass som implementerar WorkflowProcess

Öppna maven-projektet i din förmörkade utvecklingsmiljö. Expandera **projectname** > **kärna** mapp. Expandera mappen src/main/java. Du bör se ett paket som avslutas med &quot;core&quot;. Skapa Java-klass som implementerar WorkflowProcess i det här paketet. Du måste åsidosätta körningsmetoden. Den körda metodens signatur är som följer public void execute(WorkItem, WorkflowSession, workflowSession, MetaDataMap processArguments) ger WorkflowException Körningsmetoden ger åtkomst till följande tre variabler

**WorkItem**: Variabeln workItem ger åtkomst till data relaterade till arbetsflödet. Den offentliga API-dokumentationen är tillgänglig [här.](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/diff-previous/changes/com.adobe.granite.workflow.WorkflowSession.html)

**WorkflowSession**: Den här variabeln workflowSession ger dig möjlighet att styra arbetsflödet. Den offentliga API-dokumentationen är tillgänglig [här](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/diff-previous/changes/com.adobe.granite.workflow.WorkflowSession.html)

**MetaDataMap**: Alla metadata som är associerade med arbetsflödet. Alla processargument som skickas till processsteget är tillgängliga med MetaDataMap-objektet.[API-dokumentation](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/workflow/metadata/MetaDataMap.html)

I den här självstudiekursen ska vi skriva de bilagor som lagts till i det anpassade formuläret i filsystemet som en del av AEM arbetsflöde.

Följande Java-klass har skrivits för att uppnå detta användningsfall

Låt oss titta på den här koden

```java
package com.learningaemforms.adobe.core;

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
    Constants.SERVICE_DESCRIPTION + "=Write Adaptive Form Attachments to File System",
    Constants.SERVICE_VENDOR + "=Adobe Systems",
    "process.label" + "=Save Adaptive Form Attachments to File System"
})
public class WriteFormAttachmentsToFileSystem implements WorkflowProcess {

    private static final Logger log = LoggerFactory.getLogger(WriteFormAttachmentsToFileSystem.class);
    @Reference
    QueryBuilder queryBuilder;

    @Override
    public void execute(WorkItem workItem, WorkflowSession workflowSession, MetaDataMap processArguments)
    throws WorkflowException {
        // TODO Auto-generated method stub
        log.debug("The string I got was ..." + processArguments.get("PROCESS_ARGS", "string").toString());
        String[] params = processArguments.get("PROCESS_ARGS", "string").toString().split(",");
        String attachmentsPath = params[0];
        String saveToLocation = params[1];
        log.debug("The seperator is" + File.separator);
        String payloadPath = workItem.getWorkflowData().getPayload().toString();
        Map<String, String> map = new HashMap<String, String> ();
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
                log.debug("Error saving file " + e.getMessage());
            }
```

Rad 1 - definierar komponentens egenskaper. Egenskapen process.label är vad du kommer att se när du associerar OSGi-komponenten med processteget, vilket visas i en av skärmbilderna nedan.

Rader 13-15 - Processargumenten som skickas till den här OSGi-komponenten delas med avgränsaren &quot;,&quot;. Värdena för attachmentPath och saveToLocation extraheras sedan från strängarrayen.

* attachmentPath - Det här är samma plats som du angav i det adaptiva formuläret när du konfigurerade skicka-åtgärden för det adaptiva formuläret för att anropa AEM arbetsflöde. Detta är ett namn på mappen som du vill att de bifogade filerna ska sparas i AEM i förhållande till arbetsflödets nyttolast.

* saveToLocation - Det här är platsen där du vill att de bifogade filerna ska sparas i AEM filsystem.

Dessa två värden skickas som processargument, vilket visas i skärmbilden nedan.

![ProcessStep](assets/implement-process-step.gif)

Tjänsten QueryBuilder används för att fråga efter noder av typen nt:file i mappen attachmentsPath. Resten av koden itererar genom sökresultaten för att skapa ett Document-objekt och spara det i filsystemet


>[!NOTE]
>
>Eftersom vi använder Document-objekt som är specifikt för AEM Forms måste du ta med aemfd-client-sdk-beroendet i ditt maven-projekt. Grupp-ID:t är com.adobe.aemfd och artefakt-ID:t är aemfd-client-sdk.

#### Bygg och driftsätt

[Bygg paketet enligt beskrivningen här](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/creating-your-first-osgi-bundle/create-your-first-osgi-bundle.html)
[Kontrollera att paketet är distribuerat och i aktivt läge](http://localhost:4502/system/console/bundles)

Skapa en arbetsflödesmodell. Dra och släpp processsteg i arbetsflödesmodellen. Associera processteget med&quot;Spara adaptiva formulärbilagor i filsystemet&quot;.

Ange nödvändiga processargument avgränsade med kommatecken. Till exempel Bifogade filer,c:\\scrappp\\. Det första argumentet är den mapp där dina adaptiva formulärbilagor ska lagras i förhållande till arbetsflödets nyttolast. Detta måste vara samma värde som du angav när du konfigurerade åtgärden Skicka i adaptiv form. Det andra argumentet är den plats där du vill att de bifogade filerna ska lagras.

Skapa ett adaptivt formulär. Dra och släpp komponenten Bifogade filer i formuläret. Konfigurera formulärets Skicka-åtgärd för att anropa arbetsflödet som skapades i tidigare steg. Ange lämplig sökväg till bifogad fil.

Spara inställningarna.

Förhandsgranska formuläret. Lägg till några bilagor och skicka formuläret. Bifogade filer bör sparas i filsystemet på den plats som du har angett i arbetsflödet.
