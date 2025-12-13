---
title: Översikt - Skydda AEM webbplatser
description: Lär dig hur du skyddar dina AEM webbplatser från DoS, DDoS och skadlig trafik med hjälp av trafikfilterregler, inklusive dess underkategori av WAF-regler (Web Application Firewall) i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2025-06-04T00:00:00Z
jira: KT-13148
thumbnail: null
exl-id: e6d67204-2f76-441c-a178-a34798fe266d
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '1185'
ht-degree: 0%

---

# Översikt - Skydda AEM webbplatser

Lär dig hur du skyddar dina AEM webbplatser från DoS (Denial of Service), DDOS (Distributed Denial of Service), skadlig trafik och avancerade attacker med **trafikfilterregler**, inklusive dess underkategori för reglerna för **Brandvägg för webbprogram (WAF)** i AEM as a Cloud Service.

Du kan också lära dig mer om skillnaderna mellan standardtrafikfilter och WAF trafikfilterregler, när de ska användas och hur du kommer igång med regler som rekommenderas av Adobe.

>[!IMPORTANT]
>
> WAF trafikfilterregler kräver ytterligare en licens för **WAF-DDoS-skydd** eller **Förbättrat skydd**. Standardregler för trafikfilter är som standard tillgängliga för Sites- och Forms-kunder.


>[!VIDEO](https://video.tv.adobe.com/v/3469394/?quality=12&learn=on)

## Introduktion till trafiksäkerhet i AEM as a Cloud Service

AEM as a Cloud Service använder ett integrerat CDN-lager för att skydda och optimera publiceringen av din webbplats. En av de viktigaste komponenterna i CDN-lagret är möjligheten att definiera och tillämpa trafikregler. Dessa regler fungerar som ett skydd som skyddar er webbplats mot missbruk, missbruk och attacker - utan att ge avkall på prestanda.

Trafiksäkerhet är nödvändigt för att upprätthålla drifttiden, skydda känsliga data och säkerställa en sömlös upplevelse för legitima användare. AEM har två kategorier av säkerhetsregler:

- **Standardtrafikfilterregler**
- **Brandväggsregler för trafikfilter för webbprogram (WAF)**

Regeluppsättningarna hjälper kunderna att förhindra vanliga och sofistikerade webbhot, minska bruset från illasinnade eller felande klienter och förbättra spårbarheten genom loggning av förfrågningar, blockering och mönsteridentifiering.

## Skillnad mellan standardtrafikfilterregler och WAF trafikfilterregler

| Funktion | Standardregler för trafikfilter | WAF trafikfilterregler |
|--------------------------|--------------------------------------------------|---------------------------------------------------------|
| Syfte | Förebygga missbruk som DoS, DDoS, scraping eller bot activity | Upptäck och reagera på sofistikerade anfallsmönster (t.ex. OWASP Top 10), som även skyddar mot stötar |
| Exempel | Hastighetsbegränsning, geoblockering, användaragentfiltrering | SQL-injektion, XSS, kända IP-adresser för attacker |
| Flexibilitet | Kan konfigureras mycket via YAML | Kan konfigureras mycket via YAML, med fördefinierade WAF-flaggor |
| Rekommenderat läge | Börja med läget `log` och gå sedan till läget `block` | Börja med `block`-läge för `ATTACK-FROM-BAD-IP` WAF-flagga och `log`-läge för `ATTACK` WAF-flagga och gå sedan till `block`-läge för båda |
| Distribution | Definieras i YAML och distribueras via Cloud Manager Config Pipeline | Definieras i YAML med `wafFlags` och distribueras via Cloud Manager Config Pipeline |
| Licenser | Ingår i Sites och Forms licenses | **Kräver WAF-DDoS-skydd eller utökad säkerhetslicens** |

Standardreglerna för trafikfilter är användbara för att tillämpa affärsspecifika principer, som hastighetsbegränsningar eller blockera specifika regioner, samt för att blockera trafik baserat på begäranegenskaper och rubriker som IP-adress, sökväg eller användaragent.
WAF trafikfilterregler ger å andra sidan ett omfattande förebyggande skydd för kända webbexplosioner och attackvektorer och har avancerad intelligens för att begränsa falska positiva effekter (dvs. blockera legitim trafik).
Om du vill definiera båda typerna av regler använder du YAML-syntaxen. Mer information finns i [Syntax för trafikfilterregler](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#rules-syntax).

## När och varför ska de användas

**Använd trafikfilterregler** när:

- Du vill använda organisationsspecifika begränsningar, som IP-tariffbegränsning.
- Du är medveten om specifika mönster (till exempel skadliga IP-adresser, regioner, rubriker) som behöver filtreras.

**Använd WAF trafikfilterregler** när:

- Du vill ha omfattande, **proaktivt skydd** från utspridda, kända attackmönster (till exempel injicering, protokollmissbruk) samt kända skadliga IP-adresser som samlats in från expertdatakällor.
- Du vill neka skadliga förfrågningar och samtidigt begränsa möjligheten att blockera legitim trafik.
- Du vill begränsa mängden arbete som krävs för att skydda dig mot vanliga och sofistikerade hot genom att tillämpa enkla konfigurationsregler.

Tillsammans utgör dessa regler en djupgående försvarsstrategi som gör det möjligt för AEM as a Cloud Service-kunder att vidta både proaktiva och reaktiva åtgärder för att säkra sina digitala tillgångar.

## Regler som Adobe rekommenderar

Adobe innehåller rekommenderade regler för standardtrafikfilter och trafikfilterregler från WAF som hjälper dig att snabbt skydda dina AEM-webbplatser.

- **Standardregler för trafikfilter** (tillgängligt som standard): Åtgärda vanliga missförhållanden som DoS-, DDoS- och robotattacker mot **CDN-kant**, **ursprung** eller trafik från länder som omfattas av sanktioner.\
  Exempel:
   - Hastighetsbegränsande IP:n som gör fler än 500 förfrågningar/sekund _vid CDN-kanten_
   - Hastighetsbegränsande IP:n som gör fler än 100 förfrågningar/sekund _vid ursprungsläget_
   - Blockera trafik från länder som anges av OFAC (Office of Foreign Assets Control)

- **WAF trafikfilterregler** (kräver tilläggslicens): Ger ytterligare skydd mot avancerade hot, inklusive [OWASP Top Ten](https://owasp.org/www-project-top-ten/) -hot som SQL-injektion, XSS (cross-site scripting) och andra webbprogramattacker.
Exempel:
   - Blockera förfrågningar från kända felaktiga IP-adresser
   - Logga eller blockera misstänkta förfrågningar som har flaggats som attacker

>[!TIP]
>
> Börja med att tillämpa de **Adobe-rekommenderade reglerna** för att dra nytta av Adobe säkerhetsexpertis och pågående uppdateringar. Om ditt företag har specifika risker eller edge-fall, eller om du får meddelanden om falska positiva inställningar (blockering av legitim trafik), kan du definiera **anpassade regler** eller utöka standarduppsättningen så att den uppfyller dina behov.

## Kom igång

Lär dig definiera, driftsätta, testa och analysera trafikfilterregler, inklusive WAF-regler, i AEM as a Cloud Service genom att följa installationsguiden och användningsexemplen nedan. Detta ger dig bakgrundskunskaper så att du senare tryggt kan tillämpa de Adobe-rekommenderade reglerna.

<!-- CARDS
{target = _self}

* ./setup.md
  {title = How to set up traffic filter rules including WAF rules}
  {description = Learn how to set up to create, deploy, test, and analyze the results of traffic filter rules including WAF rules.}
  {image = ./assets/setup/rules-setup.png}
  {cta = Start Now}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="How to set up traffic filter rules including WAF rules">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./setup.md" title="Konfigurera trafikfilterregler inklusive WAF-regler" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/setup/rules-setup.png" alt="Konfigurera trafikfilterregler inklusive WAF-regler"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./setup.md" target="_self" rel="referrer" title="Konfigurera trafikfilterregler inklusive WAF-regler">Konfigurera trafikfilterregler inklusive WAF-regler</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du konfigurerar för att skapa, distribuera, testa och analysera resultaten av trafikfilterregler, inklusive WAF-regler.</p>
                </div>
                <a href="./setup.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Starta nu </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Adobe rekommenderade guide för regelkonfiguration

Den här guiden innehåller stegvisa instruktioner för hur du konfigurerar och distribuerar trafikfilter som rekommenderas av Adobe och WAF i AEM as a Cloud Service-miljön.

<!-- CARDS
{target = _self}

* ./use-cases/using-traffic-filter-rules.md
  {title = Protecting AEM websites using standard traffic filter rules}
  {description = Learn how to protect AEM websites from DoS, DDoS and bot abuse using Adobe-recommended standard traffic filter rules in AEM as a Cloud Service.}
  {image = ./assets/use-cases/using-traffic-filter-rules.png}
  {cta = Apply Rules}

* ./use-cases/using-waf-rules.md
  {title = Protecting AEM websites using WAF rules}
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
                    <p class="is-size-6">Lär dig hur du skyddar AEM webbplatser från avancerade hot som DoS, DDoS och robotmissbruk med trafikfilterreglerna i Adobe rekommenderade Web Application Firewall (WAF) i AEM as a Cloud Service.</p>
                </div>
                <a href="./use-cases/using-waf-rules.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Aktivera WAF </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Avancerade användningsfall

För mer avancerade scenarier kan du utforska följande exempel som visar hur du implementerar anpassade trafikfilterregler baserat på specifika affärskrav:

<!-- CARDS
{target = _self}

* ./how-to/request-logging.md

* ./how-to/request-blocking.md

* ./how-to/request-transformation.md
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Monitoring sensitive requests">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./how-to/request-logging.md" title="Övervaka känsliga begäranden" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/how-to/wknd-login.png" alt="Övervaka känsliga begäranden"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./how-to/request-logging.md" target="_self" rel="referrer" title="Övervaka känsliga begäranden">Övervaka känsliga begäranden</a>
                    </p>
                    <p class="is-size-6">Lär dig övervaka känsliga begäranden genom att logga dem med trafikfilterregler i AEM as a Cloud Service.</p>
                </div>
                <a href="./how-to/request-logging.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Restricting access">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./how-to/request-blocking.md" title="Begränsa åtkomst" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/how-to/elk-tool-dashboard-blocked.png" alt="Begränsa åtkomst"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./how-to/request-blocking.md" target="_self" rel="referrer" title="Begränsa åtkomst">Begränsar åtkomst</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du begränsar åtkomsten genom att blockera specifika begäranden med trafikfilterregler i AEM as a Cloud Service.</p>
                </div>
                <a href="./how-to/request-blocking.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Normalizing requests">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./how-to/request-transformation.md" title="Normalisera begäranden" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="assets/how-to/aemrequest-log-transformation.png" alt="Normalisera begäranden"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./how-to/request-transformation.md" target="_self" rel="referrer" title="Normalisera begäranden">Normaliserar begäranden</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du normaliserar begäranden genom att omforma dem med trafikfilterregler i AEM as a Cloud Service.</p>
                </div>
                <a href="./how-to/request-transformation.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Ytterligare resurser

- [Trafikfilterregler inklusive WAF-regler](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf)
