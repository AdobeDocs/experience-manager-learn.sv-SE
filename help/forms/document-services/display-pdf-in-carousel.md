---
title: Visa flera PDF-dokument
description: Bläddra igenom flera PDF-dokument i ett adaptivt format.
version: Experience Manager 6.5
feature: Adaptive Forms
topic: Development
role: Developer
level: Experienced
jira: KT-10292
exl-id: c1d248c3-8208-476e-b0ae-cab25575cd6a
last-substantial-update: 2021-10-12T00:00:00Z
duration: 66
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '320'
ht-degree: 0%

---

# Visa flera PDF-dokument i en karusell

Ett vanligt användningssätt är att visa flera PDF-dokument för formuläranvändaren som ska granska dem innan formuläret skickas.

Vi har använt [Adobe PDF Embed API](https://www.adobe.io/apis/documentcloud/dcsdk/pdf-embed.html) för att uppnå den här användningen.

[En live-demo av det här exemplet kan visas här.](https://forms.enablementadobe.com/content/dam/formsanddocuments/wefinancecreditcard/jcr:content?wcmmode=disabled)

Följande steg utfördes för att slutföra integreringen

## Skapa en anpassad komponent för att visa flera PDF-dokument

En anpassad komponent (pdf-carousel) skapades för att bläddra igenom PDF-dokument

## Klientbibliotek

Ett klientbibliotek skapades för att visa PDF-filer med Adobe PDF Embed API. De PDF-filer som ska visas anges i komponenterna i PDF-karusellen.

## Skapa anpassat formulär

Skapa ett anpassat formulär baserat på vissa flikar (exemplet har tre flikar)
Lägg till vissa adaptiva formulärkomponenter på de två första flikarna
Lägg till PDF-karusellkomponenten på den tredje fliken
Konfigurera komponenten pdf-carousel enligt skärmbilden nedan
![pdf-carousel](assets/pdf-carousel-af-component.png)

**Bädda in API-nyckel för PDF** - Det här är nyckeln som du kan använda för att bädda in PDF-filen. Den här nyckeln fungerar bara med localhost. Du kan skapa [din egen nyckel](https://www.adobe.io/apis/documentcloud/dcsdk/pdf-embed.html) och associera den med en annan domän.

**Ange PDF-dokument** - Här kan du ange vilka PDF-dokument du vill ska visas i karusellen.


## Distribuera exemplet på servern

Så här testar du detta på den lokala servern:

1. [Importera klientbiblioteket](assets/pdf-carousel-client-lib.zip) till din lokala AEM-instans [med hjälp av pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
1. [Importera pdf-karusellkomponenten](assets/pdf-carousel-component.zip) till den lokala AEM-instansen [med pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
1. [Importera det adaptiva formuläret](assets/adaptive-form-pdf-carousel.zip) till din lokala AEM-instans [med hjälp av pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
1. [Importera exempel-PDF-filer som ska visas](assets/pdf-carousel-sample-documents.zip) till den lokala AEM-instansen [med hjälp av länken för överföring av resursfiler](http://localhost:4502/assets.html/content/dam)
1. [Förhandsgranska anpassat formulär](http://localhost:4502/content/dam/formsanddocuments/wefinancecreditcard/jcr:content?wcmmode=disabled)
1. Fliken Dokument att granska. Du bör se tre PDF-dokument i karusellkomponenten.
