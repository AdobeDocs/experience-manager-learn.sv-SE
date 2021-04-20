---
title: Ställ in dynamisk SSLING-inkludering för AEM
description: En videogenomgång av hur du installerar och använder Apache Sling Dynamic Include med AEM Dispatcher som körs på Apache HTTP Web Server.
version: 6.3, 6.4, 6.5
sub-product: grund, platser
feature: APIs
topics: caching
activity: develop
audience: architect, developer
doc-type: technical video
topic: Development
role: Developer
level: Experienced
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '267'
ht-degree: 3%

---


# Konfigurera [!DNL Sling Dynamic Include]

En genomgång av hur du installerar och använder [!DNL Apache Sling Dynamic Include] med [AEM Dispatcher](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/dispatcher.html) som körs på [!DNL Apache HTTP Web Server].

>[!VIDEO](https://video.tv.adobe.com/v/17040/?quality=12&learn=on)

>[!NOTE]
>
> Kontrollera att den senaste versionen av AEM Dispatcher är installerad lokalt.

1. Hämta och installera [[!DNL Sling Dynamic Include] paketet](https://sling.apache.org/downloads.cgi).
1. Konfigurera [!DNL Sling Dynamic Include] via [!DNL OSGi Configuration Factory] på **http://&lt;host>:&lt;port>/system/console/configMgr/org.apache.sling.dynamicinclude.Configuration**.

   Eller, om du vill lägga till en AEM kodbas, skapar du lämplig **sling:OsgiConfig**-nod på:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="sling:OsgiConfig"
       include-filter.config.enabled="{Boolean}true"
       include-filter.config.path="/content"
       include-filter.config.resource-types="[my-app/components/content/highly-dynamic]"
       include-filter.config.include-type="SSI" 
       include-filter.config.add_comment="{Boolean}false"
       include-filter.config.selector="nocache"
       include-filter.config.ttl=""
       include-filter.config.required_header="Server-Agent=Communique-Dispatcher"
       include-filter.config.ignoreUrlParams="[]"
       include-filter.config.rewrite="{Boolean}true"
       />
   <!--
   * include-filter.config.include-type="SSI | ESI | JSI"
   * include-filter.config.ttl is # of seconds (requires AEM Dispatcher 4.1.11+)
   -->
   ```

1. (Valfritt) Upprepa det sista steget för att även tillåta att komponenter i [låst (ursprungligt) innehåll i redigerbara mallar](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/page-templates-editable.html) kan hanteras via [!DNL SDI]. Orsaken till den extra konfigurationen är att låst innehåll i redigerbara mallar hanteras från `/conf` i stället för `/content`.

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0"
       xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
       jcr:primaryType="sling:OsgiConfig"
       include-filter.config.enabled="{Boolean}true"
       include-filter.config.path="/conf"
       include-filter.config.resource-types="[my-app/components/content/highly-dynamic]"
       include-filter.config.include-type="SSI" 
       include-filter.config.add_comment="{Boolean}false"
       include-filter.config.selector="nocache"
       include-filter.config.ttl=""
       include-filter.config.required_header="Server-Agent=Communique-Dispatcher"
       include-filter.config.ignoreUrlParams="[]"
       include-filter.config.rewrite="{Boolean}true"
       />
   <!--
   * include-filter.config.include-type="SSI | ESI | JSI"
   * include-filter.config.ttl is # of seconds (requires AEM Dispatcher 4.1.11+)
   -->
   ```

1. Uppdatera `httpd.conf`-filen för [!DNL Apache HTTPD Web server] för att aktivera modulen [!DNL Include].

   ```shell
   $ sudo vi .../httpd.conf
   ```

   ```shell
   LoadModule include_module libexec/apache2/mod_include.so
   ```

1. Uppdatera [!DNL vhost]-filen så att den respekterar direktiv om inkludering.

   ```shell
   $ sudo vi .../vhosts/aem-publish.local.conf
   ```

   ```shell
   <VirtualHost *:80>
   ...
      <Directory /Library/WebServer/docroot/publish>
         ...
         # Add Includes to enable SSI Includes used by Sling Dynamic Include
         Options FollowSymLinks Includes
   
         # Required to have dispatcher-handler process includes
         ModMimeUsePathInfo On
   
         # Set includes to process .html files
         AddOutputFilter INCLUDES .html
         ...
      </Directory>
   ...
   </VirtualHost>
   ```

1. Uppdatera dispatcher.any-konfigurationsfilen så att den stöder (1) `nocache`-väljare och (2) aktivera stöd för TTL.

   ```shell
   $ sudo vi .../conf/dispatcher.any
   ```

   ```shell
   /rules {
     ...
     /0009 {
       /glob "*.nocache.html*"
       /type "deny"
     } 
   }
   ```

   >[!TIP]
   >
   > Om du lämnar det avslutande `*` i glob `*.nocache.html*`-regeln ovan kan det leda till [problem i begäranden för underresurser](https://github.com/AdobeDocs/experience-manager-learn.en/issues/16).

   ```shell
   /cache {
       ...
       /enableTTL "1"
   }
   ```

1. Starta alltid om [!DNL Apache HTTP Web Server] när du har gjort ändringar i konfigurationsfilerna eller i `dispatcher.any`.

   ```shell
   $ sudo apachectl restart
   ```

>[!NOTE]
>
>Om du använder [!DNL Sling Dynamic Includes] för att hantera SSI (edge-side includes) måste du se till att cachelagra relevanta [svarshuvuden i dispatcher-cachen](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#CachingHTTPResponseHeaders). Följande rubriker är möjliga:
>
>* &quot;Cache-Control&quot;
>* &quot;Content-Disposition&quot;
>* &quot;Content-Type&quot;
>* &quot;Förfaller&quot;
>* &quot;Senast ändrad&quot;
>* &quot;ETag&quot;
>* &quot;X-content-type-options&quot;
>* &quot;Senast ändrad&quot;

>



## Stödmaterial

* [Ladda ned paketet Sling Dynamic Include](https://sling.apache.org/downloads.cgi)
* [Dokumentation för Apache Sling Dynamic Include](https://github.com/Cognifide/Sling-Dynamic-Include)
