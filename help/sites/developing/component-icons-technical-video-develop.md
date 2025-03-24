---
title: Anpassa komponentikoner i Adobe Experience Manager Sites
description: Med komponentikoner kan författare snabbt identifiera en komponent med ikoner eller meningsfulla förkortningar. Nu kan man hitta de komponenter som behövs för att skapa webbupplevelser snabbare än någonsin.
version: Experience Manager 6.4, Experience Manager 6.5
feature: Core Components
topic: Development
role: User
level: Intermediate
doc-type: Technical Video
exl-id: 37dc26aa-0773-4749-8c8b-4544bd4d5e5f
duration: 379
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
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
   * Anpassad PNG-bild *(konfigurerad av en utvecklare)*
   * Anpassad SVG-bild *(konfigurerad av en utvecklare)*
   * CoralUI-ikon *(konfigurerad av en utvecklare)*

## Konfigurationsalternativ för komponentikoner {#component-icon-configuration-options}

### Förkortningar {#abbreviations}

Som standard används de två första tecknen i komponenttiteln (**[cq:Component]@jcr:title**) som förkortning. Om **[cq:Component]@jcr:title=Article List** skulle förkortningen visas som **Ar**.

Förkortningen kan anpassas via egenskapen **[cq:Component]@abbreption** . Även om det här värdet kan innehålla fler än 2 tecken bör förkortningen begränsas till två tecken för att undvika eventuella visuella störningar.

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  - abbreviation = "AL"
```

### CoralUI-ikoner {#coralui-icons}

CoralUI-ikoner från AEM kan användas för komponentikoner. Om du vill konfigurera en CoralUI-ikon anger du en **[cq:Component]@cq:icon** -egenskap till den önskade CoralUI-ikonens HTML-ikonattributvärde (som räknas upp i [CoralUI-dokumentationen](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/coral-ui/coralui3/Coral.Icon.html)).

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  - cq:icon = "documentFragment"
```

### PNG-bilder {#png-images}

PNG-bilder kan användas för komponentikoner. Om du vill konfigurera en PNG-bild som en komponentikon lägger du till den önskade bilden som en **nt:file** med namnet **cq:icon.png** under **[cq:Component]** .

PNG-filen ska ha en genomskinlig bakgrund eller en bakgrundsfärg inställd på **#707070**.

PNG-bilderna skalas till **20px med 20px**. Det kan dock vara bättre att använda Retina-skärmar med **40px** x **40px**.

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  + cq:icon.png
     - jcr:primaryType = "nt:file"
```

### SVG Images {#svg-images}

SVG-bilder (vektorbaserade) kan användas för komponentikoner. Om du vill konfigurera en SVG-bild som en komponentikon lägger du till önskad SVG som en **nt:file** med namnet **cq:icon.svg** under **[cq:Component]** .

SVG-bilder bör ha en bakgrundsfärg inställd på **#707070** och storleken **20px gånger 20px.**

```plain
/apps/.../components/content/my-component
  - jcr:primaryType = "cq:Component"
  + cq:icon.svg
     - jcr:primaryType = "nt:file"
```

## Ytterligare resurser {#additional-resources}

* [Tillgängliga CoralUI-ikoner](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/coral-ui/coralui3/Coral.Icon.html)
