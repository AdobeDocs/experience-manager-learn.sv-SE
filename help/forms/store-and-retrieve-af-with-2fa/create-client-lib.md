---
title: Skapa klientbibliotek
description: Skapa klientbibliotek för att hantera klickhändelsen för knappen "Spara och avsluta"
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6597
thumbnail: 6597.pg
translation-type: tm+mt
source-git-commit: 9d4e864f42fa6c0b2f9b895257db03311269ce2e
workflow-type: tm+mt
source-wordcount: '141'
ht-degree: 0%

---

# Skapa klientbibliotek

Skapa [klientlib](https://docs.adobe.com/content/help/en/experience-manager-65/developing/introduction/clientlibs.html) som innehåller koden som anropar metoden `doAjaxSubmitWithFileAttachment` för API:t `guideBridge` för händelsen click för knappen som identifieras av CSS-klassen **savebutton**.  Vi skickar de adaptiva formulärdata, `fileMap`, och `mobileNumber` till slutpunkten som lyssnar på `**/bin/storeafdatawithattachments`

När formulärdata har sparats genereras ett unikt program-ID som visas för användaren i en dialogruta. När dialogrutan stängs dirigeras användaren till formuläret som gör att användaren kan hämta det sparade adaptiva formuläret med det unika program-ID:t.

```java
$(document).ready(function () {
  
  $(".savebutton").click(function () {
    var tel = guideBridge.resolveNode(
      "guide[0].guide1[0].guideRootPanel[0].contactInformation[0].basicContact[0].telephoneNumber[0]"
    );
    var telephoneNumber = tel.value;
    guideBridge.getFormDataString({
      success: function (data) {
        var map = guideBridge._getFileAttachmentMapForSubmit();
        guideBridge.doAjaxSubmitWithFileAttachment(
          "/bin/storeafdatawithattachments",
          {
            data: data.data,
            fileMap: map,
            mobileNumber: telephoneNumber,
          },
          {
            success: function (x) {
              bootbox.alert(
                "This is your reference number.<br>" +
                  x.data.path +
                  " <br>You will need this to retrieve your application",
                function () {
                  console.log(
                    "This was logged in the callback! After the ok button was pressed"
                  );
                  window.location.href =
                    "http://localhost:4502/content/dam/formsanddocuments/myaccountform/jcr:content?wcmmode=disabled";
                }
              );
              console.log(x.data.path);
            },
          },
          guideBridge._getFileAttachmentsList()
        );
      },
    });
  });
});
```

>[!NOTE]
> Vi har använt [javascript-biblioteket](http://bootboxjs.com/examples.html) för att visa dialogrutan

Klientbiblioteken som används i det här exemplet kan [hämtas här](assets/client-libraries.zip)
