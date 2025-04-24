---
title: Klientbibliotek och arbetsflöde
description: Lär dig hur du använder klientbibliotek för att distribuera och hantera CSS och JavaScript för en implementering av Adobe Experience Manager (AEM) Sites. Se hur modulen ui.front, ett webbpaketprojekt, kan integreras i hela byggprocessen.
version: Experience Manager 6.4, Experience Manager 6.5, Experience Manager as a Cloud Service
feature: Core Components, AEM Project Archetype
topic: Content Management, Development
role: Developer
level: Beginner
jira: KT-4083
thumbnail: 30359.jpg
doc-type: Tutorial
exl-id: 8d3026e9-a7e2-4a76-8a16-a8197a5e04e3
recommendations: noDisplay, noCatalog
duration: 557
source-git-commit: 3ad201aad77e71b42d46d69fdda50bcc77316151
workflow-type: tm+mt
source-wordcount: '2432'
ht-degree: 0%

---

# Klientbibliotek och arbetsflöde {#client-side-libraries}

Lär dig hur bibliotek och klientbibliotek används för att distribuera och hantera CSS och JavaScript för en implementering av Adobe Experience Manager (AEM) Sites. I den här självstudiekursen beskrivs även hur modulen [ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html), ett frikopplat [webpack](https://webpack.js.org/) -projekt, kan integreras i hela byggprocessen.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att konfigurera en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

Vi rekommenderar även att du går igenom självstudiekursen [Grundläggande om komponenter](component-basics.md#client-side-libraries) för att förstå grunderna i klientbibliotek och AEM.

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

1. Distribuera kodbasen till en lokal AEM-instans med dina Maven-kunskaper:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 lägger du till profilen `classic` till eventuella Maven-kommandon.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/client-side-libraries-solution) eller checka ut koden lokalt genom att växla till grenen `tutorial/client-side-libraries-solution`.

## Mål

1. Förstå hur klientbibliotek inkluderas på en sida via en redigerbar mall.
1. Lär dig hur du använder modulen `ui.frontend` och en webbpaketsutvecklingsserver för dedikerad frontendutveckling.
1. Förstå hela arbetsflödet med att leverera kompilerad CSS och JavaScript till en webbplatsimplementering.

## Vad du ska bygga {#what-build}

I det här kapitlet lägger du till några baslinjeformat för WKND-webbplatsen och artikelsidmallen för att få implementeringen närmare [gränssnittets designmodeller](assets/pages-templates/wknd-article-design.xd). Du använder ett avancerat frontendarbetsflöde för att integrera ett webbpaketprojekt i ett AEM-klientbibliotek.

![Slutförda format](assets/client-side-libraries/finished-styles.png)

*Artikelsida med baslinjeformat tillämpade*

## Bakgrund {#background}

Med bibliotek på klientsidan kan du ordna och hantera CSS- och JavaScript-filer som behövs för en AEM Sites-implementering. De grundläggande målen för klientbibliotek och klientbibliotek är:

1. Lagra CSS/JS i små diskreta filer för enklare utveckling och underhåll
1. Hantera beroenden av ramverk från tredje part på ett organiserat sätt
1. Minimera antalet klientförfrågningar genom att sammanfoga CSS/JS till en eller två förfrågningar.

Mer information om hur du använder [klientbibliotek finns här.](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html)

Bibliotek på klientsidan har vissa begränsningar. Det viktigaste är ett begränsat stöd för populära språk som Sass, LESS och TypeScript. I självstudiekursen ska vi titta på hur modulen **ui.front** kan hjälpa till att lösa det här.

Distribuera startkodsbasen till en lokal AEM-instans och navigera till [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html). Den här sidan är inte formaterad. Låt oss implementera bibliotek på klientsidan för WKND-varumärket för att lägga till CSS och JavaScript på sidan.

## Biblioteksorganisation på klientsidan {#organization}

Nu ska vi utforska organisationen av klienter som genereras av [AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html).

![Klientbiblioteksorganisation på hög nivå](./assets/client-side-libraries/high-level-clientlib-organization.png)

*Högnivådiagram Biblioteksorganisation på klientsidan och sidinkludering*

>[!NOTE]
>
> Följande biblioteksorganisation på klientsidan genereras av AEM Project Archetype men är bara en startpunkt. Hur ett projekt slutligen hanterar och levererar CSS och JavaScript till en webbplatsimplementering kan variera dramatiskt baserat på resurser, kunskaper och behov.

1. Om du använder VSCode eller någon annan IDE öppnas modulen **ui.apps**.
1. Expandera sökvägen `/apps/wknd/clientlibs` om du vill visa de klientlibs som har genererats av typen architype.

   ![Clientlibs in ui.apps](assets/client-side-libraries/four-clientlib-folders.png)

   I avsnittet nedan finns mer information om dessa klientlibs.

1. I följande tabell sammanfattas klientbiblioteken. Mer information om [inklusive klientbibliotek finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/including-clientlibs.html?lang=en#developing).

   | Namn | Beskrivning | Anteckningar |
   |-------------------| ------------| ------|
   | `clientlib-base` | Grundnivån för CSS och JavaScript krävs för att WKND-webbplatsen ska fungera | inbäddar klientlibs för kärnkomponenten |
   | `clientlib-grid` | Genererar den CSS som krävs för att [Layoutläge](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/siteandpage/responsive-layout.html) ska fungera. | Brytpunkter för mobiler/surfplattor kan konfigureras här |
   | `clientlib-site` | Innehåller platsspecifikt tema för WKND-webbplatsen | Genereras av modulen `ui.frontend` |
   | `clientlib-dependencies` | Bäddar in eventuella beroenden från tredje part | Genereras av modulen `ui.frontend` |

1. Observera att `clientlib-site` och `clientlib-dependencies` ignoreras från källkontrollen. Detta är utformat eftersom dessa genereras vid byggtiden av modulen `ui.frontend`.

## Uppdatera basformat {#base-styles}

Uppdatera sedan basformaten som definierats i modulen **[ui.front](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html)**. Filerna i modulen `ui.frontend` genererar de `clientlib-site` - och `clientlib-dependecies`-bibliotek som innehåller platstemat och eventuella tredjepartsberoenden.

Klientbibliotek stöder inte mer avancerade språk som [Sass](https://sass-lang.com/) eller [TypeScript](https://www.typescriptlang.org/). Det finns flera verktyg med öppen källkod som [NPM](https://www.npmjs.com/) och [webpack](https://webpack.js.org/) som snabbar upp och optimerar frontendutvecklingen. Målet med modulen **ui.front** är att kunna använda dessa verktyg för att hantera de flesta källfiler i gränssnittet.

1. Öppna modulen **ui.front** och navigera till `src/main/webpack/site`.
1. Öppna filen `main.scss`

   ![main.scss - startpunkt](assets/client-side-libraries/main-scss.png)

   `main.scss` är startpunkten till Sass-filerna i modulen `ui.frontend`. Den innehåller filen `_variables.scss`, som innehåller en serie varumärkesvariabler som ska användas i olika Sass-filer i projektet. Filen `_base.scss` ingår också och definierar några grundläggande format för HTML-element. Ett reguljärt uttryck innehåller formaten för enskilda komponentformat under `src/main/webpack/components`. Ett annat reguljärt uttryck innehåller filerna under `src/main/webpack/site/styles`.

1. Granska filen `main.ts`. Det innehåller `main.scss` och ett reguljärt uttryck för att samla in alla `.js`- eller `.ts`-filer i projektet. Den här startpunkten används av [webbpaketets konfigurationsfiler](https://webpack.js.org/configuration/) som startpunkt för hela `ui.frontend`-modulen.

1. Granska filerna under `src/main/webpack/site/styles`:

   ![Formatfiler](assets/client-side-libraries/style-files.png)

   De här filerna formaterar för globala element i mallen, som sidhuvud, sidfot och behållare för huvudinnehåll. CSS-reglerna i de här filerna har olika HTML-element som mål `header`, `main` och `footer`. Dessa HTML-element definierades av principer i det föregående kapitlet [Sidor och mallar](./pages-templates.md).

1. Expandera mappen `components` under `src/main/webpack` och inspektera filerna.

   ![Komponentens Sass-filer](assets/client-side-libraries/component-sass-files.png)

   Varje fil mappar till en kärnkomponent som [dragspelskomponenten](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/accordion.html?lang=en). Varje kärnkomponent byggs med [Blockelementsmodifierare](https://getbem.com/) eller BEM-notation för att göra det enklare att rikta in specifika CSS-klasser med formatregler. Filerna under `/components` har delats ut av AEM Project Archetype med olika BEM-regler för varje komponent.

1. Hämta WKND-basformat **[wknd-base-styles-src-v3.zip](/help/getting-started-wknd-tutorial-develop/project-archetype/assets/client-side-libraries/wknd-base-styles-src-v3.zip)** och **zip** filen.

   ![WKND-basformat](assets/client-side-libraries/wknd-base-styles-unzipped.png)

   För att snabba upp självstudiekursen finns flera Sass-filer som implementerar WKND-varumärket baserat på kärnkomponenter och strukturen för artikelsidmallen.

1. Skriv över innehållet i `ui.frontend/src` med filer från föregående steg. Innehållet i zip-filen ska skriva över följande mappar:

   ```plain
   /src/main/webpack
            /components
            /resources
            /site
            /static
   ```

   ![Ändrade filer](assets/client-side-libraries/changed-files-uifrontend.png)

   Granska de ändrade filerna för att se information om implementeringen av WKND-formatet.

## Inspektera integreringen av ui.front {#ui-frontend-integration}

En viktig integrationsbit som är inbyggd i modulen **ui.front**, [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator), tar kompilerade CSS- och JS-artefakter från ett webpack/npm-projekt och omvandlar dem till AEM klientbibliotek.

![ui.frontEtiketintegration](assets/client-side-libraries/ui-frontend-architecture.png)

AEM Project Archetype konfigurerar automatiskt den här integreringen. Utforska sedan hur det fungerar.


1. Öppna en kommandoradsterminal och installera modulen **ui.front** med kommandot `npm install`:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend
   $ npm install
   ```

   >[!NOTE]
   >
   >`npm install`-körning behövs bara en gång, som efter en ny klon eller generering av projektet.

1. Öppna `ui.frontend/package.json` och lägg till `--env writeToDisk=true` i kommandot **scripts** **start**.

   ```json
   {
     "scripts": { 
       "start": "webpack-dev-server --open --config ./webpack.dev.js --env writeToDisk=true",
     }
   }
   ```

1. Starta webbpaketets dev-server i läget **watch** genom att köra följande kommando:

   ```shell
   $ npm run watch
   ```

1. Detta kompilerar källfilerna från modulen `ui.frontend` och synkroniserar ändringarna med AEM på [http://localhost:4502](http://localhost:4502)

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

1. Kommandot `npm run watch` fyller i **clientlib-site** och **clientlib-beroenden** i modulen **ui.apps** som sedan synkroniseras automatiskt med AEM.

   >[!NOTE]
   >
   >Det finns också en `npm run prod`-profil som miniatyriserar JS och CSS. Detta är standardkompileringen när webbpaketsbygget utlöses via Maven. Mer information om modulen [ui.front finns här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/uifrontend.html).

1. Granska filen `site.css` under `ui.frontend/dist/clientlib-site/site.css`. Detta är den kompilerade CSS-koden som baseras på Sass-källfilerna.

   ![Distribuerad plats-css](assets/client-side-libraries/ui-frontend-dist-site-css.png)

1. Granska filen `ui.frontend/clientlib.config.js`. Detta är konfigurationsfilen för ett npm-plugin-program, [aem-clientlib-generator](https://github.com/wcm-io-frontend/aem-clientlib-generator), som omformar innehållet i `/dist` till ett klientbibliotek och flyttar det till modulen `ui.apps`.

1. Granska filen `site.css` i modulen **ui.apps** på `ui.apps/src/main/content/jcr_root/apps/wknd/clientlibs/clientlib-site/css/site.css`. Detta bör vara en identisk kopia av filen `site.css` från modulen **ui.front**. Nu när den finns i modulen **ui.apps** kan den distribueras till AEM.

   ![ui.apps clientlib-site](assets/client-side-libraries/ui-apps-clientlib-site-css.png)

   >[!NOTE]
   >
   > Eftersom **clientlib-site** kompileras under byggtid, med antingen **npm** eller **maven**, kan den ignoreras från källkontrollen i modulen **ui.apps**. Granska filen `.gitignore` under **ui.apps**.

1. Öppna LA Skatepark-artikeln i AEM på: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html).

   ![Uppdaterade basformat för artikeln](assets/client-side-libraries/updated-base-styles.png)

   Du bör nu se de uppdaterade formaten för artikeln. Du kan behöva göra en hård uppdatering för att rensa alla CSS-filer som har cachelagrats i webbläsaren.

   Det börjar se mycket närmare på mockonerna!

   >[!NOTE]
   >
   > Stegen som utförs ovan för att skapa och distribuera ui.front-koden till AEM körs automatiskt när en Maven-bygge utlöses från roten för projektet `mvn clean install -PautoInstallSinglePackage`.

## Göra en formatändring

Gör sedan en liten ändring i modulen `ui.frontend` för att se hur `npm run watch` automatiskt distribuerar formaten till den lokala AEM-instansen.

1. Från öppnar modulen `ui.frontend` filen: `ui.frontend/src/main/webpack/site/_variables.scss`.
1. Uppdatera färgvariabeln `$brand-primary`:

   ```scsss
   //== variables.css
   
   //== Brand Colors
   $brand-primary:          $pink;
   ```

   Spara ändringarna.

1. Gå tillbaka till webbläsaren och uppdatera AEM-sidan för att se uppdateringarna:

   ![Bibliotek på klientsidan](assets/client-side-libraries/style-update-brand-primary.png)

1. Återställ ändringen av färgen `$brand-primary` och stoppa webbpaketsbygget med kommandot `CTRL+C`.

>[!CAUTION]
>
> Användning av modulen **ui.front** kanske inte är nödvändig för alla projekt. Modulen **ui.front** lägger till ytterligare komplexitet och om det inte finns något behov/behov av att använda några av de här avancerade frontendverktygen (Sass, webpack, npm...) kanske den inte behövs.

## Inkludering av sidor och mallar {#page-inclusion}

Sedan tittar vi på hur du refererar till klienten på AEM Page. Ett vanligt tillvägagångssätt vid webbutveckling är att inkludera CSS i HTML Header `<head>` och JavaScript precis innan du stänger `</body>` -taggen.

1. Bläddra till mallen Artikelsida på [http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html](http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/article-page/structure.html)

1. Klicka på ikonen **Sidinformation** och välj **Sidprofil** på menyn för att öppna dialogrutan **Sidprofil**.

   ![Artikelsidmallens menysidpolicy](assets/client-side-libraries/template-page-policy.png)

   *Sidinformation > Sidprofil*

1. Observera att kategorierna för `wknd.dependencies` och `wknd.site` listas här. Som standard delas klienten som konfigurerats via sidprincipen upp så att CSS inkluderas i sidhuvudet och JavaScript i brödtexten. Du kan visa en explicit lista över det clientlib JavaScript som ska läsas in i sidhuvudet. Detta gäller `wknd.dependencies`.

   ![Artikelsidmallens menysidpolicy](assets/client-side-libraries/template-page-policy-clientlibs.png)

   >[!NOTE]
   >
   > Det går också att referera till `wknd.site` eller `wknd.dependencies` från sidkomponenten direkt med skriptet `customheaderlibs.html` eller `customfooterlibs.html`. Mallen ger flexibilitet så att du kan välja vilka klipp som ska användas per mall. Om du t.ex. har ett stort JavaScript-bibliotek som bara ska användas på en viss mall.

1. Navigera till sidan **LA-skateparker** som skapats med **Artikelsidmallen**: [http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html](http://localhost:4502/editor.html/content/wknd/us/en/magazine/guide-la-skateparks.html).

1. Klicka på ikonen **Sidinformation** och välj **Visa som publicerad** på menyn för att öppna artikelsidan utanför AEM Editor.

   ![Visa som publicerad](assets/client-side-libraries/view-as-published-article-page.png)

1. Visa sidkällan för [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled) och du bör kunna se följande klientlibbreferenser i `<head>`:

   ```html
   <head>
   ...
   <script src="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.lc-d41d8cd98f00b204e9800998ecf8427e-lc.min.js"></script>
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.lc-d41d8cd98f00b204e9800998ecf8427e-lc.min.css" type="text/css">
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-site.lc-78fb9cea4c3a2cc17edce2c2b32631e2-lc.min.css" type="text/css">
   ...
   </head>
   ```

   Observera att klientlibs använder proxyslutpunkten `/etc.clientlibs`. Du bör också se att följande clientlib finns längst ned på sidan:

   ```html
   ...
   <script src="/etc.clientlibs/wknd/clientlibs/clientlib-site.lc-7157cf8cb32ed66d50e4e49cdc50780a-lc.min.js"></script>
   <script src="/etc.clientlibs/wknd/clientlibs/clientlib-base.lc-53e6f96eb92561a1bdcc1cb196e9d9ca-lc.min.js"></script>
   ...
   </body>
   ```

   >[!NOTE]
   >
   > För AEM 6.5/6.4 är inte klientbiblioteken automatiskt minifierade. Se dokumentationen för [HTML Library Manager för att aktivera miniatyrbilder (rekommenderas)](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html?lang=en#using-preprocessors).

   >[!WARNING]
   >
   >På publiceringssidan är det viktigt att klientbiblioteken **inte** hanteras från **/appar** eftersom sökvägen bör begränsas av säkerhetsskäl med filteravsnittet [Dispatcher](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#example-filter-section). Egenskapen [allowProxy](https://experienceleague.adobe.com/docs/experience-manager-65/developing/introduction/clientlibs.html#locating-a-client-library-folder-and-using-the-proxy-client-libraries-servlet) i klientbiblioteket ser till att CSS och JS hanteras från **/etc.clientlibs**.

### Nästa steg {#next-steps}

Lär dig hur du implementerar enskilda format och återanvänder kärnkomponenter med Experience Manager Style System. [Om du utvecklar med stilsystemet](style-system.md) kan du använda stilsystemet för att utöka kärnkomponenter med varumärkesspecifik CSS och avancerade principkonfigurationer i mallredigeraren.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/client-side-libraries-solution`.

1. Klona [github.com/adobe/aem-wknd-guides](https://github.com/adobe/aem-guides-wknd)-databasen.
1. Kolla in grenen `tutorial/client-side-libraries-solution`.

## Ytterligare verktyg och resurser {#additional-resources}

### Webpack DevServer - statisk kod {#webpack-dev-static}

Under de föregående övningarna uppdaterades flera Sass-filer i modulen **ui.front** och genom en byggprocess kan du slutligen se att dessa ändringar återspeglas i AEM. Låt oss nu titta på en teknik som använder en [webpack-dev-server](https://webpack.js.org/configuration/dev-server/) för att snabbt utveckla front end-formaten mot **static** HTML.

Den här tekniken är användbar om de flesta format och frontkodningar utförs av en dedikerad Front-End-utvecklare som kanske inte har enkel åtkomst till en AEM-miljö. Med denna teknik kan FED även göra ändringar direkt i HTML, som sedan kan skickas vidare till en AEM-utvecklare som ska implementera som komponenter.

1. Kopiera sidkällan för LA-skatepararartikelsidan på [http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled](http://localhost:4502/content/wknd/us/en/magazine/guide-la-skateparks.html?wcmmode=disabled).
1. Öppna din IDE igen. Klistra in den kopierade markeringen från AEM i `index.html` i modulen **ui.front** under `src/main/webpack/static`.
1. Redigera den kopierade koden och ta bort alla referenser till **clientlib-site** och **clientlib-beroenden**:

   ```html
   <!-- remove -->
   <script type="text/javascript" src="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.js"></script>
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-dependencies.css" type="text/css">
   <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-site.css" type="text/css">
   ...
   <script type="text/javascript" src="/etc.clientlibs/wknd/clientlibs/clientlib-site.js"></script>
   ```

   Ta bort dessa referenser eftersom webbpaketets dev-server automatiskt genererar dessa artefakter.

1. Starta webbpaketets dev-server från en ny terminal genom att köra följande kommando inifrån modulen **ui.front**:

   ```shell
   $ cd ~/code/aem-guides-wknd/ui.frontend/
   $ npm start
   
   > aem-maven-archetype@1.0.0 start code/aem-guides-wknd/ui.frontend
   > webpack-dev-server --open --config ./webpack.dev.js
   ```

1. Då öppnas ett nytt webbläsarfönster på [http://localhost:8080/](http://localhost:8080/) med statisk kod.

1. Redigera filen `src/main/webpack/site/_variables.scss`. Ersätt regeln `$text-color` med följande:

   ```diff
   - $text-color:              $black;
   + $text-color:              $pink;
   ```

   Spara ändringarna.

1. Ändringarna visas automatiskt i webbläsaren på [http://localhost:8080](http://localhost:8080).

   ![Ändringar på den lokala webbpaketsservern](assets/client-side-libraries/local-webpack-dev-server.png)

1. Granska filen `/aem-guides-wknd.ui.frontend/webpack.dev.js`. Detta innehåller webbpaketskonfigurationen som används för att starta webbpack-dev-servern. Sökvägarna `/content` och `/etc.clientlibs` proxyservrar från en lokal instans av AEM som körs. Så här blir bilderna och andra klientlibs (som inte hanteras av koden **ui.front** ) tillgängliga.

   >[!CAUTION]
   >
   > Bildsrc för den statiska markeringen pekar på en aktiv bildkomponent i en lokal AEM-instans. Bilder visas som brutna om sökvägen till bilden ändras, om AEM inte startas eller om webbläsaren inte har loggat in på den lokala AEM-instansen. Om du lämnar över till en extern resurs är det också möjligt att ersätta bilderna med statiska referenser.

1. Du kan **stoppa** webbpaketservern från kommandoraden genom att skriva `CTRL+C`.

### Felsöka bibliotek på klientsidan {#debugging-clientlibs}

Olika metoder i **kategorierna** och **bäddar in** för att inkludera flera klientbibliotek kan vara besvärliga att felsöka. AEM visar flera verktyg som kan hjälpa dig med detta. Ett av de viktigaste verktygen är **Återskapa klientbibliotek** som tvingar AEM att kompilera om alla LESS-filer och generera CSS.

* [**Dumpa bibliotek**](http://localhost:4502/libs/granite/ui/content/dumplibs.html) - Visar en lista över de klientbibliotek som är registrerade i AEM-instansen. `<host>/libs/granite/ui/content/dumplibs.html`

* [**Testa utdata**](http://localhost:4502/libs/granite/ui/content/dumplibs.test.html) - gör att en användare kan se förväntade HTML-utdata för clientlib includes baserat på kategori. `<host>/libs/granite/ui/content/dumplibs.test.html`

* [**Verifiering av biblioteksberoenden**](http://localhost:4502/libs/granite/ui/content/dumplibs.validate.html) - markerar beroenden eller inbäddade kategorier som inte kan hittas. `<host>/libs/granite/ui/content/dumplibs.validate.html`

* [**Återskapa klientbibliotek**](http://localhost:4502/libs/granite/ui/content/dumplibs.rebuild.html) - gör att en användare kan tvinga AEM att återskapa klientbiblioteken eller göra cachen i klientbiblioteken ogiltig. Det här verktyget är effektivt när du utvecklar med LESS eftersom det kan tvinga AEM att kompilera om den genererade CSS-koden. I allmänhet är det effektivare att validera cacheminnen och sedan utföra en siduppdatering jämfört med att återskapa biblioteken. `<host>/libs/granite/ui/content/dumplibs.rebuild.html`

![återskapa klientbibliotek](assets/client-side-libraries/rebuild-clientlibs.png)
