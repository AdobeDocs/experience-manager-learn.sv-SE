---
title: Så här använder du Rapid Development Environment
description: Lär dig hur du använder Rapid Development Environment för att distribuera kod och innehåll från din lokala dator.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
jira: KT-11862
thumbnail: KT-11862.png
last-substantial-update: 2023-02-15T00:00:00Z
exl-id: 1d1bcb18-06cd-46fc-be2a-7a3627c1e2b2
duration: 841
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '671'
ht-degree: 0%

---

# Så här använder du Rapid Development Environment

Läs **använda** Rapid Development Environment (RDE) på AEM as a Cloud Service. Distribuera kod och innehåll för snabbare utvecklingscykler med kod som nästan är färdig i den integrerade utvecklingsmiljön (IDE).

Använda [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) får du lära dig hur du distribuerar olika AEM till RDE genom att köra AEM-RDE:er `install` från din favoritutvecklingsmiljö.

- AEM kod och innehållspaket (all, ui.apps)-distribution
- Driftsättning av OSGi-paket och konfigurationsfiler
- Apache och Dispatcher konfigurerar distributionen som en zip-fil
- Enskilda filer som HTML, `.content.xml` (dialog-XML) distribution
- Granska andra RDE-kommandon som `status, reset and delete`

>[!VIDEO](https://video.tv.adobe.com/v/3415491?quality=12&learn=on)

## Förutsättning

Klona [WKND Sites](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project) och öppna den i din favoritutvecklingsmiljö för att distribuera de AEM artefakterna till den lokala utvecklingsmiljön.

```shell
$ git clone git@github.com:adobe/aem-guides-wknd.git
```

Bygg och distribuera den sedan till det lokala AEM-SDK:t genom att köra följande maven-kommando.

```
$ cd aem-guides-wknd/
$ mvn clean package
```

## Distribuera AEM med plugin-programmet AEM-RDE

Använda `aem:rde:install` kommandot, låt oss distribuera olika AEM.

### Distribuera `all` och `dispatcher` paket

En vanlig utgångspunkt är att först distribuera `all` och `dispatcher` paket genom att köra följande kommandon.

```shell
# Install the 'all' package
$ aio aem:rde:install all/target/aem-guides-wknd.all-2.1.3-SNAPSHOT.zip

# Install the 'dispatcher' zip
$ aio aem:rde:install dispatcher/target/aem-guides-wknd.dispatcher.cloud-2.1.3-SNAPSHOT.zip
```

Kontrollera WKND-webbplatsen på både författaren och publiceringstjänsterna när distributionen är klar. Du bör kunna lägga till och redigera innehållet på WKND-webbplatsens sidor och publicera det.

### Förbättra och distribuera en komponent

Låt oss förbättra `Hello World Component` och driftsätta den på den lokala utvecklingsmiljön.

1. Öppna dialogrutan XML (`.content.xml`) fil från `ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld/_cq_dialog/` mapp
1. Lägg till `Description` textfält efter befintlig `Text` dialogrutefält

   ```xml
   ...
   <description
       jcr:primaryType="nt:unstructured"
       sling:resourceType="granite/ui/components/coral/foundation/form/textfield"
       fieldLabel="Description"
       name="./description"/>       
   ...
   ```

1. Öppna `helloworld.html` fil från `ui.apps/src/main/content/jcr_root/apps/wknd/components/helloworld` mapp
1. Återge `Description` egenskapen efter befintlig `<div>` -elementet i `Text` -egenskap.

   ```html
   ...
   <div class="cmp-helloworld__item" data-sly-test="${properties.description}">
       <p class="cmp-helloworld__item-label">Description property:</p>
       <pre class="cmp-helloworld__item-output" data-cmp-hook-helloworld="property">${properties.description}</pre>
   </div>              
   ...
   ```

1. Verifiera ändringarna i lokala AEM-SDK genom att utföra maven-bygget eller synkronisera enskilda filer.

1. Distribuera ändringarna till RDE via `ui.apps` eller genom att distribuera de enskilda dialogrutorna och HTML-filerna.

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

1. Verifiera ändringar i RDE genom att lägga till eller redigera `Hello World Component` på en WKND-webbplats.

### Granska `install` kommandoalternativ

I exemplet med det ovan enskilda fildistributionskommandot `-t` och `-p` flaggor används för att ange JCR-sökvägens typ och mål. Låt oss titta på det tillgängliga `install` genom att köra följande kommando.

```shell
$ aio aem:rde:install --help
```

Flaggorna är självförklarande, `-s` -flaggan är användbar för att rikta distributionen enbart till författaren eller publiceringstjänsterna. Använd `-t` flagga vid distribution av **content-file eller content-xml** filer tillsammans med `-p` för att ange mål-JCR-sökvägen i AEM RDE-miljö.

### Distribuera OSGi-paketet

Om du vill lära dig hur man driftsätter OSGi-paketet kan vi förbättra `HelloWorldModel` Klassen Java™ och driftsätt den i RDE.

1. Öppna `HelloWorldModel.java` fil från `core/src/main/java/com/adobe/aem/guides/wknd/core/models` mapp
1. Uppdatera `init()` metod enligt nedan:

   ```java
   ...
   message = "Hello World!\n"
       + "Resource type is: " + resourceType + "\n"
       + "Current page is:  " + currentPagePath + "\n"
       + "Changes deployed via RDE, lets try faster dev cycles";
   ...
   ```

1. Verifiera ändringarna i lokal AEM-SDK genom att distribuera `core` paket via maven, kommando
1. Distribuera ändringarna till RDE genom att köra följande kommando

   ```shell
   $ cd core
   $ mvn clean package
   $ aio aem:rde:install target/aem-guides-wknd.core-2.1.3-SNAPSHOT.jar
   ```

1. Verifiera ändringar i RDE genom att lägga till eller redigera `Hello World Component` på en WKND-webbplats.

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
>Om du bara vill installera en OSGi-konfiguration på en författare eller publiceringsinstans använder du `-s` flagga.


### Distribuera Apache eller Dispatcher-konfiguration

Konfigurationsfilerna för Apache eller Dispatcher **kan inte distribueras individuellt**, men hela Dispatcher-mappstrukturen måste distribueras i form av en ZIP-fil.

1. Ändra konfigurationsfilen för `dispatcher` för demoändamål, uppdatera `dispatcher/src/conf.d/available_vhosts/wknd.vhost` för att cachelagra `html` -filer i endast 60 sekunder.

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

1. Verifiera ändringarna lokalt, se [Kör Dispatcher lokalt](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/dispatcher-tools.html#run-dispatcher-locally) för mer information.
1. Distribuera ändringarna i RDE genom att köra följande kommando:

   ```shell
   $ cd dispatcher
   $ mvn clean install
   $ aio aem:rde:install target/aem-guides-wknd.dispatcher.cloud-2.1.3-SNAPSHOT.zip
   ```

1. Verifiera ändringar i RDE

## Ytterligare AEM RDE-pluginkommandon

Låt oss granska de extra kommandona för AEM RDE-plugin som du kan hantera och interagera med RDE från din lokala dator.

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

Med ovanstående kommandon kan din utvecklingsmiljö hanteras från din favoritutvecklingsmiljö för snabbare utveckling/driftsättning.

## Nästa steg

Läs mer om [livscykeln för utveckling/driftsättning med RDE](./development-life-cycle.md) för att leverera funktioner snabbt.


## Ytterligare resurser

[Dokumentation för RDE-kommandon](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/rapid-development-environments.html#rde-cli-commands)

[Adobe I/O Runtime CLI Plugin för interaktion med AEM Rapid Development Environment](https://github.com/adobe/aio-cli-plugin-aem-rde#aio-cli-plugin-aem-rde)

[AEM projektinställningar](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/project-archetype/project-setup.html)
