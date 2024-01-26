---
title: Använda Smart Crop med AEM Assets Dynamic Media
description: Smart Crop använder Adobe Sensei för att eliminera tidskrävande och kostsamma beskärningsåtgärder för responsiv design.
feature: Smart Crop, Image Profiles
version: 6.4, 6.5
topic: Content Management
role: User
level: Beginner
jira: KT-784
doc-type: Feature Video
exl-id: 295bbfb6-241f-41c0-972d-d9688863cea1
duration: 455
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '239'
ht-degree: 0%

---

# Använda Smart Crop med AEM Assets Dynamic Media{#using-smart-crop-with-aem-assets-dynamic-media}

Smart Crop använder Adobe Sensei för att eliminera tidskrävande och kostsamma beskärningsåtgärder för responsiv design.

>[!VIDEO](https://video.tv.adobe.com/v/21519?quality=12&learn=on)

>[!NOTE]
>
>I videon antas att AEM körs i Dynamic Media S7-läge. [Instruktioner om hur du konfigurerar AEM med Dynamic Media finns här.](https://helpx.adobe.com/experience-manager/6-3/assets/using/config-dynamic-fp-14410.html)

## Adobe Experience Manager Dynamic Media Smart Crop innehåller

* AEM kan enkelt skapa bildprofiler för smart beskärning baserat på enhetens bredd och höjd.
* Smart beskärning kan utföras för en enskild resurs eller för alla resurser i en mapp.
* Du kan ändra storlek på redigeringslayouten för smart beskärning så att den blir synligare.
* AEM Sites Dynamic Media-komponent stöder Smart Crop.
* Publicerad URL för den smarta beskurna resursen är tillgänglig för användning med program från tredje part som accepterar värdbaserade resurser.

>[!NOTE]
>
>Koordinaterna för smart beskärning är proportionellt. Det vill säga, för de olika inställningarna för smart beskärning i en bildprofil, skickas samma proportioner till Dynamic Media om proportionerna är desamma för de nya måtten i bildprofilen. På grund av detta föreslås samma beskärningsområde i redigeraren för smart beskärning. En beskärningsinställning på 100x100 och 200x200 resulterar exempelvis i att samma smarta beskärning genereras av systemet.
