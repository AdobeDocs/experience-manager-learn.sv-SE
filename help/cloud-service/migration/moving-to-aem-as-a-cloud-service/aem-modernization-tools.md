---
title: Använda AEM för att gå över till AEM as a Cloud Service
description: Lär dig hur AEM modereringsverktyg används för att uppgradera ett befintligt AEM och innehåll som ska vara AEM as a Cloud Service kompatibelt.
version: Cloud Service
topic: Migration, Upgrade
feature: Migration
role: Developer
level: Experienced
kt: 8629
thumbnail: 336965.jpeg
exl-id: 310f492c-0095-4015-81a4-27d76f288138
source-git-commit: eecc275e38390b9330464c8ac0750efa2c702c82
workflow-type: tm+mt
source-wordcount: '446'
ht-degree: 1%

---


# AEM Modernization Tools

Läs om hur AEM modernisaliseringsverktyg används för att uppgradera befintligt AEM Sites-innehåll så att det är AEM as a Cloud Service kompatibelt och följer vedertagna standarder.

## All-in-One Converter

>[!VIDEO](https://video.tv.adobe.com/v/338802?quality=12&learn=on)

## Sidkonvertering

>[!VIDEO](https://video.tv.adobe.com/v/338799?quality=12&learn=on)

## Komponentkonvertering

>[!VIDEO](https://video.tv.adobe.com/v/338788?quality=12&learn=on)

## Principimport

>[!VIDEO](https://video.tv.adobe.com/v/338797?quality=12&learn=on)

## Använda AEM

![AEM verktygets livscykel](./assets/aem-modernization-tools.png)

AEM verktyg för modernisering konverterar automatiskt befintliga AEM sidor som består av gamla statiska mallar, grundkomponenter och parsys, och använder moderna metoder som redigerbara mallar, AEM viktiga WCM-komponenter och layoutbehållare.

## Viktiga aktiviteter

+ Klona AEM 6.x-produktion och kör AEM moderniseringsverktyg mot
+ Hämta och installera [de senaste AEM moderniseringsverktygen](https://github.com/adobe/aem-modernize-tools/releases/latest) på AEM 6.x-produktionsklonen via Package Manager

+ [Sidstrukturkonverterare](https://opensource.adobe.com/aem-modernize-tools/pages/structure/about.html) uppdaterar befintligt sidinnehåll från statisk mall till en mappad redigerbar mall med layoutbehållare
   + Definiera konverteringsregler med OSGi-konfiguration
   + Kör sidstrukturkonverteraren mot befintliga sidor

+ [Komponentkonverterare](https://opensource.adobe.com/aem-modernize-tools/pages/component/about.html) uppdaterar befintligt sidinnehåll från statisk mall till en mappad redigerbar mall med layoutbehållare
   + Definiera konverteringsregler via JCR-noddefinitioner/XML
   + Kör komponentkonverteringsverktyget mot befintliga sidor

+ [Principimporteraren](https://opensource.adobe.com/aem-modernize-tools/pages/policy/about.html) skapar profiler från designkonfigurationen
   + Definiera konverteringsregler med JCR-noddefinitioner/XML
   + Kör principimporteraren mot befintliga designdefinitioner
   + Använd importerade profiler på AEM och behållare

## Handövning

Prova det du lärt dig med övningen.

Innan du provar övningen bör du kontrollera att du har tittat på och förstått videon ovan och följande material:

+ [Tänk annorlunda om AEM as a Cloud Service](./introduction.md)
+ [Databasmodernisering](./repository-modernization.md)
+ [Muterbart och oföränderligt innehåll](../../developing/basics/mutable-immutable.md)
+ [AEM projektstruktur](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/aem-project-content-package-structure.html)

Se även till att du har fullföljt tidigare övningar:

+ [Praktisk övning i BPA och CAM](./bpa-and-cam.md#hands-on-exercise)

<table style="border-width:0">
    <tr>
        <td style="width:150px">
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session2-migration#bootcamp---session-2-migration-methodology"><img alt="Handövande GitHub-databas" src="./assets/github.png"/>
            </a>        
        </td>
        <td style="width:100%;margin-bottom:1rem;">
            <div style="font-size:1.25rem;font-weight:400;">Praktisk med AEM</div>
            <p style="margin:1rem 0">
                Upptäck hur du använder AEM Moderniseringsverktyg för att uppdatera en äldre WKND-webbplats så att den följer AEM as a Cloud Service praxis.
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session2-migration#bootcamp---session-2-migration-methodology" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Prova de AEM moderniseringsverktygen</span>
            </a>
        </td>
    </tr>
</table>

## Andra resurser

+ [Ladda ned verktyg för AEM](https://github.com/adobe/aem-modernize-tools/releases/latest)
+ [Dokumentation för AEM Moderniseringsverktyg](https://opensource.adobe.com/aem-modernize-tools/)
+ [AEM Gems - Introduktion till AEM Modernization Suite](https://helpx.adobe.com/experience-manager/kt/eseminars/gems/Introducing-the-AEM-Modernization-Suite.html)

1. Distribuera den nymoderniserade äldre webbplatsen på den lokala AEM SDK. AEM ASK finns att ladda ned här:
   + [Programdistributionsportal](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html).
