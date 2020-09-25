---
title: Använd oak-run.jar för att hantera index
description: index-kommandot oak-run.jar konsoliderar ett antal funktioner för att hantera Oak-index i AEM, från att samla in indexstatistik, köra konsekvenskontroller av index samt att indexera om sig själv.
version: 6.4, 6.5
feature: oak
topics: search
activity: use
audience: architect, developer, implementer
doc-type: technical video
translation-type: tm+mt
source-git-commit: e19e177589df7ce6a56c0be3f9d590cbca2f8ce7
workflow-type: tm+mt
source-wordcount: '451'
ht-degree: 0%

---


# Använd oak-run.jar för att hantera index

[!DNL oak-run.jar]Med indexkommandot konsolideras ett antal funktioner för att hantera [!DNL Oak]200 index i AEM, från insamling av indexstatistik, körning av konsekvenskontroller för index samt omindexering.

>[!NOTE]
>
>I den här artikeln och i videoklipp används termerna indexering och omindexering omväxlande och betraktas som samma åtgärd.

## [!DNL oak-run.jar] grundläggande om indexkommandon

>[!VIDEO](https://video.tv.adobe.com/v/21475/?quality=9&learn=on)

* Den version av [[!DNL oak-run.jar]](https://repository.apache.org/service/local/artifact/maven/redirect?r=releases&amp;g=org.apache.jackrabbit&amp;a=oak-run&amp;v=1.8.0) som används måste matcha den version av Oak som används i AEM.
* När du hanterar index med hjälp [!DNL oak-run.jar] av används **[!DNL index]** kommandot med olika flaggor som stöd för olika åtgärder.

   * `java -jar oak-run*.jar index ...`

## Indexstatistik

>[!VIDEO](https://video.tv.adobe.com/v/21477/?quality=12&learn=on)

* `oak-run.jar` alla indexdefinitioner, viktiga indexvärden och indexinnehåll tas bort för offlineanalys.
* Insamlingen av indexstatistik är säker att utföra på AEM som används.

## Kontroll av konsekvens i index

>[!VIDEO](https://video.tv.adobe.com/v/21476/?quality=12&learn=on)

* `oak-run.jar` avgör snabbt om index för lucene Oak är skadade.
* Konsekvenskontrollen är säker att köra på AEM som används för konsekvenskontrollnivå 1 och 2.

## TarmMK Online-indexering med [!DNL oak-run.jar] {#tarmkonlineindexingwithoakrunjar}

>[!VIDEO](https://video.tv.adobe.com/v/21479/?quality=12&learn=on)

* Det går snabbare att indexera online [!DNL TarMK] med [!DNL oak-run.jar] att använda `reindex=true` på `oak:queryIndexDefinition` noden. Trots den här prestandaökningen krävs det [!DNL oak-run.jar] fortfarande ett underhållsfönster för att indexeringen ska kunna utföras när du indexerar online.

* Onlineindexering av [!DNL TarMK] med [!DNL oak-run.jar] ska **inte** utföras mot AEM instanser utanför AEM.

## TarmMK Offline-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21478/?quality=12&learn=on)

* Offlineindexering av [!DNL TarMK] användning [!DNL oak-run.jar] är den enklaste [!DNL oak-run.jar] baserade indexeringsmetoden för [!DNL TarMK] eftersom den kräver ett enda [!DNL oak-run.jar] kommando, men den kräver att AEM instansen stängs av.

## TarmMK Out-of-band-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21480/?quality=12&learn=on)

* Indexering utanför band på [!DNL TarMK] användning [!DNL oak-run.jar] minimerar effekten av indexering på AEM som används.
* Indexering utanför band är den rekommenderade indexeringsmetoden för AEM installationer där tiden för omindexering/indexering överstiger tillgängliga underhållsperioder.

## MongoMK Online-indexering med oak-run.jar

* Online-index med [!DNL oak-run.jar] på [!DNL MongoMK] och [!DNL RDBMK] är den rekommenderade metoden för omindexering [!DNL MongoMK] (och [!DNL RDBMK]) AEM. **Ingen annan metod ska användas för[!DNL MongoMK]eller[!DNL RDBMK].**
* Den här indexeringen behöver bara utföras mot en enda AEM i klustret.
* Onlineindexering av [!DNL MongoMK] är säkert att köra mot ett AEM kluster som körs, eftersom databasgenomgången bara sker på en enda [!DNL MongoDB] nod, vilket gör att de andra kan fortsätta att hantera begäranden utan någon större prestandapåverkan.

Indexkommandot [!DNL oak-run.jar] som används för att utföra en onlineindexering av [!DNL MongoMK] är [detsamma som [!DNL TarMK] indexeringen online med [!DNL oak-run.jar]](#tarmkonlineindexingwithoakrunjar) skillnaden att segmentlagringsparametern pekar på [!DNL MongoDB] instansen som innehåller nodbutiken.

```
java -jar oak-run*.jar index
 --reindex
 --index-paths=/oak:index/lucene
 --read-write
 --fds-path=/path/to/datastore mongodb://server:port/aem
```

## Stödmaterial

* [Hämta [!DNL oak-run.jar]](https://repository.apache.org/#nexus-search;gav~org.apache.jackrabbit~oak-run~~~~kw,versionexpand)
   * *Kontrollera att den hämtade versionen överensstämmer med den version av Oak som är installerad på AEM enligt beskrivningen ovan*
* [Apache Jackrabbit Oak oak-run.jar Index Command Documentation](https://jackrabbit.apache.org/oak/docs/query/oak-run-indexing.html)
