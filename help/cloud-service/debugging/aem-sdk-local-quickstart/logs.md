---
title: Felsöka AEM SDK med hjälp av loggar
description: Loggar fungerar som en frontlinje för felsökning AEM program, men är beroende av korrekt inloggning i det distribuerade AEM.
feature: null
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5252
translation-type: tm+mt
source-git-commit: a0e5a99408237c367ea075762ffeb3b9e9a5d8eb
workflow-type: tm+mt
source-wordcount: '364'
ht-degree: 0%

---


# Felsöka AEM SDK med hjälp av loggar

Via loggarna för AEM SDK kan AEM SDK:s lokala snabbstartsverktyg eller Dispatcher Tools ge viktiga insikter i felsökning AEM program.

## AEM

>[!VIDEO](https://video.tv.adobe.com/v/34334/?quality=12&learn=on)

Loggar fungerar som en frontlinje för felsökning AEM program, men är beroende av korrekt inloggning i det distribuerade AEM. Adobe rekommenderar att du behåller lokal utveckling och AEM som en Cloud Service Dev-loggningskonfigurationer så lika som möjligt, eftersom det normaliserar loggsynligheten på AEM SDK:s lokala snabbstart och AEM som en Cloud Services Dev-miljöer, vilket minskar behovet av att ändra konfigurationen och omdistribuera den.

I [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) konfigureras loggning på DEBUG-nivå för ditt AEM Java-paket för lokal utveckling via Sling Logger OSGi-konfigurationen som finns på

`ui.apps/src/main/content/jcr_root/apps/example/config/org.apache.sling.commons.log.LogManager.factory.config-example.cfg.json`

som loggar till `error.log`.

Om standardloggningen inte är tillräcklig för lokal utveckling kan ad hoc-loggning konfigureras via AEM SDK:s lokala snabbstartswebbkonsol, på ([/system/console/slinglog](http://localhost:4502/system/console/slinglog)), men det rekommenderas inte att ad hoc-ändringar sparas i Git om inte samma loggkonfigurationer behövs i AEM som en Cloud Service Dev-miljö. Tänk på att ändringar via loggsupportkonsolen sparas direkt i AEM SDK:s lokala snabbstartdatabas.

Java-loggsatser kan visas i `error.log` filen:

```
$ ~/aem-sdk/author/crx-quickstart/logs/error.log
```

Det är ofta praktiskt att &quot;svansen&quot; `error.log` som direktuppspelar utdata till terminalen.

+ macOS/Linux
   + `$ tail -f ~/aem-sdk/author/crx-quickstart/logs/error.log`
+ Windows kräver [tredjepartsprogram](https://stackoverflow.com/questions/187587/a-windows-equivalent-of-the-unix-tail-command) eller [PowerShell-kommandot](https://stackoverflow.com/a/46444596/133936)Get-Content.

## Dispatcher-loggar

Sändningsloggar skrivs ut så att de inte stängs när `bin/docker_run` anropas, men loggarna kan nås direkt från Docker.

### Åtkomst till loggar i Docker-behållaren

Sändningsloggar kan vara direkt åtkomliga i Docker-behållaren på `/etc/httpd/logs`.

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

### Kopiera Docker-loggarna till det lokala filsystemet

Sändningsloggar kan kopieras ut från Docker-behållaren på `/etc/httpd/logs` det lokala filsystemet och granskas med det logganalysverktyg du föredrar. Observera att detta är en kopia som skickas vid en viss tidpunkt och inte innehåller realtidsuppdateringar av loggarna.

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

