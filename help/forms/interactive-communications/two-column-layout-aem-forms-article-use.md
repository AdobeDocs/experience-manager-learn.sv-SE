---
title: Skapa layouter med två kolumner för tryckta kanaldokument
seo-title: Skapa layouter med två kolumner för tryckta kanaldokument
description: Skapa layouter med två kolumner för dokument med utskriftskanaler
seo-description: Skapa layouter med två kolumner för dokument med utskriftskanaler
feature: Interaktiv kommunikation
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
topic: Utveckling
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '243'
ht-degree: 1%

---


# Layouter med två kolumner i dokument för utskriftskanal

Den här korta artikeln visar de steg som behövs för att skapa en layout med två kolumner i en tryckkanal. Det är praktiskt att generera 2 siddokument med sidlayouten 2 kolumner och sidan 2 med standardlayouten 1 kolumn.

Nedan beskrivs de steg som krävs för att skapa 2 kolumnlayouter med AEM Forms Designer.

* Skapa 2 innehållsområden på överordnad sida 1
* Namnge de två innehållsområdena &quot;leftColumn&quot; och &quot;rightColumn&quot;
* Skapa en andra överordnad sida med ett innehållsområde (standard)
* Välj fliken Sidnumrering (namnlöst delformulär) (sidan 1) och (namnlöst delformulär) (sidan 2) och ange egenskaperna enligt skärmbilderna nedan.

![page1](assets/untitledsubform_paginationproperties.gif)

![page2](assets/untitled_subformpage2.gif)

När sidnumreringsegenskaperna är inställda kan vi lägga till delformulär eller målområden under (namnlöst delformulär) (sidan 1).

Vi kan sedan lägga till dokumentfragment till dessa delformulär eller målområden. När den vänstra kolumnen är full flödar innehållet till den högra kolumnen.

Om du vill testa detta på den lokala servern hämtar du resurserna som hör till den här artikeln. Bläddra nedåt till den här sidans nederkant

* [Hämta och installera ett provkanalsdokument med hjälp av pakethanteraren](assets/print-channel-with-two-column-layout.zip)
* [Förhandsgranska dokument för utskriftskanal](http://localhost:4502/content/dam/formsanddocuments/2columnlayout/jcr:content?channel=print&amp;mode=preview&amp;dataRef=service%3A%2F%2FFnDTestData&amp;wcmmode=disabled)
