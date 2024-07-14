---
title: Cross-Origin Resource Sharing (CORS) med AEM
description: Adobe Experience Manager Cross-Origin Resource Sharing (CORS) underlättar för icke-AEM webbegenskaper att anropa AEM på klientsidan, både autentiserad och oautentiserad, för att hämta innehåll eller interagera direkt med AEM.
version: 6.4, 6.5
sub-product: Experience Manager, Experience Manager Sites
feature: Security, APIs
doc-type: Article
topic: Security
role: Developer
level: Intermediate
exl-id: 6009d9cf-8aeb-4092-9e8c-e2e6eec46435
duration: 240
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '994'
ht-degree: 0%

---

# Förstå resursdelning mellan ursprung ([!DNL CORS])

Adobe Experience Manager Cross-Origin Resource Sharing ([!DNL CORS]) underlättar för icke-AEM webbegenskaper att göra anrop på klientsidan till AEM, både autentiserad och oautentiserad, för att hämta innehåll eller direkt interagera med AEM.

OSGI-konfigurationen som beskrivs i det här dokumentet räcker för att:

1. Resursdelning från en källa på AEM Publish
2. CORS åtkomst till AEM Author

Om CORS-åtkomst med flera ursprung krävs på AEM Publish, se [den här dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/deployments/configurations/cors.html?lang=en#dispatcher-configuration).

## Adobe Granite Cross-Origin Resource Sharing Policy OSGi configuration

CORS-konfigurationer hanteras som OSGi-konfigurationsfabriker i AEM, där varje princip representeras som en instans av fabriken.

* `http://<host>:<port>/system/console/configMgr > Adobe Granite Cross Origin Resource Sharing Policy`

![Adobe Granite Cross-Origin Resource Sharing Policy OSGi configuration](./assets/understand-cross-origin-resource-sharing/cors-osgi-config.png)

[!DNL Adobe Granite Cross-Origin Resource Sharing Policy] (`com.adobe.granite.cors.impl.CORSPolicyImpl`)

### Val av policy

En profil väljs genom att jämföra

* `Allowed Origin` med begärandehuvudet `Origin`
* och `Allowed Paths` med begärandesökvägen.

Den första principen som matchar dessa värden används. Om ingen hittas nekas alla [!DNL CORS]-begäranden.

Om ingen princip är konfigurerad alls besvaras inte heller [!DNL CORS]-begäranden eftersom hanteraren är inaktiverad och därmed nekas - så länge ingen annan modul på servern svarar på [!DNL CORS].

### Principegenskaper

#### [!UICONTROL Allowed Origins]

* `"alloworigin" <origin> | *`
* Lista med `origin` parametrar som anger URI:er som kan komma åt resursen. För begäranden utan autentiseringsuppgifter kan servern ange &#42; som jokertecken, vilket ger alla ursprung åtkomst till resursen. *Du bör inte använda `Allow-Origin: *` i produktionen eftersom alla externa webbplatser (dvs. angripare) kan göra förfrågningar som inte har CORS är strängt förbjudna i webbläsare.*

#### [!UICONTROL Allowed Origins (Regexp)]

* `"alloworiginregexp" <regexp>`
* Lista med `regexp` reguljära uttryck som anger URI:er som kan komma åt resursen. *Reguljära uttryck kan leda till oönskade matchningar om de inte byggs noggrant, vilket gör att en angripare kan använda ett anpassat domännamn som också matchar principen.* Det rekommenderas i allmänhet att ha separata principer för varje specifikt ursprungligt värdnamn, med `alloworigin`, även om det innebär upprepad konfiguration av de andra principegenskaperna. Olika ursprung tenderar att ha olika livscykler och krav, vilket medför en klar separation.

#### [!UICONTROL Allowed Paths]

* `"allowedpaths" <regexp>`
* Lista med `regexp` reguljära uttryck som anger resurssökvägar som principen gäller för.

#### [!UICONTROL Exposed Headers]

* `"exposedheaders" <header>`
* Lista med rubrikparametrar som anger vilka svarshuvuden som webbläsare har åtkomst till. För CORS-begäranden (inte preflight) kopieras dessa värden till svarshuvudet `Access-Control-Expose-Headers` om de inte är tomma. Värdena i listan (rubriknamn) är sedan tillgängliga för webbläsaren. Utan dessa rubriker är de inte läsbara av webbläsaren.

#### [!UICONTROL Maximum Age]

* `"maxage" <seconds>`
* En `seconds`-parameter som anger hur länge resultatet av en preflight-begäran kan cachelagras.

#### [!UICONTROL Supported Headers]

* `"supportedheaders" <header>`
* Lista med `header` parametrar som anger vilka rubriker för HTTP-begäran som kan användas när den faktiska begäran görs.

#### [!UICONTROL Allowed Methods]

* `"supportedmethods"`
* Lista med metodparametrar som anger vilka HTTP-metoder som kan användas när den faktiska begäran görs.

#### [!UICONTROL Supports Credentials]

* `"supportscredentials" <boolean>`
* En `boolean` som anger om svaret på begäran kan visas för webbläsaren eller inte. När det används som en del av ett svar på en begäran före flygning, anger detta om den faktiska begäran kan göras med hjälp av autentiseringsuppgifter eller inte.

### Exempelkonfigurationer

Plats 1 är ett grundläggande, anonym, skrivskyddat scenario där innehåll konsumeras via [!DNL GET] begäranden:

```json
{
  "supportscredentials":false,
  "exposedheaders":[
    ""
  ],
  "supportedmethods":[
    "GET",
    "HEAD"
  ],
  "alloworigin":[
    "http://127.0.0.1:3000",
    "https://site1.com"
    
  ],
  "maxage:Integer": 1800,
  "alloworiginregexp":[
    "http://localhost:.*"
    "https://.*\.site1\.com"
  ],
  "allowedpaths":[
    "/content/_cq_graphql/site1/endpoint.json",
    "/graphql/execute.json.*",
    "/content/site1/.*"
  ],
  "supportedheaders":[
    "Origin",
    "Accept",
    "X-Requested-With",
    "Content-Type",
    "Access-Control-Request-Method",
    "Access-Control-Request-Headers"
  ]
}
```

Webbplats 2 är mer komplex och kräver godkännande och mutering (POST, PUT, DELETE):

```json
{
  "supportscredentials":true,
  "exposedheaders":[
    ""
  ],
  "supportedmethods":[
    "GET",
    "HEAD"
    "POST",
    "DELETE",
    "PUT"
  ],
  "alloworigin":[
    "http://127.0.0.1:3000",
    "https://site2.com"
    
  ],
  "maxage:Integer": 1800,
  "alloworiginregexp":[
    "http://localhost:.*"
    "https://.*\.site2\.com"
  ],
  "allowedpaths":[
    "/content/site2/.*",
    "/libs/granite/csrf/token.json",
  ],
  "supportedheaders":[
    "Origin",
    "Accept",
    "X-Requested-With",
    "Content-Type",
    "Access-Control-Request-Method",
    "Access-Control-Request-Headers",
    "Authorization",
    "CSRF-Token"
  ]
}
```

## Dispatcher cachningsproblem och konfiguration {#dispatcher-caching-concerns-and-configuration}

Från och med Dispatcher 4.1.1+ kan svarshuvuden cachelagras. Detta gör det möjligt att cachelagra [!DNL CORS] huvuden längs med de [!DNL CORS] begärda resurserna, så länge som begäran är anonym.

I allmänhet kan samma aspekter för cachelagring av innehåll i Dispatcher användas för att cachelagra CORS-svarshuvuden vid dispatcher. I följande tabell definieras när [!DNL CORS] huvuden (och därmed [!DNL CORS] förfrågningar) kan cachelagras.

| Cacheable | Miljö | Autentiseringsstatus | Förklaring |
|-----------|-------------|-----------------------|-------------|
| Nej | AEM Publish | Autentiserad | Dispatcher cachning på AEM författare är begränsad till statiskt, icke-redigerat material. Detta gör det svårt och opraktiskt att cachelagra de flesta resurser på AEM Author, inklusive HTTP-svarshuvuden. |
| Nej | AEM Publish | Autentiserad | Undvik cachelagring av CORS-huvuden vid autentiserade begäranden. Detta anpassas till den vanliga vägledningen om att inte cachelagra autentiserade begäranden, eftersom det är svårt att avgöra hur autentiserings-/auktoriseringsstatusen för den begärande användaren kommer att påverka den levererade resursen. |
| Ja | AEM Publish | Anonym | Anonyma förfrågningar som kan cache-lagras hos dispatchern kan även ha sina svarshuvuden cachelagrade, vilket garanterar att framtida CORS-förfrågningar kan komma åt det cachelagrade innehållet. Alla ändringar av CORS-konfigurationen på AEM Publish **måste** följas av en ogiltigförklaring av de cachelagrade resurserna som påverkas. De bästa sätten är att styra koddistributioner och konfigurationsdistributioner eftersom det är svårt att avgöra vilket cachelagrat innehåll som kan utföras. |

### Tillåt CORS-begäranderubriker

Om du vill tillåta att de begärda [HTTP-begäranrubrikerna skickas till AEM för bearbetning](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#specifying-the-http-headers-to-pass-through-clientheaders), måste de tillåtas i Dispatcher-konfigurationens `/clientheaders`.

```
/clientheaders {
   ...
   "Origin"
   "Access-Control-Request-Method"
   "Access-Control-Request-Headers"
}
```

### Cachelagra CORS-svarshuvuden

Om du vill tillåta cachelagring och visning av CORS-huvuden i cachelagrat innehåll lägger du till följande [/cache /headers-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#caching-http-response-headers) i den AEM Publish `dispatcher.any` -filen.

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

Kom ihåg att **starta om webbserverprogrammet** när du har gjort ändringar i filen `dispatcher.any`.

Det är troligt att cache-minnet behöver rensas helt för att säkerställa att rubrikerna cachas korrekt på nästa begäran efter en `/cache/headers`-konfigurationsuppdatering.

## Felsökning av CORS

Loggning är tillgänglig under `com.adobe.granite.cors`:

* aktivera `DEBUG` för att se information om varför en [!DNL CORS]-begäran nekades
* aktivera `TRACE` för att se information om alla begäranden som går genom CORS-hanteraren

### Tips:

* Återskapa XHR-begäranden manuellt med hjälp av bolla, men se till att kopiera alla rubriker och detaljer, eftersom var och en kan göra skillnad. I vissa webbläsarkonsoler kan kommandot bolla kopieras
* Verifiera om begäran nekades av CORS-hanteraren och inte av autentiseringen, CSRF-tokenfilter, dispatcherfilter eller andra säkerhetslager
   * Om CORS-hanteraren svarar med 200, men `Access-Control-Allow-Origin`-huvudet saknas i svaret, kan du kontrollera om loggarna innehåller nekanden under [!DNL DEBUG] i `com.adobe.granite.cors`
* Om skickarcachelagring av [!DNL CORS] begäranden är aktiverat
   * Kontrollera att konfigurationen `/cache/headers` har tillämpats på `dispatcher.any` och att webbservern har startats om
   * Kontrollera att cachen rensades korrekt efter ändringar i OSGi eller dispatcher.konfigurationer.
* vid behov, kontrollera om det finns autentiseringsuppgifter för begäran.

## Stödmaterial

* [AEM OSGi-konfigurationsfabrik för resursdelningsprinciper mellan ursprung](http://localhost:4502/system/console/configMgr/com.adobe.granite.cors.impl.CORSPolicyImpl)
* [Resursdelning mellan ursprung (W3C)](https://www.w3.org/TR/cors/)
* [HTTP-åtkomstkontroll (Mozilla MDN)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
