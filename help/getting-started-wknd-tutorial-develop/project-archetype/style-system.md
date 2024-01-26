---
title: Utveckla med Style System
description: Lär dig hur du implementerar enskilda format och återanvänder kärnkomponenter med Experience Manager Style System. I den här självstudien beskrivs hur du utvecklar för Style System för att utöka grundkomponenterna med varumärkesspecifik CSS och avancerade principkonfigurationer för mallredigeraren.
version: 6.5, Cloud Service
feature: Core Components, Style System
topic: Content Management, Development
role: Developer
level: Beginner
jira: KT-4128
mini-toc-levels: 1
thumbnail: 30386.jpg
doc-type: Tutorial
exl-id: 5b490132-cddc-4024-92f1-e5c549afd6f1
recommendations: noDisplay, noCatalog
duration: 462
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1555'
ht-degree: 0%

---

# Utveckla med Style System {#developing-with-the-style-system}

Lär dig hur du implementerar enskilda format och återanvänder kärnkomponenter med Experience Manager Style System. I den här självstudien beskrivs hur du utvecklar för Style System för att utöka grundkomponenterna med varumärkesspecifik CSS och avancerade principkonfigurationer för mallredigeraren.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

Vi rekommenderar även att du granskar [Bibliotek på klientsidan och frontendarbetsflöde](client-side-libraries.md) självstudiekurser för att förstå grunderna i klientbibliotek och de olika front end-verktygen som är inbyggda i AEM.

### Startprojekt

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Kolla in `tutorial/style-system-start` förgrening från [GitHub](https://github.com/adobe/aem-guides-wknd)

   ```shell
   $ cd aem-guides-wknd
   $ git checkout tutorial/style-system-start
   ```

1. Distribuera kodbasen till en lokal AEM med dina Maven-kunskaper:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 ska du lägga till `classic` för alla Maven-kommandon.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/style-system-solution) eller checka ut koden lokalt genom att växla till grenen `tutorial/style-system-solution`.

## Syfte

1. Lär dig hur du använder Style System för att tillämpa varumärkesspecifik CSS på AEM kärnkomponenter.
1. Lär dig mer om BEM-notation och hur det kan användas för att skapa mer detaljerade omfång för format.
1. Använd avancerade principkonfigurationer med redigerbara mallar.

## Vad du ska bygga {#what-build}

I det här kapitlet används [Style System-funktion](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/page-authoring/style-system-feature-video-use.html) för att skapa variationer av **Titel** och **Text** komponenter som används på artikelsidan.

![Tillgängliga format för titel](assets/style-system/styles-added-title.png)

*Understrykningsformat som kan användas för komponenten Title*

## Bakgrund {#background}

The [Formatsystem](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/siteandpage/style-system.html) gör att utvecklare och mallredigerare kan skapa flera visuella varianter av en komponent. Författare kan sedan i sin tur bestämma vilket format som ska användas när en sida disponeras. Style System används i resten av självstudiekursen för att uppnå flera unika format när du använder kärnkomponenter i en lågkodsstrategi.

Den allmänna idén med Style System är att författare kan välja olika stilar för hur en komponent ska se ut. &quot;Styles&quot; backas upp av ytterligare CSS-klasser som injiceras i en komponents yttre div. I klientbiblioteken läggs CSS-regler till baserat på dessa formatklasser så att komponenten ändrar utseende.

Du kan hitta [utförlig dokumentation om Style System här](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/features/style-system.html). Det finns också en [teknisk video för att förstå Style System](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/developing/style-system-technical-video-understand.html).

## Understrykningsformat - rubrik {#underline-style}

The [Titelkomponent](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/title.html) har proxynerats in i det projekt som `/apps/wknd/components/title` som en del av **ui.apps** -modul. Standardformat för rubrikelement (`H1`, `H2`, `H3`...) redan har implementerats i **ui.front** -modul.

The [WKND Artikeldesign](assets/pages-templates/wknd-article-design.xd) innehåller ett unikt format för komponenten Title med en understrykning. I stället för att skapa två komponenter eller ändra komponentdialogrutan kan du använda Style System för att ge författarna möjlighet att lägga till ett understruket format.

![Understrykningsformat - titelkomponent](assets/style-system/title-underline-style.png)

### Lägg till en titelprincip

Låt oss lägga till en princip för rubrikkomponenterna så att innehållsförfattare kan välja understrykningsformatet som ska användas för specifika komponenter. Detta görs med mallredigeraren i AEM.

1. Navigera till **Artikelsida** mall från: [http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html](http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html)

1. I **Struktur** läge, i huvudläget **Layoutbehållare** väljer du **Policy** -ikonen bredvid **Titel** som anges under *Tillåtna komponenter*:

   ![Konfiguration av titelprincip](assets/style-system/article-template-title-policy-icon.png)

1. Skapa en profil för komponenten Title med följande värden:

   *Principtitel&#42;*: **WKND**

   *Egenskaper* > *Fliken Format* > *Lägga till ett nytt format*

   **Understruken** : `cmp-title--underline`

   ![Formatprincipkonfiguration för titel](assets/style-system/title-style-policy.png)

   Klicka **Klar** om du vill spara ändringarna i titelprincipen.

   >[!NOTE]
   >
   > Värdet `cmp-title--underline` fyller i CSS-klassen på den yttre diven för komponentens HTML-kod.

### Använda understrykningsformat

Som författare kan vi använda understrykningsformatet på vissa rubrikkomponenter.

1. Navigera till **La Skateparks** artikel i AEM Sites Editor på: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html)
1. I **Redigera** väljer du en titelkomponent. Klicka på **pensel** -ikonen och välj **Understruken** format:

   ![Använda understrykningsformat](assets/style-system/apply-underline-style-title.png)

   >[!NOTE]
   >
   > Vid den här tidpunkten sker ingen synlig förändring som `underline` stilen har inte implementerats. I nästa övning implementeras den här stilen.

1. Klicka på **Sidinformation** ikon > **Visa som publicerad** för att inspektera sidan utanför AEM redigerare.
1. Använd webbläsarutvecklarverktygen för att verifiera att markeringen runt komponenten Title har CSS-klassen `cmp-title--underline` som används på den yttre diven.

   ![Div med understruken klass tillämpad](assets/style-system/div-underline-class-applied.png)

   ```html
   <div class="title cmp-title--underline">
       <div data-cmp-data-layer="{&quot;title-b6450e9cab&quot;:{&quot;@type&quot;:&quot;wknd/components/title&quot;,&quot;repo:modifyDate&quot;:&quot;2022-02-23T17:34:42Z&quot;,&quot;dc:title&quot;:&quot;Vans Off the Wall Skatepark&quot;}}" 
       id="title-b6450e9cab" class="cmp-title">
           <h2 class="cmp-title__text">Vans Off the Wall Skatepark</h2>
       </div>
   </div>
   ```

### Implementera understrykning - ui.front

Implementera sedan understrykningsformatet med **ui.front** modulen i AEM. Webbpaketets utvecklingsserver som medföljer **ui.front** för att förhandsgranska formaten *före* distribuering till en lokal instans av AEM används.

1. Starta `watch` från **ui.front** modul:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend/
   $ npm run watch
   ```

   Detta startar en process som övervakar ändringar i `ui.frontend` och synkronisera ändringarna till AEM.


1. Returnera din utvecklingsmiljö och öppna filen `_title.scss` från: `ui.frontend/src/main/webpack/components/_title.scss`.
1. Lägg in en ny regel för `cmp-title--underline` klass:

   ```scss
   /* Default Title Styles */
   .cmp-title {}
   .cmp-title__text {}
   .cmp-title__link {}
   
   /* Add Title Underline Style */
   .cmp-title--underline {
       .cmp-title__text {
           &:after {
           display: block;
               width: 84px;
               padding-top: 8px;
               content: '';
               border-bottom: 2px solid $brand-primary;
           }
       }
   }
   ```

   >[!NOTE]
   >
   >Det anses vara en bra rutin att alltid ha tätt omfång av format till målkomponenten. Detta säkerställer att extra format inte påverkar andra delar av sidan.
   >
   >Alla kärnkomponenter följer **[BEM-notation](https://github.com/adobe/aem-core-wcm-components/wiki/css-coding-conventions)**. Det är bäst att ha den yttre CSS-klassen som mål när du skapar ett standardformat för en komponent. Ett annat bra tillvägagångssätt är att ange klassnamn som anges av BEM-notationen för kärnkomponenten i stället för HTML-element som mål.

1. Återgå till webbläsaren och AEM. Du ser att understrykningsformatet har lagts till:

   ![Understrykningsformat som visas på webbpaketets dev-server](assets/style-system/underline-implemented-webpack.png)

1. I AEM Editor bör du nu kunna aktivera och inaktivera **Understruken** och se hur ändringarna visas.

## Blockformat för citat - text {#text-component}

Upprepa sedan liknande steg för att tillämpa ett unikt format på [Textkomponent](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/text.html). Textkomponenten har proxiderats in i projektet under `/apps/wknd/components/text` som en del av **ui.apps** -modul. Standardformaten för styckeelement har redan implementerats i **ui.front**.

The [WKND Artikeldesign](assets/pages-templates/wknd-article-design.xd) innehåller ett unikt format för Text-komponenten med ett citattecken:

![Blockformat för citat - textkomponent](assets/style-system/quote-block-style.png)

### Lägg till en textprofil

Lägg sedan till en profil för textkomponenterna.

1. Navigera till **Artikelsidmall** från: [http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html](http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html).

1. I **Struktur** läge, i huvudläget **Layoutbehållare** väljer du **Policy** -ikonen bredvid **Text** som anges under *Tillåtna komponenter*:

   ![Konfigurera textprofil](assets/style-system/article-template-text-policy-icon.png)

1. Uppdatera Text-komponentprincipen med följande värden:

   *Principtitel&#42;*: **Innehållstext**

   *Plugins* > *Styckeformat* > *Aktivera styckeformat*

   *Fliken Format* > *Lägga till ett nytt format*

   **Offertblock** : `cmp-text--quote`

   ![Princip för textkomponent](assets/style-system/text-policy-enable-paragraphstyles.png)

   ![Textkomponentprincip 2](assets/style-system/text-policy-enable-quotestyle.png)

   Klicka **Klar** om du vill spara ändringarna i textprofilen.

### Använda formatet Offertblock

1. Navigera till **La Skateparks** artikel i AEM Sites Editor på: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html)
1. I **Redigera** väljer du en textkomponent. Redigera komponenten för att inkludera ett citattecken-element:

   ![Konfiguration av textkomponent](assets/style-system/configure-text-component.png)

1. Markera textkomponenten och klicka på **pensel** -ikonen och välj **Offertblock** format:

   ![Använda formatet Offertblock](assets/style-system/quote-block-style-applied.png)

1. Använd webbläsarens utvecklingsverktyg för att inspektera markeringen. Klassnamnet ska visas `cmp-text--quote` har lagts till i komponentens yttre div:

   ```html
   <!-- Quote Block style class added -->
   <div class="text cmp-text--quote">
       <div data-cmp-data-layer="{&quot;text-60910f4b8d&quot;:{&quot;@type&quot;:&quot;wknd/components/text&quot;,&quot;repo:modifyDate&quot;:&quot;2022-02-24T00:55:26Z&quot;,&quot;xdm:text&quot;:&quot;<blockquote>&amp;nbsp; &amp;nbsp; &amp;nbsp;&amp;quot;There is no better place to shred then Los Angeles&amp;quot;</blockquote>\r\n<p>- Jacob Wester, Pro Skater</p>\r\n&quot;}}" id="text-60910f4b8d" class="cmp-text">
           <blockquote>&nbsp; &nbsp; &nbsp;"There is no better place to shred then Los Angeles"</blockquote>
           <p>- Jacob Wester, Pro Skater</p>
       </div>
   </div>
   ```

### Implementera formatet Offertblock - ui.front

Låt oss implementera formatet Citatblock med **ui.front** modulen i AEM.

1. Om den inte redan körs startar du `watch` från **ui.front** modul:

   ```shell
   $ npm run watch
   ```

1. Uppdatera filen `text.scss` från: `ui.frontend/src/main/webpack/components/_text.scss`:

   ```css
   /* Default text style */
   .cmp-text {}
   .cmp-text__paragraph {}
   
   /* WKND Text Quote style */
   .cmp-text--quote {
       .cmp-text {
           background-color: $brand-third;
           margin: 1em 0em;
           padding: 1em;
   
           blockquote {
               border: none;
               font-size: $font-size-large;
               font-family: $font-family-serif;
               padding: 14px 14px;
               margin: 0;
               margin-bottom: 0.5em;
   
               &:after {
                   border-bottom: 2px solid $brand-primary; /*yellow border */
                   content: '';
                   display: block;
                   position: relative;
                   top: 0.25em;
                   width: 80px;
               }
           }
           p {
               font-family:  $font-family-serif;
           }
       }
   }
   ```

   >[!CAUTION]
   >
   > I det här fallet används formaten som mål för element i Raw-HTML. Det beror på att komponenten Text har en RTF-redigerare för innehållsförfattare. Du bör skapa format direkt mot RTE-innehåll med försiktighet och det är ännu viktigare att formaten är täta.

1. Återgå till webbläsaren en gång till och se att blockformatet Offert har lagts till:

   ![Blockformat för citat visas](assets/style-system/quoteblock-implemented.png)

1. Stoppa webbpaketets utvecklingsserver.

## Fast bredd - behållare (Bonus) {#layout-container}

Behållarkomponenter har använts för att skapa artikelsidmallens grundläggande struktur och ange släppzoner där innehållsförfattare kan lägga till innehåll på en sida. Behållare kan också använda Style System, vilket ger innehållsförfattare ännu fler alternativ för att utforma layouter.

The **Huvudbehållare** i artikelsidmallen innehåller de två skrivbara behållarna med fast bredd.

![Huvudbehållare](assets/style-system/main-container-article-page-template.png)

*Huvudbehållare i artikelsidmallen*.

Policyn för **Huvudbehållare** anger standardelementet som `main`:

![Princip för huvudbehållare](assets/style-system/main-container-policy.png)

Den CSS som skapar **Huvudbehållare** fast är inställt i **ui.front** modulen vid `ui.frontend/src/main/webpack/site/styles/container_main.scss` :

```SCSS
main.container {
    padding: .5em 1em;
    max-width: $max-content-width;
    float: unset!important;
    margin: 0 auto!important;
    clear: both!important;
}
```

Istället för att målinrikta `main` Formatsystemet kan användas för att skapa ett HTML-element **Fast bredd** som en del av behållarprincipen. Formatsystemet kan ge användarna möjlighet att växla mellan **Fast bredd** och **Flytande bredd** behållare.

1. **Bonus Challenge** - använda lärdomar från tidigare övningar och använda Style System för att implementera en **Fast bredd** och **Flytande bredd** stilar för behållarkomponenten.

## Grattis! {#congratulations}

Artikelsidan är nästan formaterad och du har fått en praktisk upplevelse med AEM Style System.

### Nästa steg {#next-steps}

Lär dig stegen från början till slut för att skapa en [anpassad AEM](custom-component.md) som visar innehåll som har skapats i en dialogruta och utforskar utvecklingen av en segmentmodell för att kapsla in affärslogik som fyller i komponentens HTML-kod.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/style-system-solution`.

1. Klona [github.com/adobe/aem-wknd-guides](https://github.com/adobe/aem-guides-wknd) databas.
1. Kolla in `tutorial/style-system-solution` gren.
