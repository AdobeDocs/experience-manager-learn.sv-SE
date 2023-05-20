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
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '148'
ht-degree: 0%

---

# Distribuera resurserna

Följande resurser/konfigurationer har distribuerats på en AEM Forms-publiceringsserver.

* [Adobe Sign Wrapper Bundle](assets/AcrobatSign.core-1.0.0-SNAPSHOT.jar)

* [Exempel på mall för interaktiv kommunikation](assets/waiver-interactive-communication.zip)
* [Distribuera DevelopingWithServiceUser-paketet](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/developingwithserviceuser.zip)
* Lägg till följande post i användarmappningstjänsten för Apache Sling med OSGi configMgr
   **DevelopingWithServiceUser.core:getformsresourceReser=fd-service**
* [Här kan du hämta exempelkod för React App](assets/src.zip)



Appen för samplingsrespons måste distribueras i din lokala miljö

Du måste ändra slutpunkts-URL:en så att den matchar din miljö. Öppna filen EmergencyContact.js och ändra URL:en i hämtningsmetoden

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

Om du vill aktivera anrop av POSTEN till AEM-slutpunkten från REACT-appen måste du ange rätt poster i fältet Tillåtna ursprung i konfigurationen av resursdelningsprincipen för korsursprung i Adobe Granite

![cors-setting](assets/cors-settings.png)
