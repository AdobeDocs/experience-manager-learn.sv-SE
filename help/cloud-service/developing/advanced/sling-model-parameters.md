---
title: Parametrisera segmenteringsmodeller från HTML
description: Lär dig hur du skickar parametrar från HTML till en Sling-modell i AEM.
version: Cloud Service
topic: Development
feature: Sling Model
role: Developer
jira: KT-15923
level: Intermediate, Experienced
exl-id: 5d852617-720a-4a00-aecd-26d0ab77d9b3
source-git-commit: ba744f95f8d1f0b982cd5430860f0cb0945a4cda
workflow-type: tm+mt
source-wordcount: '264'
ht-degree: 0%

---

# Parametrisera segmenteringsmodeller från HTML

Adobe Experience Manager (AEM) erbjuder ett robust ramverk för att skapa dynamiska och anpassningsbara webbapplikationer. En av de kraftfulla funktionerna är möjligheten att parametrisera Sling-modeller, vilket ökar deras flexibilitet och återanvändbarhet. Den här självstudiekursen vägleder dig genom att skapa en parametriserad delningsmodell och använda den i HTML (HTML Template Language) för att återge dynamiskt innehåll.

## HTL-skript

I det här exemplet skickar HTML-skriptet två parametrar till `ParameterizedModel`-segmentsmodellen. Modellen ändrar parametrarna i metoden `getValue()` och returnerar resultatet för visning.

I det här exemplet skickas två String-parametrar, men du kan skicka vilken typ av värde eller objekt som helst till Sling Model, så länge som fälttypen [Sling Model, som kommenteras med `@RequestAttribute`](#sling-model-implementation), matchar den typ av objekt eller värde som skickas från HTML.

```html
<sly data-sly-use.myModel="${'com.example.core.models.ParameterizedModel' @ myParameterOne='Hello', myParameterTwo='World'}"
     data-sly-test.isReady="${myModel.isReady()}">

    <p>
        ${myModel.value}
    </p>

</sly>

<sly data-sly-use.placeholderTemplate="core/wcm/components/commons/v1/templates.html"
     data-sly-call="${placeholderTemplate.placeholder @ isEmpty=!isReady}">
</sly>
```

- **Parameterisering:** Programsatsen `data-sly-use` skapar en instans av `ParameterizedModel` med `myParameterOne` och `myParameterTwo`.
- **Villkorlig återgivning:** `data-sly-test` kontrollerar om modellen är klar innan innehållet visas.
- **Platshållaranrop:** `placeholderTemplate` hanterar fall där modellen inte är klar.

## Sling Model-implementering

Så här implementerar du Sling Model:

```java
package com.example.core.models.impl;

import org.apache.commons.lang3.StringUtils;
import org.apache.sling.api.SlingHttpServletRequest;
import org.osgi.service.component.annotations.Model;
import org.osgi.service.component.annotations.RequestAttribute;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Model(
    adaptables = { SlingHttpServletRequest.class },
    adapters = { ParameterizedModel.class }
)
public class ParameterizedModelImpl implements ParameterizedModel {
    private static final Logger log = LoggerFactory.getLogger(ParameterizedModelImpl.class);

    // Use the @RequestAttribute annotation to inject the parameter set in the HTL.
    // Note that the Sling Model field can be any type, but must match the type of object or value passed from HTL.
    @RequestAttribute
    private String myParameterOne;

    // If the HTL parameter name is different from the Sling Model field name, use the name attribute to specify the HTL parameter name
    @RequestAttribute(name = "myParameterTwo")
    private String mySecondParameter;

    // Do some work with the parameter values
    @Override
    public String getValue() {
        return myParameterOne + " " + mySecondParameter + ", from the parameterized Sling Model!";
    }

    @Override
    public boolean isReady() {
        return StringUtils.isNotBlank(myParameterOne) && StringUtils.isNotBlank(mySecondParameter);
    }
}
```

- **Modellanteckning:** Anteckningen `@Model` anger den här klassen som en segmenteringsmodell, kan anpassas från `SlingHttpServletRequest` och implementerar gränssnittet `ParameterizedModel`.
- **Attribut för begäran:** Anteckningen `@RequestAttribute` infogar HTML-parametrar i modellen.
- **Metoder:** `getValue()` sammanfogar parametrarna och `isReady()` kontrollerar att parametrarna inte är tomma.

Gränssnittet `ParameterizedModel` definieras så här:

```java
package com.example.core.models;

import org.osgi.annotation.versioning.ConsumerType;

@ConsumerType
public interface ParameterizedModel {
    /**
     * Get an example string value from the model. This value is the concatenation of the two parameters.
     * 
     * @return the value of the model
     */
    String getValue();

    /**
     * Check if the model is ready to be used.
     *
     * @return {@code true} if the model is ready, {@code false} otherwise
     */
    boolean isReady();
}
```

## Exempelutdata

Med parametrarna `"Hello"` och `"World"` genererar HTL-skriptet följande utdata:

```html
<p>
    Hello World, from the parameterized Sling Model!
</p>
```

Detta visar hur parametriserade Sling-modeller i AEM kan påverkas baserat på indataparametrar som tillhandahålls via HTML.
