---
title: Prefill Service in Adaptive Forms
description: Fyll i anpassningsbara formulär i förväg genom att hämta data från backend-datakällor.
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: f2c324a3-cbfa-4942-b3bd-dc47d8a3f7b5
last-substantial-update: 2021-11-27T00:00:00Z
duration: 136
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '424'
ht-degree: 0%

---

# Använda förifyllningstjänsten i adaptiv Forms

Du kan förifylla fälten i ett adaptivt formulär med befintliga data. När en användare öppnar ett formulär är värdena för dessa fält förifyllda. Det finns flera sätt att förifylla adaptiva formulärfält. I den här artikeln ska vi titta närmare på hur man fyller i anpassningsbara formulär med AEM Forms förifyllningstjänst.

Om du vill veta mer om olika metoder för att förifylla adaptiva formulär, [följ dokumentationen](https://helpx.adobe.com/experience-manager/6-4/forms/using/prepopulate-adaptive-form-fields.html#AEMFormsprefillservice)

Om du vill förifylla ett anpassat formulär med förifyllningstjänsten måste du skapa en klass som implementerar `com.adobe.forms.common.service.DataXMLProvider` gränssnitt. Metoden `getDataXMLForDataRef` har den logik som krävs för att skapa och returnera data som det adaptiva formuläret använder för att fylla i fälten i förväg. I den här metoden kan du hämta data från valfri källa och returnera indataströmmen för ett datadokument. Följande exempelkod hämtar användarprofilinformationen för den inloggade användaren och konstruerar ett XML-dokument vars indataström returneras för att förbrukas av de adaptiva formulären.

I kodfragmentet nedan har vi en klass som implementerar gränssnittet DataXMLProvider. Vi får åtkomst till den inloggade användaren och hämtar sedan den inloggade användarens profilinformation. Sedan skapar vi ett XML-dokument med ett rotelemente som kallas&quot;data&quot; och lägger till lämpliga element till den här datanoden. När XML-dokumentet har konstruerats returneras XML-dokumentets indataström.

Den här klassen görs sedan i OSGi-paketet och distribueras till AEM. När paketet har distribuerats är den här förifyllningstjänsten sedan tillgänglig för att användas som förifyllningstjänst i ditt adaptiva formulär.

>[!NOTE]
>
>Du kan förifylla formulär med xml- eller json-data på det sätt som anges i den här artikeln.

```java
package com.aem.prefill.core;
import com.adobe.forms.common.service.DataXMLOptions;
import com.adobe.forms.common.service.DataXMLProvider;
import com.adobe.forms.common.service.FormsException;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import javax.jcr.Session;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.jackrabbit.api.JackrabbitSession;
import org.apache.jackrabbit.api.security.user.Authorizable;
import org.apache.jackrabbit.api.security.user.UserManager;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

@Component
public class PrefillAdaptiveForm implements DataXMLProvider {
  private static final Logger log = LoggerFactory.getLogger(PrefillAdaptiveForm.class);

  @Override
  public String getServiceDescription() {

    return "Custom AEM Forms PreFill Service";
  }

  @Override
  public String getServiceName() {

    return "CustomAemFormsPrefillService";
  }

  @Override
  public InputStream getDataXMLForDataRef(DataXMLOptions dataXmlOptions) throws FormsException {
    InputStream xmlDataStream = null;
    Resource aemFormContainer = dataXmlOptions.getFormResource();
    ResourceResolver resolver = aemFormContainer.getResourceResolver();
    Session session = (Session) resolver.adaptTo(Session.class);
    try {
      UserManager um = ((JackrabbitSession) session).getUserManager();
      Authorizable loggedinUser = um.getAuthorizable(session.getUserID());
      log.debug("The path of the user is" + loggedinUser.getPath());
      DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
      DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
      Document doc = docBuilder.newDocument();
      Element rootElement = doc.createElement("data");
      doc.appendChild(rootElement);

      if (loggedinUser.hasProperty("profile/givenName")) {
        Element firstNameElement = doc.createElement("fname");
        firstNameElement.setTextContent(loggedinUser.getProperty("profile/givenName")[0].getString());
        rootElement.appendChild(firstNameElement);
        log.debug("Created firstName Element");
      }

      if (loggedinUser.hasProperty("profile/familyName")) {
        Element lastNameElement = doc.createElement("lname");
        lastNameElement.setTextContent(loggedinUser.getProperty("profile/familyName")[0].getString());
        rootElement.appendChild(lastNameElement);
        log.debug("Created lastName Element");

      }
      if (loggedinUser.hasProperty("profile/email")) {
        Element emailElement = doc.createElement("email");
        emailElement.setTextContent(loggedinUser.getProperty("profile/email")[0].getString());
        rootElement.appendChild(emailElement);
        log.debug("Created email Element");

      }

      TransformerFactory transformerFactory = TransformerFactory.newInstance();
      ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
      Transformer transformer = transformerFactory.newTransformer();
      DOMSource source = new DOMSource(doc);
      StreamResult outputTarget = new StreamResult(outputStream);
      TransformerFactory.newInstance().newTransformer().transform(source, outputTarget);
      if (log.isDebugEnabled()) {
        FileOutputStream output = new FileOutputStream("afdata.xml");
        StreamResult result = new StreamResult(output);
        transformer.transform(source, result);
      }

      xmlDataStream = new ByteArrayInputStream(outputStream.toByteArray());
      return xmlDataStream;
    } catch (Exception e) {
      log.error("The error message is " + e.getMessage());
    }
    return null;

  }

}
```

Utför följande för att testa den här funktionen på servern:

* Kontrollera att du är inloggad [användarens profil](http://localhost:4502/security/users.html) informationen fylls i. Exemplet söker efter egenskaperna FirstName, LastName och Email för den inloggade användaren.
* [Hämta och extrahera innehållet i zip-filen till datorn](assets/prefillservice.zip)
* Distribuera paketet prefill.core-1.0.0-SNAPSHOT med [AEM webbkonsol](http://localhost:4502/system/console/bundles)
* Importera det adaptiva formuläret med Skapa | Filöverföring från [Avsnittet FormsAndDocuments](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Se till att [formulär](http://localhost:4502/editor.html/content/forms/af/prefill.html) använder **&quot;Custom AEM Forms PreFill Service&quot;** som förifyllningstjänst. Detta kan verifieras med hjälp av konfigurationsegenskaperna i **Formulärbehållare** -avsnitt.
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/prefill/jcr:content?wcmmode=disabled). Du bör se formuläret ifyllt med rätt värden.

>[!NOTE]
>
>Om du har aktiverat felsökning för com.aem.prefill.core.PrefillAdaptiveForm skrivs den genererade xml-datafilen till AEM serverinstallationsmapp.

