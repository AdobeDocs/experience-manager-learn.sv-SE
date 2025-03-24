---
title: Utveckla ett block med CSS
description: Utveckla ett block med CSS för Edge Delivery Services, som kan redigeras med den universella redigeraren.
version: Experience Manager as a Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Tutorial
jira: KT-15832
duration: 900
exl-id: 14cda9d4-752b-4425-a469-8b6f283ce1db
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '437'
ht-degree: 0%

---

# Utveckla ett block med CSS

Block i Edge Delivery Services är formaterade med CSS. CSS-filen för ett block lagras i blockets katalog och har samma namn som blocket. CSS-filen för ett block med namnet `teaser` finns till exempel på `blocks/teaser/teaser.css`.

Helst ska ett -block bara behöva CSS för formatering, utan att förlita sig på JavaScript för att ändra DOM eller lägga till CSS-klasser. Behovet av JavaScript beror på blockets [innehållsmodellering](./5-new-block.md#block-model) och dess komplexitet. Om det behövs kan [blockera JavaScript](./7b-block-js-css.md) läggas till.

Om du bara använder CSS är de (mest) oskarpa HTML-elementen i blocket riktade och formaterade.

## Blockera HTML

Om du vill veta hur du formaterar ett block ska du först granska DOM som exponeras av Edge Delivery Services, eftersom det är det som är tillgängligt för formatering. DOM hittas genom att man inspekterar det block som hanteras av AEM CLI:s lokala utvecklingsmiljö. Undvik att använda den universella redigerarens DOM eftersom den skiljer sig något.

>[!BEGINTABS]

>[!TAB DOM till format]

Nedan följer det teaser-blockets DOM som är målet för formatering.

Observera att `<p class="button-container">...` som [automatiskt utökas](./4-website-branding.md#inferred-elements) som ett härledt element av Edge Delivery Services JavaScript.

```html
...
<body>
    <header/>
    <main>
        <div>
            <!-- Start block HTML -->
            <div class="teaser block" data-block-name="teaser" data-block-status="loaded">
                <div>
                    <div>
                        <picture>
                            <source type="image/webp" srcset="./media_15ba2b455e29aca38c1ca653d24c40acaec8a008f.jpeg?width=2000&amp;format=webply&amp;optimize=medium" media="(min-width: 600px)">
                            <source type="image/webp" srcset="./media_15ba2b455e29aca38c1ca653d24c40acaec8a008f.jpeg?width=750&amp;format=webply&amp;optimize=medium">
                            <source type="image/jpeg" srcset="./media_15ba2b455e29aca38c1ca653d24c40acaec8a008f.jpeg?width=2000&amp;format=jpeg&amp;optimize=medium" media="(min-width: 600px)">
                            <img loading="eager" alt="Woman looking out over a river." src="./media_15ba2b455e29aca38c1ca653d24c40acaec8a008f.jpeg?width=750&amp;format=jpeg&amp;optimize=medium" width="1600" height="900">
                        </picture>
                    </div>
                </div>
                <div>
                    <div>
                        <h2 id="wknd-adventures">WKND Adventures</h2>
                        <p>Join us on one of our next adventures. Browse our list of curated experiences and sign up for one when you're ready to explore with us.</p>
                        <p class="button-container"><a href="/" title="View trips" class="button">View trips</a></p>
                    </div>
                </div>
            </div>     
            <!-- End block HTML -->
        </div>
    </main>
    <footer/>
</body>
...
```

>[!TAB Hitta DOM]

Om du vill hitta det DOM som ska formateras öppnar du sidan med det ej formaterade blocket i den lokala utvecklingsmiljön, markerar blocket och kontrollerar DOM.

![Inspektera block-DOM](./assets/7a-block-css/inspect-block-dom.png)

>[!ENDTABS]

## Blockera CSS

Skapa en ny CSS-fil i blockets mapp med blockets namn som filnamn. För blocket **teaser** finns filen till exempel på `/blocks/teaser/teaser.css`.

Den här CSS-filen läses in automatiskt när Edge Delivery Services JavaScript upptäcker ett DOM-element på sidan som representerar ett teaser-block.

[!BADGE /blocks/teaser/teaser.css]{type=Neutral tooltip="Filnamn på kodexemplet nedan."}

```css
/* /blocks/teaser/teaser.css */

/* Scope each selector in the block with `.block.teaser` using CSS nesting (https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_nesting) to avoid accidental conflicts outside the block */
.block.teaser {
    animation: teaser-fade-in .6s;
    position: relative;
    width: 1600px;
    max-width: 100vw;
    left: 50%; 
    transform: translateX(-50%);
    height: 500px;
    overflow: hidden; 

    /* The image is rendered to the first div in the block */
    picture {
        position: absolute;
        z-index: -1;
        inset: 0;
        box-sizing: border-box;

        img {
            object-fit: cover;
            object-position: center;
            width: 100%;
            height: 100%;
        }
    }

    /** 
    The teaser's text is rendered to the second (also the last) div in the block.

    These styles are scoped to the second (also the last) div in the block (.block.teaser > div:last-child).

    This div order can be used to target different styles to the same semantic elements in the block. 
    For example, if the block has two images, we could target the first image with `.block.teaser > div:first-child img`, 
    and the second image with `.block.teaser > div:nth-child(2) img`.
    **/
    & > div:last-child {
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        background: var(--background-color);
        padding: 1.5rem 1.5rem 1rem;
        width: 80vw;
        max-width: 1200px;

        /** 
        The following elements reside within `.block.teaser > div:last-child` and could be scoped as such, for example:

        .block.teaser > div:last-child p { .. }

        However since these element can only appear in the second/last div per our block's model, it's unnecessary to add this additional scope.
        **/

        /* Regardless of the authored heading level, we only want one style the heading */
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            font-size: var(--heading-font-size-xl);
            margin: 0;
        }

        h1::after,
        h2::after,
        h3::after,
        h4::after,
        h5::after,
        h6::after {
            border-bottom: 0;
        }

        p {
            font-size: var(--body-font-size-s);
            margin-bottom: 1rem;
        }

        /* Add underlines to links in the text */
        a:hover {
            text-decoration: underline;
        }

        /* Add specific spacing to buttons. These button CSS classes are automatically added by Edge Delivery Services. */
        .button-container {
            margin: 0;
            padding: 0;

            .button {
                background-color: var(--primary-color);
                border-radius: 0;
                color: var(--dark-color);
                font-size: var(--body-font-size-xs);
                font-weight: bold;
                padding: 1em 2.5em;
                margin: 0;
                text-transform: uppercase;
            }
        }
    }
}

/** Animations 
    Scope the @keyframes to the block (teaser) to avoid accidental conflicts outside the block

    Global @keyframes can defines in styles/styles.css and used in this file.
**/

@keyframes teaser-fade-in {
    from {
        opacity: 0;
    }

    to {
        opacity: 1;
    }
}
```

## Förhandsgranskning av utveckling

När CSS-koden skrivs i kodprojektet är det AEM CLI:s funktion att läsa in ändringarna igen, vilket gör det snabbt och enkelt att förstå hur CSS påverkar blocket.

![Endast CSS-förhandsgranskning](./assets/7a-block-css/local-development-preview.png)

## Begränsa koden

Se till att du [ofta lintar](./3-local-development-environment.md#linting) dina kodändringar så att de är rena och konsekventa. Linting hjälper till att fånga upp problem tidigt och minskar den totala utvecklingstiden. Kom ihåg att du inte kan sammanfoga ditt utvecklingsarbete med `main` förrän alla dina problem med linting har åtgärdats!

```bash
# ~/Code/aem-wknd-eds-ue

$ npm run lint:css
```

## Förhandsgranska i Universal Editor

Om du vill visa ändringar i AEM Universal Editor lägger du till, bekräftar och överför dem till Git-databasgrenen som används av den universella redigeraren. Detta steg hjälper till att säkerställa att blockimplementeringen inte stör redigeringsupplevelsen.

```bash
# ~/Code/aem-wknd-eds-ue

$ git add .
$ git commit -m "Add CSS-only implementation for teaser block"
$ git push origin teaser
```

Nu kan du förhandsgranska ändringarna i Universal Editor när du lägger till frågeparametern `?ref=teaser`.

![Teaser in Universal Editor](./assets/7a-block-css/universal-editor-preview.png)
