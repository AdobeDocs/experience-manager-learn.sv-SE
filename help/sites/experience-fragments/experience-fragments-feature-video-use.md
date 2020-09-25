---
title: Använda AEM Experience Fragments
description: Med Experience Fragments kan innehållsförfattare återanvända innehåll i olika kanaler, inklusive webbplatser och tredjepartssystem.
sub-product: webbplatser, innehållstjänster
feature: experience-fragments
topics: authoring, content-architecture
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
kt: 971
translation-type: tm+mt
source-git-commit: 3b5dd583a458393a41dbce1d8eeb0095a22db734
workflow-type: tm+mt
source-wordcount: '326'
ht-degree: 0%

---


# Använda Experience Fragments{#using-aem-experience-fragments}

Experience Fragments är en funktion i Adobe Experience Manager (AEM), som först introducerades i AEM 6.3. Med Experience Fragments kan innehållsförfattare återanvända innehåll i olika kanaler, inklusive webbplatser och tredjepartssystem.

## Översikt över Experience Fragments

>[!VIDEO](https://video.tv.adobe.com/v/17028/?quality=9&learn=on)

En Experience Fragment är en uppsättning innehåll som grupperats och som ska vara begripligt på egen hand.

Med Experience Fragments kan marknadsförarna

* Återanvänd en upplevelse i alla kanaler (både egna kanaler och kontaktpunkter från tredje part)
* Skapa varianter av en upplevelse för specifika användningsområden
* Synkronisera variationerna med Live Copy
* Sociala inlägg på Facebook och Pinterest direkt

## Bygga block med upplevelsefragment

Byggblock är en ny förbättring i Experience Fragment i AEM 6.4+. Det gör att innehållsförfattare kan skapa en byggsten som består av komponenter som kan återanvändas för att skapa innehåll i olika varianter och i olika mallar.

>[!VIDEO](https://video.tv.adobe.com/v/21289/?quality=9&learn=on)

>[!NOTE]
>
> Redigerbara mallar som används för att skapa upplevelsefragment bör ha byggblockskomponenten tillagd i sina profiler.

* Genom att skapa en byggsten blir det enkelt för skribenter att återanvända innehållet i olika varianter.
* Om du ändrar byggblocket för den överordnad kopian ska ändringar av referenserna automatiskt göras utan att arv eller layoutändringar avbryts.
* Innehållsförfattare kan enkelt byta namn på ett befintligt byggblock eller ta bort det.
* När du tar bort ett byggblock från ett Experience Fragment tas inte dess referenser bort.

## Upplev fragment med fulltextsökning

AEM 6.5 har nu stöd för fulltextsökning för Experience Fragments.

>[!VIDEO](https://video.tv.adobe.com/v/27720/?quality=9&learn=on)

* **Innehållsförfattare** (intern sökning) kan nu söka efter en textdel i ett Experience Fragment och resultatet skulle inkludera de upplevelsefragment som innehåller texten samt sidan som refererar till upplevelsefragmentet.
* **Webbplatsanvändare** (extern sökning) kan nu utföra en fulltextsökning med hjälp av sökkomponenten, och resultatet skulle inkludera webbplatssidor som refererar till det upplevelsefragment som innehåller söknyckelordet.
