---
title: Skapa HTML5 Forms
description: Skapa och konfigurera HTML5-formulär
feature: Mobile Forms
doc-type: article
version: Experience Manager 6.5
jira: KT-4419
thumbnail: kt-4419.jpg
topic: Development
role: User
level: Beginner
exl-id: 67a01c41-d284-4518-adb5-21702e22ccfa
last-substantial-update: 2019-07-07T00:00:00Z
duration: 101
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '462'
ht-degree: 0%

---

# Skapa HTML5-formulär

HTML5-formulär är en ny funktion i Adobe Experience Manager som erbjuder återgivning av XFA-formulärmallar (xdp) i HTML5-format. Denna funktion gör det möjligt att återge formulär på mobila enheter och webbläsare på datorer där XFA-baserad PDF inte stöds. HTML5-blanketter har inte bara stöd för XFA-blankettmallarnas funktioner, utan även nya funktioner, som klottersignaturer, för mobila enheter.

## Förutsättning

Kontrollera att du har en fungerande instans av AEM Forms. Följ [installationsguiden](https://experienceleague.adobe.com/docs/experience-manager-65/forms/install-aem-forms/osgi-installation/installing-configuring-aem-forms-osgi.html) för att installera och konfigurera AEM Forms

## Skapa ditt första HTML5-formulär

1. [Hämta och extrahera innehållet i zip-filen](assets/assets.zip). ZIP-filen innehåller xdp och datafilen
2. [Navigera till Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
3. Klicka på Skapa -> Filöverföring
4. Välj xdp-mallen som hämtades i steg 2

## Förhandsgranska som HTML

xdp kan förhandsgranskas i HTML5-format eller PDF-format. Om du vill förhandsgranska xdp i HTML5-format följer du följande steg

* Tryck på den nyligen överförda xdp-filen och klicka på _Förhandsgranska -> Förhandsgranska som HTML_. Du bör se xdp som återges som HTML5

>[!NOTE]
>När du väljer alternativet _Förhandsgranska som PDF_ visas inte den återgivna PDF-filen i webbläsaren eftersom AEM Forms återger dynamiska PDF-filer som kräver Acrobat-plugin.Du måste hämta PDF och öppna den med Adobe Acrobat/Reader för att kunna visa


## Förhandsgranska med data

Om du vill förhandsgranska xdp-filen i HTML5-format med datafilen gör du så här:

* Tryck på den nyligen överförda xdp-filen och klicka på _Förhandsgranska -> Förhandsgranska med data_. Bläddra och markera datafilen och klicka på _Förhandsgranska_.
* Du bör se mallen renderad i HTML5-format ifylld med data

## Utforska avancerade egenskaper för xdp-mallen

Med de avancerade egenskaperna för xdp-mallen kan du ange publiceringsdatum, skicka-hanterare, återgivningsprofil för formuläret, förifyllningstjänst osv. Om du vill visa de avancerade egenskaperna för mallen trycker du på xdp och klickar på _egenskaper -> Avancerat_. Här hittar du ett antal egenskaper. Vissa av dessa egenskaper beskrivs här.

**Skicka-URL** - Det här är den URL som kommer att hantera din inskickning av HTML5-formulär. Vi ska ta upp det här i nästa lektion. Om ingen sändnings-URL anges här anropas standardhanteraren som returnerar formulärdata till webbläsaren.

**HTML-återgivningsprofil** - HTML5-formulär fungerar som profiler som exponeras som REST-slutpunkter för att aktivera mobil återgivning av formulärmallar. En majoritet gånger standardåtergivningsprofilen bör räcka för att återge formuläret. Om standardåtergivningsprofilen inte uppfyller dina behov kan en [anpassad profil](https://experienceleague.adobe.com/docs/experience-manager-65/forms/html5-forms/custom-profile.html) skapas och kopplas till formuläret.

**förifyllningstjänst** - förifyllningstjänsten används vanligtvis för att fylla i formuläret med data som hämtats från en backend-datakälla.
