---
title: Några användbara tips och tricks för användargränssnittet
description: Dokument som visar användbara tips för användargränssnittet
feature: Adaptive Forms
type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-9270
exl-id: 13b9cd28-2797-4da9-a300-218e208cd21b
last-substantial-update: 2019-07-07T00:00:00Z
duration: 38
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '147'
ht-degree: 0%

---

# Växla synlighet för lösenordsfält

Ett vanligt användningssätt är att låta formuläranvändarna växla till synlighet för den text som anges i lösenordsfältet.
Jag har använt ögonikonen från [Font Awesome Library](https://fontawesome.com/). Den CSS som krävs och eye.svg ingår i klientbiblioteket som skapats för den här demonstrationen.



## Exempelkod

Det adaptiva formuläret har ett fält av typen PasswordBox anropat **ssnField**.

Följande kod körs när formuläret läses in

```javascript
$(document).ready(function() {
    $(".ssnField").append("<p id='fisheye' style='color: Dodgerblue';><i class='fa fa-eye'></i></p>");

    $(document).on('click', 'p', function() {
        var type = $(".ssnField").find("input").attr("type");

        if (type == "text") {
            $(".ssnField").find("input").attr("type", "password");
        }

        if (type == "password") {
            $(".ssnField").find("input").attr("type", "text");
        }

    });

});
```

Följande CSS användes för att placera **ögat** ikon i lösenordsfältet

```javascript
.svg-inline--fa {
    /* display: inline-block; */
    font-size: inherit;
    height: 1em;
    overflow: visible;
    vertical-align: -.125em;
    position: absolute;
    top: 45px;
    right: 40px;
}
```

## Distribuera exempellösenordet

* Ladda ned [klientbibliotek](assets/simple-ui-tips.zip)
* Ladda ned [exempelformulär](assets/simple-ui-tricks-form.zip)
* Importera klientbiblioteket med [gränssnitt för pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* Importera exempelformuläret med [Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/simpleuitips/jcr:content?wcmmode=disabled)
