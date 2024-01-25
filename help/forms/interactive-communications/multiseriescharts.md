---
title: Diagram för flera serier i AEM Forms
description: Skapa en lämplig formulärdatamodell för att skapa diagram i flera serier i dokument för tryck och webbkanaler.
feature: Interactive Communication
doc-type: article
version: 6.5
topic: Development
role: Developer
level: Beginner
exl-id: f4af7cb9-cc3b-4bec-9428-ab4f1a3cf41a
last-substantial-update: 2019-07-07T00:00:00Z
duration: 437
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '279'
ht-degree: 0%

---

# Diagram för flera serier

I AEM Forms 6.5 fanns möjligheten att skapa och konfigurera diagram för flera serier. Diagrammen för flera serier används vanligtvis tillsammans med diagramtypen Line, Bar och Column. Följande diagram är ett bra exempel på diagram med flera serier. Diagrammet visar tillväxten på 10 000 USD i tre olika gemensamma fonder under en tidsperiod. För att kunna skapa och använda diagram av den här typen i AEM Forms måste du skapa en lämplig formulärdatamodell.

![Diagram över flera serier](assets/seriescharts.jfif)

Om du vill skapa diagram i flera serier i AEM Forms måste du skapa en lämplig formulärdatamodell med nödvändiga enheter och associationer mellan enheterna. Följande skärmbild visar enheterna och associationerna mellan de tre entiteterna. På den översta nivån har vi en enhet som heter&quot;Organisation&quot;, som har en en-till-många-association med fondenheten. Fondenheten har i sin tur en-till-många-association med resultatenheten.

![Formulärdatamodell](assets/formdatamodel.jfif)

## Skapa formulärdatamodell för diagram i flera serier

>[!VIDEO](https://video.tv.adobe.com/v/26352?quality=12&learn=on)

### Konfigurera linjeseriediagram

>[!VIDEO](https://video.tv.adobe.com/v/26353?quality=12&learn=on)

Följ de här stegen för att testa detta på datorn

* [Hämta och importera filen MutualFundFactSheet.zip med AEM Package Manager.](assets/mutualfundfactsheet.zip)
* [Hämta SeriesChartSampleData.json till hårddisken.](assets/serieschartsampledata.json) Detta är exempeldata som används för att fylla i diagrammet.
* [Navigera till Forms och Dokument.](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Välj försiktigt den interaktiva kommunikationsmallen &quot;MutualFundGrowthFactSheet&quot;.
* Klicka på Förhandsgranska | Utskriftskanal | Överför exempeldata.
* Bläddra till exempeldatafilen som ingår i den här artikeln.
* Förhandsgranska tryckkanalen för den interaktiva kommunikationen &quot;MutualFundGrowthFactSheet&quot; med exempeldata som hämtades i föregående steg.
