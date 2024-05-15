---
title: Skapa layouter med två kolumner för tryckta kanaldokument
description: Skapa layouter med två kolumner för dokument med utskriftskanaler
feature: Interactive Communication
doc-type: article
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 416e3401-ba9f-4da3-8b07-2d39f9128571
last-substantial-update: 2019-07-07T00:00:00Z
duration: 44
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '218'
ht-degree: 0%

---

# Layouter med två kolumner i ett dokument för utskriftskanaler

Den här korta artikeln visar de steg som behövs för att skapa en layout med två kolumner i en tryckkanal. Det är praktiskt att generera 2 siddokument med sidlayouten 2 kolumner och sidan 2 med standardlayouten 1 kolumn.

Nedan beskrivs de steg som krävs för att skapa 2 kolumnlayouter med AEM Forms Designer.

* Skapa 2 innehållsområden på mallsidan på sidan 1
* Namnge de två innehållsområdena &quot;left column&quot; och &quot;right column&quot;
* Skapa en andra mallsida med ett innehållsområde (standard)
* Välj fliken Sidnumrering (namnlöst delformulär) (sidan 1) och (namnlöst delformulär) (sidan 2) och ange egenskaperna enligt skärmbilderna nedan.

![page1](assets/untitledsubform_paginationproperties.gif)

![page2](assets/untitled_subformpage2.gif)

När sidnumreringsegenskaperna är inställda kan vi lägga till delformulär eller målområden under (namnlöst delformulär) (sidan 1).

Vi kan sedan lägga till dokumentfragment till dessa delformulär eller målområden. När den vänstra kolumnen är full flödar innehållet till den högra kolumnen.

Om du vill testa detta på den lokala servern hämtar du resurserna som hör till den här artikeln. Bläddra nedåt till den här sidans nederkant

* [Hämta och installera ett provkanalsdokument med hjälp av pakethanteraren](assets/print-channel-with-two-column-layout.zip)
* [Förhandsgranska dokument för utskriftskanal](http://localhost:4502/content/dam/formsanddocuments/2columnlayout/jcr:content?channel=print&amp;mode=preview&amp;dataRef=service%3A%2F%2FFnDTestData&amp;wcmmode=disabled)
