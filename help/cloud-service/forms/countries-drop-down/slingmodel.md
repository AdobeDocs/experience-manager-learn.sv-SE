---
title: Skapa en segmentmodell för komponenten
description: Skapa en segmentmodell för komponenten
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16517
exl-id: f4a18f02-61a2-4fa3-bfbb-41bf696cd2a8
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '384'
ht-degree: 0%

---

# Skapa en segmentmodell för komponenten

En Sling Model i AEM är ett Java-baserat ramverk som används för att förenkla utvecklingen av back end-logik för komponenter. Det gör att utvecklare kan mappa data från AEM-resurser (JCR-noder) till Java-objekt med hjälp av anteckningar, vilket ger ett rent och effektivt sätt att hantera dynamiska data för komponenter.
Den här klassen, CountryDropDownImpl, är en implementering av gränssnittet CountryDropDown i ett AEM-projekt (Adobe Experience Manager). Den gör det möjligt för en nedrullningsbar komponent där användarna kan välja ett land baserat på den valda kontinenten. Listrutedata läses in dynamiskt från en JSON-fil som lagras i AEM DAM (Digital Asset Manager).

**Fält i klassen**

* **multiSelect**: Anger om listrutan tillåter flera markeringar.
Inmatad från komponentegenskaperna med @ValueMapValue med standardvärdet false.
* **begäran**: Representerar den aktuella HTTP-begäran. Användbar för att komma åt sammanhangsspecifik information.
* **kontinent**: Lagrar den markerade kontinenten för listrutan (t.ex. &quot;asia&quot;, &quot;europe&quot;).
Inmatad från komponentens egenskapsdialogruta, med standardvärdet &quot;asia&quot; om ingen anges.
* **resourceResolver**:Används för att komma åt och ändra resurser i AEM-databasen.
* **jsonData**: Ett JSONObject som lagrar tolkade data från JSON-filen som motsvarar den valda kontinenten.

**Metoder i klassen**

* **getContinent()** En enkel metod för att returnera värdet för fältet på kontinenten.
Loggar värdet som returneras i felsökningssyfte.
* **init()** Lifecycle-metoden kommenterad med @PostConstruct, utförd efter att klassen har konstruerats och beroenden har injicerats. Skapar dynamiskt sökvägen till JSON-filen baserat på kontinentalvärdet.
Hämtar JSON-filen från AEM DAM med resourceResolver.
Anpassar filen till en resurs, läser dess innehåll och tolkar den till ett JSONObject.
Loggar eventuella fel eller varningar under den här processen.
* **getEnums()** Hämtar alla nycklar (landskoder) från de tolkade JSON-data.
Sorterar nycklarna i bokstavsordning och returnerar dem som en array.
Loggar antalet landskoder som returneras.
* **getEnumNames()** Extraherar alla landsnamn från tolkade JSON-data.
Sorterar namnen i bokstavsordning och returnerar dem som en array.
Loggar det totala antalet länder och varje hämtat landsnamn.
* **isMultiSelect()** Returnerar värdet för multiSelect-fältet för att ange om listrutan tillåter flera val.



```java
package com.aem.customcorecomponent.core.models.impl;
import com.adobe.cq.export.json.ComponentExporter;
import com.adobe.cq.export.json.ExporterConstants;
import com.adobe.cq.forms.core.components.internal.form.ReservedProperties;
import com.adobe.cq.forms.core.components.util.AbstractOptionsFieldImpl;
import com.aem.customcorecomponent.core.models.CountriesDropDown;
import com.day.cq.dam.api.Asset;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.models.annotations.Default;
import org.apache.sling.models.annotations.Exporter;
import org.apache.sling.models.annotations.Model;
import org.apache.sling.models.annotations.injectorspecific.InjectionStrategy;
import org.apache.sling.models.annotations.injectorspecific.ValueMapValue;
import org.json.JSONObject;
import javax.annotation.PostConstruct;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;

//@Model(adaptables = SlingHttpServletRequest.class,adapters = CountriesDropDown.class,defaultInjectionStrategy = DefaultInjectionStrategy.OPTIONAL)

@Model(
        adaptables = { SlingHttpServletRequest.class, Resource.class },
        adapters = { CountriesDropDown.class,
                ComponentExporter.class },
        resourceType = { "corecomponent/components/adaptiveForm/countries" })
@Exporter(name = ExporterConstants.SLING_MODEL_EXPORTER_NAME, extensions = ExporterConstants.SLING_MODEL_EXTENSION)

public class CountriesDropDownImpl extends AbstractOptionsFieldImpl implements CountriesDropDown {
    @ValueMapValue(injectionStrategy = InjectionStrategy.OPTIONAL, name = ReservedProperties.PN_MULTISELECT)
    @Default(booleanValues = false)
    protected boolean multiSelect;

    private static final Logger logger = LoggerFactory.getLogger(CountriesDropDownImpl.class);
    @Inject
    SlingHttpServletRequest request;

    @Inject
    @Default(values = "asia")
    public String continent;
    @Inject
    private ResourceResolver resourceResolver;
    private JSONObject jsonData;
    public String getContinent()
    {
        logger.info("Returning continent");
        return continent;
    }
    @PostConstruct
    public void init() {

        String jsonPath = "/content/dam/corecomponent/" + getContinent() + ".json"; // Update path as needed
        logger.info("Initializing JSON data for continent: {}", getContinent());

        try {
            // Fetch the JSON resource
            Resource jsonResource = resourceResolver.getResource(jsonPath);
            if (jsonResource != null) {
                // Adapt the resource to an Asset
                Asset asset = jsonResource.adaptTo(Asset.class);
                if (asset != null) {
                    // Get the original rendition and parse it as JSON
                    try (InputStream inputStream = asset.getOriginal().adaptTo(InputStream.class);
                         BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {

                        String jsonString = reader.lines().collect(Collectors.joining());
                        jsonData = new JSONObject(jsonString);
                        logger.info("Successfully loaded JSON data for path: {}", jsonPath);
                    }
                } else {
                    logger.warn("Failed to adapt resource to Asset at path: {}", jsonPath);
                }
            } else {
                logger.warn("Resource not found at path: {}", jsonPath);
            }
        } catch (Exception e) {
            logger.error("An error occurred while initializing JSON data for path: {}", jsonPath, e);
        }
    }

    @Override
    public Object[] getEnums() {
        Set<String> keySet = jsonData.keySet();


// Convert the set of keys to a sorted array
        String[] countryCodes = keySet.toArray(new String[0]);
        Arrays.sort(countryCodes);

        logger.debug("Returning sorted country codes: " + countryCodes.length);

        return countryCodes;


    }

    @Override
    public String[] getEnumNames() {
        String[] countries = new String[jsonData.keySet().size()];
        logger.info("Fetching countries - Total number: " + countries.length);

// Populate the array with country names
        int index = 0;
        for (String code : jsonData.keySet()) {
            String country = jsonData.getString(code);
            logger.debug("Retrieved country: " + country);
            countries[index++] = country;
        }

// Sort the array alphabetically
        Arrays.sort(countries);
        logger.debug("Returning " + countries.length + " sorted countries");

        return countries;

    }

    @Override
    public Boolean isMultiSelect() {
        return multiSelect;
    }
}
```

## Nästa steg

[Bygg, driftsätt och testa](./build.md)
