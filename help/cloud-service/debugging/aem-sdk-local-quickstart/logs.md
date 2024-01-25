---
title: Felsöka AEM SDK med hjälp av loggar
description: Loggar fungerar som en frontlinje för felsökning AEM program, men är beroende av korrekt inloggning i det distribuerade AEM.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
jira: KT-5252
topic: Development
role: Developer
level: Beginner, Intermediate
exl-id: 91aa4a10-47fe-4313-acd2-ca753e5484d9
duration: 430
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '382'
ht-degree: 0%

---

# Felsöka AEM SDK med hjälp av loggar

Via loggarna för AEM SDK kan AEM SDK:s lokala snabbstartsverktyg eller Dispatcher Tools ge viktiga insikter i felsökning AEM program.

## AEM loggar

>[!VIDEO](https://video.tv.adobe.com/v/34334?quality=12&learn=on)

Loggar fungerar som en frontlinje för felsökning AEM program, men är beroende av korrekt inloggning i det distribuerade AEM. Adobe rekommenderar att konfigurationerna för lokal utveckling och AEM as a Cloud Service Dev-loggning är så lika som möjligt, eftersom det normaliserar loggsynligheten i AEM SDK:s lokala snabbstart och AEM as a Cloud Service Dev-miljöer, vilket minskar behovet av konfigurationssvängningar och omdistribution.

The [AEM Project Archettype](https://github.com/adobe/aem-project-archetype) konfigurerar loggning på DEBUG-nivå för ditt AEM Java-paket för lokal utveckling via Sling Logger OSGi-konfigurationen som finns på

`ui.apps/src/main/content/jcr_root/apps/example/config/org.apache.sling.commons.log.LogManager.factory.config-example.cfg.json`

som loggar till `error.log`.

Om standardloggningen inte är tillräcklig för lokal utveckling kan ad hoc-loggning konfigureras via AEM SDK:s lokala snabbstartswebbkonsol, på ([/system/console/slinglog](http://localhost:4502/system/console/slinglog)), men det rekommenderas inte att ad hoc-ändringar sparas i Git om inte samma loggkonfigurationer behövs i AEM as a Cloud Service Dev-miljöer. Tänk på att ändringar via loggsupportkonsolen sparas direkt i AEM SDK:s lokala snabbstartdatabas.

Java-loggsatser kan visas i `error.log` fil:

```
$ ~/aem-sdk/author/crx-quickstart/logs/error.log
```

Det är ofta praktiskt att &quot;svansa&quot; `error.log` som direktuppspelar utdata till terminalen.

+ macOS/Linux
   + `$ tail -f ~/aem-sdk/author/crx-quickstart/logs/error.log`
+ Windows kräver [Slutapplikationer från tredje part](https://stackoverflow.com/questions/187587/a-windows-equivalent-of-the-unix-tail-command) eller användning av [Kommandot Get-Content i PowerShell](https://stackoverflow.com/a/46444596/133936).

## Dispatcher-loggar

Sändningsloggar skrivs ut för att stoppas när `bin/docker_run` anropas, men loggarna kan ha direkt åtkomst till dem i Docker-behållaren.

### Åtkomst till loggar i Docker-behållaren{#dispatcher-tools-access-logs}

Dispatcher-loggar kan nås direkt i Docker-behållaren på `/etc/httpd/logs`.

```shell
$ docker ps

# locate the CONTAINER ID associated with "adobe/aem-ethos/dispatcher-publisher" IMAGE
CONTAINER ID        IMAGE                                       COMMAND                  CREATED             STATUS              PORTS                  NAMES
46127c9d7081        adobe/aem-ethos/dispatcher-publish:2.0.23   "/docker_entrypoint.…"   6 seconds ago       Up 5 seconds        0.0.0.0:8080->80/tcp   wonderful_merkle

$ docker exec -it <CONTAINER ID> /bin/sh

/ # 
/ # cd /etc/httpd/logs
/ # ls
    dispatcher.log          healthcheck_access_log  httpd_access.log        httpd_error.log

# When finished viewing the logs files, exit the Docker container's shell
/# exit
```

_The `<CONTAINER ID>` in `docker exec -it <CONTAINER ID> /bin/sh` måste ersättas med det Docker CONTAINER ID som anges i `docker ps` -kommando._


### Kopiera Docker-loggarna till det lokala filsystemet{#dispatcher-tools-copy-logs}

Sändningsloggar kan kopieras ut från Docker-behållaren på `/etc/httpd/logs` till det lokala filsystemet för kontroll med det logganalysverktyg du föredrar. Observera att detta är en kopia som skickas vid en viss tidpunkt och inte innehåller realtidsuppdateringar av loggarna.

```shell
$ docker ps

# locate the CONTAINER ID associated with "adobe/aem-ethos/dispatcher-publisher" IMAGE
CONTAINER ID        IMAGE                                       COMMAND                  CREATED             STATUS              PORTS                  NAMES
46127c9d7081        adobe/aem-ethos/dispatcher-publish:2.0.23   "/docker_entrypoint.…"   6 seconds ago       Up 5 seconds        0.0.0.0:8080->80/tcp   wonderful_merkle

$ docker cp -L <CONTAINER ID>:/etc/httpd/logs logs 
$ cd logs
$ ls
    dispatcher.log          healthcheck_access_log  httpd_access.log        httpd_error.log
```

_The `<CONTAINER_ID>` in `docker cp <CONTAINER_ID>:/var/log/apache2 ./` måste ersättas med det Docker CONTAINER ID som anges i `docker ps` -kommando._
