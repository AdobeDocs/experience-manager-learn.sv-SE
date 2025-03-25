---
title: Använda objektets inläsningssökväg för att fylla i listrutan
description: Konfigurera och fylla i en nedrullningsbar lista för att läsa värden från en crx-nod
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-10961
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2022-09-20T00:00:00Z
thumbnail: item-load.jpg
exl-id: 89c486c8-95c3-4cd4-bf8e-a1b3558f17d6
duration: 34
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
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

Om du vill läsa in dessa värden i den nedrullningsbara listan anger du följande sökväg i objektets inläsningssökvägsegenskap **/content/assets/assettypes**

Exempelpaketet kan [hämtas här](assets/item-load-path-package.zip)
