---
title: Användbara tjänster
description: Några användbara verktygstjänster för AEM Forms-utvecklare
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
exl-id: add06b73-18bb-4963-b91f-d8e1eb144842
last-substantial-update: 2020-07-07T00:00:00Z
duration: 35
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '138'
ht-degree: 0%

---

# Användbara tjänster

Det här exempelpaketet innehåller användbara verktygstjänster som kan användas av en AEM Forms-utvecklare. Följande tjänster är tillgängliga.


```java
package aemformsutilityfunctions.core;
import java.util.Map;
import com.adobe.aemfd.docmanager.Document;
public interface AemFormsUtilities
{
public abstract com.adobe.aemfd.docmanager.Document createDDXFromMapOfDocuments(Map<String, com.adobe.aemfd.docmanager.Document> paramMap);
public abstract org.w3c.dom.Document w3cDocumentFromStrng(String xmlString);
public abstract com.adobe.aemfd.docmanager.Document orgw3cDocumentToAEMFDDocument(org.w3c.dom.Document xmlDocument);
public abstract String saveDocumentInCrx(String jcrPath,String fileExtension, Document documentToSave);

}
```

Exempelpaketet kan [hämtas här](assets/aemformsutilityfunctions.aemformsutilityfunctions.core-1.0-SNAPSHOT.jar)

## Exempelkod som använder verktygstjänsten/verktygen

Följande kod användes på JSP-sidan för att skapa org.w3c.dom.Document från en sträng och konvertera dokumentet och lagra det i CRX-databasen, vilket visas i följande kodutdrag.

```java
 aemformsutilityfunctions.core.AemFormsUtilities aemFormsUtilities = sling.getService(aemformsutilityfunctions.core.AemFormsUtilities.class);
com.adobe.aemfd.docmanager.Document xmlStringDoc = aemFormsUtilities.orgw3cDocumentToAEMFDDocument(aemFormsUtilities.w3cDocumentFromStrng("<data><fname>Girish</fname></data>"));
aemFormsUtilities.saveDocumentInCrx("/content/xmlfiles",".xml",xmlStringDoc);
```

## Förutsättningar


Du måste distribuera [DevelopingWithServiceUserBundle](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/DevelopingWithServiceUser.jar?lang=sv-SE) och starta paketet.


Om du ska spara dokument i CRX-databasen med den här verktygstjänsten följer du artikeln [Utveckla med tjänstanvändare](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/adaptive-forms/service-user-tutorial-develop.html?lang=sv-SE#adaptive-forms). Se till att du anger de [nödvändiga behörigheterna](http://localhost:4502/useradmin) i rätt CRX-mappar till fd-service-användaren.
