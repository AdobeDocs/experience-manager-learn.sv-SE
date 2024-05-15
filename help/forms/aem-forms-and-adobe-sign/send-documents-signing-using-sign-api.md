---
title: Använda Adobe Sign API i AEM Forms
description: Skicka dokument för signering med Adobe Sign hjälpmetoder
feature: Adaptive Forms
jira: KT-15474
topic: Development
role: Developer
level: Beginner
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: 3400b728-58ca-44c3-a882-e3170755f845
duration: 74
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '298'
ht-degree: 0%

---

# Använda hjälpmetoder i Adobe Sign

I vissa fall kan du behöva skicka ett dokument för signering utan att använda ett AEM arbetsflöde. I sådana fall är det mycket bekvämt att använda de förpackningsmetoder som finns i det exempelpaket som finns i den här artikeln.

## Distribuera OSGi-exempelpaketet

[Distribuera OSGi-paketet](assets/AdobeSignHelperMethods.core-1.0.0-SNAPSHOT.jar) via AEM OSGi Web Console. Ange API-integreringsnyckeln och API-användaren med OSGi-konfigurationen som visas nedan via AEM OSGi Web Console Configuration Manager.

 Observera att `AdobeSignHelperMethods` OSGi-paketet känns inte igen som en Adobe Experience Manager-produktkod (AEM) och stöds därför inte av Adobe Support.
![sign-configuration](assets/sign-configuration.png)


## API-dokumentation

Följande är tillgängliga via `AcrobatSignHelperMethods` OSGi-tjänsten tillhandahålls i OSGi-paketet.

### getTransientDocumentID

`String getTransientDocumentID(Document documentForSigning) throws IOException`


Dokumentet som används för att skapa ett avtal eller ett webbformulär. Dokumentet överförs först till Acrobat Sign av avsändaren. Detta kallas för _övergående_ eftersom det endast är tillgängligt för användning i 7 dagar efter överföringen. Den här metoden accepterar `com.adobe.aemfd.docmanager.Document` och returnerar tillfälligt dokument-ID.

### getAgreementID

`String getAgreementId(String transientDocumentID, String email) throws ClientProtocolException, IOException`

Skicka dokumentet för signering med det tillfälliga dokument-ID:t för signering till användaren som identifieras av e-postparametern.

### getWidgetID

`String getWidgetID(String transientDocumentID)`

En widget är som en återanvändbar mall som kan presenteras för användare flera gånger och signeras flera gånger. Använd den här metoden för att hämta widget-ID med ID:t för det tillfälliga dokumentet.

### getWidgetURL

`String getWidgetURL(String widgetId) throws ClientProtocolException, IOException`

Hämta en widget-URL för ett specifikt widget-ID. Denna widget-URL kan sedan visas för användarna för signering av dokumentet.

## Använda API

The `AcrobatSignHelperMethods` är en OSGi-tjänst, så den måste kommenteras med @Reference-anteckningen i din java-kod.

```java
...
// Import the AcrobatSignHelperMethods from the provided bundle
import com.acrobatsign.core.AcrobatSignHelperMethods;
...

@Component(service = { Example.class })
public class ExampleImpl implements Example {

 // Gain a reference to the provided AcrobatSignHelperMethods OSGi service
 @Reference
 com.acrobatsign.core.AcrobatSignHelperMethods acrobatSignHelperMethods;

 function void example() { 
    ...
    // Use the AcrobatSignHelperMethods API methods in your code
    String transientDocumentId = acrobatSignHelperMethods.getTransientDocumentID(documentForSigning);

    String agreementId = acrobatSignHelperMethods.getAgreementId(transientDocumentID, "johndoe@example.com");
    ...
 }
}
```
