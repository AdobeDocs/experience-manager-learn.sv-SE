---
title: Använd oak-run.jar för att hantera index
description: index-kommandot oak-run.jar konsoliderar ett antal funktioner för att hantera Oak-index i AEM, från att samla in indexstatistik, köra konsekvenskontroller av index samt att indexera om sig själv.
version: Experience Manager 6.4, Experience Manager 6.5
feature: Search
doc-type: Technical Video
topic: Performance
role: Developer
level: Experienced
exl-id: be49718e-f1f5-4ab2-9c9d-6430a52bb439
duration: 726
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '427'
ht-degree: 0%

---

# Använd oak-run.jar för att hantera index

Indexkommandot för [!DNL oak-run.jar] konsoliderar ett antal funktioner för att hantera [!DNL Oak]200-index i AEM, från att samla in indexstatistik, köra konsekvenskontroller för index samt att indexera om sig själv.

>[!NOTE]
>
>I den här artikeln och i videoklipp används termerna indexering och omindexering omväxlande och betraktas som samma åtgärd.

## Grundläggande om indexkommandon för [!DNL oak-run.jar]

>[!VIDEO](https://video.tv.adobe.com/v/21475?quality=12&learn=on)

* Versionen av [[!DNL oak-run.jar]](https://repository.apache.org/service/local/artifact/maven/redirect?r=releases&amp;g=org.apache.jackrabbit&amp;a=oak-run&amp;v=1.8.0) måste matcha den version av Oak som används på AEM-instansen.
* När du hanterar index med [!DNL oak-run.jar] används kommandot **[!DNL index]** med olika flaggor för att stödja olika åtgärder.

   * `java -jar oak-run*.jar index ...`

## Indexstatistik

>[!VIDEO](https://video.tv.adobe.com/v/21477?quality=12&learn=on)

* `oak-run.jar` dumpar alla indexdefinitioner, viktiga indexvärden och indexinnehåll för offlineanalys.
* Insamlingen av indexstatistik är säker att köra på AEM-instanser som används.

## Kontroll av konsekvens i index

>[!VIDEO](https://video.tv.adobe.com/v/21476?quality=12&learn=on)

* `oak-run.jar` avgör snabbt om Oak-index för lucene är skadade.
* Konsekvenskontrollen är säker att köra på en AEM-instans som används för konsekvenskontrollnivå 1 och 2.

## TARMK Online-indexering med [!DNL oak-run.jar] {#tarmkonlineindexingwithoakrunjar}

>[!VIDEO](https://video.tv.adobe.com/v/21479?quality=12&learn=on)

* Det går snabbare att indexera [!DNL TarMK] online med [!DNL oak-run.jar] än att ange `reindex=true` på noden `oak:queryIndexDefinition`. Trots den här prestandaökningen krävs fortfarande ett underhållsfönster för att indexeringen ska kunna utföras när du indexerar online med [!DNL oak-run.jar].

* Onlineindexering av [!DNL TarMK] med [!DNL oak-run.jar] ska **inte** köras mot AEM-instanser utanför underhållsfönstret för AEM-instanser.

## TarmMK Offline-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21478?quality=12&learn=on)

* Offlineindexering av [!DNL TarMK] med [!DNL oak-run.jar] är den enklaste [!DNL oak-run.jar]-baserade indexeringsmetoden för [!DNL TarMK] eftersom den kräver ett [!DNL oak-run.jar]-kommando, men AEM-instansen måste stängas av.

## TarmMK Out-of-band-indexering med oak-run.jar

>[!VIDEO](https://video.tv.adobe.com/v/21480?quality=12&learn=on)

* Utanför band-indexering på [!DNL TarMK] med [!DNL oak-run.jar] minimerar effekten av indexering på AEM-instanser som används.
* Indexering utanför band är den rekommenderade indexeringsmetoden för AEM-installationer där tiden för omindexering/indexering överstiger tillgängliga underhållsperioder.

## MongoMK Online-indexering med oak-run.jar

* Online-index med [!DNL oak-run.jar] på [!DNL MongoMK] och [!DNL RDBMK] rekommenderas för omindexering av [!DNL MongoMK] (och [!DNL RDBMK]) AEM-installationer. **Ingen annan metod bör användas för [!DNL MongoMK] eller [!DNL RDBMK].**
* Indexeringen behöver bara utföras mot en enda AEM-instans i klustret.
* Det är säkert att utföra onlineindexering av [!DNL MongoMK] mot ett AEM-kluster som körs, eftersom databasgenomgången bara sker på en enskild [!DNL MongoDB]-nod, vilket gör att de andra kan fortsätta att hantera begäranden utan någon större prestandapåverkan.

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
   * *Kontrollera att den hämtade versionen matchar den version av Oak som är installerad på AEM som beskrivs ovan*
* [Indexkommandodokumentation för Apache Jackrabbit Oak oak-run.jar](https://jackrabbit.apache.org/oak/docs/query/oak-run-indexing.html)
