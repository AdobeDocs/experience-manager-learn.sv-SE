---
title: Grundläggande om utveckling av OSGi-tjänster
description: Lär dig grunderna i att utveckla en OSGi-tjänst
role: Developer
level: Beginner
topic: Development
feature: OSGI
jira: KT-8227
thumbnail: 335476.jpeg
last-substantial-update: 2022-09-16T00:00:00Z
exl-id: a3a9bf59-e9a2-4322-ac93-9c12c70b9a75
duration: 492
source-git-commit: a18bf2c8b57eaaac3686a26fa1fb39e6fc075af5
workflow-type: tm+mt
source-wordcount: '122'
ht-degree: 0%

---

# OSGi Services

Lär dig grunderna i OSGi-utvecklingen av tjänster, inklusive:

+ Konvertera en Java POJO till en OSGi-tjänst
+ Binda en OSGi-tjänst till ett Java-gränssnitt

>[!VIDEO](https://video.tv.adobe.com/v/335476?quality=12&learn=on)

## Resurser

+ [@Component JavaDocs](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/org/osgi/service/component/annotations/Component.html)
+ [@ProviderType JavaDocs](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/org/osgi/annotation/versioning/ProviderType.html)
+ [@Version JavaDocs](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/org/osgi/annotation/versioning/Version.html)

## Code

### Activities.java

`/core/src/main/java/com/adobe/aem/wknd/examples/core/adventures/Activities.java`

```java
package com.adobe.aem.wknd.examples.core.adventures;

import org.osgi.annotation.versioning.ProviderType;

@ProviderType
public interface Activities {    
    String getRandomActivity();
}
```

### ActivitiesImpl.java

`/core/src/main/java/com/adobe/aem/wknd/examples/core/adventures/impl/ActivitiesImpl.java`

```java
package com.adobe.aem.wknd.examples.core.adventures.impl;

import java.util.Random;

import com.adobe.aem.wknd.examples.core.adventures.Activities;

import org.osgi.service.component.annotations.Component;

@Component(
    service = { Activities.class }
)
public class ActivitiesImpl implements Activities {

    private static final String[] ACTIVITIES = new String[] { 
        "Camping", "Skiing",  "Skateboarding"
    };

    //private final int randomIndex = new Random().nextInt(ACTIVITIES.length);
    private final Random random = new Random();

    /**
     * @return the name of a random WKND adventure activity
     */
    public String getRandomActivity() {
        int randomIndex = random.nextInt(ACTIVITIES.length);
        return ACTIVITIES[randomIndex];
    }    
}
```

### package-info.java

`/core/src/main/java/com/adobe/aem/wknd/examples/core/adventures/package-info.java`

```java
@Version("1.0")
package com.adobe.aem.wknd.examples.core.adventures;

import org.osgi.annotation.versioning.Version;
```

Lägga till en `package-info.java` krävs för att säkerställa att andra OSGi-paket i AEM kan lösa OSGi-tjänstgränssnittet (eller valfri Java-klass). Om `package-info.java` saknas exporteras inte Java-paketet och dess Java-interf eller -klasser. Andra OSGi-paket som försöker importera dessa Java-gränssnitt eller klasser från det här Java-paketet kommer att felsöka meddelandet __Kan inte lösas__ i AEM OSGi Bundle-konsolen.
