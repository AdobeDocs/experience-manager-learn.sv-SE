---
title: Dynamic Media för genomskinlighet och batchbearbetning av innehållsautomatisering
description: Lär dig hur du använder Dynamic Media i AEM för att skapa virtuella renderingar, hantera genomskinlighet och automatisera bildbearbetning för återanvändning av skalbart innehåll.
feature: Image Profiles, Viewer Presets
topic: Content Management
role: User
level: Beginner, Intermediate, Experienced
doc-type: Feature Video
duration: 542
last-substantial-update: 2025-05-28T00:00:00Z
jira: KT-18197
source-git-commit: 2ffe4706856f0dbf63f2916af010f23bdb7b0045
workflow-type: tm+mt
source-wordcount: '262'
ht-degree: 0%

---


# Dynamic Media för genomskinlighet och batchbearbetning av innehållsautomatisering

Lär dig hur du använder Dynamic Media i AEM för att skapa virtuella renderingar, hantera genomskinlighet och automatisera bildbearbetning för återanvändning av skalbart innehåll.

>[!VIDEO](https://video.tv.adobe.com/v/3459589/?learn=on&enablevpops)


## Exempel på dynamiska medieresurser

Följande är exempel på Dynamic Media-resurser och deras URL:er som används i videon.

>[!BEGINTABS]

>[!TAB Exempel på bildgenomskinlighet]

Här följer exempel-URL:er för Dynamic Media Image Server som används i videon.

| Förhandsgranska | Beskrivning | Dynamisk medie-URL |
|-----------|------------------|---------|
| ![Standard](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20trans?bgc=255,255,255){width="250"} | Standard | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20trans?bgc=255,255,255) |
| ![Sammansatt med sömlöst bakgrundsbildlager](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20trans?&amp;layer=1&amp;src=backdrop5-Camera&amp;size=8500,8500&amp;layer=2&amp;src=AdobeStock_322150086%20trans){width="250"} | Sammansatt med sömlöst bakgrundsbildlager | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20trans?&amp;layer=1&amp;src=backdrop5-Camera&amp;size=8500,8500&amp;layer=2&amp;src=AdobeStock_322150086%20trans) |
| ![Röd bakgrund](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20trans?&amp;layer=1&amp;color=200,50,50&amp;size=8500,8500&amp;layer=2&amp;src=AdobeStock_322150086%20trans){width="250"} | Röd bakgrund | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20trans?&amp;layer=1&amp;color=200,50,50&amp;size=8500,8500&amp;layer=2&amp;src=AdobeStock_322150086%20trans) |
| ![Urklippt till ovalbana](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=round&amp;bgc=255,255,255){width="250"} | Urklippt till ovalbana | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=round&amp;bgc=255,255,255) |


>[!TAB Exempel på bildbanor]

Här följer exempel-URL:er för Dynamic Media Image Server som används i videon.

| Förhandsgranska | Beskrivning | Dynamisk medie-URL |
|-----------|------------------|---------|
| ![Normaliserat till 80 pixlar brett (ingen genomskinlighet)](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?wid=800){width="250"} | Normaliserat till 80 pixlar brett (ingen genomskinlighet) {width="250"} | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?wid=800) |
| ![Beskär till bana](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?cropPathE=Path%201&amp;wid=800){width="250"} | Beskär till bana | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?cropPathE=Path%201&amp;wid=800) |
| ![Klipp till bana](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=Path%201&amp;wid=800){width="250"} | Beskär till bana | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=Path%201&amp;wid=800) |
| ![Beskär till bana och Beskär till bana](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=Path%201&amp;cropPathE=Path%201&amp;wid=800){width="250"} | Beskär till bana och Beskär till bana | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=Path%201&amp;cropPathE=Path%201&amp;wid=800) |
| ![Klipp till en annan bana](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=round&amp;wid=800){width="250"} | Klipp ut till en annan bana | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086%20paths?clipPathE=round&amp;wid=800) |
| ![Klipp ut till en annan bana och skapa röd bakgrund](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086fullpaths?cropPathE=round&amp;clipPathE=round&amp;bgc=200,50,50&amp;wid=800){width="250"} | Klipp ut till en annan bana och skapa röd bakgrund | [Länk](https://smartimaging.scene7.com/is/image/DynamicMediaNA/AdobeStock_322150086fullpaths?cropPathE=round&amp;clipPathE=round&amp;bgc=200,50,50&amp;wid=800) |

>[!ENDTABS]


## API:er för Dynamic Media Image Server

* [API för dynamisk mediabildserver och återgivning](https://experienceleague.adobe.com/sv/docs/dynamic-media-developer-resources/image-serving-api/image-serving-api/http-protocol-reference/c-http-protocol-reference)
* [Förhandsvisning av dynamisk ögonblicksbild av media](https://snapshot.scene7.com/)