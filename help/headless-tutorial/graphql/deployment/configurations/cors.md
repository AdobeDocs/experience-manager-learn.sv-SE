---
title: CORS-konfiguration för AEM GraphQL
description: Lär dig hur du konfigurerar Cross-origin-resursdelning (CORS) för användning med AEM GraphQL.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
kt: 10830
thumbnail: KT-10830.jpg
source-git-commit: cc78e59fe70686e909928e407899fcf629a651b9
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---


# Cross-origin resource sharing (CORS)

Adobe Experience Manager as a Cloud Service Cross-Origin Resource Sharing (CORS) underlättar för icke-AEM webbegenskaper att göra webbläsarbaserade klientanrop till GraphQL API:AEM.

I följande artikel beskrivs hur du konfigurerar _single-origin_ åtkomst till en viss uppsättning AEM Headless-slutpunkter via CORS. Ett ursprung innebär att endast en icke-AEM domän får åtkomst AEM, till exempel https://app.example.com som ansluter till https://www.example.com. Åtkomst från flera källor kanske inte fungerar med den här metoden på grund av problem med cachelagring.

>[!TIP]
>
> Följande konfigurationer är exempel. Se till att du justerar dem så att de passar projektets krav.

## CORS-krav

CORS krävs för webbläsarbaserade anslutningar till AEM GraphQL API:er när klienten som ansluter till AEM INTE betjänas från samma ursprung (kallas även värd eller domän) som AEM.

| Klienttyp | [Single-page app (SPA)](../spa.md) | [Webbkomponent/JS](../web-component.md) | [Mobil](../mobile.md) | [Server-till-server](../server-to-server.md) |
|----------------------------:|:---------------------:|:-------------:|:---------:|:----------------:|
| Kräver CORS-konfiguration | ✔ | ✔ | ✘ | ✘ |

## OSGi-konfiguration

Konfigurationsfabriken AEM CORS OSGi definierar villkoren för att tillåta CORS HTTP-begäranden.

| Klienten ansluter till | AEM Author | AEM Publish | AEM |
|-------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver CORS OSGi-konfiguration | ✔ | ✔ | ✔ |


I exemplet nedan definieras en OSGi-konfiguration för AEM Publish (`../config.publish/..`), men kan läggas till i [alla körningslägesmappar som stöds](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html#runmode-resolution).

Nyckelkonfigurationsegenskaperna är:

+ `alloworigin` och/eller `alloworiginregexp` anger vilka ursprung klienten som ansluter till AEM körs på.
+ `allowedpaths` Anger URL-sökvägsmönster som tillåts från angivna ursprung.
   + Lägg till följande mönster om du vill ha stöd AEM GraphQL beständiga frågor: `/graphql/execute.json.*`
   + Lägg till följande mönster om du vill ha stöd för Experience Fragments: `/content/experience-fragments/.*`
+ `supportedmethods` Anger tillåtna HTTP-metoder för CORS-begäranden. Lägg till `GET`, för att ge stöd AEM GraphQL beständiga frågor (och Experience Fragments).

[Läs mer om CORS OSGi-konfigurationen.](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/security/understand-cross-origin-resource-sharing.html)

Det här exemplet har stöd för användning av AEM beständiga GraphQL-frågor. Om du vill använda klientdefinierade GraphQL-frågor lägger du till en GraphQL-slutpunkts-URL i `allowedpaths` och `POST` till `supportedmethods`.

+ `/ui.config/src/main/content/jcr_root/apps/wknd-examples/osgiconfig/config.publish/com.adobe.granite.cors.impl.CORSPolicyImpl~graphql.cfg.json`

```json
{
  "alloworigin":[
    "https://spa.external.com/"
  ],
  "alloworiginregexp":[
  ],
  "allowedpaths": [
    "/graphql/execute.json.*",
    "/content/experience-fragments/.*"
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
    "HEAD",
    "OPTIONS"
  ],
  "maxage:Integer": 1800,
  "supportscredentials": false,
  "exposedheaders":[ "" ]
}
```

### Auktoriserade AEM GraphQL API-begäranden

När du får åtkomst till AEM GraphQL API:er som kräver auktorisering (vanligtvis AEM Author eller skyddat innehåll i AEM Publish) måste CORS OSGi-konfigurationen ha ytterligare värden:

+ `supportedheaders` även listor `"Authorization"`
+ `supportscredentials` är inställd på `true`

Auktoriserade begäranden AEM GraphQL API:er som kräver CORS-konfiguration är ovanliga, eftersom de vanligtvis sker i samband med [server-till-server-appar](../server-to-server.md) och därför inte kräva CORS-konfiguration. Webbläsarbaserade appar som kräver CORS-konfigurationer, som [enkelsidiga program](../spa.md) eller [Webbkomponenter](../web-component.md), använder vanligtvis auktorisering eftersom det är svårt att skydda inloggningsuppgifterna.

De här två inställningarna ställs in enligt följande i en `CORSPolicyImpl` OSGi-fabrikskonfiguration:

+ `/ui.config/src/main/content/jcr_root/apps/wknd-examples/osgiconfig/config/com.adobe.granite.cors.impl.CORSPolicyImpl~graphql.cfg.json`

```json
{ 
  ...
  "supportedheaders": [
    "Origin",
    "Accept",
    "X-Requested-With",
    "Content-Type",
    "Access-Control-Request-Method",
    "Access-Control-Request-Headers",
    "Authorization"
  ],
  ...
  "supportscredentials": true,
  ...
}
```

#### Exempel på OSGi-konfiguration

+ [Ett exempel på OSGi-konfigurationen finns i WKND-projektet.](https://github.com/adobe/aem-guides-wknd/blob/main/ui.config/src/main/content/jcr_root/apps/wknd/osgiconfig/config.publish/com.adobe.granite.cors.impl.CORSPolicyImpl~wknd-graphql.cfg.json)

## Dispatcher-konfiguration

AEM Publish (och Preview)-tjänstens Dispatcher måste vara konfigurerad för CORS.

| Klienten ansluter till | AEM Author | AEM Publish | AEM |
|-------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver konfiguration av Dispatcher CORS | ✘ | ✔ | ✔ |

### Tillåt CORS-huvuden på HTTP-begäranden

Uppdatera `clientheaders.any` fil som tillåter rubriker för HTTP-begäran `Origin`,  `Access-Control-Request-Method`och `Access-Control-Request-Headers` skickas till AEM, vilket tillåter att HTTP-begäran bearbetas av [AEM CORS-konfiguration](#osgi-configuration).

`dispatcher/src/conf.dispatcher.d/clientheaders/clientheaders.any`

```
# Allowing CORS headers to be passed through to the publish tier to support headless and SPA Editor use cases.
# https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS#the_http_request_headers

"Origin"
"Access-Control-Request-Method"
"Access-Control-Request-Headers"

$include "./default_clientheaders.any"
```

#### Exempel på Dispatcher-konfiguration

+ [Ett exempel på Dispatcher _klientrubriker_ konfigurationen finns i WKND-projektet.](https://github.com/adobe/aem-guides-wknd/blob/main/dispatcher/src/conf.dispatcher.d/clientheaders/clientheaders.any#L10-L12)


### Leverera CORS HTTP-svarshuvuden

Konfigurera Dispatcher-servergruppen till cacheminnet **CORS HTTP-svarshuvuden** för att säkerställa att de inkluderas när AEM GraphQL beständiga frågor hanteras från Dispatcher-cachen genom att lägga till `Access-Control-...` rubriker i cacherubriklistan.

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

#### Exempel på Dispatcher-konfiguration

+ [Ett exempel på Dispatcher _CORS HTTP-svarshuvuden_ konfigurationen finns i WKND-projektet.](https://github.com/adobe/aem-guides-wknd/blob/main/dispatcher/src/conf.dispatcher.d/available_farms/wknd.farm#L109-L114)
