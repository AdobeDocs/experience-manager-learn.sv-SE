---
title: Certifiera dokument i AEM Forms
seo-title: Certifiera dokument i AEM Forms
description: Certifiera PDF-dokument i AEM Forms med tjänsten Docsurance
seo-description: Certifiera PDF-dokument i AEM Forms med tjänsten Docsurance
uuid: ecb1f9b6-bbb3-43a3-a0e0-4c04411acc9f
feature: document-security
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
translation-type: tm+mt
source-git-commit: ca4a8f02ea9ec5db15dbe6f322731748da90be6b
workflow-type: tm+mt
source-wordcount: '416'
ht-degree: 0%

---


# Certifiera dokument i AEM Forms

Ett certifierat dokument ger mottagarna av PDF-dokument och -formulär ytterligare garantier för att de är autentiska och att de är intakta.

Om du vill certifiera ett dokument kan du använda Acrobat DC på skrivbordet eller AEM Forms Document Services som en del av en automatiserad process på en server.

I den här artikeln finns exempel på OSGI-paket för att certifiera PDF-dokument med AEM Forms Document Services. Den kod som används i exemplet finns [här](https://helpx.adobe.com/experience-manager/6-4/forms/using/aem-document-services-programmatically.html)

Om du vill certifiera dokument med AEM Forms måste du följa följande steg

## Lägger till certifikat i förtroendearkivet {#adding-certificate-to-trust-store}

Följ stegen nedan för att lägga till certifikatet i nyckelbehållaren i AEM

* [Initiera globalt förtroendearkiv](http://localhost:4502/libs/granite/security/content/truststore.html)
* [Sök efter fd-service](http://localhost:4502/security/users.html) -användare
* **Du måste rulla resultatsidan för att läsa in alla användare för att hitta Fd-service-användaren**
* Dubbelklicka på fd-service-användaren för att öppna fönstret med användarinställningar
* Klicka på Lägg till privat nyckel från nyckelfilen.Ange det alias och lösenord som är specifikt för certifikatet
   ![add-certificate](assets/adding-certificate-keystore.PNG)
* Spara ändringarna

## Skapar OSGI-tjänst

Du kan skriva ett eget OSGi-paket och använda AEM Forms Client SDK för att implementera en tjänst för att certifiera PDF-dokument. Följande länkar kan vara användbara för att skriva ett eget OSGi-paket

* [Skapa ditt första OSGi-paket](https://helpx.adobe.com/experience-manager/using/maven_arch13.html)
* [Använd API för dokumenttjänst](https://helpx.adobe.com/experience-manager/6-4/forms/using/aem-document-services-programmatically.html)

Du kan också använda exempelpaketet som ingår i den här självstudiekursen.
>[!NOTE]
Exempelpaketet använder alias &quot;ares&quot; för att certifiera dokumenten. Se därför till att ditt alias heter &quot;ares&quot; när du använder det här paketet

## Testa exemplet på din lokala dator

* Hämta och installera [paket med anpassade dokumenttjänster](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
* Hämta och installera [Developing with Service User Bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* [Kontrollera att du har lagt till följande post i användarmappningstjänsten för Apache Sling Service](http://localhost:4502/system/console/configMgr)

   **DevelopingWithServiceUser.core:getformsresouresolver=fd-service** enligt skärmbilden nedan
   ![User-Mapper](assets/user-mapper-service.PNG)
* [Importera anpassat exempelformulär](assets/certify-pdf-af.zip)
* [Importera och installera den anpassade överföringen](assets/custom-submit-certify.zip)
* [Öppna det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/certifypdf/jcr:content?wcmmode=disabled)
* Ladda upp PDF-dokument som behöver certifieras
   **valfritt** - Ange det signaturfält som du vill använda för att certifiera dokumentet
* Klicka på Skicka.
* Certifierad PDF bör returneras till dig.


