---
title: Använda AEM moderniseringsverktyg för att gå över till AEM as a Cloud Service
description: Läs om hur AEM Moderniseringsverktyg används för att uppgradera ett befintligt AEM-projekt och innehåll så att det blir AEM as a Cloud Service-kompatibelt.
version: Experience Manager as a Cloud Service
topic: Migration, Upgrade
feature: Migration
role: Developer
level: Experienced
jira: KT-8629
thumbnail: 336965.jpeg
exl-id: 310f492c-0095-4015-81a4-27d76f288138
duration: 2502
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '385'
ht-degree: 1%

---


# AEM Modernization Tools

Läs om hur AEM Moderniseringsverktyg används för att uppgradera befintligt AEM Sites-innehåll så att det blir AEM as a Cloud Service-kompatibelt och följer vedertagna standarder.

## All-in-One Converter

>[!VIDEO](https://video.tv.adobe.com/v/338802?quality=12&learn=on)

## Sidkonvertering

>[!VIDEO](https://video.tv.adobe.com/v/338799?quality=12&learn=on)

## Komponentkonvertering

>[!VIDEO](https://video.tv.adobe.com/v/338788?quality=12&learn=on)

## Principimport

>[!VIDEO](https://video.tv.adobe.com/v/338797?quality=12&learn=on)

## Använda AEM moderniseringsverktyg

![Livscykel för AEM moderniseringsverktyg](./assets/aem-modernization-tools.png)

AEM moderniseringsverktyg konverterar automatiskt befintliga AEM Pages-sidor som består av gamla statiska mallar, grundkomponenter och parsys för att använda moderna metoder som redigerbara mallar, AEM Core WCM-komponenter och layoutbehållare.

## Viktiga aktiviteter

+ Klona produktionen av AEM 6.x och kör AEM moderniseringsverktyg mot
+ Hämta och installera de [senaste AEM-moderniseringsverktygen](https://github.com/adobe/aem-modernize-tools/releases/latest) på produktionsklonen AEM 6.x via Package Manager

+ [Sidstrukturkonverteraren](https://opensource.adobe.com/aem-modernize-tools/pages/structure/about.html) uppdaterar befintligt sidinnehåll från en statisk mall till en mappad redigerbar mall med layoutbehållare
   + Definiera konverteringsregler med OSGi-konfiguration
   + Kör sidstrukturkonverteraren mot befintliga sidor

+ [Komponentkonverteraren](https://opensource.adobe.com/aem-modernize-tools/pages/component/about.html) uppdaterar befintligt sidinnehåll från statisk mall till en mappad redigerbar mall med layoutbehållare
   + Definiera konverteringsregler via JCR-noddefinitioner/XML
   + Kör komponentkonverteringsverktyget mot befintliga sidor

+ [Principimporteraren](https://opensource.adobe.com/aem-modernize-tools/pages/policy/about.html) skapar principer från designkonfigurationen
   + Definiera konverteringsregler med JCR-noddefinitioner/XML
   + Kör principimporteraren mot befintliga designdefinitioner
   + Använd importerade profiler på AEM-komponenter och -behållare

## Handövning

Prova det du lärt dig med övningen.

Innan du provar övningen bör du kontrollera att du har tittat på och förstått videon ovan och följande material:

+ [Tänk annorlunda om AEM as a Cloud Service](./introduction.md)
+ [Databasmodernisering](./repository-modernization.md)
+ [Muterbart och oföränderligt innehåll](../../developing/basics/mutable-immutable.md)
+ [AEM projektstruktur](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/aem-project-content-package-structure.html)

Se även till att du har fullföljt tidigare övningar:

+ [BPA och CAM: s praktiska övning](./bpa-and-cam.md#hands-on-exercise)

<table style="border-width:0">
    <tr>
        <td style="width:150px">
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session2-migration#bootcamp---session-2-migration-methodology"><img alt="Handövande GitHub-databas" src="./assets/github.png"/>
            </a>        
        </td>
        <td style="width:100%;margin-bottom:1rem;">
            <div style="font-size:1.25rem;font-weight:400;">Handfast med AEM modernisering</div>
            <p style="margin:1rem 0">
                Upptäck hur du använder AEM Modernization Tools för att uppdatera en äldre WKND-sajt som följer AEM as a Cloud Service praxis.
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session2-migration#bootcamp---session-2-migration-methodology" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Prova AEM moderniseringsverktyg</span>
            </a>
        </td>
    </tr>
</table>

## Andra resurser

+ [Ladda ned verktyg för AEM-modernisering](https://github.com/adobe/aem-modernize-tools/releases/latest)
+ [Dokumentation för AEM Modernization Tools](https://opensource.adobe.com/aem-modernize-tools/)
+ [AEM Gems - Nu kommer AEM Modernization Suite](https://helpx.adobe.com/experience-manager/kt/eseminars/gems/Introducing-the-AEM-Modernization-Suite.html)

1. Distribuera den nymoderniserade äldre webbplatsen på AEM SDK. AEM ASK finns att ladda ned här:
   + [Programdistributionsportal](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html).
