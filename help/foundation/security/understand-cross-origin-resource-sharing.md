---
title: Cross-Origin Resource Sharing (CORS) med AEM
description: Adobe Experience Manager Cross-Origin Resource Sharing (CORS) underlättar för icke-AEM webbegenskaper att anropa AEM på klientsidan, både autentiserad och oautentiserad, för att hämta innehåll eller interagera direkt med AEM.
version: 6.3, 6,4, 6.5
sub-product: grund, innehållstjänster, webbplatser
feature: null
topics: security, development, content-delivery
activity: understand
audience: architect, developer
doc-type: article
translation-type: tm+mt
source-git-commit: ecbd4d21c5f41b2bc6db3b409767b767f00cc5d1
workflow-type: tm+mt
source-wordcount: '900'
ht-degree: 0%

---


# Förstå resursdelning mellan ursprung ([!DNL CORS])

Adobe Experience Manager Cross-Origin Resource Sharing ([!DNL CORS]) underlättar för icke-AEM webbegenskaper att anropa AEM på klientsidan, både autentiserad och oautentiserad, för att hämta innehåll eller direkt interagera med AEM.

## Adobe Granite Cross-Origin Resource Sharing Policy OSGi configuration

CORS-konfigurationer hanteras som OSGi-konfigurationsfabriker i AEM, där varje princip representeras som en instans av fabriken.

* `http://<host>:<port>/system/console/configMgr > Adobe Granite Cross Origin Resource Sharing Policy`

![Adobe Granite Cross-Origin Resource Sharing Policy OSGi configuration](./assets/understand-cross-origin-resource-sharing/cors-osgi-config.png)

[!DNL Adobe Granite Cross-Origin Resource Sharing Policy] (`com.adobe.granite.cors.impl.CORSPolicyImpl`)

### Val av policy

En profil väljs genom att jämföra

* `Allowed Origin` med `Origin` begärandehuvudet
* och `Allowed Paths` med sökvägen till begäran.

Den första principen som matchar dessa värden används. Om ingen hittas kommer alla [!DNL CORS] förfrågningar att nekas.

Om ingen princip är konfigurerad alls besvaras inte heller förfrågningar eftersom hanteraren inaktiveras och därmed nekas effektivt - så länge ingen annan modul på servern svarar på [!DNL CORS] [!DNL CORS].

### Principegenskaper

#### [!UICONTROL Allowed Origins]

* `"alloworigin" <origin> | *`
* Lista med `origin` parametrar som anger URI:er som kan komma åt resursen. För begäranden utan autentiseringsuppgifter kan servern ange * som jokertecken, vilket ger alla ursprung åtkomst till resursen. *Vi rekommenderar absolut inte att använda`Allow-Origin: *`i produktionen eftersom alla externa webbplatser (dvs. angripare) kan göra förfrågningar som inte har CORS är strängt förbjudna i webbläsare.*

#### [!UICONTROL Allowed Origins (Regexp)]

* `"alloworiginregexp" <regexp>`
* Lista med `regexp` reguljära uttryck som anger URI:er som kan komma åt resursen. *Reguljära uttryck kan leda till oönskade matchningar om de inte byggs noggrant, vilket gör att en angripare kan använda ett anpassat domännamn som också matchar profilen.* Det rekommenderas i allmänhet att ha separata principer för varje specifikt ursprungligt värdnamn, med `alloworigin`hjälp av, även om det innebär upprepad konfiguration av andra principegenskaper. Olika ursprung tenderar att ha olika livscykler och krav, vilket medför en klar separation.

#### [!UICONTROL Allowed Paths]

* `"allowedpaths" <regexp>`
* Lista med `regexp` reguljära uttryck som anger resurssökvägar som principen gäller för.

#### [!UICONTROL Exposed Headers]

* `"exposedheaders" <header>`
* Lista med rubrikparametrar som anger begäranderubriker som webbläsare har åtkomst till.

#### [!UICONTROL Maximum Age]

* `"maxage" <seconds>`
* En `seconds` parameter som anger hur länge resultatet av en preflight-förfrågan kan cachelagras.

#### [!UICONTROL Supported Headers]

* `"supportedheaders" <header>`
* Lista över `header` parametrar som anger vilka HTTP-huvuden som kan användas när den faktiska begäran görs.

#### [!UICONTROL Allowed Methods]

* `"supportedmethods"`
* Lista med metodparametrar som anger vilka HTTP-metoder som kan användas när den faktiska begäran görs.

#### [!UICONTROL Supports Credentials]

* `"supportscredentials" <boolean>`
* A `boolean` som anger om svaret på begäran kan visas för webbläsaren. När det används som en del av ett svar på en begäran före flygning, anger detta om den faktiska begäran kan göras med hjälp av autentiseringsuppgifter.

### Exempelkonfigurationer

Plats 1 är ett grundläggande, anonymt och skrivskyddat scenario där innehåll konsumeras via [!DNL GET] begäranden:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
    jcr:primaryType="sling:OsgiConfig"
    alloworigin="[https://site1.com]"
    alloworiginregexp="[]"
    allowedpaths="[/content/site1/.*]"
    exposedheaders="[]"
    maxage="{Long}1800"
    supportedheaders="[Origin,Accept,X-Requested-With,Content-Type,
Access-Control-Request-Method,Access-Control-Request-Headers]"
    supportedmethods="[GET]"
    supportscredentials="{Boolean}false"
/>
```

Webbplats 2 är mer komplex och kräver auktoriserade och osäkra förfrågningar:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0"
    jcr:primaryType="sling:OsgiConfig"
    alloworigin="[https://site2.com]"
    alloworiginregexp="[]"
    allowedpaths="[/content/site2/.*,/libs/granite/csrf/token.json]"
    exposedheaders="[]"
    maxage="{Long}1800"
    supportedheaders="[Origin,Accept,X-Requested-With,Content-Type,
Access-Control-Request-Method,Access-Control-Request-Headers,Authorization,CSRF-Token]"
    supportedmethods="[GET,HEAD,POST,DELETE,OPTIONS,PUT]"
    supportscredentials="{Boolean}true"
/>
```

## Dispatcher cacheminnesproblem och konfiguration {#dispatcher-caching-concerns-and-configuration}

Från och med Dispatcher 4.1.1+ kan svarshuvuden cachelagras. Detta gör det möjligt att cachelagra [!DNL CORS] rubriker längs med de [!DNL CORS]begärda resurserna, så länge som begäran är anonym.

I allmänhet kan samma överväganden för att cachelagra innehåll vid Dispatcher användas för att cachelagra CORS-svarshuvuden vid dispatcher. I följande tabell definieras när [!DNL CORS] sidhuvuden (och därmed [!DNL CORS] begäranden) kan cachas.

| Cacheable | Miljö | Autentiseringsstatus | Förklaring |
|-----------|-------------|-----------------------|-------------|
| Nej | AEM Publish | Autentiserad | Cachelagring av Dispatcher på AEM Author är begränsad till statiska, icke-författade resurser. Detta gör det svårt och opraktiskt att cachelagra de flesta resurser på AEM Author, inklusive HTTP-svarshuvuden. |
| Nej | AEM Publish | Autentiserad | Undvik cachelagring av CORS-huvuden vid autentiserade begäranden. Detta anpassas till den vanliga vägledningen om att inte cachelagra autentiserade begäranden, eftersom det är svårt att avgöra hur autentiserings-/auktoriseringsstatusen för den begärande användaren kommer att påverka den levererade resursen. |
| Ja | AEM Publish | Anonym | Anonyma förfrågningar som kan cache-lagras hos dispatchern kan även ha sina svarshuvuden cachelagrade, vilket garanterar att framtida CORS-förfrågningar kan komma åt det cachelagrade innehållet. Alla ändringar i CORS-konfigurationen för AEM Publish **måste** följas av en ogiltigförklaring av de cachelagrade resurserna som påverkas. De bästa sätten är att styra koddistributioner och konfigurationsdistributioner eftersom det är svårt att avgöra vilket cachelagrat innehåll som kan utföras. |

Om du vill tillåta cachelagring av CORS-huvuden lägger du till följande konfiguration i alla AEM Publish Dispatcher.alla filer som stöds.

```
/cache { 
  ...
  /headers {
      "Access-Control-Allow-Origin",
      "Access-Control-Expose-Headers",
      "Access-Control-Max-Age",
      "Access-Control-Allow-Credentials",
      "Access-Control-Allow-Methods",
      "Access-Control-Allow-Headers"
  }
  ...
}
```

Kom ihåg att **starta om webbserverprogrammet** när du har gjort ändringar i `dispatcher.any` filen.

Det är troligt att cacheminnet behöver rensas helt för att säkerställa att rubrikerna cachelagras korrekt på nästa begäran efter en `/headers` konfigurationsuppdatering.

## Felsökning av CORS

Loggning finns under `com.adobe.granite.cors`:

* aktivera `DEBUG` för att se information om varför en [!DNL CORS] begäran nekades
* gör det möjligt `TRACE` att se information om alla förfrågningar som går genom CORS-hanteraren

### Tips:

* Återskapa XHR-förfrågningar manuellt med hjälp av curl, men se till att kopiera alla sidhuvuden och all information, eftersom var och en kan göra skillnad. vissa webbläsarkonsoler tillåter kopiering av rullningskommandot
* Verifiera om begäran nekades av CORS-hanteraren och inte av autentiseringen, CSRF-tokenfilter, dispatcherfilter eller andra säkerhetslager
   * Om CORS-hanteraren svarar med 200, men det inte finns någon rubrik i svaret, kan du kontrollera om loggarna innehåller nekanden `Access-Control-Allow-Origin` [!DNL DEBUG] i `com.adobe.granite.cors`
* Om Dispatcher-cachelagring av [!DNL CORS] begäranden är aktiverat
   * Kontrollera att `/headers` konfigurationen används `dispatcher.any` och att webbservern har startats om
   * Kontrollera att cachen rensades korrekt efter ändringar i OSGi eller dispatcher.konfigurationer.
* vid behov, kontrollera om det finns autentiseringsuppgifter för begäran.

## Stödmaterial

* [AEM OSGi Configuration factory for Cross-Origin Resource Sharing Policies](http://localhost:4502/system/console/configMgr/com.adobe.granite.cors.impl.CORSPolicyImpl)
* [Resursdelning mellan ursprung (W3C)](https://www.w3.org/TR/cors/)
* [HTTP-åtkomstkontroll (Mozilla MDN)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
