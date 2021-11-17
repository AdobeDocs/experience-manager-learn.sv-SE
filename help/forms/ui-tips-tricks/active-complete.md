---
title: Formatera vänster navigeringsflik med ikoner
description: Lägg till ikoner för att ange aktiva och slutförda flikar
feature: Adaptive Forms
type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: 9359
source-git-commit: bbb2c352e8a4297496f248bbbc86252ac7118999
workflow-type: tm+mt
source-wordcount: '326'
ht-degree: 7%

---

# Lägg till ikoner för att ange aktiva och slutförda flikar

När du har ett anpassat formulär med vänster fliknavigering kanske du vill visa ikoner som anger flikens status. Du kan t.ex. visa en ikon som anger att fliken är aktiv och en ikon som anger att den är klar, vilket visas på skärmbilden nedan.

![verktygsfältsavstånd](assets/active-completed.png)

## Skapa ett adaptivt formulär

Ett enkelt adaptivt formulär baserat på den grundläggande mallen och Canvas 3.0-temat användes för att skapa exempelformuläret.
The [ikoner som används i den här artikeln](assets/icons.zip) kan hämtas härifrån.


## Formatera standardläge

Öppna formuläret i redigeringsläge Se till att du är i formatlagret och välj en flik (till exempel fliken Allmänt).
Du är i standardläget när du öppnar formatredigeraren för fliken så som visas på skärmbilden nedan
![navigeringsflik](assets/navigation-tab.png)

Set the CSS properties for the default state as shown below
| Category | Property Name  |  Property Value |
|:---|:---|:---|
| Dimensions and Position | Width | 50px |
| Text | Font Weight| Bold |
| Text | Color | #FFF |
|Text | Line Height| 3 |
|Text  | Text Align | Left |
|Background| Color | #056dae |

Save your changes

## Formatera det aktiva läget

Kontrollera att du är i läget Aktiv och formatera följande CSS-egenskaper

| Kategori | Egenskapsnamn | Egenskapsvärde |
|:---|:---|:---|
| Dimensioner och position | Bredd | 50px |
| Text | Teckenbredd | Fet |
| Text | Färg | #FFF |
| Text | Radhöjd | 3 |
| Text | Textjustering | Vänster |
| Bakgrund | Färg | #056dae |

Formatera bakgrundsbilden som den visas på bilden nedan

Spara ändringarna.



![active-state](assets/active-state.png)

## Formatera besöksstatus

Make sure you are in the visited state and style the following properties

| Kategori | Egenskapsnamn | Egenskapsvärde |
|:---|:---|:---|
| Dimensioner och position | Bredd | 50px |
| Text | Teckenbredd | Fet |
| Text | Color | #FFF |
| Text | Radhöjd | 3 |
| Text | Text Align | Vänster |
| Bakgrund | Färg | #056dae |

Formatera bakgrundsbilden som den visas på bilden nedan


![besökt-state](assets/visited-state.png)

Spara ändringarna

Preview the form and test the icons are working as expected.
