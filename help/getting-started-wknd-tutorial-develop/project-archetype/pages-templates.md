---
title: Komma igång med AEM Sites - Sidor och mallar
description: Lär dig mer om relationen mellan en bassidkomponent och redigerbara mallar. Förstå hur kärnkomponenter proxiberas in i projektet. Lär dig avancerade policykonfigurationer av redigerbara mallar för att skapa en välstrukturerad artikelsidmall baserad på en dummy från Adobe XD.
feature: Core Components, Editable Templates, Page Editor
topic: Content Management, Development
role: Developer
level: Beginner
mini-toc-levels: 1
jira: KT-4082
thumbnail: 30214.jpg
doc-type: Tutorial
exl-id: e9d06dc2-ac3b-48c5-ae00-fdaf5bb45b54
recommendations: noDisplay, noCatalog
duration: 2217
source-git-commit: 0400242f6a99bc5209a8b483469d5fd88eac077e
workflow-type: tm+mt
source-wordcount: '2853'
ht-degree: 0%

---

# Sidor och mallar {#pages-and-template}

{{edge-delivery-services-and-page-editor}}

I det här kapitlet tittar vi på förhållandet mellan en bassidkomponent och redigerbara mallar. Lär dig skapa en oformaterad artikelmall baserad på vissa dummies från [Adobe XD](https://helpx.adobe.com/support/xd.html). Under processen att skapa mallen beskrivs kärnkomponenter och avancerade principkonfigurationer för redigerbara mallar.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

### Startprojekt

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Kolla in `tutorial/pages-templates-start` förgrening från [GitHub](https://github.com/adobe/aem-guides-wknd)

   ```shell
   $ cd ~/code/aem-guides-wknd
   $ git checkout tutorial/pages-templates-start
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

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/pages-templates-solution) eller checka ut koden lokalt genom att växla till grenen `tutorial/pages-templates-solution`.

## Syfte

1. Inspect är en siddesign som skapats i Adobe XD och som mappas till Core Components.
1. Förstå detaljerna om redigerbara mallar och hur profiler kan användas för att få exakt kontroll över sidinnehållet.
1. Lär dig hur mallar och sidor länkas

## Vad du ska bygga {#what-build}

I den här delen av självstudiekursen skapar du en ny artikelsidmall som kan användas för att skapa artikelsidor och justera i en gemensam struktur. Artikelsidmallen baseras på design och ett användargränssnittspaket som skapats i Adobe XD. Det här kapitlet handlar endast om att bygga ut mallens struktur eller skelett. Inga format implementeras, men mallen och sidorna fungerar.

![Artikelsiddesign och ej formaterad version](assets/pages-templates/what-you-will-build.png)

## UI Planning with Adobe XD {#adobexd}

Vanligtvis börjar planering för en ny webbplats med dummies och statisk design. [Adobe XD](https://helpx.adobe.com/support/xd.html) är ett designverktyg för att bygga upp användarupplevelser. Sedan undersöker vi ett gränssnittspaket och dummies för att planera strukturen för artikelsidmallen.

>[!VIDEO](https://video.tv.adobe.com/v/30214?quality=12&learn=on)

**Ladda ned [WKND-artikeldesignfil](https://github.com/adobe/aem-guides-wknd/releases/download/aem-guides-wknd-0.0.2/AEM_UI-kit-WKND-article-design.xd)**.

>[!NOTE]
>
> En allmän [AEM Core Components UI Kit finns också tillgängligt](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/AEM-CoreComponents-UI-Kit.xd) som utgångspunkt för anpassade projekt.

## Skapa artikelsidmall

När du skapar en sida måste du välja en mall som används som bas för att skapa sidan. Mallen definierar strukturen för den resulterande sidan, det inledande innehållet och de tillåtna komponenterna.

Det finns tre huvudområden: [Redigerbara mallar](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/templates/page-templates-editable.html):

1. **Struktur** - definierar komponenter som är en del av mallen. Dessa kan inte redigeras av innehållsförfattare.
1. **Ursprungligt innehåll** - definierar komponenter som mallen börjar med, som kan redigeras och/eller tas bort av innehållsförfattare
1. **Profiler** - definierar konfigurationer för hur komponenter beter sig och vilka alternativ författarna har.

Skapa sedan en mall i AEM som matchar strukturen i modellerna. Detta inträffar i en lokal instans av AEM. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/330991?quality=12&learn=on)

Steg på hög nivå för videon ovan:

### Strukturkonfigurationer

1. Skapa en mall med **Sidmallstyp**, namngivna **Artikelsida**.
1. Växla till **Struktur** läge.
1. Lägg till en **Experience Fragment** som fungerar som **Sidhuvud** högst upp i mallen.
   * Konfigurera komponenten att peka på `/content/experience-fragments/wknd/us/en/site/header/master`.
   * Ställ in profilen på **Sidhuvud** och se till att **Standardelement** är inställd på `header`. The `header`-elementet har CSS som mål i nästa kapitel.
1. Lägg till en **Experience Fragment** som fungerar som **Sidfot** längst ned i mallen.
   * Konfigurera komponenten att peka på `/content/experience-fragments/wknd/us/en/site/footer/master`.
   * Ställ in profilen på **Sidfot** och se till att **Standardelement** är inställd på `footer`. The `footer` -elementet har CSS som mål i nästa kapitel.
1. Lås **main** behållare som inkluderades när mallen skapades.
   * Ställ in profilen på **Sidans huvudsida** och se till att **Standardelement** är inställd på `main`. The `main` -elementet har CSS som mål i nästa kapitel.
1. Lägg till en **Bild** -komponenten till **main** behållare.
   * Lås upp **Bild** -komponenten.
1. Lägg till en **Breadcrumb** -komponenten under **Bild** i huvudbehållaren.
   * Skapa en profil för **Breadcrumb** komponent namngiven **Artikelsida - vägbeskrivningar**. Ange **Startnivå för navigering** till **4**.
1. Lägg till en **Behållare** -komponenten under **Breadcrumb** -komponenten och inuti **main** behållare. Detta fungerar som **Innehållsbehållare** för mallen.
   * Lås upp **Innehåll** behållare.
   * Ställ in profilen på **Sidinnehåll**.
1. Lägg till ytterligare **Behållare** -komponenten under **Innehållsbehållare**. Detta fungerar som **Sidospår** -behållare för mallen.
   * Lås upp **Sidospår** behållare.
   * Skapa en princip med namnet **Artikelsida - sidospalt**.
   * Konfigurera **Tillåtna komponenter** under **WKND Sites Project - Content** att inkludera: **Knapp**, **Ladda ned**, **Bild**, **Lista**, **Avgränsare**, **Delning av sociala medier**, **Text** och **Titel**.
1. Uppdatera sidrotbehållarens profil. Det här är mallens yttre behållare. Ställ in profilen på **Sidrot**.
   * Under **Behållarinställningar**, ange **Layout** till **Responsivt rutnät**.
1. Aktivera layoutläget för **Innehållsbehållare**. Dra handtaget från höger till vänster och krymp behållaren så att den blir åtta kolumner bred.
1. Aktivera layoutläget för **Side Rail-behållare**. Dra handtaget från höger till vänster och krymp behållaren så att den är fyra kolumner bred. Dra sedan det vänstra handtaget från vänster till höger en kolumn för att göra behållaren tre kolumner bred och lämna ett mellanrum på en kolumn mellan **Innehållsbehållare**.
1. Öppna mobilemulatorn och byt till en mobil brytpunkt. Aktivera layoutläget igen och gör **Innehållsbehållare** och **Side Rail-behållare** sidans hela bredd. Detta staplar behållarna lodrätt i den mobila brytpunkten.
1. Uppdatera profilen för **Text** -komponenten i **Innehållsbehållare**.
   * Ställ in profilen på **Innehållstext**.
   * Under **Plugins** > **Styckeformat**, kontrollera **Aktivera styckeformat** och se till att **Offertblock** är aktiverat.

### Inledande innehållskonfigurationer

1. Växla till **Ursprungligt innehåll** läge.
1. Lägg till en **Titel** -komponenten till **Innehållsbehållare**. Detta fungerar som artikelrubrik. När den lämnas tom visas automatiskt den aktuella sidans titel.
1. Lägg till en sekund **Titel** under den första Title-komponenten.
   * Konfigurera komponenten med texten: &quot;By Author&quot;. Det här är en textplatshållare.
   * Ange vilken typ som ska `H4`.
1. Lägg till en **Text** -komponenten under **Efter författare** Rubrikkomponent.
1. Lägg till en **Titel** -komponenten till **Side Rail Container**.
   * Konfigurera komponenten med texten: &quot;Share this Story&quot;.
   * Ange vilken typ som ska `H5`.
1. Lägg till en **Delning av sociala medier** -komponenten under **Dela den här artikeln** Rubrikkomponent.
1. Lägg till en **Avgränsare** -komponenten under **Delning av sociala medier** -komponenten.
1. Lägg till en **Ladda ned** -komponenten under **Avgränsare** -komponenten.
1. Lägg till en **Lista** -komponenten under **Ladda ned** -komponenten.
1. Uppdatera **Inledande sidegenskaper** för mallen.
   * Under **Sociala medier** > **Delning av sociala medier**, kontrollera **Facebook** och **Pinterest**

### Aktivera mallen och lägg till en miniatyrbild

1. Visa mallen i mallkonsolen genom att navigera till [http://localhost:4502/libs/wcm/core/content/sites/templates.html/conf/wknd](http://localhost:4502/libs/wcm/core/content/sites/templates.html/conf/wknd)
1. **Aktivera** artikelsidmallen.
1. Redigera egenskaperna för artikelsidmallen och överför följande miniatyrbild för att snabbt identifiera sidor som skapats med artikelsidmallen:

   ![Miniatyrbild av artikelsidmall](assets/pages-templates/article-page-template-thumbnail.png)

## Uppdatera sidhuvud och sidfot med Experience Fragments {#experience-fragments}

Ett vanligt tillvägagångssätt när du skapar globalt innehåll, till exempel ett sidhuvud eller en sidfot, är att använda en [Experience Fragment](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html). Med Experience Fragments kan användare kombinera flera komponenter för att skapa en enda referensbar komponent. Experience Fragments har fördelen att det stöder hantering av flera webbplatser och [lokalisering](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/wcm-components/experience-fragment.html?lang=en).

Den AEM projekttypen genererade ett sidhuvud och en sidfot. Uppdatera sedan Experience Fragments så att de matchar dummyerna. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/330992?quality=12&learn=on)

Steg på hög nivå för videon ovan:

1. Hämta exempelinnehållspaketet **[WKND-PagesTemplates-Content-Assets.zip](assets/pages-templates/WKND-PagesTemplates-Content-Assets-1.1.zip)**.
1. Överför och installera innehållspaketet med Package Manager på [http://localhost:4502/crx/packmgr/index.jsp](http://localhost:4502/crx/packmgr/index.jsp)
1. Uppdatera webbvariationsmallen, som är den mall som används för Experience Fragments på [http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/xf-web-variation/structure.html](http://localhost:4502/editor.html/conf/wknd/settings/wcm/templates/xf-web-variation/structure.html)
   * Uppdatera profilen med **Behållare** -komponenten i mallen.
   * Ställ in profilen på **XF-rot**.
   * Under **Tillåtna komponenter** markera komponentgruppen **WKND Sites Project - Structure** att inkludera **Språknavigering**, **Navigering** och **Snabbsökning** -komponenter.

### Uppdatera rubrikupplevelsefragment

1. Öppna Experience Fragment som återger rubriken på [http://localhost:4502/editor.html/content/experience-fragments/wknd/us/en/site/header/master.html](http://localhost:4502/editor.html/content/experience-fragments/wknd/us/en/site/header/master.html)
1. Konfigurera roten **Behållare** av fragmentet. Det här är det yttre **Behållare**.
   * Ange **Layout** till **Responsivt rutnät**
1. Lägg till **WKND, mörk logotyp** som en bild längst upp i **Behållare**. Logotypen ingick i paketet som installerades i ett tidigare steg.
   * Ändra layouten för **WKND, mörk logotyp** att **två** kolumner bred. Dra handtagen från höger till vänster.
   * Konfigurera logotypen med **Alternativ text** av &quot;WKND Logo&quot;.
   * Konfigurera logotypen för **Länk** till `/content/wknd/us/en` hemsidan.
1. Konfigurera **Navigering** som redan finns på sidan.
   * Ange **Uteslut rotnivåer** till **1**.
   * Ange **Navigeringsstrukturens djup** till **1**.
   * Ändra layouten för **Navigering** komponent som ska **åtta** kolumner bred. Dra handtagen från höger till vänster.
1. Ta bort **Språknavigering** -komponenten.
1. Ändra layouten för **Sök** komponent som ska **två** kolumner bred. Dra handtagen från höger till vänster. Alla komponenter ska nu justeras vågrätt på en enda rad.

### Uppdatera sidfotsupplevelsefragment

1. Öppna det Experience Fragment som återger sidfoten vid [http://localhost:4502/editor.html/content/experience-fragments/wknd/us/en/site/footer/master.html](http://localhost:4502/editor.html/content/experience-fragments/wknd/us/en/site/footer/master.html)
1. Konfigurera roten **Behållare** av fragmentet. Det här är det yttre **Behållare**.
   * Ange **Layout** till **Responsivt rutnät**
1. Lägg till **WKND Light, logotyp** som en bild längst upp i **Behållare**. Logotypen ingick i paketet som installerades i ett tidigare steg.
   * Ändra layouten för **WKND Light, logotyp** att **två** kolumner bred. Dra handtagen från höger till vänster.
   * Konfigurera logotypen med **Alternativ text** av &quot;WKND Logo Light&quot;.
   * Konfigurera logotypen för **Länk** till `/content/wknd/us/en` hemsidan.
1. Lägg till en **Navigering** under logotypen. Konfigurera **Navigering** komponent:
   * Ange **Uteslut rotnivåer** till **1**.
   * Avmarkera **Samla in alla underordnade sidor**.
   * Ange **Navigeringsstrukturens djup** till **1**.
   * Ändra layouten för **Navigering** komponent som ska **åtta** kolumner bred. Dra handtagen från höger till vänster.

## Skapa en artikelsida

Skapa sedan en sida med hjälp av mallen Artikelsida. Skriv innehållet på sidan så att det matchar webbplatsens modeller. Följ stegen i videon nedan:

>[!VIDEO](https://video.tv.adobe.com/v/330993?quality=12&learn=on)

Steg på hög nivå för videon ovan:

1. Navigera till webbplatskonsolen på [http://localhost:4502/sites.html/content/wknd/us/en/magazine](http://localhost:4502/sites.html/content/wknd/us/en/magazine).
1. Skapa en sida under **WKND** > **USA** > **EN** > **Magazine**.
   * Välj **Artikelsida** mall.
   * Under **Egenskaper** ange **Titel** till&quot;Ultimate Guide to LA Skateparks&quot;
   * Ange **Namn** till &quot;guide-la-skateparks&quot;
1. Ersätt **Efter författare** Titel med texten&quot;Av Stacey Roswells&quot;.
1. Uppdatera **Text** som ska innehålla ett stycke för att fylla i artikeln. Du kan använda följande textfil som kopia: [la-skate-parks-copy.txt](assets/pages-templates/la-skateparks-copy.txt).
1. Lägg till ytterligare **Text** -komponenten.
   * Uppdatera komponenten så att den innehåller citatet:&quot;Det finns ingen bättre plats att dela än Los Angeles.&quot;
   * Redigera RTF-redigeraren i helskärmsläge och ändra offerten ovan så att den använder **Offertblock** -element.
1. Fortsätt fylla i artikelns brödtext för att matcha dummies.
1. Konfigurera **Ladda ned** om du vill använda en PDF-version av artikeln.
   * Under **Ladda ned** > **Egenskaper** klickar du på kryssrutan för att **Hämta titeln från DAM-resursen**.
   * Ange **Beskrivning** till:&quot;Hämta hela artikeln&quot;.
   * Ange **Åtgärdstext** till: &quot;Download PDF&quot;.
1. Konfigurera **Lista** -komponenten.
   * Under **Listinställningar** > **Skapa lista med**, markera **Underordnade sidor**.
   * Ange **Överordnad sida** till `/content/wknd/us/en/magazine`.
   * Under **Objektinställningar** check **Länka objekt** och kontrollera **Visa datum**.

## Inspect nodstrukturen {#node-structure}

Nu är artikelsidan helt oformaterad. Den grundläggande strukturen finns dock på plats. Granska sedan artikelsidans nodstruktur för att få en bättre förståelse för mallens, sidans och komponenternas roll.

Använd verktyget CRXDE-Lite på en lokal AEM för att visa den underliggande nodstrukturen.

1. Öppna [CRXDE-Lite](http://localhost:4502/crx/de/index.jsp#/content/wknd/us/en/magazine/guide-la-skateparks/jcr%3Acontent) och navigera till `/content/wknd/us/en/magazine/guide-la-skateparks`.

1. Klicka på `jcr:content` nod under `la-skateparks` och visa egenskaperna:

   ![Egenskaper för JCR-innehåll](assets/pages-templates/jcr-content-properties-CRXDELite.png)

   Lägg märke till värdet för `cq:template`, som pekar på `/conf/wknd/settings/wcm/templates/article-page`, artikelsidmallen som skapades tidigare.

   Lägg också märke till värdet av `sling:resourceType`, som pekar på `wknd/components/page`. Detta är den sidkomponent som skapas av AEM projekttyp och som ansvarar för återgivningen av sidan baserat på mallen.

1. Expandera `jcr:content` nod under `/content/wknd/us/en/magazine/guide-la-skateparks/jcr:content` och visa nodhierarkin:

   ![JCR Content LA Skateparks](assets/pages-templates/page-jcr-structure.png)

   Du bör kunna mappa var och en av noderna löst till komponenter som har skapats. Se om du kan identifiera de olika layoutbehållarna som används genom att granska de noder som är prefix med `container`.

1. Kontrollera sedan sidkomponenten på `/apps/wknd/components/page`. Visa komponentegenskaperna i CRXDE Lite:

   ![Egenskaper för sidkomponent](assets/pages-templates/page-component-properties.png)

   Det finns bara två HTML-skript, `customfooterlibs.html` och `customheaderlibs.html` under sidkomponenten. *Hur återger den här komponenten sidan?*

   The `sling:resourceSuperType` egenskapen pekar på `core/wcm/components/page/v2/page`. Den här egenskapen tillåter att WKND:s sidkomponent ärver **alla** funktionaliteten hos komponentsidan för kärnkomponent. Detta är det första exemplet på något som kallas [Proxykomponentmönster](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/guidelines.html#ProxyComponentPattern). Mer information finns [här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/guidelines.html).

1. Inspect en annan komponent i WKND-komponenterna, `Breadcrumb` från: `/apps/wknd/components/breadcrumb`. Observera att samma `sling:resourceSuperType` -egenskapen kan hittas, men den här gången pekar den på `core/wcm/components/breadcrumb/v2/breadcrumb`. Detta är ett annat exempel på hur du använder komponentmönstret Proxy för att inkludera en Core-komponent. Faktum är att alla komponenter i WKND-kodbasen är proxies av AEM Core Components (förutom den anpassade demo-komponenten HelloWorld). Det är en god vana att återanvända så mycket som möjligt av funktionerna i kärnkomponenterna *före* skriva egen kod.

1. Kontrollera sedan sidan med kärnkomponenten på `/libs/core/wcm/components/page/v2/page` med CRXDE Lite:

   >[!NOTE]
   >
   > I AEM 6.5/6.4 ligger kärnkomponenterna under `/apps/core/wcm/components`. I, AEM as a Cloud Service, finns kärnkomponenterna under `/libs` och uppdateras automatiskt.

   ![Huvudkomponentsida](assets/pages-templates/core-page-component-properties.png)

   Observera att många skriptfiler inkluderas under den här sidan. Core Component Page innehåller flera funktioner. Den här funktionen är indelad i flera skript för enklare underhåll och läsbarhet. Du kan spåra inkludering av HTML-skript genom att öppna `page.html` och letar efter `data-sly-include`:

   ```html
   <!--/* /libs/core/wcm/components/page/v2/page/page.html */-->
   <!DOCTYPE HTML>
   <html data-sly-use.page="com.adobe.cq.wcm.core.components.models.Page" lang="${page.language}"
       data-sly-use.head="head.html"
       data-sly-use.footer="footer.html"
       data-sly-use.redirect="redirect.html">
       <head data-sly-call="${head.head @ page = page}"></head>
       <body class="${page.cssClassNames}"
           id="${page.id}"
           data-cmp-data-layer-enabled="${page.data ? true : false}">
           <script data-sly-test.dataLayerEnabled="${page.data}">
           window.adobeDataLayer = window.adobeDataLayer || [];
           adobeDataLayer.push({
               page: JSON.parse("${page.data.json @ context='scriptString'}"),
               event:'cmp:show',
               eventInfo: {
                   path: 'page.${page.id @ context="scriptString"}'
               }
           });
           </script>
           <sly data-sly-test.isRedirectPage="${page.redirectTarget && (wcmmode.edit || wcmmode.preview)}"
               data-sly-call="${redirect.redirect @ redirectTarget = page.redirectTarget}"></sly>
           <sly data-sly-test="${!isRedirectPage}">
               <sly data-sly-include="body.skiptomaincontent.html"></sly>
               <sly data-sly-include="body.socialmedia_begin.html"></sly>
               <sly data-sly-include="body.html"></sly>
               <sly data-sly-call="${footer.footer @ page = page}"></sly>
               <sly data-sly-include="body.socialmedia_end.html"></sly>
           </sly>
       </body>
   </html>
   ```

   Den andra anledningen till att HTML delas upp i flera skript är att tillåta proxykomponenterna att åsidosätta enskilda skript för att implementera anpassad affärslogik. HTML-skript `customfooterlibs.html`och `customheaderlibs.html`, skapas för att åsidosättas av implementeringsprojekt.

   Du kan lära dig mer om hur den redigerbara mallen påverkar återgivningen av [innehållssida genom att läsa den här artikeln](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/templates/page-templates-editable.html).

1. Inspect ytterligare en Core Component, som Breadcrumb på `/libs/core/wcm/components/breadcrumb/v2/breadcrumb`. Visa `breadcrumb.html` för att förstå hur koden för Breadcrumb-komponenten genereras.

## Spara konfigurationer till källkontroll {#configuration-persistence}

Det är ofta viktigt att beständiga konfigurationer, som mallar och relaterade innehållsprinciper, behålls för källkontrollen, särskilt i början av ett AEM projekt. Detta garanterar att alla utvecklare arbetar mot samma uppsättning innehåll och konfigurationer och kan säkerställa ytterligare enhetlighet mellan miljöer. När ett projekt når en viss mognadsnivå kan rutinen med mallhantering överföras till en särskild grupp med avancerade användare.


För tillfället behandlas mallar som andra kodavsnitt och synkroniserar **Artikelsidmall** som en del av projektet.
Fram tills nu överförs kod från det AEM projektet till en lokal instans av AEM. The **Artikelsidmall** skapades direkt på en lokal instans av AEM, så den måste **import** mallen i AEM projekt. The **ui.content** modulen ingår i AEM projekt för detta ändamål.

Nästa steg görs i VSCode IDE med hjälp av [Synkronisering AEM VSCode](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync&amp;ssr=false#overview) plugin-program. Men de kan använda vilken IDE som helst som du har konfigurerat till **import** eller importera innehåll från en lokal instans av AEM.

1. I öppnar VSCode `aem-guides-wknd` projekt.

1. Expandera **ui.content** i Project Explorer. Expandera `src` mapp och navigera till `/conf/wknd/settings/wcm/templates`.

1. [!UICONTROL Right+Click] den `templates` mapp och markera **Importera från AEM**:

   ![VSCode-importmall](assets/pages-templates/vscode-import-templates.png)

   The `article-page` importeras och `page-content`, `xf-web-variation` mallarna bör också uppdateras.

   ![Uppdaterade mallar](assets/pages-templates/updated-templates.png)

1. Upprepa stegen för att importera innehåll men välj **policyer** mapp från `/conf/wknd/settings/wcm/policies`.

   ![Principer för VSCode-import](assets/pages-templates/policies-article-page-template.png)

1. Inspect `filter.xml` fil från `ui.content/src/main/content/META-INF/vault/filter.xml`.

   ```xml
   <!--ui.content filter.xml-->
   <?xml version="1.0" encoding="UTF-8"?>
   <workspaceFilter version="1.0">
       <filter root="/conf/wknd" mode="merge"/>
       <filter root="/content/wknd" mode="merge"/>
       <filter root="/content/dam/wknd" mode="merge"/>
       <filter root="/content/experience-fragments/wknd" mode="merge"/>
   </workspaceFilter>
   ```

   The `filter.xml` filen ansvarar för att identifiera sökvägarna till de noder som installeras med paketet. Lägg märke till `mode="merge"` på vart och ett av filtren som anger att befintligt innehåll inte ska ändras, läggs endast nytt innehåll till. Eftersom innehållsförfattare kan uppdatera dessa sökvägar är det viktigt att en koddistribution gör det **not** skriva över innehåll. Se [FileVault-dokumentation](https://jackrabbit.apache.org/filevault/filter.html) för mer information om hur du arbetar med filterelement.

   Jämför `ui.content/src/main/content/META-INF/vault/filter.xml` och `ui.apps/src/main/content/META-INF/vault/filter.xml` för att förstå de olika noder som hanteras av varje modul.

   >[!WARNING]
   >
   > För att säkerställa konsekventa distributioner för WKND-referensplatsen har vissa grenar av projektet konfigurerats så att `ui.content` skriver över alla ändringar i JCR-filen. Detta är utformat, dvs. för Solution Branches, eftersom kod/format skrivs för specifika profiler.

## Grattis! {#congratulations}

Grattis! Du har skapat en mall och en sida med Adobe Experience Manager Sites.

### Nästa steg {#next-steps}

Nu är artikelsidan helt oformaterad. Följ [Bibliotek på klientsidan och arbetsflöde på klientsidan](client-side-libraries.md) självstudiekurs om hur du bäst använder CSS och JavaScript för att tillämpa globala format på webbplatsen och integrera en dedikerad front-end-konstruktion.

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/pages-templates-solution`.

1. Klona [github.com/adobe/aem-wknd-guides](https://github.com/adobe/aem-guides-wknd) databas.
1. Kolla in `tutorial/pages-templates-solution` gren.
