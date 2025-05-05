---
title: AEM Publish service caching
description: Allmän översikt över cachelagring av tjänsten AEM as a Cloud Service Publish.
version: Experience Manager as a Cloud Service
feature: Dispatcher, Developer Tools
topic: Performance
role: Architect, Developer
level: Intermediate
doc-type: Article
last-substantial-update: 2023-08-28T00:00:00Z
jira: KT-13858
thumbnail: KT-13858.jpeg
exl-id: 1a1accbe-7706-4f9b-bf63-755090d03c4c
duration: 240
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1134'
ht-degree: 0%

---

# AEM Publish

AEM Publish-tjänsten har två primära cachningslager, AEM as a Cloud Service CDN och AEM Dispatcher. En kundhanterad CDN kan också placeras framför AEM as a Cloud Service CDN. AEM as a Cloud Service CDN levererar toppmaterial och levererar upplevelser med låg latens till användare i hela världen. AEM Dispatcher tillhandahåller cachelagring direkt framför AEM Publish och används för att minska onödig belastning på själva AEM Publish.

![Översikt över cachelagring i AEM Publish](./assets/publish/publish-all.png){align="center"}

## CDN

AEM as a Cloud Service CDN:s cachelagring styrs av headers i HTTP-svarscache och är avsedd att cachelagra innehåll för att optimera balansen mellan aktualitet och prestanda. CDN ligger mellan slutanvändaren och AEM Dispatcher och används för att cachelagra innehåll så nära slutanvändaren som möjligt, vilket ger en bättre prestanda.

![AEM Publish CDN](./assets/publish/publish-cdn.png){align="center"}

Att konfigurera hur CDN cachelagrar innehåll begränsas till att ange cacherubriker för HTTP-svar. Dessa cacherubriker ställs vanligtvis in i AEM Dispatcher värdkonfigurationer med `mod_headers`, men kan även ställas in i anpassad Java™-kod som körs i AEM Publish.

### När cachelagras HTTP-begäranden/svar?

AEM as a Cloud Service CDN cachelagrar bara HTTP-svar, och alla följande kriterier måste vara uppfyllda:

+ HTTP-svarsstatusen är `2xx` eller `3xx`
+ HTTP-begärandemetoden är `GET` eller `HEAD`
+ Minst en av följande HTTP-svarsrubriker finns: `Cache-Control`, `Surrogate-Control` eller `Expires`
+ HTTP-svaret kan vara vilken innehållstyp som helst, inklusive HTML, JSON, CSS, JS och binära filer.

Som standard har HTTP-svar som inte cachelagrats av [AEM Dispatcher](#aem-dispatcher) automatiskt alla headers för HTTP-svarscache tagits bort för att undvika cachelagring vid CDN. Det här beteendet kan åsidosättas noggrant med hjälp av `mod_headers` med direktivet `Header always set ...` när det behövs.

### Vad cachelagras?

AEM as a Cloud Service CDN cachelagrar följande:

+ HTTP-svarsbrödtext
+ HTTP-svarsrubriker

Vanligtvis cachelagras en HTTP-begäran/ett HTTP-svar för en enskild URL som ett enskilt objekt. CDN kan emellertid hantera cachelagring av flera objekt för en enda URL när rubriken `Vary` anges för HTTP-svaret. Undvik att ange `Vary` för rubriker vars värden inte har en tätt kontrollerad uppsättning värden, eftersom detta kan leda till många cachemissar, vilket minskar träffkvoten för cachen. Om du vill ha stöd för cachelagring av olika begäranden på AEM Dispatcher [läser du dokumentationen för cachelagring av varianter](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/advanced/variant-caching.html?lang=sv-SE).

### Cachelagring{#cdn-cache-life}

AEM Publish CDN är TTL-baserad (time-to-live), vilket innebär att cachetiden bestäms av HTTP-svarshuvuden `Cache-Control`, `Surrogate-Control` eller `Expires`. Om rubrikerna för HTTP-svarscachning inte har angetts av projektet och [kriterierna ](#when-are-http-requestsresponses-cached) är uppfyllda, anger Adobe en standardcache på 10 minuter (600 sekunder).

Så här påverkar cacherubrikerna CDN-cachens livslängd:

+ [`Cache-Control`](https://developer.fastly.com/reference/http/http-headers/Cache-Control/) HTTP-svarshuvudet anger för webbläsaren och CDN hur länge svaret ska cachelagras. Värdet anges i sekunder. `Cache-Control: max-age=3600` instruerar till exempel webbläsaren att cachelagra svaret i en timme. Detta värde ignoreras av CDN om även HTTP-svarshuvudet `Surrogate-Control` finns.
+ [`Surrogate-Control`](https://developer.fastly.com/reference/http/http-headers/Surrogate-Control/) HTTP-svarshuvudet anger för AEM CDN hur länge svaret ska cachelagras. Värdet anges i sekunder. `Surrogate-Control: max-age=3600` instruerar till exempel CDN att cachelagra svaret i en timme.
+ [`Expires`](https://developer.fastly.com/reference/http/http-headers/Expires/) HTTP-svarshuvudet instruerar AEM CDN (och webbläsaren) hur länge det cachelagrade svaret är giltigt. Värdet är ett datum. `Expires: Sat, 16 Sept 2023 09:00:00 EST` instruerar till exempel webbläsaren att cachelagra svaret tills det angivna datumet och den angivna tiden.

Använd `Cache-Control` för att styra cachetiden när den är densamma för både webbläsaren och CDN. Använd `Surrogate-Control` när webbläsaren ska cachelagra svaret med en annan varaktighet än CDN.

#### Standardcachetid

Om ett HTTP-svar kvalificerar sig för AEM Dispatcher-cachelagring [per ovan-kvalificerare](#when-are-http-requestsresponses-cached), är följande standardvärden såvida det inte finns någon anpassad konfiguration.

| Innehållstyp | Standardcachetid för CDN |
|:------------ |:---------- |
| [HTML/JSON/XML](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#html-text) | 5 minuter |
| [Assets (bilder, videoklipp, dokument och så vidare)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#images) | 10 minuter |
| [Beständiga frågor (JSON)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?lang=sv-SE&publish-instances) | 2 timmar |
| [Klientbibliotek (JS/CSS)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#client-side-libraries) | 30 dagar |
| [Annan](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#other-content) | Inte cachelagrad |

### Anpassa cacheregler

[Konfigurationen av hur CDN cachelagrar innehåll ](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#disp) begränsas till att ange cacherubriker för HTTP-svar. Dessa cacherubriker ställs vanligtvis in i AEM Dispatcher `vhost`-konfigurationer med `mod_headers`, men kan även ställas in i anpassad Java™-kod som körs i AEM Publish.

## AEM Dispatcher

![AEM Publish AEM Dispatcher](./assets/publish/publish-dispatcher.png){align="center"}

### När cachelagras HTTP-begäranden/svar?

HTTP-svar för motsvarande HTTP-begäranden cachelagras när alla följande villkor uppfylls:

+ HTTP-begärandemetoden är `GET` eller `HEAD`
   + `HEAD` HTTP-begäranden cachelagrar bara HTTP-svarshuvuden. De har inga svarsorgan.
+ HTTP-svarsstatusen är `200`
+ HTTP-svaret är INTE för en binär fil.
+ URL-sökvägen för HTTP-begäran avslutas med ett tillägg, till exempel: `.html`, `.json`, `.css`, `.js` osv.
+ HTTP-begäran innehåller ingen behörighet och autentiseras inte av AEM.
   + Cachelagring av autentiserade begäranden [kan dock aktiveras globalt](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#caching-when-authentication-is-used) eller selektivt via [behörighetskänslig cachning](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/permissions-cache.html?lang=sv-SE).
+ HTTP-begäran innehåller inga frågeparametrar.
   + Om du konfigurerar [ignorerade frågeparametrar](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#ignoring-url-parameters) kan HTTP-begäranden med de ignorerade frågeparametrarna cachelagras/hanteras från cachen.
+ HTTP-begärans sökväg [ matchar en Tillåt-Dispatcher-regel och matchar inte en Neka-regel ](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#specifying-the-documents-to-cache).
+ HTTP-svar har inte någon av följande HTTP-svarshuvuden inställda av AEM Publish:

   + `no-cache`
   + `no-store`
   + `must-revalidate`

### Vad cachelagras?

AEM Dispatcher cachelagrar följande:

+ HTTP-svarsbrödtext
+ HTTP-svarshuvuden har angetts i Dispatcher [cacherubrikskonfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#caching-http-response-headers). Se standardkonfigurationen som levereras med [AEM Project Archetype](https://github.com/adobe/aem-project-archetype/blob/develop/src/main/archetype/dispatcher.cloud/src/conf.dispatcher.d/available_farms/default.farm#L106-L113).
   + `Cache-Control`
   + `Content-Disposition`
   + `Content-Type`
   + `Expires`
   + `Last-Modified`
   + `X-Content-Type-Options`

### Cachelagring

AEM Dispatcher cachelagrar HTTP-svar med följande metoder:

+ Till dess att ogiltigförklaringen utlöses via funktioner som publicering eller avpublicering av innehållet.
+ TTL (time-to-live) när [har konfigurerats explicit i Dispatcher-konfigurationen](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#configuring-time-based-cache-invalidation-enablettl). Se standardkonfigurationen i [AEM Project Archetype](https://github.com/adobe/aem-project-archetype/blob/develop/src/main/archetype/dispatcher.cloud/src/conf.dispatcher.d/available_farms/default.farm#L122-L127) genom att granska `enableTTL`-konfigurationen.

#### Standardcachetid

Om ett HTTP-svar kvalificerar sig för AEM Dispatcher-cachelagring [per ovan-kvalificerare](#when-are-http-requestsresponses-cached-1), är följande standardvärden såvida det inte finns någon anpassad konfiguration.

| Innehållstyp | Standardcachetid för CDN |
|:------------ |:---------- |
| [HTML/JSON/XML](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#html-text) | Till ogiltigförklaring |
| [Assets (bilder, videoklipp, dokument och så vidare)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#images) | Aldrig |
| [Beständiga frågor (JSON)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?lang=sv-SE&publish-instances) | 1 minut |
| [Klientbibliotek (JS/CSS)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#client-side-libraries) | 30 dagar |
| [Annan](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html?lang=sv-SE#other-content) | Till ogiltigförklaring |

### Anpassa cacheregler

AEM Dispatcher-cachen kan konfigureras via [Dispatcher-konfigurationen](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#configuring-the-dispatcher-cache-cache), inklusive:

+ Vad som cachelagras
+ Vilka delar av cachen som blir ogiltiga vid publicering/avpublicering
+ Vilka parametrar för HTTP-frågebegäran som ignoreras vid utvärdering av cache
+ Vilka HTTP-svarshuvuden som cachelagras
+ Aktivera eller inaktivera TTL-cachelagring
+ ... och mycket mer

Om du använder `mod_headers` för att ange cacherubriker kommer konfigurationen `vhost` inte att påverka Dispatcher-cachning (TTL-baserad) eftersom dessa läggs till i HTTP-svaret när AEM Dispatcher bearbetar svaret. För att Dispatcher-cachning ska påverkas via HTTP-svarshuvuden krävs anpassad Java™-kod som körs i AEM Publish och som anger lämpliga HTTP-svarshuvuden.
