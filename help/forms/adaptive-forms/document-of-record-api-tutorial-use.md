---
title: Använda API för att generera arkivdokument med AEM Forms
description: Generera DOR (Document Of Record) programmatiskt
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
exl-id: 9a3b2128-a383-46ea-bcdc-6015105c70cc
last-substantial-update: 2023-01-26T00:00:00Z
duration: 67
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '239'
ht-degree: 0%

---

# Använda API för att generera arkivdokument i AEM Forms {#using-api-to-generate-document-of-record-with-aem-forms}

Generera DOR (Document Of Record) programmatiskt

I den här artikeln visas hur `com.adobe.aemds.guide.addon.dor.DoRService API` används för att generera **dokument med post** programmatiskt. [Dokument för post](https://experienceleague.adobe.com/docs/experience-manager-65/forms/adaptive-forms-advanced-authoring/generate-document-of-record-for-non-xfa-based-adaptive-forms.html) är en PDF-version av data som har samlats in i adaptiv form.

1. Här följer kodfragmentet. Den första raden hämtar DOR-tjänsten.
1. Ange DoROptions.
1. Anropa återgivningsmetoden för DoRService och skicka DoROptions-objektet till återgivningsmetoden

```java
String dataXml = request.getParameter("data");
System.out.println("Got " + dataXml);
Session session;
com.adobe.aemds.guide.addon.dor.DoRService dorService = sling.getService(com.adobe.aemds.guide.addon.dor.DoRService.class);
System.out.println("Got ... DOR Service");
com.mergeandfuse.getserviceuserresolver.GetResolver aemDemoListings = sling.getService(com.mergeandfuse.getserviceuserresolver.GetResolver.class);
System.out.println("Got aem DemoListings");
resourceResolver = aemDemoListings.getFormsServiceResolver();
session = resourceResolver.adaptTo(Session.class);
resource = resourceResolver.getResource("/content/forms/af/sandbox/1201-borrower-payments");
com.adobe.aemds.guide.addon.dor.DoROptions dorOptions = new com.adobe.aemds.guide.addon.dor.DoROptions();
dorOptions.setData(dataXml);
dorOptions.setFormResource(resource);
java.util.Locale locale = new java.util.Locale("en");
dorOptions.setLocale(locale);
com.adobe.aemds.guide.addon.dor.DoRResult dorResult = dorService.render(dorOptions);
byte[] fileBytes = dorResult.getContent();
com.adobe.aemfd.docmanager.Document dorDocument = new com.adobe.aemfd.docmanager.Document(fileBytes);
resource = resourceResolver.getResource("/content/usergenerated/content/aemformsenablement");
Node paydotgov = resource.adaptTo(Node.class);
java.util.Random r = new java.util.Random();
String nodeName = Long.toString(Math.abs(r.nextLong()), 36);
Node fileNode = paydotgov.addNode(nodeName + ".pdf", "nt:file");

System.out.println("Created file Node...." + fileNode.getPath());
Node contentNode = fileNode.addNode("jcr:content", "nt:resource");
Binary binary = session.getValueFactory().createBinary(dorDocument.getInputStream());
contentNode.setProperty("jcr:data", binary);
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("filePath");
writer.value(fileNode.getPath());
writer.endObject();
session.save();
```

Följ de här stegen för att prova detta på din lokala dator

1. [Hämta och installera artikelresurserna med pakethanteraren](assets/dor-with-api.zip)
1. Kontrollera att du har installerat och startat DevelopingWithServiceUser-paketet som ingår i [Create Service User-artikeln](service-user-tutorial-develop.md)
1. [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
1. Sök efter användarmappningstjänsten för Apache Sling-tjänsten
1. Kontrollera att du har följande post: _DevelopingWithServiceUser.core:getformsresourceServer=fd-service_ i avsnittet Tjänstmappningar
1. [Öppna formuläret](http://localhost:4502/content/dam/formsanddocuments/sandbox/1201-borrower-payments/jcr:content?wcmmode=disabled)
1. Fyll i formuläret och klicka på Visa PDF
1. Du bör se DOR på den nya fliken i webbläsaren


**Felsökningstips**

PDF visas inte på den nya webbläsarfliken:

1. Kontrollera att du inte blockerar popup-fönster i webbläsaren
1. Kontrollera att du startar AEM-servern som administratör (åtminstone i Windows)
1. Kontrollera att DevelopingWithServiceUser-paketet är i *aktivt läge*
1. [Kontrollera att systemanvändaren ](http://localhost:4502/useradmin) fd-service har behörighet att läsa, ändra och skapa på följande nod `/content/usergenerated/content/aemformsenablement`
