---
title: Cross-Origin Resource Sharing (CORS) med AEM
description: Adobe Experience Manager Cross-Origin Resource Sharing (CORS) underlättar för icke-AEM webbegenskaper att anropa AEM på klientsidan, både autentiserad och oautentiserad, för att hämta innehåll eller interagera direkt med AEM.
version: 6.4, 6.5
sub-product: Experience Manager, Experience Manager Sites
topics: security, development, content-delivery
activity: understand
audience: architect, developer
doc-type: article
topic: Security
role: Developer
level: Intermediate
exl-id: 6009d9cf-8aeb-4092-9e8c-e2e6eec46435
source-git-commit: 2bd1b66dc28a6e591afda746e9d276cae7a29948
workflow-type: tm+mt
source-wordcount: '896'
ht-degree: 0%

---

# Förstå resursdelning mellan ursprung ([!DNL CORS])

Adobe Experience Manager Cross-Origin Resource Sharing ([!DNL CORS]) underlättar för icke-AEM webbegenskaper att ringa anrop på klientsidan till AEM, både autentiserad och oautentiserad, för att hämta innehåll eller direkt interagera med AEM.

## Adobe Granite Cross-Origin Resource Sharing Policy OSGi configuration

CORS-konfigurationer hanteras som OSGi-konfigurationsfabriker i AEM, där varje princip representeras som en instans av fabriken.

* `http://<host>:<port>/system/console/configMgr > Adobe Granite Cross Origin Resource Sharing Policy`

![Adobe Granite Cross-Origin Resource Sharing Policy OSGi configuration](./assets/understand-cross-origin-resource-sharing/cors-osgi-config.png)

[!DNL Adobe Granite Cross-Origin Resource Sharing Policy] (`com.adobe.granite.cors.impl.CORSPolicyImpl`)

### Val av policy

En profil väljs genom att jämföra

* `Allowed Origin` med `Origin` begärandehuvud
* och `Allowed Paths` med sökvägen till begäran.

Den första principen som matchar dessa värden används. Om inga hittas, [!DNL CORS] begäran nekas.

Om ingen princip har konfigurerats alls [!DNL CORS] förfrågningar kommer inte heller att besvaras eftersom hanteraren är inaktiverad och därmed nekas - så länge ingen annan modul på servern svarar på [!DNL CORS].

### Principegenskaper

#### [!UICONTROL Allowed Origins]

* `"alloworigin" <origin> | *`
* Lista över `origin` parametrar som anger URI:er som kan komma åt resursen. För begäranden utan autentiseringsuppgifter kan servern ange &#42; som jokertecken, vilket ger alla ursprung åtkomst till resursen. *Vi rekommenderar absolut inte att du använder `Allow-Origin: *` i produktion eftersom alla externa (dvs. angripare) webbplatser kan göra förfrågningar som inte har CORS är strängt förbjudna av webbläsare.*

#### [!UICONTROL Allowed Origins (Regexp)]

* `"alloworiginregexp" <regexp>`
* Lista över `regexp` reguljära uttryck som anger URI:er som kan komma åt resursen. *Reguljära uttryck kan leda till oönskade matchningar om de inte byggs noggrant, vilket gör att en angripare kan använda ett anpassat domännamn som också matchar profilen.* Vi rekommenderar att du har olika principer för varje specifikt ursprungligt värdnamn, med `alloworigin`även om det innebär upprepad konfiguration av de andra principegenskaperna. Olika ursprung tenderar att ha olika livscykler och krav, vilket medför en klar separation.

#### [!UICONTROL Allowed Paths]

* `"allowedpaths" <regexp>`
* Lista över `regexp` reguljära uttryck som anger resurssökvägar som principen gäller för.

#### [!UICONTROL Exposed Headers]

* `"exposedheaders" <header>`
* Lista med rubrikparametrar som anger begäranderubriker som webbläsare har åtkomst till.

#### [!UICONTROL Maximum Age]

* `"maxage" <seconds>`
* A `seconds` parameter som anger hur länge resultatet av en preflight-förfrågan kan cachas.

#### [!UICONTROL Supported Headers]

* `"supportedheaders" <header>`
* Lista över `header` parametrar som anger vilka HTTP-huvuden som kan användas när den faktiska begäran görs.

#### [!UICONTROL Allowed Methods]

* `"supportedmethods"`
* Lista med metodparametrar som anger vilka HTTP-metoder som kan användas när den faktiska begäran görs.

#### [!UICONTROL Supports Credentials]

* `"supportscredentials" <boolean>`
* A `boolean` ange om svaret på begäran kan visas för webbläsaren eller inte. När det används som en del av ett svar på en begäran före flygning, anger detta om den faktiska begäran kan göras med hjälp av autentiseringsuppgifter.

### Exempelkonfigurationer

Webbplats 1 är ett grundläggande, anonym, skrivskyddat scenario där innehåll konsumeras via [!DNL GET] begäranden:

```json
{
  "supportscredentials":false,
  "exposedheaders":[
    ""
  ],
  "supportedmethods":[
    "GET",
    "HEAD",
    "OPTIONS"
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
    "Access-Control-Request-Headers",
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
    "OPTIONS",
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

## Dispatcher cacheminnesproblem och konfiguration {#dispatcher-caching-concerns-and-configuration}

Från och med Dispatcher 4.1.1+ kan svarshuvuden cachelagras. Detta gör det möjligt att cachelagra [!DNL CORS] rubriker längs med [!DNL CORS]-begärda resurser, förutsatt att begäran är anonym.

I allmänhet kan samma överväganden för att cachelagra innehåll vid Dispatcher användas för att cachelagra CORS-svarshuvuden vid dispatcher. Följande tabell definierar när [!DNL CORS] rubriker (och därmed [!DNL CORS] begäranden) kan cachas.

| Cacheable | Miljö | Autentiseringsstatus | Förklaring |
|-----------|-------------|-----------------------|-------------|
| Nej | AEM Publish | Autentiserad | Cachelagring av Dispatcher på AEM Author är begränsad till statiska, icke-författade resurser. Detta gör det svårt och opraktiskt att cachelagra de flesta resurser på AEM Author, inklusive HTTP-svarshuvuden. |
| Nej | AEM Publish | Autentiserad | Undvik cachelagring av CORS-huvuden vid autentiserade begäranden. Detta anpassas till den vanliga vägledningen om att inte cachelagra autentiserade begäranden, eftersom det är svårt att avgöra hur autentiserings-/auktoriseringsstatusen för den begärande användaren kommer att påverka den levererade resursen. |
| Ja | AEM Publish | Anonym | Anonyma förfrågningar som kan cache-lagras hos dispatchern kan även ha sina svarshuvuden cachelagrade, vilket garanterar att framtida CORS-förfrågningar kan komma åt det cachelagrade innehållet. Alla ändringar i CORS-konfigurationen för AEM Publish **måste** följas av en ogiltigförklaring av de cachelagrade resurser som påverkas. De bästa sätten är att styra koddistributioner och konfigurationsdistributioner eftersom det är svårt att avgöra vilket cachelagrat innehåll som kan utföras. |

Om du vill tillåta cachelagring av CORS-huvuden lägger du till följande konfiguration i alla AEM Publish Dispatcher.alla filer som stöds.

```
/myfarm { 
  ...
  /headers {
      "Origin"
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

Kom ihåg **starta om webbserverprogrammet** efter att ha ändrat `dispatcher.any` -fil.

Det är troligt att cache-minnet behöver rensas helt för att säkerställa att rubrikerna cachas korrekt på nästa begäran efter en `/cache/headers` konfigurationsuppdatering.

## Felsökning av CORS

Loggning finns under `com.adobe.granite.cors`:

* enable `DEBUG` om du vill veta mer om varför [!DNL CORS] begäran nekades
* enable `TRACE` för att se information om alla förfrågningar som går genom CORS-hanteraren

### Tips:

* Återskapa XHR-förfrågningar manuellt med hjälp av curl, men se till att kopiera alla sidhuvuden och all information, eftersom var och en kan göra skillnad. vissa webbläsarkonsoler tillåter kopiering av rullningskommandot
* Verifiera om begäran nekades av CORS-hanteraren och inte av autentiseringen, CSRF-tokenfilter, dispatcherfilter eller andra säkerhetslager
   * Om CORS-hanteraren svarar med 200, men `Access-Control-Allow-Origin` ingen rubrik finns på svaret. Granska loggarna för nekanden under [!DNL DEBUG] in `com.adobe.granite.cors`
* Om dispatcher cachelagrar [!DNL CORS] begäran är aktiverad
   * Se till att `/cache/headers` konfiguration tillämpas på `dispatcher.any` och webbservern har startats om
   * Kontrollera att cachen rensades korrekt efter ändringar i OSGi eller dispatcher.konfigurationer.
* vid behov kontrollera om det finns autentiseringsuppgifter för begäran.

## Stödmaterial

* [AEM OSGi Configuration factory for Cross-Origin Resource Sharing Policies](http://localhost:4502/system/console/configMgr/com.adobe.granite.cors.impl.CORSPolicyImpl)
* [Resursdelning mellan ursprung (W3C)](https://www.w3.org/TR/cors/)
* [HTTP-åtkomstkontroll (Mozilla MDN)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
