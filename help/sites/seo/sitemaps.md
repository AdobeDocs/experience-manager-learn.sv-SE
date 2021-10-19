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
source-git-commit: 5bdff2eafaa28aff722b12607b1278539072be62
workflow-type: tm+mt
source-wordcount: '158'
ht-degree: 0%

---


# Webbplatskartor

Lär dig hur du kan förbättra din SEO genom att skapa webbplatskartor för AEM Sites.

>[!VIDEO](https://video.tv.adobe.com/v/337960/?quality=12&learn=on)

## Resurser

+ [AEM webbplatskartdokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/overview/seo-and-url-management.html?lang=en#building-an-xml-sitemap-on-aem)
+ [Dokumentation för Apache Sling Sitemap](https://github.com/apache/sling-org-apache-sling-sitemap#readme)
+ [AEM Core WCM Components Github](https://github.com/adobe/aem-core-wcm-components)
   + Funktioner för webbplatskartor som lagts till i v2.17.6
+ [Dokumentation för Sitemap.org Sitemap](https://www.sitemaps.org/protocol.html)
+ [Dokumentation för webbplatskartan.org för platskartor](https://www.sitemaps.org/protocol.html#index)
+ [Cronmaker](http://www.cronmaker.com/)

## Konfigurationer

### org.apache.sling.sitemap.impl.SitemapScheduler~wknd.cfg.json

`ui.config/src/main/jcr_content/apps/wknd/osgiconfig/config.publish`

Definierar [OSGi-fabrikskonfiguration](http://localhost:4502/system/console/configMgr/org.apache.sling.sitemap.impl.SitemapScheduler) för frekvensen (med [cron-uttryck](http://www.cronmaker.com)) sajtkartor genereras om och cachelagras i AEM.

```json
{
  "scheduler.name": "WKND Sitemaps",
  "scheduler.expression": "0 0 2 1/1 * ? *",
  "searchPath": "/content/wknd"
}
```

### filters.any

`dispatcher/src/conf.dispatcher.d/filters/filters.any`

Tillåt HTTP-begäranden för platskarteläge och platskartefiler.

```
...

# Allow AEM WCM Core Components sitemaps
/0200 { /type "allow" /path "/content/*" /selectors '(sitemap-index|sitemap)' /extension "xml" }
```

### rewrite.rules

`dispatcher/src/conf.d/rewrites/rewrite.rules`

Säkerställ `.xml` HTTP-begäranden för platskarta dirigeras till rätt underliggande AEM. Om URL-förkortning inte används, eller om delningskartor används för att uppnå URL-förkortning, behövs inte den här konfigurationen.

```
...
RewriteCond %{REQUEST_URI} (.html|.jpe?g|.png|.svg|.xml)$
RewriteRule ^/(.*)$ /content/${CONTENT_FOLDER_NAME}/$1 [PT,L]
```
