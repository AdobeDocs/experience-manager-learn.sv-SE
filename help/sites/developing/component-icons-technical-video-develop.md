---
title: Anpassa komponentikoner i Adobe Experience Manager Sites
description: Med komponentikoner kan författare snabbt identifiera en komponent med ikoner eller meningsfulla förkortningar. Nu kan man hitta de komponenter som behövs för att skapa webbupplevelser snabbare än någonsin.
topics: components
audience: administrator, developer
doc-type: technical video
activity: develop
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: c85a59a8bd180d5affe2a5bf5939dabfb2776d73
workflow-type: tm+mt
source-wordcount: '367'
ht-degree: 0%

---


# Anpassa komponentikoner {#developing-component-icons-in-aem-sites}

Med komponentikoner kan författare snabbt identifiera en komponent med ikoner eller meningsfulla förkortningar. Nu kan man hitta de komponenter som behövs för att skapa webbupplevelser snabbare än någonsin.

>[!VIDEO](https://video.tv.adobe.com/v/16778/?quality=9&learn=on)

Komponentwebbläsaren visas nu i ett konsekvent grått tema och med följande:

* **[!UICONTROL Component Group]**
* **[!UICONTROL Component Title]**
* **[!UICONTROL Component Description]**
* **[!UICONTROL Component Icon]**
   * De två första bokstäverna i komponenttiteln *(standard)*
   * Anpassad PNG-bild *(konfigurerad av en utvecklare)*
   * Anpassad SVG-bild *(konfigurerad av en utvecklare)*
   * CoralUI-ikon *(konfigurerad av en utvecklare)*

## Konfigurationsalternativ för komponentikoner {#component-icon-configuration-options}

### Förkortningar {#abbreviations}

Som standard används de två första tecknen i komponenttiteln (**[cq:Component]@jcr:title**) som förkortning. Om **[cq:Component]@jcr:title=Article List** skulle förkortningen visas som &quot;**Ar**&quot;.

Förkortningen kan anpassas via egenskapen **[cq:Component]@abbreption**. Även om det här värdet kan innehålla fler än 2 tecken rekommenderar vi att förkortningen begränsas till två tecken för att undvika visuella störningar.

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  - abbreviation = "AL"
```

### CoralUI-ikoner {#coralui-icons}

CoralUI-ikoner från AEM kan användas för komponentikoner. Om du vill konfigurera en CoralUI-ikon anger du egenskapen **[cq:Component]@cq:icon** till önskat HTML-ikonattributvärde för CoralUI-ikonen (anges i [CoralUI-dokumentationen](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/coral-ui/coralui3/Coral.Icon.html).

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  - cq:icon = "documentFragment"
```

### PNG-bilder {#png-images}

PNG-bilder kan användas för komponentikoner. Om du vill konfigurera en PNG-bild som en komponentikon lägger du till önskad bild som en **nt:file** med namnet **cq:icon.png** under **[cq:Component]**.

PNG-filen ska ha en genomskinlig bakgrund eller en bakgrundsfärg inställd på **#707070**.

PNG-bilderna skalas till **20px gånger 20px**. Det kan dock vara bättre att använda Retina-skärmar **40px** med **40px**.

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  + cq:icon.png
     - jcr:primaryType = "nt:file"
```

### SVG-bilder {#svg-images}

SVG-bilder (vektorbaserade) kan användas för komponentikoner. Om du vill konfigurera en SVG-bild som en komponentikon lägger du till önskad SVG som en **nt:file** med namnet **cq:icon.svg** under **[cq:Component]**.

SVG-bilder ska ha en bakgrundsfärg inställd på **#707070** och storleken **20px gånger 20px.**

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  + cq:icon.svg
     - jcr:primaryType = "nt:file"
```

## Ytterligare resurser {#additional-resources}

* [Tillgängliga CoralUI-ikoner](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/coral-ui/coralui3/Coral.Icon.html)
