---
title: Förstå innehållsfragment och upplevelsefragment
description: Lär dig likheterna och skillnaderna mellan innehållsfragment och Experience Fragments, och när och hur du använder varje typ.
sub-product: assets, sites, content services
feature: Content Fragments, Experience Fragments
topics: headless
version: 6.3, 6.4, 6.5
doc-type: article
activity: understand
audience: all
topic: Content Management
role: User
level: Beginner
exl-id: ccbc68d1-a83e-4092-9a49-53c56c14483e
source-git-commit: fb4a39a7b057ca39bc4cd4a7bce02216c3eb634c
workflow-type: tm+mt
source-wordcount: '1016'
ht-degree: 0%

---

# Förstå innehållsfragment och upplevelsefragment

Adobe Experience Manager Content Fragments och Experience Fragments kan se likadana ut på ytan, men de spelar en viktig roll i olika fall. Lär dig hur innehålls- och upplevelsefragment liknar varandra, skiljer sig åt och när och hur du använder varje fragment.

## Jämförelser av innehållsfragment och upplevelsefragment

<table>
<tbody><tr><td><strong> </strong></td>
<td><strong>Innehållsfragment (CF)</strong></td>
<td><strong>Experience Fragments (XF)</strong></td>
</tr><tr><td><strong>Definition</strong></td>
<td><ul>
<li>Återanvändbar, presentationsagnostisk <strong>innehåll</strong>, som består av strukturerade dataelement (text, datum, referenser osv.)</li>
</ul>
</td>
<td><ul>
<li>En återanvändbar, sammansatt av en eller flera AEM komponenter som definierar innehåll och presentation som utgör en <strong>upplevelse</strong> som är meningsfull på egen hand</li>
</ul>
</td>
</tr><tr><td><strong>Core Tenants</strong></td>
<td><ul>
<li>Innehållscentrerat</li>
<li>Definieras av en <a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-models.html?lang=en" target="_blank">strukturerad, formulärbaserad datamodell.</a></li>
<li>Design- och layoutagnostiker.</li>
<li>Kanalen äger presentationen av Content Fragment-innehållet (layout och design)</li>
</ul>
</td>
<td><ul>
<li>Presentationscentrerad</li>
<li>Definieras av ostrukturerad komposition för AEM</li>
<li>Definierar design och layout för innehåll</li>
<li>Används i befintligt skick i kanaler</li>
</ul>
</td>
</tr><tr><td><strong>Teknisk information</strong></td>
<td><ul>
<li>Implementerat som en <strong>dam:Asset</strong></li>
<li>Definieras av en <a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-models.html?lang=en" target="_blank">Content Fragment Model</a></li>
</ul>
</td>
<td><ul>
<li>Implementerat som en <strong>cq:Page</strong></li>
<li>Definieras av redigerbara mallar</li>
<li>Inbyggd HTML-rendering</li>
</ul>
</td>
</tr><tr><td><strong>Variationer</strong></td>
<td><ul>
<li>Den Överordnad variationen är den kanoniska variationen</li>
<li>Variationer är skiftlägeskänsliga, som kan justeras mot kanaler.</li>
</ul>
</td>
<td><ul>
<li>Variationer är kanal- eller kontextspecifika</li>
<li>Variationer hålls synkroniserade via AEM Live Copy</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html" target="_blank">Byggblock</a> tillåta återanvändning av innehåll i olika varianter</li>
</ul>
</td>
</tr><tr><td><strong>Funktioner</strong></td>
<td><ul>
<li>Variationer</li>
<li>Versioner</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-variations.html?lang=en#synchronizing-with-master" target="_blank">Synkronisering</a> innehåll i olika varianter</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-managing.html?lang=en#comparing-fragment-versions" target="_blank">Visual diff</a> av Content Fragment-versioner</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-variations.html?lang=en#annotating-a-content-fragment" target="_blank">Anteckningar</a> av flerradiga textelement</li>
<li>Intelligent <a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-variations.html?lang=en#summarizing-text" target="_blank">sammanfattning</a> av flerradiga textelement.</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/creating-translation-projects-for-content-fragments.html?lang=en" target="_blank">Översättning/lokalisering</a></li>
</ul>
</td>
<td><ul>
<li>Variationer</li>
<li>Variationer som live-kopior</li>
<li>Versioner</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en#building-blocks" target="_blank">Byggklossarna</a></li>
<li>Anteckningar</li>
<li>Responsiv layout och förhandsgranskning</li>
<li>Översättning/lokalisering</li>
</ul>
</td>
</tr><tr><td><strong>Användning</strong></td>
<td><ul>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html" target="_blank">Komponenten AEM kärnkomponenter för innehållsfragment</a> för användning i AEM Sites, AEM Screens eller i Experience Fragments.</li>
<li>JSON-export via <a href="https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview.html?lang=en" target="_blank">AEM Content Services</a> för förbrukning från tredje part</li>
<li>JSON via AEM HTTP Assets API:er för användning av tredje part.</li>
</ul>
</td>
<td><ul>
<li>AEM Experience Fragment-komponent som ska användas i AEM Sites, AEM Screens eller andra Experience Fragments.</li>
<li>Exportera som <a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en" target="_blank">Plain HTML</a> för användning i tredjepartssystem</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/administering/integration/experience-fragments-target.html?lang=en" target="_blank">HTML export till Adobe Target</a> för riktade erbjudanden</li>
<li>JSON-export till Adobe Target för riktade erbjudanden</li>
</ul>
</td>
</tr><tr><td><strong>Vanliga användningsområden</strong></td>
<td><ul>
<li>Högstrukturerat datainmatnings-/formulärbaserat innehåll</li>
<li>Långsiktigt redaktionellt innehåll (flerradselement)</li>
<li>Innehåll som hanteras utanför livscykeln för de kanaler som levererar det</li>
</ul>
</td>
<td><ul>
<li>Centraliserad hantering av marknadsföringsmaterial i flera kanaler med hjälp av olika kanaler.</li>
<li>Innehåll som återanvänds på flera sidor på en webbplats.</li>
<li>Webbplatsfärg (t.ex. sidhuvud och sidfot)</li>
<li>En upplevelse som hanteras utanför livscykeln för de kanaler som levererar den</li>
</ul>
</td>
</tr><tr><td><strong>Dokumentation</strong></td>
<td><ul>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/home.html?lang=en&amp;topic=/experience-manager/6-5/assets/morehelp/content-fragments.ug.js" target="_blank">AEM Content Fragments User Guide</a></li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-learn/sites/content-fragments/content-fragments-feature-video-use.html?lang=en" target="_blank">Använda innehållsfragment i AEM</a></li>
</ul>
</td>
<td><ul>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en" target="_blank">Adobe dokumentation om Experience Fragments</a></li>
</ul>
</td>
</tr></tbody></table>

## Arkitektur för innehållsfragment

I följande diagram visas den övergripande arkitekturen för AEM innehållsfragment

!![Arkitektur för innehållsfragment](./assets/content-fragments-architecture.png)

+ **Modeller för innehållsfragment** Definiera de element (eller fält) som definierar vilket innehåll som innehållsfragmentet kan fånga och visa.
+ The **Innehållsfragment** är en instans av en Content Fragment Model som representerar en logisk innehållsenhet.
+ Innehållsfragment **variationer** som följer innehållsfragmentmodellen har dock olika innehåll.
+ Innehållsfragment kan visas/användas av:
   + Använda innehållsfragment på **AEM Sites** (eller AEM Screens) via AEM WCM Core Components Content Fragment-komponent.
   + Bädda in ett innehållsfragment i en **Experience Fragment** via AEM WCM Core Components Content Fragment-komponent, för användning i alla Experience Fragment-fall.
   + Visa ett innehållsfragment varierar innehåll som JSON via **AEM Content Services** och API-sidor för skrivskyddade användningsfall.
   + Exponera innehåll i innehållsfragment (alla varianter) direkt som JSON via direktanrop till AEM Assets via **AEM Assets HTTP API** för CRUD-användning.

## Experience Fragments arkitektur

!![Experience Fragments arkitektur](./assets/experience-fragments-architecture.png)

+ **Redigerbara mallar**, som i sin tur definieras av **Redigerbara malltyper** och **Implementering av AEM** definierar du de AEM komponenter som kan användas för att skapa en Experience Fragment.
+ The **Experience Fragment** är en instans av en redigerbar mall som representerar en logisk upplevelse.
+ Experience Fragment **variationer** som följer den redigerbara mallen har dock olika upplevelser (innehåll och design).
+ Upplevelsefragment kan visas/användas av:
   + Använda Experience Fragments på AEM Sites (eller AEM Screens) via komponenten AEM Experience Fragment.
   + Visa ett Experience Fragment-varierande innehåll som JSON (med inbäddad HTML) via **AEM Content Services** och API-sidor.
   + Exponera en Experience Fragment-variation direkt som **&quot;Plain HTML&quot;**.
   + Exportera Experience Fragments till **Adobe Target** som antingen HTML eller JSON erbjuder.
   + AEM Sites stöder HTML erbjudanden, men JSON-erbjudanden kräver specialanpassad utveckling.

## Supporting materials for Content Fragments

+ [Användarhandbok för innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-65/assets/home.html?lang=en&amp;topic=/experience-manager/6-5/assets/morehelp/content-fragments.ug.js)
+ [Använda innehållsfragment i AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/content-fragments/content-fragments-feature-video-use.html?lang=en)
+ [AEM WCM Core Components&#39; Content Fragment component](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html)
+ [Använda innehållsfragment och AEM Headless](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/overview.html?lang=en)
+ [Komma igång med AEM Content Services](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview.html?lang=en)

## Supporting materials for Experience Fragments

+ [Adobe dokumentation om Experience Fragments](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en)
+ [AEM Experience Fragments](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html?lang=en)
+ [Använda AEM Experience Fragments](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html?lang=en)
+ [Använda AEM Experience Fragments med Adobe Target](https://medium.com/adobetech/experience-fragments-and-adobe-target-d8d74381b9b2)
