---
title: Cachelagra sidvarianter med AEM as a Cloud Service
description: Lär dig hur du konfigurerar och använder AEM som en molntjänst för att stödja cachelagring av sidvarianter.
role: Architect, Developer
topic: Development
feature: CDN Cache, Dispatcher
exl-id: fdf62074-1a16-437b-b5dc-5fb4e11f1355
duration: 172
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '551'
ht-degree: 0%

---

# Cachelagrar sidvarianter

Lär dig hur du konfigurerar och använder AEM som en molntjänst för att stödja cachelagring av sidvarianter.

## Exempel på användningsområden

+ Alla tjänsteleverantörer som erbjuder en annan uppsättning tjänster och motsvarande prisalternativ baserade på användarens geografiska plats och cachen med sidor med dynamiskt innehåll bör hanteras på CDN och Dispatcher.

+ En kund hos detaljhandeln har butiker i hela landet och varje butik har olika erbjudanden beroende på var de finns och cachen med sidor med dynamiskt innehåll bör hanteras på CDN och Dispatcher.

## Översikt över lösningar

+ Identifiera variantnyckeln och antalet värden som den kan ha. I vårt exempel varierar vi mellan olika delstater, så det högsta antalet är 50. Detta är tillräckligt litet för att inte orsaka problem med variantgränserna vid CDN. [Granska avsnittet med variantbegränsningar](#variant-limitations).

+ AEM måste ange cookie-filen __&quot;x-aem-variant&quot;__ till besökarens önskade tillstånd (t.ex. `Set-Cookie: x-aem-variant=NY`) på den initiala HTTP-begärans motsvarande HTTP-svar.

+ Efterföljande förfrågningar från besökaren skickar den cookien (t.ex. `"Cookie: x-aem-variant=NY"`) och cookien omvandlas på CDN-nivå till ett fördefinierat huvud (dvs. `x-aem-variant:NY`) som skickas till avsändaren.

+ En regel för omskrivning av Apache ändrar sökvägen till begäran så att den inkluderar rubrikvärdet i sidans URL som en Apache Sling-väljare (t.ex. `/page.variant=NY.html`). Detta gör att AEM kan leverera olika innehåll baserat på väljaren och avsändaren kan cachelagra en sida per variant.

+ Svaret som skickas av AEM Dispatcher måste innehålla en HTTP-svarshuvud `Vary: x-aem-variant`. Detta instruerar CDN att lagra olika cachekopior för olika rubrikvärden.

>[!TIP]
>
>När en cookie anges (t.ex. Set-Cookie: x-aem-variant=NY) svaret ska inte vara tillgängligt (ska ha Cache-Control: private eller Cache-Control: no-cache)

## HTTP-begärandeflöde

![Begäranflöde för variantcache](./assets/variant-cache-request-flow.png)

>[!NOTE]
>
>Det inledande flödet för HTTP-begäran ovan måste ske innan innehåll som använder varianter kan begäras.

## Användning

1. För att demonstrera funktionen använder vi [WKND](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html)implementering som ett exempel.

1. Implementera en [SlingServletFilter](https://sling.apache.org/documentation/the-sling-engine/filters.html) i AEM att ange `x-aem-variant` cookie på HTTP-svaret, med ett variantvärde.

1. AEM CDN omformas automatiskt `x-aem-variant` cookie till en HTTP-rubrik med samma namn.

1. Lägg till en Apache Web Server-mod_rewrite-regel i din `dispatcher` -projekt, som ändrar begärandesökvägen så att den innehåller variantväljaren.

1. Distribuera filtret och skriv om regler med hjälp av Cloud Manager.

1. Testa det övergripande begärandeflödet.

## Kodexempel

+ Exempel på SlingServletFilter som ska anges `x-aem-variant` cookie med ett värde i AEM.

  ```
  package com.adobe.aem.guides.wknd.core.servlets.filters;
  
  import javax.servlet.*;
  import java.io.IOException;
  
  import org.apache.sling.api.SlingHttpServletRequest;
  import org.apache.sling.api.SlingHttpServletResponse;
  import org.apache.sling.servlets.annotations.SlingServletFilter;
  import org.apache.sling.servlets.annotations.SlingServletFilterScope;
  import org.osgi.service.component.annotations.Component;
  import org.slf4j.Logger;
  import org.slf4j.LoggerFactory;
  
  
  // Invoke filter on  HTTP GET /content/wknd.*.foo|bar.html|json requests.
  // This code and scope is for example purposes only, and will not interfere with other requests.
  @Component
  @SlingServletFilter(scope = {SlingServletFilterScope.REQUEST},
          resourceTypes = {"cq:Page"},
          pattern = "/content/wknd/.*",
          extensions = {"html", "json"},
          methods = {"GET"})
  public class PageVariantFilter implements Filter {
      private static final Logger log = LoggerFactory.getLogger(PageVariantFilter.class);
      private static final String VARIANT_COOKIE_NAME = "x-aem-variant";
  
      @Override
      public void init(FilterConfig filterConfig) throws ServletException { }
  
      @Override
      public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
          SlingHttpServletResponse slingResponse = (SlingHttpServletResponse) servletResponse;
          SlingHttpServletRequest slingRequest = (SlingHttpServletRequest) servletRequest;
  
          // Check is the variant was previously set
          final String existingVariant = slingRequest.getCookie(VARIANT_COOKIE_NAME).getValue();
  
          if (existingVariant == null) {
              // Variant has not been set, so set it now
              String newVariant = "NY"; // Hard coding as an example, but should be a calculated value
              slingResponse.setHeader("Set-Cookie", VARIANT_COOKIE_NAME + "=" + newVariant + "; Path=/; HttpOnly; Secure; SameSite=Strict");
              log.debug("x-aem-variant cookie is set with the value {}", newVariant);
          } else {
              log.debug("x-aem-variant previously set with value {}", existingVariant);
          }
  
          filterChain.doFilter(servletRequest, slingResponse);
      }
  
      @Override
      public void destroy() { }
  }
  ```

+ Exempelregel för omskrivning i __dispatcher/src/conf.d/rewrite.rules__ som hanteras som källkod i Git och distribueras med Cloud Manager.

  ```
  ...
  
  RewriteCond %{REQUEST_URI} ^/us/.*  
  RewriteCond %{HTTP:x-aem-variant} ^.*$  
  RewriteRule ^([^?]+)\.(html.*)$ /content/wknd$1.variant=%{HTTP:x-aem-variant}.$2 [PT,L] 
  
  ...
  ```

## Variantbegränsningar

+ AEM kan hantera upp till 200 varianter. Det betyder att `x-aem-variant` kan ha upp till 200 unika värden. Mer information finns i [CDN-konfigurationsgränser](https://docs.fastly.com/en/guides/resource-limits).

+ Var noga med att se till att din valda variantnyckel aldrig överstiger detta antal.  Ett användar-ID är till exempel inte en bra nyckel eftersom det enkelt skulle överskrida 200 värden för de flesta webbplatser, medan delstaterna/territorierna i ett land passar bättre om det finns färre än 200 delstater i det landet.

>[!NOTE]
>
>När varianterna överstiger 200 kommer CDN att svara med&quot;för många varianter&quot; i stället för sidinnehållet.
