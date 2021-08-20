---
title: Lägga till komponenter i resultatpanelen
description: Vi ska lägga till en tabell i inkomstpanelen. Konfigurera tabellraderna och använd regelredigeraren för att beräkna totalsumman.
feature: Adaptiv Forms
version: 6.4,6.5
thumbnail: 22198.jpg
kt: 4211
topic: Utveckling
role: Developer
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '186'
ht-degree: 0%

---


# Lägga till komponenter i resultatpanelen {#adding-components-to-income-panel}

Vi ska lägga till en tabell i inkomstpanelen. Konfigurera tabellraderna och använd regelredigeraren för att beräkna totalsumman.

**Lägg till och konfigurera tabellkomponent**

>[!VIDEO](https://video.tv.adobe.com/v/22198?quality=9&learn=on)



## Gör intäktstabellen dynamisk {#make-the-income-table-dynamic}

**Kontrollera att du är i redigeringsläge. Redigeringsknappen finns längst upp till höger i webbläsaren.**

* Som standard när du infogar en tabell i adaptiv form är tabellen inte dynamisk, vilket innebär att du inte kan lägga till nya rader i tabellen under körning.

* Uppdatera webbläsaren.

* Välj Rad1 i innehållshierarkin.

* Klicka på skiftnyckelsikonen för att öppna egenskapsbladet.

* Ange Minsta och Högsta antal till 1 och 5 under Upprepa inställningar och spara ändringarna genom att klicka på den blå bockmarkeringsikonen. Det innebär att tabellen kan ha högst fem rader. Om du vill ha ett obegränsat antal rader anger du maxantalet till -1.

## Skapa regel för att beräkna totalsumma {#create-rule-to-calculate-grand-total}


>[!VIDEO](https://video.tv.adobe.com/v/22197?quality=9&learn=on)


