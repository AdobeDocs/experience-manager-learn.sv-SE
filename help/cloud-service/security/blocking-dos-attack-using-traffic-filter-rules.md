---
title: Blockera DoS, DDoS och sofistikerade attacker med trafikfilterregler
description: Lär dig hur du blockerar DoS, DDoS och avancerade attacker med trafikfilterregler i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Security, Operations
topic: Security, Administration, Performance
role: Admin, Architect
level: Intermediate
doc-type: Tutorial
duration: 436
last-substantial-update: 2024-04-19T00:00:00Z
jira: KT-15184
thumbnail: KT-15184.jpeg
exl-id: 60c2306f-3cb6-4a6e-9588-5fa71472acf7
source-git-commit: 293157c296676ef1496e6f861ed8c2c24da7e068
workflow-type: tm+mt
source-wordcount: '609'
ht-degree: 0%

---

# Blockera DoS, DDoS och sofistikerade attacker med trafikfilterregler

Lär dig hur du blockerar DoS (Denial of Service), DoS (Distributed Denial of Service) och avancerade attacker med **trafikfilterregler** i det CDN som hanteras av AEM as a Cloud Service (AEMCS).

Dessa attacker orsakar trafiktoppar vid CDN och eventuellt vid AEM Publish Service (även kallat origin) och kan påverka webbplatsens tillgänglighet och tillgänglighet.

I den här artikeln finns en översikt över standardskyddet för din AEM-webbplats och hur du utökar dessa skydd med hjälp av kundkonfigurationen. Det beskriver också hur du analyserar trafikmönster och konfigurerar standardtrafikfilterregler för att blockera dessa attacker.

## Standardskydd i AEM as a Cloud Service

Nu ska vi veta vilka DDoS-skydd som är standard för din AEM-webbplats:

- **Cachelagring:** Med bra cachelagringsprinciper är effekten av en DDoS-attack mer begränsad eftersom CDN förhindrar att de flesta begäranden kommer till ursprungsläget och orsakar prestandaförsämring.
- **Automatisk skalning:** AEM författare och publicerar tjänster automatiskt för att hantera trafiktoppar, även om de fortfarande kan påverkas av plötsliga, massiva trafikökningar.
- **Blockering:** Adobe CDN blockerar trafik till ursprunget om den överskrider en Adobe-definierad frekvens från en viss IP-adress, per CDN PoP (Point of Presence).
- **Varning!** Åtgärdscentret skickar en trafikspik med varningsmeddelanden om trafiken överskrider en viss nivå. Den här varningen utlöses när trafiken till en angiven CDN PoP överskrider en _Adobe-definierad_ förfrågningsfrekvens per IP-adress. Mer information finns i [Varningar om trafikfilterregler](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#traffic-filter-rules-alerts).

Dessa inbyggda skydd bör betraktas som en baslinje för en organisations förmåga att minimera prestandapåverkan av en DDoS-attack. Eftersom varje webbplats har olika prestandaegenskaper och kan se att prestandaförsämringen innan den Adobe-definierade hastighetsgränsen uppnås, bör du utöka standardskyddet med _kundkonfigurationen_.

## Utökat skydd med trafikfilterregler

Låt oss titta på några ytterligare, rekommenderade åtgärder som kunderna kan vidta för att skydda sina webbplatser mot DDoS-attacker:

- Implementera [standardtrafikfilterregler](./traffic-filter-and-waf-rules/use-cases/using-traffic-filter-rules.md) som rekommenderas av Adobe för att identifiera potentiellt skadliga trafikmönster genom att logga och varna om misstänkt beteende.
- Använd tillägget **WAF-DDoS-skydd** eller **Förbättrat skydd** och implementera [WAF Traffic Filter Rules](./traffic-filter-and-waf-rules/use-cases/using-waf-rules.md) som Adobe rekommenderar för att skydda mot avancerade attacker, inklusive sådana som använder avancerade protokoll- eller nyttolastbaserade tekniker.
- Öka cachetäckningen genom att konfigurera [begärandeomformningar](./traffic-filter-and-waf-rules/how-to/request-transformation.md) för att ignorera onödiga frågeparametrar.

## Kom igång

Utforska följande självstudiekurser för att konfigurera Adobe rekommenderade regler för att blockera attacker.

<!-- CARDS
{target = _self}

* ./traffic-filter-and-waf-rules/setup.md
  {title = How to set up traffic filter rules including WAF rules}
  {description = Learn how to set up to create, deploy, test, and analyze the results of traffic filter rules including WAF rules.}
  {image = ./traffic-filter-and-waf-rules/assets/setup/rules-setup.png}
  {cta = Start Now}

* ./traffic-filter-and-waf-rules/use-cases/using-traffic-filter-rules.md
  {title = Protecting AEM websites using standard traffic filter rules}
  {description = Learn how to protect AEM websites from DoS, DDoS and bot abuse using Adobe-recommended standard traffic filter rules in AEM as a Cloud Service.}
  {image = ./traffic-filter-and-waf-rules/assets/use-cases/using-traffic-filter-rules.png}
  {cta = Apply Rules}

* ./traffic-filter-and-waf-rules/use-cases/using-waf-rules.md
  {title = Protecting AEM websites using WAF traffic filter rules}
  {description = Learn how to protect AEM websites from sophisticated threats including DoS, DDoS, and bot abuse using Adobe-recommended Web Application Firewall (WAF) traffic filter rules in AEM as a Cloud Service.}
  {image = ./traffic-filter-and-waf-rules/assets/use-cases/using-waf-rules.png}
  {cta = Activate WAF}

-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="How to set up traffic filter rules including WAF rules">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./traffic-filter-and-waf-rules/setup.md" title="Konfigurera trafikfilterregler inklusive WAF-regler" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./traffic-filter-and-waf-rules/assets/setup/rules-setup.png" alt="Konfigurera trafikfilterregler inklusive WAF-regler"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./traffic-filter-and-waf-rules/setup.md" target="_self" rel="referrer" title="Konfigurera trafikfilterregler inklusive WAF-regler">Konfigurera trafikfilterregler inklusive WAF-regler</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du konfigurerar för att skapa, distribuera, testa och analysera resultaten av trafikfilterregler, inklusive WAF-regler.</p>
                </div>
                <a href="./traffic-filter-and-waf-rules/setup.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Starta nu </span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Protecting AEM websites using standard traffic filter rules">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./traffic-filter-and-waf-rules/use-cases/using-traffic-filter-rules.md" title="Skydda AEM webbplatser med standardregler för trafikfilter" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./traffic-filter-and-waf-rules/assets/use-cases/using-traffic-filter-rules.png" alt="Skydda AEM webbplatser med standardregler för trafikfilter"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./traffic-filter-and-waf-rules/use-cases/using-traffic-filter-rules.md" target="_self" rel="referrer" title="Skydda AEM webbplatser med standardregler för trafikfilter">Skydda AEM webbplatser med standardtrafikfilterregler</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skyddar AEM webbplatser från DoS-, DDoS- och robotmissbruk med de standardregler för trafikfilter som rekommenderas av Adobe i AEM as a Cloud Service.</p>
                </div>
                <a href="./traffic-filter-and-waf-rules/use-cases/using-traffic-filter-rules.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Använd regler </span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Protecting AEM websites using WAF traffic filter rules">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./traffic-filter-and-waf-rules/use-cases/using-waf-rules.md" title="Skydda AEM webbplatser med WAF trafikfilterregler" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./traffic-filter-and-waf-rules/assets/use-cases/using-waf-rules.png" alt="Skydda AEM webbplatser med WAF trafikfilterregler"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./traffic-filter-and-waf-rules/use-cases/using-waf-rules.md" target="_self" rel="referrer" title="Skydda AEM webbplatser med WAF trafikfilterregler">Skydda AEM webbplatser med trafikfilterregler från WAF</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du skyddar AEM webbplatser från avancerade hot som DoS, DDoS och robotmissbruk med trafikfilterreglerna i Adobe rekommenderade Web Application Firewall (WAF) i AEM as a Cloud Service.</p>
                </div>
                <a href="./traffic-filter-and-waf-rules/use-cases/using-waf-rules.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Aktivera WAF </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->
