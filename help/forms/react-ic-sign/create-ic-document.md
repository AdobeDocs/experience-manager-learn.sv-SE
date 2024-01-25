---
title: Generera dokument för interaktiv kommunikation med API
description: Generera dokument för interaktiv kommunikation genom att sammanfoga data från svarsappen
feature: Adaptive Forms,Acrobat Sign
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
jira: KT-13099
last-substantial-update: 2023-04-13T00:00:00Z
exl-id: d6fb6c80-4bfe-4b9d-b267-7caee3944cc0
duration: 223
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '113'
ht-degree: 0%

---

# Generera interaktivt kommunikationsdokument

För att generera ett interaktivt kommunikationsdokument med API:t måste vi göra följande

* Skapa förifyllningstjänst
* Generera interaktivt kommunikationsdokument

Tjänstnamnet `ccm-print-test` används för att komma åt den här tjänsten. När den här förifyllda tjänsten har definierats kan du komma åt den här tjänsten antingen i serverns eller arbetsflödets processstegsimplementering för att generera dokumentet för tryckkanalen.

```java
package com.acrobatsign.core;

import java.io.InputStream;
import org.osgi.service.component.annotations.Component;

import com.adobe.forms.common.service.ContentType;
import com.adobe.forms.common.service.DataOptions;
import com.adobe.forms.common.service.DataProvider;
import com.adobe.forms.common.service.FormsException;
import com.adobe.forms.common.service.PrefillData;

@Component(immediate = true, service = {
  DataProvider.class
})
public class PrintChannelPrefill implements DataProvider {

  @Override
  public String getServiceDescription() {

    return "Prefill Service for IC Print Channel";
  }

  @Override
  public String getServiceName() {

    return "ccm-print-test";
  }

  @Override
  public PrefillData getPrefillData(DataOptions options) throws FormsException {

    PrefillData data = null;
    if (options != null && options.getExtras() != null && options.getExtras().get("data") != null) {
      InputStream is = (InputStream) options.getExtras().get("data");
      data = new PrefillData(is, options.getContentType() != null ? options.getContentType() : ContentType.JSON);
    }
    return data;
  }
}
```

## Generera dokumentet

```java
package com.acrobatsign.core.impl;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.concurrent.Callable;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.acrobatsign.core.AcrobatSignHelperMethods;
import com.acrobatsign.core.PrintChannelDocumentHelperMethods;
import com.adobe.fd.ccm.channels.print.api.model.PrintChannel;
import com.adobe.fd.ccm.channels.print.api.model.PrintChannelRenderOptions;
import com.adobe.fd.ccm.channels.print.api.service.PrintChannelService;
import com.adobe.forms.common.service.ContentType;
import com.adobe.forms.common.service.DataOptions;
import com.adobe.granite.resourceresolverhelper.ResourceResolverHelper;
import com.mergeandfuse.getserviceuserresolver.GetResolver;
@Component(service = PrintChannelDocumentHelperMethods.class, immediate = true)
public class PrintChannelDocumentHelperMethodsImpl implements PrintChannelDocumentHelperMethods {
  @Reference
  GetResolver getResolver;
  @Reference
  ResourceResolverHelper resHelper;
  @Reference
  PrintChannelService printChannelService;
  @Reference
  AcrobatSignHelperMethods acrobatSignHelperMethods;

  @Override
  public String getPrintChannelDocument(String templateName, InputStream dataStream) throws Exception {
    return resHelper.callWith(getResolver.getFormsServiceResolver(), new Callable < String > () {

      @Override
      public String call() throws Exception {
        PrintChannel printChannel = null;
        printChannel = printChannelService.getPrintChannel(templateName);
        PrintChannelRenderOptions options = new com.adobe.fd.ccm.channels.print.api.model.PrintChannelRenderOptions();
        options.setMergeDataOnServer(true);
        options.setRenderInteractive(false);
        DataOptions dataOptions = new com.adobe.forms.common.service.DataOptions();
        //dataOptions.setServiceName(printChannel.getPrefillService());
        // dataOptions.setExtras(map);
        dataOptions.setContentType(ContentType.JSON);

        dataOptions.setFormResource(getResolver.getFormsServiceResolver().getResource(templateName));
        dataOptions.setServiceName("ccm-print-test");
        dataOptions.setExtras(new HashMap < String, Object > ());
        dataOptions.getExtras().put("data", dataStream);
        options.setDataOptions(dataOptions);

        com.adobe.fd.ccm.channels.print.api.model.PrintDocument printDocument = printChannel.render(options);
        com.adobe.aemfd.docmanager.Document icDocument = new com.adobe.aemfd.docmanager.Document(printDocument.getInputStream());

        String widgetId = acrobatSignHelperMethods.getWidgetID(acrobatSignHelperMethods.getTransientDocumentID(icDocument));

        return acrobatSignHelperMethods.getWidgetURL(widgetId);

      }

    });

  }

}
```java

A custom AEM bundle was developed to create and return the web form to the end user

* [Create Transient Document](https://secure.na1.echosign.com/public/docs/restapi/v6#!/transientDocuments/createTransientDocument). The document uploaded through this call is referred to as transient since it is available only for 7 days after the upload. The returned transient document ID can be used in the API calls where the uploaded file needs to be referred. The transient document request is a multipart request consisting of three parts - filename, mime type and the file stream. You can only upload one file at a time in this request.
* [Create web form](https://secure.na1.echosign.com/public/docs/restapi/v6#!/widgets/createWidget).This is a primary endpoint which is used to create a new web form. The web form was created in an ACTIVE state to immediately host the web form.
* [Retrieve the web form](https://secure.na1.echosign.com/public/docs/restapi/v6#!/widgets/getWidgets).Retrieve's web form the user. This web form is then presented to the calling application for signing the document.

## Create Acrobat Sign OSGi configuration

Acrobat Sign REST API require the integration key and email associated with the integration key. These two values are provided as an OSGi configuration properties as shown below


```java
package com.acrobatsign.core.configuration;

import org.osgi.service.metatype.annotations.AttributeDefinition;
import org.osgi.service.metatype.annotations.ObjectClassDefinition;



@ObjectClassDefinition(name="Acrobat Sign Configuration", description = "Acrobat SignConfiguration")
public @interface AcrobatSignConfiguration
{
    @AttributeDefinition(name="Acrobat Sign Integration Key", description = "Integration key you created in Acrobat Sign ")
        String getIntegrationKey();
    
    @AttributeDefinition(name="X-API-USER", description = "X-API-USER")
    String getApiUser();


}
```

```java
package com.acrobatsign.core.configuration;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.metatype.annotations.Designate;

@Component(immediate = true, service = AcrobatSignConfigurationService.class)
@Designate(ocd = AcrobatSignConfiguration.class)
public class AcrobatSignConfigurationService {

  private String IntegrationKey;
  private String apiUserEmail;
  public String getIntegrationKey() {
    return IntegrationKey;
  }
  public String getApiUserEmail() {
    return apiUserEmail;
  }

  @Activate
  protected final void activate(AcrobatSignConfiguration config) {
    IntegrationKey = config.getIntegrationKey();

    apiUserEmail = config.getApiUser();
  }

}
```

## Hämta tillfälligt dokument-ID

Följande kod skrevs för att skapa ett tillfälligt dokument

```java
public String getTransientDocumentID(Document documentForSigning) throws IOException {
  String integrationKey = acrobatSignConfig.getIntegrationKey();
  String apiUser = acrobatSignConfig.getApiUserEmail();
  String url = "https://api.na1.adobesign.com/api/rest/v6/transientDocuments";
  MultipartEntityBuilder builder = MultipartEntityBuilder.create();
  org.apache.http.impl.client.CloseableHttpClient httpClient = HttpClientBuilder.create().build();
  HttpPost httpPost = new HttpPost(url);
  httpPost.addHeader("x-api-user", "email:" + apiUser);
  httpPost.addHeader("Authorization", "Bearer " + integrationKey);
  builder.addBinaryBody("File", documentForSigning.getInputStream(), ContentType.DEFAULT_BINARY, "NDA.PDF");
  builder.addTextBody("File-Name", "NDA.pdf");
  HttpEntity entity = builder.build();
  log.debug("Build the entity");
  httpPost.setEntity(entity);
  CloseableHttpResponse response = httpClient.execute(httpPost);
  log.debug("Sent the request!!!!");
  log.debug("REsponse code " + response.getStatusLine().getStatusCode());
  HttpEntity httpEntity = response.getEntity();
  String transientDocumentId = JsonParser.parseString(EntityUtils.toString(httpEntity)).getAsJsonObject().get("transientDocumentId").getAsString();
  log.debug("Transient ID  " + transientDocumentId);
  return transientDocumentId;

}
```

## Hämta widget-ID

```java
public String getWidgetID(String transientDocumentID) {
  String integrationKey = acrobatSignConfig.getIntegrationKey();
  String apiUser = acrobatSignConfig.getApiUserEmail();
  String url = "https://api.na1.adobesign.com:443/api/rest/v6/widgets";
  org.apache.http.impl.client.CloseableHttpClient httpClient = HttpClientBuilder.create().build();
  HttpPost httpPost = new HttpPost(url);
  httpPost.addHeader("x-api-user", "email:" + apiUser);
  httpPost.addHeader("Authorization", "Bearer " + integrationKey);

  String jsonREquest = "{\r\n" +
    "  \"fileInfos\": [\r\n" +
    "    {\r\n" +
    "      \"transientDocumentId\": \"a\"\r\n" +
    "    }\r\n" +
    "  ],\r\n" +
    "  \"name\": \"Release and Waiver Agreement\",\r\n" +
    "  \"state\": \"ACTIVE\",\r\n" +
    "  \"widgetParticipantSetInfo\": {\r\n" +
    "    \"memberInfos\": [\r\n" +
    "      {\r\n" +
    "        \"email\": \"\"\r\n" +
    "      }\r\n" +
    "    ],\r\n" +
    "    \"role\": \"SIGNER\"\r\n" +
    "  }\r\n" +
    "}";
  JsonObject jsonReq = JsonParser.parseString(jsonREquest).getAsJsonObject();
  jsonReq.getAsJsonArray("fileInfos").get(0).getAsJsonObject().addProperty("transientDocumentId", transientDocumentID);
  log.debug("The updated json object is " + jsonReq);
  try {
    StringEntity stringEntity = new StringEntity(jsonReq.toString());
    httpPost.setEntity(stringEntity);
    httpPost.addHeader("Content-Type", "application/json");
    CloseableHttpResponse response = httpClient.execute(httpPost);
    log.debug("The response is  " + response.getStatusLine().getStatusCode());
    String widgetID = JsonParser.parseString(EntityUtils.toString(response.getEntity())).getAsJsonObject().get("id").getAsString();
    log.debug("The widget id is " + widgetID);
    return widgetID;
  } catch (Exception e) {
    log.debug("Error in getting Widget ID:" + e.getMessage());

  }
  return null;
}
```

## Hämta widget-URL

```java
public String getWidgetURL(String widgetId) throws ClientProtocolException, IOException {
        
        log.debug("$$$$ in get Widget URL for "+widgetId+ "widget id");
        String url = "https://api.na1.adobesign.com:443/api/rest/v6/widgets";
        org.apache.http.impl.client.CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        HttpGet httpGet = new HttpGet(url);
        httpGet.addHeader("x-api-user", "email:"+acrobatSignConfig.getApiUserEmail());
        httpGet.addHeader("Authorization", "Bearer "+acrobatSignConfig.getIntegrationKey());
        CloseableHttpResponse response = httpClient.execute(httpGet);
        JsonObject jsonResponse = JsonParser.parseString(EntityUtils.toString(response.getEntity())).getAsJsonObject();
         log.debug("The json response from get widgets is "+jsonResponse.toString());
         JsonArray userWidgetList = jsonResponse.get("userWidgetList").getAsJsonArray();
         log.debug("The array size is "+userWidgetList.size());
          for(int i=0;i<userWidgetList.size();i++)
         {
        
             log.debug("Getting widget object "+i);
             JsonObject temp = userWidgetList.get(i).getAsJsonObject();
             log.debug("The widget object "+i+"is "+temp.toString());
             if(temp.get("id").getAsString().equalsIgnoreCase(widgetId))
             {
                 log.debug("Bingo found the matching widget id  "+i);
                 String widgetURL = temp.get("url").getAsString();
                 return widgetURL;
                 
             }
            
         }
        
        return null;
        
    }
```

## Nästa steg

Skriv en [OSGi-servicewrapper som visar Acrobat Sign API](./wrapper-sign-api.md)
