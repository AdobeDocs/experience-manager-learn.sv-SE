---
title: Använda objektets inläsningssökväg för att fylla i listrutan
description: Konfigurera och fylla i en nedrullningsbar lista för att läsa värden från en crx-nod
feature: Adaptive Forms
version: 6.4,6.5
kt: 10961
topic: Development
role: Developer
level: Beginner
source-git-commit: abf5522b948c950c3ace28a8da43907959be10b4
workflow-type: tm+mt
source-wordcount: '180'
ht-degree: 0%

---

# Artikelinläsningsegenskap i AEM Forms

Konfigurera och fyll i listrutan med objektets sökvägsegenskap.
I fältet Artikelinläsningssökväg kan en författare ange en URL som den läser in de alternativ som är tillgängliga i en listruta.
Följ stegen nedan för att skapa en sådan nod i crx:
* Logga in på crx
* Skapa en nod med namnet assets (du kan namnge den här noden efter behov), typ av snedstreck:mapp under innehållet.
* Spara
* Klicka på noden för nyligen skapade resurser och ange dess egenskaper enligt nedan
* Du måste skapa en egenskap av typen String som kallas resurstyper (du kan namnge den efter behov). Kontrollera att egenskapen är ett multivärde. Ange de värden som du vill ha och spara.
   ![item-load-path](assets/item-load-path-crx.png)

Om du vill läsa in dessa värden i den nedrullningsbara listan anger du följande sökväg i objektets egenskap för inläsningssökväg  **/content/assets/assettypes**

Exempelpaketet kan [hämtad härifrån](assets/item-load-path-package.zip)
