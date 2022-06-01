---
title: HTTP/HTTPS-anslutningar för dedikerad IP-adress och VPN
description: Lär dig hur du gör HTTP/HTTPS-begäranden från AEM as a Cloud Service till externa webbtjänster som körs för dedikerad IP-adress och VPN
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
kt: 9354
thumbnail: KT-9354.jpeg
exl-id: a565bc3a-675f-4d5e-b83b-c14ad70a800b
source-git-commit: a18bea7986062ff9cb731d794187760ff6e0339f
workflow-type: tm+mt
source-wordcount: '218'
ht-degree: 0%

---

# HTTP/HTTPS-anslutningar för dedikerad IP-adress och VPN

HTTP-/HTTPS-anslutningar måste proxiceras bort från AEM as a Cloud Service, men de behöver inga särskilda `portForwards` regler och kan använda AEM avancerade nätverks `AEM_HTTP_PROXY_HOST`, `AEM_HTTP_PROXY_PORT`, `AEM_HTTPS_PROXY_HOST`och `AEM_HTTPS_PROXY_PORT`.

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

Se till att [lämplig](../advanced-networking.md#advanced-networking) avancerad nätverkskonfiguration har konfigurerats innan du följer den här självstudiekursen.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✘ | ✔ | ✔ |

>[!CAUTION]
>
> Det här kodexemplet är bara för [Dedikerad IP-adress för börs](../dedicated-egress-ip-address.md) och [VPN](../vpn.md). Ett liknande men annat kodexempel finns för [HTTP/HTTPS-anslutningar på portar som inte är standard för flexibla portadresser](./http-on-non-standard-ports-flexible-port-egress.md).

## Exempel på kod

Detta Java™-kodexempel är en OSGi-tjänst som kan köras AEM as a Cloud Service och som gör en HTTP-anslutning till en extern webbserver på 8080. Anslutningar till HTTPS-webbservrar använder `AEM_HTTPS_PROXY_HOST` och `AEM_HTTPS_PROXY_PORT` i stället för  `AEM_HTTP_PROXY_HOST` och `AEM_HTTP_PROXY_PORT`.

>[!NOTE]
> Det rekommenderas att [Java™ 11 HTTP API:er](https://docs.oracle.com/en/java/javase/11/docs/api/java.net.http/java/net/http/package-summary.html) används för att göra HTTP/HTTPS-anrop från AEM.

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

        // If the URL is http, use System.getenv("AEM_HTTP_PROXY_HOST") and System.getenv("AEM_HTTP_PROXY_PORT")
        // Else if the URL is https, us System.getenv("AEM_HTTPS_PROXY_HOST") and System.getenv("AEM_HTTPS_PROXY_PORT")

        if (System.getenv("AEM_HTTP_PROXY_HOST") != null) {
            // Create a ProxySelector that maps to AEM's provided AEM_HTTP_PROXY_HOST and AEM_HTTP_PROXY_PORT
            ProxySelector proxySelector = ProxySelector.of(
                    new InetSocketAddress(System.getenv("AEM_HTTP_PROXY_HOST"),
                            Integer.parseInt(System.getenv("AEM_HTTP_PROXY_PORT"))));
            // Create an HttpClient and provide the proxy selector that will use AEM's native HTTP proxy configuration
            client = HttpClient.newBuilder().proxy(proxySelector).build();
            log.debug("Using HTTPClient with AEM_HTTP_PROXY");
        } else {
            client = HttpClient.newBuilder().build();
            // If no proxy is set up (such as local dev)
            log.debug("Using HTTPClient without AEM_HTTP_PROXY");
        }

        // Prepare the full URI to request, note this will have the
        // - Scheme (http/https)
        // - External host name
        // - External port
        // The external service URI, including the scheme/host/port, is defined in code, rather than in Cloud Manager portForwards rules.
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
