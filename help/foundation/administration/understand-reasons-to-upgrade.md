---
title: Förstå anledningar att uppgradera
description: En högnivåbeskrivning av de viktigaste funktionerna för kunder som överväger att uppgradera till den senaste versionen av Adobe Experience Manager 6.
version: 6.5
topic: Upgrade
feature: Release Information
role: Leader, Architect, Developer, Admin, User
level: Beginner
doc-type: Article
exl-id: bf4030b0-67c4-4b00-af95-f63e6f79e995
duration: 809
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '2586'
ht-degree: 1%

---

# Förstå skäl att uppgradera

En högnivåbeskrivning av de viktigaste funktionerna för kunder som överväger att uppgradera till den senaste versionen av Adobe Experience Manager 6.

## Viktiga funktioner för uppgradering till AEM 6.5

+ [Versionsinformation om Adobe Experience Manager 6.5](https://helpx.adobe.com/experience-manager/6-5/release-notes.html)

### Foundation improvements

Adobe Experience Manager 6.5 fortsätter att förbättra systemets stabilitet, prestanda och stödbarhet via:

+ **Java 11** (med stöd för Java 8).

### Skapa och hantera webbplatser

AEM Sites presenterar ett antal funktioner för att snabba upp framtagningen och utbyggnaden av webbplatser:

+ **SPA** kan SPA (single-page-applikationer) redigeras i sin helhet i AEM, vilket stöder en omfattande, marknadsföringsvänlig upplevelse.
+_ **JavaScript SDK&#39;s**, en SPA startsats för projekt och stödverktyg för bygge, gör det möjligt för gränssnittsutvecklare att utveckla SPA redigerarkompatibla single page-applikationer oberoende av AEM.
+ **Kärnkomponenter** innehåller en mängd nya komponenter, **Komponentbibliotek** samt en mängd förbättringar av befintliga kärnkomponenter.
+ Ytterligare **Översättningar** förbättringarna effektiviserar översättningen av AEM Sites.

### Flytande upplevelser

AEM fortsätter att anamma flytande upplevelser med nya och förbättrade verktyg som underlättar användningen av innehåll utanför AEM.

+ **Innehållsfragment** stöd för versionsjämförelse/diff och anteckningar.
+ **AEM Assets HTTP API** stöder exponering **Innehållsfragment** direkt i DAM som **JSON**.
  **Upplevelsefragment** support **Fulltextsökning** och **Invalidering av AEM Dispatcher Cache** för referens **Sidor**.

### Resurshantering

AEM Assets fortsätter att bygga vidare på sin omfattande uppsättning funktioner för tillgångshantering för att förbättra användningen, hanteringen och förståelsen av DAM. AEM 6.5 fortsätter att förbättra integrationen mellan Adobe Creative Cloud och de kreativa arbetsflödena.

+ **Adobe Asset Link** kopplar samman kreatörer direkt till AEM Assets från Adobe Creative Cloud verktyg.
+ **Adobe Stock** integreringen ger direktåtkomst till Adobe Stock bilder direkt från AEM Assets och skapar en smidig upplevelse för innehållsidentifiering.
+ **AEM datorprogram** releases version 2.0 and re-envisioning self while improve performance and ability.
+ **Anslutna resurser** har stöd för diskreta AEM Sites-instanser för smidig åtkomst till och användning av resurser från en annan AEM Assets-instans.
+ Uppdaterat videostöd i **Dynamic Media**, inklusive **360-video** och **Egna videominiatyrer**.

### Innehållsintelligens

AEM fortsätter att bygga sin integrering med smarta tekniker och utnyttjar maskininlärning och artificiell intelligens för att förbättra alla upplevelser.

+ **Adobe Asset Link** tillägg **Visuell likhetssökning**, vilket gör att liknande bilder enkelt kan hittas och användas i **Adobe Creative Cloud**.

### Integreringar

AEM utökar sin förmåga att integrera med andra Adobe-tjänster:

+ **Upplevelsefragment** fördjupar integreringen med **Adobe Target** genom att **Exportera som JSON** till Adobe Target och möjlighet att **ta bort Experience Fragment-baserade erbjudanden** från **Adobe Target**.

### AMS Cloud Manager

[Cloud Manager](https://adobe.ly/2HODmsv), som endast är till för Adobe Managed Services-kunder (AMS), har följande funktioner:

+ Cloud Manager har stöd för utökade AEM från AEM Sites till **AEM Assets**, inklusive **automatisk prestandatestning av materialbearbetning**.
+ **Automatisk skalning** av AEM publiceringsnivå vid fördefinierade tröskelvärden säkerställer en optimal slutanvändarupplevelse.
+ **Icke-produktionsrörledningar** gör det möjligt för utvecklingsteam att utnyttja Cloud Manager för att kontinuerligt kontrollera kodkvaliteten och driftsätta i lägre miljöer (utveckling och kvalitetskontroll).
+ **API:er för CI/CD-pipeline** gör det möjligt för kunderna att programmatiskt interagera med Cloud Manager, vilket ger djupare integreringsmöjligheter med en lokal utvecklingsinfrastruktur.

## Foundation Features

Nedan finns en matris med grundläggande funktioner som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Foundation](https://helpx.adobe.com/experience-manager/6-5/release-notes/wcm-platform.html)

***✔<sup>+</sup> betydande förbättringar av funktionen i den här versionen.***

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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/storage-elements-in-aem-6.html" target="_blank">Lagring av TarmMK eller MongoMK</a>:</strong>
                <br> Alternativ för enkel, högpresterande filbaserad lagring av tarMK (nästa generationens version av tarPM)
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/aem-with-mongodb.html" target="_blank">Prestanda och stabilitet i MongoMK</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/operations-dashboard.html" target="_blank">Instrumentpanel för åtgärder</a>:</strong>
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
                Cloud Manager är exklusivt för Adobe Managed Services-kunder (AMS) och snabbar upp utvecklingen och driftsättningen via en modern CI/CD-pipeline.</td>
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
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/csrf-protection.html" target="_blank"><strong>CSRF</strong> <strong>skydd</strong></a>
            <br> Förfalskningsskydd för förfrågningar på flera webbplatser ingår inte.</td>
        <td></td>
        <td></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/saml-2-0-authenticationhandler.html" target="_blank"><strong>CORS</strong> <strong>support</strong></a>
            <br> Funktioner för resursdelning mellan ursprungsländer ger större flexibilitet i applikationen.</td>
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
            <br> UI för att förenkla konfiguration och hantering av SSL.</td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td> </td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/encapsulated-token.html" target="_blank">Stöd för inkapslad token</a></strong>
            <br> Krävs inte längre för"klibbiga" sessioner som har stöd för horisontell autentisering över publiceringsinstanser.</td>
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
 </strong>Endast för Adobe Managed Services (AMS) kan du centralt hantera åtkomst till AEM Author-instanser via Adobe IMS (Identity Management System).</td>
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

***✔<sup>+</sup> betydande förbättringar av funktionen i den här versionen.***

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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/responsive-layout.html" target="_blank">Framtagning av responsiv webbplats</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/spa-overview.html" target="_blank">SPA</a>:</strong>
            Skapa engagerande webbupplevelser med Single-Page Application (SPA) som bygger på React.</td>
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
            Öka återanvändningen av AEM genom att definiera deras visuella utseende med hjälp av sammanhangsberoende system.</td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td> </td>
            <td>✔<sup>SP</sup></td>
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
            <td><strong>Adobe Analytics Integration and Content Insights:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/using/aem_launch_adobeio_integration.html" target="_blank">Integrering med Adobe Launch</a>:</strong>
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
            <td><strong>Skärmar:</strong>
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

## Resursfunktioner

Nedan finns en matris med de viktigaste Assets-funktionerna som AEM erbjuder. Vissa av dessa funktioner introducerades i tidigare versioner med stegvisa förbättringar som lades till i varje release.

+ [Versionsinformation för AEM Assets](https://helpx.adobe.com/experience-manager/6-5/release-notes/assets.html)

***✔ anger att det finns betydande förbättringar av funktionen i den här versionen.***

***✔<sup>+</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***

<table>
    <thead>
        <tr>
            <td>Funktionen Resurser</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/task-content.html" target="_blank">Uppgift</a> och <a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/projects-with-workflows.html" target="_blank">Arbetsflöde</a> Hantering:</strong>
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
            Generera produktkataloger. Skapa broschyrer, flygblad och annonser baserade på mallar för InDesigner.</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/aem-assets-adobe-stock.html" target="_blank">Adobe Stock Integration</a>:</strong>
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

***✔<sup>+</sup> betydande förbättringar av funktionen i den här versionen.***

***✔<sup>SP</sup> anger att funktionen är tillgänglig via ett Service Pack eller funktionspaket.***


<table>
    <thead>
        <tr>
            <td>Dynamic Media Feature</td>
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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/managing-assets.html" target="_blank">Bildbehandling</a>:</strong>
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
            <td><strong><a href="https://experienceleague.adobe.com/docs/" target="_blank">Tittare</a>:</strong>
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

***✔<sup>+</sup> betydande förbättringar av funktionen i den här versionen.***

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
            <td><strong><a href="https://helpx.adobe.com/experience-manager/6-5/forms/using/generate-document-of-record-for-non-xfa-based-adaptive-forms.html" target="_blank">Dokument för registrering</a>:</strong>
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
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#EnhancedintegrationwithAdobeSign" target="_blank">Acrobat Sign Integration</a>:</strong>
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
            Säker åtkomst och behörighet till dokument från PDF och Office.
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
            <td><strong><a href="https://helpx.adobe.com/aem-forms/6-5/whats-new.html#Simplifiedauthoringexperience" target="_blank">Testa bildrutor</a>:</strong>
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

