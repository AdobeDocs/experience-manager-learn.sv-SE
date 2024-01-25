---
title: Cachelagring av AEM Author Service
description: Allmän översikt över cachning AEM as a Cloud Service Author-tjänsten.
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
duration: 67
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '281'
ht-degree: 0%

---

# AEM

AEM har begränsad cachelagring på grund av den mycket dynamiska och behörighetskänsliga karaktären hos det innehåll som används. I allmänhet rekommenderar vi inte att du anpassar cachelagring för AEM Author utan använder cachekonfigurationerna från Adobe för att få en bättre prestanda.

![Översiktsdiagram för AEM Author Caching](./assets/author/author-all.png){align="center"}

Även om det inte är rekommenderat att anpassa cachelagring för AEM författare är det bra att veta att AEM författare har ett CDN som hanteras av Adobe, men inte har någon AEM Dispatcher. Kom ihåg att alla AEM Dispatcher-konfigurationer ignoreras på AEM Author, eftersom den inte har någon AEM Dispatcher.

## CDN

AEM Author-tjänsten använder ett CDN, men dess syfte är att förbättra leveransen av produktresurser och bör inte konfigureras i stor omfattning, utan låta det fungera som det är.

![Översiktsdiagram för AEM publicera cachelagring](./assets/author/author-cdn.png){align="center"}

AEM författare-CDN sitter mellan slutanvändaren, vanligtvis en marknadsförare eller innehållsförfattare, och AEM författare. Det cachelagrar oföränderliga filer, t.ex. statiska resurser som används vid redigering av AEM och inte redigerat innehåll.

AEM författarens CDN cachelagrar flera typer av resurser som kan vara av intresse, bland annat en [anpassningsbar TTL på beständiga frågor](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?author-instances)och en [long TTL on custom Client Libraries](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#client-side-libraries).

### Standardcachetid

Följande kundvända resurser cachelagras av AEM författare-CDN och har följande standardcachetid:

| Innehållstyp | Standardcachetid för CDN |
|:------------ |:---------- |
| [Beständiga frågor (JSON)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?author-instances) | 1 minut |
| [Klientbibliotek (JS/CSS)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#client-side-libraries) | 30 dagar |
| [Allt annat](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#other-content) | Inte cachelagrad |


## AEM

AEM Author-tjänsten innehåller inte AEM Dispatcher och använder bara [CDN](#cdn) för cachning.
