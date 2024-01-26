---
title: Developing for Page Difference in AEM Sites
description: I den här videon visas hur du kan skapa anpassade format för AEM Sites siddifferensfunktion.
feature: Authoring
version: 6.4, 6.5
topic: Development
role: Developer
level: Beginner
doc-type: Technical Video
exl-id: 7d600b16-bbb3-4f21-ae33-4df59b1bb39d
duration: 290
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '279'
ht-degree: 0%

---

# Utveckla för sidskillnader {#developing-for-page-difference}

I den här videon visas hur du kan skapa anpassade format för AEM Sites siddifferensfunktion.

## Anpassa siddifferensformat {#customizing-page-difference-styles}

>[!VIDEO](https://video.tv.adobe.com/v/18871?quality=12&learn=on)

>[!NOTE]
>
>I den här videon läggs anpassad CSS till i webbbiblioteket.Butiksklientbiblioteket, där dessa ändringar ska göras i anpassarens AEM Sites-projekt, i exempelkoden nedan: `my-project`.

AEM sidskillnad hämtar OTB-CSS via en direkt inläsning av `/libs/cq/gui/components/common/admin/diffservice/clientlibs/diffservice/css/htmldiff.css`.

På grund av den här direkta inläsningen av CSS i stället för att använda en klientbibliotekskategori, måste vi hitta en annan inmatningspunkt för de anpassade formaten, och den här anpassade inmatningspunkten är projektets redigeringsklient.

Fördelen med detta är att dessa anpassade åsidosättningar av stilar kan vara klientspecifika.

### Förbered redigeringsklientlib {#prepare-the-authoring-clientlib}

Se till att det finns en `authoring` clientlib for your project at `/apps/my-project/clientlib/authoring.`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
        jcr:primaryType="cq:ClientLibraryFolder"
        categories="[my-project.authoring]"/>
```

### Ange anpassad CSS {#provide-the-custom-css}

Lägg till i projektets `authoring` klientlib a `css.txt` som pekar på den mindre fil som ger de åsidosättande formaten. [Mindre](https://lesscss.org/) är att föredra på grund av dess många praktiska funktioner, bland annat klassomslutning, som används i det här exemplet.

```shell
base=./css

htmldiff.less
```

Skapa `less` filen som innehåller formatåsidosättningar i `/apps/my-project/clientlibs/authoring/css/htmldiff.less`och ange önskade format.

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

### Inkludera redigeringsklientlib-CSS via sidkomponenten {#include-the-authoring-clientlib-css-via-the-page-component}

Inkludera kategorin för redigeringsklienter i projektets bassida `/apps/my-project/components/structure/page/customheaderlibs.html` direkt före `</head>` för att säkerställa att formaten läses in.

Dessa format bör begränsas till [!UICONTROL Edit] och [!UICONTROL preview] WCM-lägen.

```xml
<head>
  ...
  <sly data-sly-test="${wcmmode.preview || wcmmode.edit}" 
       data-sly-call="${clientLib.css @ categories='my-project.authoring'}"/>
</head>
```

Slutresultatet av en avvikande d-sida med formaten ovan tillämpade skulle se ut så här (HTML added och Component changed).

![Sidskillnad](assets/page-diff.png)

## Ytterligare resurser {#additional-resources}

* [Ladda ned exempelwebbplatsen för web.Retail](https://github.com/Adobe-Marketing-Cloud/aem-sample-we-retail/releases)
* [Använda AEM klientbibliotek](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/clientlibs.html)
* [Mindre CSS-dokumentation](https://lesscss.org/)
