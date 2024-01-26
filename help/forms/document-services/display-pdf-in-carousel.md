---
title: Visa flera PDF-dokument
description: Bläddra igenom flera PDF-dokument i ett adaptivt format.
version: 6.5
feature: Adaptive Forms
topic: Development
role: Developer
level: Experienced
jira: KT-10292
exl-id: c1d248c3-8208-476e-b0ae-cab25575cd6a
last-substantial-update: 2021-10-12T00:00:00Z
duration: 84
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '320'
ht-degree: 0%

---

# Visa flera PDF-dokument i en karusell

Ett vanligt användningssätt är att visa flera PDF-dokument för formuläranvändaren som ska granska dem innan formuläret skickas.

Vi har använt [Adobe PDF Embed API](https://www.adobe.io/apis/documentcloud/dcsdk/pdf-embed.html).

[Här finns en live-demo av det här exemplet.](https://forms.enablementadobe.com/content/dam/formsanddocuments/wefinancecreditcard/jcr:content?wcmmode=disabled)

Följande steg utfördes för att slutföra integreringen

## Skapa en anpassad komponent för att visa flera PDF-dokument

En anpassad komponent (pdf-carousel) skapades för att bläddra igenom PDF-dokument

## Klientbibliotek

Ett klientbibliotek skapades för att visa PDF med hjälp av Adobe PDF Embed API. PDF som ska visas anges i pdf-karusellkomponenterna.

## Skapa anpassat formulär

Skapa ett adaptivt formulär baserat på vissa flikar (exemplet har tre flikar) Lägg till några adaptiva formulärkomponenter på de första två flikarna Lägg till pdf-karusellkomponenten på den tredje fliken Konfigurera pdf-karusellkomponenten enligt skärmbilden nedan
![pdf-carousel](assets/pdf-carousel-af-component.png)

**Bädda in PDF API-nyckel** - Det här är nyckeln som du kan använda för att bädda in PDF-filen. Den här nyckeln fungerar bara med localhost. Du kan [egen nyckel](https://www.adobe.io/apis/documentcloud/dcsdk/pdf-embed.html) och associera den med en annan domän.

**Ange PDF-dokument** - Här kan du ange vilka PDF-dokument som ska visas i karusellen.


## Distribuera exemplet på servern

Så här testar du detta på den lokala servern:

1. [Importera klientbiblioteket](assets/pdf-carousel-client-lib.zip) till din lokala AEM [använda pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
1. [Importera PDF-karusellkomponenten](assets/pdf-carousel-component.zip) till din lokala AEM [använda pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
1. [Importera det adaptiva formuläret](assets/adaptive-form-pdf-carousel.zip) till din lokala AEM [använda pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
1. [Importera exempelfilerna som ska visas](assets/pdf-carousel-sample-documents.zip) till din lokala AEM [med hjälp av länken för överföring av resursfiler](http://localhost:4502/assets.html/content/dam)
1. [Förhandsgranska anpassat formulär](http://localhost:4502/content/dam/formsanddocuments/wefinancecreditcard/jcr:content?wcmmode=disabled)
1. Fliken Dokument att granska. Du bör se tre PDF-dokument i karusellkomponenten.
