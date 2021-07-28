---
title: OSGi Component Lifecycle
description: Läs om OSGi-komponentens livscykel, inklusive hur du binder en OSGi-tjänst till händelserna activate, modified och deactivate lifecycle.
role: Developer
level: Beginner
topic: Utveckling
kt: 8228
thumbnail: 335475.jpeg
source-git-commit: 680043f5717bf938bf6f0b960d9ed5939d13544c
workflow-type: tm+mt
source-wordcount: '95'
ht-degree: 3%

---


# OSGi-komponentens livscykel

Läs om OSGi-komponenternas livscykel, inklusive hur du binder en OSGi-tjänst till:

+ Aktivera
+ Ändrad
+ och inaktivera

...livscykelhändelser.

>[!VIDEO](https://video.tv.adobe.com/v/335475/?quality=12&learn=on)

## Resurser

+ [@Aktivera JavaDocs](https://javadoc.io/static/com.adobe.aem/aem-sdk-api/2021.7.5658.20210723T140305Z-210600/org/osgi/service/component/annotations/Activate.html)
+ [@Modified JavaDocs](https://javadoc.io/static/com.adobe.aem/aem-sdk-api/2021.7.5658.20210723T140305Z-210600/org/osgi/service/component/annotations/Modified.html)
+ [@Inaktivera JavaDocs](https://javadoc.io/static/com.adobe.aem/aem-sdk-api/2021.7.5658.20210723T140305Z-210600/org/osgi/service/component/annotations/Deactivate.html)

## Kod

### ActivitiesImpl.java

`/core/src/main/java/com/adobe/aem/wknd/examples/core/adventures/impl/ActivitiesImpl.java`

```java
package com.adobe.aem.wknd.examples.core.adventures.impl;

import java.util.Random;

import com.adobe.aem.wknd.examples.core.adventures.Activities;

import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(
    service = { Activities.class }
)
public class ActivitiesImpl implements Activities {
    private static final Logger log = LoggerFactory.getLogger(ActivitiesImpl.class);

    private String[] activities;

    private final Random random = new Random();

    /**
     * @return the name of a random WKND adventure activity
     */
    public String getRandomActivity() {
        int randomIndex = random.nextInt(activities.length);
        return activities[randomIndex];
    }    

    @Activate
    protected void activate() {
        this.activities = new String[] { 
            "Running", "Cycling",  "Skateboarding"
        };

        log.info("Activated ActivitiesImpl with activities [ {} ]", String.join(", ", this.activities));
    }

    @Deactivate
    protected void deactivate() {
        log.info("ActivitiesImpl has been deactivated!");
    }
}
```
