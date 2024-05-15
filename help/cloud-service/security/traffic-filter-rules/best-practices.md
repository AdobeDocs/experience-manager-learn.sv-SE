---
title: Bästa tillvägagångssätt för trafikfilterregler inklusive WAF-regler
description: Lär dig rekommenderade metoder för trafikfilterregler, inklusive WAF-regler.
version: Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Architect
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-10-26T00:00:00Z
jira: KT-13148
thumbnail: KT-13148.jpeg
exl-id: 4a7acdd2-f442-44ee-8560-f9cb64436acf
duration: 170
source-git-commit: c7c78ca56c1d72f13d2dc80229a10704ab0f14ab
workflow-type: tm+mt
source-wordcount: '411'
ht-degree: 0%

---

# Bästa tillvägagångssätt för trafikfilterregler inklusive WAF-regler

Lär dig rekommenderade metoder för trafikfilterregler, inklusive WAF-regler. Det är viktigt att notera att de bästa metoder som beskrivs i denna artikel inte är uttömmande och inte är avsedda att ersätta dina egna säkerhetsregler och säkerhetsförfaranden.

>[!VIDEO](https://video.tv.adobe.com/v/3425408?quality=12&learn=on)

## Allmän bästa praxis

- Samarbeta med ditt säkerhetsteam för att ta reda på vilka regler som är lämpliga för din organisation.
- Testa alltid regler i Dev-miljöer innan du distribuerar dem till scen- och produktionsmiljöer.
- När du deklarerar och validerar regler börjar du alltid med `action` type `log` för att säkerställa att regeln inte blockerar legitim trafik.
- För vissa regler gäller att övergången från `log` till `block` bör endast bygga på en analys av tillräcklig platstrafik.
- Lägg in regler stegvis och överväg att involvera era testteam (QA, prestanda, penetrationstestning) i processen.
- Analysera regelns påverkan regelbundet med [kontrollpanelsverktyg](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling). Beroende på webbplatsens trafikvolym kan analysen göras varje dag, varje vecka eller varje månad.
- Om du vill blockera skadlig trafik som du kanske känner till efter analysen lägger du till eventuella ytterligare regler. Exempel: vissa IP-adresser som har attackerat din webbplats.
- Regelframtagning, driftsättning och analys ska vara en pågående, iterativ process. Det är inte en engångsaktivitet.

## Bästa tillvägagångssätt för trafikfilterregler

Aktivera trafikfilterreglerna nedan för ditt AEM. De värden du vill använda för `rateLimit` och `clientCountry` egenskaperna måste fastställas i samarbete med säkerhetsteamet.

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
    # Block requests coming from OFAC countries
      - name: block-ofac-countries
        when:
          allOf:
              - reqProperty: tier
              - matches: publish
              - reqProperty: clientCountry
                in:
                  - SY
                  - BY
                  - MM
                  - KP
                  - IQ
                  - CD
                  - SD
                  - IR
                  - LR
                  - ZW
                  - CU
                  - CI
```

>[!WARNING]
>
>Samarbeta med webbsäkerhetsteamet i produktionsmiljön för att ta reda på vilka värden som är lämpliga för `rateLimit`

## Bästa tillvägagångssätt för WAF-regler

När WAF har licensierats och aktiverats för programmet visas WAF-flaggor som matchar trafik i diagram och begärandeloggar, även om du inte deklarerat dem i en regel. Ni är alltså alltid medvetna om potentiellt ny skadlig trafik och kan skapa regler efter behov. Titta på WAF-flaggor som inte återspeglas i de deklarerade reglerna och överväg att deklarera dem.

Titta på WAF-reglerna nedan för ditt AEM. De värden du vill använda för `action` och `wafFlags` egenskapen måste fastställas i samarbete med säkerhetsteamet.

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

    # Traffic Filter rules shown in above section
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
    # Disable protection against CMDEXE on /bin
      - name: allow-cdmexe-on-root-bin
        when:
          allOf:
            - reqProperty: tier
              matches: "author|publish"
            - reqProperty: path
              matches: "^/bin/.*"
        action:
          type: allow
          wafFlags:
            - CMDEXE
```

## Sammanfattning

Sammanfattningsvis har den här självstudiekursen försett dig med de kunskaper och verktyg som behövs för att öka säkerheten i dina webbapplikationer i Adobe Experience Manager as a Cloud Service (AEMCS). Med praktiska regelexempel och insikter i resultatanalysen kan ni effektivt skydda era webbplatser och tillämpningar.



