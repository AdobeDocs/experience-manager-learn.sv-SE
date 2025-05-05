---
title: Använda Assembler Service i AEM Forms
description: Använda Assembler Service i AEM Forms för att sammanställa flera PDF-filer
feature: Assembler
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
exl-id: 18da12ea-b1ea-48e4-979e-3cb59584dfbd
last-substantial-update: 2020-07-07T00:00:00Z
duration: 76
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '192'
ht-degree: 0%

---

# Använda Assembler Service i AEM Forms{#using-assembler-service-in-aem-forms}

I den här artikeln finns de resurser som du kan använda för att visa hur du kan dra och släppa flera PDF-filer i webbläsaren och spara den sammansatta PDF-filen i filsystemet. Här följer koden för den server som sätter ihop PDF-filerna som överförts med webbläsaren.

```java
protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
        log.debug("In Assemble Uploaded Files");
 
        Map<String, Object> mapOfDocuments = new HashMap<String, Object>();
        final boolean isMultipart = org.apache.commons.fileupload.servlet.ServletFileUpload.isMultipartContent(request);
        DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = null;
        try {
            docBuilder = docFactory.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        org.w3c.dom.Document ddx = docBuilder.newDocument();
        Element rootElement = ddx.createElementNS("http://ns.adobe.com/DDX/1.0/", "DDX");
 
        ddx.appendChild(rootElement);
        Element pdfResult = ddx.createElement("PDF");
        pdfResult.setAttribute("result", "GeneratedDocument.pdf");
        rootElement.appendChild(pdfResult);
        if (isMultipart) {
            final java.util.Map<String, org.apache.sling.api.request.RequestParameter[]> params = request
                    .getRequestParameterMap();
            for (final java.util.Map.Entry<String, org.apache.sling.api.request.RequestParameter[]> pairs : params
                    .entrySet()) {
                final String k = pairs.getKey();
 
                final org.apache.sling.api.request.RequestParameter[] pArr = pairs.getValue();
                final org.apache.sling.api.request.RequestParameter param = pArr[0];
 
                try {
                    if (!param.isFormField()) {
                        final InputStream stream = param.getInputStream();
                        log.debug("the file name is " + param.getFileName());
                        log.debug("Got input Stream inside my servlet####" + stream.available());
                        com.adobe.aemfd.docmanager.Document document = new Document(stream);
                        mapOfDocuments.put(param.getFileName(), document);
                        org.w3c.dom.Element pdfSourceElement = ddx.createElement("PDF");
                        pdfSourceElement.setAttribute("source", param.getFileName());
                        pdfSourceElement.setAttribute("bookmarkTitle", param.getFileName());
                        pdfResult.appendChild(pdfSourceElement);
                        log.debug("The map size is " + mapOfDocuments.size());
                    } else {
                        log.debug("The form field is" + param.getString());
 
                    }
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
 
            }
        }
 
        com.adobe.aemfd.docmanager.Document ddxDocument = documentServices.orgw3cDocumentToAEMFDDocument(ddx);
        Document assembledDocument = documentServices.assembleDocuments(mapOfDocuments, ddxDocument);
        String path = documentServices.saveDocumentInCrx("/content/ocrfiles", assembledDocument);
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("path", path);
            response.setContentType("application/json");
            response.setHeader("Cache-Control", "nocache");
            response.setCharacterEncoding("utf-8");
            PrintWriter out = null;
            out = response.getWriter();
            out.println(jsonObject.toString());
 
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
 
    }
 
}
```

För att få den här funktionen att fungera på din AEM-server

* Hämta [AssembleMultipleFiles.zip](assets/assemble-multiple-files.zip) till ditt lokala system.
* Överför och installera paketet med hjälp av [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Hämta[paket med anpassade dokumenttjänster](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
* Hämta [Developing with Service User Bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* Distribuera och starta paketen med webbkonsolen [felix](http://localhost:4502/system/console/bundles)
* Peka webbläsaren på [AssemblePdfs.html](http://localhost:4502/content/DocumentServices/AssemblePdfs.html)
* Dra och släpp några filer från PDF

>[!NOTE]
>
>Kontrollera att AEM Forms-installationen är klar. Alla paket måste vara i aktivt läge.
>
>Kontrollera att du har lagt till - Boot delegate RSA- och BouncyCastle-bibliotek som nämns i denna [Installera AEM Forms](https://helpx.adobe.com/se/aem-forms/6-3/installing-configuring-aem-forms-osgi.html)
>
>**Caveats for this Demo**
>
> * Koden hanterar inte XFA-baserade PDF-dokument
>
> * Se till att du bara drar och släpper PDF-filer
>
>
