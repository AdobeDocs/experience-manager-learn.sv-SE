---
title: Blockera DoS- och DDoS-attacker med trafikfilterregler
description: Lär dig hur du blockerar DoS- och DDoS-attacker med trafikfilterregler på det CDN som tillhandahålls av AEM as a Cloud Service.
version: Cloud Service
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
source-git-commit: 0e8b76b6e870978c6db9c9e7a07a6259e931bdcc
workflow-type: tm+mt
source-wordcount: '1924'
ht-degree: 0%

---

# Blockera DoS- och DDoS-attacker med trafikfilterregler

Lär dig hur du blockerar DoS-attacker (Denial of Service) och DoS-attacker (Distributed Denial of Service) med hjälp av **rate limit-trafikfilterregler** och andra strategier på det CDN som hanteras av AEM as a Cloud Service (AEMCS). Dessa attacker orsakar trafiktoppar vid CDN och eventuellt vid AEM Publish-tjänst (även kallat origin) och kan påverka webbplatsens tillgänglighet och tillgänglighet.

Den här självstudiekursen fungerar som en guide om _hur du analyserar dina trafikmönster och konfigurerar [trafikfilterregler ](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf)_ för att minska dessa attacker. I självstudien beskrivs även hur du [konfigurerar aviseringar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#traffic-filter-rules-alerts) så att du meddelas när en misstänkt attack inträffar.

## Förstå skydd

Lär dig mer om standardskyddet för DDoS på din AEM webbplats:

- **Cachelagring:** Med bra cachelagringsprinciper är effekten av en DDoS-attack mer begränsad eftersom CDN förhindrar att de flesta begäranden kommer till ursprungsläget och orsakar prestandaförsämring.
- **Automatisk skalning:** AEM författare och publicerar tjänster automatiskt för att hantera trafiktoppar, även om de fortfarande kan påverkas av plötsliga, massiva trafikökningar.
- **Blockering:** Adobe CDN blockerar trafik till ursprungsläget om den överskrider en Adobe-definierad frekvens från en viss IP-adress, per CDN PoP (Point of Presence).
- **Varning!** Åtgärdscentret skickar en trafikspik med varningsmeddelanden om trafiken överskrider en viss nivå. Den här varningen utlöses när trafiken till en angiven CDN PoP överskrider en _Adobe-definierad_ förfrågningsfrekvens per IP-adress. Mer information finns i [Varningar om trafikfilterregler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#traffic-filter-rules-alerts).

Dessa inbyggda skydd bör betraktas som en baslinje för en organisations förmåga att minimera prestandapåverkan av en DDoS-attack. Eftersom varje webbplats har olika prestandaegenskaper och kan se att prestandaförsämringen innan hastighetsgränsen som definieras av Adobe uppfylls, bör du utöka standardskyddet med _kundkonfigurationen_.

Låt oss titta på några ytterligare, rekommenderade åtgärder som kunderna kan vidta för att skydda sina webbplatser mot DDoS-attacker:

- Deklarera **hastighetsbegränsningen för trafikfilterregler** för att blockera trafik som överskrider en viss hastighet från en enskild IP-adress, per PoP. Dessa är vanligtvis ett lägre tröskelvärde än den Adobe-definierade hastighetsgränsen.
- Konfigurera **varningar** om hastighetsbegränsningar för trafikfilterregler via en varningsåtgärd så att ett meddelande från Åtgärdscenter skickas när regeln aktiveras.
- Öka cachetäckningen genom att deklarera **begäranomvandlingar** för att ignorera frågeparametrar.

### Variationer i trafikregler för hastighetsbegränsning {#rate-limit-variations}

Det finns två variationer av trafikreglerna för avgiftsbegränsning:

1. Edge - blockera förfrågningar baserat på hastigheten för all trafik (inklusive den som kan betjänas från CDN-cache) för en viss IP-adress, per PoP.
1. Ursprung - blockera förfrågningar baserat på andelen trafik som är avsedd för ursprunget, för en given IP-adress, per PoP.

## Kundresa

Stegen nedan visar den process som kunderna troligtvis bör gå igenom när det gäller att skydda sina webbplatser.

1. Identifiera behovet av en trafikfilterregel för hastighetsbegränsning. Detta kan bero på att man tagit emot en trafikspike för Adobe utanför förpackningen vid ursprungsaviseringen, eller på ett förebyggande beslut att vidta försiktighetsåtgärder för att minska risken för ett framgångsrikt DDoS.
1. Analysera trafikmönster med hjälp av en kontrollpanel, om webbplatsen redan är aktiv, för att fastställa de optimala tröskelvärdena för trafikfiltreringsreglerna för hastighetsbegränsning. Om sajten ännu inte är aktiv väljer du värden baserat på dina trafikförväntningar.
1. Konfigurera trafikfilterregler för hastighetsbegränsning med hjälp av värdena från föregående steg. Se till att aktivera motsvarande aviseringar så att du meddelas när tröskelvärdet har uppnåtts.
1. Få aviseringar om trafikfilterregler så snart det uppstår trafiktoppar, vilket ger dig värdefulla insikter om huruvida organisationen kan vara utsatt för skadlig påverkan.
1. Agera vid behov. Analysera trafiken för att avgöra om spiken speglar legitima förfrågningar snarare än en attack. Öka tröskelvärdena om trafiken är legitim, eller sänka dem om inte.

Resten av den här självstudiekursen guidar dig genom den här processen.

## Vi inser behovet av att konfigurera regler {#recognize-the-need}

Som tidigare nämnts blockerar Adobe som standard trafik vid CDN som överskrider en viss nivå, men vissa webbplatser kan uppleva sämre prestanda under den tröskeln. Trafikfilterregler för hastighetsbegränsning bör därför konfigureras.

Helst konfigurerar du reglerna innan du går direkt till produktion. I praktiken deklarerar många organisationer aktivt regler endast en gång som varnats för en trafiktoppar, vilket tyder på en trolig attack.

Adobe skickar en trafiktopp på ursprungsvarningen som ett [meddelande från Åtgärdscenter](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/actions-center) när en standardtröskel för trafik från en enskild IP-adress överskrids, för en angiven PoP. Om du har fått en sådan varning rekommenderar vi att du konfigurerar en trafikfilterregel för hastighetsbegränsning. Den här standardvarningen skiljer sig från de varningar som kunderna uttryckligen måste aktivera när de definierar trafikfilterregler, som du kommer att lära dig om i ett framtida avsnitt.

## Analysera trafikmönster {#analyze-traffic}

Om webbplatsen redan är aktiv kan du analysera trafikmönstren med hjälp av CDN-loggar och instrumentpaneler från Adobe.

- **CDN Traffic Dashboard**: ger insikter om trafiken via CDN och begärandefrekvens för ursprung, felfrekvens på 4xx och 5xx samt icke-cachelagrade begäranden. Ger även maximalt antal CND- och origin-begäranden per sekund per klient-IP-adress och fler insikter för att optimera CDN-konfigurationerna.

- **Träffgrad för CDN-cache**: ger insikter om den totala träffkvoten för cache och det totala antalet begäranden med HIT-, PASS- och MISS-status. Tillhandahåller även de bästa URL:erna för HIT, PASS och MISS.

Konfigurera instrumentpanelsverktygen med _ett av följande alternativ_:

### ELK - konfigurera kontrollpanelsverktyg

Kontrollpanelsverktygen **Elasticsearch, Logstash och Kibana (ELK)** från Adobe kan användas för att analysera CDN-loggarna. Verktyget innehåller en kontrollpanel som visualiserar trafikmönstren, vilket gör det enklare att fastställa optimala tröskelvärden för trafikfilterreglerna för din hastighetsbegränsning.

- Klona GitHub-databasen [AEMCS-CDN-Log-Analysis-Tooling](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling).
- Konfigurera verktyget genom att följa stegen [Så här konfigurerar du ELK Docker-behållaren](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/ELK/README.md#how-to-set-up-the-elk-docker-containerhow-to-setup-the-elk-docker-container).
- Som en del av konfigurationen importerar du filen `traffic-filter-rules-analysis-dashboard.ndjson` för att visualisera data. Kontrollpanelen _CDN-trafik_ innehåller visualiseringar som visar det maximala antalet begäranden per IP/POP på CDN Edge och origin.
- Hämta CDN-loggarna för tjänsten AEMCS Publish från _Cloud Manager_[](https://my.cloudmanager.adobe.com/)s Environmental -kortet.

  ![Cloud Manager CDN-logghämtningar](./assets/cloud-manager-cdn-log-downloads.png)

  >[!TIP]
  >
  > Det kan ta upp till 5 minuter innan de nya förfrågningarna visas i CDN-loggarna.

### Segment - konfigurera instrumentpanelsverktyg

Kunder som har [Splunk Log-vidarebefordran aktiverad](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/logging#splunk-logs) kan skapa nya instrumentpaneler för att analysera trafikmönstren.

Om du vill skapa kontrollpaneler i Splunk följer du stegen [Splunk dashboards för AEMCS CDN Log Analysis](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/Splunk/README.md#splunk-dashboards-for-aemcs-cdn-log-analysis).

### Data granskas

Följande visualiseringar finns på panelerna ELK och Splunk:

- **Edge RPS per klient-IP och POP**: Den här visualiseringen visar det maximala antalet begäranden per IP/POP **på CDN Edge**. Toppvärdet i visualiseringen anger det maximala antalet begäranden.

  **ELK Dashboard**:
  ![ELK-kontrollpanel - max antal begäranden per IP/POP](./assets/elk-edge-max-per-ip-pop.png)

  **Segmentkontrollpanel**:
  ![Splunk-instrumentpanel - max antal begäranden per IP/POP](./assets/splunk-edge-max-per-ip-pop.png)

- **Ursprunglig RPS per klient-IP och POP**: Den här visualiseringen visar det maximala antalet begäranden per IP/POP **vid ursprung**. Toppvärdet i visualiseringen anger det maximala antalet begäranden.

  **ELK Dashboard**:
  ![ELK-kontrollpanel - max antal ursprungliga begäranden per IP/POP](./assets/elk-origin-max-per-ip-pop.png)

  **Segmentkontrollpanel**:
  ![Splunk-instrumentpanel - max antal origin-begäranden per IP/POP](./assets/splunk-origin-max-per-ip-pop.png)

## Välja tröskelvärden

Tröskelvärdena för trafikfiltreringsregler för hastighetsbegränsning bör baseras på ovanstående analys och säkerställa att legitim trafik inte blockeras. Se följande tabell för vägledning om hur du väljer tröskelvärden:

| Variation | Värde |
| :--------- | :------- |
| Ursprung | Använd det högsta värdet för Max Origin Requests per IP/POP under **normala** trafikförhållanden (d.v.s. inte hastigheten vid tidpunkten för ett DDoS) och öka den med flera |
| Edge | Ta det högsta värdet av Max Edge-begäranden per IP/POP under **normala** trafikförhållanden (d.v.s. inte hastigheten vid tidpunkten för ett DDoS) och öka den med flera |

Den mängd som ska användas beror på dina förväntningar på normala trafiktoppar på grund av organisk trafik, kampanjer och andra händelser. En multipel mellan 5 och 10 kan vara rimlig.

Om webbplatsen ännu inte är aktiv finns det inga data att analysera, och du bör göra en kvalificerad gissning på vilka värden som är lämpliga för att ange trafikfilterreglerna för hastighetsbegränsning. Till exempel:

| Variation | Värde |
|------------------------------ |:-----------:|
| Edge | 500 |
| Ursprung | 100 |

## Konfigurera regler {#configure-rules}

Konfigurera trafikfilterreglerna **hastighetsbegränsningen** i AEM `/config/cdn.yaml`-filen, med värden som baseras på diskussionen ovan. Kontakta vid behov webbsäkerhetsteamet för att säkerställa att gränsvärdena är lämpliga och inte blockerar legitim trafik.

Mer information finns i [Skapa regler i ditt AEM projekt](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/how-to-setup#create-rules-in-your-aem-project).

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
    #  Prevent attack at edge by blocking client for 5 minutes if they make more than 500 requests per second on average
      - name: prevent-dos-attacks-edge
        when:
          reqProperty: tier
          in: ["author","publish"]
        rateLimit:
          limit: 500 # replace with the appropriate value
          window: 10 # compute the average over 10s
          penalty: 300 # block IP for 5 minutes
          count: all # count all requests
          groupBy:
            - reqProperty: clientIp
        action:
          type: log
          alert: true
    #  Prevent attack at origin by blocking client for 5 minutes if they make more than 100 requests per second on average
      - name: prevent-dos-attacks-origin
        when:
          reqProperty: tier
          in: ["author","publish"]
        rateLimit:
          limit: 100 # replace with the appropriate value
          window: 10 # compute the average over 10s
          penalty: 300 # block IP for 5 minutes
          count: fetches # count only fetches
          groupBy:
            - reqProperty: clientIp
        action:
          type: log
          alert: true
```

Observera att både ursprungs- och kantregler deklareras och att egenskapen alert är inställd på `true` så att du kan få aviseringar när tröskelvärdet uppnås, vilket troligen tyder på en attack.

Vi rekommenderar att åtgärdstypen är inställd på att logga initialt så att du kan övervaka trafiken under några timmar eller dagar och se till att den legitima trafiken inte överstiger dessa taxor. Efter några dagar växlar du till blockläge.

Följ stegen nedan för att distribuera ändringarna till din AEMCS-miljö:

- Verkställ och skicka ändringarna ovan till din Cloud Manager Git-databas.
- Distribuera ändringarna i AEMCS-miljön med hjälp av Cloud Manager Config-pipeline. Mer information finns i [Distribuera regler via Cloud Manager](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/how-to-setup#deploy-rules-through-cloud-manager).
- Du kan simulera en attack enligt beskrivningen i avsnittet [Attacksimulering](#attack-simulation) för att verifiera att trafikfilterregeln **för frekvensbegränsning** fungerar som förväntat. Begränsa antalet begäranden till ett värde som är högre än det hastighetsgränsvärde som angetts i regeln.

### Konfigurerar omformningsregler för begäran {#configure-request-transform-rules}

Utöver hastighetsbegränsningen för trafikfilterregler rekommenderar vi att du använder [begäranomvandlingar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn-configuring-traffic#request-transformations) för att ta bort frågeparametrar som inte behövs av programmet för att minimera sätt att kringgå cacheminnet med hjälp av cachelagringstekniker. Om du till exempel bara vill tillåta `search`- och `campaignId`-frågeparametrar kan följande regel deklareras:

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes:
    - dev
    - stage
    - prod
data:
  requestTransformations:
    rules:
      - name: unset-all-query-params-except-those-needed
        when:
          reqProperty: tier
          in: ["publish"]
        actions:
          - type: unset
            queryParamMatch: ^(?!search$|campaignId$).*$
```

## Varningar om trafikfilterregler tas emot {#receiving-alerts}

Om trafikfilterregeln innehåller *alert: true* får du en varning när regeln matchas.

## Åtgärda varningar {#acting-on-alerts}

Ibland är varningen informativ och ger en uppfattning om hur ofta attackerna sker. Det är värt att analysera dina CDN-data med den instrumentpanel som beskrivs ovan för att kontrollera att trafikökningen beror på en attack och inte bara på en ökning av den legitima trafikvolymen. Om det är det senare, överväg att höja tröskeln.

## Attacksimulering{#attack-simulation}

I det här avsnittet beskrivs metoder för att simulera en DoS-attack, som kan användas för att generera data för kontrollpanelerna som används i den här självstudiekursen och för att verifiera att konfigurerade regler blockerar attacker.

>[!CAUTION]
>
> Utför inte dessa steg i en produktionsmiljö. Följande steg är endast avsedda för simulering.
>
>Om du fick ett varningsmeddelande om att trafiken har ökat går du vidare till avsnittet [Analyserar trafikmönster](#analyzing-traffic-patterns).

Verktyg som [Apache Benchmark](https://httpd.apache.org/docs/2.4/programs/ab.html), [Apache JMeter](https://jmeter.apache.org/), [Vegeta](https://github.com/tsenart/vegeta) och andra kan användas för att simulera en attack.

### Edge-förfrågningar

Med följande [Vegeta](https://github.com/tsenart/vegeta)-kommando kan du göra många förfrågningar till din webbplats:

```shell
$ echo "GET https://<YOUR-WEBSITE-DOMAIN>" | vegeta attack -rate=120 -duration=5s | vegeta report
```

Ovanstående kommando gör 120 begäranden i 5 sekunder och skickar en rapport. Om man utgår ifrån att webbplatsen inte är begränsad kan det leda till en trafikökning.

### Ursprungsbegäranden

Om du vill kringgå CDN-cachen och göra förfrågningar till origo (AEM Publish-tjänsten) kan du lägga till en unik frågeparameter till URL:en. Se exempelskriptet för Apache JMeter från [Simulate DoS-attacken med JMeter-skriptet](https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/security/modsecurity-crs-dos-attack-protection#simulate-dos-attack-using-jmeter-script)

