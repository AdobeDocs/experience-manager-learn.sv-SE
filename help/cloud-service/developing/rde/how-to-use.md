---
title: Så här använder du Rapid Development Environment
description: Lär dig hur du använder Rapid Development Environment för att distribuera kod och innehåll från din lokala dator.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-11862
thumbnail: KT-11862.png
last-substantial-update: 2023-02-15T00:00:00Z
exl-id: 1d1bcb18-06cd-46fc-be2a-7a3627c1e2b2
duration: 792
source-git-commit: 2f7e10680c7211da836e33fdd241cd7f5d633d5f
workflow-type: tm+mt
source-wordcount: '788'
ht-degree: 0%

---

# Så här använder du Rapid Development Environment

Lär dig **hur du använder** RDE (Rapid Development Environment) i AEM as a Cloud Service. Distribuera kod och innehåll för snabbare utvecklingscykler med kod som nästan är färdig i den integrerade utvecklingsmiljön (IDE).

Med [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) får du lära dig hur du distribuerar olika AEM-artefakter till RDE genom att köra AEM-RDE:s `install`-kommando från din favoritutvecklingsmiljö.

- Driftsättning av AEM-kod och innehållspaket (all, ui.apps)
- Driftsättning av OSGi-paket och konfigurationsfiler
- Installation av Apache- och Dispatcher-konfigurationer som zip-filer
- Enskilda filer som HTML, `.content.xml` (dialogrute-XML)-distribution
- Granska andra RDE-kommandon som `status, reset and delete`

>[!VIDEO](https://video.tv.adobe.com/v/3415491?quality=12&learn=on)

## Förutsättning

Klona projektet [WKND Sites](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) och öppna det i din favoritutvecklingsmiljö för att distribuera AEM-artefakter till den lokala utvecklingsmiljön.

```shell
$ git clone git@github.com:adobe/aem-guides-wknd.git
```

Skapa och distribuera sedan materialet till AEM-SDK genom att köra följande maven-kommando.

```
$ cd aem-guides-wknd/
$ mvn clean package
```

## Distribuera AEM-felaktigheter med pluginprogrammet AEM-RDE

Kontrollera först att du har den [senaste `aio` CLI-modulen installerad](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/development-tools#aio-cli).

Använd sedan kommandot `aio aem:rde:install` för att distribuera olika AEM-artefakter.

### Distribuera `all`- och `dispatcher`-paket

En vanlig utgångspunkt är att först distribuera `all`- och `dispatcher`-paketen genom att köra följande kommandon.

```shell
# Install the 'all' content package (zip file)
$ aio aem:rde:install all/target/aem-guides-wknd.all-2.1.3-SNAPSHOT.zip

# Install the 'dispatcher' deployment artifact (zip file)
$ aio aem:rde:install dispatcher/target/aem-guides-wknd.dispatcher.cloud-2.1.3-SNAPSHOT.zip
```

Kontrollera WKND-webbplatsen på både författaren och publiceringstjänsterna när distributionen är klar. Du bör kunna lägga till och redigera innehållet på WKND-webbplatsens sidor och publicera det.

### Förbättra och distribuera en komponent

Låt oss förbättra `Hello World Component` och distribuera den till den lokala utvecklingsmiljön.

1. Öppna XML-filen för dialogrutan (`.content.xml`) från mappen `ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/_cq_dialog/`
1. Lägg till textfältet `Description` efter det befintliga fältet i dialogrutan `Text`

   ```xml
   ...
   <description
       jcr:primaryType="nt:unstructured"
       sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
       fieldLabel="Description"
       name="./description"/>       
   ...
   ```

1. Öppna filen `helloworld.html` från mappen `ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld`
1. Återge egenskapen `Description` efter det befintliga `<div>`-elementet för egenskapen `Text`.

   ```html
   ...
   <div class="cmp-helloworld__item" data-sly-test="${properties.description}">
       <p class="cmp-helloworld__item-label">Description property:</p>
       <pre class="cmp-helloworld__item-output" data-cmp-hook-helloworld="property">${properties.description}</pre>
   </div>              
   ...
   ```

1. Kontrollera ändringarna i AEM SDK genom att skapa eller synkronisera enskilda filer.

1. Distribuera ändringarna till RDE via `ui.apps`-paketet eller genom att distribuera de enskilda Dialog- och HTML-filerna:

   ```shell
   # Using 'ui.apps' package
   
   $ cd ui.apps
   $ mvn clean package
   $ aio aem:rde:install target/aem-guides-wknd.ui.apps-2.1.3-SNAPSHOT.zip
   
   # Or by deploying the individual HTL and Dialog XML
   
   # HTL file
   $ aio aem:rde:install ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/helloworld.html -t content-file -p /apps/wknd/components/helloworld/helloworld.html
   
   # Dialog XML
   $ aio aem:rde:install ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/_cq_dialog/.content.xml -t content-xml -p /apps/wknd/components/helloworld/_cq_dialog/.content.xml
   ```

1. Verifiera ändringar i RDE genom att lägga till eller redigera `Hello World Component` på en WKND-webbplatssida.

### Granska kommandoalternativen för `install`

I ovanstående exempel på enskilda fildistributionskommandon används flaggorna `-t` och `-p` för att ange typen och målet för JCR-sökvägen. Vi granskar de tillgängliga kommandoalternativen för `install` genom att köra följande kommando.

```shell
$ aio aem:rde:install --help
```

Flaggorna är självförklarande, flaggan `-s` är användbar för att rikta distributionen enbart till författaren eller publiceringstjänsterna. Använd flaggan `-t` när du distribuerar **content-file- eller content-xml**-filer tillsammans med flaggan `-p` för att ange mål-JCR-sökvägen i AEM RDE-miljön.

### Distribuera OSGi-paketet

Om du vill lära dig hur du distribuerar OSGi-paketet kan du förbättra Java™-klassen `HelloWorldModel` och distribuera den till den lokala utvecklingsmiljön.

1. Öppna filen `HelloWorldModel.java` från mappen `core/src/main/java/com/adobe/aem/guides/wknd/core/models`
1. Uppdatera metoden `init()` enligt nedan:

   ```java
   ...
   message = "Hello World!\n"
       + "Resource type is: " + resourceType + "\n"
       + "Current page is:  " + currentPagePath + "\n"
       + "Changes deployed via RDE, lets try faster dev cycles";
   ...
   ```

1. Verifiera ändringarna på lokala AEM-SDK genom att distribuera paketet `core` via kommandot maven
1. Distribuera ändringarna till RDE genom att köra följande kommando

   ```shell
   $ cd core
   $ mvn clean package
   $ aio aem:rde:install target/aem-guides-wknd.core-2.1.3-SNAPSHOT.jar
   ```

1. Verifiera ändringar i RDE genom att lägga till eller redigera `Hello World Component` på en WKND-webbplatssida.

### Distribuera OSGi-konfiguration

Du kan distribuera de enskilda config-filerna eller hela config-paketet, till exempel:

```shell
# Deploy individual config file
$ aio aem:rde:install ui.config/src/main/content/jcr_root/apps/wknd/osgiconfig/config/org.apache.sling.commons.log.LogManager.factory.config~wknd.cfg.json

# Or deploy the complete config package
$ cd ui.config
$ mvn clean package
$ aio aem:rde:install target/aem-guides-wknd.ui.config-2.1.3-SNAPSHOT.zip
```

>[!TIP]
>
>Om du bara vill installera en OSGi-konfiguration på en författare eller publiceringsinstans använder du flaggan `-s`.


### Distribuera Apache eller Dispatcher-konfiguration

Apache- eller Dispatcher-konfigurationsfilerna **kan inte distribueras individuellt**, men hela Dispatcher-mappstrukturen måste distribueras i form av en ZIP-fil.

1. Gör en önskad ändring i config-filen för modulen `dispatcher` och uppdatera `dispatcher/src/conf.d/available_vhosts/wknd.vhost` för att endast cachelagra `html`-filerna i 60 sekunder.

   ```
   ...
   <LocationMatch "^/content/.*\.html$">
       Header unset Cache-Control
       Header always set Cache-Control "max-age=60,stale-while-revalidate=60" "expr=%{REQUEST_STATUS} < 400"
       Header always set Surrogate-Control "stale-while-revalidate=43200,stale-if-error=43200" "expr=%{REQUEST_STATUS} < 400"
       Header set Age 0
   </LocationMatch>
   ...
   ```

1. Kontrollera ändringarna lokalt, se [Kör Dispatcher lokalt](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/dispatcher-tools) för mer information.
1. Distribuera ändringarna i RDE genom att köra följande kommando:

   ```shell
   $ cd dispatcher
   $ mvn clean install
   $ aio aem:rde:install target/aem-guides-wknd.dispatcher.cloud-2.1.3-SNAPSHOT.zip
   ```

1. Verifiera ändringar i RDE.

### Distribuera konfigurationsfiler (YAML)

CDN, underhållsaktiviteter, loggvidarebefordran och konfigurationsfiler för AEM API-autentisering kan distribueras till RDE med kommandot `install`. Dessa konfigurationer hanteras som YAML-filer i mappen `config` i AEM-projektet. Mer information finns i [Konfigurationer som stöds](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/config-pipeline#configurations).

Om du vill lära dig hur du distribuerar konfigurationsfilerna kan du förbättra konfigurationsfilen för `cdn` och distribuera den till RDE.

1. Öppna filen `cdn.yaml` från mappen `config`
1. Uppdatera den önskade konfigurationen, till exempel, uppdatera hastighetsgränsen till 200 begäranden per sekund

   ```yaml
   kind: "CDN"
   version: "1"
   metadata:
     envTypes: ["dev", "stage", "prod"]
   data:
     trafficFilters:
       rules:
       #  Block client for 5m when it exceeds an average of 100 req/sec to origin on a time window of 10sec
       - name: limit-origin-requests-client-ip
         when:
           reqProperty: tier
           equals: 'publish'
         rateLimit:
           limit: 200 # updated rate limit
           window: 10
           count: fetches
           penalty: 300
           groupBy:
             - reqProperty: clientIp
         action: log
   ...
   ```

1. Distribuera ändringarna till RDE genom att köra följande kommando

   ```shell
   $ aio aem:rde:install -t env-config ./config
   ```

1. Verifiera ändringar i RDE


## Ytterligare AEM RDE-pluginkommandon

Låt oss granska de extra kommandona för AEM RDE-plugin för att hantera och interagera med den lokala datorn.

```shell
$ aio aem:rde --help
Interact with RapidDev Environments.

USAGE
$ aio aem rde COMMAND

COMMANDS
aem rde delete   Delete bundles and configs from the current rde.
aem rde history  Get a list of the updates done to the current rde.
aem rde install  Install/update bundles, configs, and content-packages.
aem rde reset    Reset the RDE
aem rde restart  Restart the author and publish of an RDE
aem rde status   Get a list of the bundles and configs deployed to the current rde.
```

Med ovanstående kommandon kan din utvecklingsmiljö hanteras från din favoritutvecklingsmiljö för en snabbare utveckling/driftsättning.

## Nästa steg

Lär dig mer om [livscykeln för utveckling/distribution med RDE](./development-life-cycle.md) för att leverera funktioner med hastighet.


## Ytterligare resurser

[Dokumentation för RDE-kommandon](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/rapid-development-environments)

[Adobe I/O Runtime CLI-plugin för interaktion med AEM Rapid Development Environment](https://github.com/adobe/aio-cli-plugin-aem-rde#aio-cli-plugin-aem-rde)

[Projektinställningar för AEM](https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/project-setup)
