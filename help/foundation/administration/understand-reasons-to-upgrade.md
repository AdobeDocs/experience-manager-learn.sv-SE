---
title: Förstå skäl att uppgradera
description: En högnivåbeskrivning av de viktigaste funktionerna för kunder som funderar på att uppgradera till den senaste versionen av Adobe Experience Manager.
version: 6.5
sub-product: resurser, cloud manager, handel, innehållstjänster, dynamiska medier, formulär, grund, skärmar, sajter
topics: best-practices, upgrade
audience: all
activity: understand
doc-type: article
translation-type: tm+mt
source-git-commit: 1519856731758ece2860615c06fc0d64edb104a5
workflow-type: tm+mt
source-wordcount: '3540'
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

+ **Stöd för SPA Editor** gör att SPA (single-page applications) kan redigeras i sin helhet i AEM, vilket stöder en omfattande, marknadsföringsvänlig redigeringsupplevelse.
+_ **JavaScript SDK**, ett SPA Project Start Kit och tillhörande verktyg, gör att gränssnittsutvecklare kan utveckla SPA Editor-kompatibla single page-applikationer oberoende av AEM.
+ **Med Core Components** läggs en mängd nya komponenter till, ett **komponentbibliotek** samt en mängd förbättringar till befintliga Core Components.
+ Ytterligare **översättningsförbättringar** effektiviserar översättningen av AEM Sites.

### Flytande upplevelser

AEM fortsätter att anamma flytande upplevelser med nya och förbättrade verktyg som underlättar användningen av innehåll utanför AEM.

+ **Innehållsfragment** har stöd för versionsjämförelse/differenser och anteckningar.
+ **AEM Assets HTTP API** har stöd för att visa **innehållsfragment** direkt i DAM som **JSON**.
   **Experience Fragments** har stöd för **Fulltextsökning** och **AEM Dispatcher Cache Invalidation** för att referera till **sidor**.

### Resurshantering

AEM Assets fortsätter att bygga vidare på sin omfattande uppsättning funktioner för tillgångshantering för att förbättra användningen, hanteringen och förståelsen av DAM. AEM 6.5 fortsätter att förbättra integrationen mellan Adobe Creative Cloud och de kreativa arbetsflödena.

+ **Adobe Asset Link** kopplar samman kreatörer direkt med AEM Assets från Adobe Creative Cloud verktyg.
+ **Tack vare integreringen med Adobe Stock** får du direkt tillgång till Adobe Stock-bilder direkt från AEM Assets-upplevelsen, vilket ger en smidig upplevelse vid innehållsidentifiering.
+ **AEM Desktop App** släpper version 2.0 och omdefinierar sig själv samtidigt som prestanda och stabilitet förbättras.
+ **Anslutna resurser** stöder diskreta AEM Sites-instanser för smidig åtkomst till och användning av resurser från en annan AEM Assets-instans.
+ Uppdaterat videostöd i **Dynamic Media**, inklusive **360 Video** och **anpassade videominiatyrer**.

### Innehållsintelligens

AEM fortsätter att bygga sin integrering med smarta tekniker och utnyttjar maskininlärning och artificiell intelligens för att förbättra alla upplevelser.

+ **Adobe Asset Link** innehåller **visuell likhetssökning** som gör det enkelt att identifiera och använda liknande bilder i **Adobe Creative Cloud-verktyg**.

### Integreringar

AEM utökar sin förmåga att integrera med andra Adobe-tjänster:

+ **Experience Fragments** fördjupar integreringen med **Adobe Target** genom stöd för **Exportera som JSON** till Adobe Target och möjligheten att **ta bort Experience Fragment-baserade erbjudanden** från **Adobe Target**.

### AMS Cloud Manager

[Cloud Manager](https://adobe.ly/2HODmsv), som är exklusivt för Adobe Managed Services-kunder (AMS), erbjuder följande funktioner:

+ Cloud Manager har stöd för utökad AEM driftsättning från AEM Sites till **AEM Assets**, inklusive **automatisk prestandatestning av materialbearbetning**.
+ **Automatisk skalning** av AEM-publiceringsnivån vid fördefinierade tröskelvärden ger en optimal slutanvändarupplevelse.
+ **Med icke-produktionsrörledningar** kan utvecklingsteamen använda Cloud Manager för att kontinuerligt kontrollera kodkvaliteten och distribuera till lägre miljöer (utveckling och kvalitetssäkring).
+ **Med API:er för CI/CD-överföring** kan kunderna programmässigt interagera med Cloud Manager, vilket ger djupare integreringsmöjligheter med en lokal utvecklingsinfrastruktur.

## Foundation Features

Nedan finns en matris med grundläggande funktioner som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Foundation](https://helpx.adobe.com/experience-manager/6-5/release-notes/wcm-platform.html)

***○<sup>+</sup>signifikanta förbättringar av funktionen i den här versionen.***

***○<sup>SP</sup>anger att funktionen är tillgänglig via Service Pack eller Feature Pack.***

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
                <strong><a href="https://jackrabbit.apache.org/oak/docs/index.html" target="_blank">Oak Content Repository</a>:</strong> Ger mycket bättre prestanda och skalbarhet än föregångaren Jackrabbit 2.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/indexing-via-the-oak-run-jar.html">oak-run.jar Index Support</a>:</strong> Förbättrad omindexering, statistikinsamling och konsekvenskontroll av ekindexvärden.</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/revision-cleanup.html" target="_blank">Rensa</a>onlineändringar:</strong>
                Utför databasunderhåll utan driftavbrott.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/storage-elements-in-aem-6.html" target="_blank">Lagring</a>av tarMK eller MongoMK:</strong>
                <br> Alternativ för enkel, högpresterande filbaserad lagring av tarMK (nästa generations tarPM) <br> eller skalas vågrätt med en MongoDB-understödd databas med MongoMK.</td>
            <td> </td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/aem-with-mongodb.html" target="_blank">Prestanda och stabilitet</a>i MongoMK:</strong>
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
            <td><strong>Funktionsparitet för Touch UI:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/operations-dashboard.html" target="_blank">Kontrollpanel för</a>åtgärder:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/upgrade.html" target="_blank">Uppgraderingsförbättringar</a>:</strong>
            Uppgraderingsförbättringar gör det enklare och snabbare att uppgradera AEM på plats.</td>
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

***○<sup>+</sup>betecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

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
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-service-users.html" target="_blank">Tjänstanvändare</a></strong><br> Kompartmentaliserar behörigheter för att undvika onödig användning av administratörsbehörigheter.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/saml-2-0-authenticationhandler.html" target="_blank">Hantering</a></strong>av nyckelarkiv <br> Global Trust store, certifikat och nycklar hanteras inom databasen.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/csrf-protection.html" target="_blank"><strong>Skyddet mot CSRF</strong>-<strong>skydd</strong></a><br> av förfrågningar mellan webbplatser är inte tillgängligt.</td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/saml-2-0-authenticationhandler.html" target="_blank"><strong>CORS</strong><strong>har stöd</strong></a>för resursdelning mellan <br> ursprungsländer vilket ger större flexibilitet i applikationen.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://docs.adobe.com/docs/en/aem/6-5/administer/security/saml-2-0-authenticationhandler.html" target="_blank">Förbättrat stöd</a><br>för SAML-autentisering </strong>Förbättrad SAML-omdirigering, optimerad gruppinformation och problem med nyckelkryptering har åtgärdats.
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
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ldap-config.html" target="_blank">LDAP som en OSGi-konfiguration</a><br></strong>förenklar hantering och uppdatering av LDAP-autentisering.</td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong>OSGi-krypteringsstöd för lösenord<br></strong>med oformaterad text och andra känsliga värden kan sparas i krypterad form och dekrypteras automatiskt.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/user-group-ac-admin.html" target="_blank">CUG-förbättringarna</a><br></strong>Slutanvändargruppsimplementeringen har skrivits om för att åtgärda problem med prestanda och skalbarhet.</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔<sup>+</sup></td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/platform-repository/using/ssl-wizard-technical-video-use.html" target="_blank">SSL Wizard</a></strong><br> UI förenklar installation och hantering av SSL.</td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/encapsulated-token.html" target="_blank">Inkapslat tokenstöd</a></strong><br> behövs inte längre för att"klisterlösa" sessioner ska kunna hantera horisontell autentisering över publiceringsinstanser.</td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ims-config-and-admin-console.html" target="_blank">Adobe IMS-autentisering Support</a><br></strong>Exklusivt för Adobe Managed Services (AMS), centralt hantera åtkomst till AEM Author-instanser via Adobe IMS (Identity Management System).</td>
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

***○<sup>+</sup>signifikanta förbättringar av funktionen i den här versionen.***

***○<sup>SP</sup>anger att funktionen är tillgänglig via Service Pack eller Feature Pack.***

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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/responsive-layout.html" target="_blank">Redigering</a>av responsiv webbplats:</strong>
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
            Skapa engagerande webbupplevelser med SPA-ramverk (Single-Page Application) som bygger på React eller Angular.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
            <td>✔<sup>+</sup></td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/release-notes/style-system-fp.html" target="_blank">Formatsystem</a>:</strong>
            Öka återanvändningen av AEM genom att definiera deras visuella utseende med hjälp av sammanhangsberoende system.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>○<sup>SP</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/msm.html" target="_blank">Hanterare för flera platser (MSM)</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/sites/using/content-fragments-feature-video-understand.html" target="_blank">Innehållsfragment</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/release-notes/content-services-fragments-featurepack.html" target="_blank">Innehållstjänster</a>:</strong>
            Exportera innehåll från AEM som JSON för användning på olika enheter och i olika program.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>○<sup>SP</sup></td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/content-targeting-touch.html" target="_blank">Adobe Target Integration</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/campaign.html" target="_blank">Adobe Campaign Integration</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/aem-screens-introduction.html" target="_blank">Skärmar</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/ecommerce.html" target="_blank">e-handel</a>:</strong>
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

## Resursfunktioner

Nedan finns en matris med de viktigaste Assets-funktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Assets](https://helpx.adobe.com/experience-manager/6-5/release-notes/assets.html)

***✔ anger att det finns betydande förbättringar av funktionen i den här versionen.***

***○<sup>+</sup>betecknar att funktionen är tillgänglig via Service Pack eller Feature Pack.***

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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/managing-assets-touch-ui.html" target="_blank">Optimerat användargränssnitt</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/task-content.html" target="_blank">Hantering av uppgifter</a> och <a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/projects-with-workflows.html" target="_blank">arbetsflöden</a> :</strong>
            Färdiga arbetsflöden och uppgifter för granskning och godkännande av digitala resurser som utnyttjar AEM projekt.</td>
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
            Förbättrat stöd för konsumtion, överföring och lagring i stor skala.</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/brand-portal/using/brand-portal.html" target="_blank">Varumärkesportal</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/touch-ui-asset-insights.html" target="_blank">Resursinsikter</a>:</strong>
            Använd Adobe Analytics för att fånga upp kundernas interaktion med digitala resurser och se AEM.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/multilingual-assets.html" target="_blank">Flerspråkiga resurser</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/kt/assets/using/smart-translation-search-feature-video-use.html" target="_blank">Smart översättning-sökning</a>:</strong>
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
                <br> Photoshop och Acrobat PDF-bibliotek används för högklassig filhantering.</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/aem-assets-adobe-stock.html" target="_blank">Adobe Stock Integration</a>:</strong>
            Få smidig tillgång till och använd Adobe Stock-bilder direkt från AEM.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>○<sup>SP</sup></td>
            <td>✔</td>
        </tr>
    </tbody>
</table>

### AEM Assets Dynamic Media

***○<sup>+</sup>signifikanta förbättringar av funktionen i den här versionen.***

***○<sup>SP</sup>anger att funktionen är tillgänglig via Service Pack eller Feature Pack.***


<table>
    <thead>
        <tr>
            <td>Funktionen Dynamic Media</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/managing-assets.html" target="_blank">Bildbehandling</a>:</strong>
            Leverera bilder dynamiskt i olika storlekar och format, inklusive Smart Crop.</td>
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
            <td><strong>Uppsättningar (<a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/image-sets.html" target="_blank">bild</a>, <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/spin-sets.html" target="_blank">snurra</a>, <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/mixed-media-sets.html" target="_blank">blandade media</a>):</strong>
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
            <td><strong><a href="https://docs.adobe.com/docs/en/aem/6-5/administer/content/dynamic-media/viewer-presets.html" target="_blank">Visare</a>:</strong>
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
            Möjlighet att migrera överordnad resurser och fortsätta använda befintliga S7-URL:er.</td>
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

+ [Versionsinformation för AEM Forms](https://helpx.adobe.com/experience-manager/6-5/release-notes/forms.html)

***○<sup>+</sup>signifikanta förbättringar av funktionen i den här versionen.***

***○<sup>SP</sup>anger att funktionen är tillgänglig via Service Pack eller Feature Pack.***

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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/generate-document-of-record-for-non-xfa-based-adaptive-forms.html" target="_blank">Dokumentet</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#EnhancedintegrationwithAdobeSign" target="_blank">Adobe Sign Integration</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#AEMFormsdataintegration" target="_blank">Dataintegrering</a>från tredje part:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/user-guide.html?topic=/experience-manager/6-5/forms/morehelp/integrations.ug.js" target="_blank">Integration med Marketing Cloud</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/pdf/aem-forms/6-5/WorkbenchHelp.pdf" target="_blank">Arbetsflöde (J2EE) för Forms-bearbetning</a>:</strong>
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

## Funktioner i Communities

Nedan finns en matris med de viktigaste AEM Communities Add-on-funktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Sammanfattning av nya funktioner i AEM Communities](https://helpx.adobe.com/experience-manager/6-5/communities/using/whats-new-aem-communities.html#main-pars_text)

***○<sup>+</sup>signifikanta förbättringar av funktionen i den här versionen.***

***○<sup>SP</sup>anger att funktionen är tillgänglig via Service Pack eller Feature Pack.***

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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/forum.html" target="_blank">Forum</a>:</strong> (Social Component Framework) Skapa nya ämnen eller visa, följ, söka efter och flytta befintliga ämnen.</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>
                <p><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/working-with-qna.html" target="_blank">QnA</a>:</strong>
                Fråga, visa och svara på frågor.</p>
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
                <strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/blog-feature.html" target="_blank">Bloggar</a>:</strong>
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
                <strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/ideation-feature.html" target="_blank">Idén</a>:</strong>
                Skapa och dela idéer med communityn eller visa, följ och kommentera befintliga idéer.
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resource.html" target="_blank">Tilldelning</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/catalog.html" target="_blank">Katalog</a> - och <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resource.html" target="_blank">resurshantering</a>:</strong>
            Få åtkomst till aktiveringsresurser från katalogen.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resources.html#CreateaLearningPath" target="_blank">Hantering</a>av utbildningsvägar:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/resources.html#main-pars_text_899882038" target="_blank">Aktivering</a>:</strong>
            Lägg till kommentarer om aktiveringsresurser.</td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/analytics.html" target="_blank">Aktiveringsanalys</a>:</strong>
            Videoanalys, Progress Reporting och Assignation Reporting</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td rowspan="8">Kommentarer</td>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/comments.html" target="_blank">Kommentarer</a> och bilagor:</strong>
            (Social Component Framework) Som medlem i communityn delar han sin åsikt och kunskap om innehåll på Communities-webbplatsen.</td>
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
                (Social Component Framework) Som community-medlem granskar en del av innehållet med hjälp av en kombination av kommentarer och klassificeringsfunktioner.</td>
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
                (Social Component Framework) Som medlem i communityn lägger du upp eller ned en röst för ett visst innehåll.</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/search.html" target="_blank">Sök</a>:</strong>
            Prediktiva och prediktiva sökningar.</td>
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
                <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/sites.html" target="_blank">Webbplats</a> - och <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/tools-groups.html" target="_blank">gruppmallar</a> för guidebaserad framtagning av fullt fungerande communitysajter.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Redigerbara mallar:</strong>
            Gör det möjligt för communityadministratörer att skapa rika upplevelser med hjälp AEM redigerbara mallar.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/creating-groups.html" target="_blank">Grupper eller undergrupper</a>:</strong>
            Skapa dynamiskt undergrupper inom communityn.
            </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/in-context.html" target="_blank">Moderering</a>:</strong>
            Modererar användargenererat innehåll.
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/moderate-ugc.html#CommonModerationConcepts" target="_blank">Spam detection and Profanity filters</a>:</strong>
            Automatisk identifiering av skräppost.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/members.html" target="_blank">Medlemshantering</a>:</strong>
            Hantera användarprofiler och grupper från medlemshanteringsområdet.</td>
            <td> </td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
            <td>✔</td>
            <td>✔<sup>+</sup></td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/overview.html#main-pars_text_866731966" target="_blank">Responsiv design</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/analytics.html" target="_blank">Analyser</a>:</strong>
            Integrera med Adobe Analytics för att få viktiga insikter i hur communityn används.</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/activities.html" target="_blank">Verksamheter</a> och <a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/notifications.html" target="_blank">meddelanden</a>:</strong>
            Visa senaste aktiviteter och få meddelanden om intressanta händelser.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
        </tr>
        <tr>
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/communities/using/configure-messaging.html" target="_blank">Meddelanden</a>:</strong>
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
            Användargenererat innehåll (UGC) sparas direkt i en lokal MySQL-databasinstans.</td>
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

AEM Communities lägger till [förbättringar](https://helpx.adobe.com/experience-manager/6-5/communities/using/whats-new-aem-communities.html) genom releaser som gör det möjligt för organisationer att engagera och möjliggöra för sina användare genom att:

+ **@mention** support in user-generated content.
+ Hjälpmedelsförbättringar genom **tangentbordsnavigering** i **aktiveringskomponenter** .
+ Förbättrad **massmoderering** med **anpassade filter**.
+ **Redigerbara mallar** som gör det möjligt för communityadministratörer att skapa multimedieupplevelser i AEM.
+ Användare kan nu skicka **direktmeddelanden i grupp** till alla medlemmar i en grupp.
