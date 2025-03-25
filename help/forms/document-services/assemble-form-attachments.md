---
title: Sammanställa formulärbilagor
description: Sammanställa formulärbilagor i angiven ordning
feature: Assembler
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-6406
thumbnail: kt-6406.jpg
topic: Development
role: Developer
level: Experienced
exl-id: a5df8780-b7ab-4b91-86f6-a24392752107
last-substantial-update: 2021-07-07T00:00:00Z
duration: 150
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '589'
ht-degree: 0%

---

# Sammanställa formulärbilagor

I den här artikeln finns resurser för att sammanställa adaptiva formulärbilagor i en viss ordning. De bifogade formulären måste vara i pdf-format för att exempelkoden ska fungera. Här följer ett exempel.
Användaren som fyller i ett anpassat formulär bifogar ett eller flera PDF-dokument till formuläret.
När du skickar in formuläret sätter du ihop de bifogade filerna för att generera en PDF. Du kan ange i vilken ordning de bifogade filerna ska monteras för att skapa den slutliga PDF-filen.

## Skapa OSGi-komponent som implementerar WorkflowProcess-gränssnittet

Skapa en OSGi-komponent som implementerar gränssnittet [com.adobe.granite.workflow.exec.WorkflowProcess](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/workflow/exec/WorkflowProcess.html). Koden i den här komponenten kan associeras med processstegskomponenten i AEM-arbetsflödet. Körningsmetoden för gränssnittet com.adobe.granite.workflow.exec.WorkflowProcess implementeras i den här komponenten.

När ett anpassningsbart formulär skickas för att utlösa ett AEM-arbetsflöde lagras skickade data i den angivna filen under nyttolastmappen. Det här är till exempel den skickade datafilen. Vi måste montera de bilagor som anges under ID-kortet och bankkontoutdragstaggen.
![skickad-data](assets/submitted-data.JPG).

### Hämta taggnamnen

Ordningen på de bifogade filerna anges som processtegargument i arbetsflödet, vilket visas på skärmbilden nedan. Här sätter vi ihop de bilagor som lagts till i fältets ID-kort följt av bankkontoutdrag

![process-step](assets/process-step.JPG)

Följande kodfragment extraherar namnen på bilagor från processargumenten

```java
String  []attachmentNames  = arg2.get("PROCESS_ARGS","string").toString().split(",");
```

### Skapa DDX från namnen på de bifogade filerna

Sedan måste vi skapa [DX ](https://helpx.adobe.com/pdf/aem-forms/6-2/ddxRef.pdf)-dokument (Document Description XML) som används av Assembler-tjänsten för att samla ihop dokument. Följande är den DDX som skapades från processargumenten. Med NoForms-elementet kan du förenkla XFA-baserade dokument innan de sätts samman. Observera att källelementen i PDF är i rätt ordning enligt processargumenten.

![ddx-xml](assets/ddx.PNG)

### Skapa dokumentkarta

Sedan skapar vi en karta över dokument med namnet på den bifogade filen som nyckel och den bifogade filen som värde. Tjänsten Query Builder användes för att fråga efter de bifogade filerna under nyttolastsökvägen och skapa dokumentkartan. Den här kartan med DX behövs för att monteringstjänsten ska kunna sammanställa den slutliga PDF-filen.

```java
public Map<String, Object> createMapOfDocuments(String payloadPath,WorkflowSession workflowSession )
{
  Map<String, String> queryMap = new HashMap<String, String>();
  Map<String,Object>mapOfDocuments = new HashMap<String,Object>();
  queryMap.put("type", "nt:file");
  queryMap.put("path",payloadPath);
  Query query = queryBuilder.createQuery(PredicateGroup.create(queryMap),workflowSession.adaptTo(Session.class));
  query.setStart(0);
  query.setHitsPerPage(30);
  SearchResult result = query.getResult();
  log.debug("Get result hits "+result.getHits().size());
  for (Hit hit : result.getHits()) {
    try {
          String path = hit.getPath();
          log.debug("The title "+hit.getTitle()+" path "+path);
          if(hit.getTitle().endsWith("pdf"))
           {
             com.adobe.aemfd.docmanager.Document attachmentDocument = new com.adobe.aemfd.docmanager.Document(path);
             mapOfDocuments.put(hit.getTitle(),attachmentDocument);
             log.debug("@@@@Added to map@@@@@ "+hit.getTitle());
           }
        }
    catch (Exception e)
       {
          log.debug(e.getMessage());
       }

}
return mapOfDocuments;
}
```

### Använd AssemblerService för att samla ihop dokumenten

När du har skapat DDX-filen och dokumentöversikten är nästa steg att använda AssemblerService för att montera dokumenten.
Följande kod sätter ihop och returnerar den sammansatta PDF-filen.

```java
private com.adobe.aemfd.docmanager.Document assembleDocuments(Map<String, Object> mapOfDocuments, com.adobe.aemfd.docmanager.Document ddxDocument)
{
    AssemblerOptionSpec aoSpec = new AssemblerOptionSpec();
    aoSpec.setFailOnError(true);
    AssemblerResult ar = null;
    try
    {
        ar = assemblerService.invoke(ddxDocument, mapOfDocuments, aoSpec);
        return (com.adobe.aemfd.docmanager.Document) ar.getDocuments().get("GeneratedDocument.pdf");
    }
    catch (OperationException e)
    {
        log.debug(e.getMessage());
    }
    return null;
    
}
```

### Spara den sammansatta PDF-filen under nyttolastmappen

Det sista steget är att spara den sammansatta PDF-filen under nyttolastmappen. Den här PDF-filen kan sedan öppnas i efterföljande steg i arbetsflödet för vidare bearbetning.
Följande kodfragment användes för att spara filen under nyttolastmappen

```java
Session session = workflowSession.adaptTo(Session.class);
javax.jcr.Node payloadNode =  workflowSession.adaptTo(Session.class).getNode(workItem.getWorkflowData().getPayload().toString());
log.debug("The payload Path is "+payloadNode.getPath());
javax.jcr.Node assembledPDFNode = payloadNode.addNode("assembled-pdf.pdf", "nt:file"); 
javax.jcr.Node jcrContentNode =  assembledPDFNode.addNode("jcr:content", "nt:resource");
Binary binary =  session.getValueFactory().createBinary(assembledDocument.getInputStream());
jcrContentNode.setProperty("jcr:data", binary);
log.debug("Saved !!!!!!"); 
session.save();
```

Nedan följer mappstrukturen för nyttolast när formulärbilagor har monterats och lagrats.

![nyttload-structure](assets/payload-structure.JPG)

### För att få den här funktionen att fungera på din AEM-server

* Hämta formuläret [Sammanställ formulärbilagor](assets/assemble-form-attachments-af.zip) till ditt lokala system.
* Importera formuläret från sidan [Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments).
* Hämta [arbetsflöde](assets/assemble-form-attachments.zip) och importera till AEM med hjälp av pakethanteraren.
* Hämta det [anpassade paketet](assets/assembletaskattachments.assembletaskattachments.core-1.0-SNAPSHOT.jar)
* Distribuera och starta paketet med [webbkonsolen](http://localhost:4502/system/console/bundles)
* Peka webbläsaren på [Sammansättningsbifogade filer](http://localhost:4502/content/dam/formsanddocuments/assembleattachments/jcr:content?wcmmode=disabled)
* Lägg till en bifogad fil i ID-dokumentet och ett par PDF-dokument i avsnittet med bankutdrag
* Skicka formuläret för att utlösa arbetsflödet
* Kontrollera arbetsflödets [nyttolastmapp i crx](http://localhost:4502/crx/de/index.jsp#/var/fd/dashboard/payload) för den sammansatta PDF-filen

>[!NOTE]
> Om du har aktiverat loggning för det anpassade paketet skrivs DDX-filen och den sammansatta filen till mappen för din AEM-installation.
