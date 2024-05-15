---
title: Debugging Dispatcher Tools
description: Dispatcher Tools är en innesluten Apache-webbservermiljö som kan användas för att simulera AEM som en Cloud Services AEM Publish-tjänstens Dispatcher lokalt. Debugging Dispatcher Tools loggar och cacheinnehåll kan vara avgörande för att säkerställa att hela AEM och tillhörande cache- och säkerhetskonfigurationer är korrekta.
feature: Dispatcher
jira: KT-5918
topic: Development
role: Developer
level: Beginner, Intermediate
exl-id: f0adf7a6-c7c2-449a-9fa5-402c54b812e5
duration: 56
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '230'
ht-degree: 0%

---

# Debugging Dispatcher Tools

Dispatcher Tools är en innesluten Apache-webbservermiljö som kan användas för att simulera AEM som en Cloud Services AEM Publish-tjänstens Dispatcher lokalt.

Debugging Dispatcher Tools loggar och cacheinnehåll kan vara avgörande för att säkerställa att hela AEM och tillhörande cache- och säkerhetskonfigurationer är korrekta.

>[!NOTE]
>
>Eftersom Dispatcher Tools är behållarbaserat förstörs tidigare loggar och cacheinnehåll varje gång de startas om.

## Loggar för Dispatcher Tools

Loggarna för Dispatcher Tools är tillgängliga via `stdout` eller `bin/docker_run` eller med fler detaljer, tillgängliga i Docker-behållaren på `/etc/https/logs`.

Se [Dispatcher-loggar](./logs.md#dispatcher-logs) för instruktioner om hur du får direktåtkomst till Dispatcher Tools Docker-behållarens loggar.

## Cacheminne för Dispatcher Tools

### Åtkomst till loggar i Docker-behållaren

Dispatcher-cachen kan användas direkt i Docker-behållaren på ` /mnt/var/www/html`.

```shell
$ docker ps

# locate the CONTAINER ID associated with "adobe/aem-ethos/dispatcher-publisher" IMAGE
CONTAINER ID        IMAGE                                       COMMAND                  CREATED             STATUS              PORTS                  NAMES
46127c9d7081        adobe/aem-ethos/dispatcher-publish:2.0.23   "/docker_entrypoint.…"   6 seconds ago       Up 5 seconds        0.0.0.0:8080->80/tcp   wonderful_merkle

$ docker exec -it <CONTAINER ID> /bin/sh

/ # 
/ # cd /mnt/var/www/html

# When finished viewing the cache, exit the Docker container's shell
/# exit
```

### Kopiera Docker-loggarna till det lokala filsystemet

Sändningsloggar kan kopieras ut från Docker-behållaren på `/mnt/var/www/html` till det lokala filsystemet för granskning med dina favoritverktyg. Observera att detta är en kopia som görs vid en viss tidpunkt och inte innehåller realtidsuppdateringar av cachen.

```shell
$ docker ps

# locate the CONTAINER ID associated with "adobe/aem-ethos/dispatcher-publisher" IMAGE
CONTAINER ID        IMAGE                                       COMMAND                  CREATED             STATUS              PORTS                  NAMES
46127c9d7081        adobe/aem-ethos/dispatcher-publish:2.0.23   "/docker_entrypoint.…"   6 seconds ago       Up 5 seconds        0.0.0.0:8080->80/tcp   wonderful_ira

$ docker cp -L <CONTAINER ID>:/mnt/var/www/html cache 
$ cd cache
```
