---
title: Blockera DoS- och DDoS-attacker med trafikfilterregler
description: Lär dig hur du blockerar DoS- och DDoS-attacker med trafikfilterregler på AEM as a Cloud Service som tillhandahålls av CDN.
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
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1918'
ht-degree: 0%

---

# Blockera DoS- och DDoS-attacker med trafikfilterregler

Lär dig hur du blockerar DoS-attacker (Denial of Service) och DDoS-attacker (Distributed Denial of Service) med **trafikfilter för hastighetsbegränsning** regler och andra strategier på AEM as a Cloud Service (AEMCS) som hanteras av CDN. Dessa attacker orsakar trafiktoppar vid CDN och eventuellt vid AEM Publish Service (även kallat origin) och kan påverka webbplatsens tillgänglighet och tillgänglighet.

Den här självstudiekursen fungerar som en guide om _analysera dina trafikmönster och konfigurera hastighetsbegränsning [trafikfilterregler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf)_ för att mildra dessa attacker. I självstudiekursen beskrivs även hur du [konfigurera aviseringar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#traffic-filter-rules-alerts) så att du meddelas när en misstänkt attack inträffar.

## Förstå skydd

Lär dig mer om standardskyddet för DDoS på din AEM webbplats:

- **Cachelagring:** Med bra cachelagringsprinciper är effekten av en DDoS-attack mer begränsad eftersom CDN förhindrar att de flesta förfrågningar kommer till början och orsakar prestandaförsämring.
- **Automatisk skalning:** AEM skapar och publicerar tjänster automatiskt för att hantera trafiktoppar, även om de fortfarande kan påverkas av plötsliga, stora trafikökningar.
- **Blockering:** CDN i Adobe blockerar trafik till ursprungsläget om den överskrider en Adobe-definierad frekvens från en viss IP-adress, per CDN-postleverantör (Point of Presence).
- **Varning:** Åtgärdscentret skickar en trafiktopp på grund av varningsmeddelanden när trafiken överskrider en viss nivå. Denna varning utlöses när trafiken till en viss CDN PoP överstiger en _Adobe-definierad_ begärandefrekvens per IP-adress. Se [Varningar om trafikfilterregler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#traffic-filter-rules-alerts) för mer information.

Dessa inbyggda skydd bör betraktas som en baslinje för en organisations förmåga att minimera prestandapåverkan av en DDoS-attack. Eftersom alla webbplatser har olika prestandaegenskaper och kan uppleva prestandaförsämringar innan hastighetsgränsen som definieras av Adobe uppfylls, bör du utöka standardskyddet genom att _kundkonfiguration_.

Låt oss titta på några ytterligare, rekommenderade åtgärder som kunderna kan vidta för att skydda sina webbplatser mot DDoS-attacker:

- Deklarera **regler för trafikfilter för hastighetsbegränsning** för att blockera trafik som överskrider en viss hastighet från en enda IP-adress, per PoP. Dessa är vanligtvis ett lägre tröskelvärde än den Adobe-definierade hastighetsgränsen.
- Konfigurera **varningar** om regler för hastighetsbegränsning för trafikfilter genom en varningsåtgärd, så att ett meddelande från Åtgärdscenter skickas när regeln aktiveras.
- Öka cachemängden genom att deklarera **begäranomvandlingar** för att ignorera frågeparametrar.

>[!NOTE]
>
>The [aviseringar om trafikfilterregler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/traffic-filter-rules-including-waf#traffic-filter-rules-alerts) har inte släppts ännu. För att få tillgång till informationen via e-post **<aemcs-waf-adopter@adobe.com>**.

### Variationer i trafikregler för hastighetsbegränsning {#rate-limit-variations}

Det finns två variationer av trafikreglerna för avgiftsbegränsning:

1. Edge - blockbegäranden baserade på hastigheten för all trafik (inklusive den som kan betjänas från CDN-cache) för en viss IP-adress, per PoP.
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

Adobe skickar en trafikspik på ursprungsvarningen som [Meddelande från Åtgärdscenter](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/operations/actions-center) när en standardtröskel för trafik från en enda IP-adress överskrids, för en angiven PoP. Om du har fått en sådan varning rekommenderar vi att du konfigurerar en trafikfilterregel för hastighetsbegränsning. Den här standardvarningen skiljer sig från de varningar som kunderna uttryckligen måste aktivera när de definierar trafikfilterregler, som du kommer att lära dig om i ett framtida avsnitt.


## Analysera trafikmönster {#analyze-traffic}

Om webbplatsen redan är aktiv kan du analysera trafikmönstren med hjälp av CDN-loggar och någon av följande metoder:

### ELK - konfigurera kontrollpanelsverktyg

The **Elasticsearch, Logstash och Kibana (ELK)** Instrumentpanelsverktyg från Adobe kan användas för att analysera CDN-loggarna. Verktyget innehåller en kontrollpanel som visualiserar trafikmönstren, vilket gör det enklare att fastställa optimala tröskelvärden för trafikfilterreglerna för din hastighetsbegränsning.

- Klona [AEMCS-CDN-Log-Analysis-ELK-Tool](https://github.com/adobe/AEMCS-CDN-Log-Analysis-ELK-Tool) GitHub-databas.
- Konfigurera verktygen genom att följa följande [Så här ställer du in ELK Docker-behållaren](https://github.com/adobe/AEMCS-CDN-Log-Analysis-ELK-Tool?tab=readme-ov-file#how-to-set-up-the-elk-docker-container) steg.
- Som en del av konfigurationen importerar du `traffic-filter-rules-analysis-dashboard.ndjson` fil för att visualisera data. The _CDN-trafik_ Kontrollpanelen innehåller visualiseringar som visar det maximala antalet begäranden per IP/POP vid CDN Edge och Origin.
- Från [Cloud Manager](https://my.cloudmanager.adobe.com/)&#39;s _Miljö_ hämtar du AEMCS Publish-tjänstens CDN-loggar.

  ![CDN-logghämtningar för Cloud Manager](./assets/cloud-manager-cdn-log-downloads.png)

  >[!TIP]
  >
  > Det kan ta upp till 5 minuter innan de nya förfrågningarna visas i CDN-loggarna.

### Segment - konfigurera instrumentpanelsverktyg

Kunder som har [Splunk Log-vidarebefordran har aktiverats](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/developing/logging#splunk-logs) kan skapa en ny kontrollpanel för att analysera trafikmönstren. Följande XML-fil hjälper dig att skapa en kontrollpanel på Splunk:

- [CDN - kontrollpanel för trafik](./assets/traffic-dashboard.xml): Den här instrumentpanelen ger insikter om trafikmönstren på CDN Edge och Origin. Det innehåller visualiseringar som visar det maximala antalet begäranden per IP/POP vid CDN Edge och Origin.

### Data granskas

Följande visualiseringar finns på panelerna ELK och Splunk:

- **Edge RPS per klient-IP och POP**: Den här visualiseringen visar det maximala antalet begäranden per IP/POP **på CDN Edge**. Toppvärdet i visualiseringen anger det maximala antalet begäranden.

  **ELK Dashboard**:
  ![ELK-kontrollpanel - max antal begäranden per IP/POP](./assets/elk-edge-max-per-ip-pop.png)

  **Splunk Dashboard**:\
  ![Splunk dashboard - max antal begäranden per IP/POP](./assets/splunk-edge-max-per-ip-pop.png)

- **Ursprunglig RPS per klient-IP och POP**: Den här visualiseringen visar det maximala antalet begäranden per IP/POP **vid ursprung**. Toppvärdet i visualiseringen anger det maximala antalet begäranden.

  **ELK Dashboard**:
  ![ELK-kontrollpanel - max antal ursprungsbegäranden per IP/POP](./assets/elk-origin-max-per-ip-pop.png)

  **Splunk Dashboard**:
  ![Splunk dashboard - max origin-begäranden per IP/POP](./assets/splunk-origin-max-per-ip-pop.png)

## Välja tröskelvärden

Tröskelvärdena för trafikfiltreringsregler för hastighetsbegränsning bör baseras på ovanstående analys och säkerställa att legitim trafik inte blockeras. Se följande tabell för vägledning om hur du väljer tröskelvärden:

| Variation | Värde |
| :--------- | :------- |
| Ursprung | Använd det högsta värdet för Max Origin Requests per IP/POP under **normal** trafikförhållanden (dvs. inte hastigheten vid tidpunkten för ett DDoS) och öka den med flera |
| Kant | Använd det högsta värdet för Max edge-begäranden per IP/POP under **normal** trafikförhållanden (dvs. inte hastigheten vid tidpunkten för ett DDoS) och öka den med flera |

Den mängd som ska användas beror på dina förväntningar på normala trafiktoppar på grund av organisk trafik, kampanjer och andra händelser. En multipel mellan 5 och 10 kan vara rimlig.

Om webbplatsen ännu inte är aktiv finns det inga data att analysera, och du bör göra en kvalificerad gissning på vilka värden som är lämpliga för att ange trafikfilterreglerna för hastighetsbegränsning. Till exempel:

| Variation | Värde |
|------------------------------ |:-----------:|
| Kant | 500 |
| Ursprung | 100 |

## Konfigurera regler {#configure-rules}

Konfigurera **trafikfilter för hastighetsbegränsning** regler i AEM `/config/cdn.yaml` -fil, med värden som baseras på diskussionen ovan. Kontakta vid behov webbsäkerhetsteamet för att säkerställa att gränsvärdena är lämpliga och inte blockerar legitim trafik.

Se [Skapa regler i ditt AEM projekt](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/how-to-setup#create-rules-in-your-aem-project) för mer information.

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
          experimental_alert: true
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
          experimental_alert: true   
          
```

Observera att både origo- och edge-reglerna deklareras och att egenskapen alert är inställd på `true` så att du kan få varningar varje gång tröskelvärdet uppnås, vilket sannolikt tyder på en attack.

>[!NOTE]
>
>The _experimentell_ prefix_ framför experimentell_alert tas bort när varningsfunktionen släpps. Om du vill gå med i det tidiga adopterprogrammet skickar du e-post **<aemcs-waf-adopter@adobe.com>**.

Vi rekommenderar att åtgärdstypen är inställd på att logga initialt så att du kan övervaka trafiken under några timmar eller dagar och se till att den legitima trafiken inte överstiger dessa taxor. Efter några dagar växlar du till blockläge.

Följ stegen nedan för att distribuera ändringarna till din AEMCS-miljö:

- Verkställ och skicka ändringarna ovan till din Cloud Manager Git-databas.
- Distribuera ändringarna i AEMCS-miljön med hjälp av Cloud Managers Config-pipeline. Referens [Distribuera regler via Cloud Manager](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/security/traffic-filter-and-waf-rules/how-to-setup#deploy-rules-through-cloud-manager) för mer information.
- Verifiera **trafikfilterregel för hastighetsbegränsning** fungerar som väntat kan du simulera en attack enligt beskrivningen i [Attacksimulering](#attack-simulation) -avsnitt. Begränsa antalet begäranden till ett värde som är högre än det hastighetsgränsvärde som angetts i regeln.

### Konfigurerar omformningsregler för begäran {#configure-request-transform-rules}

Utöver trafikfilterreglerna för hastighetsbegränsning bör du använda [begäranomvandlingar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn-configuring-traffic#request-transformations) för att ta bort frågeparametrar som inte behövs av programmet för att minimera sätt att kringgå cacheminnet med hjälp av cachepubliceringstekniker. Om du till exempel bara vill tillåta `search` och `campaignId` frågeparametrar kan följande regel deklareras:

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes: 
    - dev
    - stage
    - prod  
data:  
  experimental_requestTransformations:
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

Som nämnts ovan, om trafikfilterregeln innehåller *experimentell_varning: true*, tas en varning emot när regeln matchas.

## Åtgärda varningar {#acting-on-alerts}

Ibland är varningen informativ och ger en uppfattning om hur ofta attackerna sker. Det är värt att analysera dina CDN-data med den instrumentpanel som beskrivs ovan för att kontrollera att trafikökningen beror på en attack och inte bara på en ökning av den legitima trafikvolymen. Om det är det senare, överväg att höja tröskeln.

## Attacksimulering{#attack-simulation}

I det här avsnittet beskrivs metoder för att simulera en DoS-attack, som kan användas för att generera data för kontrollpanelerna som används i den här självstudiekursen och för att verifiera att konfigurerade regler blockerar attacker.

>[!CAUTION]
>
> Utför inte dessa steg i en produktionsmiljö. Följande steg är endast avsedda för simulering.
> 
>Om du fick en varning om trafikökning går du vidare till [Analysera trafikmönster](#analyzing-traffic-patterns) -avsnitt.

Verktyg som [Apache Benchmark](https://httpd.apache.org/docs/2.4/programs/ab.html), [Apache JMeter](https://jmeter.apache.org/), [Vegeta](https://github.com/tsenart/vegeta)och andra kan användas.

### Kantförfrågningar

Använda följande [Vegeta](https://github.com/tsenart/vegeta) kan du göra många förfrågningar till din webbplats:

```shell
$ echo "GET https://<YOUR-WEBSITE-DOMAIN>" | vegeta attack -rate=120 -duration=5s | vegeta report
```

Ovanstående kommando gör 120 begäranden i 5 sekunder och skickar en rapport. Om man utgår ifrån att webbplatsen inte är begränsad kan det leda till en trafikökning.

### Ursprungsbegäranden

Om du vill kringgå CDN-cachen och göra förfrågningar till ursprungsläget (AEM publiceringstjänsten) kan du lägga till en unik frågeparameter till URL:en. Se exempelskriptet för Apache JMeter från [Simulera DoS-attack med JMeter-skript](https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/security/modsecurity-crs-dos-attack-protection#simulate-dos-attack-using-jmeter-script)

