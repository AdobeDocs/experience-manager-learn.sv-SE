---
title: Använd ModSecurity för att skydda din AEM från DoS Attack
description: Lär dig hur du aktiverar ModSecurity för att skydda din webbplats från DoS-attacker (Denial of Service) med hjälp av CRS (OWASP ModSecurity Core Rule Set).
feature: Security
version: 6.5, Cloud Service
topic: Security, Development
role: Admin, Architect
level: Experienced
jira: KT-10385
thumbnail: KT-10385.png
doc-type: Article
last-substantial-update: 2023-08-18T00:00:00Z
exl-id: 9f689bd9-c846-4c3f-ae88-20454112cf9a
duration: 783
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1172'
ht-degree: 0%

---

# Använd ModSecurity för att skydda din AEM från DoS-attacker

Lär dig hur du aktiverar ModSecurity för att skydda din webbplats från DoS-attacker (Denial of Service) med **OWASP ModSecurity Core Rule Set)** på Adobe Experience Manager (AEM) Publish Dispatcher.


>[!VIDEO](https://video.tv.adobe.com/v/3422976?quality=12&learn=on)

## Ökning

Grunden [Open Web Application Security Project® (OWASP)](https://owasp.org/) innehåller [**OWASP Top 10**](https://owasp.org/www-project-top-ten/) som beskriver de tio viktigaste säkerhetsaspekterna för webbprogram.

ModSecurity är en plattformsoberoende lösning med öppen källkod som skyddar mot en rad attacker mot webbprogram. Det möjliggör även HTTP-trafikövervakning, loggning och realtidsanalys.

OWSAP® innehåller även [OWASP® ModSecurity Core Rule Set (CRS)](https://github.com/coreruleset/coreruleset). CRS är en uppsättning allmänna **attackidentifieringsregler** som används med ModSecurity. CRS syftar alltså till att skydda webbapplikationer från en mängd olika attacker, bland annat OWASP Top Ten, med ett minimum av falska varningar.

I den här självstudien visas hur du aktiverar och konfigurerar CRS-regeln **DOS-PROTECTION** för att skydda din webbplats från en potentiell DoS-attack.

>[!TIP]
>
>Det är viktigt att notera att AEM as a Cloud Service [hanterade CDN](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn.html) uppfyller de flesta kundens krav på prestanda och säkerhet. ModSecurity erbjuder dock ett extra säkerhetslager som möjliggör kundspecifika regler och konfigurationer.

## Lägg till CRS i Dispatcher projektmodul

1. Hämta och extrahera den [senaste OWASP ModSecurity Core Rule Set](https://github.com/coreruleset/coreruleset/releases).

   ```shell
   # Replace the X.Y.Z with relevent version numbers.
   $ wget https://github.com/coreruleset/coreruleset/archive/refs/tags/vX.Y.Z.tar.gz
   
   # For version v3.3.5 when this tutorial is published
   $ wget https://github.com/coreruleset/coreruleset/archive/refs/tags/v3.3.5.tar.gz
   
   # Extract the downloaded file
   $ tar -xvzf coreruleset-3.3.5.tar.gz
   ```

1. Skapa `modsec/crs`-mapparna i `dispatcher/src/conf.d/` i AEM projektkod. I den lokala kopian av [AEM WKND Sites-projektet](https://github.com/adobe/aem-guides-wknd).

   ![CRS-mapp i AEM projektkod - ModSecurity](assets/modsecurity-crs/crs-folder-in-aem-dispatcher-module.png){width="200" zoomable="yes"}

1. Kopiera mappen `coreruleset-X.Y.Z/rules` från det hämtade CRS-versionspaketet till mappen `dispatcher/src/conf.d/modsec/crs`.
1. Kopiera filen `coreruleset-X.Y.Z/crs-setup.conf.example` från det hämtade CRS-versionspaketet till mappen `dispatcher/src/conf.d/modsec/crs` och byt namn på den till `crs-setup.conf`.
1. Inaktivera alla kopierade CRS-regler från `dispatcher/src/conf.d/modsec/crs/rules` genom att byta namn på dem till `XXXX-XXX-XXX.conf.disabled`. Du kan använda kommandona nedan för att byta namn på alla filer samtidigt.

   ```shell
   # Go inside the newly created rules directory within the dispathcher module
   $ cd dispatcher/src/conf.d/modsec/crs/rules
   
   # Rename all '.conf' extension files to '.conf.disabled'
   $ for i in *.conf; do mv -- "$i" "$i.disabled"; done
   ```

   Mer information finns i CRS-reglerna och konfigurationsfilen med det nya namnet i WKND-projektkoden.

   ![Inaktiverade CRS-regler i AEM projektkod - ModSecurity ](assets/modsecurity-crs/disabled-crs-rules.png){width="200" zoomable="yes"}

## Aktivera och konfigurera DoS-skyddsregel (Denial of Service)

Följ stegen nedan för att aktivera och konfigurera DoS-skyddsregeln (Denial of Service):

1. Aktivera DoS-skyddsregeln genom att byta namn på `REQUEST-912-DOS-PROTECTION.conf.disabled` till `REQUEST-912-DOS-PROTECTION.conf` (eller ta bort `.disabled` från regelnamnstillägget) i mappen `dispatcher/src/conf.d/modsec/crs/rules`.
1. Konfigurera regeln genom att definiera variablerna **DOS_COUNTER_THRESHOLD, DOS_BURST_TIME_SLICE, DOS_BLOCK_TIMEOUT** .
   1. Skapa en `crs-setup.custom.conf`-fil i mappen `dispatcher/src/conf.d/modsec/crs`.
   1. Lägg till nedanstående regelutdrag i den nya filen.

   ```
   # The Denial of Service (DoS) protection against clients making requests too quickly.
   # When a client is making more than 25 requests (excluding static files) within
   # 60 seconds, this is considered a 'burst'. After two bursts, the client is
   # blocked for 600 seconds.
   SecAction \
       "id:900700,\
       phase:1,\
       nolog,\
       pass,\
       t:none,\
       setvar:'tx.dos_burst_time_slice=60',\
       setvar:'tx.dos_counter_threshold=25',\
       setvar:'tx.dos_block_timeout=600'"    
   ```

I den här exempelregelkonfigurationen är **DOS_COUNTER_THRESHOLD** 25, **DOS_BURST_TIME_SLICE** 60 sekunder och **DOS_BLOCK_TIMEOUT** timeout är 600 sekunder. Den här konfigurationen identifierar mer än två förekomster av 25 begäranden, med undantag för statiska filer, inom 60 sekunder kvalificerar som en DoS-attack, vilket gör att den begärande klienten blockeras i 600 sekunder (eller 10 minuter).

>[!WARNING]
>
>Samarbeta med webbsäkerhetsteamet för att definiera värden som passar dina behov.

## Initiera CRS

Så här initierar du CRS, tar bort vanliga falska positiva och lägger till lokala undantag för din webbplats:

1. Ta bort `.disabled` från filen **REQUEST-901-INITIALIZATION** om du vill initiera CRS. Byt namn på filen `REQUEST-901-INITIALIZATION.conf.disabled` till `REQUEST-901-INITIALIZATION.conf`.
1. Om du vill ta bort vanliga falska positiva objekt som lokal IP-ping (127.0.0.1) tar du bort `.disabled` från filen **REQUEST-905-COMMON-EXCEPTIONS**.
1. Om du vill lägga till lokala undantag som AEM eller platsspecifika sökvägar byter du namn på `REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example` till `REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf`
   1. Lägg till AEM plattformsspecifika sökvägsundantag i den fil som du har bytt namn på.

   ```
   ########################################################
   # AEM as a Cloud Service exclusions                    #
   ########################################################
   # Ignoring AEM-CS Specific internal and reserved paths
   
   SecRule REQUEST_URI "@beginsWith /systemready" \
       "id:1010,\
       phase:1,\
       pass,\
       nolog,\
       ctl:ruleEngine=Off"    
   
   SecRule REQUEST_URI "@beginsWith /system/probes" \
       "id:1011,\
       phase:1,\
       pass,\
       nolog,\
       ctl:ruleEngine=Off"
   
   SecRule REQUEST_URI "@beginsWith /gitinit-status" \
       "id:1012,\
       phase:1,\
       pass,\
       nolog,\
       ctl:ruleEngine=Off"
   
   ########################################################
   # ADD YOUR SITE related exclusions                     #
   ########################################################
   ...
   ```

1. Ta även bort `.disabled` från **REQUEST-910-IP-REPUTATION.conf.disabled** för kontroll av IP-anseendeblock och `REQUEST-949-BLOCKING-EVALUATION.conf.disabled` för kontroll av avvikelsepoäng.

>[!TIP]
>
>När du konfigurerar på AEM 6.5 ska du se till att ersätta ovanstående banor med respektive AMS- eller lokala banor som kontrollerar AEM hälsa (kallas hjärtslagsbanor).

## Lägg till konfiguration av ModSecurity Apache

Så här aktiverar du ModSecurity (även `mod_security` Apache-modulen):

1. Skapa `modsecurity.conf` kl. `dispatcher/src/conf.d/modsec/modsecurity.conf` med nyckelkonfigurationer nedan.

   ```
   # Include the baseline crs setup
   Include conf.d/modsec/crs/crs-setup.conf
   
   # Include your customizations to crs setup if exist
   IncludeOptional conf.d/modsec/crs/crs-setup.custom.conf
   
   # Select all available CRS rules:
   #Include conf.d/modsec/crs/rules/*.conf
   
   # Or alternatively list only specific ones you want to enable e.g.
   Include conf.d/modsec/crs/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf
   Include conf.d/modsec/crs/rules/REQUEST-901-INITIALIZATION.conf
   Include conf.d/modsec/crs/rules/REQUEST-905-COMMON-EXCEPTIONS.conf
   Include conf.d/modsec/crs/rules/REQUEST-910-IP-REPUTATION.conf
   Include conf.d/modsec/crs/rules/REQUEST-912-DOS-PROTECTION.conf
   Include conf.d/modsec/crs/rules/REQUEST-949-BLOCKING-EVALUATION.conf
   
   # Start initially with engine off, then switch to detection and observe, and when sure enable engine actions
   #SecRuleEngine Off
   #SecRuleEngine DetectionOnly
   SecRuleEngine On
   
   # Remember to use relative path for logs:
   SecDebugLog logs/httpd_mod_security_debug.log
   
   # Start with low debug level
   SecDebugLogLevel 0
   #SecDebugLogLevel 1
   
   # Start without auditing
   SecAuditEngine Off
   #SecAuditEngine RelevantOnly
   #SecAuditEngine On
   
   # Tune audit accordingly:
   SecAuditLogRelevantStatus "^(?:5|4(?!04))"
   SecAuditLogParts ABIJDEFHZ
   SecAuditLogType Serial
   
   # Remember to use relative path for logs:
   SecAuditLog logs/httpd_mod_security_audit.log
   
   # You might still use /tmp for temporary/work files:
   SecTmpDir /tmp
   SecDataDir /tmp
   ```

1. Välj önskad `.vhost` från ditt AEM Dispatcher-modul `dispatcher/src/conf.d/available_vhosts`, till exempel `wknd.vhost`, och lägg till nedanstående post utanför `<VirtualHost>` -blocket.

   ```
   # Enable the ModSecurity and OWASP CRS
   <IfModule mod_security2.c>
       Include conf.d/modsec/modsecurity.conf
   </IfModule>
   
   ...
   
   <VirtualHost *:80>
       ServerName    "publish"
       ...
   </VirtualHost>
   ```

Alla de ovanstående konfigurationerna för _ModSecurity CRS_ och _DOS-PROTECTION_ finns tillgängliga på WKND Sites Project [AEM självstudiekurs/enable-modsecurity-crs-dos-protection](https://github.com/adobe/aem-guides-wknd/tree/tutorial/enable-modsecurity-crs-dos-protection) som du kan granska.

### Validera Dispatcher-konfiguration

När du arbetar med AEM as a Cloud Service, innan du distribuerar dina _Dispatcher-konfigurationer_ -ändringar, rekommenderas du att validera dem lokalt med hjälp av `validate` -skriptet för [AEM SDK:s Dispatcher-verktyg](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/dispatcher-tools.html) .

```
# Go inside Dispatcher SDK 'bin' directory
$ cd <YOUR-AEM-SDK-DIR>/<DISPATCHER-SDK-DIR>/bin

# Validate the updated Dispatcher configurations
$ ./validate.sh <YOUR-AEM-PROJECT-CODE-DIR>/dispatcher/src
```

## Distribuera

Distribuera lokalt validerade Dispatcher-konfigurationer med Cloud Manager pipeline [Web Tier](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/configuring-production-pipelines.html?#web-tier-config) eller [Full Stack](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/configuring-production-pipelines.html?#full-stack-code) . Du kan också använda [Rapid Development Environment](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/rde/overview.html) för snabbare vändningstid.

## Verifiera

För att verifiera DoS-skyddet, i det här exemplet, skickar vi mer än 50 förfrågningar (25 tröskelvärden för förfrågningar gånger två förekomster) inom ett intervall av 60 sekunder. Dessa förfrågningar bör dock skickas via AEM as a Cloud Service [inbyggda](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn.html) eller någon annan [CDN](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/cdn.html?#point-to-point-CDN) som finns på webbplatsen.

En metod för att få CDN-överföringen är att lägga till en frågeparameter med ett **nytt slumpmässigt värde i varje begäran om webbplatssidan**.

Om du vill utlösa ett större antal förfrågningar (50 eller fler) inom en kort period (till exempel 60 sekunder) kan Apache-verktyget [JMeter](https://jmeter.apache.org/) eller [Benchmark eller ab](https://httpd.apache.org/docs/2.4/programs/ab.html) användas.

### Simulera DoS-attack med JMeter-skript

Så här simulerar du en DoS-attack med JMeter:

1. [Hämta Apache JMeter](https://jmeter.apache.org/download_jmeter.cgi) och [installera](https://jmeter.apache.org/usermanual/get-started.html#install) lokalt
1. [Kör](https://jmeter.apache.org/usermanual/get-started.html#running) lokalt med skriptet `jmeter` från katalogen `<JMETER-INSTALL-DIR>/bin`.
1. Öppna exemplet [WKND-DoS-Attack-Simulation-Test](assets/modsecurity-crs/WKND-DoS-Attack-Simulation-Test.jmx) JMX-skript i JMeter med verktygsmenyn **Öppna**.

   ![Öppna exemplet WKND DoS Attack JMX Test Script - ModSecurity](assets/modsecurity-crs/open-wknd-dos-attack-jmx-test-script.png)

1. Uppdatera fältvärdet **Servernamn eller IP** i _Startsida_ och _Adventure Page_ HTTP Request-samplern som matchar URL:en för testmiljön AEM. Granska annan information om JMeter-exempelskriptet.

   ![AEM Servernamn HTTP Request JMetere - ModSecurity](assets/modsecurity-crs/aem-server-name-http-request.png)

1. Kör skriptet genom att trycka på knappen **Start** på verktygsmenyn. Skriptet skickar 50 HTTP-begäranden (5 användare och 10 loopar) mot WKND-platsens _hemsida_ och _Adventure-sida_. Det innebär att totalt 100 begäranden till icke-statiska filer kvalificerar DoS-attacken per anpassad konfiguration av **DOS-PROTECTION**-CRS-regel.

   ![Kör JMeter-skript - ModSecurity](assets/modsecurity-crs/execute-jmeter-script.png)

1. **Visa resultat i tabell** JMeter-avlyssnaren visar **Svarsstatus för misslyckad** för begäran nummer ~ 53 och senare.

   ![Misslyckade svar i vyresultat i tabell-JMeter - ModSecurity](assets/modsecurity-crs/failed-response-jmeter.png)

1. **503 HTTP-svarskoden** returneras för de misslyckade förfrågningarna. Du kan visa informationen med JMeter-avlyssnaren **Visa resultatträd**.

   ![503 Response JMeter - ModSecurity](assets/modsecurity-crs/503-response-jmeter.png)

### Granska loggar

Loggkonfigurationen för ModSecurity loggar information om DoS-attackincidenten. Följ stegen nedan för att visa informationen:

1. Hämta och öppna loggfilen `httpderror` för **Publish Dispatcher**.
1. Sök efter ordet `burst` i loggfilen för att se raderna **error**

   ```
   Tue Aug 15 15:19:40.229262 2023 [security2:error] [pid 308:tid 140200050567992] [cm-p46652-e1167810-aem-publish-85df5d9954-bzvbs] [client 192.150.10.209] ModSecurity: Warning. Operator GE matched 2 at IP:dos_burst_counter. [file "/etc/httpd/conf.d/modsec/crs/rules/REQUEST-912-DOS-PROTECTION.conf"] [line "265"] [id "912170"] [msg "Potential Denial of Service (DoS) Attack from 192.150.10.209 - # of Request Bursts: 2"] [ver "OWASP_CRS/3.3.5"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "paranoia-level/1"] [tag "attack-dos"] [tag "OWASP_CRS"] [tag "capec/1000/210/227/469"] [hostname "publish-p46652-e1167810.adobeaemcloud.com"] [uri "/content/wknd/us/en/adventures.html"] [unique_id "ZNuXi9ft_9sa85dovgTN5gAAANI"]
   
   ...
   
   Tue Aug 15 15:19:40.515237 2023 [security2:error] [pid 309:tid 140200051428152] [cm-p46652-e1167810-aem-publish-85df5d9954-bzvbs] [client 192.150.10.209] ModSecurity: Access denied with connection close (phase 1). Operator EQ matched 0 at IP. [file "/etc/httpd/conf.d/modsec/crs/rules/REQUEST-912-DOS-PROTECTION.conf"] [line "120"] [id "912120"] [msg "Denial of Service (DoS) attack identified from 192.150.10.209 (1 hits since last alert)"] [ver "OWASP_CRS/3.3.5"] [tag "application-multi"] [tag "language-multi"] [tag "platform-multi"] [tag "paranoia-level/1"] [tag "attack-dos"] [tag "OWASP_CRS"] [tag "capec/1000/210/227/469"] [hostname "publish-p46652-e1167810.adobeaemcloud.com"] [uri "/us/en.html"] [unique_id "ZNuXjAN7ZtmIYHGpDEkmmwAAAQw"]
   ```

1. Granska information som _klientens IP-adress_, åtgärd, felmeddelande och information om begäran.

## Prestandapåverkan av ModSecurity

Att aktivera ModSecurity och tillhörande regler har vissa prestandakonsekvenser, så tänk på vilka regler som krävs, är redundanta och ignoreras. Samarbeta med era webbsäkerhetsexperter för att aktivera och anpassa CRS-reglerna.

### Ytterligare regler

Den här självstudien aktiverar och anpassar endast CRS-regeln **DOS-PROTECTION** för demonstrationssyften. Vi rekommenderar att ni samarbetar med experter på webbsäkerhet för att förstå, granska och konfigurera lämpliga regler.
