---
title: Skapa klientbibliotek
description: Skapa ett klientbibliotek som hanterar klickhändelsen för knappen "Spara och avsluta"
feature: Adaptive Forms
type: Tutorial
version: 6.4,6.5
jira: KT-6597
thumbnail: 6597.pg
topic: Development
role: Developer
level: Intermediate
exl-id: c90eea73-bd44-40af-aa98-d766aa572415
duration: 42
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '140'
ht-degree: 0%

---

# Skapa klientbibliotek

Skapa [klientlib](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html) som innehåller koden som anropar metoden `doAjaxSubmitWithFileAttachment` i `guideBridge` API för click-händelsen för knappen som identifieras av CSS-klassen **Spara, knapp**.  Vi skickar de anpassningsbara formulärdata, `fileMap`och `mobileNumber` till slutpunkten som lyssnar på `**/bin/storeafdatawithattachments`

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
                  x.data.applicationID +
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
> Vi har använt [bootbox JavaScript-bibliotek](https://bootboxjs.com/examples.html) för att visa dialogrutan

Klientbiblioteken som används i exemplet kan [laddas ned härifrån.](assets/store-af-with-attachments-client-lib.zip)

## Nästa steg

[Verifiera användare med tjänsten för engångslösenord](./verify-users-with-otp.md)
