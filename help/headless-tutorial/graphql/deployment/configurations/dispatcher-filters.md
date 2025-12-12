---
title: Dispatcher-filter för AEM GraphQL
description: Lär dig hur du konfigurerar AEM Publish Dispatcher-filter för användning med AEM GraphQL.
version: Experience Manager as a Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer
level: Intermediate
jira: KT-10829
thumbnail: kt-10829.jpg
exl-id: b76b7c46-5cbd-4039-8fd6-9f0f10a4a84f
duration: 48
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '200'
ht-degree: 0%

---

# Dispatcher-filter

Adobe Experience Manager as a Cloud Service använder AEM Publish Dispatcher-filter för att säkerställa att endast förfrågningar som ska nå AEM verkligen når AEM. Som standard nekas alla begäranden och mönster för tillåtna URL:er måste läggas till explicit.

| Klienttyp | [Single-page app (SPA)](../spa.md) | [Webbkomponent/JS](../web-component.md) | [Mobil](../mobile.md) | [Server-till-server](../server-to-server.md) |
|------------------------------------------:|:---------------------:|:----------------:|:---------:|:----------------:|
| Kräver Dispatcher-filterkonfiguration | ✔ | ✔ | ✔ | ✔ |

>[!TIP]
>
> Följande konfigurationer är exempel. Se till att du justerar dem så att de passar projektets krav.

## Dispatcher filterkonfiguration

AEM Publish Dispatcher-filterkonfigurationen definierar URL-mönster som tillåts nå AEM och måste innehålla URL-prefixet för AEM beständiga frågeslutpunkt.

| Klienten ansluter till | AEM Author | AEM Publish | AEM Preview |
|------------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver Dispatcher-filterkonfiguration | ✘ | ✔ | ✔ |

Lägg till en `allow`-regel med URL-mönstret `/graphql/execute.json/*` och kontrollera att fil-ID:t (till exempel `/0600`, är unikt i exempelservergruppsfilen).
Detta tillåter HTTP GET-begäran till den beständiga frågeslutpunkten, till exempel `HTTP GET /graphql/execute.json/wknd-shared/adventures-all` till AEM Publish.

Om du använder Experience Fragments i din AEM Headless-upplevelse ska du göra samma sak med de här sökvägarna.

+ `dispatcher/src/conf.dispatcher.d/filters/filters.any`

```
...
# Allow headless requests for Persisted Query endpoints
/0600 { /type "allow" /method '(POST|OPTIONS)' /url "/graphql/execute.json/*" }
# Allow headless requests for Experience Fragments
/0601 { /type "allow" /method '(GET|OPTIONS)' /url "/content/experience-fragments/*" }
...
```

### Exempel på filterkonfiguration

+ [Ett exempel på Dispatcher-filtret finns i WKND-projektet.](https://github.com/adobe/aem-guides-wknd/blob/main/dispatcher/src/conf.dispatcher.d/filters/filters.any#L28)
