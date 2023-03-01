---
title: Anpassade namnutrymmen
description: Lär dig hur du definierar och distribuerar anpassade namnutrymmen till AEM as a Cloud Service.
version: Cloud Service
topic: Development, Content Management
feature: Metadata
role: Developer
level: Intermediate
kt: 11618
thumbnail: 3412319.jpg
last-substantial-update: 2022-12-14T00:00:00Z
source-git-commit: 1a4ee470a650aacc5412fbd27062ca14ccdb1967
workflow-type: tm+mt
source-wordcount: '230'
ht-degree: 0%

---

# Anpassade namnutrymmen

Lär dig hur du definierar och distribuerar anpassade [namnutrymmen](https://developer.adobe.com/experience-manager/reference-materials/spec/jcr/1.0/4.5_Namespaces.html) till AEM as a Cloud Service.

Anpassade namnutrymmen är den valfria delen av en JCR-egenskap som föregår en `:`. AEM använder flera namnutrymmen som:

+ `jcr` för JCR-systemegenskaper
+ `cq` för AEM (tidigare Adobe CQ) egenskaper
+ `dam` för AEM egenskaper som är specifika för DAM-resurser
+ `dc` för Dublin Core-egenskaper

... och många andra.

Namnutrymmen kan användas för att ange en egenskaps omfång och avsikt. Om du skapar ett anpassat namnutrymme, ofta ditt företagsnamn, blir det lättare att identifiera noder eller egenskaper som är specifika för din AEM och innehåller data som är specifika för ditt företag.

Anpassade namnutrymmen hanteras i [Initiering av Sling-databas (repoinit)](https://sling.apache.org/documentation/bundles/repository-initialization.html) skript och distribuerar till AEM as a Cloud Service som OSGi-konfigurationer - och läggs till i [AEM](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html) `ui.config` projekt.

>[!VIDEO](https://video.tv.adobe.com/v/3412319/?quality=12&learn=on)

## Resurser

+ [Dokumentation om initiering av Sling-databas (repoinit)](https://sling.apache.org/documentation/bundles/repository-initialization.html#repoinit-parser-test-scenarios)

## Kod

Följande kod används för att konfigurera en `wknd` namnutrymme.

### RepositoryInitializer OSGi-konfiguration

`/ui.config/src/main/content/jcr_root/apps/wknd-examples/osgiconfig/config/org.apache.sling.jcr.repoinit.RepositoryInitializer~wknd-examples-namespaces.cfg.json`

```json
{

    "scripts": [
        "register namespace (wknd) https://site.wknd/1.0"
    ]
}
```

Detta tillåter anpassade egenskaper med `wknd` namnutrymme, som den första parametern efter `register namespace` anvisningar, att användas i AEM. Mer avancerade skriptdefinitioner finns i exemplen i [Dokumentation om initiering av Sling-databas (repoinit)](https://sling.apache.org/documentation/bundles/repository-initialization.html#repoinit-parser-test-scenarios).
