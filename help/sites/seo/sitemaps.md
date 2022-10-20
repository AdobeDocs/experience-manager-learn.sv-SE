---
title: Webbplatskartor
description: Lär dig hur du kan förbättra din SEO genom att skapa webbplatskartor för AEM Sites.
version: Cloud Service
feature: Core Components
topic: Content Management
role: Developer
level: Intermediate
kt: 9165
thumbnail: 337960.jpeg
last-substantial-update: 2022-11-03T00:00:00Z
exl-id: 40bb55f9-011d-4261-9f44-b1104a591252
source-git-commit: f4d4bcc836123ba4320710c3024e03a82a36cfb9
workflow-type: tm+mt
source-wordcount: '228'
ht-degree: 3%

---

# Webbplatskartor

Lär dig hur du kan förbättra din SEO genom att skapa webbplatskartor för AEM Sites.

>[!VIDEO](https://video.tv.adobe.com/v/337960/?quality=12&learn=on)

## Resurser

+ [AEM webbplatskartdokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/overview/seo-and-url-management.html?lang=en#building-an-xml-sitemap-on-aem)
+ [Dokumentation för Apache Sling Sitemap](https://github.com/apache/sling-org-apache-sling-sitemap#readme)
+ [Dokumentation för Sitemap.org Sitemap](https://www.sitemaps.org/protocol.html)
+ [Dokumentation för webbplatskartan.org för platskartor](https://www.sitemaps.org/protocol.html#index)
+ [Cronmaker](http://www.cronmaker.com/)

## Konfigurationer

### OSGi-konfiguration för schemaläggare för platskarta

Definierar [OSGi-fabrikskonfiguration](http://localhost:4502/system/console/configMgr/org.apache.sling.sitemap.impl.SitemapScheduler) för frekvensen (med [cron-uttryck](http://www.cronmaker.com)) sajtkartor genereras om och cachelagras i AEM.

`ui.config/src/main/jcr_content/apps/wknd/osgiconfig/config.publish`

```json
{
  "scheduler.name": "WKND Sitemaps",
  "scheduler.expression": "0 0 2 1/1 * ? *",
  "searchPath": "/content/wknd"
}
```

### Absoluta URL för webbplatskarta

AEM sitemap stöder absoluta URL:er med [Sling-mappning](https://sling.apache.org/documentation/the-sling-engine/mappings-for-resource-resolution.html). Detta görs genom att skapa mappningsnoder på de AEM tjänsterna som genererar platskartor (vanligtvis AEM Publish-tjänsten).

Exempel på noddefinition för Sling-mappning för `https://wknd.com` kan definieras under `/etc/map/https` enligt följande:

| Bana | Egenskapsnamn | Egenskapstyp | Egenskapsvärde |
|------|----------|---------------|-------|
| `/etc/map/https/wknd-site` | `jcr:primaryType` | Sträng | `nt:unstructured` |
| `/etc/map/https/wknd-site` | `sling:internalRedirect` | Sträng | `/content/wknd/(.*)` |
| `/etc/map/https/wknd-site` | `sling:match` | Sträng | `wknd.com/$1` |

Skärmbilden nedan visar en liknande konfiguration, men för `http://wknd.local` (en lokal värdnamnsmappning körs på `http`).

![Konfiguration av absolut URL för platskarta](../assets/sitemaps/sitemaps-absolute-urls.jpg)


### Filterregel för Tillåt utskickning

Tillåt HTTP-begäranden för platskarteläge och platskartefiler.

`dispatcher/src/conf.dispatcher.d/filters/filters.any`

```
...

# Allow AEM sitemaps
/0200 { /type "allow" /path "/content/*" /selectors '(sitemap-index|sitemap)' /extension "xml" }
```

### Omskrivningsregel för Apache-webbserver

Säkerställ `.xml` HTTP-begäranden för platskarta dirigeras till rätt underliggande AEM. Om URL-förkortning inte används, eller om delningskartor används för att uppnå URL-förkortning, behövs inte den här konfigurationen.

`dispatcher/src/conf.d/rewrites/rewrite.rules`

```
...
RewriteCond %{REQUEST_URI} (.html|.jpe?g|.png|.svg|.xml)$
RewriteRule ^/(.*)$ /content/${CONTENT_FOLDER_NAME}/$1 [PT,L]
```
