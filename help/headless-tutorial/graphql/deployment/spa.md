---
title: Distribuera SPA för AEM GraphQL
description: Lär dig SPA driftsättningsalternativ vad gäller AEM GraphQL, Headless.
version: Cloud Service
feature: GraphQL API
topic: Headless, Content Management
role: Developer, Architect
level: Intermediate
kt: 10587
thumbnail: KT-10587.jpg
mini-toc-levels: 2
source-git-commit: c7d2e69a9039cfbaa43d6d9b65b9fa6f69378716
workflow-type: tm+mt
source-wordcount: '528'
ht-degree: 0%

---


# Distribuera en SPA

I det här avsnittet kommer vi att granska en metod för att distribuera SPA (React, Vue, Angular osv.) som anropar GraphQL-API:er för att läsa in data, men innan det, måste vi förstå de högnivåartefakter som måste distribueras.

**SPA Build App Artifacts:**

Filerna som skapas i SPA ramverk, vanligtvis **HTML, CSS, JS**, även statiska byggartefakter. När det gäller React-appen innehåller artefakterna från `build` katalog och för Vue-artefakter från `dist` katalog.
Begäran till SPA (t.ex. https://HOST/my-aem-spa.html) kommer att besvaras med dessa byggartefakter.

**AEM GraphQL API:er:**

Denna GraphQL API-slutpunkt (`/graphql/execute.json/<PROJECT-CONFIG>/<PERSISTED-QUERY-NAME>`) måste finnas på AEM.

Sammanfattningsvis SPA distributionsarkitekturen har två delar *1. SPA 2. AEM GraphQL API Layer* så vi går igenom distributionsalternativen för dessa två delar.


## Distributionsalternativ

| Distributionsalternativ | SPA URL | AEM URL för GraphQL API | CORS-konfiguration krävs? |
| ---------|---------- | ---------|---------- |
| **Samma domän** | https://**VÄRD**/my-aem-spa.html | https://**VÄRD**/graphql/execute.json/.. | ✘ |
| **Annan domän** | https://**SPA**/my-aem-spa.html | https://**AEM**/graphql/execute.json/.. | ✔ |

**Samma domän:**\
Båda *SPA &amp; AEM GraphQL API Layer* i det här alternativet distribueras till **Samma domän**. Betydelse av begäran till SPA URI `/my-aem-spa.html` &amp; GraphQL API-lager `/graphql/execute.json/` hanteras från exakt samma domän.

**Annan domän:**\
Båda *SPA &amp; AEM GraphQL API Layer* i det här alternativet distribueras till **Annan domän**. Betydelse av begäran till SPA URI `/my-aem-spa.html` tillhandahålls från en **annan domän** än GraphQL API-lager `/graphql/execute.json/` förfrågningar. Observera att du måste [konfigurera CORS](cors.md) på AEM.

>[!NOTE]
>
>DU MÅSTE konfigurera CORS på AEM instans, [se steg här](cors.md).

### Distribuera på samma domän

Vid distribution på samma domän kan domänen vara en **primär AEM** (På AEM domän) eller **primär SPA** (Av AEM), och inkommande SPA, AEM GraphQL API-begäranden kan delas upp i någon av distributionskomponenterna, till exempel CDN ([Snabbt](https://docs.fastly.com/en/guides/routing-assets-to-different-origins), Akamai, [CloudFront](https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-distribution-serve-content/)), [HTTPD med omvänd proxy](https://httpd.apache.org/docs/2.4/howto/reverse_proxy.html). Med andra ord distribuerar du fortfarande artefakter och AEM GraphQL API:er till olika servrar, men för slutanvändare levereras de från en enda domän och bakom scenen till en annan mål- eller origin-server.

Dessutom kan SPA byggartefakter lagras i AEM *men rekommenderas inte.*

| Samma domändistribution | CDN-delning | HTTPD + omvänd proxy | AEM SPA |
| ---------|---------- | ---------|---------- |
| **PÅ AEM** | ✔ | ✔ | ✔ |
| **AV AEM** | ✔ | ✔ | **Ej tillämpligt** |


**HTTPD + omvänd proxy**

En exempelkonfiguration ser ut så här nedan

>[!TIP]
>
> Följande konfigurationer är exempel. Se till att du justerar dem så att de passar projektets krav.

PÅ AEM DOMÄN

    &quot;
    ProxyPass &quot;/${YOUR-SPA-URI}&quot; &quot;http://${SPA-HOST}/&quot;
    ProxyPassReverse &quot;/${YOUR-SPA-URI}&quot; &quot;http://${SPA-HOST}/&quot;
    &quot;

AV AEM

    &quot;
    ProxyPass &quot;/graphql/execute.json/&quot; &quot;http://${AEM-HOST}/&quot;
    ProxyPassReverse &quot;/graphql/execute.json/&quot; &quot;http://${AEM-HOST}/&quot;
    &quot;




### Distribuera på en annan domän

I det här scenariot distribueras SPA build-artefakter till en annan domän än AEM GraphQL API:er och för slutanvändare levereras de från två separata domäner och därmed [CORS-konfiguration](cors.md) är MUST på AEM.

**SPA appförfrågningar via olika domäner**

![Leverans av olika SPA](assets/spa/different-domain-spa-delivery.png)


**CORS-svarshuvud i AEM GraphQL API**

![CORS-svarshuvud AEM GraphQL API](assets/spa/CORS-response-header-aem-graphql-api.png)


