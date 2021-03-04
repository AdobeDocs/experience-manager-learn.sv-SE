---
title: Utveckla för Cross-Origin Resource Sharing (CORS) med AEM
description: Ett kort exempel på hur du använder CORS för att komma åt AEM från ett externt webbprogram via JavaScript på klientsidan.
version: 6.3, 6,4, 6.5
sub-product: grund, innehållstjänster, webbplatser
topics: security, development, content-delivery
activity: develop
audience: developer
doc-type: tutorial
topic: Dokumentskydd
role: Developer
level: Nybörjare
feature: null
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '287'
ht-degree: 0%

---


# Utveckla för Cross-Origin Resource Sharing (CORS)

Ett kort exempel på hur du använder [!DNL CORS] för att komma åt AEM från ett externt webbprogram via JavaScript på klientsidan.

>[!VIDEO](https://video.tv.adobe.com/v/18837/?quality=12&learn=on)

I den här videon:

* **www.example.** commaps to localhost via  `/etc/hosts`
* **aem-publish.** localmaps to localhost via  `/etc/hosts`
* [SimpleHTTPServer](https://itunes.apple.com/us/app/simple-http-server/id441002840?mt=12)  (en wrapper för  [[!DNL Python]s SimpleHTTPServer](https://docs.python.org/2/library/simplehttpserver.html)) visar HTML-sidan via port 8000.
* [!DNL AEM Dispatcher] körs på  [!DNL Apache HTTP Web Server] 2.4 och omvänd proxybegäran  `aem-publish.local` till  `localhost:4503`.

Mer information finns i [Understanding Cross-Origin Resource Sharing (CORS) i AEM](./understand-cross-origin-resource-sharing.md).

## www.example.com HTML och JavaScript

Den här webbsidan har logik för att

1. När du klickar på knappen
1. Gör en [!DNL AJAX GET]-begäran till `http://aem-publish.local/content/we-retail/.../experience/_jcr_content.1.json`
1. Hämtar `jcr:title` från JSON-svaret
1. Injicerar `jcr:title` i DOM

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

OSGi-konfigurationsfabriken för [!DNL Cross-Origin Resource Sharing] är tillgänglig via:

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

Om du vill tillåta cachelagring och visning av CORS-huvuden i cachelagrat innehåll lägger du till följande [/clientheaders-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#specifying-the-http-headers-to-pass-through-clientheaders) i alla AEM Publish `dispatcher.any`-filer som stöds.

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

**Starta om webbserverprogrammet** när du har gjort ändringar i  `dispatcher.any` filen.

Det är troligt att cache-minnet måste rensas helt för att huvuden ska kunna cachas korrekt på nästa begäran efter en `/clientheaders`-konfigurationsuppdatering.

## Stödmaterial {#supporting-materials}

* [AEM OSGi Configuration factory for Cross-Origin Resource Sharing Policies](http://localhost:4502/system/console/configMgr/com.adobe.granite.cors.impl.CORSPolicyImpl)
* [SimpleHTTPServer för macOS](https://itunes.apple.com/us/app/simple-http-server/id441002840?mt=12)
* [Python SimpleHTTPServer](https://docs.python.org/2/library/simplehttpserver.html)  (Windows/macOS/Linux-kompatibel)

* [Understanding Cross-Origin Resource Sharing (CORS) in AEM](./understand-cross-origin-resource-sharing.md)
* [Resursdelning mellan ursprung (W3C)](https://www.w3.org/TR/cors/)
* [HTTP-åtkomstkontroll (Mozilla MDN)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)

