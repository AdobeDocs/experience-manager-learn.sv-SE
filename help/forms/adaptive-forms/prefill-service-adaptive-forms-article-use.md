---
title: Prefill Service in Adaptive Forms
seo-title: Prefill Service in Adaptive Forms
description: Fyll i anpassningsbara formulär i förväg genom att hämta data från backend-datakällor.
seo-description: Fyll i anpassningsbara formulär i förväg genom att hämta data från backend-datakällor.
sub-product: formulär
feature: adaptive-forms
topics: integrations
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
uuid: 26a8cba3-7921-4cbb-a182-216064e98054
discoiquuid: 936ea5e9-f5f0-496a-9188-1a8ffd235ee5
translation-type: tm+mt
source-git-commit: 3d54a8158d0564a3289a2100bbbc59e5ae38f175
workflow-type: tm+mt
source-wordcount: '478'
ht-degree: 0%

---


# Använda förifyllningstjänsten i adaptiv Forms

Du kan förifylla fälten i ett adaptivt formulär med befintliga data. När en användare öppnar ett formulär är värdena för dessa fält förifyllda. Det finns flera sätt att förifylla adaptiva formulärfält. I den här artikeln ska vi titta närmare på hur man fyller i anpassningsbara formulär med AEM Forms förifyllningstjänst.

[Följ denna dokumentation](https://helpx.adobe.com/experience-manager/6-4/forms/using/prepopulate-adaptive-form-fields.html#AEMFormsprefillservice) om du vill veta mer om olika metoder för att förifylla adaptiva formulär

Om du vill förifylla anpassningsbara formulär med förifyllningstjänsten måste du skapa en klass som implementerar DataProvider-gränssnittet. Metoden getPrefillData har logiken för att skapa och returnera data som anpassningsbara formulär använder för att fylla i fälten i förväg. I den här metoden kan du hämta data från valfri källa och returnera indataström för ett datadokument. Följande exempelkod hämtar användarprofilinformationen för den inloggade användaren och konstruerar ett XML-dokument vars indataström returneras för att förbrukas av de adaptiva formulären.

I kodfragmentet nedan har vi en klass som implementerar DataProvider-gränssnittet. Vi får åtkomst till den inloggade användaren och hämtar sedan den inloggade användarens profilinformation. Sedan skapar vi ett XML-dokument med ett rotelemente som kallas&quot;data&quot; och lägger till lämpliga element till den här datanoden. När XML-dokumentet har konstruerats returneras XML-dokumentets indataström.

Den här klassen görs sedan i OSGi-paketet och distribueras till AEM. När paketet har distribuerats är den här förifyllningstjänsten sedan tillgänglig för att användas som förifyllningstjänst i ditt adaptiva formulär.

```java
public class PrefillAdaptiveForm implements DataProvider {
 private Logger logger = LoggerFactory.getLogger(PrefillAdaptiveForm.class);

 public String getServiceName() {
  return "Default Prefill Service";
 }
 
 public String getServiceDescription() {
  return "This is default prefill service to prefill adaptive form with user data";
 }
 
 public PrefillData getPrefillData(final DataOptions dataOptions) throws FormsException {
  PrefillData prefillData = new PrefillData() {
   public InputStream getInputStream() {
    return getData(dataOptions);
   }
   
   public ContentType getContentType() {
    return ContentType.XML;
   }
  };
  return prefillData;
 }

 private InputStream getData(DataOptions dataOptions) throws FormsException {  
  try {
   Resource aemFormContainer = dataOptions.getFormResource();
   ResourceResolver resolver = aemFormContainer.getResourceResolver();
   Session session = resolver.adaptTo(Session.class);
   UserManager um = ((JackrabbitSession) session).getUserManager();
   Authorizable loggedinUser = um.getAuthorizable(session.getUserID());
   DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
   DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
   Document doc = docBuilder.newDocument();
   Element rootElement = doc.createElement("data");
   doc.appendChild(rootElement);
   Element firstNameElement = doc.createElement("fname");
   firstNameElement.setTextContent(loggedinUser.getProperty("profile/givenName")[0].getString());
     .
     .
     .
   InputStream inputStream = new ByteArrayInputStream(rootElement.getTextContent().getBytes());
   return inputStream;
  } catch (Exception e) {
   logger.error("Error while creating prefill data", e);
   throw new FormsException(e);
  }
 }
}
```

Utför följande för att testa den här funktionen på servern:

* [Hämta och extrahera innehållet i zip-filen till datorn](assets/prefillservice.zip)
* Kontrollera att den inloggade [användarens profil](http://localhost:4502/libs/granite/security/content/useradmin)-informationen är fullständigt ifylld. Detta är ett krav för att exemplet ska fungera. Exemplet innehåller inte någon felsökning för saknade användarprofilsegenskaper.
* Distribuera paketet med [AEM webbkonsol](http://localhost:4502/system/console/bundles)
* Skapa anpassat formulär med XSD
* Associera&quot;Custom AEM Form Pre Fill Service&quot; som förifyllningstjänst för ditt adaptiva formulär
* Dra och släpp schemaelement på formuläret
* Förhandsgranska formuläret

>[!NOTE]
>
>Om det adaptiva formuläret är baserat på XSD kontrollerar du att det XML-dokument som returneras av förifyllningstjänsten matchar det XSD som det adaptiva formuläret är baserat på.
>
>Om det adaptiva formuläret inte är baserat på XSD måste du binda fälten manuellt. Om du till exempel vill binda ett adaptivt formulärfält till fname-element i XML-data använder du `/data/fname` i bindningsreferensen för det adaptiva formulärfältet.

