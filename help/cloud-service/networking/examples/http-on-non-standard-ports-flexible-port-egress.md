---
title: HTTP/HTTPS-anslutningar på portar som inte är standard för flexibel portutgång
description: Lär dig hur du gör HTTP/HTTPS-förfrågningar från AEM as a Cloud Service till externa webbtjänster som körs på icke-standardportar för flexibel portadress.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9354
thumbnail: KT-9354.jpeg
exl-id: c8cc0385-9e94-4120-9fb1-aeccbfcc8aa4
duration: 86
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '237'
ht-degree: 0%

---

# HTTP/HTTPS-anslutningar på portar som inte är standard för flexibel portutgång

HTTP/HTTPS-anslutningar på portar som inte är standard (inte 80/443) måste proxygenereras från AEM as a Cloud Service, men de behöver inga särskilda `portForwards`-regler och kan använda AEM avancerade nätverks `AEM_PROXY_HOST` och en reserverad proxyport `AEM_HTTP_PROXY_PORT` eller `AEM_HTTPS_PROXY_PORT` beroende på om målet är HTTP/HTTPS.

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

Kontrollera att den [lämpliga](../advanced-networking.md#advanced-networking) avancerade nätverkskonfigurationen har konfigurerats innan du följer den här självstudien.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✔ | ✘ | ✘ |

>[!CAUTION]
>
> Det här kodexemplet är bara för [Flexibla portadresser](../flexible-port-egress.md). Ett liknande, men annat kodexempel är tillgängligt för [HTTP/HTTPS-anslutningar på icke-standardportar för dedikerad IP-adress och VPN](./http-dedicated-egress-ip-vpn.md).

## Exempel på kod

Detta Java™-kodexempel är en OSGi-tjänst som kan köras i AEM as a Cloud Service och som gör en HTTP-anslutning till en extern webbserver på 8080. För anslutningar till HTTPS-webbservrar används miljövariablerna `AEM_PROXY_HOST` och `AEM_HTTPS_PROXY_PORT` (standard är `proxy.tunnel:3128` i AEM versioner &lt; 6094).

>[!NOTE]
> Vi rekommenderar att [Java™ 11 HTTP API:er](https://docs.oracle.com/en/java/javase/11/docs/api/java.net.http/java/net/http/package-summary.html) används för att göra HTTP/HTTPS-anrop från AEM.

+ `core/src/com/adobe/aem/wknd/examples/connections/impl/HttpExternalServiceImpl.java`

```java
package com.adobe.aem.wknd.examples.core.connections.impl;

import com.adobe.aem.wknd.examples.core.connections.ExternalService;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.ProxySelector;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

@Component
public class HttpExternalServiceImpl implements ExternalService {
    private static final Logger log = LoggerFactory.getLogger(HttpExternalServiceImpl.class);

    @Override
    public boolean isAccessible() {
        HttpClient client;

        // Use System.getenv("AEM_PROXY_HOST") and proxy port System.getenv("AEM_HTTP_PROXY_PORT") 
        // or System.getenv("AEM_HTTPS_PROXY_PORT"), depending on if the destination requires HTTP/HTTPS

        if (System.getenv("AEM_PROXY_HOST") != null) {
            // Create a ProxySelector that uses to AEM's provided AEM_PROXY_HOST, with a fallback of proxy.tunnel, and proxy port using the AEM_HTTP_PROXY_PORT variable. 
            // If the destination requires HTTPS, then use the variable AEM_HTTPS_PROXY_PORT instead of AEM_HTTP_PROXY_PORT.
 
            ProxySelector proxySelector = ProxySelector.of(new InetSocketAddress(
                System.getenv().getOrDefault("AEM_PROXY_HOST", "proxy.tunnel"), 
                Integer.parseInt(System.getenv().get("AEM_HTTP_PROXY_PORT"))));

            client = HttpClient.newBuilder().proxy(proxySelector).build();
            log.debug("Using HTTPClient with AEM_PROXY_HOST");
        } else {
            client = HttpClient.newBuilder().build();
            // If no proxy is set up (such as local dev)
            log.debug("Using HTTPClient without AEM_PROXY_HOST");
        }

        // Prepare the full URI to request, note this will have the
        // - Scheme (http/https)
        // - External host name
        // - External port
        // The external service URI, including the scheme/host/port, is defined in code, and NOT in Cloud Manager portForwards rules.
        URI uri = URI.create("http://api.example.com:8080/test.json");

        // Prepare the HttpRequest
        HttpRequest request = HttpRequest.newBuilder().uri(uri).timeout(Duration.ofSeconds(2)).build();

        // Send the HttpRequest using the configured HttpClient
        HttpResponse<String> response = null;
        try {
            // Request the URL
            response = client.send(request, HttpResponse.BodyHandlers.ofString());

            log.debug("HTTP response body: {} ", response.body());

            // Our simple example returns true is response is successful! (200 status code)
            return response.statusCode() == 200;
        } catch (IOException e) {
            return false;
        } catch (InterruptedException e) {
            return false;
        }
    }
}
```
