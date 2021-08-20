---
title: Använda funktioner och kodredigerare
description: Använda funktioner och kodredigerare för att skapa affärsregler
feature: Adaptiv Forms
version: 6.4,6.5
kt: 4270
thumbnail: 22282.jpg
topic: Utveckling
role: Developer
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '139'
ht-degree: 0%

---


# Använda anpassade funktioner och kodredigerare {#using-functions-and-code-editor}

I den här delen använder vi anpassade funktioner och kodredigeraren för att skapa affärsregler.

du har redan installerat [ClientLib med den anpassade funktionen](assets/client-libs-and-logo.zip) tidigare i den här självstudien.

Ett klientbibliotek består vanligtvis av CSS- och JavaScript-filer. Det här klientbiblioteket innehåller javascript-filen som visar en funktion för att fylla i värden i listrutor.


## Funktion för att fylla i nedrullningsbar lista {#function-to-populate-drop-down-list}

>[!VIDEO](https://video.tv.adobe.com/v/22282?quality=9&learn=on)

### Ange panelens sammanfattningsrubrik {#set-the-summary-title-of-panels}

>[!VIDEO](https://video.tv.adobe.com/v/28387?quality=9&learn=on)

#### Validera panel {#validate-panels-using-rule-editor}

>[!VIDEO](https://video.tv.adobe.com/v/28409?quality=9&learn=on)

Följande kod används för att validera panelfält

```javascript
//debugger;
var errors =[];
var fields ="";
var currentPanel = guideBridge.getFocus({"focusOption": "navigablePanel"});
window.guideBridge.validate(errors,currentPanel);
console.log("The errors are "+ errors.length);
if(errors.length===0)
{
        window.guideBridge.setFocus(this.panel.somExpression, 'nextItem', true);
}
else
  {
    for(var i=0;i<errors.length;i++)
      {
        var fields = fields+guideBridge.resolveNode(errors[i].som).title+" , ";
      }
        window.confirm("Please fill out  "+fields.slice(0,-1)+ " fields");
  }
```

Du kan avkommentera rad 1 för att felsöka koden i webbläsarfönstret.

Rad 4 - Hämta den aktuella panelen

Rad 5 - Validera den aktuella panelen.

Rad 9 - Om inga fel uppstår, går du till nästa panel

Förhandsgranska formuläret och testa den nya funktionen.
