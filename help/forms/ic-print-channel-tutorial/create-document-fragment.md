---
title: Skapa dokumentfragment
description: Detta är en del av 5 i en flerstegskurs som lär dig skapa ditt första interaktiva kommunikationsdokument. I den här delen skapar vi dokumentfragment för mottagarens namn och adress.
feature: Interactive Communication
doc-type: Tutorial
version: 6.4,6.5
discoiquuid: 47d3aa97-0bff-48e0-8a65-55e5332f811b
jira: KT-5958
thumbnail: 22350.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 2fe3f950-bc2a-4e91-8d91-00438691727a
duration: 217
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '224'
ht-degree: 0%

---

# Skapa dokumentfragment

I den här delen skapar vi dokumentfragment för mottagarens namn och adress.

>[!VIDEO](https://video.tv.adobe.com/v/22350?quality=12&learn=on)

Dokumentfragment innehåller textinnehållet i interaktiva kommunikationsdokument. Det här textinnehållet kan vara statisk text eller infogas från de underliggande datamodellelementens värden. Till exempel **Bästa _{name}_**, där Bästa är statisk text och namnet är elementnamnet i formulärdatamodellen. Vid körning kommer detta att matchas till **Bästa Gloria Rios**eller **Bästa John Jacobs**beroende på värdet på name-elementet.

RTF-redigerare är tillräckligt intuitiv för att en affärsanvändare ska kunna skriva text och infoga formulärelement. Dokumentfragmentredigeraren kan formatera text, ange teckensnittstyper och format, infoga specialtecken och skapa hyperlänkar.

Dokumentfragmentredigeraren kan även infoga infogade villkor i texten, vilket visas i denna [video](https://helpx.adobe.com/experience-manager/kt/forms/using/editing-improvements-correspondence-mgmt-feature-video-use.html)

>[!NOTE]
>
>Kontrollera att elementen i formulärdatamodellen som du infogar i ett dokumentfragment är underordnade rotelementet. I det här fallet ska du till exempel kontrollera att det användarobjekt du väljer är underordnat saldoobjektet

## Nästa steg

[Skapa dokument för utskriftskanal](./create-print-channel-document.md)
