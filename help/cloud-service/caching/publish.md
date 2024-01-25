---
title: AEM Publish service caching
description: Allmän översikt över AEM as a Cloud Service Publish-tjänstcache.
version: Cloud Service
feature: Dispatcher, Developer Tools
topic: Performance
role: Architect, Developer
level: Intermediate
doc-type: Article
last-substantial-update: 2023-08-28T00:00:00Z
jira: KT-13858
thumbnail: KT-13858.jpeg
exl-id: 1a1accbe-7706-4f9b-bf63-755090d03c4c
duration: 293
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1134'
ht-degree: 0%

---

# AEM Publish

Tjänsten AEM Publish har två primära cachelagringslager, AEM as a Cloud Service CDN och AEM Dispatcher. Ett kundhanterat CDN kan också placeras framför AEM as a Cloud Service CDN. Den AEM as a Cloud Service CDN levererar toppmaterial och levererar upplevelser med låg latens till användare i hela världen. AEM Dispatcher tillhandahåller cachelagring direkt framför AEM Publish och används för att minska onödig belastning vid AEM Publish.

![Översiktsdiagram för AEM publicera cachelagring](./assets/publish/publish-all.png){align="center"}

## CDN

AEM as a Cloud Service CDN:s cachelagring styrs av headers i HTTP-svarscache och är avsedd att cachelagra innehåll för att optimera balansen mellan aktualitet och prestanda. CDN:n ligger mellan slutanvändaren och AEM Dispatcher och används för att cachelagra innehåll så nära slutanvändaren som möjligt, vilket ger en bättre prestanda.

![AEM Publish CDN](./assets/publish/publish-cdn.png){align="center"}

Att konfigurera hur CDN cachelagrar innehåll begränsas till att ange cacherubriker för HTTP-svar. Dessa cache-huvuden anges vanligtvis i AEM Dispatcher-värdkonfigurationer med `mod_headers`, men kan även anges i anpassad Java™-kod som körs i AEM Publish.

### När cachelagras HTTP-begäranden/svar?

AEM as a Cloud Service CDN cachelagrar bara HTTP-svar och alla följande kriterier måste vara uppfyllda:

+ HTTP-begärandestatus är `2xx` eller `3xx`
+ HTTP-begärandemetoden är `GET` eller `HEAD`
+ Minst en av följande HTTP-svarshuvuden finns: `Cache-Control`, `Surrogate-Control`, eller  `Expires`
+ HTTP-svaret kan vara vilken innehållstyp som helst, inklusive HTML, JSON, CSS, JS och binära filer.

Som standard är HTTP-svar inte cachelagrade av [AEM](#aem-dispatcher) tar automatiskt bort alla headers i HTTP-svarscache för att undvika cachelagring vid CDN. Detta beteende kan åsidosättas noggrant med `mod_headers` med `Header always set ...` -direktivet när det är nödvändigt.

### Vad cachelagras?

AEM as a Cloud Service CDN cache-lagras:

+ HTTP-svarsbrödtext
+ HTTP-svarsrubriker

Vanligtvis cachelagras en HTTP-begäran/ett HTTP-svar för en enskild URL som ett enskilt objekt. CDN kan dock hantera cachelagring av flera objekt för en enda URL-adress när `Vary` huvudet anges på HTTP-svaret. Undvik att ange `Vary` på rubriker vars värden inte har en tätt kontrollerad uppsättning värden, eftersom detta kan leda till många cachemissar, vilket minskar cachens träfffrekvens. För att stödja cachelagring av olika förfrågningar hos AEM Dispatcher, [Granska dokumentationen för variantcachelagring](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/advanced/variant-caching.html).

### Cachelagring{#cdn-cache-life}

Det AEM publicerade CDN är TTL-baserat (time to live), vilket innebär att cachetiden bestäms av `Cache-Control`, `Surrogate-Control`, eller `Expires` HTTP-svarsrubriker. Om rubrikerna för cachelagring av HTTP-svar inte anges av projektet, och [kvalifikationskriterier](#when-are-http-requestsresponses-cached) är uppfyllda, anger Adobe en standardcachetid på 10 minuter (600 sekunder).

Så här påverkar cacherubrikerna CDN-cachens livslängd:

+ [`Cache-Control`](https://developer.fastly.com/reference/http/http-headers/Cache-Control/) HTTP-svarshuvudet anger för webbläsaren och CDN hur länge svaret ska cachelagras. Värdet anges i sekunder. Till exempel: `Cache-Control: max-age=3600` anger för webbläsaren att cachelagra svaret i en timme. Detta värde ignoreras av CDN om `Surrogate-Control` HTTP-svarshuvud finns också.
+ [`Surrogate-Control`](https://developer.fastly.com/reference/http/http-headers/Surrogate-Control/) HTTP-svarshuvudet instruerar AEM CDN hur länge svaret ska cachelagras. Värdet anges i sekunder. Till exempel: `Surrogate-Control: max-age=3600` anger för CDN att cachelagra svaret i en timme.
+ [`Expires`](https://developer.fastly.com/reference/http/http-headers/Expires/) HTTP-svarshuvudet instruerar AEM CDN (och webbläsaren) hur länge det cachelagrade svaret är giltigt. Värdet är ett datum. Till exempel: `Expires: Sat, 16 Sept 2023 09:00:00 EST` anger att webbläsaren ska cachelagra svaret tills det angivna datumet och den angivna tiden.

Använd `Cache-Control` för att styra cachens livslängd när den är densamma för både webbläsare och CDN. Använd `Surrogate-Control` när webbläsaren ska cachelagra svaret med en annan varaktighet än CDN.

#### Standardcachetid

Om ett HTTP-svar kvalificerar sig för AEM Dispatcher-cachning [per ovan-kvalificerare](#when-are-http-requestsresponses-cached)är följande standardvärden såvida inte en anpassad konfiguration finns.

| Innehållstyp | Standardcachetid för CDN |
|:------------ |:---------- |
| [HTML/JSON/XML](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#html-text) | 5 minuter |
| [Resurser (bilder, videoklipp, dokument och så vidare)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#images) | 10 minuter |
| [Beständiga frågor (JSON)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?publish-instances) | 2 timmar |
| [Klientbibliotek (JS/CSS)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#client-side-libraries) | 30 dagar |
| [Övriga](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#other-content) | Inte cachelagrad |

### Anpassa cacheregler

[Konfigurera hur CDN cachelagrar innehåll](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#disp) begränsas till att ange cacherubriker för HTTP-svar. De här cacherubrikerna ställs vanligtvis in i AEM Dispatcher `vhost` konfigurationer med `mod_headers`, men kan även anges i anpassad Java™-kod som körs i AEM Publish.

## AEM

![AEM Publish AEM Dispatcher](./assets/publish/publish-dispatcher.png){align="center"}

### När cachelagras HTTP-begäranden/svar?

HTTP-svar för motsvarande HTTP-begäranden cachelagras när alla följande villkor uppfylls:

+ HTTP-begärandemetoden är `GET` eller `HEAD`
   + `HEAD` HTTP-begäranden cachelagrar bara HTTP-svarshuvuden. De har inga svarsorgan.
+ HTTP-svarsstatusen är `200`
+ HTTP-svaret är INTE för en binär fil.
+ URL-sökvägen för HTTP-begäran avslutas med ett tillägg, till exempel: `.html`, `.json`, `.css`, `.js`, osv.
+ HTTP-begäran innehåller ingen auktorisering och autentiseras inte av AEM.
   + Cachelagring av autentiserade begäranden [kan aktiveras globalt](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#caching-when-authentication-is-used) eller selektivt via [behörighetskänslig cachelagring](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/permissions-cache.html).
+ HTTP-begäran innehåller inga frågeparametrar.
   + Men konfigurera [Ignorerade frågeparametrar](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#ignoring-url-parameters) tillåter att HTTP-begäranden med ignorerade frågeparametrar cachelagras/hanteras från cachen.
+ Sökväg för HTTP-begäran [matchar en Tillåt Dispatcher-regel och matchar inte en Neka-regel](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#specifying-the-documents-to-cache).
+ HTTP-svar har inte någon av följande HTTP-svarshuvuden som angetts av AEM Publicera:

   + `no-cache`
   + `no-store`
   + `must-revalidate`

### Vad cachelagras?

AEM Dispatcher cachelagrar följande:

+ HTTP-svarsbrödtext
+ HTTP-svarshuvuden som har angetts i Dispatcher [konfiguration av cachehuvuden](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#caching-http-response-headers). Se standardkonfigurationen som levereras med [AEM Project Archettype](https://github.com/adobe/aem-project-archetype/blob/develop/src/main/archetype/dispatcher.cloud/src/conf.dispatcher.d/available_farms/default.farm#L106-L113).
   + `Cache-Control`
   + `Content-Disposition`
   + `Content-Type`
   + `Expires`
   + `Last-Modified`
   + `X-Content-Type-Options`

### Cachelagring

AEM Dispatcher cachelagrar HTTP-svar med följande metoder:

+ Till dess att ogiltigförklaringen utlöses via funktioner som publicering eller avpublicering av innehållet.
+ TTL (time-to-live) när [konfigurerad i Dispatcher-konfigurationen](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#configuring-time-based-cache-invalidation-enablettl). Se standardkonfigurationen i [AEM Project Archettype](https://github.com/adobe/aem-project-archetype/blob/develop/src/main/archetype/dispatcher.cloud/src/conf.dispatcher.d/available_farms/default.farm#L122-L127) genom att granska `enableTTL` konfiguration.

#### Standardcachetid

Om ett HTTP-svar kvalificerar sig för AEM Dispatcher-cachning [per ovan-kvalificerare](#when-are-http-requestsresponses-cached-1)är följande standardvärden såvida inte en anpassad konfiguration finns.

| Innehållstyp | Standardcachetid för CDN |
|:------------ |:---------- |
| [HTML/JSON/XML](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#html-text) | Till ogiltigförklaring |
| [Resurser (bilder, videoklipp, dokument och så vidare)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#images) | Aldrig |
| [Beständiga frågor (JSON)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/persisted-queries.html?publish-instances) | 1 minut |
| [Klientbibliotek (JS/CSS)](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#client-side-libraries) | 30 dagar |
| [Övriga](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#other-content) | Till ogiltigförklaring |

### Anpassa cacheregler

AEM Dispatcher-cachen kan konfigureras via [Dispatcher-konfiguration](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#configuring-the-dispatcher-cache-cache) inklusive:

+ Vad som cachelagras
+ Vilka delar av cachen som blir ogiltiga vid publicering/avpublicering
+ Vilka parametrar för HTTP-frågebegäran som ignoreras vid utvärdering av cache
+ Vilka HTTP-svarshuvuden som cachelagras
+ Aktivera eller inaktivera TTL-cachelagring
+ ... och mycket mer

Använda `mod_headers` för att ange cacherubriker för `vhost` -konfigurationen påverkar inte Dispatcher-cachning (TTL-baserad) eftersom dessa läggs till i HTTP-svaret när AEM Dispatcher bearbetar svaret. För att påverka Dispatcher-cachning via HTTP-svarshuvuden krävs anpassad Java™-kod som körs i AEM Publish och som anger lämpliga HTTP-svarshuvuden.
