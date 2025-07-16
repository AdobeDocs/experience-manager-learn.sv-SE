---
title: Normalisera begäranden
description: Lär dig hur du normaliserar begäranden genom att omforma dem med trafikfilterregler i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Architect
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2025-06-04T00:00:00Z
jira: KT-18313
thumbnail: null
source-git-commit: 293157c296676ef1496e6f861ed8c2c24da7e068
workflow-type: tm+mt
source-wordcount: '259'
ht-degree: 0%

---

# Normalisera begäranden

Lär dig hur du normaliserar begäranden genom att omforma dem med trafikfilterregler i AEM as a Cloud Service.

## Varför och när begäranden ska omvandlas

Omformningar av begäranden är användbara när du vill normalisera inkommande trafik och minska onödiga variationer som orsakas av onödiga frågeparametrar eller rubriker. Den här tekniken används ofta för att

- Förbättra effektiviteten vid cachning genom att rensa parametrar för cachefunktionen som inte är relevanta för AEM-programmet.
- Skydda ursprunget mot missbruk genom att minimera antalet förfrågningar och minimera risken för onödig behandling.
- Sanera eller förenkla förfrågningar innan de skickas till AEM.

Dessa omformningar används vanligtvis på CDN-lagret, särskilt för AEM Publish-nivåer som betjänar den allmänna trafiken.

## Förutsättningar

Innan du fortsätter bör du kontrollera att du har slutfört de nödvändiga inställningarna enligt anvisningarna i självstudiekursen [Så här konfigurerar du trafikfilter och WAF-regler](../setup.md). Du har också klonat och distribuerat [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) till din AEM-miljö.

## Exempel: Ta bort frågeparametrar som inte behövs av programmet

I det här exemplet konfigurerar du en regel som **tar bort alla frågeparametrar utom** `search` och `campaignId` för att minska cachefragmenteringen.

- Lägg till följande regel i WKND-projektets `/config/cdn.yaml`-fil.

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes: ["dev", "stage", "prod"]
data:
  requestTransformations:
    rules:
    # Unset all query parameters except those needed for search and campaignId
    - name: unset-all-query-params-except-those-needed
      when:
        reqProperty: tier
        in: ["publish"]
      actions:
        - type: unset
          queryParamMatch: ^(?!search$|campaignId$).*$
```

- Verkställ och skicka ändringarna till Cloud Manager Git-databasen.

- Distribuera ändringarna i AEM-miljön med Cloud Manager konfigurationspipeline [som skapades tidigare](../setup.md#deploy-rules-using-adobe-cloud-manager).

- Testa regeln genom att gå till WKND-webbplatsens sida, till exempel `https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html?search=foo&campaignId=bar&otherParam=baz`.

- I AEM-loggar (`aemrequest.log`) bör du se att begäran omvandlas till `https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html?search=foo&campaignId=bar`, med `otherParam` borttagen.

  ![Omvandling av WKND-begäran](../assets/how-to/aemrequest-log-transformation.png)

