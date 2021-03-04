---
title: Skapa HTML5 Forms
description: Skapa och konfigurera HTML5-formulär
feature: mobilformulär
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 4419
thumbnail: kt-4419.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '486'
ht-degree: 4%

---


# Skapa HTML5-formulär

HTML5-formulär är en ny funktion i Adobe Experience Manager som erbjuder återgivning av XFA-formulärmallar (xdp) i HTML5-format. Detta gör det möjligt att återge formulär på mobila enheter och skrivbordswebbläsare som inte har stöd för XFA-baserade PDF-filer. HTML5-formulär har inte bara stöd för de befintliga funktionerna i XFA-formulärmallar, utan även nya funktioner, som klottersignaturer, för mobila enheter.

## Förutsättning

Kontrollera att du har en fungerande instans av AEM Forms. Följ [installationshandboken](https://docs.adobe.com/content/help/en/experience-manager-65/forms/install-aem-forms/osgi-installation/installing-configuring-aem-forms-osgi.html) för att installera och konfigurera AEM Forms

## Skapa ditt första HTML5-formulär

1. [Hämta och extrahera innehållet i zip-filen](assets/assets.zip). ZIP-filen innehåller xdp och datafilen
2. [Navigera till Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
3. Klicka på Skapa -> Filöverföring
4. Välj xdp-mallen som hämtades i steg 2

## Förhandsgranska som HTML

xdp kan förhandsgranskas i HTML5-format eller PDF-format. Följ de här stegen för att förhandsgranska xdp i HTML5-format

* Tryck på den nyligen överförda xdp-filen och klicka på _Förhandsgranska -> Förhandsgranska som HTML_. Du bör se xdp renderad som HTML5

>[!NOTE]
>När du väljer alternativet _Förhandsgranska som PDF_ visas inte den återgivna PDF-filen i webbläsaren eftersom AEM Forms återger dynamiska PDF-filer som kräver Acrobat-plugin.Du måste hämta PDF-filen och öppna den med Adobe Acrobat/Reader för att kunna visa den


## Förhandsgranska med data

Om du vill förhandsgranska xdp i HTML5-format med datafil följer du följande steg:

* Tryck på den nyligen överförda xdp-filen och klicka på _Förhandsgranska -> Förhandsgranska med data_. Bläddra och markera datafilen och klicka på _Förhandsgranska_.
* Du bör se mallen renderad i HTML5-format fylld med data

## Utforska avancerade egenskaper för xdp-mallen

Med de avancerade egenskaperna för xdp-mallen kan du ange publiceringsdatum, skicka-hanterare, återgivningsprofil för formuläret, förifyllningstjänst osv. Om du vill visa de avancerade egenskaperna för mallen trycker du på xdp och klickar på _egenskaper -> Avancerat_. Här hittar du ett antal egenskaper. Vissa av dessa egenskaper beskrivs här.

**Skicka-URL**  - Det här är den URL som kommer att hantera ditt inskickade HTML5-formulär. Vi ska ta upp det här i nästa lektion. Om ingen sändnings-URL anges här anropas standardhanteraren som returnerar formulärdata till webbläsaren.

**HTML-återgivningsprofil**  - HTML5-formulär har begreppet profiler som exponeras som REST-slutpunkter för att aktivera mobil återgivning av formulärmallar. En majoritet gånger standardåtergivningsprofilen bör räcka för att återge formuläret. Om standardåtergivningsprofilen inte uppfyller dina behov kan en [anpassad profil](https://docs.adobe.com/content/help/en/experience-manager-64/forms/html5-forms/custom-profile.html) skapas och kopplas till formuläret.

**Prefill Service**  - Prefill Service används vanligtvis för att fylla i formuläret med data som hämtats från en backend-datakälla.

