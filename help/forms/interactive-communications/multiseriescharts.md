---
title: Diagram för flera serier i AEM Forms
seo-title: Diagram för flera serier i AEM Forms
description: Skapa en lämplig formulärdatamodell för att skapa diagram i flera serier i utskrifts- och webbkanalsdokument.
seo-description: Skapa en lämplig formulärdatamodell för att skapa diagram i flera serier i utskrifts- och webbkanalsdokument.
feature: Interaktiv kommunikation
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.5
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '306'
ht-degree: 0%

---


# Diagram för flera serier

I AEM Forms 6.5 fanns möjligheten att skapa och konfigurera diagram för flera serier. Diagrammen för flera serier används vanligtvis tillsammans med diagramtypen Line, Bar och Column. Följande diagram är ett bra exempel på diagram med flera serier. Diagrammet visar tillväxten på 10 000 USD i tre olika gemensamma fonder under en tidsperiod. För att kunna skapa och använda diagram av den här typen i AEM Forms måste du skapa en lämplig formulärdatamodell.

![multiserie](assets/seriescharts.jfif)

Om du vill skapa diagram i flera serier i AEM Forms måste du skapa en lämplig formulärdatamodell med nödvändiga entiteter och associationer mellan entiteterna. Följande skärmbild visar enheterna och associationerna mellan de tre entiteterna. På den översta nivån har vi en enhet som heter&quot;Organisation&quot;, som har en en-till-många-association med fondenheten. Fondenheten har i sin tur en-till-många-association med resultatenheten.

![formdatamodell](assets/formdatamodel.jfif)


## Skapa formulärdatamodell för diagram i flera serier

>[!VIDEO](https://video.tv.adobe.com/v/26352/quality=9)


### Konfigurera linjeseriediagram

>[!VIDEO](https://video.tv.adobe.com/v/26353?quality=9&learn=on)


Följ de här stegen för att testa detta på datorn

* [Hämta och importera filen MutualFundFactSheet.zip med AEM Package Manager.](assets/mutualfundfactsheet.zip)
* [Ladda ned SeriesChartSampleData.json till hårddisken.](assets/serieschartsampledata.json) Detta är exempeldata som ska användas för att fylla i diagrammet.
* [Navigera till Forms och Dokument.](https://helpx.adobe.com/aem/forms.html/content/dam/formsanddocuments.html)
* Välj försiktigt den interaktiva kommunikationsmallen &quot;MutualFundGrowthFactSheet&quot;.
* Klicka på Förhandsgranska | Överför exempeldata.
* Bläddra till exempeldatafilen som ingår i den här artikeln.
* Förhandsgranska tryckkanalen för den interaktiva kommunikationen &quot;MutualFundGrowthFactSheet&quot; med exempeldata som hämtades i föregående steg.
