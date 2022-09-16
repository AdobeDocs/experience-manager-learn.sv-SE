---
title: Reaktionskomponent
description: Ett exempel på React-komponent som visar ett innehållsfragment och refererade bildresurser.
version: Cloud Service
mini-toc-levels: 1
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
kt: 11134
thumbnail: KT-11134.jpg
index: false
hide: true
hidefromtoc: true
source-git-commit: 680ed62141b853daf104a827067ca6d5a209796d
workflow-type: tm+mt
source-wordcount: '55'
ht-degree: 0%

---


# Reaktionskomponent

Den här React-komponenten förbrukar ett enda WKND-äventyr och visar innehållet som en reklambanderoll.

Den här koden:

+ Ansluter till [wknd.site](https://wknd.site)AEM Publish-tjänsten och kräver ingen autentisering
+ Använd den beständiga frågan: `wknd-shared/adventures-by-slug`
