---
title: Lägg till webbplatsmärkning
description: Definiera global CSS, CSS-variabler och webbteckensnitt för en Edge Delivery Services-webbplats.
version: Experience Manager as a Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Tutorial
jira: KT-15832
duration: 900
exl-id: a5cd9906-7e7a-43dd-a6b2-e80f67d37992
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1315'
ht-degree: 0%

---

# Lägg till webbplatsmärkning

Börja med att konfigurera det övergripande varumärket genom att uppdatera globala format, definiera CSS-variabler och lägga till webbteckensnitt. Dessa grundläggande element säkerställer att webbplatsen är konsekvent och underhållningsbar och att den används på samma sätt på hela webbplatsen.

## Skapa ett GitHub-problem

Om du vill hålla ordning på allt använder du GitHub för att spåra arbetet. Skapa först ett GitHub-problem för den här arbetsuppgifterna:

1. Gå till GitHub-databasen (mer information finns i kapitlet [Skapa ett kodprojekt](./1-new-code-project.md)).
2. Klicka på fliken **Problem** och sedan på **Nytt problem**.
3. Skriv en **titel** och **beskrivning** för det arbete som ska utföras.
4. Klicka på **Skicka nytt utgåva**.

GitHub-utgåvan används senare när [en pull-begäran](#merge-code-changes) skapas.

![GitHub skapa nytt problem](./assets/4-website-branding/github-issues.png)

## Skapa en arbetsgren

För att upprätthålla organisationen och säkerställa kodkvaliteten skapar du en ny gren för varje del av arbetet. Detta förhindrar att ny kod påverkar prestandan negativt och ser till att ändringarna inte är aktiva innan de är klara.

Skapa en gren med namnet `wknd-styles` för det här kapitlet, som fokuserar på webbplatsens grundformat.

```bash
# ~/Code/aem-wknd-eds-ue

$ git checkout -b wknd-styles
```

## Global CSS

Edge Delivery Services använder en global CSS-fil, som finns på `styles/styles.css`, för att konfigurera de gemensamma formaten för hela webbplatsen. `styles.css` styr aspekter som färger, teckensnitt och mellanrum och ser till att allt ser likadant ut på webbplatsen.

Global CSS bör vara agnostisk för konstruktion på lägre nivå, t.ex. block, med fokus på webbplatsens övergripande utseende och känsla samt gemensamma visuella behandlingar.

Tänk på att globala CSS-format kan åsidosättas vid behov.

### CSS-variabler

[CSS-variabler](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties) är ett bra sätt att lagra designinställningar som färger, teckensnitt och storlekar. Genom att använda variabler kan du ändra dessa element på ett ställe och få det uppdaterat på hela webbplatsen.

Så här börjar du med att anpassa CSS-variablerna:

1. Öppna filen `styles/styles.css` i kodredigeraren.
2. Hitta deklarationen `:root`, där globala CSS-variabler lagras.
3. Ändra färg- och teckensnittsvariablerna så att de matchar WKND-varumärket.

Här är ett exempel:


```css
/* styles/styles.css */

:root {
  /* colors */
  --primary-color: rgb(255, 234, 3); /* WKND primary color */
  --secondary-color: rgb(32, 32, 32); /* Secondary brand color */
  --background-color: white; /* Background color */
  --light-color: rgb(235, 235, 235); /* Light background color */
  --dark-color: var(--secondary-color); /* Dark text color */
  --text-color: var(--secondary-color); /* Default text color */
  --link-color: var(--text-color); /* Link color */
  --link-hover-color: black; /* Link hover color */

  /* fonts */
  --heading-font: 'Roboto', sans-serif; /* Heading font */
  --body-font: 'Open Sans', sans-serif; /* Body font */
  --base-font-size: 16px; /* Base font size */
}
```

Utforska de andra variablerna i avsnittet `:root` och granska standardinställningarna.

När du utvecklar en webbplats och märker att du upprepar samma CSS-värden bör du överväga att skapa nya variabler för att göra formaten enklare att hantera. Exempel på andra CSS-egenskaper som kan dra nytta av CSS-variabler är: `border-radius`, `padding`, `margin` och `box-shadow`.

### Bare element

Bare element formateras direkt genom elementnamnet i stället för att använda en CSS-klass. I stället för att formatera en CSS-klass `.page-heading` används till exempel format på elementet `h1` med `h1 { ... }`.

I filen `styles/styles.css` används en uppsättning basformat på osynliga HTML-element. Edge Delivery Services webbplatser prioriterar med oskarpa element eftersom de är i linje med Edge Delivery tjänsts inbyggda semantiska HTML.

Om du vill anpassa dig till WKND-branding kan vi formatera några osynliga element i `styles.css`:

```css
/* styles/styles.css */

...
h2 {
  font-size: var(--heading-font-size-xl); /* Set font size for h2 */
}

/* Add a partial yellow underline under H2 */
h2::after {
  border-bottom: 2px solid var(--primary-color); /* Yellow underline */
  content: "";
  display: block;
  padding-top: 8px;
  width: 84px;
}
...
```

Dessa format säkerställer att `h2`-element, om de inte åsidosätts, formateras konsekvent med WKND-profileringen, vilket gör att en tydlig visuell hierarki kan skapas. Den partiella gula understrykningen under varje `h2` ger rubrikerna en distinkt touch.

### Indragna element

I Edge Delivery Services förbättrar projektets `scripts.js`- och `aem.js`-kod automatiskt specifika Bare HTML-element baserat på deras kontext inom HTML.

Ankarelement (`<a>`) som har skapats på en egen rad, i stället för inline med omgivande text, tolkas som knappar som baseras på det här sammanhanget. Dessa ankare radbryts automatiskt med behållaren `div` med CSS-klassen `button-container` och ankarelementet har en `button` CSS-klass tillagd.

När en länk skapas på en egen rad uppdaterar Edge Delivery Services JavaScript sin DOM till följande:

```html
<p class="button-container">
  <a href="/authored/link" title="Click me" class="button">Click me</a>
</p>
```

Dessa knappar kan anpassas för att matcha WKND-varumärket, vilket anger att knappar visas som gula rektanglar med svart text.

Här är ett exempel på hur du formaterar de &quot;härledda knapparna&quot; i `styles.css`:

```css
/* styles/styles.css */

/* Buttons */
a.button:any-link,
button {
  box-sizing: border-box;
  display: inline-block;
  max-width: 100%;
  margin: 12px 0;
  border: 2px solid transparent;
  padding: 0.5em 1.2em;
  font-family: var(--body-font-family);
  font-style: normal;
  font-weight: 500;
  line-height: 1.25;
  text-align: center;
  text-decoration: none;
  cursor: pointer;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;

  /* WKND specific treatments */
  text-transform: uppercase;
  background-color: var(--primary-color);
  color: var(--dark-color);
  border-radius: 0;
}
```

Denna CSS definierar basknappsformat och innehåller WKND-specifika behandlingar, t.ex. text med versaler, gul bakgrund och svart text. Egenskaperna `background-color` och `color` använder CSS-variabler som gör det möjligt för knappformatet att fortsätta vara justerat efter varumärkets färger. Detta säkerställer att knapparna formateras på ett konsekvent sätt på hela webbplatsen samtidigt som de förblir flexibla.

## Webbteckensnitt

Edge Delivery Services-projekt optimerar användningen av webbteckensnitt för att bibehålla höga prestanda och minimera effekten på poängen i Lightroom. Den här metoden garanterar snabb återgivning utan att webbplatsens visuella identitet äventyras. Så här implementerar du webbteckensnitt effektivt för optimala prestanda.

### Typsnitt

Lägg till anpassade webbteckensnitt med CSS `@font-face`-deklarationer i filen `styles/fonts.css`. Genom att lägga till `@font-faces` i `fonts.css` försäkrar du dig om att webbteckensnitt läses in vid rätt tidpunkt, vilket bidrar till att behålla Lightroom-poängen.

1. Öppna `styles/fonts.css`.
2. Lägg till följande `@font-face`-deklarationer för att inkludera WKND-märkesteckensnitt: `Asar` och `Source Sans Pro`.

```css
/* styles/fonts.css */

@font-face {
  font-family: Asar;
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url("https://fonts.gstatic.com/s/asar/v22/sZlLdRyI6TBIbkEaDZtQS6A.woff2") format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: italic;
  font-weight: 300;
  font-display: swap;
  src: url("https://fonts.gstatic.com/s/sourcesanspro/v22/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZZMkids18S0xR41.woff2") format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: italic;
  font-weight: 400;
  font-display: swap;
  src: url("https://fonts.gstatic.com/s/sourcesanspro/v22/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7nsDJB9cme.woff2") format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: italic;
  font-weight: 600;
  font-display: swap;
  src: url("https://fonts.gstatic.com/s/sourcesanspro/v22/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCds18S0xR41.woff2") format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 300;
  font-display: swap;
  src: url("https://fonts.gstatic.com/s/sourcesanspro/v22/6xKydSBYKcSV-LCoeQqfX1RYOo3ik4zwlxdu3cOWxw.woff2") format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url("https://fonts.gstatic.com/s/sourcesanspro/v22/6xK3dSBYKcSV-LCoeQqfX1RYOo3qOK7lujVj9w.woff2") format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 600;
  font-display: swap;
  src: url("https://fonts.gstatic.com/s/sourcesanspro/v22/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwlxdu3cOWxw.woff2") format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}
```

De teckensnitt som används i den här självstudiekursen kommer från Google Fonts, men webbteckensnitt kan hämtas från alla teckensnittsleverantörer, inklusive [Adobe Fonts](https://fonts.adobe.com/).

+++Använda lokala webbteckensnittsfiler

Du kan också kopiera webbteckensnittsfiler till projekt i mappen `/fonts` och referera till dem i `@font-face` -deklarationerna.

I den här självstudiekursen används webbteckensnitt på fjärrbasis, värdbaserade sådana så att det blir enklare att följa med i utvecklingen.

```css
/* styles/fonts.css */

@font-face { 
    font-family: Asar;
    ...
    src: url("/fonts/asar.woff2") format('woff2'),
    ...
}
```

+++

Uppdatera slutligen CSS-variablerna `styles/styles.css` så att de använder de nya teckensnitten:

```css
/* styles/styles.css */

:root {
    ...
    /* fonts */
    --body-font-family: 'Source Sans Pro', roboto-fallback, sans-serif;
    --heading-font-family: 'Asar', roboto-condensed-fallback, sans-serif;
    ...
}
```

`roboto-fallback` och `roboto-condensed-fallback` är grundteckensnitt som har uppdaterats i avsnittet [Reservteckensnitt](#fallback-fonts) så att de kan justeras för anpassade `Asar`- och `Source Sans Pro`-webbteckensnitt.

### Reservteckensnitt

Webbteckensnitt påverkar ofta prestandan på grund av sin storlek, vilket kan öka poängen för Cumulative Layout Shift (CLS) och minska de totala poängen för Lightroom. För att säkerställa snabb textvisning när webbteckensnitt läses in använder Edge Delivery Services-projekt webbläsarbaserade reservteckensnitt. Det här arbetssättet gör att du får en smidig användarupplevelse medan det önskade teckensnittet används.

Om du vill välja det bästa reservteckensnittet använder du Adobe [Helix Font Fallback Chrome-tillägg](https://www.aem.live/developer/font-fallback) som anger ett teckensnitt som matchar webbläsarna innan det anpassade teckensnittet läses in. De resulterande reservtypsnittsdeklarationerna bör läggas till i filen `styles/styles.css` för att förbättra prestandan och ge användarna en smidig upplevelse.

![Helix Font Fallback Chrome-tillägg](./assets/4-website-branding/font-fallback-chrome-plugin.png){align=center}

Om du vill använda Chrome-tillägget [Helix Font Fallback](https://www.aem.live/developer/font-fallback) kontrollerar du att webbsidan har webbteckensnitt i samma varianter som används på Edge Delivery Services webbplats. I den här självstudien demonstreras tillägget på [wknd.site](http://wknd.site/us/en.html). När du utvecklar en webbplats ska du tillämpa tillägget på den webbplats som du arbetar med i stället för på [wknd.site](http://wknd.site/us/en.html).

```css
/* styles/styles.css */
...

/* fallback fonts */

/* Fallback font for Asar (normal - 400) */
@font-face {
    font-family: "asar-normal-400-fallback";
    size-adjust: 95.7%;
    src: local("Arial");
}

/* Fallback font for Source Sans Pro (normal - 400) */
@font-face {
    font-family: "source-sans-pro-normal-400-fallback";
    size-adjust: 92.9%;
    src: local("Arial");
}

...
```

Lägg till teckensnittsfamiljens namn som reserv i CSS-variablerna för teckensnitt i `styles/styles.css` efter namnen på de&quot;riktiga&quot; teckensnittsfamiljerna.

```css
/* styles/styles.css */

:root {
    ...
    /* fonts */
    --body-font-family: 'Source Sans Pro', source-sans-pro-normal-400-fallback, sans-serif;
    --heading-font-family: 'Asar', asar-normal-400-fallback, sans-serif;
    ...
}
```

## Förhandsgranskning av utveckling

När du lägger till CSS läser AEM CLI:s lokala utvecklingsmiljö automatiskt in ändringarna igen, vilket gör det snabbt och enkelt att se hur CSS påverkar blocket.

![Utvecklingsförhandsgranskning av WKND-varumärkets CSS](./assets/4-website-branding/preview.png)


## Ladda ned färdiga CSS-filer

Du kan hämta de uppdaterade CSS-filerna via länkarna nedan:

* [`styles.css`](https://raw.githubusercontent.com/davidjgonzalez/aem-wknd-eds-ue/refs/heads/main/styles/styles.css)
* [`fonts.css`](https://raw.githubusercontent.com/davidjgonzalez/aem-wknd-eds-ue/refs/heads/main/styles/fonts.css)

## Lint the CSS files

Se till att [ofta granska](./3-local-development-environment.md#linting) dina kodändringar så att de är rena och konsekventa. Linting hjälper dig att fånga upp problem tidigt och minskar den totala utvecklingstiden. Kom ihåg att du inte kan sammanfoga ditt arbete med huvudgrenen förrän alla problem med linting har lösts!

```bash
$ npm run lint:css
```

## Sammanfoga kodändringar

Sammanfoga ändringarna i grenen `main` på GitHub för att skapa framtida arbete med dessa uppdateringar.

```bash
$ git add .
$ git commit -m "Add global CSS, CSS variables, and web fonts"
$ git push origin wknd-styles
```

När ändringarna har skickats till `wknd-styles`-grenen skapar du en pull-begäran på GitHub för att sammanfoga dem i `main`-grenen.

1. Navigera till GitHub-databasen från kapitlet [Skapa ett nytt projekt](./1-new-code-project.md).
2. Klicka på fliken **Pull-begäranden** och välj **Ny pull-begäran**.
3. Ange `wknd-styles` som källgren och `main` som målgren.
4. Granska ändringarna och klicka på **Skapa pull-begäran**.
5. **Lägg till följande** i informationen om pull-begäran:

   ```
   Add basic global CSS, CSS variables, and web fonts (including fallback fonts) to support the WKND brand.
   
   Fix #1
   
   Test URLs:
   - Before: https://main--wknd-aem-eds-ue--davidjgonzalez.aem.live/
   - After: https://wknd-styles--wknd-aem-eds-ue--davidjgonzalez.aem.live/
   ```

   * `Fix #1` refererar till GitHub-problemet som skapades tidigare.
   * Test-URL:erna talar om för AEM Code Sync vilka grenar som ska användas för validering och jämförelse. Efter-URL:en använder arbetsgrenen `wknd-styles` för att kontrollera hur koden påverkar webbplatsens prestanda.

6. Klicka på **Skapa pull-begäran**.
7. Vänta tills [AEM Code Sync GitHub-appen](./1-new-code-project.md) har **slutfört kvalitetskontroller**. Lös felen och kör om kontrollerna om de misslyckas.
8. **Sammanfoga pull-begäran** till `main` när kontrollerna har slutförts.

När ändringarna har sammanfogats med `main` betraktas de inte som distribuerade till produktionen, och ny utveckling kan fortsätta baserat på dessa uppdateringar.
