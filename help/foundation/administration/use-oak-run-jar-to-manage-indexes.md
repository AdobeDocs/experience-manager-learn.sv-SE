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
duration: 726
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '427'
ht-degree: 0%

---

# Använd oak-run.jar för att hantera index

Indexkommandot för [!DNL oak-run.jar] konsoliderar ett antal funktioner för att hantera [!DNL Oak] 200 index i AEM, från insamling av indexstatistik, körning av konsekvenskontroller för index samt omindexering.

>[!NOTE]
>
>I den här artikeln och i videoklipp används termerna indexering och omindexering omväxlande och betraktas som samma åtgärd.

## Grundläggande om indexkommandon för [!DNL oak-run.jar]

>[!VIDEO](https://video.tv.adobe.com/v/21475?quality=12&learn=on)

* Den version av [[!DNL oak-run.jar]](https://repository.apache.org/service/local/artifact/maven/redirect?r=releases&amp;g=org.apache.jackrabbit&amp;a=oak-run&amp;v=1.8.0) som används måste matcha den version av Oak som används i AEM.
* När du hanterar index med [!DNL oak-run.jar] används kommandot **[!DNL index]** med olika flaggor för att stödja olika åtgärder.

   * `java -jar oak-run*.jar index ...`

## Indexstatistik

>[!VIDEO](https://video.tv.adobe.com/v/21477?quality=12&learn=on)

* `oak-run.jar` dumpar alla indexdefinitioner, viktiga indexvärden och indexinnehåll för offlineanalys.
* Insamlingen av indexstatistik är säker att utföra på AEM som används.

## Kontroll av konsekvens i index

>[!VIDEO](https://video.tv.adobe.com/v/21476?quality=12&learn=on)

* `oak-run.jar` avgör snabbt om Oak-index för lucene är skadade.
* Konsekvenskontrollen är säker att köra på AEM som används för konsekvenskontrollnivå 1 och 2.

## TARMK Online-indexering med [!DNL oak-run.jar] {#tarmkonlineindexingwithoakrunjar}

>[!VIDEO](https://video.tv.adobe.com/v/21479?quality=12&learn=on)

* Det går snabbare att indexera [!DNL TarMK] online med [!DNL oak-run.jar] än att ange `reindex=true` på noden `oak:queryIndexDefinition`. Trots den här prestandaökningen krävs fortfarande ett underhållsfönster för att indexeringen ska kunna utföras när du indexerar online med [!DNL oak-run.jar].

* Onlineindexering av [!DNL TarMK] med [!DNL oak-run.jar] ska **inte** köras mot AEM instanser utanför AEM förekomstunderhållsfönster.

## TarmMK Offline-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21478?quality=12&learn=on)

* Offlineindexering av [!DNL TarMK] med [!DNL oak-run.jar] är den enklaste [!DNL oak-run.jar]-baserade indexeringsmetoden för [!DNL TarMK] eftersom den kräver ett enskilt [!DNL oak-run.jar]-kommando, men AEM måste stängas.

## TarmMK Out-of-band-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21480?quality=12&learn=on)

* Utanför band-indexering på [!DNL TarMK] med [!DNL oak-run.jar] minimerar effekten av indexering på AEM som används.
* Indexering utanför band är den rekommenderade indexeringsmetoden för AEM installationer där tiden för omindexering/indexering överstiger tillgängliga underhållsperioder.

## MongoMK Online-indexering med oak-run.jar

* Online-index med [!DNL oak-run.jar] på [!DNL MongoMK] och [!DNL RDBMK] rekommenderas för omindexering/indexering av [!DNL MongoMK] (och [!DNL RDBMK]) AEM. **Ingen annan metod bör användas för [!DNL MongoMK] eller [!DNL RDBMK].**
* Den här indexeringen behöver bara utföras mot en enda AEM i klustret.
* Det är säkert att utföra onlineindexering av [!DNL MongoMK] mot ett AEM kluster som körs, eftersom databasgenomgången bara sker på en enda [!DNL MongoDB]-nod, vilket gör att de andra kan fortsätta att hantera begäranden utan någon större prestandapåverkan.

Indexkommandot [!DNL oak-run.jar] som utför en onlineindexering av [!DNL MongoMK] är [samma som  [!DNL TarMK] onlineindexeringen med  [!DNL oak-run.jar]](#tarmkonlineindexingwithoakrunjar) med skillnaden att segmentlagringsparametern pekar på [!DNL MongoDB]-instansen som innehåller nodbutiken.

```
java -jar oak-run*.jar index
 --reindex
 --index-paths=/oak:index/lucene
 --read-write
 --fds-path=/path/to/datastore mongodb://server:port/aem
```

## Stödmaterial

* [Hämta [!DNL oak-run.jar]](https://repository.apache.org/#nexus-search;gav~org.apache.jackrabbit~oak-run~~~~kw,versionexpand)
   * *Kontrollera att den hämtade versionen matchar den version av Oak som är installerad på AEM enligt beskrivningen ovan*
* [Indexkommandodokumentation för Apache Jackrabbit Oak oak-run.jar](https://jackrabbit.apache.org/oak/docs/query/oak-run-indexing.html)
