---
title: Generera PDF från HTML5-formulärskickning
seo-title: Generera PDF från inskickning av HTML5-formulär
description: Generera PDF från inskickning av mobilformulär
seo-description: Generera PDF från inskickning av mobilformulär
uuid: 61f07029-d440-44ec-98bc-f2b5eef92b59
feature: mobile-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
discoiquuid: 816f1a75-6ceb-457b-ba18-daf229eed057
translation-type: tm+mt
source-git-commit: a0e5a99408237c367ea075762ffeb3b9e9a5d8eb
workflow-type: tm+mt
source-wordcount: '582'
ht-degree: 0%

---


# Generera PDF från HTML5-formulärskickning {#generate-pdf-from-htm-form-submission}

I den här artikeln får du stegvisa instruktioner för hur du genererar PDF-filer från en inskickning av HTML5-formulär (även Mobile Forms). Denna demo förklarar också stegen som krävs för att lägga till en bild i HTML5-formulär och sammanfoga bilden i den slutliga PDF-filen.

Om du vill se en live-demonstration av den här funktionen kan du besöka [exempelservern](https://forms.enablementadobe.com/content/samples/samples.html?query=0) och söka efter&quot;Mobilformulär till PDF&quot;.

Så här sammanfogar du skickade data i xdp-mallen:

Skriva en servett för att hantera HTML5-formuläröverföringen

* I den här serverboken får du tag i skickade data
* Sammanfoga dessa data med xdp-mallen för att generera pdf
* Strömma tillbaka PDF-filen till det anropande programmet

Nedan följer serverns kod som extraherar skickade data från begäran. Sedan anropas den anpassade metoden documentServices.mobileFormToPDF för att hämta PDF-filen.

```java
protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
  StringBuffer stringBuffer = new StringBuffer();
  String line = null;
  try {
   InputStreamReader isReader = new InputStreamReader(request.getInputStream(), "UTF-8");
   BufferedReader reader = new BufferedReader(isReader);
   while ((line = reader.readLine()) != null)
    stringBuffer.append(line);
  } catch (Exception e) {
   System.out.println("Error");
  }
  String xmlData = new String(stringBuffer);
  Document generatedPDF = documentServices.mobileFormToPDF(xmlData);
  try {
   
   InputStream fileInputStream = generatedPDF.getInputStream();
   response.setContentType("application/pdf");
   response.addHeader("Content-Disposition", "attachment; filename=AemFormsRocks.pdf");
   response.setContentLength((int) fileInputStream.available());
   OutputStream responseOutputStream = response.getOutputStream();
   int bytes;
   while ((bytes = fileInputStream.read()) != -1) {
    responseOutputStream.write(bytes);
   }
   responseOutputStream.flush();
   responseOutputStream.close();

  } catch (IOException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }

 }
```

För att lägga till bilder i mobilformulär och visa den bilden i PDF-filen har vi använt följande

XDP-mall - I xdp-mallen har vi lagt till ett bildfält och en knapp med namnet btnAddImage. Följande kod hanterar click-händelsen för btnAddImage i vår anpassade profil. Som du ser utlöser vi händelsen file1 click. Ingen kodning behövs i xdp för att uppnå detta användningsfall

```javascript
$(".btnAddImage").click(function(){

$("#file1").click();

});
```

[Anpassad profil](https://helpx.adobe.com/livecycle/help/mobile-forms/creating-profile.html#CreatingCustomProfiles). Om du använder en anpassad profil blir det enklare att hantera HTML DOM-objekt i mobilformuläret. Ett dolt filelement läggs till i HTML.jsp. När användaren klickar på&quot;Lägg till ditt foto&quot; utlöser vi klickhändelsen för filelementet. På så sätt kan användaren bläddra och välja det foto som ska bifogas. Sedan använder vi Javascript FileReader-objektet för att hämta den base64-kodade strängen för bilden. base64-bildsträngen lagras i textfältet i formuläret. När formuläret skickas extraherar vi det här värdet och infogar det i img-elementet för XML. Denna XML används sedan för att sammanfoga med xdp för att generera den slutliga PDF-filen.

Den anpassade profil som används för den här artikeln har gjorts tillgänglig som en del av artikelns resurser.

```javascript
function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                  window.formBridge.setFieldValue("xfa.form.topmostSubform.Page1.base64image",reader.result);
                    $('.img img').show();
                     $('.img img')
                        .attr('src', e.target.result)
                        .width(180)
                        .height(200)
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
```

Koden ovan körs när vi utlöser click-händelsen för filelementet. Rad 5 extraherar vi innehållet i den överförda filen som base64-sträng och lagrar det i textfältet. Värdet extraheras sedan när formuläret skickas till vår webbserver.

Sedan konfigurerar vi följande egenskaper (avancerade) för vårt mobilformulär i AEM

* Skicka URL - http://localhost:4502/bin/handlemobileformsubmission. Det här är vår servlet som sammanfogar skickade data med xdp-mallen
* HTML-återgivningsprofil - Kontrollera att du väljer &quot;AddImageToMobileForm&quot;. Detta utlöser koden för att lägga till en bild i formuläret.

Så här testar du den här funktionen på din egen server:

* [Distribuera AemFormsDocumentServices-paketet](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)

* [Distribuera Developing with Service User bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

* [Hämta och installera det paket som är kopplat till den här artikeln.](assets/pdf-from-mobile-form-submission.zip)

* Kontrollera att skicka-URL:en och HTML-återgivningsprofilen är rätt inställda genom att visa egenskapssidan för [xdp](http://localhost:4502/libs/fd/fm/gui/content/forms/formmetadataeditor.html/content/dam/formsanddocuments/schengen.xdp)

* [Förhandsgranska XDP som html](http://localhost:4502/content/dam/formsanddocuments/schengen.xdp/jcr:content)

* Lägg till en bild i formuläret och skicka. Du bör få tillbaka PDF-filen med bilden i den.

