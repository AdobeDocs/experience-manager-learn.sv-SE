---
title: Begränsa åtkomst
description: Lär dig hur du begränsar åtkomsten genom att blockera specifika begäranden med trafikfilterregler i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2025-06-04T00:00:00Z
jira: KT-18312
thumbnail: null
exl-id: 53cb8996-4944-4137-a979-6cf86b088d42
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '390'
ht-degree: 0%

---

# Begränsa åtkomst

Lär dig hur du begränsar åtkomsten genom att blockera specifika begäranden med trafikfilterregler i AEM as a Cloud Service.

I den här självstudien visas hur du **blockerar begäranden till interna sökvägar från offentliga IP:n** i AEM Publish-tjänsten.

## Varför och när förfrågningar ska blockeras

Genom att blockera trafik kan man tillämpa säkerhetsregler för organisationen genom att förhindra åtkomst till känsliga resurser eller URL:er under vissa förhållanden. Jämfört med loggning är blockering en striktare åtgärd och bör användas när du är säker på att trafik från specifika källor är otillåten eller oönskad.

Vanliga scenarier där blockering är lämpligt är:

- Begränsar åtkomst till `internal` eller `confidential` sidor till enbart interna IP-intervall (till exempel bakom ett företags-VPN).
- Blockera robottrafik, automatiserade skannrar eller hotskådespelare som identifieras av IP eller geopositionering.
- Förhindrar åtkomst till borttagna eller oskyddade slutpunkter under mellanliggande migreringar.
- Begränsa åtkomsten till redigeringsverktyg eller administrationsvägar i publiceringsnivåer.

## Förutsättningar

Innan du fortsätter bör du kontrollera att du har slutfört de nödvändiga inställningarna enligt anvisningarna i självstudiekursen [Så här konfigurerar du trafikfilter och WAF-regler](../setup.md). Du har också klonat och distribuerat [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) till din AEM-miljö.

## Exempel: Blockera interna sökvägar från offentliga IP-adresser

I det här exemplet konfigurerar du en regel som blockerar extern åtkomst till en intern WKND-sida, som `https://publish-pXXXX-eYYYY.adobeaemcloud.com/content/wknd/internal/demo-page.html`, från offentliga IP-adresser. Endast användare inom ett betrott IP-intervall (till exempel ett företags-VPN) har åtkomst till den här sidan.

Du kan antingen skapa en egen intern sida (till exempel `demo-page.html`) eller använda det [bifogade paketet](../assets/how-to/demo-internal-pages-package.zip).

- Lägg till följande regel i WKND-projektets `/config/cdn.yaml`-fil.

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes: ["dev", "stage", "prod"]
data:
  trafficFilters:
    rules:
    # Block requests to (demo) internal only page/s from public IP address but allow from internal IP address.
    # Make sure to replace the IP address with your own IP address.
    - name: block-internal-paths
      when:
        allOf:
          - reqProperty: path
            matches: /content/wknd/internal
          - reqProperty: clientIp
            notIn: [192.150.10.0/24]
      action: block    
```

- Verkställ och skicka ändringarna till Cloud Manager Git-databasen.

- Distribuera ändringarna i AEM-miljön med Cloud Manager konfigurationspipeline [som skapades tidigare](../setup.md#deploy-rules-using-adobe-cloud-manager).

- Testa regeln genom att gå till WKND-platsens interna sida, till exempel `https://publish-pXXXX-eYYYY.adobeaemcloud.com/content/wknd/internal/demo-page.html`, eller genom att använda CURL-kommandot nedan:

  ```bash
  $ curl -I https://publish-pXXXX-eYYYY.adobeaemcloud.com/content/wknd/internal/demo-page.html
  ```

- Upprepa ovanstående steg från både IP-adressen som du använde i regeln och sedan en annan IP-adress (till exempel med mobiltelefonen).

## Analyserar

Om du vill analysera resultatet av regeln `block-internal-paths` följer du de steg som beskrivs i [självstudiekursen för konfiguration](../setup.md#cdn-logs-ingestion)

Du bör se **Blockerade begäranden** och motsvarande värden i kolumnerna klient-IP (cli_ip), värd, URL, åtgärd (waf_action) och rule-name (waf_match).

![ELK Tool Dashboard Blocked Request](../assets/how-to/elk-tool-dashboard-blocked.png)
