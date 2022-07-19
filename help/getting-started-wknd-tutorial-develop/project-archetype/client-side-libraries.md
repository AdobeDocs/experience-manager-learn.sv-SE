---
title: Klientbibliotek och frontarbetsflöde
description: Lär dig hur du använder klientbibliotek eller klientbibliotek för att distribuera och hantera CSS och JavaScript för en implementering av Adobe Experience Manager (AEM) Sites. Se hur modulen ui.front, ett webbpaketprojekt, kan integreras i hela byggprocessen.
sub-product: sites
version: 6.4, 6.5, Cloud Service
type: Tutorial
feature: Core Components, AEM Project Archetype
topic: Content Management, Development
role: Developer
level: Beginner
kt: 4083
thumbnail: 30359.jpg
exl-id: 8d3026e9-a7e2-4a76-8a16-a8197a5e04e3
source-git-commit: fb4a39a7b057ca39bc4cd4a7bce02216c3eb634c
workflow-type: tm+mt
source-wordcount: '2878'
ht-degree: 0%

---

# Klientbibliotek och frontarbetsflöde {#client-side-libraries}

Lär dig hur bibliotek och klientbibliotek används för att distribuera och hantera CSS och JavaScript för en implementering av en Adobe Experience Manager (AEM) Sites. Den här självstudiekursen handlar också om hur [ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html) modul, en frikopplad [webbpaket](https://webpack.js.org/) -projektet kan integreras i hela byggprocessen.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

Vi rekommenderar även att du granskar [Grundläggande om komponenter](component-basics.md#client-side-libraries) självstudiekurs för att förstå grunderna i bibliotek och AEM på klientsidan.

### Startprojekt

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Kolla in `tutorial/client-side-libraries-start` förgrening från [GitHub](https://github.com/adobe/aem-guides-wknd)

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
   > Om du använder AEM 6.5 eller 6.4 ska du lägga till `classic` för alla Maven-kommandon.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/client-side-libraries-solution) eller checka ut koden lokalt genom att växla till grenen `tutorial/client-side-libraries-solution`.

## Mål

1. Förstå hur klientbibliotek inkluderas på en sida via en redigerbar mall.
1. Lär dig hur du använder UI.FrontEnd-modulen och en webbpaketsutvecklingsserver för dedikerad front-end-utveckling.
1. Förstå hela arbetsflödet med att leverera kompilerad CSS och JavaScript till en implementering av webbplatser.

## Vad du ska bygga {#what-you-will-build}

I det här kapitlet ska du lägga till några baslinjeformat för WKND-webbplatsen och artikelsidmallen för att få implementeringen närmare [UI-designmodeller](assets/pages-templates/wknd-article-design.xd). Du kommer att använda ett avancerat frontendarbetsflöde för att integrera ett webbpaketprojekt i ett AEM klientbibliotek.

![Slutförda format](assets/client-side-libraries/finished-styles.png)

*Artikelsida med baslinjeformat tillämpade*

## Bakgrund {#background}

Med bibliotek på klientsidan kan du ordna och hantera CSS- och JavaScript-filer som behövs för en AEM Sites-implementering. De grundläggande målen för klientbibliotek och klientbibliotek är:

1. Lagra CSS/JS i små diskreta filer för enklare utveckling och underhåll
1. Hantera beroenden av ramverk från tredje part på ett organiserat sätt
1. Minimera antalet klientförfrågningar genom att sammanfoga CSS/JS till en eller två förfrågningar.

Mer information om hur du använder [Bibliotek på klientsidan finns här.](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html)

Klientbibliotek har vissa begränsningar. Det viktigaste är ett begränsat stöd för populära språk som Sass, LESS och TypeScript. I självstudiekursen ska vi titta på hur **ui.front** modulen kan hjälpa till att lösa detta.

Distribuera startkodsbasen till en lokal AEM och navigera till [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html). Den här sidan är för närvarande inte formaterad. Vi kommer sedan att implementera bibliotek på klientsidan för WKND-varumärket för att lägga till CSS och Javascript på sidan.

## Biblioteksorganisation på klientsidan {#organization}

Därefter ska vi titta närmare på hur de klienter som genereras av [AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html).

![Klientbiblioteksorganisation på hög nivå](./assets/client-side-libraries/high-level-clientlib-organization.png)

*High level chart Biblioteksorganisation på klientsidan och sidinkludering*

>[!NOTE]
>
> Följande biblioteksorganisation på klientsidan genereras av AEM Project Archetype men representerar bara en startpunkt. Hur ett projekt slutligen hanterar och levererar CSS och Javascript till en webbplatsimplementering kan variera dramatiskt baserat på resurser, kompetens och krav.

1. Använd VSCode eller annan IDE för att öppna **ui.apps** -modul.
1. Expandera banan `/apps/wknd/clientlibs` för att visa de klienter som genereras av arketypen.

   ![Clientlibs in ui.apps](assets/client-side-libraries/four-clientlib-folders.png)

   Vi kommer att undersöka dessa klienter mer ingående nedan.

1. I följande tabell sammanfattas klientbiblioteken. Mer information om [inklusive klientbibliotek finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/including-clientlibs.html?lang=en#developing).

   | Namn | Beskrivning | Anteckningar |
   |-------------------| ------------| ------|
   | `clientlib-base` | Grundnivån för CSS och JavaScript krävs för att WKND-platsen ska fungera | inbäddar klientlibs för kärnkomponenten |
   | `clientlib-grid` | Skapar den CSS som krävs för [Layoutläge](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/siteandpage/responsive-layout.html) till jobbet. | Brytpunkter för mobiler/surfplattor kan konfigureras här |
   | `clientlib-site` | Innehåller platsspecifikt tema för WKND-webbplatsen | Genereras av `ui.frontend` modul |
   | `clientlib-dependencies` | Bäddar in eventuella beroenden från tredje part | Genereras av `ui.frontend` modul |

1. Observera att `clientlib-site` och `clientlib-dependencies` ignoreras från källkontrollen. Detta är utformat eftersom dessa genereras vid byggtillfället av `ui.frontend` -modul.

## Uppdatera basformat {#base-styles}

Uppdatera sedan basformaten som definierats i **[ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html)** -modul. Filerna i `ui.frontend` modulen genererar `clientlib-site` och `clientlib-dependecies` bibliotek som innehåller webbplatstemat och eventuella beroenden från tredje part.

Bibliotek på klientsidan har vissa begränsningar när det gäller stöd för språk som [Sass](https://sass-lang.com/) eller [TypeScript](https://www.typescriptlang.org/). Det finns ett antal verktyg med öppen källkod som [NPM](https://www.npmjs.com/) och [webbpaket](https://webpack.js.org/) som snabbar upp och optimerar framtidens utveckling. Målsättningen med **ui.front** ska kunna använda dessa verktyg för att hantera de flesta källfiler i gränssnittet.

1. Öppna **ui.front** och navigera till `src/main/webpack/site`.
1. Öppna filen `main.scss`

   ![main.scss - entrypoint](assets/client-side-libraries/main-scss.png)
klient-side-libraries/main-scss

   `main.scss` är startpunkten till alla Sass-filer i `ui.frontend` -modul. Den kommer att innehålla `_variables.scss` som innehåller en serie varumärkesvariabler som ska användas i olika Sass-filer i projektet. The `_base.scss` -filen ingår också och definierar några grundläggande format för elementen i HTML. Ett reguljärt uttryck innehåller alla format för enskilda komponentformat under `src/main/webpack/components`. Ett annat reguljärt uttryck innehåller alla filer under `src/main/webpack/site/styles`.

1. Inspect filen `main.ts`. Den innehåller `main.scss` och ett reguljärt uttryck för att samla in `.js` eller `.ts` filer i projektet. Den här startpunkten används av [konfigurationsfiler för webbpaket](https://webpack.js.org/configuration/) som startpunkt för hela `ui.frontend` -modul.

1. Inspect filerna under `src/main/webpack/site/styles`:

   ![Formatfiler](assets/client-side-libraries/style-files.png)

   De här filerna formaterar för globala element i mallen, som sidhuvud, sidfot och behållare för huvudinnehåll. CSS-reglerna i de här filerna har olika HTML-element som mål `header`, `main`och  `footer`. De här elementen från HTML definierades av policyer i det föregående kapitlet [Sidor och mallar](./pages-templates.md).

1. Expandera `components` mapp under `src/main/webpack` och inspektera filerna.

   ![Komponent-Sass-filer](assets/client-side-libraries/component-sass-files.png)

   Varje fil mappar till en kärnkomponent som [Dragspelskomponent](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/accordion.html?lang=en#components). Varje kärnkomponent byggs med [Blockelementsmodifierare](https://getbem.com/) eller BEM-notation för att göra det enklare att rikta in sig på specifika CSS-klasser med formatregler. Filerna under `/components` har delats ut av den AEM projekttypen med olika BEM-regler för varje komponent.

1. Ladda ned WKND-basformat **[wknd-base-styles-src-v3.zip](/help/getting-started-wknd-tutorial-develop/project-archetype/assets/client-side-libraries/wknd-base-styles-src-v3.zip)** och **uppzip** filen.

   ![WKND-basformat](assets/client-side-libraries/wknd-base-styles-unzipped.png)

   För att snabba upp självstudiekursen har vi tillhandahållit flera Sass-filer som implementerar WKND-varumärket baserat på kärnkomponenter och strukturen för artikelsidmallen.

1. Skriv över innehållet i `ui.frontend/src` med filer från föregående steg. Innehållet i zip-filen ska skriva över följande mappar:

   ```plain
   /src/main/webpack
            /components
            /resources
            /site
            /static
   ```

   ![Ändrade filer](assets/client-side-libraries/changed-files-uifrontend.png)

   Inspect de ändrade filerna för att se information om implementeringen av WKND-formatet.

## Integrering av Inspect med ui.front {#ui-frontend-integration}

En viktig integrationsbit som är inbyggd i **ui.front** modul, [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator) använder kompilerade CSS- och JS-artefakter från ett webpack/npm-projekt och omvandlar dem till AEM klientbibliotek.

![Integrering av ui.front-architecture](assets/client-side-libraries/ui-frontend-architecture.png)

AEM Project Archetype konfigurerar automatiskt den här integreringen. Utforska sedan hur det fungerar.


1. Öppna en kommandoradsterminal och installera **ui.front** modulen med `npm install` kommando:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend
   $ npm install
   ```

   >[!NOTE]
   >
   >`npm install` behöver bara köras en gång efter en ny klon eller generering av projektet.

1. Starta webbpaketets dev-server i **watch** genom att köra följande kommando:

   ```shell
   $ npm run watch
   ```

1. Detta kompilerar `src` filer i `ui.frontend` och synkronisera ändringarna med AEM på [http://localhost:4502](http://localhost:4502)

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

1. Kommandot `npm run watch` fyller i **clientlib-site** och **clientlib-beroenden** i **ui.apps** som sedan synkroniseras automatiskt med AEM.

   >[!NOTE]
   >
   >Det finns också en `npm run prod` profil som miniatyrbilderna JS och CSS. Detta är standardkompileringen när webbpaketsbygget utlöses via Maven. Mer information om [ui.front-modulen finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html).

1. Inspect filen `site.css` under `ui.frontend/dist/clientlib-site/site.css`. Detta är den kompilerade CSS-koden som baseras på Sass-källfilerna.

   ![Distribuerad plats-css](assets/client-side-libraries/ui-frontend-dist-site-css.png)

1. Inspect filen `ui.frontend/clientlib.config.js`. Detta är konfigurationsfilen för ett npm-plugin-program, [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator) som omformar innehållet i `/dist` till ett klientbibliotek och flyttar det till `ui.apps` -modul.

1. Inspect filen `site.css` i **ui.apps** modulen vid `ui.apps/src/main/content/jcr_root/apps/wknd/clientlibs/clientlib-site/css/site.css`. Detta bör vara en identisk kopia av `site.css` från **ui.front** -modul. Nu när den är i **ui.apps** -modul som den kan distribueras till AEM.

   ![ui.apps clientlib-site](assets/client-side-libraries/ui-apps-clientlib-site-css.png)

   >[!NOTE]
   >
   > Sedan **clientlib-site** kompileras under byggtid, med antingen **npm** eller **maven** kan den ignoreras från källkontrollen i **ui.apps** -modul. Inspect `.gitignore` fil under **ui.apps**.

1. Öppna LA Skatepark-artikeln i AEM: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html).

   ![Uppdaterade basformat för artikeln](assets/client-side-libraries/updated-base-styles.png)

   Du bör nu se de uppdaterade formaten för artikeln. Du kan behöva göra en hård uppdatering för att rensa alla CSS-filer som har cachelagrats i webbläsaren.

   Det börjar se mycket närmare på mockonerna!

   >[!NOTE]
   >
   > Stegen som utförs ovan för att skapa och distribuera ui.front-koden till AEM körs automatiskt när en Maven-bygge utlöses från projektets rot `mvn clean install -PautoInstallSinglePackage`.

## Göra en formatändring

Gör sedan en liten ändring i `ui.frontend` för att se `npm run watch` distribuerar automatiskt formaten till den lokala AEM.

1. I `ui.frontend` för att öppna filen: `ui.frontend/src/main/webpack/site/_variables.scss`.
1. Uppdatera `$brand-primary` färgvariabel:

   ```scsss
   //== variables.css
   
   //== Brand Colors
   $brand-primary:          $pink;
   ```

   Spara ändringarna.

1. Återgå till webbläsaren och uppdatera AEM för att se uppdateringarna:

   ![Klientbibliotek](assets/client-side-libraries/style-update-brand-primary.png)

1. Återställ ändringen till `$brand-primary` färga och stoppa webbpaketet med kommandot `CTRL+C`.

>[!CAUTION]
>
> Användning av **ui.front** kanske inte behövs för alla projekt. The **ui.front** extra komplexitet och om det inte finns något behov/behov av att använda några av de avancerade frontverktygen (Sass, webpack, npm...) kanske det inte behövs.

## Inkludering av sidor och mallar {#page-inclusion}

Sedan tittar vi på hur du refererar till klippen på AEM. Ett vanligt tillvägagångssätt vid webbutveckling är att inkludera CSS i sidhuvudet på HTML `<head>` och JavaScript innan du stänger `</body>` -tagg.

1. Bläddra till artikelsidmallen på [http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html](http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html)

1. Klicka på **Sidinformation** ikon och välj **Sidprofil** för att öppna **Sidprofil** -dialogrutan.

   ![Artikelsidmallens menysidpolicy](assets/client-side-libraries/template-page-policy.png)

   *Sidinformation > Sidprofil*

1. Observera att kategorierna för `wknd.dependencies` och `wknd.site` finns listade här. Som standard delas klienten som konfigurerats via sidprincipen upp så att CSS inkluderas i sidhuvudet och JavaScript i brödtexten. Om du vill kan du explicit ange att clientlib JavaScript ska läsas in i sidhuvudet. Detta är fallet för `wknd.dependencies`.

   ![Artikelsidmallens menysidpolicy](assets/client-side-libraries/template-page-policy-clientlibs.png)

   >[!NOTE]
   >
   > Det går också att referera till `wknd.site` eller `wknd.dependencies` direkt från sidkomponenten med hjälp av `customheaderlibs.html` eller `customfooterlibs.html` som vi såg tidigare för `wknd.base` clientlib. Mallen ger viss flexibilitet så att du kan välja vilka klipp som ska användas per mall. Om du t.ex. har ett mycket stort JavaScript-bibliotek som bara ska användas på en vald mall.

1. Navigera till **LA Skateparks** sida som skapats med **Artikelsidmall**: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html).

1. Klicka på **Sidinformation** ikon och välj **Visa som publicerad** för att öppna artikelsidan utanför AEM redigerare.

   ![Visa som publicerad](assets/client-side-libraries/view-as-published-article-page.png)

1. Visa sidkällan för [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled) och du bör kunna se följande clientlib-referenser i `<head>`:

   ```html
   <head>
   ...
   <script src="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.lc-d41d8cd98f00b204e9800998ecf8427e-lc.min.js"></script>
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.lc-d41d8cd98f00b204e9800998ecf8427e-lc.min.css" type="text/css">
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-site.lc-78fb9cea4c3a2cc17edce2c2b32631e2-lc.min.css" type="text/css">
   ...
   </head>
   ```

   Observera att klientlibs använder proxyn `/etc.clientlibs` slutpunkt. Du bör även se följande klickbara objekt längst ned på sidan:

   ```html
   ...
   <script src="/etc.clientlibs/wknd/clientlibs/clientlib-site.lc-7157cf8cb32ed66d50e4e49cdc50780a-lc.min.js"></script>
   <script src="/etc.clientlibs/wknd/clientlibs/clientlib-base.lc-53e6f96eb92561a1bdcc1cb196e9d9ca-lc.min.js"></script>
   ...
   </body>
   ```

   >[!NOTE]
   >
   > Om du fortsätter på 6.5/6.4 minimeras inte klientsidans bibliotek automatiskt. Läs dokumentationen på [Bibliotekshanteraren i HTML för att aktivera minering (rekommenderas)](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html?lang=en#using-preprocessors).

   >[!WARNING]
   >
   >På publiceringssidan är det viktigt att klientbiblioteken är **not** tjänstgör från **/apps** eftersom den här sökvägen bör begränsas av säkerhetsskäl med [Dispatcher, filteravsnitt](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#example-filter-section). The [allowProxy, egenskap](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html#locating-a-client-library-folder-and-using-the-proxy-client-libraries-servlet) av klientbiblioteket ser till att CSS och JS hanteras från **/etc.clientlibs**.

### Nästa steg {#next-steps}

Lär dig hur du implementerar enskilda format och återanvänder kärnkomponenter med Experience Manager Style System. [Utveckla med Style System](style-system.md) omfattar användning av Style System för att utöka kärnkomponenter med varumärkesspecifik CSS och avancerade principkonfigurationer för mallredigeraren.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-stacken `tutorial/client-side-libraries-solution`.

1. Klona [github.com/adobe/aem-wknd-guides](https://github.com/adobe/aem-guides-wknd) databas.
1. Kolla in `tutorial/client-side-libraries-solution` förgrening.

## Ytterligare verktyg och resurser {#additional-resources}

### Webpack DevServer - statisk kod {#webpack-dev-static}

Under de föregående övningarna kunde vi uppdatera flera Sass-filer i **ui.front** och genom en byggprocess kan du se dessa ändringar återspeglas i AEM. Därefter ska vi titta på en teknik som utnyttjar [webpack-dev-server](https://webpack.js.org/configuration/dev-server/) för att snabbt utveckla vår front end-stil mot **static** HTML.

Den här tekniken är användbar om huvuddelen av formaten och frontkodningen kommer att utföras av en dedikerad Front End-utvecklare som kanske inte har enkel åtkomst till en AEM. Med denna teknik kan FED även göra ändringar direkt på HTML, som sedan kan skickas vidare till en AEM som ska implementeras som komponenter.

1. Kopiera sidkällan för LA-skateparartikelsidan på [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled).
1. Öppna utvecklingsmiljön igen. Klistra in den kopierade markeringen från AEM i `index.html` i **ui.front** modul under `src/main/webpack/static`.
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

1. Starta webbpaketets dev-server från en ny terminal genom att köra följande kommando inifrån **ui.front** modul:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend/
   $ npm start
   
   > aem-maven-archetype@1.0.0 start code/aem-guides-wknd/ui.frontend
   > webpack-dev-server --open --config ./webpack.dev.js
   ```

1. Då öppnas ett nytt webbläsarfönster på [http://localhost:8080/](http://localhost:8080/) med statiska markeringar.

1. Redigera filen `src/main/webpack/site/_variables.scss` -fil. Ersätt `$text-color` regel med följande:

   ```diff
   - $text-color:              $black;
   + $text-color:              $pink;
   ```

   Spara ändringarna.

1. Ändringarna visas automatiskt i webbläsaren på [http://localhost:8080](http://localhost:8080).

   ![Ändringar av server för lokal webbpaketsdev](assets/client-side-libraries/local-webpack-dev-server.png)

1. Granska `/aem-guides-wknd.ui.frontend/webpack.dev.js` -fil. Detta innehåller webbpaketskonfigurationen som används för att starta webbpack-dev-servern. Observera att banorna proxies `/content` och `/etc.clientlibs` från en lokal instans av AEM. Så här fungerar bilderna och andra klientlibs (hanteras inte av **ui.front** finns tillgängliga.

   >[!CAUTION]
   >
   > Den statiska markeringens bildresurs pekar på en aktiv bildkomponent i en lokal AEM. Bilderna kommer att visas som brutna om sökvägen till bilden ändras, om AEM inte startas eller om webbläsaren inte har loggat in i den lokala AEM. Om du lämnar över till en extern resurs är det också möjligt att ersätta bilderna med statiska referenser.

1. Du kan **stop** webbpaketservern från kommandoraden genom att skriva `CTRL+C`.

### aemfed {#develop-aemfed}

[**aemfed**](https://aemfed.io/) är ett kommandoradsverktyg med öppen källkod som kan användas för att snabba upp frontendutvecklingen. Den drivs av  [aemsync](https://www.npmjs.com/package/aemsync), [Browsersync](https://www.npmjs.com/package/browser-sync) och [Sling Log Tracer](https://sling.apache.org/documentation/bundles/log-tracers.html).

På en hög nivå **aemfed** har utformats för att avlyssna filändringar i **ui.apps** och synkroniserar dem automatiskt direkt till en AEM som körs. Baserat på ändringarna uppdateras en lokal webbläsare automatiskt, vilket snabbar upp framtagningen. Den är även utformad för att fungera med Sling Log Tracer för att automatiskt visa eventuella serverfel direkt i terminalen.

Om du gör mycket jobb i **ui.apps** modul, ändra HTML-skript och skapa anpassade komponenter, **aemfed** kan vara ett mycket kraftfullt verktyg att använda. [Fullständig dokumentation finns här.](https://github.com/abmaonline/aemfed).

### Felsöka bibliotek på klientsidan {#debugging-clientlibs}

Med olika metoder **kategorier** och **inbäddade** om du vill inkludera flera klientbibliotek kan det vara besvärligt att felsöka. AEM visar flera verktyg som kan hjälpa dig med detta. Ett av de viktigaste verktygen är **Återskapa klientbibliotek** som tvingar AEM att kompilera om LESS-filer och generera CSS.

* [**Dumpa läppar**](http://localhost:4502/libs/granite/ui/content/dumplibs.html) - Visar en lista över alla klientbibliotek som är registrerade i AEM. `<host>/libs/granite/ui/content/dumplibs.html`

* [**Testutdata**](http://localhost:4502/libs/granite/ui/content/dumplibs.test.html) - gör att en användare kan se förväntade utdata från HTML för clientlib includes baserat på kategori. `<host>/libs/granite/ui/content/dumplibs.test.html`

* [**Validering av biblioteksberoenden**](http://localhost:4502/libs/granite/ui/content/dumplibs.validate.html) - markerar eventuella beroenden eller inbäddade kategorier som inte kan hittas. `<host>/libs/granite/ui/content/dumplibs.validate.html`

* [**Återskapa klientbibliotek**](http://localhost:4502/libs/granite/ui/content/dumplibs.rebuild.html) - gör att en användare kan tvinga AEM att återskapa alla klientbibliotek eller göra cachen i klientbiblioteken ogiltig. Det här verktyget är särskilt effektivt när du utvecklar med LESS eftersom det kan tvinga AEM att kompilera om den genererade CSS-koden. I allmänhet är det effektivare att validera cacheminnen och sedan utföra en siduppdatering jämfört med att återskapa alla bibliotek. `<host>/libs/granite/ui/content/dumplibs.rebuild.html`

![återskapa klientbibliotek](assets/client-side-libraries/rebuild-clientlibs.png)
