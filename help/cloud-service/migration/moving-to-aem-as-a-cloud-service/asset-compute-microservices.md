---
title: AEM Assets Microservices och flytt till AEM as a Cloud Service
description: Läs om hur AEM Assets as a Cloud Service resurshanteringsmikrotjänster gör att du automatiskt och effektivt kan generera vilken rendering som helst för dina resurser och ersätta den här rollen som det traditionella AEM Workflow har.
version: Experience Manager as a Cloud Service
feature: Asset Compute Microservices
topic: Migration, Upgrade
role: Developer
level: Experienced
jira: KT-8635
thumbnail: 336990.jpeg
exl-id: 327e8663-086b-4b31-b159-a0cf30480b45
duration: 973
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '291'
ht-degree: 0%

---

# AEM Assets Microservices - Moving to AEM as a Cloud Service

Läs om hur AEM Assets as a Cloud Service resurshanteringsmikrotjänster gör att du automatiskt och effektivt kan generera vilken rendering som helst för dina resurser och ersätta den här rollen som det traditionella AEM Workflow har.

>[!VIDEO](https://video.tv.adobe.com/v/3454288?quality=12&learn=on&captions=swe)

## Arbetsflödesmigreringsverktyg

![Resursarbetsflödesmigreringsverktyg](./assets/asset-workflow-migration.png)

Som en del av omfaktoriseringen av din kodbas använder du verktyget [Resursarbetsflödesmigrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/moving/refactoring-tools/asset-workflow-migration-tool.html?lang=sv-SE) för att migrera befintliga arbetsflöden och använda Asset Compute mikrotjänster i AEM as a Cloud Service.

## Viktiga aktiviteter

+ Använd verktyget [Adobe I/O Workflow Migrator](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#command-aio-aem-migrationworkflow-migrator) för att migrera arbetsflöden för resursbearbetning och använda Asset Compute mikrotjänster.
+ Konfigurera en [lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html?lang=sv-SE) och distribuera de uppdaterade arbetsflödena. Manuell justering kan behövas för komplexa arbetsflöden.
+ Fortsätt att iterera i en lokal utvecklingsmiljö med AEM SDK tills det uppdaterade arbetsflödet matchar funktionsparitet.
+ Distribuera den uppdaterade kodbasen till en AEM as a Cloud Service-utvecklingsmiljö och fortsätt att validera.

## Handövning

Prova det du lärt dig med övningen.

Innan du provar övningen bör du kontrollera att du har tittat på och förstått videon ovan och följande material:

+ [Tänk annorlunda om AEM as a Cloud Service](./introduction.md)
+ [Onboarding](./onboarding.md)

Se även till att du har fullföljt tidigare övningar:

+ [Söka och indexera praktiska övningar](./search-and-indexing.md#hands-on-exercise)

<table style="border-width:0">
    <tr>
        <td style="width:150px">
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session8-assets#cloud-acceleration-bootcamp---session-8-assets-and-microservices"><img alt="Handövande GitHub-databas" src="./assets/github.png"/>
            </a>        
        </td>
        <td style="width:100%;margin-bottom:1rem;">
            <div style="font-size:1.25rem;font-weight:400;">Handtag med överföring av resurser</div>
            <p style="margin:1rem 0">
                Upptäck hur du definierar och tilldelar AEM Assets Processing Profiles till mappar och överför resurser till AEM med hjälp av CLI-modulen "aem-upload".
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session8-assets#cloud-acceleration-bootcamp---session-8-assets-and-microservices" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Testa resurshantering</span>
            </a>
        </td>
    </tr>
</table>
