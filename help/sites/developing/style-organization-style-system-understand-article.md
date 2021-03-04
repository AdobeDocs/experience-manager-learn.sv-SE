---
title: De bästa sätten att lära sig formatsystem med AEM Sites
description: En detaljerad artikel som förklarar de bästa sätten att implementera Style System med Adobe Experience Manager Sites.
feature: Formatsystem
topics: development, components, front-end-development
audience: developer
doc-type: article
activity: understand
version: 6.4, 6.5
topic: Utveckling
role: Developer
level: Mellan, erfaren
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '1534'
ht-degree: 0%

---


# Förstå metodtips för formatsystem{#understanding-style-organization-with-the-aem-style-system}

>[!NOTE]
>
>Granska innehållet på [Kodning för Style System](style-system-technical-video-understand.md) för att se till att du är införstådd med de BEM-liknande konventioner som används av AEM Style System.

Det finns två huvudvarianter eller format som implementeras för AEM Style System:

* **Layoutstilar**
* **Visningsformat**

**Layoutstilar** påverkar många element i en komponent för att skapa en väldefinierad och identifierbar återgivning (design och layout) av komponenten, som ofta justeras efter ett visst återanvändbart varumärkeskoncept. En Teaser-komponent kan till exempel presenteras i den traditionella kortbaserade layouten, en horisontell marknadsföringsstil eller som en Hero-layout som täcker text på en bild.

**Visningsformat** används för att påverka mindre variationer av layoutformat, men de ändrar inte den grundläggande typen eller avsikten för layoutformatet. En Hero-layoutstil kan till exempel ha visningsformat som ändrar färgschemat från det primära färgschemat till det sekundära färgschemat.

## Bästa praxis för formatorganisation {#style-organization-best-practices}

När du definierar de formatnamn som är tillgängliga för AEM författare är det bäst att:

* Namnge format med hjälp av ett språk som författarna förstår
* Minimera antalet formatalternativ
* Visa endast formatalternativ och kombinationer som tillåts av varumärkesstandarder
* Visa endast formatkombinationer som har en effekt
   * Om ineffektiva kombinationer exponeras, se till att de åtminstone inte har någon skadlig effekt

I takt med att antalet möjliga formatkombinationer som är tillgängliga för AEM ökar, finns det fler permutationer som måste vara QAd och valideras mot varumärkesstandarder. För många alternativ kan också förvirra författare eftersom det kan bli oklart vilket alternativ eller vilken kombination som krävs för att skapa önskad effekt.

### Formatnamn jämfört med CSS-klasser {#style-names-vs-css-classes}

Formatnamn, eller de alternativ som visas för AEM författare, och de implementerande CSS-klassnamnen är inte kopplade till varandra i AEM.

Detta gör att formatalternativen kan märkas i en ordlista som är klar och som kan tolkas av de AEM författarna, men gör att CSS-utvecklare kan namnge CSS-klasserna på ett framtidssäkert, semantiskt sätt. Till exempel:

En komponent måste ha alternativ för att färgläggas med varumärkets **primära** och **sekundära** färger, men AEM kan färgerna som **gröna** och **gula**, i stället för det primära och sekundära designspråket.

AEM Style System kan visa dessa färgvisningsformat med hjälp av författarvänliga etiketter **Green** och **Yellow**, samtidigt som CSS-utvecklare kan använda semantisk namngivning av `.cmp-component--primary-color` och `.cmp-component--secondary-color` för att definiera den faktiska formatimplementeringen i CSS.

Formatnamnet **Green** är mappat till `.cmp-component--primary-color` och **Gul** till `.cmp-component--secondary-color`.

Om företagets varumärkefärg ändras i framtiden behöver du bara ändra implementeringarna av `.cmp-component--primary-color` och `.cmp-component--secondary-color`, samt formatnamnen.

## Teaser-komponenten som exempel använder {#the-teaser-component-as-an-example-use-case}

Följande är ett exempel på hur du formaterar en Teaser-komponent så att den har flera olika layout- och visningsformat.

Då utforskas hur formatnamn (exponerade för författare) och hur CSS-klasserna som ligger till grund för dem är ordnade.

### Konfiguration av Teaser-komponentformat {#component-styles-configuration}

Följande bild visar Teaser-komponentens [!UICONTROL Styles]-konfiguration för de variationer som diskuteras i användningsexemplet.

Namnen på [!UICONTROL Style Group], Layout och Visning matchar som en händelse de allmänna begreppen för visningsformat och layoutformat som används för att kategorisera formattyperna i den här artikeln.

Namnen på [!UICONTROL Style Group] och antalet [!UICONTROL Style Groups] ska anpassas efter komponentens användningsfall och projektspecifika regler för komponentformat.

Exempelvis kan formatgruppnamnet **Display** ha namnet **Färger**.

![Visa formatgrupp](assets/style-config.png)

### Meny för val av format {#style-selection-menu}

Bilden nedan visar hur menyförfattarna på [!UICONTROL Style] interagerar med och väljer lämpliga format för komponenten. Observera att både [!UICONTROL Style Grpi]-namnen och formatnamnen visas för författaren.

![Listruta för format](assets/style-menu.png)

### Standardformat {#default-style}

Standardformatet är ofta det vanligaste formatet för komponenten och den icke-formaterade standardvyn för teaser när den läggs till på en sida.

Beroende på hur vanligt standardformatet är kan CSS användas direkt på `.cmp-teaser` (utan modifierare) eller på en `.cmp-teaser--default`.

Om standardformatreglerna används oftare än inte för alla variationer är det bäst att använda `.cmp-teaser` som CSS-klasser för standardformatet, eftersom alla variationer ska ärva dem implicit, förutsatt att BEM-liknande konventioner följs. Om de inte är det bör de tillämpas med standardmodifieraren, till exempel `.cmp-teaser--default`, som i sin tur måste läggas till i [komponentens formatkonfigurations standard-CSS-klasser](#component-styles-configuration)-fält, annars måste dessa formatregler åsidosättas i varje variant.

Det går till och med att tilldela ett namngivet format som standardformat, till exempel Hero-formatet `(.cmp-teaser--hero)` som definieras nedan, men det är tydligare att implementera standardformatet mot implementeringarna av CSS-klasserna `.cmp-teaser` eller `.cmp-teaser--default`.

>[!NOTE]
>
>Observera att standardlayoutstilen INTE har något visningsformatnamn, men författaren kan välja ett visningsalternativ i det AEM formatsystemmarkeringsverktyget.
>
>Detta bryter mot bästa praxis:
>
>**Visa endast formatkombinationer som har en effekt**
>
>Om en författare väljer visningsformatet **Grön** händer ingenting.
>
>I det här fallet kommer vi att avstå från denna överträdelse, eftersom alla andra layoutformat måste vara färgglada med hjälp av varumärkets färger.
>
>I avsnittet **Kampanj (högerjusterad)** nedan ser vi hur du förhindrar oönskade formatkombinationer.

![standardstil](assets/default.png)

* **Layoutstil**
   * Standard
* **Visningsformat**
   * Inget
* **Effektiva CSS-klasser**:  `.cmp-teaser--promo` eller  `.cmp-teaser--default`

### Promo style {#promo-style}

**Promo-layoutstilen** används för att marknadsföra högt värde på webbplatsen och är vågrätt utformat för att ta upp ett mellanrum på webbsidan och måste kunna formateras av varumärken, med standardlayoutstilen Promo som använder svart text.

För att uppnå detta har en **layoutstil** av **Promo** och **visningsstilar** av **Green** och **Gul** konfigurerats i AEM Style System för Teaser-komponenten.

#### Promo Default

![promo default](assets/promo-default.png)

* **Layoutstil**
   * Formatnamn: **Promo**
   * CSS-klass: `cmp-teaser--promo`
* **Visningsformat**
   * Inget
* **Effektiva CSS-klasser**:  `.cmp-teaser--promo`

#### Primär kampanj

![promo primär](assets/promo-primary.png)

* **Layoutstil**
   * Formatnamn: **Promo**
   * CSS-klass: `cmp-teaser--promo`
* **Visningsformat**
   * Formatnamn: **Grön**
   * CSS-klass: `cmp-teaser--primary-color`
* **Effektiva CSS-klasser**:  `cmp-teaser--promo.cmp-teaser--primary-color`

#### Promo Secondary

![Promo Secondary](assets/promo-secondary.png)

* **Layoutstil**
   * Formatnamn: **Promo**
   * CSS-klass: `cmp-teaser--promo`
* **Visningsformat**
   * Formatnamn: **Gul**
   * CSS-klass: `cmp-teaser--secondary-color`
* **Effektiva CSS-klasser**:  `cmp-teaser--promo.cmp-teaser--secondary-color`

### Promo Right-aligned style {#promo-r-align}

Layoutstilen **Kampanj högerjusterad** är en variation av den Promo-stil som används för att vända platsen för bilden och texten (bild till höger, text till vänster).

Den högra justeringen, i sin helhet, är ett visningsformat som du kan ange i AEM Style System som ett visningsformat som du väljer i samband med kampanjlayoutformatet. Detta bryter mot bästa praxis:

**Visa endast formatkombinationer som har en effekt**

..som redan överträtts i [standardformatet](#default-style).

Eftersom den högra justeringen bara påverkar layoutformatet Promo, inte de andra två layoutformaten: standard och hjälte kan vi skapa en ny layoutstil Promo (högerjusterad) som innehåller CSS-klassen som högerjusterar innehållet i Promo-layoutstilar: `cmp -teaser--alternate`.

Den här kombinationen av flera format till en enda formatpost kan också minska antalet tillgängliga format och formatändringar, vilket är bäst för att minimera.

Observera att namnet på CSS-klassen `cmp-teaser--alternate` inte behöver matcha den författarvänliga nomenklaturen för högerjusterad.

#### Promo right-aligned Default

![högerjusterad promo](assets/promo-alternate-default.png)

* **Layoutstil**
   * Formatnamn: **Kampanj (högerjusterad)**
   * CSS-klasser: `cmp-teaser--promo cmp-teaser--alternate`
* **Visningsformat**
   * Inget
* **Effektiva CSS-klasser**:  `.cmp-teaser--promo.cmp-teaser--alternate`

#### Högerjusterad primär kampanj

![Högerjusterad primär kampanj](assets/promo-alternate-primary.png)

* **Layoutstil**
   * Formatnamn: **Kampanj (högerjusterad)**
   * CSS-klasser: `cmp-teaser--promo cmp-teaser--alternate`
* **Visningsformat**
   * Formatnamn: **Grön**
   * CSS-klass: `cmp-teaser--primary-color`
* **Effektiva CSS-klasser**:  `.cmp-teaser--promo.cmp-teaser--alternate.cmp-teaser--primary-color`

#### Högerjusterad sekundär kampanj

![Högerjusterad sekundär kampanj](assets/promo-alternate-secondary.png)

* **Layoutstil**
   * Formatnamn: **Kampanj (högerjusterad)**
   * CSS-klasser: `cmp-teaser--promo cmp-teaser--alternate`
* **Visningsformat**
   * Formatnamn: **Gul**
   * CSS-klass: `cmp-teaser--secondary-color`
* **Effektiva CSS-klasser**:  `.cmp-teaser--promo.cmp-teaser--alternate.cmp-teaser--secondary-color`

### Hero-stil {#hero-style}

Layoutstilen Hero visar komponentens bild som en bakgrund med titeln och länken överlagrad. Layoutstilen Hero, liksom layoutstilen Promo, måste vara färgstark med varumärkesfärger.

Om du vill färglägga Hero-layoutstilen med varumärkesfärger kan du använda samma visningsstilar som används för Promo-layoutstilen.

För varje komponent mappas formatnamnet till en enda uppsättning CSS-klasser, vilket innebär att CSS-klassnamnen som färgar bakgrunden i Promo-layoutstilen måste färglägga texten och länken i Hero-layoutstilen.

Detta kan uppnås delvis genom att CSS-reglerna omdefinieras, men detta kräver att CSS-utvecklarna förstår hur dessa permutationer kommer att påverka AEM.

CSS för att färglägga bakgrunden i layoutformatet **Befordra** med den primära (gröna) färgen:

```css
.cmp-teaser--promo.cmp-teaser--primary--color {
   ...
   background-color: green;
   ...
}
```

CSS för att färglägga texten i layoutformatet **Hero** med den primära (gröna) färgen:

```css
.cmp-teaser--hero.cmp-teaser--primary--color {
   ...
   color: green;
   ...
}
```

#### Hero-standard

![Hero-stil](assets/hero.png)

* **Layoutstil**
   * Formatnamn: **Hero**
   * CSS-klass: `cmp-teaser--hero`
* **Visningsformat**
   * Inget
* **Effektiva CSS-klasser**:  `.cmp-teaser--hero`

#### Hero Primary

![Hero Primary](assets/hero-primary.png)

* **Layoutstil**
   * Formatnamn: **Promo**
   * CSS-klass: `cmp-teaser--hero`
* **Visningsformat**
   * Formatnamn: **Grön**
   * CSS-klass: `cmp-teaser--primary-color`
* **Effektiva CSS-klasser**:  `cmp-teaser--hero.cmp-teaser--primary-color`

#### Hero sekundär

![Hero sekundär](assets/hero-secondary.png)

* **Layoutstil**
   * Formatnamn: **Promo**
   * CSS-klass: `cmp-teaser--hero`
* **Visningsformat**
   * Formatnamn: **Gul**
   * CSS-klass: `cmp-teaser--secondary-color`
* **Effektiva CSS-klasser**:  `cmp-teaser--hero.cmp-teaser--secondary-color`

## Ytterligare resurser {#additional-resources}

* [Systemdokumentation](https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/style-system.html)
* [Skapa AEM klientbibliotek](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/clientlibs.html)
* [Dokumentationswebbplats för BEM (Block Element Modifier)](https://getbem.com/)
* [LESS Documentation webbplats](https://lesscss.org/)
* [jQuery-webbplats](https://jquery.com/)
