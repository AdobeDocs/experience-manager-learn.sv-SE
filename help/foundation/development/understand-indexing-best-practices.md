---
title: Bästa tillvägagångssätt för indexering av AEM
description: Lär dig mer om att indexera bästa praxis inom AEM.
version: 6.4, 6.5, Cloud Service
sub-product: Experience Manager, Experience Manager Sites
feature: Search
doc-type: Article
topic: Development
role: Developer, Architect
level: Beginner
duration: 389
last-substantial-update: 2024-01-04T00:00:00Z
jira: KT-14745
thumbnail: KT-14745.jpeg
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1418'
ht-degree: 0%

---


# Bästa tillvägagångssätt för indexering av AEM

Lär dig mer om hur du indexerar metodtips i Adobe Experience Manager (AEM). Apache [Jackrabbit Oak](https://jackrabbit.apache.org/oak/docs/query/query.html) används för innehållssökning i AEM och följande är nyckelpunkter:

- AEM innehåller olika index som stöder sök- och frågefunktioner, till exempel `damAssetLucene`, `cqPageLucene` med mera.
- Alla indexdefinitioner lagras i databasen under `/oak:index` nod.
- AEM as a Cloud Service stöder endast Oak Lucene-index.
- Indexkonfigurationen ska hanteras i AEM projektkodbas och distribueras med Cloud Manager CI/CD-pipelines.
- Om det finns flera tillgängliga index för en viss fråga, **index med lägsta uppskattade kostnad används**.
- Om det inte finns något index tillgängligt för en given fråga, gås innehållsträdet igenom för att hitta det matchande innehållet. Standardgränsen via `org.apache.jackrabbit.oak.query.QueryEngineSettingsService` är att endast gå igenom 10 000 noder.
- Resultatet av en fråga är **filtrerad senast** för att säkerställa att den aktuella användaren har läsåtkomst. Det innebär att frågeresultaten kan vara mindre än antalet indexerade noder.
- Omindexeringen av databasen efter ändringar av indexdefinitionen kräver tid och beror på databasens storlek.

Om du vill ha en effektiv och korrekt sökfunktion som inte påverkar prestandan för den AEM instansen är det viktigt att du förstår de bästa metoderna för indexering.

## Index för anpassad kontra OTB

Ibland måste du skapa anpassade index som passar dina sökbehov. Följ dock riktlinjerna nedan innan du skapar anpassade index:

- Förstå sökkraven och kontrollera om OTB-indexen stöder sökkraven. Använd **Prestandaverktyg för fråga**, finns på [lokal SDK](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) och AEMCS via Developer Console eller `https://author-pXXXX-eYYYY.adobeaemcloud.com/ui#/aem/libs/granite/operations/content/diagnosistools/queryPerformance.html?appId=aemshell`.

- Definiera en optimal fråga med [optimera frågor](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/query-and-indexing-best-practices.html?#optimizing-queries) flödesdiagram och [JCR Query Cheat Sheet](https://experienceleague.adobe.com/docs/experience-manager-65/assets/JCR_query_cheatsheet-v1.1.pdf?lang=en) för referens.

- Om OTB-indexen inte stöder sökkraven finns det två alternativ. Granska dock [Tips om hur du skapar effektiva index](https://experienceleague.adobe.com/docs/experience-manager-65/content/implementing/deploying/practices/best-practices-for-queries-and-indexing.html?#should-i-create-an-index)
   - Anpassa OOTB-indexet: Det bästa alternativet eftersom det är enkelt att underhålla och uppgradera.
   - Helt anpassat index: Endast om alternativet ovan inte fungerar.

### Anpassa OTB-indexet

- I **AEMCS**, när du anpassar OTB-indexanvändningen **\&lt;ootbindexname>-\&lt;productversion>-custom-\&lt;customversion>** namnkonvention. Till exempel: `cqPageLucene-custom-1` eller `damAssetLucene-8-custom-1`. Det gör att du kan sammanfoga den anpassade indexdefinitionen när OTB-indexet uppdateras. Se [Ändringar av färdiga index](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/indexing.html?#changes-to-out-of-the-box-indexes) för mer information.

- I **AEM 6.X**, namnet ovan _fungerar inte_ uppdaterar du emellertid bara OTB-indexet med ytterligare egenskaper i `indexRules` nod.

- Kopiera alltid den senaste OTB-indexdefinitionen från den AEM instansen med CRX DE Package Manager (/crx/packmgr/), byt namn på den och lägg till anpassningar i XML-filen.

- Lagra indexdefinitionen i AEM `ui.apps/src/main/content/jcr_root/_oak_index` och driftsätta den med Cloud Manager CI/CD-pipelines. Se [Distribuera anpassade indexdefinitioner](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/indexing.html?#deploying-custom-index-definitions) för mer information.

### Helt anpassat index

Det sista alternativet måste vara att skapa ett helt anpassat index och endast om ovanstående alternativ inte fungerar.

- När du skapar ett helt anpassat index bör du använda **\&lt;prefix>.\&lt;customindexname>-\&lt;version>-custom-\&lt;customversion>** namnkonvention. Till exempel: `wknd.adventures-1-custom-1`. Detta hjälper till att undvika namnkonflikter. Här, `wknd` är prefixet och `adventures` är det anpassade indexnamnet. Denna konvention gäller för både AEM 6.X och AEMCS och bidrar till att förbereda för framtida övergång till AEMCS.

- AEMCS stöder bara Lucene-index, så för att förbereda för framtida migrering till AEMCS bör du alltid använda Lucene-index. Se [Lucene-index jämfört med egenskapsindex](https://experienceleague.adobe.com/docs/experience-manager-65/content/implementing/deploying/practices/best-practices-for-queries-and-indexing.html?#lucene-or-property-indexes) för mer information.

- Undvik att skapa ett anpassat index för samma nodtyp som OTB-indexet. Istället kan du anpassa OTB-indexet med ytterligare egenskaper i `indexRules` nod. Skapa till exempel inte ett anpassat index på `dam:Asset` nodtyp men anpassa OTB `damAssetLucene` index. _Det har varit en vanlig grundorsak till prestanda- och funktionsproblem_.

- Undvik också att lägga till flera nodtyper, till exempel `cq:Page` och `cq:Tag` enligt indexeringsreglerna (`indexRules`)-nod. Skapa i stället separata index för varje nodtyp.

- Så som nämns i avsnittet ovan, sparar indexdefinitionen i AEM projekt på `ui.apps/src/main/content/jcr_root/_oak_index` och driftsätta den med Cloud Manager CI/CD-pipelines. Se [Distribuera anpassade indexdefinitioner](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/indexing.html?#deploying-custom-index-definitions) för mer information.

- Riktlinjerna för indexdefinitioner är:
   - Nodtypen (`jcr:primaryType`) ska vara `oak:QueryIndexDefinition`
   - Indextypen (`type`) ska vara `lucene`
   - Egenskapen async (`async`) ska vara `async,nrt`
   - Använd `includedPaths` och undvika `excludedPaths` -egenskap. Alltid inställd `queryPaths` till samma värde som `includedPaths` värde.
   - Om du vill tillämpa sökvägsbegränsningen använder du `evaluatePathRestrictions` egenskap och ange den som `true`.
   - Använd `tags` för att tagga indexet och när du frågar anger du det här taggvärdet för att använda indexet. Den allmänna frågesyntaxen är `<query> option(index tag <tagName>)`.

  ```xml
  /oak:index/wknd.adventures-1-custom-1
      - jcr:primaryType = "oak:QueryIndexDefinition"
      - type = "lucene"
      - compatVersion = 2
      - async = ["async", "nrt"]
      - includedPaths = ["/content/wknd"]
      - queryPaths = ["/content/wknd"]
      - evaluatePathRestrictions = true
      - tags = ["customAdvSearch"]
  ...
  ```

### Exempel

Vi ska ta en titt på några exempel för att förstå de bästa metoderna.

#### Felaktig användning av taggegenskap

Nedanför bilden visas en anpassad indexdefinition och indexdefinitionen OTB, där markeringen av `tags` egenskap, båda indexen använder samma `visualSimilaritySearch` värde.

![Felaktig användning av taggegenskap](./assets/understand-indexing-best-practices/incorrect-tags-property.png)

##### Analys

Detta är en felaktig användning av `tags` -egenskapen i det anpassade indexet. Oak-frågemotorn väljer det anpassade indexvärdet över OTB-indexvärdet för den lägsta uppskattade kostnaden.

Det rätta sättet är att anpassa OTB-indexet och lägga till ytterligare egenskaper i `indexRules` nod. Se [Anpassa OOTB-indexet](#customize-the-ootb-index) för mer information.

#### Index på `dam:Asset` nodtyp

Nedan visas ett eget index för `dam:Asset` nodtyp med `includedPaths` egenskapen är inställd på en viss sökväg.

![Index på dam:Asset-nodtype](./assets/understand-indexing-best-practices/index-for-damAsset-type.png)

##### Analys

Om du utför en sökning på resurser returneras felaktiga resultat eftersom det anpassade indexet har en lägre uppskattad kostnad.

Skapa inte ett anpassat index på `dam:Asset` nodtyp men anpassa OTB `damAssetLucene` index med ytterligare egenskaper i `indexRules` nod.

#### Flera nodtyper under indexeringsregler

Nedan visas ett eget index med flera nodtyper under `indexRules` nod.

![Flera nodtyper under indexeringsreglerna](./assets/understand-indexing-best-practices/multiple-nodetypes-in-index.png)

##### Analys

Du bör inte lägga till flera nodtyper i ett index, men det går bra att indexera nodtyper i samma index om nodtyperna är nära besläktade, till exempel `cq:Page` och `cq:PageContent`.

En giltig lösning är att anpassa OTB `cqPageLucene` och `damAssetLucene` index, lägga till ytterligare egenskaper under det befintliga `indexRules` nod.

#### Frånvaro av `queryPaths` property

Nedanför bilden visas ett anpassat index (inte efter namnkonventionen) utan `queryPaths` -egenskap.

![Avstånd för egenskapen queryPaths](./assets/understand-indexing-best-practices/absense-of-queryPaths-prop.png)

##### Analys

Alltid inställd `queryPaths` till samma värde som `includedPaths` värde. Om du vill tillämpa sökvägsbegränsningen anger du `evaluatePathRestrictions` egenskap till `true`.

#### Fråga med indextagg

Nedan visas ett eget index med `tags` och hur du använder den när du frågar.

![Fråga med indextagg](./assets/understand-indexing-best-practices/tags-prop-usage.png)

```
/jcr:root/content/dam//element(*,dam:Asset)[(jcr:content/@contentFragment = 'true' and jcr:contains(., '/content/sitebuilder/test/mysite/live/ja-jp/mypage'))]order by @jcr:created descending option (index tag assetPrefixNodeNameSearch)
```

##### Analys

Visar hur du ställer in icke-konfliktskapande och korrigering `tags` egenskapsvärde för indexet och använd det när du frågar. Den allmänna frågesyntaxen är `<query> option(index tag <tagName>)`. Se även [Indextagg för frågealternativ](https://jackrabbit.apache.org/oak/docs/query/query-engine.html#query-option-index-tag)

#### Anpassat index

Nedan visas ett eget index med `suggestion` nod för avancerad sökning.

![Anpassat index](./assets/understand-indexing-best-practices/custom-index-with-suggestion-node.png)

##### Analys

Det är ett giltigt användningsexempel att skapa ett anpassat index för [avancerad sökning](https://jackrabbit.apache.org/oak/docs/query/lucene.html#advanced-search-features) funktionalitet. Indexnamnet måste dock följa efter **\&lt;prefix>.\&lt;customindexname>-\&lt;version>-custom-\&lt;customversion>** namnkonvention.


## Användbara verktyg

Låt oss titta på några verktyg som kan hjälpa dig att definiera, analysera och optimera index.

### Verktyget Skapa index

The [Definitionsgenerator för Oak Index](https://oakutils.appspot.com/generate/index) verktyg **för att generera indexdefinitionen** baserat på indatafrågorna. Det är en bra utgångspunkt att skapa ett anpassat index.

### Analysera indexverktyget

The [Indexdefinitionsanalys](https://oakutils.appspot.com/analyze/index) verktyg **för att analysera indexdefinitionen** och ger rekommendationer för att förbättra indexdefinitionen.

### Verktyg för frågeprestanda

OTB _Prestandaverktyg för fråga_ finns på [lokal SDK](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) och AEMCS via Developer Console eller `https://author-pXXXX-eYYYY.adobeaemcloud.com/ui#/aem/libs/granite/operations/content/diagnosistools/queryPerformance.html?appId=aemshell` hjälper **för att analysera frågeprestanda** och [JCR Query Cheat Sheet](https://experienceleague.adobe.com/docs/experience-manager-65/assets/JCR_query_cheatsheet-v1.1.pdf?lang=en) för att definiera den optimala frågan.

### Felsökningsverktyg och tips

De flesta av nedanstående gäller för AEM 6.X och lokal felsökning.

- Indexhanteraren finns på `http://host:port/libs/granite/operations/content/diagnosistools/indexManager.html` för att hämta indexinformation som typ, senast uppdaterad, storlek.

- Detaljerad loggning av Oak-frågor och indexeringsrelaterade Java™-paket som `org.apache.jackrabbit.oak.plugins.index`, `org.apache.jackrabbit.oak.query`och `com.day.cq.search` via `http://host:port/system/console/slinglog` för felsökning.

- JMX MBean av _IndexStats_ typ tillgänglig på `http://host:port/system/console/jmx` för att hämta indexinformation som status, förlopp eller statistik för asynkron indexering. Den innehåller även _FailingIndexStats_, om det inte finns några resultat här, betyder det att inga index är skadade. AsyncIndexerService markerar alla index som inte kan uppdateras i 30 minuter (konfigurerbara) som skadade och avbryter indexeringen. Om en fråga inte ger förväntat resultat är det praktiskt att utvecklarna kontrollerar detta innan de fortsätter med omindexering eftersom omindexering är resurskrävande och tidskrävande.

- JMX MBean av _LuceneIndex_ typ tillgänglig på `http://host:port/system/console/jmx` för Lucene-indexstatistik som storlek, antal dokument per indexdefinition.

- JMX MBean av _QueryStat_ typ tillgänglig på `http://host:port/system/console/jmx` för statistik över Oak-frågor, inklusive långsamma och populära frågor med detaljer som fråga, körningstid.

## Ytterligare resurser

Mer information finns i följande dokumentation:

- [Fråga och indexering](https://experienceleague.adobe.com/docs/experience-manager-65/content/implementing/deploying/deploying/queries-and-indexing.html)
- [Bästa praxis för frågor och indexering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/operations/query-and-indexing-best-practices.html)
- [Metodtips för frågor och indexering](https://experienceleague.adobe.com/docs/experience-manager-65/content/implementing/deploying/practices/best-practices-for-queries-and-indexing.html)
