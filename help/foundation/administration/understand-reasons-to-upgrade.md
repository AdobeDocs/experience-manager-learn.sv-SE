---
title: Förstå anledningar att uppgradera
description: En högnivåbeskrivning av de viktigaste funktionerna för kunder som överväger att uppgradera till den senaste versionen av Adobe Experience Manager 6.
version: Experience Manager 6.5
topic: Upgrade
feature: Release Information
role: Leader, Architect, Developer, Admin, User
level: Beginner
doc-type: Article
exl-id: bf4030b0-67c4-4b00-af95-f63e6f79e995
duration: 538
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '2588'
ht-degree: 1%

---

# Förstå skäl att uppgradera

En högnivåbeskrivning av de viktigaste funktionerna för kunder som överväger att uppgradera till den senaste versionen av Adobe Experience Manager 6.

## Viktiga funktioner för uppgradering till AEM 6.5

+ [Versionsinformation om Adobe Experience Manager 6.5](https://helpx.adobe.com/experience-manager/6-5/release-notes.html)

### Foundation improvements

Adobe Experience Manager 6.5 fortsätter att förbättra systemets stabilitet, prestanda och stödbarhet via:

+ Stöd för **Java 11** (med stöd för Java 8).

### Skapa och hantera webbplatser

AEM Sites presenterar ett antal funktioner för att snabba upp framtagningen och utbyggnaden av webbplatser:

+ Stödet för **SPA-redigeraren** gör att SPA-program (single-page applications) kan redigeras fullständigt i AEM, vilket ger stöd för en omfattande, marknadsföringsvänlig redigeringsupplevelse.
+_ **JavaScript SDK**, ett SPA Project Start Kit med stödverktyg, gör att gränssnittsutvecklare kan utveckla SPA-redigerarkompatibla single page-applikationer oberoende av AEM.
+ **Kärnkomponenter** lägger till en mängd nya komponenter, ett **komponentbibliotek** samt en mängd förbättringar av befintliga kärnkomponenter.
+ Ytterligare förbättringar i **Översättningar** effektiviserar översättningen av AEM Sites.

### Flytande upplevelser

AEM fortsätter att anamma flytande upplevelser med nya och förbättrade verktyg som underlättar användningen av innehåll utanför AEM.

+ **Innehållsfragment** har stöd för versionsjämförelse/skillnader och anteckningar.
+ **AEM Assets HTTP API** har stöd för att visa **innehållsfragment** direkt i DAM som **JSON**.
  **Experience Fragments** har stöd för **Fulltextsökning** och **AEM Dispatcher Cache Invalidation** för referens till **Sidor**.

### Resurshantering

AEM Assets fortsätter att bygga vidare på sin omfattande uppsättning funktioner för tillgångshantering för att förbättra användningen, hanteringen och förståelsen av DAM. AEM 6.5 fortsätter att förbättra integrationen mellan Adobe Creative Cloud och kreativa arbetsflöden.

+ **Adobe Asset Link** kopplar samman kreatörer direkt till AEM Assets från Adobe Creative Cloud-verktyg.
+ Integreringen av **Adobe Stock** ger direktåtkomst till Adobe Stock-bilder direkt från AEM Assets och skapar en sömlös upplevelse för innehållsidentifiering.
+ **AEM-datorprogrammet** släpper version 2.0 och omdefinierar sig själv samtidigt som prestanda och stabilitet förbättras.
+ **Ansluten Assets** har stöd för diskreta AEM Sites-instanser för smidig åtkomst till och användning av resurser från en annan AEM Assets-instans.
+ Uppdaterat videostöd i **Dynamiska media**, inklusive **360 Video** och **anpassade videominiatyrer**.

### Innehållsintelligens

AEM fortsätter att bygga sin integrering med smarta tekniker och utnyttjar maskininlärning och artificiell intelligens för att förbättra alla upplevelser.

+ **Adobe Asset Link** lägger till **Visuell likhetssökning**, vilket gör att liknande bilder enkelt kan identifieras och användas i **Adobe Creative Cloud-verktyg**.

### Integreringar

AEM utökar sin förmåga att integrera med andra Adobe-tjänster:

+ **Experience Fragments** fördjupar integreringen med **Adobe Target** genom stöd för **Exportera som JSON** till Adobe Target och möjligheten att **ta bort Experience Fragment-baserade erbjudanden** från **Adobe Target**.

### AMS CLOUD MANAGER

[Cloud Manager](https://adobe.ly/2HODmsv), som endast är till för Adobe Managed Services-kunder (AMS), har följande funktioner:

+ Cloud Manager har stöd för utökad AEM-distribution från AEM Sites till **AEM Assets**, inklusive **automatisk prestandatestning av mediebearbetning**.
+ **Automatisk skalning** av AEM Publish-nivån vid fördefinierade tröskelvärden ger en optimal slutanvändarupplevelse.
+ **Icke-produktionspipelines** gör det möjligt för utvecklingsteamen att använda Cloud Manager för att kontinuerligt kontrollera kodkvaliteten och distribuera till lägre miljöer (utveckling och kvalitetskontroll).
+ Med **CI/CD Pipeline-API:er** kan kunderna programmässigt interagera med Cloud Manager och fördjupa integreringsmöjligheterna med en lokal utvecklingsinfrastruktur.

## Foundation Features

Nedan finns en matris med grundläggande funktioner från AEM. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation om AEM Foundation](https://helpx.adobe.com/experience-manager/6-5/release-notes/wcm-platform.html)

***✔<sup>+</sup> viktiga förbättringar av funktionen i den här versionen.***

***✔<sup>SP</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***

<table>
    <thead>
        <tr>
            <td>Foundation Feature</td>
            <td>5.6.x</td>
            <td>6,0</td>
            <td>6,1</td>
            <td>6,2</td>
            <td>6,3</td>
            <td>6,4</td>
            <td>6,5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <strong>Stöd för Java 11:</strong> AEM stöder Java 11 (och Java 8).
            </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
        </tr>
        <tr>
            <td>
                <strong><a href="https://jackrabbit.apache.org/oak/docs/index.html" target="_blank">Oak Content Repository</a>:</strong> Ger mycket bättre prestanda och skalbarhet och föregångaren Jackrabbit 2.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/indexing-via-the-oak-run-jar.html">Index Support för oak-run.jar</a>:</strong> Förbättrad omindexering, statistikinsamling och konsekvenskontroll av Oak-index.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/queries-and-indexing.html" target="_blank">Anpassade sökindex</a>: </strong>
                Möjlighet att lägga till anpassade indexdefinitioner för att optimera frågeprestanda och sökrelevans.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/revision-cleanup.html" target="_blank">Rensa onlineändringar</a>:</strong>
                Utför databasunderhåll utan serverdriftavbrott.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/storage-elements-in-aem-6.html" target="_blank">Datalagring för tarMK eller MongoMK</a>:</strong>
                <br> Alternativ för enkel, högpresterande filbaserad lagring av tarMK (nästa generations version av tarPM)
                <br> eller skala vågrätt med en MongoDB-understödd databas med MongoMK.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/aem-with-mongodb.html" target="_blank">Prestanda och stabilitet för MongoMK</a>:</strong>
            MongoMK har förbättrats ytterligare sedan lanseringen med AEM 6.0.</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/data-store-config.html#AmazonS3DataStore">Amazon S3 DataStore</a>:</strong>
            Utnyttja den expanderbara molnlagringslösningen för att lagra binära resurser.</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Paritet för gränssnittsfunktion för pekskärm:</strong>
                Fortsatta förbättringar av användargränssnittet för snabbare redigering med ökad produktivitet och bättre funktionparitet med det klassiska användargränssnittet.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Omnissearch:</strong>
                Sök och navigera snabbt i AEM.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/operations-dashboard.html" target="_blank">Åtgärdsinstrumentpanel</a>:</strong>
 Utför underhåll, övervaka serverhälsan och analysera prestandan inifrån AEM.</td>
            <td></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/upgrade.html" target="_blank">Uppgraderingsförbättringar</a>:</strong>
            Tack vare uppgraderingsförbättringarna blir det enklare och snabbare att uppgradera AEM på plats.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/htl/using/overview.html" target="_blank">HTML-mallspråk</a>:</strong>
            En modern mallmotor som separerar presentation från logik. Minskar komponentutvecklingstiden avsevärt. Inkrementella funktioner som läggs till i varje release.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://sling.apache.org/documentation/bundles/models.html" target="_blank">Sling Models</a>:</strong>
            Ett flexibelt ramverk för att modellera JCR-resurser i affärsobjekt och logik. Inkrementella funktioner som läggs till i varje release.
            </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://adobe.ly/2HODmsv" target="_blank">Cloud Manager</a>: </strong>
                Cloud Manager snabbar upp utvecklingen och driftsättningen tack vare den senaste tekniken inom CI/CD för kunder som använder Adobe Managed Services (AMS).</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
    </tbody>
</table>

## Säkerhetsfunktioner

Nedan finns en matris med viktiga säkerhetsfunktioner från AEM. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation om säkerhet](https://helpx.adobe.com/experience-manager/6-5/release-notes/wcm-platform.html#Security)

***✔ anger att det finns betydande förbättringar av funktionen i den här versionen.***

***✔<sup>+</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***

<table>
    <thead>
        <tr>
            <td>Säkerhetsfunktion</td>
            <td>5.6.x</td>
            <td>6,0</td>
            <td>6,1</td>
            <td>6,2</td>
            <td>6,3</td>
            <td>6,4</td>
            <td>6,5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-service-users.html" target="_blank">Tjänstanvändare</a></strong>
            <br> Kompartmentaliserar behörigheter för att undvika onödig användning av administratörsbehörigheter.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/saml-2-0-authenticationhandler.html" target="_blank">Hantering av nyckelarkiv</a></strong>
            <br> Global Trust store, certificates, and keys all managed within the database.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/csrf-protection.html" target="_blank"><strong>CSRF</strong> <strong>protection</strong></a>
            <br> Förfalskat skydd av korsbegäran för flera webbplatser ingår inte i paketet.</td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/saml-2-0-authenticationhandler.html" target="_blank"><strong>CORS</strong> <strong>support</strong></a>
            <br> Funktioner för resursdelning mellan ursprung ger större programflexibilitet.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://experienceleague.adobe.com/docs/" target="_blank">Förbättrat stöd för SAML-autentisering</a><br>
 </strong>Förbättrad SAML-omdirigering, optimerad gruppinformation och viktiga krypteringsproblem har åtgärdats.
            <br>
        </td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ldap-config.html" target="_blank">LDAP som en OSGi-konfiguration</a><br>
 </strong>Förenklar hantering och uppdatering av LDAP-autentisering.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong>Stöd för OSGi-kryptering för lösenord med oformaterad text<br>
 </strong>Lösenord och andra känsliga värden kan sparas i krypterad form och dekrypteras automatiskt.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/user-group-ac-admin.html" target="_blank">CUG-förbättringar</a><br>
 </strong>Sluten gruppimplementering har skrivits om för att åtgärda problem med prestanda och skalbarhet.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔<sup>+</sup></td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/platform-repository/using/ssl-wizard-technical-video-use.html" target="_blank">SSL-guiden</a></strong>
            <br> Gränssnitt för att förenkla konfiguration och hantering av SSL.</td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/encapsulated-token.html" target="_blank">Inkapslat tokenstöd</a></strong>
            <br> Krävs inte längre för"klisterlappande" sessioner som stöder horisontell autentisering över publiceringsinstanser.</td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ims-config-and-admin-console.html" target="_blank">Stöd för Adobe IMS-autentisering</a><br>
 </strong>Exklusivt för Adobe Managed Services (AMS), hantera åtkomsten till AEM Author-instanser centralt via Adobe IMS (Identity Management System).</td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
    </tr>
</tbody>
</table>

## Webbplatsfunktioner

Nedan finns en matris över de viktigaste webbplatsfunktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Sites](https://helpx.adobe.com/experience-manager/6-5/release-notes/sites.html)

***✔<sup>+</sup> viktiga förbättringar av funktionen i den här versionen.***

***✔<sup>SP</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***

<table>
    <thead>
        <tr>
            <td><strong>Webbplatsfunktion</strong></td>
            <td>5.6.x</td>
            <td>6,0</td>
            <td>6,1</td>
            <td>6,2</td>
            <td>6,3</td>
            <td>6,4</td>
            <td>6,5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/sites/using/page-editor-feature-video-use.html" target="_blank">Optimerad redigering av pekskärm</a>:</strong>
            Låter redigerare utnyttja surfplattor och datorer med pekskärmar.</td>
            <td></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/responsive-layout.html" target="_blank">Redigering av responsiv webbplats</a>:</strong>
                I layoutläget kan redigerare ändra storlek på komponenter baserat på enhetsbredder för responsiva webbplatser.</td>
            <td></td>
            <td></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/sites/using/template-editor-feature-video-use.html" target="_blank">Redigerbara mallar</a>:</strong>
            Gör det möjligt för specialiserade författare att skapa och redigera sidmallar.</td>
            <td></td>
            <td></td>
            <td></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/core-components/user-guide.html" target="_blank">Kärnkomponenter</a>:</strong>
            Snabba upp webbplatsutvecklingen. Finns på GitHub för frekvent lanseringsschema och flexibilitet.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/spa-overview.html" target="_blank">SPA-redigerare</a>:</strong>
            Skapa engagerande webbupplevelser med SPA-ramverk (Single-Page Application) som bygger på React.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong>Formatsystem:</strong>
            Öka återanvändningen av AEM-komponenter genom att definiera deras visuella utseende med hjälp av kontextsystemet.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>SP</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/msm.html" target="_blank">Multi-Site Manager (MSM)</a>:</strong>
            Hantera flera webbplatser som delar gemensamt innehåll (t.ex. flerspråkiga, flera varumärken).</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/translation.html" target="_blank">Innehållsöversättning</a>:</strong>
            Plug and play-ramverket kan integreras med branschledande översättningstjänster från tredje part.</td>
            <td></td>
            <td></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/contexthub.html" target="_blank">ContextHub</a>:</strong>
            Nästa generations ramverk för klientkontext för personalisering av innehåll.</td>
            <td></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/launches.html" target="_blank">Startar</a>:</strong>
            Utveckla innehåll för en framtida release utan att störa den dagliga produktionen.</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Innehållsfragment:</strong>
            Skapa och strukturera redaktionellt innehåll som inte är kopplat från presentationen för enkel återanvändning.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/sites/using/experience-fragments-feature-video-use.html" target="_blank">Upplevelsefragment</a>:</strong>
            Skapa återanvändbara upplevelser och variationer som är optimerade för datorer, mobiler och sociala kanaler.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong>Innehållstjänster:</strong>
            Exportera innehåll från AEM som JSON för användning på olika enheter och i olika tillämpningar.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>SP</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Adobe Analytics-integrering och innehållsinsikter:</strong>
                Enkel integrering av Adobe Analytics och DTM. Visa prestandainformation i redigeringsmiljön.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/content-targeting-touch.html" target="_blank">Adobe Target-integrering</a>:</strong>
            Stegvisa guider för att skapa riktade upplevelser, skapa återanvändbara erbjudandebibliotek.</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/campaign.html" target="_blank">Adobe Campaign-integrering</a>:</strong>
            Enkel integrering med nästa generations e-postkampanjlösning.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/using/aem_launch_adobeio_integration.html" target="_blank">Taggar i Adobe Experience Platform-integrering</a>:</strong>
            Integrera med Adobe nästa generation av tagghanteringsmolntjänst.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Screens:</strong>
            Hantera upplevelser för digitala skyltar och kioskdatorer.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ecommerce.html" target="_blank">eCommerce</a>:</strong>
            Leverera varumärkesanpassade, personaliserade shoppingupplevelser via webben, mobiler och sociala kontaktytor.
            </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/overview.html" target="_blank">Communities</a>:</strong>
            Forum, kopplade kommentarer, händelsekalendrar och många andra funktioner gör att man kan engagera besökarna på webbplatsen.</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
    </tbody>
</table>

## Assets-funktioner

Nedan finns en lista över de viktigaste funktionerna i Assets som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Assets](https://helpx.adobe.com/experience-manager/6-5/release-notes/assets.html)

***✔ anger att det finns betydande förbättringar av funktionen i den här versionen.***

***✔<sup>+</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***

<table>
    <thead>
        <tr>
            <td>Assets Feature</td>
            <td>5.6.x</td>
            <td>6,0</td>
            <td>6,1</td>
            <td>6,2</td>
            <td>6,3</td>
            <td>6,4</td>
            <td>6,5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/managing-assets-touch-ui.html" target="_blank">Touchoptimerat gränssnitt</a>:</strong>
            Hantera resurser på en stationär dator eller på enheter med pekskärm.</td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/metadata.html" target="_blank">Avancerad metadatahantering</a>:</strong>
            Metadatamallar, redigerare för metadatamall och gruppmetadataredigering.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/task-content.html" target="_blank">Aktivitet</a> och arbetsflödeshantering:</strong>
            Färdiga arbetsflöden och uppgifter för granskning och godkännande av digitalt material som utnyttjar AEM Projects.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Skalbarhet och prestanda:</strong>
            Förbättrat stöd för konsumtion, uppladdning och lagring i stor skala.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/mac-api-assets.html" target="_blank">Assets HTTP API</a>:</strong>
            Interagera programmatiskt med resurser via HTTP och JSON.</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/link-sharing.html" target="_blank">Länkdelning</a>:</strong>
            Enkel ad hoc-delning av digitalt material utan behov av inloggning.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/brand-portal/using/brand-portal.html" target="_blank">Brand Portal</a>:</strong>
            SAAS-lösning för molntjänster för smidig delning och distribution av digitala resurser.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/use-assets-across-connected-assets-instances.html" target="_blank">Ansluten Assets</a>:</strong>
            AEM Sites-instanser kan smidigt komma åt och använda resurser från en annan AEM Assets-instans.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/touch-ui-asset-insights.html" target="_blank">Resursinsikter</a>:</strong>
            Utnyttja Adobe Analytics för att fånga upp kundinteraktion med digitala resurser och visa dem i AEM.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/multilingual-assets.html" target="_blank">Flerspråkig Assets</a>:</strong>
            Översättningsstöd för metadata av resurser automatiskt med språkrötter.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/enhanced-smart-tags.html" target="_blank">Smarta taggar och moderering</a>:</strong>
            Använd Adobe Sensei för att tagga bilder automatiskt med användbara metadata.</td>
            <td> </td>
            <td></td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/assets/using/smart-translation-search-feature-video-use.html" target="_blank">Sök efter smart översättning</a>:</strong>
            Översätt söktermer automatiskt när du söker efter AEM Assets.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/indesign.html" target="_blank">Adobe InDesign Server-integrering</a>:</strong>
            Generera produktkataloger. Skapa broschyrer, flygblad och annonser baserade på InDesign mallar.</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/desktop-app/aem-desktop-app.html" target="_blank">AEM-skrivbordsapp</a>:</strong>
            Synkronisera material till det lokala skrivbordet för redigering med Creative Suite-produkter.
            </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/imaging-transcoding-library.html" target="_blank">Adobe Imaging Library</a>:</strong>
                <br> Photoshop- och Acrobat PDF-bibliotek används för filhantering av hög kvalitet.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://www.adobe.com/creativecloud/business/enterprise/adobe-asset-link.html" target="_blank">Adobe Asset Link</a>:</strong>
            Få tillgång till AEM Assets direkt från Adobe Create Cloud-program.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/aem-assets-adobe-stock.html" target="_blank">Adobe Stock-integrering</a>:</strong>
            Få smidig tillgång till och använd Adobe Stock-bilder direkt från AEM.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>SP</sup></td>
            <td>✔</td>
        </tr>
    </tbody>
</table>

### AEM Assets Dynamic Media

***✔<sup>+</sup> viktiga förbättringar av funktionen i den här versionen.***

***✔<sup>SP</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***


<table>
    <thead>
        <tr>
            <td>Funktionen Dynamic Media</td>
            <td>5.6.x</td>
            <td>6,0</td>
            <td>6,1</td>
            <td>6,2</td>
            <td>6.3 +FP</td>
            <td>6,4</td>
            <td>6,5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/managing-assets.html" target="_blank">Bilder</a>:</strong>
            Leverera bilder dynamiskt i olika storlekar och format, inklusive Smart Crop.</td>
            <td> </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/video-profiles.html" target="_blank">Video</a>:</strong>
            Avancerad videokodning och adaptiv videoströmning</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/interactive-images.html" target="_blank">Interaktiva media</a>:</strong>
            Skapa interaktiva banners, videor med klickbart innehåll för att visa upp viktiga erbjudanden.
            </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Uppsättningar (<a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/image-sets.html" target="_blank">Bild</a>, <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/spin-sets.html" target="_blank">Snurra</a>, <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/mixed-media-sets.html" target="_blank">Blandade media</a>):</strong>
            Låt användarna zooma, panorera, rotera och simulera en 360-gradersvy.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://experienceleague.adobe.com/docs/" target="_blank">Visare</a>:</strong>
            Specialanpassade multimediespelare och förinställningar med stöd för olika skärmar/enheter.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/delivering-dynamic-media-assets.html" target="_blank">Leverans</a>:</strong>
            Flexibla alternativ för länkning eller inbäddning av dynamiskt medieinnehåll och leverans via HTTP/2-protokollet.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Uppgradera från Scene7 till Dynamic Media:</strong>
            Möjlighet att migrera huvudresurser och fortsätta använda befintliga S7-URL:er.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
    </tbody>
</table>

## Forms Features

Nedan finns en matris med de viktigaste AEM Forms Add-on-funktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

***✔<sup>+</sup> viktiga förbättringar av funktionen i den här versionen.***

***✔<sup>SP</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***

<table>
    <thead>
        <tr>
            <td>Forms Feature</td>
            <td>5.6.x</td>
            <td>6,0</td>
            <td>6,1</td>
            <td>6,2</td>
            <td>6,3</td>
            <td>6,4</td>
            <td>6,5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/introduction-forms-authoring.html" target="_blank">Adaptiv Forms Editor</a>:</strong>
            Skapa engagerande, responsiva och anpassningsbara formulär baserat på enhets- och webbläsarinställningar.</td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/generate-document-of-record-for-non-xfa-based-adaptive-forms.html" target="_blank">Postdokument</a>:</strong>
            Skapa ett dokument för att säkerställa långsiktig lagring av datainhämtning eller tryckklar version.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/themes.html" target="_blank">Temeredigeraren</a>:</strong>
            Skapa återanvändbara teman för att formatera komponenter och paneler i ett formulär.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/template-editor.html" target="_blank">Mallredigerare</a>:</strong>
            Standardisera och implementera bästa praxis för anpassningsbara formulär.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#EnhancedintegrationwithAdobeSign" target="_blank">Acrobat Sign-integrering</a>:</strong>
            Tillåt användning av Acrobat Sign integrerade formulärbaserade signeringsscenarier.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/cm-overview.html" target="_blank">Korrespondenshantering</a>:</strong>
            Med AEM Forms kan ni skapa, hantera och leverera personaliserade och interaktiva kundkorrespondenser.
            </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#AEMFormsdataintegration" target="_blank">Dataintegrering från tredje part</a>:</strong>
            Med dataintegrering hämtas data från olika datakällor baserat på användarens indata i ett formulär. När formuläret skickas in skrivs de inhämtade uppgifterna tillbaka till datakällorna.
            </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#FormscentricAEMWorkflowsforAEMFormsonOSGi" target="_blank">Arbetsflöde (på OSGi) för Forms-bearbetning</a>:</strong>
            Förenklad användning av godkännandeprocesser för blanketter.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/user-guide.html?topic=/experience-manager/6-5/forms/morehelp/integrations.ug.js" target="_blank">Integrering med Marketing Cloud</a>:</strong>
            Integrering med Adobe Analytics och Adobe Target för att förbättra och mäta kundupplevelserna.</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/introduction-managing-forms.html" target="_blank">Formulärhanteraren</a>:</strong>
            En och samma plats för att hantera alla formulär/dokument/all korrespondens, till exempel för analys, översättning, A/B-testning, granskningar och publicering.
            </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/aem-forms-app.html" target="_blank">AEM Forms App</a>:</strong>
            Möjliggör bearbetning av online-/offlineformulär i en app på iOS, Android eller Windows.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/adaptive-document.html" target="_blank">Interaktiv kommunikation</a>:</strong>
            Skapa innehållsrika dokument, t.ex. riktade utdrag, med interaktiva element som diagram (f.d. adaptiva dokument).</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong>Arbetsflöde (J2EE) för Forms-bearbetning:</strong>
            Bygg komplexa blanketter/dokumentbaserade arbetsflöden med en intuitiv utvecklingsmiljö.</td>
            <td></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#EnhancedDocumentSecurity" target="_blank">AEM Forms Document Security</a>:</strong>
            Säker åtkomst och behörighet till PDF- och Office-dokument.
            </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#Simplifiedauthoringexperience" target="_blank">Testar bildrutor</a>:</strong>
            Använd Calvin Framework och Chrome plugin för att stödja och felsöka adaptiva formulär.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
    </tbody>
</table>

