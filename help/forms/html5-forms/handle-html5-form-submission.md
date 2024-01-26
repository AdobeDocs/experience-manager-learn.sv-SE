---
title: Hantera inskickning av HTML5-formulär
description: Skapa HTML5-formulärshanterare
feature: Mobile Forms
doc-type: article
version: 6.4,6.5
jira: KT-5269
thumbnail: kt-5269.jpg
topic: Development
role: Developer
level: Experienced
exl-id: 93e1262b-0e93-4ba8-aafc-f9c517688ce9
last-substantial-update: 2020-07-07T00:00:00Z
duration: 75
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '251'
ht-degree: 0%

---

# Hantera inskickning av HTML5-formulär

HTML5-formulär kan skickas till en server som finns i AEM. De data som skickas kan nås i serverleten som en indataström. Om du vill skicka ditt HTML5-formulär måste du lägga till HTTP-sändningsknapp i formulärmallen med AEM Forms Designer

## Skapa en Skicka-hanterare

Du kan skapa en enkel servett som hanterar HTML5-formuläröverföringen. De data som skickas kan sedan extraheras med följande kod. Detta [servlet](assets/html5-submit-handler.zip) som ingår i den här självstudiekursen. Installera [servlet](assets/html5-submit-handler.zip) använda [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)

Koden från rad 9 kan användas för att anropa J2EE-processen. Kontrollera att du har konfigurerat [SDK-konfiguration för Adobe-klient](https://helpx.adobe.com/aem-forms/6/submit-form-data-livecycle-process.html) om du tänker använda koden för att anropa J2EE-processen.

```java
StringBuffer stringBuffer = new StringBuffer();
String line = null;
java.io.InputStreamReader isReader = new java.io.InputStreamReader(request.getInputStream(), "UTF-8");
java.io.BufferedReader reader = new java.io.BufferedReader(isReader);
while ((line = reader.readLine()) != null) {
    stringBuffer.append(line);
}
System.out.println("The submitted form data is " + stringBuffer.toString());
/*
        * java.util.Map params = new java.util.HashMap();
        * params.put("in",stringBuffer.toString());
        * com.adobe.livecycle.dsc.clientsdk.ServiceClientFactoryProvider scfp =
        * sling.getService(com.adobe.livecycle.dsc.clientsdk.
        * ServiceClientFactoryProvider.class);
        * com.adobe.idp.dsc.clientsdk.ServiceClientFactory serviceClientFactory =
        * scfp.getDefaultServiceClientFactory(); com.adobe.idp.dsc.InvocationRequest ir
        * = serviceClientFactory.createInvocationRequest("Test1/NewProcess1", "invoke",
        * params, true);
        * ir.setProperty(com.adobe.livecycle.dsc.clientsdk.InvocationProperties.
        * INVOKER_TYPE,com.adobe.livecycle.dsc.clientsdk.InvocationProperties.
        * INVOKER_TYPE_SYSTEM); com.adobe.idp.dsc.InvocationResponse response1 =
        * serviceClientFactory.getServiceClient().invoke(ir);
        * System.out.println("The response is "+response1.getInvocationId());
        */
```


## Konfigurera Skicka-URL:en för formuläret HTML 5

![submit-url](assets/submit-url.PNG)

* Tryck på xdp och klicka på _Egenskaper_->_Avancerat_
* kopiera http://localhost:4502/content/AemFormsSamples/handlehml5formsubmission.html och klistra in detta i textfältet Skicka URL
* Klicka _SparaOchStäng_ -knappen.

### Lägg till post i Uteslut banor

* Navigera till [configMgr](http://localhost:4502/system/console/configMgr).
* Sök efter _Adobe Granite CSRF-filter_
* Lägg till följande post i avsnittet Uteslutna banor
* _/content/AemFormsSamples/handlehml5formsubmit_
* Spara ändringarna

### Testa formuläret

* Tryck på xdp-mallen.
* Klicka på _Förhandsgranska_->Förhandsgranska som HTML
* Ange några data i formuläret och klicka på Skicka
* Du bör se skickade data som skrivits till serverns stdout.log-fil

### Ytterligare läsning

Detta [artikel](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/document-services/generate-pdf-from-mobile-form-submission-article.html) Vi rekommenderar också att man genererar PDF från HTML5-formulär.
