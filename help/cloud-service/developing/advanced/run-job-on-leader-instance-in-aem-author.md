---
title: Så här kör du ett jobb på en ledarinstans i AEM as a Cloud Service
description: Lär dig hur du kör ett jobb på ledarinstansen i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
topic: Development
feature: OSGI, Cloud Manager
role: Developer
level: Intermediate, Experienced
doc-type: Article
duration: 0
last-substantial-update: 2024-10-23T00:00:00Z
jira: KT-16399
thumbnail: KT-16399.jpeg
exl-id: b8b88fc1-1de1-4b5e-8c65-d94fcfffc5a5
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '557'
ht-degree: 0%

---

# Så här kör du ett jobb på en ledarinstans i AEM as a Cloud Service

Lär dig hur du kör ett jobb på ledarinstansen i AEM Author som en del av AEM as a Cloud Service och hur du konfigurerar det så att det bara körs en gång.

Sling-jobb är asynkrona uppgifter som körs i bakgrunden och är utformade för att hantera systemhändelser eller händelser som utlöses av användaren. Som standard fördelas dessa jobb jämnt över alla instanser (poder) i klustret.

Mer information finns i [Apache Sling-händelser och jobbhantering](https://sling.apache.org/documentation/bundles/apache-sling-eventing-and-job-handling.html).

## Skapa och bearbeta jobb

I demosyfte skapar vi ett enkelt _jobb som instruerar jobbprocessorn att logga ett meddelande_.

### Skapa ett jobb

Använd koden nedan för att _skapa_ ett Apache Sling-jobb:

```java
package com.adobe.aem.guides.wknd.core.sling.jobs.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.sling.event.jobs.JobManager;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(immediate = true)
public class SimpleJobCreaterImpl {

    private static final Logger log = LoggerFactory.getLogger(SimpleJobCreaterImpl.class);

    // Define the topic on which the job will be created
    protected static final String TOPIC = "wknd/simple/job/topic";

    // Inject a JobManager
    @Reference
    private JobManager jobManager;

    @Activate
    protected final void activate() throws Exception {
        log.info("SimpleJobCreater activated successfully");
        createJob();
        log.info("SimpleJobCreater created a job");
    }

    private void createJob() {
        // Create a job and add it on the above defined topic
        Map<String, Object> jobProperties = new HashMap<>();
        jobProperties.put("action", "log");
        jobProperties.put("message", "Job metadata is: Created in activate method");
        jobManager.addJob(TOPIC, jobProperties);
    }
}
```

De viktigaste punkterna att notera i ovanstående kod är:

- Jobbnyttolasten har två egenskaper: `action` och `message`.
- Jobbet läggs till i avsnittet [&#x200B; med &#x200B;](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/org/apache/sling/event/jobs/JobManager.html)JobManager`addJob(...)`s `wknd/simple/job/topic` -metod.

### Bearbeta ett jobb

Använd koden nedan för att _bearbeta_ det ovanstående Apache Sling-jobbet:

```java
package com.adobe.aem.guides.wknd.core.sling.jobs.impl;

import org.apache.sling.event.jobs.Job;
import org.apache.sling.event.jobs.consumer.JobConsumer;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(service = JobConsumer.class, property = {
        JobConsumer.PROPERTY_TOPICS + "=" + SimpleJobCreaterImpl.TOPIC
}, immediate = true)
public class SimpleJobConsumerImpl implements JobConsumer {

    private static final Logger log = LoggerFactory.getLogger(SimpleJobConsumerImpl.class);

    @Override
    public JobResult process(Job job) {
        // Get the action and message properties
        String action = job.getProperty("action", String.class);
        String message = job.getProperty("message", String.class);

        // Log the message
        if ("log".equals(action)) {
            log.info("Processing WKND Job, and {}", message);
        }

        // Return a successful result
        return JobResult.OK;
    }

}
```

De viktigaste punkterna att notera i ovanstående kod är:

- Klassen `SimpleJobConsumerImpl` implementerar gränssnittet `JobConsumer`.
- Det är en tjänst som är registrerad för att förbruka jobb från ämnet `wknd/simple/job/topic`.
- Metoden `process(...)` bearbetar jobbet genom att logga egenskapen `message` för jobbnyttolasten.

### Standardbearbetning av jobb

När du distribuerar ovanstående kod till en AEM as a Cloud Service-miljö och kör den på AEM Author-tjänsten, som fungerar som ett kluster med flera AEM Author JVM:er, körs jobbet en gång på varje AEM Author-instans (pod), vilket innebär att antalet jobb som skapas matchar antalet poder. Antalet poder kommer alltid att vara fler än ett (för miljöer som inte är i en RDE-miljö), men kommer att variera beroende på AEM as a Cloud Service interna resurshantering.

Jobbet körs på varje instans av AEM Author (pod) eftersom `wknd/simple/job/topic` är associerat med AEM huvudkö, som distribuerar jobb över alla tillgängliga instanser.

Detta är ofta problematiskt om jobbet ansvarar för att ändra tillstånd, till exempel skapa eller uppdatera resurser eller externa tjänster.

Om du vill att jobbet bara ska köras en gång på AEM Author-tjänsten lägger du till konfigurationen [jobbkö](#how-to-run-a-job-on-the-leader-instance) som beskrivs nedan.

Du kan verifiera den genom att granska loggarna för AEM Author-tjänsten i [Cloud Manager](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/debugging/debugging-aem-as-a-cloud-service/logs#cloud-manager).

![Jobbet har bearbetats av alla instanser](./assets/run-job-once/job-processed-by-all-instances.png)


Du bör se:

```
<DD.MM.YYYY HH:mm:ss.SSS> [cm-pxxxx-exxxx-aem-author-68775db964-nxxcx] *INFO* [sling-oak-observation-15] org.apache.sling.event.impl.jobs.queues.JobQueueImpl.<main queue> Starting job queue <main queue>
<DD.MM.YYYY HH:mm:ss.SSS> INFO [com.adobe.aem.guides.wknd.core.sling.jobs.impl.SimpleJobConsumerImpl] Processing WKND Job, and Job metadata is: Created in activate method

<DD.MM.YYYY HH:mm:ss.SSS> [cm-pxxxx-exxxx-aem-author-68775db964-r4zk7] *INFO* [sling-oak-observation-11] org.apache.sling.event.impl.jobs.queues.JobQueueImpl.<main queue> Starting job queue <main queue>
<DD.MM.YYYY HH:mm:ss.SSS> INFO [com.adobe.aem.guides.wknd.core.sling.jobs.impl.SimpleJobConsumerImpl] Processing WKND Job, and Job metadata is: Created in activate method
```

Det finns två loggposter, en för varje AEM Author-instans (`68775db964-nxxcx` och `68775db964-r4zk7`), som anger att varje instans (pod) har bearbetat jobbet.

## Så här kör du ett jobb på ledarinstansen

Om du vill köra ett jobb _endast en gång_ på AEM Author-tjänsten skapar du en ny Sling-jobbkö av typen **Beställd** och associerar jobbämnet (`wknd/simple/job/topic`) med den här kön. Med den här konfigurationen tillåts endast den ledande AEM Author-instansen (pod) att bearbeta jobbet.

Skapa en OSGi-konfigurationsfil (`ui.config`) i modulen `org.apache.sling.event.jobs.QueueConfiguration~wknd.cfg.json` i ditt AEM-projekt och lagra den i mappen `ui.config/src/main/content/jcr_root/apps/wknd/osgiconfig/config.author`.

```json
{
    "queue.name":"WKND Queue - ORDERED",
    "queue.topics":[
      "wknd/simple/job/topic"
    ],
    "queue.type":"ORDERED",
    "queue.retries":1,
    "queue.maxparallel":1.0
  }
```

De viktigaste punkterna att notera i ovanstående konfiguration är:

- Köämnet är inställt på `wknd/simple/job/topic`.
- Kötypen är inställd på `ORDERED`.
- Det maximala antalet parallella jobb är `1`.

När du distribuerat ovanstående konfiguration kommer jobbet att bearbetas exklusivt av ledarinstansen, vilket garanterar att det bara körs en gång i hela AEM Author-tjänsten.

```
<DD.MM.YYYY HH:mm:ss.SSS> [cm-pxxxx-exxxx-aem-author-7475cf85df-qdbq5] *INFO* [FelixLogListener] Events.Service.org.apache.sling.event Service [QueueMBean for queue WKND Queue - ORDERED,7755, [org.apache.sling.event.jobs.jmx.StatisticsMBean]] ServiceEvent REGISTERED
<DD.MM.YYYY HH:mm:ss.SSS> INFO [com.adobe.aem.guides.wknd.core.sling.jobs.impl.SimpleJobConsumerImpl] Processing WKND Job, and Job metadata is: Created in activate method
<DD.MM.YYYY HH:mm:ss.SSS> [com.adobe.aem.guides.wknd.core.sling.jobs.impl.SimpleJobConsumerImpl] Processing WKND Job, and Job metadata is: Created in activate method
```
