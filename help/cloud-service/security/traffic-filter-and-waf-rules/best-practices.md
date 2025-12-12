---
title: Metodtips för trafikfilterregler inklusive WAF-regler
description: Lär dig rekommenderade metoder för att konfigurera trafikfilterregler, inklusive WAF-regler i AEM as a Cloud Service, för att förbättra säkerheten och minska riskerna.
version: Experience Manager as a Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2025-06-04T00:00:00Z
jira: KT-18310
thumbnail: null
exl-id: 4a7acdd2-f442-44ee-8560-f9cb64436acf
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '638'
ht-degree: 0%

---

# Metodtips för trafikfilterregler inklusive WAF-regler

Lär dig rekommenderade metoder för att konfigurera trafikfilterregler, inklusive WAF-regler i AEM as a Cloud Service, för att förbättra säkerheten och minska riskerna.

>[!IMPORTANT]
>
>De bästa metoder som beskrivs i denna artikel är inte uttömmande och är inte avsedda att ersätta dina egna säkerhetsregler och -förfaranden.

## Allmän bästa praxis

- Börja med den [rekommenderade uppsättningen](./overview.md#adobe-recommended-rules) standardtrafikfilter och WAF-regler som tillhandahålls av Adobe, och justera dem baserat på programmets specifika behov och hotlandskap.
- Samarbeta med säkerhetsteamet för att ta reda på vilka regler som är anpassade till organisationens säkerhetsposition och efterlevnadskrav.
- Testa alltid nya eller uppdaterade regler i utvecklingsmiljöer innan du marknadsför dem till scenen och produktionen.
- När du deklarerar och validerar regler börjar du med typen `action` `log` för att observera beteendet utan att blockera legitim trafik.
- Flytta endast från `log` till `block` efter att ha analyserat tillräckliga trafikdata och bekräftat att inga giltiga begäranden påverkas.
- Lägg in regler stegvis, inklusive kvalitetstestning, prestationer och säkerhetstestning för att identifiera oönskade biverkningar.
- Granska och analysera regelns effektivitet regelbundet med [kontrollpanelsverktyget](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling). Granskningsfrekvensen (dagligen, veckovis, månadsvis) bör anpassas till webbplatsens trafikvolym och riskprofil.
- Kontinuerligt förfina reglerna baserat på nya hotbedömningar, trafikbeteende och granskningsresultat.

## Bästa tillvägagångssätt för trafikfilterregler

- Använd de [rekommenderade standardtrafikfilterreglerna](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#recommended-starter-rules) som baslinje, som innehåller regler för kant, ursprungsskydd och OFAC-baserade begränsningar.
- Granska varningar och loggar regelbundet för att identifiera mönster för missbruk eller felkonfigurering.
- Justera tröskelvärden för hastighetsbegränsningar baserat på programmets trafikmönster och användarbeteende.

  Se följande tabell för vägledning om hur du väljer tröskelvärden:

  | Variation | Värde |
  | :--------- | :------- |
  | Ursprung | Använd det högsta värdet för Max Origin Requests per IP/POP under **normala** trafikförhållanden (d.v.s. inte hastigheten vid tidpunkten för ett DDoS) och öka den med flera |
  | Edge | Ta det högsta värdet av Max Edge-begäranden per IP/POP under **normala** trafikförhållanden (d.v.s. inte hastigheten vid tidpunkten för ett DDoS) och öka den med flera |

  Mer information finns även i avsnittet [Välja tröskelvärden](../blocking-dos-attack-using-traffic-filter-rules.md#choosing-threshold-values).

- Flytta endast till åtgärden `block` efter att ha bekräftat att åtgärden `log` inte påverkar legitim trafik.

## God praxis för WAF regler

- Börja med Adobe [rekommenderade WAF-regler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#recommended-nonwaf-starter-rules), som innehåller regler för att blockera kända felaktiga IP-adresser, identifiera DDoS-attacker och minska robotmissbruk.
- WAF-flaggan `ATTACK` bör varna dig för potentiella hot. Kontrollera att det inte finns några falska positiva inställningar innan du går till `block`.
- Om rekommenderade WAF-regler inte täcker specifika hot bör du skapa anpassade regler som baseras på programmets unika krav. Se en fullständig lista över [WAF-flaggor](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#waf-flags-list) i dokumentationen.

## Genomförandebestämmelser

Lär dig hur du implementerar trafikfilterregler och WAF-regler i AEM as a Cloud Service:

<!-- CARDS
{target = _self}

* ./use-cases/using-traffic-filter-rules.md
  {title = Protecting AEM websites using standard traffic filter rules}
  {description = Learn how to protect AEM websites from DoS, DDoS and bot abuse using Adobe-recommended standard traffic filter rules in AEM as a Cloud Service.}
  {image = ./assets/use-cases/using-traffic-filter-rules.png}
  {cta = Apply Rules}

* ./use-cases/using-waf-rules.md
  {title = Protecting AEM websites using WAF traffic filter rules}
  {description = Learn how to protect AEM websites from sophisticated threats including DoS, DDoS, and bot abuse using Adobe-recommended Web Application Firewall (WAF) traffic filter rules in AEM as a Cloud Service.}
  {image = ./assets/use-cases/using-waf-rules.png}
  {cta = Activate WAF}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Protecting AEM websites using standard traffic filter rules">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/using-traffic-filter-rules.md" title="Skydda AEM webbplatser med standardregler för trafikfilter" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/use-cases/using-traffic-filter-rules.png" alt="Skydda AEM webbplatser med standardregler för trafikfilter"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/using-traffic-filter-rules.md" target="_self" rel="referrer" title="Skydda AEM webbplatser med standardregler för trafikfilter">Skydda AEM webbplatser med standardtrafikfilterregler</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skyddar AEM webbplatser från DoS-, DDoS- och robotmissbruk med de standardregler för trafikfilter som rekommenderas av Adobe i AEM as a Cloud Service.</p>
                </div>
                <a href="./use-cases/using-traffic-filter-rules.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Använd regler </span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Protecting AEM websites using WAF rules">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/using-waf-rules.md" title="Skydda AEM webbplatser med WAF regler" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/use-cases/using-waf-rules.png" alt="Skydda AEM webbplatser med WAF regler"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/using-waf-rules.md" target="_self" rel="referrer" title="Skydda AEM webbplatser med WAF regler">Skydda AEM webbplatser med WAF regler</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skyddar AEM webbplatser från avancerade hot som DoS, DDoS och robotmissbruk med Adobe rekommenderade regler för brandvägg för webbapplikationer (WAF) i AEM as a Cloud Service.</p>
                </div>
                <a href="./use-cases/using-waf-rules.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Aktivera WAF </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Ytterligare resurser

- [Trafikfilterregler inklusive WAF-regler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf)
- [Förstå DoS/DDoS-skydd i AEM](https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/security/understanding-dos-and-prevention-approaches)
- [Blockera DoS- och DDoS-attacker med trafikfilterregler](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/blocking-dos-attack-using-traffic-filter-rules)
