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
exl-id: e6d67204-2f76-441c-a178-a34798fe266d
duration: 165
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '270'
ht-degree: 0%

---

# Skydda webbplatser med trafikfilterregler (inklusive WAF-regler)

Lär dig mer om **trafikfilterregler**, inklusive underkategorin **Brandväggsregler för webbprogram (WAF)** i AEM as a Cloud Service (AEMCS). Läs om hur du skapar, distribuerar och testar reglerna. Analysera även resultaten för att skydda dina AEM webbplatser.

>[!VIDEO](https://video.tv.adobe.com/v/3425401?quality=12&learn=on)

## Ökning

Minska risken för säkerhetsintrång är en högsta prioritet för alla organisationer. AEMCS erbjuder trafikfilterregelfunktionen, inklusive WAF-regler, för att skydda webbplatser och applikationer.

Trafikfilterregler distribueras till det [inbyggda CDN](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn.html) och utvärderas innan begäran når den AEM infrastrukturen. Med den här funktionen kan du förbättra säkerheten på din webbplats avsevärt och se till att endast berättigade förfrågningar får tillgång till den AEM infrastrukturen.

Den här självstudiekursen vägleder dig genom processen att skapa, distribuera, testa och analysera resultaten av trafikfilterregler, inklusive WAF-regler.

Du kan läsa mer om trafikfilterregler i [den här artikeln](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf.html?lang=en).

>[!IMPORTANT]
>
> En underkategori av trafikfilterregler som kallas &quot;WAF-regler&quot; kräver en WAF-DDoS-skydd eller en förbättrad säkerhetslicens.

Vi erbjuder dig att ge feedback eller ställa frågor om trafikfilterregler genom att skicka **aemcs-waf-adopter@adobe.com** via e-post.

## Nästa steg

Lär dig [hur du konfigurerar](./how-to-setup.md) funktionen så att du kan skapa, distribuera och testa trafikfilterregler. Läs om hur du konfigurerar kontrollpanelen för stacken **Elasticsearch, Logstash och Kibana (ELK)** för att analysera resultaten av dina AEMCS CDN-loggar.


