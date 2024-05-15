---
title: Visa DAM-bilder i Adaptive Forms
description: Visa DAM-bilder i adaptiv Forms
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
last-substantial-update: 2022-10-20T00:00:00Z
thumbnail: inline-dam.jpg
kt: kt-11307
exl-id: 339eb16e-8ad8-4b98-939c-b4b5fd04d67e
duration: 60
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '200'
ht-degree: 0%

---

# Visa DAM-bild i Adaptiv Forms

Ett vanligt användningssätt är att visa de bilder som finns i crx-databasen i en adaptiv form.

## Lägg till platshållarbild

Det första steget är att lägga till en platshållar-div som prefix till panelkomponenten. I koden nedanför identifieras panelkomponenten av CSS-klassnamnet för fotoöverföring. JavaScript-funktionen är en del av klientbiblioteket som är associerat med de adaptiva formulären. Den här funktionen anropas i initialize-händelsen för den bifogade filkomponenten.

```javascript
/**
* Add Placeholder Div
*/
function addPlaceholderDiv(){

     $(".photo-upload").prepend(" <div class='preview'' style='border:1px dotted;height:225px;width:175px;text-align:center'><br><br><div class='text'>The Image will appear here</div></div><br>");
}
```

### Visa textbunden bild

När användaren har valt bilden fylls det dolda fältet ImageName i med det valda bildnamnet. Det här bildnamnet skickas sedan till funktionen damURLToFile som anropar funktionen createFile för att konvertera en URL till en Blob för FileReader.readAsDataURL().

```javascript
/**
* DAM URL to File Object
* @return {string} 
 */
 function damURLToFile (imageName) {
   console.log("The image selected is "+imageName);
     createFile(imageName);
}
```

```javascript
async function createFile(imageName){
  let response = await fetch('/content/dam/formsanddocuments/fieldinspection/images/'+imageName);
  let data = await response.blob();
    console.log(data);
  let metadata = {
    type: 'image/jpeg'
  };
  let file = new File([data], "test.jpg", metadata);
     let reader = new FileReader();
    reader.readAsDataURL(file);
     reader.onload = function() {
    console.log("finished reading ...."+reader.result);
    
  };
    var image  = new Image();
    $(".photo-upload .preview .imageP").remove();
    $(".photo-upload .preview .text").remove();
    image.width = 484;image.height = 334;
    image.className = "imageP";
    image.addEventListener("load", function () {
      $(".photo-upload .preview")[0].prepend(this);
    });
    
    console.log(window.URL.createObjectURL(file));
    image.src = window.URL.createObjectURL(file);

  }
```

### Distribuera på servern

* Hämta och installera [klientbibliotek och exempelbilder](assets/InlineDAMImage.zip) på AEM med AEM Package Manager.
* Hämta och installera [exempelformulär](assets/FieldInspectionForm.zip) på AEM med AEM pakethanterare.
* Peka webbläsaren till [FileInspectionForm](http://localhost:4502/content/dam/formsanddocuments/fieldinspection/fieldinspection/jcr:content?wcmmode=disabled)
* Välj en av korrigeringarna
* Bilden ska visas i formuläret
