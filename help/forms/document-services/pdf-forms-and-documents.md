---
title: Förstå de olika typerna av PDF forms och dokument
description: PDF är en familj av filformat och den här artikeln beskriver de typer av PDF-filer som är viktiga och relevanta för formulärutvecklare.
solution: Experience Manager Forms
product: aem
type: Dokumentation
role: Developer
level: Nybörjare,Mellanliggande
version: 6.3,6.4,6.5
feature: Dokumenttjänster
topic: Utveckling
kt: 7071
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '1301'
ht-degree: 0%

---


# PDF-format

PDF (Portable Document Format) är en familj av filformat och den här artikeln beskriver de som är mest relevanta för formulärutvecklare. Många av de tekniska detaljerna och standarderna för olika PDF-typer utvecklas och förändras. Vissa av dessa format och specifikationer är ISO-standarder (International Organization for Standardization) och vissa är specifika immateriella rättigheter som ägs av Adobe.

I den här artikeln beskrivs hur du skapar olika typer av PDF-filer. Det hjälper er att förstå hur och varför ni ska använda var och en av dem. Alla dessa typer fungerar bäst i det främsta klientverktyget för att visa och arbeta med PDF-filer - Adobe Acrobat DC.

Detta är ett exempel på en PDF/A-fil i Acrobat DC.
![pdfa](assets/pdfa-file-in-acrobat.png)

Exempelfiler kan [hämtas här](assets/pdf-file-types.zip)

## XFA PDF

Adobe använder termen PDF-formulär för att hänvisa till de interaktiva och dynamiska formulär som du skapar med AEM Forms Designer. Observera att det finns en annan typ av PDF-formulär, som kallas Acrobat, som skiljer sig från den PDF forms du skapar i AEM Forms Designer. Formulären och filerna som du skapar med Designer är baserade på Adobe XML Forms Architecture (XFA). På många sätt ligger XFA PDF-filformatet närmare en HTML-fil än en traditionell PDF-fil. Följande kod visar hur ett enkelt textobjekt ser ut i en XFA PDF-fil.

![textfält](assets/text-field.JPG)

Som du ser är XFA-formulär XML-baserade. Detta välstrukturerade och flexibla format gör att en AEM Forms Server kan omvandla dina Designer-filer till olika format, bland annat traditionell PDF, PDF/A och HTML. Du kan se den fullständiga XML-strukturen för dina formulär i Designer genom att välja fliken XML-källa i layoutredigeraren. Du kan skapa både statiska och dynamiska XFA-formulär i AEM Forms Designer.

## Statisk PDF

Statisk XFA-PDF forms ändrar inte layouten vid körning, men de kan vara interaktiva för användaren. Nedan följer några fördelar med statisk XFA-PDF forms:

* Statisk XFA-PDF forms ändrar inte layouten vid körning, men de kan vara interaktiva för användaren.
* Statiska formulär har stöd för Acrobat kommenterings- och markeringsverktyg.
* Med statiska formulär kan du importera och exportera Acrobat-kommentarer.
* Statiska formulär har stöd för underinställning av teckensnitt, vilket är en teknik som kan göras på en AEM Forms-server.
* Statiska formulär kan återges med det inbyggda PDF-visningsprogrammet som medföljer moderna webbläsare.

>[!NOTE]
> Du kan skapa statiska PDF-filer med AEM Forms Designer genom att spara XDP-filen som ett statiskt PDF-formulär i Adobe

## Dynamiska Forms

Dynamiska XFA-PDF-filer kan ändra sin layout vid körning, vilket innebär att kommenterings- och markeringsfunktionerna inte stöds. Dynamiska XFA PDF-filer ger dock följande fördelar:

* Dynamiska formulär har stöd för klientskript som ändrar formulärets layout och sidnumrering. Exempelvis kommer Purchase Order.xdp att expandera och paginera för att rymma en oändlig mängd data om du sparar den som ett dynamiskt formulär
* Dynamiska formulär har stöd för alla egenskaper i formuläret vid körning, medan statiska formulär bara har stöd för en delmängd


>[!NOTE]
> Du kan skapa dynamiska PDF-filer med AEM Forms Designer genom att spara XDP-filen som ett dynamiskt XML-formulär i Adobe

>[!NOTE]
> Dynamiska formulär kan inte återges med de inbyggda PDF-visningsprogrammen i de moderna webbläsarna.


## PDF-fil (traditionell PDF)

Det vanligaste och mest spridda PDF-formatet är den traditionella PDF-filen. Det finns många sätt att skapa en traditionell PDF-fil, bland annat med Acrobat och många tredjepartsverktyg. I Acrobat kan du skapa traditionella PDF-filer på följande sätt: Om du inte har installerat Acrobat kanske du inte ser dessa alternativ på datorn.

* Genom att hämta utskriftsströmmen för ett skrivbordsprogram: Välj Skriv ut i ett redigeringsprogram och välj Adobe PDF-skrivarikon. I stället för en tryckt kopia av dokumentet har du skapat en PDF-fil av dokumentet
* Genom att använda plugin-programmet Acrobat PDFMaker med Microsoft Office-program: När du installerar Acrobat läggs en Adobe PDF-meny till i Microsoft Office-program och en ikon till i Office-menyfliksområdet. Du kan använda de här nya funktionerna för att skapa PDF-filer direkt i Microsoft Office
* Genom att använda Acrobat Distiller för att konvertera Postscript- och Encapsulated Postscript-filer (EPS) till PDF-filer: Distiller används vanligtvis vid trycksakspublicering och andra arbetsflöden som kräver konvertering från Postscript-formatet till PDF-formatet
* Under huven är en traditionell PDF mycket annorlunda än en XFA PDF. Den har inte samma XML-struktur, och eftersom den skapas genom att en fils utskriftsström hämtas är en traditionell PDF-fil en statisk och skrivskyddad fil.

Ett certifierat dokument ger mottagarna av PDF-dokument och -formulär ytterligare garantier för att de är autentiska och att de är intakta.

## Acroforms

Acroforms är Adobe&#39;s older interactive form technology; de återgår till Acrobat version 3. Adobe tillhandahåller [API-referens för Acrobat Forms](assets/FormsAPIReference.pdf) från maj 2003 med teknisk information om tekniken. Acrobat är en kombination av
följande objekt:

* En traditionell PDF som definierar formulärets statiska layout och grafik.
* Interaktiva formulärfält som markeras ovanpå formulärverktygen i Adobe Acrobat. Observera att dessa formulärverktyg är en liten del av vad som är tillgängligt i AEM Forms Designer.

## PDF/A (PDF för arkivering)

PDF/A (PDF for Archives) bygger vidare på fördelarna med dokumentlagring i traditionella PDF-filer med många specifika detaljer som förbättrar långtidsarkivering. Det traditionella PDF-formatet ger många fördelar vid långsiktig dokumentlagring. PDF-filens kompakta natur gör det enkelt att överföra och spara utrymme, och dess välstrukturerade natur möjliggör kraftfulla indexerings- och sökfunktioner. Traditionell PDF har omfattande stöd för metadata och PDF har lång erfarenhet av att stödja olika datormiljöer.

Precis som PDF är PDF/A en ISO-standardspecifikation. Den utvecklades av en arbetsgrupp som innefattade AIIM (Association for Information and Image Management), NPES (National Printing Equipment Association) och de amerikanska domstolarnas administrativa kontor. Eftersom målet för PDF/A-specifikationen är att tillhandahålla ett långsiktigt arkivformat, utelämnas många PDF-funktioner så att filerna kan vara fristående. Nedan följer några viktiga punkter om specifikationen som förbättrar PDF/A-filens långsiktiga reproducerbarhet:

* Allt innehåll måste finnas i filen och det kan inte finnas några beroenden till externa källor som hyperlänkar, teckensnitt eller program.
* Alla teckensnitt måste vara inbäddade och de måste vara teckensnitt som har en obegränsad licens för elektroniska dokument.
* JavaScript tillåts inte
* Genomskinlighet tillåts inte
* Kryptering är inte tillåten
* Ljud- och videoinnehåll tillåts inte
* Färgrymder måste definieras på ett enhetsoberoende sätt
* Alla metadata måste följa vissa standarder

## Visa en PDF/A-fil

Två filer i exempelfilerna skapades från samma Microsoft Word-fil. Den ena skapades som en traditionell PDF och den andra som en PDF/A-fil. Öppna dessa två filer i Acrobat Professional:

simpleWordFile.pdf
simpleWordFilePDFA.pdf

Även om dokumenten ser likadana ut öppnas PDF/A-filen med ett blått fält längst upp, vilket anger att dokumentet visas i PDF/A-läge. Det här blå fältet är Acrobat dokumentmeddelandefält som visas när du öppnar vissa typer av PDF-filer.

![pdf-img](assets/pdfa-message.png)

Dokumentets meddelandefält innehåller instruktioner, och eventuellt knappar, som hjälper dig att slutföra en uppgift. Den är färgkodad och du ser den blå färgen när du öppnar särskilda typer av PDF-filer (som den här PDF/A-filen) samt certifierade och digitalt signerade PDF-filer. Fältet ändras till lila för PDF forms och gult när du deltar i en PDF-granskning.

>[!NOTE]
> Om du klickar på Aktivera redigering tar du bort det här dokumentet från PDF/A-kompatibilitet.




