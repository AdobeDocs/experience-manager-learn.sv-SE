---
title: Generera interaktivt kommunikationsdokument för tryckkanaler med bevakad mappmekanism
description: Använd bevakad mapp för att generera dokument för utskriftskanaler
feature: Interactive Communication
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
exl-id: f5ab4801-cde5-426d-bfe4-ce0a985e25e8
last-substantial-update: 2019-07-07T00:00:00Z
duration: 115
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '478'
ht-degree: 0%

---

# Generera interaktivt kommunikationsdokument för tryckkanaler med bevakad mappmekanism

När du har utformat och testat ett dokument för tryckkanaler måste du vanligtvis generera dokumentet genom att göra ett REST-anrop eller generera utskriftsdokument med hjälp av en bevakad mappmekanism.

I den här artikeln förklaras hur man genererar dokument i tryckkanaler med bevakad mappmekanism.

När du släpper en fil i den bevakade mappen körs ett skript som är kopplat till den bevakade mappen. Skriptet förklaras i artikeln nedan.

Filen som släpps i bevakad mapp har följande struktur. Koden genererar programsatser för alla kontonummer som anges i XML-dokumentet.

&lt;kontonummer>

&lt;kontonummer>509840&lt;/kontonummer>

&lt;kontonummer>948576&lt;/kontonummer>

&lt;kontonummer>398762&lt;/kontonummer>

&lt;kontonummer>291723&lt;/kontonummer>

&lt;/account numbers>

Kodlistan nedan gör följande:

Rad 1 - Sökväg till InteractiveCommunicationsDocument

Rader 15-20: Hämta listan med kontonummer från XML-dokumentet som tagits bort i den bevakade mappen

Rader 24-25: Hämta PrintChannelService och Print Channel som är associerade med dokumentet.

Rad 30: Skicka kontonumret som nyckelelement till formulärdatamodellen.

Rader 32-36: Ange dataalternativ för det dokument som ska genereras.

Rad 38: Återge dokumentet.

Rader 39-40 - Sparar det genererade dokumentet i filsystemet.

REST-slutpunkten för formulärdatamodellen förväntar sig ett id som indataparameter. detta id mappas till ett Request Attribute med namnet account number (kontonummer), vilket visas på skärmbilden nedan.

![requestedAttribute](assets/requestattributeprintchannel.gif)

```java
var interactiveCommunicationsDocument = "/content/forms/af/retirementstatementprint/channels/print/";
var saveLocation =  new Packages.java.io.File("c:\\scrap\\loadtesting");

if(!saveLocation.exists())
{
 saveLocation.mkdirs();
}

var inputMap = processorContext.getInputMap();
var entry = inputMap.entrySet().iterator().next();
var inputDocument = inputMap.get(entry.getKey());
var aemDemoListings = sling.getService(Packages.com.mergeandfuse.getserviceuserresolver.GetResolver);
var resourceResolver = aemDemoListings.getServiceResolver();
var resourceResolverHelper = sling.getService(Packages.com.adobe.granite.resourceresolverhelper.ResourceResolverHelper);
var dbFactory = Packages.javax.xml.parsers.DocumentBuilderFactory.newInstance();
var dBuilder = dbFactory.newDocumentBuilder();
var xmlDoc = dBuilder.parse(inputDocument.getInputStream());
var nList = xmlDoc.getElementsByTagName("accountnumber");
for(var i=0;i<nList.getLength();i++)
{
 var accountnumber = nList.item(i).getTextContent();
resourceResolverHelper.callWith(resourceResolver, {call: function()
       {
   var printChannelService = sling.getService(Packages.com.adobe.fd.ccm.channels.print.api.service.PrintChannelService);
   var printChannel = printChannelService.getPrintChannel(interactiveCommunicationsDocument);
   var options = new Packages.com.adobe.fd.ccm.channels.print.api.model.PrintChannelRenderOptions();
   options.setMergeDataOnServer(true);
   options.setRenderInteractive(false);
   var map = new Packages.java.util.HashMap();
   map.put("accountnumber",accountnumber);
    // Required Data Options
   var dataOptions = new Packages.com.adobe.forms.common.service.DataOptions(); 
   dataOptions.setServiceName(printChannel.getPrefillService()); 
   dataOptions.setExtras(map); 
   dataOptions.setContentType(Packages.com.adobe.forms.common.service.ContentType.JSON);
   dataOptions.setFormResource(resourceResolver.resolve(interactiveCommunicationsDocument));
            options.setDataOptions(dataOptions); 
    var printDocument = printChannel.render(options);
   var statement = new Packages.com.adobe.aemfd.docmanager.Document(printDocument.getInputStream());
            statement.copyToFile(new Packages.java.io.File(saveLocation+"\\"+accountnumber+".pdf"));

      }
   });
}
```


**Följ följande anvisningar för att testa detta på din lokala dator:**

* Konfigurera Tomcat enligt beskrivningen i den här [-artikeln.](/help/forms/ic-print-channel-tutorial/set-up-tomcat.md) Tomcat har krigsfilen som genererar exempeldata.
* Konfigurera en tjänst för en systemanvändare enligt beskrivningen i den här [artikeln](/help/forms/adaptive-forms/service-user-tutorial-develop.md).
Kontrollera att den här systemanvändaren har läsbehörighet för följande nod. Om du vill ge behörighet att logga in på [användaradministratör](https://localhost:4502/useradmin) och söka efter systemanvändarens&quot;data&quot; och ge läsbehörighet på följande nod genom att gå till fliken Behörigheter
   * /content/dam/formSanddocuments
   * /content/dam/formsanddocuments-fdm
   * /content/forms/af
* Importera följande paket till AEM med pakethanteraren. Paketet innehåller följande:


* [Exempel på interaktivt kommunikationsdokument](assets/retirementstatementprint.zip)
* [Bevakat mappskript](assets/printchanneldocumentusingwatchedfolder.zip)
* [Data Source Configuration](assets/datasource.zip)

* Öppna filen /etc/fd/watchfolder/scripts/PrintPDF.ecma. Se till att sökvägen till interactiveCommunicationsDocument på rad 1 pekar på rätt dokument som du vill skriva ut

* Ändra saveLocation enligt dina önskemål på rad 2

* Skapa filen accountNumbers.xml med följande innehåll

```xml
<accountnumbers>
<accountnumber>1</accountnumber>
<accountnumber>100</accountnumber>
<accountnumber>101</accountnumber>
<accountnumber>1009</accountnumber>
<accountnumber>10009</accountnumber>
<accountnumber>11990</accountnumber>
</accountnumbers>
```


* Släpp account.xml i mappen C:\RenderPrintChannel\input.

* De genererade PDF-filerna skrivs till saveLocation enligt specifikationen i ecma-skriptet.

>[!NOTE]
>
>Om du tänker använda detta i ett operativsystem som inte är ett Windows-operativsystem går du till
>
>/etc/fd/watchfolder /config/PrintChannelDocument och ändra folderPath enligt dina önskemål
