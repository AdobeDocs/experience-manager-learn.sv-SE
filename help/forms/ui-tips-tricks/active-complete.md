---
title: Formatera vänster navigeringsflik med ikoner
description: Lägg till ikoner för att ange aktiva och slutförda flikar
feature: Adaptive Forms
type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-9359
exl-id: f7c1f991-0486-4355-8502-cd5b038537e3
last-substantial-update: 2019-07-07T00:00:00Z
duration: 68
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '328'
ht-degree: 0%

---

# Lägg till ikoner för att ange aktiva och slutförda flikar

När du har ett anpassat formulär med vänster fliknavigering kanske du vill visa ikoner som anger flikens status. Du kan t.ex. visa en ikon som anger att fliken är aktiv och en ikon som anger att den är klar, vilket visas på skärmbilden nedan.

![verktygsfält-spacing](assets/active-completed.png)

## Skapa ett adaptivt formulär

Ett enkelt adaptivt formulär baserat på den grundläggande mallen och Canvas 3.0-temat användes för att skapa exempelformuläret.
De [ikoner som används i den här artikeln](assets/icons.zip) kan hämtas härifrån.


## Formatera standardläge

Öppna formuläret i redigeringsläge
Kontrollera att du befinner dig i stillagret och välj en flik (till exempel fliken Allmänt).
Du är i standardläget när du öppnar formatredigeraren för fliken så som visas på skärmbilden nedan
![navigeringsflik](assets/navigation-tab.png)

Ange CSS-egenskaper för standardläget enligt nedan
| Kategori | Egenskapsnamn  |  Egenskapsvärde |
|:—|:—|:—|
| Dimensioner och position | Bredd | 50px |
| Text | Teckenbredd| Fet |
| Text | Färg | #FFF |
|Text | Radhöjd| 3 |
|Text  | Textjustering | Vänster |
|Bakgrund| Färg | #056dae |

Spara ändringarna

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

Se till att du är i besökt läge och formatera följande egenskaper

| Kategori | Egenskapsnamn | Egenskapsvärde |
|:---|:---|:---|
| Dimensioner och position | Bredd | 50px |
| Text | Teckenbredd | Fet |
| Text | Färg | #FFF |
| Text | Radhöjd | 3 |
| Text | Textjustering | Vänster |
| Bakgrund | Färg | #056dae |

Formatera bakgrundsbilden som den visas på bilden nedan


![besökt-state](assets/visited-state.png)

Spara ändringarna

Förhandsgranska formuläret och testa att ikonerna fungerar som förväntat.
