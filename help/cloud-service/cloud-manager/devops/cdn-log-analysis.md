---
title: Verktyg för analys av CDN-logg
description: Läs om AEM Cloud Service CDN Log Analysis Tooling som Adobe tillhandahåller och hur det hjälper er att få insikter om både CDN-prestanda och AEM.
version: Cloud Service
feature: Developer Tools
topic: Development
role: Developer, Architect, Admin
level: Beginner
doc-type: Tutorial
duration: 219
last-substantial-update: 2024-05-17T00:00:00Z
jira: KT-15505
thumbnail: KT-15505.jpeg
exl-id: 830c2486-099b-454f-bc07-6bf36e81ac8d
source-git-commit: 4111ae0cf8777ce21c224991b8b1c66fb01041b3
workflow-type: tm+mt
source-wordcount: '442'
ht-degree: 0%

---

# Verktyg för analys av CDN-logg

Läs mer om _AEM Cloud Service CDN Log Analysis Tooling_ som Adobe tillhandahåller och hur det hjälper er att få insikter om både CDN-prestanda och AEM implementering.
 
>[!VIDEO](https://video.tv.adobe.com/v/3429177?quality=12&learn=on)

## Ökning

The [AEM as a Cloud Service CDN-logganalysverktyg](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling) har färdiga kontrollpaneler som du kan integrera med [Splunk](https://www.splunk.com/en_us/products/observability-cloud.html) eller [ELK-stack](https://www.elastic.co/elastic-stack) för realtidsövervakning och analys av CDN-loggarna.

Med den här verktygen kan du få realtidsövervakning och proaktiv problemidentifiering. På så sätt säkerställs optimerad innehållsleverans och korrekta säkerhetsåtgärder mot DoS-attacker (Denial of Service) och DDOS-attacker (Distributed Denial of Service).

## Viktiga funktioner

- Effektiv logganalys
- Övervakning i realtid
- Smidig integrering
- Kontrollpaneler för
   - identifiera potentiella säkerhetshot
   - Snabbare slutanvändarupplevelse

## Översikt över instrumentpanelen

För att snabbt kunna starta logganalysen tillhandahåller Adobe fördefinierade kontrollpaneler för både Splunk- och ELK-stacken.

- **CDN-cacheträffrekvens**: ger insikter om det totala antalet träffar i cacheminnet och det totala antalet förfrågningar från HIT-, PASS- och MISS-status. Den tillhandahåller även de bästa URL:erna för HIT, PASS och MISS.

  ![CDN-cacheträffrekvens](assets/CHR-dashboard.png)

- **Kontrollpanel för CDN-trafik**: ger insikter om trafiken via CDN och antalet förfrågningar om ursprung, felfrekvenserna 4xx och 5xx samt icke-cachelagrade förfrågningar. Det ger även max antal CND- och origin-begäranden per sekund per klient-IP-adress och fler insikter för att optimera CDN-konfigurationerna.

  ![Kontrollpanel för CDN-trafik](assets/Traffic-dashboard.png)

- **WAF-instrumentpanel**: ger insikter via analyserade, flaggade och blockerade förfrågningar. Den innehåller även toppangrepp av WAF-flagga-ID, de 100 främsta angriparna per klient-IP, land och användaragent samt fler insikter för att optimera WAF-konfigurationerna.

  ![WAF-instrumentpanel](assets/WAF-Dashboard.png)

## Splunk-integrering

För organisationer som använder [Splunk](https://www.splunk.com/en_us/products/observability-cloud.html) och som har aktiverat vidarebefordran av AEMCS-loggen till Splunk-instanserna kan snabbt importera förbyggda kontrollpaneler. Den här konfigurationen underlättar snabbare logganalys och ger användbara insikter för att optimera AEM implementeringar och minska säkerhetshot som DOS-attacker.

Du kan komma igång med [Splunk dashboards for AEMCS CDN Log Analysis](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/Splunk/README.md#splunk-dashboards-for-aemcs-cdn-log-analysis) guide.


## Integrering med ELK

The [ELK-stack](https://www.elastic.co/elastic-stack), som omfattar Elasticsearch, Logstash och Kibana, är ett annat kraftfullt alternativ för logganalys. Det är användbart för organisationer som inte har tillgång till en Splunk-konfiguration eller funktioner för vidarebefordran av loggar. Det är enkelt att konfigurera ELK-stacken lokalt. Verktyget ger tillgång till Docker Compose-filen så att du snabbt kommer igång. Sedan kan du importera de fördefinierade kontrollpanelerna och importera CDN-loggarna som hämtas med Adobe Cloud Manager.

Du kan komma igång med [ELK Docker container for AEMCS CDN Log Analysis](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/ELK/README.md#elk-docker-container-for-aemcs-cdn-log-analysis) guide.
