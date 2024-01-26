---
title: Använd oak-run.jar för att hantera index
description: index-kommandot oak-run.jar konsoliderar ett antal funktioner för att hantera Oak-index i AEM, från att samla in indexstatistik, köra konsekvenskontroller av index samt att indexera om sig själv.
version: 6.4, 6.5
feature: Search
doc-type: Technical Video
topic: Performance
role: Developer
level: Experienced
exl-id: be49718e-f1f5-4ab2-9c9d-6430a52bb439
duration: 759
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '427'
ht-degree: 0%

---

# Använd oak-run.jar för att hantera index

[!DNL oak-run.jar]Indexkommandot konsoliderar ett antal funktioner som ska hanteras [!DNL Oak]200 index i AEM, från insamling av indexstatistik, körning av konsekvenskontroller och omindexering av index.

>[!NOTE]
>
>I den här artikeln och i videoklipp används termerna indexering och omindexering omväxlande och betraktas som samma åtgärd.

## [!DNL oak-run.jar] grundläggande om indexkommandon

>[!VIDEO](https://video.tv.adobe.com/v/21475?quality=12&learn=on)

* Versionen av [[!DNL oak-run.jar]](https://repository.apache.org/service/local/artifact/maven/redirect?r=releases&amp;g=org.apache.jackrabbit&amp;a=oak-run&amp;v=1.8.0) som används måste matcha den version av Oak som används i AEM.
* Hantera index med [!DNL oak-run.jar] utnyttjar **[!DNL index]** -kommando med olika flaggor som stöder olika åtgärder.

   * `java -jar oak-run*.jar index ...`

## Indexstatistik

>[!VIDEO](https://video.tv.adobe.com/v/21477?quality=12&learn=on)

* `oak-run.jar` alla indexdefinitioner, viktiga indexvärden och indexinnehåll tas bort för offlineanalys.
* Insamlingen av indexstatistik är säker att utföra på AEM som används.

## Kontroll av konsekvens i index

>[!VIDEO](https://video.tv.adobe.com/v/21476?quality=12&learn=on)

* `oak-run.jar` avgör snabbt om index för lucene Oak är skadade.
* Konsekvenskontrollen är säker att köra på AEM som används för konsekvenskontrollnivå 1 och 2.

## TARMK Online-indexering med [!DNL oak-run.jar] {#tarmkonlineindexingwithoakrunjar}

>[!VIDEO](https://video.tv.adobe.com/v/21479?quality=12&learn=on)

* Indexering online av [!DNL TarMK] använda [!DNL oak-run.jar] är snabbare än inställning `reindex=true` på `oak:queryIndexDefinition` nod. Trots den här prestandaökningen använder onlineindexering [!DNL oak-run.jar] kräver fortfarande ett underhållsfönster för att kunna utföra indexeringen.

* Indexering online av [!DNL TarMK] använda [!DNL oak-run.jar] bör **not** körs mot AEM instanser utanför AEM.

## TarmMK Offline-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21478?quality=12&learn=on)

* Offlineindexering av [!DNL TarMK] använda [!DNL oak-run.jar] är enklast [!DNL oak-run.jar] baserad indexeringsmetod för [!DNL TarMK] eftersom det kräver en [!DNL oak-run.jar] -kommandot, men AEM måste stängas.

## TarmMK Out-of-band-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21480?quality=12&learn=on)

* Out-of-band-indexering [!DNL TarMK] använda [!DNL oak-run.jar] minimerar effekten av indexering på AEM som används.
* Indexering utanför band är den rekommenderade indexeringsmetoden för AEM installationer där tiden för omindexering/indexering överstiger tillgängliga underhållsperioder.

## MongoMK Online-indexering med oak-run.jar

* Online-index med [!DNL oak-run.jar] på [!DNL MongoMK] och [!DNL RDBMK] är den rekommenderade metoden för omindexering [!DNL MongoMK] (och [!DNL RDBMK]) AEM. **Ingen annan metod bör användas för [!DNL MongoMK] eller [!DNL RDBMK].**
* Den här indexeringen behöver bara utföras mot en enda AEM i klustret.
* Indexering online av [!DNL MongoMK] är säker att köra mot ett AEM kluster som körs, eftersom databassorteringen bara sker på en enda [!DNL MongoDB] -nod, vilket gör att de andra kan fortsätta att betjäna förfrågningar utan någon större prestandapåverkan.

The [!DNL oak-run.jar] indexkommando för att utföra en onlineindexering av [!DNL MongoMK] är [samma som [!DNL TarMK] Onlineindexering med [!DNL oak-run.jar]](#tarmkonlineindexingwithoakrunjar) med skillnaden som segmentlagringsparametern pekar på [!DNL MongoDB] -instans som innehåller nodarkivet.

```
java -jar oak-run*.jar index
 --reindex
 --index-paths=/oak:index/lucene
 --read-write
 --fds-path=/path/to/datastore mongodb://server:port/aem
```

## Stödmaterial

* [Ladda ned [!DNL oak-run.jar]](https://repository.apache.org/#nexus-search;gav~org.apache.jackrabbit~oak-run~~~~kw,versionexpand)
   * *Kontrollera att den hämtade versionen överensstämmer med den version av Oak som är installerad på AEM enligt beskrivningen ovan*
* [Apache Jackrabbit Oak oak-run.jar Index Command Documentation](https://jackrabbit.apache.org/oak/docs/query/oak-run-indexing.html)
