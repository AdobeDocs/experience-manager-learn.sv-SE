---
title: Skapa klientbibliotek
description: Klientbibliotekskod för att hämta nästa formulär att signera
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-6907
thumbnail: 6907.jpg
topic: Development
role: Developer
level: Intermediate
exl-id: 3c148b30-2c7d-428d-9a3c-f3067ca3a239
duration: 34
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '91'
ht-degree: 1%

---

# Skapa ett klientbibliotek

Skapa ett anpassat klientbibliotek, clientlib for short, för att extrahera URL-parametrarna och skicka parametrarna i GET-anropet. GET anrop görs till en serverlet som är monterad på /bin/getnextformtosign och som returnerar URL:en för nästa formulär som ska signeras i paketet.

Följande kod används i javascript-funktionen clientlib


```java
function getUrlVars()
{
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m, key, value)
    {
        vars[key] = value;
    });
    return vars;
}

function navigateToNextForm()
{
    
    console.log("The id is " + guidelib.runtime.adobeSign.submitData.agreementId);
    var guid = getUrlVars()["guid"];
    var customerID = getUrlVars()["customerID"];
    console.log("The customer Id is " + customerID);
    $.ajax(
    {
        type: 'GET',
        url: '/bin/getnextformtosign?guid=' + guid + '&customerID=' + customerID,
        contentType: false,
        processData: false,
        cache: false,
        success: function(response)
        {
            console.log(response);
            var jsonResponse = JSON.parse(JSON.stringify(response));
            console.log(jsonResponse.nextFormToSign);
            var nextFormToSign = jsonResponse.nextFormToSign;
            if (nextFormToSign != "AllDone")
            {
                window.open(nextFormToSign, '_self');
            }
            else
            {
                window.open("http://localhost:4502/content/forms/af/formsandsigndemo/alldone.html", '_self');
            }

}
    });
}
$(document).ready(function()
{
    $(document).on("click", ".nextform", navigateToNextForm);
});
```

## Assets

[Klientlib kan laddas ned härifrån](assets/get-next-form-client-lib.zip)

## Nästa steg

[Skapa en anpassad formulärmall för det här användningsfallet](./create-af-template.md)