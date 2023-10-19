---
title: Fylla i anpassat formulär med metoden setData
description: Skicka den överförda PDF-filen för dataextrahering och fyll i det adaptiva formuläret med extraherade data
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: 14196
source-git-commit: 17ab178f385619b589a9dde6089410bfa4515ffa
workflow-type: tm+mt
source-wordcount: '126'
ht-degree: 0%

---

# Ring Ajax

När användaren har överfört PDF-filen måste vi göra ett anrop till en POST och skicka det överförda PDF-dokumentet i POSTENS begäran. Begäran om POST returnerar en sökväg till exporterade data i crx-databasen

```javascript
$("#fileElem").on('change', function (e) {
           console.log("submitting files");
           var filesUploaded = e.target.files;
           var ajaxData = new FormData($("#myform").get(0));
           for (var i = 0; i < filesUploaded.length; i++) {
               ajaxData.append(filesUploaded[i].name, filesUploaded[i]);
           }

           handleFiles(ajaxData);

       });

function handleFiles(formData) {
    console.log("File uploaded");

    $.ajax({
        type: 'POST',
        data: formData,
        url: '/bin/ExtractDataFromPDF',
        contentType: false,
        processData: false,
        cache: false,
        success: function (filePath) {
            console.log(filePath);
            guideBridge.setData({
                dataRef: filePath,
                error: function (guideResultObject) {
                    console.log("Error");
                }
            })
            

        }
    });
}
```

Servern är monterad på **_/bin/ExtractDataFromPDF_** extraherar data från filen PDF och returnerar sökvägen till crx-noden där extraherade data lagras.
The [GuideBridge setData](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javascript-api/GuideBridge.html#setData__anchor) -metoden används sedan för att ange data i det adaptiva formuläret.

## Nästa steg

[Distribuera exempelresurserna](./test-the-solution.md)


