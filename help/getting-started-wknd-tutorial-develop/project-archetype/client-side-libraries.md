---
title: Bibliotek på klientsidan och arbetsflöde på klientsidan
description: Lär dig hur bibliotek och klientbibliotek används för att distribuera och hantera CSS och JavaScript för en implementering av en Adobe Experience Manager (AEM) Sites. Den här självstudiekursen handlar också om hur modulen ui.front, ett webbpaketprojekt, kan integreras i hela byggprocessen.
sub-product: platser
version: 6.4, 6.5, Cloud Service
type: Tutorial
feature: Kärnkomponenter, AEM projekttyp
topic: Innehållshantering, utveckling
role: Developer
level: Beginner
kt: 4083
thumbnail: 30359.jpg
source-git-commit: 7200601c1b59bef5b1546a100589c757f25bf365
workflow-type: tm+mt
source-wordcount: '3285'
ht-degree: 0%

---


# Bibliotek på klientsidan och arbetsflöde på klientsidan {#client-side-libraries}

Lär dig hur bibliotek och klientbibliotek används för att distribuera och hantera CSS och JavaScript för en implementering av en Adobe Experience Manager (AEM) Sites. Den här självstudiekursen handlar också om hur [ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html)-modulen, ett frikopplat [webbpack](https://webpack.js.org/)-projekt, kan integreras i hela byggprocessen.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

Vi rekommenderar också att du går igenom självstudiekursen [Component Basics](component-basics.md#client-side-libraries) för att förstå grunderna i bibliotek och AEM på klientsidan.

### Startprojekt

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Kolla in grenen `tutorial/client-side-libraries-start` från [GitHub](https://github.com/adobe/aem-guides-wknd)

   ```shell
   $ cd aem-guides-wknd
   $ git checkout tutorial/client-side-libraries-start
   ```

1. Distribuera kodbasen till en lokal AEM med dina Maven-kunskaper:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 lägger du till profilen `classic` till valfritt Maven-kommando.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/client-side-libraries-solution) eller checka ut koden lokalt genom att växla till grenen `tutorial/client-side-libraries-solution`.

## Mål

1. Förstå hur klientbibliotek inkluderas på en sida via en redigerbar mall.
1. Lär dig hur du använder UI.FrontEnd-modulen och en webbpaketsutvecklingsserver för dedikerad front-end-utveckling.
1. Förstå hela arbetsflödet med att leverera kompilerad CSS och JavaScript till en implementering av webbplatser.

## Vad du ska bygga {#what-you-will-build}

I det här kapitlet ska du lägga till några baslinjeformat för WKND-webbplatsen och artikelsidmallen för att få implementeringen närmare [gränssnittets designmodeller](assets/pages-templates/wknd-article-design.xd). Du kommer att använda ett avancerat frontendarbetsflöde för att integrera ett webbpaketprojekt i ett AEM klientbibliotek.

![Slutförda format](assets/client-side-libraries/finished-styles.png)

*Artikelsida med baslinjeformat tillämpade*

## Bakgrund {#background}

Med bibliotek på klientsidan kan du ordna och hantera CSS- och JavaScript-filer som behövs för en AEM Sites-implementering. De grundläggande målen för klientbibliotek och klientbibliotek är:

1. Lagra CSS/JS i små diskreta filer för enklare utveckling och underhåll
1. Hantera beroenden av ramverk från tredje part på ett organiserat sätt
1. Minimera antalet klientförfrågningar genom att sammanfoga CSS/JS till en eller två förfrågningar.

Mer information om hur du använder [klientbibliotek finns här.](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html)

Klientbibliotek har vissa begränsningar. Det viktigaste är ett begränsat stöd för populära språk som Sass, LESS och TypeScript. I självstudiekursen ska vi titta på hur modulen **ui.front** kan hjälpa till att lösa detta.

Distribuera startkodsbasen till en lokal AEM och navigera till [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html). Den här sidan är för närvarande inte formaterad. Vi kommer sedan att implementera bibliotek på klientsidan för WKND-varumärket för att lägga till CSS och Javascript på sidan.

## Biblioteksorganisation på klientsidan {#organization}

Därefter ska vi utforska organisationen av klienter som genereras av [AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html).

![Klientbiblioteksorganisation på hög nivå](./assets/client-side-libraries/high-level-clientlib-organization.png)

*High level chart Biblioteksorganisation på klientsidan och sidinkludering*

>[!NOTE]
>
> Följande biblioteksorganisation på klientsidan genereras av AEM Project Archetype men representerar bara en startpunkt. Hur ett projekt slutligen hanterar och levererar CSS och Javascript till en webbplatsimplementering kan variera dramatiskt baserat på resurser, kompetens och krav.

1. Använd VSCode eller någon annan IDE för att öppna modulen **ui.apps**.
1. Expandera sökvägen `/apps/wknd/clientlibs` om du vill visa de klienter som genereras av typen architype.

   ![Clientlibs in ui.apps](assets/client-side-libraries/four-clientlib-folders.png)

   Vi kommer att undersöka dessa klienter mer ingående nedan.

1. I följande tabell sammanfattas klientbiblioteken. Mer information om [att inkludera klientbibliotek finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/including-clientlibs.html?lang=en#developing).

   | Namn | Beskrivning | Anteckningar |
   |-------------------| ------------| ------|
   | `clientlib-base` | Grundnivån för CSS och JavaScript krävs för att WKND-platsen ska fungera | inbäddar klientlibs för kärnkomponenten |
   | `clientlib-grid` | Genererar den CSS som krävs för att [layoutläget](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/siteandpage/responsive-layout.html) ska fungera. | Brytpunkter för mobiler/surfplattor kan konfigureras här |
   | `clientlib-site` | Innehåller platsspecifikt tema för WKND-webbplatsen | Genereras av modulen `ui.frontend` |
   | `clientlib-dependencies` | Bäddar in eventuella beroenden från tredje part | Genereras av modulen `ui.frontend` |

1. Observera att `clientlib-site` och `clientlib-dependencies` ignoreras från källkontrollen. Detta är utformat eftersom dessa genereras vid byggtiden av modulen `ui.frontend`.

## Uppdatera basformat {#base-styles}

Uppdatera sedan basformaten som definierats i modulen **[ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html)**. Filerna i modulen `ui.frontend` genererar de `clientlib-site` och `clientlib-dependecies` bibliotek som innehåller platstemat och eventuella beroenden från tredje part.

Bibliotek på klientsidan har vissa begränsningar när det gäller stöd för språk som [Sass](https://sass-lang.com/) eller [TypeScript](https://www.typescriptlang.org/). Det finns ett antal verktyg med öppen källkod som [NPM](https://www.npmjs.com/) och [webpack](https://webpack.js.org/) som snabbar upp och optimerar frontendutvecklingen. Målet med modulen **ui.front** är att kunna använda dessa verktyg för att hantera de flesta källfiler i frontend.

1. Öppna modulen **ui.front** och navigera till `src/main/webpack/site`.
1. Öppna filen `main.scss`

   ![main.scss - entrypoint](assets/client-side-libraries/main-scss.png)

   `main.scss` är startpunkten till alla Sass-filer i  `ui.frontend` modulen. Den kommer att innehålla filen `_variables.scss`, som innehåller en serie varumärkesvariabler som ska användas i olika Sass-filer i projektet. Filen `_base.scss` ingår också och definierar vissa grundläggande format för HTML-element. Ett reguljärt uttryck innehåller alla format för enskilda komponentformat under `src/main/webpack/components`. Ett annat reguljärt uttryck innehåller alla filer under `src/main/webpack/site/styles`.

1. 
   1. Inspect filen `main.ts`. Den innehåller `main.scss` och ett reguljärt uttryck för att samla in alla `.js`- eller `.ts`-filer i projektet. Den här startpunkten används av [webbpaketets konfigurationsfiler](https://webpack.js.org/configuration/) som startpunkt för hela `ui.frontend`-modulen.

1. Inspect filerna under `src/main/webpack/site/styles`:

   ![Formatfiler](assets/client-side-libraries/style-files.png)

   De här filerna formaterar för globala element i mallen, som sidhuvud, sidfot och behållare för huvudinnehåll. CSS-reglerna i de här filerna har olika HTML-element `header`, `main` och `footer` som mål. Dessa HTML-element definierades av principer i det föregående kapitlet [Sidor och mallar](./pages-templates.md).

1. Expandera mappen `components` under `src/main/webpack` och inspektera filerna.

   ![Komponent-Sass-filer](assets/client-side-libraries/component-sass-files.png)

   Varje fil mappar till en kärnkomponent som [dragspelskomponenten](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/accordion.html?lang=en#components). Varje kärnkomponent byggs med [Blockelementsmodifierare](https://getbem.com/) eller BEM-notation för att göra det enklare att rikta in sig på specifika CSS-klasser med formatregler. Filerna under `/components` har grupperats ut av den AEM projektarkitekturen med olika BEM-regler för varje komponent.

1. Ladda ned WKND Base Styles **[wknd-base-styles-src.zip](./assets/client-side-libraries/wknd-base-styles-srcv2.zip)** och **zip** filen.

   ![WKND-basformat](assets/client-side-libraries/wknd-base-styles-unzipped.png)

   För att snabba upp självstudiekursen har vi tillhandahållit flera Sass-filer som implementerar WKND-varumärket baserat på kärnkomponenter och strukturen för artikelsidmallen.

1. Skriv över innehållet i `ui.frontend/src` med filer från föregående steg. Innehållet i zip-filen ska skriva över följande mappar:

   ```plain
   /src/main/webpack
            /base
            /components
            /resources
   ```

   ![Ändrade filer](assets/client-side-libraries/changed-files-uifrontend.png)

   Inspect de ändrade filerna för att se information om implementeringen av WKND-formatet.

## Integrering av Inspect med ui.front {#ui-frontend-integration}

En viktig integrationsbit som är inbyggd i **ui.front**-modulen [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator) tar de kompilerade CSS- och JS-artefakterna från ett webpack-/npm-projekt och omvandlar dem till AEM klientbibliotek.

![Integrering av ui.front-architecture](assets/client-side-libraries/ui-frontend-architecture.png)

AEM Project Archetype konfigurerar automatiskt den här integreringen. Utforska sedan hur det fungerar.


1. Öppna en kommandoradsterminal och installera modulen **ui.front** med kommandot `npm install`:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend
   $ npm install
   ```

   >[!NOTE]
   >
   >`npm install` behöver bara köras en gång efter en ny klon eller generering av projektet.

1. I samma terminal skapar och distribuerar du modulen **ui.front** med kommandot `npm run dev`:

   ```shell
   $ npm run dev
   ```

   >[!CAUTION]
   >
   > Du kan få ett felmeddelande som &quot;ERROR in ./src/main/webpack/site/main.scss&quot;.
   > Det här händer oftast eftersom miljön har ändrats sedan `npm install` kördes.
   > Kör `npm rebuild node-sass` för att åtgärda problemet. Det här inträffar om den version av `npm` som är installerad på den lokala datorn skiljer sig från den version som används av Maven `frontend-maven-plugin` i `aem-guides-wknd/pom.xml`-filen. Du kan korrigera detta permanent genom att ändra versionen i PDF-filen så att den matchar den lokala versionen eller vice versa.

1. Kommandot `npm run dev` bör skapa och kompilera källkoden för WebPack-projektet och slutligen fylla i **clientlib-site** och **clientlib-beroenden** i modulen **ui.apps**.

   >[!NOTE]
   >
   >Det finns också en `npm run prod`-profil som miniatyrerna för JS och CSS. Detta är standardkompileringen när webbpaketsbygget utlöses via Maven. Mer information om modulen [ui.front finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html).

1. Inspect filen `site.css` under `ui.frontend/dist/clientlib-site/site.css`. Detta är den kompilerade CSS-koden som baseras på Sass-källfilerna.

   ![Distribuerad plats-css](assets/client-side-libraries/ui-frontend-dist-site-css.png)

1. Inspect filen `ui.frontend/clientlib.config.js`. Detta är konfigurationsfilen för ett npm-plugin-program, [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator), som omformar innehållet i `/dist` till ett klientbibliotek och flyttar det till modulen `ui.apps`.

1. Inspect filen `site.css` i modulen **ui.apps** på `ui.apps/src/main/content/jcr_root/apps/wknd/clientlibs/clientlib-site/css/site.css`. Detta bör vara en identisk kopia av `site.css`-filen från **ui.front**-modulen. Nu när den finns i **ui.apps**-modulen kan den distribueras till AEM.

   ![ui.apps clientlib-site](assets/client-side-libraries/ui-apps-clientlib-site-css.png)

   >[!NOTE]
   >
   > Eftersom **clientlib-site** kompileras under byggtid med antingen **npm** eller **maven** kan den ignoreras från källkontrollen i modulen **ui.apps**. Inspect filen `.gitignore` under **ui.apps**.

1. Synkronisera `clientlib-site`-biblioteket med en lokal instans av AEM med hjälp av utvecklarverktygen eller Maven-kunskaperna.

   ![Synkronisera Clientlib-plats](assets/client-side-libraries/sync-clientlib-site.png)

1. Öppna LA Skatepark-artikeln i AEM: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html).

   ![Uppdaterade basformat för artikeln](assets/client-side-libraries/updated-base-styles.png)

   Du bör nu se de uppdaterade formaten för artikeln. Du kan behöva göra en hård uppdatering för att rensa alla CSS-filer som har cachelagrats i webbläsaren.

   Det börjar se mycket närmare på mockonerna!

   >[!NOTE]
   >
   > Stegen som utförs ovan för att skapa och distribuera ui.front-koden till AEM körs automatiskt när en Maven-bygge utlöses från projektets rot `mvn clean install -PautoInstallSinglePackage`.

>[!CAUTION]
>
> Det är inte säkert att du behöver använda modulen **ui.front** för alla projekt. Modulen **ui.front** lägger till ytterligare komplexitet och om det inte finns något behov/behov av att använda några av de här avancerade verktygen (Sass, webpack, npm...) kanske den inte behövs.

## Inkludering av sidor och mallar {#page-inclusion}

Sedan tittar vi på hur du refererar till klippen på AEM. Ett vanligt tillvägagångssätt vid webbutveckling är att inkludera CSS i HTML-huvudet `<head>` och JavaScript direkt innan du stänger taggen `</body>`.

1. Navigera till `ui.apps/src/main/content/jcr_root/apps/wknd/components/page` i modulen **ui.apps**.

   ![Struktursidkomponent](assets/client-side-libraries/customheaderlibs-html.png)

   Det här är `page`-komponenten som används för att återge alla sidor i WKND-implementeringen.

1. Öppna filen `customheaderlibs.html`. Observera raderna `${clientlib.css @ categories='wknd.base'}`. Detta anger att CSS för klientlib med kategorin `wknd.base` kommer att inkluderas via den här filen, vilket innebär att **klientlib-base** inkluderas i sidhuvudet på alla våra sidor.

1. Uppdatera `customheaderlibs.html` om du vill ta med en referens till Google-teckensnittsformat som vi angav tidigare i modulen **ui.front**.

   ```html
   <link href="//fonts.googleapis.com/css?family=Source+Sans+Pro:400,600|Asar&display=swap" rel="stylesheet">
   <sly data-sly-use.clientLib="/libs/granite/sightly/templates/clientlib.html"
    data-sly-call="${clientlib.css @ categories='wknd.base'}"/>
   
   <!--/* Include Context Hub */-->
   <sly data-sly-resource="${'contexthub' @ resourceType='granite/contexthub/components/contexthub'}"/>
   ```

1. Inspect filen `customfooterlibs.html`. Den här filen, som `customheaderlibs.html`, ska skrivas över av implementeringsprojekt. Här betyder raden `${clientlib.js @ categories='wknd.base'}` att JavaScript från **clientlib-base** kommer att inkluderas längst ned på alla våra sidor.

1. Exportera `page`-komponenten till AEM med utvecklarverktygen eller med dina Maven-kunskaper.

1. Bläddra till mallen Artikelsida på [http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html](http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html)

1. Klicka på ikonen **Sidinformation** och välj **Sidprofil** på menyn för att öppna dialogrutan **Sidprofil**.

   ![Artikelsidmallens menysidpolicy](assets/client-side-libraries/template-page-policy.png)

   *Sidinformation > Sidprofil*

1. Observera att kategorierna för `wknd.dependencies` och `wknd.site` listas här. Som standard delas klienten som konfigurerats via sidprincipen upp så att CSS inkluderas i sidhuvudet och JavaScript i brödtexten. Om du vill kan du explicit ange att clientlib JavaScript ska läsas in i sidhuvudet. Detta är fallet för `wknd.dependencies`.

   ![Artikelsidmallens menysidpolicy](assets/client-side-libraries/template-page-policy-clientlibs.png)

   >[!NOTE]
   >
   > Det går också att referera till `wknd.site` eller `wknd.dependencies` från sidkomponenten direkt med hjälp av skriptet `customheaderlibs.html` eller `customfooterlibs.html`, vilket visades tidigare för klientlib `wknd.base`. Mallen ger viss flexibilitet så att du kan välja vilka klipp som ska användas per mall. Om du t.ex. har ett mycket stort JavaScript-bibliotek som bara ska användas på en vald mall.

1. Navigera till sidan **LA Skateparks** som skapats med **Artikelsidmall**: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html). Du bör se en skillnad i teckensnitt.

1. Klicka på ikonen **Sidinformation** och välj **Visa som publicerad** på menyn för att öppna artikelsidan utanför AEM redigerare.

   ![Visa som publicerad](assets/client-side-libraries/view-as-published-article-page.png)

1. Visa sidkällan för [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled) och du bör kunna se följande klientreferenser i `<head>`:

   ```html
   <head>
   ...
   <link href="//fonts.googleapis.com/css?family=Source+Sans+Pro:400,600|Asar&display=swap" rel="stylesheet"/>
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-base.min.css" type="text/css">
   <script type="text/javascript" src="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.min.js"></script>
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.min.css" type="text/css">
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-site.min.css" type="text/css">
   ...
   </head>
   ```

   Observera att klientlibs använder proxyslutpunkten `/etc.clientlibs`. Du bör även se följande klickbara objekt längst ned på sidan:

   ```html
   ...
   <script type="text/javascript" src="/etc.clientlibs/wknd/clientlibs/clientlib-site.min.js"></script>
   <script type="text/javascript" src="/etc.clientlibs/wknd/clientlibs/clientlib-base.min.js"></script>
   ...
   </body>
   ```

   >[!NOTE]
   >
   > Om du fortsätter på 6.5/6.4 minimeras inte klientsidans bibliotek automatiskt. Se dokumentationen för [HTML-bibliotekshanteraren för att aktivera minimering (rekommenderas)](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html?lang=en#using-preprocessors).

   >[!WARNING]
   >
   >På publiceringssidan är det viktigt att klientbiblioteken **inte** hanteras från **/appar** eftersom sökvägen bör begränsas av säkerhetsskäl med [filteravsnittet](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#example-filter-section). Egenskapen [allowProxy](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html#locating-a-client-library-folder-and-using-the-proxy-client-libraries-servlet) i klientbiblioteket ser till att CSS och JS hanteras från **/etc.clientlibs**.

## Webpack DevServer - statisk kod {#webpack-dev-static}

Under de föregående övningarna kunde vi uppdatera flera Sass-filer i modulen **ui.front** och genom en byggprocess kan vi slutligen se dessa ändringar återspeglas i AEM. Därefter ska vi titta på en teknik som använder en [webpack-dev-server](https://webpack.js.org/configuration/dev-server/) för att snabbt utveckla våra front end-format mot **statisk** HTML.

Den här tekniken är användbar om huvuddelen av formaten och frontkodningen kommer att utföras av en dedikerad Front End-utvecklare som kanske inte har enkel åtkomst till en AEM. Med den här tekniken kan FED även göra ändringar direkt i HTML-koden, som sedan kan skickas vidare till en AEM som ska implementeras som komponenter.

1. Kopiera sidkällan för LA-skateparkartikelsidan på [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled).
1. Öppna utvecklingsmiljön igen. Klistra in den kopierade markeringen från AEM i `index.html` i modulen **ui.front** under `src/main/webpack/static`.
1. Redigera den kopierade koden och ta bort alla referenser till **clientlib-site** och **clientlib-beroenden**:

   ```html
   <!-- remove -->
   <script type="text/javascript" src="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.js"></script>
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.css" type="text/css">
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-site.css" type="text/css">
   ...
   <script type="text/javascript" src="/etc.clientlibs/wknd/clientlibs/clientlib-site.js"></script>
   ```

   Vi kan ta bort dessa referenser eftersom webbpaketets dev-server genererar dessa artefakter automatiskt.

1. Starta webbpaketets dev-server från en ny terminal genom att köra följande kommando i modulen **ui.front**:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend/
   $ npm start
   
   > aem-maven-archetype@1.0.0 start code/aem-guides-wknd/ui.frontend
   > webpack-dev-server --open --config ./webpack.dev.js
   ```

1. Då öppnas ett nytt webbläsarfönster på [http://localhost:8080/](http://localhost:8080/) med statisk kod.

1. Redigera filen `src/main/webpack/site/_variables.scss`. Ersätt `$text-color`-regeln med följande:

   ```diff
   - $text-color:              $black;
   + $text-color:              $pink;
   ```

   Spara ändringarna.

1. Du bör automatiskt se ändringarna återspeglas i webbläsaren på [http://localhost:8080](http://localhost:8080).

   ![Ändringar av server för lokal webbpaketsdev](assets/client-side-libraries/local-webpack-dev-server.png)

1. Granska `/aem-guides-wknd.ui.frontend/webpack.dev.js`-filen. Detta innehåller webbpaketskonfigurationen som används för att starta webbpack-dev-servern. Observera att sökvägarna `/content` och `/etc.clientlibs` proxies från en lokal instans av AEM. Så här blir bilderna och andra klientlibs (som inte hanteras av **ui.front**-koden) tillgängliga.

   >[!CAUTION]
   >
   > Den statiska markeringens bildresurs pekar på en aktiv bildkomponent i en lokal AEM. Bilderna kommer att visas som brutna om sökvägen till bilden ändras, om AEM inte startas eller om webbläsaren inte har loggat in i den lokala AEM. Om du lämnar över till en extern resurs är det också möjligt att ersätta bilderna med statiska referenser.

1. Du kan **stoppa** webbpaketservern från kommandoraden genom att skriva `CTRL+C`.

## Webpack DevServer - Titta och synka {#webpack-dev-watch}

En annan teknik är att Node.js ska bevaka om några filändringar har gjorts i src-filerna i modulen `ui.frontend`. När en fil ändras kompilerar den snabbt klientbiblioteket och använder modulen [aemsync](https://www.npmjs.com/package/aemsync) npm för att synkronisera ändringarna till en AEM som körs.

1. Starta webbpaketets dev-server i **övervakningsläget** från en ny terminal genom att köra följande kommando i modulen **ui.front**:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend/
   $ npm run watch
   ```

1. Detta kompilerar `src`-filerna och synkroniserar ändringarna med AEM på [http://localhost:4502](http://localhost:4502)

   ```shell
   + jcr_root/apps/wknd/clientlibs/clientlib-site/js/site.js
   + jcr_root/apps/wknd/clientlibs/clientlib-site/js
   + jcr_root/apps/wknd/clientlibs/clientlib-site
   + jcr_root/apps/wknd/clientlibs/clientlib-dependencies/css.txt
   + jcr_root/apps/wknd/clientlibs/clientlib-dependencies/js.txt
   + jcr_root/apps/wknd/clientlibs/clientlib-dependencies
   http://admin:admin@localhost:4502 > OK
   + jcr_root/apps/wknd/clientlibs/clientlib-site/css
   + jcr_root/apps/wknd/clientlibs/clientlib-site/js/site.js
   http://admin:admin@localhost:4502 > OK
   ```

1. Navigera till AEM och LA Skateparks-artikeln: [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled)

   ![Ändringar som distribueras till AEM](assets/client-side-libraries/changes-deployed-aem-watch.png)

   Ändringarna ska distribueras till AEM. Det är en liten fördröjning och du måste uppdatera webbläsaren manuellt för att kunna se uppdateringarna. Det är emellertid bra att visa ändringarna direkt i AEM om du arbetar med nya komponenter och redigering av dialogrutor.

1. Återställ ändringen till `_variables.scss` och spara ändringarna. Ändringarna ska synkroniseras igen med den lokala instansen av AEM efter en liten fördröjning.

1. Stoppa webbpaketets dev-server och utför en fullständig version av Maven från projektets rot:

   ```shell
   $ cd aem-guides-wknd
   $ mvn clean install -PautoInstallSinglePackage
   ```

   Återigen kompileras modulen `ui.frontend`, omformas till klientbibliotek och distribueras till AEM via modulen `ui.apps`. Men den här gången utför Maven allt för oss.

## Grattis! {#congratulations}

Grattis! Artikelsidan har nu några konsekventa format som matchar WKND-varumärket och du har blivit bekant med **ui.front**-modulen!

### Nästa steg {#next-steps}

Lär dig hur du implementerar enskilda format och återanvänder kärnkomponenter med Experience Manager Style System. [Utveckla med Style ](style-system.md) System: Använda Style System för att utöka grundkomponenterna med varumärkesspecifik CSS och avancerade principkonfigurationer i Template Editor.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/client-side-libraries-solution`.

1. Klona [github.com/adobe/aem-wknd-guides](https://github.com/adobe/aem-guides-wknd)-databasen.
1. Kolla in grenen `tutorial/client-side-libraries-solution`.

## Ytterligare verktyg och resurser {#additional-resources}

### aemfed {#develop-aemfed}

[**aemfedis är ett kommandoradsverktyg**](https://aemfed.io/) med öppen källkod som kan användas för att snabba upp framände-utvecklingen. Den drivs av [aemsync](https://www.npmjs.com/package/aemsync), [Browsersync](https://www.npmjs.com/package/browser-sync) och [Sling Log Tracer](https://sling.apache.org/documentation/bundles/log-tracers.html).

På en hög nivå **är** utformad för att lyssna på filändringar i modulen **ui.apps** och synkroniserar dem automatiskt direkt till en AEM som körs. Baserat på ändringarna uppdateras en lokal webbläsare automatiskt, vilket snabbar upp framtagningen. Den är även utformad för att fungera med Sling Log Tracer för att automatiskt visa eventuella serverfel direkt i terminalen.

Om du gör mycket arbete i **ui.apps**-modulen, ändrar HTML-skript och skapar anpassade komponenter kan **aemfed** vara ett mycket kraftfullt verktyg att använda. [Fullständig dokumentation finns här.](https://github.com/abmaonline/aemfed).

### Felsöka bibliotek på klientsidan {#debugging-clientlibs}

Olika metoder i **kategorierna** och **bäddar in** för att inkludera flera klientbibliotek. Det kan vara besvärligt att felsöka. AEM visar flera verktyg som kan hjälpa dig med detta. Ett av de viktigaste verktygen är **Återskapa klientbibliotek** som tvingar AEM att kompilera om LESS-filer och generera CSS.

* [**Dumpbibliotek**](http://localhost:4502/libs/granite/ui/content/dumplibs.html)  - Visar en lista över alla klientbibliotek som registrerats i AEM.  `<host>/libs/granite/ui/content/dumplibs.html`

* [**Testa utdata**](http://localhost:4502/libs/granite/ui/content/dumplibs.test.html)  - gör att en användare kan se förväntade HTML-utdata från clientlib includes baserat på kategori.  `<host>/libs/granite/ui/content/dumplibs.test.html`

* [**Validering**](http://localhost:4502/libs/granite/ui/content/dumplibs.validate.html)  av biblioteksberoenden - markerar beroenden eller inbäddade kategorier som inte kan hittas.  `<host>/libs/granite/ui/content/dumplibs.validate.html`

* [**Återskapa klientbibliotek**](http://localhost:4502/libs/granite/ui/content/dumplibs.rebuild.html)  - gör att en användare kan tvinga AEM att återskapa alla klientbibliotek eller göra cachen i klientbiblioteken ogiltig. Det här verktyget är särskilt effektivt när du utvecklar med LESS eftersom det kan tvinga AEM att kompilera om den genererade CSS-koden. I allmänhet är det effektivare att validera cacheminnen och sedan utföra en siduppdatering jämfört med att återskapa alla bibliotek. `<host>/libs/granite/ui/content/dumplibs.rebuild.html`

![återskapa klientbibliotek](assets/client-side-libraries/rebuild-clientlibs.png)
