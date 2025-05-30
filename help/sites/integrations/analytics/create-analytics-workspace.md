---
title: Analysera data med Analysis Workspace
description: Läs om hur du mappar data som samlats in från en Adobe Experience Manager-webbplats till mätvärden och dimensioner i Adobe Analytics rapporteringsprogram. Lär dig hur du skapar en detaljerad rapportkontrollpanel med Analysis Workspace-funktionen i Adobe Analytics.
version: Experience Manager as a Cloud Service
topic: Integrations
feature: Adobe Client Data Layer
role: User
level: Intermediate
jira: KT-6409
thumbnail: KT-6296.jpg
doc-type: Tutorial
exl-id: b5722fe2-93bf-4b25-8e08-4cb8206771cb
badgeIntegration: label="Integrering" type="positive"
last-substantial-update: 2022-06-15T00:00:00Z
duration: 443
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '2072'
ht-degree: 0%

---

# Analysera data med Analysis Workspace

Läs om hur du mappar data som samlats in från en Adobe Experience Manager-webbplats till mätvärden och dimensioner i Adobe Analytics rapporteringsprogram. Lär dig hur du skapar en detaljerad rapportkontrollpanel med Analysis Workspace-funktionen i Adobe Analytics.

## Vad du ska bygga {#what-build}

WKND:s marknadsföringsteam är intresserade av att veta vilka `Call to Action (CTA)`-knappar som fungerar bäst på hemsidan. I den här självstudiekursen skapar du ett projekt i **Analysis Workspace** för att visualisera prestandan för olika CTA-knappar och förstå användarbeteendet på webbplatsen. Följande information hämtas med Adobe Analytics när en användare klickar på en Call to Action-knapp (CTA) på WKND-hemsidan.

**Analysvariabler**

Nedan följer Analytics-variablerna som för närvarande spåras:

* `eVar5` - `Page template`
* `eVar6` - `Page Id`
* `eVar7` - `Page last modified date`
* `eVar8` - `CTA Button Id`
* `eVar9` - `Page Name`
* `event8` - `CTA Button Click event`
* `prop8` - `CTA Button Id`

![CTA Click Adobe Analytics](assets/create-analytics-workspace/page-analytics.png)

### Mål {#objective}

1. Skapa en rapportsvit eller använd en befintlig.
1. Konfigurera [konverteringsvariabler (eVars)](https://experienceleague.adobe.com/docs/analytics/admin/admin-tools/manage-report-suites/edit-report-suite/conversion-variables/conversion-var-admin.html?lang=sv-SE) och [lyckade händelser (händelser)](https://experienceleague.adobe.com/sv/docs/analytics/admin/admin-tools/manage-report-suites/edit-report-suite/conversion-variables/success-event) i rapportsviten.
1. Skapa ett [Analysis Workspace-projekt](https://experienceleague.adobe.com/docs/analytics/analyze/analysis-workspace/home.html?lang=sv-SE) för att analysera data med hjälp av verktyg som gör att du kan skapa, analysera och dela insikter snabbt.
1. Dela Analysis Workspace-projektet med andra teammedlemmar.

## Förutsättningar

Den här självstudiekursen är en fortsättning på komponenten [Spåra klickade med Adobe Analytics](./track-clicked-component.md) och förutsätter att du har:

* En **taggegenskap** med [Adobe Analytics-tillägget](https://experienceleague.adobe.com/docs/experience-platform/tags/extensions/client/analytics/overview.html?lang=sv-SE) aktiverat
* **Adobe Analytics** test-/dev-rapportsprogram-ID och spårningsserver. I följande dokumentation finns information om hur du [skapar en rapportsvit](https://experienceleague.adobe.com/docs/analytics/admin/admin-tools/manage-report-suites/c-new-report-suite/new-report-suite.html?lang=sv-SE).
* Webbläsartillägget [Experience Platform Debugger](https://experienceleague.adobe.com/docs/platform-learn/data-collection/debugger/overview.html?lang=sv-SE) har konfigurerats med en taggegenskap inläst på [WKND-platsen](https://wknd.site/us/en.html) eller en AEM-webbplats där Adobe Data Layer är aktiverat.

## Konverteringsvariabler (eVars) och lyckade händelser (Event)

Custom Insight Conversion Variable (eller eVar) placeras i Adobe-koden på de webbsidor du har valt. Dess främsta syfte är att segmentera framgångsstatistik för konverteringar i anpassade marknadsföringsrapporter. En eVar kan vara ett besöksbaserat program och fungerar på liknande sätt som cookies. De värden som skickas till eVar-variabler följer användaren under en förbestämd period.

När en eVar är inställd på en besökares värde kommer Adobe automatiskt ihåg det värdet tills det upphör att gälla. Alla lyckade händelser som besökaren påträffar när eVar-värdet är aktivt räknas mot eVar-värdet.

eVars är bäst att använda för att mäta orsak och effekt, till exempel:

* Vilka interna kampanjer som påverkade intäkterna
* Vilka banners som till slut resulterade i en registrering
* Antalet gånger som en intern sökning användes innan en order skapades

Success-händelser är åtgärder som kan spåras. Du avgör vilken händelse som lyckas. Om en besökare till exempel klickar på en CTA-knapp kan klickhändelsen betraktas som en lyckad händelse.

### Konfigurera eVars

1. På Adobe Experience Cloud hemsida väljer du organisation och startar Adobe Analytics.

   ![Analysera AEP](assets/create-analytics-workspace/analytics-aep.png)

1. Klicka på **Admin** > **Rapportsviter** i verktygsfältet Analyser och hitta din rapportsvit.

   ![Analytics Report Suite](assets/create-analytics-workspace/select-report-suite.png)

1. Välj Report Suite > **Edit Settings** > **Conversion** > **Conversion Variables**

   ![Analyskonverteringsvariabler](assets/create-analytics-workspace/conversion-variables.png)

1. Med alternativet **Lägg till ny** skapar vi konverteringsvariabler för att mappa schemat enligt nedan:

   * `eVar5` - `Page Template`
   * `eVar6` - `Page ID`
   * `eVar7` - `Last Modified Date`
   * `eVar8` - `Button Id`
   * `eVar9` - `Page Name`

   ![Lägg till nya eVars](assets/create-analytics-workspace/add-new-evars.png)

1. Ange ett namn och en beskrivning för varje eVars och **Spara** dina ändringar. I Analysis Workspace-projektet används eVars med lämpligt namn, vilket gör det enkelt att identifiera variablerna med ett användarvänligt namn.

   ![eVars](assets/create-analytics-workspace/evars.png)

### Konfigurera lyckade händelser

Låt oss sedan skapa en händelse för att spåra CTA Button-klickningen.

1. I fönstret **Report Suite Manager** väljer du **Report Suite-ID** och klickar på **Redigera inställningar**.
1. Klicka på **Konvertering** > **Slutförda händelser**
1. Använd alternativet **Lägg till ny** för att skapa en anpassad success-händelse för att spåra CTA Button-klickningen och sedan **Spara** dina ändringar.
   * `Event` : `event8`
   * `Name`:`CTA Click`
   * `Type`:`Counter`

   ![eVars](assets/create-analytics-workspace/add-success-event.png)

## Skapa ett projekt i Analysis Workspace {#workspace-project}

Analysis Workspace är ett flexibelt webbläsarverktyg som gör att du snabbt kan skapa analyser och dela insikter. Med dra-och-släpp-gränssnittet kan ni utforma analyser, lägga till visualiseringar för att ge liv åt data, strukturera en datauppsättning, dela och schemalägga projekt med vem som helst i organisationen.

Skapa sedan ett [projekt](https://experienceleague.adobe.com/docs/analytics/analyze/analysis-workspace/build-workspace-project/freeform-overview.html?lang=sv-SE#analysis-workspace) för att skapa en instrumentpanel som analyserar prestanda för CTA-knapparna på hela webbplatsen.

1. Välj **Workspace** i verktygsfältet Analyser och klicka på **Skapa ett nytt projekt**.

   ![Workspace](assets/create-analytics-workspace/create-workspace.png)

1. Välj om du vill börja i ett **tomt projekt** eller välja någon av de fördefinierade mallarna, antingen från Adobe eller från anpassade mallar som skapats av din organisation. Det finns flera tillgängliga mallar, beroende på vilken analys eller vilket användningsfall du har tänkt dig. [Läs mer](https://experienceleague.adobe.com/docs/analytics/analyze/analysis-workspace/build-workspace-project/starter-projects.html?lang=sv-SE) om de olika mallalternativen.

   I ditt Workspace-projekt nås paneler, tabeller, visualiseringar och komponenter från den vänstra listen. De skapar byggstenar för ditt projekt.

   * **[Komponenter](https://experienceleague.adobe.com/docs/analytics/analyze/analysis-workspace/components/analysis-workspace-components.html?lang=sv-SE)** - Komponenter är dimensioner, mått, segment eller datumintervall, som alla kan kombineras i en Freeform-tabell för att du ska kunna besvara din företagsfråga. Kom ihåg att bekanta dig med varje komponenttyp innan du går in i analysen. När du har mastered component terminology kan du börja dra och släppa för att skapa en analys i en Freeform-tabell.
   * **[Visualiseringar](https://experienceleague.adobe.com/docs/analytics/analyze/analysis-workspace/visualizations/freeform-analysis-visualizations.html?lang=sv-SE)** - Visualiseringar, t.ex. en stapel eller ett linjediagram, läggs sedan till ovanpå data för att ge dem liv visuellt. På den vänstra listen väljer du ikonen för mellanvisualisering för att se en fullständig lista över tillgängliga visualiseringar.
   * **[Paneler](https://experienceleague.adobe.com/docs/analytics/analyze/analysis-workspace/panels/panels.html?lang=sv-SE)** - En panel är en samling tabeller och visualiseringar. Du kommer åt panelerna från den övre vänstra ikonen i Workspace. Paneler är användbara när du vill ordna dina projekt efter tidsperioder, rapportsviter eller användningsexempel för analyser. Följande paneltyper är tillgängliga i Analysis Workspace:

   ![Mallval](assets/create-analytics-workspace/workspace-tools.png)

### Lägg in datavisualisering med Analysis Workspace

Skapa sedan en tabell för att skapa en visuell representation av hur användare interagerar med `Call to Action (CTA)`-knappar på WKND-webbplatsens hemsida. Om du vill skapa en sådan representation använder vi de data som samlats in i komponenten [Spåra klickade med Adobe Analytics](./track-clicked-component.md). Nedan följer en snabb sammanfattning av data som spårats för användarinteraktioner med knapparna Call to Action för WKND-webbplatsen.

* `eVar5` - `Page template`
* `eVar6` - `Page Id`
* `eVar7` - `Page last modified date`
* `eVar8` - `CTA Button Id`
* `eVar9` - `Page Name`
* `event8` - `CTA Button Click event`
* `prop8` - `CTA Button Id`

1. Dra och släpp dimensionskomponenten **Sida** till frihandstabellen. Nu bör du kunna visa en visualisering som visar sidnamnet (eVar9) och motsvarande sidvyer (förekomster) som visas i tabellen.

   ![Sidan Dimension](assets/create-analytics-workspace/evar9-dimension.png)

1. Dra-och-släpp **CTA Click** (event8)-mätvärdet för förekomster och ersätt det. Nu kan du visa en visualisering som visar sidnamnet (eVar9) och motsvarande antal CTA Click-händelser på en sida.

   ![Sidmått - CTA Click](assets/create-analytics-workspace/evar8-cta-click.png)

1. Låt oss dela upp sidan efter dess malltyp. Välj sidmallsmått från komponenter och dra och släpp måttet för sidmall till dimensionen Sidnamn. Nu kan du visa sidnamnet som är uppdelat efter malltyp.

   * **Före**

     ![eVar5](assets/create-analytics-workspace/evar5.png)

   * **Efter**

     ![eVar5 Metrics](assets/create-analytics-workspace/evar5-metrics.png)

1. För att förstå hur användare interagerar med CTA Buttons när de finns på WKND-webbplatssidorna krävs ytterligare uppdelning genom att lägga till mätvärden för Button ID (eVar8).

   ![eVar8](assets/create-analytics-workspace/evar8.png)

1. Här nedan ser du en visuell representation av WKND-webbplatsen som är uppdelad efter sidmallen och som ytterligare är uppdelad efter användarinteraktion med WKND Site Click to Action (CTA) Buttons.

   ![eVar8](assets/create-analytics-workspace/evar8-metric.png)

1. Du kan ersätta värdet för Knapp-ID med ett användarvänligare namn med hjälp av Adobe Analytics Classifications. Du kan läsa mer om hur du skapar en klassificering för ett specifikt mått [här](https://experienceleague.adobe.com/docs/analytics/components/classifications/c-classifications.html?lang=sv-SE). I det här fallet har vi en inställning för klassificeringsmåttet `Button Section (Button ID)` för `eVar8` som mappar knapp-ID till ett användarvänligt namn.

   ![Knappavsnitt](assets/create-analytics-workspace/button-section.png)

## Lägg till klassificering i en analytisk variabel

### Konverteringsklassificeringar

Analysklassificering är ett sätt att kategorisera Analytics-variabeldata och sedan visa data på olika sätt när du genererar rapporter. För att förbättra hur Button ID visas i Analytics Workspace-rapporten skapar vi en klassificeringsvariabel för Button Id (eVar8). När du klassificerar etablerar du en relation mellan variabeln och de metadata som är relaterade till den variabeln.

Sedan skapar vi en klassificeringsvariabel för Analytics.

1. Välj **Rapportsviter** på verktygsmenyn **Admin**
1. Välj **Report Suite-ID** i fönstret **Report Suite Manager** och klicka på **Redigera inställningar** > **Konvertering** > **Konverteringsklassificeringar**

   ![Konverteringsklassificering](assets/create-analytics-workspace/conversion-classification.png)

1. I listrutan **Välj klassificeringstyp** väljer du variabeln (eVar8-Knapp-ID) för att lägga till en klassificering.
1. Klicka på pilen till höger bredvid Klassificeringsvariabeln som listas under Klassificeringar för att lägga till en ny klassificering.

   ![Konverteringsklassificeringstyp](assets/create-analytics-workspace/select-classification-variable.png)

1. Ange ett lämpligt namn för textklassificeringen i dialogrutan **Redigera en klassificering**. En dimensionskomponent med textklassificeringsnamnet skapas.

   ![Konverteringsklassificeringstyp](assets/create-analytics-workspace/new-classification.png)

1. **Spara** dina ändringar.

### Klassificeringsimportör

Använd importverktyget för att överföra klassificeringar till Adobe Analytics. Du kan också exportera data för uppdatering före en import. Data som du importerar med importverktyget måste ha ett visst format. Adobe ger dig möjlighet att ladda ned en datamall med all korrekt rubrikinformation i en tabbavgränsad datafil. Du kan lägga till nya data i den här mallen och sedan importera datafilen i webbläsaren med FTP.

#### Klassificeringsmall

Innan du importerar klassificeringar till marknadsföringsrapporter kan du hämta en mall som hjälper dig att skapa en klassificeringsdatafil. I datafilen används de klassificeringar du vill använda som kolumnrubriker, och sedan ordnas rapportdatauppsättningen under rätt klassificeringsrubriker.

Sedan hämtar vi klassificeringsmallen för variabeln Button ID (eVar8)

1. Navigera till **Admin** > **Klassificeringsimporteraren**
1. Vi hämtar en klassificeringsmall för konverteringsvariabeln från fliken **Hämta mall**.
   ![Konverteringsklassificeringstyp](assets/create-analytics-workspace/classification-importer.png)

1. På fliken Hämtningsmall anger du datamallens konfiguration.
   * **Välj Report Suite** : Välj den rapportsvit som ska användas i mallen. Rapportsviten och datauppsättningen måste matcha.
   * **Datauppsättning som ska klassificeras** : Välj datatyp för datafilen. Menyn innehåller alla rapporter i rapportsviterna som är konfigurerade för klassificeringar.
   * **Kodning** : Välj teckenkodning för datafilen. Standardkodningsformatet är UTF-8.

1. Klicka på **Hämta** och spara mallfilen på det lokala systemet. Mallfilen är en tabbavgränsad datafil (.tab filename) som stöds av de flesta kalkylbladsprogram.
1. Öppna den tabbavgränsade datafilen med valfri redigerare.
1. Lägg till Knapp-ID (eVar9) och ett motsvarande knappnamn i den tabbavgränsade filen för varje eVar9-värde från steg 9 i avsnittet.

   ![Nyckelvärde](assets/create-analytics-workspace/key-value.png)

1. **Spara** den tabbavgränsade filen.
1. Navigera till fliken **Importera fil**.
1. Konfigurera målet för filimporten.
   * **Välj Report Suite** : WKND Site AEM (Report Suite)
   * **Datauppsättning som ska klassificeras** : Knapp-ID (konverteringsvariabel eVar8)
1. Klicka på alternativet **Välj fil** om du vill överföra den tabbavgränsade filen från datorn och klicka sedan på **Importera fil**

   ![Filimporteraren](assets/create-analytics-workspace/file-importer.png)

   >[!NOTE]
   >
   > Om importen lyckas visas omedelbart de ändringar som gjorts i en export. Dataändringar i rapporter tar dock upp till fyra timmar vid användning av en webbläsarimport och upp till 24 timmar vid användning av en FTP-import.

#### Ersätt konverteringsvariabel med klassificeringsvariabel

1. Välj **Workspace** i verktygsfältet Analyser och öppna arbetsytan som skapats i avsnittet [Skapa ett projekt i Analysis Workspace](#create-a-project-in-analysis-workspace) i den här självstudien.

   ![Workspace-knapp-ID](assets/create-analytics-workspace/workspace-report-button-id.png)

1. Ersätt sedan måttet **Knapp-ID** på arbetsytan som visar ID:t för en Call to Action-knapp (CTA) med klassificeringsnamnet som skapades i föregående steg.

1. I komponentsökaren söker du efter **WKND CTA Buttons** och drar och släpper dimensionen **WKND CTA Buttons (Knapp-ID)** till måttet för Knapp-ID och ersätter den.

   * **Före**

     ![Workspace-knapp före](assets/create-analytics-workspace/wknd-button-before.png)
   * **Efter**

     ![Workspace-knapp efter](assets/create-analytics-workspace/wknd-button-after.png)

1. Du kan lägga märke till att värdet för Knapp-ID som innehåller knapp-ID:t för en Call to Action-knapp (CTA) nu har ersatts med ett motsvarande namn som finns i Klassificeringsmallen.
1. Låt oss jämföra Analytics Workspace-tabellen med WKND-startsidan och förstå antalet klickningar i CTA Button och dess analys. Baserat på arbetsytans frihandstabelldata är det tydligt att 22 gånger användare har klickat på knappen **SKI NOW** och fyra gånger för WKND Home Page Camping i Western Australia **Läs mer** .

   ![CTA-rapport](assets/create-analytics-workspace/workspace-report-buttons-wknd.png)

1. Spara ditt Adobe Analytics Workspace-projekt och ge en beskrivning. Du kan också lägga till taggar i ett arbetsyteprojekt.

   ![Spara projekt](assets/create-analytics-workspace/save-project.png)

1. När du har sparat projektet kan du dela arbetsyteprojektet med andra medarbetare eller teamkamrater med alternativet Dela.

   ![Dela projekt](assets/create-analytics-workspace/share.png)

## Grattis!

Du har just lärt dig att mappa data som samlats in från en Adobe Experience Manager-webbplats till mätvärden och dimensioner i Adobe Analytics rapporteringsprogram. Utför också en klassificering för mätvärdena och bygg en detaljerad kontrollpanel för rapportering med Analysis Workspace-funktionen i Adobe Analytics.
