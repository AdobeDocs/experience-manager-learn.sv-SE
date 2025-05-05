---
title: Verktyg för analys av CDN-logg
description: Lär dig mer om det CDN-logganalysverktyg som tillhandahålls av Adobe för AEM Cloud-tjänster och hur det hjälper dig att få insikter om både CDN-prestanda och AEM-implementering.
version: Experience Manager as a Cloud Service
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
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '442'
ht-degree: 0%

---

# Verktyg för analys av CDN-logg

Lär dig mer om _AEM Cloud Service CDN Log Analysis Tooling_ som Adobe tillhandahåller och hur det hjälper dig att få insikter om både CDN-prestanda och AEM-implementering.
 
>[!VIDEO](https://video.tv.adobe.com/v/3446109?quality=12&learn=on&captions=swe)

## Ökning

[AEM as a Cloud Service CDN Log Analysis Tooling](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling) erbjuder fördefinierade instrumentpaneler som du kan integrera med [Splunk](https://www.splunk.com/en_us/products/observability-cloud.html) eller [ELK-stacken](https://www.elastic.co/elastic-stack) för realtidsövervakning och analys av dina CDN-loggar.

Med den här verktygen kan du få realtidsövervakning och proaktiv problemidentifiering. På så sätt säkerställs optimerad innehållsleverans och korrekta säkerhetsåtgärder mot DoS-attacker (Denial of Service) och DDOS-attacker (Distributed Denial of Service).

## Viktiga funktioner

- Effektiv logganalys
- Övervakning i realtid
- Smidig integrering
- Kontrollpaneler för
   - identifiera potentiella säkerhetshot
   - Snabbare slutanvändarupplevelse

## Översikt över instrumentpanelen

För att snabbt komma igång med logganalysen tillhandahåller Adobe fördefinierade kontrollpaneler för både Splunk- och ELK-stacken.

- **Träffgrad för CDN-cache**: ger insikter om den totala träffkvoten för cache och det totala antalet begäranden med HIT-, PASS- och MISS-status. Den tillhandahåller även de bästa URL:erna för HIT, PASS och MISS.

  ![Träffgrad för CDN-cache](assets/CHR-dashboard.png)

- **CDN Traffic Dashboard**: ger insikter om trafiken via CDN och begärandefrekvens för ursprung, felfrekvens på 4xx och 5xx samt icke-cachelagrade begäranden. Det ger även max antal CND- och origin-begäranden per sekund per klient-IP-adress och fler insikter för att optimera CDN-konfigurationerna.

  ![Kontrollpanel för CDN-trafik](assets/Traffic-dashboard.png)

- **WAF Dashboard**: Tillhandahåller insikter via begäranden som har analyserats, flaggats och blockerats. Det innehåller även toppattacker från WAF Flag ID, de 100 främsta angriparna per klient-IP, land och användaragent samt fler insikter för att optimera WAF-konfigurationerna.

  ![WAF Dashboard](assets/WAF-Dashboard.png)

## Splunk-integrering

För organisationer som utnyttjar [Splunk](https://www.splunk.com/en_us/products/observability-cloud.html) och som har aktiverat AEMCS-loggvidarebefordran till Splunk-instanserna kan du snabbt importera fördefinierade instrumentpaneler. Den här konfigurationen underlättar snabbare logganalys och ger användbara insikter för att optimera AEM-implementeringar och minska säkerhetshot som DOS-attacker.

Du kan komma igång med hjälp av guiden [Splunk dashboards för AEMCS CDN Log Analysis](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/Splunk/README.md#splunk-dashboards-for-aemcs-cdn-log-analysis).


## Integrering med ELK

[ELK-stacken](https://www.elastic.co/elastic-stack), som innehåller Elasticsearch, Logstash och Kibana, är ett annat kraftfullt alternativ för logganalys. Det är användbart för organisationer som inte har tillgång till en Splunk-konfiguration eller funktioner för vidarebefordran av loggar. Det är enkelt att konfigurera ELK-stacken lokalt. Verktyget ger tillgång till Docker Compose-filen så att du snabbt kommer igång. Sedan kan du importera de färdiga kontrollpanelerna och importera CDN-loggarna som hämtas med Adobe Cloud Manager.

Du kan komma igång med hjälp av [ELK Docker-behållaren för guiden AEMCS CDN Log Analysis](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/ELK/README.md#elk-docker-container-for-aemcs-cdn-log-analysis).
