---
title: Skapa dokumentfragment för mottagarens namn och adress
seo-title: Creating Document Fragments to hold the recipient name and address
description: Detta är en del av 5 i en flerstegskurs som du kan använda för att skapa ditt första interaktiva kommunikationsdokument. I den här delen skapar vi dokumentfragment för mottagarens namn och adress.
seo-description: This is part 5 of a multi-step tutorial for creating your first interactive communications document. In this part, we will create document fragment to hold the recipient name and address.
uuid: 689931e4-a026-4e62-9acd-552918180819
feature: Interactive Communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
discoiquuid: 404eed65-ec55-492a-85b5-59773896b217
topic: Development
role: Developer
level: Beginner
exl-id: 1d7093a8-3765-46ec-912a-b5a5503fd5af
source-git-commit: 48d9ddb870c0e4cd001ae49a3f0e9c547407c1e8
workflow-type: tm+mt
source-wordcount: '244'
ht-degree: 0%

---

# Skapa dokumentfragment för mottagarens namn och adress {#creating-document-fragments-to-hold-the-recipient-name-and-address}

I den här delen skapar vi dokumentfragment för mottagarens namn och adress.

>[!VIDEO](https://video.tv.adobe.com/v/22350?quality=12&learn=on)

Dokumentfragment innehåller textinnehållet i interaktiva kommunikationsdokument. Det här textinnehållet kan vara statisk text eller infogas från de underliggande datamodellelementens värden. Till exempel Bästa {name}, där Bästa är statisk text och {name} är namnet på formulärelementet. Under körningen tolkas detta som&quot;Bästa Gloria Rios&quot; eller&quot;Bästa John Jacobs&quot; beroende på värdet på name-elementet.

RTF-redigeraren är tillräckligt intuitiv för att en affärsanvändare ska kunna skapa text och infoga formulärelement. Dokumentfragmentredigeraren kan formatera text, ange teckensnittstyper och format, infoga specialtecken och skapa hyperlänkar.

Dokumentfragmentredigeraren kan även infoga infogade villkor i texten, vilket visas i detta [video](https://helpx.adobe.com/experience-manager/kt/forms/using/editing-improvements-correspondence-mgmt-feature-video-use.html)

>[!NOTE]
>
>Kontrollera att elementen i formulärdatamodellen som du infogar i ett dokumentfragment är underordnade rotelementet. I det här fallet ska du till exempel kontrollera att det användarobjekt du väljer är underordnat saldoobjektet

## Nästa steg

[Skapa interaktivt kommunikationsdokument](./partsix.md)