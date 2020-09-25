---
title: Förstå innehållsfragment och upplevelsefragment
description: Adobe Experience Manager Content Fragments och Experience Fragments kan se likadana ut på ytan, men de spelar en viktig roll i olika fall. Lär dig hur innehålls- och upplevelsefragment liknar varandra, skiljer sig åt och när och hur du använder varje fragment.
sub-product: resurser, webbplatser, innehållstjänster
feature: content fragments, experience fragments
topics: headless
version: 6.3, 6.4, 6.5
doc-type: article
activity: understand
audience: all
translation-type: tm+mt
source-git-commit: 03db12de4d95ced8fabf36b8dc328581ec7a2749
workflow-type: tm+mt
source-wordcount: '998'
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
<li>Återanvändbart, presentationsbaserat <strong>innehåll</strong>som består av strukturerade dataelement (text, datum, referenser osv.)</li>
</ul>
</td>
<td><ul>
<li>En återanvändbar, sammansatt av en eller flera AEM komponenter som definierar innehåll och presentation som utgör en <strong>upplevelse</strong> som är självklar</li>
</ul>
</td>
</tr><tr><td><strong>Core Tenants</strong></td>
<td><ul>
<li>Innehållscentrerat</li>
<li>Definieras av en <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/content-fragments-models.html" target="_blank">strukturerad, formulärbaserad datamodell.</a></li>
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
<li>Implementeras som en <strong>dam:Asset</strong></li>
<li>Definieras av en <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/content-fragments-models.html" target="_blank">innehållsfragmentmodell</a></li>
</ul>
</td>
<td><ul>
<li>Implementeras som en <strong>cq:Page</strong></li>
<li>Definieras av redigerbara mallar</li>
<li>Inbyggd HTML-återgivning</li>
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
<li><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/experience-fragments.html#BuildingBlocks" target="_blank">Byggblocken</a> tillåter återanvändning av innehåll i olika varianter</li>
</ul>
</td>
</tr><tr><td><strong>Funktioner</strong></td>
<td><ul>
<li>Variationer</li>
<li>Versioner</li>
<li><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/content-fragments-variations.html#SynchronizingwithMaster" target="_blank">Synkronisering</a> av innehåll mellan olika variationer</li>
<li><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/content-fragments-managing.html#ComparingFragmentVersions" target="_blank">Visual diff</a> of Content Fragment versions</li>
<li><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/content-fragments-variations.html#AnnotatingaContentFragment" target="_blank">Anteckningar</a> av flerradiga textelement</li>
<li>Intelligent <a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/content-fragments-variations.html#SummarizingText" target="_blank">sammanfattning</a> av flerradiga textelement.</li>
<li><a href="https://helpx.adobe.com/experience-manager/6-5/assets/using/creating-translation-projects-for-content-fragments.html" target="_blank">Översättning/lokalisering</a></li>
</ul>
</td>
<td><ul>
<li>Variationer</li>
<li>Variationer som live-kopior</li>
<li>Versioner</li>
<li><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/experience-fragments.html#BuildingBlocks" target="_blank">Byggklossarna</a></li>
<li>Anteckningar</li>
<li>Responsiv layout och förhandsgranskning</li>
<li>Översättning/lokalisering</li>
</ul>
</td>
</tr><tr><td><strong>Användning</strong></td>
<td><ul>
<li><a href="https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/content-fragment-component.html" target="_blank">AEM Core Components Content Fragment component</a> for use in AEM Sites, AEM Screens or in Experience Fragments.</li>
<li>JSON-export via <a href="https://helpx.adobe.com/experience-manager/kt/sites/using/content-services-tutorial-use.html" target="_blank">AEM Content Services</a> för användning i tredje part</li>
<li>JSON via AEM HTTP Assets API:er för användning av tredje part.</li>
</ul>
</td>
<td><ul>
<li>AEM Experience Fragment-komponent som ska användas i AEM Sites, AEM Screens eller andra Experience Fragments.</li>
<li>Exportera som <a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/experience-fragments.html#ThePlainHTMLRendition" target="_blank">vanlig HTML</a> för användning i tredjepartssystem</li>
<li><a href="https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/experience-fragments-target.html" target="_blank">HTML-export till Adobe Target</a> för riktade erbjudanden</li>
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
<li><a href="https://helpx.adobe.com/experience-manager/6-5/assets/user-guide.html?topic=/experience-manager/6-5/assets/morehelp/content-fragments.ug.js" target="_blank">AEM Content Fragments User Guide</a></li>
<li><a href="https://helpx.adobe.com/experience-manager/kt/sites/using/content-fragments-feature-video-use.html" target="_blank">Använda innehållsfragment i AEM</a></li>
</ul>
</td>
<td><ul>
<li><a href="https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/experience-fragments.html" target="_blank">Adobe dokumentation om Experience Fragments</a></li>
</ul>
</td>
</tr></tbody></table>

## Arkitektur för innehållsfragment

I följande diagram visas den övergripande arkitekturen för AEM innehållsfragment

!![Arkitektur för innehållsfragment](./assets/content-fragments-architecture.png)

+ **Modeller** för innehållsfragment definierar de element (eller fält) som definierar vilket innehåll som innehållsfragmentet kan fånga och visa.
+ **Innehållsfragmentet** är en instans av en innehållsfragmentmodell som representerar en logisk innehållsenhet.
+ Innehållsfragmentsvariationer **** som följer innehållsfragmentmodellen har dock olika innehåll.
+ Innehållsfragment kan visas/användas av:
   + Använda innehållsfragment på **AEM Sites** (eller AEM Screens) via AEM WCM Core Components Content Fragment-komponent.
   + Bädda in ett innehållsfragment i ett **Experience Fragment** via AEM WCM Core Components Content Fragment-komponent, som kan användas i alla Experience Fragment-användningsfall.
   + Exponera ett innehållsfragment som varierar innehåll som JSON via **AEM Content Services** och API Pages för skrivskyddad användning.
   + Exponera innehåll i innehållsfragment (alla varianter) direkt som JSON via direktanrop till AEM Assets via **AEM Assets HTTP API** för CRUD-användning.

## Experience Fragments arkitektur

!![Experience Fragments arkitektur](./assets/experience-fragments-architecture.png)

+ **Redigerbara mallar**, som i sin tur definieras av **redigerbara malltyper** och en implementering **av en** AEM sidkomponent, definierar de tillåtna AEM komponenter som kan användas för att skapa ett Experience Fragment.
+ Experience **Fragment** är en instans av en ändringsbar mall som representerar en logisk upplevelse.
+ Experience Fragment- **variationer** följer den redigerbara mallen men har olika upplevelser (innehåll och design).
+ Upplevelsefragment kan visas/användas av:
   + Använda Experience Fragments på AEM Sites (eller AEM Screens) via komponenten AEM Experience Fragment.
   + Exponera en Experience Fragment-varianter av innehåll som JSON (med inbäddad HTML) via **AEM Content Services** och API Pages.
   + Exponerar en Experience Fragment-variant direkt som **&quot;Vanlig HTML&quot;**.
   + Exportera Experience Fragments till **Adobe Target** som antingen HTML eller JSON.
   + AEM Sites stöder HTML-erbjudanden, men JSON-erbjudanden kräver anpassad utveckling.

## Supporting materials for Content Fragments

+ [Användarhandbok för innehållsfragment](https://helpx.adobe.com/experience-manager/6-5/assets/user-guide.html?topic=/experience-manager/6-5/assets/morehelp/content-fragments.ug.js)
+ [Använda innehållsfragment i AEM](https://helpx.adobe.com/experience-manager/kt/sites/using/content-fragments-feature-video-use.html)
+ [AEM WCM Core Components&#39; Content Fragment component](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/components/content-fragment-component.html)
+ [Använda innehållsfragment och AEM innehållstjänster](https://helpx.adobe.com/experience-manager/kt/sites/using/structured-fragments-content-services-feature-video-use.html)
+ [Komma igång med AEM Content Services](https://helpx.adobe.com/experience-manager/kt/sites/using/content-services-tutorial-use.html)

## Supporting materials for Experience Fragments

+ [Adobe dokumentation om Experience Fragments](https://helpx.adobe.com/experience-manager/6-5/sites/authoring/using/experience-fragments.html)
+ [AEM Experience Fragments](https://helpx.adobe.com/experience-manager/kt/sites/using/experience-fragments-feature-video-understand.html)
+ [Använda AEM Experience Fragments](https://helpx.adobe.com/experience-manager/kt/sites/using/experience-fragments-feature-video-use.html)
+ [Använda AEM Experience Fragments med Adobe Target](https://medium.com/adobetech/experience-fragments-and-adobe-target-d8d74381b9b2)
