---
title: CORS-konfiguration för AEM GraphQL
description: Lär dig hur du konfigurerar Cross-origin-resursdelning (CORS) för användning med AEM GraphQL.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10830
thumbnail: KT-10830.jpg
exl-id: 394792e4-59c8-43c1-914e-a92cdfde2f8a
last-substantial-update: 2023-08-08T00:00:00Z
source-git-commit: 30d6120ec99f7a95414dbc31c0cb002152bd6763
workflow-type: tm+mt
source-wordcount: '627'
ht-degree: 0%

---

# Cross-origin resource sharing (CORS)

Adobe Experience Manager as a Cloud Service Cross-Origin Resource Sharing (CORS) underlättar för icke-AEM webbegenskaper att göra webbläsarbaserade klientanrop till GraphQL API:er och andra AEM Headless-resurser.

>[!TIP]
>
> Följande konfigurationer är exempel. Se till att du justerar dem så att de passar projektets krav.

## CORS-krav

CORS krävs för webbläsarbaserade anslutningar till AEM GraphQL API:er när klienten som ansluter till AEM INTE betjänas från samma ursprung (kallas även värd eller domän) som AEM.

| Klienttyp | [Single-page app (SPA)](../spa.md) | [Webbkomponent/JS](../web-component.md) | [Mobil](../mobile.md) | [Server-till-server](../server-to-server.md) |
|----------------------------:|:---------------------:|:-------------:|:---------:|:----------------:|
| Kräver CORS-konfiguration | ✔ | ✔ | ✘ | ✘ |

## AEM

Att aktivera CORS på AEM Author-tjänsten skiljer sig från AEM Publish and AEM Preview-tjänster. AEM Author-tjänsten kräver att en OSGi-konfiguration läggs till i AEM Author-tjänstens körlägesmapp och använder inte en Dispatcher-konfiguration.

### OSGi-konfiguration

Konfigurationsfabriken AEM CORS OSGi definierar villkoren för att tillåta CORS HTTP-begäranden.

| Klienten ansluter till | AEM | AEM Publish | AEM |
|-------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver CORS OSGi-konfiguration | ✔ | ✘ | ✘ |


I exemplet nedan definieras en OSGi-konfiguration för AEM författare (`../config.author/..`) så att det bara är aktivt på AEM Author-tjänsten.

Nyckelkonfigurationsegenskaperna är:

+ `alloworigin` och/eller `alloworiginregexp` anger vilka ursprung klienten som ansluter till AEM körs på.
+ `allowedpaths` Anger URL-sökvägsmönster som tillåts från angivna ursprung.
   + Lägg till följande mönster om du vill ha stöd AEM GraphQL beständiga frågor: `/graphql/execute.json.*`
   + Lägg till följande mönster om du vill ha stöd för Experience Fragments: `/content/experience-fragments/.*`
+ `supportedmethods` Anger tillåtna HTTP-metoder för CORS-begäranden. Om du vill ha stöd AEM GraphQL beständiga frågor (och Experience Fragments) lägger du till `GET` .
+ `supportedheaders` inkluderar `"Authorization"` som en begäran till AEM författare ska godkännas.
+ `supportscredentials` är inställd på `true` som begäran till AEM författare ska godkännas.

[Läs mer om CORS OSGi-konfigurationen.](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/security/understand-cross-origin-resource-sharing.html)

Följande exempel stöder användning av AEM GraphQL beständiga frågor på AEM författare. Om du vill använda klientdefinierade GraphQL-frågor lägger du till en GraphQL-slutpunkts-URL i `allowedpaths` och `POST` till `supportedmethods`.

+ `/ui.config/src/main/content/jcr_root/apps/wknd-examples/osgiconfig/config.author/com.adobe.granite.cors.impl.CORSPolicyImpl~graphql.cfg.json`

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
    "Access-Control-Request-Headers",
    "Authorization"
  ],
  "supportedmethods":[
    "GET",
    "HEAD",
    "POST"
  ],
  "maxage:Integer": 1800,
  "supportscredentials": true,
  "exposedheaders":[ "" ]
}
```

#### Exempel på OSGi-konfiguration

+ [Ett exempel på OSGi-konfigurationen finns i WKND-projektet.](https://github.com/adobe/aem-guides-wknd/blob/main/ui.config/src/main/content/jcr_root/apps/wknd/osgiconfig/config.author/com.adobe.granite.cors.impl.CORSPolicyImpl~wknd-graphql.cfg.json)

## AEM Publish

Att aktivera CORS för AEM publicerings- (och förhandsgranskningstjänster) skiljer sig från AEM författartjänst. AEM Publish-tjänsten kräver att en AEM Dispatcher-konfiguration läggs till i AEM Publish Dispatcher-konfiguration. AEM Publish använder inte en [OSGi-konfiguration](#osgi-configuration).

Kontrollera följande när du konfigurerar CORS vid AEM publicering:

+ The `Origin` HTTP-begärandehuvudet kan inte skickas till AEM Publish-tjänsten genom att ta bort `Origin` rubrik (om den lagts till tidigare) från AEM Dispatcher-projektets `clientheaders.any` -fil. Alla `Access-Control-` sidhuvuden bör tas bort från `clientheaders.any` fil och Dispatcher hanterar dem, inte AEM Publiceringstjänst.
+ Om du har [CORS OSGi-konfigurationer](#osgi-configuration) som är aktiverat i AEM Publish-tjänsten måste du ta bort dem och migrera deras konfigurationer till [Dispatcher-värdkonfiguration](#set-cors-headers-in-vhost) enligt nedan.

### Dispatcher-konfiguration

AEM Publish (och Preview)-tjänstens Dispatcher måste vara konfigurerad för CORS.

| Klienten ansluter till | AEM | AEM Publish | AEM |
|-------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver konfiguration av Dispatcher CORS | ✘ | ✔ | ✔ |

#### Ange CORS-huvuden i värden

1. Öppna värdkonfigurationsfilen för AEM Publish-tjänsten i Dispatcher-konfigurationsprojektet, vanligtvis på `dispatcher/src/conf.d/available_vhosts/<example>.vhost`
2. Kopiera innehållet i `<IfDefine ENABLE_CORS>...</IfDefine>` nedan i den aktiverade värdkonfigurationsfilen.

   ```{ highlight="17"}
   <VirtualHost *:80>
     ...
     <IfModule mod_headers.c>
         ################## Start of CORS configuration ##################
   
         SetEnvIfExpr "req_novary('Origin') == ''" CORSType=none CORSProcessing=false
         SetEnvIfExpr "req_novary('Origin') != ''" CORSType=cors CORSProcessing=true CORSTrusted=false
   
         SetEnvIfExpr "req_novary('Access-Control-Request-Method') == '' && %{REQUEST_METHOD} == 'OPTIONS' && req_novary('Origin') != ''" CORSType=invalidpreflight CORSProcessing=false
         SetEnvIfExpr "req_novary('Access-Control-Request-Method') != '' && %{REQUEST_METHOD} == 'OPTIONS' && req_novary('Origin') != ''" CORSType=preflight CORSProcessing=true CORSTrusted=false
         SetEnvIfExpr "req_novary('Origin') -strcmatch '%{REQUEST_SCHEME}://%{HTTP_HOST}*'" CORSType=samedomain CORSProcessing=false
   
         # For requests that require CORS processing, check if the Origin can be trusted
         SetEnvIfExpr "%{HTTP_HOST} =~ /(.*)/ " ParsedHost=$1
   
         ################## Adapt regex to match CORS origin(s) for your environment
         SetEnvIfExpr "env('CORSProcessing') == 'true' && req_novary('Origin') =~ m#(https://.*\.your-domain\.tld(:\d+)?$)#" CORSTrusted=true
   
         # Extract the Origin header
         SetEnvIfNoCase ^Origin$ ^(.*)$ CORSTrustedOrigin=$1
   
         # Flush If already set
         Header unset Access-Control-Allow-Origin
         Header unset Access-Control-Allow-Credentials
   
         # Trusted
         Header always set Access-Control-Allow-Credentials "true" "expr=reqenv('CORSTrusted') == 'true'"
         Header always set Access-Control-Allow-Origin "%{CORSTrustedOrigin}e" "expr=reqenv('CORSTrusted') == 'true'"
         Header always set Access-Control-Allow-Methods "GET" "expr=reqenv('CORSTrusted') == 'true'"
         Header always set Access-Control-Max-Age 1800 "expr=reqenv('CORSTrusted') == 'true'"
         Header always set Access-Control-Allow-Headers "Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers" "expr=reqenv('CORSTrusted') == 'true'"
   
         # Non-CORS or Not Trusted
         Header unset Access-Control-Allow-Credentials "expr=reqenv('CORSProcessing') == 'false' || reqenv('CORSTrusted') == 'false'"
         Header unset Access-Control-Allow-Origin "expr=reqenv('CORSProcessing') == 'false' || reqenv('CORSTrusted') == 'false'"
         Header unset Access-Control-Allow-Methods "expr=reqenv('CORSProcessing') == 'false' || reqenv('CORSTrusted') == 'false'"
         Header unset Access-Control-Max-Age "expr=reqenv('CORSProcessing') == 'false' || reqenv('CORSTrusted') == 'false'"
   
         # Always vary on origin, even if its not there.
         Header merge Vary Origin
   
         # CORS - send 204 for CORS requests which are not trusted
         RewriteCond expr "reqenv('CORSProcessing') == 'true' && reqenv('CORSTrusted') == 'false'"
         RewriteRule "^(.*)" - [R=204,L]
   
         # Remove Origin before sending to AEM Publish if this configuration handles the CORS
         RequestHeader unset Origin "expr=reqenv('CORSTrusted') == 'true'"
   
         ################## End of CORS configuration ##################
     </IfModule>
     ...
   </VirtualHost>
   ```

3. Matcha önskade original-användare som har åtkomst till tjänsten AEM Publish genom att uppdatera det reguljära uttrycket på raden nedan. Om du behöver ha flera ursprung duplicerar du den här raden och uppdaterar för varje ursprungs-/ursprungsmönster.

   ```
   SetEnvIfExpr "env('CORSProcessing') == 'true' && req_novary('Origin') =~ m#(https://.*.your-domain.tld(:\d+)?$)#" CORSTrusted=true
   ```

   + Om du till exempel vill aktivera CORS-åtkomst från originalen:

      + Alla underdomäner på `https://example.com`
      + Alla portar på `http://localhost`

     Ersätt raden med följande två rader:

     ```
     SetEnvIfExpr "env('CORSProcessing') == 'true' && req_novary('Origin') =~ m#(https://.*\.example\.com$)#" CORSTrusted=true
     SetEnvIfExpr "env('CORSProcessing') == 'true' && req_novary('Origin') =~ m#(http://localhost(:\d+)?$)#" CORSTrusted=true
     ```

#### Exempel på Dispatcher-konfiguration

+ [Ett exempel på Dispatcher-konfigurationen finns i WKND-projektet.](https://github.com/adobe/aem-guides-wknd/blob/main/dispatcher/src/conf.d/available_vhosts/wknd.vhost)
