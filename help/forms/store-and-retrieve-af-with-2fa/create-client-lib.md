---
title: Skapa klientbibliotek
description: Skapa klientbibliotek för att hantera klickhändelsen för knappen "Spara och avsluta"
feature: Adaptiv Forms
type: Tutorial
version: 6.4,6.5
kt: 6597
thumbnail: 6597.pg
topic: Utveckling
role: Developer
level: Intermediate
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '142'
ht-degree: 0%

---

# Skapa klientbibliotek

Skapa [klientlib](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html) som innehåller koden som anropar metoden `doAjaxSubmitWithFileAttachment` för API:t `guideBridge` för händelsen click för knappen som identifieras av CSS-klassen **savebutton**.  Vi skickar de adaptiva formulärdata, `fileMap`, och `mobileNumber` till slutpunkten som lyssnar på `**/bin/storeafdatawithattachments`

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
