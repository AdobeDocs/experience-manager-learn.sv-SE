---
title: Användbara tjänster
description: Några användbara verktygstjänster för AEM Forms-utvecklare
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: add06b73-18bb-4963-b91f-d8e1eb144842
last-substantial-update: 2020-07-07T00:00:00Z
duration: 39
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
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

Exempelpaketet kan [hämtad härifrån](assets/aemformsutilityfunctions.aemformsutilityfunctions.core-1.0-SNAPSHOT.jar)

## Exempelkod som använder verktygstjänsten/verktygen

Följande kod användes på JSP-sidan för att skapa org.w3c.dom.Document från en sträng och konvertera dokumentet och lagra det i CRX-databasen, vilket visas i följande kodutdrag.

```java
 aemformsutilityfunctions.core.AemFormsUtilities aemFormsUtilities = sling.getService(aemformsutilityfunctions.core.AemFormsUtilities.class);
com.adobe.aemfd.docmanager.Document xmlStringDoc = aemFormsUtilities.orgw3cDocumentToAEMFDDocument(aemFormsUtilities.w3cDocumentFromStrng("<data><fname>Girish</fname></data>"));
aemFormsUtilities.saveDocumentInCrx("/content/xmlfiles",".xml",xmlStringDoc);
```

## Förutsättningar


Du måste distribuera [DevelopingWithServiceUserBundle](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/DevelopingWithServiceUser.jar) och starta paketet.


Om du tänker spara dokument i CRX-databasen med hjälp av denna verktygstjänst följer du [utveckla med tjänstanvändarens artikel](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/adaptive-forms/service-user-tutorial-develop.html?lang=en#adaptive-forms). Se till att du anger [nödvändiga behörigheter](http://localhost:4502/useradmin) till rätt CRX-mappar för Fd-service-användaren.
