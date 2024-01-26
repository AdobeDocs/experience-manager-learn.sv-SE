---
title: OSGi-konfigurationer som ObjectClassDefinition-objekt
description: Lär dig hur du skapar och anger ObjectClassDefinitions som OSGi-konfigurationsrepresentationer i en OSGi-tjänst
role: Developer
level: Beginner
topic: Development
feature: OSGI
jira: KT-8269
thumbnail: 335730.jpeg
exl-id: 72918da0-d5c4-4451-8082-0a0435c28890
duration: 700
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '56'
ht-degree: 1%

---

# OSGi-konfigurationer som ObjectClassDefinition-objekt

Lär dig hur du skapar och anger ObjectClassDefinitions som OSGi-konfigurationsrepresentationer i en OSGi-tjänst.

>[!VIDEO](https://video.tv.adobe.com/v/335730?quality=12&learn=on)

## Resurser

+ [@Utse JavaDocs](https://javadoc.io/static/com.adobe.aem/aem-sdk-api/2021.7.5658.20210723T140305Z-210600/org/osgi/service/metatype/annotations/Designate.html)
+ [@ObjectClassDefinition JavaDocs](https://javadoc.io/static/com.adobe.aem/aem-sdk-api/2021.7.5658.20210723T140305Z-210600/org/osgi/service/metatype/annotations/ObjectClassDefinition.html)
+ [@Attributdefinition JavaDocs](https://javadoc.io/static/com.adobe.aem/aem-sdk-api/2021.7.5658.20210723T140305Z-210600/org/osgi/service/metatype/annotations/AttributeDefinition.html)
+ [@Aktivera JavaDocs](https://javadoc.io/static/com.adobe.aem/aem-sdk-api/2021.7.5658.20210723T140305Z-210600/org/osgi/service/component/annotations/Activate.html)

## Code

### ActivitiesImpl.java

`/core/src/main/java/com/adobe/aem/wknd/examples/core/adventures/impl/ActivitiesImpl.java`

```java
package com.adobe.aem.wknd.examples.core.adventures.impl;

import java.util.Random;

import com.adobe.aem.wknd.examples.core.adventures.Activities;

import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.metatype.annotations.AttributeDefinition;
import org.osgi.service.metatype.annotations.Designate;
import org.osgi.service.metatype.annotations.ObjectClassDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(
    service = { Activities.class }
)
@Designate(ocd = ActivitiesImpl.Config.class)
public class ActivitiesImpl implements Activities {
    private static final Logger log = LoggerFactory.getLogger(ActivitiesImpl.class);

    @ObjectClassDefinition(
        name = "WKND Examples - Activities Service",
        description = "OSGi Service providing information about WKND Adventures activities"
    )
    @interface Config {

        @AttributeDefinition(
            name = "WKND Activities",
            description = "Human-friendly list of activity names"
        )
        String[] activities() default { "Hiking", "Jogging", "Walking" };

        @AttributeDefinition(
            name = "Random Activity Seed",
            description = "Seed used to randomize activity selection"
        )
        int random_seed() default 10;

    }

    private String[] activities;

    private Random random;

    /**
     * @return the name of a random WKND adventure activity
     */
    public String getRandomActivity() {
        int randomIndex = random.nextInt(activities.length);
        return activities[randomIndex];
    }    

    @Activate
    protected void activate(Config config) {

        this.activities = config.activities();

        final int randomSeed = config.random_seed(); 
          
        this.random = new Random(randomSeed);

        log.info("Activated ActivitiesImpl with activities [ {} ]", String.join(", ", this.activities));
    }

    @Deactivate
    protected void deactivate() {
        log.info("ActivitiesImpl has been deactivated!");
    }
}
```

### com.adobe.aem.wknd.examples.core.adventures.impl.ActivitiesImpl.cfg.json

`/ui.config/src/main/content/jcr_root/apps/wknd-examples/osgiconfig/config/com.adobe.aem.wknd.examples.core.adventures.impl.ActivitiesImpl.cfg.json`

```javascript
{
    "random.seed:Integer":12,
    "activities":[
      "Skateboarding",
      "Mountain Biking"
    ]
}
```
