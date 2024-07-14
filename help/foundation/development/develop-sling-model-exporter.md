---
title: Utveckla export av försäljningsmodeller i AEM
description: Den här tekniska genomgången går igenom hur du ställer in AEM för Sling Model Exporter, förbättrar en befintlig Sling Model med hjälp av exportramverket för att rendera som JSON, och hur du använder Exporter-alternativ och Jackson-anteckningar för att anpassa utdata ytterligare.
version: 6.4, 6.5
sub-product: Experience Manager, Experience Manager Sites
feature: APIs
doc-type: Technical Video
topic: Development
role: Developer
level: Intermediate
exl-id: fc321ed1-5cf7-4bbe-adc6-c4905af7b43c
duration: 932
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '363'
ht-degree: 0%

---

# Utveckla export av försäljningsmodeller

Den här tekniska genomgången går igenom hur du ställer in AEM för Sling Model Exporter, förbättrar en befintlig Sling Model med hjälp av exportramverket för att rendera som JSON, och hur du använder Exporter-alternativ och Jackson-anteckningar för att anpassa utdata ytterligare.

Exporteraren för försäljningsmodell introducerades i Sling Models v1.3.0. Med den här nya funktionen kan nya anteckningar läggas till i Sling-modeller som definierar hur modellen kan exporteras som ett annat Java-objekt, eller mer allmänt, serialiseras till ett annat format, till exempel JSON.

Apache Sling erbjuder en Jackson JSON-exportör som täcker det vanligaste sättet att exportera Sling Models som JSON-objekt för programmatiska webbkonsumenter som andra webbtjänster och JavaScript-program.

## Konfigurera AEM för Sling Model Exporter

>[!VIDEO](https://video.tv.adobe.com/v/16862?quality=12&learn=on)

[!DNL Sling Model Exporter] är en funktion i [!DNL Apache Sling]-projektet och är inte direkt bunden till AEM produktlanseringscykel. [!DNL Sling Model Exporter] är kompatibelt med AEM 6.3 och senare.

## Användningsfall för [!DNL Sling Model Exporter]

>[!VIDEO](https://video.tv.adobe.com/v/16863?quality=12&learn=on)

[!DNL Sling Model Exporter] är perfekt för att utnyttja Sling-modeller som redan innehåller affärslogik som stöder HTML-återgivningar via HTML (eller tidigare JSP) och som visar samma företagsrepresentation som JSON för användning via programmatiska webbtjänster eller JavaScript-program.

## Skapa en export av en segmenteringsmodell

>[!VIDEO](https://video.tv.adobe.com/v/16864?quality=12&learn=on)

Det är lika enkelt att aktivera [!DNL Exporter]-stöd för en [!DNL Sling Model] som att lägga till `@Exporter`-anteckningen i Java-klassen.

## Använda exportalternativ för delningsmodell

>[!VIDEO](https://video.tv.adobe.com/v/16865?quality=12&learn=on)

[!DNL Sling Model Exporter] stöder överföring av exportalternativ per modell till exportörimplementeringen för att styra hur [!DNL Sling Model] slutligen exporteras. De här alternativen gäller vanligtvis &quot;globalt&quot; för hur [!DNL Sling Model] exporteras, jämfört med per datapunkt, vilket kan göras via textbundna anteckningar som beskrivs nedan.

[!DNL Jackson Exporter] alternativ omfattar:

* [Alternativ för mappningsfunktioner](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/MapperFeature.html)
* [Alternativ för serialiseringsfunktioner](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/SerializationFeature.html)

## Tillämpar [!DNL Jackson] anteckningar

>[!VIDEO](https://video.tv.adobe.com/v/16866?quality=12&learn=on)

Exportörimplementeringar kan också ha stöd för anteckningar som kan användas infogat i klassen [!DNL Sling Model], som ger en bättre kontrollnivå för hur data exporteras.

* [[!DNL Jackson Exporter] anteckningar](https://github.com/FasterXML/jackson-annotations/wiki/Jackson-Annotations)

## Visa koden {#view-the-code}

[SampleSlingModelExporter.java](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/master/core/src/main/java/com/adobe/acs/samples/models/SampleSlingModelExporter.java)

## Stödmaterial {#supporting-materials}

* [[!DNL Jackson Mapper] Feature Javadoc](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/MapperFeature.html)
* [[!DNL Jackson Serialization] Feature Javadoc](https://static.javadoc.io/com.fasterxml.jackson.core/jackson-databind/2.8.5/com/fasterxml/jackson/databind/SerializationFeature.html)

* [[!DNL Jackson Annotations] Dokument](https://github.com/FasterXML/jackson-annotations/wiki/Jackson-Annotations)
