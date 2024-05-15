---
title: Generera dokument för utskriftskanal genom att sammanfoga data
description: Lär dig hur du genererar dokument för utskriftskanaler genom att sammanfoga data som finns i indataströmmen
feature: Interactive Communication
doc-type: article
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 3bfbb4ef-0c51-445a-8d7b-43543a5fa191
last-substantial-update: 2019-07-07T00:00:00Z
duration: 151
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '445'
ht-degree: 0%

---

# Generera dokument för utskriftskanaler med inskickade data

Skriv ut kanaldokument genereras vanligtvis genom att data hämtas från en backend-datakälla via formulärdatamodellens get-tjänst. I vissa fall kan du behöva generera dokument för tryckkanaler med angivna data. Till exempel: Kunden fyller i ändringar av mottagarformulär och du kanske vill generera dokument för tryckkanaler med data från det skickade formuläret. För att kunna utföra den här åtgärden måste följande steg följas

## Skapa förifyllningstjänst

Tjänstnamnet &quot;ccm-print-test&quot; används för att få åtkomst till den här tjänsten. När den här förifyllda tjänsten har definierats kan du komma åt den här tjänsten antingen i serverns eller arbetsflödets processstegsimplementering för att generera dokumentet för tryckkanalen.

```java
import java.io.InputStream;
import org.osgi.service.component.annotations.Component;

import com.adobe.forms.common.service.ContentType;
import com.adobe.forms.common.service.DataOptions;
import com.adobe.forms.common.service.DataProvider;
import com.adobe.forms.common.service.FormsException;
import com.adobe.forms.common.service.PrefillData;

@Component(immediate = true, service = {DataProvider.class})
public class ICPrefillService implements DataProvider {

@Override
public String getServiceDescription() {
    // TODO Auto-generated method stub
    return "Prefill Service for IC Print Channel";
}

@Override
public String getServiceName() {
    // TODO Auto-generated method stub
    return "ccm-print-test";
}

@Override
public PrefillData getPrefillData(DataOptions options) throws FormsException {
    // TODO Auto-generated method stub
        PrefillData data = null;
        if (options != null && options.getExtras() != null && options.getExtras().get("data") != null) {
            InputStream is = (InputStream) options.getExtras().get("data");
            data = new PrefillData(is, options.getContentType() != null ? options.getContentType() : ContentType.JSON);
        }
        return data;
    }
}
```

### Skapa WorkflowProcess-implementering

Kodfragmentet för implementering av workflowProcess visas nedan. Den här koden körs när processteget i AEM arbetsflöde är kopplat till den här implementeringen. Implementeringen förväntar sig tre processargument som beskrivs nedan:

* Namnet på den DataFile-sökväg som angavs när det adaptiva formuläret konfigurerades
* Namn på utskriftskanalmallen
* Namnet på det genererade utskriftskanaldokumentet

Rad 98 - Eftersom den adaptiva formen baseras på formulärdatamodellen extraheras data som finns i datanoden för afBoundData.
Rad 128 - Tjänstnamnet för dataalternativ har angetts. Observera tjänstnamnet. Den måste matcha det namn som returnerades på rad 45 i föregående kodexempel.
Rad 135 - Dokumentet genereras med återgivningsmetoden för objektet PrintChannel


```java
String params = arg2.get("PROCESS_ARGS","string").toString();
    String payloadPath = workItem.getWorkflowData().getPayload().toString();
    String dataFile = params.split(",")[0];
    final String icFileName = params.split(",")[1];
    String dataFilePath = payloadPath + "/"+dataFile+"/jcr:content";
    Session session = workflowSession.adaptTo(Session.class);
    Node xmlDataNode = null;
    try {
        xmlDataNode = session.getNode(dataFilePath);
        InputStream xmlDataStream = xmlDataNode.getProperty("jcr:data").getBinary().getStream();
        JsonParser jsonParser = new JsonParser();
        BufferedReader streamReader = null;
        try {
            streamReader = new BufferedReader(new InputStreamReader(xmlDataStream, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        StringBuilder responseStrBuilder = new StringBuilder();
        String inputStr;
        try {
            while ((inputStr = streamReader.readLine()) != null)
                responseStrBuilder.append(inputStr);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String submittedDataXml = responseStrBuilder.toString();
        JsonObject jsonObject = jsonParser.parse(submittedDataXml).getAsJsonObject().get("afData").getAsJsonObject()
                .get("afBoundData").getAsJsonObject().get("data").getAsJsonObject();
        logger.info("Successfully Parsed gson" + jsonObject.toString());
        InputStream targetStream = IOUtils.toInputStream(jsonObject.toString());
        //InputStream targetStream = new ByteArrayInputStream(jsonObject.toString().getBytes());
        
        // Node dataNode = session.getNode(formName);
        logger.info("Got resource using resource resolver"
                );
        resHelper.callWith(getResolver.getFormsServiceResolver(), new Callable<Void>() {
            @Override
            public Void call() throws Exception {
                System.out.println("The target stream is "+targetStream.available());
                // TODO Auto-generated method stub
                com.adobe.fd.ccm.channels.print.api.model.PrintChannel printChannel = null;
                String formName = params.split(",")[2];
                logger.info("The form name I got was "+formName);
                printChannel = printChannelService.getPrintChannel(formName);
                logger.info("Did i get print channel?");
                com.adobe.fd.ccm.channels.print.api.model.PrintChannelRenderOptions options = new com.adobe.fd.ccm.channels.print.api.model.PrintChannelRenderOptions();
                options.setMergeDataOnServer(true);
                options.setRenderInteractive(false);
                com.adobe.forms.common.service.DataOptions dataOptions = new com.adobe.forms.common.service.DataOptions();
                dataOptions.setServiceName(printChannel.getPrefillService());
                // dataOptions.setExtras(map);
                dataOptions.setContentType(ContentType.JSON);
                logger.info("####Set the content type####");
                dataOptions.setFormResource(getResolver.getFormsServiceResolver().getResource(formName));
                dataOptions.setServiceName("ccm-print-test");
                dataOptions.setExtras(new HashMap<String, Object>());
                dataOptions.getExtras().put("data", targetStream);
                options.setDataOptions(dataOptions);
                logger.info("####Set the data options");
                com.adobe.fd.ccm.channels.print.api.model.PrintDocument printDocument = printChannel
                .render(options);
                logger.info("####Generated the document");
                com.adobe.aemfd.docmanager.Document uploadedDocument = new com.adobe.aemfd.docmanager.Document(
                    printDocument.getInputStream());
                logger.info("Generated the document");
                Binary binary = session.getValueFactory().createBinary(printDocument.getInputStream());
                Session jcrSession = workflowSession.adaptTo(Session.class);
                String dataFilePath = workItem.getWorkflowData().getPayload().toString();
                
                Node dataFileNode = jcrSession.getNode(dataFilePath);
                Node icPdf = dataFileNode.addNode(icFileName, "nt:file");
                Node contentNode = icPdf.addNode("jcr:content", "nt:resource");
                contentNode.setProperty("jcr:data", binary);
                jcrSession.save();
                logger.info("Copied the generated document");
                uploadedDocument.close();
                
                return null;
            }
```

Så här testar du detta på servern:

* [Konfigurera Day CQ Mail Service.](https://helpx.adobe.com/experience-manager/6-5/communities/using/email.html) Detta behövs för att skicka e-post med dokumentet som har genererats som en bifogad fil.
* [Distribuera paketet Utveckla med tjänster](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* Kontrollera att du har lagt till följande post i konfigurationen för användarmappningstjänsten för Apache Sling
* **DevelopingWithServiceUser.core:getformsresourceReser=fd-service**
* [Ladda ned och zippa upp resurser som hör till den här artikeln i ditt filsystem](assets/prefillservice.zip)
* [Importera följande paket med AEM pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
   1. beneficiaryconfirmationic.zip
   2. changeofbeneficiaryform.zip
   3. generatebeneficiaryworkflow.zip
* [Distribuera följande med AEM Felix Web Console](http://localhost:4502/system/console/bundles)

   * GenerateIC.GenerateIC.core-1.0-SNAPSHOT.jar. Paketet innehåller den kod som omnämns i den här artikeln.

* [Öppna ChangeOfBeneficiaryForm](http://localhost:4502/content/dam/formsanddocuments/changebeneficiary/jcr:content?wcmmode=disabled)
* Kontrollera att det adaptiva formuläret är konfigurerat att skicka till AEM arbetsflöde enligt nedan
  ![bild](assets/generateic.PNG)
* [Konfigurera arbetsflödesmodellen.](http://localhost:4502/editor.html/conf/global/settings/workflow/models/ChangesToBeneficiary.html)Kontrollera att processsteget och skicka e-postkomponenter är konfigurerade enligt din miljö
* [Förhandsgranska ChangeOfBeneficiaryForm.](http://localhost:4502/content/dam/formsanddocuments/changebeneficiary/jcr:content?wcmmode=disabled) Fyll i viss information och skicka
* Arbetsflödet ska anropas och dokument för konc-utskriftskanal skickas till mottagaren som anges i skicka-e-postkomponenten som en bifogad fil
