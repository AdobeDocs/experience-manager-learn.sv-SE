---
title: Skapa dokumentfragment
description: 'Detta är en del av 5 i en flerstegskurs som du kan använda för att skapa ditt första interaktiva kommunikationsdokument. I den här delen skapar vi dokumentfragment för mottagarens namn och adress. '
seo-description: 'Detta är en del av 5 i en flerstegskurs som du kan använda för att skapa ditt första interaktiva kommunikationsdokument. I den här delen skapar vi dokumentfragment för mottagarens namn och adress. '
uuid: 7fd8a0f2-a921-4e70-91c9-908dae9aeab2
feature: interactive-communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
discoiquuid: 47d3aa97-0bff-48e0-8a65-55e5332f811b
kt: 5958
thumbnail: 22350.jpg
translation-type: tm+mt
source-git-commit: 449202af47b6bbcd9f860d5c5391d1f7096d489e
workflow-type: tm+mt
source-wordcount: '252'
ht-degree: 0%

---


# Skapa dokumentfragment

I den här delen skapar vi dokumentfragment för mottagarens namn och adress.

>[!VIDEO](https://video.tv.adobe.com/v/22350/?quality=9&learn=on)

Dokumentfragment innehåller textinnehållet i interaktiva kommunikationsdokument. Det här textinnehållet kan vara statisk text eller infogas från de underliggande datamodellelementens värden. Till exempel **Bästa _{name}_**, där Bästa är statisk text och namnet är formulärdatamodellens elementnamn. Vid körning kommer detta att evalueras till **Bästa Gloria Rios**eller **Bästa John Jacobs**beroende på name-elementets värde.

RTF-redigerare är tillräckligt intuitiv för att en affärsanvändare ska kunna skriva text och infoga formulärelement. Dokumentfragmentredigeraren kan formatera text, ange teckensnittstyper och format, infoga specialtecken och skapa hyperlänkar.

Dokumentfragmentredigeraren kan även infoga infogade villkor i texten, vilket visas i den här [videon](https://helpx.adobe.com/experience-manager/kt/forms/using/editing-improvements-correspondence-mgmt-feature-video-use.html)

>[!NOTE]
>
>Kontrollera att elementen i formulärdatamodellen som du infogar i ett dokumentfragment är underordnade rotelementet. I det här fallet ska du till exempel kontrollera att det användarobjekt du väljer är underordnat saldoobjektet

