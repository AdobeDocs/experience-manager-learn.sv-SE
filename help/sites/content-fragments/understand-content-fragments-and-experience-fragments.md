---
title: Innehållsfragment och Upplevelsefragment
description: Lär dig likheterna och skillnaderna mellan innehållsfragment och Experience Fragments, och när och hur du använder varje typ.
sub-product: Experience Manager Assets, Experience Manager Sites
feature: Content Fragments, Experience Fragments
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
role: User
level: Beginner
doc-type: Article
exl-id: ccbc68d1-a83e-4092-9a49-53c56c14483e
duration: 168
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '829'
ht-degree: 0%

---

# Innehållsfragment och Upplevelsefragment

Adobe Experience Manager Content Fragments och Experience Fragments kan se likadana ut på ytan, men de spelar en viktig roll i olika fall. Lär dig hur innehålls- och upplevelsefragment liknar varandra, skiljer sig åt och när och hur du använder varje fragment.

## Jämförelse

<table>
<tbody><tr><td><strong> </strong></td>
<td><strong>Innehållsfragment (CF)</strong></td>
<td><strong>Experience Fragments (XF)</strong></td>
</tr><tr><td><strong>Definition</strong></td>
<td><ul>
<li>Återanvändbart, presentationsbaserat <strong>innehåll</strong>, bestående av strukturerade dataelement (text, datum, referenser osv.)</li>
</ul>
</td>
<td><ul>
<li>En återanvändbar, sammansatt av en eller flera AEM-komponenter som definierar innehåll och presentation som utgör en <strong>upplevelse</strong> som är självklar</li>
</ul>
</td>
</tr><tr><td><strong>Kärnstenar</strong></td>
<td><ul>
<li>Innehållscentrerat</li>
<li>Definieras av en <a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-models.html?lang=en" target="_blank">strukturerad, formulärbaserad, datamodell.</a></li>
<li>Design- och layoutagnostiker.</li>
<li>Kanalen äger presentationen av Content Fragment-innehållet (layout och design)</li>
</ul>
</td>
<td><ul>
<li>Presentationscentrerad</li>
<li>Definieras av ostrukturerad komposition i AEM Components</li>
<li>Definierar design och layout för innehåll</li>
<li>Används som det är i kanaler</li>
</ul>
</td>
</tr><tr><td><strong>Teknisk information</strong></td>
<td><ul>
<li>Implementerat som en <strong>dam:Asset</strong></li>
<li>Definieras av en <a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-models.html?lang=en" target="_blank">innehållsfragmentmodell</a></li>
</ul>
</td>
<td><ul>
<li>Implementerad som <strong>cq:Page</strong></li>
<li>Definieras av redigerbara mallar</li>
<li>HTML-rendering</li>
</ul>
</td>
</tr><tr><td><strong>Variationer</strong></td>
<td><ul>
<li>Huvudvarianten är den kanoniska variationen</li>
<li>Variationer är skiftlägeskänsliga, som kan justeras mot kanaler.</li>
</ul>
</td>
<td><ul>
<li>Variationer är kanal- eller kontextspecifika</li>
<li>Varianterna hålls synkroniserade via AEM Live Copy</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html" target="_blank">Byggblock</a> tillåter återanvändning av innehåll i olika varianter</li>
</ul>
</td>
</tr><tr><td><strong>Funktioner</strong></td>
<td><ul>
<li>Variationer</li>
<li>Versioner</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-variations.html?lang=en#synchronizing-with-master" target="_blank">Synkronisering</a> av innehåll mellan varianter</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-managing.html?lang=en#comparing-fragment-versions" target="_blank">Visuell skillnad</a> för innehållsfragmentversioner</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-variations.html?lang=en#annotating-a-content-fragment" target="_blank">Anteckningar</a> av flerradiga textelement</li>
<li>Intelligent <a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments-variations.html?lang=en#summarizing-text" target="_blank">sammanfattning</a> av flerradiga textelement.</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/creating-translation-projects-for-content-fragments.html?lang=en" target="_blank">Översättning/lokalisering</a></li>
</ul>
</td>
<td><ul>
<li>Variationer</li>
<li>Variationer som live-kopior</li>
<li>Versioner</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en#building-blocks" target="_blank">Byggblock</a></li>
<li>Anteckningar</li>
<li>Responsiv layout och förhandsgranskning</li>
<li>Översättning/lokalisering</li>
<li>Komplex datamodell via Content Fragment-referenser</li>
<li>Förhandsgranskning i appen</li>
</ul>
</td>
</tr><tr><td><strong>Använd</strong></td>
<td><ul>
<li>JSON-export via <a href="https://experienceleague.adobe.com/landing/experience-manager/headless/developer.html">AEM Headless GraphQL API:er</a></li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html" target="_blank">AEM Core Components Content Fragment component</a> för användning i AEM Sites, AEM Screens eller i Experience Fragments.</li>
<li>JSON-export via <a href="https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview.html?lang=en" target="_blank">AEM Content Services</a> för användning i tredje part</li>
<li>JSON-export till Adobe Target för riktade erbjudanden</li>
<li>JSON via AEM HTTP Assets API:er för tredjepartsanvändning</li>
</ul>
</td>
<td><ul>
<li>AEM Experience Fragment-komponent som kan användas i AEM Sites, AEM Screens eller andra Experience Fragments.</li>
<li>Exportera som <a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en" target="_blank">normal HTML</a> för användning i tredjepartssystem</li>
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/administering/integration/experience-fragments-target.html?lang=en" target="_blank">HTML-export till Adobe Target</a> för riktade erbjudanden</li>
<li>JSON-export till Adobe Target för riktade erbjudanden</li>
</ul>
</td>
</tr><tr><td><strong>Vanliga användningsområden</strong></td>
<td><ul>
<li>Effektiva användningsfall framför GraphQL</li>
<li>Strukturerad datainmatning/formulärbaserat innehåll</li>
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
<li><a href="https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en" target="_blank">Adobe-dokumentation om Experience Fragments</a></li>
</ul>
</td>
</tr></tbody></table>

## Arkitektur för innehållsfragment

Följande diagram visar den övergripande arkitekturen för AEM Content Fragments

![Arkitektur för innehållsfragment](./assets/content-fragments-architecture.png)

+ **Modeller för innehållsfragment** definierar elementen (eller fälten) som definierar vilket innehåll som innehållsfragmentet kan fånga och visa.
+ **Innehållsfragmentet** är en instans av en innehållsfragmentmodell som representerar en logisk innehållsenhet.
+ Innehållsfragmentet **varianter** som följer innehållsfragmentmodellen har dock variationer i innehållet.
+ Innehållsfragment kan visas/användas av:
   + Använda innehållsfragment på **AEM Sites** (eller AEM Screens) via AEM WCM Core Components innehållskomponent Fragment.
   + Förbruka **innehållsfragment** från headless-appar med AEM Headless GraphQL API:er.
   + Visa ett innehållsfragment varierar innehåll som JSON via **AEM Content Services** och API Pages för skrivskyddad användning.
   + Exponera innehåll i innehållsfragment (alla varianter) direkt som JSON via direktanrop till AEM Assets via **AEM Assets HTTP API** för CRUD-användning.

## Experience Fragments arkitektur

![Upplev fragmentarkitektur](./assets/experience-fragments-architecture.png)

+ **Redigerbara mallar**, som i sin tur definieras av **Redigerbara malltyper** och en **AEM Page-komponentimplementering**, definierar de tillåtna AEM-komponenter som kan användas för att skapa ett Experience Fragment.
+ **Experience Fragment** är en instans av en redigerbar mall som representerar en logisk upplevelse.
+ Experience Fragment **variations** följer den redigerbara mallen men har olika upplevelser (innehåll och design).
+ Upplevelsefragment kan exponeras/användas av:
   + Använda Experience Fragments på AEM Sites (eller AEM Screens) via komponenten AEM Experience Fragment.
   + Exponera ett Experience Fragment-varianter av innehåll som JSON (med inbäddade HTML) via **AEM Content Services** och API Pages.
   + Exponerar en Experience Fragment-variant direkt som **&quot;Normal HTML&quot;**.
   + Exporterar Experience Fragments till **Adobe Target** som antingen HTML eller JSON.
   + AEM Sites har inbyggt stöd för HTML erbjudanden, men JSON-erbjudanden kräver anpassad utveckling.

## Stödresurs för innehållsfragment

+ [Användarhandbok för innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-65/assets/home.html?lang=en&amp;topic=/experience-manager/6-5/assets/morehelp/content-fragments.ug.js)
+ [Introduktion till Adobe Experience Manager som Headless CMS](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/introduction.html)
+ [Använda innehållsfragment i AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/content-fragments/content-fragments-feature-video-use.html?lang=en)
+ [AEM WCM Core Components&#39; Content Fragment component](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html)
+ [Använda innehållsfragment och AEM Headless](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/overview.html?lang=en)
+ [Komma igång med AEM Content Services](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/content-services/overview.html?lang=en)

## Stöd för resurser för Experience Fragments

+ [Adobe-dokumentation om Experience Fragments](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/authoring/experience-fragments.html?lang=en)
+ [Förstå AEM Experience Fragments](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html?lang=en)
+ [Använda AEM Experience Fragments](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html?lang=en)
+ [Använda AEM Experience Fragments med Adobe Target](https://medium.com/adobetech/experience-fragments-and-adobe-target-d8d74381b9b2)
