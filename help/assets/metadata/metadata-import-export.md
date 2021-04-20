---
title: Använda import och export av metadata i AEM Assets
description: Lär dig hur du använder metadatafunktionerna för import och export i Adobe Experience Manager Assets. Tack vare import- och exportfunktionerna kan innehållsförfattare uppdatera metadata för befintliga resurser gruppvis.
version: 6.3, 6.4, 6.5, cloud-service
topic: Content Management
feature: Metadata
role: Admin
level: Intermediate
kt: 647, 917
thumbnail: 22132.jpg
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '265'
ht-degree: 2%

---


# Använda import och export av metadata i AEM Assets {#metadata-import-and-export}

Lär dig hur du använder metadatafunktionerna för import och export i Adobe Experience Manager Assets. Tack vare import- och exportfunktionerna kan innehållsförfattare uppdatera metadata för befintliga resurser gruppvis.

## Export av metadata {#metadata-export}

>[!VIDEO](https://video.tv.adobe.com/v/22132/?quality=12&learn=on)

## Import av metadata {#metadata-import}

>[!VIDEO](https://video.tv.adobe.com/v/21374/?quality=12&learn=on)

>[!NOTE]
>
> När du förbereder en CSV-fil för import är det enklare att generera en CSV-fil med resurslistan med hjälp av funktionen för export av metadata. Du kan sedan ändra den genererade CSV-filen och importera den med importfunktionen.

## CSV-filformat för metadata {#metadata-file-format}

### Första raden

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

### Andra raden till N-rader

* Den första kolumnen innehåller den absoluta JCR-sökvägen för en resurs. Till exempel: /content/dam/asset1.jpg
* Metadataegenskapen för en resurs kan sakna värden i CSV-filen. Metadataegenskaper som saknas för den aktuella resursen uppdateras inte.
