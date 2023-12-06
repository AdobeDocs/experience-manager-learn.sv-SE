---
title: Inaktivera CDN-cachning
description: Lär dig hur du inaktiverar cachelagring av HTTP-svar i AEM as a Cloud Service CDN.
version: Cloud Service
feature: Operations, CDN Cache
topic: Administration, Performance
role: Admin, Architect, Developer
level: Beginner
doc-type: Tutorial
last-substantial-update: 2023-11-30T00:00:00Z
jira: KT-14224
thumbnail: KT-14224.jpeg
source-git-commit: 43c021b051806380b3211f2d7357555622217b91
workflow-type: tm+mt
source-wordcount: '501'
ht-degree: 0%

---


# Inaktivera CDN-cachning

Lär dig hur du inaktiverar cachelagring av HTTP-svar i AEM as a Cloud Service CDN. Cachelagring av svar styrs av `Cache-Control`, `Surrogate-Control`, eller `Expires` Cache-rubriker för HTTP-svar.

Dessa cache-huvuden anges vanligtvis i AEM Dispatcher-värdkonfigurationer med `mod_headers`, men kan även anges i anpassad Java™-kod som körs i AEM Publish.

## Standardbeteende för cachelagring

Granska standardbeteendet för cachning för AEM och författare när en [AEM Project Archettype](./enable-caching.md#default-caching-behavior) AEM distribueras.

## Inaktivera cachelagring

Om du stänger av cachelagring kan det påverka prestandan för den AEM as a Cloud Service instansen negativt, så var försiktig när du stänger av standardcachelagring.

Det finns dock vissa scenarier där du kanske vill inaktivera cachelagring, som:

- Utveckla en ny funktion och vill omedelbart se ändringarna.
- Innehållet är säkert (endast avsett för autentiserade användare) eller dynamiskt (kundvagn, orderdetaljer) och ska inte cachas.

Om du vill inaktivera cachelagring kan du uppdatera cacherubrikerna på två sätt.

1. **Dispatcher-värdkonfiguration:** Endast tillgängligt för AEM.
1. **Anpassad Java™-kod:** Finns för både AEM och författare.

Låt oss titta närmare på de här alternativen.

### Dispatcher-värdkonfiguration

Det här alternativet rekommenderas för att inaktivera cachelagring, men det är bara tillgängligt för AEM. Om du vill uppdatera cacherubrikerna använder du `mod_headers` modul och `<LocationMatch>` -direktivet i Apache HTTP-serverns värdfil. Den allmänna syntaxen är följande:

    &quot;conf
    &lt;locationmatch url=&quot;&quot; url_regex=&quot;&quot;>
    # Tar bort svarshuvudet för det här namnet, om det finns. Om det finns flera rubriker med samma namn tas alla bort.
    Cachekontroll för borttagning av huvud
    Ångra av huvud upphör
    
    # Instruerar CDN att inte cachelagra svaret.
    Header set Cache-Control &quot;private&quot;
    &lt;/locationmatch>
    &quot;

#### Exempel

Inaktivera CDN-cachning för **CSS-innehållstyper** för vissa felsökningssyften, följ dessa steg.

Observera att om du vill åsidosätta den befintliga CSS-cachen måste du ändra CSS-filen för att skapa en ny cachenyckel för CSS-filen.

1. Leta reda på önskad värdfil i AEM projekt `dispatcher/src/conf.d/available_vhosts` katalog.
1. Uppdatera värden (t.ex. `wknd.vhost`) på följande sätt:

       &quot;conf
       &lt;locationmatch etc.clientlibs=&quot;&quot;>*\.(css)$&quot;>
       # Tar bort svarshuvudet för det här namnet, om det finns. Om det finns flera rubriker med samma namn tas alla bort.
       Cachekontroll för borttagning av huvud
       Ångra av huvud upphör
       
       # Instruerar CDN att inte cachelagra svaret.
       Header set Cache-Control &quot;private&quot;
       &lt;/locationmatch>
       &quot;
   Värdfilerna i `dispatcher/src/conf.d/enabled_vhosts` katalogen är **symboler** till filerna i `dispatcher/src/conf.d/available_vhosts` ska du se till att det inte finns några länkar.
1. Distribuera värdändringarna till AEM as a Cloud Service miljö med [Cloud Manager - Konfigurationspipeline för webbnivå](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html?#web-tier-config-pipelines) eller [RDE-kommandon](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/how-to-use.html?lang=en#deploy-apache-or-dispatcher-configuration).

### Anpassad Java™-kod

Det här alternativet är tillgängligt för både AEM och författare. Om du vill uppdatera cacherubrikerna använder du `SlingHttpServletResponse` -objekt i egen Java™-kod (Sling-serverlet, Sling-serverletsfilter). Den allmänna syntaxen är följande:

    &quot;java
    response.setHeader(&quot;Cache-Control&quot;, &quot;private&quot;);
    &quot;
