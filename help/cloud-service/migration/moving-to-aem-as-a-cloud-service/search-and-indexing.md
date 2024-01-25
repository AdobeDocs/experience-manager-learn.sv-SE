---
title: Söka och indexera på AEM as a Cloud Service
description: Lär dig mer om AEM as a Cloud Service sökindex, hur du konverterar AEM 6 indexdefinitioner och hur du distribuerar index.
version: Cloud Service
feature: Search
topic: Migration, Upgrade
role: Developer
level: Experienced
jira: KT-8634
thumbnail: 336963.jpeg
exl-id: f752df86-27d4-4dbf-a3cb-ee97b7d9a17e
duration: 1247
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '297'
ht-degree: 0%

---

# Söka och indexera

Lär dig mer om AEM as a Cloud Service sökindex, hur du konverterar AEM 6-indexdefinitioner till AEM as a Cloud Service kompatibla och hur du distribuerar index till AEM as a Cloud Service.

>[!VIDEO](https://video.tv.adobe.com/v/336963?quality=12&learn=on)

## Indexkonverterare

![Indexkonverterare](./assets/index-converter.png)

När du omfaktoriserar din kodbas använder du [Indexkonverteringsverktyg](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#command-aio-aem-migrationindex-converter) om du vill konvertera anpassade indexdefinitioner för ekv till AEM as a Cloud Service kompatibla indexdefinitioner.

Granska [dokumentation för konverterare av index](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/refactoring-tools/index-converter.html) för den kompletta och aktuella uppsättningen indexkonverterarfunktioner.

## Viktiga aktiviteter

+ Använd [Adobe I/O Workflow Migrator](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#command-aio-aem-migrationindex-converter) verktyg för att migrera arbetsflöden för bearbetning av resurser så att de kan använda Asset compute mikrotjänster.
+ Konfigurera en [lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html) och driftsätta anpassade index. Se till att de uppdaterade indexen är uppdaterade.
+ Distribuera den uppdaterade kodbasen till en AEM as a Cloud Service utvecklingsmiljö och fortsätt att validera.
+ Om du ändrar ett utanför rutans index **ALLTID** kopiera den senaste indexdefinitionen från en AEM as a Cloud Service miljö som körs i den senaste versionen. Ändra den kopierade indexdefinitionen efter dina behov.

## Handövning

Prova det du lärt dig med övningen.

Innan du provar övningen bör du kontrollera att du har tittat på och förstått videon ovan och följande material:

+ [Tänk annorlunda om AEM as a Cloud Service](./introduction.md)
+ [Databasmodernisering](./repository-modernization.md)

Se även till att du har fullföljt tidigare övningar:

+ [Handövning med verktyget Innehållsöverföring](./content-migration/content-transfer-tool.md#hands-on-exercise)

<table style="border-width:0">
    <tr>
        <td style="width:150px">
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session7-indexes#cloud-acceleration-bootcamp---session-7-search-and-indexing"><img alt="Handövande GitHub-databas" src="./assets/github.png"/>
            </a>        
        </td>
        <td style="width:100%;margin-bottom:1rem;">
            <div style="font-size:1.25rem;font-weight:400;">Handtag med index</div>
            <p style="margin:1rem 0">
                Utforska hur du definierar och distribuerar Oak-index till AEM as a Cloud Service.
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session7-indexes#cloud-acceleration-bootcamp---session-7-search-and-indexing" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Testa med indexering</span>
            </a>
        </td>
    </tr>
</table>
