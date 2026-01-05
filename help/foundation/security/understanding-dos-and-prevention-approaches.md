---
title: Förstå DoS/DDoS-skydd
description: Lär dig hur du förhindrar och förhindrar DoS- och DDoS-attacker mot AEM.
version: Experience Manager 6.5, Experience Manager as a Cloud Service
feature: Security
topic: Security, Development
role: Admin, Developer
level: Beginner
doc-type: Article
duration: 75
last-substantial-update: 2024-03-30T00:00:00Z
jira: KT-15219
exl-id: 1d7dd829-e235-4884-a13f-b6ea8f6b4b0b
source-git-commit: 7b29187ef84bebebd4586374abb09ced947dff28
workflow-type: tm+mt
source-wordcount: '374'
ht-degree: 1%

---

# Förstå DoS/DDoS-skydd i AEM

Läs mer om de alternativ som finns för att förhindra och begränsa DoS- och DDoS-attacker på din AEM-miljö. En kort översikt över [DoS](https://developer.mozilla.org/en-US/docs/Glossary/DOS_attack) och [DDoS](https://developer.mozilla.org/en-US/docs/Glossary/Distributed_Denial_of_Service) innan du börjar använda de förebyggande mekanismerna.

- DoS-attacker (Denial of Service) och DDoS-attacker (Distributed Denial of Service) är båda skadliga försök att störa den normala funktionen hos en målserver, tjänst eller nätverk, vilket gör den oåtkomlig för de avsedda användarna.
- DoS-attacker kommer vanligtvis från en enda källa, medan DDoS-attacker kommer från flera källor.
- DDoS-attacker är ofta större än DoS-attacker på grund av de kombinerade resurserna hos flera attackerande enheter.
- Dessa attacker genomförs genom att målet översvämmas av mycket trafik och sårbarheter utnyttjas i nätverksprotokoll.

I följande tabell beskrivs hur du förhindrar och minskar DoS- och DDoS-attacker:

<table>
    <tbody>
        <tr>
            <td><strong>Förebyggande mekanism</strong></td>
            <td><strong>Beskrivning</strong></td>
            <td><strong>AEM as a Cloud Service</strong></td>
            <td><strong>AEM 6.5 (AMS)</strong></td>
            <td><strong>AEM 6.5 (lokal)</strong></td>
        </tr>
        <tr>
            <td>Brandvägg för webbaserade program (WAF)</td>
            <td>En säkerhetslösning som utformats för att skydda webbapplikationer från olika typer av attacker.</td>
            <td>
            <a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/examples-and-analysis#waf-rules" target="_blank">Utökad säkerhet (tidigare WAF-DDoS-skydd) licens</a></td>
            <td><a href="https://docs.aws.amazon.com/waf/" target="_blank">AWS</a> eller <a href="https://azure.microsoft.com/en-us/products/web-application-firewall" target="_blank">Azure</a> WAF via AMS-kontrakt.</td>
            <td>Ditt favoritprogram för WAF</td>
        </tr>
        <tr>
            <td>ModSecurity</td>
            <td>ModSecurity (även kallad "mod_security" Apache-modulen) är en plattformsoberoende lösning med öppen källkod som skyddar mot en rad attacker mot webbprogram.<br/> I AEM as a Cloud Service gäller detta endast AEM Publish-tjänsten eftersom det inte finns någon Apache-webbserver och AEM Dispatcher framför AEM Author-tjänsten.</td>
            <td colspan="3"><a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/security/modsecurity-crs-dos-attack-protection" target="_blank">Aktivera ModSecurity </a></td>
        </tr>
        <tr>
            <td>Trafikfilterregler</td>
            <td>Trafikfilterregler kan användas för att blockera eller tillåta förfrågningar i CDN-lagret.</td>
            <td><a href="https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/examples-and-analysis" target="_blank">Exempel på trafikfilterregler</a></td>
            <td><a href="https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-type-rate-based.html" target="_blank">Regelbegränsningsfunktioner för AWS</a> eller <a href="https://learn.microsoft.com/en-us/azure/web-application-firewall/ag/rate-limiting-overview" target="_blank">Azure</a>.</td>
            <td>Den lösning du föredrar</td>
        </tr>
    </tbody>
</table>

## Analys efter incident och kontinuerlig förbättring

Det finns inte ett standardflöde som passar alla för att identifiera och förhindra DoS/DDoS-attacker, och det beror på organisationens säkerhetsprocess. **Efterfallsanalysen och den kontinuerliga förbättringen** är ett viktigt steg i processen. Här är några tips att tänka på:

- Identifiera grundorsaken till DoS/DDoS-attacken genom att utföra en analys efter incidenten, inklusive granskning av loggar, nätverkstrafik och systemkonfigurationer.
- Förbättra de förebyggande mekanismerna baserat på resultaten av analysen efter incidenter.

