---
title: Förstå Sling Model Exporter i AEM
description: I Apache Sling Models 1.3.0 introduceras Sling Model Exporter, ett elegant sätt att exportera eller serialisera Sling Model-objekt till anpassade abstraktioner. I den här artikeln beskrivs det traditionella sättet att använda Sling-modeller för att fylla i HTML-skript, med hjälp av Sling Model Exporter-ramverket för att serialisera en Sling-modell till JSON.
version: 6.3, 6.4, 6.5
sub-product: grund, innehållstjänster
feature: API:er
topics: development, content-delivery, headless
activity: understand
audience: developer, architect
doc-type: article
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '575'
ht-degree: 0%

---


# Förstå [!DNL Sling Model Exporter]

Apache [!DNL Sling Models] 1.3.0 introducerar [!DNL Sling Model Exporter], ett elegant sätt att exportera eller serialisera [!DNL Sling Model]-objekt till anpassade abstraktioner. I den här artikeln beskrivs det traditionella användningsfallet med [!DNL Sling Models] för att fylla i HTML-skript, med användning av [!DNL Sling Model Exporter]-ramverket för att serialisera en [!DNL Sling Model] till JSON.

## Traditionellt HTTP-begäranflöde för segmenteringsmodell

Traditionellt användningsfall för [!DNL Sling Models] är att tillhandahålla en affärsabstraktion för en resurs eller begäran, som tillhandahåller HTML-skript (eller tidigare JSP-skript) som ett gränssnitt för att komma åt affärsfunktioner.

Vanliga mönster utvecklar [!DNL Sling Models] som representerar AEM komponenter eller sidor och använder [!DNL Sling Model]-objekten för att mata in HTML-skripten med data, med slutresultatet för HTML som visas i webbläsaren.

### Sling Model - flöde för HTTP-begäran

![Förfrågningsflöde för segmenteringsmodell](./assets/understand-sling-model-exporter/sling-model-request-flow.png)

1. [!DNL HTTP GET] Begäran görs för en resurs i AEM.

   Exempel: `HTTP GET /content/my-resource.html`

1. Beroende på den begärda resursens `sling:resourceType` är rätt skript löst.

1. Skriptet anpassar begäran eller resursen till önskad [!DNL Sling Model].

1. Skriptet använder objektet [!DNL Sling Model] för att generera HTML-återgivningen.

1. Den HTML som genereras av skriptet returneras i HTTP-svaret.

Det här traditionella mönstret fungerar bra när du genererar HTML eftersom [!DNL Sling Model] enkelt kan utnyttjas via HTML. Att skapa mer strukturerade data som t.ex. JSON eller XML är en mycket mer tidsödande strävan, eftersom HTML inte naturligtvis passar in på definitionen av dessa format.

## [!DNL Sling Model Exporter] HTTP-begärandeflöde

Apache [!DNL Sling Model Exporter] har en Sling-medföljande Jackson Exporter som automatiskt serialiserar ett &quot;normal&quot; [!DNL Sling Model]-objekt till JSON. Jackson Exporter, som är ganska konfigurerbar, undersöker i sin kärna objektet [!DNL Sling Model] och genererar JSON med hjälp av&quot;getter&quot;-metoder som JSON-nycklar, och get-metoden returnerar värden som JSON-värden.

Med den direkta serialiseringen av [!DNL Sling Models] kan de hantera båda vanliga webbförfrågningar med sina HTML-svar som skapats med det traditionella [!DNL Sling Model]-frågeflödet (se ovan), men också visa JSON-återgivningar som kan användas av webbtjänster eller JavaScript-program.

![Sling Model Exporter - flöde för HTTP-begäran](./assets/understand-sling-model-exporter/sling-model-exporter-request-flow.png)

*Det här flödet beskriver flödet med angivet Jackson Exporter för att skapa JSON-utdata. Användning av anpassade exporterare följer samma flöde men med deras utdataformat.*

1. Begäran om HTTP-GET görs för en resurs i AEM med väljaren och tillägget som är registrerade med exporteraren för [!DNL Sling Model].

   Exempel: `HTTP GET /content/my-resource.model.json`

1. Sling löser den begärda resursens `sling:resourceType`, väljare och tillägg till en dynamiskt genererad Sling Exporter-server, som mappas till [!DNL Sling Model] med Exporter.
1. Den matchade Sling Exporter Servlet anropar [!DNL Sling Model Exporter] mot [!DNL Sling Model]-objektet som är anpassat från begäran eller resursen (enligt Sling Models adaptables).
1. Exportören serialiserar [!DNL Sling Model] baserat på Exporter Options och Exporter-specifika Sling Model annotations och returnerar resultatet till Sling Exporter Servlet.
1. Sling Exporter-servern returnerar JSON-återgivningen av [!DNL Sling Model] i HTTP-svaret.

>[!NOTE]
>
>Apache Sling-projektet ger Jackson Exporter som serialiserar [!DNL Sling Models] till JSON, men Exporter-ramverket har också stöd för anpassade exporterare. Ett projekt kan till exempel implementera en anpassad exporterare som serialiserar en [!DNL Sling Model] till XML.

>[!NOTE]
>
>Det är inte bara [!DNL Sling Model Exporter] *serialisera* [!DNL Sling Models] som kan exporteras som Java-objekt. Exporten till andra Java-objekt spelar ingen roll i flödet för HTTP-begäran och visas därför inte i diagrammet ovan.

## Stödmaterial

* [ [!DNL Sling Model Exporter] ApacheFramework-dokumentation](https://sling.apache.org/documentation/bundles/models.html#exporter-framework-since-130)
