---
title: Bästa praxis för indexering i AEM
description: Läs om hur du indexerar metodtips i AEM.
version: Experience Manager 6.4, Experience Manager 6.5, Experience Manager as a Cloud Service
sub-product: Experience Manager, Experience Manager Sites
feature: Search
doc-type: Article
topic: Development
role: Developer, Architect
level: Beginner
duration: 373
last-substantial-update: 2024-01-04T00:00:00Z
jira: KT-14745
thumbnail: KT-14745.jpeg
exl-id: 3fd4c404-18e9-44e5-958f-15235a3091d5
source-git-commit: 1048beba42011eccb1ebdd43458591c8e953fb8a
workflow-type: tm+mt
source-wordcount: '1706'
ht-degree: 0%

---

# Bästa praxis för indexering i AEM

Läs om hur du indexerar metodtips i Adobe Experience Manager (AEM). Apache [Jackrabbit Oak](https://jackrabbit.apache.org/oak/docs/query/query.html) driver innehållssökningen i AEM och följande är viktiga punkter:

- AEM tillhandahåller olika index som stöder sök- och frågefunktioner, till exempel `damAssetLucene`, `cqPageLucene` med flera.
- Alla indexdefinitioner lagras i databasen under noden `/oak:index`.
- AEM as a Cloud Service stöder endast Oak Lucene-index.
- Indexkonfigurationen bör hanteras i AEM projektkodbas och distribueras med Cloud Manager CI/CD-pipelines.
- Om det finns flera tillgängliga index för en given fråga används **index med den lägsta uppskattade kostnaden**.
- Om det inte finns något index tillgängligt för en given fråga, gås innehållsträdet igenom för att hitta det matchande innehållet. Standardgränsen via `org.apache.jackrabbit.oak.query.QueryEngineSettingsService` är dock att bara gå igenom 100 000 noder.
- Resultatet av en fråga **filtreras senast** för att säkerställa att den aktuella användaren har läsåtkomst. Det innebär att frågeresultaten kan vara mindre än antalet indexerade noder.
- Omindexeringen av databasen efter ändringar av indexdefinitionen kräver tid och beror på databasens storlek.

Om du vill ha en effektiv och korrekt sökfunktion som inte påverkar AEM-instansens prestanda är det viktigt att du förstår hur du indexerar de bästa metoderna.

## Index för anpassad kontra OTB

Ibland måste du skapa anpassade index som passar dina sökbehov. Följ dock riktlinjerna nedan innan du skapar anpassade index:

- Förstå sökkraven och kontrollera om OTB-indexen stöder sökkraven. Använd **frågeprestandaverktyget** som finns på [lokal SDK](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) och AEMCS via Developer Console eller `https://author-pXXXX-eYYYY.adobeaemcloud.com/ui#/aem/libs/granite/operations/content/diagnosistools/queryPerformance.html?appId=aemshell`.

- Definiera en optimal fråga genom att använda flödesdiagrammet [optimera frågor](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/query-and-indexing-best-practices) och [JCR-frågechebladet](https://experienceleague.adobe.com/docs/experience-manager-65/assets/JCR_query_cheatsheet-v1.1.pdf) för referens.

- Om OTB-indexen inte stöder sökkraven finns det två alternativ. Granska dock [Tipsen för hur du skapar effektiva index](https://experienceleague.adobe.com/en/docs/experience-manager-65/content/implementing/deploying/practices/best-practices-for-queries-and-indexing)
   - Anpassa OOTB-indexet: Det bästa alternativet eftersom det är enkelt att underhålla och uppgradera.
   - Helt anpassat index: Endast om alternativet ovan inte fungerar.

### Anpassa OTB-indexet

- I **AEMCS** använder du namnkonventionen **\&lt;OOTBIndexName>-\&lt;productVersion>-custom-\&lt;customVersion>** när du anpassar OOTB-indexet. Till exempel `cqPageLucene-custom-1` eller `damAssetLucene-8-custom-1`. Det gör att du kan sammanfoga den anpassade indexdefinitionen när OTB-indexet uppdateras. Mer information finns i [Förändringar av index som inte finns i kartongen](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/indexing).

- I **AEM 6.X** fungerar inte namngivningen __, men du behöver bara uppdatera OTB-indexet med nödvändiga egenskaper i noden `indexRules`.

- Kopiera alltid den senaste OTB-indexdefinitionen från AEM-instansen med CRX DE Package Manager (/crx/packmgr/), byt namn på den och lägg till anpassningar i XML-filen.

- Lagra indexdefinitionen i AEM-projektet på `ui.apps/src/main/content/jcr_root/_oak_index` och distribuera den med Cloud Manager CI/CD-pipelines. Mer information finns i [Distribuera anpassade indexdefinitioner](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/indexing).

### Helt anpassat index

Det sista alternativet måste vara att skapa ett helt anpassat index och endast om ovanstående alternativ inte fungerar.

- Använd **\&lt;prefix> när du skapar ett helt anpassat index.\&lt;customIndexName>-\&lt;version>-custom-\&lt;customVersion>**-namnkonvention. Exempel: `wknd.adventures-1-custom-1`. Detta hjälper till att undvika namnkonflikter. Här är `wknd` prefixet och `adventures` är det anpassade indexnamnet. Denna konvention gäller för både AEM 6.X och AEMCS och bidrar till att förbereda för framtida övergång till AEMCS.

- AEMCS stöder bara Lucene-index, så för att förbereda för framtida migrering till AEMCS bör du alltid använda Lucene-index. Mer information finns i [Lucene-index jämfört med egenskapsindex](https://experienceleague.adobe.com/en/docs/experience-manager-65/content/implementing/deploying/practices/best-practices-for-queries-and-indexing).

- Undvik att skapa ett anpassat index för samma nodtyp som OTB-indexet. Anpassa i stället OTB-indexet med nödvändiga egenskaper i noden `indexRules`. Skapa till exempel inte ett anpassat index för nodtypen `dam:Asset` utan anpassa indexet OTB `damAssetLucene`. _Det har varit en vanlig grundorsak till prestandaproblem och funktionsproblem_.

- Undvik också att lägga till flera nodtyper, till exempel `cq:Page` och `cq:Tag`, under indexeringsregelnoden (`indexRules`). Skapa i stället separata index för varje nodtyp.

- Som vi nämnt ovan ska du lagra indexdefinitionen i AEM-projektet på `ui.apps/src/main/content/jcr_root/_oak_index` och distribuera den med Cloud Manager CI/CD-pipelines. Mer information finns i [Distribuera anpassade indexdefinitioner](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/indexing).

- Riktlinjerna för indexdefinitioner är:
   - Nodtypen (`jcr:primaryType`) ska vara `oak:QueryIndexDefinition`
   - Indextypen (`type`) ska vara `lucene`
   - Den asynkrona egenskapen (`async`) ska vara `async,nrt`
   - Använd `includedPaths` och undvik egenskapen `excludedPaths`. Ange alltid värdet `queryPaths` till samma värde som värdet för `includedPaths`.
   - Använd egenskapen `evaluatePathRestrictions` och ange den till `true` för att framtvinga sökvägsbegränsningen.
   - Använd egenskapen `tags` för att tagga indexet och ange det här taggvärdet för att använda indexet när du frågar. Den allmänna frågesyntaxen är `<query> option(index tag <tagName>)`.

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

I bilden nedan visas en anpassad indexdefinition och en indexdefinition för OTB, där egenskapen `tags` markeras, används samma `visualSimilaritySearch` för båda indexvärdena.

![Felaktig användning av taggegenskap](./assets/understand-indexing-best-practices/incorrect-tags-property.png)

##### Analys

Det här är en felaktig användning av egenskapen `tags` i det anpassade indexet. Oak frågemotor väljer det anpassade indexvärdet över OTB-indexet för den lägsta uppskattade kostnaden.

Det rätta sättet är att anpassa OTB-indexet och lägga till nödvändiga egenskaper i noden `indexRules`. Mer information finns i [Anpassa OOTB-indexet](#customize-the-ootb-index).

#### Index för nodtypen `dam:Asset`

Nedan visas ett anpassat index för nodtypen `dam:Asset` med egenskapen `includedPaths` inställd på en specifik sökväg.

![Index på dam:Asset nodetype](./assets/understand-indexing-best-practices/index-for-damAsset-type.png)

##### Analys

Om du gör en sökning i Assets returneras felaktiga resultat eftersom det anpassade indexet har en lägre uppskattad kostnad.

Skapa inte ett anpassat index för nodtypen `dam:Asset` utan anpassa OTB `damAssetLucene`-indexet med nödvändiga egenskaper i noden `indexRules`.

#### Flera nodtyper under indexeringsregler

Nedan visas ett anpassat index med flera nodtyper under noden `indexRules`.

![Flera nodtyper under indexeringsreglerna](./assets/understand-indexing-best-practices/multiple-nodetypes-in-index.png)

##### Analys

Du bör inte lägga till flera nodtyper i ett enda index, men det går bra att indexera nodtyper i samma index om nodtyperna är nära besläktade, till exempel `cq:Page` och `cq:PageContent`.

En giltig lösning är att anpassa OTB-indexet `cqPageLucene` och `damAssetLucene` och lägga till nödvändiga egenskaper under den befintliga `indexRules`-noden.

#### Egenskapen `queryPaths` saknas

I bilden nedan visas ett anpassat index (som inte följer namnkonventionen) utan egenskapen `queryPaths`.

![Frågesökvägsegenskapen &#x200B;](./assets/understand-indexing-best-practices/absense-of-queryPaths-prop.png) saknas

##### Analys

Ange alltid värdet `queryPaths` till samma värde som värdet för `includedPaths`. Om du vill framtvinga sökvägsbegränsningen anger du egenskapen `evaluatePathRestrictions` till `true`.

#### Fråga med indextagg

Nedanför bilden visas ett anpassat index med egenskapen `tags` och hur det används vid frågor.

![Frågar med indextagg](./assets/understand-indexing-best-practices/tags-prop-usage.png)

```
/jcr:root/content/dam//element(*,dam:Asset)[(jcr:content/@contentFragment = 'true' and jcr:contains(., '/content/sitebuilder/test/mysite/live/ja-jp/mypage'))]order by @jcr:created descending option (index tag assetPrefixNodeNameSearch)
```

##### Analys

Visar hur du ställer in icke-konfliktskapande och korrigerar egenskapsvärdet `tags` för indexet och använder det när du frågar. Den allmänna frågesyntaxen är `<query> option(index tag <tagName>)`. Se även [Indextagg för frågealternativ](https://jackrabbit.apache.org/oak/docs/query/query-engine.html#query-option-index-tag)

#### Anpassat index

Nedanför bilden visas ett anpassat index med noden `suggestion` som ger den avancerade sökfunktionen.

![Anpassat index](./assets/understand-indexing-best-practices/custom-index-with-suggestion-node.png)

##### Analys

Det är ett giltigt användningsexempel att skapa ett anpassat index för funktionen [avancerad sökning](https://jackrabbit.apache.org/oak/docs/query/lucene.html#advanced-search-features). Indexnamnet måste dock följa **\&lt;prefix>.\&lt;customIndexName>-\&lt;version>-custom-\&lt;customVersion>**-namnkonvention.

## Indexoptimering genom att inaktivera Apache Tika

AEM använder [Apache Tika](https://tika.apache.org/) för _att extrahera metadata och textinnehåll från filer_ som PDF, Word, Excel med flera. Det extraherade innehållet lagras i databasen och indexeras av Oak Lucene-indexet.

Ibland behöver användare inte kunna söka i innehållet i en fil eller resurs, och i sådana fall kan du förbättra indexeringsprestandan genom att inaktivera Apache Tika. Fördelarna är:

- Snabbare indexering
- Minska indexstorlek
- Mindre maskinvaruanvändning

>[!CAUTION]
>
>Innan du inaktiverar Apache Tika måste du se till att sökkraven inte kräver möjligheten att söka i innehållet i en resurs.


### Inaktivera efter MIME-typ

Så här inaktiverar du Apache Tika efter MIME-typ:

- Lägg till noden `tika` av typen `nt:unstructured` under anpassad indexdefinition eller OOBT-indexdefinition. I följande exempel är MIME-typen för PDF inaktiverad för OTB `damAssetLucene`-index.

```xml
/oak:index/damAssetLucene
    - jcr:primaryType = "oak:QueryIndexDefinition"
    - type = "lucene"
    ...
    <tika jcr:primaryType="nt:unstructured">
        <config.xml/>
    </tika>
```

- Lägg till `config.xml` med följande information under noden `tika`.

```xml
<properties>
  <parsers>
    <parser class="org.apache.tika.parser.EmptyParser">
      <mime>application/pdf</mime>
      <!-- Add more mime types to disable -->
  </parsers>
</properties>
```

- Om du vill uppdatera det lagrade indexet anger du egenskapen `refresh` till `true` under indexdefinitionsnoden. Mer information finns i [Egenskaper för indexdefinition](https://jackrabbit.apache.org/oak/docs/query/lucene.html#index-definition:~:text=Defaults%20to%2010000-,refresh,-Optional%20boolean%20property).

Följande bild visar indexet OTB `damAssetLucene` med noden `tika` och filen `config.xml` som inaktiverar PDF och andra MIME-typer.

![OTB damAssetLucene-index med kodnoden &#x200B;](./assets/understand-indexing-best-practices/ootb-index-with-tika-node.png)

### Inaktivera helt

Följ stegen nedan för att inaktivera Apache Tika helt:

- Lägg till egenskapen `includePropertyTypes` vid `/oak:index/<INDEX-NAME>/indexRules/<NODE-TYPE>` och ange värdet till `String`. I bilden nedan har till exempel egenskapen `includePropertyTypes` lagts till för nodtypen `dam:Asset` i OOBT `damAssetLucene` -indexet.

![IncludePropertyTypes, egenskap](./assets/understand-indexing-best-practices/includePropertyTypes-prop.png)

- Lägg till `data` med nedanstående egenskaper under noden `properties` och kontrollera att det är den första noden ovanför egenskapsdefinitionen. Se till exempel bilden nedan:

```xml
/oak:index/<INDEX-NAME>/indexRules/<NODE-TYPE>/properties/data
    - jcr:primaryType = "nt:unstructured"
    - type = "String"
    - name = "jcr:data"
    - nodeScopeIndex = false
    - propertyIndex = false
    - analyze = false
```

![Dataegenskap](./assets/understand-indexing-best-practices/data-prop.png)

- Indexera om den uppdaterade indexdefinitionen genom att ange egenskapen `reindex` till `true` under indexdefinitionsnoden.

## Användbara verktyg

Låt oss titta på några verktyg som kan hjälpa dig att definiera, analysera och optimera index.

### Indexverktyg och Oak-verktyg

Med verktyget [Oak Index Definition Generator](https://thomasmueller.github.io/oakTools/indexDefGenerator.html) kan **generera indexdefinitionen** baserat på indatafrågorna. Det är en bra utgångspunkt att skapa ett anpassat index.

[Oak-verktygen](https://thomasmueller.github.io/oakTools/index.html) innehåller även andra
Verktyg för indexering och frågor, t.ex. för att konvertera index mellan JSON- och XML-format.
för att konvertera XPath-frågor till SQL-2 och för att jämföra index.

### Verktyg för frågeprestanda

OTB _frågeprestandaverktyget_ som finns på [lokal SDK](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) och AEMCS via Developer Console eller `https://author-pXXXX-eYYYY.adobeaemcloud.com/ui#/aem/libs/granite/operations/content/diagnosistools/queryPerformance.html?appId=aemshell` hjälper **att analysera frågeprestanda** och [JCR-frågecheblad](https://experienceleague.adobe.com/docs/experience-manager-65/assets/JCR_query_cheatsheet-v1.1.pdf?lang=en) för att definiera den optimala frågan.

### Felsökningsverktyg och tips

De flesta av nedanstående gäller för AEM 6.X och lokal felsökning.

- Indexhanteraren är tillgänglig på `http://host:port/libs/granite/operations/content/diagnosistools/indexManager.html` för att hämta indexinformation som typ, senast uppdaterad, storlek.

- Detaljerad loggning av Oak frågor och indexeringsrelaterade Java™-paket som `org.apache.jackrabbit.oak.plugins.index`, `org.apache.jackrabbit.oak.query` och `com.day.cq.search` via `http://host:port/system/console/slinglog` för felsökning.

- JMX MBean av _IndexStats_-typen som är tillgänglig på `http://host:port/system/console/jmx` för att hämta indexinformation som status, förlopp eller statistik som rör asynkron indexering. Den tillhandahåller också _FailingIndexStats_, om det inte finns några resultat här, vilket betyder att inga index är skadade. AsyncIndexerService markerar alla index som inte kan uppdateras i 30 minuter (konfigurerbara) som skadade och avbryter indexeringen. Om en fråga inte ger förväntat resultat är det praktiskt att utvecklarna kontrollerar detta innan de fortsätter med omindexering eftersom omindexering är resurskrävande och tidskrävande.

- JMX MBean av typen _LuceneIndex_ som finns på `http://host:port/system/console/jmx` för Lucene-indexstatistik som storlek, antal dokument per indexdefinition.

- JMX MBean av _QueryStat_-typen som finns på `http://host:port/system/console/jmx` för Oak Query Statistics, inklusive långsamma och populära frågor med detaljer som query, körningstid.

## Ytterligare resurser

Mer information finns i följande dokumentation:

- [Oak-frågor och indexering](https://experienceleague.adobe.com/en/docs/experience-manager-65/content/implementing/deploying/deploying/queries-and-indexing)
- [Bästa praxis för frågor och indexering](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/query-and-indexing-best-practices)
- [Bästa tillvägagångssätt för frågor och indexering](https://experienceleague.adobe.com/en/docs/experience-manager-65/content/implementing/deploying/practices/best-practices-for-queries-and-indexing)

