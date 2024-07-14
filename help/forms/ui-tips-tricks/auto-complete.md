---
title: Komplettera automatiskt i AEM Forms
description: Gör det möjligt för användare att snabbt hitta och välja från en ifylld lista med värden när de skriver, med hjälp av sökning och filtrering.
feature: Adaptive Forms
type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-11374
last-substantial-update: 2022-11-01T00:00:00Z
exl-id: e9a696f9-ba63-462d-93a8-e9a7a1e94e72
duration: 47
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '177'
ht-degree: 0%

---

# Automatisk komplettering

Implementera funktioner för automatisk ifyllnad i AEM formulär med hjälp av Jquery funktion för automatisk ifyllnad.
I exemplet som ingår i den här artikeln används en rad olika datakällor (statisk array, dynamisk array ifylld från ett REST API-svar) för att fylla i förslagen när användaren börjar skriva i textfältet.

Den kod som används för att utföra funktionen för automatisk komplettering är associerad med händelsen initialize för fältet.

## Ange förslag för adress

![landsförslag](assets/auto-complete2.png)



Följande kod används för att ge förslag på gatuadresser

```javascript
$(".streetAddress input").autocomplete({
    source: function(request, response) {
        $.ajax({
            url: "https://api.geoapify.com/v1/geocode/autocomplete?text=" + request.term + "&apiKey=Your API Key", //please get your own API key with geoapify.com
            responseType: "application/json",
            success: function(data) {
                console.log(data.features.length);
                response($.map(data.features, function(item) {
                    return {
                        label: [item.properties.formatted],
                        value: [item.properties.formatted]
                    };
                }));
            },
        });
    },
    minLength: 5,
    select: function(event, ui) {
        console.log(ui.item ?
            "Selected: " + ui.item.label :
            "Nothing selected, input was " + this.value);
    }

});
```





## Förslag med uttryckssymboler

![landsförslag](assets/auto-complete3.png)

Följande kod användes för att visa uttryckssymboler i förslagslistan

```javascript
var values=["Wolf \u{1F98A}", "Lion \u{1F981}","Puppy \u{1F436}","Giraffe \u{1F992}","Frog \u{1F438}"];
$(".Animals input").autocomplete( {
minLength: 1, source: values, delay: 0
}

);
```

Exempelformuläret [kan hämtas](assets/auto-complete-form.zip) härifrån. Se till att du anger din egen användarnamn/API-nyckel med kodredigeraren för koden för att kunna göra REST-anrop.

>[!NOTE]
>
> För att automatisk komplettering ska fungera måste formuläret använda följande klientbibliotek: **cq.jquery.ui**. Det här klientbiblioteket levereras med AEM.
