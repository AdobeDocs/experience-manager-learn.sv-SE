---
title: Konverterar kommaavgränsad sträng till strängmatris i AEM Forms Workflow
description: När formulärdatamodellen har en matris med strängar som en indataparameter, måste du massera data som genererats från en skickaåtgärd i ett adaptivt formulär innan du anropar åtgärden skicka för formulärdatamodellen.
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
jira: KT-8507
exl-id: 9ad69407-2413-416f-9cec-43f88989b31d
last-substantial-update: 2021-06-09T00:00:00Z
duration: 115
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '340'
ht-degree: 0%

---

# Konverterar kommaavgränsad sträng till strängarray {#setting-value-of-json-data-element-in-aem-forms-workflow}

När formuläret baseras på en formulärdatamodell som har en array med strängar som indataparameter, måste du ändra skickade adaptiva formulärdata för att infoga en array med strängar. Om du till exempel har bundit ett kryssrutefält till ett element i en formulärdatamodell av typen strängarray, kommer data från kryssrutefältet att vara i ett kommaavgränsat strängformat. I exempelkoden nedan visas hur du ersätter den kommaavgränsade strängen med en array med strängar.

## Skapa ett processsteg

Ett processsteg används i ett AEM arbetsflöde när vi vill att arbetsflödet ska köra en viss logik. Processsteget kan associeras med ett ECMA-skript eller en OSGi-tjänst. Vårt anpassade processteg kör OSGi-tjänsten.

De data som skickas har följande format. Värdet för elementet businessUnits är en kommaavgränsad sträng som måste konverteras till en array med strängar.

![skickad-data](assets/submitted-data-string.png)

Indatadata för resten av slutpunkten som är associerad med formulärdatamodellen förväntar sig en array med strängar som visas på den här skärmbilden. Den anpassade koden i processsteget konverterar skickade data till rätt format.

![fdm-string-array](assets/string-array-fdm.png)

Vi skickar JSON-objektsökvägen och elementnamnet till processsteget. Koden i processsteget ersätter elementets kommaseparerade värden i en array med strängar.
![process-step](assets/create-string-array.png)

>[!NOTE]
>
>Kontrollera att sökvägen till datafilen i det adaptiva formulärets överföringsalternativ är inställd på &quot;Data.xml&quot;. Detta beror på att koden i processsteget söker efter filen Data.xml under nyttolastmappen.

## Bearbeta stegkod

```java
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.jcr.Binary;
import javax.jcr.Node;
import javax.jcr.Session;

import org.osgi.framework.Constants;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.adobe.granite.workflow.WorkflowException;
import com.adobe.granite.workflow.WorkflowSession;
import com.adobe.granite.workflow.exec.WorkItem;
import com.adobe.granite.workflow.exec.WorkflowProcess;
import com.adobe.granite.workflow.metadata.MetaDataMap;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component(property = {
    Constants.SERVICE_DESCRIPTION + "=Create String Array",
    Constants.SERVICE_VENDOR + "=Adobe Systems",
    "process.label" + "=Replace comma seperated string with string array"
})

public class CreateStringArray implements WorkflowProcess {
    private static final Logger log = LoggerFactory.getLogger(CreateStringArray.class);
    @Override
    public void execute(WorkItem workItem, WorkflowSession workflowSession, MetaDataMap arg2) throws WorkflowException {
        log.debug("The string I got was ..." + arg2.get("PROCESS_ARGS", "string").toString());
        String[] arguments = arg2.get("PROCESS_ARGS", "string").toString().split(",");
        String objectName = arguments[0];
        String propertyName = arguments[1];

        String objects[] = objectName.split("\\.");
        System.out.println("The params is " + propertyName);
        log.debug("The params string is " + objectName);
        String payloadPath = workItem.getWorkflowData().getPayload().toString();
        log.debug("The payload  in set Elmement Value in Json is  " + workItem.getWorkflowData().getPayload().toString());
        String dataFilePath = payloadPath + "/Data.xml/jcr:content";
        Session session = workflowSession.adaptTo(Session.class);
        Node submittedDataNode = null;
        try {
            submittedDataNode = session.getNode(dataFilePath);

            InputStream submittedDataStream = submittedDataNode.getProperty("jcr:data").getBinary().getStream();
            BufferedReader streamReader = new BufferedReader(new InputStreamReader(submittedDataStream, "UTF-8"));
            StringBuilder stringBuilder = new StringBuilder();

            String inputStr;
            while ((inputStr = streamReader.readLine()) != null)
                stringBuilder.append(inputStr);
            JsonParser jsonParser = new JsonParser();
            JsonObject jsonObject = jsonParser.parse(stringBuilder.toString()).getAsJsonObject();
            System.out.println("The json object that I got was " + jsonObject);
            JsonObject targetObject = null;

            for (int i = 0; i < objects.length - 1; i++) {
                System.out.println("The object name is " + objects[i]);
                if (i == 0) {
                    targetObject = jsonObject.get(objects[i]).getAsJsonObject();
                } else {
                    targetObject = targetObject.get(objects[i]).getAsJsonObject();

                }

            }

            System.out.println("The final object is " + targetObject.toString());
            String businessUnits = targetObject.get(propertyName).getAsString();
            System.out.println("The values of " + propertyName + " are " + businessUnits);

            JsonArray jsonArray = new JsonArray();

            String[] businessUnitsArray = businessUnits.split(",");
            for (String name: businessUnitsArray) {
                jsonArray.add(name);
            }

            targetObject.add(propertyName, jsonArray);
            System.out.println(" After updating the property " + targetObject.toString());
            InputStream is = new ByteArrayInputStream(jsonObject.toString().getBytes());
            System.out.println("The changed json data  is " + jsonObject.toString());
            Binary binary = session.getValueFactory().createBinary(is);
            submittedDataNode.setProperty("jcr:data", binary);
            session.save();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
}
```

Exempelpaketet kan [hämtas här](assets/CreateStringArray.CreateStringArray.core-1.0-SNAPSHOT.jar)
