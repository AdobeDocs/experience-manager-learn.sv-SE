---
title: Skapa HTML5 Forms
description: Skapa och konfigurera HTML5-formulär
feature: Mobile Forms
doc-type: article
version: 6.5
jira: KT-4419
thumbnail: kt-4419.jpg
topic: Development
role: User
level: Beginner
exl-id: 67a01c41-d284-4518-adb5-21702e22ccfa
last-substantial-update: 2019-07-07T00:00:00Z
duration: 124
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '462'
ht-degree: 0%

---

# Skapa HTML5-formulär

HTML5-formulär är en ny funktion i Adobe Experience Manager som erbjuder återgivning av XFA-formulärmallar (xdp) i HTML5-format. Denna funktion gör det möjligt att återge formulär på mobila enheter och webbläsare på datorer där XFA-baserad PDF inte stöds. HTML5-formulär har inte bara stöd för XFA-formulärmallarnas befintliga funktioner, utan även nya funktioner, som klottersignaturer, för mobila enheter.

## Förutsättning

Kontrollera att du har en fungerande instans av AEM Forms. Följ [installationsguide](https://experienceleague.adobe.com/docs/experience-manager-65/forms/install-aem-forms/osgi-installation/installing-configuring-aem-forms-osgi.html) installera och konfigurera AEM Forms

## Skapa ditt första HTML5-formulär

1. [Hämta och extrahera innehållet i zip-filen](assets/assets.zip). ZIP-filen innehåller xdp och datafilen
2. [Navigera till Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
3. Klicka på Skapa -> Filöverföring
4. Välj xdp-mallen som hämtades i steg 2

## Förhandsgranska som HTML

xdp kan förhandsvisas i HTML5- eller PDF-format. Om du vill förhandsgranska xdp i HTML5-format följer du följande steg

* Tryck på den nyligen överförda xdp-filen och klicka på _Förhandsgranska -> Förhandsgranska som HTML_. Du bör se xdp renderas som HTML5

>[!NOTE]
>När du väljer _Förhandsgranska som PDF_ det återgivna PDF visas inte i webbläsaren eftersom AEM Forms återger dynamiska PDF-filer som kräver Acrobat-plugin.Du måste hämta PDF och öppna det med Adobe Acrobat/Reader för att kunna visa


## Förhandsgranska med data

Om du vill förhandsgranska xdp-filen i HTML5-format med datafilen gör du så här:

* Tryck på den nyligen överförda xdp-filen och klicka på _Förhandsgranska -> Förhandsgranska med data_. Bläddra och markera datafilen och klicka på _Förhandsgranska_.
* Du bör se mallen renderad i HTML5-format ifylld med data

## Utforska avancerade egenskaper för xdp-mallen

Med de avancerade egenskaperna för xdp-mallen kan du ange publiceringsdatum, skicka-hanterare, återgivningsprofil för formuläret, förifyllningstjänst osv. Om du vill visa de avancerade egenskaperna för mallen trycker du på xdp och klickar på _properties -> Advanced_. Här hittar du ett antal egenskaper. Vissa av dessa egenskaper beskrivs här.

**Skicka URL** - Det här är den URL som kommer att hantera din inskickning av HTML5-formulär. Vi ska ta upp det här i nästa lektion. Om ingen sändnings-URL anges här anropas standardhanteraren som returnerar formulärdata till webbläsaren.

**Återgivningsprofil för HTML** - HTML5-formulär har en uppfattning om profiler som visas som REST-slutpunkter för att möjliggöra mobil återgivning av formulärmallar. En majoritet gånger standardåtergivningsprofilen bör räcka för att återge formuläret. Om standardåtergivningsprofilen inte uppfyller dina behov kan du [egen profil](https://experienceleague.adobe.com/docs/experience-manager-65/forms/html5-forms/custom-profile.html) kan skapas och kopplas till formuläret.

**Förifyllningstjänst** - förifyllningstjänsten används vanligtvis för att fylla i formuläret med data som hämtats från en backend-datakälla.
