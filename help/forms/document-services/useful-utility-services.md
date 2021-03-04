---
title: Användbara tjänster
description: Några användbara verktygstjänster för AEM Forms-utvecklare
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
topic: Utveckling
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '160'
ht-degree: 1%

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


Du måste distribuera [DevelopingWithServiceUserBundle](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/DevelopingWithServiceUser.jar) och starta paketet.


Om du ska spara dokument i CRX-databasen med dessa verktygstjänster följer du [Utveckla med tjänstanvändarens artikel](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/adaptive-forms/service-user-tutorial-develop.html?lang=en#adaptive-forms). Se till att du anger [nödvändiga behörigheter](http://localhost:4502/useradmin) för respektive CRX-mapp till fd-service-användaren.

