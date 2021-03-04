---
title: Använda API för att generera arkivdokument med AEM Forms
seo-title: Använda API för att generera arkivdokument med AEM Forms
description: Generera DOR (Document Of Record) programmatiskt
seo-description: Använda API för att generera arkivdokument med AEM Forms
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
uuid: 94ac3b13-01b4-4198-af81-e5609c80324c
discoiquuid: ba91d9df-dc61-47d8-8e0a-e3f66cae6a87
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '281'
ht-degree: 0%

---


# Använda API för att generera ett dokument för post i AEM Forms {#using-api-to-generate-document-of-record-with-aem-forms}

Generera DOR (Document Of Record) programmatiskt

I den här artikeln visas hur `com.adobe.aemds.guide.addon.dor.DoRService API` används för att generera **postdokument** programmatiskt. [Document of ](https://docs.adobe.com/content/help/en/experience-manager-65/forms/adaptive-forms-advanced-authoring/generate-document-of-record-for-non-xfa-based-adaptive-forms.html) Recordis är en PDF-version av de data som samlats in i adaptiv form.

1. Här följer kodfragmentet. Den första raden hämtar DOR-tjänsten.
1. Ange DoROptions.
1. Anropa återgivningsmetoden för DoRService och skicka DoROptions-objektet till återgivningsmetoden

```java
com.adobe.aemds.guide.addon.dor.DoRService dorService = sling.getService(com.adobe.aemds.guide.addon.dor.DoRService.class);
com.adobe.aemds.guide.addon.dor.DoROptions dorOptions =  new com.adobe.aemds.guide.addon.dor.DoROptions();
 dorOptions.setData(dataXml);
 dorOptions.setFormResource(resource);
 java.util.Locale locale = new java.util.Locale("en");
 dorOptions.setLocale(locale);
 com.adobe.aemds.guide.addon.dor.DoRResult dorResult = dorService.render(dorOptions);
 byte[] fileBytes = dorResult.getContent();
 com.adobe.aemfd.docmanager.Document dorDocument = new com.adobe.aemfd.docmanager.Document(fileBytes);
```

Följ de här stegen för att prova detta på din lokala dator

1. [Hämta och installera artikelresurserna med pakethanteraren](assets/dor-with-api.zip)
1. Kontrollera att du har installerat och startat DevelopingWithServiceUser-paketet som ingår i [Create Service User-artikeln](service-user-tutorial-develop.md)
1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter användarmappningstjänsten för Apache Sling-tjänsten
1. Se till att du anger följande _DevelopingWithServiceUser.core:getformsresourceServer=fd-service_ i avsnittet Tjänstmappningar
1. [Öppna formuläret](http://localhost:4502/content/dam/formsanddocuments/sandbox/1201-borrower-payments/jcr:content?wcmmode=disabled)
1. Fyll i formuläret och klicka på Visa PDF
1. Du bör se DOR på den nya fliken i webbläsaren


**Felsökningstips**

PDF visas inte på den nya fliken i webbläsaren:

1. Kontrollera att du inte blockerar popup-fönster i webbläsaren
1. Låt dig följa stegen som beskrivs i den här [artikeln](service-user-tutorial-develop.md)
1. Kontrollera att DevelopingWithServiceUser-paketet är i *aktivt läge*
1. Kontrollera att systemanvändarens data har behörigheterna Läs, Ändra och Skapa på följande nod `/content/usergenerated/content/aemformsenablement`

