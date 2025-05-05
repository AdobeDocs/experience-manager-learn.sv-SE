---
title: Hantera inskickning av HTML5-formulär
description: Skapa hanterare för inskickning av HTML5-formulär.
feature: Mobile Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-5269
thumbnail: kt-5269.jpg
topic: Development
role: Developer
level: Experienced
exl-id: 93e1262b-0e93-4ba8-aafc-f9c517688ce9
last-substantial-update: 2020-07-07T00:00:00Z
duration: 66
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '227'
ht-degree: 0%

---


# Hantera inlämning av HTML5-formulär

HTML5-formulär kan skickas till en server som ligger i AEM. De data som skickas kan nås i serverleten som en indataström. Om du vill skicka ditt HTML5-formulär lägger du till en HTTP-sändningsknapp i formulärmallen med AEM Forms Designer.

## Skapa en Skicka-hanterare

En enkel servett kan hantera inskickandet av HTML5-formulär. Extrahera skickade data med följande kodfragment. Hämta [servleten](assets/html5-submit-handler.zip) som finns i den här självstudiekursen. Installera [servleten](assets/html5-submit-handler.zip) med hjälp av [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp).

```java
StringBuffer stringBuffer = new StringBuffer();
String line = null;
java.io.InputStreamReader isReader = new java.io.InputStreamReader(request.getInputStream(), "UTF-8");
java.io.BufferedReader reader = new java.io.BufferedReader(isReader);
while ((line = reader.readLine()) != null) {
    stringBuffer.append(line);
}
System.out.println("The submitted form data is " + stringBuffer.toString());
```

Kontrollera att du har konfigurerat [Adobe LiveCycle Client SDK Configuration](https://helpx.adobe.com/se/aem-forms/6/submit-form-data-livecycle-process.html) om du tänker använda koden för att anropa en J2EE-process.

## Konfigurera Skicka-URL:en för HTML5-formuläret

![Skicka URL](assets/submit-url.PNG)

- Öppna xdp-filen och gå till _Egenskaper_->_Avancerat_.
- Kopiera http://localhost:4502/content/AemFormsSamples/handlehml5formsubmission.html och klistra in den i textfältet Skicka URL.
- Klicka på knappen _SaveAndClose_.

### Lägg till post i Uteslut banor

- Gå till [configMgr](http://localhost:4502/system/console/configMgr).
- Sök efter _Adobe Granite CSRF-filter_.
- Lägg till följande post i avsnittet Undantagna sökvägar: _/content/AemFormsSamples/handlehml5formsubmit_.
- Spara ändringarna.

### Testa formuläret

- Öppna xdp-mallen.
- Klicka på _Förhandsgranska_->Förhandsgranska som HTML.
- Ange data i formuläret och klicka på Skicka.
- Kontrollera serverns stdout.log-fil för att se om det finns skickade data.

### Ytterligare läsning

Mer information om hur du genererar PDF-filer från inskickade HTML5-formulär finns i den här [artikeln](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/document-services/generate-pdf-from-mobile-form-submission-article.html?lang=sv-SE).

