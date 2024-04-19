---
title: Exempel och resultatanalys av trafikfilterregler inklusive WAF-regler
description: Lär dig olika trafikfilterregler inklusive exempel på WAF-regler. Du kan även analysera resultaten med hjälp av AEM as a Cloud Service (AEMCS) CDN-loggar.
version: Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Architect
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-10-26T00:00:00Z
jira: KT-13148
thumbnail: KT-13148.jpeg
exl-id: 49becbcb-7965-4378-bb8e-b662fda716b7
duration: 626
source-git-commit: 9af60e1d45eb4569e05ba135fec43e4c744b2a0d
workflow-type: tm+mt
source-wordcount: '1472'
ht-degree: 0%

---

# Exempel och resultatanalys av trafikfilterregler inklusive WAF-regler

Lär dig hur du deklarerar olika typer av trafikfilterregler och analyserar resultaten med hjälp av CDN-loggar och kontrollpanelsverktyg i Adobe Experience Manager as a Cloud Service (AEMCS).

I det här avsnittet kommer du att utforska praktiska exempel på trafikfilterregler, inklusive WAF-regler. Du får lära dig hur du loggar, tillåter och blockerar begäranden baserat på URI (eller sökväg), IP-adress, antalet förfrågningar och olika typer av attacker med [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project).

Dessutom kommer du att upptäcka hur du kan använda kontrollpanelsverktyg som importerar AEMCS CDN-loggar för att visualisera viktiga mätvärden via kontrollpaneler som tillhandahålls av Adobe.

Om du vill anpassa dig efter dina specifika krav kan du förbättra och skapa anpassade instrumentpaneler och på så sätt få djupare insikter och optimera regelkonfigurationerna för dina AEM.

>[!VIDEO](https://video.tv.adobe.com/v/3425404?quality=12&learn=on)

## Exempel

Låt oss utforska olika exempel på trafikfilterregler, inklusive WAF-regler. Kontrollera att du har slutfört den nödvändiga konfigurationsprocessen enligt beskrivningen i tidigare versioner [konfigurera](./how-to-setup.md) och att du har klonat [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd#aem-wknd-sites-project).

### Förfrågningar om loggning

Börja med **logga förfrågningar från WKND-inloggnings- och utloggningssökvägar** mot AEM Publish-tjänsten.

- Lägg till följande regel i WKND-projektets `/config/cdn.yaml` -fil.

```yaml
kind: CDN
version: '1'
metadata:
  envTypes:
    - dev
    - stage
    - prod
data:
  trafficFilters:
    rules:
    # On AEM Publish service log WKND Login and Logout requests
      - name: publish-auth-requests
        when:
          allOf:
            - reqProperty: tier
              matches: publish
            - reqProperty: path
              in:
                - /system/sling/login/j_security_check
                - /system/sling/logout
        action: log
```

- Verkställ och skicka ändringarna till Cloud Manager Git-databasen.

- Distribuera ändringarna i AEM Dev-miljön med hjälp av Cloud Manager `Dev-Config` konfigurationsflöde [skapades tidigare](how-to-setup.md#deploy-rules-through-cloud-manager).

  ![Konfigurationspipeline för Cloud Manager](./assets/cloud-manager-config-pipeline.png)

- Testa regeln genom att logga in och logga ut från programmets WKND-webbplats på Publiceringstjänst (till exempel `https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html`). Du kan använda `asmith/asmith` som användarnamn och lösenord.

  ![WKND-inloggning](./assets/wknd-login.png)

#### Analyserar{#analyzing}

Låt oss analysera resultaten av `publish-auth-requests` genom att hämta AEMCS CDN-loggar från Cloud Manager och använda [kontrollpanelsverktyg](how-to-setup.md#analyze-results-using-elk-dashboard-tool)som du skapade i det tidigare kapitlet.

- Från [Cloud Manager](https://my.cloudmanager.adobe.com/)&#39;s **Miljö** ladda ned AEMCS **Publicera** CDN-loggar för tjänsten.

  ![CDN-logghämtningar för Cloud Manager](./assets/cloud-manager-cdn-log-downloads.png)

  >[!TIP]
  >
  >    Det kan ta upp till 5 minuter innan de nya förfrågningarna visas i CDN-loggarna.

- Kopiera den hämtade loggfilen (till exempel `publish_cdn_2023-10-24.log` på skärmbilden nedan) i `logs/dev` mapp för det elastiska instrumentpanelsverktyget.

  ![Loggmapp för ELK-verktyg](./assets/elk-tool-logs-folder.png){width="800" zoomable="yes"}

- Uppdatera sidan med verktyget Elastic Dashboard.
   - Överst **Globalt filter** -avsnittet, redigera `aem_env_name.keyword` filtrera och markera `dev` miljövärde.

     ![ELK Tool Global Filter](./assets/elk-tool-global-filter.png)

   - Om du vill ändra tidsintervallet klickar du på kalenderikonen i det övre högra hörnet och väljer önskat tidsintervall.

     ![Tidsintervall för ELK-verktyg](./assets/elk-tool-time-interval.png)

- Granska den uppdaterade instrumentpanelens  **Analyserade förfrågningar**, **Flaggade begäranden** och **Information om flaggade begäranden** paneler. För matchande CDN-loggposter bör värdena för varje posts klient-IP (cli_ip), host, url, action (waf_action) och rule-name (waf_match) visas.

  ![Kontrollpanel för ELK-verktyg](./assets/elk-tool-dashboard.png)


### Blockera förfrågningar

I det här exemplet lägger vi till en sida i en _internal_ mapp vid sökvägen `/content/wknd/internal` i det distribuerade WKND-projektet. deklarera sedan en trafikfilterregel som **block** till undersidor från andra platser än en angiven IP-adress som matchar din organisation (till exempel ett VPN för företag).

Du kan antingen skapa en egen intern sida (till exempel `demo-page.html`) eller använder [bifogat paket](./assets/demo-internal-pages-package.zip).

- Lägg till följande regel i WKND-projektets `/config/cdn.yaml` fil:

```yaml
kind: CDN
version: '1'
metadata:
  envTypes:
    - dev
    - stage
    - prod
data:
  trafficFilters:
    rules:
    ...

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

- Distribuera ändringarna i AEM Dev-miljön med [tidigare skapad](how-to-setup.md#deploy-rules-through-cloud-manager) `Dev-Config` konfigurationsflöde i Cloud Manager.

- Testa regeln genom att gå till WKND-platsens interna sida, till exempel `https://publish-pXXXX-eYYYY.adobeaemcloud.com/content/wknd/internal/demo-page.html` eller med CURL-kommandot nedan:

  ```bash
  $ curl -I https://publish-pXXXX-eYYYY.adobeaemcloud.com/content/wknd/internal/demo-page.html
  ```

- Upprepa ovanstående steg från både IP-adressen som du använde i regeln och sedan en annan IP-adress (till exempel med mobiltelefonen).

#### Analyserar

Analysera resultaten av `block-internal-paths` -regeln, följ samma steg som beskrivs i [tidigare exempel](#analyzing).

Den här gången bör du dock se **Blockerade förfrågningar** och motsvarande värden i klientens IP-kolumner (cli_ip), värd, URL-adress, åtgärd (waf_action) och rule-name-kolumner (waf_match).

![Blockerad begäran för ELK Tool Dashboard](./assets/elk-tool-dashboard-blocked.png)


### Förhindra DoS-attacker

Låt oss **förhindra DoS-attacker** genom att blockera begäranden från en IP-adress som gör 100 förfrågningar per sekund, vilket gör att den blockeras i 5 minuter.

- Lägg till följande [trafikfilterregel för hastighetsbegränsning](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf.html#ratelimit-structure) i WKND-projektets `/config/cdn.yaml` -fil.

```yaml
kind: CDN
version: '1'
metadata:
  envTypes:
    - dev
    - stage
    - prod
data:
  trafficFilters:
    rules:
    ...
    #  Prevent DoS attacks by blocking client for 5 minutes if they make more than 100 requests in 1 second.
      - name: prevent-dos-attacks
        when:
          reqProperty: path
          like: '*'
        rateLimit:
          limit: 100
          window: 1
          penalty: 300
          groupBy:
            - reqProperty: clientIp
        action: block
```

>[!WARNING]
>
>Samarbeta med webbsäkerhetsteamet i produktionsmiljön för att ta reda på vilka värden som är lämpliga för `rateLimit`,

- Genomför, push och distribuera ändringar enligt [tidigare exempel](#logging-requests).

- Använd följande för att simulera DoS-attacken [Vegeta](https://github.com/tsenart/vegeta) -kommando.

  ```shell
  $ echo "GET https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html" | vegeta attack -rate=120 -duration=5s | vegeta report
  ```

  Med det här kommandot utförs 120 begäranden i 5 sekunder och en rapport skapas. Som du ser är antalet lyckade försök 32,5 %. En 406 HTTP-svarskod tas emot för resten, vilket visar att trafiken blockerades.

  ![Vegeta DoS-attack](./assets/vegeta-dos-attack.png)

#### Analyserar

Analysera resultaten av `prevent-dos-attacks` -regeln, följ samma steg som beskrivs i [tidigare exempel](#analyzing).

Den här gången bör du se många **Blockerade förfrågningar** och motsvarande värden i klientens IP-kolumner (cli_ip), värd, url, åtgärd (waf_action) och rule-name-kolumner (waf_match).

![ELK Tool Dashboard DoS Request](./assets/elk-tool-dashboard-dos.png)

Dessutom finns **De 100 viktigaste attackerna per klient-IP, land och användaragent** på panelerna visas ytterligare information som kan användas för att ytterligare optimera regelkonfigurationen.

![ELK Tool Dashboard DoS Top 100 Requests](./assets/elk-tool-dashboard-dos-top-100.png)

Mer information om hur du förhindrar DoS- och DDoS-attacker finns i [Blockera DoS- och DDoS-attacker med trafikfilterregler](../dos/blocking-dos-attack-using-traffic-filter-rules.md) självstudie.

### WAF-regler

Trafikfilterregelexemplen hittills kan konfigureras av alla Sites- och Forms-kunder.

Sedan ska vi utforska upplevelsen för en kund som har köpt en licens för Förbättrad säkerhet eller WAF-DDoS-skydd, som låter dem konfigurera avancerade regler för att skydda webbplatser från mer sofistikerade attacker.

Aktivera WAF-DDoS-skyddet för ditt program innan du fortsätter, enligt beskrivningen i dokumentationen för trafikfilterregler [konfigurationssteg](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf.html?lang=en#setup).

#### Utan WAFFlags

Låt oss först se upplevelsen även innan WAF-reglerna har deklarerats. När WAF-DDoS är aktiverat i ditt program loggar CDN som standard alla matchningar av skadlig trafik så att du har rätt information att komma fram med rätt regler.

Vi börjar med att angripa WKND-webbplatsen utan att lägga till en WAF-regel (eller använda `wafFlags` -egenskapen) och analysera resultaten.

- Använd [Nikto](https://github.com/sullo/nikto) nedan, som skickar runt 700 skadliga förfrågningar på 6 minuter.

  ```shell
  $ ./nikto.pl -useragent "AttackSimulationAgent (Demo/1.0)" -D V -Tuning 9 -ssl -h https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html
  ```

  ![Simulering av Nikto-attack](./assets/nikto-attack.png)

  Läs mer om attacksimulering i [Nikto - skanningsjustering](https://github.com/sullo/nikto/wiki/Scan-Tuning) dokumentation som anger hur du anger vilken typ av testattacker som ska inkluderas eller exkluderas.

##### Analyserar

Om du vill analysera resultatet av attacksimulering följer du de steg som beskrivs i [tidigare exempel](#analyzing).

Den här gången bör du dock se **Flaggade begäranden** och motsvarande värden i kolumnerna klient-IP (cli_ip), host, url, action (waf_action) och rule-name (waf_match). Med den här informationen kan du analysera resultaten och optimera regelkonfigurationen.

![ELK Tool Dashboard WAF Flagged Request](./assets/elk-tool-dashboard-waf-flagged.png)

Anteckna hur **WAF-flaggdistribution** och **De vanligaste attackerna** på panelerna visas ytterligare information som kan användas för att optimera regelkonfigurationen ytterligare.

![ELK Tool Dashboard WAF Flags Attacks Request](./assets/elk-tool-dashboard-waf-flagged-top-attacks-1.png)

![ELK Tool Dashboard WAF Top Attacks Request](./assets/elk-tool-dashboard-waf-flagged-top-attacks-2.png)


#### Med WAFFlags

Nu ska vi lägga till en WAF-regel som innehåller `wafFlags` som en del av `action` egenskap och **blockera simulerade attackförfrågningar**.

Ur syntaxperspektiv liknar emellertid WAF-reglerna de som har setts tidigare, `action` egenskapen refererar till en eller flera `wafFlags` värden. Läs mer om `wafFlags`, granska [WAF-flagglista](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf.html#waf-flags-list) -avsnitt.

- Lägg till följande regel i WKND-projektets `/config/cdn.yaml` -fil. Anteckna hur `block-waf-flags` regeln innehåller några av de wafFlags som hade funnits i kontrollpanelsverktyget när de attackerades med simulerad skadlig trafik. Det är god praxis att över tiden analysera loggar för att avgöra vilka nya regler som ska deklareras, allt eftersom hotelselandskapet utvecklas.

```yaml
kind: CDN
version: '1'
metadata:
  envTypes:
    - dev
    - stage
    - prod
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
```

- Genomför, push och distribuera ändringar enligt [tidigare exempel](#logging-requests).

- Använd samma [Nikto](https://github.com/sullo/nikto) som tidigare.

  ```shell
  $ ./nikto.pl -useragent "AttackSimulationAgent (Demo/1.0)" -D V -Tuning 9 -ssl -h https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html
  ```

##### Analyserar

Upprepa samma steg som beskrivs i [tidigare exempel](#analyzing).

Den här gången ska du se poster under **Blockerade förfrågningar** och motsvarande värden i kolumnerna klient-IP (cli_ip), host, url, action (waf_action) och rule-name (waf_match).

![Begäran om blockerad WAF-fil för instrumentpanelen för ELK](./assets/elk-tool-dashboard-waf-blocked.png)

Dessutom finns **WAF-flaggdistribution** och **De vanligaste attackerna** panelerna innehåller mer information.

![ELK Tool Dashboard WAF Flags Attacks Request](./assets/elk-tool-dashboard-waf-blocked-top-attacks-1.png)

![ELK Tool Dashboard WAF Top Attacks Request](./assets/elk-tool-dashboard-waf-blocked-top-attacks-2.png)

### Omfattande analys

I ovanstående _analys_ har du lärt dig att analysera resultaten av särskilda regler med hjälp av kontrollpanelsverktyget. Du kan utforska hur du analyserar resultaten med andra paneler på kontrollpanelen, bland annat:


- Analyserade, flaggade och blockerade begäranden
- WAF Flaggar distributionen över tid
- Regler för utlöst trafikfilter över tid
- De vanligaste attackerna av WAF-flagga-ID
- Topputlöst trafikfilter
- De 100 bästa angriparna per klient-IP, land och användaragent

![Heltäckande analys av ELK-verktygspanelen](./assets/elk-tool-dashboard-comprehensive-analysis-1.png)

![Heltäckande analys av ELK-verktygspanelen](./assets/elk-tool-dashboard-comprehensive-analysis-2.png)


## Nästa steg

Bekanta dig med våra rekommendationer [bästa praxis](./best-practices.md) minska risken för säkerhetsöverträdelser.

## Ytterligare resurser

[Syntax för trafikfilterregler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf.html#rules-syntax)

[CDN-loggformat](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf.html#cdn-log-format)

