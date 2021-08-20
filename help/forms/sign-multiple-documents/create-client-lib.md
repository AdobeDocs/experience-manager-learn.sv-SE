---
title: Skapa klientbibliotek
description: Klientbibliotekskod för att hämta nästa formulär att signera
feature: Adaptiv Forms
version: 6.4,6.5
kt: 6907
thumbnail: 6907.jpg
topic: Utveckling
role: Developer
level: Intermediate
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '84'
ht-degree: 2%

---

# Skapa ett klientbibliotek

Skapa ett anpassat klientbibliotek, clientlib for short, för att extrahera URL-parametrarna och skicka parametrarna i GET-anropet. GET-anropet görs till en serverlet som är monterad på /bin/getnextformtosign och som returnerar URL:en för nästa formulär som ska signeras i paketet.

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
