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
exl-id: 22b1869e-5bb5-437d-9cb5-2d27f704c052
duration: 100
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '400'
ht-degree: 0%

---

# Inaktivera CDN-cachning

Lär dig hur du inaktiverar cachelagring av HTTP-svar i AEM as a Cloud Service CDN. Cachelagringen av svar styrs av `Cache-Control`, `Surrogate-Control` eller `Expires` cachehuvuden för HTTP-svar.

Dessa cacherubriker ställs vanligtvis in i AEM Dispatcher värdkonfigurationer med `mod_headers`, men kan också anges i anpassad Java™-kod som körs i AEM Publish.

## Standardbeteende för cachelagring

Granska standardbeteendet för cachning för AEM Publish och författare när ett [AEM Project Archetype](./enable-caching.md#default-caching-behavior)-baserat AEM distribueras.

## Inaktivera cachelagring

Om du stänger av cachelagring kan det påverka prestandan negativt för din AEM as a Cloud Service-instans, så var försiktig när du stänger av standardcachelagring.

Det finns dock vissa scenarier där du kanske vill inaktivera cachelagring, som:

- Utveckla en ny funktion och vill omedelbart se ändringarna.
- Innehållet är säkert (endast avsett för autentiserade användare) eller dynamiskt (kundvagn, orderdetaljer) och ska inte cachas.

Om du vill inaktivera cachelagring kan du uppdatera cacherubrikerna på två sätt.

1. **Dispatcher-värdkonfiguration:** Endast tillgänglig för AEM Publish.
1. **Anpassad Java™-kod:** Tillgänglig för både AEM Publish och författare.

Låt oss titta närmare på de här alternativen.

### Dispatcher-värdkonfiguration

Det här alternativet rekommenderas för att inaktivera cachelagring, men det är bara tillgängligt för AEM Publish. Om du vill uppdatera cacherubrikerna använder du direktivet `mod_headers` module och `<LocationMatch>` i Apache HTTP Server-serverns värdfil. Den allmänna syntaxen är följande:

```
<LocationMatch "$URL$ || $URL_REGEX$">
    # Removes the response header of this name, if it exists. If there are multiple headers of the same name, all will be removed.
    Header unset Cache-Control
    Header unset Expires

    # Instructs the CDN to not cache the response.
    Header set Cache-Control "private"
</LocationMatch>
```

#### Exempel

Följ de här stegen för att inaktivera CDN-cachelagring av **CSS-innehållstyper** i vissa felsökningssyften.

Observera att om du vill åsidosätta den befintliga CSS-cachen måste du ändra CSS-filen för att skapa en ny cachenyckel för CSS-filen.

1. Leta reda på önskad värdfil från katalogen `dispatcher/src/conf.d/available_vhosts` i ditt AEM projekt.
1. Uppdatera Vhost-filen (t.ex. `wknd.vhost`) enligt följande:

   ```
   <LocationMatch "^/etc.clientlibs/.*\.(css)$">
       # Removes the response header of this name, if it exists. If there are multiple headers of the same name, all will be removed.
       Header unset Cache-Control
       Header unset Expires
   
       # Instructs the CDN to not cache the response.
       Header set Cache-Control "private"
   </LocationMatch>
   ```

   Värdfilerna i katalogen `dispatcher/src/conf.d/enabled_vhosts` är **symlinks** till filerna i katalogen `dispatcher/src/conf.d/available_vhosts`, så se till att du skapar symboler om sådana inte finns.
1. Distribuera värdändringarna till önskad AEM as a Cloud Service-miljö med [Cloud Manager - konfigurationspipeline för webbnivå](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html?#web-tier-config-pipelines) eller [RDE-kommandon](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/how-to-use.html?lang=en#deploy-apache-or-dispatcher-configuration).

### Anpassad Java™-kod

Det här alternativet är tillgängligt för både AEM Publish och författare. Om du vill uppdatera cacherubrikerna använder du objektet `SlingHttpServletResponse` i anpassad Java™-kod (Sling-servlet, Sling-serverletsfilter). Den allmänna syntaxen är följande:

```java
response.setHeader("Cache-Control", "private");
```
