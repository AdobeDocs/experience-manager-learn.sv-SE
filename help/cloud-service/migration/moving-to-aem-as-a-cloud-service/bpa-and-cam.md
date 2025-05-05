---
title: Konfigurera ditt BPA- och CAM-projekt
description: Läs om hur Best Practices Analyzer och Cloud Acceleration Manager kan ge en anpassad guide för migrering till AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Developer Tools
topic: Migration, Upgrade
role: Developer
level: Experienced
jira: KT-8627
thumbnail: 336957.jpeg
exl-id: f8289dd4-b293-4b8f-b14d-daec091728c0
duration: 680
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '350'
ht-degree: 2%

---

# Best Practices Analyzer och Cloud Acceleration Manager

Läs om hur Best Practices Analyzer (BPA) och Cloud Acceleration Manager (CAM) ger en anpassad guide för migrering till AEM as a Cloud Service. 

>[!VIDEO](https://video.tv.adobe.com/v/3453345?quality=12&learn=on&captions=swe)

## Använda BPA och CAM

![Högnivådiagram för BPA och CAM](assets/bpa-cam-diagram.png)

BPA-paketet ska installeras på en klon av AEM 6.x-produktionsmiljön. BPA kommer att generera en rapport som sedan kan överföras till CAM, som ger vägledning om de viktigaste aktiviteter som behöver utföras för att kunna flyttas till AEM as a Cloud Service.

## Viktiga aktiviteter

+ Klona produktionen i 6.x-miljö. När du migrerar innehåll och kodar för omfakturor är det viktigt att ha en klon av en produktionsmiljö för att testa olika verktyg och ändringar.
+ Hämta det senaste BPA-verktyget från [portalen för programvarudistribution](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html) och installera i din AEM 6.x-klonade miljö.
+ Använd BPA-verktyget för att generera en rapport som kan överföras till Cloud Acceleration Manager (CAM). CAM nås via [https://experience.adobe.com/](https://experience.adobe.com/) > **Experience Manager** > **Cloud Acceleration Manager**.
+ Använd CAM för att få vägledning om vilka uppdateringar som behöver göras i den aktuella kodbasen och -miljön för att kunna gå över till AEM as a Cloud Service.

## Handövning

Prova det du lärt dig med övningen.

Innan du provar övningen bör du kontrollera att du har tittat på och förstått videon ovan och följande material:

+ [Tänk annorlunda om AEM as a Cloud Service](./introduction.md)
+ [Vad är AEM as a Cloud Service?](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/introduction/what-is-aem-as-a-cloud-service.html?lang=sv-SE)
+ [Arkitekturen för AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/introduction/architecture.html?lang=sv-SE)
+ [Innehåll som kan ändras och inte kan ändras](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/developing/basics/mutable-immutable.html?lang=sv-SE)
+ [Skillnader i utveckling för AEM as a Cloud Service och AEM 6.x](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/development-guidelines.html?lang=sv-SE#developing)

<table style="border-width:0">
    <tr>
        <td style="width:150px">
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session1-differently#bootcamp---session-1-introduction-and-thinking-differently"><img alt="Handövande GitHub-databas" src="./assets/github.png"/>
            </a>        
        </td>
        <td style="width:100%;margin-bottom:1rem;">
            <div style="font-size:1.25rem;font-weight:400;">Handfast med Best Practices Analyzer</div>
            <p style="margin:1rem 0">
                Utforska BPA (Best Practices Analyzer) och granska resultatet genom att köra det mot en äldre WKND-kodbas som innehåller exempel på överträdelser.
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session1-differently#bootcamp---session-1-introduction-and-thinking-differently" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Prova Best Practices Analyzer</span>
            </a>
        </td>
    </tr>
</table>


## Andra resurser

+ [Hämta Best Practices Analyzer](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=Best*+Practices*+Analyzer*&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=1)