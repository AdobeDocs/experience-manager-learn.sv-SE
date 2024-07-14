---
title: Konfigurera smart översättningssökning med AEM Assets
description: Med Smart Translation Search kan du använda söktermer som inte är engelska för att matcha till engelskt innehåll. Om du vill konfigurera AEM för smart översättning-sökning måste Apache Oak Search Machine Translation OSGi-paketet installeras och konfigureras, samt de relevanta kostnadsfria och öppna källspråkspaketen för Apache Joshua som innehåller översättningsreglerna.
version: 6.4, 6.5
feature: Search
topic: Content Management
role: Developer
level: Beginner
doc-type: Technical Video
exl-id: 7be8c3d5-b944-4421-97b3-bd5766c1b1b5
duration: 603
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '811'
ht-degree: 0%

---

# Konfigurera smart översättningssökning med AEM Assets{#set-up-smart-translation-search-with-aem-assets}

Med Smart Translation Search kan du använda söktermer som inte är engelska för att matcha till engelskt innehåll. Om du vill konfigurera AEM för smart översättning-sökning måste Apache Oak Search Machine Translation OSGi-paketet installeras och konfigureras, samt de relevanta kostnadsfria och öppna källspråkspaketen för Apache Joshua som innehåller översättningsreglerna.

>[!VIDEO](https://video.tv.adobe.com/v/21291?quality=12&learn=on)

>[!NOTE]
>
>Smarta översättningssökningar måste konfigureras för varje AEM som kräver det.

1. Hämta och installera Oak Search Machine Translation OSGi-paketet
   * [Hämta Oak Search Machine Translation OSGi-paketet](https://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.apache.jackrabbit%22%20AND%20a%3A%22oak-search-mt%22) som motsvarar AEM Oak-version.
   * Installera det hämtade Oak Search Machine Translation OSGi-paketet i AEM via [`/system/console/bundles`](http://localhost:4502/system/console/bundles).

2. Hämta och uppdatera språkpaketen för Apache Joshua
   * Ladda ned och zippa upp [Apache Joshua-språkpaket](https://cwiki.apache.org/confluence/display/JOSHUA/Language+Packs).
   * Redigera filen `joshua.config` och kommentera de två rader som börjar med:

     ```
     feature-function = LanguageModel ...
     ```

   * Fastställ och registrera storleken på språkpaketets modellmapp, eftersom detta påverkar hur mycket extra stackutrymme som AEM kräver.
   * Flytta den uppackade språkpaketsmappen för Apache Joshua (med `joshua.config` ändringar) till

     ```
     .../crx-quickstart/opt/<source_language-target_language>
     ```

     Till exempel:

     ```
      .../crx-quickstart/opt/es-en
     ```

3. Starta om AEM med uppdaterad heap-minnestilldelning
   * Stoppa AEM
   * Ange den nya nödvändiga stackstorleken för AEM

      * AEM stackstorlek för förspråksbrist + storleken på modellkatalogen avrundad uppåt till närmaste 2 GB
      * Exempel: Om förspråkspaket AEM kräver 8 GB stackutrymme och språkpaketets modellmapp är 3,8 GB okomprimerad är den nya stackstorleken:

        Det ursprungliga `8GB` + ( `3.75GB` avrundat uppåt till närmaste `2GB`, som är `4GB`) för totalt `12GB`

   * Kontrollera att datorn har den här mängden extra ledigt minne.
   * Uppdatera AEM startskript som ska justeras för den nya stackstorleken

      * Exempel: `java -Xmx12g -jar cq-author-p4502.jar`

   * Starta om AEM med den ökade stackstorleken.

   >[!NOTE]
   >
   >Det nödvändiga stackutrymmet för språkpaket kan bli stort, särskilt när flera språkpaket används.
   >
   >
   >Kontrollera alltid att **instansen har tillräckligt med minne** för att hantera ökningarna av det allokerade stackutrymmet.
   >
   >
   >**base heap måste alltid beräknas för att stödja godtagbara prestanda utan att några språkpaket** är installerade.

4. Registrera språkpaketen via Apache Jackrabbit Oak Machine Translation Full-text Query Terms Provider OSGi-konfigurationer

   * För varje språkpaket skapar [en ny konfiguration för Apache Jackrabbit Oak Machine Translation Full-text Query Terms Provider OSGi](http://localhost:4502/system/console/configMgr/org.apache.jackrabbit.oak.plugins.index.mt.MTFulltextQueryTermsProviderFactory) via konfigurationshanteraren för AEM Web Console.

      * `Joshua Config Path` är den absoluta sökvägen till filen joshua.config. AEM måste kunna läsa alla filer i språkpaketets mapp.
      * `Node types` är de kandidatnodtyper vars fulltextsökning kommer att aktivera det här språkpaketet för översättning.
      * `Minimum score` är det lägsta konfidensvärdet för en översatt term som ska användas.

         * hombre (Spanish for &quot;man&quot;) kan till exempel översätta till det engelska ordet &quot;man&quot; med konfidensvärdet `0.9` och även översätta till det engelska ordet &quot;human&quot; med konfidensvärdet `0.2`. Om du justerar det minsta poängvärdet till `0.3` behålls konverteringen från&quot;hombre&quot; till&quot;man&quot;, men konverteringen från&quot;hombre&quot; till&quot;human&quot; ignoreras eftersom det här översättningspoängen på `0.2` är mindre än det minsta poängvärdet på `0.3`.

5. Gör en fulltextsökning mot resurser
   * Eftersom Asset är nodtypen som det här språkpaketet registreras på nytt, måste vi söka efter AEM Assets med fulltextsökning för att validera detta.
   * Navigera till AEM > Assets och öppna Search. Sök efter en term på det språk vars språkpaket installerades.
   * Finjustera den lägsta poängen i OSGi-konfigurationerna för att säkerställa att resultatet blir korrekt.

6. Uppdaterar språkpaket
   * Apache Joshua-språkpaketen underhålls helt och hållet av Apache Joshua-projektet, och uppdateringen eller korrigeringen av dem görs efter Apache Joshua-projektet.
   * Om ett språkpaket uppdateras för att installera uppdateringarna i AEM måste ovanstående steg 2-4 följas och stackstorleken justeras upp eller ned efter behov.

      * Observera, att när du flyttar det uppackade språkpaketet till mappen crx-quickstart/opt flyttar du en befintlig språkpaketsmapp innan du kopierar den i det nya.

   * Om AEM inte behöver starta om måste de aktuella OSGi-konfigurationerna för Apache Jackrabbit Oak Machien Translation Fulltext Query Terms Provider som gäller för de uppdaterade språkpaketen sparas på nytt så att de uppdaterade filerna bearbetas AEM.

## Uppdaterar index för damAssetLucene {#updating-damassetlucene-index}

För att [AEM smarta taggar](https://helpx.adobe.com/experience-manager/6-3/assets/using/touch-ui-smart-tags.html) ska påverkas av AEM smart översättning måste AEM `/oak   :index  /damAssetLucene`-indexet uppdateras för att markera att de förväntade taggarna (systemnamnet för smarta taggar) är en del av resursens sammanlagda Lucene-index.

Kontrollera att konfigurationen är följande under `/oak:index/damAssetLucene/indexRules/dam:Asset/properties/predicatedTags`:

```xml
 <damAssetLucene jcr:primaryType="oak:QueryIndexDefinition">
        <indexRules jcr:primaryType="nt:unstructured">
            <dam:Asset jcr:primaryType="nt:unstructured">
                <properties jcr:primaryType="nt:unstructured">
                    ...
                    <predictedTags
                        jcr:primaryType="nt:unstructured"
                        isRegexp="{Boolean}true"
                        name="jcr:content/metadata/predictedTags/*/name"
                        useInSpellheck="{Boolean}true"
                        useInSuggest="{Boolean}true"
                        analyzed="{Boolean}true"
                        nodeScopeIndex="{Boolean}true"/>
```

## Ytterligare resurser{#additional-resources}

* [Apache Oak Search Machine Translation OSGi-paket](https://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.apache.jackrabbit%22%20AND%20a%3A%22oak-search-mt%22)
* [Språkpaket för Apache Joshua](https://cwiki.apache.org/confluence/display/JOSHUA/Language+Packs)
* [AEM smarta taggar](https://helpx.adobe.com/experience-manager/6-3/assets/using/touch-ui-smart-tags.html)
* [Bästa praxis för frågor och indexering](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/best-practices-for-queries-and-indexing.html)
