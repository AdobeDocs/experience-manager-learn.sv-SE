---
title: Spara formulärinlämning i Azure Storage
description: Lagra formulärdata i Azure Storage med REST API
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2023-10-23T00:00:00Z
kt: 14238
source-git-commit: 5e761ef180182b47c4fd2822b0ad98484db23aab
workflow-type: tm+mt
source-wordcount: '282'
ht-degree: 0%

---

# Hämta data från Azure-lagring

I den här artikeln visas hur du fyller i ett adaptivt formulär med data som lagras i Azure-lagringen.
Du förutsätts ha lagrat data i det adaptiva formuläret i Azure-lagringen och nu vill fylla i det anpassade formuläret i förväg med dessa data.

## Skapa GET-förfrågan

Nästa steg är att skriva koden för att hämta data från Azure Storage med hjälp av blobID. Följande kod skrevs för att hämta data. URL:en konstruerades med ASToken- och storageURI-värden från OSGi-konfigurationen och det blobID som skickades till funktionen getBlobData

```java
 @Override
public String getBlobData(String blobID) {
    String sasToken = azurePortalConfigurationService.getSASToken();
    String storageURI = azurePortalConfigurationService.getStorageURI();
    log.debug("The SAS Token is " + sasToken);
    log.debug("The Storage URL is " + storageURI);
    String httpGetURL = storageURI + blobID;
    httpGetURL = httpGetURL + sasToken;
    HttpGet httpGet = new HttpGet(httpGetURL);

    org.apache.http.impl.client.CloseableHttpClient httpClient = HttpClientBuilder.create().build();
    CloseableHttpResponse httpResponse = null;
    try {
        httpResponse = httpClient.execute(httpGet);
        HttpEntity httpEntity = httpResponse.getEntity();
        String blobData = EntityUtils.toString(httpEntity);
        log.debug("The blob data I got was " + blobData);
        return blobData;

    } catch (ClientProtocolException e) {

        log.error("Got Client Protocol Exception " + e.getMessage());
    } catch (IOException e) {

        log.error("Got IOEXception " + e.getMessage());
    }

    return null;
}
```

När ett anpassat formulär återges med en `guid` -parametern i URL hämtar och fyller den anpassade sidkomponenten som är kopplad till mallen i det adaptiva formuläret med data från Azure-lagringen.
Sidkomponenten som är associerad med mallen har följande JSP-kod.

```java
com.aemforms.saveandfetchfromazure.StoreAndFetchDataFromAzureStorage azureStorage = sling.getService(com.aemforms.saveandfetchfromazure.StoreAndFetchDataFromAzureStorage.class);


String guid = request.getParameter("guid");

if(guid!=null&&!guid.isEmpty())
{
    String dataXml = azureStorage.getBlobData(guid);
    slingRequest.setAttribute("data",dataXml);

}
```

## Testa lösningen

* [Distribuera det anpassade OSGi-paketet](./assets/SaveAndFetchFromAzure.core-1.0.0-SNAPSHOT.jar)

* [Importera den anpassade formulärmallen och sidkomponenten som är kopplad till mallen](./assets/store-and-fetch-from-azure.zip)

* [Importera det adaptiva exempelformuläret](./assets/bank-account-sample-form.zip)

* Ange lämpliga värden i Azure Portal Configuration med OSGi-konfigurationskonsolen
* [Förhandsgranska och skicka bankkontoformuläret](http://localhost:4502/content/dam/formsanddocuments/azureportalstorage/bankaccount/jcr:content?wcmmode=disabled)

* Verifiera att data lagras i den Azure-lagringsbehållare du väljer. Kopiera blob-ID:t.
* [Förhandsgranska bankkontoformuläret](http://localhost:4502/content/dam/formsanddocuments/azureportalstorage/bankaccount/jcr:content?wcmmode=disabled&amp;guid=dba8ac0b-8be6-41f2-9929-54f627a649f6) och ange blob-ID:t som en GUID-parameter i URL:en för formuläret som ska fyllas i med data från Azure-lagringen

