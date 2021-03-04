---
title: Anpassning av inkorgen
description: 'Anpassa inkorgen genom att lägga till nya kolumner baserat på arbetsflödesdata '
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.5
kt: 5830
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '206'
ht-degree: 0%

---

# AEM

AEM Inkorg konsoliderar meddelanden och uppgifter från olika AEM komponenter, inklusive Forms-arbetsflöden. När ett formulärarbetsflöde som innehåller ett tilldelningssteg aktiveras, visas det associerade programmet som en uppgift i den tilldelades inkorg.
Användargränssnittet i Inkorgen innehåller lista- och kalendervyer för att visa uppgifter. Du kan också konfigurera visningsinställningarna. Du kan filtrera uppgifter baserat på olika parametrar
Du kan anpassa en inkorg i Experience Manager om du vill ändra en kolumns standardtitel, ändra ordningen på en kolumns placering och visa ytterligare kolumner baserat på data i ett arbetsflöde


>[!NOTE]
>
>Du måste vara medlem i administratörer eller arbetsflödesadministratörer för att kunna anpassa inkorgskolumnerna

## Kolumnanpassning

[Öppna AEM ](http://localhost:4502/aem/inbox)
inkorgÖppna Admin Control genom att klicka på  _List_ Viewicon och sedan välja  _Admin_ Controls som visas på bilden nedan

![admin-control](assets/open-customization.png)

I kolumnanpassningsgränssnittet kan du utföra följande åtgärder

* Ta bort kolumner
* Ordna om kolumnerna
* Byt namn på kolumner

## Anpassning av varumärkesprofilering

Du kan göra följande när du anpassar varumärket:

* Lägg till din organisationslogotyp
* Anpassa rubriktext
* Anpassa hjälplänken
* Dölj navigeringsalternativ

![inbox-branding](assets/branding-customization.PNG)
