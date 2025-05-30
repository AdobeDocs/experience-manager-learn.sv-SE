---
title: Innehållsmigrering med verktyget Innehållsöverföring
description: Läs om hur verktyget Innehållsöverföring hjälper dig att migrera innehåll till AEM as a Cloud Service från AEM 6.
version: Experience Manager as a Cloud Service
topic: Migration, Upgrade
feature: Migration
role: Developer
level: Experienced
jira: KT-8919
thumbnail: 336970.jpeg
exl-id: c51ce8e3-e83c-4f8b-a835-70335ed3a5b9
duration: 1362
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '295'
ht-degree: 1%

---


# Verktyget Innehållsöverföring

Läs om hur verktyget Innehållsöverföring hjälper dig att migrera innehåll till AEM as a Cloud Service från AEM 6.3+.

>[!VIDEO](https://video.tv.adobe.com/v/3454751?quality=12&learn=on&captions=swe)

## Använda verktyget Innehållsöverföring

![Verktygets livscykel för innehållsöverföring](../assets/content-transfer-tool.png)

Verktyget Innehållsöverföring installeras på AEM 6.3+ och överför innehåll till AEM as a Cloud Service.

## Viktiga aktiviteter

+ Hämta det [senaste verktyget för innehållsöverföring](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=Content*+Transfer*+Tool*&amp;1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;order.sort=desc&amp;layout=list&amp;list p.offset=0&amp;p.limit=2).
+ Överför slutinnehåll från AEM Author 6.3+ till tjänsten AEM as a Cloud Service Author.
   + Installera verktyget Innehållsöverföring på AEM 6.3+ Author som innehåller det slutgiltiga innehåll som ska överföras.
   + Kör verktyget Innehållsöverföring gruppvis och överför uppsättningar av innehåll.
+ Överför slutinnehåll från AEM Publish 6.3+ till tjänsten AEM as a Cloud Service Publish.
   + Installera verktyget Innehållsöverföring på AEM 6.3+ Publish med det slutgiltiga innehåll som ska överföras.
   + Kör verktyget Innehållsöverföring gruppvis och överför uppsättningar av innehåll.
+ Alternativt kan du&quot;top-up&quot;-innehåll på AEM as a Cloud Service genom att överföra nytt innehåll sedan den senaste innehållsöverföringen

## Handövning

Prova det du lärt dig med övningen.

Innan du provar övningen bör du kontrollera att du har tittat på och förstått videon ovan och följande material:

+ [AEM Modernization Tools](../aem-modernization-tools.md)
+ [Onboarding](../onboarding.md)
+ [Cloud Manager](../cloud-manager.md)

Se även till att du har fullföljt tidigare övningar:

+ [Dispatcher praktiska övning](../dispatcher.md#hands-on-exercise)

<table style="border-width:0">
    <tr>
        <td style="width:150px">
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session6-transfercontent#cloud-acceleration-bootcamp---session-6-content"><img alt="Handövande GitHub-databas" src="../assets/github.png"/>
            </a>        
        </td>
        <td style="width:100%;margin-bottom:1rem;">
            <div style="font-size:1.25rem;font-weight:400;">Handverktyget med verktyget Innehållsöverföring</div>
            <p style="margin:1rem 0">
                Se hur verktyget Innehållsöverföring automatiskt kan flytta innehåll från AEM 6 till AEM as a Cloud Service.
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session6-transfercontent#cloud-acceleration-bootcamp---session-6-content" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Testa verktyget Innehållsöverföring </span>
            </a>
        </td>
    </tr>
</table>

## Andra resurser

+ [Ladda ned innehållsöverföringsverktyget](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=Content*+Transfer*+Tool*&amp;1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&amp;order.sort=desc&amp;layout=list&amp;list p.offset=0&amp;p.limit=2)
+ [Videofilm om hur man gör i massimporttjänsten](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/migration/bulk-import.html?lang=sv-SE)

