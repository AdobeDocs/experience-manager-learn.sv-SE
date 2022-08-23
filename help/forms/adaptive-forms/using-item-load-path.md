---
title: Använda objektets inläsningssökväg för att fylla i listrutan
description: Konfigurera och fylla i en nedrullningsbar lista för att läsa värden från en crx-nod
feature: Adaptive Forms
version: 6.4,6.5
kt: 10961
topic: Development
role: Developer
level: Beginner
source-git-commit: 614db8b03a823b60846ab8ccfa8fbc29a41f7791
workflow-type: tm+mt
source-wordcount: '175'
ht-degree: 0%

---

# Artikelinläsningsegenskap i AEM Forms

Konfigurera och fyll i listrutan med objektets sökvägsegenskap.
I fältet Artikelinläsningssökväg kan en författare ange en URL som den läser in de alternativ som är tillgängliga i en listruta.
Följ stegen nedan för att skapa en sådan nod i crx

* Logga in på crx
* Skapa en nod med namnet assets (du kan namnge den här noden efter behov), typ av snedstreck:mapp under innehållet.
* Spara
* Klicka på noden för nyligen skapade resurser och ange dess egenskaper enligt nedan
* Du måste skapa en egenskap av typen String som kallas resurstyper (du kan namnge den efter behov) med multivalue. Ange de värden som du vill ha och spara.

![item-load-path](assets/item-load-path-crx.png)

Om du vill läsa in dessa värden i den nedrullningsbara listan anger du följande sökväg i objektets egenskap för inläsningssökväg  **/content/assets/assettypes**

Exempelpaketet kan [hämtad härifrån](assets/item-load-path-package.zip)
