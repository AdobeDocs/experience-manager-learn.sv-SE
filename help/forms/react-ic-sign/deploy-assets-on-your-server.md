---
title: Distribuera exempelresurserna på servern
description: Hämta användningsexemplet som fungerar på den lokala servern
feature: Adaptive Forms,Acrobat Sign
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
kt: 13099
last-substantial-update: 2023-04-13T00:00:00Z
exl-id: 44f4261b-d6fe-42ad-a3aa-2a36ca897b5e
source-git-commit: 137f7166a6a10ecd95a85114b27a1a3bd608b965
workflow-type: tm+mt
source-wordcount: '168'
ht-degree: 0%

---

# Distribuera resurserna

Följande resurser/konfigurationer har distribuerats på en AEM Forms-publiceringsserver.

* [Adobe Sign Wrapper Bundle](assets/AcrobatSign.core-1.0.0-SNAPSHOT.jar)

* [Exempel på mall för interaktiv kommunikation](assets/waiver-interactive-communication.zip)
* [Distribuera DevelopingWithServiceUser-paketet](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/developingwithserviceuser.zip)
* Lägg till följande post i användarmappningstjänsten för Apache Sling med OSGi configMgr
  **DevelopingWithServiceUser.core:getformsresourceReser=fd-service**

## Distribuera exempelappen

* [Hämta exempelappen](assets/mult-step-form1.zip)
* Zippa upp innehållet i den reaktionsapp i en ny mapp
* Navigera till mappen och kör följande kommandon

```java
npm install
npm start
```

Öppna filen EmergencyContact.js och ändra URL:en i hämtningsmetoden så att den matchar din miljö.


```javascript
 const getWebForm=async()=>
     {
        setSpinner(true)
        console.log("inside widgetURL function emergency contact");
        // NOTE: replace the `aemforms.azure.com:4503` with your AEM FORM server
        let res = await fetch("http://aemforms.azure.com:4503/bin/getwidgeturl",
          {
            method: "POST",
            body: JSON.stringify({"icTemplate":"/content/forms/af/waiver/waiver/channels/print","waiver":formData})
                     
         })
 
```

Om du vill att POSTEN ska kunna anropa AEM-slutpunkten från REACT-appen måste du ange rätt poster i fältet Tillåtna ursprung i konfigurationen av resursdelningsprincipen för korsursprung för Adobe Granite.

![cors-setting](assets/cors-settings.png)

Se [förstå CORS med AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/security/understand-cross-origin-resource-sharing.html) för mer information om CORS-konfigurationsalternativ.
