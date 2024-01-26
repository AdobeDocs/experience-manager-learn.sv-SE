---
title: Genomför varningar på AEM as a Cloud Service
description: Lär dig hur du minskar genomströmningsvarningar på AEM as a Cloud Service.
feature: Migration
role: Architect, Developer
level: Beginner
jira: KT-10427
hidefromtoc: true
hide: true
index: false
thumbnail: kt-10427.jpg
exl-id: 8fcc9364-b84c-4458-82e2-66b47429cd4b
duration: 303
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '715'
ht-degree: 0%

---

# Traversal-varningar

>[!TIP]
>Bokmärk den här sidan för framtida referens.

_Vad är traversal-varningar?_

Traversal-varningar är __aemerror__ loggsatser som anger att dåligt utförda frågor körs i AEM Publiceringstjänst. Traversal-varningar visas vanligtvis på AEM på två sätt:

1. __Långsamma frågor__ som inte använder index, vilket ger långsamma svarstider.
1. __Misslyckade frågor__, som ger `RuntimeNodeTraversalException`, vilket ger en trasig upplevelse.

Om du tillåter att spårningsvarningar avmarkeras försämras AEM prestanda och kan resultera i trasiga upplevelser för användarna.

## Lösa genomgångsvarningar

Du kan åtgärda genomgångsvarningar i tre enkla steg: analysera, justera och verifiera. Förvänta dig flera iterationer av justering och verifiering innan du identifierar de optimala justeringarna.

<div class="columns is-multiline">

<!-- Analyze -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Analyze" tabindex="0">
   <div class="x-card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="#analyze" title="Analysera" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/traversals/1-analyze.png" alt="Analysera">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
                <p class="headline is-size-5 has-text-weight-bold">Analysera problemet</p>
               <p class="is-size-6">Identifiera och förstå vilka frågor som går igenom.</p>
               <a href="#analyze" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Analysera</span>
               </a>
           </div>
       </div>
   </div>
</div>

<!-- Adjust -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Adjust" tabindex="0">
   <div class="x-card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="#adjust" title="Justera" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/traversals/2-adjust.png" alt="Justera">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
                <p class="headline is-size-5 has-text-weight-bold">Justera koden eller konfigurationen</p>
               <p class="is-size-6">Uppdatera frågor och index för att undvika frågematerial.</p>
               <a href="#adjust" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Justera</span>
               </a>
           </div>
       </div>
   </div>
</div>

<!-- Verify -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Verify" tabindex="0">
   <div class="x-card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="#verify" title="Verifiera" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/traversals/3-verify.png" alt="Verifiera">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
                <p class="headline is-size-5 has-text-weight-bold">Verifiera justeringarna</p>                       
               <p class="is-size-6">Verifiera ändringar i frågor och index för att ta bort traversals.</p>
               <a href="#verify" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Verifiera</span>
               </a>
           </div>
       </div>
   </div>
</div>

</div>

## 1. Analysera{#analyze}

Börja med att identifiera vilka AEM Publish-tjänster som har resvägsvarningar. Om du vill göra det går du till Cloud Manager, [ladda ned Publish services `aemerror` loggar](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/debugging/debugging-aem-as-a-cloud-service/logs.html#cloud-manager){target="_blank"} från alla miljöer (Dev, Stage och Production) sedan tidigare __tre dagar__.

![Hämta AEM as a Cloud Service loggar](./assets/traversals/download-logs.jpg)

Öppna loggfilerna och sök efter Java™-klassen `org.apache.jackrabbit.oak.plugins.index.Cursors$TraversingCursor`. Loggen som innehåller traversal-varningar innehåller en serie satser som ser ut ungefär som:

```log
24.05.2022 14:18:46.146 [cm-p123-e456-aem-author-9876-edcba] *WARN* [192.150.10.214 [1653401908419] GET /content/wknd/us/en/example.html HTTP/1.1] 
org.apache.jackrabbit.oak.plugins.index.Cursors$TraversingCursor Traversed 5000 nodes with filter 
Filter(query=select [jcr:path], [jcr:score], * from [nt:base] as a where [xyz] = 'abc' and isdescendantnode(a, '/content') 
/* xpath: /jcr:root/content//element(*, nt:base)[(@xyz = 'abc')] */, path=/content//*, property=[xyz=[abc]]) 
called by apps.wknd.components.search.example__002e__jsp._jspService; 
consider creating an index or changing the query
```

Beroende på sammanhanget för frågans körning kan loggsatserna innehålla användbar information om frågeförfattaren:

+ URL för HTTP-begäran som är associerad med frågekörning

   + Exempel: `GET /content/wknd/us/en/example.html HTTP/1.1`

+ Syntax för Oak-fråga

   + Exempel: `select [jcr:path], [jcr:score], * from [nt:base] as a where [xyz] = 'abc' and isdescendantnode(a, '/content')`

+ XPath-fråga

   + Exempel: `/jcr:root/content//element(*, nt:base)[(@xyz = 'abc')] */, path=/content//*, property=[xyz=[abc]])`

+ Kod som kör frågan

   + Exempel:  `apps.wknd.components.search.example__002e__jsp._jspService` → `/apps/wknd/components/search/example.html`

__Misslyckade frågor__ följs upp av en `RuntimeNodeTraversalException` -programsats, liknande:

```log
24.05.2022 14:18:47.240 [cm-p123-e456-aem-author-9876-edcba] *WARN* [192.150.10.214 [1653401908419] GET /content/wknd/us/en/example.html HTTP/1.1] 
org.apache.jackrabbit.oak.query.FilterIterators The query read or traversed more than 100000 nodes.
org.apache.jackrabbit.oak.query.RuntimeNodeTraversalException: 
    The query read or traversed more than 100000 nodes. To avoid affecting other tasks, processing was stopped.
    ...
```

## 2. Justera{#adjust}

När de felaktiga frågorna och deras anropande kod har identifierats måste justeringar göras. Det finns två typer av justeringar som kan användas för att minska genomströmningsvarningar:

### Justera frågan

__Ändra frågan__ om du vill lägga till nya frågebegränsningar som leder till befintliga indexbegränsningar. Om det är möjligt bör du helst ändra frågan till att ändra index.

+ [Lär dig justera frågeprestanda](https://experienceleague.adobe.com/docs/experience-manager-65/developing/bestpractices/troubleshooting-slow-queries.html#query-performance-tuning){target="_blank"}

### Justera indexvärdet

__Ändra (eller skapa) ett AEM__ så att befintliga frågebegränsningar kan matchas mot indexuppdateringarna.

+ [Lär dig hur du trimmar befintliga index](https://experienceleague.adobe.com/docs/experience-manager-65/developing/bestpractices/troubleshooting-slow-queries.html#query-performance-tuning){target="_blank"}
+ [Lär dig hur du skapar index](https://experienceleague.adobe.com/docs/experience-manager-65/developing/bestpractices/troubleshooting-slow-queries.html#create-a-new-index){target="_blank"}

## 3. Verifiera{#verify}

Justeringar av frågor, index eller båda måste verifieras för att säkerställa att de minskar varningarna.

![Förklara fråga](./assets/traversals/verify.gif)

Endast [justeringar av frågan](#adjust-the-query) när du gör det kan frågan testas direkt på AEM as a Cloud Service via Developer Console [Förklara fråga](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/debugging/debugging-aem-as-a-cloud-service/developer-console.html#queries){target="_blank"}. Förklara fråga körs mot AEM författartjänst, men eftersom indexdefinitionerna är desamma i författar- och publiceringstjänsterna räcker det att validera frågor mot AEM författartjänst.

If [justeringar av index](#adjust-the-index) måste indexet distribueras till AEM as a Cloud Service. När indexjusteringarna är distribuerade är det Developer Console [Förklara fråga](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/debugging/debugging-aem-as-a-cloud-service/developer-console.html#queries){target="_blank"} kan användas för att köra och finjustera frågan ytterligare.

I slutändan implementeras alla ändringar (fråga och kod) i Git och distribueras till AEM as a Cloud Service med hjälp av Cloud Manager. Testa kodsökvägarna som är kopplade till de ursprungliga varningarna för genomgång och kontrollera att varningar för genomgång inte längre visas i `aemerror` log.

## Andra resurser

Läs om de här andra användbara resurserna för att förstå AEM, söka och bläddra igenom varningar.

<div class="columns is-multiline">

<!-- Cloud 5 - Search &amp; Indexing -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Cloud 5 - Search &amp; Indexing" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/expert-resources/cloud-5/cloud5-aem-search-and-indexing.html" title="Cloud 5 - sökning och indexering" tabindex="-1"><img class="is-bordered-r-small" src="../../../expert-resources/cloud-5/imgs/009-thumb.png" alt="Cloud 5 - sökning och indexering"></a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/expert-resources/cloud-5/cloud5-aem-search-and-indexing.html" title="Cloud 5 - sökning och indexering">Cloud 5 - sökning och indexering</a></p>
               <p class="is-size-6">I Cloud 5-teamet utforskas allt om sökning och indexering på AEM as a Cloud Service.</p>
               <a href="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/expert-resources/cloud-5/cloud5-aem-search-and-indexing.html" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
               </a>
           </div>
       </div>
   </div>
</div>

<!-- Content Search and Indexing -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Content Search and Indexing
" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/indexing.html" title="Innehållssökning och indexering" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/traversals/resources--docs.png" alt="Innehållssökning och indexering">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/indexing.html" title="Innehållssökning och indexering">Dokumentation för innehållssökning och indexering</a></p>
               <p class="is-size-6">Lär dig hur du skapar och hanterar index på AEM as a Cloud Service.</p>
               <a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/indexing.html" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
               </a>
           </div>
       </div>
   </div>
</div>

<!-- Modernizing your Oak indexes -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Modernizing your Oak indexes" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/migration/moving-to-aem-as-a-cloud-service/search-and-indexing.html" title="Modernisera Oak-index" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/traversals/resources--aem-experts-series.png" alt="Modernisera Oak-index">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/migration/moving-to-aem-as-a-cloud-service/search-and-indexing.html" title="Modernisera Oak-index">Modernisera Oak-index</a></p>
               <p class="is-size-6">Lär dig hur du konverterar AEM 6 Oak-indexdefinitioner så att de blir AEM as a Cloud Service kompatibla och behåller index som fortsätter framåt.</p>
               <a href="https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/migration/moving-to-aem-as-a-cloud-service/search-and-indexing.html" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
               </a>
           </div>
       </div>
   </div>
</div>

<!-- Index definition documentation -->
<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Index definition documentation" tabindex="0">
   <div class="card">
       <div class="card-image">
           <figure class="image is-16by9">
               <a href="https://jackrabbit.apache.org/oak/docs/query/lucene.html" title="Dokumentation för indexdefinition" tabindex="-1">
                   <img class="is-bordered-r-small" src="./assets/traversals/resources--oak-docs.png" alt="Dokumentation för indexdefinition">
               </a>
           </figure>
       </div>
       <div class="card-content is-padded-small">
           <div class="content">
               <p class="headline is-size-6 has-text-weight-bold"><a href="https://jackrabbit.apache.org/oak/docs/query/lucene.html" title="Dokumentation för indexdefinition">Dokumentation för Lucene-index</a></p>
               <p class="has-ellipsis is-size-6">Indexreferensen för Apache Oak Jackrabbit Lucene som dokumenterar alla Lucene-indexkonfigurationer som stöds.</p>
               <a href="https://jackrabbit.apache.org/oak/docs/query/lucene.html" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                   <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
               </a>
           </div>
       </div>
   </div>
</div>

</div>
