---
title: Skydda webbplatser med trafikfilterregler (inklusive WAF-regler)
description: Läs mer om reglerna för trafikfilter, inklusive dess underkategori enligt reglerna för Web Application Firewall (WAF). Skapa, distribuera och testa reglerna. Analysera även resultaten för att skydda dina AEM webbplatser.
version: Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Architect
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-10-26T00:00:00Z
jira: KT-13148
thumbnail: KT-13148.jpeg
source-git-commit: 3752e22455020b58d23524f7e6a99414e773422d
workflow-type: tm+mt
source-wordcount: '266'
ht-degree: 0%

---


# Skydda webbplatser med trafikfilterregler (inklusive WAF-regler)

Läs mer om **trafikfilterregler**, inklusive dess underkategori **Brandväggsregler för webbaserade program (WAF)** på AEM as a Cloud Service (AEMCS). Läs om hur du skapar, distribuerar och testar reglerna. Analysera även resultaten för att skydda dina AEM webbplatser.

## Översikt

Minska risken för säkerhetsintrång är en högsta prioritet för alla organisationer. AEMCS erbjuder trafikfilterregelfunktionen, inklusive WAF-regler, för att skydda webbplatser och applikationer.

Trafikfilterregler distribueras till [inbyggd CDN](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn.html) och utvärderas innan begäran når AEM. Med den här funktionen kan du förbättra säkerheten på din webbplats avsevärt och se till att endast berättigade förfrågningar får tillgång till den AEM infrastrukturen.

Den här självstudiekursen vägleder dig genom processen att skapa, distribuera, testa och analysera resultaten av trafikfilterregler, inklusive WAF-regler.

Du kan läsa mer om trafikfilterregler i [den här artikeln](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf.html?lang=en)

>[!IMPORTANT]
>
> En underkategori av trafikfilterregler som kallas &quot;WAF-regler&quot; kräver en WAF-DDoS-skyddslicens


## Nästa steg

Läs [konfigurera](./how-to-setup.md) funktionen så att du kan skapa, distribuera och testa trafikfilterregler. Läs om hur du konfigurerar **Elasticsearch, Logstash och Kibana (ELK)** kontrollpanelsverktyg för stackar för att analysera resultaten av dina AEMCS CDN-loggar.



