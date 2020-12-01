---
title: Implementera anpassat processsteg
seo-title: Implementera anpassat processsteg
description: Skriva adaptiva formulärbilagor till filsystemet med anpassade processsteg
seo-description: Skriva adaptiva formulärbilagor till filsystemet med anpassade processsteg
feature: workflow
topics: development
audience: developer
doc-type: tutorial
activity: understand
version: 6.5
translation-type: tm+mt
source-git-commit: 3a3832a05ed9598d970915adbc163254c6eb83f1
workflow-type: tm+mt
source-wordcount: '895'
ht-degree: 0%

---


# Anpassat processsteg

Den här självstudiekursen är avsedd för AEM Forms-kunder som behöver implementera anpassade processsteg. Ett processteg kan köra ECMA-skript eller anropa anpassad Java-kod för att utföra åtgärder. I den här självstudiekursen beskrivs de steg som behövs för att implementera WorkflowProcess som körs i processteget.

Det främsta skälet till att implementera anpassade processsteg är att utöka AEM arbetsflöde. Om du till exempel använder AEM Forms-komponenter i arbetsflödesmodellen kanske du vill utföra följande åtgärder:

* Spara de anpassade formulärbilagorna i filsystemet
* Bearbeta inskickade data

För att uppnå ovanstående användningsfall skriver du vanligtvis en OSGi-tjänst som körs i processteget.

## Create Maven Project

Det första steget är att skapa ett maven-projekt med lämplig Adobe Maven Archetype. De detaljerade stegen finns i den här [artikeln](https://helpx.adobe.com/experience-manager/using/maven_arch13.html). När du har importerat ditt maven-projekt till förmörkning är du redo att börja skriva din första OSGi-komponent som kan användas i ditt steg i processen.


### Skapa klass som implementerar WorkflowProcess

Öppna maven-projektet i din förmörkade utvecklingsmiljö. Expandera mappen **projektnamn** > **core**. Expandera mappen src/main/java. Du bör se ett paket som avslutas med &quot;core&quot;. Skapa Java-klass som implementerar WorkflowProcess i det här paketet. Du måste åsidosätta körningsmetoden. Signaturen för execute-metoden är följande
public void execute(WorkItem workItem, WorkflowSession, workflowSession, MetaDataMap processArguments)returnerar WorkflowException
Körningsmetoden ger åtkomst till följande tre variabler

**WorkItem**: Variabeln workItem ger åtkomst till data relaterade till arbetsflödet. Den offentliga API-dokumentationen är tillgänglig [här.](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/diff-previous/changes/com.adobe.granite.workflow.WorkflowSession.html)

**WorkflowSession**: Den här variabeln workflowSession ger dig möjlighet att styra arbetsflödet. Den offentliga API-dokumentationen är tillgänglig [här](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/diff-previous/changes/com.adobe.granite.workflow.WorkflowSession.html)

**MetaDataMap**: Alla metadata som är associerade med arbetsflödet. Alla processargument som skickas till processsteget är tillgängliga med MetaDataMap-objektet.[API-dokumentation](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/workflow/metadata/MetaDataMap.html)

I den här självstudiekursen ska vi skriva de bilagor som lagts till i det anpassade formuläret i filsystemet som en del av AEM arbetsflöde.

Följande Java-klass har skrivits för att uppnå detta användningsfall

Låt oss titta på den här koden

```
@Component(property = { Constants.SERVICE_DESCRIPTION + "=Write Adaptive Form Attachments to File System",
        Constants.SERVICE_VENDOR + "=Adobe Systems",
        "process.label" + "=Save Adaptive Form Attachments to File System" })
public class WriteFormAttachmentsToFileSystem implements WorkflowProcess {
     private static final Logger log = LoggerFactory.getLogger(WriteFormAttachmentsToFileSystem.class);
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
 
        String attachmentsFilePath = payloadPath + "/" + attachmentsPath + "/attachments";
        log.debug("The data file path is " + attachmentsFilePath);
 
        ResourceResolver resourceResolver = workflowSession.adaptTo(ResourceResolver.class);
 
        Resource attachmentsNode = resourceResolver.getResource(attachmentsFilePath);
        Iterator<Resource> attachments = attachmentsNode.listChildren();
        while (attachments.hasNext()) {
            Resource attachment = attachments.next();
            String attachmentPath = attachment.getPath();
            String attachmentName = attachment.getName();
 
            log.debug("The attachmentPath is " + attachmentPath + " and the attachmentname is " + attachmentName);
            com.adobe.aemfd.docmanager.Document attachmentDoc = new com.adobe.aemfd.docmanager.Document(attachmentPath,
                    attachment.getResourceResolver());
            try {
                File file = new File(saveToLocation + File.separator + workItem.getId());
                if (!file.exists()) {
                    file.mkdirs();
                }
 
                attachmentDoc.copyToFile(new File(file + File.separator + attachmentName));
 
                log.debug("Saved attachment" + attachmentName);
                attachmentDoc.close();
 
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
 
        }
 
    }
```

Rad 1 - definierar komponentens egenskaper. Egenskapen process.label är vad du kommer att se när du associerar OSGi-komponenten med processteget, vilket visas i en av skärmbilderna nedan.

Rader 13-15 - Processargumenten som skickas till den här OSGi-komponenten delas med avgränsaren &quot;,&quot;. Värdena för attachmentPath och saveToLocation extraheras sedan från strängarrayen.

* attachmentPath - Det här är samma plats som du angav i det adaptiva formuläret när du konfigurerade skicka-åtgärden för det adaptiva formuläret för att anropa AEM arbetsflöde. Detta är ett namn på mappen som du vill att de bifogade filerna ska sparas i AEM i förhållande till arbetsflödets nyttolast.

* saveToLocation - Det här är platsen där du vill att de bifogade filerna ska sparas i AEM filsystem.

Dessa två värden skickas som processargument, vilket visas i skärmbilden nedan.

![ProcessStep](assets/implement-process-step.gif)


Rad 19: skapar vi sedan attachmentFilePath. Sökvägen till den bifogade filen är som

    /var/fd/dashboard/payload/server0/2018-11-19/3EF6ENASOQTHCPLNDYVNAM7OKA_7/Bifogade filer/bifogade filer

* &quot;Bifogade filer&quot; är namnet på mappen i förhållande till arbetsflödets nyttolast som angavs när du konfigurerade det adaptiva formulärets sändningsalternativ.

   ![inskickningsalternativ](assets/af-submit-options.gif)

Rader 24-26 - Hämta ResourceResolver och sedan resursen som pekar på attachmentFilePath.

Resten av koden skapar Document-objekt genom att iterera genom det underordnade objektet för resursen som pekar på attachmentFilePath med API:t. Det här dokumentobjektet är specifikt för AEM Forms. Vi använder sedan metoden copyToFile för dokumentobjektet för att spara dokumentobjektet.

>[!NOTE]
>
>Eftersom vi använder Document-objekt som är specifikt för AEM Forms måste du ta med beroendet aemfd-client-sdk i ditt maven-projekt. Grupp-ID:t är com.adobe.aemfd och artefakt-ID:t är aemfd-client-sdk.

#### Bygg och driftsätt

[Bygg paketet enligt beskrivningen ](https://helpx.adobe.com/experience-manager/using/maven_arch13.html#BuildtheOSGibundleusingMaven)
[härKontrollera att paketet är distribuerat och i aktivt läge](http://localhost:4502/system/console/bundles)

Skapa en arbetsflödesmodell. Dra och släpp processsteg i arbetsflödesmodellen. Associera processteget med&quot;Spara adaptiva formulärbilagor i filsystemet&quot;.

Ange nödvändiga processargument avgränsade med kommatecken. Till exempel Bifogade filer,c:\\scrappp\\. Det första argumentet är den mapp där dina adaptiva formulärbilagor ska lagras i förhållande till arbetsflödets nyttolast. Detta måste vara samma värde som du angav när du konfigurerade åtgärden Skicka i adaptiv form. Det andra argumentet är den plats där du vill att de bifogade filerna ska lagras.

Skapa ett adaptivt formulär. Dra och släpp komponenten Bifogade filer i formuläret. Konfigurera formulärets Skicka-åtgärd för att anropa arbetsflödet som skapades i tidigare steg. Ange lämplig sökväg till bifogad fil.

Spara inställningarna.

Förhandsgranska formuläret. Lägg till några bilagor och skicka formuläret. Bifogade filer bör sparas i filsystemet på den plats som du har angett i arbetsflödet.

