---
title: Skydda AEM webbplatser med WAF regler
description: Lär dig hur du skyddar AEM webbplatser från avancerade hot som DoS, DDoS och robotmissbruk med Adobe rekommenderade regler för brandvägg för webbapplikationer (WAF) i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2025-06-04T00:00:00Z
badgeLicense: label="Kräver licens" type="positive" before-title="true"
jira: KT-18308
thumbnail: null
exl-id: b87c27e9-b6ab-4530-b25c-a98c55075aef
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '1376'
ht-degree: 0%

---

# Skydda AEM webbplatser med WAF regler

Lär dig hur du skyddar AEM webbplatser från avancerade hot som DoS, DDoS och robotmissbruk med _Adobe-rekommenderade_ **Brandväggsregler för webbprogram (WAF)** i AEM as a Cloud Service.

De sofistikerade attackerna kännetecknas av hög begärandefrekvens, komplexa mönster och användning av avancerad teknik för att kringgå traditionella säkerhetsåtgärder.

>[!IMPORTANT]
>
> WAF trafikfilterregler kräver ytterligare en licens för **WAF-DDoS-skydd** eller **Förbättrat skydd**. Standardregler för trafikfilter är som standard tillgängliga för Sites- och Forms-kunder.


>[!VIDEO](https://video.tv.adobe.com/v/3469397/?quality=12&learn=on)

## Utbildningsmål

- Läs WAF regler som Adobe rekommenderar.
- Definiera, driftsätt, testa och analysera regelresultaten.
- Förstå när och hur reglerna ska förfinas baserat på resultaten.
- Lär dig hur du använder AEM Actions Center för att granska varningar som genererats av reglerna.

### Implementeringsöversikt

Implementeringsstegen omfattar:

- Lägger till WAF-reglerna i AEM WKND-projektets `/config/cdn.yaml`-fil.
- Implementera och skicka ändringarna till Cloud Manager Git-databasen.
- Distribuera ändringarna i AEM-miljön med Cloud Manager konfigurationsflöde.
- Testa reglerna genom att simulera en DDoS-attack med [Nikto](https://github.com/sullo/nikto/wiki).
- Analysera resultaten med hjälp av AEMCS CDN-loggarna och ELK-kontrollpanelen.

## Förutsättningar

Innan du fortsätter bör du kontrollera att du har slutfört de nödvändiga inställningarna enligt anvisningarna i självstudiekursen [Så här konfigurerar du trafikfilter och WAF-regler](../setup.md). Du har också klonat och distribuerat [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) till din AEM-miljö.

## Granska och definiera regler

Regler som rekommenderas av Adobe för brandvägg för webbaserade program (WAF) är viktiga för att skydda AEM webbplatser mot avancerade hot, som DoS, DDoS och robotmissbruk. De sofistikerade attackerna kännetecknas ofta av hög begärandefrekvens, komplexa mönster och användning av avancerad teknik (protokollbaserade eller nyttolastbaserade attacker) för att kringgå traditionella säkerhetsåtgärder.

Vi ska granska tre rekommenderade WAF-regler som ska läggas till i filen `cdn.yaml` i AEM WKND-projektet:

### &#x200B;1. Blockera attacker från kända skadliga IP-adresser

Den här regeln **blockerar** begäranden som båda ser misstänkt *och* härstammar från IP-adresser som har flaggats som skadliga. Eftersom båda dessa kriterier är uppfyllda kan vi vara säkra på att risken för falska positiva faktorer (blockera legitim trafik) är mycket låg. Kända dåliga IP-adresser identifieras utifrån hotunderrättelsefeeds och andra källor.

WAF-flaggan `ATTACK-FROM-BAD-IP` används för att identifiera dessa begäranden. Den samlar flera av WAF-flaggorna [som listas här](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#waf-flags-list).

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes: ["dev", "stage", "prod"]
data:
  trafficFilters:
    rules:
    - name: attacks-from-bad-ips-globally
      when:
        reqProperty: tier
        in: ["author", "publish"]
      action:
        type: block
        wafFlags:
          - ATTACK-FROM-BAD-IP
```

### &#x200B;2. Logga (och senare blockera) attacker från alla IP-adresser globalt

Den här regeln **loggar** begäranden som identifieras som potentiella attacker, även om IP-adresserna inte hittas i hotinformationsflöden.

WAF-flaggan `ATTACK` används för att identifiera dessa begäranden. Liknar `ATTACK-FROM-BAD-IP`,   samlar flera WAF-flaggor.

Dessa begäranden är sannolikt skadliga, men eftersom IP-adresserna inte identifieras i hotinformationsflöden kan det vara klokt att starta i `log`-läge i stället för i blockläge. Analysera loggarna för att se om det finns falskt positiva resultat, och när den har validerats **måste du ändra regeln till `block` mode**.

```yaml
...
    - name: attacks-from-any-ips-globally
      when:
        reqProperty: tier
        in: ["author", "publish"]
      action:
        type: log
        alert: true
        wafFlags:
          - ATTACK
```

Du kan också välja att använda läget `block` omedelbart om dina affärskrav är sådana att du inte vill ta någon risk av skadlig trafik.

Dessa rekommenderade WAF-regler utgör ytterligare ett säkerhetsskikt mot kända och nya hot.

![WKND WAF-regler](../assets/use-cases/wknd-cdn-yaml-waf-rules.png)

## Migrera till de senaste WAF-reglerna som rekommenderas av Adobe

Innan flaggorna `ATTACK-FROM-BAD-IP` och `ATTACK` för WAF introducerades (i juli 2025) var de rekommenderade WAF-reglerna följande. De innehöll en lista med specifika WAF-flaggor för att blockera begäranden som matchade vissa villkor, som `SANS`, `TORNODE`, `NOUA` osv.

```yaml
...
data:
  trafficFilters:
    rules:
    ...
    # Enable WAF protections (only works if WAF is enabled for your environment)
      - name: block-waf-flags
        when:
          reqProperty: tier
          matches: "author|publish"
        action:
          type: block
          wafFlags:
            - SANS
            - TORNODE
            - NOUA
            - SCANNER
            - USERAGENT
            - PRIVATEFILE
            - ABNORMALPATH
            - TRAVERSAL
            - NULLBYTE
            - BACKDOOR
            - LOG4J-JNDI
            - SQLI
            - XSS
            - CODEINJECTION
            - CMDEXE
            - NO-CONTENT-TYPE
            - UTF8
...
```

Regeln ovan är fortfarande giltig, men vi rekommenderar att du migrerar till de nya reglerna som använder flaggorna `ATTACK-FROM-BAD-IP` och `ATTACK` WAF _, förutsatt att du inte redan har anpassat `wafFlags` så att den passar dina affärsbehov_.

Du kan migrera till de nya reglerna så att de överensstämmer med bästa praxis genom att följa dessa steg:

- Granska de befintliga WAF-reglerna i din `cdn.yaml`-fil, som kan se ut som i exemplet ovan. Bekräfta att det inte finns någon anpassning av `wafFlags` som är specifik för dina affärskrav.

- Ersätt dina befintliga WAF-regler med de nya Adobe-rekommenderade WAF-reglerna som använder flaggorna `ATTACK-FROM-BAD-IP` och `ATTACK`. Kontrollera att alla regler är i blockläge.

Om du tidigare har anpassat `wafFlags` kan du fortfarande migrera till dessa nya regler, men gör det noga så att du ser till att eventuella anpassningar förs in i de reviderade reglerna.

Migreringen bör hjälpa er att förenkla era WAF-regler samtidigt som ni får ett robust skydd mot avancerade hot. De nya reglerna är utformade för att vara effektivare och enklare att hantera.


## Distribuera regler

Så här distribuerar du ovanstående regler:

- Verkställ och skicka ändringarna till Cloud Manager Git-databasen.

- Distribuera ändringarna i AEM-miljön med Cloud Manager konfigurationspipeline [som skapades tidigare](../setup.md#deploy-rules-using-adobe-cloud-manager).

  ![Cloud Manager Config Pipeline](../assets/use-cases/cloud-manager-config-pipeline.png)

## Testregler

Om du vill verifiera WAF-regelns effektivitet simulerar du en attack med [Nikto](https://github.com/sullo/nikto), en webbserverskanner som upptäcker sårbarheter och felkonfigurationer. Följande kommando utlöser SQL-injektionsattacker mot AEM WKND-webbplatsen, som skyddas av WAF regler.

```shell
$./nikto.pl -useragent "AttackSimulationAgent (Demo/1.0)" -D V -Tuning 9 -ssl -h https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html
```

![Simulering av Nikto-attack](../assets/use-cases/nikto-attack.png)

Om du vill lära dig mer om attacksimulering kan du läsa dokumentationen för [Nikto - skannerjustering](https://github.com/sullo/nikto/wiki/Scan-Tuning) som innehåller information om hur du anger vilken typ av testattacker som ska inkluderas eller exkluderas.

## Granska aviseringar

Varningar genereras när trafikfilterreglerna aktiveras. Du kan granska dessa varningar i [AEM Actions Center](https://experience.adobe.com/aem/actions-center).

![WKND AEM Actions Center](../assets/use-cases/wknd-aem-action-center.png)

## Analysera resultaten

Om du vill analysera resultatet av trafikfilterreglerna kan du använda AEMCS CDN-loggarna och ELK-kontrollpanelen. Följ instruktionerna från inställningsavsnittet [CDN-loggar &#x200B;](../setup.md#ingest-cdn-logs) för att importera CDN-loggarna till ELK-stacken.

På följande skärmbild ser du CDN-loggarna i AEM Dev-miljön som är inkapslade i ELK-stacken.

![WKND CDN-loggar ELK](../assets/use-cases/wknd-cdn-logs-elk-waf.png)

I ELK-programmet ska **WAF Dashboard** visa
Flaggade begäranden och motsvarande värden i klientens IP-kolumner (cli_ip), värd, url, åtgärd (waf_action) och rule-name-kolumner (waf_match).

![WKND WAF Dashboard ELK](../assets/use-cases/elk-tool-dashboard-waf-flagged.png)

På panelerna **WAF Flags distribution** och **Top-attacker** visas även ytterligare information.

![WKND WAF Dashboard ELK](../assets/use-cases/elk-tool-dashboard-waf-flagged-top-attacks-1.png)

![WKND WAF Dashboard ELK](../assets/use-cases/elk-tool-dashboard-waf-flagged-top-attacks-2.png)

![WKND WAF Dashboard ELK](../assets/use-cases/elk-tool-dashboard-waf-flagged-top-attacks-3.png)

### Splunk-integrering

Kunder som har [Splunk Log-vidarebefordran aktiverad](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/developing/logging#splunk-logs) kan skapa nya instrumentpaneler för att analysera trafikmönstren.

Om du vill skapa kontrollpaneler i Splunk följer du stegen [Splunk dashboards för AEMCS CDN Log Analysis](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/Splunk/README.md#splunk-dashboards-for-aemcs-cdn-log-analysis).

## När och hur du förfinar regler

Ert mål är att undvika att blockera legitim trafik samtidigt som ni skyddar era AEM webbplatser från sofistikerade hot. De rekommenderade WAF-reglerna är utformade som en startpunkt för din säkerhetsstrategi.

Om du vill förfina reglerna gör du så här:

- **Övervaka trafikmönster**: Använd CDN-loggarna och ELK-kontrollpanelen för att övervaka trafikmönster och identifiera eventuella avvikelser eller toppar i trafiken. Var uppmärksam på panelerna _WAF flaggar distribution_ och _Top attack_ på ELK-kontrollpanelen för att förstå vilka typer av attacker som identifieras.
- **Justera wafFlags**: Om `ATTACK` flaggor aktiveras för ofta eller
Om du behöver finjustera attackvektorn kan du skapa anpassade regler med specifika WAF-flaggor. Se en fullständig lista över [WAF-flaggor](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#waf-flags-list) i dokumentationen. Överväg att först testa nya anpassade regler i `log`-läge.
- **Flytta till blockeringsregler**: När du har verifierat trafikmönstren och justerat WAF-flaggorna kan du överväga att gå över till blockeringsregler.

## Sammanfattning

I den här självstudiekursen lärde du dig att skydda AEM webbplatser från avancerade hot som DoS, DDoS och robotmissbruk med Adobe rekommenderade regler för brandvägg för webbapplikationer (WAF).

## Användningsexempel - mer än standardregler

För mer avancerade scenarier kan du utforska följande exempel som visar hur du implementerar anpassade trafikfilterregler baserat på specifika affärskrav:

<!-- CARDS
{target = _self}

* ../how-to/request-logging.md

* ../how-to/request-blocking.md

* ../how-to/request-transformation.md
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Monitoring sensitive requests">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="../how-to/request-logging.md" title="Övervaka känsliga begäranden" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="../assets/how-to/wknd-login.png" alt="Övervaka känsliga begäranden"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="../how-to/request-logging.md" target="_self" rel="referrer" title="Övervaka känsliga begäranden">Övervaka känsliga begäranden</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du övervakar känsliga begäranden genom att logga dem med trafikfilterregler i AEM as a Cloud Service.</p>
                </div>
                <a href="../how-to/request-logging.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Restricting access">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="../how-to/request-blocking.md" title="Begränsa åtkomst" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="../assets/how-to/elk-tool-dashboard-blocked.png" alt="Begränsa åtkomst"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="../how-to/request-blocking.md" target="_self" rel="referrer" title="Begränsa åtkomst">Begränsar åtkomst</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du begränsar åtkomsten genom att blockera specifika begäranden med trafikfilterregler i AEM as a Cloud Service.</p>
                </div>
                <a href="../how-to/request-blocking.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Normalizing requests">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="../how-to/request-transformation.md" title="Normalisera begäranden" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="../assets/how-to/aemrequest-log-transformation.png" alt="Normalisera begäranden"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="../how-to/request-transformation.md" target="_self" rel="referrer" title="Normalisera begäranden">Normaliserar begäranden</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du normaliserar begäranden genom att omforma dem med trafikfilterregler i AEM as a Cloud Service.</p>
                </div>
                <a href="../how-to/request-transformation.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Läs mer</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Ytterligare resurser

- [Rekommenderade startregler](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#recommended-nonwaf-starter-rules)
- [WAF-flagglista](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#waf-flags-list)
