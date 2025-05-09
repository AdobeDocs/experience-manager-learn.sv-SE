---
title: Utveckla för Cross-Origin Resource Sharing (CORS) med AEM
description: Ett kort exempel på hur CORS kan utnyttja AEM-material från ett externt webbprogram via JavaScript på klientsidan.
version: Experience Manager 6.4, Experience Manager 6.5
topic: Security, Development
role: Developer
level: Beginner
feature: Security
doc-type: Technical Video
exl-id: 867cf74e-44e7-431b-ac8f-41b63c370635
duration: 333
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '318'
ht-degree: 0%

---

# Utveckla för Cross-Origin Resource Sharing (CORS)

Ett kort exempel på hur [!DNL CORS] kan utnyttja AEM-innehåll från ett externt webbprogram via JavaScript på klientsidan. I det här exemplet används CORS OSGi-konfigurationen för att aktivera CORS-åtkomst på AEM. OSGi-konfigurationsmetoden är användbar när:

* Ett enda ursprung är åtkomst till AEM Publish-innehåll
* CORS-åtkomst krävs för AEM Author

Om åtkomst till AEM Publish med flera ursprung krävs, se [det här dokumentet](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/configurations/cors.html?lang=sv-SE#dispatcher-configuration).

>[!VIDEO](https://video.tv.adobe.com/v/18837?quality=12&learn=on)

I den här videon:

* **www.example.com** mappar till localhost via `/etc/hosts`
* **aem-publish.local** mappar till localhost via `/etc/hosts`
* SimpleHTTPServer (en wrapper för [[!DNL Python]s SimpleHTTPServer](https://docs.python.org/2/library/simplehttpserver.html)) visar HTML-sidan via port 8000.
   * _Finns inte längre i Mac App Store. Använd liknande [Jeeves](https://apps.apple.com/us/app/jeeves-local-http-server/id980824182?mt=12)._
* [!DNL AEM Dispatcher] körs på [!DNL Apache HTTP Web Server] 2.4 och begäran om omvänd proxering till `aem-publish.local` till `localhost:4503`.

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

### Tillåt CORS-begäranderubriker

Om du vill tillåta de begärda [HTTP-begäranrubrikerna att gå igenom till AEM för bearbetning](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#specifying-the-http-headers-to-pass-through-clientheaders) måste de tillåtas i Dispatcher-konfigurationen `/clientheaders`.

```
/clientheaders {
   ...
   "Origin"
   "Access-Control-Request-Method"
   "Access-Control-Request-Headers"
}
```

### Cachelagra CORS-svarshuvuden

Om du vill tillåta cachelagring och visning av CORS-huvuden i cachelagrat innehåll lägger du till följande [/cache /headers-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#caching-http-response-headers) i AEM Publish `dispatcher.any`-filen.

```
/publishfarm {
    ...
    /cache {
        ...
        # CORS HTTP response headers
        # https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS#the_http_response_headers
        /headers {
            ...
            "Access-Control-Allow-Origin"
            "Access-Control-Expose-Headers"
            "Access-Control-Max-Age"
            "Access-Control-Allow-Credentials"
            "Access-Control-Allow-Methods"
            "Access-Control-Allow-Headers"
        }
    ...
    }
...
}
```

**Starta om webbserverprogrammet** när du har gjort ändringar i filen `dispatcher.any`.

Det är troligt att cache-minnet måste rensas helt för att huvuden ska kunna cachas korrekt på nästa begäran efter en `/cache /headers`-konfigurationsuppdatering.

## Stödmaterial {#supporting-materials}

* [Jeeves for macOS](https://apps.apple.com/us/app/jeeves-local-http-server/id980824182?mt=12)
* [Python SimpleHTTPServer](https://docs.python.o:qrg/2/library/simplehttpserver.html) (Windows/macOS/Linux-kompatibel)

* [Understanding Cross-Origin Resource Sharing (CORS) in AEM](./understand-cross-origin-resource-sharing.md)
* [Resursdelning mellan ursprung (W3C)](https://www.w3.org/TR/cors/)
* [HTTP-åtkomstkontroll (Mozilla MDN)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
