---
title: Använda Brand Portal
description: Videogenomgångar av integrationen mellan AEM Author och AEM Assets Brand Portal.
feature: Brand Portal
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
role: User
level: Beginner
last-substantial-update: 2022-06-15T00:00:00Z
doc-type: Feature Video
exl-id: 42f13a19-52bf-413d-a141-63f1f0910dce
duration: 2460
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1702'
ht-degree: 0%

---

# Använda Brand Portal med AEM Assets{#using-brand-portal-with-aem-assets}

Videoguider för integrering av Adobe Experience Manager (AEM) Assets Brand Portal.

## Brand Portal, funktioner och förbättringar september 2019

Brand Portal introducerar i september 2019 främst resurshantering, som ökar innehållets hastighet och möjliggör enkelt och snabbt utbyte av resurser mellan Experience Manager-författare och tredjepartsskapare och -medarbetare.

### Brand Portal Resurser{#asset-sourcing}

Brand Portal Assets Sourcing används för att samla in resurser från tredjepartsorgan och -team och smidigt synkronisera dem tillbaka till Experience Manager Author för granskning och användning.

>[!VIDEO](https://video.tv.adobe.com/v/29365?quality=12&learn=on)

*Experience Manager Author 6.5 SP2 (6.5.2) eller senare krävs för att använda Resurser*

Granska [Aktivera Experience Manager Author för Resurser](https://experienceleague.adobe.com/docs/experience-manager-brand-portal/using/asset-sourcing-in-brand-portal/brand-portal-asset-sourcing.html?lang=sv-SE) om du vill ha instruktioner om hur du konfigurerar och konfigurerar Resurser för Experience Manager Author.

## Brand Portal februari 2019 Funktioner och förbättringar{#brand-portal-features-and-enhancements-644}

>[!VIDEO](https://video.tv.adobe.com/v/26354?quality=12&learn=on)

Brand Portal februari 2019-utgåvan fokuserar på förbättringar av textsökning och de vanligaste kundförfrågningarna.

### Förbättrade sökfunktioner

Brand Portal förbättrar sökningen med partiell textsökning på egenskapsprediat i filtreringsrutan. Om du vill tillåta partiell textsökning måste du aktivera Delvis sökning i egenskapspredikatet i sökformuläret.

Läs vidare om du vill veta mer om partiell textsökning och jokerteckensökning.

#### Sökning efter delvis fras

Nu kan du söka efter resurser genom att endast ange en del - det vill säga ett eller två - av den sökda frasen i filtreringsrutan.

**Använd skiftläge** : Delvis frassökning är användbart när du är osäker på den exakta kombinationen av ord som förekommer i den sökta frasen.

Om ditt sökformulär i Brand Portal till exempel använder egenskapspredikatet för partiell sökning på resurstitel, kommer alla resurser med ordet läger i sin titelfras att returneras när du anger termen läger.

#### Sökning med jokertecken

I Brand Portal går det att använda asterisken (*) i sökfrågan tillsammans med en del av ordet i den sökta frasen.

**Använd skiftläge** :Om du inte är säker på exakt vilka ord som förekommer i den sökda frasen kan du använda en jokerteckenssökning för att fylla i luckorna i sökfrågan.

Om du till exempel anger klättra* returneras alla resurser som har ord som börjar med tecknen klättra i sin titelfras om sökformuläret i Brand Portal använder egenskapspredikat för partiell sökning på resurstitel.

På samma sätt kan du ange:

* \*klättb returnerar alla resurser med ord som slutar med tecken som klättrar i sin titelfras.
* \*klättb\* returnerar alla resurser som innehåller ord som innehåller tecknen som klättrar i sin titelfras.

#### Aktivera mapphierarki

Administratörer kan nu konfigurera hur mapparna visas för icke-adminanvändare (redigerare, visningsprogram och gästanvändare) vid inloggning.
Konfigurationen [Aktivera mapphierarki](https://helpx.adobe.com/se/experience-manager/brand-portal/using/brand-portal-general-configuration.html) har lagts till i Allmänna inställningar på panelen Administrationsverktyg. Om konfigurationen är:

* Aktiverat är det mappträd som börjar från rotmappen synligt för användare som inte är administratörer. Det innebär att de får en navigeringsupplevelse som liknar administratörerna.
* Inaktiverat visas bara de delade mapparna på landningssidan.

[Aktivera mapphierarki](https://helpx.adobe.com/se/experience-manager/brand-portal/using/brand-portal-general-configuration.html) (när det här alternativet är aktiverat) hjälper dig att skilja på mappar med samma namn som delas från olika hierarkier. När du loggar in kan användare som inte är administratörer nu se de virtuella överordnade (och överordnade) mapparna för de delade mapparna.

De delade mapparna ordnas i respektive katalog i virtuella mappar. Du känner igen dessa virtuella mappar med en låsikon.

Observera att standardminiatyrbilden för de virtuella mapparna är miniatyrbilden för den första delade mappen.

### Stöd för videoåtergivningar i Dynamic Media

Användare vars AEM Author-instans är i läget Dynamic Media kan förhandsgranska och ladda ned de dynamiska medieåtergivningarna utöver de ursprungliga videofilerna.

För att tillåta förhandsgranskning och hämtning av dynamiska medierenderingar på specifika innehavarkonton måste administratörer ange Dynamic Media Configuration (DM-Gateway URL) och registrerings-ID för att hämta den dynamiska videon) i videokonfigurationen från administratörsverktygspanelen.

Dynamiska medievideor kan förhandsgranskas på:

* Sidan Resursinformation
* Resursvy
* Förhandsgranskning av länkresurs

Dynamic Media Video-kodningar kan hämtas från:

* Brand Portal
* Delad länk

### Schemalagd publicering till Brand Portal

Assets (och mappar) publiceringsarbetsflöde från [AEM (6.4.2.0)](https://helpx.adobe.com/se/experience-manager/6-5/release-notes/sp-release-notes.html#main-pars_header_9658011) Författarinstans till Brand Portal kan schemaläggas för ett senare datum och en senare tidpunkt.

Publicerade resurser kan också tas bort från portalen vid ett senare datum (tid) genom att schemalägga arbetsflödet för att avpublicera från Brand Portal.

### Konfigurerbart klientalias i URL

Organisationer kan anpassa sin portal-URL genom att ha ett alternativt prefix i URL:en. För att få ett alias för innehavarens namn i den befintliga portalwebbadressen måste man kontakta Adobe support.

Observera att endast prefixet för Brand Portal URL kan anpassas och inte hela URL:en.
En organisation med den befintliga domänen `wknd.brand-portal.adobe.com` kan till exempel få `wkndinc.brand-portal.adobe.com` skapad på begäran.

Instansen AEM Author kan dock bara vara [konfigurerad](https://helpx.adobe.com/se/experience-manager/6-5/assets/using/brand-portal-configuring-integration.html) med URL:en för klient-ID och inte med URL:en för klientalias (alternativ).

**Använd fall** : Organisationer kan uppfylla sina varumärkesbehov genom att anpassa portalens URL i stället för att följa den URL som tillhandahålls av Adobe.

## Brand Portal December 2018 - funktioner och förbättringar{#brand-portal-features-and-enhancements-642}

>[!VIDEO](https://video.tv.adobe.com/v/23707?quality=12&learn=on)

### Gäståtkomst

AEM Brand-portalen ger gäster åtkomst till portalen. En gästanvändare behöver inga autentiseringsuppgifter för att gå in på portalen och kan komma åt och hämta alla gemensamma mappar och samlingar. Gästanvändare kan lägga till resurser i sin ljuslåda (privat samling) och hämta samma. De kan även visa smarta taggsöknings- och sökpredikat som angetts av administratörer. Gästsessionen tillåter inte användare att skapa samlingar och sparade sökningar eller dela dem ytterligare, få åtkomst till inställningar för mappar och samlingar och dela resurser som länkar.

### Snabbare nedladdning

Brand Portal-användare kan utnyttja Aspera-baserade snabba nedladdningar för att få upp till 25 gånger snabbare och få en smidig nedladdningsupplevelse oavsett var i världen de befinner sig. Om du vill hämta resurserna snabbare från Brand Portal eller via en delad länk måste du välja alternativet Aktivera acceleration för hämtning i hämtningsdialogrutan, förutsatt att hämtningsacceleration är aktiverat i organisationen.

* [Guide för att snabba upp hämtningar från Brand Portal](https://helpx.adobe.com/se/experience-manager/brand-portal/using/accelerated-download.html#main-pars_header)
* [Aspera Connect Test Server](https://test-connect.asperasoft.com/)

### Rapport om användarinloggning

En ny rapport om att spåra användarinloggningar har lagts till. Rapporten om användarinloggningar kan vara avgörande för att organisationer ska kunna granska och kontrollera delegerade administratörer och andra användare av Brand Portal.

Rapportloggarna visar namn, e-post-ID:n, profiler (admin, visningsprogram, redigerare, gäst), grupper, senaste inloggning, aktivitetsstatus och antal inloggningar för varje användare.

### Åtkomst till ursprungliga återgivningar

Administratörer kan begränsa användarnas åtkomst till originalbildfiler (jpeg, tiff, png, bmp, gif, pjpeg, x-portable-anymap, x-portable-bitmap, x-portable-graymap, x-portable-pixmap, x-rgb, x-xbitmap, x-pixmap, x-icon, image/photoshop, image/x-photoshop, psd, image/vnd.adobe.photoshop) och ge åtkomst till lågupplösta renderingar som de hämtar från Brand Portal eller via en delad länk. Åtkomsten kan styras på användargruppnivå på fliken Grupper på sidan Användarroller på panelen Administrationsverktyg.

### Nya konfigurationer

Sex nya konfigurationer har lagts till för administratörer för att aktivera/inaktivera följande funktioner för specifika innehavare:

* Tillåt gäståtkomst
* Tillåt användare att begära åtkomst till Brand Portal
* Tillåt administratörer att ta bort resurser från Brand Portal
* Tillåt att offentliga samlingar skapas
* Tillåt att offentliga smarta samlingar skapas
* Tillåt hämtning av acceleration

### Andra förbättringar

* *Sökväg till mapphierarkin på kort- och listvyer* - gör att användarna kan hitta de mappar som lagras i en Brand Portal-instans. Hjälper användarna att skilja mappar med samma namn i olika mapphierarkier.
* *Översiktsalternativ* - ger icke-adminanvändare metadata om resursen/mappen genom att markera resursen/mappen och sedan välja översiktsalternativet i verktygsfältet. Visar för närvarande rubrik, skapad den och sökväg

### Adobe I/O värdar-användargränssnitt för att konfigurera autentiseringsintegreringar

Brand Portal använder Adobe I/O [https://legacy-oauth.cloud.adobe.io/](https://legacy-oauth.cloud.adobe.io/) -gränssnitt för att skapa JWT-program, som gör det möjligt att konfigurera autentiseringsintegreringar för att tillåta AEM Assets-integrering med Brand Portal. Tidigare fanns användargränssnittet för konfigurering av OAuth-integreringar i `https://marketing.adobe.com/developer/`. Mer information om hur du integrerar AEM Assets med Brand Portal för publicering av resurser och samlingar i Brand Portal finns i [Konfigurera AEM Assets-integrering med Brand Portal](https://helpx.adobe.com/se/experience-manager/6-4/assets/using/brand-portal-configuring-integration.html).

## Brand Portal, februari 2018 - funktioner och förbättringar{#brand-portal-features-and-enhancements-632}

Nya funktioner som är inriktade på att anpassa Brand Portal till AEM.

>[!VIDEO](https://video.tv.adobe.com/v/26354?quality=12&learn=on)

### Navigeringsförbättringar

* Uppgraderat användargränssnitt som är anpassat till AEM och använder Coral3 UI.
* Snabb och enkel åtkomst till administrationsverktyg med nya Adobe logotyp.
* Produktnavigering genom en övertäckning
* Snabbnavigering till överordnade mappar från en underordnad mapp.
* Omsökningsalternativ för att navigera till administrationsverktyg och innehåll.
* Med kortvyn, listvyn och kolumnvyn kan du enkelt bläddra bland kapslade mappar.
* Resurssorteringen i listvyn är inte längre begränsad till antalet resurser som visas på skärmen. Alla resurser i en mapp sorteras.

### Förbättrade sökfunktioner

* Med Omnissearch kan du göra en snabb sökning efter resurser och filer i Brand Portal.
* Det finns även ett alternativ för att söka efter resurser i en viss mapp eller plats
* Automatiska nyckelordsförslag gör sökningen enklare
* Förbättra din Omnissearch med ytterligare filter. Du kan spara sökresultatet i en Smart Collection om du vill gå tillbaka till sökningen vid ett senare tillfälle.
* Stöder smart taggad resurssökning
* AEM Smart-taggade resurser kan delas från AEM till Brand Portal och använda smarta taggar för resurssökning i Brand Portal.

### Förbättringar av fildelning

* Användaren kan dela en resurs med hjälp av alternativet för länkdelning.
* När användaren delar resurser måste användaren ange ett förfallodatum för varje resurs. Ger användarna bättre kontroll över de delade resurserna.
* En extern användare med resursdelningslänk kan hämta bilden och visa dess egenskaper.
* Den ursprungliga hierarkin för kapslade mappar bevaras för resursmappar som hämtas.

### Rapporterings- och administrationsfunktioner

* Metadata-schema från AEM Assets kan nu publiceras från AEM till Brand Portal.
* Administratörer kan skapa och hantera tre typer av rapporter - resurser som laddats ned, gått ut och publicerats
* Möjlighet att konfigurera kolumnen som ska inkluderas i rapporten.
* Skapa bildförinställningar för resurser i Brand Portal.
* Möjlighet att ändra administratörens sökformulär för e-post eller söka i Forms för att inkludera ytterligare filtreringsalternativ.
* Uppdatera och förhandsgranska anpassade bakgrundsbilder för ert varumärke
* Använd en rapport om hur många användare, vilket lagringsutrymme som används och totalt antal resurser som används.

## Ytterligare resurser{#additional-resources}

* [Nyheter i Brand Portal](https://helpx.adobe.com/se/experience-manager/brand-portal/using/whats-new.html)
* [AEM Author Replication Agents](https://helpx.adobe.com/se/experience-manager/6-5/assets/using/brand-portal-configuring-integration.html)
* [Guide till accelererad hämtning](https://helpx.adobe.com/se/experience-manager/brand-portal/using/accelerated-download.html#main-pars_header)
* [AEM Assets Brand Portal Adobe Docs](https://helpx.adobe.com/se/experience-manager/brand-portal/using/brand-portal.html)
* [AEM Assets Dynamic Media Adobe Docs](https://experienceleague.adobe.com/docs/?lang=sv-SE)
* [Hämta Aspera Connect](https://downloads.asperasoft.com/connect2/)
* [Aspera Connect Test Server](https://test-connect.asperasoft.com/)
