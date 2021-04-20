---
title: Developing for Page Difference in AEM Sites
description: I den här videon visas hur du kan skapa anpassade format för funktionen Sidskillnad i AEM Sites.
feature: Authoring
topics: development
audience: developer
doc-type: technical video
activity: develop
version: 6.3, 6.4, 6.5
topic: Development
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '295'
ht-degree: 1%

---


# Utveckla för siddifferens {#developing-for-page-difference}

I den här videon visas hur du kan skapa anpassade format för funktionen Sidskillnad i AEM Sites.

## Anpassa siddifferensformat {#customizing-page-difference-styles}

>[!VIDEO](https://video.tv.adobe.com/v/18871/?quality=9&learn=on)

>[!NOTE]
>
>I den här videon läggs anpassad CSS till i webbbiblioteket.Butiksklientbiblioteket, där dessa ändringar bör göras i anpassarens AEM Sites-projekt. i exempelkoden nedan: `my-project`.

AEM sidskillnad hämtar OTB-CSS via en direkt inläsning på `/libs/cq/gui/components/common/admin/diffservice/clientlibs/diffservice/css/htmldiff.css`.

På grund av den här direkta inläsningen av CSS i stället för att använda en klientbibliotekskategori, måste vi hitta en annan inmatningspunkt för de anpassade formaten, och den här anpassade inmatningspunkten är projektets redigeringsklient.

Fördelen med detta är att dessa anpassade åsidosättningar av stilar kan vara klientspecifika.

### Förbered redigeringsklientlib {#prepare-the-authoring-clientlib}

Kontrollera att det finns ett `authoring`-klientlib för ditt projekt på `/apps/my-project/clientlib/authoring.`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
        jcr:primaryType="cq:ClientLibraryFolder"
        categories="[my-project.authoring]"/>
```

### Ange anpassad CSS {#provide-the-custom-css}

Lägg till en `css.txt`-klient i projektets `authoring` som pekar på den mindre fil som kommer att innehålla de åsidosättande formaten. [](https://lesscss.org/) Lessis föredrog att använda eftersom de har många praktiska funktioner, bland annat klassomslutning som används i det här exemplet.

```shell
base=./css

htmldiff.less
```

Skapa den `less`-fil som innehåller formatåsidosättningarna på `/apps/my-project/clientlibs/authoring/css/htmldiff.less` och ange de överliggande formaten efter behov.

```css
/* Wrap with body to gives these rules more specificity than the OOTB */
body {

    /* .html-XXXX are the styles that wrap text that has been added or removed */

    .html-added {
        background-color: transparent;
     color: initial;
        text-decoration: none;
     border-bottom: solid 2px limegreen;
    }

    .html-removed {
        background-color: transparent;
     color: initial;
        text-decoration: none;
     border-bottom: solid 2px red;
    }

    /* .cq-component-XXXX require !important as the class these are overriding uses it. */

    .cq-component-changed {
        border: 2px dashed #B9DAFF !important;
        border-radius: 8px;
    }
    
    .cq-component-moved {
        border: 2px solid #B9DAFF !important;
        border-radius: 8px;
    }

    .cq-component-added {
        border: 2px solid #CCEBB8 !important;
        border-radius: 8px;
    }

    .cq-component-removed {
        border: 2px solid #FFCCCC !important;
        border-radius: 8px;
    }
}
```

### Inkludera CSS för redigeringsklientlib via sidkomponenten {#include-the-authoring-clientlib-css-via-the-page-component}

Inkludera kategorin för redigeringsklienter i projektets bassidas `/apps/my-project/components/structure/page/customheaderlibs.html` direkt före taggen `</head>` för att säkerställa att formaten läses in.

Dessa format bör begränsas till WCM-lägena [!UICONTROL Edit] och [!UICONTROL preview].

```xml
<head>
  ...
  <sly data-sly-test="${wcmmode.preview || wcmmode.edit}" 
       data-sly-call="${clientLib.css @ categories='my-project.authoring'}"/>
</head>
```

Slutresultatet av en annan d-sida med formaten ovan tillämpade skulle se ut så här (HTML-tillägg och komponent ändrat).

![Sidskillnad](assets/page-diff.png)

## Ytterligare resurser {#additional-resources}

* [Ladda ned exempelwebbplatsen för web.Retail](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail/releases)
* [Använda AEM Client Libraries](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/clientlibs.html)
* [Mindre CSS-dokumentation](https://lesscss.org/)
