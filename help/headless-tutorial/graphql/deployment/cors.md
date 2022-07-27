---
title: CORS-konfiguration för AEM GraphQL
description: Lär dig hur du konfigurerar korsdomänsresursdelning (CORS) för användning med AEM GraphQL.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
kt: 10587
thumbnail: KT-10587.jpg
mini-toc-levels: 2
source-git-commit: 56831a30a442388e34d8388546787ed22e7577f5
workflow-type: tm+mt
source-wordcount: '362'
ht-degree: 0%

---


# Cross-origin resource sharing (CORS)

Adobe Experience Manager as a Cloud Service Cross-Origin Resource Sharing (CORS) underlättar för icke-AEM webbegenskaper att göra webbläsarbaserade klientanrop AEM GraphQL API:er.

>[!TIP]
>
> Följande konfigurationer är exempel. Se till att du justerar dem så att de passar projektets krav.



## CORS-krav

CORS krävs för webbläsarbaserade anslutningar till AEM GraphQL API:er när klienten som ansluter till AEM INTE betjänas från samma ursprung (kallas även värd eller domän) som AEM.

| Klienttyp | Single-page app (SPA) | Webbkomponent/JS | Mobil | Server till server |
|----------------------------:|:---------------------:|:-------------:|:---------:|:----------------:|
| Kräver CORS-konfiguration | ✔ | ✔ | ✘ | ✘ |

## OSGi-konfiguration

Konfigurationsfabriken AEM CORS OSGi definierar villkoren för att tillåta CORS HTTP-begäranden.

| Klienten ansluter till | AEM Author | AEM Publish | AEM |
|-------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver CORS OSGi-konfiguration | ✔ | ✔ | ✔ |


I exemplet nedan definieras en OSGi-konfiguration för AEM Publish (`../config.publish/..`), men kan läggas till i [alla runmode-mappar som stöds](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html#runmode-resolution).

Nyckelkonfigurationsegenskaperna är:

+ `alloworigin` och/eller `alloworiginregexp` Anger ursprung som klienten som ansluter till AEM körs på.
+ `allowedpaths` Anger URL-sökvägsmönster som tillåts från angivna ursprung. Använd följande mönster om du vill ha stöd AEM beständiga GraphQL-frågor: `"/graphql/execute.json.*"`
+ `supportedmethods` Anger tillåtna HTTP-metoder för CORS-begäranden. Lägg till `GET`, för att ge stöd AEM GraphQL-beständiga frågor.

[Läs mer om CORS OSGi-konfigurationen.](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/security/understand-cross-origin-resource-sharing.html)


Det här exemplet har stöd för användning av beständiga AEM GraphQL-frågor. Om du vill använda klientdefinierade GraphQL-frågor lägger du till en GraphQL-slutpunkts-URL i `allowedpaths` och `POST` till `supportedmethods`.

+ `/ui.config/src/main/content/jcr_root/apps/wknd-examples/osgiconfig/config.publish/com.adobe.granite.cors.impl.CORSPolicyImpl~graphql.cfg.json`

```json
{
  "alloworigin":[
    "https://spa.external.com/"
  ],
  "alloworiginregexp":[
    "http://localhost:.*"
  ],
  "allowedpaths": [
    "/graphql/execute.json.*"
  ],
  "supportedheaders": [
    "Origin",
    "Accept",
    "X-Requested-With",
    "Content-Type",
    "Access-Control-Request-Method",
    "Access-Control-Request-Headers"
  ],
  "supportedmethods":[
    "GET",
    "HEAD"
  ],
  "maxage:Integer": 1800,
  "supportscredentials": false,
  "exposedheaders":[ "" ]
}
```


## Dispatcher-konfiguration

AEM Publish (och Preview)-tjänstens Dispatcher måste vara konfigurerad för CORS.

| Klienten ansluter till | AEM Author | AEM Publish | AEM |
|-------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver konfiguration av Dispatcher CORS | ✘ | ✔ | ✔ |

### Tillåt CORS-huvuden på HTTP-begäranden

Uppdatera `clientheaders.any` fil som tillåter rubriker för HTTP-begäran `Origin`,  `Access-Control-Request-Method` och `Access-Control-Request-Headers` skickas till AEM, vilket tillåter att HTTP-begäran bearbetas av [AEM CORS-konfiguration](#osgi-configuration).

`dispatcher/src/conf.dispatcher.d/clientheaders/clientheaders.any`

```
# Allowing CORS headers to be passed through to the publish tier to support headless and SPA Editor use cases.
# https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS#the_http_request_headers

"Origin"
"Access-Control-Request-Method"
"Access-Control-Request-Headers"

$include "./default_clientheaders.any"
```

### Leverera CORS HTTP-svarshuvuden

Konfigurera avsändarservergrupp att cachelagra **CORS HTTP-svarshuvuden** för att säkerställa att de inkluderas när AEM beständiga GraphQL-frågor hanteras från Dispatcher-cachen genom att lägga till `Access-Control-...` rubriker i cacherubriklistan.

+ `dispatcher/src/conf.dispatcher.d/available_farms/wknd.farm`

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
