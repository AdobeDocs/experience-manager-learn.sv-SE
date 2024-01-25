---
title: Analys av träffgrad i CDN-cache
description: Lär dig hur du analyserar de AEM as a Cloud Service CDN-loggarna. Få insikter som till exempel cacheminnets träffgrad och de översta URL:erna för MISS- och PASS-cachetyperna för optimeringsändamål.
version: Cloud Service
feature: Operations, CDN Cache
topic: Administration, Performance
role: Admin, Architect, Developer
level: Intermediate
doc-type: Tutorial
last-substantial-update: 2023-11-10T00:00:00Z
jira: KT-13312
thumbnail: KT-13312.jpeg
exl-id: 43aa7133-7f4a-445a-9220-1d78bb913942
duration: 342
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1352'
ht-degree: 0%

---

# Analys av träffgrad i CDN-cache

Innehåll som cachas vid CDN minskar den fördröjning som webbplatsanvändare upplever, som inte behöver vänta på att en begäran ska skickas tillbaka till Apache/Dispatcher eller AEM publicering. Med detta i åtanke är det värt att optimera CDN-cache-träffkvoten för att maximera mängden innehåll som kan cachas vid CDN.

Lär dig hur du analyserar den AEM as a Cloud Service **CDN-loggar** och få insikter som **träffgrad för cache** och **de översta URL:erna för _MISS_ och _PASS_ cachetyper**, för optimeringsändamål.


CDN-loggarna är tillgängliga i JSON-format, som innehåller olika fält, bland annat `url`, `cache`. Mer information finns i [CDN-loggformat](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/logging.html?lang=en#cdn-log:~:text=Toggle%20Text%20Wrapping-,Log%20Format,-The%20CDN%20logs). The `cache` fält innehåller information om _cachestatus_ och dess möjliga värden är HIT, MISS eller PASS. Vi granskar detaljerna om möjliga värden.

| Status för cache </br> Möjligt värde | Beskrivning |
|------------------------------------|:-----------------------------------------------------:|
| TRYCK | Begärda data är _hittades i CDN-cachen och kräver inte någon hämtning_ begäran till AEM. |
| MISS | Begärda data är _hittades inte i CDN-cachen och måste begäras_ från AEM. |
| PASS | Begärda data är _explicit inställd på att inte cachelagras_ och alltid hämtas från AEM. |

I den här självstudiekursen ska [AEM WKND-projekt](https://github.com/adobe/aem-guides-wknd) distribueras till den AEM as a Cloud Service miljön och ett litet prestandatest aktiveras med [Apache JMeter](https://jmeter.apache.org/).

Den här självstudiekursen är utformad för att ta dig igenom följande process:
1. Hämta CDN-loggar via Cloud Manager
1. Analysera dessa CDN-loggar, som kan utföras med två metoder: en lokalt installerad instrumentpanel eller en fjärransluten Jupityer-anteckningsbok (för dem som licensierar Adobe Experience Platform)
1. Optimerar CDN-cachekonfiguration

## Hämta CDN-loggar

Så här hämtar du CDN-loggarna:

1. Logga in i Cloud Manager på [my.cloudmanager.adobe.com](https://my.cloudmanager.adobe.com/) och väljer organisation och program.

1. För önskad AEMCS-miljö väljer du **Hämta loggar** på ellipsmenyn.

   ![Hämta loggar - Cloud Manager](assets/cdn-logs-analysis/download-logs.png){width="500" zoomable="yes"}

1. I **Hämta loggar** väljer du **Publicera** Tjänst från listrutan och klicka sedan på nedladdningsikonen bredvid **cdn** rad.

   ![CDN-loggar - Cloud Manager](assets/cdn-logs-analysis/download-cdn-logs.png){width="500" zoomable="yes"}


Om den hämtade loggfilen kommer från _idag_ filtillägget är `.log` annars är tillägget för tidigare loggfiler `.log.gz`.

## Analysera hämtade CDN-loggar

Analysera CDN-loggfilen om du vill få insikter om till exempel cacheminnets träffgrad och de översta URL:erna för MISS- och PASS-cachetyperna. Dessa insikter hjälper till att optimera [Konfiguration av CDN-cache](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html) och förbättra webbplatsens prestanda.

För att analysera CDN-loggarna finns det två alternativ i den här artikeln: **Elasticsearch, Logstash och Kibana (ELK)** [kontrollpanelsverktyg](https://github.com/adobe/AEMCS-CDN-Log-Analysis-ELK-Tool) och [Jupyter Notebook](https://jupyter.org/). ELK-instrumentpanelsverktygen kan installeras lokalt på din bärbara dator, medan Jupityr-verktygen för bärbara datorer kan nås via fjärranslutning [som en del av Adobe Experience Platform](https://experienceleague.adobe.com/docs/experience-platform/data-science-workspace/jupyterlab/analyze-your-data.html?lang=en) utan att installera ytterligare programvara för dem som har licens för Adobe Experience Platform.


### Alternativ 1: Använda verktygen på ELK-kontrollpanelen

The [ELK-stack](https://www.elastic.co/elastic-stack) är en uppsättning verktyg som ger en skalbar lösning för att söka, analysera och visualisera data. Den består av Elasticsearch, Logstash och Kibana.

Om du vill identifiera nyckeldetaljerna använder du [AEMCS-CDN-Log-Analysis-ELK-Tool](https://github.com/adobe/AEMCS-CDN-Log-Analysis-ELK-Tool) verktygsprojekt för kontrollpanelen. Det här projektet innehåller en Docker-behållare för ELK-stacken och en förkonfigurerad Kibana-kontrollpanel för analys av CDN-loggarna.

1. Följ stegen från [Så här konfigurerar du ELK Docker-behållaren](https://github.com/adobe/AEMCS-CDN-Log-Analysis-ELK-Tool#how-to-set-up-the-elk-docker-container) och se till att importera **CDN-cacheträffrekvens** Kibanans kontrollpanel.

1. Följ de här stegen för att identifiera CDN-cachens träfffrekvens och övre URL:er:

   1. Kopiera de hämtade CDN-loggfilerna i den miljöspecifika mappen.

   1. Öppna **CDN-cacheträffrekvens** genom att klicka på navigeringsmenyn i det övre vänstra hörnet > Analytics > Dashboard > CDN Cache Hit Ratio.

      ![CDN-cacheträffrekvens - Kibaninstrumentpanel](assets/cdn-logs-analysis/cdn-cache-hit-ratio-dashboard.png){width="500" zoomable="yes"}

   1. Välj önskat tidsintervall i det övre högra hörnet.

      ![Tidsintervall - Kibana Dashboard](assets/cdn-logs-analysis/time-range.png){width="500" zoomable="yes"}

   1. The **CDN-cacheträffrekvens** Instrumentpanelen är självförklarande.

   1. The _Analys av totalt begärande_ visas följande information:
      - Cacheproportioner efter cachetyp
      - Cacheantal per cachetyp

      ![Analys av totalt begäranden - Kibana Dashboard](assets/cdn-logs-analysis/total-request-analysis.png){width="500" zoomable="yes"}

   1. The _Analys efter begäran eller MIME-typer_ visar följande information:
      - Cacheproportioner efter cachetyp
      - Cacheantal per cachetyp
      - MEST SAKNAS- och PASS-URL:er

      ![Analys efter begäran eller MIME-typer - Kibana Dashboard](assets/cdn-logs-analysis/analysis-by-request-or-mime-types.png){width="500" zoomable="yes"}

#### Filtrera efter miljönamn eller program-ID

Följ stegen nedan för att filtrera de kapslade loggarna efter miljönamn:

1. Klicka på knappen **Lägg till filter** -ikon.

   ![Filter - Kibanas Dashboard](assets/cdn-logs-analysis/filter.png){width="500" zoomable="yes"}

1. I **Lägg till filter** modal, välj `aem_env_name.keyword` fält från den nedrullningsbara menyn och `is` operator och önskat miljönamn för nästa fält och klicka slutligen på _Lägg till filter_.

   ![Lägg till filter - Kibana Dashboard](assets/cdn-logs-analysis/add-filter.png){width="500" zoomable="yes"}

#### Filtrera efter värdnamn

Följ stegen nedan för att filtrera de kapslade loggarna efter värdnamn:

1. Klicka på knappen **Lägg till filter** -ikon.

   ![Filter - Kibanas Dashboard](assets/cdn-logs-analysis/filter.png){width="500" zoomable="yes"}

1. I **Lägg till filter** modal, välj `host.keyword` fält från den nedrullningsbara menyn och `is` operator och önskat värdnamn för nästa fält och klicka slutligen på _Lägg till filter_.

   ![Värdfilter - Kibankontrollpanel](assets/cdn-logs-analysis/add-host-filter.png){width="500" zoomable="yes"}

Lägg också till fler filter på kontrollpanelen baserat på analyskraven.

### Alternativ 2: Använda Jupyter-anteckningsbok

För dem som inte vill installera programvaran lokalt (dvs. ELK-kontrollpanelsverktyget från föregående avsnitt) finns det ett annat alternativ, men det krävs en licens för Adobe Experience Platform.

The [Jupyter Notebook](https://jupyter.org/) är ett webbprogram med öppen källkod som gör att du kan skapa dokument som innehåller kod, text och visualisering. Det används för datatransformering, visualisering och statistisk modellering. Den kan nås via fjärranslutning [som en del av Adobe Experience Platform](https://experienceleague.adobe.com/docs/experience-platform/data-science-workspace/jupyterlab/analyze-your-data.html?lang=en).

#### Hämtar den interaktiva Python-anteckningsboksfilen

Ladda först ned [AEM-som-molntjänst - CDN-logganalys - Jupyter-anteckningsbok](./assets/cdn-logs-analysis/aemcs_cdn_logs_analysis.ipynb) -filen, som är till hjälp vid CDN-logganalysen. Den här&quot;interaktiva Python Notebook&quot;-filen är självförklarande, men huvudinnehållet i varje avsnitt är:

- **Installera ytterligare bibliotek**: installerar `termcolor` och `tabulate` Python-bibliotek.
- **Läs in CDN-loggar**: läser in CDN-loggfilen med `log_file` variabelvärde; se till att uppdatera värdet. CDN-loggen omvandlas också till [Pandor DataFrame](https://pandas.pydata.org/docs/reference/frame.html).
- **Utför analys**: det första kodblocket är _Visa analysresultat för totalt, HTML, JS/CSS och bildbegäranden_; ger cacheträffgrad i procent, bar och cirkeldiagram.
Det andra kodblocket är _De fem vanligaste URL:erna för MISS- och PASS-begäranden för HTML, JS/CSS och Image_; URL:er och deras antal visas i tabellformat.

#### Kör Jupyter-anteckningsboken

Kör sedan Jupyter Notebook i Adobe Experience Platform enligt följande:

1. Logga in på [Adobe Experience Cloud](https://experience.adobe.com/), på startsidan > **Snabb åtkomst** > klicka på **Experience Platform**

   ![Experience Platform](assets/cdn-logs-analysis/experience-platform.png){width="500" zoomable="yes"}

1. På Adobe Experience Platform hemsida > Datavetenskap > klickar du på **Bärbara datorer** menyalternativ. Starta Jupyter Notebooks-miljön genom att klicka på **JupyterLab** -fliken.

   ![Uppdatering av loggfilsvärde för anteckningsbok](assets/cdn-logs-analysis/datascience-notebook.png){width="500" zoomable="yes"}

1. På JupyterLab-menyn använder du **Överför filer** överför CDN-loggfilen och `aemcs_cdn_logs_analysis.ipynb` -fil.

   ![Överför filer - JupyteLab](assets/cdn-logs-analysis/jupyterlab-upload-file.png){width="500" zoomable="yes"}

1. Öppna `aemcs_cdn_logs_analysis.ipynb` genom att dubbelklicka.

1. I **Läs in CDN-loggfil** i anteckningsboken, uppdatera `log_file` värde.

   ![Uppdatering av loggfilsvärde för anteckningsbok](assets/cdn-logs-analysis/notebook-update-variable.png){width="500" zoomable="yes"}

1. Om du vill köra den markerade cellen och gå framåt klickar du på **Spela upp** -ikon.

   ![Uppdatering av loggfilsvärde för anteckningsbok](assets/cdn-logs-analysis/notebook-run-cell.png){width="500" zoomable="yes"}

1. När du har kört **Visa analysresultat för totalt, HTML, JS/CSS och bildbegäranden** i kodcellen visas cache-träff i procent, staplar och cirkeldiagram.

   ![Uppdatering av loggfilsvärde för anteckningsbok](assets/cdn-logs-analysis/output-cache-hit-ratio.png){width="500" zoomable="yes"}

1. När du har kört **De fem vanligaste URL:erna för MISS- och PASS-begäranden för HTML, JS/CSS och Image** i kodcellen visas de fem vanligaste URL:erna för MISS- och PASS-begäranden.

   ![Uppdatering av loggfilsvärde för anteckningsbok](assets/cdn-logs-analysis/output-top-urls.png){width="500" zoomable="yes"}

Du kan förbättra Jupyter-anteckningsboken för att analysera CDN-loggarna utifrån dina behov.

## Optimerar CDN-cachekonfiguration

När du har analyserat CDN-loggarna kan du optimera CDN-cachekonfigurationen för att förbättra platsens prestanda. Det AEM bästa sättet är att ha en cacheträffkvot på 90 % eller mer.

Mer information finns i [Optimera CDN-cachekonfiguration](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/content-delivery/caching.html#caching).

AEM WKND-projektet har en referens-CDN-konfiguration. Mer information finns i [CDN-konfiguration](https://github.com/adobe/aem-guides-wknd/blob/main/dispatcher/src/conf.d/available_vhosts/wknd.vhost#L137-L190) från `wknd.vhost` -fil.
