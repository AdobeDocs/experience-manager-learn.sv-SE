---
title: Generera PDF med data från grundläggande komponentbaserad adaptiv form
description: Sammanfoga data från inskickade kärnkomponentbaserade formulär med XDP-mallar i arbetsflödet
version: 6.5
feature: Forms Service
topic: Development
role: Developer
level: Experienced
jira: KT-15025
last-substantial-update: 2024-02-26T00:00:00Z
exl-id: cae160f2-21a5-409c-942d-53061451b249
duration: 97
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '324'
ht-degree: 0%

---

# Generera PDF med data från blankettinlämning som bygger på kärnkomponenter

Här är den reviderade texten med&quot;Core Components&quot; (kärnkomponenter) med inledande versal:

Ett typiskt scenario är att generera ett PDF från data som skickas via en Core Components-baserad adaptiv form. Dessa data är alltid i JSON-format. Om du vill skapa en PDF med API:t Render PDF måste JSON-data konverteras till XML-format. Metoden `toString` i `org.json.XML` används för den här konverteringen. Mer information finns i [dokumentationen för `org.json.XML.toString` method](https://www.javadoc.io/doc/org.json/json/20171018/org/json/XML.html#toString-java.lang.Object-).

## Anpassningsbart formulär baserat på JSON-schema

Följ de här stegen för att skapa ett JSON-schema för ditt adaptiva formulär:

### Generera exempeldata för XDP

Så här effektiviserar du processen:

1. Öppna XDP-filen i AEM Forms Designer.
1. Navigera till Arkiv > Formuläregenskaper > Förhandsgranska.
1. Välj&quot;Generera förhandsgranskningsdata&quot;.
1. Klicka på&quot;Generera&quot;.
1. Tilldela ett beskrivande filnamn, till exempel `form-data.xml`.

### Generera JSON-schema från XML-data

Du kan använda vilket kostnadsfritt onlineverktyg som helst för att [konvertera XML till JSON](https://jsonformatter.org/xml-to-jsonschema) med hjälp av XML-data som genererats i föregående steg.

### Anpassad arbetsflödesprocess för att konvertera JSON till XML

Den angivna koden konverterar JSON till XML och lagrar den resulterande XML-koden i en arbetsflödesprocessvariabel som heter `dataXml`.

```java
import org.slf4j.LoggerFactory;
import com.adobe.granite.workflow.WorkflowException;
import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import javax.jcr.Node;
import javax.jcr.Session;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.osgi.service.component.annotations.Component;
import com.adobe.granite.workflow.WorkflowSession;
import com.adobe.granite.workflow.exec.WorkItem;
import com.adobe.granite.workflow.exec.WorkflowProcess;
import com.adobe.granite.workflow.metadata.MetaDataMap;

@Component(property = {
    "service.description=Convert JSON to XML",
    "process.label=Convert JSON to XML"
})
public class ConvertJSONToXML implements WorkflowProcess {

    private static final Logger log = LoggerFactory.getLogger(ConvertJSONToXML.class);

    @Override
    public void execute(final WorkItem workItem, final WorkflowSession workflowSession, final MetaDataMap arg2) throws WorkflowException {
        String processArgs = arg2.get("PROCESS_ARGS", "string");
        log.debug("The process argument I got was " + processArgs);
        
        String submittedDataFile = processArgs;
        String payloadPath = workItem.getWorkflowData().getPayload().toString();
        log.debug("The payload in convert json to xml " + payloadPath);
        
        String dataFilePath = payloadPath + "/" + submittedDataFile + "/jcr:content";
        try {
            Session session = workflowSession.adaptTo(Session.class);
            Node submittedJsonDataNode = session.getNode(dataFilePath);
            InputStream jsonDataStream = submittedJsonDataNode.getProperty("jcr:data").getBinary().getStream();
            BufferedReader streamReader = new BufferedReader(new InputStreamReader(jsonDataStream, "UTF-8"));
            StringBuilder stringBuilder = new StringBuilder();
            String inputStr;
            while ((inputStr = streamReader.readLine()) != null) {
                stringBuilder.append(inputStr);
            }
            JSONObject submittedJson = new JSONObject(stringBuilder.toString());
            log.debug(submittedJson.toString());
            
            String xmlString = XML.toString(submittedJson);
            log.debug("The json converted to XML " + xmlString);
            
            MetaDataMap metaDataMap = workItem.getWorkflow().getWorkflowData().getMetaDataMap();
            metaDataMap.put("xmlData", xmlString);
        } catch (Exception e) {
            log.error("Error converting JSON to XML: " + e.getMessage(), e);
        }
    }
}
```

### Skapa arbetsflöde

Om du vill hantera formuläröverföringar skapar du ett arbetsflöde som innehåller två steg:

1. I det inledande steget används en anpassad process för att omvandla skickade JSON-data till XML.
1. I det följande steget genereras ett PDF genom att XML-data kombineras med XDP-mallen.

![json-to-xml](assets/json-to-xml-process-step.png)


## Distribuera exempelkoden

Så här testar du detta på den lokala servern:

1. [Hämta och installera det anpassade paketet via AEM OSGi-webbkonsolen](assets/convertJsonToXML.core-1.0.0-SNAPSHOT.jar).
1. [Importera arbetsflödespaketet](assets/workflow_to_render_pdf.zip).
1. [Importera exemplet Adaptivt formulär och XDP-mall](assets/adaptive_form_and_xdp_template.zip).
1. [Förhandsgranska det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/f23/jcr:content?wcmmode=disabled).
1. Fyll i några formulärfält.
1. Skicka formuläret för att starta AEM arbetsflöde.
1. Hitta det återgivna PDF i arbetsflödets nyttolastmapp.
