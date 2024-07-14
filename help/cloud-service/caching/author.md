---
title: Cachelagring av AEM Author Service
description: Allmän översikt över cachelagring av tjänsten AEM as a Cloud Service Author.
version: Cloud Service
feature: Developer Tools
topic: Performance
role: Architect, Developer
level: Intermediate
doc-type: Article
last-substantial-update: 2023-08-28T00:00:00Z
jira: KT-13858
thumbnail: KT-13858.jpeg
exl-id: b8e09820-f1f2-4897-b454-16c0df5a0459
duration: 56
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '281'
ht-degree: 0%

---

# AEM

AEM har begränsad cachelagring på grund av den mycket dynamiska och behörighetskänsliga karaktären hos det innehåll som används. I allmänhet rekommenderar vi inte att du anpassar cachelagring för AEM Author utan använder cachekonfigurationerna från Adobe för att få en bättre prestanda.

![AEM Översiktsdiagram över redigeringscachning](./assets/author/author-all.png){align="center"}

Även om det inte är rekommenderat att anpassa cachelagring för AEM författare är det bra att veta att AEM författare har ett CDN som hanteras av Adobe, men inte har något AEM Dispatcher. Kom ihåg att alla AEM Dispatcher-konfigurationer ignoreras på AEM författare, eftersom den inte har någon AEM Dispatcher.

## CDN

AEM Author-tjänsten använder ett CDN, men dess syfte är att förbättra leveransen av produktresurser och bör inte konfigureras i stor omfattning, utan låta det fungera som det är.

![AEM Översikt över cachelagring i Publish](./assets/author/author-cdn.png){align="center"}

AEM författare-CDN sitter mellan slutanvändaren, vanligtvis en marknadsförare eller innehållsförfattare, och AEM författare. Det cachelagrar oföränderliga filer, t.ex. statiska resurser som används vid redigering av AEM och inte redigerat innehåll.

AEM författares CDN cachelagrar flera typer av resurser som kan vara av intresse, bland annat en [anpassningsbar TTL för beständiga frågor](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?author-instances) och en [lång TTL för anpassade klientbibliotek](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#client-side-libraries).

### Standardcachetid

Följande kundvända resurser cachelagras av AEM författare-CDN och har följande standardcachetid:

| Innehållstyp | Standardcachetid för CDN |
|:------------ |:---------- |
| [Beständiga frågor (JSON)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?author-instances) | 1 minut |
| [Klientbibliotek (JS/CSS)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#client-side-libraries) | 30 dagar |
| [Allt annat](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#other-content) | Inte cachelagrad |


## AEM Dispatcher

AEM Author-tjänsten innehåller inte AEM Dispatcher och använder bara [CDN](#cdn) för cachelagring.
