---
title: Implementera URL-omdirigeringar som är fria från pipeline
description: Lär dig hur du implementerar URL-omdirigeringar som är kostnadsfria i AEM as a Cloud Service så att marknadsföringsteamet kan hantera omdirigeringarna utan att behöva någon utvecklare.
version: Experience Manager as a Cloud Service
feature: Operations, Dispatcher
topic: Development, Content Management, Administration
role: Developer, User
level: Beginner, Intermediate
doc-type: Article
duration: 0
last-substantial-update: 2025-02-05T00:00:00Z
jira: KT-15739
thumbnail: KT-15739.jpeg
exl-id: 3b0f5971-38b8-4b9e-b90e-9de7432e0e9d
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '973'
ht-degree: 0%

---

# Implementera URL-omdirigeringar som är fria från pipeline

Lär dig hur du implementerar [URL-omdirigeringar utan pipeline](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/pipeline-free-url-redirects) i AEM as a Cloud Service så att marknadsföringsteamet kan hantera omdirigeringarna utan att behöva någon utvecklare.

Det finns flera alternativ för att hantera URL-omdirigeringar i AEM. Mer information finns i [URL-omdirigeringar](url-redirection.md).

I självstudien ligger fokus på att skapa URL-omdirigeringar som nyckelvärdepar i en textfil som [Apache RewriteMap](https://httpd.apache.org/docs/2.4/rewrite/rewritemap.html) och AEM as a Cloud Service-specifik konfiguration används för att läsa in dem i Apache/Dispatcher-modulen.

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service-miljö med version **18311 eller senare**.

- Exempelprojektet [WKND Sites](https://github.com/adobe/aem-guides-wknd) måste distribueras till det.

## Exempel på självstudiekurser

Vi antar att WKND:s marknadsföringsteam lanserar en ny skidkampanj. De vill skapa korta URL:er för hjälpsidorna och hantera dem själva på samma sätt som de hanterar innehållet. De bestämde sig för att använda metoden [URL-omdirigeringar utan pipeline](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/pipeline-free-url-redirects) för att hantera URL-omdirigeringarna.

Baserat på marknadsföringsteamets krav är följande URL-omdirigeringar som måste skapas.

| SOURCE URL | Mål-URL |
|------------|------------|
| /ski | /us/en/adventures.html |
| /ski/northamerica | /us/en/adventures/downhill-skiing-wyoming.html |
| /ski/westkusten | /us/en/adventures/tahoe-skiing.html |
| /ski/europe | /us/en/adventures/ski-touring-mont-blanc.html |

Nu ska vi se hur du hanterar dessa URL-omdirigeringar och obligatoriska engångskonfigurationer för Dispatcher i AEM as a Cloud Service.

## Hantera URL-omdirigeringar{#manage-redirects}

Om du vill hantera URL-omdirigeringar finns det flera tillgängliga alternativ, så tittar vi närmare på dem.

### Textfil i DAM

URL-omdirigeringarna kan hanteras som nyckelvärdepar i en textfil och överföras till AEM Digital Asset Management (DAM).

Ovanstående URL-omdirigeringar kan till exempel sparas i en textfil med namnet `skicampaign.txt` och överföras till mappen DAM @ `/content/dam/wknd/redirects`. Efter granskning och godkännande kan marknadsföringsteamet publicera textfilen.

```
# Ski Campaign Redirects separated by the TAB character
/ski      /us/en/adventures.html
/ski/northamerica  /us/en/adventures/downhill-skiing-wyoming.html
/ski/westcoast   /us/en/adventures/tahoe-skiing.html
/ski/europe          /us/en/adventures/ski-touring-mont-blanc.html
```

![Textfil i DAM](./assets/pipeline-free-redirects/text-file-in-dam.png)

### ACS-kommandon - Omdirigeringshanteraren

[ACS Commons - Omdirigeringshanteraren](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-map-manager/index.html) innehåller ett användarvänligt gränssnitt för att hantera URL-omdirigeringar.

Marknadsföringsteamet kan till exempel skapa en ny *sida för omdirigeringskartor* med namnet `SkiCampaign` och lägga till ovanstående URL-omdirigeringar med fliken **Redigera poster** . URL-omdirigeringarna är tillgängliga på `/etc/acs-commons/redirect-maps/skicampaign/jcr:content.redirectmap.txt`.

![Omdirigeringshanteraren](./assets/pipeline-free-redirects/redirect-map-manager.png)

>[!IMPORTANT]
>
>ACS Commons version **&lbrace;6.7.0 eller senare** krävs för att använda Omdirigeringshanteraren. Mer information finns i [ACS Commons - Redirect Manager](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-manager/index.html).

### ACS-kommandon - omdirigeringshanteraren

Alternativt har [ACS Commons - Redirect Manager](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-manager/index.html) ett användarvänligt gränssnitt för att hantera URL-omdirigeringar.

Marknadsföringsteamet kan till exempel skapa en ny konfiguration med namnet `/conf/wknd` och lägga till URL-omdirigeringar ovan med knappen **+ Omdirigeringskonfiguration** . URL-omdirigeringarna är tillgängliga på `/conf/wknd/settings/redirects.txt`.

![Omdirigeringshanteraren](./assets/pipeline-free-redirects/redirect-manager.png)

>[!IMPORTANT]
>
>ACS Commons version **6.10.0 eller senare** krävs för att använda omdirigeringshanteraren. Mer information finns i [ACS Commons - Redirect Manager](https://adobe-consulting-services.github.io/acs-aem-commons/features/redirect-manager/subpages/rewritemap.html).

## Konfigurera Dispatcher

Följande Dispatcher-konfigurationer krävs för att läsa in URL-omdirigeringar som en RewriteMap och tillämpa dem på inkommande begäranden.

### Aktivera Dispatcher-modulen för flexibelt läge

Kontrollera först att Dispatcher-modulen är aktiverad för _flexibelt läge_. Förekomsten av filen `USE_SOURCES_DIRECTLY` i mappen `dispatcher/src/opt-in` anger att Dispatcher är i flexibelt läge.

### Läs in URL-omdirigeringar som RewriteMap

Skapa sedan en ny konfigurationsfil `managed-rewrite-maps.yaml` i mappen `dispatcher/src/opt-in` med följande struktur.

```yaml
maps:
- name: <MAPNAME>.map # e.g. skicampaign.map
    path: <ABSOLUTE_PATH_TO_URL_REDIRECTS_FILE> # e.g. /content/dam/wknd/redirects/skicampaign.txt, /etc/acs-commons/redirect-maps/skicampaign/jcr:content.redirectmap.txt, /conf/wknd/settings/redirects.txt
    wait: false # Optional, default is false, when true, the Apache waits for the map to be loaded before starting
    ttl: 300 # Optional, default is 300 seconds, the reload interval for the map
```

Under distributionen skapar Dispatcher filen `<MAPNAME>.map` i mappen `/tmp/rewrites`.

>[!IMPORTANT]
>
> Filnamnet (`managed-rewrite-maps.yaml`) och platsen (`dispatcher/src/opt-in`) ska vara exakt som anges ovan, tänk på det som en konvention att följa.

### Använd URL-omdirigeringar på inkommande begäranden

Skapa eller uppdatera slutligen konfigurationsfilen för Apache genom att skriva om den så att den använder ovanstående karta (`<MAPNAME>.map`). Vi använder till exempel filen `rewrite.rules` från mappen `dispatcher/src/conf.d/rewrites` för att tillämpa URL-omdirigeringarna.

```
...
# Use the RewriteMap to define the URL redirects
RewriteMap <MAPALIAS> dbm=sdbm:/tmp/rewrites/<MAPNAME>.map

RewriteCond ${<MAPALIAS>:$1} !=""
RewriteRule ^(.*)$ ${<MAPALIAS>:$1|/} [L,R=301]    
...
```

### Exempelkonfigurationer

Låt oss granska Dispatcher-konfigurationerna för var och en av de URL-omdirigeringsalternativ som nämns [ovan](#manage-redirects).

>[!BEGINTABS]

>[!TAB Textfil i DAM]

När URL-omdirigeringar hanteras som nyckelvärdepar i en textfil och överförs till DAM är konfigurationerna följande.

[!BADGE dispatcher/src/opt-in/managed-rewrite-maps.yaml]{type=Neutral tooltip="Filnamn på kodexemplet nedan."}

```yaml
maps:
- name: skicampaign.map
  path: /content/dam/wknd/redirects/skicampaign.txt
```

[!BADGE dispatcher/src/conf.d/rewrites/rewrite.rules]{type=Neutral tooltip="Filnamn på kodexemplet nedan."}

```
...

# The DAM-managed skicampaign.txt file as skicampaign.map
RewriteMap skicampaign dbm=sdbm:/tmp/rewrites/skicampaign.map

# Apply the RewriteMap for matching request URIs
RewriteCond ${skicampaign:$1} !=""
RewriteRule ^(.*)$ ${skicampaign:$1|/} [L,R=301]

...
```

>[!TAB ACS-kommandon - Omdirigeringshanteraren]

När URL-omdirigeringar hanteras med ACS Commons - Omdirigeringshanteraren är konfigurationerna följande.

[!BADGE dispatcher/src/opt-in/managed-rewrite-maps.yaml]{type=Neutral tooltip="Filnamn på kodexemplet nedan."}

```yaml
maps:
- name: skicampaign.map
  path: /etc/acs-commons/redirect-maps/skicampaign/jcr:content.redirectmap.txt
```

[!BADGE dispatcher/src/conf.d/rewrites/rewrite.rules]{type=Neutral tooltip="Filnamn på kodexemplet nedan."}

```
...

# The Redirect Map Manager-managed skicampaign.map
RewriteMap skicampaign dbm=sdbm:/tmp/rewrites/skicampaign.map

# Apply the RewriteMap for matching request URIs
RewriteCond ${skicampaign:$1} !=""
RewriteRule ^(.*)$ ${skicampaign:$1|/} [L,R=301]

...
```

>[!TAB ACS-kommandon - Omdirigeringshanteraren&#x200B;]

När URL-omdirigeringar hanteras med ACS Commons - Redirect Manager är konfigurationerna följande.

[!BADGE dispatcher/src/opt-in/managed-rewrite-maps.yaml]{type=Neutral tooltip="Filnamn på kodexemplet nedan."}

```yaml
maps:
- name: skicampaign.map
  path: /conf/wknd/settings/redirects.txt
```

[!BADGE dispatcher/src/conf.d/rewrites/rewrite.rules]{type=Neutral tooltip="Filnamn på kodexemplet nedan."}

```
...

# The Redirect Manager-managed skicampaign.map
RewriteMap skicampaign dbm=sdbm:/tmp/rewrites/skicampaign.map

# Apply the RewriteMap for matching request URIs
RewriteCond ${skicampaign:$1} !=""
RewriteRule ^(.*)$ ${skicampaign:$1|/} [L,R=301]

...
```

>[!ENDTABS]

## Så här distribuerar du konfigurationerna

>[!IMPORTANT]
>
>Termen *pipeline-fri* används för att betona att konfigurationerna bara distribueras en gång *och marknadsföringsteamet kan hantera URL-omdirigeringar genom att uppdatera textfilen.*

Om du vill distribuera konfigurationerna använder du pipeline [full-stack](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines#full-stack-pipeline) eller [web tier config](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines#web-tier-config-pipelines) i [Cloud Manager](https://my.cloudmanager.adobe.com/) .

![Distribuera via pipeline i helhög](./assets/pipeline-free-redirects/deploy-full-stack-pipeline.png)


När distributionen är klar är URL-omdirigeringarna aktiva och marknadsföringsteamet kan hantera dem utan att behöva en utvecklare.

## Så här testar du URL-omdirigeringar

Låt oss testa URL-omdirigeringarna med webbläsaren eller kommandot `curl`. Gå till URL:en för `/ski/westcoast` och verifiera att den omdirigeras till `/us/en/adventures/tahoe-skiing.html`.

## Sammanfattning

I den här självstudiekursen fick du lära dig att hantera URL-omdirigeringar med hjälp av pipelinefria konfigurationer i AEM as a Cloud Service-miljön.

Marknadsföringsteamet kan hantera URL-omdirigeringar som nyckelvärdepar i en textfil och överföra dem till DAM eller använda ACS Commons - Redirect Map Manager eller Redirect Manager. Dispatcher-konfigurationerna uppdateras för att läsa in URL-omdirigeringarna som en RewriteMap och tillämpa dem på inkommande begäranden.

## Ytterligare resurser

- [Pipeline-fria URL-omdirigeringar](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/content-delivery/pipeline-free-url-redirects)
- [URL-omdirigeringar](url-redirection.md)
