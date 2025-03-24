---
title: Förstå Sling Model Exporter i AEM
description: I Apache Sling Models 1.3.0 introduceras Sling Model Exporter, ett elegant sätt att exportera eller serialisera Sling Model-objekt till anpassade abstraktioner. I den här artikeln beskrivs det traditionella sättet att använda Sling-modeller för att fylla i HTML-skript, med hjälp av Sling Model Exporter-ramverket för att serialisera en Sling-modell till JSON.
version: Experience Manager 6.4, Experience Manager 6.5
sub-product: Experience Manager, Experience Manager Sites
feature: APIs
doc-type: Article
topic: Development
role: Developer
level: Beginner
exl-id: 03cdf5d1-3253-44c9-ae1f-ec5d3c562427
duration: 133
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '568'
ht-degree: 0%

---

# Förstå [!DNL Sling Model Exporter]

Apache [!DNL Sling Models] 1.3.0 introducerar [!DNL Sling Model Exporter], ett elegant sätt att exportera eller serialisera [!DNL Sling Model] objekt till anpassade abstraktioner. I den här artikeln beskrivs det traditionella användningsfallet för [!DNL Sling Models] för att fylla i HTML-skript, med användning av [!DNL Sling Model Exporter]-ramverket för att serialisera [!DNL Sling Model] till JSON.

## Traditionellt HTTP-begäranflöde för segmenteringsmodell

Traditionellt användningsfall för [!DNL Sling Models] är att tillhandahålla en affärsabstraktion för en resurs eller begäran, som tillhandahåller HTML-skript (eller tidigare JSP-skript) som ett gränssnitt för åtkomst till affärsfunktioner.

Vanliga mönster utvecklar [!DNL Sling Models] som representerar AEM-komponenter eller -sidor och använder [!DNL Sling Model]-objekten för att mata in HTML-skripten med data, med slutresultatet för HTML som visas i webbläsaren.

### Sling Model - flöde för HTTP-begäran

![Förfrågningsflöde för segmenteringsmodell](./assets/understand-sling-model-exporter/sling-model-request-flow.png)

1. [!DNL HTTP GET]-begäran görs för en resurs i AEM.

   Exempel: `HTTP GET /content/my-resource.html`

1. Beroende på begäranderesursens `sling:resourceType` har rätt skript lösts.

1. Skriptet anpassar begäran eller resursen till önskad [!DNL Sling Model].

1. Skriptet använder objektet [!DNL Sling Model] för att generera HTML-återgivningen.

1. Den HTML som genereras av skriptet returneras i HTTP-svaret.

Det här traditionella mönstret fungerar bra när du genererar HTML eftersom [!DNL Sling Model] enkelt kan utnyttjas via HTML. Att skapa mer strukturerade data som JSON eller XML är en mycket mer tidsödande strävan, eftersom HTML inte naturligtvis passar in på definitionen av dessa format.

## [!DNL Sling Model Exporter] HTTP-begäranflöde

Apache [!DNL Sling Model Exporter] levereras med en Sling som tillhandahålls av Jackson Exporter som automatiskt serialiserar ett &quot;normalt&quot; [!DNL Sling Model] -objekt till JSON. Jackson Exporter, som är ganska konfigurerbar, inspekterar objektet [!DNL Sling Model] i sin kärna och genererar JSON med hjälp av någon &quot;getter&quot;-metod som JSON-nycklar, och get-metoden returnerar värden som JSON-värden.

Med den direkta serialiseringen av [!DNL Sling Models] kan de hantera båda vanliga webbförfrågningar med sina HTML-svar som skapats med det traditionella [!DNL Sling Model]-begäranflödet (se ovan), men även visa JSON-återgivningar som kan användas av webbtjänster eller JavaScript-program.

![Sling Model Exporter HTTP Request flow](./assets/understand-sling-model-exporter/sling-model-exporter-request-flow.png)

*Det här flödet beskriver flödet med den angivna Jackson Exporter för att skapa JSON-utdata. Användning av anpassade exporterare följer samma flöde men med deras utdataformat.*

1. HTTP GET-begäran görs för en resurs i AEM med väljaren och tillägget som är registrerat hos [!DNL Sling Model]s exportör.

   Exempel: `HTTP GET /content/my-resource.model.json`

1. Sling löser den begärda resursens `sling:resourceType`, väljare och tillägg till en dynamiskt genererad Sling Exporter-server, som mappas till [!DNL Sling Model] med Exporter.
1. Den matchade Sling Exporter-servertypen anropar [!DNL Sling Model Exporter] mot objektet [!DNL Sling Model] som är anpassat från begäran eller resursen (enligt Sling Models-adaptables).
1. Exportören serialiserar [!DNL Sling Model] baserat på Exporter Options och Exporter-specifika Sling Model-anteckningar och returnerar resultatet till Sling Exporter Servlet.
1. Sling Exporter-servern returnerar JSON-återgivningen av [!DNL Sling Model] i HTTP-svaret.

>[!NOTE]
>
>Apache Sling-projektet tillhandahåller Jackson Exporter som serialiserar [!DNL Sling Models] till JSON, men Exporter-ramverket har även stöd för anpassade exporterare. Ett projekt kan till exempel implementera en anpassad exportör som serialiserar en [!DNL Sling Model] till XML.

>[!NOTE]
>
>Det är inte bara [!DNL Sling Model Exporter] *serialize* [!DNL Sling Models] som kan exporteras som Java-objekt. Exporten till andra Java-objekt spelar ingen roll i flödet för HTTP-begäran och visas därför inte i diagrammet ovan.

## Stödmaterial

* [Apache [!DNL Sling Model Exporter] Framework-dokumentation](https://sling.apache.org/documentation/bundles/models.html#exporter-framework-since-130)
