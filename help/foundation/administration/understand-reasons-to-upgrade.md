---
title: Förstå skäl att uppgradera
description: En högnivåbeskrivning av de viktigaste funktionerna för kunder som funderar på att uppgradera till den senaste versionen av Adobe Experience Manager.
version: 6.5
topic: Upgrade
role: Leader, Architect, Developer, Admin, User
level: Beginner
source-git-commit: ea7d49985e69ecf9713e17e51587125b3fb400ee
workflow-type: tm+mt
source-wordcount: '3462'
ht-degree: 1%

---


# Förstå skäl att uppgradera

En högnivåbeskrivning av de viktigaste funktionerna för kunder som funderar på att uppgradera till den senaste versionen av Adobe Experience Manager.

## Viktiga funktioner för uppgradering till AEM 6.5

+ [Versionsinformation om Adobe Experience Manager 6.5](https://helpx.adobe.com/experience-manager/6-5/release-notes.html)

### Foundation improvements

Adobe Experience Manager 6.5 fortsätter att förbättra systemets stabilitet, prestanda och stödbarhet via:

+ **Stöd för Java 11** (med stöd för Java 8).

### Skapa och hantera webbplatser

AEM Sites presenterar ett antal funktioner för att snabba upp framtagningen och utbyggnaden av webbplatser:

+ **Med SPA** Editor Support kan SPA (single-page-applikationer) redigeras i sin helhet i AEM, vilket stöder en omfattande, marknadsföringsvänlig redigeringsupplevelse.
+_ **JavaScript SDK&#39;s**, en SPA Project Start Kit med stödverktyg, gör att gränssnittsutvecklare kan utveckla SPA redigerarkompatibla single page-applikationer oberoende av AEM.
+ **Core** Components - en mängd nya komponenter, ett  **komponentbibliotek** samt en mängd förbättringar av befintliga Core Components.
+ Ytterligare **Translations**-förbättringar effektiviserar översättningen av AEM Sites.

### Flytande upplevelser

AEM fortsätter att anamma flytande upplevelser med nya och förbättrade verktyg som underlättar användningen av innehåll utanför AEM.

+ **Content** Fragmentsupportför versionsjämförelse/diff och anteckningar.
+ **AEM Assets HTTP** APIet exponera  **Content** Fragmentsdirekt i DAM som  **JSON**.
   **Experience** Fragmenterstöder  **fulltextsökning** och  **AEM Dispatcher Cache** Invalidering för att referera till  **sidor**.

### Resurshantering

AEM Assets fortsätter att bygga vidare på sin omfattande uppsättning funktioner för tillgångshantering för att förbättra användningen, hanteringen och förståelsen av DAM. AEM 6.5 fortsätter att förbättra integrationen mellan Adobe Creative Cloud och de kreativa arbetsflödena.

+ **Adobe Asset** Links knyter samman kreatörer direkt till AEM Assets från Adobe Creative Cloud verktyg.
+ **Tack vare integreringen med Adobe** Stock får du direkt tillgång till Adobe Stock-bilder direkt från AEM Assets-upplevelsen, vilket skapar en smidig upplevelse när du identifierar innehåll.
+ **AEM Desktop** version 2.0 och omdesignar sig själv samtidigt som prestanda och stabilitet förbättras.
+ **Anslutna** resurser stöder diskreta AEM Sites-instanser för smidig åtkomst till och användning av resurser från en annan AEM Assets-instans.
+ Uppdaterat videostöd i **Dynamic Media**, inklusive **360 Video** och **anpassade videominiatyrer**.

### Innehållsintelligens

AEM fortsätter att bygga sin integrering med smarta tekniker och utnyttjar maskininlärning och artificiell intelligens för att förbättra alla upplevelser.

+ **Adobe Asset** Links innehåller  **visuell likhetssökning** som gör att liknande bilder enkelt kan hittas och användas i  **Adobe Creative Cloud-verktyg**.

### Integreringar

AEM utökar sin förmåga att integrera med andra Adobe-tjänster:

+ **Experience** Fragmenters fördjupar integreringen med  **Adobe** Targetby med stöd för  **Exportera som** JSONtill Adobe Target och möjligheten att  **ta bort Experience Fragment-baserade** erbjudanden från  **Adobe Target**.

### AMS Cloud Manager

[Cloud Manager](https://adobe.ly/2HODmsv), som är exklusivt för Adobe Managed Services-kunder (AMS), erbjuder följande funktioner:

+ Cloud Manager har stöd för utökning AEM driftsättningsstöd från AEM Sites till **AEM Assets**, inklusive **automatisk prestandatestning av mediebearbetning**.
+ **Automatisk skalning** av AEM-publiceringsnivån vid fördefinierade tröskelvärden ger en optimal slutanvändarupplevelse.
+ **Icke-produktionsförlopp** gör det möjligt för utvecklingsteam att använda Cloud Manager för att kontinuerligt kontrollera kodkvaliteten och distribuera till lägre miljöer (utveckling och kvalitetskontroll).
+ **Med API:t för CI/CD-** pipeline kan kunderna programmässigt interagera med Cloud Manager och fördjupa integreringsmöjligheterna med en lokal utvecklingsinfrastruktur.

## Foundation Features

Nedan finns en matris med grundläggande funktioner som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Foundation](https://helpx.adobe.com/experience-manager/6-5/release-notes/wcm-platform.html)

***○ <sup>+</sup> Betydande förbättringar av funktionen i den här versionen.***

***○ <sup></sup> SPbetecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

<table>
    <thead>
        <tr>
            <td>Foundation Feature</td>
            <td>5.6.x</td>
            <td>6.0</td>
            <td>6.1</td>
            <td>6.2</td>
            <td>6.3</td>
            <td>6.4</td>
            <td>6.5</td>
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
                <strong><a href="https://jackrabbit.apache.org/oak/docs/index.html" target="_blank">Oak Content Repository</a>:</strong> Ger mycket bättre prestanda och skalbarhet jämfört med föregångaren Jackrabbit 2.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/indexing-via-the-oak-run-jar.html">indexstöd</a> för oak-run.jar:</strong> Förbättrad indexering, statistikinsamling och konsekvenskontroll av Oak-index.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/queries-and-indexing.html" target="_blank">Anpassade sökindex</a>:  </strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/revision-cleanup.html" target="_blank">Rensa</a> online-versioner:</strong>
                Utför databasunderhåll utan driftstopp på servern.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/storage-elements-in-aem-6.html" target="_blank">Lagring</a> i TjärMK- eller MongoMK-databas:</strong>
                <br> Alternativ för enkel, högpresterande filbaserad lagring av TjärMK (nästa generationens version av TjärPM) 
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/aem-with-mongodb.html" target="_blank">MongoMK-prestanda och -stabilitet</a>:</strong>
            MongoMK har förbättrats ytterligare sedan det introducerades med AEM 6.0.</td>
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
            Utnyttja den expanderbara molnlagringslösningen för lagring av binära resurser.</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Touch UI Feature Parity: </strong>
                Kontinuerliga förbättringar av användargränssnittet för snabbare redigering med ökad produktivitet och funktionsparitet med Classic UI.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Sök:</strong>
                Sök och navigera AEM snabbt.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/operations-dashboard.html" target="_blank">Kontrollpanel</a> för åtgärder:</strong>
 Utför underhåll, övervaka serverns hälsa och analysera prestanda inifrån AEM.</td>
            <td></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/upgrade.html" target="_blank">Förbättrade uppgraderingar</a>: </strong>
            Förbättrade uppgraderingar gör det enklare och snabbare att uppgradera AEM på plats.</td>
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
            <td><strong><a href="https://adobe.ly/2HODmsv" target="_blank">Cloud Manager</a>:  </strong>
                Cloud Manager är exklusivt för kunder som använder Adobe Managed Services (AMS) och snabbar upp utvecklingen och driftsättningen via en modern CI/CD-pipeline.</td>
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

Nedan finns en matris med viktiga säkerhetsfunktioner som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation om säkerhet](https://helpx.adobe.com/experience-manager/6-5/release-notes/wcm-platform.html#Security)

***✔ anger att det finns betydande förbättringar av funktionen i den här versionen.***

***○ <sup>+</sup> betecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

<table>
    <thead>
        <tr>
            <td>Säkerhetsfunktion</td>
            <td>5.6.x</td>
            <td>6.0</td>
            <td>6.1</td>
            <td>6.2</td>
            <td>6.3</td>
            <td>6.4</td>
            <td>6.5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-service-users.html" target="_blank">TjänstanvändareBehörigheter </a></strong>
            <br> förenklar användningen av administratörsbehörighet i onödan.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/saml-2-0-authenticationhandler.html" target="_blank">Hantering av nyckelarkivGlobal </a></strong>
            <br> förtroendearkiv, certifikat och nycklar hanteras inom databasen.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/csrf-protection.html" target="_blank"><strong>Förfalskningsskydd för </strong> <strong></strong></a>
            <br> CSRFprotectionCross-Site Request.</td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/saml-2-0-authenticationhandler.html" target="_blank"><strong>CORSsupportStöd </strong> <strong></strong></a>
            <br> för resursdelning mellan ursprung ger större flexibilitet i programanvändningen.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://experienceleague.adobe.com/docs/" target="_blank">Förbättrat stöd </a><br>
 </strong>för SAML-autentiseringFörbättrad SAML-omdirigering, optimerad gruppinformation och problem med nyckelkryptering har åtgärdats. 
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
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ldap-config.html" target="_blank">LDAP som OSGi-</a><br>
 </strong>konfigurationFörenklar hantering och uppdatering av LDAP-autentisering.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong>OSGi-krypteringsstöd för <br>
 </strong>lösenord med oformaterad textLösenord och andra känsliga värden kan sparas i krypterad form och dekrypteras automatiskt.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/user-group-ac-admin.html" target="_blank">CUG-</a><br>
 </strong>förbättringarSlutanvändargruppsimplementeringen har skrivits om för att åtgärda problem med prestanda och skalbarhet.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔<sup>+</sup></td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/platform-repository/using/ssl-wizard-technical-video-use.html" target="_blank">SSL </a></strong>
            <br> WizardUI för att förenkla installation och hantering av SSL.</td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/encapsulated-token.html" target="_blank">Inkapslat </a></strong>
            <br> tokenstödKrävs inte längre för"klisterlösa" sessioner som stöder horisontell autentisering över publiceringsinstanser.</td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ims-config-and-admin-console.html" target="_blank">Adobe IMS Authentication </a><br>
 </strong>SupportExklusivt för Adobe Managed Services (AMS), centralt hantera åtkomst till AEM Author-instanser via Adobe IMS (Identity Management System).</td>
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

Nedan finns en matris med de viktigaste webbplatsfunktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Sites](https://helpx.adobe.com/experience-manager/6-5/release-notes/sites.html)

***○ <sup>+</sup> Betydande förbättringar av funktionen i den här versionen.***

***○ <sup></sup> SPbetecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

<table>
    <thead>
        <tr>
            <td><strong>Webbplatsfunktion</strong></td>
            <td>5.6.x</td>
            <td>6.0</td>
            <td>6.1</td>
            <td>6.2</td>
            <td>6.3</td>
            <td>6.4</td>
            <td>6.5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/sites/using/page-editor-feature-video-use.html" target="_blank">Touchoptimerad sidredigering</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/responsive-layout.html" target="_blank">Responsiv webbplatsredigering</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/core-components/user-guide.html" target="_blank">Kärnkomponenter</a>: </strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/spa-overview.html" target="_blank">SPA Editor</a>:</strong>
            Skapa tilltalande, engagerande webbupplevelser med ramverk för Single-Page Application (SPA) som bygger på React eller Angular.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong>Style System:</strong>
            Öka återanvändningen av AEM genom att definiera deras visuella utseende med hjälp av sammanhangsberoende formatsystem.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>SP</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/msm.html" target="_blank">Hanteraren för flera webbplatser (MSM)</a>:</strong>
            Hantera flera webbplatser som delar gemensamt innehåll (t.ex. flerspråkiga varumärken).</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/translation.html" target="_blank">Innehållsöversättning</a>: </strong>
            Plug and play-ramverket integreras med branschledande översättningstjänster från tredje part.</td>
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
            Nästa generationens ramverk för klientkontext för personalisering av innehåll.</td>
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
            Framkalla innehåll för en framtida release utan att störa den dagliga redigeringen.</td>
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
            Skapa och strukturera redigerbart innehåll som inte är kopplat från presentationen för enkel återanvändning.</td>
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
            Exportera innehåll från AEM som JSON för användning på olika enheter och i olika program.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>SP</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Adobe Analytics integrerings- och innehållsinsikter:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/content-targeting-touch.html" target="_blank">Adobe Target-integrering</a>: </strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/campaign.html" target="_blank">Adobe Campaign-integrering</a>: </strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/using/aem_launch_adobeio_integration.html" target="_blank">Adobe Launch Integration</a>:</strong>
            Integrera med Adobe nästa generations tagghanteringsmolntjänst.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>skärmar:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ecommerce.html" target="_blank">e-handel</a>: </strong>
            Leverera varumärkesanpassade, personaliserade shoppingupplevelser på webben, i mobilen och via sociala kontaktytor.
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

## Resursfunktioner

Nedan finns en matris med de viktigaste Assets-funktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Assets](https://helpx.adobe.com/experience-manager/6-5/release-notes/assets.html)

***✔ anger att det finns betydande förbättringar av funktionen i den här versionen.***

***○ <sup>+</sup> betecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

<table>
    <thead>
        <tr>
            <td>Funktionen Resurser</td>
            <td>5.6.x</td>
            <td>6.0</td>
            <td>6.1</td>
            <td>6.2</td>
            <td>6.3</td>
            <td>6.4</td>
            <td>6.5</td>
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
            metadatamallar, redigeringsprogram för metadatamodell och gruppmetadataredigering.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/task-content.html" target="_blank">Hantering av </a> uppgifter och  <a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/projects-with-workflows.html" target="_blank"></a> arbetsflöden:</strong>
            Fördefinierade arbetsflöden och uppgifter för granskning och godkännande av digitala resurser som utnyttjar AEM projekt.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Skalbarhet och prestanda: </strong>
            Förbättrat stöd för förtäring, överföring och lagring i stor skala.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/mac-api-assets.html" target="_blank">Resurser för HTTP API</a>:</strong>
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
            Enkel ad hoc-delning av digitalt material utan att behöva logga in.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/brand-portal/using/brand-portal.html" target="_blank">Brand Portal</a>:SAAS-lösning för </strong>
            molntjänster för smidig delning och distribution av digitala resurser.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/use-assets-across-connected-assets-instances.html" target="_blank">Anslutna resurser</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/touch-ui-asset-insights.html" target="_blank">Resursinsikter</a>: </strong>
            Utnyttja Adobe Analytics för att fånga kundens interaktion med digitala resurser och visa i AEM.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/multilingual-assets.html" target="_blank">Flerspråkiga resurser</a>: </strong>
            Översättningsstöd för metadata för resurser automatiskt med språkrötter.</td>
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
            Utnyttja Adobe Sensei för att tagga bilder automatiskt med användbara metadata.</td>
            <td> </td>
            <td></td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/assets/using/smart-translation-search-feature-video-use.html" target="_blank">SmartTranslation Search</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/indesign.html" target="_blank">Adobe InDesign Server Integration</a>:</strong>
            Generera produktkataloger. Skapa broschyrer, flygblad och annonser baserade på InDesign-mallar.</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/desktop-app/aem-desktop-app.html" target="_blank">AEM datorprogram</a>:</strong>
            Synkronisera resurser till det lokala skrivbordet för redigering med Creative Suite-produkter.
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/imaging-transcoding-library.html" target="_blank">Adobe Imaging Library</a>: </strong>
                <br> Photoshop och Acrobat PDF Libraries används för att hantera filer med hög kvalitet.</td>
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
            Få åtkomst till AEM Assets direkt från Adobe Create Cloud-program.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/aem-assets-adobe-stock.html" target="_blank">Adobe Stock Integration</a>: </strong>
            Få smidig tillgång till Adobe Stock-bilder direkt från AEM.</td>
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

***○ <sup>+</sup> Betydande förbättringar av funktionen i den här versionen.***

***○ <sup></sup> SPbetecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***


<table>
    <thead>
        <tr>
            <td>Dynamic Media Feature</td>
            <td>5.6.x</td>
            <td>6.0</td>
            <td>6.1</td>
            <td>6.2</td>
            <td>6.3 +FP</td>
            <td>6.4</td>
            <td>6.5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/managing-assets.html" target="_blank">Bild</a>: Leverera bilder </strong>
            dynamiskt i olika storlekar och format, inklusive Smart Crop.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/interactive-images.html" target="_blank">Interaktiva media</a>: </strong>
            Skapa interaktiva banners, videor med klickbart innehåll för att visa viktiga erbjudanden.
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
            <td><strong>Uppsättningar (<a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/image-sets.html" target="_blank">Bild</a>,  <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/spin-sets.html" target="_blank">Snurra</a>,  <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/mixed-media-sets.html" target="_blank">Blandade media</a>):</strong>
            Låt användare zooma, panorera, rotera och simulera en 360-graders bildupplevelse.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://experienceleague.adobe.com/docs/" target="_blank">visningsprogram</a>:</strong>
            anpassade multimediespelare och förinställningar med stöd för olika skärmar/enheter.</td>
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
            Flexibla alternativ för länkning eller inbäddning av Dynamic Media-innehåll och leverans via HTTP/2-protokoll.</td>
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
            möjlighet att migrera överordnad resurser och fortsätta använda befintliga S7-URL:er.</td>
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

***○ <sup>+</sup> Betydande förbättringar av funktionen i den här versionen.***

***○ <sup></sup> SPbetecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

<table>
    <thead>
        <tr>
            <td>Forms Feature</td>
            <td>5.6.x</td>
            <td>6.0</td>
            <td>6.1</td>
            <td>6.2</td>
            <td>6.3</td>
            <td>6.4</td>
            <td>6.5</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/generate-document-of-record-for-non-xfa-based-adaptive-forms.html" target="_blank">Dokument för arkivering</a>:</strong>
            Skapa ett dokument för att säkerställa långsiktig lagring av data eller klar version.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/themes.html" target="_blank">Theme Editor</a>:</strong>
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
            Standardisera och implementera bästa praxis för adaptiva formulär.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#EnhancedintegrationwithAdobeSign" target="_blank">Adobe Sign-integrering</a>: </strong>
            Tillåt användning av Adobe Sign integrerade formulärbaserade signeringsscenarier.</td>
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
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#AEMFormsdataintegration" target="_blank">Dataintegrering</a> från tredje part:</strong>
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
            Förenklad driftsättning av godkännandeprocesser för formulär.</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/introduction-managing-forms.html" target="_blank">Form Manager</a>:</strong>
            En och samma plats för hantering av alla formulär/dokument/korrespondens, t.ex. för analys, översättning, A/B-testning, granskning och publicering.
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
            Tillåt bearbetning av online-/offlineformulär i en app på iOS, Android eller Windows.</td>
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
            Skapa innehållsrik kommunikation som riktade programsatser med interaktiva element som diagram (kallades tidigare Adaptiva dokument).</td>
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
            Bygg komplexa formulär/dokumentorienterade arbetsflöden med en intuitiv IDE.</td>
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
            Säker åtkomst och behörighet för PDF- och Office-dokument.
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
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#Simplifiedauthoringexperience" target="_blank">Testa ramverk</a>:</strong>
            Använd plugin-programmet Calvin framework och Chrome för att stödja och felsöka adaptiva formulär.</td>
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

## Funktioner i Communities

Nedan finns en matris med de viktigaste AEM Communities Add-on-funktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

***○ <sup>+</sup> Betydande förbättringar av funktionen i den här versionen.***

***○ <sup></sup> SPbetecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

<table>
    <thead>
        <tr>
            <td> </td>
            <td>Funktionen Communities</td>
            <td>6.0</td>
            <td>6.1</td>
            <td>6.2</td>
            <td>6.3</td>
            <td>6.4</td>
            <td>6.5</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="7">Communities-funktioner</td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/forum.html" target="_blank">Forum</a>:</strong> (Social Component Framework) Skapa nya ämnen eller visa, följa, söka efter och flytta befintliga ämnen.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>
                <p><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/working-with-qna.html" target="_blank">Fråga</a>: </strong>
                Ställ frågor, visa och svara på frågor.</p>
            </td>
            <td></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>
                <strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/blog-feature.html" target="_blank">bloggar</a>:</strong>
                Skapa bloggartiklar och kommentarer på publiceringssidan.
            </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>
                <strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/ideation-feature.html" target="_blank">Idéer</a>:</strong>
                Skapa och dela idéer med communityn eller visa, följa och kommentera befintliga idéer.
            </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>
                <strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/calendar.html" target="_blank">Kalender</a>:</strong>
                (Social Component Framework) Ge webbplatsbesökarna information om communityhändelser.
            </td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>
                <strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/file-library.html" target="_blank">Filbibliotek</a>:</strong>
                Överför, hantera och hämta filer på communitywebbplatsen.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/users.html#AboutCommunityGroups" target="_blank">Användargrupper</a>: 
            </strong>En uppsättning användare kan tillhöra medlemsgrupper och kan tilldelas roller gemensamt.</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong> </strong></td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resource.html" target="_blank">uppdrag</a>:</strong>
            Skapa och tilldela utbildningsresurser till communitymedlemmar.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td rowspan="5">Aktivera</td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/catalog.html" target="_blank">Katalog- och </a> resurshantering <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resource.html" target="_blank">:</a> </strong>
            Åtkomst till aktiveringsresurser från katalog.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resources.html#CreateaLearningPath" target="_blank">Hantering</a> av utbildningsvägar:</strong>
            Hantera kurser eller grupper med aktiveringsresurser.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/reports.html#main-pars_text_1739724213" target="_blank">Aktivera rapportering</a>:</strong>
            Rapportering om aktiveringsresurser och utbildningsvägar.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resources.html#main-pars_text_899882038" target="_blank">Engagemang för aktivering</a>:</strong>
            Lägg till kommentarer för aktiveringsresurser.</td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/analytics.html" target="_blank">aktiveringsanalys</a>:</strong>
            videoanalys, förloppsrapportering och uppdragsrapportering</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td rowspan="8">Kommentarer</td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/comments.html" target="_blank">Kommentarer </a> och bilagor:</strong>
            (Social Component Framework) Som medlem i communityn delar åsikter och kunskap om innehåll på Communities-webbplatsen.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Konvertering av innehållsfragment:</strong>
            Konvertera UGC-bidrag till innehållsfragment.</td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/reviews.html" target="_blank">Recensioner</a>:</strong>
                (Social Component Framework) Som community-medlem granskar en del av innehållet med en kombination av kommentarer och klassificeringsfunktioner.</td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/rating.html" target="_blank">Betyg</a>:/strong&gt; (Social Component Framework) Som medlem i communityn betygsätter en del innehåll.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/voting.html" target="_blank">Röster</a>:</strong>
                (Social Component Framework) Som medlem i communityn kan du rösta ned eller lägga upp innehåll.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/tag-ugc.html" target="_blank">Taggar</a>:</strong>
            Bifoga taggar (nyckelord eller etiketter) med innehåll för att snabbt hitta innehållet.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/search.html" target="_blank">sökning</a>:</strong>
            prediktiva och prediktiva sökningar.</td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/translate-ugc.html" target="_blank">Översättning</a>:</strong>
            Maskinöversättning av användargenererat innehåll.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td rowspan="10">Administration</td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/create-site.html" target="_blank">Platshantering</a>:</strong>
            Skapa webbplatser med communityfunktioner.</td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/sites.html" target="_blank">Mallar</a>:</strong>
                <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/sites.html" target="_blank"></a> Webbplatser och  <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/tools-groups.html" target="_blank"></a> gruppmallar för guidebaserad framtagning av fullt fungerande communitysajter.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Redigerbara mallar:</strong>
            Ge communityadministratörer möjlighet att skapa avancerat material med hjälp AEM redigerbara mallar.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/creating-groups.html" target="_blank">Grupper eller undergrupper</a>:</strong>
            Skapa undergrupper dynamiskt på communityplatser.
            </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/in-context.html" target="_blank">moderering</a>:</strong>
            moderera användargenererat innehåll.
            </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/moderation.html" target="_blank">Massmoderering</a>:</strong>
            Moderationskonsol för att hantera användargenererat innehåll gruppvis.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/moderate-ugc.html#CommonModerationConcepts" target="_blank">Spam-identifiering och Profanity-filter</a>:</strong>
            Automatisk skräppostidentifiering.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/members.html" target="_blank">Medlemshantering</a>: </strong>
            Hantera användarprofiler och grupper från medlemshanteringsområdet.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/overview.html#main-pars_text_866731966" target="_blank">Responsiv design</a>: </strong>
            AEM Communities webbplatser är responsiva.
            </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/analytics.html" target="_blank">Analyser</a>: </strong>
            Integrera med Adobe Analytics för att få viktiga insikter om hur communityn används.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td rowspan="4">Medlemmar</td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/advanced.html" target="_blank">Betygsättning och märkning</a>:</strong>
            (Avancerad poängsättning från Adobe Sensei) Identifiera communitymedlemmar som experter och belöna dem.</td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/activities.html" target="_blank"></a> Aktiviteter och  <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/notifications.html" target="_blank">meddelanden</a>:</strong>
            Visa senaste aktivitetsströmmen och få meddelanden om intressanta händelser.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/configure-messaging.html" target="_blank">meddelanden</a>:</strong>
            Direktmeddelanden till användare och grupper.</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/social-login.html" target="_blank">Sociala inloggningar</a>:</strong>
            Logga in med deras Facebook- eller Twitter-konto.</td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td rowspan="5">Plattform</td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/working-with-srp.html" target="_blank">MSRP (Mongo Storage)</a>:</strong>
            Användargenererat innehåll (UGC) sparas direkt i en lokal MongoDB-instans</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/working-with-srp.html" target="_blank">DSRP (Database Storage)</a>:</strong>
            User-generated content (UGC) finns kvar direkt i en lokal MySQL-databasinstans.</td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/working-with-srp.html" target="_blank">SRP (Cloud Storage)</a>:</strong>
                Användargenererat innehåll (UGC) lagras på fjärrbasis i en molntjänst som hanteras av Adobe.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/working-with-srp.html" target="_blank"><strong>JSRP</a>:</strong>
                Community-innehåll lagras i JCR och UGC är tillgängligt från författarinstansen (eller publiceringsinstansen) som det publicerades i.</td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/sync.html" target="_blank">Användar- och gruppsynkronisering</a>:</strong>
            Synkronisera användare och grupper mellan publiceringsinstanser när du använder en publiceringsservergruppstopologi.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
    </tbody>
</table>

AEM Communities lägger till förbättringar genom releaser som gör det möjligt för organisationer att engagera och möjliggöra för sina användare genom att:

+ **@** mentionsupport i användargenererat innehåll.
+ Hjälpmedelsförbättringar genom **tangentbordsnavigering** i **Aktivera**-komponenter.
+ Förbättrad **Massmoderering** med **Egna filter**.
+ **Redigerbara** mallar ger communityadministratörer möjlighet att skapa multimedieupplevelser i AEM.
+ Användare kan nu skicka **direktmeddelanden i bulk** till alla medlemmar i en grupp.
