---
title: Webbplatskartor
description: Lär dig hur du kan förbättra din SEO genom att skapa webbplatskartor för AEM Sites.
version: Experience Manager as a Cloud Service
feature: Core Components
topic: Content Management
role: Developer
level: Intermediate
jira: KT-9165
thumbnail: 337960.jpeg
last-substantial-update: 2022-10-03T00:00:00Z
doc-type: Technical Video
exl-id: 40bb55f9-011d-4261-9f44-b1104a591252
duration: 937
source-git-commit: d2714443fa644ba17afdfbed5e6da8091425aeab
workflow-type: tm+mt
source-wordcount: '234'
ht-degree: 0%

---

# Webbplatskartor

Lär dig hur du kan förbättra din SEO genom att skapa webbplatskartor för AEM Sites.

>[!WARNING]
>
>I den här videon visas hur relativa URL:er används i platskartan. Webbplatskartor [ska använda absoluta URL:er](https://sitemaps.org/protocol.html). Se [Konfigurationer](#absolute-sitemap-urls) för hur du aktiverar absoluta URL:er, eftersom detta inte beskrivs i videon nedan.

>[!VIDEO](https://video.tv.adobe.com/v/337960?quality=12&learn=on)

## Konfigurationer

### Absoluta URL för webbplatskarta{#absolute-sitemap-urls}

AEM webbplatskarta stöder absoluta URL:er genom att använda [delningskarta](https://sling.apache.org/documentation/the-sling-engine/mappings-for-resource-resolution.html). Detta görs genom att skapa mappningsnoder på AEM-tjänster som genererar platskartor (vanligtvis AEM Publish-tjänsten).

Ett exempel på en noddefinition för Sling-mappning för `https://wknd.com` kan definieras under `/etc/map/https` enligt följande:

| Bana | Egenskapsnamn | Egenskapstyp | Egenskapsvärde |
|------|----------|---------------|-------|
| `/etc/map/https/wknd-site` | `jcr:primaryType` | Sträng | `nt:unstructured` |
| `/etc/map/https/wknd-site` | `sling:internalRedirect` | Sträng | `/content/wknd/(.*)` |
| `/etc/map/https/wknd-site` | `sling:match` | Sträng | `wknd.com/$1` |

Skärmbilden nedan visar en liknande konfiguration, men för `http://wknd.local` (en lokal värdnamnsmappning som körs på `http`).

![Konfiguration av absolut URL för webbplatskarta](../assets/sitemaps/sitemaps-absolute-urls.jpg)


### OSGi-konfiguration för schemaläggare för platskarta

Definierar fabrikskonfigurationen [OSGi](http://localhost:4502/system/console/configMgr/org.apache.sling.sitemap.impl.SitemapScheduler) för frekvensen (med [cron expressions](https://cron.help/)) återskapas/genereras och cachelagras i AEM.

`ui.config/src/main/jcr_content/apps/wknd/osgiconfig/config.author`

```json
{
  "scheduler.name": "WKND Sitemaps",
  "scheduler.expression": "0 0 2 1/1 * ? *",
  "searchPath": "/content/wknd"
}
```

### Dispatcher Tillåt filterregel

Tillåt HTTP-begäranden för platskarteläge och platskartefiler.

`dispatcher/src/conf.dispatcher.d/filters/filters.any`

```
...

# Allow AEM sitemaps
/0200 { /type "allow" /path "/content/*" /selectors '(sitemap-index|sitemap)' /extension "xml" }
```

### Omskrivningsregel för Apache-webbserver

Kontrollera att `.xml` platskarta HTTP-begäranden dirigeras till rätt underliggande AEM-sida. Om URL-förkortning inte används, eller om delningskartor används för att uppnå URL-förkortning, behövs inte den här konfigurationen.

`dispatcher/src/conf.d/rewrites/rewrite.rules`

```
...
RewriteCond %{REQUEST_URI} (.html|.jpe?g|.png|.svg|.xml)$
RewriteRule ^/(.*)$ /content/${CONTENT_FOLDER_NAME}/$1 [PT,L]
```

## Resurser

+ [AEM SiteMap-dokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/overview/seo-and-url-management.html?lang=sv-SE)
+ [Dokumentation för Apache Sling Sitemap](https://github.com/apache/sling-org-apache-sling-sitemap#readme)
+ [Sitemap.org för webbplatskartan](https://www.sitemaps.org/protocol.html)
+ [Sitemap.org Dokumentation för indexfil för platskarta](https://www.sitemaps.org/protocol.html#index)
+ [Kronhjälpen](https://cron.help/)
