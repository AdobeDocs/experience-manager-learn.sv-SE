---
title: Aktivera CDN-cachning
description: Lär dig hur du aktiverar cachelagring av HTTP-svar i AEM as a Cloud Service CDN.
version: Cloud Service
feature: Operations, CDN Cache
topic: Administration, Performance
role: Admin, Architect, Developer
level: Beginner
doc-type: Tutorial
last-substantial-update: 2023-11-17T00:00:00Z
jira: KT-14224
thumbnail: KT-14224.jpeg
exl-id: 544c3230-6eb6-4f06-a63c-f56d65c0ff4b
duration: 200
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '637'
ht-degree: 0%

---

# Aktivera CDN-cachning

Lär dig hur du aktiverar cachelagring av HTTP-svar i AEM as a Cloud Service CDN. Cachelagring av svar styrs av `Cache-Control`, `Surrogate-Control`, eller `Expires` Cache-rubriker för HTTP-svar.

Dessa cache-huvuden anges vanligtvis i AEM Dispatcher-värdkonfigurationer med `mod_headers`, men kan även anges i anpassad Java™-kod som körs i AEM Publish.

## Standardbeteende för cachelagring

När det INTE finns några anpassade konfigurationer används standardvärdena. I följande skärmbild kan du se standardbeteendet för cachning för AEM Publicera och Författare när en [AEM Project Archettype](https://github.com/adobe/aem-project-archetype) baserad `mynewsite` AEM är distribuerat.

![Standardbeteende för cachelagring](../assets/how-to/aem-publish-default-cache-headers.png){width="800" zoomable="yes"}

Granska [AEM publicering - standardcachetid](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/caching/publish.html#cdn-cache-life) och [AEM författare - standardcachetid](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/caching/author.html?#default-cache-life) för mer information.

Sammanfattningsvis cachelagrar AEM as a Cloud Service de flesta innehållstyperna (HTML, JSON, JS, CSS och Assets) i AEM Publish och några innehållstyper (JS, CSS) i AEM Author.

## Aktivera cachelagring

Om du vill ändra standardbeteendet för cachning kan du uppdatera cacherubrikerna på två sätt.

1. **Dispatcher-värdkonfiguration:** Endast tillgängligt för AEM.
1. **Anpassad Java™-kod:** Finns för både AEM och författare.

Låt oss titta närmare på de här alternativen.

### Dispatcher-värdkonfiguration

Det här alternativet är det rekommenderade sättet att aktivera cachelagring, men det är bara tillgängligt för AEM. Om du vill uppdatera cacherubrikerna använder du `mod_headers` modul och `<LocationMatch>` -direktivet i Apache HTTP-serverns värdfil. Den allmänna syntaxen är följande:

```
<LocationMatch "$URL$ || $URL_REGEX$">
    # Removes the response header of this name, if it exists. If there are multiple headers of the same name, all will be removed.
    Header unset Cache-Control
    Header unset Surrogate-Control
    Header unset Expires

    # Instructs the web browser and CDN to cache the response for 'max-age' value (XXX) seconds. The 'stale-while-revalidate' and 'stale-if-error' attributes controls the stale state treatment at CDN layer.
    Header set Cache-Control "max-age=XXX,stale-while-revalidate=XXX,stale-if-error=XXX"
    
    # Instructs the CDN to cache the response for 'max-age' value (XXX) seconds. The 'stale-while-revalidate' and 'stale-if-error' attributes controls the stale state treatment at CDN layer.
    Header set Surrogate-Control "max-age=XXX,stale-while-revalidate=XXX,stale-if-error=XXX"
    
    # Instructs the web browser and CDN to cache the response until the specified date and time.
    Header set Expires "Sun, 31 Dec 2023 23:59:59 GMT"
</LocationMatch>
```

Nedan sammanfattas syftet med varje **header** och tillämpliga **attributes** för sidhuvudet.

|                     | Webbläsare | CDN | Beskrivning |
|---------------------|:-----------:|:---------:|:-----------:|
| Cache-Control | ✔ | ✔ | Det här huvudet styr webbläsarens och CDN-cachetid. |
| Surrogate-kontroll | ✘ | ✔ | Den här rubriken styr CDN-cacheperioden. |
| Upphör | ✔ | ✔ | Det här huvudet styr webbläsarens och CDN-cachetid. |


- **max-age**: Det här attributet styr TTL-värdet eller&quot;time to live&quot; för svarsinnehållet i sekunder.
- **inaktuell-while-revalidate**: Det här attributet styr _inaktuellt läge_ Behandlingen av svarsinnehållet i CDN-lagret när en begäran tas emot ligger inom den angivna perioden i sekunder. The _inaktuellt läge_ är tidsperioden efter det att TTL-värdet har upphört att gälla och innan svaret har validerats på nytt.
- **stale-if-error**: Det här attributet styr _inaktuellt läge_ behandling av svarsinnehållet i CDN-lagret när den ursprungliga servern inte är tillgänglig och mottagen begäran är inom den angivna perioden i sekunder.

Granska [aktualitet och förlängning](https://developer.fastly.com/learning/concepts/edge-state/cache/stale/) mer information.

#### Exempel

Öka webbläsarens och CDN-cachetid för **HTML-innehållstyp** till _10 minuter_ utan behandling i inaktivt tillstånd, följ dessa steg:

1. Leta reda på önskad värdfil i AEM projekt `dispatcher/src/conf.d/available_vhosts` katalog.
1. Uppdatera värden (t.ex. `wknd.vhost`) på följande sätt:

   ```
   <LocationMatch "^/content/.*\.(html)$">
       # Removes the response header if present
       Header unset Cache-Control
   
       # Instructs the web browser and CDN to cache the response for max-age value (600) seconds.
       Header set Cache-Control "max-age=600"
   </LocationMatch>
   ```

   Värdfilerna i `dispatcher/src/conf.d/enabled_vhosts` katalogen är **symboler** till filerna i `dispatcher/src/conf.d/available_vhosts` ska du se till att det inte finns några länkar.
1. Distribuera värdändringarna till AEM as a Cloud Service miljö med [Cloud Manager - Konfigurationspipeline för webbnivå](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html?#web-tier-config-pipelines) eller [RDE-kommandon](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/how-to-use.html?lang=en#deploy-apache-or-dispatcher-configuration).

Om du vill ha olika värden för webbläsarens och CDN-cacheperioden kan du använda `Surrogate-Control` i ovanstående exempel. På samma sätt kan du använda `Expires` header. Med `stale-while-revalidate` och `stale-if-error` kan du styra hur svarsinnehållet ska behandlas i inaktivt läge. AEM WKND-projektet har en [behandling av föråldrat referenstillstånd](https://github.com/adobe/aem-guides-wknd/blob/main/dispatcher/src/conf.d/available_vhosts/wknd.vhost#L150-L155) Konfiguration av CDN-cache.

På samma sätt kan du uppdatera cacherubrikerna för andra innehållstyper (JSON, JS, CSS och Assets) också.

### Anpassad Java™-kod

Det här alternativet är tillgängligt för både AEM och författare. Du bör dock inte aktivera cachelagring i AEM Author och behålla standardbeteendet för cachelagring.

Om du vill uppdatera cacherubrikerna använder du `HttpServletResponse` -objekt i egen Java™-kod (Sling-serverlet, Sling-serverletsfilter). Den allmänna syntaxen är följande:

```java
// Instructs the web browser and CDN to cache the response for 'max-age' value (XXX) seconds. The 'stale-while-revalidate' and 'stale-if-error' attributes controls the stale state treatment at CDN layer.
response.setHeader("Cache-Control", "max-age=XXX,stale-while-revalidate=XXX,stale-if-error=XXX");

// Instructs the CDN to cache the response for 'max-age' value (XXX) seconds. The 'stale-while-revalidate' and 'stale-if-error' attributes controls the stale state treatment at CDN layer.
response.setHeader("Surrogate-Control", "max-age=XXX,stale-while-revalidate=XXX,stale-if-error=XXX");

// Instructs the web browser and CDN to cache the response until the specified date and time.
response.setHeader("Expires", "Sun, 31 Dec 2023 23:59:59 GMT");
```
