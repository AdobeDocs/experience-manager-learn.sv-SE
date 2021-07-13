---
title: Använda Smart Crop med AEM Assets Dynamic Media
description: Smart Crop använder Adobe Sensei för att eliminera tidskrävande och kostsamma beskärningsåtgärder för responsiv design.
sub-product: dynamiska medier
feature: Smart beskärning, bildprofiler
version: 6.4, 6.5
topic: Innehållshantering
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '253'
ht-degree: 0%

---


# Använda Smart Crop med AEM Assets Dynamic Media{#using-smart-crop-with-aem-assets-dynamic-media}

Smart Crop använder Adobe Sensei för att eliminera tidskrävande och kostsamma beskärningsåtgärder för responsiv design.

>[!VIDEO](https://video.tv.adobe.com/v/21519/)

>[!NOTE]
>
>I videon antas att AEM körs i Dynamic Media S7-läge. [Instruktioner om hur du konfigurerar AEM med Dynamic Media finns här.](https://helpx.adobe.com/experience-manager/6-3/assets/using/config-dynamic-fp-14410.html)

## Adobe Experience Manager Dynamic Media Smart Crop innehåller

* AEM kan enkelt skapa bildprofiler för smart beskärning baserat på enhetens bredd och höjd.
* Smart beskärning kan utföras för en enskild resurs eller för alla resurser i en mapp.
* Du kan ändra storlek på redigeringslayouten för smart beskärning så att den blir synligare.
* Dynamic Media-komponenten för AEM Sites har stöd för Smart Crop.
* Publicerad URL för den smarta beskurna resursen är tillgänglig för användning med program från tredje part som accepterar värdbaserade resurser.

>[!NOTE]
>
>Koordinaterna för smart beskärning är proportionellt. Det vill säga, för de olika inställningarna för smart beskärning i en bildprofil, skickas samma proportioner till Dynamic Media om proportionerna är desamma för de nya måtten i bildprofilen. På grund av detta föreslås samma beskärningsområde i redigeraren för smart beskärning. En beskärningsinställning på 100x100 och 200x200 resulterar exempelvis i att samma smarta beskärning genereras av systemet.
