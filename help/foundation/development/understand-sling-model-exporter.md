---
title: Förstå Sling Model Exporter i AEM
description: I Apache Sling Models 1.3.0 introduceras Sling Model Exporter, ett elegant sätt att exportera eller serialisera Sling Model-objekt till anpassade abstraktioner. I den här artikeln beskrivs det traditionella sättet att använda Sling-modeller för att fylla i HTML-skript, med hjälp av Sling Model Exporter-ramverket för att serialisera en Sling-modell till JSON.
version: 6.4, 6.5
sub-product: Experience Manager, Experience Manager Sites
feature: APIs
doc-type: Article
topic: Development
role: Developer
level: Beginner
exl-id: 03cdf5d1-3253-44c9-ae1f-ec5d3c562427
duration: 133
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '568'
ht-degree: 0%

---

# Förstå [!DNL Sling Model Exporter]

Apache [!DNL Sling Models] 1.3.0 introducerar [!DNL Sling Model Exporter], ett elegant sätt att exportera eller serialisera [!DNL Sling Model] till egna abstraktioner. I den här artikeln beskrivs det traditionella sättet att använda [!DNL Sling Models] för att fylla i HTML-skript med [!DNL Sling Model Exporter] för att serialisera [!DNL Sling Model] till JSON.

## Traditionellt HTTP-begäranflöde för segmenteringsmodell

Traditionell användning för [!DNL Sling Models] är att tillhandahålla en affärabstraktion för en resurs eller begäran som tillhandahåller HTML-skript (eller tidigare JSP-skript) ett gränssnitt för att komma åt affärsfunktioner.

Vanliga mönster utvecklas [!DNL Sling Models] som representerar AEM komponenter eller sidor och använder [!DNL Sling Model] -objekt som matar in HTML-skript med data, med slutresultatet HTML som visas i webbläsaren.

### Sling Model - flöde för HTTP-begäran

![Förfrågningsflöde för segmenteringsmodell](./assets/understand-sling-model-exporter/sling-model-request-flow.png)

1. [!DNL HTTP GET] Begäran görs för en resurs i AEM.

   Exempel: `HTTP GET /content/my-resource.html`

1. Baserat på begäranderesursens `sling:resourceType`, är rätt skript löst.

1. Skriptet anpassar begäran eller resursen till det önskade [!DNL Sling Model].

1. Skriptet använder [!DNL Sling Model] objekt för att skapa återgivningen av HTML.

1. HTML som genereras av skriptet returneras i HTTP-svaret.

Detta traditionella mönster fungerar bra när det gäller att generera HTML och [!DNL Sling Model] kan enkelt utnyttjas via HTML. Att skapa mer strukturerade data som JSON eller XML är en mycket mer tidsödande strävan, eftersom HTML inte naturligtvis passar in på definitionen av dessa format.

## [!DNL Sling Model Exporter] HTTP-begärandeflöde

Apache [!DNL Sling Model Exporter] levereras med en Sling-medföljande Jackson Exporter som automatiskt serialiserar en&quot;vanlig&quot; [!DNL Sling Model] till JSON. Jackson Exporter är ganska konfigurerbar, men vid kärnan kontrolleras [!DNL Sling Model] och genererar JSON med någon&quot;getter&quot;-metod som JSON-tangenter, och get-tangenten returnerar värden som JSON-värden.

Direkt serialisering av [!DNL Sling Models] gör att de kan hantera både vanliga webbförfrågningar med HTML-svar som skapats med [!DNL Sling Model] begäranflöde (se ovan), men visar också JSON-renderingar som kan användas av webbtjänster eller JavaScript-program.

![Sling Model Exporter - flöde för HTTP-begäran](./assets/understand-sling-model-exporter/sling-model-exporter-request-flow.png)

*Det här flödet beskriver flödet med angivet Jackson Exporter för att skapa JSON-utdata. Användning av anpassade exporterare följer samma flöde men med deras utdataformat.*

1. HTTP-GET-begäran görs för en resurs i AEM med väljaren och tillägget som är registrerat med [!DNL Sling Model]Vi exporterar.

   Exempel: `HTTP GET /content/my-resource.model.json`

1. Sling löser den begärda resursens `sling:resourceType`, väljare och tillägg till en dynamiskt genererad Sling Exporter-server som mappas till [!DNL Sling Model] med Exporter.
1. Den matchade Sling Exporter-servertypen anropar [!DNL Sling Model Exporter] mot [!DNL Sling Model] objekt anpassat från begäran eller resursen (enligt Sling Models adaptables).
1. Exportören serialiserar [!DNL Sling Model] baserat på Exporter Options och Exporter-specific Sling Model annotations och returnerar resultatet till Sling Exporter Servlet.
1. Sling Exporter-servern returnerar JSON-återgivningen av [!DNL Sling Model] i HTTP-svaret.

>[!NOTE]
>
>Apache Sling-projektet tillhandahåller Jackson Exporter som serialiserar [!DNL Sling Models] till JSON, Exporter-ramverket har också stöd för anpassade exporterare. Ett projekt kan till exempel implementera en anpassad exportör som serialiserar en [!DNL Sling Model] till XML.

>[!NOTE]
>
>Inte bara [!DNL Sling Model Exporter] *serialisera* [!DNL Sling Models]kan de också exporteras som Java-objekt. Exporten till andra Java-objekt spelar ingen roll i flödet för HTTP-begäran och visas därför inte i diagrammet ovan.

## Stödmaterial

* [Apache [!DNL Sling Model Exporter] Ramdokumentation](https://sling.apache.org/documentation/bundles/models.html#exporter-framework-since-130)
