---
title: Andra verktyg för felsökning AEM SDK
description: En mängd andra verktyg kan hjälpa dig att felsöka AEM SDK:s lokala snabbstart.
feature: Developer Tools
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5251
topic: Development
role: Developer
level: Beginner, Intermediate
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '339'
ht-degree: 1%

---


# Andra verktyg för felsökning AEM SDK

En mängd andra verktyg kan hjälpa dig att felsöka programmet på AEM SDK:s lokala snabbstart.

## CRXDE Lite

![CRXDE Lite](./assets/other-tools/crxde-lite.png)

CRXDE Lite är ett webbaserat gränssnitt för interaktion med JCR-AEM. CRXDE Lite ger fullständig synlighet i JCR-rapporterna, inklusive noder, egenskaper, egenskapsvärden och behörigheter.

CRXDE Lite ligger på:

+ Verktyg > Allmänt > CRXDE Lite
+ eller direkt på [http://localhost:4502/crx/de/index.jsp](http://localhost:4502/crx/de/index.jsp)

## Förklara fråga

![Förklara fråga](./assets/other-tools/explain-query.png)

Förklara frågebaserade verktyg i AEM SDK:s lokala snabbstart, som ger viktiga insikter i hur AEM tolkar och kör frågor, och ett värdefullt verktyg för att säkerställa att frågor körs på ett bra sätt av AEM.

Förklara frågan finns på:

+ Verktyg > Diagnostik > Frågeprestanda > Fliken Förklara fråga
+ [http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) > Fliken Förklara fråga

## QueryBuilder-felsökning

![QueryBuilder-felsökning](./assets/other-tools/query-debugger.png)

QueryBuilder-felsökningsverktyget är ett webbaserat verktyg som du kan använda för att felsöka och förstå sökfrågor med AEM [QueryBuilder](https://docs.adobe.com/content/help/en/experience-manager-65/developing/platform/query-builder/querybuilder-api.html)-syntax.

Felsökaren för QueryBuilder finns på:

+ [http://localhost:4502/libs/cq/search/content/querydebug.html](http://localhost:4502/libs/cq/search/content/querydebug.html)

## Sling Log Tracer och AEM Chrome

![Sling Log Tracer och AEM Chrome](./assets/other-tools/log-tracer.png)

[Sling Log Tracer](https://sling.apache.org/documentation/bundles/log-tracers.html), som medföljer AEM SDK:s lokala snabbstart, möjliggör detaljerad spårning av HTTP-begäranden och visar detaljerad felsökningsinformation per begäran. Konfigurationen [Loggspårarens OSGi måste konfigureras](https://sling.apache.org/documentation/bundles/log-tracers.html#configuration-1) för att den här funktionen ska kunna aktiveras.

Öppen källkod [AEM Chrome-plugin](https://chrome.google.com/webstore/detail/aem-chrome-plug-in/ejdcnikffjleeffpigekhccpepplaode?hl=en-US) för webbläsaren [Google Chrome](https://www.google.com/chrome/), integreras med loggspåraren och felsökningsinformationen visas direkt i Chrome&#39;s Dev Tools.

_Plugin-programmet AEM Chrome är ett verktyg med öppen källkod, och Adobe har inget stöd för det._

