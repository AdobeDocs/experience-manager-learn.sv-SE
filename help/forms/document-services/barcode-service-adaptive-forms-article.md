---
title: Streckkodstjänst med adaptiv Forms
description: Använda streckkodstjänsten för att avkoda streckkod och fylla i formulärfält från extraherade data.
feature: Barcoded Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: f89cd02d-3ffe-42c6-b547-c0445f912ee8
last-substantial-update: 2020-02-07T00:00:00Z
duration: 115
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '354'
ht-degree: 0%

---

# Streckkodstjänst med adaptiv Forms{#barcode-service-with-adaptive-forms}

I den här artikeln visas hur streckkodstjänsten används för att fylla i adaptiva formulär. Användningsexemplet är följande:

1. Användaren lägger till PDF med streckkod som bilaga i anpassat formulär
1. Sökvägen till den bifogade filen skickas till servern
1. Servern avkodade streckkoden och returnerade data i JSON-format
1. Det adaptiva formuläret fylls sedan i med avkodade data

Följande kod avkodar streckkoden och fyller i ett JSON-objekt med de avkodade värdena. Servern returnerar sedan JSON-objektet i sitt svar på det anropande programmet.



```java
public JSONObject extractBarCode(Document pdfDocument) {
  // TODO Auto-generated method stub
  try {
   org.w3c.dom.Document result = barcodeService.decode(pdfDocument, true, false, false, false, false, false,
     false, false, CharSet.UTF_8);
   List<org.w3c.dom.Document> listResult = barcodeService.extractToXML(result, Delimiter.Carriage_Return,
     Delimiter.Tab, XMLFormat.XDP);
   log.debug("the form1 lenght is " + listResult.get(0).getElementsByTagName("form1").getLength());
   JSONObject decodedData = new JSONObject();
   decodedData.put("name", listResult.get(0).getElementsByTagName("Name").item(0).getTextContent());
   decodedData.put("address", listResult.get(0).getElementsByTagName("Address").item(0).getTextContent());
   decodedData.put("city", listResult.get(0).getElementsByTagName("City").item(0).getTextContent());
   decodedData.put("state", listResult.get(0).getElementsByTagName("State").item(0).getTextContent());
   decodedData.put("zipCode", listResult.get(0).getElementsByTagName("ZipCode").item(0).getTextContent());
   decodedData.put("country", listResult.get(0).getElementsByTagName("Country").item(0).getTextContent());
   log.debug("The JSON Object is " + decodedData.toString());
   return decodedData;
  } catch (Exception e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }
  return null;
 }
```

Här följer serverns kod. Den här servern anropas när användaren lägger till en bifogad fil i det adaptiva formuläret. Servern returnerar JSON-objektet tillbaka till det anropande programmet. Anropande program fyller sedan i det adaptiva formuläret med de värden som extraherats från JSON-objektet.

```java
@Component(service = Servlet.class, property = {

  "sling.servlet.methods=get",

  "sling.servlet.paths=/bin/decodebarcode"

})
public class DecodeBarCode extends SlingSafeMethodsServlet {
 @Reference
 DocumentServices documentServices;
 @Reference
 GetResolver getResolver;
 private static final Logger log = LoggerFactory.getLogger(DecodeBarCode.class);
 private static final long serialVersionUID = 1L;

 protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) {
  ResourceResolver fd = getResolver.getFormsServiceResolver();
  Node pdfDoc = fd.getResource(request.getParameter("pdfPath")).adaptTo(Node.class);
  Document pdfDocument = null;
  log.debug("The path of the pdf I got was " + request.getParameter("pdfPath"));
  try {
   pdfDocument = new Document(pdfDoc.getPath());
   JSONObject decodedData = documentServices.extractBarCode(pdfDocument);
   response.setContentType("application/json");
   response.setHeader("Cache-Control", "nocache");
   response.setCharacterEncoding("utf-8");
   PrintWriter out = null;
   out = response.getWriter();
   out.println(decodedData.toString());
  } catch (RepositoryException | IOException e1) {
   // TODO Auto-generated catch block
   e1.printStackTrace();
  }
 }
}
```

Följande kod är en del av klientbiblioteket som det adaptiva formuläret refererar till. När en användare lägger till den bifogade filen i det adaptiva formuläret utlöses den här koden. Koden gör ett GET-anrop till servern med sökvägen till den bifogade filen som skickas i parametern request. Data som tas emot från serverletanropet används sedan för att fylla i det adaptiva formuläret.

```javascript
$(document).ready(function()
   {
       guideBridge.on("elementValueChanged",function(event,data){
             if(data.target.name=="fileAttachment")
         {
             window.guideBridge.getFileAttachmentsInfo({
        success:function(list) 
                 {
                     console.log(list[0].name + " "+ list[0].path);
                      const getFormNames = '/bin/decodebarcode?pdfPath='+list[0].path;
      $.getJSON(getFormNames, function (data) {
                            console.log(data);
                            var nameField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Name[0]");
                            nameField.value = data.name;
                            var addressField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Address[0]");
                            addressField.value = data.address;
                            var cityField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].City[0]");
                            cityField.value = data.city;
                            var stateField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].State[0]");
                            stateField.value = data.state;
                             var zipField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Zip[0]");
                            zipField.value = data.zipCode;
                            var countryField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Country[0]");
                            countryField.value = data.country;
                        });
                        }
                  });
             }
         });
        });
```

>[!NOTE]
>
>Det adaptiva formuläret som ingår i paketet har skapats med AEM Forms 6.4. Om du tänker använda det här paketet i AEM Forms 6.3-miljö skapar du det adaptiva formuläret i AEM 6.3

Rad 12 - Anpassad kod för att hämta tjänstmatcharen. Det här paketet ingår som en del av dessa artiklar.

Rad 23 - Anropa metoden extractBarCode för DocumentServices så att JSON-objektet fylls med avkodade data

Så här kör du det här på datorn:

1. [Hämta BarcodeService.zip](assets/barcodeservice.zip) och importera till AEM med pakethanteraren
1. [Hämta och installera paketet med anpassade Document Services](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
1. [Hämta och installera paketet DevelopingWithServiceUser](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
1. [Ladda ned exempelformuläret PDF](assets/barcode.pdf)
1. Peka webbläsaren på det [exempel på anpassningsbara formuläret](http://localhost:4502/content/dam/formsanddocuments/barcodedemo/jcr:content?wcmmode=disabled)
1. Överför exempelfilen PDF
1. Du bör se formulären som innehåller data
