---
title: Övervaka känsliga begäranden
description: Lär dig övervaka känsliga begäranden genom att logga dem med trafikfilterregler i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2025-06-04T00:00:00Z
jira: KT-18311
thumbnail: null
exl-id: 8fa0488f-b901-49bf-afa5-5ed29242355f
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '520'
ht-degree: 0%

---

# Övervaka känsliga begäranden

Lär dig övervaka känsliga begäranden genom att logga dem med trafikfilterregler i AEM as a Cloud Service.

Loggning gör att du kan observera trafikmönster utan att påverka slutanvändare eller tjänster och är ett viktigt första steg innan du implementerar blockeringsregler.

I den här självstudien visas hur du **loggar begäranden om WKND-inloggning och utloggningssökvägar** mot AEM Publish-tjänsten.

## Varför och när begäranden ska loggas

Loggning av specifika förfrågningar är en riskfylld, värdefull metod för att förstå hur användare - och potentiellt skadliga aktörer - interagerar med ditt AEM-program. Det är särskilt användbart innan ni tillämpar blockeringsregler, vilket ger er förtroendet att förfina säkerhetspositionen utan att störa legitim trafik.

Vanliga scenarier för loggning är:

- Verifierar effekten och räckvidden för en regel innan den befordras till läget `block`.
- Övervaka inloggnings-/utloggningssökvägar och autentiseringsslutpunkter för ovanliga mönster eller försök med styrka.
- Spåra högfrekvent åtkomst till API-slutpunkter för potentiellt missbruk eller DoS-aktivitet.
- Fastställande av baslinjer för båda beteendena innan strängare kontroller tillämpas.
- Vid säkerhetsincidenter ska du tillhandahålla kriminaltekniska uppgifter för att förstå attackens och de drabbade resurserna.

## Förutsättningar

Innan du fortsätter bör du kontrollera att du har slutfört den nödvändiga konfigurationen enligt anvisningarna i självstudiekursen [Så här konfigurerar du trafikfilter och WAF-regler](../setup.md). Att du har klonat och distribuerat [AEM WKND Sites Project](https://github.com/adobe/aem-guides-wknd) till din AEM-miljö.

## Exempel: Logga WKND-inloggnings- och utloggningsbegäranden

I det här exemplet skapar du en trafikfilterregel som loggar begäranden som görs till inloggnings- och utloggningssökvägarna för WKND i tjänsten AEM Publish. Det hjälper dig att övervaka autentiseringsförsök och identifiera potentiella säkerhetsproblem.

- Lägg till följande regel i WKND-projektets `/config/cdn.yaml`-fil.

```yaml
kind: "CDN"
version: "1"
metadata:
  envTypes: ["dev", "stage", "prod"]
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

- Distribuera ändringarna i AEM-miljön med Cloud Manager konfigurationspipeline [som skapades tidigare](../setup.md#deploy-rules-using-adobe-cloud-manager).

- Testa regeln genom att logga in och logga ut från programmets WKND-plats (till exempel `https://publish-pXXXX-eYYYY.adobeaemcloud.com/us/en.html`). Du kan använda `asmith/asmith` som användarnamn och lösenord.

  ![WKND-inloggning](../assets/how-to/wknd-login.png)

## Analyserar

Låt oss analysera resultatet av regeln `publish-auth-requests` genom att hämta AEMCS CDN-loggarna från Cloud Manager och använda [AEMCS CDN Log Analysis Tooling](../setup.md#setup-the-elastic-dashboard-tool).

- Hämta CDN-loggarna för AEMCS [Publish](https://my.cloudmanager.adobe.com/)-tjänsten från **Cloud Manager** s **Environmental**-kort.

  ![Cloud Manager CDN-logghämtningar](../assets/how-to/cloud-manager-cdn-log-downloads.png)

  >[!TIP]
  >
  > Det kan ta upp till 5 minuter innan de nya förfrågningarna visas i CDN-loggarna.

- Kopiera den hämtade loggfilen (till exempel `publish_cdn_2023-10-24.log` i skärmbilden nedan) till mappen `logs/dev` i det Elastic Dashboard-verktygsprojektet.

  ![Loggmapp för ELK-verktyg](../assets/how-to/elk-tool-logs-folder.png)

- Uppdatera sidan med verktyget Elastic Dashboard.
   - I det övre avsnittet **Global filter** redigerar du filtret `aem_env_name.keyword` och väljer miljövärdet `dev` .

     ![ELK Tool Global Filter](../assets/how-to/elk-tool-global-filter.png)

   - Om du vill ändra tidsintervallet klickar du på kalenderikonen i det övre högra hörnet och väljer önskat tidsintervall.

     ![Tidsintervall för ELK-verktyg](../assets/how-to/elk-tool-time-interval.png)

- Granska den uppdaterade instrumentpanelens **Analyserade förfrågningar**, **Flaggade förfrågningar** och **Flaggade förfrågningar**. För matchande CDN-loggposter bör värdena för varje posts klient-IP (cli_ip), host, url, action (waf_action) och rule-name (waf_match) visas.

  ![ELK Tool Dashboard](../assets/how-to/elk-tool-dashboard.png)
