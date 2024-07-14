---
title: HTTP/HTTPS-anslutningar för dedikerad IP-adress och VPN
description: Lär dig hur du gör HTTP/HTTPS-begäranden från AEM as a Cloud Service till externa webbtjänster som körs för dedikerad IP-adress och VPN
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9354
thumbnail: KT-9354.jpeg
exl-id: a565bc3a-675f-4d5e-b83b-c14ad70a800b
duration: 70
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '228'
ht-degree: 0%

---

# HTTP/HTTPS-anslutningar för dedikerad IP-adress och VPN

HTTP-/HTTPS-anslutningar proxyeras automatiskt ut från AEM as a Cloud Service med dedikerad IP-adress för utgångar eller VPN, och de behöver inga särskilda `portForwards`-regler.

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

Kontrollera att den [dedikerade IP-adressen för utgångar eller den avancerade VPN](../advanced-networking.md#advanced-networking)-nätverkskonfigurationen har konfigurerats innan du följer den här självstudien.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✘ | ✔ | ✔ |

>[!CAUTION]
>
> Det här kodexemplet gäller bara för [IP-adressen ](../dedicated-egress-ip-address.md) och [VPN](../vpn.md) för det dedikerade uttrycket. Ett liknande, men annat kodexempel är tillgängligt för [HTTP/HTTPS-anslutningar på portar som inte är standard för flexibla portadresser](./http-on-non-standard-ports-flexible-port-egress.md).

## Exempel på kod

Detta Java™-kodexempel är en OSGi-tjänst som kan köras i AEM as a Cloud Service och som gör en HTTP-anslutning till en extern webbserver på 8080. HTTPS-anslutningarna (eller HTTP) proxyeras automatiskt från AEM as a Cloud Service och kräver ingen särskild utveckling.

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
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

@Component
public class HttpExternalServiceImpl implements ExternalService {
    private static final Logger log = LoggerFactory.getLogger(HttpExternalServiceImpl.class);

    // client with connection pool reused for all requests
    private HttpClient client = HttpClient.newBuilder().build();

    @Override
    public boolean isAccessible() {

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
