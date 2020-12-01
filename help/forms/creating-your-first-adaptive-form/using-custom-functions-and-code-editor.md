---
title: Använda funktioner och kodredigerare
seo-title: Använda funktioner och kodredigerare
description: Använda funktioner och kodredigerare för att skapa affärsregler
seo-description: Använda funktioner och kodredigerare för att skapa affärsregler
uuid: 578e91f8-0d93-4192-b7af-1579df2feaf8
feature: adaptive-forms
topics: authoring
audience: developer
doc-type: tutorial
activity: understand
version: 6.4,6.5
discoiquuid: f480ef3e-7e38-4a6b-a223-c102787aea7f
kt: 4270
thumbnail: 22282.jpg
translation-type: tm+mt
source-git-commit: c60a46027cc8d71fddd41aa31dbb569e4df94823
workflow-type: tm+mt
source-wordcount: '150'
ht-degree: 0%

---


# Använda anpassade funktioner och kodredigeraren {#using-functions-and-code-editor}

I den här delen använder vi anpassade funktioner och kodredigeraren för att skapa affärsregler.

du har redan installerat [ClientLib med den anpassade funktionen](assets/client-libs-and-logo.zip) tidigare i den här självstudien.

Ett klientbibliotek består vanligtvis av CSS- och JavaScript-filer. Det här klientbiblioteket innehåller javascript-filen som visar en funktion för att fylla i värden i listrutor.


## Funktion för att fylla i nedrullningsbar lista {#function-to-populate-drop-down-list}

>[!VIDEO](https://video.tv.adobe.com/v/22282?quality=9&learn=on)

### Ange sammanfattningsrubrik för panelen {#set-the-summary-title-of-panels}

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
