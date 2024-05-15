---
title: Ställ in dynamisk SSLING-inkludering för AEM
description: En videogenomgång av hur du installerar och använder Apache Sling Dynamic Include med AEM Dispatcher som körs på Apache HTTP Web Server.
version: 6.4, 6.5
sub-product: Experience Manager, Experience Manager Sites
feature: APIs
doc-type: Technical Video
topic: Development
role: Developer
level: Experienced
exl-id: 6c504710-be8f-4b44-bd8a-aaf480ae6d8a
duration: 863
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '230'
ht-degree: 0%

---

# Konfigurera [!DNL Sling Dynamic Include]

En videogenomgång av installation och användning [!DNL Apache Sling Dynamic Include] med [AEM](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/dispatcher.html) körs [!DNL Apache HTTP Web Server].

>[!VIDEO](https://video.tv.adobe.com/v/17040?quality=12&learn=on)

>[!NOTE]
>
> Kontrollera att den senaste versionen av AEM Dispatcher är installerad lokalt.

1. Hämta och installera [[!DNL Sling Dynamic Include] paket](https://sling.apache.org/downloads.cgi).
1. Konfigurera [!DNL Sling Dynamic Include] via [!DNL OSGi Configuration Factory] på **http://&lt;host>:&lt;port>/system/console/configMgr/org.apache.sling.dynamicinclude.Configuration**.

   Eller, om du vill lägga till i en AEM kodbas, skapa **sling:OsgiConfig** nod vid:

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

1. (Valfritt) Upprepa det sista steget för att tillåta komponenter på [låst (ursprungligt) innehåll i redigerbara mallar](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/page-templates-editable.html) att delges via [!DNL SDI] också. Orsaken till den extra konfigurationen är att låst innehåll i redigerbara mallar hanteras från `/conf` i stället för `/content`.

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

1. Uppdatera [!DNL Apache HTTPD Web server]&#39;s `httpd.conf` -fil för att aktivera [!DNL Include] -modul.

   ```shell
   $ sudo vi .../httpd.conf
   ```

   ```shell
   LoadModule include_module libexec/apache2/mod_include.so
   ```

1. Uppdatera [!DNL vhost] fil som ska följas innehåller direktiv.

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

1. Uppdatera dispatcher.alla konfigurationsfiler som stöds (1) `nocache` väljare och (2) aktivera stöd för TTL.

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
   > Lämna efterföljande `*` av i glob `*.nocache.html*` linje före, kan resultera i [problem vid begäran om underresurser](https://github.com/AdobeDocs/experience-manager-learn.en/issues/16).

   ```shell
   /cache {
       ...
       /enableTTL "1"
   }
   ```

1. Starta alltid om [!DNL Apache HTTP Web Server] efter att ha gjort ändringar i konfigurationsfilerna eller `dispatcher.any`.

   ```shell
   $ sudo apachectl restart
   ```

>[!NOTE]
>
>Om du använder [!DNL Sling Dynamic Includes] för servering av SSI (edge-side includes), se till att cachelagra relevanta [svarsrubriker i dispatchercachen](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#CachingHTTPResponseHeaders). Följande rubriker är möjliga:
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
