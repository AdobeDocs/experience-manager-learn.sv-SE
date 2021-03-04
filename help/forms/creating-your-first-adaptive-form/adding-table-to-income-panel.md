---
title: Lägga till komponenter i resultatpanelen
seo-title: Lägga till komponenter i resultatpanelen
description: Vi ska lägga till en tabell i inkomstpanelen. Konfigurera tabellraderna och använd regelredigeraren för att beräkna totalsumman.
seo-description: Vi ska lägga till en tabell i inkomstpanelen. Konfigurera tabellraderna och använd regelredigeraren för att beräkna totalsumman.
uuid: d5c98561-c559-4624-976a-7a1486da7e69
feature: Adaptiv Forms
topics: authoring
audience: developer
doc-type: tutorial
activity: understand
version: 6.4,6.5
thumbnail: 22198.jpg
kt: 4211
discoiquuid: fa483260-38ff-40d8-96a7-1de11d8b792b
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '216'
ht-degree: 0%

---


# Lägga till komponenter i inkomstpanelen {#adding-components-to-income-panel}

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

## Skapa regel för att beräkna totalsumman {#create-rule-to-calculate-grand-total}


>[!VIDEO](https://video.tv.adobe.com/v/22197?quality=9&learn=on)


