---
title: Webboptimerad bildleverans Java&handel; API:er
description: Lär dig använda AEM as a Cloud Service webboptimerade Java&handel; API:er för att utveckla högpresterande webbupplevelser.
version: Experience Manager as a Cloud Service
feature: APIs, Sling Model, OSGI, HTL or HTML Template Language
topic: Performance, Development
role: Architect, Developer
level: Intermediate
doc-type: Code Sample
last-substantial-update: 2023-03-30T00:00:00Z
jira: KT-13014
thumbnail: KT-13014.jpeg
exl-id: c6bb9d6d-aef0-42d5-a189-f904bbbd7694
duration: 352
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '810'
ht-degree: 0%

---

# Webboptimerade Java™-API:er för bildleverans

Lär dig använda AEM as a Cloud Service webboptimerade Java™-API:er för bildleverans för att utveckla högpresterande webbupplevelser.

AEM as a Cloud Service stöder [webboptimerad bildleverans](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/web-optimized-image-delivery.html) som automatiskt genererar optimerade bildwebbåtergivningar av resurser. Webboptimerad bildleverans kan användas på tre sätt:

1. [Använd AEM Core WCM-komponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)
2. Skapa en anpassad komponent som [utökar avbildningskomponenten för AEM Core WCM-komponenten](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/custom-component.html#tackling-the-image-problem)
3. Skapa en anpassad komponent som använder AssetDelivery Java™ API för att generera webboptimerade bild-URL:er.

I den här artikeln utforskas hur du använder Java™-API:er för webboptimerade bilder i en anpassad komponent, på ett sätt som tillåter kodbaserad användning på både AEM as a Cloud Service och AEM SDK.

## Java™-API:er

[AssetDelivery API](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/com/adobe/cq/wcm/spi/AssetDelivery.html) är en OSGi-tjänst som genererar webboptimerade URL:er för leverans av bildresurser. `AssetDelivery.getDeliveryURL(...)` tillåtna alternativ [dokumenteras här](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/web-optimized-image-delivery.html#can-i-use-web-optimized-image-delivery-with-my-own-component%3F).

OSGi-tjänsten `AssetDelivery` är bara klar när den körs i AEM as a Cloud Service. I AEM SDK returneras `AssetDelivery` OSGi-tjänsten `null`. Det är bäst att villkorligt använda den webboptimerade URL:en när du kör på AEM as a Cloud Service och använda en URL för reservbild på AEM SDK. Resursens webbåtergivning är vanligtvis ett tillräckligt reservläge.


### API-användning i OSGi-tjänsten

Markera referensen `AssetDelivery` som valfri i anpassade OSGi-tjänster så att den anpassade OSGi-tjänsten fortfarande är tillgänglig i AEM SDK.

```java
import com.adobe.cq.wcm.spi.AssetDelivery;
...
@Reference(cardinality = ReferenceCardinality.OPTIONAL)
private volatile AssetDelivery assetDelivery;
```

### API-användning i Sling Model

Markera referensen `AssetDelivery` som valfri i anpassade modeller för Sling-modellerna så att den anpassade modellen för Sling-modellering fortfarande är tillgänglig i AEM SDK.

```java
import com.adobe.cq.wcm.spi.AssetDelivery;
...
@OSGiService(injectionStrategy = InjectionStrategy.OPTIONAL)
private AssetDelivery assetDelivery;
```

### Villkorlig användning av API

Returnera den webboptimerade bild-URL:en eller reservwebbadressen baserat på `AssetDelivery` OSGi-tjänstens tillgänglighet. Med den villkorliga användningen kan koden fungera när den körs i AEM SDK.

```java
if (assetDelivery != null ) {
    // When running on AEM as a Cloud Service use the real web-optimized image URL.
    return assetDelivery.getDeliveryURL(...);
} else {
    // When running on AEM SDK, use some fallback image so the experience does not break.
    // What the fallback is up to you! 
    return getFallbackURL(...);
}
```

## Exempelkod

I följande kod skapas en exempelkomponent som visar en lista med bildresurser med webboptimerade bild-URL:er.

När koden körs på AEM as a Cloud Service används webboptimerade bildåtergivningar i den anpassade komponenten.

![Webboptimerade bilder på AEM as a Cloud Service](./assets/web-optimized-image-delivery-java-apis/cloud-service.png)

_AEM as a Cloud Service stöder AssetDelivery API, så den webboptimerade återgivningen används_

När koden körs på AEM SDK används de mindre optimala statiska webbåtergivningarna, vilket gör att komponenten kan fungera under lokal utveckling.

![Webboptimerade reservbilder på AEM SDK](./assets/web-optimized-image-delivery-java-apis/aem-sdk.png)

_AEM SDK stöder inte AssetDelivery API, så den statiska standardwebbåtergivningen (PNG eller JPEG) används_

Implementeringen är uppdelad i tre logiska delar:

1. OSGi-tjänsten `WebOptimizedImage` fungerar som en&quot;smart proxy&quot; för den OSGi-tjänst som tillhandahålls av AEM och som kan hantera körning i både AEM as a Cloud Service och AEM SDK.`AssetDelivery`
2. Sling-modellen `ExampleWebOptimizedImages` innehåller affärslogik för att samla in listan över bildresurser och deras webboptimerade URL:er som ska visas.
3. AEM-komponenten `example-web-optimized-images` implementerar HTML för att visa listan över webboptimerade bilder.

Exempelkoden nedan kan kopieras i din kodbas och uppdateras vid behov.

### OSGi-tjänst

OSGi-tjänsten `WebOptimizedImage` delas upp i ett adresserbart offentligt gränssnitt (`WebOptimizedImage`) och en intern implementering (`WebOptimizedImageImpl`). `WebOptimizedImageImpl` returnerar en webboptimerad bild-URL när den körs på AEM as a Cloud Service, och en statisk webbåtergivnings-URL på AEM SDK, vilket gör att komponenten kan fortsätta fungera på AEM SDK.

#### Gränssnitt

Gränssnittet definierar det OSGi-serviceavtal som annan kod som Sling Models kan interagera med.

```java
package com.adobe.aem.guides.wknd.core.images;

import org.apache.sling.api.resource.ResourceResolver;
import org.osgi.annotation.versioning.ProviderType;

import java.util.Map;

/**
 * OSGi Service that acts as a facade for the AssetDelivery API, such that a fallback can be automatically served on the AEM SDK.
 *
 * This service can be extended to provide additional functionality, such as srcsets, etc.
 */
@ProviderType
public interface WebOptimizedImage {
    /**
     * Returns the Web Optimized Image URL.
     * @param resourceResolver the user's resource resolver
     * @param path the path to the asset
     * @param options the options to pass to the AssetDelivery API
     * @return the Web Optimized Image URL
     */
    String getDeliveryURL(ResourceResolver resourceResolver, String path, Map<String, Object> options);
}
```

#### Implementering

Implementeringen av OSGi-tjänsten innehåller en valfri referens till AEM `AssetDelivery` OSGi-tjänsten och reservlogik för att välja en lämplig bild-URL när `AssetDelivery` är `null` på AEM SDK. Reservlogiken kan uppdateras baserat på krav.

```java
package com.adobe.aem.guides.wknd.core.images.impl;

import com.adobe.aem.guides.wknd.core.images.WebOptimizedImage;
import com.adobe.cq.wcm.spi.AssetDelivery;
import com.day.cq.dam.api.Asset;
import com.day.cq.dam.api.Rendition;
import com.day.cq.dam.api.RenditionPicker;
import com.day.cq.dam.commons.util.DamUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;

import java.util.Map;
@Component
public class WebOptimizedImageImpl implements WebOptimizedImage {
    private static final String DEFAULT_FORMAT = "webp";
    @Reference(cardinality = ReferenceCardinality.OPTIONAL)
    private volatile AssetDelivery assetDelivery;

    /**
     * Returns the Web Optimized Image URL.
     * @param resourceResolver the user's resource resolver
     * @param path the path to the asset
     * @param options the options to pass to the AssetDelivery API
     * @return the Web Optimized Image URL
     */
    @Override
    public String getDeliveryURL(ResourceResolver resourceResolver, String path, Map<String, Object> options) {
        if (assetDelivery != null) {
            return getWebOptimizedUrl(resourceResolver, path, options);
        } else {
            return getFallbackUrl(resourceResolver, path);
        }
    }
    /**
     * Uses the AssetDelivery API to get the Web Optimized Image URL.
     * @param resourceResolver the user's resource resolver
     * @param path the path to the asset
     * @param options the options to pass to the AssetDelivery API
     * @return the Web Optimized Image URL
     */
    private String getWebOptimizedUrl(ResourceResolver resourceResolver, String path, Map<String, Object> options) {
        Resource resource = resourceResolver.getResource(path);
        Asset asset = DamUtil.resolveToAsset(resource);

        // These 3 options are required for the AssetDelivery API to work, else it will return null
        options.put("path", asset.getPath());
        options.put("format", StringUtils.defaultString((String) options.get("format"), DEFAULT_FORMAT));
        options.put("seoname", StringUtils.defaultString((String) options.get("seoname"), asset.getName()));

        // The resource only provides the security context into AEM so the asset's UUID can be looked up for the Web Optimized Image URL
        return assetDelivery.getDeliveryURL(resource, options);
    }

    /**
     * Fallback to the static web rendition if the AssetDelivery API is not available, meaning the code is running on the AEM SDK.
     * @param resourceResolver the user's resource resolver
     * @param path the path to the asset
     * @return the path to the web rendition
     */
    private String getFallbackUrl(ResourceResolver resourceResolver, String path) {
        Resource resource = resourceResolver.getResource(path);
        Asset asset = DamUtil.resolveToAsset(resource);

        return asset.getRendition(WebRenditionPicker).getPath();
    }

    /**
     * Picks the web rendition of the asset.
     */
    private static final RenditionPicker WebRenditionPicker = new RenditionPicker() {
        @Override
        public Rendition getRendition(Asset asset) {
            return asset.getRenditions().stream().filter(rendition -> StringUtils.startsWith(rendition.getName(), "cq5dam.web.")).findFirst().orElse(asset.getOriginal());
        }
    };
}
```

### Sling Model

Sling-modellen `ExampleWebOptimizedImages` delas upp i ett adresserbart offentligt gränssnitt (`ExampleWebOptimizedImages`) och en intern implementering (`ExampleWebOptimizedImagesImpl`);

Sling-modellen `ExampleWebOptimizedImagesImpl` samlar in listan över bildresurser som ska visas och anropar den anpassade OSGi-tjänsten `WebOptimizedImage` för att hämta den webboptimerade bild-URL:en. Eftersom den här delningsmodellen representerar en AEM-komponent har den de vanliga metoderna, som `isEmpty()`, `getId()` och `getData()` , men dessa metoder är inte direkt relevanta för användning av webboptimerade bilder.

#### Gränssnitt

Gränssnittet definierar det Sling Model-kontrakt som annan kod, till exempel HTML, kan interagera med.

```java
package com.adobe.aem.guides.wknd.core.models;

import com.adobe.cq.wcm.core.components.models.datalayer.ComponentData;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public interface ExampleWebOptimizedImages {

    /**
     * @return a list of web optimized images for the component to display. Each item in the list has necessary information to render the image.
     */
    List<Img> getImages();

    /**
     * @return true if this component has no images to display.
     */
    boolean isEmpty();

    /**
     * @return String representing the unique identifier of the ExampleWebOptimizedImages component on a page
     */
    String getId();

    /**
     * @return JSON data to populate the data layer
     */
    @JsonProperty("dataLayer")
    default ComponentData getData() {
        return null;
    }

    /**
     * Describes a web optimized image.
     */
    interface Img {
        /**
         * @return the URL to the web optimized rendition of the image.
         */
        String getSrc();

        /**
         * @return the alt text of the web optimized image.
         */
        String getAlt();

        /**
         * @return the height of the web optimized image.
         */
        String getHeight();
        /**
         * @return the width of the web optimized image.
         */
        String getWidth();
    }
}
```

#### Implementering

Sling Model använder den anpassade `WebOptimizeImage` OSGi-tjänsten för att samla in webboptimerade bild-URL:er för de bildresurser som komponenten visar.

I det här exemplet används en enkel fråga för att samla in bildresurser.

```java
package com.adobe.aem.guides.wknd.core.models.impl;

import com.adobe.aem.guides.wknd.core.images.WebOptimizedImage;
import com.adobe.aem.guides.wknd.core.models.ExampleWebOptimizedImages;
import com.adobe.cq.wcm.core.components.models.datalayer.ComponentData;
import com.adobe.cq.wcm.core.components.models.datalayer.builder.DataLayerBuilder;
import com.adobe.cq.wcm.core.components.util.ComponentUtils;
import com.day.cq.dam.api.Asset;
import com.day.cq.dam.commons.util.DamUtil;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.components.ComponentContext;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.models.annotations.DefaultInjectionStrategy;
import org.apache.sling.models.annotations.Model;
import org.apache.sling.models.annotations.Required;
import org.apache.sling.models.annotations.injectorspecific.OSGiService;
import org.apache.sling.models.annotations.injectorspecific.ScriptVariable;
import org.apache.sling.models.annotations.injectorspecific.Self;

import java.util.*;

@Model(
        adaptables = {SlingHttpServletRequest.class},
        adapters = {ExampleWebOptimizedImages.class},
        resourceType = {ExampleWebOptimizedImagesImpl.RESOURCE_TYPE},
        defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL
)
public class ExampleWebOptimizedImagesImpl implements ExampleWebOptimizedImages {

    protected static final String RESOURCE_TYPE = "wknd/components/example-web-optimized-images";

    private static final int MAX_RESULTS = 10;

    @Self
    @Required
    private SlingHttpServletRequest request;

    @OSGiService
    private WebOptimizedImage webOptimizedImage;

    @ScriptVariable
    private Page currentPage;

    @ScriptVariable
    protected ComponentContext componentContext;

    private List<Img> images;

    // XPath query to find image assets to display
    private static final String XPATH_QUERY = "/jcr:root/content/dam/wknd-shared/en/adventures//element(*, dam:Asset) [ (jcr:contains(jcr:content/metadata/@dc:format, 'image/')) ]";
    @Override
    public List<Img> getImages() {

        if (images == null) {
            images = new ArrayList<>();

            // Set the AssetDelivery options to request a web-optimized rendition.
            // These options can be set as required by the implementation (Dialog, pass in from HTL via @RequestAttribute)
            final Map<String, Object> options = new HashMap<>();
            options.put("format", "webp");
            options.put("preferwebp", "true");
            options.put("width", "350");
            options.put("height", "350");

            final Iterator<Resource> results = request.getResourceResolver().findResources(XPATH_QUERY, "xpath");

            while (results.hasNext() && images.size() < MAX_RESULTS) {
                Resource resource = results.next();
                Asset asset = DamUtil.resolveToAsset(resource);

                // Get the image URL; the web-optimized rendition on AEM as a Cloud Service, or the static web rendition fallback on AEM SDK
                final String url = webOptimizedImage.getDeliveryURL(request.getResourceResolver(), resource.getPath(), options);

                // Add the image to the list that is passed to the HTL component to display
                // We'll add some extra attributes so that the HTL can display the image in a performant, SEO-friendly, and accessible way
                // ImgImpl can be extended to add additional attributes, such as srcset, etc.
                images.add(new ImgImpl(url, asset.getName(), (String) options.get("height"), (String) options.get("width")));
            }
        }

        return this.images;
    }

    @Override
    public boolean isEmpty() {
        return getImages().isEmpty();
    }

    @Override
    public String getId() {
        return ComponentUtils.getId(request.getResource(), currentPage, componentContext);
    }

    @Override
    public ComponentData getData() {
        if (ComponentUtils.isDataLayerEnabled(request.getResource())) {
            return DataLayerBuilder.forComponent()
                    .withId(() -> getId())
                    .withType(() -> RESOURCE_TYPE)
                    .build();
        }
        return null;
    }

    class ImgImpl implements Img {
        private final String url;
        private final String alt;
        private final int height;
        private final int width;

        public ImgImpl(String url, String alt, String height, String width) {
            this.url = url;
            this.alt = alt;
            this.height = Integer.parseInt(height);
            this.width = Integer.parseInt(width);
        }

        @Override
        public String getSrc() {
            return url;
        }

        @Override
        public String getAlt() {
            return alt;
        }

        @Override
        public String getHeight() {
            return height + "px";
        }

        @Override
        public String getWidth() {
            return width + "px";
        }
    }
}
```

### AEM Component

En AEM-komponent är bunden till Sling-resurstypen för implementeringen av `WebOptimizedImagesImpl` Sling Model och ansvarar för att visa listan med bilder.



Komponenten får en lista över `Img` objekt via `getImages()` som innehåller de webboptimerade WEBP-bilderna när de körs i AEM as a Cloud Service. Komponenten får en lista över `Img` objekt via `getImages()` som innehåller statiska PNG-/JPEG-webbilder när de körs på AEM SDK.

#### HTL

HTML använder `WebOptimizedImages`-delningsmodellen och återger listan med `Img` objekt som returneras av `getImages()`.

```html
<style>
    .cmp-example-web-optimized-images__list {
        width: 100%;
        list-style: none;
        padding: 0;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        gap: 2rem;
    }

    .cmp-example-web-optimized-images-list__item {
        margin: 0;
        padding: 0;
    }
</style>

<div data-sly-use.exampleImages="com.adobe.aem.guides.wknd.core.models.ExampleWebOptimizedImages"
     data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
     data-sly-test.hasContent="${!exampleImages.empty}"
     data-cmp-data-layer="${exampleImages.data.json}">

    <h3>Example web-optimized images</h3>

    <ul class="cmp-example-web-optimized-images__list"
        data-sly-list.item="${exampleImages.images}">
        <li class="cmp-example-web-optimized-images-list__item">
            <img class="cmp-example-web-optimized-images__image"
                 src="${item.src}"
                 alt="${item.alt}"
                 width="${item.width}"/>
        </li>
    </ul>
</div>
<sly data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!hasContent, classAppend='cmp-example-web-optimized-images'}"></sly>
```
