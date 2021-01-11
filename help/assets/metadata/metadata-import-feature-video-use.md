---
title: Använda import och export av metadata i AEM Assets
description: Tack vare import- och exportfunktionerna för AEM Assets-metadata kan skribenterna enkelt flytta metadata i och från AEM och dra nytta av kraften i Microsoft Excel för att hantera metadata i stor skala, vilket underlättar uppdateringen av metadata för befintligt material i AEM.
topics: metadata
audience: all
doc-type: feature video
activity: use
kt: 647
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 2c0818d0223a3db55e6407068f4802b9e7f7dd83
workflow-type: tm+mt
source-wordcount: '256'
ht-degree: 2%

---


# Använda import och export av metadata i AEM Assets{#using-metadata-import-and-export-in-aem-assets}

Tack vare import- och exportfunktionerna för AEM Assets-metadata kan skribenterna enkelt flytta metadata i och från AEM och dra nytta av kraften i Microsoft Excel för att hantera metadata i stor skala, vilket underlättar uppdateringen av metadata för befintligt material i AEM.

## Export av metadata {#metadata-export}

>[!VIDEO](https://video.tv.adobe.com/v/22132/?quality=9&learn=on)

## Import av metadata {#metadata-import}

>[!VIDEO](https://video.tv.adobe.com/v/21374/?quality=9&learn=on)

Ladda ned [Sportmappen WeRetail](assets/we-retail-sports.zip)

Hämta [metadatapaket för resurs](assets/we-retail-sports-asset-metadata.zip)

## Metadatafilformat {#metadata-file-format}

### CSV-filformat

#### Första raden

* Den första raden i CSV-filen definierar metadataschemat.
* Den första kolumnen är som standard `assetPath`, som innehåller den absoluta JCR-sökvägen för en resurs.

* Efterföljande kolumner i den första raden pekar på andra metadataegenskaper för en resurs.

   * Till exempel : `dc:title, dc:description, jcr:title`

* Egenskapsformat för ett värde

   * `<metadata property name> {{<property type}}`
   * Om ingen egenskapstyp anges används String som standard.
   * Till exempel: `dc:title {{String}}`

* Egenskapsnamnet är skiftlägeskänsligt
   * Rätt : `dc:title {{String}}`
   * Felaktigt: `Dc:Title {{String}}`

* Egenskapstypen är inte skiftlägeskänslig
* Alla giltiga [JCR-egenskapstyper](https://docs.adobe.com/docs/en/spec/jsr170/javadocs/jcr-2.0/javax/jcr/PropertyType.html) stöds

* Egenskapsformat för flera värden - `<metadata property name> {{<property type : MULTI }}`

#### Andra raden till N-rader

* Den första kolumnen innehåller den absoluta JCR-sökvägen för en resurs. Till exempel: /content/dam/asset1.jpg
* Metadataegenskapen för en resurs kan sakna värden i CSV-filen. Metadataegenskap som saknas för den aktuella resursen uppdateras inte.
