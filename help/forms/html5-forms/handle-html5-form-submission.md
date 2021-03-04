---
title: Hantera inskickning av HTML5-formulär
description: Skapa hanterare för att skicka HTML5-formulär
feature: mobilformulär
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5269
thumbnail: kt-5269.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '278'
ht-degree: 0%

---


# Hantera inskickning av HTML5-formulär

HTML5-formulär kan skickas till en server som finns i AEM. De data som skickas kan nås i serverleten som en indataström. Om du vill skicka ditt HTML5-formulär måste du lägga till HTTP-sändningsknapp i formulärmallen med AEM Forms Designer

## Skapa en Skicka-hanterare

Du kan skapa en enkel servett som hanterar inskickandet av HTML5-formulär. De data som skickas kan sedan extraheras med följande kod. Den här [servleten](assets/html5-submit-handler.zip) är tillgänglig som en del av den här självstudiekursen. Installera [servleten](assets/html5-submit-handler.zip) med [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)

Koden från rad 9 kan användas för att anropa J2EE-processen. Kontrollera att du har konfigurerat [SDK-konfiguration för LiveCycle-klient](https://helpx.adobe.com/aem-forms/6/submit-form-data-livecycle-process.html) om du tänker använda koden för att anropa J2EE-processen.

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


## Konfigurera HTML5-formulärets Skicka-URL

![submit-url](assets/submit-url.PNG)

* Tryck på xdp och klicka på _Egenskaper_->_Avancerat_
* kopiera http://localhost:4502/content/AemFormsSamples/handlehml5formsubmission.html och klistra in detta i textfältet Skicka URL
* Klicka på _Spara och stäng_.

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

Den här [artikeln](https://docs.adobe.com/content/help/en/experience-manager-learn/forms/document-services/generate-pdf-from-mobile-form-submission-article.html) om att generera PDF från HTML5-formulär rekommenderas också.




