---
title: AEM Assets Microservices och gå över till AEM as a Cloud Service
description: Se hur AEM Assets as a Cloud Service mikrotjänster på asset compute gör det möjligt att automatiskt och effektivt generera alla renderingar av dina resurser och ersätta det traditionella AEM arbetsflödet.
version: Cloud Service
feature: Asset Compute Microservices
topic: Migration, Upgrade
role: Developer
level: Experienced
jira: KT-8635
thumbnail: 336990.jpeg
exl-id: 327e8663-086b-4b31-b159-a0cf30480b45
duration: 989
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '291'
ht-degree: 0%

---

# AEM Assets Microservices - Moving to AEM as a Cloud Service

Se hur AEM Assets as a Cloud Service mikrotjänster på asset compute gör det möjligt att automatiskt och effektivt generera alla renderingar av dina resurser och ersätta det traditionella AEM arbetsflödet.

>[!VIDEO](https://video.tv.adobe.com/v/336990?quality=12&learn=on)

## Arbetsflödesmigreringsverktyg

![Migreringsverktyg för arbetsflöde för resurs](./assets/asset-workflow-migration.png)

När du omfaktoriserar din kodbas använder du [Verktyget för arbetsflödesmigrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/moving/refactoring-tools/asset-workflow-migration-tool.html) för att migrera befintliga arbetsflöden för att använda Asset compute-mikrotjänsterna på AEM as a Cloud Service.

## Viktiga aktiviteter

+ Använd [Adobe I/O Workflow Migrator](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#command-aio-aem-migrationworkflow-migrator) verktyg för att migrera arbetsflöden för bearbetning av resurser så att de kan använda Asset compute mikrotjänster.
+ Konfigurera en [lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html) och driftsätta de uppdaterade arbetsflödena. Manuell justering kan behövas för komplexa arbetsflöden.
+ Fortsätt att iterera i en lokal utvecklingsmiljö med AEM SDK tills det uppdaterade arbetsflödet matchar funktionsparitet.
+ Distribuera den uppdaterade kodbasen till en AEM as a Cloud Service utvecklingsmiljö och fortsätt att validera.

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
                Se hur du definierar och tilldelar AEM Assets Processing Profiles till mappar och överför resurser till AEM med hjälp av CLI-modulen "aem-upload".
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session8-assets#cloud-acceleration-bootcamp---session-8-assets-and-microservices" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Testa resurshantering</span>
            </a>
        </td>
    </tr>
</table>
