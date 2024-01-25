---
title: Visa textbundna bilder i Adaptiv Forms
description: Visa överförda bilder i adaptiv Forms
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: 4a69513d-992c-435a-a520-feb9085820e7
last-substantial-update: 2020-06-09T00:00:00Z
duration: 68
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '216'
ht-degree: 0%

---

# Textbundna bilder i Adaptive Forms

Ett vanligt användningssätt är att visa den överförda bilden som en textbunden bild i adaptiv form. Som standard visas den överförda bilden som en länk och den här upplevelsen kan förbättras genom att bilden visas i adaptiv form. I den här artikeln får du hjälp med att visa textbundna bilder.

## Lägg till platshållarbild

Det första steget är att lägga till en platshållare-div i filbilagekomponenten. I koden nedanför identifieras den bifogade filkomponenten av CSS-klassnamnet för överföring av foton. JavaScript-funktionen är en del av klientbiblioteket som är associerat med de adaptiva formulären. Den här funktionen anropas i initialize-händelsen för den bifogade filkomponenten.

```javascript
/**
* Add Placeholder Image
* @return {string} 
 */
function addTempImage(){
  $(".photo-upload").prepend(" <div class='preview'' style='border:2px solid;height:225px;width:175px;text-align:center'><br><br><div class='text'>3.5mm * 4.5mm<br>2Mb max<br>Min 600dpi</div></div><br>");

}
```

### Visa textbunden bild

När användaren har överfört bilden anropas funktionen nedan i en implementeringshändelse för den bifogade filkomponenten. Funktionen tar emot det överförda filobjektet som ett argument.

```javascript
/**
* Consume Image
* @return {string} 
 */
function consumeImage (file) {
  var reader = new FileReader();
    console.log("Reading file");
  reader.addEventListener("load", function (e) {
    console.log("in the event listener");
    var image  = new Image();
    $(".photo-upload .preview .imageP").remove();
    $(".photo-upload .preview .text").remove();
    image.width = 170;image.height = 220;
    image.className = "imageP";
    image.addEventListener("load", function () {
      $(".photo-upload .preview")[0].prepend(this);
    });
    image.src = window.URL.createObjectURL(file);
  });
  reader.readAsDataURL(file); 
}
```

### Distribuera på servern

* Hämta och installera [klientbibliotek](assets/inline-image-client-library.zip) på AEM med AEM pakethanterare.
* Hämta och installera [exempelformulär](assets/inline-image-af.zip) på AEM med AEM pakethanterare.
* Peka webbläsaren till [Lägg till textbunden bild](http://localhost:4502/content/dam/formsanddocuments/addinlineimage/jcr:content?wcmmode=disabled)
* Klicka på knappen &quot;Bifoga ditt foto&quot; för att lägga till en bild
