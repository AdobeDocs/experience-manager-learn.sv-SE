---
title: Anropa interna API:er med privata certifikat
description: Lär dig hur du anropar interna API:er med privata eller självsignerade certifikat.
feature: Security
version: Experience Manager 6.5, Experience Manager as a Cloud Service
topic: Security, Development
role: Admin, Developer
level: Experienced
jira: KT-11548
thumbnail: KT-11548.png
doc-type: Article
last-substantial-update: 2023-08-25T00:00:00Z
exl-id: c88aa724-9680-450a-9fe8-96e14c0c6643
duration: 332
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '467'
ht-degree: 0%

---

# Anropa interna API:er med privata certifikat

Lär dig hur du gör HTTPS-anrop från AEM till webb-API:er med privata eller självsignerade certifikat.

>[!VIDEO](https://video.tv.adobe.com/v/3424853?quality=12&learn=on)

Som standard misslyckas anslutningen när du försöker skapa en HTTPS-anslutning till ett webb-API som använder ett självsignerat certifikat. Fel:

```
PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
```

Det här problemet inträffar vanligtvis när **API:ts SSL-certifikat inte har utfärdats av en erkänd certifikatutfärdare (CA)** och Java™-programmet inte kan validera SSL-/TLS-certifikatet.

Låt oss lära oss hur du kan anropa API:er som har privata eller självsignerade certifikat med [Apache HttpClient](https://hc.apache.org/httpcomponents-client-4.5.x/index.html) och **AEM global TrustStore**.


## Prototypisk API-anropskod med HttpClient

Följande kod skapar en HTTPS-anslutning till ett webb-API:

```java
...
String API_ENDPOINT = "https://example.com";

// Create HttpClientBuilder
HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();

// Create HttpClient
CloseableHttpClient httpClient = httpClientBuilder.build();

// Invoke API
CloseableHttpResponse closeableHttpResponse = httpClient.execute(new HttpGet(API_ENDPOINT));

// Code that reads response code and body from the 'closeableHttpResponse' object
...
```

Koden använder [Apache HttpComponent](https://hc.apache.org/)s [HttpClient](https://hc.apache.org/httpcomponents-client-4.5.x/index.html) -biblioteksklasser och deras metoder.


## HttpClient och läsa in AEM TrustStore-material

Om du vill anropa en API-slutpunkt som har _privat eller självsignerat certifikat_ måste [ för ](https://hc.apache.org/httpcomponents-client-4.5.x/index.html)HttpClient`SSLContextBuilder` läsas in med AEM TrustStore och användas för att underlätta anslutningen.

Följ stegen nedan:

1. Logga in på **AEM Author** som **administratör**.
1. Navigera till **AEM Author > Tools > Security > Trust Store** och öppna **Global Trust Store**. Om du försöker komma åt den första gången anger du ett lösenord för Global Trust Store.

   ![Global Trust Store](assets/internal-api-call/global-trust-store.png)

1. Om du vill importera ett privat certifikat klickar du på knappen **Välj certifikatfil** och väljer önskad certifikatfil med tillägget `.cer`. Importera den genom att klicka på knappen **Skicka**.

1. Uppdatera Java™-kod enligt nedan. Observera att om du vill använda `@Reference` för att hämta AEM `KeyStoreService` måste anropskoden vara en OSGi-komponent/tjänst, eller en Sling-modell (och `@OsgiService` används där).

   ```java
   ...
   
   // Get AEM's KeyStoreService reference
   @Reference
   private com.adobe.granite.keystore.KeyStoreService keyStoreService;
   
   ...
   
   // Get AEM TrustStore using KeyStoreService
   KeyStore aemTrustStore = getAEMTrustStore(keyStoreService, resourceResolver);
   
   if (aemTrustStore != null) {
   
       // Create SSL Context
       SSLContextBuilder sslbuilder = new SSLContextBuilder();
   
       // Load AEM TrustStore material into above SSL Context
       sslbuilder.loadTrustMaterial(aemTrustStore, null);
   
       // Create SSL Connection Socket using above SSL Context
       SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
               sslbuilder.build(), NoopHostnameVerifier.INSTANCE);
   
       // Create HttpClientBuilder
       HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
       httpClientBuilder.setSSLSocketFactory(sslsf);
   
       // Create HttpClient
       CloseableHttpClient httpClient = httpClientBuilder.build();
   
       // Invoke API
       closeableHttpResponse = httpClient.execute(new HttpGet(API_ENDPOINT));
   
       // Code that reads response code and body from the 'closeableHttpResponse' object
       ...
   } 
   
   /**
    * 
    * Returns the global AEM TrustStore
    * 
    * @param keyStoreService OOTB OSGi service that makes AEM based KeyStore
    *                         operations easy.
    * @param resourceResolver
    * @return
    */
   private KeyStore getAEMTrustStore(KeyStoreService keyStoreService, ResourceResolver resourceResolver) {
   
       // get AEM TrustStore from the KeyStoreService and ResourceResolver
       KeyStore aemTrustStore = keyStoreService.getTrustStore(resourceResolver);
   
       return aemTrustStore;
   }
   
   ...
   ```

   * Mata in OTB `com.adobe.granite.keystore.KeyStoreService` OSGi-tjänsten i OSGi-komponenten.
   * Hämta den globala AEM TrustStore med `KeyStoreService` och `ResourceResolver`, det gör metoden `getAEMTrustStore(...)`.
   * Skapa ett objekt av `SSLContextBuilder`, se Java™ [API-information](https://javadoc.io/static/org.apache.httpcomponents/httpcore/4.4.8/index.html?org/apache/http/ssl/SSLContextBuilder.html).
   * Läs in den globala AEM TrustStore till `SSLContextBuilder` med metoden `loadTrustMaterial(KeyStore truststore,TrustStrategy trustStrategy)`.
   * Skicka `null` för metoden `TrustStrategy` i ovanstående säkerställer att endast AEM tillförlitliga certifikat lyckas under API-körningen.


>[!CAUTION]
>
>API-anrop med giltiga CA-utfärdade certifikat misslyckas när de körs med den angivna metoden. Endast API-anrop med AEM tillförlitliga certifikat kan lyckas när den här metoden används.
>
>Använd [standardmetoden](#prototypical-api-invocation-code-using-httpclient) för att köra API-anrop av giltiga CA-utfärdade certifikat, vilket innebär att endast API:er som är kopplade till privata certifikat ska köras med den tidigare nämnda metoden.

## Undvik JVM-nyckelbehållarändringar

Ett vanligt tillvägagångssätt för att effektivt anropa interna API:er med privata certifikat är att ändra JVM-nyckelbehållaren. Detta uppnås genom att importera privata certifikat med kommandot Java™ [keytool](https://docs.oracle.com/en/java/javase/11/tools/keytool.html#GUID-5990A2E4-78E3-47B7-AE75-6D1826259549) .

Den här metoden är dock inte anpassad efter bästa säkerhetspraxis och AEM erbjuder ett överlägset alternativ genom att använda **Global Trust Store** och [KeyStoreService](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/com/adobe/granite/keystore/KeyStoreService.html).


## Lösningspaket

Exempelprojektet Node.js som har nedgraderats i videon kan hämtas från [här](assets/internal-api-call/REST-APIs.zip).

AEM-serverns kod är tillgänglig i WKND Sites Projects `tutorial/web-api-invocation`-gren, [se](https://github.com/adobe/aem-guides-wknd/tree/tutorial/web-api-invocation/core/src/main/java/com/adobe/aem/guides/wknd/core/servlets).
