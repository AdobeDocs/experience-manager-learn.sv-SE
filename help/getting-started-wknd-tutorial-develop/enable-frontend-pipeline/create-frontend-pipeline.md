---
title: Distribuera via pipeline i frontend-läget
description: Lär dig hur du skapar och kör en frontend-pipeline som bygger front-end-resurser och distribuerar till det inbyggda CDN på AEM as a Cloud Service.
version: Cloud Service
feature: AEM Project Archetype, Cloud Manager, CI-CD Pipeline
topic: Content Management, Development, Development, Architecture
role: Developer, Architect, Admin
level: Intermediate
jira: KT-10689
mini-toc-levels: 1
index: y
recommendations: noDisplay, noCatalog
doc-type: Tutorial
exl-id: d6da05e4-bd65-4625-b9a4-cad8eae3c9d7
duration: 270
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '685'
ht-degree: 0%

---

# Distribuera via pipeline i frontend-läget

I det här kapitlet skapar och kör vi en frontpipeline i Adobe Cloud Manager. Det bygger bara filer från `ui.frontend` och distribuerar dem till det inbyggda CDN på AEM as a Cloud Service. Gå bort från  `/etc.clientlibs` för leverans av särskilda resurser.


## Mål {#objectives}

* Skapa och kör en frontendpipeline.
* Verifiera att frontendresurserna INTE levereras från `/etc.clientlibs` men från ett nytt värdnamn som börjar med `https://static-`

## Använda den främre rörledningen

>[!VIDEO](https://video.tv.adobe.com/v/3409420?quality=12&learn=on)

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att stegen som beskrivs i [Uppdatera AEM](./update-project.md) har slutförts.

Se till att du har [behörighet att skapa och distribuera rörledningar i Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/requirements/users-and-roles.html?lang=en#role-definitions) och [åtkomst till en AEM as a Cloud Service miljö](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments.html).

## Byt namn på befintlig pipeline

Byt namn på befintlig pipeline från __Distribuera till Dev__ till  __FullStack WKND Distribuera till Dev__ genom att gå till __Konfiguration__ flikar __Namn på icke-produktionsförlopp__ fält. Detta för att tydligt ange om en pipeline är en hel hög eller en front-end genom att bara titta på dess namn.

![Byt namn på pipeline](assets/fullstack-wknd-deploy-dev-pipeline.png)


I __Källkod__ ska du kontrollera att fältvärdena Databas och Git Branch är korrekta och att grenen har ditt avtal för frontend-pipeline ändrat.

![Källkodskonfigurationspipeline](assets/fullstack-wknd-source-code-config.png)


## Skapa en pipeline för säljprojektet

Till __ENDAST__ bygga och driftsätta resurser från `ui.frontend` utför du följande steg:

1. I användargränssnittet för Cloud Manager kan du gå till __Pipelines__ avsnitt, klicka __Lägg till__ knapp och sedan markera __Lägg till icke-produktionsförlopp__ (eller __Lägg till produktionspipeline__) baserat på den AEM as a Cloud Service miljön som du vill distribuera till.

1. I __Lägg till icke-produktionsförlopp__ som en del av __Konfiguration__ steg väljer du __Distributionsförlopp__ option, name it as __FrontEnd WKND Distribuera till Dev__ och klicka __Fortsätt__

![Skapa frontlinjeförslutskonfigurationer](assets/create-frontend-pipeline-configs.png)

1. Som en del av __Källkod__ steg väljer du __Front End-kod__ och välj miljö __Berättigade driftsättningsmiljöer__. I __Källkod__ kontrollerar du att fälten Databas och Git Branch är korrekta och att grenen har ditt avtal för frontend-pipeline ändrat.
Och __viktigast__ för __Kodplats__ fält där värdet är `/ui.frontend` och slutligen klickar du __Spara__.

![Skapa källkod för frontpipeline](assets/create-frontend-pipeline-source-code.png)


## Distributionssekvens

* Kör först det nya namnet __FullStack WKND Distribuera till Dev__ för att ta bort WKND-klientfiler från AEM. Och viktigast av allt, förbered AEM för det rörliga slutavtalet genom att lägga till __Sling-konfiguration__ filer (`SiteConfig`, `HtmlPageItemsConfig`).

![Oformaterad WKND-plats](assets/unstyled-wknd-site.png)

>[!WARNING]
>
>Efter __FullStack WKND Distribuera till Dev__ slutförande av pipeline kommer att ha __oformaterad__ WKND-plats, som kan se trasig ut. Planera ett driftstopp eller en driftsättning under udda timmar. Detta är en engångsstörning som du måste planera för under den initiala övergången från att använda en enda pipeline i full hög till den främre pipelinen.


* Till sist kör du __FrontEnd WKND Distribuera till Dev__ endast bygga `ui.frontend` och driftsätta resurserna direkt till CDN:n.

>[!IMPORTANT]
>
>Du märker att __oformaterad__ WKND-webbplatsen är nu normal igen och den här gången __FrontEnd__ körningen av pipeline var mycket snabbare än den fullständiga pipeline-stacken.

## Verifiera formatändringar och nya leveranssätt

* Öppna WKND-webbplatsens alla sidor så ser du textfärgen __Adobe röd__ och frontend-resurserna (CSS, JS) levereras från CDN. Resursbegärans värdnamn börjar med `https://static-pXX-eYY.p123-e456.adobeaemcloud.com/$HASH_VALUE$/theme/site.css` och på samma sätt som site.js eller andra statiska resurser som du refererade till i `HtmlPageItemsConfig` -fil.


![WKND-webbplats med ny formatering](assets/newly-styled-wknd-site.png)



>[!TIP]
>
>The `$HASH_VALUE$` det här är samma som det du ser i __FrontEnd WKND Distribuera till Dev__  pipeline __INNEHÅLLSHASH__ fält. AEM meddelas om frontend-resursens CDN-URL, värdet lagras på `/conf/wknd/sling:configs/com.adobe.cq.wcm.core.components.config.HtmlPageItemsConfig/jcr:content` under __prefixPath__ -egenskap.


![Hash-värdekorrelation](assets/hash-value-correlartion.png)



## Grattis! {#congratulations}

Gratulerar, du skapade, körde och verifierade frontpipeline som bara bygger och distribuerar ui.front-modulen i WKND Sites-projektet. Nu kan teamet snabbt iterera på webbplatsens design och gränssnitt, utanför hela AEM.

## Nästa steg {#next-steps}

I nästa kapitel [Överväganden](considerations.md)kommer du att granska hur utvecklingsprocessen påverkar både den interna och den bakre utvecklingsprocessen.
