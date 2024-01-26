---
title: Konfigurerar Outlook-panel för pensionering
description: Detta är en del av 10 av en självstudiekurs i flera steg för att skapa ditt första interaktiva kommunikationsdokument. I den här delen konfigureras Outlook-panelen för borttagning genom att text och diagramkomponenter läggs till.
feature: Interactive Communication
doc-type: Tutorial
version: 6.4,6.5
discoiquuid: 2ee2cea2-aefa-4d21-a258-248648f73a68
topic: Development
role: Developer
level: Beginner
exl-id: 0dd8a430-9a4e-4dc7-ad75-6ad2490430f2
duration: 93
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '347'
ht-degree: 0%

---

# Konfigurerar Outlook-panel för pensionering{#configuring-retirement-outlook-panel}

* Detta är en del av 10 av en självstudiekurs i flera steg för att skapa ditt första interaktiva kommunikationsdokument. I den här delen konfigureras Outlook-panelen för borttagning genom att text och diagramkomponenter läggs till.

* Logga in på AEM Forms och gå till Adobe Experience Manager > Forms > Forms &amp; Documents.

* Öppna mappen 401KStatement.

* Öppna 401KStatement-dokumentet i redigeringsläge.

**Konfigurera målområdet för LeftPanel**

* Tryck på målområdet för vänsterpanelen till höger och klicka på plusikonen (+) för att öppna dialogrutan för att infoga komponenten.

* Infoga textkomponent.

* Tryck försiktigt på den nya textkomponenten för att visa komponentverktygsfältet

* Markera pennikonen om du vill redigera standardtexten.

* Ersätt standardtexten med &quot;**Din intäkt för pensionerade Outlook&quot;**

**Konfigurera målområde för höger panel**

* Tryck på målområdet för högerpanelen till höger och klicka på plustecknet (+) för att öppna dialogrutan för att infoga komponenten.

* Infoga textkomponent.

* Tryck försiktigt på den nya textkomponenten för att visa komponentverktygsfältet.

* Markera pennikonen om du vill redigera standardtexten.

* Ersätt standardtexten med &quot;**Uppskattad månadsvis pensionsinkomst&quot;**

## Lägg till dokumentfragment för återbetalningsintäkt i Outlook {#add-retirement-income-outlook-document-fragment}

* Klicka på ikonen Resurser och använd filtret för att visa resurser av typen &quot;Dokumentfragment&quot;. Dra och släpp dokumentfragmentet RetirementIncomeOutlook på målområdet för den vänstra panelen.

* Du kan referera till [till denna sida](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/partseven.html) när dokumentfragment läggs till i innehållsområden.

## Ökning av uppskattad månadsinkomst {#adding-estimated-monthly-income-chart}

* Klicka på målområdet för högerpanelen på den högra sidan. Klicka på plustecknet (+) för att infoga diagramkomponenten. Vi ska använda ett kolumndiagram för att visa den beräknade månadsinkomsten. Tryck försiktigt på den nyligen infogade diagramkomponenten. Klicka på ikonen &quot;Wrench&quot; för att öppna konfigurationsbladet.Konfigurera diagrammet med följande egenskaper så som visas på skärmbilden nedan.

**AEM Forms 6.4 - Konfigurera uppskattad månadsinkomst (kolumndiagram)**

![form64](assets/estimatedmonthlyincomechart.png)

**AEM Forms 6.5 - Konfigurera uppskattad månadsinkomst (kolumndiagram)**

![forms65](assets/estimatedmonthlyincomechart65.PNG)

## Nästa steg

[Konfigurera cirkeldiagram](./parteleven.md)
