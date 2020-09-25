---
title: Översikt över Dynamic Media med AEM Assets
seo-title: Översikt över Dynamic Media med AEM Assets
description: I den här videoserien får du en översikt över hur mediematerial hanteras och nås med Adobe Experience Manager Dynamic Media som tjänst för innehållsvisning. Med Dynamic Media kan ni hantera och publicera dynamiska digitala upplevelser - en funktion som är unik för Experience Manager Assets. Med vårt ramverk och våra komponenter kan marknadsförarna anpassa och leverera interaktiva multimedieupplevelser för alla enheter.
seo-description: I den här videoserien får du en översikt över hur mediematerial hanteras och nås med Adobe Experience Manager Dynamic Media som tjänst för innehållsvisning. Med Dynamic Media kan ni hantera och publicera dynamiska digitala upplevelser - en funktion som är unik för Experience Manager Assets. Med vårt ramverk och våra komponenter kan marknadsförarna anpassa och leverera interaktiva multimedieupplevelser för alla enheter.
sub-product: dynamiska medier
feature: smart-crop, video-profiles, image-profiles, viewer-presets, vr-360, sets
topics: videos, renditions, authoring, best-practices
doc-type: feature video
audience: all
activity: use
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 9cf01dbf9461df4cc96d5bd0a96c0d4d900af089
workflow-type: tm+mt
source-wordcount: '940'
ht-degree: 0%

---


# Använda Dynamic Media med AEM Assets {#understanding-aem-dynamic-media}

Den här videoserien i flera delar ger dig en översikt över hur mediematerial hanteras och nås med Adobe Experience Manager Dynamic Media som tjänst för innehållsvisning. Med Dynamic Media kan ni hantera och publicera dynamiska digitala upplevelser - en funktion som är unik för Experience Manager Assets. Med vårt ramverk och våra komponenter kan marknadsförarna anpassa och leverera interaktiva multimedieupplevelser för alla enheter.

## Dynamisk mediaöversikt

>[!VIDEO](https://video.tv.adobe.com/v/27144/?quality=9&learn=on)

>[!NOTE]
>
>Funktionaliteten som visas här är tillgänglig med körningsläget Dynamic Media DMS7, som är det körningsläge som stöds för närvarande, inte nödvändigtvis DMHybrid, som har ersatts av DMS7.

I den här videon beskrivs hur mediematerial hanteras och nås med Adobe Experience Manager Dynamic Media som en tjänst för innehållsleverans. Dynamic Media använder en enda metod för Överordnad Asset där du överför en bildresurs eller videomaterial som kan begäras för att klara en obegränsad uppsättning förbrukningsbara variationer eller härledda återgivningar. Ingår:

* Enskild Överordnad resurs till URL-produkt som kan levereras
* Bildbearbetningsalternativ
* Alternativ för Content Viewer
* Kopiera URL:er till bilder och responsiva visningsprogram
* Variationer för smart beskärning till URL-adresser

## Dynamiska medier med AEM Sites och andra CMS-system

>[!VIDEO](https://video.tv.adobe.com/v/27145/?quality=9&learn=on)

>[!NOTE]
>
>Funktionaliteten som visas här är tillgänglig med körningsläget Dynamic Media DMS7, som är det körningsläge som stöds för närvarande, inte nödvändigtvis DMHybrid, som har ersatts av DMS7. Den här videon refererar till begrepp som beskrivs i del 1-video (Dynamic Media Overview).

I den här videon beskrivs hur mediematerial hanteras i Adobe Experience Manager Dynamic Media och kan enkelt användas i AEM Sites, med en komponent, för enkel och automatiskt beskärd för att optimera baserat på responsiv sidbredd. Skapa enkelt interaktiv bildbanderoll och generera en kopia-URL som kan användas i alla Content Management System.

* AEM Sites Dynamic Media Components flexibility
* Hämta lokalt med bildförinställningar
* Skapa och publicera interaktiv banderoll

## Dynamic Media för att skapa en blandad mediesamling och ett anpassat visningsprogram

>[!VIDEO](https://video.tv.adobe.com/v/27146/?quality=9&learn=on)

>[!NOTE]
>
>Funktionaliteten som visas här är tillgänglig med körningsläget Dynamic Media DMS7, som är det körningsläge som stöds för närvarande, inte nödvändigtvis DMHybrid, som har ersatts av DMS7. Den här videon refererar till begrepp som beskrivs i del 1-video (Dynamic Media Overview).

I den här videon beskrivs den enkla processen att skapa för en samling medieresurser i visningsprogrammet för blandade media, inklusive en snurruppsättning, video och en samling produktbilder. Lägg till innehåll i den blandade medieuppsättningen och skapa ett anpassat visningsprogram som du kan välja från i den slutliga kopiera-URL:en eller AEM Sites-komponenten.

* Skapa snurra uppsättning av lämpliga produktfoton
* Ladda upp och koda matervideo för Dynamic Media Video
* Skapa en uppsättning med blandade media från snurra, video och foton
* Redigera och använda anpassat visningsprogram för blandade media

## Dynamiska förinställningar för mediabilder

>[!VIDEO](https://video.tv.adobe.com/v/27320/?quality=9&learn=on)

I den här videon beskrivs hur bildförinställningar skapas och vad som är en bildförinställning, en URL-förkortning till en serie Image Server-argument som används på en bild när en URL begär det. Lär dig värdefulla tekniker för att utöka och redigera bildförinställningar.

* Kortkommando för bildförinställning döljer en samling med explicita Image Server-kommandon
* Använd endast en pixeldimension - bredd ELLER höjd - för att anpassa nya storleksändrade bilder utan utfyllnad
* Använd alltid skärpa
* Fältet URL-modifierare om du vill lägga till extra kommandon för att ändra storlek på bildförinställningen

## Avancerade URL-modifierare för Dynamic Media

>[!VIDEO](https://video.tv.adobe.com/v/27319/?quality=9&learn=on)

I den här videon beskrivs mer än att ändra storlek på bilder för att utnyttja funktionerna i själva källfilen - genomskinlighet i bakgrunden, inbyggda urklippsbanor och beskärningar samt text som variabler - med Dynamic Medias URL-modifierare.

* Använda URL-modifierare i fältet Dynamisk mediemodifierare
* Ändra bakgrundsfärg på bilder med genomskinlighet
* Urklipp till en bildbana
* Beskära till en bildbana
* Skapa en textmall från en Photoshop-fil

## Dynamic Media Controlling JPEG file size in Kilobytes

>[!VIDEO](https://video.tv.adobe.com/v/27404/?quality=9&learn=on)


>[!NOTE]
>
>Bildkvaliteten mäts i procent vid omvänd komprimering, där 100 % kvalitet är minst komprimerad vilket resulterar i bilder med hög kvalitet men relativt stora filstorlekar. JPEG-komprimering är ett förlustgivande komprimeringsschema där komprimeringsinställningarna bestämmer bildkvalitet och filstorlek.

Balansera jpeg-bildens kvalitet mot den resulterande filstorleken (i kilobyte) för att förbättra sidans inläsningshastighet, med 2 kommandon för att justera jpeg-komprimeringsinställningarna. QLT definierar bildkvaliteten genom att justera kvalitetsinställningarna för jpeg-komprimering. Med kommandot JPEG-storlek kan du ange vilken filstorlek som ska uppnås med komprimering.

## Lägga till CC-undertexter i Dynamic Media Video

>[!VIDEO](https://video.tv.adobe.com/v/28074/?quality=9&learn=on)

Lägg enkelt till textning i Dynamic Media-video genom att lägga till URL:en Copy så att den pekar på ett annat dokument i filen Closed Captioning, en web.VTT-fil, som innehåller CC-informationen för alla videofilmer.

## Använda bildskärpa med AEM Dynamic Media

I den här videon beskrivs varför det är viktigt att göra en bild skarpare för att bibehålla bildens återgivning och hur du använder avancerade inställningar för att skapa den perfekta bilden.

>[!VIDEO](https://demos-pub.assetsadobe.com/etc/dam/viewers/s7viewers/html5/VideoViewer.html?asset=%2Fcontent%2Fdam%2Fdm-public-facing-upgrade-portal-video%2F04_DynamicImagery_AdvancedSettings_071917_BH.mp4&amp;config=/etc/dam/presets/viewer/Video_social&amp;serverUrl=https%3A%2F%2Fadobedemo62-h.assetsadobe.com%2Fis%2Fimage%2F&amp;contenturl=%2F&amp;config2=/etc/dam/presets/analytics&amp;videoserverurl=https://gateway-na.assetsadobe.com/DMGateway/public/demoCo&amp;posterimage=/content/dam/dm-public-facing-upgrade-portal-video/04_DynamicImagery_AdvancedSettings_071917_BH.mp4)
