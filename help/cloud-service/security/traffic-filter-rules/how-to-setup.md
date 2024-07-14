---
title: Konfigurera trafikfilterregler inklusive WAF-regler
description: Lär dig hur du konfigurerar för att skapa, driftsätta, testa och analysera resultaten av trafikfilterregler, inklusive WAF-regler.
version: Cloud Service
feature: Security
topic: Security, Administration, Architecture
role: Admin, Architect
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-10-26T00:00:00Z
jira: KT-13148
thumbnail: KT-13148.jpeg
exl-id: b67bf642-3341-48d0-8ea9-5f262febf414
duration: 292
source-git-commit: c7c78ca56c1d72f13d2dc80229a10704ab0f14ab
workflow-type: tm+mt
source-wordcount: '575'
ht-degree: 0%

---

# Konfigurera trafikfilterregler inklusive WAF-regler

Lär dig **hur du konfigurerar** trafikfilterregler, inklusive WAF-regler. Läs om hur du skapar, distribuerar, testar och analyserar resultat.

>[!VIDEO](https://video.tv.adobe.com/v/3425407?quality=12&learn=on)

## Inställningar

Installationsprocessen omfattar följande:

- _skapar regler_ med en lämplig AEM projektstruktur och konfigurationsfil.
- _distribuerar regler_ med konfigurationsflödet Adobe Cloud Manager.
- _testar regler_ med olika verktyg för att generera trafik.
- _analyserar resultaten_ med hjälp av AEMCS CDN-loggar och instrumentpanelsverktyg.

### Skapa regler i ditt AEM projekt

Så här skapar du regler:

1. Skapa en mapp `config` på den översta nivån i AEM.

1. Skapa en ny fil med namnet `cdn.yaml` i mappen `config`.

1. Lägg till följande metadata i filen `cdn.yaml`:

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
```

Se ett exempel på filen `cdn.yaml` i AEM Guides WKND Sites Project:

![WKND AEM projektregelfil och -mapp](./assets/wknd-rules-file-and-folder.png){width="800" zoomable="yes"}

### Distribuera regler via Cloud Manager {#deploy-rules-through-cloud-manager}

Så här distribuerar du reglerna:

1. Logga in på Cloud Manager på [my.cloudmanager.adobe.com](https://my.cloudmanager.adobe.com/) och välj rätt organisation och program.

1. Navigera till kortet _Pipelines_ på sidan _Programöversikt_ och klicka på knappen **+Lägg till** och välj önskad pipelinetyp.

   ![Cloud Manager Pipelines-kort](./assets/cloud-manager-pipelines-card.png)

   I exemplet ovan har _Lägg till icke-produktionsförlopp_ valts för demoändamål eftersom en utvecklingsmiljö används.

1. Välj och ange följande information i dialogrutan _Lägg till icke-produktionspipeline_:

   1. Konfigurationssteg:

      - **Typ**: Distributionsförlopp
      - **Pipelinenamn**: Dev-Config

      ![Dialogrutan Cloud Manager Config Pipeline ](./assets/cloud-manager-config-pipeline-step1-dialog.png)

   2. Source Code step:

      - **Kod för distribution**: Måldistribution
      - **Inkludera**: Konfiguration
      - **Distributionsmiljö**: Miljöns namn, till exempel wk-program-dev.
      - **Databas**: Git-databasen varifrån pipelinen ska hämta koden, till exempel `wknd-site`
      - **Git-grenen**: Namnet på Git-databasgrenen.
      - **Kodplats**: `/config`, som motsvarar den konfigurationsmapp på den översta nivån som skapades i föregående steg.

      ![Dialogrutan Cloud Manager Config Pipeline ](./assets/cloud-manager-config-pipeline-step2-dialog.png)

### Testa regler genom att generera trafik

För att testa regler finns det olika tredjepartsverktyg att tillgå, och din organisation kan ha ett verktyg som du föredrar. För demosyftet använder vi följande verktyg:

- [Rullande](https://curl.se/) för grundläggande testning, som att anropa en URL och kontrollera svarskoden.

- [Vegeta](https://github.com/tsenart/vegeta) för att utföra denial of service-attacker (DOS). Följ installationsanvisningarna från [Vegeta GitHub](https://github.com/tsenart/vegeta#install).

- [Nikto](https://github.com/sullo/nikto/wiki) om du vill hitta potentiella problem och säkerhetsluckor som XSS, SQL-injektion med mera. Följ installationsanvisningarna från [Nikto GitHub](https://github.com/sullo/nikto).

- Kontrollera att verktygen är installerade och tillgängliga i terminalen genom att köra kommandona nedan:

  ```shell
  # Curl version check
  $ curl --version
  
  # Vegeta version check
  $ vegeta -version
  
  # Nikto version check
  $ cd <PATH-OF-CLONED-REPO>/program
  ./nikto.pl -Version
  ```

### Analysera resultaten med kontrollpanelsverktygen

När du har skapat, distribuerat och testat reglerna kan du analysera resultaten med hjälp av **CDN**-loggar och **AEMCS-CDN-Log-Analysis-Tooling**. Verktyget innehåller en uppsättning instrumentpaneler för att visualisera resultatet för Splunk- och ELK-stacken (Elasticsearch, Logstash och Kibana).

Verktyget kan klonas från GitHub-databasen [AEMCS-CDN-Log-Analysis-Tooling](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling). Följ sedan instruktionerna för att installera och läsa in kontrollpanelerna **CDN Traffic Dashboard** och **WAF Dashboard** för det observerbarhetsverktyg du föredrar.

I den här självstudiekursen använder vi ELK-stacken. Följ instruktionerna för [ELK Docker-behållaren för AEMCS CDN-logganalys](https://github.com/adobe/AEMCS-CDN-Log-Analysis-Tooling/blob/main/ELK/README.md) för att konfigurera ELK-stacken.

- När du har läst in exempelinstrumentpanelen bör sidan med verktyget Elastic Dashboard se ut så här:

  ![Kontrollpanel för ELK-trafikfilterregler](./assets/elk-dashboard.png)

>[!NOTE]
>
>    Instrumentpanelen är tom eftersom det ännu inte finns några AEMCS CDN-loggar.


## Nästa steg

Lär dig hur du deklarerar trafikfilterregler inklusive WAF-regler i kapitlet [Exempel och resultatanalys](./examples-and-analysis.md) med hjälp av AEM WKND Sites Project.
