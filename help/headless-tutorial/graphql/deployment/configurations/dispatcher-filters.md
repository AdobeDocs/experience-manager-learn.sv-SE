---
title: Dispatcher-filter för AEM GraphQL
description: Lär dig hur du konfigurerar AEM Publish Dispatcher-filter för användning med AEM GraphQL.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
jira: KT-10829
thumbnail: kt-10829.jpg
exl-id: b76b7c46-5cbd-4039-8fd6-9f0f10a4a84f
duration: 48
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '207'
ht-degree: 0%

---

# Dispatcher-filter

Adobe Experience Manager as a Cloud Service använder AEM Publish Dispatcher-filter för att säkerställa att endast förfrågningar som ska nå AEM når AEM. Som standard nekas alla begäranden och mönster för tillåtna URL:er måste läggas till explicit.

| Klienttyp | [Enkelsidig app (SPA)](../spa.md) | [Webbkomponent/JS](../web-component.md) | [Mobil](../mobile.md) | [Server-till-server](../server-to-server.md) |
|------------------------------------------:|:---------------------:|:----------------:|:---------:|:----------------:|
| Kräver Dispatcher-filterkonfiguration | ✔ | ✔ | ✔ | ✔ |

>[!TIP]
>
> Följande konfigurationer är exempel. Se till att du justerar dem så att de passar projektets krav.

## Dispatcher filterkonfiguration

Filterkonfigurationen för AEM Publish Dispatcher definierar URL-mönster som tillåts nå AEM och måste innehålla URL-prefixet för den AEM beständiga frågeslutpunkten.

| Klienten ansluter till | AEM | AEM Publish | AEM |
|------------------------------------------:|:----------:|:-------------:|:-------------:|
| Kräver Dispatcher-filterkonfiguration | ✘ | ✔ | ✔ |

Lägg till en `allow`-regel med URL-mönstret `/graphql/execute.json/*` och kontrollera att fil-ID:t (till exempel `/0600`, är unikt i exempelservergruppsfilen).
Detta tillåter HTTP GET-begäran till den beständiga frågeslutpunkten, till exempel `HTTP GET /graphql/execute.json/wknd-shared/adventures-all` till AEM Publish.

Om du använder Experience Fragments i din AEM Headless-upplevelse ska du göra samma sak för de här sökvägarna.

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
