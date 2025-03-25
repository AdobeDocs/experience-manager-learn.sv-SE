---
title: Konfigurera panelen Investment Mix
description: Detta är en del av en självstudiekurs i flera steg för att skapa ditt första interaktiva kommunikationsdokument. I det här avsnittet kommer vi att lägga till cirkeldiagram för att visa den aktuella och modellens investeringsmix.
feature: Interactive Communication
doc-type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
discoiquuid: 77de4e76-53ee-467c-a71c-d1d3ea15283b
topic: Development
role: Developer
level: Beginner
exl-id: 774d7a6e-2b8f-4a70-98c5-e7712478ff75
duration: 69
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '336'
ht-degree: 0%

---

# Konfigurera panelen Investment Mix

I den här delen ska vi lägga till cirkeldiagram för att visa den aktuella och modellbaserade investeringsmixen.

* Logga in på AEM Forms och gå till Adobe Experience Manager > Forms > Forms &amp; Documents.

* Öppna mappen 401KStatement.

* Öppna 401KStatement i redigeringsläge.

* Vi kommer att lägga till två cirkeldiagram som representerar kontoinnehavarens aktuella och modellbaserade investeringsmix.

## Aktuell resursblandning {#current-asset-mix}

* Tryck på panelen &quot;CurrentAssetMix&quot; till höger och välj ikonen &quot;+&quot; och infoga textkomponenten. Ändra standardtexten till &quot;Aktuell resursblandning&quot;.

* Tryck på panelen &quot;CurrentAssetMix&quot; och välj ikonen &quot;+&quot; och infoga diagramkomponenten. Tryck på den nyligen infogade diagramkomponenten och klicka på ikonen &quot;skiftnyckel&quot; för att öppna diagrammets konfigurationsblad.

* Ange egenskaperna enligt bilden nedan. Se till att diagramtypen är cirkeldiagram.

* Observera datamodellobjektet som är bundet till X- och Y-axlarna. Du måste markera rotelementet i formulärdatamodellen och sedan gå ned på detaljnivå för att välja rätt element.

* ![currentassemix](assets/currentassetmixchart.png)

## Modellresursblandning {#model-asset-mix}

* Tryck på panelen &quot;RecommendedAssetMix&quot; till höger och välj ikonen &quot;+&quot; och infoga textkomponenten. Ändra standardtexten till &quot;Model Asset Mix&quot;.

* Tryck på panelen RecommendedAssetMix och välj ikonen + och infoga diagramkomponenten. Tryck på den nyligen infogade diagramkomponenten och klicka på ikonen &quot;skiftnyckel&quot; för att öppna diagrammets konfigurationsblad.

* Ange egenskaperna enligt bilden nedan. Se till att diagramtypen är cirkeldiagram.

* Observera datamodellobjektet som är bundet till X- och Y-axlarna. Du måste markera rotelementet i formulärdatamodellen och sedan gå ned på detaljnivå för att välja rätt element.

* ![assettype](assets/modelassettypechart.png)

## Nästa steg

[Förbered för att leverera webbkanalsdokument](./parttwelve.md)
