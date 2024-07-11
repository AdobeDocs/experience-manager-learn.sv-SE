---
title: Använda import och export av metadata i AEM Assets
description: Lär dig hur du använder metadatafunktionerna för import och export i Adobe Experience Manager Assets. Tack vare import- och exportfunktionerna kan innehållsförfattare uppdatera metadata för befintliga resurser gruppvis.
version: 6.4, 6.5, Cloud Service
topic: Content Management
feature: Metadata
role: Admin
level: Intermediate
kt: 647, 917
thumbnail: 22132.jpg
last-substantial-update: 2022-06-13T00:00:00Z
doc-type: Feature Video
exl-id: 0681e2c4-8661-436c-9170-9aa841a6fa27
duration: 419
source-git-commit: 726715890d997ba3bb85f4833e220ac2222b3a42
workflow-type: tm+mt
source-wordcount: '378'
ht-degree: 0%

---

# Använda import och export av metadata i AEM Assets {#metadata-import-and-export}

Lär dig hur du använder metadatafunktionerna för import och export i Adobe Experience Manager Assets. Tack vare import- och exportfunktionerna kan innehållsförfattare uppdatera metadata för befintliga resurser gruppvis.

## Export av metadata {#metadata-export}

>[!VIDEO](https://video.tv.adobe.com/v/22132?quality=12&learn=on)

>[!TIP]
>
> När du öppnar en CSV-fil för export av metadata i Excel använder du [Excel-import](https://support.microsoft.com/en-us/office/import-data-from-a-csv-html-or-text-file-b62efe49-4d5b-4429-b788-e1211b5e90f6) i stället för att dubbelklicka på filen för att undvika problem med UTF-8-kodade CSV-filer.
>
> Så här öppnar du CSV-filen för metadataexport i Excel:
> 
> 1. Öppna Microsoft Excel
> 1. Välj __Arkiv > Nytt__ skapa ett tomt kalkylblad
> 1. Öppna det tomma kalkylbladet och markera __Arkiv > Importera__
> 1. Välj __Text__ och klicka på __Importera__
> 1. Markera den exporterade CSV-filen i filsystemet och klicka på __Hämta data__
> 1. I steg 1 i importguiden väljer du __Avgränsad__ och ange __Filens ursprung__ till __Unicode (UTF-8)__ och klicka __Nästa__
> 1. I steg 2 anger du __Avgränsare__ till __Komma__ och klicka __Nästa__
> 1. I steg 3 lämnar du __Kolumndataformat__ som det är och klicka __Slutför__
> 1. Välj __Importera__ för att lägga till data i kalkylblad

## Import av metadata {#metadata-import}

>[!VIDEO](https://video.tv.adobe.com/v/21374?quality=12&learn=on)

>[!NOTE]
>
> När du förbereder en CSV-fil för import är det enklare att generera en CSV-fil med resurslistan med hjälp av funktionen för export av metadata. Du kan sedan ändra den genererade CSV-filen och importera den med hjälp av importfunktionen.

## CSV-filformat för metadata {#metadata-file-format}

### Första raden

* Den första raden i CSV-filen definierar metadataschemat.
* Den första kolumnen är som standard `assetPath`, som innehåller den absoluta JCR-sökvägen för en resurs.

* Efterföljande kolumner i den första raden pekar på andra metadataegenskaper för en resurs.
   * Till exempel: `dc:title, dc:description, jcr:title`

* Egenskapsformat för ett värde

   * `<metadata property name> {{<property type}}`
   * Om ingen egenskapstyp anges används String som standard.
   * Till exempel: `dc:title {{String}}`

* Egenskapsnamnet är skiftlägeskänsligt
   * Korrekt: `dc:title {{String}}`
   * Felaktigt: `Dc:Title {{String}}`

* Egenskapstypen är skiftlägesokänslig
* Alla giltiga [JCR-egenskapstyper](https://www.adobe.io/experience-manager/reference-materials/spec/jsr170/javadocs/jcr-2.0/javax/jcr/PropertyType.html) stöds

* Egenskapsformat för flera värden - `<metadata property name> {{<property type : MULTI }}`

### Andra raden till N-rader

* Den första kolumnen innehåller den absoluta JCR-sökvägen för en resurs. Till exempel: /content/dam/asset1.jpg
* Metadataegenskapen för en resurs kan sakna värden i CSV-filen. Metadataegenskaper som saknas för den aktuella resursen uppdateras inte.
