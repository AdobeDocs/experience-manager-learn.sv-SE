---
title: Frågar efter formulärinlämning
description: Multidelad självstudiekurs som visar hur du går igenom stegen för att fråga efter formuläröverföringar som lagras i Azure Portal
feature: Adaptive Forms
doc-type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Experienced
jira: kt-14884
last-substantial-update: 2024-03-03T00:00:00Z
source-git-commit: ae2a2cbde1bf21314cc77863014cb0f013b6e0bb
workflow-type: tm+mt
source-wordcount: '164'
ht-degree: 0%

---

# Skapa anpassad sändning

En anpassad överföringshanterare skrevs för att hantera formuläröverföringen. På en hög nivå gör den anpassade överföringshanteraren följande

* Extraherar namnet på det skickade formuläret.
* Extraherar skickade data.Skickade data i ett kärnkomponentbaserat formulär är alltid i JSON-format.
* Extraherar och lagrar formulärbilagor i Azure-portalen. Uppdaterar skickade JSON-data med den bifogade filens URL.
* Skapar blobbindextaggar - Hittar listan med sökbara fält för formuläret och dess motsvarande värde från skickade data.
* Associerar blobindextaggarna med skickade data och lagrar dem i Azure-portalen.

I följande skärmbild visas blobindextaggarna i Azure Portal

![blob-index-tags](assets/blob-index-tags.png)

Den anpassade skicka-koden finns i **_StoreFormDataWithBlobIndexTagsInAzure_** och koden för att lagra och hämta data från Azure finns i komponenten **_SparaOchHämtaFrånAzure_**

## Nästa steg

[Skapa frågegränssnitt](./part3.md)

