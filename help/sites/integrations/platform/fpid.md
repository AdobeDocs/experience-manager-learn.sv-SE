---
title: Generera Adobe Experience Platform FPID:n med AEM Sites
description: Lär dig hur du genererar eller uppdaterar Adobe Experience Platform FPID-cookies med AEM Sites.
version: Cloud Service
feature: Integrations, APIs, Dispatcher
topic: Integrations, Personalization, Development
role: Developer
level: Beginner
last-substantial-update: 2022-10-20T00:00:00Z
jira: KT-11336
thumbnail: kt-11336.jpeg
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
exl-id: 18a22f54-da58-4326-a7b0-3b1ac40ea0b5
duration: 266
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '982'
ht-degree: 0%

---

# Generera Experience Platform FPID:n med AEM Sites

För att det ska gå att spåra användaraktivitet måste du skapa och underhålla en unik FPID-cookie (unique first-party device ID) (AEM) för att kunna integrera Adobe Experience Manager-webbplatser med Adobe Experience Platform (AEP).

Läs stöddokumentationen för att [lära dig mer om hur enhets-ID:n i första delen och Experience Cloud-ID:n fungerar tillsammans](https://experienceleague.adobe.com/docs/platform-learn/data-collection/edge-network/generate-first-party-device-ids.html?lang=en).

Nedan visas en översikt över hur FPID fungerar när AEM används som webbvärd.

![FPID och ECID med AEM](./assets/aem-platform-fpid-architecture.png)

## Generera och behåll FPID med AEM

AEM Publish-tjänst optimerar prestanda genom att cachelagra förfrågningar så många som möjligt, både i CDN- och AEM Dispatcher-cachen.

Det är en absolut nödvändighet att HTTP-begäranden som genererar FPID-cookie för en unik användare och returnerar FPID-värdet cachelagras aldrig, och skickas direkt från AEM Publish som kan implementera logik för att garantera unika funktioner.

Undvik att generera FPID-cookie för webbsidor eller andra tillgängliga resurser eftersom kombinationen av FPID:ts unika krav skulle göra dessa resurser otillgängliga.

I följande diagram beskrivs hur AEM Publish-tjänst hanterar FPID:n.

![FPID och AEM ](./assets/aem-fpid-flow.png)

1. Webbläsaren begär en webbsida som AEM. Begäran kan behandlas med en cachelagrad kopia av webbsidan från CDN- eller AEM Dispatcher-cachen.
1. Om webbsidan inte kan hanteras från cacheminnen i CDN eller AEM Dispatcher, kommer begäran att nå AEM Publish-tjänst, som genererar den begärda webbsidan.
1. Webbsidan skickas sedan tillbaka till webbläsaren och fyller i de cacheminnen som inte kunde hantera begäran. Med AEM förväntar du att antalet träffar i CDN och AEM Dispatcher-cachen är större än 90 %.
1. Webbsidan innehåller JavaScript som gör en otillgänglig asynkron XHR-begäran (AJAX) till en anpassad FPID-server i AEM Publish-tjänsten. Eftersom detta är en otillgänglig begäran (på grund av dess slumpmässiga frågeparameter och Cache-Control-headers) cachelagras den aldrig av CDN eller AEM Dispatcher och når alltid AEM Publish-tjänst för att generera svaret.
1. Den anpassade FPID-servern i AEM Publish-tjänsten bearbetar begäran och genererar ett nytt FPID när ingen befintlig FPID-cookie hittas, eller förlänger livscykeln för en befintlig FPID-cookie. Servern returnerar också FPID i svarstexten som ska användas av JavaScript på klientsidan. Lyckligtvis är den anpassade FPID-serverlogiken liten, vilket förhindrar att den här begäran påverkar AEM Publish tjänstprestanda.
1. Svaret på XHR-begäran återgår till webbläsaren med FPID-cookien och FPID som JSON i svarstexten för användning av Platform Web SDK.

## Kodexempel

Följande kod och konfiguration kan distribueras till AEM Publish-tjänst för att skapa en slutpunkt som genererar eller förlänger livscykeln för en befintlig FPID-cookie och returnerar FPID som JSON.

### AEM FPID-cookie-server

En AEM HTTP-slutpunkt måste skapas för att en FPID-cookie ska kunna genereras eller utökas med hjälp av en [Sling-server](https://sling.apache.org/documentation/the-sling-engine/servlets.html#registering-a-servlet-using-java-annotations-1).

+ Servern är bunden till `/bin/aem/fpid` eftersom autentisering inte krävs för att komma åt den. Om autentisering krävs binder du till en Sling-resurstyp.
+ Servern accepterar HTTP GET-begäranden. Svaret har markerats med `Cache-Control: no-store` för att förhindra cachelagring, men den här slutpunkten ska också begäras med unika frågeparametrar för cachebuffring.

När en HTTP-begäran når servern kontrollerar servern om det finns en FPID-cookie på begäran:

+ Om det finns en FPID-cookie förlänger du cookie-filens livslängd och samlar in dess värde för att skriva till svaret.
+ Om det inte finns någon FPID-cookie skapar du en ny FPID-cookie och sparar värdet för att skriva till svaret.

Servern skriver sedan FPID till svaret som ett JSON-objekt i formatet: `{ fpid: "<FPID VALUE>" }`.

Det är viktigt att tillhandahålla FPID till klienten i brödtexten eftersom FPID-cookien är markerad som `HttpOnly`, vilket innebär att bara servern kan läsa dess värde, och inte JavaScript på klientsidan.

FPID-värdet från svarstexten används för att parametrisera anrop med Platform Web SDK.

Nedan visas exempelkod för en AEM serverlet-slutpunkt (tillgänglig via `HTTP GET /bin/aep/fpid`) som genererar eller uppdaterar en FPID-cookie och returnerar FPID som JSON.

+ `core/src/main/java/com/adobe/aem/guides/wkndexamples/core/aep/impl/FpidServlet.java`

```java
package com.adobe.aem.guides.wkndexamples.core.aep.impl;

import com.google.gson.JsonObject;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.Servlet;
import javax.servlet.http.Cookie;
import java.io.IOException;
import java.util.UUID;

import static org.apache.sling.api.servlets.ServletResolverConstants.SLING_SERVLET_PATHS;
import static org.apache.sling.api.servlets.ServletResolverConstants.SLING_SERVLET_METHODS;

@Component(
        service = {Servlet.class},
        property = {
                SLING_SERVLET_PATHS + "=/bin/aep/fpid",
                SLING_SERVLET_METHODS + "=GET"
        }
)
public class FpidServlet extends SlingAllMethodsServlet {
    private static final Logger log = LoggerFactory.getLogger(FpidServlet.class);
    private static final String COOKIE_NAME = "FPID";
    private static final String COOKIE_PATH = "/";
    private static final int COOKIE_MAX_AGE = 60 * 60 * 24 * 30 * 13;
    private static final String JSON_KEY = "fpid";

    @Override
    protected final void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) throws IOException {
        // Try to get an existing FPID cookie, this will give us the user's current FPID if it exists
        final Cookie existingCookie = request.getCookie(COOKIE_NAME);

        String cookieValue;

        if (existingCookie == null) {
            //  If no FPID cookie exists, Create a new FPID UUID
            cookieValue = UUID.randomUUID().toString();
        } else {
            // If a FPID cookie exists. get its FPID UUID so it's life can be extended
            cookieValue = existingCookie.getValue();
        }

        // Add the newly generate FPID value, or the extended FPID value to the response
        // Use addHeader(..), as we need to set SameSite=Lax (and addCoookie(..) does not support this)
        response.addHeader("Set-Cookie",
                COOKIE_NAME + "=" + cookieValue + "; " +
                        "Max-Age=" + COOKIE_MAX_AGE + "; " +
                        "Path=" + COOKIE_PATH + "; " +
                        "HttpOnly; " +
                        "Secure; " +
                        "SameSite=Lax");
        
        // Avoid caching the response in any cache
        response.addHeader("Cache-Control", "no-store");

        // Since the FPID is HttpOnly, JavaScript cannot read it (only the server can)
        // Write the FPID to the response as JSON so client JavaScript can access it.
        final JsonObject json = new JsonObject();
        json.addProperty(JSON_KEY, cookieValue);
        
        // The JSON `{ fpid: "11111111-2222-3333-4444-55555555" }` is returned in the response
        response.setContentType("application/json");
        response.getWriter().write(json.toString());
    }
}
```

### HTML script

En anpassad klientsidesbaserad JavaScript måste läggas till på sidan för att anropa servern asynkront, generera eller uppdatera FPID-cookien och returnera FPID i svaret.

Det här JavaScript-skriptet läggs till på sidan på något av följande sätt:

+ [Taggar i Adobe Experience Platform](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html)
+ [AEM klientbibliotek](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/full-stack/clientlibs.html?lang=en)

XHR-anropet till den anpassade AEM FPID-servern är snabbt, även om det är asynkront, så det är möjligt för en användare att besöka en webbsida som AEM och navigera bort innan begäran kan slutföras.
Om detta inträffar kommer samma process att försöka igen på nästa sida att läsa in en webbsida från AEM.

HTTP-GETEN till den AEM FPID-servern (`/bin/aep/fpid`) parametriseras med en slumpmässig frågeparameter för att säkerställa att eventuella infrastrukturer mellan webbläsaren och AEM Publish-tjänsten inte cachelagrar svaret från begäran.
På samma sätt läggs begärandehuvudet `Cache-Control: no-store` till för att det ska gå att undvika cachelagring.

Vid ett anrop av AEM FPID-server hämtas FPID från JSON-svaret och används av [Platform Web SDK](https://experienceleague.adobe.com/docs/platform-learn/implement-web-sdk/tags-configuration/install-web-sdk.html?lang=en) för att skicka det till Experience Platform API:er.

Mer information om [att använda FPID:n i identityMap finns i dokumentationen för Experience Platform ](https://experienceleague.adobe.com/docs/experience-platform/edge/identity/first-party-device-ids.html#identityMap)

```javascript
...
<script>
    // Invoke the AEM FPID servlet, and then do something with the response

    fetch(`/bin/aep/fpid?_=${new Date().getTime() + '' + Math.random()}`, { 
            method: 'GET',
            headers: {
                'Cache-Control': 'no-store'
            }
        })
        .then((response) => response.json())
        .then((data) => { 
            // Get the FPID from JSON returned by AEM's FPID servlet
            console.log('My FPID is: ' + data.fpid);

            // Send the `data.fpid` to Experience Platform APIs            
        });
</script>
```

### Dispatcher allow, filter

Till sist måste HTTP GET-begäranden till den anpassade FPID-servern tillåtas via AEM Dispatcher `filter.any`-konfiguration.

Om den här Dispatcher-konfigurationen inte implementeras korrekt resulterar HTTP GET-begäranden till `/bin/aep/fpid` i 404.

+ `dispatcher/src/conf.dispatcher.d/filters/filters.any`

```
/1099 { /type "allow" /method "GET" /url "/bin/aep/fpid" }
```

## Experience Platform resurser

Läs följande Experience Platform-dokumentation för FPID (First-party device ID) och hantering av identitetsdata med Platform Web SDK.

+ [Generera enhets-ID:n från första part](https://experienceleague.adobe.com/docs/platform-learn/data-collection/edge-network/generate-first-party-device-ids.html)
+ [Första parts enhets-ID i plattformens webb-SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/identity/first-party-device-ids.html)
+ [Identitetsdata i plattformens webb-SDK](https://experienceleague.adobe.com/docs/experience-platform/edge/identity/overview.html)
