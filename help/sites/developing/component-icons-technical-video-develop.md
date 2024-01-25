---
title: Anpassa komponentikoner i Adobe Experience Manager Sites
description: Med komponentikoner kan författare snabbt identifiera en komponent med ikoner eller meningsfulla förkortningar. Nu kan man hitta de komponenter som behövs för att skapa webbupplevelser snabbare än någonsin.
version: 6.4, 6.5
feature: Core Components
topic: Development
role: User
level: Intermediate
doc-type: Technical Video
exl-id: 37dc26aa-0773-4749-8c8b-4544bd4d5e5f
duration: 389
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '353'
ht-degree: 0%

---

# Anpassa komponentikoner {#developing-component-icons-in-aem-sites}

Med komponentikoner kan författare snabbt identifiera en komponent med ikoner eller meningsfulla förkortningar. Nu kan man hitta de komponenter som behövs för att skapa webbupplevelser snabbare än någonsin.

>[!VIDEO](https://video.tv.adobe.com/v/16778?quality=12&learn=on)

Komponentwebbläsaren visas nu i ett konsekvent grått tema och med följande:

* **[!UICONTROL Component Group]**
* **[!UICONTROL Component Title]**
* **[!UICONTROL Component Description]**
* **[!UICONTROL Component Icon]**
   * De två första bokstäverna i komponenttiteln *(standard)*
   * Egen PNG-bild *(konfigurerad av en utvecklare)*
   * Anpassad SVG-bild *(konfigurerad av en utvecklare)*
   * CoralUI, ikon *(konfigurerad av en utvecklare)*

## Konfigurationsalternativ för komponentikoner {#component-icon-configuration-options}

### Förkortningar {#abbreviations}

Som standard är de två första tecknen i komponenttiteln (**[cq:Component]@jcr:title**) används som förkortning. Om **[cq:Component]@jcr:title=Artikellista** förkortningen skulle visas som &quot;**Ar**&quot;.

Förkortningen kan anpassas via **[cq:Component]@förkortning** -egenskap. Även om det här värdet kan innehålla fler än 2 tecken bör förkortningen begränsas till två tecken för att undvika eventuella visuella störningar.

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  - abbreviation = "AL"
```

### CoralUI-ikoner {#coralui-icons}

CoralUI-ikoner från AEM kan användas för komponentikoner. Konfigurera en CoralUI-ikon genom att ange en **[cq:Component]@cq:ikon** till den önskade CoralUI-ikonens HTML-ikonattributvärde (anges i [CoralUI-dokumentation](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/coral-ui/coralui3/Coral.Icon.html).

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  - cq:icon = "documentFragment"
```

### PNG-bilder {#png-images}

PNG-bilder kan användas för komponentikoner. Om du vill konfigurera en PNG-bild som en komponentikon lägger du till önskad bild som en **nt:fil** namngiven **cq:icon.png** under **[cq:Component]**.

PNG-filen ska ha en genomskinlig bakgrund eller en bakgrundsfärg inställd på **#707070**.

PNG-bilder skalas till **20px x x 20px**. Men för att passa Retina-skärmar **40px** av **40px** kan vara att föredra.

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  + cq:icon.png
     - jcr:primaryType = "nt:file"
```

### SVG bilder {#svg-images}

SVG-bilder (vektorbaserade) kan användas för komponentikoner. Om du vill konfigurera en SVG-bild som en komponentikon lägger du till SVG som en **nt:fil** namngiven **cq:icon.svg** under **[cq:Component]**.

SVG-bilder bör ha en bakgrundsfärg inställd på **#707070** och en storlek på **20px x x 20px.**

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  + cq:icon.svg
     - jcr:primaryType = "nt:file"
```

## Ytterligare resurser {#additional-resources}

* [Tillgängliga CoralUI-ikoner](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/coral-ui/coralui3/Coral.Icon.html)
