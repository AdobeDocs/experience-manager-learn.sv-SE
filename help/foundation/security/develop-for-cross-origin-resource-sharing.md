---
title: Utveckla för Cross-Origin Resource Sharing (CORS) med AEM
description: Ett kort exempel på hur du använder CORS för att komma åt AEM från ett externt webbprogram via JavaScript på klientsidan.
version: 6.4, 6.5
topic: Security, Development
role: Developer
level: Beginner
feature: Security
exl-id: 867cf74e-44e7-431b-ac8f-41b63c370635
source-git-commit: 41be8c934bba16857d503398b5c7e327acd8d20b
workflow-type: tm+mt
source-wordcount: '293'
ht-degree: 0%

---

# Utveckla för Cross-Origin Resource Sharing (CORS)

Ett kort exempel på hur man utnyttjar [!DNL CORS] för att komma åt AEM från ett externt webbprogram via JavaScript på klientsidan.

>[!VIDEO](https://video.tv.adobe.com/v/18837/?quality=12&learn=on)

I den här videon:

* **www.example.com** mappar till localhost via `/etc/hosts`
* **aem-publish.local** mappar till localhost via `/etc/hosts`
* SimpleHTTPServer (en wrapper för [[!DNL Python]&#39;s SimpleHTTPServer](https://docs.python.org/2/library/simplehttpserver.html)) serverar HTML via port 8000.
   * _Finns inte längre i Mac App Store. Använd liknande [Jeeves](https://apps.apple.com/us/app/jeeves-local-http-server/id980824182?mt=12)._
* [!DNL AEM Dispatcher] körs på [!DNL Apache HTTP Web Server] 2.4 och begäran om omvänd proxering till `aem-publish.local` till `localhost:4503`.

Mer information finns på [Understanding Cross-Origin Resource Sharing (CORS) in AEM](./understand-cross-origin-resource-sharing.md).

## www.example.com HTML och JavaScript

Den här webbsidan har logik för att

1. När du klickar på knappen
1. Gör en [!DNL AJAX GET] begäran till `http://aem-publish.local/content/we-retail/.../experience/_jcr_content.1.json`
1. Hämtar `jcr:title` från JSON-svaret
1. Injicerar `jcr:title` till DOM

```xml
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.2.1.min.js"
  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
  crossorigin="anonymous"></script>   
</head>
<body style="width: 960px; margin: 2rem auto; font-size: 2rem;">
    <button style="font-size: 2rem;"
            data="fn-getTitle">Get Title as JSON from AEM</button>
    <pre id="title">The page title AJAX'd in from AEM will injected here</pre>
    
    <script>
    $(function() { 
        
        /** Get Title as JSON **/
        $('body').on('click', '[data="fn-getTitle"]', function(e) { 
            $.get('http://aem-publish.local/content/we-retail/us/en/experience/_jcr_content.1.json', function(data) {
                $('#title').text(data['jcr:title']);
            },'json');
            
            e.preventDefault();
            return false;
        });
    });
    </script>
</body>
</html>
```

## OSGi-fabrikskonfiguration

OSGi Configuration factory för [!DNL Cross-Origin Resource Sharing] är tillgängligt via:

* `http://<host>:<port>/system/console/configMgr > [!UICONTROL Adobe Granite Cross-Origin Resource Sharing Policy]`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
    jcr:primaryType="sling:OsgiConfig"
    alloworigin="[https://www.example.com:8000]"
    alloworiginregexp="[]"
    allowedpaths="[/content/we-retail/.*]"
    exposedheaders="[]"
    maxage="{Long}1800"
    supportedheaders="[Origin,Accept,X-Requested-With,Content-Type,
Access-Control-Request-Method,Access-Control-Request-Headers]"
    supportedmethods="[GET]"
    supportscredentials="{Boolean}false"
/>
```

## Dispatcher-konfiguration {#dispatcher-configuration}

Om du vill tillåta cachelagring och visning av CORS-huvuden i cachelagrat innehåll lägger du till följande [/clientheaders-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#specifying-the-http-headers-to-pass-through-clientheaders) till alla AEM Publish som stöds `dispatcher.any` filer.

```
/cache { 
  ...
  /clientheaders {
      "Access-Control-Allow-Origin"
      "Access-Control-Expose-Headers"
      "Access-Control-Max-Age"
      "Access-Control-Allow-Credentials"
      "Access-Control-Allow-Methods"
      "Access-Control-Allow-Headers"
  }
  ...
}
```

**Starta om webbserverprogrammet** efter att ha ändrat `dispatcher.any` -fil.

Det är troligt att cache-minnet måste rensas helt för att huvuden ska kunna cachas korrekt på nästa begäran efter en `/clientheaders` konfigurationsuppdatering.

## Stödmaterial {#supporting-materials}

* [AEM OSGi Configuration factory for Cross-Origin Resource Sharing Policies](http://localhost:4502/system/console/configMgr/com.adobe.granite.cors.impl.CORSPolicyImpl)
* [Jeeves for macOS](https://apps.apple.com/us/app/jeeves-local-http-server/id980824182?mt=12)
* [Python SimpleHTTPServer](https://docs.python.org/2/library/simplehttpserver.html) (Windows/macOS/Linux-kompatibel)

* [Understanding Cross-Origin Resource Sharing (CORS) in AEM](./understand-cross-origin-resource-sharing.md)
* [Resursdelning mellan ursprung (W3C)](https://www.w3.org/TR/cors/)
* [HTTP-åtkomstkontroll (Mozilla MDN)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
